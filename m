Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA14968F3
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528194; cv=none; b=h095GHcNTVi0AxoAkJoi8Yfn4b/aXomW8Suo80eD+L0CG/lWD3wRoxZ1Oy3Sl2MVmmmHpjJCOwgBkQMdzOQEPVP9sUzXRDje6sM2vUIJEzgOrGl+uywTd9+JyO72enNPN3VmSGFKIV+ClyOlL8xgpeRy1jSruJhw56OBVdl4HtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528194; c=relaxed/simple;
	bh=M6PaO15AL1les95fs2M50qBWvkR1+aozFPKRVFNrcew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as3GcgErbTnOGvj9QIe/69USWW2EV/pm7zgVVvnHHdd50gE/GQ0yx3xJsmx0V1Wo4BdM9X3/Bv3XFTHidgrPmJxu9h9avkVkunvLVVd/3DlceoYSG75ogOAkRScBKRGbdsRirN9R9jqJPnTJU1rBqQGPegNoD0cDapF4F1W4Uus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ItHNQFCV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BxewnFLP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItHNQFCV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BxewnFLP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653JZ9Tk1039504
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 23:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VM7re91kygzVwItS+ciTwBT7
	UhZcfvCtwxBR7/9Rl6k=; b=ItHNQFCVXlcr3sWHBPrR/Jiyl4WNsdz75NYJwNVA
	u9QYRBhxqmnTBQ6F+9QHJfy37sA8aw1eh+flWW0DcMAOSAncb0ALAbwf2oEwVI1P
	QA6KKlRW2F7birwA6SoFimt7A3uGH4cy3TNDkc2u6n8pcpl0nE5G4aFicrt82W53
	xwnuayjo+lnqnsFItT+VXwZplDO+BbvxbXdnVLYbEXLtVZxdSA4mVkzaCLFzh2Wr
	0yed7dV3ssEW8dSjmHN5h8X+Y6Hvh5/HOMMoOOt0nM+u1LXpkSwQUJOO8aqtxcTa
	3G44XaKRDxj2JxBKRuPcYPc4UVmMz6FyfZltEbPOipE0fw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejtj8gpd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 23:09:52 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5a10923f7d7so1952324e0c.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780528192; x=1781132992; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VM7re91kygzVwItS+ciTwBT7UhZcfvCtwxBR7/9Rl6k=;
        b=BxewnFLPK69ddmcXYtzcID1M6zi3Gx8xlFHr303MSsBddi4FNL58gT1EcOi/78tz+F
         ZsE4i/ZsRfB/Aq0dckyelHe4qDdu8vDIyq1X8rEjd2pQNe1H1ylc8cDkn+2jM7Ibu6XA
         uds5cbTeOY70sSY5uEcgfKbnQAR6o1+uQd65Ph85cj5AOusX0rd/v5iZuiUXcXz39fJ9
         fZshZ7fDJ+PPmeFrK2Xk5SGF4Hz1/TexqI0bpa/AqA+ynQ3zxItiH5Rn4SYBRq/UPOD5
         K8AjKQswSOG9ppsuFyOWfv3NnxYuF3xT8+IsS+8qfdwnmjquL1t5a5uZKgLP5P5ybOVq
         jWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528192; x=1781132992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM7re91kygzVwItS+ciTwBT7UhZcfvCtwxBR7/9Rl6k=;
        b=Zt+LF9UPNgpPJaRtiP4Wb2G0yMTaJ2WjX1oMpPa6l6O/mYarMoM5pMw4+CIQwQG3LN
         2r+kb5LcG6y0MumZvrtuA9e5tiRI0f/sIf3MEnwD86otPTlfktvruECf4pnKqT8sFz5z
         Ep7UH+k/iNgahYX3u1Mm4W5Pwy1pB/iMFc2YorvZ+bRIA4C/B2x3wtX+Zu1p0EKJrW+8
         ZwQY3wxox5IRZB99X4UOQU22ejdjUCs6xnt7KTHHPlWYsMdeOPe9SzlWKMI12vmBcMJb
         DTfXhSmT63VV3mDMhU79N8T+nvUow4kT2tHnycuZjGWyGHD9crX3v3SPg9fO57N+jTqu
         R4Mw==
X-Forwarded-Encrypted: i=1; AFNElJ+2t2OMdbX1gvGlxOTgvMa2T5Kt47beBCyFiIUjVA1BpQLnEMArldQL1yGOQw0RKxIlWE6Riw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE07U4jtSRJj08MI21DfNkjU5yH9Rk+0BaXpyO0/UW+hLXt+MR
	YdTvQ/dGQXcD9Nvn0V9K2T6rgg/k5g/0x2Eu1mPR6uce7sOB7v/naq6WbE14EOWhB9WFZI/y5/j
	Zy7zJRUsmS+RW04+vvBPSKSYFgY9XCWYRciw1v7CcQkMaw/8F2OsIdV2E2Q==
X-Gm-Gg: Acq92OG4n5stXb0q8AtX1JOYSIA9B7e4BhHSJHjlA/M32zzAq/AvXGCnm2ySSle/lZF
	sxmHfsHKQJZxvXObdhHq06z/3IIwkqx89TXmmo7EhY8Qog7Ed1RXV3khyhYKD3Oat9D+3I6ZP1A
	uL5MCv3YL6FVqJhFmUmdvPIpApA1qKrvB6ChQzeuCD27wmKSBcW2uFN8FovBvxQRAyDVU4dP/Eh
	Tqi1E3WTm4C/Py/liJ0egZOEodDdLKezhgUB5QcbtLpLAAGKXPiLiLYudZ6KDgfOcnY+MVXZaKI
	MMDDnImhgez4BtomaJhWc38FpYAB254z4HpT6zeCiiZ3aLJC1kHd1z6Jzic2bf/0PhKz4SHl3DF
	nmjVSA+047/kTTk1rYz7glrz89QOoZ/wsscZoaYXS+8Pm7bSdR5Z/30lAaRxrcd5zflJ6c20MCJ
	xtCvkcMWyfbJCURsV54dP+9td8WwgP8bzBPyyZMbFXXMUn6g==
X-Received: by 2002:a05:6102:7:b0:6d2:1633:1803 with SMTP id ada2fe7eead31-6f5512f0f18mr606512137.19.1780528192021;
        Wed, 03 Jun 2026 16:09:52 -0700 (PDT)
X-Received: by 2002:a05:6102:7:b0:6d2:1633:1803 with SMTP id ada2fe7eead31-6f5512f0f18mr606503137.19.1780528191675;
        Wed, 03 Jun 2026 16:09:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9082b7sm883863e87.36.2026.06.03.16.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:09:50 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:09:48 +0300
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
Subject: Re: [PATCH 3/5] arm64: defconfig: Enable ILI7807S DSI panel driver
Message-ID: <bhq7pallav6wfni7l3xtalv3ophpoa7offdzdhfoqk3a6lj46e@ke34hu2ukig7>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-3-aeac1b94faa7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-shikra-display-v1-3-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: GegNAIrfoe53FM8meGPYUwAtMVtYeYTq
X-Proofpoint-GUID: GegNAIrfoe53FM8meGPYUwAtMVtYeYTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX1cQJHM+rERGb
 ppnV2cya1ZxEVVZzeLVifU3J+oiiIhjoikyCoQYZGUVjR7mxatwuBwWTfciXytDZvFsOHyvTcJa
 Ouzub8AkExYPk19t1bazgX3/NlESQLbNYbBu7AMZz3fJLdgLLtppcctuqgYfpe4ercdDkEcrxK8
 K5E7ocukSg6Ue/G9Gy3L5TzcuN8BF9vuiKRpYanobOwyDEpf1hT+XU6NxjVTaibaUVB2QruHGZb
 TtciK2KpT7OBc9hkObP+WZbeY0yMgpP2Sr0Szc6ubA7UqK7knlBMdxK1eLJOBRFUgF9fvUqw2fw
 Nlsld69/R2F4iIH8UUYl3pHkA7nk2storYY/PNysLwsQdZKtm/DuEvA2z05lcBRv9nPL+XHERoY
 kIAQaY32WNwDbnrRyHJG7w4PQgAKneA0rx8lzx7evE+P0Uq5nKhrjGjPSYrmz8VEmA8YSG1Snlf
 4fqPmCEwK/vcIxyfncQ==
X-Authority-Analysis: v=2.4 cv=f4p4wuyM c=1 sm=1 tr=0 ts=6a20b440 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=oNl6jLlcSFQHEdJXP8oA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030226

On Wed, Jun 03, 2026 at 08:29:28PM +0530, Nabige Aala wrote:
> Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
> used on the Shikra CQM EVK board.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
