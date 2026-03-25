Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FA28C869
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451689; cv=none; b=rAQiOhxpfJ93ZHxJlgQEdGNk7M5HGbcbwK8mA3coOl9R3iWrRWCHC4WQGNo+2+svhHEVXwVKW/bRD7cj9K1CCma/hTaT6y9N+BKDe7UG3lvnCgF9CnYCX/8wZOf/NI5tyQaBjjkNice9hv32IuMxIlsXhWK+CBXpLGwxGhei93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451689; c=relaxed/simple;
	bh=rcShfDxb0SWVUoYsT+a4OUOe9fGgAM8/hMD9dz9s7Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOSG6eEvAg1IWxtoMhH51xi8uW5MRHtGT2YrUVfvj7Vy7z3d+r6B55taCxL3TC+0GV9jrdWzW6U2AOhYFVKyeGuTGocMySk7T0oog5Wdi4INZhFTgIMeoeTobW7SOBiQsacQq+vukWy/zE+zkY6jxQeTHjbI2Py7RjW4ha57l+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBZWJdn9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmIrRDRV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBZWJdn9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmIrRDRV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBGQD24092205
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x7j3ryAcBMvHA8/N9VGk+JyVdzzgELfi5f6qP5tgez8=; b=iBZWJdn96S7kNo0K
	kQu6HMNiVVJBhY1PYontI5d4cBONCTnOG4CqdX18E2iP9s7y87dXZgdZeOLCdpzA
	6qkHUiaqgoQj6lh8awR4BMrnR6KxWAMTlfx0UV+F2wrMw7wOgw+8ARweBoG/3lYb
	1HNb+ImxHYJJQayhygppfqeDTrH/4oFZDMVhEZ764ymVQKLbyzVtVRIafzo6F0DV
	54N1RwPZ1XF26jEJr8k6q5bCKTfQIDlSdkeXZcoznRVPGew3vy/haW7hTygGsqfq
	FgWJ4zqbfUK+li7wsSNCwgZSmQ0xH/oDi7ILHlJ0OdwjfyJRGjXRcJXVdwWh8xiE
	zXQisQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d41413qx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:14:47 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829bf6406ecso16135373b3a.0
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774451686; x=1775056486; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7j3ryAcBMvHA8/N9VGk+JyVdzzgELfi5f6qP5tgez8=;
        b=WmIrRDRVCzH7DUy5ibWuCVWnwGYji1RmN1EtGVYtCmMiqN3F0P0Iqd/aD0+stdnaC1
         89SM12LnGD/KiQa0x+kj86PYCEBjaDs6DZKbiuFEtqxwkDWeDe/DG6DOBoWz/l5HGA9O
         qKhTu2mCbZgiqfejCBAj0XTTj/ef2VoFN7FFVPQWSxhKADt/WDU8eEHr07G7maarsrll
         /B3kf/ZjNV0YtJyZxKPI4nvXw6mTW8EXKVPwN6Rz17kXg1m1amlVRw8La/PxUcEGZJ2t
         Mqu1J4so/KPiPLNLNu7zFI2RYMFe65+Yl+Wd5mIkG8VbFczSxWNUwoIbcArFkZluc8MP
         tw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451686; x=1775056486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7j3ryAcBMvHA8/N9VGk+JyVdzzgELfi5f6qP5tgez8=;
        b=sLvUOmJTOe/+IjpPSmToJOYShSK1KeSNRgF0jOXn5PgrX6XvXVF56r3mGykaudgepT
         hi9UyzFRghwTnH/rCWQqSwutHoGgG5gkCZhCOJ2jmHVVIN/h16ts75/lHUAJIwfxGInr
         FAG0/Zlk+AQMttfm4x6+5AXgEjiyUn3+rnb5Hg1mrhqZHj49SJpKNCUiJvwZhekOGXJ7
         v2+eCDOhtzAS0v22B3SJVgj8XvdU5KN5kBXhAgX2VFu91RpdtrTH11+EaszqdwWSNb0A
         AE9qVgkX5FhKi4I6MgGYtXGfCsE9FGuyRI6V/Bv6fnVB9o9tGDWbDwn2NG9XOroWN0lZ
         07cw==
X-Forwarded-Encrypted: i=1; AJvYcCUNwfs7YFR8kfp1jeJ9ktS0jgwNaE49NKBYU/P8Pr/3JlsOe7bK2rdYv84YY6rptPGb4Ab13g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5GwAkUAfVqpaoXhDkPn5NZKpcvYzjlxP6mcE2UBfIPCyXZVlS
	YvlejjMOa8rekz0O+qr3tvToRfAvuOfDl1v64jQtjqowbQHhdyo0pcPhW8K4opOYCt+SpvHiZ3c
	b2lek6YBSsoVbH5vCpTv7CBRtjMXVEu/mY7eGPw66NOISaYySNUUC/jIkOA==
X-Gm-Gg: ATEYQzyxZxmmxn7HnSIngRGvA9NCmk7iEopOVRIf6dAybtYSQ6wV7dy13cB+TWem++b
	v5fw60BogpXfUZpaSSdBwQLkmAiYJGGp/tmYUvvTigisOKhD80Eajd9fjIjAoHkZV1CwS5Y/UnZ
	eyRvOxQbOfI0rm9//JgFazjO/TcnxCQjFnofrqHd8+BZXKD6KhmG7diBB+2fiP50jP0YiRNjRKK
	7lIlPH5RGVaUpa80ei0jbGQpkFazGM0YizQMufFeeH8bovkEHDHrWPEw6oOn1XQQwCIWBlDlh7M
	8/s4H1QVW20u2ydesYhhriIXsa7+PfZNGAx649SSrY9Tsm9aGMT3J47onAW5A0Ib5i9SGLXKX6m
	TMPFYZo9L5ZTMergce8VPwqcwVJIZAqmB1Z+QCjscAMBBbH+PCBQMFw==
X-Received: by 2002:a05:6a00:4147:b0:829:803e:678b with SMTP id d2e1a72fcca58-82c6e1039c5mr3966023b3a.54.1774451686469;
        Wed, 25 Mar 2026 08:14:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:4147:b0:829:803e:678b with SMTP id d2e1a72fcca58-82c6e1039c5mr3965989b3a.54.1774451685929;
        Wed, 25 Mar 2026 08:14:45 -0700 (PDT)
Received: from [10.204.101.77] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d1e619esm68019b3a.9.2026.03.25.08.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:14:45 -0700 (PDT)
Message-ID: <7dbf7a23-7a02-4e9e-99c8-6716e3dcf7d9@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 20:44:37 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] media: iris: switch to hardware mode after
 firmware boot
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
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
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-2-9c0d1a67af4b@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260313-kaanapali-iris-v3-2-9c0d1a67af4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fOk0HJae c=1 sm=1 tr=0 ts=69c3fbe7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=dE1MpONsbtOZy1RxgbwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 5PFu0v0PQclh0ANdAIxkx6d0KMKMenmi
X-Proofpoint-ORIG-GUID: 5PFu0v0PQclh0ANdAIxkx6d0KMKMenmi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwOSBTYWx0ZWRfXxNUHre26+1OQ
 VmHafWFpLLPIKSlmKLD9U5Gmoh5A0LTwd0u2SxLRH4Oy58ycY2OWC5DfqoF14YyljQURhrMqVSV
 +gXmnnxhoeTHkh56B7LXmWPmSCYCDwVV0PZSx63DEX8EhUTRuln669kAIkSNIDh8H64sulD5+Tt
 sHbv4HOXj6pXrjwl3Q97WB+AQJtAPTGIO5wfSadtHRJA8t6ol+5cKOsfZoGoANNPr8cm9l1pSsY
 PuVel9rpmJfmmLZ/0yDe3qGSpRy8h+pooeO24RbrGNjYgfyOjZxRjHo0IE9pp7DavE63j+awHQQ
 C+Q0YzDH4kQSV/vv6qMUEfSZ+CfCDpJFHMTPtN8zV/o3/rP1Xv13Fydu2DtQfUcBk0aYDDI6bPO
 +f/tOqH0EyGC+1LLtMysQToZA2Lw/6I1U82wcWkMlTlhycyCcMAzMZ57X4bW+i/IgaZfsEPRdix
 jaRDm4NaWnWlFJ91pAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250109


On 3/13/2026 6:49 PM, Vikash Garodia wrote:
> Currently the driver switches the vcodec GDSC to hardware (HW) mode
> before firmware load and boot sequence. GDSC can be powered off, keeping
> in hw mode, thereby the vcodec registers programmed in TrustZone (TZ)
> carry default (reset) values.
> Move the transition to HW mode after firmware load and boot sequence.
> 
> The bug was exposed with driver configuring different stream ids to
> different devices via iommu-map. With registers carrying reset values,
> VPU would not generate desired stream-id, thereby leading to SMMU fault.
> 
> For vpu4, when GDSC is switched to HW mode, there is a need to perform
> the reset operation. Without reset, there are occassional issues of
> register corruption observed. Hence the vpu GDSC switch also involves
> the reset.
> 
> Fixes: dde659d37036 ("media: iris: Introduce vpu ops for vpu4 with necessary hooks")
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---

Hi Bryan,

Please pull this fix patch, let me know if you need me to resend this 
separately.

Regards,
Vikash
