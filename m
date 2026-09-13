Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C93F7AA9
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325421; cv=none; b=YKZ2Ck0QiHIJIJftafbt/o9aU2dCBwuObwK2zlyQmmCy2Jkp3ZmiEI3vuBvnNt02A67j5kKTwYpfd5OgV7RLt83STGGbICm/KE8KFNBmyw9FYYhCXbPCKktWzI/qW9YehpVvlZvhdzbfo3QNYOV5nUd5TaPNk8bUPL52cYNlOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325421; c=relaxed/simple;
	bh=SotE3v19uTlQ096YvT10NlnX7cpT6wjYoiC6wIywFc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODh7GX8PmcSIiwDZnyuDmbxrvlIW1DTyUtFFtN6w2DJyplQpqmo7w/WqQJMHTYQ+f7VEV18ARRiA2yL5ntEbdLWt7NXBcAHuBb6HHrmq6+o4Bz9sALXBT7GZV+WqPhLANNqpTYHddLPpsfl4Oxf/RcGKMZ0v7nLljjTZQGDPddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KmBG+UUg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hza01Tp2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KmBG+UUg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hza01Tp2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2hdh1929748
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pWuI/WNDQwf1Ze/N0XRHCYa4glKdApgbQFIkuNsVpTE=; b=KmBG+UUgdcFiuabQ
	GKhxDBBEnBnPLu98dcfyTXu1y/7NMSyjyMTvBy/JnW7xpI7z3ru87phgSvg77JSE
	UPiNHiwWNENgFZ06qNFG9RK6HFUrywlmcjzC9iLGRLes2HDPklT1793y0Yem2HnA
	eNcM9s1EyKUBMKUae10DKXu50qUrfi5xx8bMu++BC07aVtDbsEOX6b3R+XXB3yGy
	yKoc4+PZgtBnD4LWNuNSU6I6NUItQGEAwVgnL2JvSCB+NhBCEiQNi6w4ytOxPps4
	kKIAGjHzK76/MZW8d0t7Sh89nuYR07z96mVF+nVPXdiQQYrUwhrsB1qVnRnORyxX
	i7rurg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd3y5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:50:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b6416441eso5005586a91.1
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325417; x=1789930217; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWuI/WNDQwf1Ze/N0XRHCYa4glKdApgbQFIkuNsVpTE=;
        b=Hza01Tp2VJcgidUHbDQi1Oit4Ss5QHGPLzeVn0Ush3pH0oR8w4wd3jzoNG5jVLWVfW
         PGQ+hCyHdqpwegijJiepzpH45eCQD5nL7UuE4xkkVhII9WJszcLoBgKXX3htvkcuj8dS
         Ufgqeuc+zrzyFZFXV8wgVqtASlT3eoRgChY3dTXfIFee+GEFwRUJ1UbW5iL5jfLZlTFj
         iTNaWF4MkXqzHrU+fvXxBLVyi648YAQKjFSmSUcauLqQIAYWc110E2sYq/yNlDw37caF
         kZsXswpckKI+5HiF0BkrVZ6LKiBJEzojyv1niUULIJ0t2DpQBjnOH6uN783xPTe/0o0d
         RRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325417; x=1789930217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWuI/WNDQwf1Ze/N0XRHCYa4glKdApgbQFIkuNsVpTE=;
        b=mWElATnMWdirMhdu6U5I1s3DompAqviTZvIRA1T4mkQFy8sNskmShrCYFX/3D2duaf
         N1nKRymP37ak1iVS4arsvTb6Ui+fAkLxMchUKcnFbaDrhjV4EIQhGOx1FSXf02IATOfX
         Ga0YZVHtGR4k1zsq6CsLZTlOyOv6th9BGTnBaxVUYycyAn1iJlDwchuja/uRpaLJxfBD
         IS/f5bgk7jpSsF4nAuSd7EH161HeafH19o8n9+JKTh2vDoCaJMiTizLyM+ZzwdlnVs5l
         fpx6/NGVJhrvPDcCD7lD4/fgdPCbPNpFVV8CzTfOxBrKS2aNcxJT4pBn+P8uXw3zDgaI
         KRaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDoKWePMYBe4AzaERHzI7ENyjB7TAg3sxKGXhjXCkAG6WzQs4KJKZtW1ocdrWwEs6FhwkkVQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kR4tQEUtdPo+JBZjvhz0u38UqhbjIwc9+TkkDAnD15hyM3V9oT
	qBsWtoed1ZxYx/hPse5LJ1BHcxCltiS9NGgc8BJ3rDaPr9pZniF7taxIHi6mEXrbZwsPPx97L2u
	hcEDHHbi+NlcYyJB/5do/GZZ0VrapnQ8qPVoaT/mI6kNx6yM4WNDYt/BefA==
X-Gm-Gg: AYBFou1d7+h+Sxx4XTIWQVXeB87j3Z5SLzFSx6E01nIRm9R1MzFVHugukBNeiRxRT0a
	dTfiRxaIn1qtsem5ye4ZcCNzMcry4Zfaoe3Tk3NsSMIroo1aTKLxz8a7ke8UUAqsvgu0lWaD6zf
	5EwWFHd8nD0ZIWur+GLqu6K6WIeYPRqZZwAxGSRmt0uZvyvbzOtFj4Z7FtRgjwhmbYEY1Uiq8Ln
	h+reJZRk2NwMLx99Wn1TsOmfQSoA8A51ACgmSwt3E9fY2vAJO34J6/gXlF0MGFcclK2aAqjYmTN
	dSqPfEn64G+eUgvy+iGYZJAWfTxA4kIkvfb2P9XgltfNz2saJKHaA2WfLl3pJMg7QqYd3oLM8HU
	VT5RvG6WYL/0rYA1bY/s/+T1Wpo25st1YrCs=
X-Received: by 2002:a17:90b:134f:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39d9beb0be4mr26510988a91.7.1789325417386;
        Sun, 13 Sep 2026 11:50:17 -0700 (PDT)
X-Received: by 2002:a17:90b:134f:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39d9beb0be4mr26510935a91.7.1789325416949;
        Sun, 13 Sep 2026 11:50:16 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:50:16 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:21 +0530
Subject: [PATCH v4 04/13] iommu: of_iommu: Add support for "iommu-ranges"
 on a device node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-4-9b9074a73c41@oss.qualcomm.com>
References: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
In-Reply-To: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=5912;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=SotE3v19uTlQ096YvT10NlnX7cpT6wjYoiC6wIywFc0=;
 b=KbtO+WjJsBKGHbk8Ef8lwgXtsXrFvcv2kA44jhpSPiwxZ0Z0YO5OtIGIfpNMFWsoas1fLZa3j
 /Kq8XjxatuDDbsIPxYDiSDC8a+z5pA1D5/b1pStcgy+Ewlbf9DV0H17
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa6f06a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5d7BNXMnqyCmxenBVOsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX6+XiNuc/TP8K
 syJlFyg03FShY+sSvRYJcWVC5sBpVQO6utDi3DxhVtzFNWYa7vdPhPzepMfsfY8/lIS8IgbYfuD
 v7nQWQkMTPRRvIOCapqxb3F2CmkYQ4gb0tEEpA0tvVX19QfkIf1zJazeI89p+Z60A8BVUlRMsCF
 QTJiUVCMJZdNvX4xKN/hzzzkrYP8v4p8sDa1++nvKNj8ZrOK7ZgAGRGZSMoMqCCATAVzQ6mx9xu
 cETA4rNk96wm7BMElt93I0aLSUCF35QUKlW/lfjOYre6gxOMw567GpHLTYnt2H9+AL1qwZangrC
 jknWljk1on6xOewT1E5vxt+T82fg1XIo3ZpJNsayg7+kTS2OHgosTtpeBVbjrEpyCFUHFB1bakJ
 aw0ocPlDGKy6fbz3bPrnIAnKLP95isW0XMQ3FWpRFck7/N1DRJF6jDroduuKEaf05BOtgwJZMRH
 JPzBymMaq+oyMNcWD2g==
X-Proofpoint-ORIG-GUID: 9-O2UfipxKUv7LMwFd4gsiH56BezrAc2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfXxfQL+rZI2+KV
 Y3lwfwABP9urd1rAOvgQkxsi0WUpruE1XjL8968i2lxBN7uwUsPJfG3rIiysVoglZQl27tRYT0v
 +TevkYGLJw1kevFye2saRvoMDjlpK5g=
X-Proofpoint-GUID: 9-O2UfipxKUv7LMwFd4gsiH56BezrAc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130267

Reserving an IOVA address using "iommu-addresses" requires it to be
placed in the reserved-memory node. But when "iommu-addresses" is the
only property being described and there is no backing "reg" (i.e. no
actual reserved system memory), it does not really belong under
/reserved-memory. A device IOVA range is specific to its own address
space, and does not describe the system physical memory to make it
qualify under reserved-memory. Given this, place "iommu-addresses"
inside reserved-memory only when it is paired with a "reg", otherwise,
define it within the device own node. It was discussed here:
https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org

Existing "iommu-addresses" property expects a phandle, which does
not make sense when the property is defined within the device node.
Introduce a new property, "iommu-ranges", to specify the device
specific IOVA ranges when there is no backing "reg".

Suggested-by: Rob Herring <robh@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 115 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 108 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a18bb60f6f3dfdba853b6e16dd2a8616f6a731c7..baf74db838d6bc45df2b36c49eb47eeca21b4b7b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -190,6 +190,98 @@ iommu_resv_region_get_type(struct device *dev,
 	return IOMMU_RESV_RESERVED;
 }
 
+/**
+ * of_iommu_derive_resv_regions - derive reserved regions which
+ *                                are outside of iommu-ranges
+ * @dev: device for which to get reserved regions
+ * @list: reserved region list
+ *
+ * A device can describe its own usable IOVA ranges directly on its node
+ * via "iommu-ranges". Everything not under those ranges is derived
+ * as a reserved region so the IOMMU allocator won't use it. Entries may
+ * appear in any order in the property.
+ */
+static void of_iommu_derive_resv_regions(struct device *dev, struct list_head *list)
+{
+	struct of_iommu_range {
+		struct list_head node;
+		phys_addr_t start;
+		phys_addr_t end;
+	} *pos, *new, *next_range;
+	int size, prot = IOMMU_READ | IOMMU_WRITE;
+	struct iommu_resv_region *region;
+	const __be32 *maps, *end;
+	phys_addr_t next = 0;
+	LIST_HEAD(ranges);
+
+	maps = of_get_property(dev->of_node, "iommu-ranges", &size);
+	if (!maps)
+		return;
+
+	end = maps + size / sizeof(__be32);
+
+	while (maps < end) {
+		phys_addr_t iova;
+		size_t length;
+
+		maps = of_translate_dma_region(dev->of_node, maps, &iova, &length);
+		if (!maps) {
+			dev_err(dev, "%pOF: failed to parse iommu-ranges\n",
+				dev->of_node);
+			break;
+		}
+
+		if (!length)
+			continue;
+
+		if (iova + length < iova) {
+			dev_err(dev, "%pOF: iommu-ranges overflows address space\n",
+				dev->of_node);
+			continue;
+		}
+
+		list_for_each_entry(pos, &ranges, node)
+			if (pos->start > iova)
+				break;
+
+		new = kmalloc_obj(*new);
+		if (!new)
+			continue;
+
+		new->start = iova;
+		new->end = iova + length;
+		list_add_tail(&new->node, &pos->node);
+	}
+
+	if (list_empty(&ranges))
+		return;
+
+	if (of_dma_is_coherent(dev->of_node))
+		prot |= IOMMU_CACHE;
+
+	list_for_each_entry_safe(pos, next_range, &ranges, node) {
+		if (pos->start > next) {
+			region = iommu_alloc_resv_region(next, pos->start - next, prot,
+							 IOMMU_RESV_RESERVED, GFP_KERNEL);
+			if (region)
+				list_add_tail(&region->list, list);
+		}
+		if (pos->end > next || !pos->end)
+			next = pos->end;
+
+		list_del(&pos->node);
+		kfree(pos);
+	}
+
+	if (!next)
+		return;
+
+	region = iommu_alloc_resv_region(next, ~(phys_addr_t)0 - next + 1,
+					 prot, IOMMU_RESV_RESERVED, GFP_KERNEL);
+	if (region)
+		list_add_tail(&region->list, list);
+}
+
 /**
  * of_iommu_get_resv_regions - reserved region driver helper for device tree
  * @dev: device for which to get reserved regions
@@ -214,10 +306,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 
 		memset(&phys, 0, sizeof(phys));
 
+		maps = of_get_property(it.node, "iommu-addresses", &size);
+		if (!maps)
+			continue;
+
 		/*
-		 * The "reg" property is optional and can be omitted by reserved-memory regions
-		 * that represent reservations in the IOVA space, which are regions that should
-		 * not be mapped.
+		 * "iommu-addresses" must be used in combination with a "reg" that provides
+		 * the physical address and size of this memory region, for an identity 1:1
+		 * IOVA mapping to that physical memory.
 		 */
 		if (of_property_present(it.node, "reg")) {
 			err = of_address_to_resource(it.node, 0, &phys);
@@ -226,11 +322,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 					it.node, err);
 				continue;
 			}
-		}
-
-		maps = of_get_property(it.node, "iommu-addresses", &size);
-		if (!maps)
+		} else {
+			dev_err(dev, "%pOF: iommu-addresses requires a reg property\n",
+				it.node);
 			continue;
+		}
 
 		end = maps + size / sizeof(__be32);
 
@@ -258,6 +354,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
+				if (type != IOMMU_RESV_DIRECT)
+					continue;
+
 				region = iommu_alloc_resv_region(iova, length, prot, type,
 								 GFP_KERNEL);
 				if (region)
@@ -265,6 +364,8 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 			}
 		}
 	}
+
+	of_iommu_derive_resv_regions(dev, list);
 #endif
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);

-- 
2.34.1

