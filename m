Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939433EA
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789339; cv=none; b=JPJYrHVrXxmTTngi5E2dwMwmXKLwPV2O6HSCdiosRvY+2D3aTtuXGVyWECW/2McFY9T4lVIMlyHmKtBQDkg/qi35Py+9Dvhm7YT2CpykpPMMCPOzx6Di7/6CuyNGgbzKcsW5cSMgUOVonnsbwc0aFdSQNv7NXleognNNdcMFJrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789339; c=relaxed/simple;
	bh=fCCZukAuf1ZGTvdBNIOP21esoFsR86SfKtRp2H/OEAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBGbW6QQL5GpN0HJ5ts+hNSYQ0yhMnyodYHsXo1qVUXZRTDPonraSvkQI/gS7aG5hV0jerx6YcgWIm58Hou2Qsy46cqzPk1bHXg6BR4LapIogTB/O3Xe9Pg7HCeOxD6hFfYH/R918XTKUHlo0WwYn/iXFacA+yEqWjgDrUOU2W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SEUS2Yx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SEUS2Yx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca03687fdso8035ad.0
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729789337; x=1730394137; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8asSIWMJ4VxW95HSTlFcYjf4b6xkmlZbQtmI3uAFUQ=;
        b=0SEUS2YxVMDd79azfyk+h3LcJBH3NAtkKc2XUP0vu7bxRvNz0U8NV+JJiVBDq/AyzB
         aVZI+dNZvEwSkyOWCPQ6t7gLcyUWg5bkUBlnv/J0SxsSvCr7Nad2bJAbzsluDzkzm7a6
         YZ8IKxaeGXuzpEmpcDYCyyNFkku3B3X/JXP0ZB3pFFD9VodIgryEkq1ahpdozdqdpFfe
         7Mf0fxUasCnZm050ribx9Xz5RywWqT2zmWr7oIo9cu7vbqG3xaZzrOpRhKTw43dS/qZR
         Eo8aTtvo+asyZN1EAYhiyvGhJPOJqL1LYjIjAk0Yznj2vApnathCt8TQxBH+HX1ff3TA
         qbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789337; x=1730394137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8asSIWMJ4VxW95HSTlFcYjf4b6xkmlZbQtmI3uAFUQ=;
        b=ID7AE7gktQ9Wwerag43JclsMW2uhBqjkI6EKtYAx7+fQSJf3OSCuqg20SyDx+AyFIm
         by8g6ReYWKcCNU6Bbe1x/qCNy360ShLqvnnsittAlZ4qh7QYx1K4CXO0Gcut8j18Iep8
         Uz9rUOnRhtZzIZ4cpY6s9JDCpjd5NQ5amiAPm38GWjwO12GhGB+xWnnEGn81n2OPmfFk
         RB0pQDoG3zrCE1Lv5JJ7smIof3MVVYmBV3sJQY42HRHE64TKvsdjMCUYV/g1IUjI5tjv
         udj2tw3vfT1ZtpiZU6PLgCYM+E6s8cgSwCmRf1ChP7K4FiRIYRUUpli0I7DKcRObrhXD
         5wjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdnezmPwlNlNk/0hAlUD3hYVFvl3IEdsByqWens4d65xsH0Tb9mK1+xo/2hdWyWKIClVY1DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUvbSHIKQRc0M7d2hUvVkzNwMLa2R8uDkeXsKSndBfTbly8jOM
	E7Fp/Ee3xD5aKvRBiKpOIvNDG2SNY5YlZpKtPWmGTEtTr2d+kVVN+qz6wXQhsw==
X-Google-Smtp-Source: AGHT+IFweS21hXUTo7S84Xcbe1084ho9BEo0onF8+V3JBoGxW3uK5GA8OnbH7V/3ZR2DyJC18wAkNw==
X-Received: by 2002:a17:903:1d2:b0:206:a87c:2873 with SMTP id d9443c01a7336-20fb76b796bmr2766725ad.5.1729789336410;
        Thu, 24 Oct 2024 10:02:16 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0e1d9sm74606395ad.108.2024.10.24.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:02:16 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:02:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <Zxp9kHerb-ln4ioO@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <20241024131147.GG30704@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024131147.GG30704@willie-the-truck>

On Thu, Oct 24, 2024 at 02:11:48PM +0100, Will Deacon wrote:
> On Fri, Oct 18, 2024 at 06:00:20PM +0000, Pranjal Shrivastava wrote:
> > +struct arm_smmu_event {
> > +	struct arm_smmu_device		*smmu;
> > +	u8				id;
> > +	u8				class;
> > +	u16				stag;
> > +	u32				sid;
> > +	u32				ssid;
> > +	u64				iova;
> > +	u64				ipa;
> > +	u64				raw[EVTQ_ENT_DWORDS];
> > +	bool				stall;
> > +	bool				ssid_valid;
> > +	bool				privileged;
> > +	bool				instruction;
> > +	bool				s2;
> > +	bool				read;
> > +};
> 
> minor nit, but it might be worth seeing what pahole says about the
> layout of this structure in case you've got a bunch of wasted padding
> thanks to the mixed-size fields.

I ran pahole with this, looks like there's only one 4-byte hole but the
cacheline aligment is bad (for a 64-byte cacheline):

struct arm_smmu_event {
	const char  *              master_name;          /*     0     8 */
	struct arm_smmu_device *   smmu;                 /*     8     8 */
	struct device *            dev;                  /*    16     8 */
	u8                         id;                   /*    24     1 */
	u8                         class;                /*    25     1 */
	u16                        stag;                 /*    26     2 */
	u32                        sid;                  /*    28     4 */
	u32                        ssid;                 /*    32     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        iova;                 /*    40     8 */
	u64                        ipa;                  /*    48     8 */
	u64                        raw[4];               /*    56    32 */
	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
	bool                       stall;                /*    88     1 */
	bool                       ssid_valid;           /*    89     1 */
	bool                       privileged;           /*    90     1 */
	bool                       instruction;          /*    91     1 */
	bool                       s2;                   /*    92     1 */
	bool                       read;                 /*    93     1 */
	bool                       ttrnw;                /*    94     1 */
	bool                       ttrnw_valid;          /*    95     1 */

	/* size: 96, cachelines: 2, members: 19 */
	/* sum members: 92, holes: 1, sum holes: 4 */
	/* last cacheline: 32 bytes */
};

I don't think we can do much about the 4-byte hole as the members occupy
92 bytes only. I assume a single 4-byte hole shall be fine?

However, for cacheline aligment we can move the 3 top pointer-members,
`master_name`,`smmu` & `dev` which improves the cacheline aligment:

struct arm_smmu_event {
	u8                         id;                   /*     0     1 */
	u8                         class;                /*     1     1 */
	u16                        stag;                 /*     2     2 */
	u32                        sid;                  /*     4     4 */
	u32                        ssid;                 /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        iova;                 /*    16     8 */
	u64                        ipa;                  /*    24     8 */
	u64                        raw[4];               /*    32    32 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	bool                       stall;                /*    64     1 */
	bool                       ssid_valid;           /*    65     1 */
	bool                       privileged;           /*    66     1 */
	bool                       instruction;          /*    67     1 */
	bool                       s2;                   /*    68     1 */
	bool                       read;                 /*    69     1 */
	bool                       ttrnw;                /*    70     1 */
	bool                       ttrnw_valid;          /*    71     1 */
	const char  *              master_name;          /*    72     8 */
	struct arm_smmu_device *   smmu;                 /*    80     8 */
	struct device *            dev;                  /*    88     8 */

	/* size: 96, cachelines: 2, members: 19 */
	/* sum members: 92, holes: 1, sum holes: 4 */
	/* last cacheline: 32 bytes */
};

I'll fix this in the next version of the patch. Thanks!

> 
> Will

Thanks,
Praan
