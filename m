Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B1233921
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624411; cv=none; b=urxVo96AVesrl2U0doyK/5g65fdFMcfL993SQ/2Zqz3h1ApMp8ZJNXCm/H3tblWW/FELWs9xGqVGjO1ZLIhKON1XaGGQmtVeuYib9noWZ6eZanEmfcyf+cIApEAA+5nm0npKs4dGV6x+7o+Jgx+fb/cJgAM9jyKI93V/kmbRpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624411; c=relaxed/simple;
	bh=97jCrfJLul7kc105qG9+OBG9JEfnJOKqogY4DP44QCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m51L4hBVRdVGYz4U9ikorEJK4lH1qmXZWbqLcBapvnLsJTd+Ia4/x6TNbvwuGWODkuh4h5s43PuTewtJ9pTGhjz51eV9jLXGd9URebo0YEHadvdCXTNWCSt0JunhVSTGXOsAz73T1OuvbO8m4GcuneLyg4Tx02EjTYR44Sq2Kls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVmUgrwN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MFebCp85; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVmUgrwN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MFebCp85"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HYDLT2476568
	for <iommu@lists.linux.dev>; Thu, 9 Jul 2026 19:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	93SaqZgRCSZmk9+Ho1xlDlbMr7fxHHhWTs2lCLEiG/0=; b=YVmUgrwNnfs5PiOP
	xVFJ+HLcHPcQzDiBLtL5JLLhOBBI3ef8L/ZUJhvcvpxV1hYIta22f8DSSRBncqzu
	JvAOXIp31N47AmnsygndA5oWLS+WI8EQv8osBcvo6NTlk7E5fqXkWAWyAdbadji0
	ONX/xMAk0wHhMinxZuhejIbE9J4BFODILamS/mwvJjeb+UjwlxIj+EnWOvBMXCjD
	RA/0w2NQ5ZU4At/d724ZsyQZ5RIPlRUpSwuJjMeCtymfqsTf9+IyTTwJwQQ6w6pB
	OmrOHktk4Qgo8jid+3Kifc9wozrVwNBoKdwG9aErCkbrNUcNTBMRfNkEyMm3Vwz2
	yeHwMA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mrt6t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 19:13:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c27616421so408281cf.2
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783624408; x=1784229208; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93SaqZgRCSZmk9+Ho1xlDlbMr7fxHHhWTs2lCLEiG/0=;
        b=MFebCp85XfF9weu26zNMtGjYwl/FdSMR9W7NOlN4lizjY5VYcMNWIGgs0OMf89mrBB
         VRFuqciO0Io7CH+r7Wz7k9Goqfm4QFu9EezEGS3daqfqJ34h9von+eVatfwl4EPd455w
         fuR/7jd5rZrx3+T6taY/GFNWn6d6BGXxhW27+UeA/wqp2BkadEEY9SC0yiZSPwhFyZMm
         /hMQNQoL+pgqBGO5x4THAreBK/bOIQlDxM6uCLLI0FLGKlpu66EK3D2i5lr1O32YNnm/
         uez67jmzk3Zl6s1/TD5NXitqcB+ba5mFfhEWqnRXQoWaAkt33/rAoOeTLRx3Kcb7TXZW
         ZsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624408; x=1784229208;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93SaqZgRCSZmk9+Ho1xlDlbMr7fxHHhWTs2lCLEiG/0=;
        b=nc6CYAI34d8De9K6oCCqwfOh6RdMkqkN2MfYno3btpR0eFgEJJfMNBZLNfeIT2mPRM
         KoqFSW/ONp403AH3vIvzm7hQFAIRvqMP1bfgihAHkWS6Hw0haTP2JNlSluGF2W2PdsT2
         8YZAKKy+l1qVAUm7ROiaBmet/wFNKBF92kxyxt0FDFgoAObyeAXEEQld4dAyNGOfTXra
         BZFZkRMjAKgRWTKQIxTQsovEgnGByRXWTGAtitNflETDw9tsg0Us6TCMUpnabdSJCrh8
         uiUO2cY403cdOtlsG63cTCvgdyWMX6Dsc2bXt/Vz+lXfqYANCj51p8DpDgDYA+9ehXOJ
         zMsA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1ziaRiIZZ7DtiKtbZ08dRmIi8By0cSiA3d9yYHVLPEqWDG/QPoiVpH6v84XCQ+26seVtIlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJCHVMkf5eIsg8NFqrzSkUGU1YCYJRWhGhfMEadFmQ223UIA45
	3agZQUZpJQWSQ2o3ZZNAChuQYkPO6IIyFJCCVR0t+eYiUh2ognz1zHuzjtTqu39EMpH6F2aZmhw
	0SM1+0uRYdPt0Rdwb7RlAeFOYBD4D++XKWiAE61ly2VFdjyEbQJWw9GioXg==
X-Gm-Gg: AfdE7cmjcxkUK83yrPXjOaxuC79J1pV1Y9Vpp295t41ozU0nAeewjHljSifwdY6M8CB
	pQUgoLxObM2F5YLcDRQhSSFQtveaPcy9njgPfbc9nblWCo9WozaMwTFbPPezk5tMGKkNeLYSCeV
	WgVyCmWHYfEiNRaM95oHbJDIyKYWiqLD4nt+Hjjq0f8tmciuAXDsRCDo6+Hzjf+ZnlKJdTL15pk
	slkkpxRvlenK4Kf9hzQYCf6ftvS47hSOGvPSLoyLlG3sdN16DK79BE4OT3HE6gy7t8keWqm/gfW
	k4Tay4VgE1ABeh8UZBICcCq7Tc9M4LvspHkOuve+cwWLVFnDb3LSxr51wkzpVRuJk2Zz0dKOpNX
	ad9MnNkdzYK+5wW/n5xcATbxCREI7sxXKic0=
X-Received: by 2002:ac8:5d41:0:b0:51a:8945:312d with SMTP id d75a77b69052e-51c963e7d09mr47417371cf.0.1783624408394;
        Thu, 09 Jul 2026 12:13:28 -0700 (PDT)
X-Received: by 2002:ac8:5d41:0:b0:51a:8945:312d with SMTP id d75a77b69052e-51c963e7d09mr47416731cf.0.1783624407847;
        Thu, 09 Jul 2026 12:13:27 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm277444666b.39.2026.07.09.12.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 12:13:26 -0700 (PDT)
Message-ID: <b9c41d2c-b036-4d58-8cd2-da94ab6b9ca0@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 21:13:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: shikra-evk: Enable A704 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
 <20260710-shikra-gpu-v6-7-b388ec5dce77@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-7-b388ec5dce77@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yWmtL69_ZimW-FIambZD4FryWhBDwmZh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4OSBTYWx0ZWRfX9j1cFl+pnUFL
 5L3kjoAqBJnw0ax/VKwZ2QLT6k8rJSTO5w5+hzFXhMs3cDAuZ6VYEwdSUFXNTfX4ANplJG4UUyd
 Bh5YwYLf3kHqDSuoQ7m27CoApu+lQV0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4OSBTYWx0ZWRfX/IgJgNOtjs8L
 04Eh+hXTxy5TYRkJdjNLerIwwVjfcNDNJeuFJMm7+UM/CYkXbtULi/q1YXtxpEmpV5+69PG/RMc
 ILZFgsIXfygThQh+WC5cZGkbbDmQosFaTEvfheT7y3K72Le2fvR/GEXk8G/k5MiSrKR8SaxzPR2
 JBidUMqAMHBgm1HJI1AAiGQQrTc7vwURuoHHcSJUjzOpbEdgjf3hn4xjHf7/ES5oC5ADY09ujcz
 g7kB0WlqjHnYuhy0/q351GLSNsnpD8j5Kg/Sgh8fIwWvc+rkEKGXn0K11Bd2NLfRpOpj9GLwBKH
 /1kOrJoUEAtPQMQwEjFruAaSf/PHHJG+UOJEYWJt+Si289SDRguxVlnJMpIVz9hQEEEvIeQbQe6
 7bcTd0XzcuZw+rCPyzwN7BiP1wyhNqeULkQq0/gYso+jQ7rcOMxMLoU03pWEZfpAJiMYg7FIW/k
 CsUDiXNrziocV5dnMLw==
X-Proofpoint-GUID: yWmtL69_ZimW-FIambZD4FryWhBDwmZh
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a4ff2d8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090189

On 7/9/26 8:42 PM, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra EVK boards.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

