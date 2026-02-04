Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E13F076B
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213895; cv=none; b=b0KpXmRt9kU1m6hLbiOz2+VcXVP5ki/WiHMo3fd+s+mT6jp9BQBP/4nVY7rZO6bGJsMIUhHCyXROCu7V3YoNuN1OVYmwkyrmECF1i2OinzqAKjqFnrnBwRIJY0cYQjbNyk5jjaJZan7TAVOuGLCz+4yJn6fxtfC1u1KTCaBMqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213895; c=relaxed/simple;
	bh=RLBNkLX00/DVFN+jbfXa24RWsw0z6IhmuksSlVBTxqk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k8WKNgBG4HGXwcl59SC/nGwLBbCnJ5FBuTu0FlelTB5bPkjw7qch5fkDgWadH4ohVwfJr5EQzXkTbAhQh9yZhovLa/qgBbVO6TSUiw4O9gWn7Gv013syGg5N4cVlZMEJG895VsCZR5PxyItCpkCNHY1XW7im9ARYmODPsNo39n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pR28mkPE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UYtSnH2J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pR28mkPE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UYtSnH2J"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIVBU675078
	for <iommu@lists.linux.dev>; Wed, 4 Feb 2026 14:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8tqW5Hq/w4yBZGsIGjLboSs0fMRtytJGNyqGY+7pxA=; b=pR28mkPE79srk/r0
	tc+k6GtbMrLxlIlRm2yZU+MYOLtltcGdlGgs95wbtyRwq93lvppI1oCF39Z+Z/jo
	A+TBXTguc/QlUyHHrZkvdfuwxcaUlFwADeica30sLwKEUeIvhwITtioLAtSL/Mrn
	AAqGwC65mhxoFIl9VvrrjxRsEgAQCyn/wFHeVJbnKqK82Qfr6kG0Ox/sCYLr8rpJ
	Eu856/1h364OIn/TsmbYDu+nACPGTmtyQmNEa4FtYMYRVIRCeakzFY43GV7Ta1oD
	vgnCS2XInV2Eb15Ww+yzeKlIo0UdAzhWeP+yId3Q7mQuZ7AMZgpQ7yJI86YuDXWL
	+aYrxQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3h07mjfm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 14:04:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352e195f662so5847091a91.2
        for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 06:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770213893; x=1770818693; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g8tqW5Hq/w4yBZGsIGjLboSs0fMRtytJGNyqGY+7pxA=;
        b=UYtSnH2J39TiySf2NtfDgqN7+l2XEtBi+xhBWNvHFqyTwtffrYDLnoQ+l6Hb5FGmBz
         HLp2Q90Hf5WjRORw8qaLwlffa50vsY5HOSFWVcA42GSHr1hWInrSFnAUmt35fhDN9eg5
         oUdsgdoqxRDsdJBEvo+tAxYymzuSjdW1z1Cf3WAPD4+8AyMYlbrb1pbdhrpy2fi/liX0
         HDp8oWoXt2+SR4z6n6kMv/PkUhlsxhhHq9QxSO7mzY/F/wNevzfJckapIRcMDGNBTgKt
         YGmS3Ny4VvezGE7BOKwRw5zyd/CdFeXdfER7t5acryeh9xQVSweBvnCaqC1iue9ekZR4
         h4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770213893; x=1770818693;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8tqW5Hq/w4yBZGsIGjLboSs0fMRtytJGNyqGY+7pxA=;
        b=Uv5xmPN1gzdHtRWqesceUtKBi7OHVODu5SE7dT6X4EjujTa37+SPdDwxIWBYWL7Y3P
         as6i5xhEy9OrZyCX5Fq5BiD80DqKpWV8+71P2saMoeuS61HXAEvnXDKVeTEswdIumPAa
         Gnq7+CeB5zRzjMflCUll5N15UeX7h65fxkZyv6pLOWsPDai2/rB3Nym4SgcREAU+FieI
         RD6g0Ii8qUzPt/KGBzk1UpHmPig+FNTSM7Ns4SPgFsrNxtj3SocjMwMPw1rB4OqTJsCT
         nJl1vk5sUQrI75cG51xHlRqGeoRgkqSv2our3bYfUCMAXsbTj30JVrRRXir7FQWQzTZA
         SC2A==
X-Forwarded-Encrypted: i=1; AJvYcCWL+EO1FN9bd7rpqBQLzYTwjt1j4y1CDGCbp1vzVbHQu8NR+6hvlpESWYU0+5XNJH/FXRsrMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjKZxgc2lmHAQuyTcHf1xun8YO+Gz0m8LSeVDPKPy9nbC6iivK
	iEOJ1IWGuPAO3yGxImJgicrDVTF8TAnCq1vz60ZF3R0hgm6sHu7FBdcXSp7YDXTZJLYrxy1usTe
	k2O5DW1vUCrfiu9N+AkjIEXJ2ZcFoYe9F50WJhdnmwMICMU/zo3sM2sEUfw==
X-Gm-Gg: AZuq6aIOIe27p/Y3KQGJUolf9Fpw3fvT5puOLe4ovcgOIQSmhaBocoK7lpqw6mGgE15
	U1nWCGLu5FmRFWGTp2VAbf99c7Ysw2OZ/h/HRGEDtjLIHQh/ai+4K1ZJeQbivpfNiiS4AilSyug
	XWxBRc/jhITn6O+0e5SpeUnyN9DUTr3ExdV2Jwr+8BUl7HyiXF1igcjteKjcStgvVG772imaxiw
	nOp01JfAxBYMhrj7FqiSSUw7nLIK+3/CbqYdl6kmIqex6Qd+f3D6R4EDtUgSiU/wZrOF5763BCS
	vOcUQejG2XjEFPXmEtyTMo/8UShT2PFlUtgUORRbtgCWQbwrdV3SG6kXMJaHcxCVmXkALyC+YL3
	0dPxfh2J9C8KNGv1+Mtd4JQQEVHKzKgIOJ/avVfHs6rDu3F08nUk=
X-Received: by 2002:a17:90b:2e10:b0:343:87b1:285 with SMTP id 98e67ed59e1d1-354871a9119mr2601974a91.18.1770213892661;
        Wed, 04 Feb 2026 06:04:52 -0800 (PST)
X-Received: by 2002:a17:90b:2e10:b0:343:87b1:285 with SMTP id 98e67ed59e1d1-354871a9119mr2601622a91.18.1770213887347;
        Wed, 04 Feb 2026 06:04:47 -0800 (PST)
Received: from [10.217.216.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1b71cesm2524594b3a.19.2026.02.04.06.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 06:04:46 -0800 (PST)
Message-ID: <563080fc-e5b3-4ff3-9c27-74a167246544@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 19:34:42 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
From: Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nitin.rawat@oss.qualcomm.com, Leon Romanovsky <leon@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203052756.GA15839@lst.de>
 <79034c4c-ba06-4961-b41b-a43e5f5946af@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <79034c4c-ba06-4961-b41b-a43e5f5946af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEwNiBTYWx0ZWRfX5kFV2ckJScKL
 itPcwzVCHhgqc4pStnUjWMDkUckzDixelFr1HxDeyfy+rgF0PoTeJ3+PvMdczdlfK71YyXliexP
 iXK1xFgtO5wtQBpXTorvR65Fs+g6KFc7NLS+5uYP3PynWZYTU+Ksbspg9eufksJzefD6MRk0gP/
 iAPYkpno01t+cv5szAeZ3+CvtqyM+ofcwol4bi/1+jvJxVorRc9KIAuxfZiWaQfpPWAcUk2mIql
 5WoJl7VwAwv35r+7UAvB5tibCJDa7AZahc//qLCj3z3txYOdgpURuajTjso4kDbZ2dKYXnpq9Jg
 sDf3pdRkdY6s4nwrfSSDCYx/PFHI3Z9ll8StPfV9xXApjO92wmP5A7sjW0eH//15y6j2bg9dEUN
 firWxu0I/O3kfn0Uly7dMHPDO6LXJSZ8JjGUO6VfKe1RvYinCXpbBIBGOPU0ndLH6bHpuznuk0T
 BApv2LgN/XLcA92sJ7w==
X-Authority-Analysis: v=2.4 cv=CMknnBrD c=1 sm=1 tr=0 ts=69835205 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Gc0GUWPnaK2Fg8JTCy4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: lKHS1KvABAiXbtRw-5ziIXz6ENLKp6MZ
X-Proofpoint-GUID: lKHS1KvABAiXbtRw-5ziIXz6ENLKp6MZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040106



On 2/3/2026 7:35 PM, Pradeep Pragallapati wrote:
> 
> 
> On 2/3/2026 10:57 AM, Christoph Hellwig wrote:
>> On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
>>> In the case where this iteration caused dma_need_unmap() to toggle to
>>> true, this is the iteration that allocates the dma_vecs, and it
>>> initializes the first entry to this iter. But the next lines proceed to
>>> the save this iter in the next index, so it's doubly accounted for and
>>> will get unmapped twice in the completion.
>>
>> Yeah.
>>
>>> Also, if the allocation fails, we should set iter->status to
>>> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
>>> Otherwise, the caller will think the request is badly formed if you
>>> return false from here without setting iter->status.
>>>
>>> Here's my quick take. Boot tested with swiotlb enabled, but haven't
>>> tried to test the changing dma_need_unmap() scenario.
>>
>> Looks much better.  Cosmetic nits below.
>>
>> Pradeep, can you test this with your setup?
> Sure, testing has started, and I will share the findings soon.
> Also, I did not pick up the initialization of dma_vecs during testing.

I ran testing for over 20 hours and did not observe the issue on my 
setup. It appears to be helping.
> 
>>
>>> +    if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
>>> +        return nvme_pci_prp_save_mapping(iter, req);
>>
>>> +    if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev- 
>>> >dev))
>>> +        if (!nvme_pci_prp_save_mapping(iter, req))
>>> +            return iter->status;
>>
>> I'd move the dma_use_iova / dma_need_unmap checks into
>> nvme_pci_prp_save_mapping to simplify this a bit more.
>>
>>>       /*
>>>        * PRP1 always points to the start of the DMA transfers.
>>> @@ -1218,6 +1231,8 @@ static blk_status_t nvme_prep_rq(struct request 
>>> *req)
>>>       iod->nr_descriptors = 0;
>>>       iod->total_len = 0;
>>>       iod->meta_total_len = 0;
>>> +    iod->nr_dma_vecs = 0;
>>> +    iod->dma_vecs = NULL;
>>
>> I don't think we need the dma_vecs initialization here, as everything
>> is keyed off nr_dma_vecs.
> 

