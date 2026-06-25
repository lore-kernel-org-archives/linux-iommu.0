Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CE265621
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366472; cv=none; b=pWiodgJNtkRPC4iB+TgfizmM4gOVTGSJ8Zu5rCQDcbkFoZIS89VuUNBOFj0iCrMNL14OL6ustJh6GPbqhzyiRgzyNOWTsm6MX7JdfSLda2dPA1N813iaIPT1QJdMw+8IjAvv6GNO5loMrpg+6UiRWhEL6V0le1j5V1lwouM1ReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366472; c=relaxed/simple;
	bh=9TaWxQHIK3+Vm6U0liSitnPiiXKLQ1md4Yaxeni3Bho=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EJ/6l2MH+VT14pNYFxxDw4uGwqKF1PpsdS615kDWCkDvG1pC1qTf0cG64yD3OjuHvthKid6rmN5NJLzg8pBcrc3Czi61+rRzJKu4r7ntLbNWTdakKE45oCO3U+Enx2v8y3ISxL6cHmUWWyW72WFRkvdRsoAuyneKVL1x2tztEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=knk/ccUx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pkm6UZN6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="knk/ccUx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pkm6UZN6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3dwev2260730
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 05:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M3I+DqW2/rPEMQxEB4Tut72vdKlbdYsutIbq0uGtNJE=; b=knk/ccUxuYUeuhqY
	pdLnzCEbOCPpAxWu3+BOFN6RC5NhBF7yiQbjorS3jGDvc6Iw74jH5SGVpDpXEHWN
	VfRuvUKqrGT/hOcQeR0Su3QkK55YFvxPGgBXUOk2qgJcrIEFwQEGvgYfn32VAQSK
	25Ck37sCRMHpaRWSoTbvYQBJkM2bePYYo8O4aWa8h6Gsfzu/s5cRaiSUWIH5itce
	bqC4u4l8wulKN69i7W4QoDXJO0OrDYyunytLkkrZ93yIIg187fhop3Mx5LBDxKQK
	q6QcvskHQsRHwoikLAUpXsLGVTsMDcy2lvOt5KnidoalAnxgR18i8GeK/zonCY2p
	q6uOYQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0aqpctg3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 05:47:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f3e4728so1367345b3a.2
        for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782366468; x=1782971268; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M3I+DqW2/rPEMQxEB4Tut72vdKlbdYsutIbq0uGtNJE=;
        b=Pkm6UZN60m5dPyqfqWilKkX4c5RBNi3Gq1N1PLqoPq4JQoNr+bgYwBqdLnhCscCqN+
         q0qabWH8ZImfODfoAb/PUEu/Wj7HEKS1Wwq8aXaNI4q9Vh5IybVKpVxgjsSPFCa3Z9Zn
         bC1cKKUeM7OXeOBM28SpyHkvHs5X0Vg4Rx2D4iAV9xHqMbO5xedueN1E9pDSfNHEV3Br
         vJJ1/I5m56DHspFJfTRihkl+ntGf4EUfZplpFvAKrLYq4U5TCJN86w0k4BnSD63gjVuN
         muEDNx0lIzF2bTc6s6q8oHPyF9rMkHbde8nmvIJMRBUhnhnZKJR+ou3g3ESpBM1XNckh
         88VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782366469; x=1782971269;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3I+DqW2/rPEMQxEB4Tut72vdKlbdYsutIbq0uGtNJE=;
        b=NKRUn/yGa/QWCU3yPOZjzbn/twRwaWxCldYTtpb5PTZ0buE/xH/ITWp/KtYjuHMYTO
         naqCK81pEb7JgEc9Ml2Kh8YOer3DzJ1unfpQRG7MjCqO2fPMwHY7xCJNdiZsV3xs299E
         rG0nhkKZ8Q8Ncyxpv8Oan/l+33mCVaRwESm5IhWPFF1rtdFNWHsSzMoX+bpTk9VjU1dR
         Pr0WGSOb8aQz3Tq8xLVcwWEiKZTLMld9Yvdi+k9y8sBOe+k2qxyDcbQVP1CaG5Tq2TSm
         TNM+S03PCcZGhRNZW6agOBQGnZqdLk2en535ZD3IPgGFzGzC15B6EqUPhxllovTA7Ryt
         qIiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Or0FgTXhUjOwKrLlWRaJ+dQiEkMK8EET/riALTD9553qqxgPmixtd1EV1KTZfluHtoxZ0vA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy+5N6I8H0Ipu5LJp75hWxa7En/14wB82g86L2iqvs2g+n+vy8
	QHjmRCzb3qmw4HD5Wf/WZcBQzIJ6yEC3TMAZaHSYc8AoGXhYCmjwXvg2fjsJ0+c0fA4lAIsuuiI
	Kpun0IYcXkQcJAffUEhHZGirDrAez23vq1s6L3a5KGvTz6VjPQlKMRIbCEg==
X-Gm-Gg: AfdE7cmRq38i8IQ/HFvZRwMA2QnXsG/PmuAQuosZixdy4VFGTrjLQH8yDn95qVN6p7b
	uIdpdQT7JSOySI6ZgTi8xEVitkpq5DgO9evykc5O+dgx11xA2m7VivfukTFYnWxJ62cBNW0h3A+
	k8oZV+GQg4NJtttUsnUcshMPzUfz6SExdQjua2JGbb8DNcBIcq2x9O9Um9MmL/ud57QiSRLN1H6
	B/bx2VcZ3d3UvEb/HXzybFICLHVK8A0OBSV+bde9+uvYDLOxa/7EzEefDB5ar9MQuVOm1RcYXnM
	l9H4rbygO9K5CA0Z3Jc2tNd4tQC5KZi/LMDqrVDkG9/Pa7HGowKo4iODGbBSGkfIjo+ORSyANe7
	OLV5u2AkW/vy/loHMixNkdJzMjog2F8hn63DCQ/t6tF+f
X-Received: by 2002:a05:6a00:f8b:b0:842:7f81:8079 with SMTP id d2e1a72fcca58-845b3ae1ac6mr1470949b3a.37.1782366468451;
        Wed, 24 Jun 2026 22:47:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:f8b:b0:842:7f81:8079 with SMTP id d2e1a72fcca58-845b3ae1ac6mr1470925b3a.37.1782366467845;
        Wed, 24 Jun 2026 22:47:47 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fcc82dsm4343164b3a.7.2026.06.24.22.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 22:47:47 -0700 (PDT)
Message-ID: <9b5b8feb-da05-4381-93dc-c11e135fff10@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 11:17:21 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Daniel Mentz <danielmentz@google.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
 <CAE2F3rABU2_d+e+NuFJ3ngDCEnGuVCsmE612V9RAKmyAX-R9Mw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE2F3rABU2_d+e+NuFJ3ngDCEnGuVCsmE612V9RAKmyAX-R9Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2Mai7EIBbA-OspXPwaQCUK03UpeF8IaB
X-Proofpoint-GUID: 2Mai7EIBbA-OspXPwaQCUK03UpeF8IaB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0NyBTYWx0ZWRfX1EYqYzbbQTaC
 bVqg6fn5UDVS8o/GHoGf5STlm2dGWvJe6id70UBd5YqNDg3Qb+wQfcPZHzH5Pc1TDkiWZCrTVl/
 10qdPQbznOCD5SVsezzi444pB9f4+5TLucyz5sHyTccjzwNfJ8JoVfAteP+IPT+CoPd9sEBEwIK
 olygV9JLvZpsFQBasFzD3B5nI5z0nz86MQSLhiDBqBRIll336JujxhiVZo94aKlpyFvkEXNbVN5
 EH8G78iMIdAimz1lqM0J0PYq2Y/+q10Qr6VEKh7rzblHsYgFbg3H+hjDvtGCOQF6zllqdg1cJ+P
 RS18OAGFAIpJmYObTmG8Gqrma0hE7dMnAmjQ7Qae6xhHWF20E4qBaPeSMPee78yXxlF/YXyx3vw
 67TgBmmebEk7yfPYwsH8BFZ+fsxHYz0ooxMSHgQ6HmX9PO5rYeGfqsytFX1+J24JzDUnQnr1bz8
 1tCs8n8ENhPXFOy0FkA==
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=6a3cc105 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=2pZLd1I5B0H_JK-GwgIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0NyBTYWx0ZWRfX65JAn+V1wFOD
 WQd8mB4954kQTh8ISiy4cRNCAP3IpL3NPxc0qgRi99CTnt33p6/4IBUqJX1fn2FS4BArYbgjsU/
 YNgvQZ7FcGLHqQGYvqDiDzMTaYX0DQ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250047



On 6/20/2026 1:10 AM, Daniel Mentz wrote:
> On Thu, Jun 18, 2026 at 2:06 AM Vijayanand Jitta
> <vijayanand.jitta@oss.qualcomm.com> wrote:
>> Support is gated behind CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT, which
>> provides a compile-time opt-out for hardware affected by SMMU errata
>> related to the contiguous bit.
> 
> Have you considered making this a runtime option? Compare this with
> arm_smmu_device_iidr_probe() where the smmuv3 driver disables certain
> features based on the identified implementation and the errata
> affecting that implementation.
> 

Thanks for the review comments.

Good point. I’ll drop the Kconfig switch and make this runtime-controlled
via an io-pgtable quirk, so SMMU drivers can disable CONT based on errata.

>> On the mapping side, __arm_lpae_map() detects when the requested size
>> matches a contiguous range at the next level, sets the CONT bit on all
>> PTEs in the group, then recurses with the base block size and an
>> adjusted pgcount.
> 
> I would perform this check at the current level not the previous
> level. See comments below.
> 

Sure, will update this check at current level.

>>
>> On the unmapping side, the CONT bit is cleared from all PTEs in the
>> affected contiguous group before any individual entry is invalidated,
>> following the Break-Before-Make requirement of the architecture.
> 
> My understanding is that for unmap operations, the following rule applies:
> 
> The IOVA range targeted by an unmap operation must exactly match the
> IOVA range of a previous map operation. Partial unmap operations are
> not allowed.
> 
> The iopgtable code previously had a function named
> arm_lpae_split_blk_unmap() which allowed a block mapping to be split
> up. However, that function has since been removed, which aligns with
> prohibiting partial unmaps.
> The other concern I have is a potential race condition: While one
> thread clears the contiguous bit, another thread could try to unmap
> the same descriptor.
> 
> Consider dropping support for partial unmap and just triggering a
> WARN_ON() if you detect that a contiguous group is partially unmapped.
> 

Sure, will drop partial unmap support and  I'll update with WARN_ON()
as suggested.

>> +static inline int arm_lpae_cont_pmds(unsigned long size)
> 
> PMD is not a term that is used in this file. I advise against
> introducing this term.
> 

Agreed, I’ll avoid PMD terminology here and rename those helpers/comments
to use block-level wording.

>> +static u32 arm_lpae_find_num_cont(struct arm_lpae_io_pgtable *data, int lvl)
>> +{
>> +       if (lvl == ARM_LPAE_MAX_LEVELS - 2)
>> +               return arm_lpae_cont_pmds(ARM_LPAE_BLOCK_SIZE(lvl, data));
>> +       else if (lvl == ARM_LPAE_MAX_LEVELS - 1)
>> +               return arm_lpae_cont_ptes(ARM_LPAE_BLOCK_SIZE(lvl, data));
> 
> Consider supporting the contiguous bit at lookup level 1.
> 

Sure.

>>  static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>>                           phys_addr_t paddr, size_t size, size_t pgcount,
>>                           arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
>> @@ -463,6 +583,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>>         size_t tblsz = ARM_LPAE_GRANULE(data);
>>         struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>         int ret = 0, num_entries, max_entries, map_idx_start;
>> +       u32 num_cont = 1;
>>
>>         /* Find our entry at the current level */
>>         map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
>> @@ -505,6 +626,24 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>>                 return -EEXIST;
>>         }
>>
>> +       if (arm_lpae_pte_is_contiguous_range(data, size, lvl + 1, &num_cont)) {
> 
> I would recommend performing this check at the actual level not at the
> previous lookup level i.e. not at the (lvl - 1) level. Imagine the
> following situation: The granule size is 4KB, the initial lookup level
> is 2, and size is 32MB. I'm wondering if in that case, it'll just keep
> recursing until it hits (WARN_ON(lvl >= ARM_LPAE_MAX_LEVELS - 1)).
> 

Right, I see your point. The contiguous-size check should be done against the
current level, I’ll fix that in v2.

>> +#ifdef CONFIG_IOMMU_IO_PGTABLE_CONTIG_HINT
>> +static void arm_lpae_cont_clear(struct arm_lpae_io_pgtable *data,
>> +                               unsigned long iova, int lvl,
>> +                               arm_lpae_iopte *ptep, size_t num_entries)
>> +{
>> +       struct io_pgtable_cfg *cfg = &data->iop.cfg;
>> +       u32 num_cont = arm_lpae_find_num_cont(data, lvl);
>> +       arm_lpae_iopte *cont_ptep;
>> +       arm_lpae_iopte *cont_ptep_start;
>> +       unsigned long cont_iova;
>> +       int offset, itr;
>> +
>> +       cont_ptep = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>> +       cont_iova = round_down(iova,
>> +                              ARM_LPAE_BLOCK_SIZE(lvl, data) * num_cont);
> 
> As a result of this round_down() function, you are accessing a
> descriptor that describes an IOVA outside the range targeted by the
> iommu_unmap call. Consequently, you might race against another thread
> accessing the same descriptor.
> 

Agreed. I’m going to drop partial-unmap handling for contiguous groups,
so we will only operate on an exact aligned contiguous range and
reject partial unmaps with WARN_ON(). That also removes the need for
the current round_down()-based logic.

>> +       cont_ptep += ARM_LPAE_LVL_IDX(cont_iova, lvl, data);
>> +       cont_ptep_start = cont_ptep;
>> +
>> +       /*
>> +        * iova may not be aligned to the contiguous group boundary; include
>> +        * any leading entries so round_up() covers all overlapping groups.
>> +        */
>> +       offset = ARM_LPAE_LVL_IDX(iova, lvl, data) -
>> +                ARM_LPAE_LVL_IDX(cont_iova, lvl, data);
>> +       num_entries = round_up(offset + num_entries, num_cont);
>> +
>> +       for (itr = 0; itr < num_entries; itr++) {
>> +               WRITE_ONCE(*cont_ptep, READ_ONCE(*cont_ptep) & ~ARM_LPAE_PTE_CONT);
> 
> This read-modify-write operation is not safe due to the potential race
> described above.
> 

With partial unmap support removed, I suppose this should be fine now.

>> +               cont_ptep++;
>> +       }
>> +
>> +       if (!cfg->coherent_walk)
>> +               __arm_lpae_sync_pte(cont_ptep_start, num_entries, cfg);
>> +}
>> +#else
>> +static void arm_lpae_cont_clear(struct arm_lpae_io_pgtable *data,
>> +                               unsigned long iova, int lvl,
>> +                               arm_lpae_iopte *ptep, size_t num_entries)
>> +{
>> +}
>> +#endif
>> +
>>  static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>                                struct iommu_iotlb_gather *gather,
>>                                unsigned long iova, size_t size, size_t pgcount,
>> @@ -660,7 +841,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>  {
>>         arm_lpae_iopte pte;
>>         struct io_pgtable *iop = &data->iop;
>> -       int i = 0, num_entries, max_entries, unmap_idx_start;
>> +       int i = 0, num_cont = 1, num_entries, max_entries, unmap_idx_start;
>>
>>         /* Something went horribly wrong and we ran out of page table */
>>         if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>> @@ -675,9 +856,15 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>         }
>>
>>         /* If the size matches this level, we're in the right place */
>> -       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>> +       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data) ||
>> +           (size == arm_lpae_find_num_cont(data, lvl) *
>> +                    ARM_LPAE_BLOCK_SIZE(lvl, data))) {
>> +               size_t pte_size;
>> +
>>                 max_entries = arm_lpae_max_entries(unmap_idx_start, data);
>> -               num_entries = min_t(int, pgcount, max_entries);
>> +               num_cont = arm_lpae_check_num_cont(data, size, lvl);
>> +               num_entries = min_t(int, num_cont * pgcount, max_entries);
>> +               pte_size = size / num_cont;
>>
>>                 /* Find and handle non-leaf entries */
>>                 for (i = 0; i < num_entries; i++) {
>> @@ -687,11 +874,27 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>                                 break;
>>                         }
>>
>> +                       /*
>> +                        * Break-Before-Make: before invalidating any leaf
>> +                        * entry, clear the CONT bit from every entry in the
>> +                        * contiguous group(s) and flush the TLB, as required
>> +                        * by the architecture.  arm_lpae_cont_clear() covers
>> +                        * the full [iova, iova + num_entries * pte_size) range
>> +                        * via round_up(), so subsequent entries read back
>> +                        * CONT=0 and skip this block.
>> +                        */
>> +                       if (pte & ARM_LPAE_PTE_CONT) {
>> +                               arm_lpae_cont_clear(data, iova, lvl, ptep, num_entries);
>> +                               io_pgtable_tlb_flush_walk(iop, iova,
>> +                                                         num_entries * pte_size,
>> +                                                         ARM_LPAE_GRANULE(data));
> 
> I believe this is inefficient. Consider the case where we unmap 2MB
> worth of IOVA space mapped by 512 4KB page descriptors with the
> contiguous bit set. If I'm not mistaken, you're running CMOs
> (__arm_lpae_sync_pte) twice for every page descriptor. In addition,
> io_pgtable_tlb_flush_walk() will submit an extra CMD_SYNC and wait for
> it's completion.
> 
> Additionally, you perform rounding in arm_lpae_cont_clear(). However,
> io_pgtable_tlb_flush_walk() is called on the original, potentially
> unaligned range. Can this lead to under invalidation? Again, my
> preference would be to drop support for partial unmaps which would
> also remove the requirement for calling io_pgtable_tlb_flush_walk()
> here.
> 

Agreed. The current unmap path is more complex and expensive than necessary.
Since partial unmap of contiguous groups should not be supported, I will remove
the rounding-based handling and only permit unmaps that exactly match an
aligned contiguous group. That also eliminates the need for the 
extra io_pgtable_tlb_flush_walk() here.

Thanks,
Vijay

>> +                       }
>> +
>>                         if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>                                 __arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
>>
>>                                 /* Also flush any partial walks */
>> -                               io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
>> +                               io_pgtable_tlb_flush_walk(iop, iova + i * pte_size, pte_size,
>>                                                           ARM_LPAE_GRANULE(data));
>>                                 __arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
>>                         }

