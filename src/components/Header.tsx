import { Github, Linkedin, Facebook, Mail, MapPin, Phone } from 'lucide-react';
import { cvData } from '../data/cvData';

export function Header() {
  const { personalInfo } = cvData;

  return (
    <div className="bg-gradient-to-r from-blue-600 to-blue-700 text-white p-8 rounded-lg shadow-lg">
      <h1 className="text-4xl font-bold mb-2">{personalInfo.name}</h1>
      <div className="flex flex-col gap-2 md:flex-row md:items-center md:gap-6 text-blue-100">
        <div className="flex items-center gap-2">
          <Mail size={16} />
          <a href={`mailto:${personalInfo.email}`} className="hover:text-white">
            {personalInfo.email}
          </a>
        </div>
        <div className="flex items-center gap-2">
          <Phone size={16} />
          <span>{personalInfo.contact}</span>
        </div>
        <div className="flex items-center gap-2">
          <MapPin size={16} />
          <span>{personalInfo.address}</span>
        </div>
      </div>
      <div className="flex gap-4 mt-4">
        <a href={personalInfo.social.github} target="_blank" rel="noopener noreferrer" className="hover:text-white">
          <Github size={20} />
        </a>
        <a href={personalInfo.social.linkedin} target="_blank" rel="noopener noreferrer" className="hover:text-white">
          <Linkedin size={20} />
        </a>
        <a href={personalInfo.social.facebook} target="_blank" rel="noopener noreferrer" className="hover:text-white">
          <Facebook size={20} />
        </a>
      </div>
    </div>
  );
}