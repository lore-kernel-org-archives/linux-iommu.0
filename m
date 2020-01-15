Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2811BC33CB7
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BFD206D7
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GizgJV+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BFD206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B35A581429;
	Wed, 15 Jan 2020 12:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Jb3m9I6IsnU; Wed, 15 Jan 2020 12:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4CEE68632F;
	Wed, 15 Jan 2020 12:53:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38C51C1D8D;
	Wed, 15 Jan 2020 12:53:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1D36C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB83F20524
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Bsfhfhz8RMz for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 12:53:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 8A42920523
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:41 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id j42so15588656wrj.12
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C3g2nYTO2xQzb0GJuxY8N32scuZW4mZloVEmHa7VH1s=;
 b=GizgJV+NAlkwmPStOaKeLJGVjuw+mNcVnRBGC3KOsPI8Ckz3NtzP81ZW0FXqyGTgmo
 CQSBQ1i/367JhF2Hr9aOyBH7HhwOtRQxxhF1ER/yFhgBYGARKyuYZwnyUOM16f9ZkoHz
 932OC6jTw3G1Yo73aVV7ol9jYuBydFvGU5nbMGRb8wnB/wZMPE3SbC9TXmYjWfC0Hj8w
 toP68qIugnKqfeVmyqApFpJyXHnxypMTrAs0iJBxdz+LQ8B8jT0dBRDD7X39lECHCK9Y
 lz9qLSHufNXYhKd+fOGRYzHa41Bh2IjLy2+y4DlRmvQ2I5XcgoOrSTzHbGvUrovuTt/X
 3gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C3g2nYTO2xQzb0GJuxY8N32scuZW4mZloVEmHa7VH1s=;
 b=Of0zq4+lNxmu31HxCOwxB45ztCUwJ1OvyZu6E33ce7mrUK4D1eAH7aHMp/Anutbp7i
 qAOerJ0QjKgDfmhx7u3zwHWbfXjyoynXaob61pjTjOdLzNpbZOe2rGsq3NeUsZF5q4SB
 VTbwyGlQ5Ta+xvU0nQhpDIHGAzaP/qfmApbj0Cdr30WPEVjDQ5ESOk54KiXhitrC3Om/
 IZyIXt+MaP4ocNys+bP7cFhPZ7zYeYrItBgPW37mfDx5Ui3+VYDEj4ZKfEwoBoaatiYG
 6lUpSROuIxK73i6TkafC5eX9Rx1r+TumCQ4gKPXeNdvm5oQdrOriA6tURZwJgA+L4hBM
 mYKQ==
X-Gm-Message-State: APjAAAU/wXOqxNubw67XSxcb7vU4k4yd7j5da6CRcilm5qoX9/d+effD
 Zkgk406DUCsxcFq4+dw1SiL/Rg==
X-Google-Smtp-Source: APXvYqwSGcbdAtd5+ica/pXHhp8VLPeN94EbbtkoRsRsPY47afNQboGMHUBtV30+2XDoEbdnJ8V8Ug==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr11624781wrn.140.1579092820130; 
 Wed, 15 Jan 2020 04:53:40 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 04:53:39 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
Subject: [PATCH v5 11/13] iommu/arm-smmu-v3: Improve add_device() error
 handling
Date: Wed, 15 Jan 2020 13:52:37 +0100
Message-Id: <20200115125239.136759-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
 robh+dt@kernel.org, sudeep.holla@arm.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, lenb@kernel.org
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
index 04144b39c4ce..b2b7ba9c4e32 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2827,14 +2827,16 @@ static int arm_smmu_add_device(struct device *dev)
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
 
@@ -2844,13 +2846,25 @@ static int arm_smmu_add_device(struct device *dev)
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
