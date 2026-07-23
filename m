Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984E39C657
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827819; cv=none; b=GQHJ4nAjFAg/i+W/CoMTS0/43txdhnSeZIfcUA1QCpi6Jc++1WyH0FI/QlMOP84M4tZGfZF7LwhLBK/VWqVX0twuO6vAF5NUN2SMKxM8GEDMqzJ/ECVxGgEHjlaIyfRklqr29EzPw3HT8Ja8DPutLCxtf+8yeRe3rdoU90ogYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827819; c=relaxed/simple;
	bh=GiKunErmVpgwhtQi4uYiU4GILTxzZiK4e8zpwVNAGB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5mJ8z2DDtG4ThrTIkZbfa0Wbw1h31u0xB2ALnFnZYRd6LA5vNCGfUYg/v5xnWqzykUsZcS16fHnVU+WPUQVOtMwvFgVLr7Gs9KbhuDWlY+VBMGRmRFXzfv0cDBhiTOM1qkpYIiyK07MWOb+DRLCoXh3mjtYM6dCUP6HOloOg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WdskJwH8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CX3vFhiG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WdskJwH8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CX3vFhiG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NF5V5k1326126
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 17:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uMzoVZC+7YL7JhMFnPv+xGVvZurLm4hepnhNJ6t6CnM=; b=WdskJwH83kgMfYXI
	0ug+Ejd2Jan9SKtAGl+1ChkawoWByhvPteRajDTlFrjAN94mKT9hPS0Gs/v/GxKh
	pKQBIlS1tDJuIS5hWanwXvn4/8ldSOgWpRDnGQcyZwmqMLp2K9PBNYY2ZZAca+6O
	hRF4FbmnO2qxDgvPelupIPXirIkzS5JmW5oMw6g1miTqwXdRW979+YHvmitibsn3
	3k5BEr2AP0GmD4g7ONscA9IahQbPQF7/o4YRzjkaA8X0grFX7zzitPc16jF9DSSC
	LZWDmnwXo574dnOlBrKQVhQYt+SpDreY4F5zitiuR5WJlchVRKmK3OG4sjmQxgyv
	Pxuw+Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkn9a0r81-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 17:30:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so752937a12.1
        for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784827816; x=1785432616; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMzoVZC+7YL7JhMFnPv+xGVvZurLm4hepnhNJ6t6CnM=;
        b=CX3vFhiGDg1lsism4wyCvFWZsUBYZJAKH3ybKZqfX4qncmlIVA+sVs1x0pBZdccWsI
         t/sCwRNmI+TBNuvzHKBmjSiyi9J/O6Xu9jZirSjp5EIOeIEO4xzcam14zsExDjnkldUu
         r8RtFDM/BnVfETrqqv3GT15K+fQKWQottEgJ+h9pxappZm3ZlVnXxIy/xmAAf6Zw9cgS
         a3gYjCYSH2/ib7kp8C3JDmp313hmwgTeWKfQS1ZbJCJmxKOWkbk2WxPyAT3nNoDTC6ki
         jf5LgA/49K/oPRQtBUcE/DyiSPSlHiU3srbeHOsF9awt1AMkp0dYAYwyzn0BbnRn+5e0
         YKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827816; x=1785432616;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMzoVZC+7YL7JhMFnPv+xGVvZurLm4hepnhNJ6t6CnM=;
        b=EUjcKTjxqvXs1NaUK1ICZJAxBVmPl0cR9Z38bZ9FUiaRdTD0SxZFf47Rz3zuCXBpxZ
         0+QHnpstWVesgU7BoKwauCUf5yMJgr5FAZ521us9YqtGXYcfpFQzgyCDHtXisSLC+1/k
         BM2ThjcM9xlVzd7wUD62FXxXKMmEjquNV8CpHBpqyxsl6aN4kZOIwAMxdFpmoa7RqB07
         ukdKWJW7ffNkL65dhOtc1YhdLJDjl9kY11wAmWMerbj3H02oyUKpw+fhLFB95/KGsaPN
         Jluk4ILzjz0g/jn6N/IF9dhcqxPlLoN5lx2pNCaq71vaIc3ar3VZy32H7kR8gaHk/UFi
         jDqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvlzCAYjHP4o5cvSgcbjnXQMuoUOtRMJfgl4QICStHD+fJnZitCuJyHq8coM0eZJTgptFPag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVMeUojzBHgtscuGQiJr9Rn1bgCLKRUuCWcQCK+h+P8ONGqpUO
	apkc6iporP8V084ghkHGddbuxr+gEqvRcXTRQGjJzu7/EeWq/ao6zW41lSxok/sQnqSfuOyiHyq
	uevdw4+B45teLMTXtaSh3G9r72E9S/OOyOfCeDTMBI89APH1BLIBmLSZz5A==
X-Gm-Gg: AR+sD11wAh/S9mafyG1mGC8BlLKBhVE2bQOcpAVrPpu2k1K0kfaHUj8NweJTPHtl3Ox
	N0YLfq8NpeIqZK6+bTYWRGlQkxRRzpmzts5uv6GWOEWFRsKlGvJbcQeqiWvKRh4fYCxj4VKwWbo
	i5Ne836QcKkMqO5pQsBGUepWLJ7CN2pomENHs5t1DK5KqNeUSrqQQWErBQk5y49Z/mmBIFficoa
	bRyiKoxS1o/YIRW7rGKd8frAoSb8ICzA5gUdY81x/whTzoe7dAG8fSDHuZNB+qgQfIo4AMR6ufx
	PHojKSaxpF7eCOC90n5qadyBWzjZYn71Hh5dbctBxzaiAzJ8qjcsuXChjthDcISxbWX78KMgknY
	V5h4z6WzdqpyA39BvISQcMl09AommHtNf4VzM
X-Received: by 2002:a05:6300:141:b0:3c3:a1a4:862c with SMTP id adf61e73a8af0-3c44b2680b9mr4464100637.68.1784827816110;
        Thu, 23 Jul 2026 10:30:16 -0700 (PDT)
X-Received: by 2002:a05:6300:141:b0:3c3:a1a4:862c with SMTP id adf61e73a8af0-3c44b2680b9mr4464054637.68.1784827815579;
        Thu, 23 Jul 2026 10:30:15 -0700 (PDT)
Received: from [192.168.1.9] ([205.254.168.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm21787202eec.26.2026.07.23.10.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 10:30:14 -0700 (PDT)
Message-ID: <8c285d41-8236-4c54-b62c-407b4aac926a@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 22:59:21 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260722-iommu_contig_hint-v3-1-10923a683441@oss.qualcomm.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260722-iommu_contig_hint-v3-1-10923a683441@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MCBTYWx0ZWRfXxUUQjLjM6UE+
 h9jmbnL0lb8mQm6Xrwn7hQjuTF7J2O0+Z6umYXVtz78c2qvz2sELyjHpW8AybGxlArXl0fW6hLZ
 QzsIAISAZEV+Cd9qF0Whhw40CE+LiVcPEgzdTujJS4dBXqfQJjeNZz3/NEsb8DDdZFZD3Bx61vS
 nw/OSUsR7PPNc6uxXHLVCQXWAr9z2Y2d4rcAGvxqUjDC0jewjzx5WzgRVlVxkSYyRImzQeT1kYt
 Rb43HUv+4sQhnR5MLjPSDY5x4VdSK7sC8SXPaZvq7NP3MtfZsGfEND7pqB3l3EGgx3DrXnojNZ0
 HF6+U1Md/WhDvEcQzUgU2LBZBZK4Pv0rfj+PHnHWVtO3lYUUNvS4vCyiGQIAGI2FvSNOilKGOMb
 sxFuvxDWBjEGMQI9jyNYAkY2XNQv7yQqUNHT6huYcRCtxwe633D3wkKDtg33CCUJwLz8rVeVoWd
 J7FefZFzVsnIe3U3vSw==
X-Proofpoint-ORIG-GUID: kPQP2t6oqv3F_pki4I2RxgrBrT4EAjZd
X-Proofpoint-GUID: kPQP2t6oqv3F_pki4I2RxgrBrT4EAjZd
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a624fa8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=FJCQGTV+dYaoHdG4tXisQw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
 a=tA7aZXjiAAAA:8 a=JfrnYn6hAAAA:8 a=BMDDCE21D0KWtaaFyzEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MCBTYWx0ZWRfXxCiZsSwOYWS1
 tBiFyXs5IqWCAdHDcVHdvX8qhBiLBCj4VRkZ3jcdixfYZGph/Jxl79L3DhVbBwN3RtaP+P32UtU
 6yyBbOq8yPH9gn5GVvlf2thheUBAe70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230170



On 7/22/2026 9:17 PM, Vijayanand Jitta wrote:
> From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> 
> Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
> When a set of consecutive PTEs map a naturally-aligned contiguous block
> of memory, the CONT bit can be set on all entries in the group to allow
> the hardware to combine them into a single TLB entry, improving TLB
> utilization.
> 
> The contiguous hint sizes per granule are:
> 
>   Page Size | CONT PTE |  Block  | CONT Block | L1 Block | CONT L1
>   ----------+----------+---------+------------+----------+---------
>       4K    |   64K    |   2M    |    32M     |    1G    |   16G
>      16K    |    2M    |  32M    |     1G     |          |
>      64K    |    2M    | 512M    |    16G     |          |
> 
> Contiguous hint sizes are advertised in pgsize_bitmap so that IOMMU API
> users can align allocations to these sizes and benefit from the TLB
> optimization automatically.
> 
> Partial unmaps of a contiguous group are rejected, ensuring the full
> group is always invalidated as a unit. The
> IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
> contiguous hint support at runtime for hardware with
> implementation-specific errata.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Co-developed-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> ---
> Changes in v3:
> - Collapse arm_lpae_cont_ptes()/arm_lpae_cont_blks()/
>   arm_lpae_cont_pte_size()/arm_lpae_cont_blk_size()/
>   arm_lpae_find_num_cont() into a single arm_lpae_num_cont(size_t size)
>   helper, since leaf/block/L1-block sizes never overlap across granules.
> - Fix arm_lpae_pte_is_contiguous_range() never checking that iova/paddr
>   are aligned to the contiguous group size, by removing it entirely -
>   __arm_lpae_map()'s new arm_lpae_install_leaf() helper scans for
>   aligned sub-chunks and independently verifies paddr alignment for
>   each one before applying the CONT hint.
> - Fold the CONT case into __arm_lpae_map()'s existing size == block_size
>   leaf path instead of duplicating arm_lpae_init_pte() in a separate
>   branch. A request whose size exactly matches a whole CONT group is
>   normalized down to block_size/scaled pgcount so it reaches that path;
>   arm_lpae_install_leaf() then walks the resulting range in chunks,
>   tagging only the sub-chunks that are both index-aligned and
>   paddr-aligned to the group size, since a single map_pages() call at
>   the plain block_size can still contain such an aligned group midway
>   through a larger, otherwise ungrouped range.
> - Replace the unmap-side WARN_ON_ONCE(!IS_ALIGNED(iova, size)) with a
>   check on the actual ARM_LPAE_PTE_CONT bit of the PTEs being cleared.
>   The previous check incorrectly warned on any unmap whose size
>   happened to numerically match a CONT group size, even when the
>   underlying PTEs were never CONT-tagged (e.g. because the original
>   iommu_map() wasn't group-aligned), and even though iommu_unmap() can
>   legitimately assemble such a size from multiple independent prior
>   iommu_map() calls.
> - Close a leak where ARM_MALI_LPAE would gain CONT-sized entries in its
>   pgsize_bitmap despite the format having no CONT bit, by having
>   arm_mali_lpae_alloc_pgtable() set IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT
>   internally rather than special-casing the format in the shared
>   arm_lpae_restrict_pgsizes()/arm_lpae_get_cont_sizes() path.
> - Gate each contiguous-hint size in arm_lpae_get_cont_sizes() on whether
>   a single group actually fits within the configured IAS/OAS, so e.g. a
>   16G level-1 CONT group is never advertised for an IAS too small to
>   address it.
> - Link to v2: https://patch.msgid.link/20260721-iommu_contig_hint-v2-1-90c731a41163@oss.qualcomm.com
> 
> Changes in v2:
> - Extend contiguous hint support to level-1 (1G) blocks for the 4K granule,
>   adding a CONT L1 (16G) grouping alongside the existing CONT PTE/CONT Block
>   sizes.
> - Replace the compile-time CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT Kconfig option
>   with a runtime quirk, IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT, so SMMU drivers
>   can opt out per page table instance instead of at build time.
> - Simplify __arm_lpae_map() to program the CONT-sized block directly via
>   arm_lpae_init_pte() instead of recursing into the next level with an
>   adjusted pgcount.
> - Reject unmaps that are not aligned to the contiguous group size with
>   WARN_ON_ONCE(), instead of clearing the CONT bit on a partial group before
>   invalidation.
> - Link to v1: https://patch.msgid.link/20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com
> 
> To: Will Deacon <will@kernel.org>
> To: Robin Murphy <robin.murphy@arm.com>
> To: "Joerg Roedel (AMD)" <joro@8bytes.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iommu/io-pgtable-arm.c | 231 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/io-pgtable.h     |   3 +
>  2 files changed, 226 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 476c0e25631af..ec6eacff07ac8 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -86,6 +86,21 @@
>  /* Software bit for solving coherency races */
>  #define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
>  
> +/* PTE Contiguous Bit */
> +#define ARM_LPAE_PTE_CONT		(((arm_lpae_iopte)1) << 52)
> +
> +/*
> + * CONTIG HINT SUPPORT TABLE
> + *
> + *------------------------------------------------------------------
> + *| Page Size | CONT PTE |  Block  | CONT Block | L1 Block | CONT L1 |
> + *------------------------------------------------------------------
> + *|     4K    |   64K    |   2M    |    32M     |    1G    |   16G   |
> + *|    16K    |    2M    |  32M    |     1G     |          |         |
> + *|    64K    |    2M    | 512M    |    16G     |          |         |
> + *------------------------------------------------------------------
> + */
> +
>  /* Stage-1 PTE */
>  #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
>  #define ARM_LPAE_PTE_AP_RDONLY_BIT	7
> @@ -453,6 +468,137 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
>  	return old;
>  }
>  
> +static int arm_lpae_num_cont(size_t size)
> +{
> +	switch (size) {
> +	case SZ_4K:
> +	case SZ_2M:
> +	case SZ_1G:
> +		return 16;
> +	case SZ_64K:
> +	case SZ_32M:
> +	case SZ_512M:
> +		return 32;
> +	case SZ_16K:
> +		return 128;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +/*
> + * A contiguous-hint group of the given size can only be usable if a single
> + * group's span fits within both the configured input (ias) and output (oas)
> + * address space - otherwise no aligned iova/paddr pair for a full group can
> + * ever exist, and advertising the size in pgsize_bitmap would let callers
> + * pick a mapping that unconditionally fails.
> + */
> +static bool arm_lpae_cont_size_fits(struct io_pgtable_cfg *cfg, unsigned long size)
> +{
> +	int size_bits = ilog2(size);
> +
> +	return size_bits <= cfg->ias && size_bits <= cfg->oas;
> +}
> +
> +static unsigned long arm_lpae_get_cont_sizes(struct io_pgtable_cfg *cfg)
> +{
> +	unsigned long pg_size, blk_size, l1_blk_size, cont_sizes = 0;
> +	unsigned long cont_leaf_size, cont_blk_size, cont_l1_blk_size;
> +	int pg_shift, bits_per_level;
> +
> +	if (!cfg->pgsize_bitmap || (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
> +		return 0;
> +
> +	pg_shift = __ffs(cfg->pgsize_bitmap);
> +	bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
> +	pg_size = 1UL << pg_shift;
> +	blk_size = pg_size << bits_per_level;
> +	l1_blk_size = blk_size << bits_per_level;
> +
> +	cont_leaf_size = arm_lpae_num_cont(pg_size) * pg_size;
> +	if ((cfg->pgsize_bitmap & pg_size) &&
> +	    arm_lpae_cont_size_fits(cfg, cont_leaf_size))
> +		cont_sizes |= cont_leaf_size;
> +
> +	if (cfg->pgsize_bitmap & blk_size) {
> +		cont_blk_size = arm_lpae_num_cont(blk_size) * blk_size;
> +		if (arm_lpae_cont_size_fits(cfg, cont_blk_size))
> +			cont_sizes |= cont_blk_size;
> +	}
> +
> +	/*
> +	 * Only add the level-1 contiguous block size if level-1 block mappings
> +	 * are supported for this granule. For 16K and 64K granules, level-1
> +	 * block mappings do not exist, so l1_blk_size would not be in
> +	 * pgsize_bitmap after arm_lpae_restrict_pgsizes() has filtered it.
> +	 * For 4K granule, 1G blocks are supported, giving a 16G contiguous group.
> +	 */
> +	if (cfg->pgsize_bitmap & l1_blk_size) {
> +		cont_l1_blk_size = arm_lpae_num_cont(l1_blk_size) * l1_blk_size;
> +		if (arm_lpae_cont_size_fits(cfg, cont_l1_blk_size))
> +			cont_sizes |= cont_l1_blk_size;
> +	}
> +
> +	return cont_sizes;
> +}
> +
> +/*
> + * Install num_entries leaf entries starting at ptep (index map_idx_start
> + * within the current table), scanning for aligned groups of arm_lpae_num_cont()
> + * consecutive entries that also have a naturally-aligned physical address and
> + * tagging only those with the contiguous hint. A group may be a strict
> + * sub-range of [map_idx_start, map_idx_start + num_entries) - e.g. when this
> + * call's index range isn't itself aligned to the group size, or when its
> + * paddr isn't - in which case the mismatched entries are installed without
> + * the hint instead.
> + */
> +static int arm_lpae_install_leaf(struct arm_lpae_io_pgtable *data,
> +				 unsigned long iova, phys_addr_t paddr,
> +				 arm_lpae_iopte prot, int lvl,
> +				 int map_idx_start, int num_entries, int num_cont,
> +				 arm_lpae_iopte *ptep, size_t *mapped)
> +{
> +	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	size_t cont_size = num_cont * block_size;
> +	int done = 0;
> +
> +	while (done < num_entries) {
> +		int idx = map_idx_start + done;
> +		int remaining = num_entries - done;
> +		int off = idx % num_cont;
> +		arm_lpae_iopte pte = prot;
> +		int chunk, ret;
> +
> +		if (off == 0 && remaining >= num_cont &&
> +		    IS_ALIGNED(paddr, cont_size)) {
> +			/* Fully aligned group: tag with the CONT hint */
> +			chunk = num_cont;

While looking at arm_lpae_install_leaf() again, I realized the per-num_cont-window loop does more arm_lpae_init_pte() calls than necessary.
Consecutive qualifying (or non-qualifying) windows can be merged into a single call. Planning to make below change in v4:

-             if (off == 0 && remaining >= num_cont &&
-                 IS_ALIGNED(paddr, cont_size)) {
-                     /* Fully aligned group: tag with the CONT hint */
-                     chunk = num_cont;
-                     pte |= ARM_LPAE_PTE_CONT;
-             } else if (off == 0) {
-                     /*
-                      * Aligned start, but too short or paddr doesn't
-                      * line up - install the rest of this window plain.
-                      */
-                     chunk = min_t(int, num_cont, remaining);
-             } else {
-                     /* Misaligned prefix: advance to the next boundary */
-                     chunk = min_t(int, num_cont - off, remaining);
-             }
+             if (off) {
+                     /* Misaligned prefix: advance to the next boundary */
+                     chunk = min_t(int, num_cont - off, remaining);
+             } else if (remaining >= num_cont && IS_ALIGNED(paddr, cont_size)) {
+                     /* Aligned: merge every full group in this run */
+                     chunk = remaining - remaining % num_cont;
+                     pte |= ARM_LPAE_PTE_CONT;
+             } else {
+                     chunk = remaining;
+             }

Thanks,
Vijay

> +			pte |= ARM_LPAE_PTE_CONT;
> +		} else if (off == 0) {
> +			/*
> +			 * Aligned start, but too short or paddr doesn't
> +			 * line up - install the rest of this window plain.
> +			 */
> +			chunk = min_t(int, num_cont, remaining);
> +		} else {
> +			/* Misaligned prefix: advance to the next boundary */
> +			chunk = min_t(int, num_cont - off, remaining);
> +		}
> +
> +		ret = arm_lpae_init_pte(data, iova, paddr, pte, lvl, chunk, ptep);
> +		if (ret)
> +			return ret;
> +
> +		*mapped += chunk * block_size;
> +		ptep += chunk;
> +		iova += chunk * block_size;
> +		paddr += chunk * block_size;
> +		done += chunk;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>  			  phys_addr_t paddr, size_t size, size_t pgcount,
>  			  arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
> @@ -462,21 +608,44 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>  	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>  	size_t tblsz = ARM_LPAE_GRANULE(data);
>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> -	int ret = 0, num_entries, max_entries, map_idx_start;
> +	bool cont_hint_enabled = !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT);
> +	int num_entries, max_entries, map_idx_start;
> +	int num_cont = cont_hint_enabled ? arm_lpae_num_cont(block_size) : 1;
> +	bool use_cont = cont_hint_enabled && num_cont > 1;
>  
>  	/* Find our entry at the current level */
>  	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
>  	ptep += map_idx_start;
>  
> +	/*
> +	 * Normalize an exact whole-CONT-group request down to the
> +	 * equivalent block_size/pgcount so it funnels through the same
> +	 * leaf path below - arm_lpae_install_leaf() independently decides,
> +	 * per sub-chunk, whether the CONT hint actually applies.
> +	 */
> +	if (use_cont && size == block_size * num_cont) {
> +		pgcount *= num_cont;
> +		size = block_size;
> +	}
> +
>  	/* If we can install a leaf entry at this level, then do so */
>  	if (size == block_size) {
> +		int ret;
> +
>  		max_entries = arm_lpae_max_entries(map_idx_start, data);
>  		num_entries = min_t(int, pgcount, max_entries);
> -		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
> -		if (!ret)
> -			*mapped += num_entries * size;
>  
> -		return ret;
> +		if (!use_cont) {
> +			ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl,
> +						num_entries, ptep);
> +			if (!ret)
> +				*mapped += num_entries * size;
> +			return ret;
> +		}
> +
> +		return arm_lpae_install_leaf(data, iova, paddr, prot, lvl,
> +					     map_idx_start, num_entries,
> +					     num_cont, ptep, mapped);
>  	}
>  
>  	/* We can't allocate tables at the final level */
> @@ -660,6 +829,8 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>  {
>  	arm_lpae_iopte pte;
>  	struct io_pgtable *iop = &data->iop;
> +	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	int num_cont = arm_lpae_num_cont(block_size);
>  	int i = 0, num_entries, max_entries, unmap_idx_start;
>  
>  	/* Something went horribly wrong and we ran out of page table */
> @@ -674,8 +845,20 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>  		return 0;
>  	}
>  
> +	/*
> +	 * Normalize an exact whole-CONT-group request down to the
> +	 * equivalent block_size/pgcount, mirroring __arm_lpae_map().
> +	 */
> +	if (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT) &&
> +	    num_cont > 1 && size == block_size * num_cont) {
> +		pgcount *= num_cont;
> +		size = block_size;
> +	}
> +
>  	/* If the size matches this level, we're in the right place */
> -	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> +	if (size == block_size) {
> +		size_t cont_size = num_cont * block_size;
> +
>  		max_entries = arm_lpae_max_entries(unmap_idx_start, data);
>  		num_entries = min_t(int, pgcount, max_entries);
>  
> @@ -687,6 +870,33 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>  				break;
>  			}
>  
> +			/*
> +			 * Splitting a real CONT group by unmapping a subset
> +			 * of it is not allowed - the group must always be
> +			 * invalidated as a unit. Detect this from the PTE's
> +			 * own CONT bit, not from the caller's size, since a
> +			 * legitimate unmap can span multiple prior iommu_map()
> +			 * calls and its size alone says nothing about how the
> +			 * underlying PTEs were grouped. Only the first and last
> +			 * entries of the unmapped range can possibly straddle a
> +			 * group boundary - every interior entry, if CONT-tagged,
> +			 * belongs to a group that is necessarily fully covered
> +			 * by this unmap, since contiguity means groups can't
> +			 * overlap without also covering everything between them.
> +			 */
> +			if (pte & ARM_LPAE_PTE_CONT) {
> +				bool ok = true;
> +
> +				if (i == 0)
> +					ok = ok && IS_ALIGNED(iova, cont_size);
> +				if (i == num_entries - 1)
> +					ok = ok && IS_ALIGNED(iova + (i + 1) * block_size,
> +							      cont_size);
> +
> +				if (WARN_ON_ONCE(!ok))
> +					return 0;
> +			}
> +
>  			if (!iopte_leaf(pte, lvl, iop->fmt)) {
>  				__arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
>  
> @@ -943,6 +1153,7 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>  	}
>  
>  	cfg->pgsize_bitmap &= page_sizes;
> +	cfg->pgsize_bitmap |= arm_lpae_get_cont_sizes(cfg);
>  	cfg->ias = min(cfg->ias, max_addr_bits);
>  	cfg->oas = min(cfg->oas, max_addr_bits);
>  }
> @@ -1001,7 +1212,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>  			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
>  			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
>  			    IO_PGTABLE_QUIRK_ARM_HD |
> -			    IO_PGTABLE_QUIRK_NO_WARN))
> +			    IO_PGTABLE_QUIRK_NO_WARN |
> +			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
>  		return NULL;
>  
>  	data = arm_lpae_alloc_pgtable(cfg);
> @@ -1103,7 +1315,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>  	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
>  
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
> -			    IO_PGTABLE_QUIRK_NO_WARN))
> +			    IO_PGTABLE_QUIRK_NO_WARN |
> +			    IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
>  		return NULL;
>  
>  	data = arm_lpae_alloc_pgtable(cfg);
> @@ -1224,6 +1437,8 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>  		return NULL;
>  
>  	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
> +	/* Mali LPAE has no CONT bit - never advertise CONT page sizes */
> +	cfg->quirks |= IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT;
>  
>  	data = arm_lpae_alloc_pgtable(cfg);
>  	if (!data)
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index e19872e37e067..7b2097aaffb09 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -86,6 +86,8 @@ struct io_pgtable_cfg {
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
>  	 * IO_PGTABLE_QUIRK_ARM_S2FWB: Use the FWB format for the MemAttrs bits
> +	 * IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT: Disable use of the contiguous
> +	 *	hint for hardware affected by implementation-specific errata.
>  	 *
>  	 * IO_PGTABLE_QUIRK_NO_WARN: Do not WARN_ON() on conflicting
>  	 *	mappings, but silently return -EEXISTS.  Normally an attempt
> @@ -103,6 +105,7 @@ struct io_pgtable_cfg {
>  	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
>  	#define IO_PGTABLE_QUIRK_ARM_S2FWB		BIT(8)
>  	#define IO_PGTABLE_QUIRK_NO_WARN		BIT(9)
> +	#define IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT	BIT(10)
>  	unsigned long			quirks;
>  	unsigned long			pgsize_bitmap;
>  	unsigned int			ias;
> 
> ---
> base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
> change-id: 20260618-iommu_contig_hint-71ae491fbb52
> 
> Best regards,
> --  
> Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> 

