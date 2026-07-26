Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D83C8C55
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082990; cv=none; b=nEVaIMtx4GOX7/RxnqcIq8pXxiKMOdYChEhHly8yQbdCbtkmKjUE+aaiSoE+oSHpgvJ9M4bqFMPV4TWpn/wM3HD6tUuHo3WQsRvV0fWSxwrF3FAZf+DK9rrnmQ0nxGifeQsBZ8FD5eY0PJ72/qvNwmbXvIAobcdtqH5Yb8GFDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082990; c=relaxed/simple;
	bh=dqXFXbXUVXKpMi3EZoVlEyKmreyknyy7Kt+mgq6gTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma4vDTiayMQfqx7aL59i8VpkhgMKdpF/ipP9fpa5jXivFUTg90l2FSDKIQvfWxXN4dgvnN/Aozecsd4+CD4ZnSVVSes61kGxQ70ZPQv/PemcVQWzk1AQvDcA5P+5cv5VTDUn/MozSRz9jt7aVejKKbNgmZwUK7/DnT3FO60iFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZVPp/DCW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZVPp/DCW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso22133765ad.1
        for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785082988; x=1785687788; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuXTk3sNqgjvfJDVodnQ6dQBc+GEb7krH4jOLDWR1sw=;
        b=ZVPp/DCWamKbCTiFLf7yoxD19HCwUibpS6SdwZ11MQbSjcKSLoRUYHk+qKToBV4lqy
         hY7R4FxoMGaDnGBJwMgnPUICcKuoFGVM3HO4iTXytjUw3icFAmn6QwZiCRXxRpjTug9p
         w8JrgFO7D8Li1j5G0t9gnudtfHm5khAxTKJNJG4VPrIGiYemPzFutIwuE5gyvqTkhQ52
         3lh3o4yeWf+2sqdWdQFN11TxRpPC4LBDizNN6+OZnh1oy+3r6Mt5643vl8h6443s0IqD
         CmVTZQT4tO+Y0A4oJAn1oLdOUj8bk9KqhIfNx+dcyuYrCCOirttHIkHjNbec0k8MuLR+
         PtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785082988; x=1785687788;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuXTk3sNqgjvfJDVodnQ6dQBc+GEb7krH4jOLDWR1sw=;
        b=Jk+kPIz1AydmS4wlMfbUCjr9C9B7uOnPVi//RYG2Ufnb4eOfaNV4DoPBTcEgsNAgQh
         Wg7mmXl1HGJh+bOESnoy205kWWvlGbdRl3FNkf/TCSr4DWNDLrUyjn0H3RQWHvi4JjSE
         TKpT7oGH11WawKCLjAzn0biS3eImZpNTXGChaLbUgJG8r/VErs/eM4T/Adnp2c1D/RiE
         DOhltt3N4Qd3PRux2qIAyIiHfJGXyhqsYeMfNMAwBmLTMbH1PlPlFF3u1BWNy1ABAPp9
         V0fk+8+TVnoCDjycd0sKiD4avZ8/liqmB8RY7s/NyLu3RQ8wF1m9sR0EyxP0NrnqF/su
         qyiw==
X-Forwarded-Encrypted: i=1; AHgh+RqOe+3YZ5VgzOkouiz3gOlKjrO4y0FIGEq79UETA4soLhe+UgZyYVj5GZL8Q08zPoer60cEpA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz85Uu97UQkdhelRiyiOC7TkvSvw+s1d1KUvIPVDZDNG6GAnIrD
	+oaQEkCmDyen+XspgtQYThA3qseF8jqzs0mh8Gv3MPGpqS9m1BCx1NnIz8KoxUykP0w=
X-Gm-Gg: AR+sD11zuDuQEqvb6j7mg0k9Jw8mFPAtYfh7Qib+1IHOHmeC4Dc5gE8piziZT86vFSR
	36XkKas5zLEAHtegM1UkdT8m95NXYswhgctiXpnIXAapKEQR3OmFmmJs1jUGW4S/SujbREt2XHp
	3K0TDyHeGSLYrf3oDXoptfK/upDdWku7VdR6+0jRdxnmSNkTo0tzD/YArlBnnJOAqJvNcwg8+6T
	HaK3nN95ljCjqAUlaFiKygW4jqQN0jim69K7XKnCB9KKXawrhOgNXkG/zK/CEsH8UlmkWHjAUhr
	sPaATzElQwjm8T2r1+ULWJ0BmP/k8vbcB2cxMq2/BAYj38ojAbS6bPkWPhpkQ1e8MCyDkJ+6SZ1
	47BmxM3ppyzhY45pmMJgdc0hQIeWd8UivniyMYplBSYG8BpZbYxM=
X-Received: by 2002:a17:903:4687:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2cfde79058fmr52053305ad.1.1785082988138;
        Sun, 26 Jul 2026 09:23:08 -0700 (PDT)
Received: from ziepe.ca ([64.114.68.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde80f50asm21426485ad.77.2026.07.26.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 09:23:07 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wo1d5-0001Tl-8m;
	Sun, 26 Jul 2026 13:23:07 -0300
Date: Sun, 26 Jul 2026 13:23:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 3/4] iommu/arm-smmu-v3-iommufd: Report
 CFGI/TLBI-repeat erratum
Message-ID: <amY0azMCny2sHfX2@ziepe.ca>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
 <20260726081904.1408859-4-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726081904.1408859-4-amhetre@nvidia.com>

On Sun, Jul 26, 2026 at 08:19:03AM +0000, Ashish Mhetre wrote:
> A guest with access to VCMDQ generates its own invalidation commands
> and must apply any invalidation errata before submitting them. If the
> host also repeats those commands, each affected invalidation is issued
> four times instead of twice.
> 
> Add IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI to report the
> CFGI/TLBI-repeat erratum to user space. This allows the VMM to expose
> the erratum to the guest or apply the workaround itself.
> 
> Use the raw __arm_smmu_cmdq_issue_cmdlist() helper for user-provided
> invalidations so the host does not apply the workaround a second time.
> Add arm_smmu_erratum_repeat_tlbi_cfgi() to query the static key when
> populating the SMMUv3 hardware information.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c |  7 +++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         |  7 ++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         |  1 +
>  include/uapi/linux/iommufd.h                        | 13 ++++++++++++-
>  4 files changed, 24 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
