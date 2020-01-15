Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C638DC35249
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBC2206D7
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMEN5de5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBC2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8AB6686016;
	Wed, 15 Jan 2020 12:53:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdxvWjfsGV-7; Wed, 15 Jan 2020 12:53:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 25326862E1;
	Wed, 15 Jan 2020 12:53:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F541C1D8B;
	Wed, 15 Jan 2020 12:53:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A83E0C1D8D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 97B9E85E8A
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WA_hGQRhARPW for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 12:53:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6795984B1F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:53:39 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id m24so17736222wmc.3
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ovlZEJ3MFxMFIeaWjeBxqpybO8xAZBGhmofvDyv09KM=;
 b=aMEN5de52sUoibJjcgOb+6eTx1h6fTv2UQ6WOa5q3Q6KiJA4GEB9NVcvkjp5XTDpw0
 jyrlMPEEviSdgsEwPxnn9Qz4ztTIX7m8d3wu8FrFmUwKiXL+nOjMqWUR5vGtLernKgVK
 Q4R3z+oQjYLX0uQdMrVVaHa5dbQc3Tw0ln21IYTTubylIuPt2K9feenebb5Pze+7i3iH
 72VB4jpBo6CPlpj9BX+uLH0Gq/t5k7z+IV0RzkE2TBQ3QZHc/sNDML1H9dU55iSMdK92
 vuUczV5TEeoRgiZ9py79YvE0UIEZiXLTzJDRV+IIxn6fWVQr8YnXBCTycNdwBzUwU5eM
 OJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ovlZEJ3MFxMFIeaWjeBxqpybO8xAZBGhmofvDyv09KM=;
 b=ssuCH6E6ONfkOVSEJUwIBQRhBy1Dv7siy2aw9D/TLByuZtMo1rWLb9QRpHV0ZUGB6h
 9uhpWW3zeNDrN0hNqy7F33YVXoNH1NagoPFunimp8GF/1vhvekZDBhb7Udfszw8oVUQn
 rjjifrjdr2EAxFhQr53tTwze85gWUoHDKIATQdH/ZazKNxucNg6+cVQGL1Mp7H9IqCiO
 vSrvZGEs6Rd9id6Abv+r03N/0JVzS12EcF9NLWNcs5HuTL52PoPiOBf2wK2ph4s/K/a1
 O4mARG81N9o1hFbHKttQN3teKkpM2lAmlN9PaSAqrtfOGJNcmQZlm6RsSFHs6jKXrkUY
 zb+A==
X-Gm-Message-State: APjAAAVtwQ9+SwSalRdtVD8lBU68C8IYtTCBnRTBkEcoI0Wooy7EU5N4
 VzPl2iXzcjVQp2Aw4TuVyH+eOg==
X-Google-Smtp-Source: APXvYqwvjgPB35BKDw3598B+f3tN02Oa/sBncf4ulCANAV1l9+FYbfBBXQvNAcGYK7F4agxMEERIfA==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr33782202wmk.85.1579092817895; 
 Wed, 15 Jan 2020 04:53:37 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 04:53:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org
Subject: [PATCH v5 09/13] iommu/arm-smmu-v3: Prepare for handling
 arm_smmu_write_ctx_desc() failure
Date: Wed, 15 Jan 2020 13:52:35 +0100
Message-Id: <20200115125239.136759-10-jean-philippe@linaro.org>
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

Second-level context descriptor tables will be allocated lazily in
arm_smmu_write_ctx_desc(). Help with handling allocation failure by
moving the CD write into arm_smmu_domain_finalise_s1().

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7b7dea596f60..c35863073ab3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2299,8 +2299,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	if (ret)
+		goto out_free_cd_tables;
+
 	return 0;
 
+out_free_cd_tables:
+	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_bitmap_free(smmu->asid_map, asid);
 	return ret;
@@ -2567,10 +2574,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
-		arm_smmu_write_ctx_desc(smmu_domain, 0,
-					&smmu_domain->s1_cfg.cd);
-
 	arm_smmu_install_ste_for_dev(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
