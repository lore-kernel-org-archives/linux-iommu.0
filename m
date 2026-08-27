Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533D23C4F3
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819088; cv=none; b=m/DQ4w5nq1SeaL1pZNrmELvoWAPUdR5nD2P5ipLw93zyePXcmVP/mNcRPYYS6GbOlvlF3Zb5xvNVN2rU4JttafmLomNFEJjnKpXBOtbXQAVWYGVM4mLn/DI+78n6xG7i40FadzV01Jcz3zhe/G9EJkMqE9ePOFbUYL22yOUSkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819088; c=relaxed/simple;
	bh=/Q0aJrv+yl12z/4UckcwepB9NSMo1dKRgB+t+KI/qk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRvQB/fSO0YUWbYGnXqJbkWgZ6wa4idJfUVtq3Q1K696EdUWbo1Q7sOai98WaQwAt2XbKYMDxA/lqr6aev8Xqa5kvkIEwTSO3wieABLc7KttfDT1793urkKuXqjITM25drvNb1lb05AWasOB5ttBbsjKakT7VIe0SsxTOnMmrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cHTYdhin; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GEBwsgiX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHTYdhin";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GEBwsgiX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R83Z087755
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0WOkKUTTNS6mJs2BwdqhMg+NA2BpiKjHIQAe3GoU9ZE=; b=cHTYdhinTE2J6jHu
	CRsL3AEWHTNk59lfjUAvsY2eSKPkO65LCpqfIwm/F11fPHe/TxipKRpCch1qPUkZ
	g0Zdv5f7ZZXJglBzZ++Pp45Lmlp9ohyoW6BLLGdr+ZP+Eb2pjefHo3Nyqtq7TFBn
	tGBokPgf5kGmoiQD6ZWQttK8rcjHUoqkv7dbovdNbY3RHs9MfrB9/KowXcrbm+3g
	RoPU5AWjwPUqM57H5P/JtaOoIrJdhJG7Qsdqkkkb23DvYJsyWys2s3IEe4/ALx17
	qERojUpilfpRoAI/RLXWthRvqKZ7pp0nSDOrVbBrd+YGq69eQYKQZctTWJXklQ4n
	4ra5MA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5ht87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:24:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb92868263so441140a12.2
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787819086; x=1788423886; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WOkKUTTNS6mJs2BwdqhMg+NA2BpiKjHIQAe3GoU9ZE=;
        b=GEBwsgiXm4T8aVCq3Nd54Q/RRpbuV6bf1jTLtqwG6+wbxB5uEn/JneLUHWlT4uQlVb
         vXPZBkwBxyFFCfTDVKt54n3C3uZr/655A9+2EJtrz9RTN1Yal2ipzMe2JR5FHWNDa5ie
         vtAUMrGWEpU4wCpbiqpMYQzwXwk3SrgUDX2qlpECRT483vWUzOa3r1xB7xJ5KW3gKx+O
         f2QmkqdwyWzZlmPLrUImC26zeh9pSyFBM4rJLVHCY+/ZDA0ODwbTydXd/AxK9et1Wqjn
         Gg0l59JLtxbSIiH8aMMYGMJNoqzwASKzzPmDHtvGW+8WTfjxPz7fCuNq/nhdr6UXrYtW
         lZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787819086; x=1788423886;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0WOkKUTTNS6mJs2BwdqhMg+NA2BpiKjHIQAe3GoU9ZE=;
        b=EvEfB5l+mte1U7efc+CUDVFY2FZTXdoUy5TCzRSEb/2oVQ3m7ieTJUfO1ssMmtoetD
         jqnsikfHe20zyKSXgQKuWtXA47qiUYX/7d6Jm/fHSVdUILZq5ait9mTCKaKaWQ1hTOsD
         PHsss5zo8GkXlcRTJ+a6HwxO6N4+1mlg+Gf+fCwCxoOD4xKHzUOmEdnccD7xMG33OmvG
         SMs/m84UHkz653C13I4GR2ZGVnfrz/POpFtii15u2aiDNr0Gbl6O0jAnxggWWfyVysa/
         hxvt0+Vq+wQeL58j5U3gJcDPESYBUYbVJaB43R472wHmGo+vVYqPFklwh5B/NWFx40Rx
         RWzg==
X-Forwarded-Encrypted: i=1; AHgh+RqUWqeVNVX6/a6LCxddFXaklDuyR+lb8qvgm+gb1pyZMe23NVGPUPXSilRTW+8xI3tkq3MXZA==@lists.linux.dev
X-Gm-Message-State: AFuF++kT+X/09SS6yud16KrKpQENXZS3dfBrWb2DPMmV3BXfCwnisboF
	Ig+T/ij3tvdHWTjstFqsmRrXl5QXRm5DAshBtCRrv92WDW43PuMoNVzGRnEQD5BEvfoMJaXfso8
	XbPH1ZxTgcsrA7jTw5qFX762FrkYoeDSdTIih5Cns3PPdXPTdPmN/wLMfog==
X-Gm-Gg: AR+sD11hLPnWDzVdXloseXKqt4wIAXoOn/30rej7GUQ+ukNw0mqKmiNaOsSOS+ZnWGx
	kk5kcKGXvBBUeIBcZaDZw6v8Wk5Pd1+W1ihFs7j78effqwgZ3zRZpJHePuJ4cA5Vxuyj+vkLYTX
	gUe1Su25oHQf7equSYEj/ozTcTp1RPA+mTn51EHUqjfcidom4Gw/hy8rleNj1wPBF3mabwvZPb6
	u2zC38UYBySudsWul23wTEPYKjc7pjbr9RZ580jHY+eZ6zIfMbv8UPvXkeamzi3hJQPsKMaw7cJ
	FzhhJDxgOIAxgtfNpWQrGke/QNhicbfAp1nzhLFbfxQFuYfclHhm/Yp5ARjfaTZOPxmDS9fft8D
	sgBk/NjrFQrP0YHXzIUHf9YiIhCsqoT9cGQ==
X-Received: by 2002:a05:6a21:9d84:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cf844449abmr28579008637.10.1787819085636;
        Thu, 27 Aug 2026 01:24:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:9d84:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cf844449abmr28578942637.10.1787819085169;
        Thu, 27 Aug 2026 01:24:45 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1bec989f2sm1835547a12.28.2026.08.27.01.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:24:44 -0700 (PDT)
Message-ID: <8188c158-60ed-4d05-a26e-c127850520cb@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 13:54:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Daniel Mentz <danielmentz@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
 <CAE2F3rB7zpPFfC376mP=god9HWRmKOaQUEgPVzKScxS12pZrvQ@mail.gmail.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <CAE2F3rB7zpPFfC376mP=god9HWRmKOaQUEgPVzKScxS12pZrvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lgc3rIO-OLjdlXOKmyOPbYzjQBR_Hkdo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2OCBTYWx0ZWRfX6X9Hq/ZXlI+Y
 c9l4tjlborpodFFXDFmuANysDd0d904Wn9IpFdl8D+Y9gryyAt8zFTUzINpNezRZTlgJWEB3eYn
 hYOLl3rT9PU2WMyJ1YGeccp3y93Xtus=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2OCBTYWx0ZWRfX85a02zTiXj1T
 RxlTpgCuExTENAt0sX9GkIUIc7NQQtmnJ1OrXzUyBuJbjPUVH93am98oth/WPIl62cvWWN0rteG
 2RkQ6REWyBmMgeheBc+G9c7Bw2jd2hvmOfsT+SppfhS2jUnorahccVo+jIFrTeKXfODBFS9Hwvr
 3dCQd/EGEuJzcuEGbvP5vgyzFqBMUK5shou9e51I2NtXAeQHJwpidiVwCxL6i4GDRbPVF7avrwK
 iBPhJWmWVLeyoYgGR7h/S8AE2qDPm18wUfbbKb6E/WCtrw2/SNRX7tjUGWyVj2qqOaPPHIYrLJE
 WV4BIgphsQ70jAxlN49c+cLuMnQ1M1MyoDEnCbiJxp+eHPENPToemR+28hbiovLz/PsqGDr+sdW
 VEzoIYcfsoKKXMRvmBXZPV43l8bTImKPrN3+x1r1Cb2JhvViqn4onvHNvmEhiG4I7P96zx4DfcP
 D4HglUN4aPwTHSoV3kg==
X-Proofpoint-GUID: lgc3rIO-OLjdlXOKmyOPbYzjQBR_Hkdo
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8ff44e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hD7wzR-C_dcGOD24FjMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270068



On 8/15/2026 3:27 AM, Daniel Mentz wrote:
> On Mon, Aug 3, 2026 at 11:19 PM Vijayanand Jitta
> <vijayanand.jitta@oss.qualcomm.com> wrote:
>> +static unsigned long arm_lpae_get_cont_sizes(struct io_pgtable_cfg *cfg)
>> +{
>> +       unsigned long pg_size, blk_size, l1_blk_size, cont_sizes = 0;
>> +       unsigned long cont_leaf_size, cont_blk_size, cont_l1_blk_size;
>> +       int pg_shift, bits_per_level;
>> +
>> +       if (!cfg->pgsize_bitmap || (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
>> +               return 0;
>> +
>> +       pg_shift = __ffs(cfg->pgsize_bitmap);
>> +       bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
>> +       pg_size = 1UL << pg_shift;
>> +       blk_size = pg_size << bits_per_level;
>> +       l1_blk_size = blk_size << bits_per_level;
>> +
>> +       cont_leaf_size = arm_lpae_num_cont(pg_size) * pg_size;
>> +       if ((cfg->pgsize_bitmap & pg_size) &&
>> +           arm_lpae_cont_size_fits(cfg, cont_leaf_size))
>> +               cont_sizes |= cont_leaf_size;
>> +
>> +       if (cfg->pgsize_bitmap & blk_size) {
>> +               cont_blk_size = arm_lpae_num_cont(blk_size) * blk_size;
>> +               if (arm_lpae_cont_size_fits(cfg, cont_blk_size))
>> +                       cont_sizes |= cont_blk_size;
>> +       }
>> +
>> +       /*
>> +        * l1_blk_size is only set in pgsize_bitmap if level-1 blocks are
>> +        * supported for this granule (not 16K/64K, per
>> +        * arm_lpae_restrict_pgsizes()), so no extra gating is needed here.
>> +        */
>> +       if (cfg->pgsize_bitmap & l1_blk_size) {
>> +               cont_l1_blk_size = arm_lpae_num_cont(l1_blk_size) * l1_blk_size;
> 
> Our AI model is saying that this might overflow cont_l1_blk_size on 32
> bit platforms i.e. 16 * 1G doesn't fit into a 32 bit type. It says
> that cont_l1_blk_size will be truncated to 0, and
> arm_lpae_cont_size_fits() then calls ilog2(0) which is undefined.
> 

Ack. With arm_lpae_cont_size_fits removed this won't be an issue anymore.

>> +               if (arm_lpae_cont_size_fits(cfg, cont_l1_blk_size))
>> +                       cont_sizes |= cont_l1_blk_size;
>> +       }
>> +
>> +       return cont_sizes;
>> +}
> [...]
>> @@ -660,6 +829,8 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>  {
>>         arm_lpae_iopte pte;
>>         struct io_pgtable *iop = &data->iop;
>> +       size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>> +       int num_cont = arm_lpae_num_cont(block_size);
>>         int i = 0, num_entries, max_entries, unmap_idx_start;
>>
>>         /* Something went horribly wrong and we ran out of page table */
>> @@ -674,10 +845,22 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>                 return 0;
>>         }
>>
>> +       /*
>> +        * Normalize an exact whole-CONT-group request down to the
>> +        * equivalent block_size/pgcount, mirroring __arm_lpae_map().
>> +        */
>> +       if (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT) &&
>> +           num_cont > 1 && size == block_size * num_cont) {
>> +               pgcount *= num_cont;
>> +               size = block_size;
>> +       }
>> +
>>         /* If the size matches this level, we're in the right place */
>> -       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>> +       if (size == block_size) {
>> +               size_t cont_size = num_cont * block_size;
>> +
>>                 max_entries = arm_lpae_max_entries(unmap_idx_start, data);
>> -               num_entries = min_t(int, pgcount, max_entries);
>> +               num_entries = min_t(size_t, pgcount, max_entries);
>>
>>                 /* Find and handle non-leaf entries */
> 
> This comment is no longer accurate. The handling now extends beyond
> non-leaf entries.
> 

Agreed, that comment is stale -- the loop now also validates CONT-group
alignment on leaf entries (rejecting an unmap that would split a tagged
group) before falling through to the non-leaf teardown. Will update it to
something like:

/* Validate leaf entries and handle non-leaf entries */


>>                 for (i = 0; i < num_entries; i++) {
>> @@ -687,6 +870,40 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>                                 break;
>>                         }
>>
>> +                       /*
>> +                        * A real CONT group must always be invalidated as a
>> +                        * unit, so reject an unmap that splits one. Check the
>> +                        * PTE's own CONT bit rather than the caller's size,
>> +                        * since a legitimate unmap can span multiple prior
>> +                        * iommu_map() calls and its size alone doesn't say how
>> +                        * the underlying PTEs were grouped. Only the first and
>> +                        * last entries can straddle a group boundary; an
>> +                        * interior CONT-tagged entry's group is necessarily
>> +                        * fully covered by this unmap, since groups can't
>> +                        * overlap without also covering everything between
>> +                        * them.
>> +                        */
>> +                       if (pte & ARM_LPAE_PTE_CONT) {
>> +                               bool ok = true;
>> +
>> +                               if (i == 0)
>> +                                       ok = ok && IS_ALIGNED(iova, cont_size);
>> +                               if (i == num_entries - 1)
>> +                                       ok = ok && IS_ALIGNED(iova + (i + 1) * block_size,
>> +                                                             cont_size);
>> +
>> +                               /*
>> +                                * Stop short of this entry instead of returning
>> +                                * 0: entries before i may already have had
>> +                                * non-leaf sub-tables torn down above, so the
>> +                                * caller needs the real unmapped count, and the
>> +                                * loop exit below still clears/gathers entries
>> +                                * [0, i) correctly.
>> +                                */
>> +                               if (WARN_ON_ONCE(!ok))
> 
> Consider aligning with the following WARN_ONCE in the same function:
> 
> WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed");
> 

Ack.

>> +                                       break;
> 
> I think this behavior is inconsistent: when a problem is detected at
> the beginning of the unmap range, you return without modifying the
> table, whereas if it's detected at the end, the code proceeds with
> unmapping and leaves the table misconfigured. Could these checks be
> performed before entering the loop?
> 

Agreed, Will move both checks before the loop so a rejected unmap is always a
full no-op, regardless of whether the violation is at the start or end of
the range.

Thanks,
Vijay

>> +                       }
>> +
>>                         if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>                                 __arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
>>

