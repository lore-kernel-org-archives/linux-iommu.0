Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C66436342
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418178; cv=none; b=IHosDiR2HtuEmn8FIyjrj3SG9zD4ujkVXXqnpNLHuyAb4jdGvUXmUmURIjGmuwyX+nIJhrtMPoeBOwQUTxpyOkFWGKGRbiZUHji3cK1SVdLEDWaS4fFGci5kvqvxgh7ZxEAfR/80KSwsMpIGlTOtMksRAir9VUOiCcqPhivnfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418178; c=relaxed/simple;
	bh=QeuOZ/3E7srmsN4kZYdWvz+jVIa+pIBlQp4fMxk0c0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KgxLsoUj+NagsHyAGYUggAeiKsEU/qZDtx1YhTZXkn3OzTQ+D/PXXYVgK+nOgTwExFcDZiJRDJ5TFWZ8H9xI/HUPv6RIzpRCBxrDH2mojIgtgMOSbyxVIjEYYKWeE3rD4lPeVKco1mIZ+NdcMtcGY6LIJP/3KfheoJDAvUGYgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W1Ki/nu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XD1+00+Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1Ki/nu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XD1+00+Y"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDAnx2093974
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FrBxWxjqRXZNRvOm43VwxP
	FxRLqKBA6+pd4WCL/GOZE=; b=W1Ki/nu1aVDuyPmM9trr6PPb7poeN5QDAOHsEd
	jbhxiSE6nzIRlG6VNHVvOWDlxFMQViG076Bqb32lcOWyDA11SbzoNQuFcWndSZMR
	coFq/pFW78LlK7l6/SU8ZAfJEF1kqB6mhymB891IP2occB8EOuORh89+Z3umwfiu
	3nJpXOCbyDIlG2AHNzAA9xVamUUf0z+LaE5AXSPC3N6D3F37fh7gnq2WekrmZEbv
	jU8oNIbAamDOLMHLdYipWTirAWXO/57+xL347zRIFM3qABSy3Qz8Ww0ucD33k8t1
	HnqTJiKpmwfYcme6ZpzR2LIkHopmHTUrYZ5P64P3tutXgW+g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ky8937-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0f0a0760so44154281cf.2
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785418175; x=1786022975; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FrBxWxjqRXZNRvOm43VwxPFxRLqKBA6+pd4WCL/GOZE=;
        b=XD1+00+YqEAJYbBEx9jOAuf/4/6jjG/5v27Ja+O5lY6enDYxsbgOFtKmWag/ylh/9Z
         kklTjHZKH4afDek7gNsiHnIk7M9gdHTzAyua9rU0peCV50GNYTXeEcHAWGT4v4mOLnP1
         zvVYIOI7nyPFLAi2eIuEpe3YWS1Tkn2WFvxOdTp5fXLXWHseyob22To0B5KmgloLggb5
         bTo9VXb5Vb1mzoaqOGxsbV3l6DRnm+T+M4KkvHmFYULwc/JywCASNPjJS80ZpEt3/rQF
         vUCte2Ti0NoOo+17k4OkrMdOMgv6JuhjplILqXNAFFJv87g3/BJL9udsVncyiT3rl0tf
         TPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418175; x=1786022975;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FrBxWxjqRXZNRvOm43VwxPFxRLqKBA6+pd4WCL/GOZE=;
        b=lPieQ0gVqZDVZgRx+r0fk0gJ/OtR0y/15GBaerAdJsIQxc6U2eDhTMxo0n42/OtLvZ
         0zPHhMQ2sqBHDWynvRJcAVw6ysndobK+WIryhy3R3HdcFeoEgkKo2nOfgHb+0V8hdjMt
         CAwuQlC0UC9DQ3A3l7dH4LOr9E4EG4BiZqxQXn9V/xK1QFrnDMyfit6cqQ2qEmMZ7L+X
         X07jJhNlKWLCfCqAR29mE1FTEd6cY62ZNmsHFIR9AHZQRsfNBEWXSjEhbQcaRtzdGn6Q
         nU0u9QtSjVT0mN/GYYRDq3u76PqtMU+8iEi0FweLh1+v15tec8FqBGiF1SzQVuL/ED4d
         rP4g==
X-Forwarded-Encrypted: i=1; AHgh+RpkiAW9wDuLbf/4/aw59PnpBTTFpYuMZs+Vxzlwhwd9bvjTQ0Raa+xk3wSYqkn+IXFC1acR4w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg9C6f9X1KieR76kMUMsVfAZoDm0CnpZO41dsnDH1hCouWPxgq
	/JA7YpXzLA1Cq/Z5470UOUBKuMK/6eQw5HrM/XLkvfUs52zDtS/uEGF3GWam8BqdEdY3++wl1lP
	JMtkkXlGYSOXo6vQFj4W+DyMM/0TXcjulYoYXP2oSnV6ZPwsdtOImN3c0qw==
X-Gm-Gg: AR+sD11INN2t02PiBsRMOZgdQs4VyAXSik140nm2tnwWj3gTKocv1tUhvv8RuOWesKI
	KaayUf6dFWhws7T30bs7EfKMmlgXwnLQAFTeKnpDfCkpleHZ9Up93GjASuzAbR/aZe6n2eZXPPH
	eWYFniSo5QgYBH/Ne+D12MtdeT7O3MfM5X0A4gqTunk/GGX+Mc6YGtBn55OY5NtwppKpnX3VAmH
	T3/BLTd5LCDxS1ZfzuwzbzghZ9wAyKmiHYGGzkXLR4JLXAPuSS0+gvGSAnsOSqO/Fr+hSuXMrv4
	iT4z2ACppaw+hBcYqgoBuVxFzM/j+ss6Uqno/7iHtatdTqtkJPbYvHOp1MJsgDDcaO6yGrOWSr5
	JmtCILRz1Dc2y68t6fFDeiilVB50DZ0IDkMbI2Br0+NbSEFH684Z/kAWg5RRfhOJIBu+jawn/6s
	Wo0zOeuDYbLY6Zvw==
X-Received: by 2002:a05:622a:1aa0:b0:51c:61a:50fa with SMTP id d75a77b69052e-52b385eded3mr25658051cf.39.1785418174817;
        Thu, 30 Jul 2026 06:29:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa0:b0:51c:61a:50fa with SMTP id d75a77b69052e-52b385eded3mr25657711cf.39.1785418174288;
        Thu, 30 Jul 2026 06:29:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f6acaa009sm2976631fa.34.2026.07.30.06.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:29:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/3] Fix GPU and display on ARM32 platforms using the MSM
 IOMMU
Date: Thu, 30 Jul 2026 16:29:30 +0300
Message-Id: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpRa2oC/0WOQQ6CMBBFr9J07UQoUqBXMSxKGaUmBekUQkK4u
 wWMLn/y5r1ZOaG3SFyxlXucLdmhjyO9MG463T8RbBs3F4mQSSEyeNgFRjM4IOcmaPKiKo3MW1l
 WPN68PUbg8N3rc9PUvNCEXfIlPI5TDIUT+3cU+1UcuaNkvKYOSpNmQiRtdZO5mtNd02hCiG84G
 xTrcQlXpymg5/W2fQAr4Tap1QAAAA==
X-Change-ID: 20260723-fix-qcom-smmu-b5798c65d689
To: Rob Clark <robin.clark@oss.qualcomm.com>,
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
        Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2815;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QeuOZ/3E7srmsN4kZYdWvz+jVIa+pIBlQp4fMxk0c0c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa1G8vHFfUkazJpdtkfWB5qcSLTbcR9WeggcWK
 ZnHvv659nSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamtRvAAKCRCLPIo+Aiko
 1Q4KB/45W5IuLGMfukDxWtAm4Kn8WpvsrZCG43DTGKSpOFCALq9XgwWFi8s9keLSIB4kYrYNe06
 XtyxqMCC0IkQ0FM1E//oevvm9bvqUqL/VeNT9pSZykkGfRuEFxlwC04OkBZMAY86IHws8iYgGeA
 TBNi1Xu3GnAMhqtBzcqeHzGdVUn87pGMjczIsbbM8CX2dT+xSCjA1ztwD6ZIPhEC4eeYw8XhlyA
 Oew1C0tmhzqsF/zcB37ma81WyXwpOiLc7RGR66XnWNPAIvKsmhyC6UUHLA9v7La6w5GRi890tNo
 uTB4CSpg9MoHUsrXHeKMbwt/nxWdl1Z0ZcaMEM7DxFp2bEvp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX1vIu+vfQpfkG
 JiX7GPqO4MekUd+hrNqAu6tQQnw8M+wBiP2u0PErMX4GuQ+N/mgFyeA7UKuTiAsK9ByxzyVUHJy
 etE9WvFqbJ9aAurH6O2F5agPMIVlTzwoLfEfyaVrxbJm2nA8vEv3IDMcATKUjzczD2nGTKK/Nir
 vPdHRRkaZDkBUeYzaEAhTdlgZyW91RxwvYOo4k2k4DHnb2qDyrUKCLOfGggAgcMy/eZ4p8GBqyN
 MK2533doCBETekmRQauNjxya1guXTxs3WCMbAevGeMv+hX43RW+6m/sk6gl7kTfmrUE3c7g/cBG
 teUWJvEBENMCjUMtIZkkCpQM4z1iZC+nrb8/xMVrKsRyFaA+b3vyvcJNqYOVvhCV0GXz69dWFSw
 tCGZ0qVF00/603xabm3U62XFuBIfzPSE93OflVgdzdxLllGCZmwNFmre/BRkW8E+wjg6ZaiWZDr
 Zsq5YiodU0o+ir+E4mA==
X-Proofpoint-GUID: -f9vV00ISxwJUC0EWew7eL83xl0Jv59n
X-Authority-Analysis: v=2.4 cv=ctOrVV4i c=1 sm=1 tr=0 ts=6a6b51c0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=shkEvlnnkTupmQYayisA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: -f9vV00ISxwJUC0EWew7eL83xl0Jv59n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX089VcZoMGayD
 KmSvtEg5gFflhQ72/xc9hUr7i+sdstLAbx+4WUTHQTtqyVTu9Kt6GsrbYRWBGHoVCHh1mJ0WflQ
 udOPMlk+QcUIQCaFCZ2vDWyQbz87D1A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300102

On apq8064 (tested on the IFC6410 board) neither the GPU nor the display
controller comes up in mainline: with CONFIG_ARM_DMA_USE_IOMMU enabled
both devices either fail to probe with -EBUSY or take the kernel down
during the ensuing unwind. Three independent problems stack up on that
path, one in each of three subsystems, and only fixing all of them makes
the board usable.

First, the MSM IOMMU driver does not handle a device that is attached to
several IOMMU instances, which is exactly how apq8064 describes both the
GPU (&gfx3d and &gfx3d1) and the display controller (&mdp_port0 and
&mdp_port1). It keyed the per-device bookkeeping off two mismatched
things, a per-IOMMU list and a per-device pointer, so only one of the
instances ever got programmed with the stream IDs. That had been merely
wrong for years, but it turned into a NULL dereference once the IOMMU
core started deferring probe per instance, so today the board does not
even reach a shell with the display enabled.

Second, on ARM32 the arch code gives every IOMMU-backed device a
dma_iommu_mapping of its own and attaches it. drm/msm manages its address
spaces itself and cannot take over a device whose group already has that
foreign domain attached. The other ARM32 DRM drivers that are in the same
position (tegra, rockchip, exynos) drop the arch mapping first; drm/msm
has to do the same.

Third, arm_iommu_detach_device() undoes things in the opposite order from
the one arm_iommu_attach_device() set them up in. An IOMMU driver that
allocates its page tables during attach therefore frees them with the
IOMMU DMA ops installed rather than the direct ops that mapped them,
which ends in a NULL pointer dereference. This is trivially reachable as
soon as any of the probe failures above unwinds, and it is what turns the
GPU probe failure into a crash rather than an error message.

The three patches are independent and are expected to be picked up by
three different maintainers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      iommu/msm: track a context master per device and IOMMU
      ARM: dma-mapping: reset DMA ops before detaching from the IOMMU
      drm/msm: detach the ARM DMA mapping before attaching our own domain

 arch/arm/mm/dma-mapping.c       |  5 ++++-
 drivers/gpu/drm/msm/msm_iommu.c | 22 ++++++++++++++++++++++
 drivers/iommu/msm_iommu.c       | 27 +++++++++++++++------------
 3 files changed, 41 insertions(+), 13 deletions(-)
---
base-commit: 3652b49adac266a3d27cb41cdfdb7d8790fc3633
change-id: 20260723-fix-qcom-smmu-b5798c65d689
prerequisite-change-id: 20260723-msm-fix-crash-8c13220d9465:v1
prerequisite-patch-id: 3556d41e924ad64e8e9c06cc5bd1972c66957f42

Best regards,
--  
With best wishes
Dmitry

