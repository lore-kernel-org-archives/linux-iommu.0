Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23228469D
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215950; cv=none; b=IArXsSABlaaCKLlyQ18xPPti2l8xe7cTE2kMKYVbKK1aQJt6VYhtcEnOnTXhD30ELtQ1ko9P3Yei/S6adT9yDrH2OuQfos3UJOYrk3t32B2KOojCLEnuCEi1SLAaLeCHbpa7GfXSlCEwizPvO/W44bYi/z0zVniJts13t00Tps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215950; c=relaxed/simple;
	bh=/mCXINsouksdvH8ujJuWt7bdhP4SnZEy7otbguluseM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuaYCFLz8WaR/gEKqeGOXsylQOyTKpgeA1Kumf+bPNP8n5sfk3RN7dX6lG/qlgrdetFIvLN4whpVUQUWM4PhunMuGSmPyvR+RSwvgl1Kg4k3HyKBfza6Wi9fOwre/BEWNy9EeHIb0r1XlXeeT/KhtEfwh/v5KNHVB1v/Fyi9tOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iTnzXzJC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTnzXzJC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HVdw030619
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YkcyM04R0DD+Qr3GHQ8OUnac
	Su7NvjdL0Knj9f30K/M=; b=iTnzXzJCCeI4G/IXM3iCA+u1U+kUCgpTbDDW0j9i
	SJOj5h9+3BBYuyoaVL1NretVK72heIAARIz51/FwbeZ/ZuAPpsj7EtkDeSN2FN8K
	ovbqZYPQ1C2V16I6gZ8kPRaiCcSe7qdWBCr2bXXVcT+iMfYP5zbLA2kgKoqzfJdg
	Qg0jmvNIqTjE/pAjEB6xZBHOndn8L0Zv3F9m7dx79YQ6K2mDJGNZTZa+AXRhD9zw
	r0EHNJ8bJvzKGyIi40foXUD4B1EdWSQHU+xSs0DSFqziVw6HE15k+h4DPaoe8x4u
	lVP2BKMTF34+zeRtgF3xcOCeEdvj+uEGgeyUv5DljuYhTg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdfs3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:05:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dfe8dafd18so92594261cf.0
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215947; x=1759820747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkcyM04R0DD+Qr3GHQ8OUnacSu7NvjdL0Knj9f30K/M=;
        b=I5b3ZnMcVpzhSsw6vghzcY22jUi5KVx/3XRhlPuQmwHurulNrT13UfMn62FAbWFYx5
         eZp5NCfHqZ94pInvCWqB9aAnbdJP7nwljsSG1/sDBc4X/RVPVSoZWC4aGRGD30/L1hnk
         B3cRLQqTcWoUvoDpTHq6k7H8ZspeWgTPrngQLYXxE8OLjRS+2sl3Yjn90UeO04j3HoeP
         3HlCOPRpAXowmU6FMlsvwwq8xQnYyZj1kHn/rgIG2c7wsI8dWKJhxqDUgTkFLt6YjeSy
         CWJqVzfUPjN+7UC7mXqrbrqXYjK4+gdLNwOMdsi0K6RaESoOCfiFcPQRFwtbaDYAMu52
         HlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlbSZZZ/iTLeRRZxwm39u1CvChDsYPiZHpcfVkcH6L7TKK+eiremglLRjlHEvkW1HwLLz3ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwVWhWjnHkHxjKDNfK01T41MKSzrjJ1ArL0Uj6wifi3mv3ZYGa
	AMPcc9c0SyAZUUKi91tRWLYjd5ECBDq0FMHlSq+cypijKwEtuBVljj9o1c+BaUHQUcgedQ7v1Fu
	pB9mXQcVtPdRpYS0TY/lu/ckUZ4FlDunAK4ABYdWwCzZtzIOifejNcQNdLA==
X-Gm-Gg: ASbGncsDCEWan0blS/tXRvAM0xLkjmXnnFmg5Xc+1u9b8XXV7GOXCanQyCLjieMSvWL
	0uSIrPiA6xj3LTxG8UK/oGVr8UxMpVR+GPspAfL6ftmLojGEzIegMY24NZnMojXKUE6aTMwN7c7
	xLcakcYvxUvuK2OqqEPlFVpzw3pYTC0izqKsRWaUzm12gGKiHzQ4mI1yaVFYctGOlN+kwSBMVZN
	oobktdcPEbFgatLF3q6gPbmfzPB1Vaw1/emERerMk06IMWA1wjkGskB78B+N+t0GV9hqt8+62RJ
	Xomx3DabfC7HibrQoMD5GesTmEJM8eOMNb8fEteS4Cg8FVsz3rBVpPQDmrHZLV6x051Jhfx9IE9
	STgG64LKCDp/r9lhgUyZwqbpfvG05q9qSlaG52RIi7q4YUD3VyHsWcL6z9w==
X-Received: by 2002:ac8:7602:0:b0:4dc:d94f:d13f with SMTP id d75a77b69052e-4dcd94fd62cmr145860231cf.72.1759215947137;
        Tue, 30 Sep 2025 00:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6np5FgFR3yiAoIV4w+0+a5+/kCzcX9eD5vqs8OqsXllqsDXGgjrxwAtZPkSL/3P7NcRUnlQ==
X-Received: by 2002:ac8:7602:0:b0:4dc:d94f:d13f with SMTP id d75a77b69052e-4dcd94fd62cmr145860071cf.72.1759215946624;
        Tue, 30 Sep 2025 00:05:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-587748b15d2sm1648013e87.7.2025.09.30.00.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:05:45 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:05:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/17] drm/msm/adreno: Common-ize PIPE definitions
Message-ID: <xsgnpvswvkyuxiviv4uyb6pxbpi646fut6dy54kpyfisqrxycz@tyfox3zdi26e>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-3-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-3-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-GUID: s7azP_xMFvrgHaYxQYGRrhvpXO20r_Nt
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68db814c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ffTnwjXrKXMzwz1Z5d8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: s7azP_xMFvrgHaYxQYGRrhvpXO20r_Nt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX0JceJPzDSytO
 T5dco00VO0nypWj4v8bmh0YZ9/MoMKQviNteButvk2igvBWiU4Vi1fgVYb21jD4zurQoyoQmIwN
 vgRIqhvZr47G2O0Nv5YYXvYYxeCct4fo6hpgUlmxiNcO1xcDLT2CbPhGFwmO0bySKfVZTAMpnQO
 UOdLXNtwXwMxdwS0ri37+M1Nrb4mKh9PJB2FKruHhXqS+LTJEEs5Hvu3AIUl3BeNH7TpHqCjW+A
 OQPddn1DPVOwtVH+38mTGIROiWrQtXorc465g9M+oUx4at6Z/+ypSVOuN25uLJP0nTxkxBLK5Cx
 LegoJ7DBDqplNtKSmQ/Ie1spiCTgwjxtA9hLCDNBMg0XLoHmdpxL7sRYlvmXm8usCCWBfJA/cxR
 ObxG7QHbuRmdWTmopTp5m6Zum5LZ2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On Tue, Sep 30, 2025 at 11:18:08AM +0530, Akhil P Oommen wrote:
> PIPE enum definitions are backward compatible. So move its definition
> to adreno_common.xml.

What do you mean here by 'backward compatible'. Are they going to be
used on a6xx? a5xx? If not, then why do we need to move them?

> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  10 +-
>  .../gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h  | 412 +++++++++---------
>  .../gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h  | 324 +++++++--------
>  .../gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h  | 462 ++++++++++-----------
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   4 +-
>  .../gpu/drm/msm/registers/adreno/a7xx_enums.xml    |   7 -
>  .../gpu/drm/msm/registers/adreno/adreno_common.xml |  11 +
>  7 files changed, 617 insertions(+), 613 deletions(-)
> 

-- 
With best wishes
Dmitry
