Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA0C2EA
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569297; cv=none; b=O0ZkCPKopoVEoRZ7VwSTjt1tYXadKEsUTFjQqjey+XK5Z+yAmuRQNhlMjtXJlebR85oxR4NDvLvJyU2mJ6Z7xuqMNV0RRY2hs7ieGVrMeSh5h7A9NeilDPNSyA8vH/fI+ViPGFAprVi5NLYknU8fCV81YSk4uaCxRXI4bwEVQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569297; c=relaxed/simple;
	bh=11E88Luuh9A7pHdUZjbdVB67EIiwfHFebSQIHTGLQYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZX3Nkd4qL96ldtQm5gYPqCzsG7/pqQSAHDCTTCDzn6XBZmngRHhVJdY4RD71wmcql6D6R6/z0MWvzZ6tgz4wfDlVulrndZFYsHTiGYBgssNje2g5wkGNzzBbrbURZZGd185Jaq+ppBZ47mrL99wZyl48Pz/CxVWhZCLqAQ4iA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kMsLiSYE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DErh7+om; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kMsLiSYE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DErh7+om"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FIwx8A3577873
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GXLr0N/URsCJyix68R2sWZbi
	19vCcQkgs1ZPrv1rgMQ=; b=kMsLiSYEp9iBn67MtLPyXoWPNsPEFlHZO+BdwhrA
	qy+3q7g9tD/1zMOwwgtudHOJVMJkhR5tZIfgbgiaOZ2inkDi5e+91fKKoSH8fm60
	C9O2pBzWonVoZ2EaMlFmlgUhjXFrR8lvryhGycQOR1eebJYd6utn+4PniDxeaT7z
	obzFMwPOVKnqg0PMtfWy6EB6XguX7z0TYz0BI5meFyjlRI/v6/IwoubpMzOkd5Un
	HKEIx8VE5uflNsoOqYj9IXFAyvzSMfmuPCbVwmoSW8xA8O4pabO1qIQTrqv/1ij+
	jjGIgq00g2rQo1Ig1y0EAZBlQjnkIdQYhGB++9bM1c6d6Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete983vru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 00:21:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157c8eb597so631603785a.2
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781569295; x=1782174095; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXLr0N/URsCJyix68R2sWZbi19vCcQkgs1ZPrv1rgMQ=;
        b=DErh7+omz2SRX/+gr3uRz2+My7MkJNPJ7+1nlGa4eqw2kApBREIvh/IyYI6mnfbwAx
         GVYdqc/UZRU0m4tpd7iDjyr+be9WHBWQ9elCUpo8SX0csbfNVcGE303Ta+akkddwiN5q
         PRi0Xyu8tL3luNjaqSHjHHi/aG2kcqG2S+Z16IpLMEj0jRZfVSbIMhDsLd/vfRAr98es
         eri68sXzbRX2PrOYZGCtJ2H7Rzji/TTzNlg9AjVcAHz0eZeAyrZwXETK7fvzELPOyGsI
         dBJVoM49k47T/njTbEaerlr0oXV3l3nIVfwy+6VuwdvqrVxLUuvZTotaKv8RDuKkNr+5
         Ys6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569295; x=1782174095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXLr0N/URsCJyix68R2sWZbi19vCcQkgs1ZPrv1rgMQ=;
        b=r3aSE3Kf3i+/RRN4pdWg3DJeeP5XEbl6LB3gGPw3g28rJ6b1PkMOdEUr8h6BaioOrD
         25nwlHMv/v1qhLFVGSw05BsehwghCXh/JqDaqPBxIo+DI/2519e8ews/Qr+LUFA7ptLD
         fkZhwLvvkriP4XhPDACRcP6TvA7NgTBfcjtP5HD89eTQRn+Ua+orZFjfsh3PcYPxGRmA
         hQ5Vdo4s/3LuoUSz5v/sjyeAfD2lc/3vhlHYFDwjq+WB8GPrEianA0HWlNHVj428Ok89
         egzPZO65TlevoHDKK5Lh35wC9Q/0Y3ALMJtgkeAnlusu3VbJPsGQbT1l9rZZil0MLu0c
         3GBw==
X-Forwarded-Encrypted: i=1; AFNElJ9ndUNUvxPEFa0wyRcYCx39wLuLIsQWC35GmR+Ek0fB3coJhysbsKPH+LPdVxm3bbZLbHaVpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzunzOQlR1QS6XB3NSDBptYSQ6mteXPogaZlT/cA7xXbN4zuthM
	jpqtqZmzvDG1aHDZfiF2jIe3I1i76rza2MKy3xiN+Kn0b0xCAWhZZxcFUwy06cHknH8QOtFS83z
	OyzD+uF8ohrlxMt8YQE5XuSVSGIp1QOUgXV15Zz/T/CxU5lo52gjr290YHA==
X-Gm-Gg: Acq92OEY63JmNCuOjyiYs94NvTf9rhg9re5NywQC4tN5XVDAg7YxIj7cibCOtAU/1DH
	Hkn9uYO3a9OyLcjeZeXU6fTauWW0jN947Th9h+3a8DX6EIG5Rtkefxyes9iBUvK9PpGDXZpVHI1
	8KW8rtIbxadLLGnRfPuJzRa18dyI+7Ul0vGcCZx0olj1WRRY6k5uEQlFvG2lxNnDdwnX69zXB+e
	iI8dlh9STqZ4ID5pfnPe/2FuQ/dK8lF3Vxw/NutAOHfTYaiLVKlCbqCP7VaelFolXUEDkiysReY
	Id3RaPdNlc4F1Z1QaD75Cs4EN4Q++TWNZGamubc7kFrJ32pvHdiE9bRQ6q4gcS98wHjyxWFnZBI
	tunuLBajgOwI5OVDywXaegvmG1dGgEoX7PWhcl771EgDZxbFORKtkPGLs1ZblW5It7IlTB4dg/K
	11/8F3Z08sCGNRtfjxmnj/AhuhRHM1GJqGwu4=
X-Received: by 2002:a05:620a:2728:b0:915:a457:bf94 with SMTP id af79cd13be357-91c48262296mr197856985a.48.1781569294770;
        Mon, 15 Jun 2026 17:21:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2728:b0:915:a457:bf94 with SMTP id af79cd13be357-91c48262296mr197853385a.48.1781569294305;
        Mon, 15 Jun 2026 17:21:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c05abc0sm2661311fa.14.2026.06.15.17.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:21:32 -0700 (PDT)
Date: Tue, 16 Jun 2026 03:21:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
Message-ID: <sdm7sqiokmsgczeat2mxch42ois5rwabav6c5fm7abct2xoepf@j3kraqrjvpoc>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
 <d25f24ca-5bb3-4276-ac8f-8340e8fb4ce8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d25f24ca-5bb3-4276-ac8f-8340e8fb4ce8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a30970f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ak52lZM5eA1PxQ1fx0cA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 9OQAsPp5xOLaXZU3C8ttpNyWu5YcoiNz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX5V4AIstpXLj2
 S2QuD1yjU5Vl3XkhJZ3rYKWdIDdi9hnezqLcL1jzV/LGTzag8FxOKJM+UOzXRKztAFsBRO8LlH1
 pYk7JXQ0uYzidUwJkgVYg32dZo/Mqys=
X-Proofpoint-ORIG-GUID: 9OQAsPp5xOLaXZU3C8ttpNyWu5YcoiNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMSBTYWx0ZWRfX5gLTy2jNOTQv
 0hqkaQFcQgE1OolyT8bhLC1dYJT8GcXUfO8zKwENSA/rL88EGpki97En243Vk6aGqhGrHUrcnUK
 FBPCFN6DuSIgCJMRdgRDb3zIBoxD/g9GKzT54da3WiIv3YSIe4e1Am8yvjKTet9TYYlZL1yak3r
 tgy+TrWTwd2f1vjAzfPXejRRNJQyGrFyL2K9IwFqLSwahyXN57n4MPSHQ6/wKoVVZVWNqFFinwG
 NlgamKofOG/YOPGVKGvwPhnB3NzDbh/d8azI4ZBYRyZpZV9rVcv7MnR2t8SwsG+k22viDp93v42
 X5lCtMxgHzQEIW7ERP77KR8Bq4e32NzeRAbDDvbvo+J99032Kt9dGYqgrmGJ/RA4B2uPNGUCK8B
 jjUJwPNuvJNXK8P9+UYxRFEUJ7KXApiIIHHmIw4yr98VeLPmGKMj1SRTyUN5NkTeTdw12XBE6iO
 3t3RQbTTgBfoeEpkG6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160001

On Mon, Jun 15, 2026 at 06:36:51PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
> > On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
> > > On some SoCs the SMMU registers require an active interconnect
> > > bandwidth vote to be accessible. While other clients typically
> > > satisfy this requirement implicitly, certain corner cases (e.g.
> > > during sleep/wakeup transitions) can leave the SMMU without a
> > > vote, causing intermittent register access failures.
> > > 
> > > Add support for an optional interconnect path to the arm-smmu
> > > driver and vote for bandwidth while the SMMU is active. The path
> > > is acquired from DT if present and ignored otherwise.
> > > 
> > > The bandwidth vote is enabled before accessing SMMU registers
> > > during probe and runtime resume, and released during runtime
> > > suspend and on error paths.
> > > 
> > > Generally, from an architectural perspective, GEM_NOC and DDR are
> > > expected to have an active vote whenever the adreno_smmu block is
> > > powered on. In most common use cases, this requirement is implicitly
> > > satisfied because other GPU-related clients (for example, the GMU
> > > device) already hold a GEM_NOC vote when adreno_smmu is enabled.
> > > 
> > > However, there are certain corner cases, such as during sleep/wakeup
> > > transitions, where the GEM_NOC vote can be removed before adreno_smmu
> > > is powered down. If adreno_smmu is then accessed while the interconnect
> > > vote is missing, it can lead to the observed failures. Because of the
> > > precise ordering involved, this scenario is difficult to reproduce
> > > consistently.
> > > (also GDSC is involved in adreno usecases can have an independent vote)
> > > 
> > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
> > >   2 files changed, 57 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > @@ -53,6 +53,11 @@
> > >   #define MSI_IOVA_BASE			0x8000000
> > >   #define MSI_IOVA_LENGTH			0x100000
> > > +/* Interconnect bandwidth vote values for the SMMU register access path */
> > > +#define ARM_SMMU_ICC_AVG_BW		0
> > > +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
> > 
> > totally random numbers, which might be different for non-Qualcomm platform.
> > 
> 
> Ideally, any non-zero value would be enough to keep the path active.

This is true for Qualcomm devices. However, you are adding this to a
generic code.

> Here 1 Would be enough to keep the path active, but might be too small to
> reliably keep the bus active.
> Other is UINT_MAX, which will reliably keep the bus active but might cause a
> power penalty.
> 
> #define ARM_SMMU_ICC_PEAK_BW_HIGH	UINT_MAX
> 
> seems to be suitable here to reliably keep the bus active by BCM
> for both Qualcomm and non-Qualcomm platforms (with some power penalty).
> 
> LMK, if you feel otherwise.

Shift it to the qcom instance or provide platform-specific values? (My
preference would be towards the first solution).

> 
> 
> > > +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
> > > +
> > >   static int force_stage;
> > >   module_param(force_stage, int, S_IRUGO);
> > >   MODULE_PARM_DESC(force_stage,

-- 
With best wishes
Dmitry
