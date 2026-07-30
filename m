Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005E437461
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418186; cv=none; b=nP+HMdbMih+q+NErS8oZxcT/QZ+TmpM+v707KbDoVLWxpsd4iILAjCqRXaQ93RayFOVb6Vn/sGIutmPF/1SjpUptrktdLetCvEYdh6shR1ciLG5UGsr2RkHUgAH2ay5wFrQwxgM5T6FUbBNPHW6U8/gIScB94fMUl12U1D8TCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418186; c=relaxed/simple;
	bh=0nxp1o2ipBKscUADiWjzkVftGYkzppsXEG9Cty/+pmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdnGOMv+GScUv9HaoHVoygd2eFnjJTcHtMpYAYK18iPgGBOoArpzaCoW8eWg/RDMZoX36kcGDgYpnrywOE2tptF18wi3Rk8sI0xS3CU3C3kCchZEd1U0ui53o8Wlhj0RLdLoGoBSgZcSYKo3FtBXhEoUZYtxdIlfWJw/q1iAKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LYURgvp1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L901VXFm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYURgvp1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L901VXFm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDH422094013
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4GiyYr8BNvsq5rBrfJ99f2IOVz7T7wBUN5vtVYuv3w8=; b=LYURgvp1IOeS0d3m
	HJGWxB91RSgH72Uo0Wdct4qEB0Z5w9mxpcC7DbYvvYgDuF1tehH0if988qoHbQYq
	Le4FvAaQhwnLlpAhDjC+Uf2YdruL91L9z3E/sI6FTdT6/uBoD8ABT8NfEreerjze
	TUut3vh+uCVTZltfqpNOLy4MeoIYwudZua9D0jXR8J4tbo3jB1qBLkpAkJ22i2zg
	UudXYyrIDWVIK7zHsR4SQ62EX7OnbzzAQEWXvV1kRqS0fuY6ClwmX62gWdItC+ed
	zMIWYBBCVSmlxo21fpgvXeVO9+NLYuIDXOtl9x+2YmLOxlS+lWoJlzX9vsL7aOqL
	LzdfQQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ky8943-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:29:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1c7f135bso38164331cf.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785418182; x=1786022982; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GiyYr8BNvsq5rBrfJ99f2IOVz7T7wBUN5vtVYuv3w8=;
        b=L901VXFmtFExS7bigA2DIfKYUZ2nBtd4XQtgiJcie1PrAZ4cbAVvaQCye1H/rjz7XZ
         0Qk1ojO9tYE5AbKMnBhM5N8ddTpx+5Fp/7seRRAOcC7c5y4Keq+tFiz6c9lnmvoVb5zq
         SPpjJ7XgF97ifbUBmgJ3jBZDNz3F3DcxOJXEqC2mv13eidY4dE23i5vIKZhyoAoJJn9P
         rYGrkwVBfAlCZfcTIXKK/s1vgth8DrdNQD8Os9v74MiaNDGGpxOGkpPOm7L4Hlnz8L30
         4FuDciWqF4S/U6I9MB4ljjNnqCdBsBGorh9F76b1rtOmrvV3f4Wk6J+mncQ1TDLpmYhY
         i8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418182; x=1786022982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GiyYr8BNvsq5rBrfJ99f2IOVz7T7wBUN5vtVYuv3w8=;
        b=I/z/XwzNxWmZ3jqZ22XRzuoXlKZ7CDsp8Dv3TBeYWF1dyeW207reZ7tafsQSkrtV9C
         9wnEcZcGTKt7cyiMfs2+oQmI64MoDxrx7GOWN21uhY7g8al3/dscXewVc/AtgKsXlaO7
         HoDOL3KiV42qVwr7KQr3iCwbu/7X4QKu1+948fsLNH8Pqij8y/5mKVrtKr1VYrt7UMhu
         4Xa0GqWTQMoTZurnZXpPDaXQEyXo0MuuDCeUSJJ5Zx5UevOTBAQmggpjTHGAECRC6mjj
         lUJFtSFfcXHTKONYYeFgYi3L0d1wydKnCjS0hmDB4i1UwGvmO+OApHy4NKR5/296kU89
         wmcg==
X-Forwarded-Encrypted: i=1; AHgh+RqofUK9wGKZjYBu7t5T6Ak/UIQkZhvFR8++NvKxK2cf2YVXHVsxDhO+H23asLA47sXk9mH9Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUmBjhnzPzja/j01BiZEo/SeKFuYsAxJi3pfRfF/O7h+3WHVEo
	w/YGkpRHZAPDd/Fm+qFfgcTCokZj0voASzKHXQ0Bp9iSYUN1Rf+eOA3oEvhF65klzMCFPciEXT1
	BoxPdCWKKnvR81Xyk0NKA4jo2vMKWhnKT4LQ450Vb9WXETs9nD254UwuXgw==
X-Gm-Gg: AR+sD10uLRaGddaDBtBUqvl6wrsutmHzh27LkPZuLr4CEDKtKNUbeeYituP8vZcITTv
	CZznrRF3p0nql8+1Tk3zLAONCuNjvvIxr74YgLNL/FzDodCy2Cd/2TBp9xjGdpzlB86WrXo05R8
	0AzyNdiAf2WgGwiYf5dEWJO342b5bzcicb2JhEbyK1/wRhgCIF7UEfYOUEzK+6uRtoBuuWmEDvV
	bvq4f7dtTGFDy95+7KmoZjHQY1hboVKqfaxgdzleUDWWzk4BHrfBjM8ZUUoMoVwZToWob6xJUnd
	p6fkCsv+FrWm2oiDavsMxuBWKMIsclOiy2tXvQWmPUWO0TxdvwzBTemJIK0UP9+uysLRq4FxaUC
	l2ZdjoAa3LUT0EPAq1sqvDnF08w3NjLgse1FcbUA1+ldehBQq3BLMOPXuHNzXqQUz/5vEuYjau9
	oeb2mlMNYg75MD1w==
X-Received: by 2002:a05:622a:5ce:b0:51b:eb55:2916 with SMTP id d75a77b69052e-52b384c4702mr28152531cf.34.1785418182312;
        Thu, 30 Jul 2026 06:29:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5ce:b0:51b:eb55:2916 with SMTP id d75a77b69052e-52b384c4702mr28152121cf.34.1785418181713;
        Thu, 30 Jul 2026 06:29:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f6acaa009sm2976631fa.34.2026.07.30.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:29:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:29:33 +0300
Subject: [PATCH 3/3] drm/msm: detach the ARM DMA mapping before attaching
 our own domain
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0nxp1o2ipBKscUADiWjzkVftGYkzppsXEG9Cty/+pmo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1Z24J6b6wVbFP1Dv968/8bQ87nekTkSTCwmWXuZJ85pD
 0p7dd+ok9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATYZZg/5/7tEvjz+Qk7vJX
 k3zOtPEfveHQZOPl4cMrqnnMZovt2isnJ07bw6x5j8vBskrclyXQJOLU3mYN69k+OdufMkn28yd
 oXdC4vNBQvF0jvuL/n/j/7K8ND0z8nx1RFSH2t/XxES9nFumAE3fvXWXY3DaTe9kqjnu9bZuNdo
 dLV1y6baTwef+y11rGEiq3b7B7s71kDXk0Z+4zrVfqWba7mTbLbGKtv2mh8vb1iVWJ3zx2CRku9
 i18yJBVJC0nkiZqmZ1xIevEvNvmuSaTanI/pWr3Ou90PDhR7LSPW+8h1VfV63zFRHgmWO5Su/0z
 ZW7YKlWpl857L8hvdYlhjq6SKXyqyHe6lFEr5nTGR6P5AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX1zGPOxhxCOmU
 4nJoKkT5gPcqlqEoynQT8lR5oDAKdnnQ1rdL0RW9FfPfleuabf7MS4vjODWpjV7wglREZX/0y4p
 oM6/2DVRKyCehHMKilTmr6Z/Ft1Ft5G41++mfYprvnu0Q247YP9/nR7Hc9/946hNVvX0ciGm+6p
 fiXFMcK+rzmKfpnLZ0UF2o9OStBp40lrAdSmtz2ZUrlrw8GEHGBFlXDxrC0Uc3DCOY0LANFeOQn
 4Kr13EE9XlSTCsv/ul8yop6tcn8FZsCkTSrpVHXkGVKJn+PWOEeyLJvkMJSDh8JXYxzBGYFndTH
 p8MuxTrRYuqdLrbBKsP/A8IsLBBTrBOm+kJGXw1a092G4RlY0NjgybrOKhAtFSr0Mi+uafk6rX+
 lqhuA69Besgsm4EL7Im9inld4mIe+qUPPBcsy1dRwS95zDJHl540KsSB513mAtk+djaGyu1uiQA
 U4ARrRcQi1LaX2YobxQ==
X-Proofpoint-GUID: gvorhWIYGwlgItX0HjJfTorqZXNeKIxx
X-Authority-Analysis: v=2.4 cv=ctOrVV4i c=1 sm=1 tr=0 ts=6a6b51c7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=epCurf6C53ZFYVxhAokA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: gvorhWIYGwlgItX0HjJfTorqZXNeKIxx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX3V3jDVucdrQ2
 RA9j9J0g6COYE3wqqoVOWcZY/x3XbXHgeXDO9Nzq8aqITJ5NrFIfPzjqtk0N3h4bjwUtnYGWHFh
 JrjX5FfiKXQpW9dRdLaELpnFnjc5nqI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300102

On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
dma_iommu_mapping for every IOMMU-backed device and attaches its domain
to the device's IOMMU group. That domain is neither the group's default
nor its blocking domain, so when msm_iommu_new() later attaches the
domain the driver manages itself, __iommu_attach_group() refuses it:

	if (group->domain && group->domain != group->default_domain &&
	    group->domain != group->blocking_domain)
		return -EBUSY;

Both the GPU and the display controller are hit by this on apq8064
(IFC6410), leaving the board with no GPU and no display:

  adreno 4300000.gpu: failed to load adreno gpu
  adreno 4300000.gpu: probe with driver adreno failed with error -16
  mdp4 5100000.display-controller: [drm:msm_drm_kms_init] *ERROR* failed to load kms
  mdp4 5100000.display-controller: adev bind failed: -16

Other ARM32 DRM drivers that manage their own domains (tegra, rockchip,
exynos) drop the arch mapping first. Do the same in msm_iommu_new(),
which both the display and the GPU paths go through.

With this the GPU and the KMS device both initialise:

  [drm] Initialized msm 1.13.0 for 4300000.gpu on minor 0
  [drm] Initialized msm-kms 1.13.0 for 5100000.display-controller on minor 1

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/gpu/drm/msm/msm_iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 897e42c8d5c8..da6782fca6bd 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -7,6 +7,15 @@
 #include <linux/adreno-smmu-priv.h>
 #include <linux/io-pgtable.h>
 #include <linux/kmemleak.h>
+
+#if defined(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#else
+#define arm_iommu_detach_device(...)	({ })
+#define arm_iommu_release_mapping(...)	({ })
+#define to_dma_iommu_mapping(dev)	NULL
+#endif
+
 #include "msm_drv.h"
 #include "msm_gpu_trace.h"
 #include "msm_mmu.h"
@@ -749,6 +758,19 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 
 	mutex_init(&iommu->init_lock);
 
+	/*
+	 * ARM32 attaches a DMA mapping domain to every IOMMU-backed device,
+	 * which would make attaching our own domain fail with -EBUSY.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
+		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+		if (mapping) {
+			arm_iommu_detach_device(dev);
+			arm_iommu_release_mapping(mapping);
+		}
+	}
+
 	ret = iommu_attach_device(iommu->domain, dev);
 	if (ret) {
 		iommu_domain_free(domain);

-- 
2.47.3

