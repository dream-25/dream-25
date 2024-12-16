import { Code2 } from 'lucide-react';
import { cvData } from '../data/cvData';

export function Skills() {
  return (
    <div className="bg-white p-6 rounded-lg shadow-lg">
      <div className="flex items-center gap-2 mb-4">
        <Code2 className="text-blue-600" size={24} />
        <h2 className="text-2xl font-bold">Technical Skills</h2>
      </div>
      <div className="space-y-4">
        {cvData.skills.map((skill, index) => (
          <div key={index} className="flex flex-col">
            <div className="flex justify-between mb-1">
              <span className="font-medium">{skill.area}</span>
              <span className="text-blue-600">{skill.years} Years</span>
            </div>
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div
                className="bg-blue-600 h-2 rounded-full"
                style={{ width: `${(skill.years / 5) * 100}%` }}
              />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}