Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D185803A8
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965884; cv=none; b=NPmMbykhJgyWq6/wSeRYFLTdD6MSgzvPYg3/PWBdyzBxzdCuAQeGmxvuAmZRkL85mbgwfLkJ9PQfNj5eAwdXN5F1kHWBGA2iRM6T1ALnmYxFekcyk2GNZoTrBu8teHi+U4CtjN1SXJeyqYc45SZg449+w14QlcsAk6H6ws91/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965884; c=relaxed/simple;
	bh=PnyhyXsK/uKdrS8E0sDYZofAuweW5PtRkPRa36gAFh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=un9H+yNr5CUxdHN3w8i1h1G0K1Vw45A8WMZMFmd4zzxxVm9J2p9MYZufM9LZs3cRiuVzInQlZoLLFoAvOQO7+SHJjD8VC0AuB9WPtLVJ/rJ4gsp22QKSz/HkYWbL0jM4SsHowLT5qpmkyAvSqmUtAhZVkUF/8q9XYnAg8mDRw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B06ahjVV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bi8DL/uC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B06ahjVV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bi8DL/uC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CCjNR1400912
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w4mHrMNwv2XiFKZ4wSaQxIr6rcxOi2dXJs6ooQxgIb4=; b=B06ahjVVEr64lARM
	u8vS0jTMdgSXQauJaNDFDb7gCw9k9Jzp6s6gPljKH3uFnx4uocdk4vI4L7laLImA
	Qw9MrjaEdTZVSjVxwK25Ge0QzX+sr09Zj0ypdP7t4fZtN/uTIQhcmYcjbbWDmFHT
	UWKc34jxqC0dlwurcWSzoex/yzn9wIy93H7sz4p8sKHhnQKQOjhReaTMdMJpZE7c
	nIOAaVFrDctc3Mbh4uo0oRfHYEsBX9nDLH/980U4nrQletSeCRtfRcJkl6jE7+8+
	biNoULO2swasBpBNrBWkvEqOa2wa9yEwCD+zWlCruX2OZEG4J5TwtsoP+FNuQDsk
	6t3/cg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk78x0r32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:58:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso4426479a12.1
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965882; x=1789570682; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4mHrMNwv2XiFKZ4wSaQxIr6rcxOi2dXJs6ooQxgIb4=;
        b=bi8DL/uCKDC4iGa7leOybVVprhf2Qz9YeWBslSlwemFTpQJnFDXRsp0m93ISVGaj/w
         yd19O01mAoY/lGJqaia/mPBVIqwoQ61RXZCA9E6fF0f52Oj27aKmQBk3gMpGJ3nHIqvO
         TNvDDfKifzj4uiRozL7O/VL03r0Dd3VXaXDMPFCs5fQXvK0OsBN7NIrjgjlz/ydI5MxB
         vFOT1e2JGY6jSz3bB6nRTG+1+Wy0wj6V/whIHEcQ3gU0qViZvIM1LQs+vYrsc5O22dsQ
         nLEXXkvZhwQ7l3+1m6/CTO9DIsA818H8L7GyhqlXyG8AqeWiZj+SEIfluTauXer2siAP
         zHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965882; x=1789570682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4mHrMNwv2XiFKZ4wSaQxIr6rcxOi2dXJs6ooQxgIb4=;
        b=dx6pxoZ8mCkelUkF3HMHMW+FzXVLMusR5ZVmYtnMb+rX4y1HCH2QewiKrOSvE40xFK
         Q98dAhrRHYJK1llqsq9fQr7jwFHx0BilU02AL8BzA/9OAQPLybJ+TSPzowoNwsfGufAX
         gleMz30oIdgygiozMG9FGH8wgM0tCqPVj60Qc/dOdR9zWzoV3N0qBFwQJktFzHzl+nKZ
         7PBYv1hAH7JYhnUxcs3KwjklFbccfb+d9YqRFj0RQw5RN+axJVejOGbQrpvMkUD6QQCl
         EL9QAdCFJ5qklwZb2/qu1LB3LeiGWmLkG4iOkzISYL/Q9nn/wmaa0g99sB5CPj1M7r+E
         zaXw==
X-Forwarded-Encrypted: i=1; AKwUvBw2Qw/H0n/a5nmF6MqtwG+ILJZyp94keiCdBmT9c7ebrVQwv70889dwORWT8z1XZNQ5RcUG1A==@lists.linux.dev
X-Gm-Message-State: AFuF++lIwnJGbtQedCbu85R8uG00RimNHogUV/7dXfAVWzrW93jH5AtW
	+hLAlR2zRmb3TbGBiQMeBGdUoKQ951Iug+PWsPPfNL4Hmy1V0wMZ0/Flcoo6fgXkrVGZvqur7k4
	uwPyuMA2Z7Sr7ui9GBT6AhTzMqyWE1CHj6LdTJtkwzSoB2GhxMnSzMUv5Ww==
X-Gm-Gg: AYBFou1blnTNTBA6T0ZKbq7/DM1YxxLF7QEVlyh9cgDTWulVHwTUAbUGcV7+F/lMn7p
	Z7TjRfzT+LCjremy0UL6fZVVmwWYRs+hysGxsBT/ZRxVaIZvNfN0obP0lOC+zlOspZRojfrkKFs
	2YKOHLYetTRyjiililv+Nb1n0wyRjYnosGu2XGvHVV8AyO49/5nOkFGtoeAKHSy3aduIdWmBqFA
	R2xAkXoxAVz5okjQOazqln29nh6eP6skEe9OCjM046mNTNBBrw0+TN54oWpx+lh84OkVog9itn/
	TgyeMMKYZwqpnGqBOXppAwlNexTyclWg9lbCYMsKjjg3O3l504HLT17/OOGDcqhS0SdH3fmETzh
	nboUev+BDbb5/0fXBZZRrBuXd7EdocuJXvXY=
X-Received: by 2002:a05:6a21:6e04:b0:3cc:f008:8125 with SMTP id adf61e73a8af0-3da39cffb2amr58878690637.1.1788965881543;
        Wed, 09 Sep 2026 07:58:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e04:b0:3cc:f008:8125 with SMTP id adf61e73a8af0-3da39cffb2amr58878605637.1.1788965881031;
        Wed, 09 Sep 2026 07:58:01 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:58:00 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:11 +0530
Subject: [PATCH v3 04/13] iommu: of_iommu: Add support for "iommu-ranges"
 on a device node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-4-2fe43ae45495@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
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
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965840; l=5846;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=PnyhyXsK/uKdrS8E0sDYZofAuweW5PtRkPRa36gAFh8=;
 b=CIIS85QEWP00CNdqoHfAi6N5Mbyl5OiOTkszOZgBXEba/tiTYSzUYezZrj2BppyysJQtqhy8l
 zqG/sGicuwtAElZEBu1f0O/vxTfn0gZHGJlxA+SSorpfxXzDAbFsqTu
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: yhYRWNVIG48J-9dKboyJ7seHuV_3Ie8E
X-Proofpoint-GUID: yhYRWNVIG48J-9dKboyJ7seHuV_3Ie8E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX0gcXg2wkRxXa
 LMunWCWQAGfoOoLPu4Q13Ucz3Q/WMOZfINchXoK6RKd+d7eUbrttG3TekrL5nw8I0DMLg1nYtrO
 kW2QqwIxZPRaSGtfnQLUSCWe8QfiaIY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX3P6zwtcqDXI3
 ijnr0JH9swSO6do4uaF4Rso5WgVpKm5Us92cNNdGgjXBLLgMdkO/qtQIV+M73Gzf6ur2Oj9v8vH
 EI3pE97ICTSHZAdPkT0PSTyjEoFEKRLjqgNNpkyTTPQsRf1zlxNjm0QyjvbjgPxE2eKMdPq9Ud8
 /ydShxCKFFZJ+0ia4YywfueBQJAw5Ns6+/XiW+Zw7Pkyptw0m7dDn8c1UQOMJFl0pV923gHjLPC
 PDNGLASHe3OOrbDEEu4JiRCSMNkta5umUZ+FNWPf3pEasFB+P7HSuuGFlmyWQcmA6yAt+JMplRk
 zZCgXQENqGiqEB3+yimQ33xtuvZnX8a1YrtB+YX6YmoqtP9gqMycYqeGCG3tS8yKJqGOdU/Yb0T
 jS81dkCB/DNeOACFOW3zCNdcSQThfMEFrtY5P606szk2im2XnxRHs9LkTuMt8l9vOeAFqhOlcEr
 Dhbt2xZ/NMih/4EbaVw==
X-Authority-Analysis: v=2.4 cv=SvWgLvO0 c=1 sm=1 tr=0 ts=6aa173fa cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=5d7BNXMnqyCmxenBVOsA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090167

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

This patch depends-on:
https://github.com/devicetree-org/dt-schema/pull/207

Suggested-by: Rob Herring <robh@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 107 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 100 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a18bb60f6f3dfdba853b6e16dd2a8616f6a731c7..1b014666d6b8ee3beadbd77e2ec8a24459468652 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -190,6 +190,90 @@ iommu_resv_region_get_type(struct device *dev,
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
+			dev_err(dev, "failed to parse iommu-ranges\n");
+			break;
+		}
+
+		if (!length)
+			continue;
+
+		list_for_each_entry(pos, &ranges, node)
+			if (pos->start > iova)
+				break;
+
+		new = kmalloc_obj(*new);
+		if (!new) {
+			dev_err(dev, "kmalloc_obj() failed\n");
+			continue;
+		}
+
+		new->start = iova;
+		new->end = iova + length - 1;
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
+		if (pos->end + 1 > next)
+			next = pos->end + 1;
+
+		list_del(&pos->node);
+		kfree(pos);
+	}
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
@@ -214,10 +298,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 
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
@@ -226,11 +314,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
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
 
@@ -258,6 +346,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
+				if (type != IOMMU_RESV_DIRECT)
+					continue;
+
 				region = iommu_alloc_resv_region(iova, length, prot, type,
 								 GFP_KERNEL);
 				if (region)
@@ -265,6 +356,8 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
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

