Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375143934D
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419902; cv=none; b=LH2J5wI+B6j1zf4ZJPyaTlUZHPPmiPDsRXfuUEUEgXOCpYg8V5P1vHqAW+izX4UHVqzwi8BI+ige8jn/tYs+RCq/EgQrlzU1ZvqaNa84hSZZsfYRLtBDo7K9OxMQPPXdRqKUoqPb8X6bsrt70WAGdJJyySopLGsQ0pegH4d0foY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419902; c=relaxed/simple;
	bh=NGmaykbghdv5wsGGoS0c7PRsUk7uE67XyK8PQWs6r+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6F7F2uIuGuGs9eVKmBSrFJOXNruUA4Yj2gIqvp4sfKGcohlLi/RDDludCFqOGVdZWW8/xa0T/yexlgPiOtx+gRGOM65aIH+sLJIuBPZBKYAkzdJtJEVyUp+9DHj2I5QFSaeeVwEeddvS1HeX6yWf5/CGWCSsJJiOlqKnIxb6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JtDGpmHE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HIiBn7mE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JtDGpmHE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HIiBn7mE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDQ2p427129
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HAQjGeRZHjyUwhLQVrzoyan+
	i2a1c9ZmrG0BP4f4QSE=; b=JtDGpmHEJRmAYidb7xSW8UbrE6V3u1IQjp+WDhkr
	XsgLWPuDjJe//HelvH+nb5W4sUwseM2j5J1QJ7M4iFam4BlMoZ/5ou+24aoJITmc
	n1FiKdbsXbu4FZSJPzkCNpJCnfgUEbacSyeut+7NkPh+7IoiVIKMKTudfbhxRoXH
	OSFgsCpvJOYDJP/vjdvZ9GbyFzQmpAsd0jUTCB3zb4O6ATuUuZHxtvTtxTjcF3GG
	TwrGNkBlKvGg9kJLChk+4LbaSFCWrmkcTH1I3xF4QHRpl3V+kp+q5LUe9gD4YjtB
	+oi/x297yj3NAjW6h2d2iKiWwxTEgQxh6ZH1xl8EgBFeAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3tyh5es-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:58:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso22176861cf.3
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785419900; x=1786024700; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HAQjGeRZHjyUwhLQVrzoyan+i2a1c9ZmrG0BP4f4QSE=;
        b=HIiBn7mEf29tXeZO9WnRPqDzOQeedxaPF8f5BdEOJgXP9ph6zdVMs0OPygpkPvRH6H
         gN6WgDnfdacvwo79fRuAn1IYH6KNe5TNXos1c1tenZhZRUp+/QA+Joi9zubZqgLUL1Nf
         Qp1OA6mveumhofu25+Isza+i/ohvKnR9kIfRW5Ozn6PIyBln8ijVjjUXDQ2mX+AE7tO5
         YAFxXh85DQf3h1Jg+2ELRz7y10+Igp0xd5pQjIRqTqlU+74q2yKMCa8fFL1AHVfKJX1f
         Y5VIOXBOmBeI/v/pRz18qV1kk/G/9cTP1s5FEhULaalsV2HJ2zuJQoSgdjLbzHynfhJQ
         FHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419900; x=1786024700;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAQjGeRZHjyUwhLQVrzoyan+i2a1c9ZmrG0BP4f4QSE=;
        b=hCjCd6X/gPmfaxUlSlNxyZIJR2IW8pfIZTQ2kwVSSFk/hSeUvJkEDAz9ZtUrQr1yXP
         oSo2hxn4F5KI9jO/gVxo55SRxB06AtgEzt0nbGc745zixvRotlPVtFg2Ya1IVHeCeR/I
         uUZCABJrbueTUHsRV7Zyn56Akqrz9P+c4ZetxMBeIpA9HAT6kVjZqBHOkeY5vyLvxcem
         fG8FT5FXublloJWCl0otncYpr3PnmBr1VJ15h9txkxdfBu9C9NL2ORB5wekADh4IoMf0
         b8drJW/zp54wgrFvMb7CYZpTO1FZaWj1v4G5J1OKE0Jnqzb3mO+IlS9RifNSCvW59eX1
         HKkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpo1yVe87b8eXGXEoDztBTG3pEy1dnpfSOC6ZZUZbZHwkE6KwD1H7lQsJ/UZawlNdI3Q9E8tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVqB6/6CMF0l0LHQePc3vHw6OMTQa4lCpXzHf7/tMN4FF91a5p
	HU508pPosLiWuj+D/Slp52zFVfZE2M69Xbb86NYGN2lLuflGSLS5UGK1Y3vxD69OpC3ZqoVeLtK
	QHf2r9uTvMJ9/JZp8wLTMVVKQujwh3IHRZ9MJJAnDQKZpOZQMm77hrkGmSA==
X-Gm-Gg: AR+sD1276kYeYMWL0dc25tYri3dFWiufd31NJ2TRZ1vzSSzB7PV3ysx1MndQnkh6B2A
	5aGHH/HwZnYpXreR/Sf/MJy4cnAsMTknD9M8bN08/8m7EktMRQKw4bWcCokvgT0lXM6qq1+oYcu
	94/25WgW8ygcvmh8vZngH6l6KI1THlKtALfUkonEqWQJd3YrdtZorVPYh6jKOjjmWi23rE503LL
	wo6YAaAG2quXKkkY/eKz/QpRG6vIMMVlbEUvw6hfPU3J67d7WP9gIfhLULySzPnPgHZnoGi3qmE
	OEpMEkL9mTfzCjLt1++5aDArNRFHDaQmg4rKTIcC4o3eYE4o+9XK5h7p7HFdxr+a69E5YYYwOLU
	C4cx0qMu1AnUNPsZxDIfiviXURX3+ywQNSG5GfphHQVilhhxLG0CK9FuAZqZKEj2f7buSLp3yeO
	8qGxxAAPfIeJI5ZQ==
X-Received: by 2002:a05:622a:281:b0:51c:7b12:1200 with SMTP id d75a77b69052e-52b386c480emr27808561cf.78.1785419899793;
        Thu, 30 Jul 2026 06:58:19 -0700 (PDT)
X-Received: by 2002:a05:622a:281:b0:51c:7b12:1200 with SMTP id d75a77b69052e-52b386c480emr27807931cf.78.1785419899145;
        Thu, 30 Jul 2026 06:58:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2db94febasm343902e87.19.2026.07.30.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:58:17 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:58:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] drm/msm: detach the ARM DMA mapping before attaching
 our own domain
Message-ID: <h3rfonvwkxkmschyypytwgwxbmnq4rou4iyk6iq577c5tcfdl2@zrz3xhfzpmlr>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
 <8e55ef12-6c4a-42b4-923b-238b3739ea51@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e55ef12-6c4a-42b4-923b-238b3739ea51@oss.qualcomm.com>
X-Proofpoint-GUID: YARZBwYNSO4t4gprak4NnfJztMhR8C51
X-Authority-Analysis: v=2.4 cv=JZOMa0KV c=1 sm=1 tr=0 ts=6a6b587c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=iwl2vSsomdHTBBcAHCgA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfX+qynu5KTt3e1
 7mdhhonocA3zddZDTs2IIzrjEPV7fSGC9tW6vM2Q+4a8n9Z9pT4BlU0BdNHBEmEDJENI/idYTPQ
 f4DzjuuAkCBmXiKL6f08Y1loHlmxUeP1SGowdaWj2hWsFXO/ljDVsGfeVVAwEtp7rdb+1eJeYtQ
 8dWwItpYwZ7G0wPPVNawtOJE0zdiyfyLmiV9oncq+DgxLUguRtetbNLODLiRcEs/A4l4czROauF
 4OaNV5GzyD0l908TbyidiTFXkvVs1ZZWlOGxrptbsR/sRBvKCPW7FHMYC8pYRIm57fJUJMewVVF
 QWf6LPSBzNOjHtdbGzjq3KNs0KjwCFcjb/zqS2oBAsZBKLYA89x9NwKEt5mkpHp9iJQyavyoY+g
 +yVksKSBWw4EwsToT8v1c3g/EgWqZH9F8ssFwgmT8kQVxOFuAvdLByNo+2GuYTFcjGEHE3X+6nG
 Xg7V7BXAe6YvuiFhJNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfX4E40v4zhVvQI
 zdOw5CmH17T8f9pXzJ1Wv/62PgHtQXL3BjYgovCZfSYA98W/hJ2eIy/wn+TgIoLXX8C57EbaUhi
 FRBahigIOmgGk1bVVUYr7o/i3dwwXDo=
X-Proofpoint-ORIG-GUID: YARZBwYNSO4t4gprak4NnfJztMhR8C51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300106

On Thu, Jul 30, 2026 at 03:42:58PM +0200, Konrad Dybcio wrote:
> On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
> > On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
> > dma_iommu_mapping for every IOMMU-backed device and attaches its domain
> > to the device's IOMMU group. That domain is neither the group's default
> > nor its blocking domain, so when msm_iommu_new() later attaches the
> > domain the driver manages itself, __iommu_attach_group() refuses it:
> 
> [...]
> 
> > +#if defined(CONFIG_ARM_DMA_USE_IOMMU)
> > +#include <asm/dma-iommu.h>
> > +#else
> > +#define arm_iommu_detach_device(...)	({ })
> > +#define arm_iommu_release_mapping(...)	({ })
> > +#define to_dma_iommu_mapping(dev)	NULL
> > +#endif
> 
> I see this is prior art, but should we support this config being off?

Yes. For example, on arm64.

-- 
With best wishes
Dmitry
