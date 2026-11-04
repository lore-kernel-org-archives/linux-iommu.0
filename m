Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781924;
	b=d8KYqnXd6eacYX8cXvthzuid+M17OUqNsp6Er/SP6mDW0YjkEVylGf77bx25Yk4Im73S
	 n7bAIhE2RYKdwuRH9Z/krAerWRMjyDGwTLXt4eTVA2pbBpZiTXBQu/B/ejD0e7YZgQtsI
	 hw95Q95UwauIzs6Qw5VVX+VcAoUuceQiPCUK8RGLrM5Z4QsREPS59wWgf632DPs5tKEpO
	 Ll3LaIuCMme5t1LdodWeDi7qV8UB14EtR35Op4glIoeM4YIY5/7/OFIjOTbo3fSonTLIm
	 FzHf2qlFKadh/YuFShLDdGraJaoojeohCWj1xSEEWqOdls/tnl7pcWyT5jZvQwnF6GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781924;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=D5swImB+Qk7T+rwUH4JizFOOYT+1YDU9kW4rI7mC2mw=;
	b=v4MiuLYEkjKqM7JhfyoAZOMRRhUrAM0l8YLs5lNzqMAbvepLrT0Z9CWGiji5O1JiaX2F
	 MxLIZC3iCymGWBJwUT91nCgc+VMW16228jIW2wI6oYj48Oj+1cUQHz16kWQCB7sFjsAkY
	 2WzCw9PL+bq1H/diAfu0qCxfAHqlN7Fv3aLn1Jhp1zR8xHsNTw7MGYiTSvzVD9/WWxnPf
	 o4Jm5PYFq/hApi2Em46IIiGPPH/xopFQlDUfFjHlaiV4nIeJmZ1B7GdR+bFQlxc/DvCUO
	 ZWGzznxd2M4MZL/TmUi1mrw61IdJ95XsDm+C2sJlwaMuAEcwvvvwSEsdcni6yq9A00Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCEE606A329
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 08:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCEE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jKJt809b0z8Xrrr;
	Wed, 04 Nov 2026 16:45:20 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 6A48j9Vc096993;
	Wed, 4 Nov 2026 16:45:09 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Wed, 4 Nov 2026 16:45:11 +0800
X-Zmail-TransId: 3e816aeaf08f029-ccf59
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, andrew.jones@linux.dev, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev, baolu.lu@linux.intel.com,
        gong.shuai@sanechips.com.cn, guoren@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, jgg@ziepe.ca, joerg.roedel@amd.com, joro@8bytes.org,
        jroedel@suse.de, kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        nutty.liu@hotmail.com, palmer@dabbelt.com, pjw@kernel.org,
        robin.murphy@arm.com, skhawaja@google.com, tanchi25@mails.ucas.ac.cn,
        tomasz.jeznach@linux.dev, vasant.hegde@amd.com, will@kernel.org,
        zong.li@sifive.com
Subject: Re: [PATCH v7 09/10] iommu/riscv: Add dirty tracking support for second-stage domains
Date: Wed,  4 Nov 2026 16:45:03 +0800
Message-ID: <20261104084503.118083-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103120236.53474-10-fangyu.yu@linux.alibaba.com>
References: <20261103120236.53474-10-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 6A48j9Vc096993
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 16:45:20 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEAF0A0.000/4jKJt809b0z8Xrrr

Hi Fangyu,

> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Add hardware dirty tracking support for second-stage (iohgatp) domains
> used in KVM VFIO device pass-through.
> 
> The RISC-V IOMMU can automatically set the dirty bit in PTEs on write
> access when DC.tc.GADE is set and the hardware has AMO_HWAD capability.
> Wire this up to the iommufd dirty tracking interface:
> 
>   - riscv_iommu_set_dirty_tracking(): Return success without toggling GADE.
> 
>   - riscv_iommu_dirty_ops: Exposes set_dirty_tracking and the generic
>     page-table read_and_clear_dirty via IOMMU_PT_DIRTY_OPS(riscv_64).
> 
>   - domain_alloc_paging_flags: Assigns dirty_ops to second-stage domains
>     when IOMMU_HWPT_ALLOC_DIRTY_TRACKING is requested.
> 
>   - riscv_iommu_capable: Reports IOMMU_CAP_DIRTY_TRACKING when
>     AMO_HWAD is present.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> ---
>  drivers/iommu/riscv/iommu.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index b3f05dfdf278..ff1043afe973 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1350,6 +1350,10 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  	if (domain->gscid) {
>  		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
>  			return -EINVAL;
> +		/* Dirty tracking requires AMO_HWAD on every attached IOMMU */
> +		if (iommu_domain->dirty_ops &&
> +		    !(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD))
> +			return -EINVAL;
>  
>  		dc.iohgatp =
>  			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
> @@ -1377,6 +1381,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  	return 0;
>  }
>  
> +static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
> +					  bool enable)
> +{
> +	/*
> +	 * Always enabled and the dirty bitmap is cleared prior to
> +	 * set_dirty_tracking().
> +	 */
> +	return 0;
> +}
> +
> +static const struct iommu_dirty_ops riscv_iommu_dirty_ops = {
> +	IOMMU_PT_DIRTY_OPS(riscv_64),
> +	.set_dirty_tracking = riscv_iommu_set_dirty_tracking,
> +};
> +
>  static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
>  	IOMMU_PT_DOMAIN_OPS(riscv_64),
>  	.attach_dev = riscv_iommu_attach_paging_domain,
> @@ -1418,7 +1437,8 @@ static int riscv_iommu_init_domain_s1(struct device *dev,
>   */
>  static int riscv_iommu_init_domain_s2(struct device *dev,
>  				      struct riscv_iommu_domain *domain,
> -				      struct pt_iommu_riscv_64_cfg *cfg)
> +				      struct pt_iommu_riscv_64_cfg *cfg,
> +				      u32 flags)
>  {
>  	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>  
> @@ -1439,6 +1459,10 @@ static int riscv_iommu_init_domain_s2(struct device *dev,
>  	if (domain->gscid < 0)
>  		return -ENOMEM;
>  
> +	/* AMO_HWAD is checked by iommufd via IOMMU_CAP_DIRTY_TRACKING */
> +	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
> +		domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
> +
>  	return 0;
>  }
>  
> @@ -1481,7 +1505,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  	case IOMMU_HWPT_ALLOC_NEST_PARENT:
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
> -		ret = riscv_iommu_init_domain_s2(dev, domain, &cfg);
> +		ret = riscv_iommu_init_domain_s2(dev, domain, &cfg, flags);
>  		break;
>  	default:
>  		ret = -EOPNOTSUPP;
> @@ -1559,9 +1583,13 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
>  
>  static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
>  {
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return dev_is_dma_coherent(dev);
> +	case IOMMU_CAP_DIRTY_TRACKING:
> +		return !!(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD);

I'm not quite sure about this. Could there be a device that supports
AMO_HWAD but not any of the S2 modes? GET_HW_INFO would report
DIRTY_TRACKING as supported, but HWPT_ALLOC would then fail in
riscv_iommu_init_domain_s2(). Should this check also include the
S2 modes, like

    AMO_HWAD && (SV39X4|SV48X4|SV57X4) ?

BTW, in riscv_iommu_init_domain_s1/s2, why not return -EOPNOTSUPP
instead of -ENODEV for "cannot find supported page table mode"?

Thanks,
Shuai

>  	default:
>  		return false;
>  	}
> -- 
> 2.50.1
> 
