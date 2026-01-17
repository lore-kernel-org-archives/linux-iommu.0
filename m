Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518218C02E
	for <iommu@lists.linux.dev>; Sat, 17 Jan 2026 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624295; cv=none; b=sH/cGsCd22Rf0rTqABSDcv6OC6o2wAnS7upIbtBU6OQNEXsIcD/gtuRl66O7K3r6R7dM+qu8v5EG2sIwLvXv7qbq1Yi4yh7OoVrEy6tK+uBdZ3mk3Hy++xtl6wJWr5OHTGItpf4IRV4CLRHb4eOjpM0YA5xtcT+hG8EibfxsBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624295; c=relaxed/simple;
	bh=4FeJFkQPtIAguk7w+dELSaVMhp1ZvshYfF2mEclf2Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IR8SxwxKoOl96of+9MAEbJ3Oz3Zme3906iAMAqcnAwuVsGrfl/OOwplX8BFy9AJpQ0mUIsFrDFX9Jr+VA090JF2OvpL/Kw0QuGtCrg3vIzSehl9qQbyM86fu/3kSbtRcGiuewICIY+C214cM8UTId2cv7DtWI9nf+E9zM5p5s5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cHTrCMGS; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cHTrCMGS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768624285; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=sdQdmbnFJtM7zv/9PxUEdmxzoy0jV5u+mvL7/Ga2jCI=;
	b=cHTrCMGS7z8VgV87G2sUysB7o5wtYG03arCkc7y4Ejudme1xZtn0u3LclMmnwlT8m3x1TqnJ9Xro9Wv75ByKx8Gq9JjAtlC0bQWqZ6x8PI9sHQGNKb13WuggufWtGeeCJkV2n5F1yVHM96PGWl5QzdXvmKiu6QIaM2jom2nBh18=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WxC8X4A_1768624283 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 12:31:24 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	will@kernel.org
Subject: Re: Re: [PATCH] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
Date: Sat, 17 Jan 2026 12:31:17 +0800
Message-Id: <20260117043117.76052-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <c5sk7h5r5fozjdyguamekenlzd7pzbtvdh2boq3arynxifba22@ii4ikea2tuyq>
References: <c5sk7h5r5fozjdyguamekenlzd7pzbtvdh2boq3arynxifba22@ii4ikea2tuyq>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> Add riscv_iommu_iodir_iotinval() to perform required TLB and context cache
>> invalidations after updating DDT or PDT entries, as mandated by the RISC-V
>> IOMMU specification (Section 6.3.1 and 6.3.2).
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/iommu/riscv/iommu.c | 85 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index d9429097a2b5..2900170133fc 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -996,7 +996,82 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
>>  }
>>
>>  #define RISCV_IOMMU_FSC_BARE 0
>> +/*
>> + * This function sends IOTINVAL commands as required by the RISC-V
>> + * IOMMU specification (Section 6.3.1 and 6.3.2 in 1.0 spec version)
>> + * after modifying DDT or PDT entries
>> + */
>> +static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
>> +				    bool inval_pdt, unsigned long iohgatp,
>> +				    struct riscv_iommu_dc *dc, struct riscv_iommu_pc *pc)
>> +{
>> +	struct riscv_iommu_command cmd;
>>
>> +	if (FIELD_GET(RISCV_IOMMU_DC_IOHGATP_MODE, iohgatp) ==
>> +		RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
>
>nit: This condition can stick out. We have 100 chars.
>
Ack.

>> +		if (inval_pdt) {
>> +			/*
>> +			 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
>> +			 * PSCID=PC.PSCID
>> +			 */
>> +			riscv_iommu_cmd_inval_vma(&cmd);
>> +			riscv_iommu_cmd_inval_set_pscid(&cmd,
>> +				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
>> +		} else {
>> +			if (FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) || (
>> +				    FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc->fsc) ==
>> +				    RISCV_IOMMU_DC_FSC_MODE_BARE)) {
>
>nit: formatting

Ack.

>			if (FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) ||
>			    (FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc->fsc) ==
>			     RISCV_IOMMU_DC_FSC_MODE_BARE)) {
>
>> +				/* IOTINVAL.VMA with GV=AV=PSCV=0 */
>> +				riscv_iommu_cmd_inval_vma(&cmd);
>> +			} else {
>> +				/*
>> +				 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
>> +				 * PSCID=DC.ta.PSCID
>> +				 */
>> +				riscv_iommu_cmd_inval_vma(&cmd);
>> +				riscv_iommu_cmd_inval_set_pscid(&cmd,
>> +					FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, dc->ta));
>> +			}
>> +		}
>> +	} else {
>> +		if (inval_pdt) {
>> +			/*
>> +			 * IOTINVAL.VMA with GV=1, AV=0, and PSCV=1, and
>> +			 * GSCID=DC.iohgatp.GSCID, PSCID=PC.PSCID
>> +			 */
>> +			riscv_iommu_cmd_inval_vma(&cmd);
>> +			riscv_iommu_cmd_inval_set_gscid(&cmd,
>> +				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
>> +			riscv_iommu_cmd_inval_set_pscid(&cmd,
>> +				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
>> +		} else {
>> +			/*
>> +			 * IOTINVAL.VMA with GV=1,AV=PSCV=0,and
>> +			 * GSCID=DC.iohgatp.GSCID
>> +			 */
>> +			riscv_iommu_cmd_inval_vma(&cmd);
>> +			riscv_iommu_cmd_inval_set_gscid(&cmd,
>> +				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
>> +
>> +			/*
>> +			 * IOTINVAL.GVMA with GV=1,AV=0,and
>> +			 * GSCID=DC.iohgatp.GSCID
>> +			 */
>> +			/*
>> +			 * For now, the Second-Stage feature have not yet been merged, so
>> +			 * let's comment out the code first.
>> +			 */
>> +#if 0
>> +			riscv_iommu_cmd_send(iommu, &cmd);
>> +			memset(&cmd, 0, sizeof(cmd));
>
>The memset isn't necessary since riscv_iommu_cmd_inval_gvma(), which
>doesn't yet exist, will overwrite dword0 and zero out dword1.

Agreed, I’ll drop memset in v2.

>
>> +			riscv_iommu_cmd_inval_gvma(&cmd);
>> +			riscv_iommu_cmd_inval_set_gscid(&cmd,
>> +				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
>> +#endif
>> +		}
>> +	}
>> +	riscv_iommu_cmd_send(iommu, &cmd);
>> +}
>>  /*
>>   * Update IODIR for the device.
>>   *
>> @@ -1031,6 +1106,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>>  		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>>  		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
>>  		riscv_iommu_cmd_send(iommu, &cmd);
>> +		/*
>> +		 * For now, the SVA and PASID features have not yet been merged, the
>> +		 * default configuration is inval_pdt=false and pc=NULL.
>> +		 */
>> +		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
>>  		sync_required = true;
>>  	}
>>
>> @@ -1055,6 +1135,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>>  		/* Invalidate device context after update */
>>  		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>>  		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
>> +		/*
>> +		 * For now, the SVA and PASID features have not yet been merged, the
>> +		 * default configuration is inval_pdt=false and pc=NULL.
>> +		 */
>> +		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
>>  		riscv_iommu_cmd_send(iommu, &cmd);
>>  	}
>>
>> --
>> 2.50.1
>>
>
>A faithful implementation of the 6.3.1 and 6.3.2 guidelines for what the
>code currently supports. I presume this is fixing an issue? If so, can you
>point that out in the commit message?

Yes, this is fixing a functional issue: when software changes a leaf-level
DDT or PDT entry we weren't issuing the required IOTINVAL.
I'll update the commit message in v2.

>
>Otherwise,
>
>Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>
>Thanks,
>drew
>
Thanks,
Fangyu
