Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FD31E844
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398640; cv=none; b=kEvAy8/IoDaBzdrVAD17Kk8GylQS4N48vUiOXtXUc3Npm+XZULLcLci7CdFDQbtsXzWCmwKS0K583P00UsUPgsl8/6xHIgfxMjbfkU3BuPBPW5B2bUhUwro4I19QgdVwcxhUjr+r7sX20xfQglg/3/8JDFENWgsdoVHrk0cnXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398640; c=relaxed/simple;
	bh=FgWjBTA/iLlK6ZCp3kZQBVGLSatIbrMyuIlDbArJh+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo78eeYTAr/JOh3YKVKVwyiV6nFj0OhIk0yD4feh059igQ+TPc4nneIZrqVW4zPRKfaWrvfxabp6fkuLNHc9Tzw2aYimOvW6rDq8n/lPJqcldv0r4INDw/ILEzwRsxSc/YNAG2eWw0y/5MdaBPN7+PhymoJ5sjLlN3O20ofFfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VAbU4MJL; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VAbU4MJL"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso123914566d6.2
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777398638; x=1778003438; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLQfCSN8EWjiFZX7iYk3vg7MUEyfn/VCYlErQ2TNxjE=;
        b=VAbU4MJL1dKU+qsR00Z/9hCdY6/6mglE90n8VK1Fr9uum8Gii4i+WIRSY+e9rLmUZQ
         EigVaZOFuUOco5s8hoE/x11SWh1agGc4voIrax3w6veKOlH6yRyNWqB4kG5wZWYW7AmS
         WlUl06dMmhT5uUJVI2AjdBd2h4Iy7w9ptcy7J2+Dd1HIdnwqHL4pNr5MzT+1JYsuO6I1
         Q/bv4b80Pv2dqwKWA92qtfK01T+v3c0ODjLW+dWtg6k6hCKi02kH79tdG0zg3l9ycHMG
         bRv7lb127OpAQ3XQfGwt9REjQD2oD2zPkUbkj/f6AQXaSrnZJrKHGFJ/84pM4sAeENWb
         P2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777398638; x=1778003438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLQfCSN8EWjiFZX7iYk3vg7MUEyfn/VCYlErQ2TNxjE=;
        b=LU/tjclJLKy62rrtvRKLXyUeD5p68LFBWfGvgL7zk4AXVdEXnaJK09KHmUofqIyeRx
         epzkbUGSPiPmwlXDLLh70TXijYQ9yEkCuFR0EYdJNPLiF7mhvu/zzOgK1Y48eg8ywLi2
         Qi3rUDSHGsie0qe8Klv/psaaQ914npWWX09+IkdMqv0uR7cYtSJXapRxE0+QMt4+12U2
         8Qe4yOfdKSGGCprcgRk3KpROK0llQgzW8JAszOmWAY4DQ+HL93DI2VifTrDClypXGJSG
         qmHMXlLPRkST2ucX2ekYaumOqQBnmByc1lJ6nAHyVbDpKQ/WiTb4sS1QQc+x9cN/WZdp
         DJng==
X-Forwarded-Encrypted: i=1; AFNElJ+ZR/9MJX9JlfiAb+/6H7Ze71YY6q8LZ1o/tzy8NAEJ4Rx078TVpn4FrJhxUVkP8J51QxEHtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmPvnh7kLVD2oyNT7tqu8YaZF2YHxNod0MH8xhxknPtSkd+ub+
	R+69DiVqtT9jmU3X/wCXdcycmwyRZXPfHYzsMCqa7F6azz9uGV10QTgb6onGqy2ome4=
X-Gm-Gg: AeBDietVed9ebdF3LqEqscq/G59iNL0hD4bhPQD2vrmTvazrZNSbSj9f3n2HDw94IUJ
	E+bZXgYH4ydU5P3RtPbNii8Nb5h1Fs4mR6nUVMQjHwWAn2CSrSamkJIBLA3p/P0vrmng5q1gb1H
	alWe96Z0fsDEX/Fvd/rhei1/59W2zioTDP/v8ppmLE/KMvTi96jpFVmhBnK8VLfuNsJQdvJBTwz
	HSJtUHsgZLVfPdf9yFH75K1xpi8FLG3PtdUnt6Bqh97Da9jVR+TEZEY4UuT8hFPwgaLqoJJ6sQL
	1OvPV2+fhl0CE/JFv7l/zbouURsLhmZrkwiUX3bERY9GyqEV3JCU8rUOrv1CmIIDG/r/mMytNDS
	+KbDJI62cXGqdMEbgZYdWZoVGRjONvbQB9/DV0KIcO8WFt8ren9qElYos5MkU8OIshEFpQw4Lkb
	YonNu8WaPMfQbVrJjDr5ustFvy7A7Dgts647oYabk9fjjNS5wd3dFDwIiwgrtADw==
X-Received: by 2002:a0c:f40e:0:b0:8ac:b14d:fbe5 with SMTP id 6a1803df08f44-8b3e306950emr64326106d6.13.1777398637724;
        Tue, 28 Apr 2026 10:50:37 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e281bd11sm26479316d6.8.2026.04.28.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:50:37 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:50:35 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <afDroRNDr9ttY4O9@plex>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
 <aetvAkM0y45WAmfV@plex>
 <ae_4fg_18Rli2_Nt@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae_4fg_18Rli2_Nt@google.com>

On 04-27 23:59, David Matlack wrote:
> On 2026-04-24 01:29 PM, Pasha Tatashin wrote:
> > On 04-24 14:33, Pratyush Yadav wrote:
> > > Hi David,
> > > 
> > > On Thu, Apr 23 2026, David Matlack wrote:
> > > [...]
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index c9b7b6f9828e..94af31837375 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> > > >  S:	Supported
> > > >  F:	Documentation/PCI/pci-error-recovery.rst
> > > >  
> > > > +PCI LIVE UPDATE
> > > > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > > > +M:	David Matlack <dmatlack@google.com>
> > > > +L:	linux-pci@vger.kernel.org
> > > > +S:	Supported
> > > > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > > > +B:	https://bugzilla.kernel.org
> > > > +C:	irc://irc.oftc.net/linux-pci
> > > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > > +F:	drivers/pci/liveupdate.c
> > > > +F:	include/linux/kho/abi/pci.h
> > > > +
> > > 
> > > Can we please also add these files under the "LIVE UPDATE" entry. The
> > > code here concerns both live update and PCI.
> 
> Covering that intersection of Live Update and PCI was exactly my
> intention with introducing this new PCI LIVE UPDATE entry. This ensures
> we have maintenance coverage with knowledge of that intersection.
> 
> > > We can figure out the
> > > maintenance details as we go along, but I think the live update
> > > maintainers should at least get all the patches for PCI live update.
> 
> Would adding kexec@ here be sufficient or do you want to be CC'd
> directly?
> 
> If you want to be CC'd directly do you think makes more sense to add the
> Live Update maintainers as Reviewers under PCI LIVE UPDATE, or add
> drivers/pci/liveupdate.c under LIVE UPDATE?
> 
> > > 
> > > Perhaps also add the kexec list here? We plan to use it to maintain the
> > > LUO patches, and adding it will make sure we get the patches in case
> > > someone updates the file list here but forgets to update it in the LIVE
> > > UPDATE entry.
> > 
> > +1
> > 
> > These files should also be added to the Live Update entry, and the kexec
> > mailing list should be included.
> > 
> > Changes specific to Live Update should be routed through the
> > liveupdate/linux.git tree, while generic PCI changes should go through
> > pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
> > acks are required from the Live Update group.
> 
> Do you want to merge changes to drivers/pci/liveupdate.c through the
> live update tree or PCI tree? We should probably decide now. I was
> assuming the PCI tree since its part of PCI core.
> 
> As we project this out there are going to be users of the Live Update
> API across different parts of the kernel: PCI core, IOMMU core, IOMMU
> drivers, VFIO core, VFIO PCI drivers, and KVM. I don't think it will
> scale to take all that code through the live update tree.

All Live-Update-specific changes should go through the liveupdate tree. 
The liveupdate tree is the only Linux tree that will cover full Live 
Update regression testing, and it contains reviewers and maintainers who 
know the details of the Live Update process, its lifecycle, and its 
requirements.

The request we are hearing from other subsystem maintainers is that they 
want to make sure Live Update is isolated enough not to make their lives 
harder. This means reducing the number of conflicts, the maintenance 
burden, and testing responsibilities.

Therefore, the "PCI LIVE UPDATE" entry should specify you as a 
maintainer, "kexec@lists.infradead.org" as the list to which all LU 
changes should be CC'd, and "liveupdate/linux.git" as the git tree 
against which changes should be applied.

It should also include "linux-pci@vger.kernel.org" so the PCI 
maintainers are CC'd. In case there are larger changes that touch core 
PCI and liveupdate.c/abi, we can ACK them, ensuring we are aware of 
incoming conflicts during the current or next merge cycle.

It should also specify the members of LU group so we can stage the 
changes.

This is the way we agreed to handle kexec changes: Baoquan He is the 
maintainer, and without his Reviewed-by tag, we won't take changes to 
kexec. This is the approach we follow with MM for KHO changes to 
memblock and memfd preservation, as well as the upcoming 
hugetlb/guestmemfd preservation. 

This is also the approach we should continue using when adding LUO 
support to other components like PCI, VFIO, IOMMU, and KVM. It keeps 
life easier for the core component maintainers and ensures we do not 
regress LU by staging everything in the same tree and sending LU merge 
requests from a single tree.

Pasha
