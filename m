Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47B33121E
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856166; cv=none; b=R2jZkbFkl5KwhFNY1yrWDvG0Kf36XZCNTBDcZaLS/HsgkHImw2Ed0kEo2a4QFUS65skLnLPelCW76Ymls3LrRgf8jRVgXt9rd+ECUwSMi422PohUpyCrLimuGJUAZgU1zLrBpOFgJOAD20mk3o9abaLXvTFuIY6NCr7FxptjLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856166; c=relaxed/simple;
	bh=Y2/o/ebxsdPQbPCrZDWTV82JL/XtU45w5Gvly4ZT4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFGWEezfZLJ28hGitHv+01BGWzsUWn6qaJSzZPtuqdZcL3rcJTnpuwIKGeUIpjCA8mts3sJ1tpIR1MekGBUgX+OzyTI1wtti/N+ghhRdQK8eYXYweEiU1bxp+RBSbfPbcuT9taPIEARu3JFHUHWyIdFBt+jUYs7PWuoxjcJvbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxMlvBCF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxMlvBCF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b052ec7176so5725ad.1
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773856165; x=1774460965; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2/o/ebxsdPQbPCrZDWTV82JL/XtU45w5Gvly4ZT4qk=;
        b=LxMlvBCFkHYCBXFntctdQMAzvmVcjoF/PkVc3Y5NZloLlCSeSw0ghu6eukax5SIcRm
         IcgdMY+e7cRZtFT+6YrQpkiU7v5pMlOGyncDJfJJ0XCyZbJLN1m9BN/sOYl4yVBIjSZC
         rSGsiowL567evAj/Lb0yIssngP+rSGenWa98STGDD6X7hHMnvqlYIQTmLOnQ7rIoN4eo
         Q4xpNU0hxLGP4Rx7d/xDCzCs6c7AAkFB8KI/eoZNQSD2tTpIALZcCtbV0+p6mROk5GUb
         qqX2Aty+TBG6qTTXuSv9caTew71vWXzLf3KlV3FMtQw/2z/L2JiOHLEXsmZsULSgieEU
         7Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856165; x=1774460965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2/o/ebxsdPQbPCrZDWTV82JL/XtU45w5Gvly4ZT4qk=;
        b=E4aAWHm3yDCbKY1vFBKrRLxkAS54HHm3bSC03NQULbkC+BZBYeAXSu29ERXRmQKonu
         0e+TaL0ue3l42OOVs9e7oZBxH6U6ZSIn5qNMw/qlA4V7SQeDF04frra/5KKjJWAUNDPX
         S/hlqyMchfnqbejISKjZdog2KoaRkSxdRDlv0fK+9H2ixBogqyaVeWjmJtkBwNb4DSah
         VKDihHfkvcD0RVKZUdwoEUWtJBSS3r6a/TA1vjVoCLthSc5c6B7Mdz2yf1nqrVfclHtH
         uHI8CNdEQhH6QCMMwcReIxAgSJMgkPiphpSLNTqD3uTdp77ZkhDJpkMUQcBXspH6Oejt
         Mrhw==
X-Forwarded-Encrypted: i=1; AJvYcCUmBXHyB5qf4G3DTaA1O4kOijA0LmmSptjy1vlfTPEPcc5gdHTOlksgXFLDyulqdYlD6IDrgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKBFbO6BKOG/M2jQrw+xlOLlEptU5pB9zXtS3qCdYpiCkRKE/f
	+ME/3uWQOCvD8Ttys9o2S8dLXwihU2xydzwGCJ+kAZvcTCsv/Z00p3EkR3hld7sJzA==
X-Gm-Gg: ATEYQzyStMAv6QRor8vZBErhmorNGHJRgnEGL630YJTXP5WnRZbJw5gKUC7fHWFkC7A
	gwhErsVqgw+0BaMI1hiWfhp4g4prqXER8wp0AhpVQY3aiGrKnME4Wf5XB4Q6aQazKiRzFzHZPOE
	yhTUesa1pd1HJ55DdZzs5rp4TOlYhaFeZ1KldEb3cBSxgtDGeG2vTvmKc8qVcSnh+Wyl2yQANrJ
	GyNgboUyPRqzmugNxJnnEZDdOoX8IUj0QmxZ5+sZ5OGopYcKzYcd3U9jk0JR2c4/DEqk+X7c01t
	yQulY8F2NbGO7+XM6nJVI8L1iqJSUymNITxrc+rpLIbAlPsDeua/vDLc+wX6Qq+LAacp5CXCr4f
	CihZHGlLOR/bHVq/F3JQ9rJs92USeiDxs5c9fGsgQ2/wTpoT7pYIyD5cRE+lNrLuhbog2ELtTTO
	PkcTQNVXjELQeOX7WUTa1khCqTDX7pJER7cMuszgRcJV/Mj5avpeBildPdcFcfLg==
X-Received: by 2002:a17:902:f544:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2b077df8c89mr179905ad.20.1773856164572;
        Wed, 18 Mar 2026 10:49:24 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe6162sm3180791b3a.42.2026.03.18.10.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:49:23 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:49:20 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <abrk39_M8k45myXJ@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <abNH7LAj9thuGOoG@google.com>
 <abROLLfSUK8pXM5J@google.com>
 <abm09vCaAMtiQPVs@google.com>
 <abm1esL1dzN7NTC7@google.com>
 <abm4ShqPTxIujDlt@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abm4ShqPTxIujDlt@google.com>

On Tue, Mar 17, 2026 at 08:23:38PM +0000, Pranjal Shrivastava wrote:
>On Tue, Mar 17, 2026 at 08:13:47PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 17, 2026 at 08:09:26PM +0000, Pranjal Shrivastava wrote:
>> > On Fri, Mar 13, 2026 at 06:42:05PM +0000, Samiullah Khawaja wrote:
>> > > On Thu, Mar 12, 2026 at 11:10:36PM +0000, Pranjal Shrivastava wrote:
>> > > > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
>> > > > > +EXPORT_SYMBOL(iommu_get_preserved_data);
>> > > > > +
>> >
>> > Also, I don't see these helpers being used anywhere in this series yet?
>> > Should we add them with the phase-2 series? When we actually "Restore"
>> > the domain?
>>
>> Phase 1 does restore the iommu and domains during boot. But the
>> iommufd/hwpt state is not restored or re-associated with the restored
>> domains.
>>
>> These helpers are used to fetch the preserved state during boot.
>>
>> Thanks,
>> Sami
>
>I see these are used in PATCH 8, should we introduce these helpers in
>PATCH 8 where we actually use them? As we introduce iommu_restore_domain
>in PATCH 8?

Agreed. I will move the helper for getting the device state into PATCH
8. But the one that is used to fetch the iommu state is used by the vt-d
driver in the PATCH 7. I will add a new patch before PATCH 7 to add that
helper.

Thanks,
Sami
>
>Thanks,
>Praan
>
