import { GraduationCap, Briefcase } from 'lucide-react';
import { cvData } from '../data/cvData';

export function Timeline() {
  return (
    <div className="space-y-8">
      <div className="bg-white p-6 rounded-lg shadow-lg">
        <div className="flex items-center gap-2 mb-6">
          <Briefcase className="text-blue-600" size={24} />
          <h2 className="text-2xl font-bold">Work Experience</h2>
        </div>
        <div className="space-y-6">
          {cvData.experience.map((exp, index) => (
            <div key={index} className="relative pl-6 border-l-2 border-blue-600">
              <div className="absolute -left-[9px] top-0 w-4 h-4 bg-blue-600 rounded-full" />
              <div className="mb-1">
                <h3 className="text-xl font-semibold">{exp.company}</h3>
                <p className="text-gray-600">{exp.period}</p>
              </div>
              <p className="text-gray-700 mb-2">Tech Stack: {exp.techStack}</p>
              <p className="text-sm text-gray-600">{exp.address}</p>
              <div className="text-sm text-gray-600 mt-2">
                Reference: {exp.reference.name} ({exp.reference.position}) - {exp.reference.contact}
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="bg-white p-6 rounded-lg shadow-lg">
        <div className="flex items-center gap-2 mb-6">
          <GraduationCap className="text-blue-600" size={24} />
          <h2 className="text-2xl font-bold">Education</h2>
        </div>
        <div className="space-y-6">
          {cvData.education.map((edu, index) => (
            <div key={index} className="relative pl-6 border-l-2 border-blue-600">
              <div className="absolute -left-[9px] top-0 w-4 h-4 bg-blue-600 rounded-full" />
              <div className="mb-1">
                <h3 className="text-xl font-semibold">{edu.degree}</h3>
                <p className="text-gray-600">{edu.period}</p>
              </div>
              {edu.specialization && (
                <p className="text-gray-700">{edu.specialization}</p>
              )}
              <p className="text-gray-600">
                {edu.institution}, {edu.location}
              </p>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}