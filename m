Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F253C6A4A
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420442; cv=none; b=COzKjPIIlxXyNCTo2pOKqnUI/r9GOWyFC+t6wli7gUxYGuKDCyZR2t90UZq/o4dHnv4fFNnsulYKA1tL10vVZbN7pc2Rks8WpF+bgdpRBcs88TkKuOkmi4indRasRZNAcTB0+FWDdawTNmQYucQNVE1eC66i8WzzZI7Aqau4BDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420442; c=relaxed/simple;
	bh=PK0TC6Ws+9gPY3Yw3OnZpR+CsABURlUBk9BkuAZYcsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Uh5uy/nDFsYZlfRnwamupPBtUQ+nXHmrk3yUq/YfRLQraDngYmeyoqFHtQN1AgBo6gBg4pPdA1Aqs+dTl3RN7+igtofCq/U2um16gKce8P2Kk8EV2elUfxUEXc2EPDFQq7vRSw2I4iXN7AAcXGAGz/VsNwtvgjreP9YS+pPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I1wM8wxS; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I1wM8wxS"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6f21c2d81so230477185a.2
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773420439; x=1774025239; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=avZ4grXviKCmzlaXI2c5ulxCKd8sv6dyVglvXzo2HNM=;
        b=I1wM8wxSSuYw5CRAt6FV+WVVwn7YjMKE83e+2aytts1iKRTIJzqSJw3FxvBBCkUdHf
         3JPKrArFGFEeHqsCechcGMP3dVKaxZL1JJoTK7k2q6thGEXQtM74IK9eRi003C5AU0uk
         xLYnkykelzloOugWoEcjhwCEBnhgoZuBozWyULi+BugU8hOI+YjW9RIw5XLs08K35SWD
         pgJfs2swgczRpAuVQvtcab8kbRCxfu9DjY9mDUvdw4KIzn1XQSvkHBeGfoTfBrWtMKsU
         Yvye53Z5kI/lHQsdH7WJNav/kQOVhrzzDRk7wl5xasVpkwjn7WSTVQuQ3imXKFjh0neS
         mwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773420439; x=1774025239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avZ4grXviKCmzlaXI2c5ulxCKd8sv6dyVglvXzo2HNM=;
        b=Wc+769ysQchbIgLT0RHDCyiA18O8b6bzZf2aHJIuiWDhiUtXu4Lj3YqF/Wty0HMm07
         sQ83+CvOfRf52VrU+IbO0f5Z2AXg9mx8/0BsL4wXOGmSV3bzUy1MzC9J4fuWA0F6odIL
         j1HXBwvFs4ZPNTx1f6nrzrBWEhl/9//M0Pcon9PoB4XL0DJziQzNLGje1rV/i978H86h
         nJwUxx5EFzxk1R/2BhJV9n74DKz2n0Y8kdxnX77QDtxx3gpCugNH/evg6ttRx/nvgixU
         JICJtRBAkE4vDdBNoizAoAZEktlL/HFIXnSEsZM+9xoGhoDoJzlqhIOfXI+9oLhO4ykb
         4T4A==
X-Gm-Message-State: AOJu0YysOP5t+gECnyeNsvElvhn4SZeoyyuQRfc+O7HoVAurq1GhbRNF
	wSldbN8Us7KMcOj/LC5utrGBDxfARRbNJbOgrrJzMVjqmuZI+Fx7pHpey9nViRfKTmc=
X-Gm-Gg: ATEYQzyi6r2jQKPRvN+7g8BWCtndwJbchaKxRnGiqwdZnIZ2d4sU2INFglfCIcwyxD4
	3olaoZUEfxZ17xqzBqcZDhd2hp9cZn3zSk4hORICXUFdP7Hp0kMyIz/dp6hdfYFupocaaDy1Odw
	iRQhRHAebjqJUxECi8rFxNMFZbp9OxXfpGhXu84W++H6tnUXI4b6nFGoyl+i3nhKXH/U1pbZxS2
	dKDvkjptli93h1PMfN0rwRCjoZgp0hyuqbLGwj2g1Lhj0nmXy6odU9EkPbcHVG613GMVJUABRhv
	qsaYB+xZbwLG77ksEtkdLarrp3OB9gT4iIwPTSykrBjZTlkVf+Nw7rWg0Crs2Z6K4t8rWHGr77p
	5Ne7nJarIfIGfkKI09n0HTsFNtzEN0qSUhb4ER5T3fkjyQ0zN77JXMvgan401UD0qv6osCVPdnm
	hifx1Ma8Ahm5lMPBVWNUmW+mDGvBzqT70Ee6COq4Xh4pzCmuFJWpbgthZQKjOCXPZny5kX7bpfA
	23Acj/R3M6zSI/2FB8=
X-Received: by 2002:a05:620a:28c7:b0:8cd:9365:f277 with SMTP id af79cd13be357-8cdb5b7b470mr540160785a.62.1773420439206;
        Fri, 13 Mar 2026 09:47:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc2725sm612437385a.8.2026.03.13.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:47:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w15fR-00000007JWe-3ytz;
	Fri, 13 Mar 2026 13:47:17 -0300
Date: Fri, 13 Mar 2026 13:47:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, nicolinc@nvidia.com, nathanc@nvidia.com,
	mochs@nvidia.com, kjaju@nvidia.com
Subject: Re: [PATCH 1/2] iommu: Add device ATS not supported capability
Message-ID: <20260313164717.GE1704121@ziepe.ca>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-2-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303150348.233997-2-skolothumtho@nvidia.com>

On Tue, Mar 03, 2026 at 03:03:47PM +0000, Shameer Kolothum wrote:
> PCIe ATS may be disabled by platform firmware, root complex limitations,
> or kernel policy even when a device advertises the ATS capability in its
> PCI configuration space.
> 
> Add a new IOMMU_CAP_PCI_ATS_NOT_SUPPORTED capability to allow IOMMU
> drivers to report the effective ATS decision for a device.
> 
> When this capability is returned true for a device, ATS is not
> supported and not used for that device, regardless of the presence
> of the PCI ATS capability.
> 
> A subsequent patch will extend iommufd to expose the effective ATS
> status to userspace.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  include/linux/iommu.h                       | 2 ++
>  drivers/iommu/amd/iommu.c                   | 6 ++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
>  drivers/iommu/intel/iommu.c                 | 2 ++
>  4 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54b8b48c762e..f40ecdc5d761 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -271,6 +271,8 @@ enum iommu_cap {
>  	 */
>  	IOMMU_CAP_DEFERRED_FLUSH,
>  	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty tracking */
> +	/* ATS is not supported and not used on this device */
> +	IOMMU_CAP_PCI_ATS_NOT_SUPPORTED,

I think this one we should invert so it has saner semantics in-kernel
and for the drivers.

IOMMU_CAP_PCI_ATS_SUPPORTED

And then if not implemented it follows the usual cap protocol meaning
the iommu driver does nto support ATS.

It can be inverted by iommufd for the uapi.

Looks OK otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
