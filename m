Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124D345731
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274479; cv=none; b=lsjefX677+vEXaTeWqPgmpssricT70WCyjT+A4ePBFtGnKUoBLTSHTJh5aCSqyeoJoOWRjjh/5lw2wrgE2qBKKpMJ8d1awhpq9ZAzICrM6UMyuvgArVxkk70d3yH+arTMcE2KzTnEeZOmWLb7Le5HeC3TeE+VUDQ8z8bqTqXJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274479; c=relaxed/simple;
	bh=PTd4B5uhCcPDIe5w9NIhHzaDs9hz6KZ6USjgaGgCaFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKzBC39v9nc8iosCqJ+AkpAeI23zFb0EU/xACGV39hpGJsKXvoGtYSmVhXY8f3Ysj90AeX0x9S2w4VGacoMBEAHKpP62c7SHmqvw7AJwbnMuOf75ofMOXjMcei6eSpTPTQMW75WBGho74A36VOhHPvDYJmJnS3nOl/DIqTqzB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIzZLNQr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z5hIIuAc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIzZLNQr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z5hIIuAc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FEl2BJ579807
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 17:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vbR6uymC69o6Z8rsQWYUozstbIH9JlydsnIlYMif8rU=; b=gIzZLNQr3c5GZpCJ
	DAvLsiqk4yCnL+T32P+6t65uFnVeGd2BAl53FHVbbg2nXX57DxzV55EGKRtYNG69
	tUKwuIUPSddrCy95Aofs1v1BEhC+BJiX/rdMX06n+/4vv7GlsdJH2bQVycq62kKi
	0osILBVmxC4qNHfKWVjpniLeU+MiN18L25ako0u7QF+P0P9p16DBY0IJs8441zT9
	ADJ7dUgvDlK3Qh52UJGE3buGYoT9tMgzv/ugXRs4Tk5EJhrkXGfMXEEJVfMRojvZ
	2zezmIw0SvNZr69FLxes7jKlICbPW+dOc1xewDhjWlLgnjTJFMvMmuRnmjUqLb59
	K42vQw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcr8rkyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 17:34:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4530a90fdso85716965ad.1
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776274476; x=1776879276; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbR6uymC69o6Z8rsQWYUozstbIH9JlydsnIlYMif8rU=;
        b=Z5hIIuAco3mdZZqmZqnhxoRtSqVBtGXwhL4fuLokerJrnERF/OgiAR4Px5uUrXMY6C
         N6CVPt8VCySWc0mW1eZe54UsnakZS2QVSU5smho3Wx8m4etn975HVWaI5IEFzwrV6bJ3
         r/38Ln5u2zg1AcZliE5Z5tEgM0VtNf6mItUB2jlzIsaOqt09ZGslQL7Nxh5dJvBcBELq
         7tuT3PJnk+FtXPZe13kjbnLWP1YmISH9PBIYbCW4XenentYP9ciypNeb5swETOPu7+Tm
         9CfYFHb25Dvob/mVTMYpEuDrAoHT0U0+zISVSVdky1cDe1TX/ux6TuDGEpZMqxsFv+j8
         nkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274476; x=1776879276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbR6uymC69o6Z8rsQWYUozstbIH9JlydsnIlYMif8rU=;
        b=lBhzZv4Sg7bjqcS78udqTwRikeheMTLlTIKES9ish526XEN/QXeyzIDaz3YJ2mQGaK
         L6eDxYShb3FHinO3N5P1SRdF1+efeaYoq/j9NNZRldRt2pjcC47tuysimQcXeS2uisAD
         8Dguh48yDp7swcXhqsSm8W1ySSJsLksQUKQlljlTm+yO6oO97S8AQDFYefOP9x11bADy
         QkTS1w/dbK09FCmxpjBg7wbGRuIBslOyzRoG39jZ+NJEREPrWh/tJDMecBxkSw9eehgM
         YBrupdPqYdoEOxc/2e+IUkhRP+EJ+ac7jkbYGIRlrz4B3kIJM/vCBnnqBuwFW5SRLfO2
         1IKw==
X-Forwarded-Encrypted: i=1; AFNElJ/kvXAM/aMRZfiQeWhhEaWgtlpiBGzWCWeyMIsSaKjtmxUU+d3OI/cI/+At7pH54ClLsMIf+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQakoKjYZ0t3FpCC2LmxbpDZ0PecqxGIgTACGb5+qzvx9q6hhI
	ps1KKalM2XacnVk/lLFEo46RK3Bdtq6BEotBc3U0SxiZs2n2TFKv5bR1QEpY3Zryq5vId6VlZM8
	fSAj0Z8xwk49fuUVhBoYr8TS7LTrF7PFec01jk6g+Csa6Q3W5e3llTnPiaQ==
X-Gm-Gg: AeBDieuCQzG4IXuneVYuXzLaYzx048f+7KXpsZvw6kqXe2K1DoXs6HV8tabx7MdjEcy
	qPHKq+dFN2liLIKAA0p1guR+KRyUALWFCcwNEuTtp1POXMl1CCwVnEaVUJRQZQgMMM83uJxyeZ4
	2DRI91raZY/pHxHyvLbKf2UVBvBZdRNI91lAHR9JXkxxvceIZU1bMkQp/iDK74wesI0trN41odj
	HlkoxK0rHnCPnB/k0Gut34nUmcIuWuCEi1KBLqFa6ij+ZwClfE6k62tLGKm5gmeWbAtOjP8GcD/
	8IvQgv67HQLq/Q1yBtZoX+LWIfuKefyfWVajcrYGZyhvu/FVJGI6OfpgcEawrXHsMvOrAdJB+yg
	0I8VRI0eSChi7QHJlsriXvHrcg5y0dqF7wu0HFj+h6KRk6sMoiBMg8w==
X-Received: by 2002:a17:902:6949:b0:2b2:b117:1e16 with SMTP id d9443c01a7336-2b2d5a459ffmr160044625ad.20.1776274475845;
        Wed, 15 Apr 2026 10:34:35 -0700 (PDT)
X-Received: by 2002:a17:902:6949:b0:2b2:b117:1e16 with SMTP id d9443c01a7336-2b2d5a459ffmr160044375ad.20.1776274475300;
        Wed, 15 Apr 2026 10:34:35 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47810b70csm25397215ad.23.2026.04.15.10.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 10:34:34 -0700 (PDT)
Message-ID: <c4f21420-c299-f161-2bf7-c9b79ca15037@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 23:04:26 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] drivers: base: Add generic context device bus
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ekansh.gupta@oss.qualcomm.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
 <2026041418-volley-composer-6363@gregkh>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <2026041418-volley-composer-6363@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gc8nWwXL c=1 sm=1 tr=0 ts=69dfcc2c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=xRG3GzwA0ZaNjhFdG0MA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ys5eGBFCf8vgTUq9zxeJ1nz_Z2JzaBwh
X-Proofpoint-ORIG-GUID: ys5eGBFCf8vgTUq9zxeJ1nz_Z2JzaBwh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE2MyBTYWx0ZWRfX5GThgWFfBvh9
 RNuUE9dMA5nmnQw/Qf5ZNGqYdM211vkdz0Hnv8cyD483nP1DOUC2wT/O4/vfpWoJhIPJ4hHxmgG
 1QqCmC4o56H+neaHSMNQiteGi9Wq3sm4BPmUO4YaHAghgwQyaUfIP8IZ+ib4GAN3dkcGM03a1XR
 dKyrrDMRRxXVKfFB42mTqigmaagAkuO8KtugMPfcFA61nGuwajS9mk/Lgt2bH/fe2BK7mia61DP
 Il2a5wRc5gB9rPNT52j612pedpApDLeckBFua6Za5yovlJlJxcA//+tLIotGXxMeLkwEkdKDn/o
 3wBoukD0rieFv0mHNEHbNE/zzI+DgktOYhzWh9QOOPqTJ4SXDOkFLDP81htStH6fHGj7yjTibdG
 9on783m5Y3IFePXmQeOUL+I0CJ7IhKVJEoT2xf9tUvYnFxp9oulR9LPMtPeyfCWIzlFaSJaB98i
 GAmDRN0r3ZexQzGsVHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150163



On 4/14/2026 10:19 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 14, 2026 at 10:01:15PM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce a new generic bus type for synthetic context bank devices
>> that require IOMMU context isolation. This bus provides a shared
>> infrastructure for accelerator and GPU drivers that create virtual
>> devices representing IOMMU context banks.
>>
>> Currently, drivers like host1x implement their own bus types for
>> context devices. This generic implementation allows multiple drivers
>> to share the same bus infrastructure, simplifying the IOMMU subsystem
>> integration and reducing code duplication.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>   drivers/base/Kconfig        |  3 +++
>>   drivers/base/Makefile       |  1 +
>>   drivers/base/context_bus.c  | 24 ++++++++++++++++++++++++
>>   include/linux/context_bus.h | 15 +++++++++++++++
>>   4 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> index f7d385cbd3ba..479bc4bb442b 100644
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -4,6 +4,9 @@ menu "Generic Driver Options"
>>   config AUXILIARY_BUS
>>   	bool
>>   
>> +config CONTEXT_DEVICE_BUS
>> +	bool
> 
> So this is a context-free bus?  I.e. no documentation?
> 
> :)
> 
> This feels really odd, this "bus" isn't doing anything at all.  So why
> do you need it and can't use auxbus or faux?

Looks like the device have specific iommu configuration (via 
of_dma_configure()), then using the auxbus or faux bus types does not 
have the bus notifier calls to iommu_release_device(). Please correct me 
if I misunderstood?

> 
> You say something about an iommu, but yet this has no information about
> an iommu at all, so why are they somehow special?
> 
> You need to provide a lot more information here, sorry.
> 
> greg k-h
> 
> 
