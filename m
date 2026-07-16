Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6E33ADAE
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170807; cv=none; b=tIAM1auUh5ygoipHEPylRHzcayyMUMPVPJPFVpDJ/pdEX2Tm+fNAyLCstJs1ozsBI51F7yFvw4xhiTxBdERR2+Tn1T6/2qFZHtd/+Dwh0aGf5MOP6EeS0b174/BYDT2yVObi9CmhftUD8sUJZbwsqHVWwPr/VmbqIy7VjmGLm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170807; c=relaxed/simple;
	bh=xXS328NenWYdWrVxSjmVOn+66dLmS7vGg6SlIgkpuh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=se8UE6Pha6m6wBOseaalVTJK55mA2ZTU02Yh91iaoZ4mwYlvStJ06BGM+IJsFM2oIZxSv8hLkBrRhNabz5lM+6RprTAPrXbytu9l8PG0G/78XiUEQFiaHo52xnx1mil5iQea3KtFXLHG3b1eAgy3V2tyvgm0Mpw3znP93Jd5vec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a+s2EVqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fz09Bgus; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a+s2EVqL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fz09Bgus"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xtrn1160955
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 03:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xXS328NenWYdWrVxSjmVOn+66dLmS7vGg6SlIgkpuh4=; b=a+s2EVqLXf9v6Fdn
	9NQE/H5sHVS3yfE5C7hFH5wdv+geYr5SerZ9X8sy2qefOLLsJpezdCkXtdwt7dIy
	oyoj3TWGTcPlBgC6w0sfm1uVz3YhECQFPCVuBDxGq6EEqxWemnuZxAUB438YDMmW
	aoRGQJFqjnhjL3ekE2H6JHioTahXEFBTeG52Dld19of6DZtyE/39uZSKLP5xOmac
	OoSJDcncz6Ur6GzcnyjesZhWBz9xjpAQ2HSdh09aVqIEbpaEMbM/bl8RfdFwo5JY
	vN9OChJjomPWSjL2+4RWsIAfp4O6e/whRhCPV3oxi1L2ttb99foapYmjzUW3nJE0
	JMtuBg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfjvk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 03:00:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8952346bb9so5198132a12.2
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 20:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784170804; x=1784775604; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXS328NenWYdWrVxSjmVOn+66dLmS7vGg6SlIgkpuh4=;
        b=fz09BgusSzkr8NPaxw9KnTEhQ2S6IjNLiq6N+kK3NefAbm+QZbGBQYwchIHDLyGFHu
         1QFkLBy5MFb4nEy8JK6GJqIjJvJHq7OPfSiMVIcISgHFFFsjw+8cJVz6Ms709Y41kHfx
         qleDd4vl3c0jgPLkXkHBX/E7l/f6N7Mt41PuLpIRy8xjaJGyZT7lxQWkheiPzMU6qcdh
         HcLiN0Lifz1DBFdNYWGO/OlyXwGBWPLNDyf3snDeunoYhUJElll/rZAzfCfYKfvA6Ctw
         N2Kzz4QcOCtg0T4zkk9vTkLHHbEaj/2OlvzlfzDaU0srip/NZWOzIhS7w5KkW+IcaeIl
         Asyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784170804; x=1784775604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xXS328NenWYdWrVxSjmVOn+66dLmS7vGg6SlIgkpuh4=;
        b=aEJEIfrTDd27vlNuVh29WbQ/5lqaQVxcGF9uKvVchrGs6IfTLqJkef/m2Px2CI3Ecc
         kUsI/k7AUJJougv+xIK1WzqmZakJJhArb+AuDVld4Tf58K9aDPSuhD/6y4kOD8kb0d3y
         2lI0ijl/GuBJncnFIccFxsVT/tsCmTqAMozmtrSFB0gVoFkkxtCNaEPAdReOd/C00qrI
         n8Xg+cFR345516wD/FaZMwUjOIRbi0m+osgaZuPZ/qw0fSZ/RhzVQjbrYOtTXVHgHrJL
         phNTpGZOlL0aSfb6fiiVf8ev9Su2wPWxV3QB11xgF1gHu/EbdrP0sZ3pfBgg9Dp/2PGu
         Lv3A==
X-Forwarded-Encrypted: i=1; AHgh+RrEj4hO52hcm5fFmxJ0Uwefp1CpYCiA6U56vsK6bKJn9rGZX8wA/GLdnXVUStLWbVdLRaA8SA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywva0jVl3CO8cE4dYkB2Mn8GR+cfHFRYXh/hYWM4cJWears/CNv
	nyuKp/CiD304crAd5W6B8ywjvjksnlSIKifnMOaLot/Kwa7339n+EUny+HZunJrKQR3ikdadlzj
	vN/vLbLWvzhjkK3dYMVIZOROQLYMZxcQmG+nVreFYaaYKQkHpA81RdcZWsA==
X-Gm-Gg: AfdE7cnnR5DDwnANujT+eBUsaDufl5Mnqg7TMa58dMNT4O2PvYFoXJwDR5+S4CAmUab
	HIIG5yAWml0EeNEoWMjWYNuRgaZAt+knZtrSUg6yeN9/+3md81z+f/a8oVJT5YC3q5PlC15NYm5
	QystFNSdp1O5Sm+spA0v/8JFlBVv28M7cyqvkMTO8U/7o3jm/junUmerHt+CBGKORg7G4P4u7Qx
	rXlskxlvbiuJqmI4txnyvDn2A9DAWfaxilzjANwkzuq0UoIvjwFLzJYuTYcfPZBkdabfkrOtNYC
	F7TguRgus/ichI15gDl3FBCRWccEX3SBuVFhjtqZo/CCJNosDF6JyGI5NoP4mW5m68bD8tg5003
	mfheBYmV1VOVpF7p4h4x/eOaoihLxseNB
X-Received: by 2002:a05:6a20:6a09:b0:3c0:9c19:65a4 with SMTP id adf61e73a8af0-3c36c465036mr5496343637.76.1784170803873;
        Wed, 15 Jul 2026 20:00:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a09:b0:3c0:9c19:65a4 with SMTP id adf61e73a8af0-3c36c465036mr5496321637.76.1784170803467;
        Wed, 15 Jul 2026 20:00:03 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4359166sm5611519c88.14.2026.07.15.19.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 20:00:02 -0700 (PDT)
Message-ID: <205236d6-6d0f-b88d-99fd-b03decba6fa6@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 08:29:54 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 11/14] media: iris: Add hooks for pixel and non-pixel
 context banks
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Daniel J Blueman <daniel@quora.org>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
 <5bXXsqVEXaFsaBMxPP6AkG6XZFXCBP5B8YfjHjhTXuqrGd-XmP2eWPhNhH3LWxKQ_PWHTbdgIRh9AvROtnEHog==@protonmail.internalid>
 <20260715-glymur-v9-11-8cf2cbe12a07@oss.qualcomm.com>
 <65e09849-a27c-4d6c-9afe-934f08f802ed@kernel.org>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <65e09849-a27c-4d6c-9afe-934f08f802ed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wSruV8BTC2WaDsZbjCpxCOlWZw4gdaL1
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a584934 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=wOmbOZ9kRXkywvreR9UA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAyOCBTYWx0ZWRfX33AytiRBTHtA
 LatY+DRULptYTkbtxmzhI2yiNv0bCLMul/pjlBG50MLa0GyLnZK9gMLcErIwBNO80CLVfoC+vPx
 o7x0+eYywp/j9px4JlS/e7+6lR0OdMBHsD/TMnopArh18rS2xZuWhOV/CaesfrsEsuDJIgBfltQ
 WKWK3sjiAaa2n+yQcOJKwGDiD4jB1zHL+tCerCCbYxe9+Ct2fHJJbjr1Ymn8f0IxYtQFF1nX/me
 8OKdsL3tSRpyTEiN0gvsfmXXMhC0LxxUkbNNdr5P3yN/lcGL2Z2m1AQaZGDEVcuxvdxr+E604Vw
 YwZ7aVMGMYxlUV3q9d0W5ivdVCq7bnMyZfewx2wBAF6stu96ZulYQgbxfqYLJc7cRI60pE4TwG/
 NR2x0ikXoWgSKCw+XnXOUazbkVERS1Rv8e9W+Jwa8+WQUWrCAsSmMkOaHKL3MKWGSEbM1kOmdSF
 6jSay7BBUiVrAOA0emw==
X-Proofpoint-ORIG-GUID: wSruV8BTC2WaDsZbjCpxCOlWZw4gdaL1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAyOCBTYWx0ZWRfX96uS2Yxo7dJt
 tdMaTgEpe5vpjZ9nOvidFt1PKNjeR77gVlkE6z5jBt+C19iJlgunsUMJiEuMs8NntSlRr1RVZsl
 2jskSeRyDZsA5YelpaJe9DuwzB3Gj5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160028


On 7/15/2026 8:57 PM, Bryan O'Donoghue wrote:
> On 15/07/2026 15:10, Vishnu Reddy wrote:
>> Add platform hooks to create and destroy those
>> subdevices, and wire them up for the affected platforms.
>
> All platforms are affected no ?
>

Agreed, it's applicable to all platforms. Will update commit description.

Thanks,
Vishnu Reddy.

> ---
> bod
