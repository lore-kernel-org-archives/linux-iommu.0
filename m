Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D10451980
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427505; cv=none; b=qqBURTo8LgGnl3yl/jLFmz9nCMmuBQw9JXB23wEEwuzaiEI0MROJjKYlLoqdZyU+WjH3eahyDcH7Nhthz62nk32aCjmi3CzEcz1CDMldmmS5HaAVcq1UtTviR1UOcbNwVHY50esGzZ5WeapQg01AEWppK5Q767ejHi1c6Q0JLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427505; c=relaxed/simple;
	bh=yylnZwZL30zYazuVfjsidUHvHDh1/ZHcvFZVH/q3EiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=As8KKMKkm75Vqkh9sMVWAPNJ2OMJ4o1vPtN7rS5rrK+RJEy7w3l3KEJiy/5QEax6JgGyQ5pT70VdyBSJlzNEpj9Oelyg2z9NfWLhT1jDoHL3TydmP2Xi+mZDF7P4/tWOs4fG7bzzUAyzRbJ8cwf2xBvGxLHFoCDTHCb/f/LiQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gD56y8s5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aQoEXh6w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gD56y8s5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aQoEXh6w"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQpqN1414230
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a8y0lJAoP13jgR+kOYEHrpotPr79UnqM6rwBXM92zVs=; b=gD56y8s5X6fP1JXA
	/Roy+/9TPOR8JHkyPbPsYdDJq3g9F7yudy6ISFyCqMh786EsH8hGGm3qpxcsw0y1
	80vIeNs/KoL3SlZnysWWcnXMR3E9N7fKGtu+/4vu3pdPUkKEN+1N0bOw2S+7ixal
	TFjLTZbuqlPnnRmNfIV+WNT8iLQzWL2FV6/spHrt6i9tV835raFhJd3aeds1u0uo
	KVvfCSYlEfTYhXPhPZEILnpzUhcVs6JGGl8rsb/r2reyK0ar5JszBay1nLR/YDCL
	xNQDyqo/+qUWBXDhdaDj9oi8h69AemQta2kWWs5dfYXZ8JaOxzyJkwwcCf72qgsP
	Ali47g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr891gkxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 16:05:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1eb52e1fso42633431cf.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427502; x=1786032302; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a8y0lJAoP13jgR+kOYEHrpotPr79UnqM6rwBXM92zVs=;
        b=aQoEXh6w4SSTHRjde8jl3U4KnsL0KZ84vhePG7tmuAvtBuqDqNJnr/i3UsyoUU8pHO
         bA9UL94c/1b9G09me4Ll4i0g10aPGLvG1aKd/GZCDD81Dz79Pi9mHYdp9A9vB9GQW4N1
         95B1FVsIXgpMn/t5/mI0CCbgwVTbGMN85KoH0nkFC2UAwAZ7DsQDCdEfZVea5XSqM5m9
         lA3nXewa2BsFlXRz+wpFh2WABZUAyvgx3yg+EeE+64SRSeFHyixBKE9tT7T/ddCY6DAL
         t1VfI1FM+FFjcSHuFbEtaX+k1L9NYQHgvMbPt/0fBNHHWDdOzDh5JwoZlKuq6/J4Ak2v
         HYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427502; x=1786032302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8y0lJAoP13jgR+kOYEHrpotPr79UnqM6rwBXM92zVs=;
        b=UTQHuxSlZh0SFgoZB7z6clzzhoRjBcNiS7OPEKOgpa+7II/z68NeWRB0NCatTHFI1f
         edZuMGodzbFwxxog2v4RhwHzQA5cyNKCOtbn93Om6b9iaFzsF5Hjp8bgfLwXE9wLBtUp
         bvfjPJCHgfzzIo+oLlMPSDd5tiT2fd68SpyLlVEujwj6YAL5wmR9tLCFFcpLMCbT00b4
         fQHVmdXrgosXrY890yoEWC4pQzcAJbIg4XLjJCv59ALLrInIPVePmRxaj0uEjAbbs4UJ
         nbw8kdDPqgeUiPVthAcCYl9wCAKha20oZbikYAWqDVbBUbPUWNuvp3ek3YhJCHD6p545
         zjMQ==
X-Gm-Message-State: AOJu0YwhYrkoBk4a+dr+PHJE/lZzMHpothGHC/aBXcWB9KnXrbjYNveB
	7giFRmm4bHyCwLrvwnqHH3K5KgnCGloJGo+JyNPlpmGDfvtHO47dZniZK3cbWqa1UazXEkMETbk
	U7bpG1B6qd/NTfL99BZAje/99spBEFjRP9iB3bWkdof6Mw/5fnr9OvSBtuA==
X-Gm-Gg: AR+sD13hH7nhVzT+Ybbx2Zrc1looXEBmisdprGgTFCmT9Nrgrx+RfM3O+7kv/lsdw4u
	yfO25nXt6O8LGKoC9jzS9VVS3mESRfKVAvKxywz0pZcUEf2AnGQ8s8XE1TInoMWrfybUrfhhKSd
	YPoCHZLWie58AbTpZPGFVzV4a/ek9QaeY5dDornmLN6sKpm4yql4jdPCxjZo2f1INMJZ/Pm597Y
	/jhN/4msoA5TMvLc0gs/H7eW741DPpoKvWDb23xWs97s6ClZPYRF3ZqRXgaGhDjyQRMa/BErcMh
	tAlfrrFNL3ulOUarbG9cJ+5PGd5bRjczTNkUk4hIRfBDM/TKV+Ingg4t2P6wM+uSNCKcd8NUTvz
	S3tSGAI/Of8egrxYthYCmUCgj1CmlUlPoKFmodCjsGHNqnYWJaoHEswaOxqIiv7ASQfqUA/FKQC
	R/LgWalGa2N9MeVA==
X-Received: by 2002:a05:622a:410a:b0:51c:7b12:5fd4 with SMTP id d75a77b69052e-52b38701050mr31840221cf.80.1785427501671;
        Thu, 30 Jul 2026 09:05:01 -0700 (PDT)
X-Received: by 2002:a05:622a:410a:b0:51c:7b12:5fd4 with SMTP id d75a77b69052e-52b38701050mr31839361cf.80.1785427501076;
        Thu, 30 Jul 2026 09:05:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2db8a3bbbsm455174e87.0.2026.07.30.09.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:04:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 19:04:55 +0300
Subject: [PATCH v2 2/3] iommu/msm: use the IOMMU device for page table
 allocation
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v2-2-18e0daf2d836@oss.qualcomm.com>
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
        linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3976;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yylnZwZL30zYazuVfjsidUHvHDh1/ZHcvFZVH/q3EiA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa3Yn4LRMmKH2hP112MTUGn1A2CzlJEBLVqtPp
 LAeD7A4P0SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamt2JwAKCRCLPIo+Aiko
 1cx+B/98g7StpIO2hL9jj/qBiRFSU/vSn9xglHxuoBbQMs2HR9pt0gcz+IK/S1FaTLF18Ve5azl
 FsSckp8I/juT6AAQTlIAnG/GRiY3S9omseCRp6S/HQX9Tm/2NWbLGlHfFHREoOWYf2h8kH9Cpdy
 S24hPjqZzJOrpQaZ83gw2tVqAioJmv2JImnoZxeVXw8PX/Hyxf3tIvxrnzmTfgqu2bsehCyjOnI
 XXrx8xa2guRBqdlYxxViI/y16QNfxvHWE/kNTDO0eSewLl0T5BHSiWC6q+/pf2yiiTyZZPm97AK
 ugnCQ0Sk0x5Xtn0oaa7gTExl2M5GkcBVRAHjhm+S3owboOsb
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX3KBko6S8Ekrh
 6ruSFK4AdfFmLfqNR/cg+NSXrD7xG7TiEaUHKlzoC3mxY188q27xSSqyBo5u2YNqqiDEsdMouUT
 jSpaRuzVd8X7ZucAfStDrjAptvKuewNcJzfXcaDwy7TsjkWpSye89Emzf8WzR0+MtGux2ABZZVk
 81qxSE6j3YPWgoWY57LVLvcetzbIguCE7owupUZh0r9SbJYgOaax7tVRGg+XkdaT4jhH/HZgb5R
 H3m8Bt7pitTYY6JLOsWAYQzuqACYzEVsHs2SSxbEfNNay9zFuaQ9Mdg776tVT8fvDJkiLJP5NV6
 mKM7uM16m+HBLyRt4bnbtz+V3XAHxviSOY7w2965jVsFGldv7VUQHb5MHRGsH8Yyn2a792V6IHQ
 YxacgX1cxgYOWA2JDxV3oqNHXiEpn+0/KFKxXfAERI8PZEHQ7mN//ZlNempoy/Lxt+ljtuhrZUZ
 4detMtaUiDuARULyCTg==
X-Proofpoint-ORIG-GUID: NBFz_iYISuus9lDA6uUbpzUfI7PAtIP7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX8vIJSHa5P/Gh
 PXX1PgnQNEsj6BZEqBMSkcJ3Ioqx5AjrtslLPJBO/5F0BrTaF0iGVIKfOmQyjgpdp1Umfq7nNYW
 +xGK3OHlEqDlgb3yrzOZ7pq2IfKkLFE=
X-Authority-Analysis: v=2.4 cv=PdzPQChd c=1 sm=1 tr=0 ts=6a6b762f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qBQ8OOdg5lpXHOzljU0A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: NBFz_iYISuus9lDA6uUbpzUfI7PAtIP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300121

io_pgtable_cfg.iommu_dev is "the device representing the DMA
configuration for the page table walker": io-pgtable-arm-v7s hands it to
the DMA API to allocate and sync the tables on behalf of the IOMMU's
table walker. msm_iommu_attach_dev() instead stores the client device in
priv->dev and passes that, so every page table is allocated and synced
through the DMA configuration of the device being attached rather than
through the IOMMU's own.

That is wrong on its own terms, and on ARM32 with
CONFIG_ARM_DMA_USE_IOMMU it is fatal. The client device carries a
dma_iommu_mapping, so the tables are mapped and unmapped through the very
IOMMU they describe. The mapping happens while the device still has the
direct DMA ops installed, because arm_iommu_attach_device() only swaps in
the IOMMU-aware ops after iommu_attach_device() has returned, so
dma_handle ends up being the physical address. By the time the tables are
freed the IOMMU-aware ops are in place and treat that physical address as
an IOVA: iommu_unmap() warns "region not mapped" and __free_iova() clears
bits in an unallocated bitmap extension, dereferencing NULL:

  __bitmap_clear from arm_iommu_unmap_phys
  arm_iommu_unmap_phys from dma_unmap_phys
  dma_unmap_phys from __arm_v7s_free_table
  __arm_v7s_free_table from arm_v7s_free_pgtable
  arm_v7s_free_pgtable from msm_iommu_identity_attach
  msm_iommu_identity_attach from __iommu_attach_device
  __iommu_attach_device from iommu_detach_device
  iommu_detach_device from arm_iommu_detach_device
  arm_iommu_detach_device from arch_teardown_dma_ops
  arch_teardown_dma_ops from device_unbind_cleanup

This is reached on apq8064 (ifc6410) when the adreno GPU probe fails and
its DMA ops are torn down.

Locate the IOMMU instance before configuring the domain and pass its
struct device to io-pgtable. priv->dev has no other user, so drop it.

Fixes: c9220fbd7741 ("iommu/msm: use generic ARMV7S short descriptor pagetable ops")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/iommu/msm_iommu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 109688d69e50..15220d79ece3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -42,7 +42,6 @@ struct msm_priv {
 	struct iommu_domain domain;
 	struct io_pgtable_cfg	cfg;
 	struct io_pgtable_ops	*iop;
-	struct device		*dev;
 	spinlock_t		pgtlock; /* pagetable lock */
 };
 
@@ -336,7 +335,8 @@ static void msm_iommu_domain_free(struct iommu_domain *domain)
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 }
 
-static int msm_iommu_domain_config(struct msm_priv *priv)
+static int msm_iommu_domain_config(struct msm_priv *priv,
+				   struct msm_iommu_dev *iommu)
 {
 	spin_lock_init(&priv->pgtlock);
 
@@ -345,12 +345,12 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
 		.ias = 32,
 		.oas = 32,
 		.tlb = &msm_iommu_flush_ops,
-		.iommu_dev = priv->dev,
+		.iommu_dev = iommu->dev,
 	};
 
 	priv->iop = alloc_io_pgtable_ops(ARM_V7S, &priv->cfg, priv);
 	if (!priv->iop) {
-		dev_err(priv->dev, "Failed to allocate pgtable\n");
+		dev_err(iommu->dev, "Failed to allocate pgtable\n");
 		return -EINVAL;
 	}
 
@@ -400,8 +400,15 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	struct msm_priv *priv = to_msm_priv(domain);
 	struct msm_iommu_ctx_dev *master;
 
-	priv->dev = dev;
-	msm_iommu_domain_config(priv);
+	spin_lock_irqsave(&msm_iommu_lock, flags);
+	iommu = find_iommu_for_dev(dev);
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+	if (!iommu)
+		return -ENODEV;
+
+	ret = msm_iommu_domain_config(priv, iommu);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {

-- 
2.47.3

