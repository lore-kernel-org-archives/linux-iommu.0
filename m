Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AD274669
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532472; cv=none; b=X0hEyhC1GHT3zEY5ngEGdcOWrEAsIP65bdZ2IadHjEOpMSU2lP2LRgintvVteNTutmAcxAZGGi8UVg9t+TlN5tFukA9uMYKYdA6eOQFqPz/JvGpPWY+/U/BHuTW5ApHDLwdA+BLe2bSsMJKPqk/hg/75HLGIU5Vgi64PhiqD0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532472; c=relaxed/simple;
	bh=PWZIHxNO9F6b5mRaqczR3GeKYl1D6LdC4n5HIjFGDFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTRHVcWlrNym6oGeVpsuwjgf+Y9qv0DAaQyEOUY5n3LW0L3+JwIEKVQfioV8qHFtI/8EuTNIRkc6ZnSrE+zRoWBX0aiPnIzlixuu5DK8o+3M4H8HYzSt/0gU73Q66+TPIzviC4oHgHhA03SLmrBXaJ7Y1+2+Ifksi9t/aXar5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RuvKRtZP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuvKRtZP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46d72711971so30875e9.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758532469; x=1759137269; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wgArYQu+cHNbaIGGgNnr3ySxE/Az/B6v/bHyH6zdSV4=;
        b=RuvKRtZPVdBpQn9kvOmO8CMXrKdSv9eQkMSlqEg5YdXRgO7Tdli3UsUOkwPM3uyA0J
         7huqjoroGut9SBv34xmO38qaveBQ7gEYVDVr4Wfbg+S5ochz2ex8fVJuNk/4Mgd2rKM0
         mCpVVbkaiD/B9R7SOOrbFQAlApATjoa1X2dA0VOiL2z+hEI2xkE670/kJgpHn8iC2EXp
         8byLae9fqAVZzBCO8zKGZ+fL4Vbv7j3birjikAMZV16Uapr/n0sXC5Af12nzvWoVtiDO
         6JBIlZklPb6V8Oq7lNMBDQeGKTp7WcvzOMY7LDe+/OSZPIi7R5kVK0W22+sbkC+N0VeI
         3ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532469; x=1759137269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgArYQu+cHNbaIGGgNnr3ySxE/Az/B6v/bHyH6zdSV4=;
        b=uyhVJX3Y8HMMiyr/pmvdIZDQSui0tO9DosoUgeis27ikjcv5iX+KE1tjej4oZBTwMG
         KvhGNhXycbqF+d7BvwW/TzhdbWUx4ojn4Xhu1Ll7/lFBIJVs6FpzGHItB5HBebNm7y4y
         P6ZICjD495Jo+EdSd8h2o2aAXecxXzwOfyx54Qvw/2g8gysC1gWheaCT8FDufFFqQBjn
         mYnQiVi6USpOR1IDh6YvKiibZoUA9i6loY0I7hwYaYSpcdfar07Ai6FEyhh49SfOf6tu
         jZPsTqQn+zNmnLYTqqzpSobYxg6TvU82k5FAtF/h/1e25MR1ahAsQjUPHH5kmHQlNX2T
         icWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1gCrEWgQ3dRuorvpT54s/nn5W8cjVYilnrx4Qw7YnksOhoPgDuMrnhAjwUxNpYcFNaufLtg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8Nm6171KiQUl0ng5/sTIW/tGF+kheByE4AeKrSu+XtwXdu86d
	NMrJCwVfBG7GeFjv2I5eHY3njNrM7A9kGBdlxuZvcjZ1KI7gX216nBJrKBVd3iGp2w==
X-Gm-Gg: ASbGnctpxXg6nPv1vnnQwGhi1FoAI8TwnOjCA8m4pkdvKb0h9bDRSFCktKmIybJeFrh
	/oHMeglDFXoOLT5B6W8gYyS0uN6SGDLUa8wplXcHdw1DCKEhtSjbMzugzCILBtYnBedkqOl/cpV
	uABvExqZL/skJSHnan1fqeGBA8P54q41ry3nAR7huvXlGorN2OSKrWej5f6ykoBoMkQ5l0Vpv2k
	yHPcfBLA1pHF130PezA1s1hHd+VJQIVKUm56xHffbuh5zohSRO89rSoujcc+PFUmD9ffMkxucq7
	PtkHGINSqjdb4HgOIAw3Kqauh1UjXVn+B8+02G5ptyW9XqubeQCGHW10XMcEIOlajNOOrqmUyjL
	NL5sO9LaTK7DXh5Gmhc5NNTB6aQgFA1PLtfcNuB1MMxevyPMehV2Xlbim9t2Ww8o=
X-Google-Smtp-Source: AGHT+IHzWY/BU+tZg/uSMYwHsohYz2u6un9Jyb5wJfEWQ7iDRJk2kEB7VjW0B+HU5Afwed6ytoIPQw==
X-Received: by 2002:a05:600c:190e:b0:45f:2e6d:ca01 with SMTP id 5b1f17b1804b1-46154878d4bmr11295375e9.4.1758532468571;
        Mon, 22 Sep 2025 02:14:28 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm7769744f8f.57.2025.09.22.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:14:28 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:14:24 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	Li Zhe <lizhe.67@bytedance.com>, Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <aNETcPELm72zlkwR@google.com>
References: <20250918214425.2677057-1-amastro@fb.com>
 <20250918225739.GS1326709@ziepe.ca>
 <aMyUxqSEBHeHAPIn@kbusch-mbp>
 <BN9PR11MB5276D7D2BF13374EEA2C788F8C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276D7D2BF13374EEA2C788F8C11A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Sep 19, 2025 at 07:00:04AM +0000, Tian, Kevin wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > Sent: Friday, September 19, 2025 7:25 AM
> > 
> > On Thu, Sep 18, 2025 at 07:57:39PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 18, 2025 at 02:44:07PM -0700, Alex Mastro wrote:
> > >
> > > > We anticipate a growing need to provide more granular access to device
> > resources
> > > > beyond what the kernel currently affords to user space drivers similar to
> > our
> > > > model.
> > >
> > > I'm having a somewhat hard time wrapping my head around the security
> > > model that says your trust your related processes not use DMA in a way
> > > that is hostile their peers, but you don't trust them not to issue
> > > hostile ioctls..
> > 
> > I read this as more about having the granularity to automatically
> > release resources associated with a client process when it dies (as
> > mentioned below) rather than relying on the bootstrapping process to
> > manage it all. Not really about hostile ioctls, but that an ungraceful
> > ending of some client workload doesn't even send them.
> > 
> 
> the proposal includes two parts: BAR access and IOMMU mapping. For
> the latter looks the intention is more around releasing resource. But
> the former sounds more like a security enhancement - instead of
> granting the client full access to the entire device it aims to expose
> only a region of BAR resource necessary into guest. Then as Jason
> questioned what is the value of doing so when one client can program
> arbitrary DMA address into the exposed BAR region to attack mapped
> memory of other clients and the USD... there is no hw isolation 
> within a partitioned IOAS unless the device supports PASID then 
> each client can be associated to its own IOAS space.

That’s also my opinion, it seems that PASIDs are not supported in
that case, that’s why the clients share the same IOVA address space,
instead of each one having their own.
In that case I think as all of this is cooperative and can’t be enforced,
one process can corrupt another process memory that is mapped the IOMMU.

It seems to me that any memory mapped in the IOMMU is that situation
has to be explicitly shared between processes first through the kernel,
so such memory can be accessed both by CPU and DMA by both processes.

Thanks,
Mostafa
