Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D527FD59
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826239; cv=none; b=R8e4oTZWUHoup9axeb78yb/NT4TlrIKoxZtKtr+BAlge/g3Zbc2NjdXbJBwRaoqllRXw4Z+fPSERwRjzhqXdGx4fdl65Wi7OZ6YDGDYdiNC5gzpPfVq0PF6WPZDEXHmLIHjAJ5d+i/N6SFVHYTlBowMuFtPlgt7drw/jaL4QRJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826239; c=relaxed/simple;
	bh=hG1Kpqlm5WuUCAzZGjEyX7QifUntUknhBtbEKoZXnOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKgO+v1XDb/1oOf5H5guYC8JqrXotyiTVjQDFKvOciIGUkS/fBskqcpcIp1sryv8sRsnCrtMSsnsJbtb3bDBfHsQNm/FUZIOcQMi3WUKBqgMFaE/u3jAaGf/mMsnJwslWPliwItSOrxEjI0o8XSjESzNdzgASwcxSFDAZBrWVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LR+WysaT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwvjFzYc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LR+WysaT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwvjFzYc"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BAccAk2396524
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 16:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LJBDI3PIChhc2kws+W0dzeaInjfDoZDme9zhqYCp+Tg=; b=LR+WysaTJo+GJCLG
	V4okYhQZAmJAvT7TcGVYe4h5Bkk8WpWdHKBM1X3evt1oVmvgpN5RbgquI260u61F
	zshpAG85Imk3/gxhcGjvE7rnaYXJqLgRxEC7ihrjJIw4bga3He2OSARNc9sFRzxj
	p8Dw6H/G3bFk1HAglxt5lnIJA2HbtN5xhDXpbDwJhBW0PWwUZEFmyZszz2kd2OPu
	xx1V1ZEDarqfjYwpM+0blZi+JnYyDNk+uTNolVvdrSO5K3ybIdYjjccV+i2pO1Wc
	2CKQ1sASuwp7P2tIDoit5OZBrgwZjHu87QrM9bbZsok4QJqhMTuo49VaziF0S4g+
	BzBs5A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c88wqkw5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 16:10:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c56848e6f53so4476156a12.0
        for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 08:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770826236; x=1771431036; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJBDI3PIChhc2kws+W0dzeaInjfDoZDme9zhqYCp+Tg=;
        b=ZwvjFzYcQRejfw7MQPrglpwZYS2aMoW0XH1Tf1dsDy6fYcNvzTnSARQIOGS/rM0hg2
         riSPX78eJHYV5eX+aB9KwFmv4Qn4snty9pZpuIJWuoib+wo8bobGPXX4MWrkkOVRuolQ
         oZH/A2QXXJkwCuvLpJehC3E8ABg8BQxYF1NSk1ZURNxXXqevrQWriOn/nzhlEiUUVIxB
         8mgXcFw5tx6lk0YB6uuAYepc52vG1aYRWOlfBiZF9ZtN3gFCRJvAwRpQwBRe6Fi5TXG8
         9BCOl9a82Fdfx8ygNfpd5dC+scITWmN6HyxI2GeqV0zAnebkaSAGprlcw+wMuHQOVuwX
         KljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770826236; x=1771431036;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJBDI3PIChhc2kws+W0dzeaInjfDoZDme9zhqYCp+Tg=;
        b=CzJSx6yGjwvLykZ3HbBtxC2PvUcCCEt7KXVH+LqFHI5DPnGhHlFFErMy8wPV1GHpEf
         DYxx8B8WFzn7GKWniEqLqbmmP10EBoF7IC6uhGbwEqZCiEVmZYy7GdJB0uMZX+fAjiOb
         MHNpT3q9f735BPgepcnc8s/mStjwN6Gmvgpn7ed8h7IGoUwpumc4oS0pa0rz2fYu6Kmy
         dSFhZm4Ys4F5QmUvy3G/+IvMQJAtVeAAtHc1vpETB6Fs5MORBnEzkT/xcWDHauTdLzlE
         VeRxNUoPeqYKjpA8PxRV3q/8s3jlC/THaaVtNRBJdTdiISSsk0L/jXdApaDn1hV1ckaQ
         unOw==
X-Forwarded-Encrypted: i=1; AJvYcCVAubh8yLR7ThuCpmLrQP0Ub9a1B3+bxhvxXFX+1CSnWS2/sRMYIuepAIA9IzL2nUU08NSoDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4Xn999Xez6fDqJq77re3etKFXok0UtGASFRIDKq90rQ6WzmWS
	kpfA2PU14OCTA5v2uBCn6ahD6LAiSy8cSm+YIP2PVvSSURamhBn8bMjHXDUYxMJURneJgY9MvEY
	3cax70RosvTPnsLzIci4IOxqhYwDQTgc+Wq42ikZtFrUy4Zuas6mHLrHnlg==
X-Gm-Gg: AZuq6aKvyqST8BxFbNzzlomtutRjLrlWs0URTEkcVB1k/nplCeu72iDHir31vKpU4bN
	jUhXHI67SEWAaz90M4+tkXnzlgLeyOAT0XlfMRaicAF1fj4RzBXEPKzco1d9OXrFXXsq2qe2xfb
	Sa9BBVIcFLR7j1toz/EJDZTCL+jokG3WAmS7XgTwMP+7KkiPwjz3NFCiao3eAzhqmEc752rg2ws
	gTgEBqTwAICrp5s0/LHlhx7f9mhzb5iRRRSfuUcqLQ9USNiwb9y8F+aTtq8tP93FAZSvK3q/Asi
	ngbnDg1mF9+1ZS3UbbVULYE/Ca1JNvci8LXLuBzykQOt1AfdqY0VLdJCYSK0XLhRE9TgPvECRMa
	tz9TgBNYtxOGmYmSLl3cnpcKu6j3SBSxOGqFaSBX4JgzKGKEr3uDI
X-Received: by 2002:a05:6a21:478a:b0:38d:7d8e:5062 with SMTP id adf61e73a8af0-394322dec17mr2632284637.34.1770826235736;
        Wed, 11 Feb 2026 08:10:35 -0800 (PST)
X-Received: by 2002:a05:6a21:478a:b0:38d:7d8e:5062 with SMTP id adf61e73a8af0-394322dec17mr2632247637.34.1770826235179;
        Wed, 11 Feb 2026 08:10:35 -0800 (PST)
Received: from [192.168.1.8] ([122.177.240.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad84sm28188315ad.5.2026.02.11.08.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 08:10:34 -0800 (PST)
Message-ID: <53c051f3-3a72-4d8d-917e-3b9d1537443e@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 21:40:29 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
References: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
 <9fb8f661-a235-4f86-bc10-f80a21a8fa9d@arm.com>
 <00fcbcf2-3f48-410d-88a3-88dc834c1ed7@oss.qualcomm.com>
 <d6bc7f38-b41d-4e89-b484-0e699981b8b4@arm.com> <aYEFop8CJiLYzhLw@google.com>
 <7720d215-9f92-4f0f-83af-c992e1cbe531@oss.qualcomm.com>
 <aYsvacmKoLroXlrZ@google.com>
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aYsvacmKoLroXlrZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDEyNCBTYWx0ZWRfX9aVqUXtButOD
 ee8ElAoK+YzBGfku44VIUl4xd22McWm1JKnNhGXK6YXb7c34M3At2Mk+vHO2m98WqBUNXumB+HQ
 FGKlp4CRh/8mgaP9rnvCK1qnDLG6KKIww2R7UvIikGNaxnAsZhDRz3fmlMLXcDiYQWtChksoVlQ
 XgCyW8r8+qbfiXc8x+y1vGnscDfO2eH+GM7vvNy6yYwD27MZbU06fVoVUoZFHZM/tQB9IY1f8Ut
 yVnaULM1ZCP9TvlJN+d6RIdG8H4jRQFM51OvNLoS88Jxs5JkkCyS+zoOWHO1hN3/SOgV8pBQkyY
 2dpzoTm1FpB3wP1u/P57uHi0wmKmvBz4nHLq+dTkzViPzUp5jiURdS1Tm+SH+7WAjVQwlVMu24B
 6kqO045secLXW23HwYb/Xp1mws3ZMT75/9Cl5Q+kc0KuW3WX5tHWeH5jqm3I3A61Ibx3vmTzrnr
 0cSvpXX9jcZQjC+eBNw==
X-Proofpoint-GUID: eipSEnN84grHiIIMzoN-cP8qRvCvjJEs
X-Authority-Analysis: v=2.4 cv=W7Q1lBWk c=1 sm=1 tr=0 ts=698ca9fc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=AriDp7QaH+PBGn1cKZtmxA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=2sq3q3wKjKmezesidpQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: eipSEnN84grHiIIMzoN-cP8qRvCvjJEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110124



On 2/10/2026 6:45 PM, Pranjal Shrivastava wrote:
> On Tue, Feb 10, 2026 at 04:39:56PM +0530, Prakash Gupta wrote:
>>
>>
>> On 2/3/2026 1:44 AM, Pranjal Shrivastava wrote:
>>> On Wed, Jan 28, 2026 at 06:44:35PM +0000, Robin Murphy wrote:
>>>> [ +Pranjal as this might matter for v3 too... ]
>>>>
>>>
>>> Hi Robin,
>>>
>>> To weigh in from the arm-smmu-v3 side, we’ve attempted to address the
>>> "can of worms" regarding power races by leaning on these differences:
>>>
>>>  - Threaded IRQs for PRI/Events: In the recent series[1], the PRI and
>>>    event handlers are fully threaded. This allows us to call 
>>>    arm_smmu_rpm_get() safely, as the handler can sleep while waiting for
>>>    the hardware to resume.
>>>
>>>  - GERROR Handling: Since GERROR remains a hard IRQ, we handle any
>>>    pending gerrors in the suspend callback before the SMMU actually
>>>    powers down. Any GERROR interrupts received while the device was
>>>    suspended are treated as spurious and ignored.
>>>
>>> Thanks,
>>> Praan
>>
>> [1] refer to case where SMMU state is not retained during smmu device
>> power down, this I think is equally applicable for both context and
>> global faults.
>>
>> Since the ARM SMMU runtime resume triggers a device reset, any pending
>> faults would be cleared during resume. Here the solution can be to
>> handle both global and context faults before allowing the SMMU device to
>> suspend.
>> With this approach, any hard or threaded IRQ scheduled after the SMMU
>> device has suspended can be safely ignored.
>> One concern I see is iommu fault reporting to clients while handling
>> fault during smmu device suspend.
> 
> I believe by the time we've reached suspend it's safe to assume that all
> clients have been suspended. Thus, we could simply not report the error
> and instead scream by having a dev_warn_ratelimited about the situation.
> 

By reporting error I meant reporting the error to client with
report_iommu_fault(). I agree that if smmu device is being suspended the
dma devices should have suspended by now. If so, it should be safe to
just handle the fault excluding report_iommu_fault() in suspend path and
complete smmu device suspend. Will update in next patchset.

> Thanks,
> Praan
> 
>>
>> Thanks,
>> Prakash
>>
>> [1] https://lore.kernel.org/all/20260126151157.3418145-9-praan@google.com/
>>

