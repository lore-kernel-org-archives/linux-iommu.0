Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3774848BA
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100572; cv=none; b=SFVP/AzeEy0UmnaBE8Ik1LUXBGokqNJyMd3DLyu5BbAKR+Y/DH0694hRRrVOYkdTrtb7kOBzt1p7f+AnlaB6DIK/bW6G8AzOLAh+Mz1+VtzjhDRpVIioW5q9QRZtQIOYu7XFEThCWz5ucKW9nSFVn7IdYvLc8uoO6Wh36jHEJOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100572; c=relaxed/simple;
	bh=VqkBZkDaJiRDdADJ8Lxaecq3PYa0YExXfSjFPd9R/Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6U7IjGM+wu4o3OBaXRROviVpvMpwWtTlf0dVoCOx8uKrKTpGzdntY6VDpOOzfE/eHdkauq5m3F6Gs1qraTUG1EBUlJK43V82wQakV3TwhJzIaR2MxNT31IkeH+Gsk5cmZ54kr45cRJnwVlYut0iuVnJblYGhlDC9hNvKr+2hUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqQowyh+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bTBOWJCd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqQowyh+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTBOWJCd"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7D5W368062
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OUYfzTv8ACTsYRs+CfRzQrQLm7ATPQuahpCau7u+jJY=; b=UqQowyh+tpao22yu
	zk+Hbc1nl42ZY+WUJb/SGORwpESizUkz3N+XG2KEzcX6eaOMt1tJvML51Ko55FOs
	/oOrL7lOStXMJs4yt9b+GQEMSS16oHP05MwmEUn2H7NoiY/bnrJ0SdCrTLm1tq1b
	t7qToka4SmSnFTkNJSzNT3DctekjReYyEOcPcJKGnA3+rpDYSKKorkJEIwxVTdGF
	pOtlIItLEXEvDPqXTikKK3tRek9UqsqTUCmWRwr6dntck5Ki9gBmBoHc2DYJ3OmD
	5xuu9yENPmZ1PEkatFJOZLPYIZnGFRu2JY7Qq1KD9hg3xeR291HxsPmDHm8IwHsY
	5xMuMw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurnta31s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:09:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-334f782d1abso260114eec.0
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790100569; x=1790705369; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUYfzTv8ACTsYRs+CfRzQrQLm7ATPQuahpCau7u+jJY=;
        b=bTBOWJCdY9IJjLnuDkDjj/dR6fD2Is+Wmfd1+kBLFGvrOOtR0azATp24RE+kW3DsCu
         NXgICkdIPv6fsz/r5UtULnJpWOpxKmCx8Bgiq0S1vSZNazIVWftRYOP1oP8D5YJCihmT
         eVHakmo9USd5PPlcUw/FkAMpkXlhHvc5wsCbkxCX9TXxTJK1NjG70v8AaIqsn1pDC0/L
         aWgEKWwtH8BD8Yzc6QBB4t6qSDOKT4/v4gKwy3aWn2iFCpT+h0Dc37HxxwO18thOmzW+
         sAFs9N4NZu7Op7QdFqXF011p7wp8YKuLBRWhjOVsxHdIg5noDLpsdv9oCCc143/1U7xn
         Mdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100569; x=1790705369;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUYfzTv8ACTsYRs+CfRzQrQLm7ATPQuahpCau7u+jJY=;
        b=gyPH9fjlU/USAxPEDUhBwGFk7KnOaNARU83t32+dq2cdkvaVmjGVluPiAYFW/XdKc0
         gAuQeoGIaX4REjpnsUF0p2W2xBquv877cRqGolfpgCJb/2pl5A85xW3gofyBvCiJ192T
         FQtb6N7yQXoA8XHnjlBpvtSLKO+TaayW3fBmjpsJ+XDefQE8CIYcIM4x4tKRDHHN4X2D
         6EcuoR3P6sfEP6KjZz1tfEyhBT1SPu4w5hrCK2Y3cQS6Bp5nYa2XrXzbzeCKhCuqUt/L
         5ydoexcHach1ATRPG6gk8mV6t6kgbhjZDtgiYXJGZO6wYiY06QP8IveQOMdIEcvibFr+
         fmUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgzxaCtKiyIaJLXjE92Wd0rBNDtaGvuG3/nezeMtAa9+OLcYxAD/IMH+u7SZf+acy4dxw0+w==@lists.linux.dev
X-Gm-Message-State: AFuF++msuqCtjAOHsxhVG9ufPWBt23F3+01QFxD8WJ0N8Z5SJNXZLJ0u
	DHApXKg2ZriSC1fhF1P1dwgbmcSFymgahfPyCOrdkqtMtm7hv17t91RpQXOzBvpVtD9qH5WbDFK
	a8dW86kd00k5U2CEEnM/tQ4i5PjKGBdPZo8ZWBvOSgDS1Sr9tCGye95Jtug==
X-Gm-Gg: AYBFou0gRcD/Gg3jwR1AUJA+htDVKxX6qsMKV/Y9pTkLlJ5h+YwxCuqQrUyOG3eOG0h
	c8sXYqX944zMIzbJQJ2/FrJRtzOqqZZXsvvIUExUWSXtZ2EyJF73x/tlqvfm4eO0KZY2vU6b48a
	SNcgPQkhvAbb8ANY3cSoigDBeGc3P2pC+G19SOSFKbxJqCB0s11latrDRKJkcGgAFZEffjWkCHV
	cUEySYf0azvoqsmdnUUGZk3Q8LE3ZfbbhQ0D4XWXG7W1Lcha5qVW/Lc9MskVTx3JcIft3WMQWS8
	KdjrjMJS9doRgpn/p9Gk+6VHx8QBqsGqp0raR7trVDmUKKWNXfMRjUOykxbbqtZkoebiakiCLcn
	CW2+nKMcjQX68AP08VQx3Qzmopo1nGlUWfA==
X-Received: by 2002:a05:7301:2e34:b0:33e:6812:29d7 with SMTP id 5a478bee46e88-33e8d9ce170mr70660eec.19.1790100568462;
        Tue, 22 Sep 2026 11:09:28 -0700 (PDT)
X-Received: by 2002:a05:7301:2e34:b0:33e:6812:29d7 with SMTP id 5a478bee46e88-33e8d9ce170mr70631eec.19.1790100567834;
        Tue, 22 Sep 2026 11:09:27 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.143.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7d003sm7215eec.9.2026.09.22.11.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:09:27 -0700 (PDT)
Message-ID: <0eea448d-da5c-434a-909f-b50cc7c57754@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 23:39:17 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/9] media: iris: Replace enum-indexed clock and power
 domain tables with per-block structures
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-glymur-v11-3-e0c8bc914742@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260917-glymur-v11-3-e0c8bc914742@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uxL0yR00mpZP1U1qU4KbcVbCchXwF-o_
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab2c459 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=d+GKXRUq2vCLDWIvqUj1TA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cQsnMm6kD37X6GfbhGIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI2NSBTYWx0ZWRfXzz8uybFPJCty
 ak7F/A5oWpzGwdQJugqlEDmdsVhe/SKUW7XWdDFNj7aQAC2np9PfN1V3WpK9WNErk7VbJA+L8dz
 Ngc9BvBXsOTdkmPd6RRPQPgmOVX7duOOSCTF2hI3SqPr1MtStG1AnfIlIqNOJP/nIGrDpihyLEg
 jII5S+zNoSIumWcgZGQwTgT/nRj91XC1a3P2F/mbHN8U1hm1KFAxYFdKGGYZt9nHMkNvG9pcnjC
 CiJ3rVQjugPOQ4KWQi5twUADjghAn2u7/3j70kojjmIFM6B8s4gTIHty4UAIh7sZ7u5T6Huiuh6
 5nl9JkjcikmzIa+f2nZZxbGqfVnB+VVZN+uOXqqVy9AhNVRtQQXv5wOp7biZLk4fBdHf8qCrpRQ
 UKKDWwo0YRzOjyOd9gYuh8QsTuUOLxD1TYtHxP9YIqbXBv7/wf5/4Y9DVprmuP+ldmUMXuqP8KS
 Qx+s0k8oFbJpFKu+45A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI2NSBTYWx0ZWRfX0Xo4v5wN8ggs
 QLHCAxGpprfjF2zFzHv+eSbbHXMAIcA80+eJ4bBLASWPQv1voPVoGsFk6EdEgjQ93YE5xgXlkf1
 qp1ic/Jf4cqvyC24+jmcggkBPq9Exu4=
X-Proofpoint-GUID: uxL0yR00mpZP1U1qU4KbcVbCchXwF-o_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220265



On 9/17/2026 10:30 AM, Vishnu Reddy wrote:
> As new platforms are added, the platform_clk_type and
> platform_pm_domain_type enums keep growing. Every new clock or
> power domain requires a new enum entry, and every enable/disable
> path has to loop through the clock table to find the right clock
> by enum value, adding overhead and boilerplate on each path.
> The enum index space is also shared across all hardware blocks.
> On the Glymur platform, the VPP0 index for VPU4x and the VCODEC1
> index clash, making it error-prone to extend support without
> breaking existing platforms.
> Replace the flat tables and enum-based lookups with
> iris_power_domain, which bundles a power domain device and its
> associated clocks together per hardware block. Platform data
> describes each block via iris_power_domain_data, and the enable
> and disable helpers operate directly on an iris_power_domain
> instance, removing the need for any index lookup at runtime.
> 
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_core.h       |  23 +++-
>   .../platform/qcom/iris/iris_platform_common.h      |  41 ++----
>   .../platform/qcom/iris/iris_platform_sc7280.h      |  28 ++++-
>   .../platform/qcom/iris/iris_platform_sm8250.h      |  26 +++-
>   .../platform/qcom/iris/iris_platform_sm8550.h      |  26 +++-
>   .../platform/qcom/iris/iris_platform_sm8750.h      |  29 +++--
>   .../media/platform/qcom/iris/iris_platform_vpu2.c  |  20 +--
>   .../media/platform/qcom/iris/iris_platform_vpu3x.c |  32 ++---
>   .../platform/qcom/iris/iris_platform_x1p42100.h    |  27 +++-
>   drivers/media/platform/qcom/iris/iris_probe.c      | 137 +++++++++++++++++++--
>   drivers/media/platform/qcom/iris/iris_resources.c  |  81 ++++++------
>   drivers/media/platform/qcom/iris/iris_resources.h  |   8 +-
>   drivers/media/platform/qcom/iris/iris_vpu3x.c      |  37 +-----
>   drivers/media/platform/qcom/iris/iris_vpu4x.c      | 137 +++------------------
>   drivers/media/platform/qcom/iris/iris_vpu_common.c |  98 ++-------------
>   15 files changed, 347 insertions(+), 403 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

