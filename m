Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01B2EC0A6
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440231; cv=none; b=krTtrl55cXBFesBh8SptkAnsEqVNHiC+nvXoL3AsENIgxATx6+VAjaaM+FUiVXgOZtttZWgX/sUJnk1g6VJirNsHP1f0YrkirNdgxYS8k1uBHIkB9rlKoaFfEh6MGL1ezxW1QArFj3VICLcqI3S16ogZaDro2IhQkxeY2y6NOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440231; c=relaxed/simple;
	bh=qJ6XgO+Z4q2nOaiJ/NRiGVTsW6eC14GjcLX2jUr7Ygo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eo+Hkp+lobRvnxHwf7Xkdhc0UQ2cLRuBmM9hqhaPa6IHuu0HzyxYIwQ2PpF66kDwI3ZoYp2OE3qjojDcdS7pENJ33oJnzTnxXqd+chwwdJHbqQiypS+dqnKPyULXAuFbLI7JVgkHCnbhicU9sGBdmd1qYTHpio9ANK8n+SodjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PYcNLUAL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1vDLPvW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYcNLUAL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1vDLPvW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H8tZLw1971720
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W/kp6DxhkJC40rZeKpLXVuU3JvhzGifeqaHkyOv4r28=; b=PYcNLUAL58xTzjmZ
	6dq8x6LcZH+1TF+hilB3lsT8//NZYMLo7Kw11FWkGB/B2RLZvbhHQT+uw3y8FKlO
	UgSAbJJYQKld7kKAIbYwbZHd7AQmCJWXWDMMmZDQ1Y6G6L0ByDA9K0d2bzU4QclT
	PgcsiVpNukuEBLx5Rlr0sxNodY92yocCM7rxoDCP/WT8SdCRbVHoICh+YvXbKIB0
	lP86jCKc20Bf8LN1FX8yzfrQgN3R2l41JiLsoS6o64mnPZ+1BRDHR529gp/bmngI
	75zdxxmCurkua8Fh7NVNpeRZq0qnRmdilA4NmnTTQEKnn+3FrCSPki8tmbbM6apr
	2yK1uQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhsh9dxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:37:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so15489705ad.0
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776440228; x=1777045028; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/kp6DxhkJC40rZeKpLXVuU3JvhzGifeqaHkyOv4r28=;
        b=L1vDLPvW8kii7EZ93ABnI9MUp1s4U1X2sX2zGvLiRnrTiwEd3R5He19Up493LWu0px
         WFq0lHJqdfQwx/eLETNwPXQpz/6oY9CTcU+ZjBT4oaZjS/n7EOp9CPYUr3eYKZ9k5A2c
         SWWdyNvm2+QGX5b9SRPWsUPR05lcrr6S49OZ/OJ6apQgc34ERnAln0PSO10gopFdHX/y
         O4Dl07e7my4WMjgnesBNPRpTc5IGw8ChatrCMascVC2npvTvsAOckuAfxjA8XrPdrwGa
         5sCbx2uX1PUw0LD2h41hyYPPYWScMCanDCz7T7D4A1LWuRUfgC5CrpNQJDea3jXQ8RXU
         ml0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440228; x=1777045028;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/kp6DxhkJC40rZeKpLXVuU3JvhzGifeqaHkyOv4r28=;
        b=o0cQnvuXbch0U36MnFJL2QFoRqZZwVSdHgYck45B1i/REyd+M8iI5M8qyUN6ujOJrf
         v/LjlcFr0vjz4rVnsG+iJk+DGzVIxZL6feu4+WntmUyMrGBRjew8vxnYtMZ1AXXZgVZD
         F3EWwd31iP0SjvSBy+lRWdAYbdFy47dTrw15o6k4psqFZeSb4m2aXpH1WRk9Tmy0ilHR
         x4QFh6iXsb82ceJcnX7LiFj8bwz2XCttXJbhpwh6smPtdpe7y5vn2roPHSEjg0pWhqkz
         2vMep/RYBNb6FHrEMIY5uo+4XPK3wq/tJj0lTQSkZSVr7sfVOSoarExxprsVaYwWvUhY
         CaoA==
X-Forwarded-Encrypted: i=1; AFNElJ/gvOsCwm/MHkbGw9P6seJJqSxMZDkhfs2qY5SVIuh1v9RPJ+T3duM/HI/CPd1WRw8LVoJf1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTDAYaw/wdyyzh7tCkyeCRFAlRxotrzQeyvoBnkCXJLw3k44nT
	/gQYo5oJc69FQ8aSyxaqAWky5wsC/sfcr6mAjJUr4EvnsblVPqHIITw6YUouayPNFWPXk4lCte4
	TAv8XFetS1f7NF4u/B9cEtZXi0q+GiPJioX2Z9VINLzICD8ZixK8+SJpTwQ==
X-Gm-Gg: AeBDietvKHTCr7wy1j7CXazEyKJqTuC00AL8lNQN5vJHy/hn48X6Jh1jb5iUCJuOkqJ
	zYhG+CHfe7eTry8rKF1ueHyQ/ZCJ2ToW6jt+u6RTodtqKRmc10sy4i5dehW1pB6MxV0i5u8smxw
	Gqw87eQ4w8NoDVnmlHYH39jUewBt3rpEl8LiX9pnpvNepJR/yFLBCCzTCdK/R4j/QRxJ1EnZFQo
	aipsvDKc1ZkugN2sa732XrfKoi+Ed8hCdQijEori0xO110uZGUJm/T+IUryOJlBSaioVC232NKM
	AEQQP4nTabYIXBDBawNMvDhPN4XEm1gAqoXscKurVJJFmM72ZAaE1QmatFLl6I8Kae54HFPh9yh
	ytegRpQ6Bpu0Zohb4mer+30ehGh1GGDLSi5quqLJMFOjqVKq9u5YSMmir2YKZGEQ2
X-Received: by 2002:a17:902:f788:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b5f9eaea76mr40171355ad.11.1776440227754;
        Fri, 17 Apr 2026 08:37:07 -0700 (PDT)
X-Received: by 2002:a17:902:f788:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b5f9eaea76mr40170805ad.11.1776440227220;
        Fri, 17 Apr 2026 08:37:07 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff390sm23819975ad.9.2026.04.17.08.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:37:06 -0700 (PDT)
Message-ID: <f811d6fc-bee5-bcf2-bbbc-408b777536d9@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 21:06:58 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 09/11] media: iris: Add support to select core for dual
 core platforms
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-9-7d3d1cf57b16@oss.qualcomm.com>
 <d1834575-768e-4805-9e21-50a796690bda@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d1834575-768e-4805-9e21-50a796690bda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d6/FDxjE c=1 sm=1 tr=0 ts=69e253a4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=039WMPxP2uN8QpXWscsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 2pruoDVyLgvITA95BLDKGOkjUxfH-aCK
X-Proofpoint-ORIG-GUID: 2pruoDVyLgvITA95BLDKGOkjUxfH-aCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NyBTYWx0ZWRfX2xevj/XnyQFG
 JwFHdlyhJB7pe4cTcloSJ+XCGBGnECT+YwLp+yYw+AVr4QH1sLRbB/8ETGIa6iEUyS5MEOIU3Ev
 xANbpeZekzM3WxJ7YeP0Xmm3vHEDmjo7J2cuHjsLMl4wEM51Vo6P+keI4Na3821BY/sG/oJ5F8B
 3VfZwntRKnViXE9YULpbgeLiT9dLiAtoVaGkG9kWP6P0DuUjAgUGPtLg/7jXrZTt7l1AOtY0UCq
 2Ln/VgpiFLBMxBLG8JJ36/vg3d/8/+rsFybNwSrW1B0yQiRB8UTX7GWgWksZvMrWPF28ICk3Mid
 VeLIa99dYL2AMf9OZdX/i10SKgNLFrF45XD5u5u4xf2r8LHcV8X9miw+crR0JXBxyGUVZyX1lUi
 ee/TM4jiJtd2bYq8yGYUjCLkmMRghAebuYEmtGlVR9muhc/fPYFAYzqaZNX2EdFIKdWosewVJCY
 lx/jhHbpe22ZneVlfOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170157


On 4/14/2026 3:21 PM, Konrad Dybcio wrote:
> On 4/14/26 7:00 AM, Vishnu Reddy wrote:
>> Select the hardware core (vcodec) for a session, based on load when the
>> platform supports dual vcodec cores. Assign the session to vcodec if its
>> MBPF/MBPS capacity allows it, otherwise assign to vcodec1. Communicate
>> the selected vcodec core to firmware using new HFI_PROP_CORE_ID property.
>>
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
> [...]
>
>> +	if (core_mbpf[0] + new_mbpf <= max_core_mbpf)
>> +		inst->core_id = BIT(0);
>> +	else if (dual_core && core_mbpf[1] + new_mbpf <= max_core_mbpf)
>> +		inst->core_id = BIT(1);
> Let's store the core ID as an index and only wrap it in BIT() where
> necessary to pass into the firmware

For the current instance, I'm marking the inst->core_id = 0 at initial 
to skip that current inst
for the calculation of current load. If we store index in core_id, then 
need to pass the current
inst to iris_get_core_load() and additional check required in that 
function for proper core load.

Thanks,
Vishnu Reddy.

> Konrad
