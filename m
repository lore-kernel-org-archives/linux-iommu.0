Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784096;
	b=slcYSoVQ4oGHU0+k/mCLUnkCJmJMeTniOj6qnYBjndDMxJ2FvHiixdtZM+EWP3Vr6IUQ
	 de8efX+qtDv5lt74Vd7dXeuvkClNNvpPN6pHN/zKuxsk7ofSFG2tpcmNfyKHLLf4216qP
	 FAYeb9KwP8YwRNCVotPLqj3gPUEJCcqeBnKBN+hJ1PeNXvwpXpzKvZQ7UtxU9RZHtPORw
	 +X5nbxggkmX8ydMwII4k1W3SarqXjbbWuLiAoSquc3hgSgXW3NVfS7U2NaQXPFkoe5WYF
	 ZGM09AG/WjDe34npzsFg8gGqvR31gQLJVTOrvRKllNFC0SXO5n/BjcIH6US6xt6U76g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784096;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=l02k7HuERHdY3gvfUjsKRGhZjDezJ9lvCttCbYwWDlw=;
	b=B3qGuSFKaPKfHEjUrfKME6/+v0+nuTghS6bgzBBKgKfNFxvEGATmbXVDfy4WXikWT5Jb
	 UizUcrZWg5CqZJjYF0OZgZ8mqGh42SaQ8pYjNnpCIeuMcKT5q3/4EWTE2VLtR0fWCROl9
	 +EewRlppGKoOgBPoiLcTe/WkuxKZNaLVUUHzGTzfFoZBqdkKcu0cXfH7c0/fEQIqLmTk/
	 SjCTXOdAxpo/sJYf1Wfx2Mxah8V1R98kk4aagq9JFBNzIlYtSYxK2dh3zWXPG897GS3Sr
	 983RTVJqB5a/xeEXcDdLrKEVw+4FiwdyOovgRerskSv4Dt6QGNurmli+IQGqtiTrdbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55A606A33A
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 09:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD55A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jKKgl3G1qz58fdJ;
	Wed, 04 Nov 2026 17:21:23 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 6A49LF4E026376;
	Wed, 4 Nov 2026 17:21:15 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Wed, 4 Nov 2026 17:21:17 +0800
X-Zmail-TransId: 3e816aeaf906029-d1e8b
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
Subject: Re: [PATCH v7 05/10] iommu/riscv: support GSCID and GVMA invalidation command
Date: Wed,  4 Nov 2026 17:21:11 +0800
Message-ID: <20261104092111.119394-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103120236.53474-6-fangyu.yu@linux.alibaba.com>
References: <20261103120236.53474-6-fangyu.yu@linux.alibaba.com>
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
X-MAIL:mse-fl2.zte.com.cn 6A49LF4E026376
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 17:21:23 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEAF913.001/4jKKgl3G1qz58fdJ

Hi Fangyu,

> From: Zong Li <zong.li@sifive.com>
> 
> This patch adds a ID Allocator for GSCID and a wrap for setting up
> GSCID in IOTLB invalidation command.
> 
> Set up iohgatp to enable second stage table and flush stage-2 table if
> the GSCID is set.
> 
> The GSCID of domain should be freed when release domain. GSCID will be
> allocated for parent domain in nested IOMMU process.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> ---
>  drivers/iommu/riscv/iommu-bits.h |  7 ++++
>  drivers/iommu/riscv/iommu.c      | 62 ++++++++++++++++++++++++++------
>  2 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
> index f2ef9bd3cde9..65d1f2250011 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -720,6 +720,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
>  	cmd->dword1 = 0;
>  }
>  
> +static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
> +{
> +	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
> +		      FIELD_PREP(RISCV_IOMMU_CMD0_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
> +	cmd->dword1 = 0;
> +}
> +
>  static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
>  						  u64 addr)
>  {
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 918fce4aa8c4..5546dfcd976c 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -49,6 +49,10 @@
>  static DEFINE_IDA(riscv_iommu_pscids);
>  #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
>  
> +/* IOMMU GSCID allocation namespace. */
> +static DEFINE_IDA(riscv_iommu_gscids);
> +#define RISCV_IOMMU_MAX_GSCID		(BIT(16) - 1)
> +
>  /* Device resource-managed allocations */
>  struct riscv_iommu_devres {
>  	void *addr;
> @@ -842,6 +846,7 @@ struct riscv_iommu_domain {
>  	struct list_head bonds;
>  	spinlock_t lock;		/* protect bonds list updates. */
>  	int pscid;
> +	int gscid;
>  };
>  PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
>  
> @@ -1004,7 +1009,7 @@ static void riscv_iommu_tlbi_calc(struct riscv_iommu_tlbi *tlbi,
>  }
>  
>  static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
> -					  int pscid,
> +					  int pscid, int gscid,
>  					  struct riscv_iommu_tlbi *tlbi)
>  {
>  	bool use_nl = tlbi->non_leaf &&
> @@ -1012,8 +1017,13 @@ static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
>  	struct riscv_iommu_command cmd;
>  	unsigned int i;
>  
> -	riscv_iommu_cmd_inval_vma(&cmd);
> -	riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
> +	if (gscid) {
> +		riscv_iommu_cmd_inval_gvma(&cmd);
> +		riscv_iommu_cmd_inval_set_gscid(&cmd, gscid);
> +	} else {
> +		riscv_iommu_cmd_inval_vma(&cmd);
> +		riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
> +	}

As I understand it, the same choice is needed in
riscv_iommu_bond_unlink().

The missing GVMA command does not break anything today, because every
caller of bond_unlink() runs iodir_update() just before it, and that
already sends the GVMA for the old GSCID. But depending on that
ordering seems fragile, and the comment in bond_unlink(), "invalidate
all cached entries for domain's PSCID", is no longer true now that we
have S2 domains.

The change, if you think it is needed, fits better in the last patch,
"iommu/riscv: Add IOTINVAL.GVMA invalidations". I am replying here
only because the code is very similar.

Thanks,
Shuai

>  
>  	/*
>  	 * If non-leaf entries were changed and the IOMMU doesn't
> @@ -1097,7 +1107,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
>  		if (iommu == prev)
>  			continue;
>  
> -		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, &tlbi);
> +		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, domain->gscid, &tlbi);
>  		prev = iommu;
>  	}
>  
> @@ -1231,6 +1241,7 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>  
>  		WRITE_ONCE(dc->fsc, new_dc->fsc);
>  		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
> +		WRITE_ONCE(dc->iohgatp, new_dc->iohgatp);
>  		/* Update device context, write TC.V as the last step. */
>  		dma_wmb();
>  		WRITE_ONCE(dc->tc, tc);
> @@ -1281,16 +1292,19 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
>  
>  	WARN_ON(!list_empty(&domain->bonds));
>  
> -	if ((int)domain->pscid > 0)
> +	if (domain->pscid > 0)
>  		ida_free(&riscv_iommu_pscids, domain->pscid);
> +	if (domain->gscid > 0)
> +		ida_free(&riscv_iommu_gscids, domain->gscid);
>  
>  	pt_iommu_deinit(&domain->riscvpt.iommu);
>  	kfree(domain);
>  }
>  
> -static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
> +static bool riscv_iommu_fsc_supported(struct riscv_iommu_device *iommu,
> +				      int mode)
>  {
> -	switch (pgd_mode) {
> +	switch (mode) {
>  	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
>  		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39;
>  
> @@ -1303,6 +1317,22 @@ static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_m
>  	return false;
>  }
>  
> +static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu,
> +					  int mode)
> +{
> +	switch (mode) {
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4;
> +
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4;
> +
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4;
> +	}
> +	return false;
> +}
> +
>  static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  					    struct device *dev,
>  					    struct iommu_domain *old)
> @@ -1315,11 +1345,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  
>  	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
>  
> -	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
> -		return -ENODEV;
> +	if (domain->gscid) {
> +		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
> +			return -EINVAL;
> +
> +		dc.iohgatp =
> +			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
> +			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
> +			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
> +	} else {
> +		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
> +			return -ENODEV;
>  
> -	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> -	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> +		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> +			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> +	}
>  	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>  	     RISCV_IOMMU_PC_TA_V;
>  
> -- 
> 2.50.1
> 
