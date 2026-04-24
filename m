Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8233D6CA9
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037373; cv=none; b=K0er900m0k9+ZlIn7nSGJNEWdy2vbd1QaK1rEYw8wGB/rlDXUr2whxPY4rJqtgU7mOEYFL/mVa9QonA7ZnOxb+5DI98knmaVHTQKSlH/Kj9baR+NdC4LuN9+Jt3x+SLbvTgpwQ5JafhHUZgfL1Bs8dLlLFZDqsqorh7izvEuUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037373; c=relaxed/simple;
	bh=8N9ZUyumLhZPpREviRbZwKlXS861tjEA3KjPMdkQopg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR44HKnVnOfEGKGH3EMpB9xE+YX2U9OJ0Q4Tcx3gLsaX9ejiMHk2zAJMg+QSj5z4O1QsAs1uQuKlVDhuWNILlFbryGQStUoAnRGd4zLEYZ/uLVC/waSLslJgEGcKtf4zhOEC3tF9p7WqaJGGUfskzSquBfsyB8KN5E+fQOnsXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=iVwhJ6Q0; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iVwhJ6Q0"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a7bbe9d0so65533441cf.0
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777037368; x=1777642168; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ezbOz+DNq/Ln5lGWJ2GbxuTePwedL+fzC5CYxvFRhc=;
        b=iVwhJ6Q0Q4Zt6L70XMoA5orwDuFU3xUcrEeUeKhOM/JqTDGQIHI/W+XCGp60CEmMJ2
         Ni9Ikf3QQLs6K1L5N96cMgr+fGLRYQ95UoFL2SKh9M22AANDXHgJ55UhDsjdHjGFARLy
         xV40CFV6WMJIzgDRktwxS9a3t7nrOhnrVkQ/Cvhj13KnVrVtt+OSob5HR82hdmppom5D
         o0VqlLWkoFRyHWG/gpfD9LI/Xqqm7/mPR1OAaqe7Yo0HZSeutDDHRcKvkQoatF03Gy2a
         TiCbS6HjFFMLEuobf1HoBwfm6PtrcdzyStYLNSqeq1mTfjxuV8rZ2GZKPTmMXQgmLMkO
         sB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037368; x=1777642168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ezbOz+DNq/Ln5lGWJ2GbxuTePwedL+fzC5CYxvFRhc=;
        b=XkeL8GlyKHCrDPJJsFn+WiMmDyuBOKFNv8Olf9cXf1zznQqtNIU1Q+y5XXrkdOhll3
         xTKtxOpHANRay6m1WfLtRj64dYkLuXkhYXc/4X9Wc5JLRkhW4rySAuakeo5Q5HDKS0Vw
         zmo6UInMRYSCUu7fqs7zkEXvSEAkmexMSuhGOGM3iTsNhvVTBiBjzNSDNTXqwy3OOkAx
         XC33OLVMSlmp99N4pP3LkAV5JqUL2CX3L0cUlAbXX/473mKu9e+yhUF/MswuEZ16stCa
         sdXBcQMR/GNXMvYlPabvwqj+nWu+q7KUtLtgq4YonjhtgpwATOVmGOodJ9t9wVgmQpCn
         2d/g==
X-Forwarded-Encrypted: i=1; AFNElJ+Cy4kQOzsTNCEQ++BveAl1sFNxlXZgqCKvS1GqXU6KKRUBFxKm1ZN7V8rXqU007MjWnc+xFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWVe/eqhZTDnEdTjw4IX02OB5Ma/Ah9cjWQhR0lcZMqV3Hpr8T
	XiJCrUFYAUOgpolKoFMlTaFHD11yKL+DCAxzZuQSZPTTG7blN6gEdBv//wdOcrtSGjM=
X-Gm-Gg: AeBDietvK4ACimwqtGUKJA93XXX+SGbo1tVnLqIJjKLhwHjhKPVvWM9JS9UXTjWmbAF
	8cQSQadVe/dVWohKqtdQBSf50WLutbogl1RWx2uRWVeOfES4DGzosaz9kVnalOjBkfq1J7Xg2BN
	Kxbw1yhNAtJVvbH9ec4BriHGh/bhpBBZSo6mRyPNW38wYEQv+LLzRmT3ngiMfMYc/zi+Sr2cQpf
	D+9OsAeLZaSEoeRTlYs1P2BwSa5tDuuE4JWdrVuarBEoZdaD1IMBqUXHlhGZ4oUUjra14KwTvcY
	3BWhIL1DZHcIRo3cGEEhjl8lY5cofqm1XwsZZyaTcjBuDOhfo/HurAU1m1Cv3tWKOvcIlEm9+3j
	dZhZoEcJUcDTgU/VnfeQCFUfM3Q+edLCfyHFcygVg/ZKCvVBzc8LYg6Ikle1K4Oe0zfX1s0Aho0
	khW3IG3QSDdmCJAXhQHU4zJP0btMqqDZ/wV5P6KilXBKPxmmHzXYfb58hFQRbyGw==
X-Received: by 2002:a05:622a:1f0d:b0:50f:c36a:381a with SMTP id d75a77b69052e-50fc36a3bd2mr157337571cf.55.1777037367645;
        Fri, 24 Apr 2026 06:29:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb5fc8e04sm101886121cf.13.2026.04.24.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:29:26 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:29:24 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aetvAkM0y45WAmfV@plex>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <2vxzeck45yin.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzeck45yin.fsf@kernel.org>

On 04-24 14:33, Pratyush Yadav wrote:
> Hi David,
> 
> On Thu, Apr 23 2026, David Matlack wrote:
> [...]
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c9b7b6f9828e..94af31837375 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/PCI/pci-error-recovery.rst
> >  
> > +PCI LIVE UPDATE
> > +M:	Bjorn Helgaas <bhelgaas@google.com>
> > +M:	David Matlack <dmatlack@google.com>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Supported
> > +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> > +B:	https://bugzilla.kernel.org
> > +C:	irc://irc.oftc.net/linux-pci
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > +F:	drivers/pci/liveupdate.c
> > +F:	include/linux/kho/abi/pci.h
> > +
> 
> Can we please also add these files under the "LIVE UPDATE" entry. The
> code here concerns both live update and PCI. We can figure out the
> maintenance details as we go along, but I think the live update
> maintainers should at least get all the patches for PCI live update.
> 
> Perhaps also add the kexec list here? We plan to use it to maintain the
> LUO patches, and adding it will make sure we get the patches in case
> someone updates the file list here but forgets to update it in the LIVE
> UPDATE entry.

+1

These files should also be added to the Live Update entry, and the kexec
mailing list should be included.

Changes specific to Live Update should be routed through the
liveupdate/linux.git tree, while generic PCI changes should go through
pci/pci.git. In either case, if liveupdate.c or abi/pci.h are modified,
acks are required from the Live Update group.

Pasha
