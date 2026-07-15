Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A2374A1D
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124634; cv=none; b=VNFi5nns16Ox5HiTfdezUV0XMawqLoIvXxyDvS4VWMWubsnKPAFFolPdSjTYUbdmj6QQ7BxKL5iUw4O1NqbA1HzlqkG496vGNll4zclKaUEqyT5YzszUXfWgMxa8gZChnhq4YO8epZMqpMEiUfXwBdmw9VesqvfqRR12fwEP1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124634; c=relaxed/simple;
	bh=Z7a+KeKlfsd6hODeCUGUk5GwLjPusVx49RSzZ6ytvIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OalqL3aU71WQbd4VcxTYHpqa8EzRzEJ0zwXa3y1TuXDRkfhr0Pp32Mgi5LsauUGIHDNu9kU177Hqe/ciWG6wXhC54rzLdNH2ZpPp4GRdyr5sFPwNfdRTBYtHuV5jpy/Sfk8+KIHBGmFvVNxxQImT1NLyVfdst6RsFepGKPcwSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V8vZWrnI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LFwvpzYz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8vZWrnI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LFwvpzYz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FE3SnR3805955
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rccCrQapLXpGKmzhslQnhMFu7V0TczQtmSRgtHbcpXA=; b=V8vZWrnIY8F4lR2l
	4RXYe33gqTTTrtUP+tiuXZlpBjph2VhscMKCWaapZJ2KySvfQestzd5W1+h8zPrv
	4cYbFWIoxSCnB7FWK6k2vnQ1bzKvg3xkfgkzlxpgGimqBoWCy4kgv/HuuKzgUaFB
	xm8R1Asdb/h/P0/hHzAIUCQKRvULIBj7V+YOTpyxS46AZRVfFo8WY8EDStIm2x6N
	S2yuD51XFbnh4oUcFb13FEIBoqTwIfFIcN3pYgKI1bor78fyK+vHV4gJ/SkUDF6i
	PlfFsRb76cL/D3BWL0Gi5lFP30I24zadIYEWMRY0VEyOlGyLn+rA2UGAgwrzRyD/
	KErCrg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9g40uu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:10:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so34865575ad.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784124631; x=1784729431; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rccCrQapLXpGKmzhslQnhMFu7V0TczQtmSRgtHbcpXA=;
        b=LFwvpzYzjEALPY12XaWlrqjt8zKI5BGFrIMUOx509vg5IfqUR6sCJxOoZ8cqzqL/Y0
         C0F+KVgR4JPs1AegaJ5oqUrEeoec46Tj+OFI4IOREc6vN1nH14xdi2h+n5m71EfD+MNn
         VgMArxCFrYqfovoimqd9aOMVU921lSZXHB1DFjRjM5WIfzzU/djNWXtKZ+/XGf71vG9E
         yicgcxBywKZ4AP8siBkU9waaZswbAvAvzXNsbqNff3j1VEiGLKolSM8nRqXTC40CZcmS
         4VF7+JJcpe/Oq8KjCW0heZxRJdKJvot0g+21n2sCz6Ywdx5jInOjfPrsbHVzAaHJR4ov
         snXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124631; x=1784729431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rccCrQapLXpGKmzhslQnhMFu7V0TczQtmSRgtHbcpXA=;
        b=dqUnEXOIC6B3dS6H9Y2ny6mm9piUBQuRsznVgUmYJA9floB358o6Px4oC1oKl2aVpq
         ogcLLFiRLP+DlJcY/vFZjlzsATWSnvKsIqJr//wB2mvfUZ4FBF2FClpviAUG1oiSTe9R
         LCcFjCRAWhSNqMhFECtN6TVrXyOOILAG0KN/RNdS0pbHu4hrlfBncm3wNKUzafGZJTOv
         nhmO4Ij6Twe+RQOWmcWNWInsvlTZvZnylB4AypvWRmCWt3mJ1jtFbkh60nsBEFU5ITbr
         NXK7C8ui8+xGMyREVBirp6NDSX6pWUUMywfE6UcftYOVTMLSwp/4H93Dt7ntNcfLM962
         +BjA==
X-Forwarded-Encrypted: i=1; AHgh+RpHKXZL33QqL0VVa6TQpTaoQ08WufpEs445G9EIFzC8FbgCUuu8xYBYvKtJBQ+1IVG4QKYTvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yztw7W1Q1xZ4OQ9m3qcAxJfpOiz5dGXdEF6/rNfwVEyiQXYCjrJ
	/+GhDLNgs/242X8N8IuFeQFzZ6FSCDm2/VCfLCLncbwZiC3CPiW1mS5Ql39gZzJqZlb5f2fjYim
	fVg9n99+qF4G7gUdCIY1pUbSb3H5RZP4JD6Q7y0IzYFOu4bFv5XcsCCIULA==
X-Gm-Gg: AfdE7ckk5Us8YL56EzC6wKYmWizCe3RcwqwAzWAuhk7AaZRwGImsC2sLnQblcbraFIY
	vh6E+lnhR2PzmEkGHhn8qsaatJ6En7Vl5ZRRDsfjHoEUkUaGbUwqJTwJoc7hWyv/LMP3Z8U+RGK
	ELdQlp63ePPJPTdXnIf9eHRpxv+7+xQxiSZDQbxy79Pn3ee62utaS3H0dEmZfugUjsgn20Dk+Si
	6KN58+RMT2GAHMdcHoKJw1wjBkWHwFrPdYNm6fijSOHbt50sMrNdc4nHJK+w21p+6gLC6+3MAyC
	7jKjoMCmsFzvpLX0MlJlNhlVH+J1qy5oFkRSfx8On/2y7myNLrDrywxsTRN4LVOei/awpLcf2P8
	5WiNtZcZDSTWOEhlf0ta3Zsh0YeOvlaLWmq4tpndLjB10
X-Received: by 2002:a17:902:e542:b0:2c9:d277:2cdb with SMTP id d9443c01a7336-2cea16fc0cfmr159083975ad.9.1784124631161;
        Wed, 15 Jul 2026 07:10:31 -0700 (PDT)
X-Received: by 2002:a17:902:e542:b0:2c9:d277:2cdb with SMTP id d9443c01a7336-2cea16fc0cfmr159083485ad.9.1784124630603;
        Wed, 15 Jul 2026 07:10:30 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1070b68dsm2913215ad.79.2026.07.15.07.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:10:30 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:39:57 +0530
Subject: [PATCH v9 03/14] media: iris: Add helper to create a context bank
 device
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-glymur-v9-3-8cf2cbe12a07@oss.qualcomm.com>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
In-Reply-To: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784124602; l=2769;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=YR+PjYPX5zksaKJC/NvxWsdFNoGva+12VxA4G3rAknc=;
 b=bD+EReDXs3o480Zk1OghwCSx7mBFpmiw7ZRkROj5f0g9INqbdS/VO/svLYrOaoh2nS4yIFN8Q
 YyPxQHza2wWBJsxxNDlMSwHuKqIMINy0LMsqXjZJTzA0fcQDQJhWmW7
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfXwHBVyUTStFac
 x1FFonbJ7jUUSuLMKXlDrYSvgApZkDWeTPp817i1Ijt+655GjrppVl1/DkYXswxDRoiVEoWPKNK
 SrtzeOV2NLCpndJOzAvUyBeWcgGE1oY=
X-Proofpoint-ORIG-GUID: JU2f4i2oKc4lqA7U-dUHc0gXCFvv4Jmc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX/8Mifag6CStN
 glUVyQcxsFYtGCsl1f5G4d5k1Iay1ekjWnQL6lwyHan4un9vXV6saITni7zrY2ghHlXO4+94m1a
 stSYdqQH+Z6EuZjKHHSksPu92ntx+GL9IgZ/AOU1K/9QipHUUHpaWyBb56vDB1QIpP4qrv2TG+6
 qAQ/qjlpDlLDUXOESyKnNsNThF9be02P2jm3C6FwMBx+jK37KN9eN+r6PIXYX+ReDOQIUpzvcm5
 bzkdCs+DlOMYnaM6g9kluYNKbI9sRarvvtBS1xAHUWudhhrmAjNxTEMschTy003BaM/qHIKjBBR
 tyV6N3sVlry0RNRzjlmW7ON99ZQY/1VFvo3tHOxtt64Oy+YMpXEwwqfpbRoD1APFrCNPJDaRZwr
 BwwcLDKvHZ9AAE6jB+LQLCrYu0OlofBJSFN7yjiIzk3bz5c124WUxrO9Itubw/DCJoNDGOQzxna
 LK8fxJMI+zx1pqJir5w==
X-Proofpoint-GUID: JU2f4i2oKc4lqA7U-dUHc0gXCFvv4Jmc
X-Authority-Analysis: v=2.4 cv=VoATxe2n c=1 sm=1 tr=0 ts=6a5794d8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=11-_c5lL_m6SPrwGrosA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150141

From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

The subnode in the device tree is registered as a separate device so
that it gets its own IOMMU context. Pixel/non-pixel buffers are mapped
into these iommu domain, to ensure they are within the addressable range.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Tested-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/media/platform/qcom/iris/iris_resources.c | 28 +++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 773f6548370a..a685915a19e9 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/devfreq.h>
+#include <linux/dma-mapping.h>
 #include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
@@ -141,3 +142,30 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
 
 	return 0;
 }
+
+struct device *iris_create_cb_dev(struct iris_core *core, const char *name)
+{
+	struct platform_device_info plat_dev_info = {};
+	struct device_node *child_of_node;
+	struct platform_device *pdev;
+
+	child_of_node = of_get_child_by_name(core->dev->of_node, name);
+	if (!child_of_node)
+		return NULL;
+
+	plat_dev_info.dma_mask = core->iris_platform_data->dma_mask;
+	plat_dev_info.fwnode = &child_of_node->fwnode;
+	plat_dev_info.name = child_of_node->name;
+	plat_dev_info.id = PLATFORM_DEVID_AUTO;
+	plat_dev_info.parent = core->dev;
+
+	pdev = platform_device_register_full(&plat_dev_info);
+	of_node_put(child_of_node);
+	if (IS_ERR(pdev))
+		return ERR_CAST(pdev);
+
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
+
+	return &pdev->dev;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index 6bfbd2dc6db0..ca53c01f60ae 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
 int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
 int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
 int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
+struct device *iris_create_cb_dev(struct iris_core *core, const char *name);
 
 #endif

-- 
2.34.1

