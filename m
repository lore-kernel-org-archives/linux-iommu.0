Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE39283140
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691646; cv=none; b=QF4N7NB3YPrwDu7xPmdLqVem7GOTT3kUbtq132UjX8ctDNehGseqtdRykcD3UTol3rDBx2LVn2wsPu9/VzfZQ74Ee3mb6kvymJv7/EDluT1wpXlTFUpftOhmRnR2sz1VNP2ymllVD3w4tivKv8XZtvafIpzxXwjfI4WcklNXNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691646; c=relaxed/simple;
	bh=T97FIRu7KTdXAKAuE2uiR/N85Qp0pQvg5x4paRRjBE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr+++J6gstwyS7yjNeElarlcN33p2mk5v4OJ9TXAiweCkmufKM/IZ0OlaAq0+2hPwM52tIMt07wEwbvySvag8DUyN4MEw4pol/IZDTJmkK/tZtdhI8Scl7u9Mpw4tAF7sZ0yzbVAT5eIv6xhmqnf7f4oZZclV0GJUiKNIHHRe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZ2HHS+8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZ2HHS+8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2357c61cda7so223505ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750691644; x=1751296444; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQjNcvHYakrNgjIQGLE/wyS2yfZF4798fujbYGUPWpc=;
        b=lZ2HHS+8iV9qToBbN9H7BKcz9WrbWe74+R+stKoQ8S++Q0mQ/4CKX+HZZnr/p5/lvo
         1gFcNYRLVS2lmTQbyw9nTZCsxGZbIoqn4wij3lZ7kBZc/yPyga2FEXOJQog7qRkSc7EY
         BxoLKl0g6krhruBvlz8o2GX9+IIqohNjgCVbDis+xIVPoPiQi+MTAfu0YrZe4SGx8Jm1
         IrzGi1vpJINQT/OTEQVDzZg01xUkXCX5ojulw2q/j+7ETuGcWuJ1x4b4etje2xjdf4Cw
         aumQZPHX+vC7lAd/+WsFQAwBUASDGwGdfo8NeBkIs5I7W6KhnK2FKerCxfcK3CIsxfLy
         WZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691644; x=1751296444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQjNcvHYakrNgjIQGLE/wyS2yfZF4798fujbYGUPWpc=;
        b=VGyJOr+xhAQRRSRfXNzL/cb/l9I5zXg/xSqcRbi1ItgDH+ZWN70uq+m7ZkiqBG7nRZ
         Dvbcnc4JBl93rAu3/h55tpTXxivHQsdWBGudUukwLj2qv6IhxKsOEbiNcA1viI9rs0L1
         Jpp6Usw7GulIh2Hm9jJl6Y75heKIyQo66hdK1W7Pe59jnkRTbwEc9i81KL3jCMSbEl8g
         2jy3PioMoq5OsDnSnUIpouSXNKA77o0rtTVLOWCcqmqw5LqssJioL/40WK93iNPAnReJ
         m/9SP3kOc9kG2wDOMQgBqU7jtNb+xXQBBcWUs4/xFWQDlRMUc/rTqy0EDbHdnzbr3Lfk
         jA8w==
X-Forwarded-Encrypted: i=1; AJvYcCXz9QcHrARU0Geuc0nEkkAkxjEAdxlkWN0KdLiKnSB/oqPCaEPcov1VqiP+0bDefUs3X/jxkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY12ixMBvVyUImGfkDjb6zaoqNg74WtSo0olG/BY4+YbsLQ/Uh
	EIKEsTaebeOr5FgFGHJmfmVbvFx1wyAqKv4hSZ49gCn2s3Q7wPrk12MhxVgdpGICiw==
X-Gm-Gg: ASbGnct2PLUlZ0WKo77TPMz5bJOj2Ua9IT/H1bDY1YAvhaqjB08LGGFFKxYTtxhda4X
	cx9axOgCRq0UXSJgYmp+JlfMbVXyY2PLrh8pbwREEnd2wraVkD7bLgO3GrQUimqEl0G7OXrPXGF
	Ci9ZJ0qSQLMS1XEW9D1HS7qGbhBtpn5e79M0SotpchLyAl0tysGZ0NagYqdRxUhQA8Udz9kYwml
	2X8AT1bW/gasVCgbRSxNhMVtHDCSLKTUDXkcMNevXJ6zQdL76DhFU+tT601vtOVQml4jIfxXUqB
	iRvO7DaRG+qLttSJGJomdDnd8uOgqvWiRqwPlk3Cff65cNL7ZQKy2rhITqnNIEPEpVy1WE3Iz5O
	joBE6SDs2CgzQHwBZUpfDKNvROf3Jr1E=
X-Google-Smtp-Source: AGHT+IFjZuHSmjWz3mlyiiORGjulfaekm2TrngIFHZiE0ZqJkNGQDEFi3n1LBmgMIlW05C9z3Da4aQ==
X-Received: by 2002:a17:902:e951:b0:224:6c8:8d84 with SMTP id d9443c01a7336-237e478a96fmr4808555ad.4.1750691643222;
        Mon, 23 Jun 2025 08:14:03 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a23e6fbsm11004566a91.14.2025.06.23.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:14:02 -0700 (PDT)
Date: Mon, 23 Jun 2025 15:13:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
	will@kernel.org, bagasdotme@gmail.com, robin.murphy@arm.com,
	joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
	nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
	mshavit@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 20/25] iommu/arm-smmu-v3-iommufd: Add hw_info to
 impl_ops
Message-ID: <aFlvLw0SHgYiA614@google.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <f36b5e42bac83d0cdf5773cad1c3a44c3eaed396.1749884998.git.nicolinc@nvidia.com>
 <aFP4zHIVT6epJeLb@google.com>
 <20250619185325.GB17127@nvidia.com>
 <aFTWQ4v6aZABpzeV@google.com>
 <aFZE+MhTOCvbkKbH@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFZE+MhTOCvbkKbH@nvidia.com>

On Fri, Jun 20, 2025 at 10:36:56PM -0700, Nicolin Chen wrote:
> On Fri, Jun 20, 2025 at 03:32:19AM +0000, Pranjal Shrivastava wrote:
> > My point is that in-case someone passed INTEL_VTD type, we would end up
> > calling impl_ops->hw_info and then the impl_ops->hw_info shall check for
> > the type to return -EOPNOTSUPP. Either we should clearly mention that
> > each impl_op implementing hw_info *must* add another type and check for
> > it
> 
> Let's add this:
> 
> @@ -721,6 +721,11 @@ struct arm_smmu_impl_ops {
>         int (*init_structures)(struct arm_smmu_device *smmu);
>         struct arm_smmu_cmdq *(*get_secondary_cmdq)(
>                 struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> +       /*
> +        * An implementation should define its own type other than the default
> +        * IOMMU_HW_INFO_TYPE_ARM_SMMUV3. And it must validate the input @type
> +        * to return its own structure.
> +        */
>         void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length, u32 *type);
>         const size_t vsmmu_size;
>         const enum iommu_viommu_type vsmmu_type;
> 
> And I found that we could have another patch changing "u32 *type"
> to "enum iommufd_hw_info_flags *type" to avoid some duplications
> in the kdocs.
> 

Yea, that sounds good. Thanks!

> Thanks
> Nicolin
