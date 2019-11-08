Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E04FC6195
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:27:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4A22178F
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDQ7ZeC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4A22178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8F47DEC9;
	Fri,  8 Nov 2019 15:26:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0B0EAE80
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 69863196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:57 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id t26so6622626wmi.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 08 Nov 2019 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XcF4FI/xEJT2ddBZxLwsH4kwVBtXhLcA/n4y2uy3gfU=;
	b=BDQ7ZeC9LB/2Lh6DQj16J8t0f6umU/jbny0nZwuikklVbgDi7dCWTbWMm0aRjLi005
	V9skokHIp4EKef66gOqo4I/nTxWGvc+9S6EKjBlJxyLdKbQSqZqWvqeY+Z77HTqkfX16
	4JkmEuH7gjM/RdLJO9BN/Vyp34vnY9Hjxh0xTuSOc2pbbXcqJvbeKLT8KPs3B6zuGeSk
	oQeEJyv8qFljGOOQ55RrjTk0fCjjESA+CfjKaY7SQ8SZ3HRmaDrfbgz8Gb5nIqgT00q+
	AA1hFm+CnyswDokicO8N1z95D2kGm5pzZtaKebbBgrFl7rKhfqfepJE34J7LhtfZSbFY
	G1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=XcF4FI/xEJT2ddBZxLwsH4kwVBtXhLcA/n4y2uy3gfU=;
	b=D2yURN5hCeeXSbBpcqkQxineufwGhqR+DYIqNwV9o2leuMGajAYdi4y4739AfZbatV
	+FzVTPVeKBBHl+BukxPYg0B8AgKtMnIW7NPuIEyOkw2/SPFFAN3UusHDQK7PBJ5HlouU
	z312Z9uhqaX5E0jbhGoZ87Ec2R2YPYVPuBzqNzuSmPkesJ5u9mjr0tdo14yIf/cDif7l
	opllkyvMJ/RrbCFg9wohAwJYvTE7BXSp/DAtisFIf2PL4A90/flaDa2K3x6rBa5eee7A
	+OkFHQpqkXieoL1I2Pev8p+PreXQIO4NC3cv+06LaYAXEiuQe998IdpISZ8JI0g8V6ue
	rabQ==
X-Gm-Message-State: APjAAAU5s9TOdsPeCcMbJ2vcZzoiEpAMBhh+nUrKNKlEWZHCFcDwUjfc
	ygQDYuW88cGJxsii0/8VNfjridFMjxQtuA==
X-Google-Smtp-Source: APXvYqzgCicwCZbEjPp1W/xKMCJmORJ4A/9v+uL6ZQTDFPmzJrCekPgMET2BLRpL/BAud9T+NepWPQ==
X-Received: by 2002:a1c:9917:: with SMTP id b23mr8603435wme.42.1573226815904; 
	Fri, 08 Nov 2019 07:26:55 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id
	w18sm6579232wrp.31.2019.11.08.07.26.54
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 08 Nov 2019 07:26:55 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/8] iommu/arm-smmu-v3: Improve add_device() error handling
Date: Fri,  8 Nov 2019 16:25:07 +0100
Message-Id: <20191108152508.4039168-8-jean-philippe@linaro.org>
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

Let add_device() clean up after itself. The iommu_bus_init() function
does call remove_device() on error, but other sites (e.g. of_iommu) do
not.

Don't free level-2 stream tables because we'd have to track if we
allocated each of them or if they are used by other endpoints. It's not
worth the hassle since they are managed resources.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82eac89ee187..88ec0bf33492 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2826,14 +2826,16 @@ static int arm_smmu_add_device(struct device *dev)
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
 
@@ -2843,13 +2845,25 @@ static int arm_smmu_add_device(struct device *dev)
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
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
