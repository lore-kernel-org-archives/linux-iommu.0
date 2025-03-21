Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB941D5177
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568259; cv=none; b=PtFasfA1dCGKzHtzwEHcNrT6Kv5ece0gqaJO5s3r56fYVBkpQ1MvPtZ1U3356rv/md6BXhnnB3TlUWLkcxzGZD6aVrguvw2bR3dio3cApPU0VgkM7JrfBISVZQhq5Xn6UDPgiYyf4N1mSyw+ZkyIEkO0ViLt9JrUoxdkctAsu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568259; c=relaxed/simple;
	bh=tvYKUPlkZNL7oOuBMLqKYyTSkj2isClRJwkIA5TR+Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYeNCdjoh59a8O2qWqcwDHhWD/H2jfIZjUMUAo1L7REjwANMGeQ/H1D3DQ5EVS4T+4pohS6Qqtjs4gKrqjNvabzQafK6u7MQOzESEhIHMd+u5TBZIm1GiaDWme38I9XPQWTVSHx7FYIbuRAGu0k4PsZyAN0vvYKNDKV9KP6AHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAWP0ICz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAWP0ICz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so237945ad.0
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742568258; x=1743173058; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfaSpMQU1Jg+jr4ULTVjwQrwQVJ7IHQwyFEBYSTtlV0=;
        b=eAWP0ICzVWEAyoiqacH8c6McpT0DUjzSnFP0M055BDjgMFJXeAjUSLNMJh2tRAnrgV
         AuthmBW5+vXr2qjJYSMgPk288fe3YheS4J50KTiMBkdC5N9pAus+CdXTBMV5DCn1HLli
         ldqz/vnUU/TwkF/Yu7nueIQuyoJs/Ni6PmAF2XkxZEC8OROjyuvjVZ/+bJgQus8E2EcS
         8r5Qr7mpfhLMIp9EuWWsynNTWURt9dV/HIq1A4mjn6AWC513+TANuYzqXrNGvX6x8XFT
         QJzkr15y/BKFCxZeOuEXyc3Hv+6C5niAdBk5dbloBBueYiWly+4K7lgpe2s7QD5ekx6W
         /AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568258; x=1743173058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfaSpMQU1Jg+jr4ULTVjwQrwQVJ7IHQwyFEBYSTtlV0=;
        b=AEyDABk1dAX0OeqUl9DnO7kJKWeEQzb3At/HVBL2mnD4kT+oCqGZGC1vA3c9GO1kcR
         hm1kxm9K/nGQMFah4y+YZ2bKUoOsjnWw7xJXOmkjjV7UA5PxTbXZuRN7OkKasBwSmQ54
         FZogXu0KdCb6WlhhlxrLqDirz06zUJ5pqdeq+C7AV8gAaN8rKrJbJngU/fwgoSS/qEkN
         1E9EqU4tZ8eNchDS1xeWVEms1CUNQTVH+10x42w/O857EL8QKrC0mOlxWSaPMlSzECCX
         5GNcMVDdMj3kRiRRMEuFoGLT9S+16cqMfL1N3eTkrlweDXEAlgjuzOgE2i218C8BKSTj
         YqOg==
X-Forwarded-Encrypted: i=1; AJvYcCWjYvgmJskIT1eSt117xvmDqVE4oupCS73QXWkPfDx7j3Rx2lu8Lv6bPUBHFP6j7ZE+5jZbpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7awSogiSg+gWcRWapSJMrOMRTGCy9o4FTkxyd9kCbk907ARWi
	GKKRoMH5P2ku2+BYOkdJ2OWL8z8/Vew5UpWMFnYuY5B38YZQ+bnpJmFb1EJZDw==
X-Gm-Gg: ASbGncv0VAU+I1irmRe8SYI0AEZmkzqM0L36He3OqdQ98S3u1m17w6mBnB9jIs0Km9h
	Qe+rSb/y98YqCUTLIIzQ8y7j6+cgDUVuk4+gMfhhq7S6Rn80jGnOnO+9cCTuhqE25V77u92UdVI
	BQVV4VEZp/b3Oe7UQTum00XSMYRjPOqbbzJiQbhXvlAQTDopVxbww97DKZhBsYyng/kXbuwTdL7
	UNNnj5sCT4Esjcsp1TfvZMvhcMt9Yc4PZ5KyC7+u9G/OLOdMEkoSl6UyjED0Hig/79/PbodWTRZ
	0PzqvQpw6S7w7iNTLksYD4xcYRXe3nkgqvj0eZGEtTuZrlS8XHG7/izfKB3j6FWIp3O7JsZ4MLq
	QWcM=
X-Google-Smtp-Source: AGHT+IG1gWkEn6KBl6muH4EEcPMEPVrXzLH6N15cacmydG29ZGkjYVIMi8Gs7Q5si1+WeFO4VWoTsA==
X-Received: by 2002:a17:902:e80b:b0:216:21cb:2e14 with SMTP id d9443c01a7336-227844dde68mr2213785ad.21.1742568257503;
        Fri, 21 Mar 2025 07:44:17 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab82esm2052155b3a.14.2025.03.21.07.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:44:17 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:44:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z917OSsvHBIZfar8@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yWnBmOfeG-7rno@google.com>
 <20250320230551.GL126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320230551.GL126678@ziepe.ca>

On Thu, Mar 20, 2025 at 08:05:51PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 10:28:44PM +0000, Mostafa Saleh wrote:
> > On Wed, Mar 19, 2025 at 04:46:09PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Mar 19, 2025 at 06:22:30PM +0000, Robin Murphy wrote:
> > > > I don't see SVA and VFIO needing any special considerations, so it might
> > > > just be the new vIOMMU stuff which may need to hold PM enabled for the
> > > > lifetime of things exposed to userspace.
> > > 
> > > Are you expecting that the VFIO driver, and whatever driver is
> > > managing the SVA will keep the power turned on as necessary then?
> > > 
> > > VFIO is not going to work if the SMMU power goes off unexpectedly
> > > while the VFIO FD is open.
> > > 
> > > I suppose VFIO also can power off on-demand via userspace asking
> > > it. In that case the VM would be co-operating.
> > 
> > I guess VFIO is tricky as there is a security boundary. In case the
> > SMMUv3 wakes up with caches not clean, there is a window of time where
> > the device is accessible from userspace with old (or garbage) TLBs.
> > I see VFIO-platform always take a PM reference for the device at
> > open(), but I am not sure how that works with VFIO-pci.
> 
> I think that is my prior remark, PM must either abort or translate
> exactly as the domain contains. Never something weird/old/bypass.
> 
> If the HW isn't guaranteeing that then we have a bigger discussion
> here about how to deal with the security issues that creates.
> 

+1. I strongly believe that the disable that happens through
CR0.SMMUEN=0 would (and should) clear all TLB entries or *atleast*
ensure all transactions henceforth cause a TLB miss. I'll go through the
spec once to confirm this. If that's correct and we configure 
GBPA.Abort=1, all transactions should be aborted.

However, still there's a worry about the reset value of GBPA.Abort as
pointed out by Robin earlier. Since the reset value of GBPA.Abort is 
implementation defined.. there's a chance that after a power cycle the
SMMU wakes up with GBPA configured to bypass.. in such a case, I don't
think the kernel should be responsible to ensure security..

Thanks,
Praan
