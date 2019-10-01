Return-Path: <SRS0=VD3v=X2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FD6C352AA
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 22:02:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C60921906
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 22:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaKNLF6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C60921906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F3D522354;
	Tue,  1 Oct 2019 22:02:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9B3C71A88
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 22:02:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D34063D0
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 22:02:11 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id v8so17311919wrt.2
	for <iommu@lists.linux-foundation.org>;
	Tue, 01 Oct 2019 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hteX5Po5jH9mp6pG+BqMJxAmFHZvrUZhbwHbRe2F5fc=;
	b=SaKNLF6hmU7isKtHSAvW2k1hH/JhnGAhRZ7eMLJ66AQnleQcgoCf+e5FeoqeeKFtgf
	GXhqIVMCDJyzp+NYe2NQEJRm0CR41svyJfFQJ1lLdM03q4TWTIzMpPBbP0KHm8DxpLir
	DcnYp5R766EW42RRnTUSDnX+0HTg8c47CVYxIxQ4aKn1EYr09ptMjwYPnQh12U0770gX
	Lw+s64vHKggF4mmJk4Ip0XPcEowFy6lvtn8JCMOBg1sPII4kIYCaOqu7iOtn0Z/8w3rx
	Vl8z1j6oVnoxMetPHBh1J74klpDEpR6y/mGXhFfl6nX/WTCYvvxA0CLge4liKX8Lv8/z
	EDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hteX5Po5jH9mp6pG+BqMJxAmFHZvrUZhbwHbRe2F5fc=;
	b=qXi9pjT3xbUBgnh2/X9kIuQUb+Rhyyknv0JLgKufE1zh4uq3GlzlaSTciVH5Ukk9ax
	Zq5sz/t96dsSDEqZ9Sw20G6H04W8UypZez1H2GDKk73VkjMBT5yAf+blW1vcFgAjji5b
	hJiGHPhAxYbpRW+xwq48Tjl/w0fuPWl63v2FAQUUk48MMSCzjVW7wVtdMKn5UvQbrdfP
	rhirkYBtssToSDHF4GdabUOwvLuBmgwiJ828u2tixmMwzKC8W2LnZ5yaFwlCvfIiqlls
	oZJ7X3+nJB23X2E8Z1h45xLCZot+XXXpF5hPRhf84kAz1P+VC/wgeaAfyB9PcWReV4pe
	sT/A==
X-Gm-Message-State: APjAAAWxnm27bh/gxDuP0v3f0P/ImfZ7eHPyDgqpXBzrQacNBg3GXrpt
	dZth4Dg+22B1DcoNgmgnRL0=
X-Google-Smtp-Source: APXvYqzHW80JeoqBqf3ODbZgwnZ22i7c0iPjee8HOvTf3Qev1Ltnbao5xz6b8sb5eYJMhtBvxA80ug==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr19324573wrj.277.1569967330396;
	Tue, 01 Oct 2019 15:02:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	v16sm21811219wrt.12.2019.10.01.15.02.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Oct 2019 15:02:09 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 2/7] iommu/qcom: Use the asid read from device-tree if
	specified
Date: Wed,  2 Oct 2019 00:02:00 +0200
Message-Id: <20191001220205.6423-3-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001220205.6423-1-kholk11@gmail.com>
References: <20191001220205.6423-1-kholk11@gmail.com>
MIME-Version: 1.0
Cc: marijns95@gmail.com, iommu@lists.linux-foundation.org, agross@kernel.org,
	kholk11@gmail.com
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
index 059139abce35..ba0b77889f02 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -46,6 +46,7 @@ to non-secure vs secure interrupt line.
                      for routing of context bank irq's to secure vs non-
                      secure lines.  (Ie. if the iommu contains secure
                      context banks)
+- qcom,ctx-num     : The number associated to the context bank
 
 
 ** Examples:
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c31e7bc4ccbe..504ca69adc5a 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -585,7 +585,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	 * index into qcom_iommu->ctxs:
 	 */
 	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs))
+	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
+	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL))
 		return -EINVAL;
 
 	if (!fwspec->iommu_priv) {
@@ -693,7 +694,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
 
 static int get_asid(const struct device_node *np)
 {
-	u32 reg;
+	u32 reg, val;
+	int asid;
 
 	/* read the "reg" property directly to get the relative address
 	 * of the context bank, and calculate the asid from that:
@@ -701,7 +703,16 @@ static int get_asid(const struct device_node *np)
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
