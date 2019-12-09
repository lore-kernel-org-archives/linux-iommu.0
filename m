Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5BDC2D0D3
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95389208C3
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 18:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHfiTmHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95389208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 77B4C87D3D;
	Mon,  9 Dec 2019 18:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogI5hBA6jgdS; Mon,  9 Dec 2019 18:12:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7179A87CC9;
	Mon,  9 Dec 2019 18:12:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FC13C1796;
	Mon,  9 Dec 2019 18:12:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E408CC0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E037B87C20
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fvuh2NJTI780 for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 18:12:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 67B2B881D0
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 18:12:09 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id n9so320512wmd.3
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 10:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dS9JHQoIet3pVv6eJb9kJhT5ftY7Ua+yYZWdXaG4gzo=;
 b=jHfiTmHM4CgLf+XW4XJxxOpTyiR6rKXGw0zHau9qPm2vGLuTDtwrk1iEmqAtUcL0i1
 GsCQCDgc6hgt4m1sndQFIWIIUKcYhL3IICK4Fqklm0GGYn+i8/U2GBdcVIS7kpyJntqK
 FncR+fmMSAF2mS9jczjFGKFdm/z/keSkGM1LzIOx+yDEkmzwl+Dx3hiYEEq7n5Ta8Vlq
 ruclXWt71bhEl2VL8xVlpMVPiSsHqe3n9I6P6HD+ta2oXHF1cST8lor+yZKxe9kLQzqp
 //OPHKtrlucEqJ22vm3L1SlVRIUHcuhtXn61mRWuGRC0y+tJPOx0Fb2FHsmhDZ9xMc1r
 golg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dS9JHQoIet3pVv6eJb9kJhT5ftY7Ua+yYZWdXaG4gzo=;
 b=p9kr2oRbZ4j12NeN4BeQ7asyv9ZWPK4hwe4EkJVvy8p4paJ+danDqtOozbJthKZ+zv
 OD+rUSOZdji14qFpydxvvqB3USX9OVpKd7FqKCSH797dTr9zE6FhUzFtKgRVK6e/08GV
 pvsgXZvWYooCb+PukdKGh2VSr9U+BiZuTESxC2yUzXlUmvbv+oyfKli1o3FltsObMCjg
 DtE9Xy93QxAd3GGzGN4XxK4/1bO2ZM/kn3x9b+LUA86dH1esvy9ccYfYUG6nBX6mKuF2
 u3SVbHkurTqi+WzXOt8INWZxahldA0bhRyxm8h3IkR7yAWX+OUfoHtM56WWt9ZZ4WsZg
 8c6w==
X-Gm-Message-State: APjAAAW12H7+7/SMG+Xr9osKWTpuOy9Ro6KykGquy71UHf1KrQK4MyAg
 e+ETTRt3VKoLFMIvRUmLzTG1DQ==
X-Google-Smtp-Source: APXvYqwLObPVApm61pTMGQoHPnKg/K//kDJoQJn+2j5gLjfljwmJA5TLzDgo+SfmbkrNRrb8uanIWA==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr394499wmg.66.1575915127985;
 Mon, 09 Dec 2019 10:12:07 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch.
 [62.167.101.88])
 by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 10:12:07 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH v3 11/13] iommu/arm-smmu-v3: Improve add_device() error
 handling
Date: Mon,  9 Dec 2019 19:05:12 +0100
Message-Id: <20191209180514.272727-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
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
index 52adcdfda58b..d20a79108f8a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2836,14 +2836,16 @@ static int arm_smmu_add_device(struct device *dev)
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
 
@@ -2853,13 +2855,25 @@ static int arm_smmu_add_device(struct device *dev)
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
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
