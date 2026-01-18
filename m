Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3D3B2AA
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768746804; cv=none; b=KFOct3SKuwcbueN12875uUmclGqOSxSNsNxeMLH0CfDYOi21eYXFDR0Gg628H7S9S81D4GtwLnlfFZnb7apIMK7GeTKxfRTn9OR/gL0K8grYi6SVW3VY3UjcgXc+IEcnP/t8eCz1EbJwF/CF7QtfZ2NBNsLfPfEqhSO3tZuI/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768746804; c=relaxed/simple;
	bh=R/Xh3AHQ607LJCdMF01IiPogVWb0J4dKnVHmrAGkHUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHF336e277XxjLZxr2oonDV5K1ze4OGEHnzlMleAbZDmV4gPdq/jVtt2Y3sOsH2hP94cll8Zw8XAG6EYrrm3zlivRn2l6C3VwncvQZWlPFQiBPA19QomlVHJbyt/a8cxFxGVWPz3z57HTTH7HKWjeGGVPRekC7dgSatU8vYcybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YXOK/Z2n; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YXOK/Z2n"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768746792; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=iCz/1vk1Ei2IWAYd4SZ6Ak/RPBfeSYsHibOQYewCZg0=;
	b=YXOK/Z2n5JOT6lee/hROhx6mnM4aNBm/8aJD8JMELGt4Swzq9PHkgpthMEalfMLpceqpIcFi8chgz8ztu9RwRtllXm5bk+4Wj/QqrVPPSGptWySSxwC/X+f0FHa9FwK+fXiWYuU8G/qXVft8C6WnUvmtP5aFQzs/g849nnaNdP4=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WxG4hj5_1768746789 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 18 Jan 2026 22:33:11 +0800
From: fangyu.yu@linux.alibaba.com
To: guoren@kernel.org
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
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
Date: Sun, 18 Jan 2026 22:33:09 +0800
Message-Id: <20260118143309.94209-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAJF2gTQj-mtbg8Q9fN6=EprfV0XaXy-X=auP9iwrF-nLAJ4Ovg@mail.gmail.com>
References: <CAJF2gTQj-mtbg8Q9fN6=EprfV0XaXy-X=auP9iwrF-nLAJ4Ovg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>Hi fangyu,
>
>On Thu, Jan 8, 2026 at 9:49 PM <fangyu.yu@linux.alibaba.com> wrote:
>>
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
>> +                                   bool inval_pdt, unsigned long iohgatp,
>> +                                   struct riscv_iommu_dc *dc, struct riscv_iommu_pc *pc)
>> +{
>> +       struct riscv_iommu_command cmd;
>>
>> +       if (FIELD_GET(RISCV_IOMMU_DC_IOHGATP_MODE, iohgatp) ==
>> +               RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
>> +               if (inval_pdt) {
>> +                       /*
>> +                        * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
>> +                        * PSCID=PC.PSCID
>> +                        */
>> +                       riscv_iommu_cmd_inval_vma(&cmd);
>> +                       riscv_iommu_cmd_inval_set_pscid(&cmd,
>> +                               FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
>> +               } else {
>> +                       if (FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) || (
>> +                                   FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc->fsc) ==
>> +                                   RISCV_IOMMU_DC_FSC_MODE_BARE)) {
>> +                               /* IOTINVAL.VMA with GV=AV=PSCV=0 */
>> +                               riscv_iommu_cmd_inval_vma(&cmd);
>> +                       } else {
>> +                               /*
>> +                                * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
>> +                                * PSCID=DC.ta.PSCID
>> +                                */
>> +                               riscv_iommu_cmd_inval_vma(&cmd);
>> +                               riscv_iommu_cmd_inval_set_pscid(&cmd,
>> +                                       FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, dc->ta));
>> +                       }
>> +               }
>> +       } else {
>> +               if (inval_pdt) {
>> +                       /*
>> +                        * IOTINVAL.VMA with GV=1, AV=0, and PSCV=1, and
>> +                        * GSCID=DC.iohgatp.GSCID, PSCID=PC.PSCID
>> +                        */
>> +                       riscv_iommu_cmd_inval_vma(&cmd);
>> +                       riscv_iommu_cmd_inval_set_gscid(&cmd,
>> +                               FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
>> +                       riscv_iommu_cmd_inval_set_pscid(&cmd,
>> +                               FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
>The riscv_iommu_cmd_inval_vma() and riscv_iommu_cmd_inval_set_pscid()
>could be moved out to prevent duplicate code.

Thanks, Agreed on reducing duplication.

I'll move riscv_iommu_cmd_inval_vma() to a common path (build the VMA command
once), and only conditionally call riscv_iommu_cmd_inval_set_pscid() when
PSCV=1 is required by the spec.

>
>> +               } else {
>> +                       /*
>> +                        * IOTINVAL.VMA with GV=1,AV=PSCV=0,and
>> +                        * GSCID=DC.iohgatp.GSCID
>> +                        */
>> +                       riscv_iommu_cmd_inval_vma(&cmd);
>> +                       riscv_iommu_cmd_inval_set_gscid(&cmd,
>> +                               FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
>> +
>> +                       /*
>> +                        * IOTINVAL.GVMA with GV=1,AV=0,and
>> +                        * GSCID=DC.iohgatp.GSCID
>> +                        */
>> +                       /*
>> +                        * For now, the Second-Stage feature have not yet been merged, so
>> +                        * let's comment out the code first.
>> +                        */
>> +#if 0
>> +                       riscv_iommu_cmd_send(iommu, &cmd);
>> +                       memset(&cmd, 0, sizeof(cmd));
>> +                       riscv_iommu_cmd_inval_gvma(&cmd);
>> +                       riscv_iommu_cmd_inval_set_gscid(&cmd,
>> +                               FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
>> +#endif
>All the above should be removed from the patch; we don't need draft code.

Agreed, I will drop the entire #if 0 draft block and add a TODO here.

>
>> +               }
>> +       }
>> +       riscv_iommu_cmd_send(iommu, &cmd);
>> +}
>>  /*
>>   * Update IODIR for the device.
>>   *
>> @@ -1031,6 +1106,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>>                 riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>>                 riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
>>                 riscv_iommu_cmd_send(iommu, &cmd);
>> +               /*
>> +                * For now, the SVA and PASID features have not yet been merged, the
>> +                * default configuration is inval_pdt=false and pc=NULL.
>> +                */
>> +               riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
>The riscv_iommu_iodir_iotinval() is the same level as
>riscv_iommu_iodir_update(). Could we move it out and put it after
>riscv_iommu_iodir_update()?

In riscv_iommu_iodir_update() we first clear the valid bit in dc->tc, an
IOTINVAL is required immediately after modifying the DDT/PDT entry to make
the change effective.

So riscv_iommu_iodir_iotinval() is paired with the DDT/PDT update sequence at the
same level as riscv_iommu_cmd_iodir_inval_ddt(), and keeping it adjacent preserves
the required ordering and avoids a window where stale cached context could be used.
>
>>                 sync_required = true;
>>         }
>>
>> @@ -1055,6 +1135,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>Why do you have two riscv_iommu_iodir_update() function definitions?
>
>>                 /* Invalidate device context after update */
>>                 riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>>                 riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
>> +               /*
>> +                * For now, the SVA and PASID features have not yet been merged, the
>> +                * default configuration is inval_pdt=false and pc=NULL.
>> +                */
>> +               riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
>If IOTLB invalidation occurs before DDT_CACHE invalidation, the IOTLB
>may use DDT_CACHE's stall info, which may cause IOTLB invalidation to
>fail.

You're right. I placed riscv_iommu_iodir_iotinval() before riscv_iommu_cmd_send()
by mistake, I’ll fix the ordering in v2.

>
>>                 riscv_iommu_cmd_send(iommu, &cmd);
>>         }
>>
>> --
>> 2.50.1
>>
>
>-- 
>Best Regards
> Guo Ren

Thanks,
Fangyu
