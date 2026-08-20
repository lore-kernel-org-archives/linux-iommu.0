Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0908448D15
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231841; cv=none; b=iNmCEqvNH4c7DSBdR+vxhuHrbdYz/QkF1pq/RAfsu3qwfrT2PL4KINdhR/6fansu6ojZHjFZX2GWktRuV0yxA7TG/3o+1cJsGVAWYwUO+tKf7WFXM1T3cje3Q2XDcivLwaQDSyJEmSCmEtfrk74ZLilUsc0nVVnX2QHfoFXehyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231841; c=relaxed/simple;
	bh=1CnNo5c3+W4kz6Kt7wqmydjbAinEf2KlvzTzD+ptxmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtMpnADTln5/DDEzUiehMjjZpQwKNz4G8Vjs6bTgrKTTtCabYKV0NzOvrl3jugWOf3I2zeg1p5xPtP9fT2YAH+0RthLGxDvYdPYlDf0TIwLPzt/NODT+EBNPjhDmdd6c5z+5vx8NhoHEavNBxDDdskfyGpNMjivAWdtfUalEdeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gmoEhjUd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZNScMnIt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmoEhjUd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZNScMnIt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8PERY2465462
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 13:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FRn7XK+ROzWG2rvgcKJwV7AzQsMgAI1TASr45vyqJ98=; b=gmoEhjUdDJpy3Un7
	/05JKM/eYIVdcr6EnZripaPAzrd+h18Y3/X4BYTI1o9xfVe3V9Tl9rUy2CfpyEVZ
	yrTcp/V7k5Oy31pSO4x8XRACgLa7ATmqePbt+0E12TuFjTX+1JyH/nXayvJfsYYN
	CEdwN4sv13gS3VDObVLzPhxRCSeyzH8FvRDuOD1Oc3/R5czay27AoE/19XJY+xz/
	CVLEl/bbEVrodJd/I7qw87+Ut4tMpKsAMHeMdp7WD4TqUHgocIMV6yWiRsW/2/Gx
	s0yBt/SS1Gg8oli0M66XIDC/mVKLNPqUeZPEDvIUd1gR64Elbgf0U9J6io6uPf4z
	Xmpdog==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29h2ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 13:17:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso2786416a91.0
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787231838; x=1787836638; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRn7XK+ROzWG2rvgcKJwV7AzQsMgAI1TASr45vyqJ98=;
        b=ZNScMnItYfsMmyxjI4dspCoW2UM+fc94wN8e1emiNv1Cu7zw9eXPSIhDlcxGpFZGTr
         2Bd7aZNKOb9hb9S64qYSloWjwoYX140qntOTZcxHRgxt4Y7ebmLMO5x6moPWTZN3hWRj
         peR70qc3yGpJ5m3AsMv00p3uz101ZmliIG+Qp4dray/dwEDYpg9vbaT8Qb5NjDrsY97S
         EaC+QwaNytu2jaC8WIlioW4oAv9FmwDyFZ82nSOM4+HrxLZrhmKe8GQWiblcueHtUN6A
         rieaCPT2pPlbT72zw4N4Zqa9wSwOMUsaRecM0ImBpDaoTXkTJylyx0jAoqVyRaqwhCzr
         w8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231838; x=1787836638;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRn7XK+ROzWG2rvgcKJwV7AzQsMgAI1TASr45vyqJ98=;
        b=ZHkrML5+R3TUOKm29GoCSLD3q4wdnfg56MkhYkT5JQwcjZ9Ys1XebUItG2AAxIDRMW
         3fgeu9YnhiIaQoIqi5GVKgcNu0KMO8iYklYaMSPq3lpBT43RL558uyANkd9nsLPzeJON
         HQKH/Zd3dQRmZ/1g0Tsd9oBc/b2VjVI1v4vovY7hqmK33xCSgfZ3LE10zS71qKsiYhJw
         bdCk/Qhqc9VfFpk6nt0UD4846AzJpAesJk+X3eO5RZxC8tJ3UchMut7dFAZ55HwFO6w5
         GkFWvy4AtO8fgM44XQ6chZqwvPUu/CE0ogNNVHczoBQYnW/Xr6lrEt+n0ufU8ZLiCF+U
         /9OA==
X-Forwarded-Encrypted: i=1; AHgh+RrfHqXukwlGcoq2NgTOI2ory44swWdIzSrF1rlGCk2OcDZ50jp06WASjJkujtUqk+lCqlZ37Q==@lists.linux.dev
X-Gm-Message-State: AFuF++ntwFli1Tm7CwQIb8QMAD7Gseih7G9+NZwTDhbh+xnwIpk1A+j7
	wsGJXHSZTtV4gG66HBotcv3kKeVi8tyllN0cTNCQWG8/OXaNBu1FQn4Es1SQgS4riqTybsR3rcg
	3JGjuqYLEXfLJtLFWg9Ib41FO6q3EFCfdNf8HvmrsUF8SLLcB8E2Q9kj00w==
X-Gm-Gg: AR+sD12YaJZ6MtPui/qc1aYPOXzj2H8nj+cD+vD3OVQgoX4Ao2YDqmiIv6cKxcWWn+v
	LU+v+3yooiCXfnz0WmhFKdy8/YduSZ3JVaQiiuTuKXHRMIVO6yKHvEcbYTC+vtYNV3UIs1FXgSU
	O6KUHgVvqWS3VLHuFezVHkUxMPR8L67PSNwQpX2ddPRDCfZv/39mpY8WCm6+pNwfXpCBFC3NbDr
	tVpZPdnlIlEVrXznkmiWZ9IyoVb3L60GYuy2nkgmAHaDMjtnc4Labke4p+byryAW4jOWBRFrt6K
	7Tdbic3Y75h1qnDLxpBugv1q6Rt0s+5Kig7jfq+mcDxVAVbpXw7jYoNvmSQsleNfxRFPZT0sRTb
	A9bvIp3707W6EGmWC/d/4hlZhCxkszA==
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3958110cfc4mr24511137a91.9.1787231837570;
        Thu, 20 Aug 2026 06:17:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3958110cfc4mr24511026a91.9.1787231837065;
        Thu, 20 Aug 2026 06:17:17 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae143edsm32627819c88.10.2026.08.20.06.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 06:17:16 -0700 (PDT)
Message-ID: <d39fe14b-1fd6-476e-9e5e-f4030c60b66c@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 18:47:05 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
To: Jason Gunthorpe <jgg@ziepe.ca>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>
 <20260817134416.GA1415075@ziepe.ca>
 <89ec74da-15ed-4278-b651-5c753fa4f146@oss.qualcomm.com>
 <20260818130724.GA5482@ziepe.ca>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260818130724.GA5482@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GGudil-40-LBSNcnFeDDT-VWGHxxkv4G
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a86fe5e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8 a=gAPlAFmufI-heuDFQeYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5OSBTYWx0ZWRfX4grPFLMHxB7N
 7D40neM1s1TsJyz6bznLBjZFtyEMPeuk1/1w3tK7UH6TcmgOLfZ0pv7Z7gCOcO9F06vi+nvioKJ
 tUQExBWrlSfYG+1DkqfgmovQxfWZLM0dMUZgdP1AroJ3Bs0eUm9Fda/yqEcn8Dm9dXr5hyAyFuj
 gY5tiGa6SMBOHGhPJRYxgZm5KCJyVBWbAnJC0EDDXhqn+n3+Qzcznmrw8BlYk2r69tCPbbYIvQk
 uwVkJX1puyxfRNuvDcnlSzXotFS1eBLPQlhAo6eH0pcJ5OsbZCwhPqFBg4e/jV/AWkt3b1uIUXi
 zpmKNvgDdz/iBBsYwjYVclf/qyfckW3x7F1i6WAGm1KivtS6TZHLK0YKLeBw2RRt0trj2VNidmN
 rUsc1hzTQw9PS3IbkPua1Y0Lo/NojFz8rMzyC40SZpYdb+iqeiDMApCMC/pxXxKn+c0zCPFEQjZ
 AX7oK6nW/0QNP8aTFYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5OSBTYWx0ZWRfXwBezZ+/r3dTa
 lOzQ6RXa1SfkDuq5VG2s6jBLYr56NkiN1pf7L/3zEl0TPGFpY+ys14QNW97lBZ6g31KhsCX0Zsv
 slyNZ2gMDnvevOkdNb8cYxcPri4qT7w=
X-Proofpoint-GUID: GGudil-40-LBSNcnFeDDT-VWGHxxkv4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200099

On 18-08-2026 18:37, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2026 at 10:40:25AM +0530, Ekansh Gupta wrote:
> 
>> The CB child nodes are not separate addressable hardware — they are SMMU
>> stream-ID assignments described as sub-resources of the parent DSP
>> interface. 
> 
> So this is exactly the same thing.
> 
> Read my remarks here:
> https://lore.kernel.org/linux-iommu/20260618151745.GD231643@ziepe.ca/
> 
> The DT modeling for devices that have multiple stream-IDs is to list
> them all in iommus list.
> 
> If you don't like that DT modeling then you need to start out by
> explaining why not very clearly.
> 
> There is undeniably a Linux gap where it forces all streams in the
> iommus property to share a translation. This is a *linux* problem in
> the iommu subsystem and DMA API. In an ideal world it should not be
> fixed by hacking up new busses or mangling the DT.
> 
> But of the easy options I think hacking in new busses is the worst
> option and has already been basically NAK'd for the hamoa project so
> please don't use it here for a diferent qualcomm IP.
> 
> Given several qualcomm chips now have this same issue I strongly
> suggest qualcomm consider trying to fix the root cause and provide
> some way for a Linux driver to progmatically "unbundle" the multiple
> streams.
> 
> It would be much easier if the HW properly supported actual sub
> streams as we do already have a programming model for PASID. Maybe
> some kind of driver thing to reconstruct the iommus so that each entry
> is exposed as a PASID in the API instead of an alias or something like
> that would be an easy direction.
> 
> Jason
Hi Jason,

Thank you for the detailed analysis and the pointers to the VPU
discussion. I understand your concern about proliferating custom buses
for this class of problem.

I'm exploring an alternative approach that avoids the custom bus
entirely and will try to address this in the next revision.

//Ekansh
