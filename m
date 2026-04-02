Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88E3BAD9F
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119317; cv=none; b=QItSymKwfO2tUW9w/DX1y8DWcbPDyyAnihv+TNXbf5B9kg2DrnHSN67F9GlXoKuQLFXhWz4P7k3ov5oGPPVHuq8KGDbkyeal4lk8AKQhlurXLHQY2WQDU04a2Vox+C6kHuB6Rv2efeJfYZEeXgsBOT1J7IrE2mIp0TReR4UpBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119317; c=relaxed/simple;
	bh=pW3ATQOcrqkFNMekHPEdPoJfFRW8eoJwjRH2lOOWNWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/FlkrNPkpxfgR4mCu5GEEifYbrKGJEOlrrqd/Txw31QOnPE3aPK7QNyajlwv/KLwTEeKyjISkPjphNtGYjjd4CNBS22b6I0ubZhwq/kSrxz8sjVP8bdXYaHOVyLhMu9GFGueLtl4EuzVHSqTV6489CYQ8TnAbK7r1MfIf5LC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BJt44dr/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GMa6VcHF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJt44dr/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GMa6VcHF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6325VRTK090853
	for <iommu@lists.linux.dev>; Thu, 2 Apr 2026 08:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0IbQWlYWo+noHc0aenssJgU60HYSp3RE6rMEPE72jcg=; b=BJt44dr/mmxhctc2
	iVXAVEtKBlF+i/g+M9vvEmNxo4Z91vH1GAOtvUGvc+9Ap1pgGiHArCj3JhSU4tdO
	1LbBr8Uzc/86RUIaUXhjZKdvo2UV8AucXHW6EsWOWa56WnYxoygbCyeZ9fX/U2+f
	RVEeX7qEcWBsRhef46gCHcLxnHmYrEJ73umyG6Oz/p5Ic2te8BKSNGId9hbClOoj
	IMw99rg+ZDanloFIP1H5A+RiDcfBkLPgsKoMu89veT/gvq+Arpuot8W35yhMhTcr
	5x075IQ/Ny3eqx4ahGfKvTVIp0SvCCRwQoWLObPsjLtc9D6HwwXc2aqF1n+g2fkJ
	80Lfng==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9jcu8s0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 08:41:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bce224720d8so336748a12.1
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775119313; x=1775724113; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IbQWlYWo+noHc0aenssJgU60HYSp3RE6rMEPE72jcg=;
        b=GMa6VcHFFZIX0WWXbA2jOxCwF4F732NxD50Gq7iEmVW+4BRSBZvcfYH5SHAi0okWab
         3iE+pgYTvVVXOzrmwZpI201WEiIzo3RK0/qdtQeBWcxuIC1QsparQWey8/ZOhEu9FIoJ
         9FFrQbNVOjbiqizXqz4fIPzXl6dp3s5p+b2zgW+QXv0SMXh/oE6ViNOs2vQIgTEV7KtM
         iEd0+IbCm4WFXvxLlY0GKZ5EbXlJL6fnWVbf8czw4Fw4K/7sZwMXseF0JCuvZAwWA94v
         imiT+3UZc0Nucdu7ARu8qqyIEu5yZ6gchgFJpR0F9b3IPoPeh/Rcgk44fYWe5KGiJn2n
         4t8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775119313; x=1775724113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IbQWlYWo+noHc0aenssJgU60HYSp3RE6rMEPE72jcg=;
        b=kXsf8MLRrq4ws1avC5GOXMB84hMbitq5XTzDL6btgoBI4x9wocqAr2Pq7kAUZQagfi
         LzMVvXuAEhuCJWpWM3JVPdVcwvFd4j3E/E8Bm3AJIU7rcXEzAdKiXXx9WDTywGRQLNWM
         DUFrjoPdbhb2ldO4jGN+bTBNsWONgrVeuMxNOHSX0AFI37KFENjF5uGRMIcm/plyYVk8
         ZRza/+dmaED1U2vQebZOMEBtA5aVBDs4k9+snXgPGrhuBXu5uINc9hVyA97SEr3a1Qve
         3m7deSn7meHYo7/IKa7Cu97vx2miYrXOGEIH2MYd71tMPcvSQuIgFk8Vleg5zw2s8IQa
         lWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2dMVc4N0UHswz531qAhouJ5oyl9iulJcwDUAkEeCnycuTvUmB8cubcnC+tf5xmfPuaZl9pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUK8FCLfHIteqG0HEyhlZiWaTNUMYJ2pZXJP4ENcYpAR6Flpnm
	/amG+Pw038Lwm+ceKvmcSClFkBBQqnx3Zm9QQppVfAUNInTFfDxeuXoAX7CXj9kz7P+FL3LjmDn
	P1q9+dsuxSqVcOX6/ZLBmpt+ceO3S6L772OfKmefqxizNvcBF7jY31rioKg==
X-Gm-Gg: ATEYQzyOcY7dTtsn2viXt31qRJyES0xS4SNQnrmsG6FNH5rAdueRZuM/rmA6zisZfdy
	WMkfPEPuFUDdJNX8aC6dip7Tm30De8hjAYkvakrYX7mjdlSsh/J4fOYCee8ut7DW0eSGTcnDGBK
	M8kgHP3MqVPpZgBiPrRPQ/byvGRWNLCizL0G9odCzdM47lD7mb0Kd1DqSsvVtKqkVLRD7lIc+0j
	bfaZ53tn++v0wdE+fhNRGRhckR7tXoLP8O4onGZ8vlQ+ZuCwtlAZUDYpRYjmge0zN+WIcYxlmMk
	wzNHIhzYEf1oqsotmFjOsLiufFTG8wCsPFVEBj2eLtXAoc16qhHl4uPYZ2qKtjLgfKOuo36xKk0
	BTv2je+JLYUbRYIjxfDO3LyJLQwTXoEZtVts4Nwm5kZI/JuUExtr5
X-Received: by 2002:a05:6a21:32a4:b0:398:ab13:b990 with SMTP id adf61e73a8af0-39f10c7c014mr2804484637.34.1775119312681;
        Thu, 02 Apr 2026 01:41:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a4:b0:398:ab13:b990 with SMTP id adf61e73a8af0-39f10c7c014mr2804434637.34.1775119312125;
        Thu, 02 Apr 2026 01:41:52 -0700 (PDT)
Received: from [192.168.1.14] ([110.225.167.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65a3f08sm2076441a12.31.2026.04.02.01.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 01:41:51 -0700 (PDT)
Message-ID: <7f349ca9-60d4-46bf-acec-84ded1da29c9@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 14:11:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/18] accel/qda: Add Qualcomm QDA DSP accelerator
 driver docs
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
 <3f06453a-ac7e-46e0-8d37-e0f9980b438d@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <3f06453a-ac7e-46e0-8d37-e0f9980b438d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3NyBTYWx0ZWRfX8lx7MTFk6Ucn
 TDi2kgM9Jl4IVs6NlRFoIijD2h80aTBG8pWm6imh4+rNzEXNP4yQk220u+EGsab9DGPhy4iAMSd
 t/6x4I19r6abLZJac2lqVSjJVh0Zw78/dOgSzmpzc0Y+r8bo5lOQ96jJGmn3GSGd6zG+Qw4F3W7
 6CxRs8vtjBZ4wlr8vCUz6m4JxBIzLIdWbtDVilWhSgOU+u71s5gBTjKhOB1mmWCRaXAuR8FVpOD
 Ha3TdQgn9qzRKKb+h6Cain7Glka9HYjq0U4ZCfm644errhncH7W8EOWet4ohlhrUjI5SEjKnFAb
 D6cZji02D+MKptew148CDul2Okwd0Kx31m37wA67ToRwRAXQhzVJt4DVmqD9AUW9aat+6OYVuf0
 LNOyOL/vnyKzwZPEkl8odGiozro7V2Rfi7vZ1UKtpmyBlBlv4xvjz6MpcCDYsF/FUzJuWHgzHaE
 fZ8UGTNF9LD3Xs9eJbQ==
X-Proofpoint-GUID: VHRrT4OIYDEoYOgaMaigwdga2r9CVf9G
X-Authority-Analysis: v=2.4 cv=eYYwvrEH c=1 sm=1 tr=0 ts=69ce2bd1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=GstQyB7T1i92F5dDEt+vJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Ny-Kw3UXgnDAMZ4gig0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: VHRrT4OIYDEoYOgaMaigwdga2r9CVf9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020077



On 2/26/2026 4:48 AM, Trilok Soni wrote:
> On 2/25/2026 11:40 AM, Dmitry Baryshkov wrote:
>> On Wed, Feb 25, 2026 at 11:16:26AM -0800, Trilok Soni wrote:
>>> On 2/25/2026 7:12 AM, Bjorn Andersson wrote:
>>>> On Wed, Feb 25, 2026 at 07:47:08PM +0530, Ekansh Gupta wrote:
>>>>>
>>>>> On 2/24/2026 9:03 AM, Trilok Soni wrote:
>>>>>> On 2/23/2026 11:08 AM, Ekansh Gupta wrote:
>>>>>>> Add initial documentation for the Qualcomm DSP Accelerator (QDA) driver
>>>>>>> integrated in the DRM accel subsystem.
>>>>>>>
>>>>>>> The new docs introduce QDA as a DRM/accel-based implementation of
>>>>>>> Hexagon DSP offload that is intended as a modern alternative to the
>>>>>>> legacy FastRPC driver in drivers/misc. The text describes the driver
>>>>>>> motivation, high-level architecture and interaction with IOMMU context
>>>>>>> banks, GEM-based buffer management and the RPMsg transport.
>>>>>>>
>>>>>>> The user-space facing section documents the main QDA IOCTLs used to
>>>>>>> establish DSP sessions, manage GEM buffer objects and invoke remote
>>>>>>> procedures using the FastRPC protocol, along with a typical lifecycle
>>>>>>> example for applications.
>>>>>>>
>>>>>>> Finally, the driver is wired into the Compute Accelerators
>>>>>>> documentation index under Documentation/accel, and a brief debugging
>>>>>>> section shows how to enable dynamic debug for the QDA implementation.
>>>>>> So existing applications written over character device UAPI needs to be
>>>>>> rewritten over new UAPI and it will be broken once this driver gets
>>>>>> merged? Are we going to keep both the drivers in the Linux kernel
>>>>>> and not deprecate the /char device one? 
>>>>>>
>>>>>> Is Qualcomm going to provide the wrapper library in the userspace
>>>>>> so that existing applications by our customers and developers
>>>>>> keep working w/ the newer kernel if the char interface based
>>>>>> driver gets deprecated? It is not clear from your text above. 
>>>>> Thanks for raising this, Trilok.
>>>>>
>>>>> This is one of the open items that I have. I'm not exactly sure what would be the
>>>>> acceptable way for this. 
>>>>>
>>>>> As you mentioned, applications that rely on /dev/fastrpc* might not work on QDA
>>>>> without modification.
>>>>>
>>>>> I was thinking in the same lines as you have mentioned and  having some shim/compat
>>>>> driver to translate FastRPC UAPI to QDA. The compat driver would expose the existing
>>>>> character devices and route the calls to QDA. The compat driver could be built via Kconfig.
>>>>>
>>>> This is a fundamental requirement, you need to address this in order for
>>>> this to move forward.
>>>>
>>>> Which makes me wonder if it would be possible to reach an accel driver
>>>> through incremental transition of the current driver, instead of just
>>>> dropping in a few thousand lines of new code/design.
>>>>
>>>>> However, I haven’t encountered an example of such a UAPI‑translation driver in the kernel
>>>>> before, so I would want guidance from maintainers on whether this is an acceptable
>>>>> model or not.
>>>>>
>>>>> Regarding your question about library, all the APIs exposed by github/fastrpc library are kept
>>>>> unchanged in terms of definitions and expectation. The same project can be build for both
>>>>> FastRPC and QDA based on configure options. So, the applications using github/fastrpc should
>>>>> not face any problem if the libs is built with proper configure options.
>>>>>
>>>> You're assuming that the kernel and userspace are a unified piece of
>>>> software, they are not. It must be possible for me to install a new
>>>> kernel package without having to replace the userspace libraries.
>>> Thank you Bjorn for providing the inputs. 
>>>
>>> I also foresee that we will be stop adding (or already happened) new features
>>> into the existing fastrpc driver, so calling the new driver as an alternative
>>> is in oversold category.
>>>
>>> You are pretty much began the deprecating the existing fastrpc driver, so let's
>>> just mention it if that is the case and provide migration/shim path so that
>>> existing binaries doesn't break.
>> I agree that we need a migration path, but I'd really focus on it after
>> getting at least basic parts of the QDA reviewed and agreed upon.
>> Otherwise the shim layer will be reworked again and again with no
>> immediate added benefit.
>>
> I am fine with the review to be continued, this is RFC series anyway. We should also decide
> the design of the shim layer here as well. I prefer to not have multiple
> RFC revisions here if we don't agree on the basic requirements which
> leads to acceptance of this new driver. 

Just wanted to provide an update here, I'm currently working on a new
version of this driver with majority of comments addressed.

I'm thinking of including limited functionalities (say, init, gem_alloc, invoke)
as of now along with a minimal compat/shim driver.

The compat driver is currently planned in the same drivers/accel/qda path which
will be exposing same interfaces(device nodes and ioctls) as fastrpc and simply
route the calls to QDA. Please let me know if you see any concerns with this. I
can rework my approach before sending the v1 of actual patch series.

//Ekansh

>
> ---Trilok Soni

