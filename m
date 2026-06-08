Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB87378D9F
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903185; cv=none; b=tUiJYXyrd+74sdGj9FtgjfaD9PlqEd3KUOfzm3Izt83YViSJXXCnH3UTypVyHLbJ5sJIsAq373y0K0xPjFyh3Fcjh4ZRTK9he3v197gueBYouxRM0kAK+lmAj5vWwSiRnyTcuGjr421C+rU4ytlrFC892me66xv4Y0uzQ7Fr+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903185; c=relaxed/simple;
	bh=qD9e4KyK1fIzkRMHO6aMKPF96czRHshznS/0D0FaTMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh6fNewlTAAYqQdx/uMy9IIPbLtzQ8i942GU1h243OBWhdw2+UhVeTlMK4clDLhGhpgJiLexgM6zHAyCGQTRof555oRngYk9fV7Fm3IraDjR+AxGxYUJLkkR6vZbOpX73qgFI/c4Dn+6/S9ZGigPpAegO8444Fh0pRb732xr+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jpcG/D0X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WrGDawtM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpcG/D0X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WrGDawtM"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586P76T2386295
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 07:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TszHFZ7K4js/ZAFR2FtK66NQ
	PI9cujME4oGOjetByeg=; b=jpcG/D0X2/E/WrFN1uFBDKV/q4WUAZwxEvep5M1J
	j1BiCdduPfaq02JEUHAzRRGLIAwq7CjazfFRjN+HyM+LAM2dyysoT7hDLqIfAvXz
	9Nwg5sfFc+41cIR/o+5tI5fRue7n2BZoRBGGIh5VJLcSrlIjAnd39++ucNtF89fP
	bKfGg8DXlFg8BDDJFMlnFQDFUXh/JXj1VoZYWzUC8f/bcUENSh+7CQoCmrODHd/2
	YiSkB7eeV7/TuLUszkH9X6BWGlPIN4wX9gb26VtOQ97G5a10pPn7UCuS583WphJE
	jp469EdWpssWsVebwH5dn3ZN4TXUWvfxF6wbVymaoP7obQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1ecfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 07:19:43 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963d7670e38so5094308241.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780903183; x=1781507983; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TszHFZ7K4js/ZAFR2FtK66NQPI9cujME4oGOjetByeg=;
        b=WrGDawtMv3I7UqAzdWOE2KP99/7x9o8ZQjWxbdl2qBIkPy5PNu7lvHseQky7HLlNpd
         guqTBwRk+cPGfK+enRFxu801Fbe/Xucwwx+CQpsz9LKbXPmi/KaA0nC5dv/OUmj+movF
         rmFFkR/+SJ6VPJ3r9DuG/PkPIayMcg868imfKXU4rnwhonTfQ3u10jNj+oXO4mEdxkGP
         yVr6ADYypkxHGRGeTXzx6YP7o+i4Qx44y9pGtdYhJGBpDh2klUOypYnfws+CeR4Iz6IQ
         9mLOUwsbvNSBgkyrtwqTymSwoE5y6NXKqecYhflnvWvY/bV+L9rvhcoJvnRJ/eLwS8v+
         Gg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780903183; x=1781507983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TszHFZ7K4js/ZAFR2FtK66NQPI9cujME4oGOjetByeg=;
        b=pElT3NhuN393LXO9zPCo+AAmYq0r+O/Y2VUzaYCeSmTs7TyLxfocR80Ndzjo8S4vtV
         q4wJkdqORAhzlRKHcsENqqUKQL+9T8mqgDj2ePc1qh3E6yFO0LA7PlPYPxkO28+tpNXP
         aGHT+7sDHEWblZApCeKdP0GnkNeZ2h6XV6M1XV3A5f8RdJzFLzqLcf7g/kafrifGdOxM
         5D0g3ADLOkwo0EwChWqIq6yUH7Rz1yMFZo1SNaIi0zzQyWXFH88bX20h8fLob9LTwCPW
         4ZC5aqdi7szfDtbBshm7s0sf4n757X4jI9e3M/s0abXXyWNKdY5Es+urkl6j82OmAXOz
         DH1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+TFLbGz02C2UFTjy+r5OJ7f+Pd5JqTqBKTwaYJEwjZxdkdBy2moGmhx1h/zAZjAId0mHK/PQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBkzPf5+j9e3Lm0b/yCcyNcCH3g9LmIjRd1g91wZb9sPJXv+Al
	dZGaRwdiNdYF8JrCjIyofV0QWlWQlpANuiX/mDjFsdW5unB86BG71FRoEcrc+g3L8NI3GKdwuGn
	11HkKjFlPMJ6KeqVzi3I7mUIVIhoEM/ZXNeHTfmmA56xMZQ3jlIN3x+xFvg==
X-Gm-Gg: Acq92OHMLBiHXyV1ZQ2irexYsUStthYr7hFFiV39NlWX9XILzpyxVCDH6uA7iDfzQd4
	PXSX2gi1oGY03crcmdkx6kUMXqGmt//tGetBUomoVKnuwzuuADnc0tCXXUottbav4RE2XWmiYPG
	VPIGGPFCrR11ezj4Wg2hiugpoqg5ASj9RtMmN/avXZLDdFMLuB+Lx2yaRd8TxKQ5QeWJ50CD8eV
	gbK6NZrYJT16/rl2Oj3c79DFE2LlOcfYIOM8vzyytootKEGR9NXL+0DNWMbi9YiUVaXdzVfISwM
	vqbG1o1ZFHCDxZMaJuGGORouOCzwnaC4hCpvDJUni8HRj8xfsWxv7YBWefMTSDLyrlGR5nMejmL
	9/headfYx10tZWz1llNzyPbWv0xOkRYuDEi/T6w2HAHZxheXoKwqzDcC4aTwjG1UE9+cqszDQcr
	fTQC9icueS6MhkX8LVowN86/RXYg5QNJo4f2A7lc2monvVlA==
X-Received: by 2002:a05:6102:6204:10b0:6cb:b3db:c31c with SMTP id ada2fe7eead31-7001b3c61d6mr2919804137.0.1780903182937;
        Mon, 08 Jun 2026 00:19:42 -0700 (PDT)
X-Received: by 2002:a05:6102:6204:10b0:6cb:b3db:c31c with SMTP id ada2fe7eead31-7001b3c61d6mr2919793137.0.1780903182529;
        Mon, 08 Jun 2026 00:19:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fbcc7sm3605566e87.23.2026.06.08.00.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:19:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:19:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: msm: qcm2290: Add Shikra
 MDSS
Message-ID: <dhtuvm4ejg456jy65kwbejdo2amrg2khaljlmurse4vkjok25p@rd6wd7tp4rwd>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
 <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2NiBTYWx0ZWRfX4dUpaByIcm5u
 Nop/6J+3X66jjnXFw6t5kqbjKVBWLbCaitO3qE0bHMbwlzicF6h2iqixBg2jPePvDkQgkp9NJhg
 hJTu4JQpFItmuzh5sxLdQB7/9A9rSMiAlzKpUz+ogplZr6BaOygWBJlsLdxmgVGyMN09ec4e+Ld
 9JMU1Jq3eHUCNfd7UsUMuUSoqFejKWFyamYGFpcXBAZhbkJWit2emIPnDJPd8xY5EvRbBtRSl8F
 /L8h/IFDBT/Twp4vIz56ezhYIWpD38F5aGXJ5fbdy2Vh+2CLZIVXGhsaIzfT8J7FLmQn+Z2gKoW
 ZSuzKZoZTkx8cDzQ/qgIH6lAJ8YAuwi/NJVZnvYHzFCCuEz1L6RQBW774EmLVWnsugzWcd8do3s
 7apwacm4yJRG1O4gJNX7EI2tOKYktG98++mPb68/hEkGaiAKqpOs4+4k9on9V9STSGE7XjtmY/7
 6qiPvMmcmOeLbxJnwxw==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a266d0f cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=h5pAuauRZTFNeIU57NgA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: hdL4urtHukQEVcC4sS0pEjs8Kqg6TfUh
X-Proofpoint-GUID: hdL4urtHukQEVcC4sS0pEjs8Kqg6TfUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080066

On Mon, Jun 08, 2026 at 12:31:42PM +0530, Nabige Aala wrote:
> Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
> the existing qcm2290 bindings to cover Shikra by adding fallback
> compatible chains for MDSS, DPU and DSI controller nodes rather
> than introducing a separate binding file.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml     |  4 ++++
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml        |  6 +++++-
>  .../bindings/display/msm/qcom,qcm2290-mdss.yaml       | 19 ++++++++++++-------
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
