Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156E337F32B
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819901; cv=none; b=VJ24xyBWUycHX6CgezsZlsdKFW2cr0AV/YHy9mwtni+CQtydzMGG4X6jV851XlEzRLolOCA+l5EAaONAL/BFOFR0EeplzPR0IZXlTw2zfzyS1Fn4yahlZjkBnRrOrD7075U4MGYcQl3CCsjoZLNHu9N6n9OTzjlVj3FsVUKCyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819901; c=relaxed/simple;
	bh=WNlxAVW9sEGah+tbexj/J3vs8zzU01+pV505LfFfPdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6M06EgHCVpWd6CWD1fJB5zoolAqbk9CTJ2FKMSvvOwN6vGR79WZwPHFIUKCxUdGA60V0Cp4IVtu91+g84Ivoi7K5sC6TKHlT2BXwbVEROUoj4er96QyLPX3jowhChwk+6FVvgfg9DDI8PxfPpK7F9070VIy0yU4lV3L7Gwqut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Av6XhOcW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ynb6Sshy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Av6XhOcW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ynb6Sshy"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6910k2LG2012667
	for <iommu@lists.linux.dev>; Thu, 1 Oct 2026 01:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZdeAUChydPqhPIvtw0cY1t+X
	ErxSg9azs+6bi/qs5xI=; b=Av6XhOcW37SpihgwTkGfs4qIDt0nNlPqo7uM+tTP
	csNja1zSArvVgJBXalT9UdhucfFxx30xWP3vbe9cMp/ntSP2ByZNm90EG5v4c7VJ
	oJRM6K0oQAo2/W6sdLegXqhDjNH6g0ZWQl4iej31n1Jnf43bB7ZmmgH7nRQ78Uvt
	CyODMykncY4RRlobcyM8BvdeEg6lyJpGykgjRJg5dDYHUGmGCcvmRu1UVvwOuJpW
	mb8tx/7QI09N3Q+Js/9N6NCgSGYOWJQ/8t1vMMmS3EsV9vI+8nS8lm3nZpdqimoq
	BDGxotkozDyWaDVXRZGMY7T2nOabY3jC70ckSGuF9uyvGQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh83xjd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 01:58:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93bf4c0af4eso77927385a.1
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790819898; x=1791424698; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZdeAUChydPqhPIvtw0cY1t+XErxSg9azs+6bi/qs5xI=;
        b=Ynb6SshyNhfurwhPlgBq72cMj6I3Z40J/oBfKHM/nlm41IwHzIVi4YKzXRXhIW3Vyq
         2r39TYEbe+y8ZiQGhPwZyBOxUKEGW6dLMM9jyVme4en9f2kjmowdBnTxIJ1M8lMg4QkM
         AHOF3OziNtMpAIqMfWCweRjXJo49tDNZMETKi/N8SPLN7Dhs+sNQrRkJZALb+wR5wb0c
         CLU8dsEFVdI0PBltTAm23pEkNjYq1HsZ7+VYeqI2gBLCLnrtSKdlaGi8pqJ82OEb2Kjf
         pjDMDkkx4a5qLP5hx+ujydvWhJI+B3slAxu8wRQEK7PKbAVnFHUboz2YWUNJfET1nFK2
         Efnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790819898; x=1791424698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZdeAUChydPqhPIvtw0cY1t+XErxSg9azs+6bi/qs5xI=;
        b=OQO9dHQITNe/hSQrAqAhsr22KUjcguDTIoaGeN1MzBc1m9rMpIAz0+orKhgYgaUuXV
         lIa0itKT4Od1D5U6UzSUNhVNuszl764CmvkLHoEXKaLxOfdBg5pVP1XJHnRhv9Htf7uH
         T/v/BsBUYpfhQU/AQibH14UvrLCKJS6KLJV0F4+SHVvaOOyGFkla20+80dyBAfcobjNJ
         N8NbbQ4jfHnR+isPJmDDj9MECZmYx2WPvuImZWyIA+ai1K+OnCmXqHxWjPZM4YA68qnp
         oICDFumObbMFx9kVjoZHsiji73rxEM0Vlc1ndOCJCwUkC/+rBKsv7nc57CFsnhdOqTWE
         AtAA==
X-Forwarded-Encrypted: i=1; AKwUvBzgCVWo2F9SnsD+YyhNxcGeFNutp077aZZqjsuIzKlc5yq4b++URmyxJoVpON3njyaAESuv3A==@lists.linux.dev
X-Gm-Message-State: AFuF++mL8eo8fPmzSnytO9JJxDfFs/DS3injqjaTB6s3texwD8ENL4xz
	JsFJZM/A75/rhEXidBd9OkpBM6c8thgkS9LxeTORsltY2Q3hiYQkHpW5tBb3dGyeVCsEQESvvaW
	Z3IXMlozO1Ehugbr21668L41NDj2GTYt1lqe0ADmL205APO7Cfzzag8nX3w==
X-Gm-Gg: AYBFou0lfXceT1ZlN4RVOghuRkHLySABn8vk0whFV1eSpV1DzLDkxSccInl0Pbs96ZC
	gp2hmM2y3kmuCe3NuX+L5cj5Lapoj+r07d/mtED2P18sZgCNFRU82WYDyfa8wl9agYPrUKpN/Pq
	QgLBKywSGlJw36nR6UTujkxGD5aLGntst0CfpqYJp5AfPVnpraMJ7EPzlG7ZPVmGNqU/o5kLy0I
	eJ3QmI36misMepYTgkWiNevB2TJWn1zhC43f9ZiGcsm5RAdq2CcAFVbfuF01s6P+S4vrBXP4xNZ
	p0Y3WrqJxfFgWrd+GaZnpgVFS9V920OZzv3cOjSB6A8zz3qSoR0VZGyyLNasDLALaJHLpJhtv5s
	8L3jCl1ET6QsgvlbjWWTG6/2aDOsUbkMiny0uf6SbTfsghFsELTjugHaR28hJU/g6E/HEniSKl7
	mqqJ23Oe/oPUcg
X-Received: by 2002:a05:620a:2991:b0:93c:aa6b:93a9 with SMTP id af79cd13be357-93cb5c10d42mr278084985a.32.1790819897790;
        Wed, 30 Sep 2026 18:58:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:93c:aa6b:93a9 with SMTP id af79cd13be357-93cb5c10d42mr278079485a.32.1790819897286;
        Wed, 30 Sep 2026 18:58:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba440595e3sm175732e87.8.2026.09.30.18.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 18:58:15 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:58:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v3 14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
Message-ID: <lxil5g2zx3gr2li5ola6xyj7khwfltzbyqfuflqygrcetztryu@mr65up77ioec>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX7I96BwyYz2EU
 DnRszklGFfrCbZuxG0QkSjTx0gqeS6m7HjV146r7+U/sNQbrCZLZSOjmDT++bspkWPFEfvZdFs8
 lN2fyx7AeLYKwcJES1+aafO802sj+2XS3ay46Fnab5wh76gxtoJkj2MBDDIU5EAKWVxggLmfe1f
 pHeCyCjMcscgzKqXLpy/o5VoT5lwPz1Oru/GyZASeM9Upfnpk6kfr+xju6abGeGW4wqgm3/IDF+
 yUpcSkKzDmXWFDRgJcMNvcq/SEkmKhHdfajCxYoCSEY6g+5djIvBiyPNivdnb5/sB71J5x5O1pV
 V7uRJxAu3TsK+PXYiJqKLXFduBkhzxbfFn1ufGgSMJweFVCj/Lt/WXlxrJZGgX7XUxN6jGNPdPq
 aLITR/lySJ4FkPpm5ff4AtuiyqxLsy9sLvEIenqYHm+CstcuV9ZHTDzxy9o8coI0UyaqQKeQRhP
 PIcF+hJlr9jPwB+tGvg==
X-Proofpoint-ORIG-GUID: 2N3isJqvv1tECFixkh3qjD_z4s5RFhMf
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abdbe3b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=OuZLqq7tAAAA:8
 a=EUspDBNiAAAA:8 a=bqz1LMNPX605IxUfdh4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: 2N3isJqvv1tECFixkh3qjD_z4s5RFhMf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX//b3LswoJJG+
 baTEz3h4leDFwiotlUa5yLpKFZruuvRzAMK+XXLca9DE/z8XG6Sf64LTlqkZ3wo0M5NdwgHdu4X
 8vbxBxDCvCbHYoYTNVOTBEINpii7EN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010007

On Mon, Sep 21, 2026 at 09:19:05PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
