Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167C48033F
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077596; cv=none; b=kEpQg1Bb24ejilaX16rugatGJxKZPe/i/wnT8B5+dMbMH/WEUAt3VH/E8KljbteN71/6sGBO1AbL8AppbcCntj9TFGx1p5RFKxKxIYQ56Kvi9t9cQ3jJzTPPXxKiHeZrLIj4dR0OoVBLD54eWfuRjS4p0tF6GrLQqkTeNwavlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077596; c=relaxed/simple;
	bh=srPsf9DGtjuwNp0lmZ/jXjqw3neX9w70YKOrPJckz/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqjCGUEYaCqV5pPEKelWBzfa8KBdVMkMYTLH78RpkLn65TAmQ0cRwgdr727WCkssX7RQgKwX2ujRftkzwZGq+bWJdaVri6TJhZkOWiUvWFnPMZfjRukImECSDVCdDyjgfsVVKpa2XJzbX426hNzKTVfeMQVNbr6G4waEQsXOqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iN1G/EWN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H9Zq2jFe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iN1G/EWN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H9Zq2jFe"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BFWnj2581393
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 14:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rqf4RBq3GqNRH4BGmUrshX4k7nqqdx7ZkyuDEuKF3e0=; b=iN1G/EWNwfgWQKL3
	YAX+dNLrgxe2qqzkPQEvOTz9o8n8gYjG7HIbqbrC2dQ48IromOGPqNvckoG7DZUm
	YMO+2WEfAZPWoygw22tPuxiAD/h6hOndd+qVPjNqUqVRFRM6tGdtUqqM45pMfRdp
	XocTHk1vLrByN6EWoqEqhTNyBZBHOB5b5YceOBvwtrKR8MYSM71ZWotYXEId+SS/
	UMwJWBgTzPwoMThpSEhpbiqecdJibaGDgMNoNp4Bq9RAIKotGSQrGHjBacQsHnz0
	8LDRjA1lCwoPo8jw+yGY+eQz4Qi6m+3mXezqCYhCE5tTPSwx6+s1H879cO2FAT+i
	4t2eFQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw1y7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 14:26:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-836cfd84728so458071b3a.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778077592; x=1778682392; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqf4RBq3GqNRH4BGmUrshX4k7nqqdx7ZkyuDEuKF3e0=;
        b=H9Zq2jFejDRMcAn0EUit5KfaQtz7tccvupW2pCp6zxoGNiz08xi8BRiEb3lT2kcV/Q
         /PI1H8nngLKAqrqDTziIpvdnZdMd23xhAVOe9rsVcNGnKVFlNEq/uvw3vxj9OW+MGqY9
         Dv5VVCTxX3snSqhTgm6rpoZMSiZCv4qd7SEYYulA2WmgJ+fKd8+5cXeAycxlaN/WYlIZ
         E4W258CzQvABDD53iUptM7RZkF2VDIb5ZDbFxAB9OSQjpUSHuk7OOKzHLkPNX+uGHDFf
         EqGpFDejjeMjELs5VghuRHqY3LXWzw4NGwQyFMvdFiBnkzS+H8MXDptrHi5PH2a7s+1N
         J4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077592; x=1778682392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqf4RBq3GqNRH4BGmUrshX4k7nqqdx7ZkyuDEuKF3e0=;
        b=Jm3tITOADIJArqBI2IijpyQzo9A+JWy0iK/wkc1q9aWUvTDBGRUfEe1szt4bkkj3L4
         3ObDst/geQJ4t9DlrxxSBEauzzEbnCkrO3S5RVa8M9I0dXkD68O/F9U7YGd1i7GI036U
         LmpOUQOVuiCF9/nnG8xrQBzZGAOgbkPxA1e+tPNYt5oUeHMZ5rySy2rpj25iHZBHpcRg
         qWmk6uut9NSe2B+cmn5SnW5GTbhxQwsK/h5WjY4OKgg3aRwot07xs3c8uciZj3e2q9DO
         +3z1srAT/BBXd8BgeyetYBNYkOAAmnfxY9mR3/kv5kJdzM2mRruPwAZl9VAAZuPnSrGl
         z2zQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uT5wkl0Vsl+HNCf9xAEVDUhhqNC0CtFkM6Ft9f7a+cXVSd+JQaIqmhpiwrz7SIfiKZY//aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgunVFR9eaOSeyzpInQDuZhpT8US39FoS5tOZT3028bjuj7k1f
	flkZNjAg1kNX5F0mAxqR+c2DfHuPQ1kMwpKK3ZxTd0NHf5pQhxrA/aEaMWsknYx0mnMdLCtzZCE
	0ypg8soWLHcfsfPUjgujviaOokAU+8PVeoFCQiJdUNp2KKSgEhzNYceAyRA==
X-Gm-Gg: AeBDieu6NWlkN0E8qYJfujrfutHpvY7CzV6wfaWHDZpfrIZUBe9j/+dc5LuCwCvj+uM
	hnFnNfnmQFnxUTgglIADw6ep94wcQ593OWIbNaOzSl8FA3lv6EO6fe26HiQ0XbPl39RylDih3kk
	y9+O6mYJp88uL7KCdRwDe6OYPVOf2XnScHX67LRreuQC52SJiDIrF60WKZqVvKCeFq2BdVBGjo5
	PzgzP39BYHDKjleU4Ophm3xYryH/ZHpbNeY6DDtT5YXwv74U6fhQRMSUNVSkeB5zM9m3BLO+cBT
	3Kbakuj1Db4tdhdfA0Of0cHipA4oOF1A0ap2suxl0KJzUPfEJycu3SHpD4DkziLb8PBPZBXH5fA
	PWhiBG5KYcGLPexjlo8z+8YH5/MJUfTvwSu3aB5N4CZAPrrg5V8Zv+BCqxeaPGPr4
X-Received: by 2002:a05:6a00:98f:b0:835:3f9c:c681 with SMTP id d2e1a72fcca58-838fed5e872mr6814161b3a.34.1778077592389;
        Wed, 06 May 2026 07:26:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:98f:b0:835:3f9c:c681 with SMTP id d2e1a72fcca58-838fed5e872mr6814130b3a.34.1778077591827;
        Wed, 06 May 2026 07:26:31 -0700 (PDT)
Received: from [10.204.101.47] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d36c10sm7146996b3a.25.2026.05.06.07.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 07:26:31 -0700 (PDT)
Message-ID: <0c33ae9b-db53-4557-8fff-27c2da69366c@oss.qualcomm.com>
Date: Wed, 6 May 2026 19:56:23 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] media: iris: Add context bank hooks for platform
 specific initialization
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-6-17571dbd1caa@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-6-17571dbd1caa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fb4f99 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=LctZHUKdXz4wyCJjwzEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0MiBTYWx0ZWRfX1Z9cF4xc87JD
 jpvonICUR7Rb3K6Voc/C3dpBeEjkFPmXDsk4RmbFrwEmlp+/+eIsKDgD5h6HeDsIai/MLGuQAQV
 sIgUIoz0ugtbHLvhjpUOq+l2qOGp0TLx4BMGeTVEyrNmIZAHbpBJ1iZ/FZC+U39R43WJNr83mYq
 KRGb2pjEF7dnjRTxaAdWt8HpNXXz9fgsUfSxulsqXfD59mdbdv8lnv77R+VJdI2FnkjkBqWabdf
 z47HD7xWu5pw4TnkL01FxjqiUVS8m+R0+65OxSKMfZNkkXmC5+2/HbpWax6LEZrh363lXzzuCKl
 VLxwz+BcU4uRQgaDsnjw9px4VqhyG4g9CILEWk9yxqd6BkPyXoioSDvAjz7xBovjXPtbmGpbIq6
 mLiBut5gMx1JjarG423qOSc/RCXxt0b9xudw9ZSYSLI3KgMZk5dOT+lVzQaPHY+uEwwG3KVkhW6
 C1L711YqWEU69PM1hxw==
X-Proofpoint-ORIG-GUID: MekF105Kpu_KyD6J2oqgwCzlEwmcRxJP
X-Proofpoint-GUID: MekF105Kpu_KyD6J2oqgwCzlEwmcRxJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060142


On 5/5/2026 12:29 PM, Vishnu Reddy wrote:
> The Glymur platform requires a dedicated firmware context bank device
> which is mapped to the firmware stream ID to load the firmware.
> 
> Add init and deinit hooks in the platform data for context bank setup.
> These hooks allow platform specific code to initialize and tear down
> context banks.
> 
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
