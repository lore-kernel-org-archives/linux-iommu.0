Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C5BFC6198
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F442178F
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJH028lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F442178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AC28DE0E;
	Fri,  8 Nov 2019 15:26:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2CC51DE0
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8A9A2196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:51 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id i12so584621wro.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 08 Nov 2019 07:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=SJ0pi6TcxZ7peU2M0iysnkfrxFwiFSB7n/XBu4wivSo=;
	b=FJH028lD8udbYUj9HmW9HX+1pehY+1lWWRbuMjmApuHYEIKQLcSg0vICaIv4+60xTP
	SZObRA6SwQO9RwBVxZugqTUZI+vA8BvgqNj052zrmBwRHwWzaojQtHWRGbFCtztastzr
	pmnt/WYGWHFKd5AIcAMo8pJ6oAExUKnBYXeKVhe6kKjq+nXxzRdtnQJqvWgIRIrK+0ku
	4w7Dv2dYtYuKDn+v92hj11WbpQkpItAZUnzsJTk2q+ms3DMjKlct9veZzcMJgZOs9qQH
	iADkZLXOARDNATZhqDbKKo0FVoWdnh6jiRIOlQnG9iluhoxnk9D5UjR8R2mtDUOOVWdC
	O1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=SJ0pi6TcxZ7peU2M0iysnkfrxFwiFSB7n/XBu4wivSo=;
	b=pmfBCTRBvJPjrm+YqdChmlOJl8L5/MIhNtCNy8HOujTQ2b2WjLdEZdsHo4wfto/bBS
	u/VlhX58xvOlnCagyI4THNSYAgWlDc78ljnW2eXh3Yf6X+g2FOuBRxzu8YW9prOysQm4
	FAtVxMKUBgQJfvdbawFxOBfQDYFfWw2h9OXwf9CVAxbEpCfHS0rbKcBOP41FBlGM5IBq
	a7TM4U2YAAf0BfmjVHmVD0SbdbbbG90pnxv0CDq8CtjlUZokmK4S28vWX2KTna2LiKfR
	NACuWa2UFGt2e1C+ukDch1BgNXMh2n0QqHJNXUJmEcP1Src1i5gbwR4byQj6Cs4L5FTT
	CfMA==
X-Gm-Message-State: APjAAAXf4b3n+fJJaa4WjUdZgpE/TRlR29eV4z/xd+4juQZ90WxcAoVI
	Sz6rJE/qie2k/sNLZvaCAD9DQ8OkipH+8g==
X-Google-Smtp-Source: APXvYqwyU++SQOEON9veNpljNNQZ0DLUXxBMuURhZ+hXhsR0MUMzQbS2imzKSghHCvbQFiMGMII/Dw==
X-Received: by 2002:adf:edc5:: with SMTP id v5mr8967125wro.322.1573226809763; 
	Fri, 08 Nov 2019 07:26:49 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id
	w18sm6579232wrp.31.2019.11.08.07.26.48
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 08 Nov 2019 07:26:49 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/8] iommu/arm-smmu-v3: Support platform SSID
Date: Fri,  8 Nov 2019 16:25:02 +0100
Message-Id: <20191108152508.4039168-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
	rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
	zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

For platform devices that support SubstreamID (SSID), firmware provides
the number of supported SSID bits. Restrict it to what the SMMU supports
and cache it into master->ssid_bits, which will also be used for PCI
PASID.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 13 +++++++++++++
 drivers/iommu/of_iommu.c    |  6 +++++-
 include/linux/iommu.h       |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8da93e730d6f..33488da8f742 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -292,6 +292,12 @@
 
 #define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(51, 4)
 
+/*
+ * When the SMMU only supports linear context descriptor tables, pick a
+ * reasonable size limit (64kB).
+ */
+#define CTXDESC_LINEAR_CDMAX		ilog2(SZ_64K / (CTXDESC_CD_DWORDS << 3))
+
 /* Convert between AArch64 (CPU) TCR format and SMMU CD format */
 #define ARM_SMMU_TCR2CD(tcr, fld)	FIELD_PREP(CTXDESC_CD_0_TCR_##fld, \
 					FIELD_GET(ARM64_TCR_##fld, tcr))
@@ -638,6 +644,7 @@ struct arm_smmu_master {
 	u32				*sids;
 	unsigned int			num_sids;
 	bool				ats_enabled;
+	unsigned int			ssid_bits;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -2572,6 +2579,12 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
+		master->ssid_bits = min_t(u8, master->ssid_bits,
+					  CTXDESC_LINEAR_CDMAX);
+
 	group = iommu_group_get_for_dev(dev);
 	if (!IS_ERR(group)) {
 		iommu_group_put(group);
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..aab63e9f283f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -194,8 +194,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			if (err)
 				break;
 		}
-	}
 
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (!err && fwspec)
+			of_property_read_u32(master_np, "pasid-num-bits",
+					     &fwspec->num_pasid_bits);
+	}
 
 	/*
 	 * Two success conditions can be represented by non-negative err here:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f84fe76f0eea..0a3d9c3c368a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -576,6 +576,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @iommu_priv: IOMMU driver private data for this device
+ * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -584,6 +585,7 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
 	u32			flags;
+	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[1];
 };
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
