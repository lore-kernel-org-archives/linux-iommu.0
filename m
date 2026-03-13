Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9F3BB9E2
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416507; cv=none; b=Y+lrRTHw5USwHdsRsQnCeLQuZrgczCk8gj8VzyGY3Ib9IlU0/5usIfIzUq7/blN1Fz1ak/nazD2H5L8XXpdmtAsbcbPeAlAWgYy+jVBPXV4RVy6rrqorCkwWv/A2tIzUQQm56yXEqAq6p+vLxICQpOFVuIfIKjHA1ZJWC+Qbdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416507; c=relaxed/simple;
	bh=MaiIry6g1HGAhKzGVifNyMsE7l9EPQrOe+s3ZJ/XqnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCVWpIzPnyYqiaDySWDZFdJOPckKz3MZjkIY30wEKF/dErOb8/VXHzp8ynO7BxNnq2TibcCgB7WQmdU+s1yzv3ALRW026aq0h760dVfxmFdelL4cSA1tPUEJM/8Nf8H/SSGbzCTGATwOoJfPvQicsu5Kw6K0lzhMG5zp2f53bEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wyq2R13q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ds/Pl86T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wyq2R13q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ds/Pl86T"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DA7s0o1749244
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3huDFL/uMHzUyF/m5Jbypl50
	A1EHb0E/+PjkLmvRWTo=; b=Wyq2R13q9o/OD7KN1zwANuwq3sI3bpjvBs5kTnpz
	szKqQYaGWr6fRxkPO4H5OsyUuJ5OzJPHpKH5jip8P5aInYOBF0iijWdALEO6Y/cR
	grEralZ51vN/COja16IW+SEBJqOSNoSYDUNsabRyYaURSVLLGaR0Bw49DgFw9DhM
	a+L/3D2QRCGdyGhiA969NEWYNzcNsHmyc0GFIUB8cH/LjKsF4okWqDYnGglz/fQl
	uX2ELVnCGDS217qoVTuI8gig7SNb7RxPV5Vw6/kWSNhhBvFWpXvINJRdKcZEvoiR
	EWg4d9l+mD/Kci4iEXUIgkPZ9jxo2GAjFjCY5tHPBp/llA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvgj6h3r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:41:44 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56b67e8c2f5so6929509e0c.0
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773416503; x=1774021303; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3huDFL/uMHzUyF/m5Jbypl50A1EHb0E/+PjkLmvRWTo=;
        b=ds/Pl86TzgFn40eA1yeiz9zzx4+xF4xmAqKeu7G6/mQsjYwQ2XJr+7TK+7nfsoR1fu
         PInYemyyIH7af9+SZu1yprWHk1MVF9jF3xrE7iEpl3r/pZvgUPOE7LiURL9qFTZpRllZ
         KGhGSXWayNkdtQP3b5hdEpQ3LBpiR19sk2Z27w24ufvWjtHxyxenNG6h+PImwJjCEOg/
         1rF+wT6yMIh/B6BlGLQr66/el4Bklm9pSNNTIruTs62OufULdxmAwXXo5tFOa055ga0U
         fa6EldF5EEZ5CqSCmINVH6kFGHAnYCbQ9Vv0dbNEVfE4VTx7BMm/FXaN0/Xzs0pi+l4L
         4g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416503; x=1774021303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3huDFL/uMHzUyF/m5Jbypl50A1EHb0E/+PjkLmvRWTo=;
        b=ASOqL4U3Yj1JkfxQ1LgtPo+fY1cM2B2aCOlyv2QPDBedGVCa56Mb6xtbet0gIz6VpI
         yM7j+1JHnpF31vJoGIqkWCMEq9z0BwPJHa5SlknNu2PdAuKD9y2dqE4bLbB87CRDTVAo
         FHMUdxTPRzr9/AsoFPRRJ/f0UlbQejx5PeV0OlUc9zVipF6UYxVNOATS1GCNFKbJFI8a
         xX2Hh0teOw2tN+F5QplfzSEkrnUmhK4kxMgG7/gzA50eALw/VkVni13gR8W+wKvDt8Ou
         Gtt5bnM8ii9j4mLetpXj503Mk6RGEXNItEzETHJBOUVeEzd8P5lv8NHCWEbfDgFmgH6D
         pWnw==
X-Forwarded-Encrypted: i=1; AJvYcCVagAiw7d3ff3n4IrAjpoVTt/I0mZW0PacIfrZEGPy+fP9A7eg6CZmNuxz1OXLNZePvbqBiBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwubZlWIOa2vke0DRoBln8VaLGBPenOj7JKZq1rsoFYanOV5z9x
	d+2Df1d1XD4OQJgu9sxgxCPunbvlp3zgb0llHA+gQ11X4w3fgbgX9M+zRl8dwVqahPGA54QeF21
	bXHlgzkOP5LWkQrcYeJuVsxQbeVoySh06FiejDOuyE6qLxcdMtxaDZtHkeA==
X-Gm-Gg: ATEYQzyWcZc8o7fHUJYQNTrTLOId1cxa7MuwbmFSbQ0/Cyff165iE3BuVaDcOIdOOv/
	rAlvkls4+a1r81/psXR5sgnYYN+16in1M10JCXP31LKTOmZd6uiD6J1fozLLRiB8IdSfv2DA9IV
	f1Ul560KS1lxTvT+pnTBjbJ4vGVSL8j77pXtvWcxC+Xslpx9sabJV7X9oN6vfdUhRUOAGSHr3FI
	8LoFwhJIAvGDkESiS7BX0PpNPywvPdnfTmJVMx0KF+3DKa0uJFzYObUj8o7Ul/rhzyvP+qmtkgT
	NXCUkuyLJCVWtK8Rss3D20jfpS4azETDANW8rRx1redkfkP8oSL0D9rsQTQlb4vRDYH2TxV3qk6
	ccWlSr3YIQJCrdU9I4M/tb8N94ORuKJlrd3IK4SKB1Pa9ijhBcGrZSVqtdCgYtc0dav3I6igdSe
	UmEMBrx1eDOmbOIQcQfjfiAeSqablzLeTDyZE=
X-Received: by 2002:a05:6102:508c:b0:600:a2:1397 with SMTP id ada2fe7eead31-6020e5345d4mr1755122137.25.1773416503380;
        Fri, 13 Mar 2026 08:41:43 -0700 (PDT)
X-Received: by 2002:a05:6102:508c:b0:600:a2:1397 with SMTP id ada2fe7eead31-6020e5345d4mr1755102137.25.1773416502957;
        Fri, 13 Mar 2026 08:41:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed6esm14182221fa.23.2026.03.13.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:41:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:41:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 5/7] media: iris: add helper to select context bank
 device
Message-ID: <5a33eitlctupl5b65zr33kukfgru22qldkmfiyzlq6buczttmk@5nayj7qea3fq>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-5-9c0d1a67af4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-kaanapali-iris-v3-5-9c0d1a67af4b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyNSBTYWx0ZWRfX6sO7pOCErQ2b
 uGLYXls/skxrMLmmUS8rqgh1jONVRQgjIYSnKLalwLTazsXEz0OjzEYfshPDibia5aVodZCH9BQ
 u4Whj6d0IIDelNRFl0cwVSn8m2j7mffkDYTqzWLgh6teboA6d7vsgkFygenwoQRdGeUg+5xnqxc
 gzED0PxluENq8LFZhW0tViWU+GgPQr++0sCKqv9J3JnxsxUUEpfEu5oAce4zw+GFGAxt2VRJLsl
 aLceV2XpD+mRN5QC18EwRU5SPfxmrSJmNfeT2GRyx5WuH5nuzGUndNGR/9FbTj18IccbtP/y1rO
 DMmlPLgChwXp5CD+2YbmwN2ufebSfI630/rSSMovlBFnHUMZfHh5Od3mKr3fhupFb91pXvxgwb1
 o9AsFkd8vfAxncqlEjQOC98K2tVjbK8z6F9DRSZFbo7w8XntJnhMKsJReqymy/n/ZdSltIT6my8
 gmWgE9Wpvzi9C+wcPFw==
X-Proofpoint-GUID: fpWHgzWB5L-Ag5x9uehcd3cDtU4ZM4Y0
X-Proofpoint-ORIG-GUID: fpWHgzWB5L-Ag5x9uehcd3cDtU4ZM4Y0
X-Authority-Analysis: v=2.4 cv=H+vWAuYi c=1 sm=1 tr=0 ts=69b43038 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=m0VDa53i6esOPautn7AA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130125

On Fri, Mar 13, 2026 at 06:49:39PM +0530, Vikash Garodia wrote:
> Depending on the buffer type (input, output, internal and interface
> queues), associated context bank is selected, if available. Fallback to
> parent device for backward compatibility.
> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_buffer.c    |  7 ++--
>  drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++++----
>  drivers/media/platform/qcom/iris/iris_resources.c | 41 +++++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_resources.h |  2 ++
>  drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +--
>  5 files changed, 58 insertions(+), 12 deletions(-)
> 
> @@ -187,3 +188,43 @@ int iris_create_child_device_and_map(struct iris_core *core, const struct iris_c
>  
>  	return 0;
>  }
> +
> +enum iris_buffer_region iris_get_region(struct iris_inst *inst, enum iris_buffer_type buffer_type)
> +{
> +	switch (buffer_type) {
> +	case BUF_INPUT:
> +		if (inst->domain == ENCODER)
> +			return IRIS_PIXEL_REGION;
> +		else
> +			return IRIS_BITSTREAM_REGION;
> +	case BUF_OUTPUT:
> +		if (inst->domain == ENCODER)
> +			return IRIS_BITSTREAM_REGION;
> +		else
> +			return IRIS_PIXEL_REGION;
> +	case BUF_BIN:
> +		return IRIS_BITSTREAM_REGION;
> +	case BUF_DPB:
> +	case BUF_PARTIAL:
> +	case BUF_SCRATCH_2:
> +	case BUF_VPSS:
> +		return IRIS_PIXEL_REGION;
> +	case BUF_ARP:
> +	case BUF_COMV:
> +	case BUF_LINE:
> +	case BUF_NON_COMV:
> +	case BUF_PERSIST:
> +		return IRIS_NON_PIXEL_REGION;
> +	default:
> +		dev_err(inst->core->dev, "unknown buffer type: %d\n", buffer_type);
> +		return IRIS_UNKNOWN_REGION;
> +	}
> +}
> +
> +struct device *iris_get_cb_dev(struct iris_core *core, enum iris_buffer_region region)

Are you going to call these two functions separately? If not, it's
easier to squash them.

> +{
> +	if (core->cb_devs[region])
> +		return core->cb_devs[region];
> +
> +	return core->dev;
> +}

-- 
With best wishes
Dmitry
