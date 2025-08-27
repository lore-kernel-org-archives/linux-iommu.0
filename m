Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B031E25E3
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259730; cv=none; b=gHXLrCUxxPYqhgkEckHEP/DeK5LVLckprK+Dh+/VyfAkbF4VPhebJ2pIHJjNqnpu8NITJ3xcAtQ/e0CSG6t0LuLLn/qHMnnDvb2N1p8L+2qTX5VAO54H5DId55qILlaKjcqEEmn4XPizUnola1QLeDWGgLp5JxU6zC9w5IBbLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259730; c=relaxed/simple;
	bh=EG/uyqg10U+IFfisvso0bEBlysgxBsgMwVPEVZCea5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCwBvwyU1JnClGN5faLP5uxw0QNLiAiYyxvLng4p8GcN0m/0xVZMR51QTIqb+ZiwHVDblgEF611f58aEg9UfKF0jmvedmB3z71pKQhYj6PFouAGyE1d61nm2HXSVZUobkXM+cz3RtFe0YTG3u4VoF/qVMN8hwkyfjb8ODTF0vDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETjfHBI8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETjfHBI8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QJIw5g004377
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 01:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyZ5iLGjMEfr8zWA8TqBNrggJ/o46idkE8iV1Fg6GHU=; b=ETjfHBI8Qn8OTsO+
	LquT8vZTyxHCAsBfmtP94C9F/AqUCa05eBfEf3bXw2cuz5pCbYF3u/FfQ/yKzzEM
	eGRRPlEZLmwx0urzVzGaZGuWwiCPUmzhwT2lvc2fCqy0YJvQEkiALgJBw2bkbE1J
	wCB14okLSEbLNgEc7frsGu4wgEsKKcjoFJ9w0Irb8/TBZKt68mPkTuA/KghCTw+j
	OyIINNc2/gFbNiOb5/rsGBc2qQ4RhQlPgHoJP8+n1wZYv6tvlQANCeW4IfMVgEtf
	aVmPs/eplCykldzk7tjAQYPqqjPQ1jrnebTK+MTPG6gtHed/VI6AtvYYbEvOR4bi
	rac9+w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpu5aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 01:55:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246cf6af2f4so56258535ad.1
        for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 18:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259728; x=1756864528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyZ5iLGjMEfr8zWA8TqBNrggJ/o46idkE8iV1Fg6GHU=;
        b=MgcIM+CC0GjSVMu3TgsKoAb1Ac7Gom1BB3zn1E17iPa6B8l8p91dwI0hubm84rYAVi
         psKim1vrKZ6SHAvdYdOlEGMN3JVfHF72hLQ5b1zTikJ2bMPAMInyIRBlS0qj4J9ESf4X
         op+610NVCnzxJQNMJUjjCPoAFXenEsvhwFblLaJJ1mJ3vgWroYEPK0qGJ2TFlCJpjqWf
         zKO8zlT1XN/80BBGVKeKaFhQDHuaNTTcXGDEKORlnuvzZznIkAZPXZiBGZWjwaocArvk
         frFeLpuXf2bvThcRHiBbKZBL2bSmvmFCFs3Qaxl6AGM/wUEExZup5I/M8LSe9GIMnBwT
         e5pQ==
X-Gm-Message-State: AOJu0YyZCtIv54ANzu1u8FOjyRbQC6VNt7Fxuf3XIblAaAnQsWIVfm0J
	OnJ+uf2Msz5EY2nfIxlIIItZ1gCvIXjffhKaISVL8MXSSLdun6FBTUKdSE9SX9mP3ONeR/9ddlx
	O2fP8oj+kjg/sMkR4EfJ0OK2fg/VVKq3P9udVJ/RHZF5zHLctafiyBmhUpw==
X-Gm-Gg: ASbGnctBEL8EtPJ4um82uuomJKACrKUxcFXXHxyhxBnV4grhAW8Tq3PIFpYmMaVJObb
	Dvn52VZrGMJjiIKhnbz+RWszaC/D+6Tk79302lcPS6nhJRSpwpy+CMU/+bC6A0c/WxMD2RUI+Jv
	TkvjPpjB33P/T28yp2ODiOICq1+dBc6pJS7RyvYl0ZVwxo3TMVRGzzR3ZfzTQusqH+Eo9hFl1mB
	rdo6nXywMzRhn1zcNBMe64KXYavciVkZhVRI2xBQ/wTioNYxDXBpI070aMP5xaofKJOX3mW/FaO
	GJa50b3dXcFrV6kSdyzzMN84d+/vt9Qi+wpdkEPlKKSXtYDxjPzPzrHN+HYjsDLDT8GxS594+Pl
	64Gf/xUlcJru3PpMe69lEjjZmAvXbQwwY69+1yw==
X-Received: by 2002:a17:903:2f44:b0:240:a222:2312 with SMTP id d9443c01a7336-2462eeeca94mr229747265ad.44.1756259727681;
        Tue, 26 Aug 2025 18:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2i5XtdpRUbO/urKMakMgXLRO2eBfmK/dMCP7CKXewUgYFm/OlcVeTpLpdrPdXjPdZowBzJw==
X-Received: by 2002:a17:903:2f44:b0:240:a222:2312 with SMTP id d9443c01a7336-2462eeeca94mr229747085ad.44.1756259727126;
        Tue, 26 Aug 2025 18:55:27 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm108143455ad.60.2025.08.26.18.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 18:55:26 -0700 (PDT)
Message-ID: <b679c1ec-be21-458e-a650-1aa14e2366a1@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 09:55:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: is dma_mapping_error() check necessary for
 dma_alloc_noncoherent()?
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: iommu@lists.linux.dev,
        "linux-kernel@vger.kernel.org >> linux-kernel"
 <linux-kernel@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <CGME20250826094453eucas1p178ff4a39db0c655f3505128a5cfb0a6a@eucas1p1.samsung.com>
 <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
 <89954593-8236-464e-8848-e7cdcf639c0a@samsung.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <89954593-8236-464e-8848-e7cdcf639c0a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ae6590 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=v1NiFcvVahR_jOWWQrIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 1ZF65lPWP_h-dpFyKAm4_mOnL-6hmGCX
X-Proofpoint-ORIG-GUID: 1ZF65lPWP_h-dpFyKAm4_mOnL-6hmGCX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXy/0PnL/iuUlt
 ivrqY8fgu5E4jrAOe+pqx7XLVz0aKqEkC16cdaqjVBJ6dDr0sWmagkdATBtXRvyev9PqsXa8+fk
 RALKQ9/AdIm4bYvcR/U1jjqf3Al3uySwi4XdS4RENiOd0NyLa7L9EfZF2Itj53dBoWOV1TRvUDe
 J1BTpdIY7niQ3DOvM9xNS8zQJEm5W/Co017MoBzKKGfUcCo9eMS/Dz5LN/KVPfXoUyOF+7FzUue
 drWXqfu+b3D1CNheD0Yp+Kid50OYe2gVZK0KqmMiOOgIw1vt/zNz52/ljTHYhSq867Ao/DgQs7L
 T1ehHNw4/uwztA4CbWGRizmh1RpX7JB0DazIo6Y26YQp/GAQvPuAWzi144B3/TneLgVrHu6GRZy
 Tr6sBIdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/26/2025 10:09 PM, Marek Szyprowski wrote:
> On 26.08.2025 11:44, Baochen Qiang wrote:
>> Hi guys,
>>
>> I have a driver which allocate noncoherent DMA buffer and get the returned CPU addr tested:
>>
>> 	vaddr_unaligned = dma_alloc_noncoherent(ab->dev, rx_tid->unaligned_size, &paddr,
>> 						DMA_BIDIRECTIONAL, GFP_ATOMIC);
>> 	if (!vaddr_unaligned) {
>> 		spin_unlock_bh(&ab->base_lock);
>> 		return -ENOMEM;
>> 	}
>>
>> while free the buffer
>>
>> 	dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
>> 			     rx_tid->vaddr_unaligned,
>> 			     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
>>
>> I get below warnings:
>>
>>   DMA-API: ath11k_pci 0000:03:00.0: device driver failed to check map error[device
>> address=0x00000000f3ad7000] [size=639 bytes] [mapped as single]
>>   WARNING: CPU: 15 PID: 64303 at kernel/dma/debug.c:1036 check_unmap+0x7e2/0x950
>>   RIP: 0010:check_unmap+0x7e2/0x950
>>   Call Trace:
>>    <TASK>
>>    ? free_to_partial_list+0x9d/0x350
>>    debug_dma_unmap_page+0xac/0xc0
>>    ? debug_smp_processor_id+0x17/0x20
>>    ? rcu_is_watching+0x13/0x70
>>    dma_free_pages+0x56/0x180
>>    [...]
>>    </TASK>
>>   ---[ end trace 0000000000000000 ]---
>>   DMA-API: Mapped at:
>>    debug_dma_map_page+0x7c/0x140
>>    dma_alloc_pages+0x74/0x220
>>    [...]
>>
>> Checking code gives me the impression that I should do dma_mapping_error() check as well.
>> And indeed with below diff the warning is gone:
>>
>> +       dma_mapping_error(ab->dev, paddr);
>>
>> However this does not make sense to me since IMO testing the CPU address is good enough, I
>> can not imagine a valid case where DMA alloc/map fails while returning a valid CPU
>> address, no?
>>
>> If I was right, should we remove invocation to debug_dma_map_page() in dma_alloc_pages()?
> 
> Simply replace "if (!vaddr_unaligned)" with "if 
> dma_mapping_error(ab->dev, paddr)" and the debug code will be happy.

Thanks, much better!

But I am wondering if the debug code is worrying too much? isn't the CPU addr test already
good enough?

> 
> Best regards

