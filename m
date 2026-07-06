Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A56432BF7
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355815; cv=none; b=Wz9kT95W/om13WJBnxRVY5neDpLPScVs3Tw1w9M1dcY9ahrOwBWscLSvNfWj1F9Drqqo14dFiKuIjzMJ1B0Mw/zB4XJlliBpuG1LMFMg2hHSLWiinG/5/CpmHGHlyVdIZCYnMSblNI0inWTKfmDL8zyqumBhpIxNA+UB+k3MRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355815; c=relaxed/simple;
	bh=oXxzqxUWNYvCFmZrt/ZzFvpveO7OkWrcSL3lLSJY/ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb46nQW4AjZ3I67rlJVHDR6CcWIwjIXPKeChN/G8f8eIXf39kRxLghmZpGWb/yJzOXWRcZZblB9qkT3pbyP4Hvvedn1kHNkdw2Kd+gRjPCyl1K2bawsvUT2HZJDsc3ikjGLCTK7DuMkEx87tOROgpFpLEI51peJLXAUMmwyq3D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A+kE9elW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FQnSBKGY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+kE9elW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FQnSBKGY"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFGlx809794
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 16:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oXxzqxUWNYvCFmZrt/ZzFvpveO7OkWrcSL3lLSJY/ys=; b=A+kE9elW43k3JhEE
	wG5rxbGyVqiu2EJsjUp4w8h255fyh8Sp7V1w75SG1Ng9NMOdpwAOQmFB8YKd5QjU
	d7HSNSGLcZaVU7dC713562ldZ6524HIU9eTjCknQ3KlIdtBzkUwj4nGhH9tCg6Ro
	rmCpvpmSDucwm88BxcOV+oGsUYlUaOFo0KNIwnZJ1O/wvfe1FeYeLcl9poOZwNmL
	RqZYuT469qkFJg9EG1djaMfkTW0CTmzC6c19Z7jY7BAgY7gfmOju+N2koDZjgUhw
	WLyE+QaDhqQvpN6lbTAdalxfKEI9w0iWF56xBTM87k5N2fLk4qexXlL8+o07U2Ys
	f5UTEQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsabmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 16:36:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0c6ea10e8so8887166d6.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783355812; x=1783960612; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXxzqxUWNYvCFmZrt/ZzFvpveO7OkWrcSL3lLSJY/ys=;
        b=FQnSBKGY6PCXQI5cwbCBCNs132ViCxpA2FBKwmToPrHqKi2TO+Zu7BXui1Yq0qthmY
         wqW6GIjyusZBNmkznjCAn6XMx14E6r4FPD2kwUbcFXaXBoUBwMD/i/ZIXqgONwYFG8hb
         33rOM7MacUyupaftvu+FRwAIMQOnldDpkXt7TBSMBg1tmJzV/foUCMm0tZcOqSHNAQt7
         gDVGlgM5cxvez+u5ACMrhAV1CTWRou7h52UoeBOqvarEkZrvrGlnMIL4uyBLtsGS/dtO
         mdpoWqIf+sp5kwv+E+qI69fuQ+MO9dKM/EGLnXG1fjgxymklqKtRZXpcy4h1wgC5jXZM
         az5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355812; x=1783960612;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oXxzqxUWNYvCFmZrt/ZzFvpveO7OkWrcSL3lLSJY/ys=;
        b=A8o5Af/MTdWL9jfIbcbfr14KkCvvVRUhE7p4XLfodJwT4elvgpC+JEdTo+eXc8s4Mg
         akGndFSvxC3gJKG6gM2eftVn/0+Z4M9SyFuGSph0xEg1j1FdYq0UPfV+nNrKhi/6Bbm0
         9eS4Kp6anrRuJwghuQ5q3bDxUoJ3X1+NYJB+A3sPil2DqinIqpOcrKJq32k6/u2MDQkW
         IBIJgQhBFPKntAM3T0GPZb4UOgVSs+Gx0OPaNOpAOyzErC4y6hlJ24vUdY91dtkprd8v
         4co5DQE+8/hHyOAjjBd5Kl3JI1O/GBE6eUkQ0BEICfsvwkjOq7Rt4y1TdGbZO/LPofz8
         oQXA==
X-Forwarded-Encrypted: i=1; AHgh+RokgiRTWyTJIm1CpaKIu2wI6nmZKE1hZus7wWZo1qKOU+sxdMOsDo6CNC1419uxRuSEJviObw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcUWR/vDkkyTSq5ga547OFpvaooIjIJwg+GImJvy0J2z1DA8xx
	uT7S7JfOJqVBGa46GQSzLsO8+F0YLph3a7nk3hDXUFZbq+3rMlLurnQY0/VJ2T9RJLr0U/QnYJN
	1JrS8r7CDYTkDy4D3thZBReOClK4l+wsf1dzfpT6NV/cnxCm4ncB7oS2jnQ==
X-Gm-Gg: AfdE7clNUg4G4GonNB1wzkleAsDQKnTbWjLIKpTuQzZ8E+OHqS/0WCTnfFal1eKPqQV
	URpS8OvlAxDcH0CRczpH8jvSl9D/fDST95Z5dqhvXVxp6lKj53nsWoujau+m2RsdJdqw5dqwZqR
	ROlJEej3rzoavE9VSEQhbJXnr8eInjQHgbuNQDDWymr/jZzFpcTAlf1H4RQppiYADOfG71kW6Vt
	Pinxqewqy1Mlq2SpGY2kW8LS0BZ3qSiFFU7lWeR9NCdT0e/TTVRaFvZhoOLle95wIlIbVHwm9ti
	/psPwwbucv+PCbwjApdQ+wRY3LiEf9ZfeN8O1syUUTkL/ep1r8AU5ihCvdSFdPfWT939TA9nbmd
	BwWAhUowCpnuI0oYqKYG7Jd/9Aj1yEuGI8Kw=
X-Received: by 2002:a05:622a:7:b0:51c:11b4:6b24 with SMTP id d75a77b69052e-51c4bdd7802mr101176441cf.3.1783355812356;
        Mon, 06 Jul 2026 09:36:52 -0700 (PDT)
X-Received: by 2002:a05:622a:7:b0:51c:11b4:6b24 with SMTP id d75a77b69052e-51c4bdd7802mr101176081cf.3.1783355811741;
        Mon, 06 Jul 2026 09:36:51 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19ce4588sm4668489a12.7.2026.07.06.09.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 09:36:50 -0700 (PDT)
Message-ID: <7cfbc3dc-c1c7-4e4d-afe4-67a25084f607@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 18:36:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] phy: qcom: qmp-combo: Correct pre-emphasis table for
 QMP v4 DP PHYs
To: Esteban Urrutia <esteuwu@proton.me>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-7-37e2ee8df9da@proton.me>
 <4635a665-f605-4647-810d-c9d83a271a86@oss.qualcomm.com>
 <9a203e5e-5d16-400d-a507-8b68df8eb017@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9a203e5e-5d16-400d-a507-8b68df8eb017@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AkVvTyC98D2l7saXkDvCJIZ2AOsBXWyn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2OCBTYWx0ZWRfX04fvSK/4WtUq
 aiJ8xF182DMfrVkCXN1JSA83scve7nZiLfKjQSAOnlJAd5dahq8Am3IZe5XbTJHDRQs8UMOU0kZ
 uMF3AJmYaVB8MLaVwUCN4WK8gezFlg1m1DWoSGuIF3Sdr+8MWjRcSORK/xxoTjD06SlBHZ6i3rT
 GD2I66GHOQ5c3ic8ZM4REcVzdSAyKTz/KovkeP+89Xjt4o0LV40Ogfp4T6+wpG6U04MPH3qAoE4
 mny30jo767q50sXdVO9sJ4oVomfLNtdSQ/KXfnCMTLG5jbzwPVAVJ9CN1BlfK0Kl3MtJIuIpo97
 NsLCVMEtOnRLOlpRr6RcMv9xFVlw4Ros22d5HIDsNgUuo8H1ktRRMWYfajqPAQslMaK1k/D6g7s
 BwI6YgONDDHK2jnYXmKMxKh/NiGdhbWYCbESSVr2daaEidjCUo50YY0ZlN1c4yDjm96qoZ8jmTg
 WkZRso4DuatLgt5iEYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2OCBTYWx0ZWRfX2c9RsKzOxIO/
 tcNpnHAO3Y/8+pvlQTRcRcQJK/IF/t0kdOdRd1LsVl8tSNE3FCer8nLqZXIM4iYaZvP3nrS2CnS
 ynGMuL7e3uS1L1p9bD4fevFaCzs7yEo=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bd9a4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=F-ycRNR0_AuAsNl2EYwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: AkVvTyC98D2l7saXkDvCJIZ2AOsBXWyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060168

On 7/6/26 4:44 PM, Esteban Urrutia wrote:
> On 6/23/26 7:36 AM, Konrad Dybcio wrote:
>> It seems like 8350/8450 should be using what this driver calls
>> v5 tables, with this fixup:
> Any updates on this?

Dmitry, could you take a look at my findings?

https://lore.kernel.org/linux-arm-msm/4635a665-f605-4647-810d-c9d83a271a86@oss.qualcomm.com/

Konrad
