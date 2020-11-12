Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD18C6369E
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4893721D7F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uA63WGlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4893721D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D17F787094;
	Thu, 12 Nov 2020 13:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4yiTMse+Smtf; Thu, 12 Nov 2020 13:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68AA4870A3;
	Thu, 12 Nov 2020 13:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49359C1AD5;
	Thu, 12 Nov 2020 13:03:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE7E1C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A99FA8708C
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3B0k33j-Slgv for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:03:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A469E8703D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:21 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id s8so5888671wrw.10
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 05:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3ygm1AXTLu+53w4Gri7BYEJbuhvyMFezCUVbiVOA1cI=;
 b=uA63WGlRDXWDF9rIZV4RZkVq6oJU37wcFuSQmD8BzO159BANMh6M+qpRZeX3/9SDUX
 NgjC/6kMJoth33QcDclO+ynaJlZA5DobFNRQNYs96uO5BecxpNBWMkORbZcRWO5P6qD/
 BJkF/jlsL/X45r34/KxlPQbUjbKshwp4elCUfaZGnESVEwpxokGBOQy9Uvj/8ap3OCIH
 X4XkbC3JjCUSG2bj/0UjM+bplVf6wDID7rR7qluxsv54s4WElIx8dWnQLCnODfH4+4TN
 1fQtFlyLdLdG2hhM+mcaKhRK/XdUJ1cFPfj1ecKiWJDeJr3prD0gWxlUnB4H0tf5eUhK
 2bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3ygm1AXTLu+53w4Gri7BYEJbuhvyMFezCUVbiVOA1cI=;
 b=ONNaN2qTBvoya5Ll0r+ql8WTAEXpV9n5BkmcBE4Ze8CQgM8wm3Y5Olepkb0qF0IjTN
 lCqw/LYgiJyQwgvgkJJ4jqt5xy0zLT/79CEs1zeKz/WFME9mBOXA0Bt+vAzNvgGsbIm1
 f/DYL4cpD/BJ8ZyKgUGIqCXjt+lFnWySPkdxoipXz7lPWpONMAijNXlD4H+qPWX6dpj0
 TPeFfKRXvAaSvuc2a2oyxZrFp9EooAejGfQFxGZR1tkABEnCt2hIaQRM7W9J4cMsyqxV
 d3PS2dw/LnofClAqfHED9rosNK/zVRNa+mn8KF5QL8mygLmf9XUY96zfcqB6JnZr5wOw
 IS0w==
X-Gm-Message-State: AOAM532j6c0iRzVJiRhkEFjFArHcIOZ9yld0mYYAb4689ox1xvGTTiDy
 GDJHZsrNiS44oHtNN2N3oS+ANw==
X-Google-Smtp-Source: ABdhPJz9bTvkN2/dsnznhn0qkGq1x4rrRxxckt9ZNtviWKF6XljTnBbloojb2RmpNHrLbr6LrtRoPQ==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr30481293wru.345.1605186200191; 
 Thu, 12 Nov 2020 05:03:20 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 05:03:19 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
 robh+dt@kernel.org
Subject: [PATCH v8 4/9] of/iommu: Support dma-can-stall property
Date: Thu, 12 Nov 2020 13:55:16 +0100
Message-Id: <20201112125519.3987595-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, guohanjun@huawei.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, vivek.gautam@arm.com, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

Copy the dma-can-stall property into the fwspec structure.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h    | 2 ++
 drivers/iommu/of_iommu.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1c78c4cdeb1..9076fb592c8f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -572,6 +572,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @iommu_priv: IOMMU driver private data for this device
  * @num_pasid_bits: number of PASID bits supported by this device
+ * @can_stall: the device is allowed to stall
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -579,6 +580,7 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			num_pasid_bits;
+	bool			can_stall;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b9130a1c..d6255ca823d8 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -212,9 +212,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		err = of_iommu_configure_device(master_np, dev, id);
 
 		fwspec = dev_iommu_fwspec_get(dev);
-		if (!err && fwspec)
+		if (!err && fwspec) {
 			of_property_read_u32(master_np, "pasid-num-bits",
 					     &fwspec->num_pasid_bits);
+			fwspec->can_stall = of_property_read_bool(master_np,
+								  "dma-can-stall");
+		}
 	}
 
 	/*
-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
