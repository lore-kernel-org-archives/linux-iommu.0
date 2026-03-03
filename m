Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4222D8379
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561737; cv=none; b=a71Jqx0N8yguh55ZAJLSsHzU/A9UNKaZQARYPiqGNbKuZDiYJwZ5jUMfBUk+xnfpRs1vSg1gpbOohIvk318D8CvRYe71TknN1tH2FAwSXctwkaluF1DxtD8rjrzJNJX4I+u35zyOOPabv6xmLX+2g+gpNBOCYZHa9MqFLbIH1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561737; c=relaxed/simple;
	bh=nIplDHq0GeoyYW/IrfDMgxh6AOLa4S2pZUoiV75xPdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIw3RpHkGylNOzz6wcZKXV1McbvPwfcXZQB0btVpU4H7CKddsjiZR03KJNDF5NY6snoktauG0Fj9OzkP4Ow5FR2BGoIVKbnEkRt6mfkf92+orEtqGeSGjiisuzS6JsfiRho1EKFEIr5xGenZ4frLA32NHjjCdpGdURl/z5QLFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H5u9kOV5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UwM9mU3T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H5u9kOV5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UwM9mU3T"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623HBXWm2787060
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 18:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pdhCqMOgDEEGAqfnqFlnXNDGRXW1vEoUmxQcDAextXs=; b=H5u9kOV5qtItcQI8
	JOXDmLkJoV7agyXL3KycA1Y3nfxv/IKIDCI8lSjiuDhxtfUN3oi60hkqerJA4GRt
	Ql+ZZ3JF3neYi22DMZWsf58MrenD6wc5ZaewPmwiaWoW9d/O6VFNQiDw3ZyBr6/Y
	sakDYym4reEuEOEG8NaD3grPivy/v6cXd3OgC9rvj13uIQfIp6clqtZD3jiXZXan
	kGs0UvxNBYGeH2APHDb1c/rVynp9MjN0crQpD1KiVP8UCk8QniBBrhBMZseEcuS7
	iSnmRVRVCqyz4l6ghWskudnnlQfLtXTqDLEV4R4tqQQgFEzMOQG94chF8PIVyynW
	Fc4fcQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvg7fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 18:15:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso4796891a91.2
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772561735; x=1773166535; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdhCqMOgDEEGAqfnqFlnXNDGRXW1vEoUmxQcDAextXs=;
        b=UwM9mU3TYBzKbKCxM07uOgMLfqV0Kc3sSp6X54j6BaZl0Y4bB2sUQ+tFWTUl4vD0hg
         aRXiIMcaB+6hq/Ff6+kCwEGnaiyDNzziZR63ZidIzF0UE87gePjCZZErJhSBN9nNr/CZ
         4RtSxgheCvcSVTbMyKQfRbPKmgCWgtifylyr2PIcB8Lt3Oebw8TM3s/z9CUA3n6t6HE7
         ffdILcKeXKHZThaaZuszltO8zcAUZ4yYd3iQXme4HdSJN3kFqEGaqqX8A3VCkJzREN6j
         uqbPOtqgccY39Z+KZZw5tmDEAUtcuIsJUrM76Q7DWpVVgSVpLhMHHYcf4BMyjIzR7Oqo
         6gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561735; x=1773166535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdhCqMOgDEEGAqfnqFlnXNDGRXW1vEoUmxQcDAextXs=;
        b=kaSTo5rz11GYMdvFV+7HM5MuYuOLQZJuoB48wpyn02r4osx+NUkToSZbjsZLnA32tB
         y0V3DaGiJaPb5tzpz4R/a11ApwrU0ewpEIgj3PLw4F3n5CgAvwTGwOQ+WHUIm/0JeC5k
         6jKD28r83B/tLOW0B8/+cc71MQtYRNkzigHNAIzjHjPave2pO4JJCiH6C9tZOZFxizBW
         cAnjEdr0s7TZm/lxWmucl75itCVS4Aa7NUhsqvnHm/EVEnUkIpOm6Ix6v/qyiKb3dy0U
         ZeIUU6BNFrQoUWVl7HR1pP8pqbeWMrd9ojaUNbp0I7rH0kCHsOuwBALz7wkcSE/8i+ti
         bybg==
X-Forwarded-Encrypted: i=1; AJvYcCU4qUF8+MWhneurzqUoNsqswdBp8dq/m1V9zpYb586lmowdXp51GQeF2cKoebNhsNoP/j5L8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiHKUeipqsYtdnNcxYgNam7RO4gNrS73drE+VCNasrctc2mAvP
	vwUK457sakeUXO2TYDIjP4oPgF7wo2tcSiu/sma7PSr5U3812VkGY6bkbZsDUDLf9P8yfM2vym7
	EKLFfZXcoN+kUlDrczJRbpUdD7cvk26kOdbzIVtYSlWjvB2LWqk09VyS7nA==
X-Gm-Gg: ATEYQzwrzWY1XbZJA7nHALPzYpTWtcidNiwo+Fo4glS9uyJ8FL8hJCLfVElARD+TmtO
	oOIPy5kGCV/tKlnVHUnOV0l0HnuyJBjHFFPpdXJ3Rg39tY8oJeyla1em2oXH/IywXDzpk1PsqfA
	jFIwqAnqD3HGUEk0QnJOKcMlsuxiYSdcR6expxqLJguJAXd0MYQACJY2rdg2guzbmMTOaZlge4X
	S6xMEJG9DYt93EibSfhN0hFrOj/n6HF9mXgNZfdMQaCz85rlQxVUx5TdpDxIpz7X3a6WdMEcuoJ
	QqFh2HGMxEyTX4wLe/xJ0cvW3m8aUMs7rCer7itaNBuKK9EbqF+LsM86KQ5mDt54oXRYnofEkr1
	90chVMQCR48gcBHtF+fPRIOU59i2AXVYEoYtEgZTubWXRMUuHLCA5Tjc=
X-Received: by 2002:a17:90b:3dd0:b0:359:9224:6c16 with SMTP id 98e67ed59e1d1-35992246da0mr6103143a91.14.1772561735102;
        Tue, 03 Mar 2026 10:15:35 -0800 (PST)
X-Received: by 2002:a17:90b:3dd0:b0:359:9224:6c16 with SMTP id 98e67ed59e1d1-35992246da0mr6103119a91.14.1772561734500;
        Tue, 03 Mar 2026 10:15:34 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c39def7sm2866240a91.12.2026.03.03.10.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:15:34 -0800 (PST)
Message-ID: <164928f6-cd29-49e4-8b5e-365f5b0a70e5@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 23:45:25 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] media: iris: switch to hardware mode after
 firmware boot
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-2-850043ac3933@oss.qualcomm.com>
 <6fe3a1a8-46c7-427c-abb5-2e7366a43392@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <6fe3a1a8-46c7-427c-abb5-2e7366a43392@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NyBTYWx0ZWRfX8AGkMlqP6Hm8
 H54YpYmAAZYRutJbLLCBge8bTkpA0x4FiN7MUb1DWomYspRHVLfIVZl4aqK0evwpBJbUH1x+VA/
 h50nESsEehjXI4B4Y7c1TMLV48gptkxbSkPtLSXo82uRjElR23vzST0HFR1XrwmSU4D9VOjfLij
 VkRNZlPAHqz4POPPWSp7hGAKlRn4LRDCrgCFQ6V1XDlj3kfLCruSY+vY1EC5z40PsC/LSNVDnux
 2M1AuaH2ZwjyB2UKKe0NVjINPwFpVT8opuhW4ZyGQKFaOET/qcIzpOe0Z9PJr/874P8ZmkEqAz1
 pKnlLOVbnQ5v/MWdTG0mlU+B0iIjGwkiAR3fQid0y2X+9ZMSbAhtx+/hV6yVzAT4Q5RBJhVaBZ0
 WzrPuq+40OezRziQ+nEpPgy2VISeWn8UuTcl2YtRDaExiI7nisRbD4XhkVLRRT4HFj8zLOL8DyO
 kKUUcF3SUR9/WgD6fEg==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a72547 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=UfkxKPkKiOspLhQzxRwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Cu8Ljg4ynu69ZjZTkrnuItOLREmngLad
X-Proofpoint-ORIG-GUID: Cu8Ljg4ynu69ZjZTkrnuItOLREmngLad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030147



On 2/27/2026 10:19 PM, Konrad Dybcio wrote:
> On 2/27/26 3:11 PM, Vikash Garodia wrote:
>> Currently the driver switches the vcodec GDSC to hardware (HW) mode
>> before firmware load and boot sequence. GDSC can be powered off, keeping
>> in hw mode, thereby the vcodec registers programmed in TrustZone (TZ)
>> carry default (reset) values.
>> Move the transition to HW mode after firmware load and boot sequence.
>>
>> The bug was exposed with driver configuring different stream ids to
>> different devices via iommu-map. With registers carrying reset values,
>> VPU would not generate desired stream-id, thereby leading to SMMU fault.
>>
>> For vpu4, when GDSC is switched to HW mode, there is a need to perform
>> the reset operation. Without reset, there are occassional issues of
>> register corruption observed. Hence the vpu GDSC switch also involves
>> the reset.
> 
> Is that a characteristic of the hardware (e.g. also seen downstream), or
> is that required with upstream iris only?

it was found lately with one of vpu4 variant SOC and applicable for all 
vpu4s.

> 
> Konrad

Regards,
Vikash
