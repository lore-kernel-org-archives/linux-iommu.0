Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD74C4332F
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 21:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AE886F4BC;
	Fri, 27 May 2022 21:39:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lb_zdtqNpCrF; Fri, 27 May 2022 21:39:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C628F6F4C2;
	Fri, 27 May 2022 21:39:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06B17C0086;
	Fri, 27 May 2022 21:39:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5462AC0039
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFF9284C05
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-XNk5Hd0TLT for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 21:38:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it
 [IPv6:2001:4b7a:2000:18::165])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F29A84C03
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (abxh119.neoplus.adsl.tpnet.pl
 [83.9.1.119])
 by m-r1.th.seeweb.it (Postfix) with ESMTPA id B24AB20543;
 Fri, 27 May 2022 23:29:36 +0200 (CEST)
From: Konrad Dybcio <konrad.dybcio@somainline.org>
To: ~postmarketos/upstreaming@lists.sr.ht, linux-arm-msm@vger.kernel.org,
 bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
Date: Fri, 27 May 2022 23:28:56 +0200
Message-Id: <20220527212901.29268-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527212901.29268-1-konrad.dybcio@somainline.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-kernel@vger.kernel.org,
 jamipkettunen@somainline.org, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, martin.botka@somainline.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
 Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

As specified in this driver, the context banks are 0x1000 apart.
Problem is that sometimes the context number (our asid) does not
match this logic and we end up using the wrong one: this starts
being a problem in the case that we need to send TZ commands
to do anything on a specific context.

For this reason, read the ASID from the DT if the property
"qcom,ctx-num" is present on the IOMMU context node.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../devicetree/bindings/iommu/qcom,iommu.txt   |  1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c        | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 059139abce35..ba0b77889f02 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -46,6 +46,7 @@ to non-secure vs secure interrupt line.
                      for routing of context bank irq's to secure vs non-
                      secure lines.  (Ie. if the iommu contains secure
                      context banks)
+- qcom,ctx-num     : The number associated to the context bank
 
 
 ** Examples:
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4c077c38fbd6..1728d4d7fe25 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -566,7 +566,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	 * index into qcom_iommu->ctxs:
 	 */
 	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
+	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
+	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
 		put_device(&iommu_pdev->dev);
 		return -EINVAL;
 	}
@@ -654,7 +655,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
 
 static int get_asid(const struct device_node *np)
 {
-	u32 reg;
+	u32 reg, val;
+	int asid;
 
 	/* read the "reg" property directly to get the relative address
 	 * of the context bank, and calculate the asid from that:
@@ -662,7 +664,17 @@ static int get_asid(const struct device_node *np)
 	if (of_property_read_u32_index(np, "reg", 0, &reg))
 		return -ENODEV;
 
-	return reg / 0x1000;      /* context banks are 0x1000 apart */
+	/*
+	 * Context banks are 0x1000 apart but, in some cases, the ASID
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
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
