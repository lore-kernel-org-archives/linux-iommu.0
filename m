Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCB1E9B06
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806555; cv=none; b=pBi7bE1bao+hlwsLZD3JsqtRl3M7IsEt+Em+KnVbrC3tiqDSNa/S6lVtcGO4ZFeOJumtD9MzezfkoaW3mPWhXYpRKBAmyPewW+h3TqmTI9t+JTdRgRHH2dNDd3DtwHcnxJIwWshIhb9/3LOAfknntW8o4+cAytHy6TiPGal2Jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806555; c=relaxed/simple;
	bh=+9MK5Uba3B1mThw+WPEF+LJgfgjqc/Fmngif1Cazx/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixCfi1KxBev8F5f83QoZXRzRhRvVSLAYek3u5AdtOq/kDkFmVWmie6k5dor/smvmghtwxQHWrtMdkPnwHPzLx0ipBoYObZK2y5AEPgWx/Vf6FNpezshJNEmzkOf66OYqKWsrqmoMmTMcSt8bMFUIy2KUn/s4mqJy1se+5c8Di8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3IkMwtGB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3IkMwtGB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264c9d0295so201565ad.0
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744806553; x=1745411353; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMYSkLfK2GKpmX4jUxei26lzwlY/c54Sb0TdXGcaydA=;
        b=3IkMwtGBFNrimOHvn+/TcfcIPH8paSLrsw8BNves/jQJAMCxvQbbIbfUjBYBbPNSCj
         usmoX0g/PUqwa+hu/WOweNehwsFgGi0lK3iucHX4xihtmXTybYFRF+jEsHIs6Zv9rKLP
         pqiP3wJAV/lkK4cQeiu6XVLAJ/a8nyO9NR+vxINxwUNJDnclj9jFZmTTOJFas/nzpvya
         44EhjGHFPTB0Vi1aOIsn/JfyDc2ksoS8XFyzyn0vIiBTSt4zo4+XuZw8HYVkhsslEvBR
         Hwtqf4lfOOX81ukBB97Eq6PHtoAmYHlU6toEWg3sIhiipVPWijIzlqmlzFcWnzkxGOXo
         yTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806553; x=1745411353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMYSkLfK2GKpmX4jUxei26lzwlY/c54Sb0TdXGcaydA=;
        b=NuWk6FwrVApCGbS+xH7I1eceXd+BgFw+48Y66RCEtN7mPaFMUvsjiEbZgGoAq2G9ib
         ujn9yEXqs0QyXizx8LU0HcPGqIw6aic3U9QRndw/qJjJhrInc49I65eASs/tyr2bX5Bm
         TK5rvcu2cK7iOuNv0aQszjW7eySPB6AF6crQs6ajHhN2WMbfRVaQV9uD0XfPYBBRI3YO
         REQLVJG5gKWdHqAb1kMx504ZjN0lbXkjA2urdhhKCQ3rJgJwQWYYIGHIdgcSs3nidbdX
         5/bUyM7PqvunMPhGEaW4JveQGwetWJ9a8meAamZ3iw98M6263A8M6zsZkdu3rRbdJ1BH
         0X/g==
X-Forwarded-Encrypted: i=1; AJvYcCU/aQq+DHTp3hOIlmEh5vHP8uBUTY2e7SCSbHZL/Rx9ZFX87m/ZBejz87UtzCxvIrGWgMlsYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGuA6TiqzkJ3JG3fMQocyVyRN6D5Xd5tZk02M2PbcJuQA/gybn
	zcY0PHe9TRzQh08ua9g8iGKLvybrJB0D1MsQ2YhoECxl2mXhueDLbEYmPrO53w==
X-Gm-Gg: ASbGncvLE633kBisMunxYxWR+Zkzyry1bP684ufwMgNApC7/LAP+V6/A7ohF0Ec64r5
	lvzjLCcPbVDgjFrym22xqBhc/hPHV0FhDUVwofgnPt4W02Dwt/Vv5pHTqMoxTMF4vnTqGdu69Th
	/4JOwyaOdeyclCSk0i9LOfxWmlh9lfk8cZmufLD+PTuHl1sM3FwVucsgvGtJjSGifjJKhenZGEb
	rbptmw/pvBfCewirkPaDOo+c+VlxyQT2HorfWbnM3OoDQSSRh46siB8J0sYbU3qwkeCBJ0mobXp
	PCk8VUaJZ7Yq7A73SKwp+TAA+t76i1sUUHoaHLOYl5d8kv/yYntAgxKsaLstzJN9GUidHRza
X-Google-Smtp-Source: AGHT+IHjUv714O6M4Hn95ODK1CgCwQcte7+EDenoMSkN2ew+9X/bNj+eIA41hbFVmRL7t3ZKEuFVeQ==
X-Received: by 2002:a17:902:e78d:b0:216:6ecd:8950 with SMTP id d9443c01a7336-22c3557b23dmr1225495ad.19.1744806552796;
        Wed, 16 Apr 2025 05:29:12 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe68bcsm12431285ad.220.2025.04.16.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:29:12 -0700 (PDT)
Date: Wed, 16 Apr 2025 12:29:05 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z_-ikT2whG6ekqrN@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
 <Z_7Fx-Q8baoyzJe2@google.com>
 <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>
 <Z_-FdLizyrz2_ovi@google.com>
 <20250416120251.GC493866@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416120251.GC493866@ziepe.ca>

On Wed, Apr 16, 2025 at 09:02:51AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 16, 2025 at 10:24:52AM +0000, Pranjal Shrivastava wrote:
> 
> > Also, this would mean that we'll have to take care if the Guest Kernel
> > ends up touching the mmio region while the SMMU is suspended?
> 
> I think this is approaching it backwards.
> 
> If power management is supported then the power should be on unless
> the VM has activated its own virtual power management. VM virtual
> power mangement would flush the cmdq from the VM side then signal the
> host that it is OK to power down the SMMU, which the host may or may
> not do
> 
> It doesn't make alot of sense to power down the SMMU while a VM is
> running...
> 

Exactly, that's what I meant to convey..
So.. can't we simply take a ref as soon as a VM is created (IOMMU is
assigned to it), maybe from somewhere like vfio_change_dma_owner and
keep things powered on? That way we keep the IOMMU powered ON if it's
controlled by the userspace.

This would also allow us to only care about the host-managed queues
while suspening because we'll be sure that if we are suspending the
IOMMU, no VM is active.

> Jason

Thanks
Praan
