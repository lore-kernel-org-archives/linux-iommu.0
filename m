Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6137E2E4
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300657; cv=none; b=JTXu+M9l9tg4zOvEFTU/rOD7We6RGqmOWGHZjDR9DqpRSOnMJrlUycX3nJgJxDC6VuVtZIsfb/Dw3g25/iyVPmoVsGIoKDhVSIkly9FUoYdEzH7HOTUtetpy37Wha0NzVWrSatJ0ROy3uSRWqe956cU1iLUbqWzWfpmVhTG4IHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300657; c=relaxed/simple;
	bh=Nm+VZTxnT9qw3EFPipXSMTWJ48lruE6BGIiYuVcKFcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVzgxTK+vnwixY4qZfr8+QJkgq1KZQN/M2PStmaq0mlX++qq7mRwkI+YbObRDpC8ASoqS/+OT1iae85pRrxa0UtDy2b9GCOfeSVLZ4h+KT82E70jAgnW6quR5jsnF8azSmlTMm5vc4r0IuX9wqgNZm1u3jw7RCXv8NWoQNOZpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+6eQbeJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+6eQbeJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b052ec7176so10145ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774300654; x=1774905454; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=layxP6Fhjqp+wTdLPHecG2YnZ/zXdi50jvGwdG06cGQ=;
        b=t+6eQbeJtig1aSSyuWPqndlE8BlD/Qx80LcPPPTJzdHbHFg+oU2PHYD+1td88LPn8N
         HoJ7o2ElLIEblzy3YEzRvMmEaY6tFyLqvk2Aw6kvIZfK7PSXHjcK7KcvSTHqPoA89kTz
         qVYSW0tbKcDu/zd9+nW6yIGHKW0zspunQ0uXtwR1m4YwgYEe1MPEQ3WWS9um5qBvaYu6
         8mQuV2eeQ1fX/rAfszzVAdnWCWKPhTaUTjXKnA5l1AzaqfBXSg74i6TWst0a8wXoZva4
         EviWP17IUxKjV9N8YopqBLaL7DeFwb3GLQqw0xvSDswlSNmS+BJ/91WSE1dZWY7c43GL
         hTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774300654; x=1774905454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=layxP6Fhjqp+wTdLPHecG2YnZ/zXdi50jvGwdG06cGQ=;
        b=QReeb1pcEmmEPhr6qCq5VoNaOKl7h+IJRi35QNjJiHWez0IXhVSiHJCohHUUOw617A
         aglcDkXztL7b6Q+ZjgRn9YCvhsTv5y6GECG4Wf9oD4Uo8tVFfUhhrGCh91kuRVcG5g1v
         +QqVjKevtDEs1HlCK1RjoMdyIN6AFdEgRYryFg4x3irkMCsqlhsQYj6B0X+O2xoouXqb
         wUSQJ5Z7Fqhi0ME2bsJD0NXHE367cphU0qv97GVEOSkCqG4yUcD4Zxvo5p2dQeZZ1V6/
         uSZuLjRv2tJYfeSrdTuEV8LB7CdQBNhaaN6MXmlAalErvZh7h2KTivn0SICqm+8swUzO
         Uycw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6ihQ+49Vc0kX7zXRkA0xX2m+uhAY/rYMjRGTyysDtbr8DQFM/AIdIy0uAcySsslQWFzVQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YysjdPEPRYLJWSicRtoA+wuRbS1R/NTy0C7j5+KHyyBwy0vX4/1
	XglnJTyAOm5Ge6AH1hL2ivX6PGEKzxy6/qKHNXG3r5WOdFKr48AaqEyrSrnuGSPy2Q==
X-Gm-Gg: ATEYQzx/y6JDcRsAWNSCXRWSIZhhkWpgiNu4mFoV8gGL2AXr/RcK4olCGWBIVzQp5HJ
	dyZyvzERxvyeiO2iDmu82lR07sLpkY4JxuX8SP6RPHGxtBqcQzlq2MUAdySa18JJkQ2t6n23xHd
	fqTiCxD8cOU71eTKHE+obq6EenTJ5nLBYTLecT6Pe6xYWa7leer8smJTBYPuWH+r50ppG++/tNt
	70PxU8nPfpaqg7dL65pz3AV56/e9JNDgtbGk3ZzEIogcS1egIVVmTgIH4W6wjCAB5yPRghRtEC/
	Cy8N5a+o0mcPK+dE11Dt5OF5yFUP37fzc+Kkq7cHnfL+l6/wKrFrAnfUJdXdSPaEh7WBr/1uF8t
	6Ftx0JZPUzxSRAkOc8Lwx2MYiSqdSpUQnry050+UZTap+I+NeL5W8tWO6Tetg3QJ80KZLGMIu+Z
	4+2Hy7GVrIcc8tCSoH5CI1mdZ4NA1FJ3f7RRTSWsEzWrqHrC9/hGPl8YGxOg==
X-Received: by 2002:a17:902:c943:b0:2a9:5bfa:54ef with SMTP id d9443c01a7336-2b0a540776emr966405ad.10.1774300654128;
        Mon, 23 Mar 2026 14:17:34 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76565c35desm1829840a12.15.2026.03.23.14.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:17:33 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:17:29 -0700
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
Subject: Re: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio
 cdev
Message-ID: <20260323210111.GB2571566.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-14-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-14-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:47PM +0000, Samiullah Khawaja wrote:
> If the vfio cdev is attached to an iommufd, preserve the state of the
> attached iommufd also. Basically preserve the iommu state of the device
> and also the attached domain. The token returned by the preservation API
> will be used to restore/rebind to the iommufd state after liveupdate.

Lets add token when it is used in restore/rebind patches in future.

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	if (vfio_pci_is_intel_display(pdev))
>  		return -EINVAL;
>  
> +#if CONFIG_IOMMU_LIVEUPDATE
> +	/* If iommufd is attached, preserve the underlying domain */
> +	if (device->iommufd_attached) {
> +		int err = iommufd_device_preserve(args->session,
> +						  device->iommufd_device,
> +						  &token);
> +		if (err < 0)
> +			return err;
> +	}
> +#endif
> +
>  	ser = kho_alloc_preserve(sizeof(*ser));
> -	if (IS_ERR(ser))
> +	if (IS_ERR(ser)) {
> +		if (device->iommufd_attached)
> +			iommufd_device_unpreserve(args->session,
> +						  device->iommufd_device, token);
> +
>  		return PTR_ERR(ser);
> +	}

driver/vfio/pci/iommufd.c has all of the code which interacts with
iommufd in VFIO, I think we should follow the convention and add a
function there which can be called from here.

> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
> +/**
> + * struct vfio_iommufd_ser - Serialized state of the attached iommufd.
> + *
> + * @token: The token of the bound iommufd state.
> + */
> +struct vfio_iommufd_ser {
> +	u32 token;

This is u32, whereas the token above is u64.


