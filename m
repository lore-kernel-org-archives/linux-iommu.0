Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971635CB6F
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687988; cv=none; b=gzwbnolY2maExgIcPJgfU5UcGlg+93V/2M/sjSifuTwzkf/M2A462ZTa5GUwmxtDZaJjElD6Z+Uogz4rJULcGYYzUMjeoQArUCkYKBIonfEnbUnivD9g4bo+ig+zt2Kn94gISSrIzssAXOAghc+ph2t1HGwPakQLx4m+wNH2yCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687988; c=relaxed/simple;
	bh=IS2UepS5Nuz0XmQH8QwJwNbe3A0qEhU/8jm6Uq2TkxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDHkW17B6JA+wHAy2V9gnimqt6tS9D2syoTo09RbuEU/DFlpKUSwwuqX1uTl4F2D+XLOgaFxahpBNvIQDHapcpJV/LrP57xDebfQ49VY1UBKlpGQnK/m3+fJjjaThihwIM3a3CTTSHgWFjQJIV2i7j2i58CM3kMDZjWxIv8Dn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fflAcvjt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VaPq2PDq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fflAcvjt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VaPq2PDq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4QXjD979808
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 06:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	764Phtwd3fK6Miua79lODWauqsKM+9dHxURkjgBLlsE=; b=fflAcvjtyGxUVYtg
	q2sL2Dt9qL2bxZcbrsbyLhxoViSKgBxP13EHdeBEtAuU+AVb3JFIMjxFeTEBLM7q
	g8WiOb/xMEGeFlxWQFEamR7Sy5RWzskN/jZEDnYHtkySLbrTznMdSZWJDIgEhzaM
	QLlQMVslaiYNYsgu3d4+ECmcr93LOPZTbdMHosM5rOSbUQUlmizXZAVMgwfDLGDS
	lFoYcPj97aa/VG5uIb6qm5qoJ7lEk3GAhZhCrpS8QS16Ly0NwCf4Ve27UM/6uzzC
	v9T3gWZSpcICqkSVKXCLbXv8LDR+eaXZGJKziLzEZGs1bqTIqGMJM6ZKKt9yL8Gp
	ffJ4ZQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1pea1ef5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 06:13:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so1420859a91.3
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786687984; x=1787292784; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=764Phtwd3fK6Miua79lODWauqsKM+9dHxURkjgBLlsE=;
        b=VaPq2PDqIbKjhP96jXtkuq5b/tSkyf9UN4QUlnGIBIhCEPr6CAYMF4YwFe0jz+Bz+Q
         Gd89j7ZJnzr/poLtJIF4T8HwJJjVMebMN8kL+FwvvFGwMpOiH5lr7wuK/1ddPrC1Ffd7
         ttCLTTxOGfpUbeCpHiXqbVkxRwNgSlfMaq5nltC10fR/jL3thr9iR9QkaPU6V51KogMJ
         MWV3vLHqUkuKmrsBBzo2iB7zQTI76GLuFGVCsWOXDOfBu2tlfadwINBqDNWzjVlW/Wu6
         35BYlt2N5pdqlYWgYHJiWMzkBwQ/aon2kzTRFNIGLwpoel/oxyXocCKNStRmQTLJacJn
         AKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786687984; x=1787292784;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=764Phtwd3fK6Miua79lODWauqsKM+9dHxURkjgBLlsE=;
        b=nT0/TEudGGmC40Ktl7AOnkdKg0+0sGH0vVtPFa8xRUuhalXqw3r/Y1kug+3h2WIXp9
         ACaL6yuBGerMWFS1it9Y+LJp1wenTLXkonWyj2q+aeJQCcCVI6J97rcqA2rkepsto8hP
         VJgFk8WFXHTyAg4XNOKHOoNhlnSLYei6Q3KHLIqESnNHPZRImPfpT6KiBoFPdccNfthh
         2iWlKE/B0ErG6kLtJ8ApNKfuv0/6QdXVc3Rsy48rIQzJ9o5TTsC7+zlO2q3h4Gx+pzIY
         XIFJ9Om0Ko2E49Bx5GK4lydFAsCJR3LICce1GmR552/UMrghsw9itfzuekLeVdWb26Fr
         RLxw==
X-Forwarded-Encrypted: i=1; AHgh+RqPH/h9UTIW4H9d1ToNHMByimn+6elGhZbGEjXznFBwzBfOTORc4hLSuTXsETofNIh+qoCq+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/WIDXY5RkjHet64tHvEUcjPsGR6qu/AUTg2wh+u0OYUV45GvL
	cYlETiFVPBTJwpeXNL8Aqmz8xLLOkQX2H5FVaAtG/ZDT0J9WaNVZ3ehTzMSFfFohbMNtDAX+9zE
	Sl5W+IPQAPhZIMFneln0kNGzRaT9o7j+AXP3AGtK0iJDf27f0N7GiwigJFQ==
X-Gm-Gg: AR+sD10vdnvlUEJDGkhCQzYV4NhbP9QuvXlvSp2PAlxW7koHHQ1AJHCnj+8PXOd4R/+
	ufNymcxcowQ0xJf0PZe96Kl+Lm09j/qgUkGdpAbCYDc8XfGK3KTXclp0WzSPomPcCTjQ+GuvZ0K
	IBoa//jPPkw/QgKH7Z0BCkks4Qd7YgK/0XYtha2wmuU2nRevBf6iCJZs9LtoVaJZSSlOBoeqj1E
	mA/5kvJfGxV0QKkrNGOmE8PgpcDcLGwS5ehIrimBLp6iPs5StnbV262sXQeNk1/sU3X011TtL9A
	9Ra+qGtCIfG+K3Sp2k1WY8mJHMHzgiJfb21ranTZBxE+/cAmJvnX5WhV/k29gfRwZfKpBHhy8/c
	Kaf+l7dG8SKf9TJ2OTAEvYcwSefSSjysnkg==
X-Received: by 2002:a17:90a:e7cd:b0:380:fead:448d with SMTP id 98e67ed59e1d1-3933b87224cmr3434207a91.13.1786687984277;
        Thu, 13 Aug 2026 23:13:04 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cd:b0:380:fead:448d with SMTP id 98e67ed59e1d1-3933b87224cmr3434146a91.13.1786687983643;
        Thu, 13 Aug 2026 23:13:03 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e921709dsm1167120a91.0.2026.08.13.23.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 23:13:03 -0700 (PDT)
Message-ID: <c84e61b1-785e-4a47-9082-c5111bf35fd4@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 11:42:31 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Daniel Mentz <danielmentz@google.com>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
 <CAE2F3rBQQEHsksOyE2ojQPbMd_vvFqaFMC2RzT0B6KkxMB5YgQ@mail.gmail.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <CAE2F3rBQQEHsksOyE2ojQPbMd_vvFqaFMC2RzT0B6KkxMB5YgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TbGmcxQh c=1 sm=1 tr=0 ts=6a7eb1f1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0oEs0c1nrpSZiC37xdsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: aiMraeWnynOFoGA2W7uwQ3CUEUltphyN
X-Proofpoint-ORIG-GUID: aiMraeWnynOFoGA2W7uwQ3CUEUltphyN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0NyBTYWx0ZWRfX1DpJFD0hxe1j
 0xgEiWgYgwYSjEDLh6k4zTECd7UiRaNdB7hJCplIaLGrt0t6WTRPxyyqAdxTn9UsV+2tfSFjMSQ
 +nCQmvhDcv9BQp0rTFBXhVjKFXbpqBDxJJhkLihQzODDpH2oAOQHA6s2/LiEFtEA/k7IMg+V/Yl
 Pn7pnKEuna0utovQUZj4GVixWQuhUTOLxNkDx9bMBKsBH58j/Dhz1PkFbV4JTxaljrN2nVD/l+G
 HWyLKx9rjGTv4Bi4RxPrtDkBzJT3N0q0AfNWlGy83Rsub8gVNz1zVsi6P3vcOQSWyad8yhIVsrU
 o9wjwhpS1ab6DP5oVUh+f4VYjmiK+/2KZOzUZHrehpKkf11b5cxovGpA9Jl/Gej1O2xK8BrN3lt
 PqH3CsewAAPB9zDApTRBaRgZJtGVQ8b0uNOSWVS0lD8z0s+7ckBXs3rv538bMHhbBQyirantn70
 jtOAE92JRDEi282AD2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0NyBTYWx0ZWRfX2ZTWXF3liP2H
 oKjd34toKfzGeC81aX65KYhrOzKJCi9p+8nzAmY0FltoebGGupeGxYz+F7KDI159RPKq00UB0o1
 xvQErig1H0ekgSQ1cE08lAmqMcVA/mM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140047



On 8/11/2026 10:34 AM, Daniel Mentz wrote:
> On Mon, Aug 3, 2026 at 11:19 PM Vijayanand Jitta
> <vijayanand.jitta@oss.qualcomm.com> wrote:
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 476c0e25631af..23a238de53ed5 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> [...]
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
> 
> bits_per_level is also calculated in arm_lpae_alloc_pgtable(). I'm
> wondering if we can somehow re-use that value, although, I do
> understand that data->bits_per_level is only populated later.
> 

For the same reason that you mentioned, I don't see we can reuse,
at this point we only have cfg, no data.
>> +       pg_size = 1UL << pg_shift;
> 
> In arm_lpae_restrict_pgsizes(), they call the same value "granule".
> Can we align with that and call it granule instead of pg_size?
> 

Sure, will rename it to granule.

>> +       blk_size = pg_size << bits_per_level;
> 
> I'm wondering if we can re-use the macro ARM_LPAE_BLOCK_SIZE. I do
> acknowledge, though, that this macro doesn't work in this context,
> because (d)->bits_per_level is still not populated.
> Also, for consistency, you might want to call this l2_blk_size.
> 

I don't see a easy way to reuse it, for same reason that you mentioned.
Sure, will rename it to l2_blk_size.

>> +       l1_blk_size = blk_size << bits_per_level;
>> +
>> +       cont_leaf_size = arm_lpae_num_cont(pg_size) * pg_size;
>> +       if ((cfg->pgsize_bitmap & pg_size) &&
> 
> Is (cfg->pgsize_bitmap & pg_size) ever false?
> 
> [...]
> 

You are right, it's always true. The !cfg->pgsize_bitmap check above
rules out the zero case. Will drop the redundant check and keep just
the arm_lpae_cont_size_fits() check.

>> +/*
>> + * Install num_entries leaf entries starting at ptep (index map_idx_start
>> + * within the current table), tagging arm_lpae_num_cont()-sized groups with
>> + * the contiguous hint where both idx and paddr are aligned to the group
>> + * size. Entries in a misaligned group are installed without the hint.
>> + *
>> + * idx and paddr both advance by block_size per entry, so their alignment
>> + * relative to the group size is invariant across a run of entries within
>> + * this call: once a group qualifies (or fails to), every later whole group
>> + * does too, up to num_entries. This merges each such run into a single
>> + * arm_lpae_init_pte() call instead of one call per group.
>> + */
> 
> Can you provide an example for when this function installs descriptors
> where the contiguous bit is only set on a subset of them. I would
> assume that the contiguous bit is either set for all descriptors or
> none of them.
> 

That assumption doesn't hold in general -- it's only true when the
map request happens to start and end on a cont_size boundary. For an
arbitrary map_pages() call it usually doesn't.

Example, 4K granule (num_cont = 16, cont_size = 64K),
iova = paddr = 0x1000, pgcount = 34:

   - idx 1..15  (off != 0, misaligned prefix):        installed plain
   - idx 16..31 (off == 0, paddr now 64K-aligned):     installed w/ CONT
   - idx 32..34 (off == 0, remaining < num_cont):      installed plain

One arm_lpae_install_leaf() call, three chunks, CONT set on only the
middle one. 

>> +static int arm_lpae_install_leaf(struct arm_lpae_io_pgtable *data,
>> +                                unsigned long iova, phys_addr_t paddr,
>> +                                arm_lpae_iopte prot, int lvl,
>> +                                int map_idx_start, int num_entries, int num_cont,
>> +                                arm_lpae_iopte *ptep, size_t *mapped)
>> +{
>> +       size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>> +       size_t cont_size = num_cont * block_size;
>> +       int done = 0;
>> +
>> +       while (done < num_entries) {
>> +               int idx = map_idx_start + done;
>> +               int remaining = num_entries - done;
>> +               int off = idx % num_cont;
>> +               arm_lpae_iopte pte = prot;
>> +               int chunk, ret;
>> +
>> +               if (off) {
>> +                       /* Misaligned prefix: advance to the next boundary */
>> +                       chunk = min_t(int, num_cont - off, remaining);
>> +               } else if (remaining >= num_cont && IS_ALIGNED(paddr, cont_size)) {
>> +                       /* Aligned: merge every full group in this run */
>> +                       chunk = remaining - remaining % num_cont;
>> +                       pte |= ARM_LPAE_PTE_CONT;
>> +               } else {
>> +                       /*
>> +                        * Aligned idx but paddr doesn't line up with cont_size,
>> +                        * or too short for a full group. That holds for the
>> +                        * rest of this call too, so install the remainder
>> +                        * plain in one go.
>> +                        */
>> +                       chunk = remaining;
>> +               }
>> +
>> +               ret = arm_lpae_init_pte(data, iova, paddr, pte, lvl, chunk, ptep);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               *mapped += chunk * block_size;
>> +               ptep += chunk;
>> +               iova += chunk * block_size;
>> +               paddr += chunk * block_size;
>> +               done += chunk;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>>                           phys_addr_t paddr, size_t size, size_t pgcount,
>>                           arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
>> @@ -462,21 +608,44 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>>         size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>         size_t tblsz = ARM_LPAE_GRANULE(data);
>>         struct io_pgtable_cfg *cfg = &data->iop.cfg;
>> -       int ret = 0, num_entries, max_entries, map_idx_start;
>> +       bool cont_hint_enabled = !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT);
>> +       int num_entries, max_entries, map_idx_start;
>> +       int num_cont = cont_hint_enabled ? arm_lpae_num_cont(block_size) : 1;
>> +       bool use_cont = cont_hint_enabled && num_cont > 1;
>>
>>         /* Find our entry at the current level */
>>         map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
>>         ptep += map_idx_start;
>>
>> +       /*
>> +        * Normalize an exact whole-CONT-group request down to the
>> +        * equivalent block_size/pgcount so it funnels through the same
>> +        * leaf path below. arm_lpae_install_leaf() independently decides,
>> +        * per sub-chunk, whether the CONT hint actually applies.
>> +        */
>> +       if (use_cont && size == block_size * num_cont) {
>> +               pgcount *= num_cont;
>> +               size = block_size;
> 
> This appears to me as if you're throwing away information about
> whether this mapping request is suitable for the contiguous bit, and
> then in arm_lpae_install_leaf(), you're trying to recover that
> information. Can't you just do "prot |=ARM_LPAE_PTE_CONT" here and
> then completely avoid the logic in arm_lpae_install_leaf?
>

That optimization only applies to the exact-whole-group case already
handled above (size == block_size * num_cont). A single map_pages()
call can also cover the general case shown above, where a misaligned
prefix/suffix surrounds one or more aligned groups within the same
call. Setting prot |= ARM_LPAE_PTE_CONT unconditionally here would
incorrectly tag those misaligned entries with the hint.

arm_lpae_install_leaf()'s off/remaining logic is what detects those
group boundaries per chunk, so I don't think we can drop it in favor
of always setting prot |= CONT at this call site. The size ==
block_size * num_cont check here is just a fast path for the common
whole-group case, avoiding a walk through install_leaf() for something
the caller has already told us.

Thanks,
Vijay

>> +       }
>> +
>>         /* If we can install a leaf entry at this level, then do so */
>>         if (size == block_size) {
>> +               int ret;
>> +
>>                 max_entries = arm_lpae_max_entries(map_idx_start, data);
>> -               num_entries = min_t(int, pgcount, max_entries);
>> -               ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
>> -               if (!ret)
>> -                       *mapped += num_entries * size;
>> +               num_entries = min_t(size_t, pgcount, max_entries);
>>
>> -               return ret;
>> +               if (!use_cont) {
>> +                       ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl,
>> +                                               num_entries, ptep);
>> +                       if (!ret)
>> +                               *mapped += num_entries * size;
>> +                       return ret;
>> +               }
>> +
>> +               return arm_lpae_install_leaf(data, iova, paddr, prot, lvl,
>> +                                            map_idx_start, num_entries,
>> +                                            num_cont, ptep, mapped);

