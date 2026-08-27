Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3C31354F
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810132; cv=none; b=Vul/cA+obcl8H1EuutMQEMbYufsEhd0FbnA3UKkPEGlvTwwpMt+/yDgN79jJqQ2YeSnngNOfG86Dd89DQFFDYjt860NdAveXW+QLJjwoZqwN+MfIM8ROiBixHB2yvWUkutFO4ogu5dkpMZr5mcFMzQDQMUFP3tgm4458EJEKhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810132; c=relaxed/simple;
	bh=hPMuyywoVecl8ax2KcK5SPpsS7pAlk7mB4FHSFpJk6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyzfrgoxKh61mIQUHShtJIQCzWZSAVWKTMn2prSWmOm8zlnPTLmshOOSsTTponGP5ShrQeKAWaNvql8w01mDPbZWBpysoWjPsicJpmnb+2dxnNM23H9Fbk4drUWpSTK6Wgk81YIGTgcKMe6K53oZoLrhy5p8z2VQ79lj+QGrc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cv1Q9mLx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JhpCqYFw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cv1Q9mLx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JhpCqYFw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3J0WD3875210
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 05:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9KwtqjdHygA+JfB7KLbWaNqlpDVgF/I0UutfMHntlA=; b=Cv1Q9mLxWzu4kkmi
	pojw3wJuTKcBQU5/brnmhfMjXRBQQ2UzSk0XLb5fzssGnUQzae/brdDrsb2S2Bix
	hBqOwlwd36CMbh5aV5SUjinaDLe8AxjXmDccvSUk1+sXvproKpqaxOSN7K4didVZ
	TrW5KNcsHenQWr2suhF5nLgMXI3PpOYhSjNpnwVfKC33S2TE0U3K9OCINcd2Ma0O
	JmtW5Vz+fSdBKVhWleTO4Ns7iwfXSGviWgF6PMaaspspdLaVSp+IW45k6QXeYcTi
	Y691rCLDaAviGRACwt6LslSFusMC90FMd/D7w5P1D2OX4HeLqOf8DYHBKrhuSNGV
	sDKkXQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5h7pe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 05:55:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396638f9a18so3415823a91.2
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 22:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787810129; x=1788414929; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9KwtqjdHygA+JfB7KLbWaNqlpDVgF/I0UutfMHntlA=;
        b=JhpCqYFwAmfvWJO9ZU/bdHgTaoPLXpVcMXIbzdUkcGPYtou2eu6Im+vsoF1R/XV1HK
         4lQdl7WO7ELF3+kE53esGh/9uR3qsaLT2WxyVelCiiGlqDvvHWzoG/91JjgFgi/aiBZu
         Snj2cyO5SSIMBe6ULe0Qtov6SgTT6EHz+IA2S4VGprksiS2H/iZS3tglzVt0n5aphDQe
         miq58830/yHRDqc5D9HgE01xcgjRq3Ph3sIe8EO7bnQDVBG/1164s9HzujwqkRpFZxL6
         nD8+RkX5KpNK9zn0iX+ooLIx3aV7ptsQXsX22ML6ZoPwP96q+R2k6EMHC1jZ4MUs1IOj
         w4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787810129; x=1788414929;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9KwtqjdHygA+JfB7KLbWaNqlpDVgF/I0UutfMHntlA=;
        b=ZLyhCLPa4oevWjJ14GbfyVML+GPSYnHU5i6pMWMQWGZD9BwOhV1d34GEhozE9/ND5P
         iOWiRORep0eToSBbZygFyiY0FCfc6PCr5be65gbnkqiuOFUD9bkdAnWNHD0GeLM6ZehZ
         QPtXOCJQ1j/jZUQQn7TQ1yxq6pZK/1r4zeKSWfbWCv56jSdF6uQmHv1Nt7BXEtD+IGxc
         aprcHdVuKDlXyAzbcRdzJ3iqbs8k2wkiMf9zGpVPAKoXm209m6kWoqw0j97nVt9O6Ll5
         gE0m0qCmxfedQ2/ltrMXH3H+sGDvHYfjFLM3ptU5zuAmpNdzmYHGSlSs98OVWyCTZT/1
         zakg==
X-Forwarded-Encrypted: i=1; AHgh+RoQ5br7EIAZncDJu+PMmsM1lOWr5TUA3PPiP8lwaUMZfw+k59TuGvDIOop/dSl9qAAWUQMiPA==@lists.linux.dev
X-Gm-Message-State: AFuF++lmvnisR8r0b0YCNA64N61l3GJtKkdjwGEj2MkTIHeWxzp1SFv0
	ehP/smJ8geRGjGQrnkwioZkOlpF7aS7iViKmnAt7tt0rOWKe4r0NdzGOs7RFNdIGrQrmFTvGgum
	+PJNNOJtAWZKND9Ebsg8JjrGIEO+KqiZuP4qyDuI4lQfAUPk449tvtHxLvg==
X-Gm-Gg: AR+sD119o4qg5ehNzPXS/o8G+lyYw920L0wmDh7W3R2u/1HuTDFMwWhEEin1C1j4WoL
	cKb6dtIa71CQ3zAd83MIStoKqVCO8bfylVvIlTy2LyLSkFIOVQyc7a9sYmM62fas+fAkwqzkmQt
	AJy7r5vWRZUErhVXDQShVr67be/964iVq3jjt1qS3+J5u+x9IfILcnTAi53pHTzbH8+DrndtTEX
	rjjZDy8hQFh0JBkdKwzQ1PRmPl7n2zgtTO8+8/LX6XhTffjp2cS4pM0f00NJhLXDXocSxQZbgb3
	1nSC22JdTVcqoa7vuZdMNrVeUWoH/gMd9Ouv9zJHQE2ied4azTLDrpPB6ynyOpQzJMHlpfBTULf
	EcVJGWrGb/rKyvJgO3/lrht/X+iRUC9WNqw==
X-Received: by 2002:a17:90b:586d:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-3966d491c45mr26906381a91.16.1787810129203;
        Wed, 26 Aug 2026 22:55:29 -0700 (PDT)
X-Received: by 2002:a17:90b:586d:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-3966d491c45mr26905985a91.16.1787810128348;
        Wed, 26 Aug 2026 22:55:28 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20036sm22588440c88.5.2026.08.26.22.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 22:55:27 -0700 (PDT)
Message-ID: <9c28300b-a17f-4324-b9d5-8fc800e4d794@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 11:24:16 +0530
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
Cc: Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
 <CAE2F3rBQQEHsksOyE2ojQPbMd_vvFqaFMC2RzT0B6KkxMB5YgQ@mail.gmail.com>
 <c84e61b1-785e-4a47-9082-c5111bf35fd4@oss.qualcomm.com>
 <CAE2F3rC80=ZpiHVtmRDU6f8g4AwV_RrJ-Zqr0Xi7zbUc0fsQog@mail.gmail.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <CAE2F3rC80=ZpiHVtmRDU6f8g4AwV_RrJ-Zqr0Xi7zbUc0fsQog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rq0NHm05x_eVvhdHD_uXG7HexEFgQNQs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0NyBTYWx0ZWRfX5aeMfShWOfhR
 bBMwegZ6Up21zm3cDfeY1dN/UTf7eyNCWtaKBn3/fqzK32MLXgk1sJ6xG7WymNBFFjipL8IydEb
 4ptq2w7Uljasnr4iNQyAWIwYye2w7wc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0NyBTYWx0ZWRfX5DmpETlXaf3R
 mCTX+2D3P/LRRWVvo6TtgiBKqxhsni66hMxDIN9U+J+Nv/Km0GiSDyAFuM0ErBWit6RpKoDNBiW
 G6incu4CgivLFX8duJ5TyedN6RH0NuRhtRZVMXWrZLXBqMoxt/hcM4F3s23NJxiw+P+TLJUxHOi
 SUvg3O/HgGPTfhQZUthY7zaPzKO04wf3jnF6TEk0UB+zN2nLrbZbk2ydAtD4oLg6KifTZOo9H3O
 xvtf3IaaVTscwmha2me0AIfFdHlAHFrNb6hWCtTTAXQRVzxvUtKXmITrgdzhPi8aWqlf8Xx8+Wt
 Z38Rtqe/mow9vWwcKJadoR/9L88lO2DII82Lvoahf0U5O7vOVhuGyrCHQN+rIlsc25r9joUNOoo
 +jUyygAz6R+boVRQoDl7b5uvO3HCOm7qqiXUE6fG84zWlpJz1txZsyqeHLxHIkF9iitvO6XHB0M
 nW+ipHyP6kVSVpid5XA==
X-Proofpoint-GUID: Rq0NHm05x_eVvhdHD_uXG7HexEFgQNQs
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8fd152 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=CZE9kkL2blzp5uFjx4sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270047



On 8/15/2026 2:15 AM, Daniel Mentz wrote:
> On Thu, Aug 13, 2026 at 11:13 PM Vijayanand Jitta
> <vijayanand.jitta@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 8/11/2026 10:34 AM, Daniel Mentz wrote:
>>> On Mon, Aug 3, 2026 at 11:19 PM Vijayanand Jitta
>>> <vijayanand.jitta@oss.qualcomm.com> wrote:
>>>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>>>> index 476c0e25631af..23a238de53ed5 100644
>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>> [...]
>>>> +static unsigned long arm_lpae_get_cont_sizes(struct io_pgtable_cfg *cfg)
> 
> I'm wondering if we need this function at all. I'm trying to
> understand that would happen if we advertise page sizes that cannot
> possibly be used given the constraints imposed by cfg->ias and
> cfg->oas.
> arm_lpae_read_and_clear_dirty() appears to check if the end of the
> iova range is out-of-bounds (WARN_ON((iova + size - 1) &
> ~(BIT(cfg->ias) - 1))), but function arm_lpae_map_pages() appears to
> not have such a check.
> 
> If we need to restrict the "cont sizes", we could consider Will's
> suggestion: Add all the sizes to cfg->pgsize_bitmap in
> arm_lpae_restrict_pgsizes, and then subsequently clamp it like so
> 
> cfg->pgsize_bitmap &= (BIT(cfg->ias) - 1))
> cfg->pgsize_bitmap &= (BIT(cfg->oas) - 1))
> 
> That would be shorter than the 39-line arm_lpae_get_cont_sizes function.
> 

Agree , I think both arm_lpae_get_cont_sizes and arm_lpae_cont_size_fits can
be removed.

Instead I'll add something like below to arm_lpae_restrict_pgsizes as suggested.

+ if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT)) {
+        unsigned long sizes = cfg->pgsize_bitmap;
+
+        while (sizes) {
+                unsigned long size = BIT(__ffs(sizes));
+
+                cfg->pgsize_bitmap |= arm_lpae_num_cont(size) * size;
+                sizes &= ~size;
+        }
+  }

  cfg->ias = min(cfg->ias, max_addr_bits);
  cfg->oas = min(cfg->oas, max_addr_bits);

+ cfg->pgsize_bitmap &= (BIT(cfg->ias) - 1);
+ cfg->pgsize_bitmap &= (BIT(cfg->oas) - 1);

>>>> +/*
>>>> + * Install num_entries leaf entries starting at ptep (index map_idx_start
>>>> + * within the current table), tagging arm_lpae_num_cont()-sized groups with
>>>> + * the contiguous hint where both idx and paddr are aligned to the group
>>>> + * size. Entries in a misaligned group are installed without the hint.
>>>> + *
>>>> + * idx and paddr both advance by block_size per entry, so their alignment
>>>> + * relative to the group size is invariant across a run of entries within
>>>> + * this call: once a group qualifies (or fails to), every later whole group
>>>> + * does too, up to num_entries. This merges each such run into a single
>>>> + * arm_lpae_init_pte() call instead of one call per group.
>>>> + */
>>>
>>> Can you provide an example for when this function installs descriptors
>>> where the contiguous bit is only set on a subset of them. I would
>>> assume that the contiguous bit is either set for all descriptors or
>>> none of them.
>>>
>>
>> That assumption doesn't hold in general -- it's only true when the
>> map request happens to start and end on a cont_size boundary. For an
>> arbitrary map_pages() call it usually doesn't.
> 
> I believe you won't see arbitrary map_pages() calls. I understand that
> these calls are exclusively coming from __iommu_map_domain_pgtbl()
> which uses iommu_pgsize() to determine optimal page sizes.
> 
>> Example, 4K granule (num_cont = 16, cont_size = 64K),
>> iova = paddr = 0x1000, pgcount = 34:
>>
>>    - idx 1..15  (off != 0, misaligned prefix):        installed plain
>>    - idx 16..31 (off == 0, paddr now 64K-aligned):     installed w/ CONT
>>    - idx 32..34 (off == 0, remaining < num_cont):      installed plain
> 
> In the example you provided, I expect that you'll receive three
> separate calls from __iommu_map_domain_pgtbl:
>  * idx 1..15 with pgsize 4KB
>  * one call with pgsize 64KB
>  * idx 32..34 with pgsize 4KB
> 
> If I took your argument further, I could argue that we'd also have to
> check if we can put down a block mapping if iova = paddr = 0x0 and
> pgcount = 512, but we're not doing that either.
> 
> Could you provide the input parameters to the iommu_map() call that
> resulted in the parameters you provided i.e. iova = paddr = 0x1000,
> pgcount = 34:
> 

You're right -- for the iommu_map()/__iommu_map_domain_pgtbl() path, iommu_pgsize()
already splits the request at the boundaries you describe before install_leaf() ever
sees it, so install_leaf() doesn't need to handle a mixed prefix/CONT-group/suffix
chunk for that caller.

That said, install_leaf() is shared by other callers that reach it through
ops->map_pages() directly, without going through iommu_pgsize(). panthor_vm_map_pages()
(drivers/gpu/drm/panthor/panthor_mmu.c) is one -- it allocates its io_pgtable_ops via
alloc_io_pgtable_ops(ARM_64_LPAE_S1, ...), same as any other LPAE consumer, but does its
own chunking with a local get_pgsize() that only ever returns SZ_4K or SZ_2M, with no
notion of the 64K/32M CONT boundaries. That can hand install_leaf() exactly the mixed
iova=paddr=0x1000, pgcount=34 shape in a single call (panfrost's map loop uses the same
get_pgsize() and hits the same case). So the prefix/aligned-group/suffix handling in
install_leaf() is still needed for that path.


>>
>> One arm_lpae_install_leaf() call, three chunks, CONT set on only the
>> middle one.
>>
>>>> +static int arm_lpae_install_leaf(struct arm_lpae_io_pgtable *data,
>>>> +                                unsigned long iova, phys_addr_t paddr,
>>>> +                                arm_lpae_iopte prot, int lvl,
>>>> +                                int map_idx_start, int num_entries, int num_cont,
>>>> +                                arm_lpae_iopte *ptep, size_t *mapped)
>>>> +{
>>>> +       size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>>> +       size_t cont_size = num_cont * block_size;
>>>> +       int done = 0;
>>>> +
>>>> +       while (done < num_entries) {
>>>> +               int idx = map_idx_start + done;
>>>> +               int remaining = num_entries - done;
>>>> +               int off = idx % num_cont;
>>>> +               arm_lpae_iopte pte = prot;
>>>> +               int chunk, ret;
>>>> +
>>>> +               if (off) {
>>>> +                       /* Misaligned prefix: advance to the next boundary */
>>>> +                       chunk = min_t(int, num_cont - off, remaining);
>>>> +               } else if (remaining >= num_cont && IS_ALIGNED(paddr, cont_size)) {
>>>> +                       /* Aligned: merge every full group in this run */
>>>> +                       chunk = remaining - remaining % num_cont;
>>>> +                       pte |= ARM_LPAE_PTE_CONT;
>>>> +               } else {
>>>> +                       /*
>>>> +                        * Aligned idx but paddr doesn't line up with cont_size,
>>>> +                        * or too short for a full group. That holds for the
>>>> +                        * rest of this call too, so install the remainder
>>>> +                        * plain in one go.
>>>> +                        */
>>>> +                       chunk = remaining;
>>>> +               }
>>>> +
>>>> +               ret = arm_lpae_init_pte(data, iova, paddr, pte, lvl, chunk, ptep);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +
>>>> +               *mapped += chunk * block_size;
>>>> +               ptep += chunk;
>>>> +               iova += chunk * block_size;
>>>> +               paddr += chunk * block_size;
>>>> +               done += chunk;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>  static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>>>>                           phys_addr_t paddr, size_t size, size_t pgcount,
>>>>                           arm_lpae_iopte prot, int lvl, arm_lpae_iopte *ptep,
>>>> @@ -462,21 +608,44 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>>>>         size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>>>         size_t tblsz = ARM_LPAE_GRANULE(data);
>>>>         struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>>> -       int ret = 0, num_entries, max_entries, map_idx_start;
>>>> +       bool cont_hint_enabled = !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT);
>>>> +       int num_entries, max_entries, map_idx_start;
>>>> +       int num_cont = cont_hint_enabled ? arm_lpae_num_cont(block_size) : 1;
>>>> +       bool use_cont = cont_hint_enabled && num_cont > 1;
>>>>
>>>>         /* Find our entry at the current level */
>>>>         map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
>>>>         ptep += map_idx_start;
>>>>
>>>> +       /*
>>>> +        * Normalize an exact whole-CONT-group request down to the
>>>> +        * equivalent block_size/pgcount so it funnels through the same
>>>> +        * leaf path below. arm_lpae_install_leaf() independently decides,
>>>> +        * per sub-chunk, whether the CONT hint actually applies.
>>>> +        */
>>>> +       if (use_cont && size == block_size * num_cont) {
>>>> +               pgcount *= num_cont;
>>>> +               size = block_size;
>>>
>>> This appears to me as if you're throwing away information about
>>> whether this mapping request is suitable for the contiguous bit, and
>>> then in arm_lpae_install_leaf(), you're trying to recover that
>>> information. Can't you just do "prot |=ARM_LPAE_PTE_CONT" here and
>>> then completely avoid the logic in arm_lpae_install_leaf?
>>>
>>
>> That optimization only applies to the exact-whole-group case already
>> handled above (size == block_size * num_cont). A single map_pages()
>> call can also cover the general case shown above, where a misaligned
>> prefix/suffix surrounds one or more aligned groups within the same
>> call. Setting prot |= ARM_LPAE_PTE_CONT unconditionally here would
>> incorrectly tag those misaligned entries with the hint.
> 
> Due to how __iommu_map_domain_pgtbl and iommu_pgsize operate, I don't
> expect to see the prefixes and suffixes that you are describing.
> Instead, I expect we'll see separate calls to __arm_lpae_map(): One
> for the prefix, one for the set of aligned groups and another one for
> the suffix.
> 

Agreed, Replied in above comment.

Thanks,
Vijay>>
>> arm_lpae_install_leaf()'s off/remaining logic is what detects those
>> group boundaries per chunk, so I don't think we can drop it in favor
>> of always setting prot |= CONT at this call site. The size ==
>> block_size * num_cont check here is just a fast path for the common
>> whole-group case, avoiding a walk through install_leaf() for something
>> the caller has already told us.
>>

