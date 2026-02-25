Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116D21257F
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046992; cv=none; b=O/7p2khwD6AP2+0QBb0wW8jVVHsBnQ2uWo3zmpuLUxnH6N7nMvMnnHn+st6fpNvhnR76kEn/HDzYueEAsQ9Dfk0Jsd4sSYM/5hQV/IruoKMLvrbPFdleaAk0t562w5M+QAX/lXJ8T3UZ/jsTrkyGL4G3W/vrsoSFWhWYdXCSfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046992; c=relaxed/simple;
	bh=JKDW/3JaTVDQQN1HGh2Kx50563O3XSftBtp3y9MuSmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEOGLiXusMlKTpqaHfXHD3ma44EXCaNVDRijtp9qAUiMl28xpwPEuFWsqdddW9p3j9xnzdM5DveUhe2T9apIGRbTGGhDkbEGah5JhcYlK3uIgdbmJptEUK6ejdok8HyL5kFurLXsMyff6OUHka+cu62g1zTTvJEuIkDrRf/pobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NBIuGH+q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PYGQ0Kg4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NBIuGH+q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYGQ0Kg4"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PHTdc81025026
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kdS/QntJSaGj5m5uHLTyiULnHKwPg/+0nR+soa0YEdU=; b=NBIuGH+qsITYkPXs
	Lof0N/6lSzDAv7Bpsm1A94Chi6YXXVYgoHooLmZ82JXaMITNohWCFCF5VA++xnoN
	yFJorSI5utmoSnY1IhQPWMnBVJp91XxB28WwAFzWVEGN3qSiQZCVtHkO5nZsRo2c
	JpJvOGSulZmLVv3Ty54oc1DNU2nIwPiaHIsLPqsoM1WW3qQCi34G+Bvjexxh6JlM
	uafSnrGYntn6CiqjATlu+MZVNOrBjrL6486X76+gARLA1z3DqX0pMoQtPXmQWMhN
	YH7S0MKzRKnXfjyz3xCY97lqnaDBIvi8uc5BjAJfkuSc/hfMmthY1ejzMJHJ1Gi+
	Zxh29A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chq57u2nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:16:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so26892eec.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772046989; x=1772651789; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdS/QntJSaGj5m5uHLTyiULnHKwPg/+0nR+soa0YEdU=;
        b=PYGQ0Kg4geD68jReQonAGGn0VEruv1MyYj2W62pGEH8Jl7iiK0nJCtYHfMdIWDCCyk
         RDwJjzKOspoJR6jeM81y0T2tmSe1KkY0oic50msAQGfHdVEx3DzOpyDEnTXMhoc2fpU3
         hh99ufaZeGRUSvPAb1g1Y8M0QPIi9oG0WcYKKWu1s7BM2BLvaSr2XlFFXn7WzVeZMHvR
         Um2GQhnVdxG7iMp5iXOc/ci4bb3JWGY6MNpgPfPWIc/4/FqiKqA06JHmKXrQ58+HphFe
         ylqb0p2wvM+BxgpXFJN0ccdxQZgJVD5XuCk8J5eVwscRrhS+3Z7Mz1TiyfH1Sx5hN/is
         OMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772046989; x=1772651789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdS/QntJSaGj5m5uHLTyiULnHKwPg/+0nR+soa0YEdU=;
        b=DDMPjKo1AQVjGnPueSJhb9eaxuhj1P/YhYD7wH7+xD3t0/8TF3HprYaaC4yhTPXOiG
         cNQLZF95839WPDJRa8PCd25hQiTHSeobMPi8h49RtuQxnLlayds21q7eeU6PCn9RZzSO
         a/NpFNtoZai3jVp9HNbIM++FMcuRTotEx2m00vJL8jd+WkMKuxsyJeq2vVZXsqnRWyFZ
         wPA9qMsCCpZveM9lVX7g9Z4TDgC2+xdl1MmRfniF5oHimXjO02ggEDiFo0BTQWbSdeYn
         gflUSwZxf98kgadwg38qCyb0wAyqfzvPDgzp71WscCUQvKQEG8PjGyrX0MOaSHX9N7+i
         LB1w==
X-Forwarded-Encrypted: i=1; AJvYcCXSz2HOQFez2c4yvjmeu64lz+fTHTrPjeZnJsxqthJFiZDBTRBS5OnIxPoCs472ai72qwarhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUU6Zm3bn8Tq33Td2GVgbRoclSNeT/Mhlj69GFPze9XJ1lI1Hf
	TuT4Exw4odhMLKCfDHpdjR3xt41W/0L4o8RvGhKN5PsbH/MsD7iFUg/AAQ+xiVZYYXgrH89MFQg
	r/oGRvAxOxCkjpwWs6ioO23O+0MhELtbfiQPhySnIKkVJb1WaOXfKM4nbEQ==
X-Gm-Gg: ATEYQzxob9IpmNLelVbxovGNotZMqBy7P6ihb24Dmho1SsjhND+Z9aqA81HJTzKdnGr
	rjyiPkkziFbJDJ3GukwKQ2VCbkguEr9/ts6cHEoW4Wcxhixcl4EW57ST1U3aTAnO6wypR/h2j/k
	GYim0ME01rImo0pi7l10IwYZ0ZmhhxgnsFmviY7WstfLD2ESzzEkoRXQ6oQWSF8gsTvJIEb2A47
	WQOUaAGPi15KwaSL4lv6hOlXUqBuP8UXVAUItNGtoGghKhV1DjtGwThHiukGRWgW5MncaYXd3+w
	0JIhKlXApZ1ZaVhGudRj35HBJqpuACvf/HHP95sSA+RezHfZD0p6XlEUN3Kl7lIoCpgr4vAHLKH
	mv9NGQ1QgIVknD9IuPfjLe510KSZGyaOBC4c1WI6yPPmRpcvcjfpcgoc=
X-Received: by 2002:a05:7301:434b:b0:2ba:990a:4829 with SMTP id 5a478bee46e88-2bd7bd112fcmr7841905eec.30.1772046989274;
        Wed, 25 Feb 2026 11:16:29 -0800 (PST)
X-Received: by 2002:a05:7301:434b:b0:2ba:990a:4829 with SMTP id 5a478bee46e88-2bd7bd112fcmr7841890eec.30.1772046988649;
        Wed, 25 Feb 2026 11:16:28 -0800 (PST)
Received: from [192.168.86.165] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe8304sm9699189eec.17.2026.02.25.11.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 11:16:28 -0800 (PST)
Message-ID: <4e4b50fe-1091-451e-b854-f7b061ebd88d@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 11:16:26 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/18] accel/qda: Add Qualcomm QDA DSP accelerator
 driver docs
To: Bjorn Andersson <andersson@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-1-fe46a9c1a046@oss.qualcomm.com>
 <e94ce683-d47c-4c8e-8b26-cd327c891cc8@oss.qualcomm.com>
 <5a278b02-f2ad-408b-b0ad-f2297817bd7e@oss.qualcomm.com>
 <opjniedtfhkv7vlb57g3xyikcfkxelthx3lmspmypws4vxz4oc@4uypmmf4t6fb>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <opjniedtfhkv7vlb57g3xyikcfkxelthx3lmspmypws4vxz4oc@4uypmmf4t6fb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=faOgCkQF c=1 sm=1 tr=0 ts=699f4a8e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Vs6AG_5Z_IHWLNxo5LUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: YQdeK6PioSMOlXMt-k8OrAlqiunqs636
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE4MCBTYWx0ZWRfX9kB1yGPyTZ9C
 p7Xd50H4x6gsqTDqH331eNFzNPsvGpqBGl128vI4o2HLUzqjjHYY5fzrviVle9EmGNMlEII8DE1
 f7XEc0D9XOtg/cHdaqj/CBfv1zQZcifsUP2c4txc9m2TtXmZBgJ6eBav+sxVQ6FrtHX27TSMbRk
 Taf/tquOGbpE84L2GTyTDvbP3lKFKZsiutecg/TUnpqlT3umTRdyhtiqvtxM+EUGP6f8MfBAdBL
 mTKTsCQDw0acxO4HRK9D6ozqOwiqIhxGYjkiU29RhpiL9sIngExXU9JfiOn15aKwolr9/XKroEO
 ZvA4m2m1Tjfq4lgtQjP/ahnnCjADU79i+drA/WgmTPZzYRb+UCKAxFZBaRj6EAzIR3d8VzvJ8Qh
 UmzgoHXJS4jS0OxTDTAzGK/C7Cil7Eq9EcWo1jYNUJt5ncVifVx/m8skTys6cjdBYHm43dG1Hw1
 Lw8zhXdiBw/0zr19XsA==
X-Proofpoint-GUID: YQdeK6PioSMOlXMt-k8OrAlqiunqs636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250180

On 2/25/2026 7:12 AM, Bjorn Andersson wrote:
> On Wed, Feb 25, 2026 at 07:47:08PM +0530, Ekansh Gupta wrote:
>>
>>
>> On 2/24/2026 9:03 AM, Trilok Soni wrote:
>>> On 2/23/2026 11:08 AM, Ekansh Gupta wrote:
>>>> Add initial documentation for the Qualcomm DSP Accelerator (QDA) driver
>>>> integrated in the DRM accel subsystem.
>>>>
>>>> The new docs introduce QDA as a DRM/accel-based implementation of
>>>> Hexagon DSP offload that is intended as a modern alternative to the
>>>> legacy FastRPC driver in drivers/misc. The text describes the driver
>>>> motivation, high-level architecture and interaction with IOMMU context
>>>> banks, GEM-based buffer management and the RPMsg transport.
>>>>
>>>> The user-space facing section documents the main QDA IOCTLs used to
>>>> establish DSP sessions, manage GEM buffer objects and invoke remote
>>>> procedures using the FastRPC protocol, along with a typical lifecycle
>>>> example for applications.
>>>>
>>>> Finally, the driver is wired into the Compute Accelerators
>>>> documentation index under Documentation/accel, and a brief debugging
>>>> section shows how to enable dynamic debug for the QDA implementation.
>>> So existing applications written over character device UAPI needs to be
>>> rewritten over new UAPI and it will be broken once this driver gets
>>> merged? Are we going to keep both the drivers in the Linux kernel
>>> and not deprecate the /char device one? 
>>>
>>> Is Qualcomm going to provide the wrapper library in the userspace
>>> so that existing applications by our customers and developers
>>> keep working w/ the newer kernel if the char interface based
>>> driver gets deprecated? It is not clear from your text above. 
>> Thanks for raising this, Trilok.
>>
>> This is one of the open items that I have. I'm not exactly sure what would be the
>> acceptable way for this. 
>>
>> As you mentioned, applications that rely on /dev/fastrpc* might not work on QDA
>> without modification.
>>
>> I was thinking in the same lines as you have mentioned and  having some shim/compat
>> driver to translate FastRPC UAPI to QDA. The compat driver would expose the existing
>> character devices and route the calls to QDA. The compat driver could be built via Kconfig.
>>
> 
> This is a fundamental requirement, you need to address this in order for
> this to move forward.
> 
> Which makes me wonder if it would be possible to reach an accel driver
> through incremental transition of the current driver, instead of just
> dropping in a few thousand lines of new code/design.
> 
>> However, I haven’t encountered an example of such a UAPI‑translation driver in the kernel
>> before, so I would want guidance from maintainers on whether this is an acceptable
>> model or not.
>>
>> Regarding your question about library, all the APIs exposed by github/fastrpc library are kept
>> unchanged in terms of definitions and expectation. The same project can be build for both
>> FastRPC and QDA based on configure options. So, the applications using github/fastrpc should
>> not face any problem if the libs is built with proper configure options.
>>
> 
> You're assuming that the kernel and userspace are a unified piece of
> software, they are not. It must be possible for me to install a new
> kernel package without having to replace the userspace libraries.

Thank you Bjorn for providing the inputs. 

I also foresee that we will be stop adding (or already happened) new features
into the existing fastrpc driver, so calling the new driver as an alternative
is in oversold category.

You are pretty much began the deprecating the existing fastrpc driver, so let's
just mention it if that is the case and provide migration/shim path so that
existing binaries doesn't break.

---Trilok Soni

