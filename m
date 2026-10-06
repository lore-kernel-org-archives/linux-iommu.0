Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216DE3C09FF
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276804; cv=pass; b=CZa2DZRi5IQL3xcaHQ+i6I8WFrwshp8P4Dm4ij2iQ+giCFxvIKbf71gZeBQDyNEgGWYN2Qv4PzBq0S7tWzXeRhkTZGq4YPg9cS/u+7mZ0pUfxDWYv+lyYL7YbceGJ3uSazvKFMtSEw50HIMAAVLwZVdVCrIDhOBaWTJNvBh8ZYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276804; c=relaxed/simple;
	bh=VLcjVIGQA/r1W3ldFK6WW8apuDX6mf7txYWwobfyjFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtA3nDS4bq7eOENlGb5vm//L5/+1hoUiRU7z11zTdMRQbI+FkxI5fbNJF7m22It1XSlm36glzEtsmiyJhIqwYnquKeI0y8hb8lavGx4BcGKeA6UXhc8eZOcGUMIw+jhb/u94oIXRJ669inRGiFN3Bgw9yRInYVQ9XSKeFd/TOOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N11QSB1z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FVRwD8ch; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N11QSB1z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FVRwD8ch"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966eEW04103759
	for <iommu@lists.linux.dev>; Tue, 6 Oct 2026 08:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QQGtjGd8ssqWuv/V61Y20ONf
	ksGn+OprzCvB7AXUQWs=; b=N11QSB1zHyJJcjTIZFpax126Tk7PweRduHBLIQfr
	9WI/6tPVU6/1Sq7jSIhD7iJncx2dewrhweyDOeUxV7rS7YUMXPT4CrkLbzD5QgzM
	2q+RyDEN71+5KHHvSjS5clpUzoAVcBcq//y305l50RsWDd6KAR//l+rjuKWZCW2+
	wipkInHf7SGEizuN4h6jeybHNmEW2SJIBirz46aStIzpgr6hKBd8oLIihZDzjNR7
	sb8BuFtQnbettKsV3vvYdZC4V6ZTrDJylyo07DXmfIVN3D37HZ2g3ECCIl7F5JQn
	rUollOwbyfQoRHPqdxD6SfvQavDSjhPpLiyRB6m2GiM92g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr0at9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 06 Oct 2026 08:53:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db8e9fe9c7so28585255ad.0
        for <iommu@lists.linux.dev>; Tue, 06 Oct 2026 01:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791276800; cv=none;
        d=google.com; s=arc-20260327;
        b=VUrOzqnrstVU6IGWFHw7GyuSXt3tLh2tR05phg0/PTpNrEmtZzU8jyWADXltlyTcol
         sJLJQnj9TunYCVjaqUmOgf0tDPc9rxsjg5oB7bgC+fglH2u377TBFk5yi8mzp2VtY6my
         CqJ2VOAEitizOgXOiuS/ziVrGYZK8ERi9RMD1JaLX7a8sgjk8jx5zN0uJNeZdXwX31Gi
         XYQDXnX9kpyJXDcslGHsZheGoqnT0gMNb7Vfju2CYXtjIEth0GnpcNU3q5H68nPYmW2L
         UKZYCool4gJRxnNel8B8sV5qVU4LJX1Z538KIux3V34Lmlw/DTOShbxVxCpkCsqHocFT
         UiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        fh=ui+x0D2d7wM+6qIcnmZ44GhS1wDN0FopTaTUQg8Rn9s=;
        b=gOg5DpQm1OEjaZuXAkTEapYFSqdL6RayXJxP7NrCi811xcUangs+/Q1OnM6ibw6xB+
         QJq2flc/KAXyepklcRcr/5rufQS6LDpP7P6b1bZr4Grli9UjDgW1AkT4haheO7RrZA1n
         q9P6i1do2Ny7GGQdGBMEQeH5yQl5BM3tqukUtXQKLKvUQ7dEfBCfUz3+JY0+dYF11ffc
         MB5QP5HPicRz2XLo3+n5VzDtfJN4L496UhovIbL1I65n0wZUCLryaxZ3E0qc8l3Inu5i
         h/aTWBZASeFL1HXm1HLEpgvdYYfKLvtvZeT8klJ+wgCHhtNwuZ0vURcRGHVNvW6xeyVC
         sFcg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791276800; x=1791881600; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        b=FVRwD8chEjSG7lHD5i1vjrhVM79NyBDtCYUB6KQNyJBRF8Fyvs8u2t5AWeEPo5Tfrv
         Vkwbp9HVIvoBDGmWXDkGZYBliQCtklWCgFmCSaXy0UAMu9Li4WiKCPVQLCXDw4Ov6JJ8
         XWOB+EsKqqMRIKPtHmMc7KZ8Itg+JQbu9UmEkMMAe6r7Gz50betntvUapRslpk6ltg8v
         CBi4o9cdA4WUcBjwH/7dMH/g2dpoBtIkBZqZvmtNc8Qelx3z4pYvOIFWmHTbCT6IICTI
         fITmrnebTr07z+c+1iUNv42MpGcFrv7aNz+ZYhpyTQkF22HntCExWgIXkUllmQzohumo
         mWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791276800; x=1791881600;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQGtjGd8ssqWuv/V61Y20ONfksGn+OprzCvB7AXUQWs=;
        b=qif7HzcXABuhugMWUJaTVEAJ76QfSq67moV5vplhtE8VDwayRdYZ1Xr8r1TEwmIaMF
         MKv7/w9hJE6UDQhaJ14AAjVWfUWFwsap1faumA5PmIpfYNaEg4BvxNtfzZ3Fg0PdWQU/
         NTUHkNVAjRRKmeEd1HWs1H/NP7QSqZ1z4e2KHGu7nm9O0ulCMDB5UeOuN9TctAlD2wZc
         o3J6AjT2LQw+8BG4EPaE8wQCFWaZBjdys2McQ7OQzTXKkj1/sDy1cKXjpMYSQYtRCUUT
         Tbh3nHZJ/4/7FztNHg9kbozl732ZmJDm7wpLqDdPqV6N6emMAbKPQFEmG7q4kLEJm5ek
         9m8A==
X-Forwarded-Encrypted: i=1; AKwUvBzITJzoWzsopcolN/Uw6J1WgXKf6izWEoc1oT8Jz6y1O/gmq92O2PJqpP/yb6KkTvG7rNTI1g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ4yG1DvKCc9edwiHFxmfWZxcwOUmJarF19sa+plMTNmcW+40JZ
	MWoJUggnpDu1X/Ho0Sfp1jWFyKhQF+K4BW8vSrhdtKgQl3mv2jGYqiowzDbJpWpi1kjtHvGNxNG
	PozhdkF6003X6a/4+JzRS6GgEJ2RrB9ieu13ptZzYbLugQtpPEqjTYMSswEiqRystW88xm44YMk
	nWxxJ/9LOgecPgIKcBBGBIx/0HUaHspAUr
X-Gm-Gg: AYBFou0ieD07zL4GZHaBibmf8Cy4yjgZsofjoEs99jHeMylIiUa+uoAGFs+wG09dduu
	nx9Me/p3zooVbo0ad/nTitcmBFow1MIM1cuoqSCfPmpZGo16p3GxmW3lyDPT/clzDlKXEadvH3P
	N3Rgs2jLc5GleKJ2o+RFQhnO3E2YeFUT/44ng1rEcJSO4RVt9UZIfnUJQSeIoiGppvfdsxHIYN9
	sELJGH5vrtmJpE=
X-Received: by 2002:a17:903:388f:b0:2e4:949b:1ea1 with SMTP id d9443c01a7336-2e5dcde4da4mr6597305ad.55.1791276799658;
        Tue, 06 Oct 2026 01:53:19 -0700 (PDT)
X-Received: by 2002:a17:903:388f:b0:2e4:949b:1ea1 with SMTP id
 d9443c01a7336-2e5dcde4da4mr6596685ad.55.1791276799127; Tue, 06 Oct 2026
 01:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <179098834078.3641559.798772743228949994.b4-ty@b4> <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
In-Reply-To: <e590764c-1ef7-4166-9c2d-a96a89029736@mainlining.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 10:53:07 +0200
X-Gm-Features: AclHuK-hxeLXCCkrwwvQbFIYUVeIjRX4eEFvyGsggP4ez254hGL6BWI-C4KAx08
Message-ID: <CAO9ioeVAf2GgS+wu9GiQ3kM-_1KnrdMfhcpVotxhiFegEiZP2A@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfXxChVYyCyAJ/R
 Q2MsxM0G6bLdPB2gHTBiRhqJrlGr9lyowPeDdOmcfpt3ujEKrGchxO1/CBVin7yDftdKG+QMrYS
 rT6B5k2FAJaGOWuadnnCZt0h9Mj8VtCtaH2oNFczhZkRwOcbzHQj6xu2itNtT16/0Y6wM/NNi5+
 mOcLRY9UYPwPsUPZqhW4OS9hTKlc8LW1gQjK6HHM+oNRRVXl2bWwQhurDn/P/jNU2GmBTRG5ZtJ
 WIv2rdhoPwjdCoa7Om9d3Gd/ooQ/gc+v+d18pQ7P0rZosd5djhSXOEBFAzNxP+bcnSmsFa4SOsT
 dpaK2n9f8fcSaAY3hyvXwH4TSE/fPnrJCHW1pBizJyf78FcGy54KtzZZwZ+S7AcYBGQ6R0NDp4h
 mCSTvvBuiGwDaGa2/EOlvFJ2lRYs4TwoJ2MWyOuSmUFZs7Qh4cp5cfQgspCR8utwJuaxW4pGIhD
 CW5wjLXICDJkeEjdEqQ==
X-Proofpoint-GUID: e7XDVLu_NdrhgGbz5_G2CoSktnb2yPLh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfX3yw6ITGUxvYP
 2Ndf4FDpr0X0OWtXsREtloccipJbMv1ntpAbIF4O53VUoQWMnGbPE4Sw+uZB94zALatv4svn7q8
 eCCfH4GbaXOKUp947Ac3WfWzY5EZexA=
X-Proofpoint-ORIG-GUID: e7XDVLu_NdrhgGbz5_G2CoSktnb2yPLh
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac4b700 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8 a=OuZLqq7tAAAA:8
 a=wG-LvS21qxlCLh7KYX8A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060035

On Mon, 5 Oct 2026 at 16:00, Muzaffer Kadir
<muzafferkadir@mainlining.org> wrote:
>
> On Sat,  3 Oct 2026 03:46:52 +0300, Dmitry Baryshkov wrote:
> > On Mon, 21 Sep 2026 21:18:51 +0300, Muzaffer Kadir wrote:
> >> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
> >>
> >> Ported without uart connection. ramoops and usb
> >> mainly used to debug.
> >> USB is not enabled in this series because it
> >> depends on the not yet upstreamed (and not developed by me)
> >> pmi8950_smbcharger.
> >>
> >> [...]
> >
> > Applied to ttt, thanks!
> >
> > [01/19] dt-bindings: clock: qcom: Add MSM8952 global clock controller
> >         (no commit info)
> > [02/19] clk: qcom: Add global clock controller driver for MSM8952
> >         (no commit info)
> > [03/19] dt-bindings: nvmem: Add compatible for MSM8952
> >         (no commit info)
> > [04/19] dt-bindings: power: rpmpd: Add MSM8952 power domains
> >         (no commit info)
> > [05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952 compatible
> >         (no commit info)
> > [06/19] dt-bindings: vendor-prefixes: Add General Mobile
> >         (no commit info)
> > [07/19] dt-bindings: arm: qcom: Document MSM8952 SoC binding
> >         (no commit info)
> > [08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
> >         (no commit info)
> > [09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
> >         (no commit info)
> > [10/19] dt-bindings: display/msm: qcom, mdp5: Add MSM8952 compatible
> >         https://gitlab.freedesktop.org/lumag/msm/-/commit/df6ce9e6447e
> > [11/19] dt-bindings: firmware: qcom,scm: Document MSM8952 SCM
> >         (no commit info)
> > [12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible
> >         (no commit info)
> > [13/19] drm: msm: mdp5: Add MDP5 configuration for MSM8952
> >         https://gitlab.freedesktop.org/lumag/msm/-/commit/7af226f9aa59
> > [14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
> >         (no commit info)
> > [15/19] dt-bindings: thermal: tsens: Add MSM8952
> >         (no commit info)
> > [16/19] thermal: qcom: tsens: Add support for MSM8952 tsens
> >         (no commit info)
> > [17/19] arm64: dts: qcom: Add initial support for MSM8952
> >         (no commit info)
> > [18/19] dt-bindings: input: touchscreen: goodix: Add binding for GT970
> >         (no commit info)
> > [19/19] arm64: dts: qcom: generalmobile-shamrock: new device
> >         (no commit info)
>
> Hi Dmitry,
>
> Thanks for accepting MDP5 patches.
>
> The message lists all 19 patches, but only 10 and 13 have commit
> links, the rest say "(no commit info)". Does this mean the whole
> series was applied, or only the MDP5 ones?

Only MDP5 ones.

>
> Best regards,
> Muzaffer Kadir
>


-- 
With best wishes
Dmitry
