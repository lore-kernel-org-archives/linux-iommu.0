Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69BF9DB
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599977; cv=none; b=DiqOL5/XwkSc576b6ggIdvuEjcxV2mJ14wDdAbj31H6Pn0/bLVHz7TS5p6hse5cUz5i9x57bbisD4VKttKlIOjFdQ9M9dOrCIGJSxaYcqKnRP6seFvxg826ZpfTcMIqqjvtouTJJg9CR3KegqKcpnmVfZG7mjGq6IvKDETEMmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599977; c=relaxed/simple;
	bh=eVi9HnEVBXePw8CULuM7naqiYIHNPKc0XNaedsU1Cgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKzLAs+UvHT0mQ7OVTcIzoSuOZLME+LquE50+A/gmiaZV/x20ivnGh0ZfTybsi7isgNbBOZYpt4Jm4GI61y4yO7C0okCImy4Qwt2BdX3KrIOtehrYohpUMTkvOXfHWwi6TLaxuDo71KUuhP+SpgHvAr4gCI+9CgPSMM2CHYPUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KYn2sf7a; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KYn2sf7a"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e4f706847so37250581cf.2
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 16:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709599975; x=1710204775; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QezIdcMhBK4JmpH5lnLJ59QKzefVecbHv1nG3ueZguQ=;
        b=KYn2sf7aoio+a48QAR6dEH72PsdtDWYoQn/0FwAeOi521MZEKY0A5+89uCkBP2pwCt
         tAiPQGrTltlt+psAzwHT3IIPXnlyOWsSg72hy0LyxoD9SNU4EJJCZuWQKFtuPZVF3ZbP
         yPx++yzls3mBMiAyvPvco24hmCXsknCavS6q+dzS86ftA22qe4U0kc5l2r1Cf91MRNrZ
         YfR2RqEn85rHi38TAEIV98dNovmAIwzTg43FJV1nOh49Mc2nGd+WzkjA7AMrcniUC+iw
         d5IQHWNAyoPwVe1pCun3BtRaKylNNWpFLF6B2GHWMnupa2lwL6G6GxAfOeQfGvNYBuRv
         YBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599975; x=1710204775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QezIdcMhBK4JmpH5lnLJ59QKzefVecbHv1nG3ueZguQ=;
        b=YXmaeYMnoXQPBENcv6GLWQzgXwyGlxMciNd5r/C8QHfWMd3TWCj0CftLYKzoY3eQpb
         BLg/yYEZyi0xhG8ZF4SCVgnw82+jNGLY2+2JQzOAaEOrx/+jO2k62x3hZA8bBiL98phy
         bNTGGyWiKmTyXaqo9jqfMkoqjzO3RZ+qOxhRiBE24xafwDZt61PND7zUgtHbPAmfs9e0
         4EHo1Vu7uSCjbRkTLyYeOJ/ehApGzS4HCRGwMhwTOj2zMLE88wuKDlZX/kHO+0+KNIQm
         PK3WNnM5IjknI8a7Qx3nk48xJt2SXOJIY92QRXCCZcW1MN0oCBrjgbRFePfaT2cxMOHx
         VHIg==
X-Gm-Message-State: AOJu0YwpHW74+uVKV8d2Wu4Q6W1iInwFWfVMAnXnrDvsyL5sxL8wZwkd
	q1GeZleoX/5BDvUkshbvDdnOuHFxi3NBPc2MYqfQJzPRzEPa5cZ1cP5bOm7rlgABlageV7t7+A+
	mETk=
X-Google-Smtp-Source: AGHT+IHSZQI5whEGo+0AVcLk0R43AvtytXIV6juSbIy0oDmeDbBbaq80hJQgYCeSLJPb4GgOZoOEuQ==
X-Received: by 2002:a05:622a:24c:b0:42e:b470:1ba5 with SMTP id c12-20020a05622a024c00b0042eb4701ba5mr607487qtx.24.1709599974901;
        Mon, 04 Mar 2024 16:52:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id kq5-20020ac86185000000b0042efbd83ab5sm483098qtb.5.2024.03.04.16.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:52:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhJ37-00DceF-Rf;
	Mon, 04 Mar 2024 20:52:53 -0400
Date: Mon, 4 Mar 2024 20:52:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 00/15] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Message-ID: <20240305005253.GI9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:15AM +0000, Vasant Hegde wrote:
> Jason Gunthorpe (1):
>   iommu: Add ops->domain_alloc_sva()
> 
> Suravee Suthikulpanit (3):
>   iommu/amd: Move PPR-related functions into ppr.c
>   iommu/amd: Define per-IOMMU iopf_queue
>   iommu/amd: Add support for page response
> 
> Vasant Hegde (9):
>   iommu/amd: Rename amd_iommu_v2_supported() as
>     amd_iommu_pasid_supported()
>   iommu/amd: Introduce per device DTE update function
>   iommu/amd: Fix PPR interrupt processing logic
>   iommu/amd: Introduce iommu_dev_data.max_pasids
>   iommu/amd: Setup GCR3 table in advance if domain is SVA capable
>   iommu/amd: Enable PCI features based on attached domain capability
>   iommu/amd: Add support for enable/disable IOPF
>   iommu/amd: Initial SVA support for AMD IOMMU
>   iommu/amd: Add SVA domain support
> 
> Wei Huang (2):
>   iommu/amd: Add support for enabling/disabling IOMMU features
>   iommu/amd: Add IO page fault notifier handler

There is still more to be done in the drievr, but this looks
structured well now that it should go ahead. I think you need to
rebase this on the Joerg's latest tree?

Either way, fingers crossed for this cycle, sorry to have been so late
with this.

Jason
