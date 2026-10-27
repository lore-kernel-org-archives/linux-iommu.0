Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101029;
	b=11V5w8qrMeUo453/gzQjgM6anJ6MbUt93zWeO0gwTpMsbSfoHeu/8hNbMilxRHAGqX0I
	 bl8Kga+vQMwE1VshU5FBVZ7JgYvmOcIWGprFnCRiRvUSraKMur6QnPP13JNGL75YPLBRm
	 Pn2LDZHPkipcCfAymE+b3TvctoI3q5rbmuDen4o7bvxI0vglSyz0vTFOoxi1eY1wmLMXI
	 8h89DTI1euxZoKDH7DtqsZbDkkge3WrZJ5a3w6R7N4wUMLzHhUGxhMAXgKGvvalSMSMtz
	 Y6i60SoQmCu2uIFePucWD1hITBa34tjvFKXpCMCsBB8b3AizRRbPNoIxifYabMTlt8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101029;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=d9Gksr16Ym7a6rQh3BsSgLKtbW1PN6uAQD1PHStu3Cg=;
	b=Mc7YCirMwMWoas0bP54E7QWWb2KelfHClnYiIxonNB6SO3uP+ut0uxEunAmzfnvfi6oj
	 Fofi23YeUdcZaz4muYXUbQl0urj6AyqXVL6//27lH2APcKdowSYIz4+1QYuvD5qHtZ8PD
	 iZ0zHoUbvcb9Q5/fWpgPP/jT959CoJ5kXnifx289pF9BHa70Nn+qp0OTRnV2AGinpOG+b
	 dtqgLyvWUIDMcCm9XW0gZKzNq+hvuY1po9uxWlLEheGA7dLiqqOHICWLRn8KCv0GHNwac
	 oR0S8ut9UaESLbUN/oylCTU86jGrHADqDRm0STK2qJenCCslc2XOu/7kNIacLSy/HLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="BYkqWIL/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwYAIa58;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E82606A320
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E82606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BYkqWIL/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwYAIa58
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe7Wm1974773
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d9Gksr16Ym7a6rQh3BsSgLKt
	bW1PN6uAQD1PHStu3Cg=; b=BYkqWIL/vT76gUwo2BPV8+qHrr6gTQHtEF/qsZzV
	t9k7/HNQeqhwS+OHKqnDsMIWulbLG2pqkKIwvCy+qUpRSxC99/XxZBrYFP4cxZ7l
	/Q5YOmpG3L271QH2G5vKyPoPM1U+Mq8rSMuRfxu5hdQR1Oyw80YcKP/fbSWdHayk
	T1s4ECD6OiTjnRcPlz4xyWeEWk5/6k+IM1aG5CEfYWk//wv8JxvDfs9IpI340eXV
	4UYya+dCPcGYNtZp5Y0LWnfYkoc75+7VeOWSCho+8Jf88hndccM3tEwzSWSew6Ic
	bV2hVKl418/lToGDeg8NuPuK+BK//WEAdS2VFXbsnHzZsw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1gbfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:37:08 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf08dc2fc8so981472137.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793101027; x=1793705827; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d9Gksr16Ym7a6rQh3BsSgLKtbW1PN6uAQD1PHStu3Cg=;
        b=YwYAIa58bf9rj8YOE5fSBzcJ9G8STim2199vHLTWNRkM+jp9LyX5P9BLnOs1gbt9sc
         ZC8ZaZ0DIi9aCPjrC2I/7O+APnfrmx+G4oHC7R3qo/8nTCtidaynhX9wHazzOl5emwsz
         i31LyBx9tWyA9+2PQ1cDBh2Jr2JBmhqpQoTDH7uu7W/3EUWu2cSJ7Swym6lqLH4GCDwq
         ZFsK3iZFUrmD+ZVfDubjwgxg1dD9/PIlJVtSp4+LnWBrtzS+F9C1VFMlRvM6gCBBMrLU
         MoRqtZCysThq2jQghpvvK8iqGXjRG4P25j7OQwYcq/kQLiX4KxGssBBpn3nOv4XprCzO
         ZWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101027; x=1793705827;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9Gksr16Ym7a6rQh3BsSgLKtbW1PN6uAQD1PHStu3Cg=;
        b=iCNwUagH6G0PrUZtheXQ+6TPI04+OvKKmVmS0FwTpUkwWZxrBQ4ce0xfBU4y30kG1V
         WQpNOTNVYZUxYYJPw+1KuGvxQK8TFbbNIgt52sS2QDDkXQmWBjwUYnnr74T2ApcxEYsP
         HnresS0KjbXtEQdQtmdHNQqII1KYGB5BalLV7Fyb2Q12R9gzG4u2cbxgu3pSAUNLD3aJ
         P5T/+VKJD2fWPfUHMS7TpVB6iXIzXDyXyRC/3t5aATdkn6gzwNAgNMK7xrHrrpnFoKH2
         ITsHUXM6SFQNBTQYaXJWqaloHVJksOZHj7r5oNyKVKADnlJNhPz0vIhmJ9M2ia15uWqp
         QBYA==
X-Forwarded-Encrypted: i=1; AKwUvBwjRg0akPxmpd2u44cEOnsfaZZRE7nLr5DXDqbeTZKgUHJpaF6KXBdVTDzhMuqdv0Tv12c+vQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJWghj/0Hi925y1EzoiLjYOx+jMg+V5NI39hyQvt2d2BoxXKI78
	mU5F3nAFGYFSnPwpmhYaSBe0/I1dR8JGMIhsYIYkL0lmz0SGWdojeWm0svmtblZWVkEo8SaMCLU
	etWElJFERNtPHZZkokAx8+wqzXMomYn0YCkYb9ikYTO5/e0CslmG/s/dg+w==
X-Gm-Gg: AYBFou2E3xYH7hjtz0x6nyj1BcC8Y1bSaZy65s6LGyKS0OBZZjpVEUPKU1ViUouYbla
	gOLsdEvaE9+3vtRiH1wyfxTbtpBdpud1DM+uDZE4j04yIm2WMo7shHnWQAHHHiIZz6Ak4A/rckg
	YhYYS4EU3td7wMUxCHA2UhtbT6zh3z2I4b1haKKgQoSt20sesPeWYb5Wfhm+usFwMWRvweF7Zif
	ezTPOKr5yL0u4Y5iSDg4pki13UcqAHAAY0ZDGzYU9PBCpgFOcbAYVdxdQbgULW00fi4Lefc37aJ
	AGityZ48v4XhR97Vun0Di3PJuegpp8S+d0N0P1BxvDygei2FPCWpnuNbfWieFMY0FO0CA/BSImk
	e7uDQV7lCYlXUiIT5rc5OT3hg0shURSMBRCqxb1Mw90Ip+p2OvCftfR6fuHhfH/hroYMx+zOpeg
	m52WjA7OBTmju0
X-Received: by 2002:a05:6102:644a:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7ce5ccaae68mr2852922137.7.1793101026946;
        Tue, 27 Oct 2026 04:37:06 -0700 (PDT)
X-Received: by 2002:a05:6102:644a:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7ce5ccaae68mr2852880137.7.1793101026222;
        Tue, 27 Oct 2026 04:37:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a8930dsm2093206e87.46.2026.10.27.04.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:37:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:37:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
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
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 21/23] drm/msm: Support KMS backends without a display
 IRQ
Message-ID: <jmsh74ugfivd6ffwiqvofwnkkxnu5z67hqdei7jarhrftvkgac@hq2e5s2aj7fr>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae08ce4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=auR94sGctrba0TjZuGkA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: OLFacC56w2R8aCkIs6134EyGxTzzabC_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX+Hfr1ZlTwn5R
 0yl7UoIGDUB29/Q42C9t2/8i2maezxZRdSljCdHWAzLwzNAm4aUu68bR2kCzpsJJISkIuZeA6Z6
 W4OmbGJoF8L7kd13ij7ihElFtogcGkc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX06G8W7XEbRpq
 zHOp3fWotA+Ml92u8/kDSATudL+COGHb6EdbQk/6z3l0NRyph4IqZ2FiUBfo8Km/Y2ZXsMknp0P
 W5yN7k+acnkGjhUfmPyE3h07TZFqhRPYY9KT6nvvP1CGXXfrS6tBM52E4gnCEanjpX4a8u6adMx
 kcFIkJ31Y9t0K6KsL4+E1pUFMZuA48Jy8zDg000vNwWAaapQvFahkt48VEqNpjFJTiREk35likz
 RInTM5CQjmNdV4Y0nMk1hLyIWKIuG/X6P+VHAbhvwO4SJRwW9lzFr7pjOPsXSMAh4hlQNL8gOTc
 W1OXRoYLgC9fX8uSygg7IDULnHz0e3MPjUo3Cv+kQIDPcaBShSEbMnxU59Zv/miyg1sTZshDikS
 kLaETefF9Ik3yJV51Uy09GDIaf+q3ZdG59rVPNkw6X7QTtcetdxsqHZO1cGT6esEPIH0K1emQc1
 E3fi7gUHlfMf3HIXBSQ==
X-Proofpoint-GUID: OLFacC56w2R8aCkIs6134EyGxTzzabC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270046

On Mon, Oct 26, 2026 at 11:51:31AM +0530, Jayant Shekhar wrote:
> Some MSM KMS backends receive display events through firmware or

Which ones?

> another transport and therefore have no host-visible display interrupt.
> Rejecting such a backend during common KMS initialization prevents
> it from using the MSM DRM framework.
> 
> Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
> frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
> interrupt is reserved for power-notify acknowledgments. Existing
> IRQ-backed KMS implementations retain their current request and
> teardown flow.

With the commit message fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
