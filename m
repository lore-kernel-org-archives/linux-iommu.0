Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F87C4360C
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 12:28:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B65207FF
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 12:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3QJp0Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B65207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2F5081235;
	Thu, 26 Sep 2019 12:28:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7122C1184
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 12:05:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DDEAC8A
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 12:05:21 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id v8so2471118wrt.2
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MOsVaiINRsQWi6qw1udz6Ri8temeMMS+LWwbQK7C8b8=;
	b=Y3QJp0WsN3oMzWiNiQaGbg0PlhKzNmGO4xOJsBPQzCTBrhcy2Fxu0zkMteZG0XCt7F
	AB77+7fPlGCtsSVdS9KOBWPZD7ydTbFUMv3/mz9i2B1ixi3p+avOkBhHycZI5ZU5bYBV
	uSD09cUlmKKcUgbMaYeEDqr0xP7HbIPh5/EUAfJJqiEtx0Ci/sPafM2Yl7aAYKVZ1ACz
	Q1HN6b6X/yVRWIdU8P68lPbmDJuvoHXRUHPp+Ucoe0XbfJdFqJn+9y/WayoWcxlo/jYg
	3qDaQ5yLId4OhHLGlfAKi1eO5gfebPhpcNukRPR1qkrP/5/V9QL7/y0Az4lHE1Fnm3Kz
	x3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=MOsVaiINRsQWi6qw1udz6Ri8temeMMS+LWwbQK7C8b8=;
	b=IHhyN1gblA4JBCwDU5EMFD28URH5S0WM3Ewdu4Sxwq3avR9ibyoaYaHby0LFqq9l4+
	4jw0omFH4UkQAE3OQ09RrE7LBaoasvm9P1jLedWmyZW2LOA93By/hfjru7+Ynzdq6oan
	o5828IukHeq1ueWBjz61VVgHH5GSOfl0Ib1rRNmNTlgXRFl4AMwBd7oQYQQd+Tyc9USp
	w6SOlBj/bO4e8Uz/7eQcWhrd2XsjyurES/i7rtlvTF2K2L3HOL+Z9ZfLkMw2749i57Th
	tZOn+g4173E7F4/0bJvQOVVlHDlZwEvorc68OI6U9CR/hsV08SdNfdL7nOitByElZBhb
	q5OA==
X-Gm-Message-State: APjAAAWlU3UYQR2sKsohzCa1ModHNd4U/AANV8dLqlr+7QCCto+DASH/
	bFTz6yRTh6BWN+sydQnyTwo=
X-Google-Smtp-Source: APXvYqx7wD+ZGQZkH/FkOlgTDQOFFXVBpRCAr3zs2vWK/gYIxmLmVH17JL+DgYXfDGR43YDUXPPLLQ==
X-Received: by 2002:adf:f081:: with SMTP id n1mr2904579wro.273.1569499520399; 
	Thu, 26 Sep 2019 05:05:20 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	d193sm5289584wmd.0.2019.09.26.05.05.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Sep 2019 05:05:19 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
	specified
Date: Thu, 26 Sep 2019 14:05:11 +0200
Message-Id: <20190926120516.4981-2-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926120516.4981-1-kholk11@gmail.com>
References: <20190926120516.4981-1-kholk11@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 26 Sep 2019 12:28:08 +0000
Cc: marijns95@gmail.com, iommu@lists.linux-foundation.org, agross@kernel.org,
	AngeloGioacchino Del Regno <kholk11@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

As specified in this driver, the context banks are 0x1000 apart.
Problem is that sometimes the context number (our asid) does not
match this logic and we end up using the wrong one: this starts
being a problem in the case that we need to send TZ commands
to do anything on a specific context.

For this reason, read the ASID from the DT if the property
"qcom,ctx-num" is present on the IOMMU context node.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 .../devicetree/bindings/iommu/qcom,iommu.txt    |  1 +
 drivers/iommu/qcom_iommu.c                      | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 059139abce35..98102b323196 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -38,6 +38,7 @@ to non-secure vs secure interrupt line.
         - "qcom,msm-iommu-v1-sec" : secure context bank
   - reg            : Base address and size of context bank within the iommu
   - interrupts     : The context fault irq.
+  - qcom,ctx-num   : The number associated to the context bank
 
 ** Optional properties:
 
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index dadc707573a2..5837556af147 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -557,7 +557,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	 * index into qcom_iommu->ctxs:
 	 */
 	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs))
+	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
+	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL))
 		return -EINVAL;
 
 	if (!fwspec->iommu_priv) {
@@ -665,7 +666,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
 
 static int get_asid(const struct device_node *np)
 {
-	u32 reg;
+	u32 reg, val;
+	int asid;
 
 	/* read the "reg" property directly to get the relative address
 	 * of the context bank, and calculate the asid from that:
@@ -673,7 +675,16 @@ static int get_asid(const struct device_node *np)
 	if (of_property_read_u32_index(np, "reg", 0, &reg))
 		return -ENODEV;
 
-	return reg / 0x1000;      /* context banks are 0x1000 apart */
+	/* Context banks are 0x1000 apart but, in some cases, the ASID
+	 * number doesn't match to this logic and needs to be passed
+	 * from the DT configuration explicitly.
+	 */
+	if (of_property_read_u32(np, "qcom,ctx-num", &val))
+		asid = reg / 0x1000;
+	else
+		asid = val;
+
+	return asid;
 }
 
 static int qcom_iommu_ctx_probe(struct platform_device *pdev)
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
