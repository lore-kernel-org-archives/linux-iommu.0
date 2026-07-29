Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F334DDCD
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327339; cv=none; b=ehbpR9+JoMxHY9D/Yki4GFpPiVbW674Z8WeIW52SKrOc7x7JwW0xNNnflTM+5mLE/jniITHOjjIa0XypAJvm4vM47+uF08z7132DLBGOyVXfEQZUxalBm4laoUpqlI+k9MMbM2k2xgEFJuWyWMcnBTHZZnqnw+eUZSF4LI6fKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327339; c=relaxed/simple;
	bh=s1gO6f09FjP880JK9PFOp1s4Jhd3meLkvmePYpvEaME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElyXfWJtgNyJzeBn+UdxO9deAcFYdbzB8fkZx4JSKFgFAWxK0OebdNxkgEbtNhl/uDHDYp5qe+9PWxeSFUApAZeenwVbIl+6GPzzdo9NLjsyLBCrh1WPEdR3PLn93EX8dE88yABpHSHn9fKOEBZY4+aIqJef0dIa38UVyA836Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ntcstcyb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=frULyvQ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ntcstcyb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frULyvQ0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBtDTe1767784
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 12:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZElkTGKf83zLq2SbG+PkttDl3n41jxZHeLynZGXTAho=; b=NtcstcyblUs8obhs
	ysvKMRRidoHCETaaiqeNG1BgfTAhsrZ7tn6uONKNJ2R5iOTNYTgKyATa4JiuzdvS
	25JBLvKw21O3BtL//eNybZzx4/q50Bw5zvanJ6/qxe8ojF04mTT/V8R4iQ0IfGY/
	sw7K7ob3WaSYIZEInzq5qhpIgYcJzl0GQAn21rXnGEO0GlQ1Bijcnqu9065Z9qxW
	EZr8Hy9HHJtDjamdro3PTTyG/ZorrLNnSv45UU1gj85PXfuzEmACEv67nsYMun76
	2k6+xJmzM38uktQDtjGCqlHRPgssO3LCQliLQClRB50coXs4bMD7zMfnqYWVT8Ln
	5MSOKQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh2kg2kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 12:15:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276a49e761so1334551cf.3
        for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785327336; x=1785932136; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZElkTGKf83zLq2SbG+PkttDl3n41jxZHeLynZGXTAho=;
        b=frULyvQ0MdNLWxpVAdeFEztj2zKDHMnQxOwCWxDnxs77BFp84iLicxf7YQLWsVx1qK
         ASPPMu1okNOOCiiPd7b6EQQ9wEtBYTSbhQWCIPilso68tLKXQyZ2Z0b5Ih0rHKqy2xRy
         f/nMuBBPaUUU/JPAGVw709EzDblDrl2G1IDVNuGbZ+fFOqeOM7xdcopPsnGxDa8iL5dY
         CxKWwivzImRsePupubnL1caOfZ/nGNb5ZnAF3/PNAuljXM8XPKsB1cY9uEZDA9fG3v9K
         h71mO0pSww37nkgWuXXBEt+d4zCsBCp+q0uL2Mc3VZSLMdg5DHdhnSFfVcz3we6r+dzK
         iioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327336; x=1785932136;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZElkTGKf83zLq2SbG+PkttDl3n41jxZHeLynZGXTAho=;
        b=Xa8EDZ5M44Ira1L38rTFZbuF8EjUeR8wH+I1AinbEh/lbSj1Nn36AfsvpK/SGL4c71
         fL9ZpBMdkMNn6xhVuHhfIxG3BZ4Dz03fd22T88tkfPC6IX1XPrr+zfYdjZ1AddWWl1ai
         HGpzPimv5Q3DtZMQAVEYECssD5jk+ISVcxac2rF14RnMDcnA5xvanHYNUEE/uzRgD661
         PKJfmnrRzI0dl3E4Wrtj4uBVviYhLwrkdd2pie6XXSeSKk6keh+Tj0WVpBcvcyV+c7pV
         U7y1VEg1Jhjzb/rKPu3alG5GKatIBCVWE7Rr3qavWYiwmceN3z2PaaUz0yAUxPNSq2nZ
         MQbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAVYmWGyk1111J4NTM5duGN81HKebgNwBeJKyj4n96/RSdkV2biLgOD37phL7C3dnG+vQ9uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAIH8qceu2i5VophNm5KFgacgpEnHd1lOWT6D4R4G4CLuMlFQ+
	HXiDR+2Ow2CCIg7FV8VQd2qlwbpn79Oz/9n5FugYSsVJHh/ETrIaqIQ9XyYPy/nWJ2Y8jkwNpFv
	sW/i5hZdksbcBXarlyyoDzTntuyWjMQC8gHD6vQsjd1+92TmZUZmbDHEoHg==
X-Gm-Gg: AR+sD139kF3SSlC0aSJDLCojA1FAmmG4Nl34ZmFK75VfRCe/jlvt65PVhARr4O3Dc4O
	vlVMb5l7GqcDfQngOxiLJX1vwFsUKUyMptaSSl4POeXwF/yuR7CosV+PQsXhOrIutbCi8s4eF2K
	Biss3H62jO5Sr1kh+SDiGLo65M7Q6m0Wdlc9NS8nOtmZwCycuKzhF4OJro18zNVGSqbmfh6hb7O
	CrdeZ4B8ybUJAZkrbHyBTScDzaUtMPfzXHx94LTkMDTwMinfj93zbi8mIPBXfoUUjNXNr9RrPr4
	LuVchA3jA57FdXzLh3tMONzmg17SAq2OlM+vgrpXr8tnrp2bdmcLsMcaTnss65IULlIFwErYTMY
	eLANyoruX/lYc38goij7sLrRE
X-Received: by 2002:a05:622a:82:b0:51a:8079:795e with SMTP id d75a77b69052e-529d70f64dbmr56395651cf.4.1785327332049;
        Wed, 29 Jul 2026 05:15:32 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:51a:8079:795e with SMTP id d75a77b69052e-529d70f64dbmr56389371cf.4.1785327328171;
        Wed, 29 Jul 2026 05:15:28 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4e079sm104234966b.30.2026.07.29.05.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:15:27 -0700 (PDT)
Message-ID: <207866a8-bb1d-412f-9cef-3a597762a949@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:15:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] arm64: dts: qcom: eliza: Add GPU SMMU node
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
 <20260718-eliza-gpu-v2-6-64379dbebd7a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-6-64379dbebd7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMSBTYWx0ZWRfX7NTxsa8swspG
 490s6/IrhPWk+vcl6E54aNgzbL4u/EHieZ2NQe+pFffIdWLOB5ZohuexEJcRjw1q6qd6kE/ABU5
 reNJrLiUCCKqXdxuaBcuYHk8U4aXmQU28joWiHBvEjQ5ocfidUdzq22gqXRiIrrWZKQxPdAvB2B
 oH3V1wB71ATg+2eVF5Q6VUe7hB/JTTZwdHRNBu8K2oAZRzONnc6nHZ12z0oLlJcWLKc2xqnnFPB
 BJ5fBq2EgFg14TkbOG3JBNc4kS8AnNc8ILkZU/Dwb9zp4UX/gP8ozSLrkmFcRmw15O5amepuWFz
 SZoV2S7oQE7rW4yArMlNNJBSrdMdXpxbWFVh9DjJAbJ9IAUZQXDOZqlZG1dkDnSrNo06C9I0sfh
 r4haE+YcgyrAT7p7eeSzsBQlYLsFGouxgEBZ1RzObwZVlGbUal93vjuG7sRB5iF6G5eXUEcp5Cg
 +SpQl8bDBxFuitanI6Q==
X-Proofpoint-GUID: Fem4Cy66A0yc05aqc0isgkCYa-2vLQ4l
X-Authority-Analysis: v=2.4 cv=Q4biJY2a c=1 sm=1 tr=0 ts=6a69eee8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMSBTYWx0ZWRfX9/w8CBOq405o
 yFbczUilqKwtDwkymKHT1aj+eqcb30EQfGI5I9jIfrnjRkR+gf+9IBmsVRcBkWPN1pRHJ3sF4Ne
 m6U8r2YxDY422kerIOLxQph5+LvNoms=
X-Proofpoint-ORIG-GUID: Fem4Cy66A0yc05aqc0isgkCYa-2vLQ4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290101

On 7/17/26 10:41 PM, Akhil P Oommen wrote:
> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
> Add the nodes to describe the GPU SMMU.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
