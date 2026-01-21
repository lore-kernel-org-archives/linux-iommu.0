Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272233D6CD
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768975266; cv=pass; b=WVs6V/l+/ze/SjhP9CWi6iG+0If9XFOWStRAPmIGZuKAHlwkpCHmVXakiBTkQ3BfzqHBL0wffwbMoMgzECdeKF0Cc5miZifY5tecksDFpTKv9v5WaaFzBLF/B0Ug5Fm1WETtmZbVUtI1ctKKtFvR2jmNTABZGV6qMYv0A6zgXaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768975266; c=relaxed/simple;
	bh=PIEAM/MgNLzP76uOlF5SmUyBHUjJVEVQeinphZiXYuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSRWO0dlzLVNWisx7kEjpNyT8SQr95k9i5wXqGuO4j9B3GUXS5xpyIwztPAuaK5Zn14/ogocm2Mhd7vpcnmYf1XQjiKf0faK3ULFFFZOe10XCDemdXxcJ0vmDjDA4Nd59cr4t9tmJiDF1AUw5jbmfwt1TPLrws2DNe0OcKJ2XwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nb0XnS/9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcKDWPW9; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nb0XnS/9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcKDWPW9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L4FFMt2840467
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gSvyHaRoK8a/eK7RNla/ksOG
	lCIDLS71LBI9aYDbSFE=; b=Nb0XnS/93FWODyFx/U+GpO+c2LRqoCzZP/xp0Oi7
	8x4IAaxaeezBHbVFuDuURoDKNgdqki0b1ozWwRoP99Xv6xuz1tcmX14oPjUtLhPc
	FH6QeELEHGZPszV4YvnTXCiZOREZ+aaoLCG0/rnjle43I6LYix8koXJmtS4W7sOW
	A76wvYO7ZzVjlIAzUaayq7NDrPG0OvU9sw0gX4FhR/Xb/KP5i3PTSgs+ElN+CWiq
	wNZSoEKgSzi+Ypf/wTwfPxr6pDn0LSBZ0nyoNpRSCk+Laeu052N8KQQUd+nsqVHu
	GIy4EfkFCeWClQXYERxPXni9U310uhNzWD64cQuKcBB6Cg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btqm1rcny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:01:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7a98ba326so3227005ad.1
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 22:01:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768975263; cv=none;
        d=google.com; s=arc-20240605;
        b=cfyKZAZvaIMx0q7DfqiFnl+a8XPKyqv6W1i6ti63si0czMSGm9R9dMHWqJvKEbBqRD
         aKYLtitSlVmGuDfUjl58+lOyqQXIj2sOKE5BXC/qRayky7Jc4XtxxMw0zvvi/VfLGCpE
         c5IGRyfgxBRbQX/6Abj4lYK6WSnMs2G51kHbgZov1hTLYNEXs/PsmFclnU7Ocv3uRRBm
         VeUmv3+OLT3a6QeKFc/YV0H8CDpwFJuP07H8E5LQP+LAEGaUGtPqvhF3nBJcIZy7vPkL
         +HHId+ehx/KlJmQstmCOdi1vgBNtd9o4ma28nEc2+TzsZZT8vs7Nqp7/4Rk/bMCfBxNV
         NeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gSvyHaRoK8a/eK7RNla/ksOGlCIDLS71LBI9aYDbSFE=;
        fh=TCMJ0G8osYTMv40+Zr5IzxQiSdotYuaiH7eImFEpUTA=;
        b=HP7YZrB9o7D7fi7c6fl+UgS6+/IePCSjqGpxGHRCQaTicSkMTDXGuNxJ10+6HZoelx
         MSGnMWuzNG4efSLI6mA/rypsLt4NzgNVmahEqz64LwsXXDt/xJguIChsbY2RAF8nLzhL
         y33xPBAPSsqO64mYfUDhpzfEVyFNS/3ggfmtBVm83xfaBb7gyFLldm9zGTr/1frEUQe9
         sKHyw2h+LjQyXXmfAcsL+P661X5HYrBeGpHMlh8lKGajMxSoJzdXu9LupHjcxBVX1Jxp
         0zy07hc2Ia6YLqkM6VPuwLa6mSoExyzfMfzXuZRT6/aNYezJiL4nq02EqRdK1gnJArBW
         8b2g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768975263; x=1769580063; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gSvyHaRoK8a/eK7RNla/ksOGlCIDLS71LBI9aYDbSFE=;
        b=UcKDWPW9QjyiN9Ol+FhZSPhj5sk66kZugG4/iXd86gW/XnJHqJ2WMpPDMvHRmI9uN4
         fNdXWCE9Roike379ylq4w2cBEKDlXhdpTfegWoFcmFniXQynGGypbs6qjlvVTvgb/4o/
         41rM0alQbAdYx2B4XZc7bl5CyNhBH7RnxbpvNgpVYmbI3dNmPB9YpssOdrllUzHZu9O1
         es856IIn/zHKdvSqejbaPyMVE2yRM8xPH7TtEUkh7FJcfz/0siRxG8eJQU2GaEflBLLy
         swZ5vSwYmOkdlDS4G8UL7kdvY7+H5asrzMVtezZ/UPuW+u9PNYf+UaN2LZ+8aIXQjKTD
         /udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768975263; x=1769580063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSvyHaRoK8a/eK7RNla/ksOGlCIDLS71LBI9aYDbSFE=;
        b=tNcXEx/hzQwdFfZIuAWqDCoMC/Qr4g65HITOdMZMbUn28VWMC5gruca1IKI0YhTTFK
         PsrbdETbGvYrYG/CSqqMYd+1onO5jd/ZRqzaBOyG7s5jRK2Nhz5152RpK09DWT+PtqZX
         ZTCsm4ixtWkC1XZZMTX2xIpCagCc0i6upaBcir41aZI08LbI/3hl7rpnyoPnhGOlj2NL
         rKu5fvIgC/52YjJUXw7vRyvnt61gYPxZJblWsZBIE1gj2xj2fKAbBGfHTAASm2aYhwE7
         VdL8TjIwYzR3shLdawe0YrSaoIuXeIznkqnct4XV20j/Ha4REMgA99cfWLG76AQ0zw6z
         49eQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/fwIEwOEurw7AR0kEj4ZWM7mDu8e8EtNLe0uxAl1wenLo+zeQKiWOnTUHpdfz6pY29lHLWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw0KONE6JNrvpxmG9qppAU+zbNpgV30F/8OkG3x5ar+VaOsRmi
	9QsobBb8lh6bPQp6Tls57KaKy5ys/px4BPhCvPnxjA6FiJdsLVS3uhi7H08ipyDDlDGunFQQ1tl
	rP8+i/iieU5M7jPtcAHIqkFVrU8KBtd94NJXQ3vWGdwW/KBNrY4g1Gg/G7x7ZoLzVYY7/W4bD0N
	ab9XLJKh0cQqlHzBS8NSxxgg78eIQVcH1z
X-Gm-Gg: AZuq6aLrTMPIbXzEroBGQMqwYfwNhHXUkpmVW1NCOwDsl7uRGSsjWUQFnVO5VCZmkLP
	Ev5EiLCji2EDAY5c4TYYi6uW8RHAdQluZGkta1q29bJxxKaxzkCXMT1V6dGYFMHwdiabdgTOr3r
	1A2vjytZVeQPHdv/ImrNJfFHnlRhxH6lFwC2LOzDqNHAZrfvbeeUB32YWuJBwwAgzVprENO/enf
	bEKkP8OISAofs9cjEwy3Y7F5I4=
X-Received: by 2002:a17:902:f545:b0:294:8c99:f318 with SMTP id d9443c01a7336-2a717546704mr161191665ad.3.1768975263406;
        Tue, 20 Jan 2026 22:01:03 -0800 (PST)
X-Received: by 2002:a17:902:f545:b0:294:8c99:f318 with SMTP id
 d9443c01a7336-2a717546704mr161191075ad.3.1768975262696; Tue, 20 Jan 2026
 22:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com> <20260121055400.937856-3-vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260121055400.937856-3-vijayanand.jitta@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 08:00:51 +0200
X-Gm-Features: AZwV_Qg6Ul_V3ogOQp1zbvETUAk5jiMEg3E2MGIICiSY2GjISUBiJcgDF0zh7zc
Message-ID: <CAO9ioeXLJK6fvriRA9RZs8cWcBdv4fgw8VG1_LqLDfc-5hFQZQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] of: factor arguments passed to of_map_id() into a struct
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA0OCBTYWx0ZWRfX8IQnf1gFVtho
 YkK5nZZcBzm4UMnE8lolelvTnn0oG2dJvoSFWdUGgoA7mUYFfy4PSroUJRYhccdjEIYavEzpb/k
 c5HQeXHvqsE843+iBPbKfuEYpTdwz2z00lyabE5A2gYuTVRPIiEgbkJnEkh4Ogzl3FvGGnngCsx
 uj73dBZ9uIpWkBfAVClV6X6hSIph3wo84OBHv0mcqDk7FHgku479nJSHwvEDUq8KVrHvuCWgWkZ
 z7WXtReO6fXmyVkf/PuLpUCx0rHMc+miY33rinyckJ+FgC2PD4OgF+RLQa9VJH1hPlxY59z17uK
 J4I35oNhdKki+YRDzFWii9myl3EiAooJhsQp+01tQ/48KQgeMcMgmBJoagV9qqIce7nd5d17JGe
 6nMk04gmMoWnv5AQDE8hqhUPMG0waMYLQKJUBKZDkpMcNI72UJ/yTAiUkUDUxLVHT2Y7TYepHEJ
 rlWjNyWHjflZ2rUn2lQ==
X-Proofpoint-ORIG-GUID: 2s8Fqjqao-PznLklMvpjEVHqFRDmWVmF
X-Authority-Analysis: v=2.4 cv=dtnWylg4 c=1 sm=1 tr=0 ts=69706ba0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=3_r-Vw7G6DVWPkSdAkoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 2s8Fqjqao-PznLklMvpjEVHqFRDmWVmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210048

On Wed, 21 Jan 2026 at 07:54, Vijayanand Jitta
<vijayanand.jitta@oss.qualcomm.com> wrote:
>
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>
> Introduce a new struct type where the optional arguments passed to
> of_map_id() are Currently embedded as of_phandle_args struct.
> Subsequent patches add additional arguments to the struct that the
> caller expects to be filled of_map_id().

Which additional arguments? I don't see anything being added in 3/3 of
this series.

Can we use of_phandle_args and switch to of_map_id_args when it's
actually required.

>
> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/cdx/cdx_msi.c                 |  2 +-
>  drivers/iommu/of_iommu.c              | 12 ++++++---
>  drivers/of/base.c                     | 37 +++++++++++++--------------
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++--
>  drivers/pci/controller/pcie-apple.c   |  4 ++-
>  drivers/xen/grant-dma-ops.c           | 20 +++++++++------
>  include/linux/of.h                    | 32 ++++++++++++++++++-----
>  7 files changed, 75 insertions(+), 42 deletions(-)
>


-- 
With best wishes
Dmitry
