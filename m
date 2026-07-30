Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522245198F
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427517; cv=none; b=Dka6H7lU5pgfkJvgnvGkIyvca+wM87vF3zxhrfrpMExsx9OczLvcUiznm6htQQ2KAQbHxCQ7mIXT0hr+35X2LJPD2GKnIUbejS4u0q0DIHcqsIS8B1Q7eiIw3njqtSuQXfKNOvllc0thNgnxMC4WKUvm6N52y3zafwP9rsYHkcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427517; c=relaxed/simple;
	bh=YMHA00MGVdMnlcJxJUco7AZri2HHepPYlEdrPa5Y7M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9j6+5xUPTrnFuCdzAev3hkMFXGqq/MJIkLAUg5fx8uBWxBivID2rOLFvoPxFfcf8mxWO1WBTptyja0hcnqf54hVleaFwKh9GeSYdFE3AzYFMKSzio0/Yjarpe7vy21/SbLE4tqD7PUlGdHMQ1fvUaeWFbzxtRuQkoGuzryNTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P59Y+N5L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EWPFljqn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P59Y+N5L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EWPFljqn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQmaC2401459
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hQB705iUg9cjPgL+aBVmOnrDJY/xYVqVa7zVBN3y69c=; b=P59Y+N5L7cVuDVWt
	zuGX2bG32jSGlZ0SovPg35dI0f5HBwFVcTOylO2/2+c0jWwVxPe6hLPbUzca5YpW
	m0bVcOX1RqOi5WQscJW8y3z5r3DIAV9/b00ZallZvsOmpPLHJvgPK4Mk99MH50fF
	bR3/G57+apjiZKrKSII6IgvcW6NcKQHgCndt2bhKx37reFi0e1N3QhLAOyEb0SwY
	uqJEq7TnZQKJwC09dSHbYLXPwzwIFwpAfc7mwHc9aYFGLFbLcvf23nVn1AQ/aoZr
	zhZoyN0JphAcyA2Az3XtQvSE7dUC9+oRmboSwakPqFwq2+nvg4FwYi+ueo8TXJcy
	fs/cSQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8168pme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0199faafso24550831cf.3
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427514; x=1786032314; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hQB705iUg9cjPgL+aBVmOnrDJY/xYVqVa7zVBN3y69c=;
        b=EWPFljqnPDg3i3cYkllfI0GzUOf1YlsOONptTRW/f4vAl0DeQRlb2CNEkM2i1fg+0z
         +cq2EEKcokmsDUuLc1M2j72uf4kxhVg1Au9h/8ckDZOnpkWurgffY5PU9mTnDjfNdDa4
         X1tn1kcCrXI/FGXeH5XxAhyTtdYDU2bX4Ebhq0qWRRnbQx3Ue0cZuJnkKAo4Kmwr443y
         u5s3NoZo7rBZleAIqGeDD8L+g1xBsNIf+Jzy8T2vACZ/UXmklFVWfO+GuaZhZyMact98
         33OxY6yGWDJXJqAGDBcWYLMokumYVaHoR4mV/0yDJ5bDeTtCHsQTROGtlPDZLLF1j7LS
         /BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427514; x=1786032314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hQB705iUg9cjPgL+aBVmOnrDJY/xYVqVa7zVBN3y69c=;
        b=Gc7vniyWHPTcTv00r0PH+mSIRZXCZSCpjWw04YQ0AFoQLBj/ZwRO3nRoddJfzXACdZ
         8jQAAAFg9/UeZoonpkE+31CC+7YGlvbQXA5CvO0nODPf8CaV2u3Ek7KxlfdPKGr0x0in
         BZ/THPxgHWkqDNveQDIoeoiKA5n/GLqUKICMXDQDkU3A9Fdl00U/bJxJCJ0TmJrrmjsE
         mFfHXZXwEWrsNnJbw+TDEUTa4M5lnb3T73ZCqaYelgBBw4os3EcMt9+C7XwPccMmztJ7
         hSuAOwbsFnHHxf65XjU7lt4atooCTSGTfBM7wbAyQPg3fEW5VfKPkGGEa/aSg8YBYTT9
         br8A==
X-Gm-Message-State: AOJu0Yy2CVWUfTzjlTpien/DKBcHT0lwYx1Pszhw4XuWb33YDELl0Psk
	+c+fWgN6Xz3QJisHP0AEwNckZRNXmV9E5iHkIVr7KiqP+PUgyaAZecAONUrJuJMBEDzmUjIttzh
	/h2+ODjX/fmpAYx8QxmfWFylEoOaDSumho/s0MSyVVWGKiPXv2zYqqHePYA==
X-Gm-Gg: AR+sD10NZHCSeO/VigvuoHbTMvhGhD+gL0wMwQWtiTvpIDtCdxpoBr6tZhDciEQSJCp
	Mhh8FtihlEOxGes1trNp5a9ycAwz+dnVtrFR3WOBMnDFUtCK3briCx01UI6WByx6ANmwh85nfIq
	YqFWiethmjv6F76OY6VP2GDhEJOpbz0GSlLxVIYxsjKy0v4gtC7BYeq8p2hrAbmRsDWJ4MxDVWk
	w/s00bn4pfRENeKqy54F/nFCrtUw75Oni1Hg4fHJSskUVqFB9p6cDpUCSdsuLnO8w3m3Yk0JvHR
	Sm9W4z2qleQcUPWi+tw43WbBVTDDHItrn+ud0q1JB8F+KGTWtlmWt+sp6cMjX+NhL/SSoKmYhfs
	QuDqhemHwFRsQ7r8CPdJ+4cCaO932B3s5Cw9dh0fwmXnaEGwSMZ787vteUMmGvziFSpK4m0EkS/
	2W5bJaYznCu+AcWg==
X-Received: by 2002:a05:622a:2512:b0:51a:bec0:1040 with SMTP id d75a77b69052e-52b383784b6mr31071191cf.12.1785427514092;
        Thu, 30 Jul 2026 09:05:14 -0700 (PDT)
X-Received: by 2002:a05:622a:2512:b0:51a:bec0:1040 with SMTP id d75a77b69052e-52b383784b6mr31060261cf.12.1785427503397;
        Thu, 30 Jul 2026 09:05:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2db8a3bbbsm455174e87.0.2026.07.30.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:05:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 19:04:56 +0300
Subject: [PATCH v2 3/3] drm/msm: detach the ARM DMA mapping before
 attaching our own domain
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v2-3-18e0daf2d836@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=YMHA00MGVdMnlcJxJUco7AZri2HHepPYlEdrPa5Y7M0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa3YnaPFREPHCdxSgZcp5fpVW9xlJ/nlVPFcVS
 v0UUSRLrMKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamt2JwAKCRCLPIo+Aiko
 1VQHB/4jV3KN0jQQp5q7JC3OLW/+7/9QYHQszWWEPbzovZ7YSoVIaUjgRZYI/1ctEi+wcrpzaAv
 Va5WmD7hjl/D2fCOXFhNsDNVitwbyzMoFcySrFAP6HHiFtTWfb0LolQS2OWn1XDa6L78DNFut9s
 fJJlX6ARuf/n9NgAbt3aVC3gHG+EXDp7uX0Dgo5NNP72nh/ericsR62eeX3/BOo2HjazwEyDnqh
 76tcLP0DlMrGzVG4djvTwWelXB6ADuZvwe4f2F8EtHfEzsw0GpbMok6Z+pcijQJU69cv/8GOjvc
 qO76MtdwYmfE05Nk6nmAJJcIncdyXlN+lD/MqChGEPSB6DSi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX6lMUHHZFNx0U
 2OYxaJTa+zAGXdpjBqqQG9m2LlVuu6OcXLdL5iwDuNJVCGjPKTj4fs4zpbrvH4DWfWVQmanYeeV
 F4+kcQ61ARJFSPASL/CpeTbj6vYcj41THIWjGvUMuvwmPT7m3BknAgAa0JV9LYWPzZIJnu9i5UV
 wLHb4jg3agj8SNLnCmFWim1gf2vArGuwQbl22+2DlmV7/qHd/o07A1whZHApKMLFr8Tv/qIbV+D
 GAiiwtE+hoDFBCl5IRkw1vOiFliFmI/XbsMaEUdDYdMa6Ne2JfS/mvjHCcdcLVcoB/Q6P4o0hGZ
 CsislXh8awVY9++J55j9/0RUK1sH0N4RyJXVqOfXrQCx+o/d/U0kGTicfOCJ8l4s+7CqQxmEzWn
 g2HbXqdCzyjqrf9XBNNt0j7SZuy5c5IPJfIIRxpACVLDJx5RMoqUBWEOIbbXkQVe8EWuaKSS6EA
 7A03o0f7C9djMMqW2MA==
X-Authority-Analysis: v=2.4 cv=LIlWhpW9 c=1 sm=1 tr=0 ts=6a6b763b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=epCurf6C53ZFYVxhAokA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: zezAYYvp0VuToXsJieVYyElKQie0e2Ob
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfXywrJc/rsFbID
 g/yAco7cfSSWuk83Om9OSTVtrbsh6O8Kne2RlNBkGqsvLHPHGyYsVvLbeecnD/ecv/EgW3lDdWo
 FQ1oAEUT+vgZZM05+58Jw8Nfp8CZl2c=
X-Proofpoint-GUID: zezAYYvp0VuToXsJieVYyElKQie0e2Ob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300121

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

Assisted-by: Claude:claude-opus-5
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

