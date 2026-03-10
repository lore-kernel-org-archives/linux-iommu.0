Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ABD3E315F
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172852; cv=none; b=iLcbTXV526+LCH88duLQtTzJX0p94NLiednRnAiOfqv02mHSALh66ezf4aqa1Sd4DjrcxLK1OUP7/TgLqql8gOTa4PKc2FmQfOg39+6Weio9KcRkAAbHS+10nbOSBDtgpIG5NbRJMcbpj1OpPH2fFcqIlT4MkBtthDeuOfX0kDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172852; c=relaxed/simple;
	bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egJBiUNDe26u/yMH6vUT2eZw+dDNpFtpPgMRZCrVAxG0Wtbv4vs+DNiVLTCTwRayZa+VciVvsQmoBVh14jKQhaUpMhDrA54G7hsvmGaRb9JdTntmm2F9MCUJshEpWOv4Zjd+P6HyP4BbcCGmlJuh7MFQhY6wjycFsfEWZPWPBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKvsIILZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKvsIILZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae49120e97so23755ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773172850; x=1773777650; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
        b=ZKvsIILZ/d5CTw3aj+AtZnf0fnnmi6NZIAiXKCOtCB+Wb1+nUrTHCh/W1XRzmumK69
         rDUNaY0kyvByUm0NcWkQVe7HHLf6nqpEWIv3idJes79nWTblx9cbuWNCM7gKhdPh+gy5
         ng8NVUK1a8BsZhy7p7PxLxNewr8xy33DEDwCmnHqOseChjVNMsG89r5W57QWetkmiKJ0
         2MJr6R4aFLBUsFggfMcAHFDfIF4xHsQ94f3DRyJ6ZhsFg/5fseT7QBCZKFxlDhxTDFew
         KFypwLdbkn/ix2MbfwWaYLfUXG87nIHqj+Hnz7yT3sdwZ5fdZ0E/e9BE20t1R1ZEbtCW
         gctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172850; x=1773777650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
        b=GCxSBAtZJVN6G6U+PDtfA5+QF4t2KeuSviHKGRU3VRAmFDcnHbM0foYIanYOZQeWKD
         G9eCkVQVEVML7xalSkqIz/UUlrnkxV9KMWFU3Lbx/lH6ptRoIRF1kltbf1NQK/4Nzgn+
         ZkUMm0hN0hlVl+vqu+NYmRWK6jjlLSY56xL8xxijBUXrQvLfZ0+KsUDCYNaJ1/1xRDpC
         iRQFbznW7C5xiN3O15gEftoNrnz9ih1SSt93JYFXcNGuxn3sxqN3ITIczXcI0BZ3I45n
         PVbr9JDnb2P36h1QQ6Xv5FU0UqRlFqs8Dm8RAS391AvocfOCHahVwh0j4POH52N66Ikb
         9kOA==
X-Forwarded-Encrypted: i=1; AJvYcCUBDAedzDHhlvKJhJsnm/TQvG0gIZvSWN/thX7lnEg9CAL7zBoEELF+zKLDFtTezkh6vzMwVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxR+957J7mN0k0Zej5yw7JR5e7CH3/1V4jqSd56cGL2Hvs5S027
	iqbiMZTX6+vR6aW5VbsiuZa+GAX8ELP8Ld8eLtB3be5DKzn6G2kEa5IWk8Q3EVomrA==
X-Gm-Gg: ATEYQzziYkbA29HfiCahjyZNy4AOe6A/E6FDTDb5PS26OTMSWq/BFNtUtUYLDThlXfU
	JnvsKflvYuWLF3JHnVwZXgEQPH2woacou+A6z0VH1laJ2KVwPco/kpzLdmwLe8lntpZegyfND9i
	visTkYqetYWnAwofJZ2BcQqZMbw36htYPlbwW5c8Xms5iAe3ZiEq0lZ1r11DHO2Y40kunrxf2iB
	J3u1WoAr0hahOXXPhUEUyjQdsuOQ25vqa+8jbU2PrEq8DlxHYKBwdHD6VZHWoMoBfAZNjAlS+KM
	MuEIoQ6EI/7qq+a260CxvbKQqtVFboH2S5maz+OmiozERWkPJJNS8D9cQqqtRV5Sr45cZXzVgmN
	4cMu7T24UePcCv2d1Ne/j8XpGlge0M/ADZg8mbKg3hOLuJAsQC/znYCkwOBUeDxTRQjbLuKPycI
	0PX+d3ZxNQtu7PtqBq6Q7ItulbBH1KGrOuw7+wROpS2FDexL/1nVWSW4qs7pl68g==
X-Received: by 2002:a17:903:234d:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2aeae708648mr72605ad.3.1773172849749;
        Tue, 10 Mar 2026 13:00:49 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f110991esm3573204a91.13.2026.03.10.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:00:49 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:00:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB1VJ5Op24dMIog@google.com>
References: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
 <aasv1HYOKuuJyi1k@google.com>
 <20260306200321.GN1651202@nvidia.com>
 <aas0dLwKmZyL_iOL@google.com>
 <20260306202652.GP1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306202652.GP1651202@nvidia.com>

On Fri, Mar 06, 2026 at 04:26:52PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 08:22:08PM +0000, Samiullah Khawaja wrote:
>
>> But do you think doing the timeout logic without fencing would be good
>> enough?
>
>It is what ARM and AMD do, so I wouldn't object to it.

I think without any back pressure to the caller, a device will be able
to fill the invalidation queue with device IOTLB invalidations that get
stuck until the HW timeout occurs.
>
>> Currently VT-d blocks itself, until it gets an Invalidation Timeout
>> from HW, and system ends up in a hardlockup since interrupts are
>> disabled.
>>
>> Are you concerned that if fencing is done without an RAS flow, the
>> device might not be able to detect the failure (if it really needs ATS
>> to work)?
>
>Yes, and then the device is badly locked because nothing will fix the
>IOMMU fence.
>
>VFIO might fix it if it is restarted, but other approahces like
>rmmod/insmod won't restore the broken device.
>
>So I'd rather see a more complete solution before we add fencing to
>the iommu drivers. Minimally userspace doing a rmmod, flr, insmod
>should be able to restore the device.
>
>Then auto-FLR through RAS could sit on top of that.
>
>> I am thinking, we can do translated fence and timeout change for VT-d.
>> And the device can use existing RAS mechanism to recover itself. This
>> way we atleast make sure that caller of flush can reuse the memory/IOVAs
>> without UAFs.
>
>Without a larger framework to unfence I think this will get devices
>stuck..
>
>Jason
