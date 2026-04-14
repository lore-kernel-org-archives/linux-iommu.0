Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F2392822
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160291; cv=none; b=e/mOr8pUbkln74KDXf4zj21Cdb3W2eC5IxIy/a39vjDQ/gMreB1h4O6vrKq8auL2Igc49HhHweMF74zfLlpapTPSYa1lIw3/ZI8H8w7E16sNAkTDm2dHS2+ohWzET9n23B0DNS3I443474coku+UPGQab5gcHUlwMhWynAEY/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160291; c=relaxed/simple;
	bh=GjYSzpaBOY+tQSBP+F/2fNUDYZP16CuhUhfczyEWtsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBcmwZbwIgCXoHwErdgTNMxHcfeWnhTrgarWW9M2PIl2MXTL1RbO2sgMetomUFA5668NvOJCI5nf89M5TZ7jICH2IaASlr7R4xsPqf6HwhXMU+VLffCn2uOF3Jj9Vzvj2iLn9O9XbDBELy4Kf8Fb9G7Wl//3kWNd/+3wfWFfUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YHYpQyby; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j54esGQm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHYpQyby";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j54esGQm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6epL03681355
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M2Nqoj6YRG35dW9rwuMRPa4c0UNKE0+QLsU4feV7SfA=; b=YHYpQybyafBetHKj
	D+Rj6GEvCn5Aya/tQ7HJNdaVNIAN0UJ6pOCCzXHmeiV+1oediw9BlZ5tnrMw08rl
	tAu++N+534fsLXnodyfgs3+FkaSLGg20+T1E8UYwvanuKHrO1Z3fHRbYYPnMooKM
	cjsP6aPDdXLs6DPHlikThtlz5Rx831qx3w45IHL+Wosmc9LN7V03SdzbJl4qUPTx
	mjdcPK5WCzoN2c+0CZwockf+V82ZBx406+Hir/LlBe3vdA016u1LqgCk9pQHQYns
	2Smj5ZL9Z7UuEuKmnt5DxrvbFeXMN5N1L3F1l04wEhRLZUs6O8gTYHTKUwoZQzdH
	zvmd3w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d25rf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:51:29 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8aa9fe6b6bcso9775416d6.3
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776160289; x=1776765089; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2Nqoj6YRG35dW9rwuMRPa4c0UNKE0+QLsU4feV7SfA=;
        b=j54esGQm/QoqrSvwkb5sANNSJf7cJuK1/DUQSwHa7TboRhNE0gtm4yHuchExPNq+pP
         P0OiNkMOFBp2VxXN+lVDXXsNkMeijximyNFLvm9mQejuySpF1rMDhG0NcMtYL/tD5EOQ
         o7DB+IlRSkaOc/hDKwoWp3dEdNOwlRRH4XA9SXJJBCuVCm/poq132fsKQD6lqwfSDw0Y
         RQTZGiOKxQWX9YHztrz1dcrwpk3IfSAPg9Srcc5pbQOHoWM2YUcyDweKHqs58f4Mx5v/
         VyWdyaNo/b4Vs5Bh/7id8CK7sVQZNmBWwdp9RbR509lH1nN9SkA5P9lJMcioyYUa7Fx2
         XuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160289; x=1776765089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2Nqoj6YRG35dW9rwuMRPa4c0UNKE0+QLsU4feV7SfA=;
        b=hOHxEt2oHZ4jLo16tYglRkxzs6sViY4po76xuzcB5dJL7otbU+FThSa5N9o11flO39
         z5IO+/Vvw9eZ+pumu4NmZBMJDtjxkNwTXNoAmAJyrfSx62ZsynDuKeFjEiCNSa+VvE+s
         ++8hNXpnr96zEXNsI/QAhBj2m/JEtgN1wSBksZVKmV96emFC+3RUK7NzVHPkfbf98XZi
         62kCCzDvN17naedVY9OUBl5JxgSVEJVA09EMt9gQ5XjOd9vOWBaUrOGx56MG694KGRNP
         h1oFO3KNhKBuIIMOxt3nPr61JleJb2i0PtZlJQnEC9nTrdjbk38q2IdIyg09Ibj38PYk
         BHmA==
X-Forwarded-Encrypted: i=1; AFNElJ9ToGyTlQWiwQUskH2Ta6HyHfhWA1jCix+jcFyc9HYgI9eH0jA9fHqP4gwKEaTIQ5Ped0S1Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy011Gt4awHeQqdKYaTiGYuVspOkDjMMdfbQOLTuZD2nsT9t7wY
	tugKkic3I1wfxakOqHMDMG85DIWpF5B49EPGWk4chwzY6UxMszlOhZy+c8rUHbJIaRWE0zH+yzc
	ehhIAuQIPOLjOEP3bkd/8mU6XFtTU5H4AS/1xWx/WN1rLm/WT5zRnQbWY7Q==
X-Gm-Gg: AeBDiesq+O0LRs1dYJn409Sh858LRTYL2tf76wLZxGjRI4w6zC/m4ml2tiMtngvawuM
	jE2QIGTBB+0XTauWSnddwOTUOLOSqayGfSjDePlRhIyXTHCD6oWLoouN09AJQ1dKOZmfOwtfoCp
	xxuku9FLbZO7ckHYfBXrav/V13Nkcwr0HbESi3hmVIOFUAMdGEVSFRHtse4pnTBvLoRq+ILRWW5
	zUWdE309gMpL4ulILO00LM2lu4r2zy/MMEL/vCFbRWXSYDwboylZwEKzUUBxHH4+nYTISy6Pfm2
	xw388HlvEf8tC05Rz8aPiDrMSEC6Ec/3nmJNNcnJjyOB3f05glf78sCbdnDsr/j9wkGgtwfLU3r
	7v84OMzJDBhZLq8LPTpVLAlMjlp4E6QP6+B5wVrhq10htvCTQ50aYK2bzbX6cotb/uGNlq1F/aR
	gsmcmBjbGFtp6Xhg==
X-Received: by 2002:a05:6214:ac6:b0:89a:7d14:66cb with SMTP id 6a1803df08f44-8ac8629bcfemr194153436d6.5.1776160288876;
        Tue, 14 Apr 2026 02:51:28 -0700 (PDT)
X-Received: by 2002:a05:6214:ac6:b0:89a:7d14:66cb with SMTP id 6a1803df08f44-8ac8629bcfemr194153016d6.5.1776160288365;
        Tue, 14 Apr 2026 02:51:28 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a78sm384964866b.50.2026.04.14.02.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:51:27 -0700 (PDT)
Message-ID: <d1834575-768e-4805-9e21-50a796690bda@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 11:51:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] media: iris: Add support to select core for dual
 core platforms
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-9-7d3d1cf57b16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MiBTYWx0ZWRfXzGbsuSCJmoQY
 yGthY6Eq9c6ERR5IaNAa+1meXeTs90kT/U6Laf405ZWeWCHanqbm+FbRAxFZjk6Bn67zSpGdRu8
 9oyxVVnUFdLlQLqfvHCHbT5zOWJ0oYMP5jQMQOsymnXB8HUEMqJ6YXSGGq56phfibTMqMVJSClr
 entLhsebpREJE2o+wSNfhTnq26K6ZqzN+kpwmdiiOhp2bLFFLRQFJ1GOONFQ/uR/kg/sF8XpiGa
 zpEugEyVereismeloPkV9LULB+IFa2nLpb2a+yPmxVVNlYiYJMOwst2YO0w2IfDGKF+omUl59dJ
 oHL+RNJFYx7ZCqqyzmEbxZ7F4PG56912D9tfQ5tzBvVDs+auMSyQc9x0Xya8UUTVUpwJPUnB7kL
 0M4DplDL2XGztbrxSBZo2rMYBhLy3vut0z62lFD2UYECQjDUkkZQhpPnOSt+vrXX2N0PtCGhRk6
 lM9THnZ1eds0MwBL6Bw==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69de0e21 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=LyQ9poKqOzz0K_9SBp8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: RXZOj3cJ4XxFpuh1N647ZyLEqsOVWNeP
X-Proofpoint-ORIG-GUID: RXZOj3cJ4XxFpuh1N647ZyLEqsOVWNeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140092

On 4/14/26 7:00 AM, Vishnu Reddy wrote:
> Select the hardware core (vcodec) for a session, based on load when the
> platform supports dual vcodec cores. Assign the session to vcodec if its
> MBPF/MBPS capacity allows it, otherwise assign to vcodec1. Communicate
> the selected vcodec core to firmware using new HFI_PROP_CORE_ID property.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---

[...]

> +	if (core_mbpf[0] + new_mbpf <= max_core_mbpf)
> +		inst->core_id = BIT(0);
> +	else if (dual_core && core_mbpf[1] + new_mbpf <= max_core_mbpf)
> +		inst->core_id = BIT(1);

Let's store the core ID as an index and only wrap it in BIT() where
necessary to pass into the firmware

Konrad
