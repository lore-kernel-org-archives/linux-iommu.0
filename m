Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16738836A;
	Thu, 13 Aug 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642466; cv=none; b=FUoaBLicry0gFaso74kDgSGfGOc5/5NjDcQ/44jfMOoG7Td/zdlORLehfCMSngJEGBtBJpOw9fXFZwktxVWyMySyasq8CkLw1z2K/feOXBX09OI/MH7rtWa0WCNV0g++PbY1pI65uTGpl5cJQxoYsnMgVKrBQqZjIEiVtnSfYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642466; c=relaxed/simple;
	bh=oxphTxwPEqFTAObRGBQorHiq4mlcmdg+TJtOb1EUUfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agm49WPtAEKoYHGZu7RjUlKmBx5qZ5G5xhO+YwqSkaQaQ6LwEXKa1cDKfOl4DxIf4jf/1bdlt2kgW6xVEPCPCzXn/fd6DNxOZJDd46dr9k5F0q2mANBYja0XKCWip9yO+hshSNcTTXKGEgb1F7bmVJQNJUTvrX8lsdIHSwrIN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9MJOeCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9MJOeCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CC31F00A3A;
	Thu, 13 Aug 2026 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786642465;
	bh=d9/MjXSR6H4kUMgKLQ420rzJEEx4EYhO23B15g1ByFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c9MJOeCdmP8nd/hQntQKWiS5Rf1oiv+z9t8+HpBf8+k+4p3YAWy9JOpeHj8WxIAUK
	 hmOtKn7g3SIegv9clnN/P1fCzzHBnSSQW9l0d+QzySPIeVf8S2cLvuXhAy8OUekhmi
	 3IySaD44+xKIDsYeo2u3ukhtqSy5pEbJvpel17Rf7ynezm609FGwCVhcRu0Gj56w/a
	 UQSSkWbhdRr2zLBA25qc/5lQdjzQsGnVShMV3bfHEsRbRX46k63It9HPituT5vEdLT
	 +CDHkDyzQj71QGndWnds5IA0fgxmGpF5kh2wmc876ufEzW70dqC1Xlr2hJOiEGhKHW
	 j6qwYR7Y/Y4Qw==
Date: Thu, 13 Aug 2026 10:34:23 -0700
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev,
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
	james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net,
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com,
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 4/7] iommu/riscv: Program QoS IDs for assigned groups
Message-ID: <an4AH5p2NW+tFlyR@x1>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-5-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130657.46963-5-zhangzhanpeng.jasper@bytedance.com>

On Tue, Jul 14, 2026 at 09:06:54PM +0800, Zhanpeng Zhang wrote:
> Program RCID and MCID for RISC-V IOMMU groups through the device context
> TA fields. The resctrl group assignment is per device group, so reject
> BARE mode where only the per-IOMMU iommu_qosid global default is
> available.
> 
> Validate every group member, firmware ID, device context, field value,
> and QoS ID capability before changing hardware. Then update all members
> through the checked IOMMU group helper so a validation failure leaves the
> group unchanged.
> 
> Serialize DC.ta changes with context setup under qosid_lock. Change only
> the RCID and MCID fields with ordinary accesses so fixed DDT mappings are
> not subject to atomic LR/SC operations, invalidate active device contexts
> after an update, and clear the IDs when a device is released.
> 
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>  arch/riscv/include/asm/qos.h     |  16 +++
>  drivers/iommu/riscv/iommu-bits.h |  15 +++
>  drivers/iommu/riscv/iommu.c      | 200 ++++++++++++++++++++++++++++++-
>  drivers/iommu/riscv/iommu.h      |   3 +
>  4 files changed, 232 insertions(+), 2 deletions(-)
[..]
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
> index f2ef9bd3cde9..782de5c92727 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -63,6 +63,7 @@
>  #define RISCV_IOMMU_CAPABILITIES_PD8		BIT_ULL(38)
>  #define RISCV_IOMMU_CAPABILITIES_PD17		BIT_ULL(39)
>  #define RISCV_IOMMU_CAPABILITIES_PD20		BIT_ULL(40)
> +#define RISCV_IOMMU_CAPABILITIES_QOSID		BIT_ULL(41)
>  #define RISCV_IOMMU_CAPABILITIES_NL		BIT_ULL(42)
>  #define RISCV_IOMMU_CAPABILITIES_S		BIT_ULL(43)
>  
> @@ -274,6 +275,14 @@ enum riscv_iommu_hpmevent_id {
>  #define RISCV_IOMMU_TR_RESPONSE_SZ	BIT_ULL(9)
>  #define RISCV_IOMMU_TR_RESPONSE_PPN	RISCV_IOMMU_PPN_FIELD
>  
> +/* 6.27 IOMMU QoS IDs for IOMMU-initiated requests (32bits) */
> +#define RISCV_IOMMU_REG_IOMMU_QOSID	0x0270
> +#define RISCV_IOMMU_IOMMU_QOSID_RCID	GENMASK(11, 0)
> +#define RISCV_IOMMU_IOMMU_QOSID_MCID	GENMASK(27, 16)
> +
> +#define RISCV_IOMMU_IOMMU_QOSID_RCID_SHIFT	0
> +#define RISCV_IOMMU_IOMMU_QOSID_MCID_SHIFT	16

Sorry for not making all my comments in one pass but I think these two
shifts are left over from before you were using GENMASK?

Drew
