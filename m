Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6482C3276C
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C48124685
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgEdguI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C48124685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 62F7987F9A;
	Thu, 19 Dec 2019 16:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XFKKRBvGfT40; Thu, 19 Dec 2019 16:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0F85687FC3;
	Thu, 19 Dec 2019 16:31:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08F76C1AE8;
	Thu, 19 Dec 2019 16:31:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3007C1AE8
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8E9DB86FD3
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbVRjzIrsjKg for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 16:31:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CE42686FFB
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:31:35 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id p17so6299662wma.1
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=en1Diu3sI6Wm13W9qcASbGXcjcSPf5WXodRzGlHYYvg=;
 b=dgEdguI1vFCV7YNVUg0oEi5hoedAB5SCo0EHqrgrYN2fDZQP1jM0e2gVFmXjAsarm9
 sE3jEiVBfo9bIxoraETghmWio/hExZaK0G2MlaAUWWPlH/s/lgj8y2aPluLIJwIiWDO5
 nPCsL9EFTnWUXXPdeHMf2mqD8ncvbLtOVcjLDDmK20sqR/zY19gWGF0iPqJMOqrpBHzU
 P5l5nDoT+24rRDoL/bDgoMasOpqDS3TpLXI4nHsZ6shxvb0a59G2E8TD5mPZoPT7AZm0
 TE/nR/n+4AfO7nup111L94qgV7A8exhXah9vnGXYO9tpJuoHYa73upM3pfuz8aU4XUjD
 EyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=en1Diu3sI6Wm13W9qcASbGXcjcSPf5WXodRzGlHYYvg=;
 b=pUSPqoSAzzJU/YncuxEi3Tjx8rduewtDZdztZeFwNlEHCbMsbAA9tspvOl+ltBm+8F
 Dv3K6KHTYldzYIgr+q8bEP42Bvc7hYAaHirctJZJJrdyTX31UcaUExAXiux8eyodjocq
 P2bTcE/k6o+ninBqgeVgyI4E5zIWTn+7SxkN5T5grNC87ucxW+lN2gqRDRJsm0yP4r5y
 xBrK8bUjbw/hNABuRRb64dYzhEjsJHB41KfeVEP05P+tbKOnMcap+w5lIkged6ShZ13F
 VdFKAmSFnfnEFauLqZ9kjx+oLhkN+bktoyx+zcq6q0Afb87p8EV9pGWte3byy7YTp1AG
 wylw==
X-Gm-Message-State: APjAAAVVpdTvo2iCvTPThSjutRbXa8wcqiMKbEcE/kdTV/1fsULWk9QW
 siky6/9mbZbwHudGOkNcW+gLRg==
X-Google-Smtp-Source: APXvYqz7aYfTKLRMIc9dIpZKfGpZT6KS6fOh8tdIld2RBmduglCWax9u24T9mQN4/gn+82GrDikg0g==
X-Received: by 2002:a1c:7d93:: with SMTP id
 y141mr11448751wmc.111.1576773093503; 
 Thu, 19 Dec 2019 08:31:33 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch.
 [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 08:31:33 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v4 11/13] iommu/arm-smmu-v3: Improve add_device() error
 handling
Date: Thu, 19 Dec 2019 17:30:31 +0100
Message-Id: <20191219163033.2608177-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

Let add_device() clean up after itself. The iommu_bus_init() function
does call remove_device() on error, but other sites (e.g. of_iommu) do
not.

Don't free level-2 stream tables because we'd have to track if we
allocated each of them or if they are used by other endpoints. It's not
worth the hassle since they are managed resources.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index bf106a7b53eb..e62ca80f2f76 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2837,14 +2837,16 @@ static int arm_smmu_add_device(struct device *dev)
 	for (i = 0; i < master->num_sids; i++) {
 		u32 sid = master->sids[i];
 
-		if (!arm_smmu_sid_in_range(smmu, sid))
-			return -ERANGE;
+		if (!arm_smmu_sid_in_range(smmu, sid)) {
+			ret = -ERANGE;
+			goto err_free_master;
+		}
 
 		/* Ensure l2 strtab is initialised */
 		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
 			ret = arm_smmu_init_l2_strtab(smmu, sid);
 			if (ret)
-				return ret;
+				goto err_free_master;
 		}
 	}
 
@@ -2854,13 +2856,25 @@ static int arm_smmu_add_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
+	ret = iommu_device_link(&smmu->iommu, dev);
+	if (ret)
+		goto err_free_master;
+
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group)) {
-		iommu_group_put(group);
-		iommu_device_link(&smmu->iommu, dev);
+	if (IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto err_unlink;
 	}
 
-	return PTR_ERR_OR_ZERO(group);
+	iommu_group_put(group);
+	return 0;
+
+err_unlink:
+	iommu_device_unlink(&smmu->iommu, dev);
+err_free_master:
+	kfree(master);
+	fwspec->iommu_priv = NULL;
+	return ret;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
