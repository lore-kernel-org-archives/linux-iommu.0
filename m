Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2E43CE6E
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420002; cv=none; b=I09qqzBsg3KxTRAfr/YHt8WXOZomKKG7+QD0P710pf4jrGsEnQ5ru8eB1T0EXDCoA+R1fOS7Gsk2GPYCuHxYsR2CNnN1nBBZLDoPngPP9wj3P2ZNB2Kkj6eT3aUAmElc6HxPtTYHw87Wm9EG19LhXNXP8MRpBUdFLqDv1h6jPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420002; c=relaxed/simple;
	bh=2MKJpYCcEmBvomCNL8/c/RcwMm5yPaziZOFjzrfdOOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwL43+F2Jo9Sx9ZYawccTtn8Rsr+XcgvCf36BteijwiITG5VGjraKdx6JtzG3SIEGQUcH65wFUJB5IvCUpz754XgqOkazjAVA1WHZfdwzbZV8AIAuuZJ7CsoFdy4VdyAPCCsNzZZEEt+EhbKKlNhMoVT7G1o75JNevizxZWaDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UIz+yc2X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eC9ZdOEK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UIz+yc2X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eC9ZdOEK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDTMU920548
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bx2xLoU9ox3YzTyuhkOQkmhNLpIKdS9tw9DJDHAPc0U=; b=UIz+yc2X1jEWPTdy
	WwXtE1QE92TeVS/mdHfvjN1HOxbYI5AssW4CqRojNV+GVWWcAnYIrTEMecbvK6Jb
	fFgdCdLu2kyJ8aZU6AhZEUrfqR8Vvqmw681XXVd+zR9YEu94Z6wQAK0YHJMYjgv/
	N6HPqlAfX4h+YoiRD/J2AyvnohJFzMYurtcWM8zIxCiU3pKWE13PGOgVFc2G9Tsi
	BqWBp5xJrtCIOXCg7DmAbGDCvp/CKVFAoNscQJ/NMblywndCwTwCu4FS0JYp9seL
	Za9QOZ0URQML8NPSoTxKKXLyV9uP1UnnUkfHrekEnNGCXGZOPjbnMg5E9i89VKdW
	TCqwiw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6s1rbp4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:59:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c21be5bb4so3476021cf.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785419994; x=1786024794; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bx2xLoU9ox3YzTyuhkOQkmhNLpIKdS9tw9DJDHAPc0U=;
        b=eC9ZdOEKpWRkbwHPZ0bua6WQVNLjGFD8PqCSinGIGD4XyepQNrHjcuuISVHvXBt5Xv
         RjV9jUws+n7Jt9TgTbY9mPtI6hovZXuJwCIqgIO5YsI+JVeDlqO9M0BDbCgsI+vAOAqT
         3GhY05yoppwRGZ4vsUE0VS/mvNCLu77Oa8ERstXDOZesZLsMvgjYbcJ0vowTcc7NFGWO
         gTWpqPtUtbBj7dDuqcprBtfqAav06nga1lkm96X5+ONlSmw5l0iP5tPdDKzbNVXU4OJ+
         p3H1j+vX9CTqXUtPKjJhmNgXCR7zd6KW8EFKR74sAGJANgahTJK9xUc4i7O48cXEe8qF
         Q4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419994; x=1786024794;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bx2xLoU9ox3YzTyuhkOQkmhNLpIKdS9tw9DJDHAPc0U=;
        b=RkkUQbz70Q21InzWfq+bKe87hnq8P5oN+lg3TQ0yRPM1xdJC7fagr9zMoyrsqyOZ/h
         IkE+05Sc1hG16atbnFmgkTWlQQG0mmglsN10uc1Jk60E6+P2C+3mNNnEWHhOkUF/pBNw
         glrbTlsG1rdZxsb7BlBzn81NEGv4naTsQ1koOdsQOBNarK87GIQhxTeyNy/5JxoHIxjG
         mp2uZHuFsfcBkmi8UhNQc7gvZ+EQvRSZYFIrm7qYb5QoEj1GCzLWFpNgeDH2Vfflu69/
         Lm97vfUwqJAfmsvN3sKpYaLSs6tfk0FhRL5dUnYp5ch8pAia/QQFzogoJCYiB+3MCmDd
         O4qA==
X-Forwarded-Encrypted: i=1; AHgh+RrGAu19E1lc3HgtZHW0k1kniBfeJVkef7dol73qFeYOM1tEuNoY1voVHhq34HPfQJYrENrFiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFrvv89faB+stmNA8AtsXJUn9u86V+itnC5DIyUt1Ph09yFQTR
	XSwylf7tbCKb+R3f8YoVQLr9wwrULsYGZ1x2VImopXsM2QilaYGTZ90M+2ElXeBNAZhFlMCypH6
	9Az5BErole1V7xYzQvdx0i4YlX+vAznj/0fWFjlIYRpRopJlYumwa8PPTjQ==
X-Gm-Gg: AR+sD11DEvP3e0CAT0UqPJIp1pwrOtCyqMl/B2ovvj7vogoCaryRfJUT9YPWEuo7P4v
	r4LMHetIVIUcqVnVC9c5TLLoKYUh9fv4ko9fH/A0JOtJo1FAj2ZK5XARKjX7vij/o1+pI+3XCNI
	ZPW4W9HluyQ3aOfJ7J4ad3/WEiXgQyJlZH9aC2p3TexGYTremJFBz+XmWAcmoEuVsYwoRBPZQU7
	jirSickhJv6NHl/bO+1GaGXLmbNRLQp/PBnkCBf4fQGFxXctU1VNEpQ6rdoJy7tSq70UcbDV46b
	HF94+ayZ6yUV3yvcuConP3GxQzPWLYOwns/lyZvcxKf/ki7Hs5Gcfp5uqO8fUi0M9wBtpV2IIHU
	/MOcnJ8EN+y9B065CX1+mcD2f
X-Received: by 2002:a05:622a:a990:10b0:50f:b9a6:82ae with SMTP id d75a77b69052e-52b42b4deb6mr3957991cf.2.1785419993995;
        Thu, 30 Jul 2026 06:59:53 -0700 (PDT)
X-Received: by 2002:a05:622a:a990:10b0:50f:b9a6:82ae with SMTP id d75a77b69052e-52b42b4deb6mr3957631cf.2.1785419993517;
        Thu, 30 Jul 2026 06:59:53 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8576a3dsm71944066b.14.2026.07.30.06.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 06:59:52 -0700 (PDT)
Message-ID: <9d43109a-6c4a-4339-bf8f-de3aae6e25a6@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 15:59:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm: detach the ARM DMA mapping before attaching
 our own domain
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
 <8e55ef12-6c4a-42b4-923b-238b3739ea51@oss.qualcomm.com>
 <h3rfonvwkxkmschyypytwgwxbmnq4rou4iyk6iq577c5tcfdl2@zrz3xhfzpmlr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <h3rfonvwkxkmschyypytwgwxbmnq4rou4iyk6iq577c5tcfdl2@zrz3xhfzpmlr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dZ6H8sAacHP_Jx24Uk3Si4_YDmbU_wgB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfXwjL7ve/diYcj
 FoAtHDSJeko7uYXJlovuYp/s7J1ZNNAkBgijWhKbkn/z6GK0c1okRmn7gHa9p9rueJwfMz6fD16
 3AVAsFUKQqKXImvT741SmS3+1rCi39M=
X-Authority-Analysis: v=2.4 cv=EK42FVZC c=1 sm=1 tr=0 ts=6a6b58de cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=FAOltU6waKXSbT9yybQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: dZ6H8sAacHP_Jx24Uk3Si4_YDmbU_wgB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfX9jyjk1EZgg48
 LTwgF0IAgXXx9pm3Xl/SebsW1dC6CydzRrg2bPAR361ZjXyUHbDOB7RiyydDvnq9USysjk/2xB+
 K3MC3asBpFnwCeRDfNy76WoYCfTEAuXr2nAxTQ+d1CidtyGTslCo8bxCE1o0hZ+hbjtochh+hfM
 GtINTrlxMl09dV2+V9z5K44si44qg/DEwbAnkfJi8TRSGu34pzpwaGSvPQrdpPEg1KzrXtVEFKJ
 daCcLWQn8EhKMLbI51LloU+R32EKIkU76nKmDUqObHY3sYD5/ADLWv89YC3fcLZvSeJAJzVQdC2
 NbQOwzdc1qFXgtOaScL48cTy5E+9tJ1Qs8Jbl2Gy3DY/D2pFd0KhtIxFUFjYIgBFm2FJhAusNf0
 uRRJtVFgPkZT/qC7QBvzBpOzndq1EENjW3+RT32nDKAfN/dTsj4voTewaqsClikKoxsD6PwX8Tl
 kuWiROK8G7wimSnQoJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300106

On 7/30/26 3:58 PM, Dmitry Baryshkov wrote:
> On Thu, Jul 30, 2026 at 03:42:58PM +0200, Konrad Dybcio wrote:
>> On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
>>> On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
>>> dma_iommu_mapping for every IOMMU-backed device and attaches its domain
>>> to the device's IOMMU group. That domain is neither the group's default
>>> nor its blocking domain, so when msm_iommu_new() later attaches the
>>> domain the driver manages itself, __iommu_attach_group() refuses it:
>>
>> [...]
>>
>>> +#if defined(CONFIG_ARM_DMA_USE_IOMMU)
>>> +#include <asm/dma-iommu.h>
>>> +#else
>>> +#define arm_iommu_detach_device(...)	({ })
>>> +#define arm_iommu_release_mapping(...)	({ })
>>> +#define to_dma_iommu_mapping(dev)	NULL
>>> +#endif
>>
>> I see this is prior art, but should we support this config being off?
> 
> Yes. For example, on arm64.

Right

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
