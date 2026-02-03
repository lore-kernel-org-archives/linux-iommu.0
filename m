Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2003A1CEA
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127551; cv=none; b=abVAigGIHmCWfsOqirPvu4W6cqI11IBhnbz7Obf/14VZc5u2AFeUR9jbuu7EFGOYVFQPVCBDv7/6rV5CJTHQwjWX1T/gvmYjuw6/r1RGQE6n95olVjf4POatRmXLuUtGGFowtPCuEe4eaC9IJKQTh+sV9ODgM0JxfY5IQ7DkCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127551; c=relaxed/simple;
	bh=AdnbG1mSoEYvcYhYnToyL1f8w2uVIotRM/DCTsC88Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuDzKMlzC7X2g4GCNrRXFpx9jxHe/c/5N7cxfSLi3JtmNMyiPApN6/F8HtA5fA4z4GNThwAly4DJJ4KgnSf4uL0aiK9p/iRWj/ar4mFTBxNkpW/DuB5cSPMiIGWr1Qv8Z1TaheN59Mk+G+ofgHkKjd2StbjZCOZUa02JDWaQb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJYFjyZZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jY8FaSUH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJYFjyZZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jY8FaSUH"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613CABwT1191821
	for <iommu@lists.linux.dev>; Tue, 3 Feb 2026 14:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bEL43MhGa4sMuZXohHqUo8HZ6KYOBL8kkEKhb9cT3hs=; b=gJYFjyZZAYvlqt3l
	sDDpBNvz8JZKEzjcS+WwCZ7uyeUjRFC49dXPysrJw/IHCxRiz6FC4ymZYEl01/p1
	icS+ta3L+ajJ0sz4x0WornJOdSC5EPM7voHsfYJOPSwMZKqZnE9UyC9d5gt1O/bv
	O07DTn/VDydsi/jCkmNVnY7AGvHwcAMOIUEA/TfKAGrNbw4OzjbR/LP0aA2yww2U
	pDFUT6Sc9HHpIYxCZ/zBh0mABti19bQ3L4iKTc/nv1ssJxCciBAG08rA5xPFmjox
	hTQmkX3FxAYYuUpmCyManYay62ZoEeHmoLx5uGeVXGlc3RMYU1NANVEdUm7qr4vA
	lEFsMw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3gsr0a10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:05:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a92a3f5de9so3492585ad.2
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 06:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770127548; x=1770732348; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEL43MhGa4sMuZXohHqUo8HZ6KYOBL8kkEKhb9cT3hs=;
        b=jY8FaSUH3Gs5gLeZPmscPQwNHy7+w0UJgHcHY4NxDaMN2Lr1dMkgWVjF5ycRl3ea2S
         nWRtCQ9hPQ5dyAAnoS8e7n+4Y8BkBVXTui2dRNKB5RextD+S/xGLpaEA/LrWy4xI56Gn
         4fTiL3KjynNENneKgPUDa/pH8DAIq019+LU7FP1FnV2qqtQOzQcxPu93N/Wfgm4k0nyL
         XYXT/F2IoVzgZOq/bfxJcjF7OFgU7ZcMXT0EgW/eDChYDOFLJL5u1OCMrIP4cdiqvRyZ
         sf+XEAL4pW2EAENiUWHROTz+cFwAm8Di3ZKo2t8bKx3nufQ3hMufkwbZGomQZWnOCr5o
         69Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770127548; x=1770732348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEL43MhGa4sMuZXohHqUo8HZ6KYOBL8kkEKhb9cT3hs=;
        b=WuJhbeRoRf4W8DUUs+ee/jFTtQGn5vMIlNPB83tDODZ9sQ5B/oQEAntlf4A3E4aokK
         crBIpZCed1iHigS4OpMczItZX3Yjx+BWdhHJT+GDFhvLWjd7sqy4ZhugZ+bszp+9AAQX
         bSXO1Di2fQscmfXebJX5QI0yaqmSeIbxrsTKVLzoNc3wDY/s/6BgAr6XxzmG9hX3YeYX
         F7WWKiVvNskjEsGWGu9dACs0HzBqxPenY6qfIHL0Hk7u49Hla6jFvUAvqm2F5XlU2/br
         jZaTGeSCJcFKJjR50hpHSOhIeuuWF/1f0yVxBeg7P4166wd/sa/Q+aMt+Kue05qm5y9Z
         0VRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwm77YqEV5HqCb45+kBY4VI6KqZ0CFNTOLGP/DECBXSm2vk3Nzn6ykNqyAzQL3Aoenl2PjIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTZu/cZnjBjgSfYTPc225sjMM/2BoFMakifgk8/b40ukYxbzdp
	11WSBqvXwD8zEiX3LlnmyY97yD2wmIHdJE803+c9cQ1YH+3G1aN1K3ZVmJO1uS1LehC78pHgGc2
	GTyOOqGOQN/FaIebMj54/g2nDwqY1glSd0aY2Dc6UFQjybBjpj7MmfFgvbg==
X-Gm-Gg: AZuq6aLAf63w8TSRQr++mbrX2i45HxSf5Lq4/ESuj5nWIKv5GH+lAR2U/LclG8zGddS
	r6kAY2laSA9jt6+pvVg6aNN2Gd31/ImQpkFRiNilwJ8gWQz/frjufZhF2U/PklL9ywZf6iZrjHn
	SisgS2/kc9JehU+d281m/Tue705ouSevuVPkxFZtC50w9zAG3y11u+6tHgW3RmWigq94xHizC/m
	XQy+xm5/qDeIoN09U2kLZeH3DQQjSy7eesmgiDJHHnEpwKk7tYDZwZk4IInZLsE+fKM9xG1IW4Q
	0699Sa3sW1KkWKOf0LNUsvXS+0afcFNCm4eIZtiZM96fOCukMHoycjmBCLcfRetJ4dXdhRtHhLS
	/c1d1sU7Jdu4WFZodnFzi+el7REcXeNRz43p1gL6Poi7+T+nDppE=
X-Received: by 2002:a17:902:ce8e:b0:2a7:3dbe:353d with SMTP id d9443c01a7336-2a8d81a0da6mr159708295ad.53.1770127547701;
        Tue, 03 Feb 2026 06:05:47 -0800 (PST)
X-Received: by 2002:a17:902:ce8e:b0:2a7:3dbe:353d with SMTP id d9443c01a7336-2a8d81a0da6mr159707915ad.53.1770127547086;
        Tue, 03 Feb 2026 06:05:47 -0800 (PST)
Received: from [10.217.216.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8b47f4717sm171421055ad.18.2026.02.03.06.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:05:46 -0800 (PST)
Message-ID: <79034c4c-ba06-4961-b41b-a43e5f5946af@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 19:35:41 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nitin.rawat@oss.qualcomm.com, Leon Romanovsky <leon@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203052756.GA15839@lst.de>
Content-Language: en-US
From: Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>
In-Reply-To: <20260203052756.GA15839@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A+9h/qWG c=1 sm=1 tr=0 ts=698200bd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=zVLJcoG1pTuyLsMQ7wEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: XsgeDq1-KFXjwJH505wdria_VNKvXGYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDExMyBTYWx0ZWRfXy16Ma1Tyyz3B
 w+8ub2vAM/Ivv1UhsVdHVD2OEdaJhYhh6VcThuie+o/fxp68oaLs5NSeqZHavd1mKCeVlnhSVpi
 jPpBfPvi6soBaTtvxcZP988TpKkl/sRO1UD7imyzAHN8JWVF2NczibVpFBXZI6b81ifytVlJDnt
 m/KmGCzWHjjPx854l9QsVr4khzzKIM7XZVP8tbv5fWNQTBJEaHWycqozPLmu9KLYlMCuw0OmtRH
 o1isfwXCG5rMXWpESg6v1QQhsYlLzPZVcBDEN97kWLPSBGWbkv2LgG80YPtwcUSyt1y+5q8Vykk
 H7Ka2QF8aIPc28ttnDMCYI/aHi4jKqEdQhLGPXntrr7rkaiy+I9LRWdfrJXePkX2rZ4igdE8Nvl
 GwPPAwaLHPNctmDNfH+he9okg3I/fpScU13THkEOS28F2COLpHTc183rsOv4gmvkVE4wAZiEG/I
 XzsyIlDS++XuuHSTltA==
X-Proofpoint-GUID: XsgeDq1-KFXjwJH505wdria_VNKvXGYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030113



On 2/3/2026 10:57 AM, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
>> In the case where this iteration caused dma_need_unmap() to toggle to
>> true, this is the iteration that allocates the dma_vecs, and it
>> initializes the first entry to this iter. But the next lines proceed to
>> the save this iter in the next index, so it's doubly accounted for and
>> will get unmapped twice in the completion.
> 
> Yeah.
> 
>> Also, if the allocation fails, we should set iter->status to
>> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
>> Otherwise, the caller will think the request is badly formed if you
>> return false from here without setting iter->status.
>>
>> Here's my quick take. Boot tested with swiotlb enabled, but haven't
>> tried to test the changing dma_need_unmap() scenario.
> 
> Looks much better.  Cosmetic nits below.
> 
> Pradeep, can you test this with your setup?
Sure, testing has started, and I will share the findings soon.
Also, I did not pick up the initialization of dma_vecs during testing.

> 
>> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
>> +		return nvme_pci_prp_save_mapping(iter, req);
> 
>> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev))
>> +		if (!nvme_pci_prp_save_mapping(iter, req))
>> +			return iter->status;
> 
> I'd move the dma_use_iova / dma_need_unmap checks into
> nvme_pci_prp_save_mapping to simplify this a bit more.
> 
>>   
>>   	/*
>>   	 * PRP1 always points to the start of the DMA transfers.
>> @@ -1218,6 +1231,8 @@ static blk_status_t nvme_prep_rq(struct request *req)
>>   	iod->nr_descriptors = 0;
>>   	iod->total_len = 0;
>>   	iod->meta_total_len = 0;
>> +	iod->nr_dma_vecs = 0;
>> +	iod->dma_vecs = NULL;
> 
> I don't think we need the dma_vecs initialization here, as everything
> is keyed off nr_dma_vecs.

