Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176693A9D9A
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038297; cv=none; b=Mm6QXNwGmiHIMzDvPR7fMb4+7odD3eIgnL97fJpit37wMdET/aTWUGBhSwztQxlW6vNzKMEQrcpZm3pv7bapSMKJ32xYt6xKZsYmiGDoM7NhAeHOtiM1FKR+GsyDbkK8bOE9vCk09D1F+9EWoSTTGoy1USpSZDVa3Z1JnYLVFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038297; c=relaxed/simple;
	bh=iam0u/2Jl6XkPvwi1qwhiflT+1xKVHGWQhuOjLQOVSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ick9XZh2qduSyCkHuEiiYh3IKFvJMCYLqrLsRzsNVT/vj2XHMGihgKsyXgdmaw37cU6OaGIIjgfzU3VhL7ykuiIYMYwo1NN07OTGPdEJ5+SoYhrQwKCyhLptkbvZnnoFeWUT2pdl3yqqEjaFr9XP0++OwSTiSFddGDNtA7rH+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amFZeXU3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amFZeXU3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf2911f93cso875ad.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780038295; x=1780643095; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpdj4zdvOr4RmzrDJJcOOQOaZ4aQerKSX3Hu7HK0Ghk=;
        b=amFZeXU3ppYT/sdXo+1XwM6SczF8H68WZ0EiuSF9QgvN8nE/T0M+aypvfXLREQjyOM
         2RtWs/oYrWyWCgAqG2Eja9nBWVYuI6VYOFVWxttgc7gB8eigm+tKUOoaGsRaLPigDLbx
         bcGsCMTd77sXw7i1E39fgtQNYJ1ak9iq/bIgAR0dHILxmv4Sgp167d4d2ZaGfjGZ4Hmb
         X1FyYr4qqobuvtGskl+oIahCgFKjyv2S2oVxQKg+22pObasuI4i7aw56CKLoLDznPT8r
         WqgDs8OShTQZUH2AZkFs8nhtWxXeT/5eXorKz30x7Z0ch5HW21N0z+bYeanS3CQC8KH0
         lFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038295; x=1780643095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpdj4zdvOr4RmzrDJJcOOQOaZ4aQerKSX3Hu7HK0Ghk=;
        b=WrxHYJmR/lb5MEAVibQjXlp7IQinCWSG3FdopQLgFj8DEYzDnl0p8FBV4f3M+lbm2X
         Xovuk0OlRJKXd4xoGYMe9Q479PUBebpmgXl2i3ow86P4Gg/gvMieZneNs0Lj/vb8SEsI
         QiejMtXD+vZ0p7f3emWs+nRV8+VULL7uRrRoD4p9d1CXYEko5lirqsOCN3a32K2xj3CN
         DmU3ZX2BY+EZRzbHbznGn4fgxfs84OlUTyucgqcn5Qel/NXg1iI1Ya5cWSzVz34efjm9
         OtVdAkO7IVx/6nyaXeDKtSeHVvyyrTJJTzDeNgecdcRC4JNQywGz+d+NSbE1IoUKzaIm
         2ZzQ==
X-Gm-Message-State: AOJu0YyHH+SFfrKewj/NzXL1EsnULegX/PEuzbHdYMT2je85JkvAig9U
	0qz/AsVn88sxeUrQd3xH4wcqUgMhja97ECXP47+txexVCDYGkakGQj0NcDFTZEFNeKVrA5LdNkf
	RbRlx+w==
X-Gm-Gg: Acq92OGpM2BWYA8oBQlrXwbX0WTG4bEyAp0KtrZ1gVTbR174HQmLuUmhbZt4m2xKElN
	YfYflkiPiBID1Kp7UvWHaGVV5UbFTcZEcEniU2eNrjTNkCRSz2jG6XRBfyxY4Y+yYCmIhS3eEuK
	shUNPtn7K0kByP2tbQ7ceMXgU4xv/FQPDCabe3hnuJc9j5J5eUtQdYzpd/vwYspBF3FhW36uVjm
	x5V9VWtYxDqK++NenecsI5QaALF/M8zcVvc6x9P6u1UI1yzpztki19lQUKi0PwGw6uv/5if4ntR
	Oiqxh80lW6lHCgCU9Pu934hstscITkB1dcx8tg/V6BhdtqLvXCtLcMRZhUzCOCNGixofcIuNw8F
	5UE22B7ypB3eBO9RysUTszWpGzlR3BhIQID1qC2l0TGfDRKLF69tARlTT0vLoKDq92xyV9r2m/I
	5RrYXVP5UKvGQH7kuUXlK6hiB/vetQry0EoYP2z6ASjCgItkpWcKsXf17weLUed2W3BvYb
X-Received: by 2002:a17:902:db0f:b0:2ba:73c3:49b0 with SMTP id d9443c01a7336-2bf20d1645bmr1335815ad.14.1780038294503;
        Fri, 29 May 2026 00:04:54 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a7c24sm914873a12.2.2026.05.29.00.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:04:53 -0700 (PDT)
Date: Fri, 29 May 2026 07:04:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] iommu/vt-d: Fix RB-tree corruption and
 Use-After-Free in probe
Message-ID: <ahk6jom_zexIt5S8@google.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-6-praan@google.com>
 <5c5e85f1-f745-4667-af0d-30af71288294@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c5e85f1-f745-4667-af0d-30af71288294@linux.intel.com>

On Fri, May 29, 2026 at 11:20:47AM +0800, Baolu Lu wrote:
> On 5/29/26 04:23, Pranjal Shrivastava wrote:
> > The intel_iommu_probe_device() function contains two pre-existing
> > memory safety issues on its error path:
> > 
> > 1. The info->node RB-tree member is zero-initialized via kzalloc. If
> >     a device does not support ATS, the device_rbtree_insert() call is
> >     skipped. If a subsequent probe step fails, the error path jumps to
> >     device_rbtree_remove(), which misinterprets the zeroed node as
> >     a tree root and corrupts the device RB-tree.
> > 
> > 2. The info structure is freed on failure, but the pointer remains
> >     linked to the device via dev_iommu_priv_set(). This leads to a
> >     Use-After-Free regression if the pointer is accessed later.
> > 
> > Fix these by explicitly initializing the RB-node as empty and guarding
> > its removal. Additionally, ensure dev_iommu_priv_set(dev, NULL) is
> > called before freeing the info structure in the error path.
> 
> Thanks for the fixes. Could you please separate these two fixes into two
> distinct patches and post them as a standalone series? These two fixes
> are quick cleanups and are not part of the current series, which focuses
> on improving the robustness of ATS enablement.

Ack. I'll send these as stanalone patches. I added these here to keep
Sashiko at bay.

Thanks,
Praan
