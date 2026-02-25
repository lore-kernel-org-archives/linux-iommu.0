Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061DE315D23
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061515; cv=none; b=nYswrasU/YeXb9W+Mnu8SHiGYpV1JEMC5tuTfdEDMM5UclJYvFLw61ZUCxH4NSDTe+uUgG90xfWHCv/l5HHM67+lwFmKKE6I6V/IeHhKP6jZBrPUgGLE7T52dBmhJPHM6phydPVQJBGewQee34zktu2FjbVvddlRTymHP+hVWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061515; c=relaxed/simple;
	bh=HhhiVoqh4Q1gSvfSxzm9qMI34m/iQys18sSsZO1HSnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8PbE49/qGxyPteUqqGCahH0xEvg+jLU/it9hPzIh4V049VUIJgY8YPZ4TcVv6lJW8S9++E9wS20dCjAvpt5zIr5++wSqPriCKubRHrrW9SNK4ngpaXWU1nA/QmfGsp2p2JWDsWPQop9ZlA4wJ/IWVuDPBM7mf87G3EXTDSBHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JpmL+CkW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bytHINzR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpmL+CkW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bytHINzR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PH2KXG3100871
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 23:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k1ncu6ArYzJhC1oWtoKaTbf490HS3AonBnLenM3Jd0c=; b=JpmL+CkWYUP0rhkq
	yvcnpyP/EsHfwQoW0K88N1JAwbxTi+LLkZjH9DnYvIiobtYH5J/g8+9NO85fBMy2
	kviXPZxgDBjU9X/GvP4DBmN+EQ3kZmoyKjP7w6eVnJVJzNDhRfpq2IsfE81WQkuh
	SqGKaB0hOvmonmXYz8t/bTRs9L/qyP0J6vhfIpk7hwpr4X/Oa++bWNC8h1FEQnM0
	aRUSD8losKzsY6bDy0GwTFFfO5k1NBw/RQLoC5/2zk+aY+Gn89MIwAMaa4NJeH2v
	SO1uWYK0vdnDIr369SYLjwZ1kJxo32PT1fieroRk0aGGqmVEoRy2LpCjqL1JCwzX
	OLvqSw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54p9281-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 23:18:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdcd394f5bso257925eec.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 15:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772061512; x=1772666312; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1ncu6ArYzJhC1oWtoKaTbf490HS3AonBnLenM3Jd0c=;
        b=bytHINzR+ubkP+Rqp8SNPRs7jE0P67Qu+M5HyKf4Zphber21A9uxgZjqf1Vwjj1rPI
         HBvHbPEOBCKHnMkJwiQuU+qxPTodbtbJfwN2YIYrvpmKKl1r4c4lEfHEtOirfFpGAEIu
         0pKyxd+Exvdy4UAP9msjojTBTZL+0AP3oPcUpZVaNk/3oNpJBLWGfU8cr5ViqnA+NWIP
         UOxY3AaDeIQ6a0MpKSPlAR19hY/qomNBsZ7dCRAYDXLpyDaBA3xPewlYY4BRRYZegske
         rZG8/9j3T7lPHphWh+7qyW6TaCtLKQOc1BwB+4Ru/OB7TT7wY93d5ibOsDKAzN7Itd0P
         BSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772061512; x=1772666312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1ncu6ArYzJhC1oWtoKaTbf490HS3AonBnLenM3Jd0c=;
        b=GXHW3d57pSs2DaP5pGqyhcMuz0GMD4pDzRwsSnxA0ajem8OVMednDKR91blvfcAI5o
         GLV/4GLMw8fCHktHUEfFdXe0/xVIu1Khv17T8jp7ae3eX2q6IO+DHElZLCOTqSC3tjVB
         adUnvd3FhiLxKO0eWlBcD/bj6GjIRNZXUgWyilweylKKLrf6kJJZTP/W+in/GOdTXAJt
         EmsccR5bzgUBIqb2D88KaOl+/+ZmvG/xEfAYW+fvU9ehbo9K+RETzZgf9+AKtOlxsCcJ
         2ZWV6BRiVA0Dyup7QTcuVRiRe9fJQ7nRLHGpAH0ahwvuOCm4ywIYT5ok9wiMTllw4Tof
         ciEg==
X-Forwarded-Encrypted: i=1; AJvYcCW+/O9U9nXO+if85rrffQ0YYF8HASbyBGdrcR2hrkpgztu8T+1jlwhzSTw1wVNEmAIciuIS5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKOrPpKUYPzV0qQr9NFeX/zkpc1uv8ZQe2LqpVhC/65JxZluK6
	ucx6fsFflLC7FC33BlmcyMUQhvHaxacl8bkJDsrZkmdydco/cG4LoXT3mykCe8r8Qv1rIJ2L1o/
	FRoGBPVMqmxK9n/dcUPiLFJIilrlGA2rS+WcG56EEEgFfq+lWNrU8LXQIOw==
X-Gm-Gg: ATEYQzxTAoAIrIGjuiy4HFRp2slUhZyNZUeBm3YCj0K2w9dk32d7Clc3fictiWlkZEM
	3i5pG1y6svhjNW+zwIXUZAyBXCuKpVxRvdn2ISvMzcixc6VHt2Ybr1pB3TmRCSeddSLe8at8N4z
	4MyJRU6N2yTL2Tt0BBQ0Xm+29B6noso+FTUieew6uhzNSr1eEGIz0OrGwb27a8QJcKBlAIU1yWp
	rzQi6VeeN+w8CBUxmYOftNjU0leZO4gTy2/xrw1KqYcud72A7V5EJjffHaYW7vvEPtfXdF9Kduu
	WAtr3dOVQ1Xchw84+/i2Qa5JBraYXDXEGLEDcaEN3J1IUIDnTuAiDg1aw1RjmbfezwkCxB5ksI5
	8AFWL8UoCs0+MKmwgCOkgxaF7RGPhjUdYCe9AYzhN0f1wLjOVrMLONvfTIsWtOwZ6Egi6XGXV1c
	f9jBQQ
X-Received: by 2002:a05:7300:538e:b0:2b7:1abc:a6eb with SMTP id 5a478bee46e88-2bdcbf4440dmr892777eec.7.1772061511655;
        Wed, 25 Feb 2026 15:18:31 -0800 (PST)
X-Received: by 2002:a05:7300:538e:b0:2b7:1abc:a6eb with SMTP id 5a478bee46e88-2bdcbf4440dmr892750eec.7.1772061510969;
        Wed, 25 Feb 2026 15:18:30 -0800 (PST)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cf0115sm357385eec.8.2026.02.25.15.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 15:18:30 -0800 (PST)
Message-ID: <3f06453a-ac7e-46e0-8d37-e0f9980b438d@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 15:18:29 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/18] accel/qda: Add Qualcomm QDA DSP accelerator
 driver docs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-1-fe46a9c1a046@oss.qualcomm.com>
 <e94ce683-d47c-4c8e-8b26-cd327c891cc8@oss.qualcomm.com>
 <5a278b02-f2ad-408b-b0ad-f2297817bd7e@oss.qualcomm.com>
 <opjniedtfhkv7vlb57g3xyikcfkxelthx3lmspmypws4vxz4oc@4uypmmf4t6fb>
 <4e4b50fe-1091-451e-b854-f7b061ebd88d@oss.qualcomm.com>
 <jmv4jkwku5x5acxno3vyar4cozl3makdz6vzdyjsitf2vtyhp6@cxtl7zmaayvq>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <jmv4jkwku5x5acxno3vyar4cozl3makdz6vzdyjsitf2vtyhp6@cxtl7zmaayvq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIyMiBTYWx0ZWRfX+aXjHM8Eo4vK
 Hr0XYDBdXqjwUoMwqV1Pj2+8WppM/16Su8/14+kIZlBirr/K82yORmuBD5ZMhcPQBKJITzfF5uM
 fWUN2yY2rr4RZE2mlkWklr2CLAB3eSxMgZUxfl+ujGWScury01pLqf90lC0KpvQTzVZuFTZVh5g
 4We64/gITDIHHj7MrwwpC8O9nhuuVMyR/FjMVBvi627nydVB14DzyaAXKN+koiCD6+js7GATy/h
 XvfyyrJc5N0WMUi/V6N+w9rc2NQ9i9GyRzS70yRW1ZRqjQ/wCqtAdU74juYVXo4YPXnwhrpk+ma
 aqyRlF7AxLTpJGIWax+XAZkm2rSZ72IlNzq3Y5ZH92BqstATas7exQXOwK1Q2qgdo/0a40pqmhU
 wYP97Xp4+V3WLmzPsh6/vCBk21ARzSoo9KiRUphoznA8PHlyz/J2j9BLIaBb9BKH8RbXrcieCFh
 68DtM44m2XMSx0uD1Xg==
X-Proofpoint-GUID: NTnO9fKdI5tiv87V5Cd6eAjxpn-kJwEH
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699f8348 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=AmUwcyaVtIZmdcZSVHAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: NTnO9fKdI5tiv87V5Cd6eAjxpn-kJwEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250222

On 2/25/2026 11:40 AM, Dmitry Baryshkov wrote:
> On Wed, Feb 25, 2026 at 11:16:26AM -0800, Trilok Soni wrote:
>> On 2/25/2026 7:12 AM, Bjorn Andersson wrote:
>>> On Wed, Feb 25, 2026 at 07:47:08PM +0530, Ekansh Gupta wrote:
>>>>
>>>>
>>>> On 2/24/2026 9:03 AM, Trilok Soni wrote:
>>>>> On 2/23/2026 11:08 AM, Ekansh Gupta wrote:
>>>>>> Add initial documentation for the Qualcomm DSP Accelerator (QDA) driver
>>>>>> integrated in the DRM accel subsystem.
>>>>>>
>>>>>> The new docs introduce QDA as a DRM/accel-based implementation of
>>>>>> Hexagon DSP offload that is intended as a modern alternative to the
>>>>>> legacy FastRPC driver in drivers/misc. The text describes the driver
>>>>>> motivation, high-level architecture and interaction with IOMMU context
>>>>>> banks, GEM-based buffer management and the RPMsg transport.
>>>>>>
>>>>>> The user-space facing section documents the main QDA IOCTLs used to
>>>>>> establish DSP sessions, manage GEM buffer objects and invoke remote
>>>>>> procedures using the FastRPC protocol, along with a typical lifecycle
>>>>>> example for applications.
>>>>>>
>>>>>> Finally, the driver is wired into the Compute Accelerators
>>>>>> documentation index under Documentation/accel, and a brief debugging
>>>>>> section shows how to enable dynamic debug for the QDA implementation.
>>>>> So existing applications written over character device UAPI needs to be
>>>>> rewritten over new UAPI and it will be broken once this driver gets
>>>>> merged? Are we going to keep both the drivers in the Linux kernel
>>>>> and not deprecate the /char device one? 
>>>>>
>>>>> Is Qualcomm going to provide the wrapper library in the userspace
>>>>> so that existing applications by our customers and developers
>>>>> keep working w/ the newer kernel if the char interface based
>>>>> driver gets deprecated? It is not clear from your text above. 
>>>> Thanks for raising this, Trilok.
>>>>
>>>> This is one of the open items that I have. I'm not exactly sure what would be the
>>>> acceptable way for this. 
>>>>
>>>> As you mentioned, applications that rely on /dev/fastrpc* might not work on QDA
>>>> without modification.
>>>>
>>>> I was thinking in the same lines as you have mentioned and  having some shim/compat
>>>> driver to translate FastRPC UAPI to QDA. The compat driver would expose the existing
>>>> character devices and route the calls to QDA. The compat driver could be built via Kconfig.
>>>>
>>>
>>> This is a fundamental requirement, you need to address this in order for
>>> this to move forward.
>>>
>>> Which makes me wonder if it would be possible to reach an accel driver
>>> through incremental transition of the current driver, instead of just
>>> dropping in a few thousand lines of new code/design.
>>>
>>>> However, I haven’t encountered an example of such a UAPI‑translation driver in the kernel
>>>> before, so I would want guidance from maintainers on whether this is an acceptable
>>>> model or not.
>>>>
>>>> Regarding your question about library, all the APIs exposed by github/fastrpc library are kept
>>>> unchanged in terms of definitions and expectation. The same project can be build for both
>>>> FastRPC and QDA based on configure options. So, the applications using github/fastrpc should
>>>> not face any problem if the libs is built with proper configure options.
>>>>
>>>
>>> You're assuming that the kernel and userspace are a unified piece of
>>> software, they are not. It must be possible for me to install a new
>>> kernel package without having to replace the userspace libraries.
>>
>> Thank you Bjorn for providing the inputs. 
>>
>> I also foresee that we will be stop adding (or already happened) new features
>> into the existing fastrpc driver, so calling the new driver as an alternative
>> is in oversold category.
>>
>> You are pretty much began the deprecating the existing fastrpc driver, so let's
>> just mention it if that is the case and provide migration/shim path so that
>> existing binaries doesn't break.
> 
> I agree that we need a migration path, but I'd really focus on it after
> getting at least basic parts of the QDA reviewed and agreed upon.
> Otherwise the shim layer will be reworked again and again with no
> immediate added benefit.
> 

I am fine with the review to be continued, this is RFC series anyway. We should also decide
the design of the shim layer here as well. I prefer to not have multiple
RFC revisions here if we don't agree on the basic requirements which
leads to acceptance of this new driver. 

---Trilok Soni
