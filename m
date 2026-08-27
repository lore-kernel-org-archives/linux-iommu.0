Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B633C9886
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819905; cv=none; b=od9wr958I7kI62Ei55W1k8GJ/5lRM1emhwAJqfrJ5vSdN8AIpSGnFm7GyNJ42MTCYSc68lJItyXYswGBOxRUzjGN04vh6ldwHrv+NHtlNE26ctwFG88VvxjL+krjPE/3w9iWbtdqyaPeY46g1Sg7OQZQC2O6h7AGFpvoahItI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819905; c=relaxed/simple;
	bh=XsHsr9qm73nNpkAc3jdOhekpim+WG116KKjk1ClGWgE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pOo/CBOUDsBh6wy52Sgzw5JPJtAEG8ymDhuwLnxmHnpeQjavWKW8kEbsSm3HHIOjD26LJcTvbT+PZpudb2twY+xh8Wvg1XBVv0a63pXcN1nkyl7uKpIua6IHe36BPRhRMO3HUrO7j2l6xa0qCkQSibU9md5mrKw5xWVNnA9VvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gf1YeRfG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jHfrA/Dv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gf1YeRfG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jHfrA/Dv"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R5l02143796
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	71q6qFkbUbAl2V56zYmUPUePGcmMBG2bx1YcmcaTAes=; b=gf1YeRfG0jMWjJvk
	A+oDzPUuH5WBz2seDRuTBu2O2cIwjWUZ0Rf2OTAZmWp/nwEucRDj2ASlkf9YJndd
	m61fwXt9K9twk2rCd5EG9R1gVAeNx8LP3S3A3PZxw1QiRAFVJLIXN5+hXX5iLE09
	yGJpRw9WPfnriuJ3zZUIDU7OJpi4Y8puOs2gKQmv2zMfIYdDg0//Hg3Puc0jojdj
	ONUk0WlMUW+waxBNtCLoSNv+UbSt7VuqiMydUJ0oQxgJQzFyGLGjvklRu+bf90g9
	+hQ4Oqqz45SmVapOj+ZZVDgAfcTbmDKTQz9RJbojp6uSD8IPRTsAjgcVuYQJ+rXl
	py/hUQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gab7t1g3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:38:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396901263b6so2290469a91.2
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787819902; x=1788424702; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=71q6qFkbUbAl2V56zYmUPUePGcmMBG2bx1YcmcaTAes=;
        b=jHfrA/DveScDnXuVCCfHB9T6jdL2N8z+vbp+Y0WsdMym5cAxmABDnZ+UDlbnt6blre
         ToTcIq/gdNRM+8TNWwBqSy4C1Q0bQd9k778wD7fFBXdu17qulg4e0rAkvOvshuQlkM5v
         DRJJULb/mTdLkJyNset2yUkCkRCU+w3kPMf9RvZoavXE/vfiIKjX0OjO+JCqifyhYw0X
         9Mj0Enq/gtWc+lLNEeK1iP+hObBujdWDr8Rq97wHtSn8KgflZhEke659aMJy+U/TNmjd
         g8QQ6Kn9QOeB9l//GzD8ADdOA0gB4th4M3dinEVsYzQxN4DaYEs0iL8RJC9HgTsc9Cq/
         NHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787819902; x=1788424702;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71q6qFkbUbAl2V56zYmUPUePGcmMBG2bx1YcmcaTAes=;
        b=rsujsE8bMAxdafT1jm7lKeCg8+YTRR9evtQSn0eikIu/jnashxTkd5tktXlphbW1zA
         vODgqT5c88Rb8bhp6jRaiphbTDrzvMtAtFKowP4nekkGoleHjUs3rTBI8MzaPZF3WMFJ
         RAXd6YaiAE5T44P29yv/Yl+4rKngIuXAmfRE/nTfNDAq7Nk+dU/loK2YKpDDdfgix3An
         Rvuniq46Xb2twrwDUZKg16FprDR0HlSg3Nm1r66ctpKoA5rnnZGiAkRS8qcJVIv6q3NO
         N36uVw/lVAjilzxIAstV1Wf6BC1135VS6WvJFc2Dy+XIZeO3IsXmPYtf5XZ1GDaDYREy
         cseg==
X-Forwarded-Encrypted: i=1; AHgh+RqmOTIYUMMt2E8mV+G/hxXvKvbGODHFs7d0AHCFwNorq1I3mw4zF+cKf69FaF2iKJZqAbZ7Gw==@lists.linux.dev
X-Gm-Message-State: AFuF++msr+ihvIRNLeOOEbnxj0NTh+D/5NI56FQ9ExUHOnhI75mdtVXq
	WTmnPxAi1GNeBfp9/efDcj+60aUa3IyWLKhx/mtKhXn4f/5i+UrphNpa0iutUlF5jEBtyvox031
	twoU323nW07dUvtaIK/CD21vAUMBTZkp7wQh3m0NO2SrnZbYOZAbPQNy+EA==
X-Gm-Gg: AR+sD10lpHkZU6gUH5Q/LDfSCO85InXQxZxWqTzBmBTFE08gez7JfyrrsTIXmOjY1zv
	ii1RQ9T64P4VvwjI3qa3GJai103Oq65zOzWc9135lkc5v+xMoAhe7E0J0Mm2gtbripbwsCLnFKU
	BzZNJRe5FX/n531WPKS/YBwV3e2z4LMv0k7woD2VXo8558PG+yBg1x9BAqv8+t6awEAoP57qSMr
	vHc1W/NZNJcz7/i9i+tIXb2qgDAGfCpQrMksKr8GMCHTWGpl4p5WBZfty5MXQ0VB2lt04IFfEwY
	EAJM85W0vI01yIxhmvU88Ax1A3pyB3u3/RABM3dAO6AZQGh5XhnFb+HCGtc54K2updyGREctdMT
	h3WLE+No0bdjDWy5ABFQsyAfd2S+dm7FDHw==
X-Received: by 2002:a17:90b:3890:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-3966d17865fmr25898132a91.2.1787819902434;
        Thu, 27 Aug 2026 01:38:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3890:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-3966d17865fmr25898042a91.2.1787819901946;
        Thu, 27 Aug 2026 01:38:21 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0d3d7fbsm1863422a91.3.2026.08.27.01.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:38:21 -0700 (PDT)
Message-ID: <071db604-0744-4a45-87ac-085a40cb5999@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 14:08:17 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
 <CAE2F3rB7zpPFfC376mP=god9HWRmKOaQUEgPVzKScxS12pZrvQ@mail.gmail.com>
 <8188c158-60ed-4d05-a26e-c127850520cb@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8188c158-60ed-4d05-a26e-c127850520cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X6Bi7mTe c=1 sm=1 tr=0 ts=6a8ff77f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=3AgxOFbAtmQaTp21eccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: VtvjT8ICl7MF2ih6bldCNW1EdDfyNJlI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfXyaUO5S90vR64
 sPbJ/Pi4//JmQfwfYL07PfkWmc1Opdy/kKs6cylEGkkUK53Mcm8JVWvAYcwa8PRSzm19vcWOTQp
 lQ4J0f1uh439fnOf+rapFVCnqZbf79Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX6EJ7orPuhHuc
 AGl/WH9fEY+pCSdzxGkH1M0RDgyOEYLaIKNvcCduCiH/e/+om1LHzT17cGt6y4cpQD+B+bmrrva
 mD7jezPR09aVsduo61AMM/TAYKSs9Of+NR6IgWabo6ltt659Y4LiBcjvF0K6Uannh9rNH92HtRB
 KnjpPKDAzkjMWfuIolr1c6IDvxr1G9w54bcBfJCYlmN2T6ckS3w3E313H7RvKwKYVjx7i+v3DOs
 gv+D4bXRTg/xgGk6r+pIlRCoE8VqKRwvwN9a9DgNpYIR+dWibJwobW8TS6BoMNbjVooatwFUQRa
 kUsPA/4BRH8Wu+ylVu5dDyoq76itkNMk2j/qzg9cG0j16IRCa0ZzlruIbgV3/AK48jnfOEso6f+
 I3Ow+OBlki/skAZT0lJAYJpB/Y7ZW8HRnbpPlPZkI9roB7ljTTouonAZ29vI1hRJAhDyJWjunyl
 3Vsr2ozTLBOkJKD5ECg==
X-Proofpoint-GUID: VtvjT8ICl7MF2ih6bldCNW1EdDfyNJlI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270070



On 8/27/2026 1:54 PM, Vijayanand Jitta wrote:
> 
> 
> On 8/15/2026 3:27 AM, Daniel Mentz wrote:
>> On Mon, Aug 3, 2026 at 11:19 PM Vijayanand Jitta
>> <vijayanand.jitta@oss.qualcomm.com> wrote:
>>> +static unsigned long arm_lpae_get_cont_sizes(struct io_pgtable_cfg *cfg)
>>> +{
>>> +       unsigned long pg_size, blk_size, l1_blk_size, cont_sizes = 0;
>>> +       unsigned long cont_leaf_size, cont_blk_size, cont_l1_blk_size;
>>> +       int pg_shift, bits_per_level;
>>> +
>>> +       if (!cfg->pgsize_bitmap || (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT))
>>> +               return 0;
>>> +
>>> +       pg_shift = __ffs(cfg->pgsize_bitmap);
>>> +       bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
>>> +       pg_size = 1UL << pg_shift;
>>> +       blk_size = pg_size << bits_per_level;
>>> +       l1_blk_size = blk_size << bits_per_level;
>>> +
>>> +       cont_leaf_size = arm_lpae_num_cont(pg_size) * pg_size;
>>> +       if ((cfg->pgsize_bitmap & pg_size) &&
>>> +           arm_lpae_cont_size_fits(cfg, cont_leaf_size))
>>> +               cont_sizes |= cont_leaf_size;
>>> +
>>> +       if (cfg->pgsize_bitmap & blk_size) {
>>> +               cont_blk_size = arm_lpae_num_cont(blk_size) * blk_size;
>>> +               if (arm_lpae_cont_size_fits(cfg, cont_blk_size))
>>> +                       cont_sizes |= cont_blk_size;
>>> +       }
>>> +
>>> +       /*
>>> +        * l1_blk_size is only set in pgsize_bitmap if level-1 blocks are
>>> +        * supported for this granule (not 16K/64K, per
>>> +        * arm_lpae_restrict_pgsizes()), so no extra gating is needed here.
>>> +        */
>>> +       if (cfg->pgsize_bitmap & l1_blk_size) {
>>> +               cont_l1_blk_size = arm_lpae_num_cont(l1_blk_size) * l1_blk_size;
>>
>> Our AI model is saying that this might overflow cont_l1_blk_size on 32
>> bit platforms i.e. 16 * 1G doesn't fit into a 32 bit type. It says
>> that cont_l1_blk_size will be truncated to 0, and
>> arm_lpae_cont_size_fits() then calls ilog2(0) which is undefined.
>>
> 
> Ack. With arm_lpae_cont_size_fits removed this won't be an issue anymore.
> 
>>> +               if (arm_lpae_cont_size_fits(cfg, cont_l1_blk_size))
>>> +                       cont_sizes |= cont_l1_blk_size;
>>> +       }
>>> +
>>> +       return cont_sizes;
>>> +}
>> [...]
>>> @@ -660,6 +829,8 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>  {
>>>         arm_lpae_iopte pte;
>>>         struct io_pgtable *iop = &data->iop;
>>> +       size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>> +       int num_cont = arm_lpae_num_cont(block_size);
>>>         int i = 0, num_entries, max_entries, unmap_idx_start;
>>>
>>>         /* Something went horribly wrong and we ran out of page table */
>>> @@ -674,10 +845,22 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>                 return 0;
>>>         }
>>>
>>> +       /*
>>> +        * Normalize an exact whole-CONT-group request down to the
>>> +        * equivalent block_size/pgcount, mirroring __arm_lpae_map().
>>> +        */
>>> +       if (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT) &&
>>> +           num_cont > 1 && size == block_size * num_cont) {
>>> +               pgcount *= num_cont;
>>> +               size = block_size;
>>> +       }
>>> +
>>>         /* If the size matches this level, we're in the right place */
>>> -       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>>> +       if (size == block_size) {
>>> +               size_t cont_size = num_cont * block_size;
>>> +
>>>                 max_entries = arm_lpae_max_entries(unmap_idx_start, data);
>>> -               num_entries = min_t(int, pgcount, max_entries);
>>> +               num_entries = min_t(size_t, pgcount, max_entries);
>>>
>>>                 /* Find and handle non-leaf entries */
>>
>> This comment is no longer accurate. The handling now extends beyond
>> non-leaf entries.
>>
> 
> Agreed, that comment is stale -- the loop now also validates CONT-group
> alignment on leaf entries (rejecting an unmap that would split a tagged
> group) before falling through to the non-leaf teardown. Will update it to
> something like:
> 
> /* Validate leaf entries and handle non-leaf entries */
> 
> 

You can ignore the above comment, after moving the checks to outside the loop
the earlier comment would stay accurate for the loop.

Thanks,
Vijay
>>>                 for (i = 0; i < num_entries; i++) {
>>> @@ -687,6 +870,40 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>                                 break;
>>>                         }
>>>
>>> +                       /*
>>> +                        * A real CONT group must always be invalidated as a
>>> +                        * unit, so reject an unmap that splits one. Check the
>>> +                        * PTE's own CONT bit rather than the caller's size,
>>> +                        * since a legitimate unmap can span multiple prior
>>> +                        * iommu_map() calls and its size alone doesn't say how
>>> +                        * the underlying PTEs were grouped. Only the first and
>>> +                        * last entries can straddle a group boundary; an
>>> +                        * interior CONT-tagged entry's group is necessarily
>>> +                        * fully covered by this unmap, since groups can't
>>> +                        * overlap without also covering everything between
>>> +                        * them.
>>> +                        */
>>> +                       if (pte & ARM_LPAE_PTE_CONT) {
>>> +                               bool ok = true;
>>> +
>>> +                               if (i == 0)
>>> +                                       ok = ok && IS_ALIGNED(iova, cont_size);
>>> +                               if (i == num_entries - 1)
>>> +                                       ok = ok && IS_ALIGNED(iova + (i + 1) * block_size,
>>> +                                                             cont_size);
>>> +
>>> +                               /*
>>> +                                * Stop short of this entry instead of returning
>>> +                                * 0: entries before i may already have had
>>> +                                * non-leaf sub-tables torn down above, so the
>>> +                                * caller needs the real unmapped count, and the
>>> +                                * loop exit below still clears/gathers entries
>>> +                                * [0, i) correctly.
>>> +                                */
>>> +                               if (WARN_ON_ONCE(!ok))
>>
>> Consider aligning with the following WARN_ONCE in the same function:
>>
>> WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed");
>>
> 
> Ack.
> 
>>> +                                       break;
>>
>> I think this behavior is inconsistent: when a problem is detected at
>> the beginning of the unmap range, you return without modifying the
>> table, whereas if it's detected at the end, the code proceeds with
>> unmapping and leaves the table misconfigured. Could these checks be
>> performed before entering the loop?
>>
> 
> Agreed, Will move both checks before the loop so a rejected unmap is always a
> full no-op, regardless of whether the violation is at the start or end of
> the range.
> 
> Thanks,
> Vijay
> 
>>> +                       }
>>> +
>>>                         if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>>                                 __arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
>>>
> 

