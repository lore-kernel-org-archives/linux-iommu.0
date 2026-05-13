Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AB406271
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691144; cv=none; b=ijayn4H1HPsby1ih/+ij6grBe7WiNreNqPURjVHSU/6yb4VpFN1nEggVGCfi4xjLzLmihyxRzi1+0efVdbrxZhcRlOQ4f8xiRx6hpVePWzxKUwfFrL8rYoqCOYY15i0SI2XFkrsnMVBnK7HiJhr39uiEulCtNQGgXGtZZIDwOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691144; c=relaxed/simple;
	bh=qOKgjEVuqIbEtUVcQNUPmBWk/ToVLd8iHPeTuwLwbE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1kZDqQEwmLF9FrqLmDIiqeL+ctlH64tFLKv5BaGfgsJZX/xlmVjq7e4VG6I46HY0DjcyYjFIyLViT8Ic5cXfdf5z2gXFu0P4Oq0MJE/gg9ay3yEwebQhNTVVWEQKH4jfLHhk4IOdM3JGqL2bBSFimT6HhBGLxq7fV6YDgNXk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ub9SG6+J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CxvwwZZG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ub9SG6+J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxvwwZZG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAPBNd2321422
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PQDKVHkpUsfpWP0216KpWZo/
	ckkZQvWAnsqZGCHLh74=; b=Ub9SG6+JgDbR98bvDLUhCV9iBCiaZ2TMHpDiSraS
	Kxee6/wCy2LOyFoS5fSuP/f6AN4+VlmVakSq+jruUriTHDoh8SSpyCvy+CwFiXpx
	kPO1H5Nl1vrZ22MN5zAsz3+ke1ipSWJSxSxmEzxK3didYf/fpqFQmF5Af5Vl/z2k
	i23RfLj2pmfIJnh9C8TS70J/VzJsi6ncVhIKLPjfyjVDmhe3okXnA5EEv3DXAHfZ
	i1J3q8RIFywnRTVNiLLvs108RhgG8wuOJ2IzBrhA26nc29JtS4G6OfteEprEiUz8
	hYGXeEKA7Rgqm7bkFCuiuZi8I8dieqvYDx/HrzTFRimuOg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgub1xu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:52:22 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6343b1bcbe8so2678906137.3
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778691142; x=1779295942; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQDKVHkpUsfpWP0216KpWZo/ckkZQvWAnsqZGCHLh74=;
        b=CxvwwZZGxjlcFSkgqzGiJdlcj6r3Sv1NjKTiswtqKg6n8yNB9tvjC5IVHJYKph4vZn
         eohLxr4KbUFBujsQvVk9SGbvxK2Ke+ZKpNC5C6gXbOa+MTAHTudw+Dyy9fNbleDn5Kh3
         Dt6poKbKazGEsaw9KZiRg+vkTA3ashkY+2fZzcOKOwvvokO6+X1fj+7iUKvBoFoFN2Ck
         hEX+ezfSeB9B2VYUpAxvFd2ZX2rQcZ6PLV6kzXU3kuc18D++nmXo72sihH4yuaH4CnbB
         N+l2sIX0YyS5YlAQdcx0Qts7abPe88AMh8qVg0JxDOZ226evetApHfrBkCZ1iHPcbIT9
         KMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691142; x=1779295942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQDKVHkpUsfpWP0216KpWZo/ckkZQvWAnsqZGCHLh74=;
        b=rVlN3YNyTdHmWoBLIEkuHYQE0KayOAPLRzRd3t/6pH8F0CWafGpiarKmFgtIJ1THo/
         gOtOiDOZDSiV1DX3Xs1cWY1JrYxmDiXZzPzg0/x6PzJzTJLS3touXjXqvxl4q808PqOE
         6B6qArKOnP7UzJVy7tjtt33HKB6vV7hTMi9hrx7jurGUQsM3qWMpqL1KCZqWfan3b58L
         CZJNyVsSxVtUayUYXQlbvDoRThiyaOyywXMNcv2GigmHcz2feu6MaK4491l44Ghyhqoc
         KapkSU6WtV5VG981IBS3ea1zZlGdoWvryLHZWcYIqfYGrCkBB1SapC90fNZuxbQmZRws
         qguw==
X-Forwarded-Encrypted: i=1; AFNElJ88j/dKQCISFDpHWMYPBwCNw53xV9Ui/qReDr/uU0ZTL03cDQomwmKD5fIFNwt/UbuGYeFdlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO2fy4OQiT3uciUSavBY7eTSRcs4/SCKHqE2w97Q37SvansnT0
	6nAQzeKoVE3Xx6qlGUlZnvAa1Vnie1X6c1SkErYWB8rA7pCDY0yFzoWcIL9oCaHydCcYVrTwwup
	8Ui7fuh98OB4bXzVjwf6igSPgZ3LfXc2MVPw23QLjHkGRVGmTDmBRX9HoKA==
X-Gm-Gg: Acq92OGUsd2ePUQgCBtni6iem/uupSnfw8LibV/RruWUgXYFc+ZHhckjHWqL2WxQUc1
	SiKZ7ZLImGmNgI5HjpvJNYcAu4uF7g7eofTOyIaqpi8djF/NRAr981MZMkw5e+SU4YxN3Yiifbh
	1i6sFN4FD+H+zEmkAEHZ6cK37QWW7mim3UG/p+ayj/CU2L/tI0+NiVC1dV560qq+4rOiAa3hPCm
	JPrftsSxZL7TnUpH/4yNwdIf/ImEXKaDH8xvLS0JyOrRgBdPgKkxFLK8a39u+yg2Z/NCiWlDfP7
	CbH5FiNHeyOQ5RTam8b2HYj7c0gvlqFUx0EekJk9o5PGbrLsGYzKxsZauGiclcNW7XqcV3nwQUQ
	OdJbtCuLK1f7g9aLwGk96C0dhoHwhM/DNKvAg587tbrqndXDxxRDffmL24sgFTtkExDeuQCAmJy
	Yk1dbxCJAFIRaidGIT/g/Q6qkzgA81N8R0i+M=
X-Received: by 2002:a05:6102:a51:b0:632:29a5:2b27 with SMTP id ada2fe7eead31-6377239d243mr2364707137.3.1778691141163;
        Wed, 13 May 2026 09:52:21 -0700 (PDT)
X-Received: by 2002:a05:6102:a51:b0:632:29a5:2b27 with SMTP id ada2fe7eead31-6377239d243mr2364665137.3.1778691140453;
        Wed, 13 May 2026 09:52:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a956b3d0sm4096876e87.80.2026.05.13.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:52:19 -0700 (PDT)
Date: Wed, 13 May 2026 19:52:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH 4/8] arm64: dts: qcom: kaanapali: Add qfprom node
Message-ID: <smuahoo5kk23pmy6hl3ydnha4aak3xyalrkg4vydixoq4zrro4@rpb2c2oy7lko>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04ac46 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: jbNCQQ84-z53Yn79tVrQbqxxn5l-H-0l
X-Proofpoint-ORIG-GUID: jbNCQQ84-z53Yn79tVrQbqxxn5l-H-0l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3MCBTYWx0ZWRfXy1qWMF08W6Eh
 NRFXB7joOQq5k/wlBh9XE3Abv60BO5kYFZ3V21cPH6bA6ym6nFcoqIyVtzFiXBnyi02UTvZzZhT
 Upre4IdDas+rBtnQ9L1JuhIlzcLUs3IQakM7pMa/qqvnPwp8I1y5LlqlUTCmGdUEvC7I8RxAquc
 o8IcSEtySxeTA9aYPfDlZelqMfpHet6/mfaMNrhNOSj6F8P3gwtrvZJJ6hPsanxlpualnfPimM5
 3Rq3rz3yS+sWj+B4fcDf2X5fq5g+3ahyprN7BefgpBkJpRo5+qD2ev3vKi5jAhZJlek+BK5rlph
 uIY6VqpJQptl6WeaGoaygzDWN0AnumER2iVMe6E51WWcBf1wEMEpO5889ZY3NuSd09hPR6YAVWc
 n+AVLN3rsRgMOyKeaUO5kpWVka9J96IVjmUzXpg7zQWsCXyCOfQePfAihOyeawrPlP0ia7/nKhy
 rr6nG5tM2/F5dYGvjng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130170

On Tue, May 12, 2026 at 03:53:18AM +0530, Akhil P Oommen wrote:
> From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Add the qfprom node and gpu related subnodes on Kaanapali SoC.

QFPROM, GPU

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

-- 
With best wishes
Dmitry
