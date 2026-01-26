Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655046B5
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430415; cv=none; b=ZMhSm0dGSem5OUGNDO6u/tymRV8Oak796D/lfUUdVlq8FV3oOmmtm9srBQ58BttAoqVt3w/u/JGSiL2jtzXxlzNy712BnzCLx0V13f5HrELlp5Th16WSUKD/u/Io4i6WjCbg1bO2LwRmHu55R2zmsK93oJTFRjy1R8OU8/Y2FP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430415; c=relaxed/simple;
	bh=IqJsRexS/6twiyjUn6Ip0MjRVU5qD6SvEyWdsCIv7Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifvse1uuuZA+IGVEO1gmkxb+YtIl/LZFFuv8hS6s2aDxUkUqg+gEXFM058ZSPaFkOBC+Y8Heua78k1LaaQZp4l0ioMD+ilhrqlUGmpihdDp62Ms/UX40NcSRdTVsTPSbKxp/24/Gsh+QZpYglSHQpBjcnPZadgUvYrvpjjdvxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MKmoR3Gw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JyMgZPmk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MKmoR3Gw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JyMgZPmk"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q8K2is486893
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pVCkh/W6bHIxppZtdEhqPaJQn9q3J1ln2hdlI6R74MI=; b=MKmoR3GwMLta2QG6
	7ouqrxlRyeLGJRWZ1YoNshe9RR2Km53S990v6p0oeNU1f046/1wcci0o4gCkJjta
	xJU8K+/QVcrIniRtpN04e2DmDBtIxveg57oouRcbxnrRy1ATUeCQspKrteb9OmPJ
	6i24yJOk69yw+RdWl8m7G5xq0Iknyf/kIUZ+ymfvMYNNwnxDLmJiUvh7s115dw33
	FGQ0o9eeiK5Qjvw5l/Do5B/ISV9YS2ksI2Nnoof2vw2WOgNaGZjk4s0D4JXkyF16
	OH7uXj7WUDwO96Ywger38BM2RNYPrq9YSgV1Z0lGOv+PlhsiMAPOz6pGfzQXM2bD
	oPJ2zQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9f4f55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6310f81285so6295815a12.0
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 04:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769430407; x=1770035207; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVCkh/W6bHIxppZtdEhqPaJQn9q3J1ln2hdlI6R74MI=;
        b=JyMgZPmkayeR9H8udeqRtq+UzjFh/Nik/vU7uEu60XOJsCfVoXq6uzOV/l83QGOAW+
         lQj7pcwsFzgsfXn/KSCgwJuG5o2h2dwhyO5/BSg+2YomGa7RJLMVV1cbJw5otVbvvzL9
         5V+hGVreM4bsKeWtFYh+QZVcxSRqKjg0F7Zcl/HHsrmUxVl+FoZT/S8ESBB4ExWR9x7j
         3gNAog2/g8Im6YCL5tWeMPdQQXYrux78kDZ7zrft9rHxIVN93ecWqWi90GYTf+wNp4Pw
         X7mub32pJXLDVK+7o5jVA9IMcuUEHlFylAekvDzoPxzGLjp2W5jguP4uVn3xklYuW1kI
         OUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430407; x=1770035207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pVCkh/W6bHIxppZtdEhqPaJQn9q3J1ln2hdlI6R74MI=;
        b=B8qBPNTCHSiXVVdms09uyHXS+w0zFPjdpFrSkD16Vi1efFhT/iK8YCclKF6CpIcIes
         ds4M0HuNuIpu+bZByUjeN//1wvGH9t4OxAeEkBP/V8CAthVvrGPPcSQpuwSF/DLKfyOg
         7cB1i4FyGsnjXOZf5wla4kfiVrBB8eek8HNgzVPj7MpwnWVcNFMPvzdf6tErkMNEKea+
         7UOh3bVEyDPrr1yvjJb3EyI6acqKm1Ksy89NQBIvQrpOWX1OY2MrmlFV3hVTdkBXwSQ0
         54rj31ElfdIUKGmDtZqZIQ1llG02xe0Ziy/migL1nBckEFUzwj0DPJ5anj3+aD+t/8EV
         LQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUrKYw+XxYXaGlIqZCagBx8aOjBKyqKM7yDlhbzahHewpqkhfivCjh15E8WQLNFm3prn8geZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQkLCtAfuFKLEUNspZCqSI7rF2DgCu5PbrQsNqfTvp3G58kiRA
	bYMWnu+1ovhAR7CmXBDkdBxCeunIxErSpxfXvdI1UswT4yry9wtGosT0dpCf4Hs99+hJd8tPmUe
	GfuZyQWoA7p2hek+wFkX9VltTTFmhceZWpgJbagb1MyhCzt3H1DbvuVbF6w==
X-Gm-Gg: AZuq6aI+88wepi5zQEjfGzqqxGrOwtPenphLtOx4UWD6pP7NabwEFZUZdWkXRSGs+SZ
	oqc/aRzCY7hLUx7JqOghpb+iBFxgUS1H992KyRCwhAc1kCsFH8NBBSkG69nmpK/e7uJF8pAuK+G
	iKDcF5gff5c9lGudGyZhfZo/63trxrj2/gvzh1Ck6yrwByvDIAtJpaJpPXuQtpOuIHDB6wpFkzR
	fzHL4V7FxmrxRdmJC3Pi9baDYroCebAVULbAmxExJX+urj1L1aDdN/1SIEYzxgfCXxl1XemWKgl
	I18WNjCnr/g9jPx8wU07BmMdYJl53iEy1GRLYueEESXBv42ZG1dAZfbvDh2a9vkwSpY0x5BWJKF
	SFLzgChdqq4uZ3WnE0NtHUDRxQr7aS3V8eHzyGUG8vSu4
X-Received: by 2002:a05:6a21:9082:b0:38b:e944:3e94 with SMTP id adf61e73a8af0-38e9f2853c7mr3680246637.39.1769430406961;
        Mon, 26 Jan 2026 04:26:46 -0800 (PST)
X-Received: by 2002:a05:6a21:9082:b0:38b:e944:3e94 with SMTP id adf61e73a8af0-38e9f2853c7mr3680213637.39.1769430406447;
        Mon, 26 Jan 2026 04:26:46 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6366644379sm6076022a12.33.2026.01.26.04.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 04:26:45 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 17:55:46 +0530
Subject: [PATCH 3/7] of/iommu: add multi-map support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
In-Reply-To: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769430381; l=6265;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=EUkaNWa1MVcCxEdOynQtZlG6RF2qb9JysfZNRjrcwmA=;
 b=hkULUopyIT1ZocwCpTifqAIj8RNy7i9ZYw7+k3+dPNzOWShp4cRUCIJ1vuWPWmD/tBaRW/bhO
 vogZYGvX3WIDylxFZDGanvOPh9o6JBGQqHrETtLMF1xhjZwksaFX4s8
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=YLGSCBGx c=1 sm=1 tr=0 ts=69775d8b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=vJTt6mY4ybVYvk96TFUA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LYZOra6MFMiHc0YsytKSMl9g1hBsvN0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNSBTYWx0ZWRfX57KT1M/Arcpb
 pUymLCHYhOkDGDmlYa0DdH+2v2WKLJOMVh7A3ULO7CHsoWqQSQSkojnuRwhOw0F55qyBCuP4sve
 oT/GieL634NE/wVtRqVlvgWrni0wHXcYUoe43ISOKKjGTkO94mH1+gIU2uF1DOzDX8dfwWT0Zv+
 ZDz5Xzm6F54uY0OjATvAFUA5ctzG2FZ9psALtNhOdvv0i9ILLL0mwm2AhIt8DaXmVFbq0eWajBk
 TawjfzB8Yjqq0v6XVPG3XdGdtXZ7x0mVpEbTAVBtfRXKZBZCWMwa1x8OvwEXdue44PWV6mtOEvt
 9+1nMEmTS7f7CN1WBzzgXyemu5pmWUrq1rQXjesjvPXzRz3TxqyZNHP/A0e+zURvg2NzliDBZPH
 kpzq2esoiAzVBHbkp+ACD9MEY9Wv0wdPrYVKSeySrZKQT2kFM2MZingIGdZVN8dFiFB97eEI+dF
 qKaSRkQCi/PxNCOjtWg==
X-Proofpoint-ORIG-GUID: LYZOra6MFMiHc0YsytKSMl9g1hBsvN0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260105

From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

When multiple mappings are present for an input id, linux matches just
the first one. There is a usecase[1] where all the mappings are to be
maintained in parallel for an iommu-map entry of a same input id.

Whether multi-map is needed is reported by the callers through the
callback function passed, which is called for every input id match.

Since the requirement in the usecase[1] is for platform devices, not
sure if it is really clean to maintain this decision on the bus type at
the of_iommu layer or further to be from the respective
iommu_driver->impl_ops().

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 36 ++++++++++++++++++++++++++++--------
 drivers/of/base.c        | 38 ++++++++++++++++++++++++++++----------
 include/linux/of.h       |  6 ++++++
 3 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 768eaddf927b0700b2497b08ea21611b1a1b5688..067bb2298973671e1eaf01bb2ea52df3d2a52a44 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
+#include <linux/platform_device.h>
 
 #include "iommu-priv.h"
 
@@ -41,22 +42,41 @@ static int of_iommu_xlate(struct device *dev,
 	return ret;
 }
 
+/*
+ * Callback to be called from of_map_id(), that tells if
+ * all the mappings for an input id to be maintained in
+ * parallel. Should this decission be from further layers,
+ * iommu_driver->impl_ops?
+ */
+static int of_iommu_configure_cb(struct of_map_id_arg *arg)
+{
+	struct of_phandle_args *iommu_spec = &arg->map_args;
+	struct device *dev = arg->dev;
+	int err;
+
+	err = of_iommu_xlate(dev, iommu_spec);
+	of_node_put(iommu_spec->np);
+
+	/* !iommu_spec->np may be from the bypassed translations */
+	if (!err)
+		err = (!arg->multi_map || !iommu_spec->np) ? 0 : -EAGAIN;
+
+	return err;
+}
+
 static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     struct device *dev,
 				     const u32 *id)
 {
 	struct of_map_id_arg arg = {
 		.map_args = {},
+		.cb = of_iommu_configure_cb,
+		.dev = dev,
+		/* Should this be pushed to iommu_driver->impl_ops? */
+		.multi_map = dev_is_platform(dev),
 	};
-	int err;
-
-	err = of_map_iommu_id(master_np, *id, &arg);
-	if (err)
-		return err;
 
-	err = of_iommu_xlate(dev, &arg.map_args);
-	of_node_put(arg.map_args.np);
-	return err;
+	return of_map_iommu_id(master_np, *id, &arg);
 }
 
 static int of_iommu_configure_dev(struct device_node *master_np,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 606bef4f90e7d13bae4f7b0c45acd1755ad89826..a1c3c5954ec7e8eb3753c8fd782a1570f9eb9c17 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2122,14 +2122,21 @@ static bool of_check_bad_map(const __be32 *map, int len)
 	return true;
 }
 
-static int of_map_id_fill_output(struct of_map_id_arg *arg,
-				 struct device_node *phandle_node, u32 id_or_offset,
-				 const __be32 *out_base, u32 cells,
-				 bool bypass)
+/*
+ * Fill the id_out and target for the of_map_id() caller. Also
+ * call the callback passed to the of_map_id() as part of the arg
+ * that decides if to continue further search.
+ */
+static int of_map_id_fill_arg(struct of_map_id_arg *arg,
+			      struct device_node *phandle_node, u32 id_or_offset,
+			      const __be32 *out_base, u32 cells,
+			      bool bypass, bool *multi_id_map)
 {
+	int ret;
+
 	if (bypass) {
 		arg->map_args.args[0] = id_or_offset;
-		return 0;
+		goto output;
 	}
 
 	if (arg->map_args.np)
@@ -2145,7 +2152,14 @@ static int of_map_id_fill_output(struct of_map_id_arg *arg,
 
 	arg->map_args.args_count = cells;
 
-	return 0;
+output:
+	/* pass the output for the callback, callers may further decide */
+	ret =  arg->cb ? arg->cb(arg) : 0;
+
+	if (multi_id_map && ret == -EAGAIN)
+		*multi_id_map = true;
+
+	return ret;
 }
 
 /**
@@ -2179,6 +2193,7 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 	int map_bytes, map_len, offset = 0;
 	bool bad_map = false;
 	const __be32 *map = NULL;
+	bool multi_id_map = false;
 
 	if (!np || !map_name || !arg)
 		return -EINVAL;
@@ -2264,23 +2279,26 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
 		if (masked_id < id_base || id_off >= id_len)
 			continue;
 
-		ret = of_map_id_fill_output(arg, phandle_node, id_off, out_base, cells, false);
+		ret = of_map_id_fill_arg(arg, phandle_node, id_off, out_base,
+					 cells, false, &multi_id_map);
 		if (ret == -EAGAIN)
 			continue;
 
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
 			id_len, id, id_off + be32_to_cpup(out_base));
-		return 0;
+		return ret;
 	}
 
+	if (multi_id_map)
+		return 0;
+
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
 		id, arg->map_args.np  ? arg->map_args.np : NULL);
 
 bypass_translation:
 	/* Bypasses translation */
-	return of_map_id_fill_output(arg, NULL, id, 0, 0, true);
-
+	return of_map_id_fill_arg(arg, NULL, id, 0, 0, true, NULL);
 err_map_len:
 	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
 	return -EINVAL;
diff --git a/include/linux/of.h b/include/linux/of.h
index 9efa6f93712c6024f05476f9fd39f3294f942ec1..abab73a76682351f5635c1127a6c899917525050 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -25,6 +25,9 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
+struct of_map_id_arg;
+typedef int (*of_map_id_cb)(struct of_map_id_arg *arg);
+
 struct property {
 	char	*name;
 	int	length;
@@ -76,6 +79,9 @@ struct of_phandle_args {
 
 struct of_map_id_arg {
 	struct of_phandle_args map_args;
+	of_map_id_cb cb;
+	struct device *dev;
+	bool multi_map;
 };
 
 struct of_phandle_iterator {

-- 
2.34.1

