Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61913793DC
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780896666; cv=none; b=o3CLx2D2Ksi+3MtuML1c/coDmC4BXmwW/PmZyjL0LSJrB4iY25XRaP501ajclpCFGpC+jlQnDcvB5HdZ0e5GIYIDAm/q8Zy5DNM4SUnkGY63FxtaJUfBiWiQczhlebdalkHoCiINjOx5GWIpuZj4Kigb17fbWet/f+veUgXr1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780896666; c=relaxed/simple;
	bh=qTx+DHtWre/vWRqrd4nb+kTk0I/WA3gYh9rVEZ8lRMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8lVRxragzyohIzz/nrEeu+EkCQNpZTwDFuW7/uNLgKWN1I+PrkKDZQUfWXu06P8YmSQOb7yXkKX23h5JxmOQ7CPuzyu7qgL7tT/b3jGawha0v8gKea+4GkVJFeSgVsKh3F1C39x65XnpUxXHEMnQq3qSV2ogEHsFCg6nG1ocaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQlEaXTc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aeVOl1Ad; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQlEaXTc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aeVOl1Ad"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580ECOX1574271
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 05:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hi15Xm8d7G0ExlIDhiqsbLHBGa3znaUw7XkKqHIeAEw=; b=SQlEaXTc2HTwUtKl
	vP6UjSZZiZ+KL94k8tWgc4R7n/XHQkay/RttbnXeazEA0guDyjMTBAy1uYo8xSST
	t5B6ig7rpZqMbcURmD2VdCoEpCCK12OS15fJo/hMf815er7dl7o5MMYAt/lDvqXC
	QZdsOyrhVgt5uE947omn+btpmZkXpEHuCGLL2IQOCCu5q0IS/9dhWuwTZa58sIE4
	KhPTpInViGAYiZq34qIPqyRe5BerWVAR0eoVRjFRBX314tLZ0Mg3i3oOAhgYhi37
	S4154se3lJV+B5mY/8TQJD2Ys2UfWE3yIgHPotvaTXkA+NmZvfS3fwXC5+DXyLjO
	VvNQsw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cxf3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 05:31:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51758177935so30878241cf.1
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 22:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780896663; x=1781501463; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hi15Xm8d7G0ExlIDhiqsbLHBGa3znaUw7XkKqHIeAEw=;
        b=aeVOl1AdqCgpsHy/WDYUfe9ASkMkrZ6jDk4psGhoM5+mWbuQ//3+auEbR+yi1AlDSk
         3EIDw7RN0TNCaZuYIrQSxzBy7mymUjYUKl+kdXh4AQqi8cHWR3Vuq0KZccey8BgRqFpX
         T89gR6+Ae0fHaGz65YdEmtlwfuJOnvKvl09zb4FnmI9t2Nno4Gk/yyOg/eMvuc4B3Q/v
         22DyepDxBdSGAkHuykVVssMc5UTvibsgu5B/GOpVgeKA+bXouvkpeqczMQ06Gnb35Jgk
         J72+06vyg/BWWDch2EmaU3+fQN1l//zENUmk/53V0ZsPMqXViK6/7+EBG7dfHAaD3v26
         vppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780896663; x=1781501463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi15Xm8d7G0ExlIDhiqsbLHBGa3znaUw7XkKqHIeAEw=;
        b=JdNiE7Jd448rBpXEGzJduSrswiXC4im+Edm8q9oNbonP9ACjQZHxheL4yvOcQQVT+f
         9D199ITKxGEAM5yVNMhnzjOCy+dDsH5LAv7ga/0JH+if87faI/C+pr2J5WLYPMby+SH0
         E4JC9B1BcyPATfYhdK1n+Wyw7LpIX/CRHYzlLY8FSYL3aZg+VRURWHvbY3SQVnE/Njwt
         X0cJlvtZ7lfDm0HOZdlnBSmgSrxx6jg3ugI7as6EVPEcHpFJMQYBylIDyN7NoC4Splnh
         51oukestyN4jeouRacZyBjc3vx4VziX1F4kQPwfkwocBuBnInpeqNCehZNt8rXtBZ1iM
         pUWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8W5V2LDFqQM0unGAR7C+MelzrFl9g7eFt/Ee5XmwcXvP7NsZolUdDH9h3gttrtoRqDLqd+bw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs0XJboI+UsWd/M7AjMrmX5ua8PatHSkrdZ4MnikO1KfOGrncF
	o8RHXuG/murgACZfqrvCiJOfm4xm3yRY7WGnBU9NfzdDsIe/uL8qzamdiogG6oFMQDIsYrb3jIz
	rAgGJNjtEU+TCeQb6GSJjr5lpSTNiUyCP29/nRTjs+xmt8Fz8Al2ga2KREg==
X-Gm-Gg: Acq92OHGisPLjbmjAUC7AIqVBfShXOHDngWUtAXjCa6abeWgJquckabUvr4CD/yUWA5
	ClAVqeZMrrnw43AFhz85fdH/G/tfLvdpOmpkvlbivnJWK4qj2FlxmU1rR4eH/gflOh834P67DzS
	zQTAE7U/7tUZQnAD30fsLMw6S5aAAX7fdGPRcHsxUw9u2V00nLQDkhrbO61gHzf667oMT0ZPuT/
	3hXwgeBfeOhO1lsOQ6DVBLelEE3s5rr7f5W5KtIQ5Wj3MpJQ1AYuIn1M8UXo1ZKaROR613CrAqz
	BLBHM2Dd1oIfWltdiYmz41gvql2hWLy0ahrQ1fveuRJ8+rstHT3Gc8ivIm5FucgH/RTt65C4JGU
	f6ypvtYjxgwD7JWw5DpGdtxGEp1KrTawV1wpvLzr6KfU6uYvc8UOcdCQXb35R5R5V0g==
X-Received: by 2002:a05:622a:98d:b0:516:ef49:f6f5 with SMTP id d75a77b69052e-51795c5306emr207093251cf.39.1780896662657;
        Sun, 07 Jun 2026 22:31:02 -0700 (PDT)
X-Received: by 2002:a05:622a:98d:b0:516:ef49:f6f5 with SMTP id d75a77b69052e-51795c5306emr207092961cf.39.1780896662245;
        Sun, 07 Jun 2026 22:31:02 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.249.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65851d7bsm6551413a12.14.2026.06.07.22.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 22:31:00 -0700 (PDT)
Message-ID: <75755586-0cc6-4dce-a1e2-726b33623eab@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:00:46 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] media: iris: Add support for glymur platform
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0NyBTYWx0ZWRfX5HbiaQQK4B/I
 R1M+/mpIdeE52c3uRRHpIlw2WiLhuOUoMXi4R648anCzEhhMcQYIlkyXtRDIBU9CpmsXQkzg2f5
 a/YZ39Ne34NDNz7j+dOKCgVSDvD2AgUuE0u7owcq2SdZNdo4Q7mQr3Czq2n+MK6ot/rXv2qJp9W
 acr/ktn3rB8lz5gEW4Q0KFB0yb8dDaLSYxp41xmAA4qb1k8oJO4E0t6l0Be5gcbyz9t8t4AAuyD
 xuwLiTxGbkAKiFebU8H/mRhOP8bXFEYEtFMwj7kWTZs2Bl2nH/BgKjDRoCN4EhKEMNO00iFyeRn
 CThTr+mjcjdMZZaUK3w4G8FJ18HsYDoKNcRuKPSKU47ghLhkGhZnW7hn6OLh+kc/Enm/LYBkoRm
 nssIqFWXPLcLZGJS0HWBjtTninuNpDDTDbbaZ79k6pH7CkjY3dNcQ82t4qA2+2fx5yzWJ7TrL3r
 M/Nyc+zUDA5lItkaFEQ==
X-Proofpoint-ORIG-GUID: ERgvt1ZyZyG8cxnTjfLDN1FcE4E5XnEO
X-Proofpoint-GUID: ERgvt1ZyZyG8cxnTjfLDN1FcE4E5XnEO
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a265397 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=LkejVvrHZj9QS69ASjwr7Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=kk5GEcIQhxhgB6gqvmQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080047


On 6/3/2026 7:48 PM, Vishnu Reddy wrote:
> Glymur is a new generation video codec that supports dual hardware cores
> along with additional power domains and clocks.
> 
> This series adds platform specific support in the iris driver to handle
> the extra cores, power domains, and clock requirements introduced by
> glymur. Add support for firmware loading through context bank firmware
> device.
> 

<snip>

> 
> Vikash Garodia (2):
>        media: iris: Add iris vpu bus support
>        iommu: Add iris-vpu-bus to iommu_buses
> 

Bryan,

AFAIU, if media maintainer can review and ack these patches, then we can 
check with iommu maintainers to pick these ?

Regards,
Vikash

