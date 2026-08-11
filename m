Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E471A3160
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452203; cv=none; b=HC+KdhZH7ktKs/zncfbaxYK89dlHm4HScFVTCXt+XvU1AFYZaY1jP25C1gnELeeQ0vfHKm+uDwGiPA+Z7eChow+RlNFX9BW5BfX0epuSR6l1oOdBExuCM6gTT6mCZjLHonm0JVFKQnnHA3BmefR4hZRjq27iwwtlzXGFRykyQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452203; c=relaxed/simple;
	bh=Vl8+7IT/uEy0SK+7WR3BHgfykoQtDa1Phxl1M7aqKcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWWNjEdcp7EEU9xC28DvE1wGN8rZYuZXLe1wa9at2M3oUWr3SjdqMolJzUFasV3wgbIjnhFpUTFoC5W3k4hwDqXtWGlo2pFxuEiaZcxRbC0cSwirhj/t8pZ5+Mun4JWpn9gW4VMP9/F0kyuNk5zjaZ9+inZxcnPC9KYwokRvHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N5hVmZtW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CePTCVNE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N5hVmZtW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CePTCVNE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BCR48T263317
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 12:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZotZ3xHhfhh4lvvQ7TJQUuGK
	xRSsnI9jOw2Piwhfm9Y=; b=N5hVmZtW+cloo3ZaTcxV54OSrmISf1IYQocQFzT6
	doIAgBsnFOKnAsrJRfoBbiBSVDP6erJQzK6Ja1zHkLNyYfBCwDNiUPAoT4HCX751
	m9qGH8bgibeXa6bceVFmtR48ODuhZ2m/0OeQbd4gQdNMqlUf6qSQYce1ga6a7OQQ
	wL+2ZLDgcCAtcrHNBEKXe7Xw6EPhCkqoGao0emQ5MWKMxztcyrsLGV3heWV4pgUx
	4Fxm5OAW8R0na9SUXxdI36UQQwwulQImZuPS5kU3lA1vbpIudMH4/xKlE8LvPKTV
	ydXlUVrVjumegq0G6IUDfbtotacgRpjGfjQYajXaaZ1OCQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyvcr9te8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 12:43:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91931144870so342243485a.1
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786452200; x=1787057000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZotZ3xHhfhh4lvvQ7TJQUuGKxRSsnI9jOw2Piwhfm9Y=;
        b=CePTCVNEc7EGrSmn7Tr/ykqylS5kiJSEvhtjYh9gnOYcyOLOanERAB2LHAM7T7HDcn
         u0LnF6ozfQR4Aw8PEWTBJ3afervYYBt/kqm8BSMfcIesBDgS566FCEMkrq2To8N5Yhsp
         fZBjkoV75zRDpTvbP8jZjieU5NjWRygP2cFWAry7BzrooCivroswv2YNyNfd/FzApcE3
         RQk2wGhEV5sFj+rWJ4mT2U84dOr6TKC5DQlVwTHe1dLVbinDdScpuE2dIzfh0iR9DlVS
         g7jKcdqRYYW6AuJ627FTBpcqCw+nSr1+lAYiUp+55piX18jvSiMxldflRYPak9PYP3uI
         krag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452200; x=1787057000;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZotZ3xHhfhh4lvvQ7TJQUuGKxRSsnI9jOw2Piwhfm9Y=;
        b=hvqpZ59/gpGO0gTE5nxm2LfGqhNPDP/RiKc1+l/YRHd/c7A81gx0yXp88uui5P/yXg
         8ZgWzXjplFh1fWY4YsyI1bB/J8Y0epF7KUBpzttz+ybTd805ISW+iB6clvd1pQBn07ix
         ESvl2whktgBMGn7GrrfaldLrV2B7ud0OuRLSdvqoEBQaWfoy2o2H9SugDmmtWM1DzRhG
         jmbzlgKILZciva6c4qXeRBGKjZVo2a/4jaMLB0vmVqKheUkYflLYHWdY4H3m83Ahf7kJ
         y4LBm4L6EKFlxXfhGF7f4g0eb2uP2jIgLJwUqqhOCR7f3TC3YWOWs68gvO+5XM4lSOta
         42zw==
X-Forwarded-Encrypted: i=1; AHgh+RqzkNkpu3CejqAX2pCyCH4OX39njgmLK+V99mnvSGXPk5P1OXY+FIoLwkgUeL2tCAsxUNtyMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxctG8yv5qtFSDLP13OFJEdpfomf3DtnS69Y7htPUcFKt0Z7yh+
	kkGKsFLvhcBBJSlkEOI+cpcWdHeltFjrB/F6DYe4qPQX2+g3FXqCQkD4vlyUNNkF9yfYjXa3IFw
	28GC02uXAJP8lPvaxCHt92328Veyp2blXxY7Cl/o8ckaTwtlr+4q1sLkW1A==
X-Gm-Gg: AR+sD13THzwnyB3Q4AH2RiqQHDlEgSgHWo4ynJyc7BE7GUIomDUC2Eqi8Hea8oXzXxN
	I+KqNAyE5p5FoZuPoj0wVfgJVQuDPRoukTnACwRQrIRxq9D4edv2xKY/zJcQ8fr1kYzBv+nzfyH
	v0W/0KxGwJt56Y9b1Tdj37rcRRFzUSCunjENGz0GTtRemANm4VIZXcmzlmXbBnurbBNO8LhgQdS
	OfdddHL3gPFoJdguXWhHOyK+vEeg/9kwHtmScaLwDNsI28ALd+dq0n40LrPiX16UU63rZzNTtex
	QqTxxFtmlHGD1zVsehnP+AGdLioAApDlX639KqbpyB/Jn9Ls+7F7XOpAje31SdNGMPsXH9Pw+Z/
	dSYR+JOgcXUbXeYz0Avnn31p5lQcbXYQQtYECreoepOYDCeO8TosvhIieFhfVJiBAq5A/HgQMVF
	rZohnOX1BaEo7P5w==
X-Received: by 2002:a05:622a:544b:b0:51c:73f:e3a7 with SMTP id d75a77b69052e-52d585e2be2mr24810211cf.26.1786452199493;
        Tue, 11 Aug 2026 05:43:19 -0700 (PDT)
X-Received: by 2002:a05:622a:544b:b0:51c:73f:e3a7 with SMTP id d75a77b69052e-52d585e2be2mr24809341cf.26.1786452198937;
        Tue, 11 Aug 2026 05:43:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a0fa3bd115sm2187991fa.9.2026.08.11.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:43:17 -0700 (PDT)
Date: Tue, 11 Aug 2026 15:43:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for instances
 on MSM8974
Message-ID: <iv5radfllym2bjvkrdu4ffs25bqixyos7k3ymncpcdtc2uobn2@zlhsybrj3pwz>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
 <DKL6P7G0WTM7.UJ6KZERQZDFK@fairphone.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKL6P7G0WTM7.UJ6KZERQZDFK@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfX4pcajJwqcpBa
 Au1/3++Oua6e1+b9BP9WTHF41QATYIxtIMbGG8mkWVPrDiCW80FTRK3ZNjZntyewYW/oB5giXQj
 yoTcnLWJbKp1fTc/ofr5yBVQT4sINYf/6K2/lQ+Vp3nKF+y/BGQKzWfBjHWy8oG5BO7DNUIyw7f
 +C4+TSI0aN/duH0epQb9QYRdOxa3+/OltLto0JpEYslumAQRmyXfqazAhJ6kMRdEBXeATp8soT/
 BIkNlwdJNn8Cfn5sK7gw8mFpSzWwBUn/EUudZjw0djwAsqjTR+MNCir/BHahH2Hw9yfMZ9OvBIn
 Fw+byHs+Pzn7aTHAXodvXVFGyXxp7WZdOBOL9JQ7phFSLi00qyzkAMMkRlrZ8yUv6at6gHQ4z/K
 sCWDt/wDB1OtNQOy6k6LcQ/2WdQxiicpeU63xejmzzZ0qOYfMPBfVgO7oooIITMrUU3t31nr316
 Thtt5s81C1Ie2MZX+wQ==
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a7b18e8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=X4WPEW2F6xLIBrl7kOIA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: N40bHfsKjhBwsiSS64fa3504NAyIQNGz
X-Proofpoint-ORIG-GUID: N40bHfsKjhBwsiSS64fa3504NAyIQNGz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfX6/ZFZvC1Ivx/
 bgz7SyAWCBN/CwsAV/az+hQ053Jq52j5Q0QQuxo3eCqiQ/0LYQfgmkZLyhisEJ8G8qvRzlx/5tc
 97GAXTatTnEszmRA9OiuqN5gMe1kPAo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110106

On Mon, Aug 10, 2026 at 12:16:19PM +0200, Luca Weiss wrote:
> Hi Dmitry,
> 
> Many thanks for working on this and sending this patch series!
> 
> On Sun Aug 9, 2026 at 10:15 PM CEST, Dmitry Baryshkov wrote:
> > Qualcomm MSM8974 platform has five SMMU instances, used by display, GPU,
> > Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1
> > spec, however they differ from other Qualcomm platforms in the
> > implementation-specific registers and also in interaction with TZ.
> > Venus, MDP and VFE SMMUs are secured and require programming only of
> > CBs, while GPU and JPEG require full programming.
> >
> > This series skips IOMMUs which can't be tested right now (VFE and JPEG),
> > and adds only MDP, GPU and Venus (although untested, it is required for
> > display to work) SMMU instances.
> 
> I do have a patch series (sent years ago to the mailing lists as well)
> for CAMSS so I can definitely test this in the future.

Ok, let's land these first, unless VFE IOMMU blocks display on your
platform (Venus was blocking display on APQ8074 DragonBoard).

> > Note, to get display to work properly one fix is necessary, [1]
> >
> > [1] https://patch.msgid.link/20260809-msm8974-mmcc-fix-v1-1-50f2dcf18d2e@oss.qualcomm.com
> 
> I've applied this series on v7.2-rc7, with the extra commits between
> that and linux-next for qcom_iommu.c backported so that your series
> applies without conflicts.
> 
> So far I'm stuck with the GPU not being able to probe, adding some
> printk's shows that in msm_iommu_new() the call for
> iommu_attach_device() is failing.
> 
> [    5.971154] msm_mdp fd900100.display-controller: failed to load adreno gpu
> [    5.972991] msm_mdp fd900100.display-controller: failed to bind fdb00000.gpu (ops a3xx_ops [msm]): -16
> [    5.974073] msm_mdp fd900100.display-controller: adev bind failed: -16
> [    5.974152] panel-s6d6fa1 fd922800.dsi.0: error -EBUSY: Failed to attach to DSI host
> [    5.974230] panel-s6d6fa1 fd922800.dsi.0: probe with driver panel-s6d6fa1 failed with error -16

See the patch [1], it's picked up for 7.3


[1] https://lore.kernel.org/r/20260730-fix-qcom-smmu-v2-3-18e0daf2d836@oss.qualcomm.com

> 
> ~ # dmesg | grep iommu
> [    0.127014] iommu: Default domain type: Translated
> [    0.127052] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.739899] platform fdb00000.gpu: Adding to iommu group 0
> [    0.741358] qcom-iommu fdc84000.iommu: iommu sec: pgtable size: 90112
> [    6.006877] platform fd900100.display-controller: Adding to iommu group 1
> 
> Have you seen any issues like this?

-- 
With best wishes
Dmitry
