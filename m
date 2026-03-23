Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A926CE11
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299560; cv=none; b=SezJwoPa/Mxu/CwPkvkTqVf4mPwGFkVS6dfJuzZwdf5KollgnjpcbPGLc9NWFa6FRjOfWLJ4mlinnBUdyPNjQzyFwT/Wcl7iQj7xHetDi1i+CxL0uLzn8+Vi2LH80ZvWbH192Trb4vD8P4aaAlk5OmLngHwB20OLyl0AjmozjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299560; c=relaxed/simple;
	bh=IKUYy6h7E6OacLnO0SCP+Gf6jvCT2VvxqJLPXFXcJuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VThpl+9UDXhNKqRnbqLbRgdzsn9vpFgYeBr2qda7S8MXDYjaYPelwtme7yD9Aby4S77ds8U/Iwgu1PTHeBQkoasbI+gDfc3CWrVF33gT0PE092rew62rZHWlqb/kFCs7Y10McVO7aAqnKx+7GCUiwRbCNOku6T/KcLJxP3k1o6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFNzHgRZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFNzHgRZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so26835ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774299558; x=1774904358; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfEbQ9zMwITLJ6hWqGMJubvK51p36l2V00YC6g9wwEI=;
        b=vFNzHgRZ3fOcM9e4jqnRnz47SUO8jGFRvKZT3dw/MVuYQIMX4HpEiTRF021mZb6kKc
         KHBYqC31GGjkSyF1Zef0tTEcbeOJthsgZ1AyqIAool34xrS8eBxHiggN2TiN4RkZ3pmW
         LnM948+SAklg2drg/+blwdtL+O6OdV7QWSnUwvmQ0TYwkJ+ttVQa7AnCTb9U4ZGH+ma0
         xtn6riCwiG9yRvQOJwTbcFQUWGFGN/uz4rOGZqg3fi52/dI60piY0Qw8pItvv5ANgx+l
         F3zL4tWpbfOyHR9o0cyIiAjice/2mPNiHqtruh1U9R87G6P69+rZhnks8ehi+mcmGN5z
         Zhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774299558; x=1774904358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfEbQ9zMwITLJ6hWqGMJubvK51p36l2V00YC6g9wwEI=;
        b=Cs0dUVHh9BjFOFzdwHJvEQ8U9SLGL5ax816O9JlWWltxYBjlxpDUy0LPOADXiNKgip
         KoBkWWCPKBGksMNnAE0rwIudAssQ9BnQf2WXOVImgHIRAXIwEn0vb4kye04fee4ZqL5g
         8uTBGtS4pXAybCG9+7DuQU9PTMyaPAAdbC9nGflyeswau/sQpbnykKCV682Oq3a2ibz8
         v27OEjs5aPTBF3Nf7NzYGOp47S2sYUOLJ15J6u5qalwTooiRw2x63HlXO/KFJcayGjv8
         Mof9Xk+4OfmbJHBHaWfdgewiZIrqMF7smcK/UVTjnWJP+Rmq9peVVyVjPw/ZDuWlbusn
         9FwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdwuz566LOVcZCy6A39FYHCGbRDyy1kI+5L3V1j+E6ggttSBUeoY4hfqfk+OUrU/rAOgAiRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YytTg7mDdrKRklugLTNNpY2t5UrnEOHxgRDjMLJGIVepwD1PdBQ
	gMStVH2XswljyypPONKH2pjBqKVCc9jk9ZiQuAntwEG1fIhAtKlKx4nNkHUd7CZy7A==
X-Gm-Gg: ATEYQzzLsWRbqUqYdY0tnKvuEWjwqgQKe5073nzuIM95KMKUCTLG1xNlnoFvOcEYj9i
	nqbGeiEAgXMjBr+v8Enj1wDzkrz9Sc2TljWKzhZYLE2aeyaASeGqopSJPi+qg+rMlum6ZUm7zDH
	ur0M0P9JVSS4yxCG7umb/+dTVf3B1Q3Ryby2f2aB+Gy+2V+08rxA78PmWGJhO8Mrf24bj/FLUYV
	QoVqdYoMe91ZpLNSHXC+vkTN99ozGDT5CDg4MqH39+Y9YOzJkIjJt5EH+YeR8E3c/ps0p86329A
	ogESf42YV3pnLNI4G2CZWxYpf5wy0PtxEzKKclbAPbcQj62FhCkymgDYQM7F8Wbz2K9uVEyeJ46
	/M5nHzoTN131aIPHKIPi89q6t6iESbCDImFN88m2zFHxFYvkinh/MHFGLeslxwrxLNWwqn9FREU
	kGga/ZMCzsEdCfsBjNqBWWvVmcq7ZkgwcJYa4jX3MDuzylijLD7+BZmbIm5A==
X-Received: by 2002:a17:902:e80f:b0:2ae:4453:3674 with SMTP id d9443c01a7336-2b0a53e76f6mr951935ad.4.1774299557926;
        Mon, 23 Mar 2026 13:59:17 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c015cd6b8sm101179a91.0.2026.03.23.13.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:59:17 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:59:13 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 12/14] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <20260323203818.GA2571566.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-13-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-13-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:46PM +0000, Samiullah Khawaja wrote:
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int iommufd_device_preserve(struct liveupdate_session *s,
> +			    struct iommufd_device *idev,
> +			    u64 *tokenp)
> +{
> +	struct iommufd_group *igroup = idev->igroup;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_attach *attach;
> +	int ret;
> +
> +	mutex_lock(&igroup->lock);
> +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> +	if (!attach) {
> +		ret = -ENOENT;
> +		goto out;
> +	}

Should VFIO in its can_preserve() add this check?

> +void iommufd_device_unpreserve(struct liveupdate_session *s,
> +			       struct iommufd_device *idev,
> +			       u64 token)

Where is token used in this function?

