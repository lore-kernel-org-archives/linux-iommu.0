Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E67C5DF60
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:27:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4362178F
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Stc/zRTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4362178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B7131DDD;
	Fri,  8 Nov 2019 15:27:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3EB92E5E
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A0960196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:58 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id b3so7456113wrs.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 08 Nov 2019 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FjGV9dHEsXE/CXRMwyPeo6zW+qyz6ot3r0JcxY8EA5E=;
	b=Stc/zRTgvuJV42ldqRHlqe8DkziQ/xZI3K/M//32mxdJaRU1jz2L5/fMxZ1QFhpcGb
	EvSLry3iFu8329VB2GuTsvuMtRKQtUr6NhZe+OfFoUtq8NdYCPynlIwHbw/GjFUbmRC+
	H6gal8DBpakRVo3SnhTJfseRLFp1XqfFkb3D3NUiwdPCcqFJAIgPj+gGr6Z9Up4EP+4P
	8+Ut1quAnJxAurGbZKQH/VrQGWCWm7la8zmxc89J8tDCxR4MRqdAj9qnVky2l9P/QGSc
	7hQrDyjXx2qQgCLFiaNFaKInDn2CY6ehhHcEYqTjArSQZFKJgu0xbSGyle/kTSvYSm0a
	jagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FjGV9dHEsXE/CXRMwyPeo6zW+qyz6ot3r0JcxY8EA5E=;
	b=MkuTEZqyUDu13wrj1hqV7MzctFPKraVGDttEBJHigv5ZifTNnbI4bPVhhUnOEBK5cc
	ZY2lND3V80VQHGhUBbrSJ8IyGZPjGNznc+21cbMEbTquEayHMw/9WgkYROnH5/U6SeLO
	M0qHMUEKgn4WQTYTywnMCKLBIbwBvAe7FPjB1lP0W1D1Qtx2/EYLJ8uvc76TymXFm1nb
	mVKxbwBYKZiZR1l93SzQqZBQbeB7OZH8XlgphzHXh5dL4y0W6udZXVhlA1NA+On3tr3z
	CZ6Ci/DdwsV20nEOgCNqE8Pa2Ski+iw5l4637Uase2cxuRIjw9rTHLDYzhNumReCcXSn
	padg==
X-Gm-Message-State: APjAAAUARBZVDQh8P7+w4zHSSH/RjXq7DC6+guy1ofAWlQE5OHwiLYv/
	8GLJLwHCxoHozhf3QbciGKrxodjRNvr4ew==
X-Google-Smtp-Source: APXvYqyYxAoUhXJzLGprymri1AM4kybRhlq/Xshi8NVcy8x0x8VatgjfP55PcG/0utxa9PrTdLVdag==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr9845340wrt.260.1573226817077; 
	Fri, 08 Nov 2019 07:26:57 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id
	w18sm6579232wrp.31.2019.11.08.07.26.56
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 08 Nov 2019 07:26:56 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 8/8] iommu/arm-smmu-v3: Add support for PCI PASID
Date: Fri,  8 Nov 2019 16:25:08 +0100
Message-Id: <20191108152508.4039168-9-jean-philippe@linaro.org>
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

Enable PASID for PCI devices that support it. Since the SSID tables are
allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
arm_smmu_dev_feature_enable() would be too late, since by that time the
main DMA domain has already been attached. Do it in add_device() instead.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 88ec0bf33492..3ee313c08325 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2633,6 +2633,49 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
+static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
+{
+	int ret;
+	int features;
+	int num_pasids;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+	features = pci_pasid_features(pdev);
+	if (features < 0)
+		return -ENOSYS;
+
+	num_pasids = pci_max_pasids(pdev);
+	if (num_pasids <= 0)
+		return -ENOSYS;
+
+	ret = pci_enable_pasid(pdev, features);
+	if (!ret)
+		master->ssid_bits = min_t(u8, ilog2(num_pasids),
+					  master->smmu->ssid_bits);
+	return ret;
+}
+
+static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->pasid_enabled)
+		return;
+
+	master->ssid_bits = 0;
+	pci_disable_pasid(pdev);
+}
+
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
@@ -2841,13 +2884,16 @@ static int arm_smmu_add_device(struct device *dev)
 
 	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
 
+	/* Note that PASID must be enabled before, and disabled after ATS */
+	arm_smmu_enable_pasid(master);
+
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
 	ret = iommu_device_link(&smmu->iommu, dev);
 	if (ret)
-		goto err_free_master;
+		goto err_disable_pasid;
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
@@ -2860,6 +2906,8 @@ static int arm_smmu_add_device(struct device *dev)
 
 err_unlink:
 	iommu_device_unlink(&smmu->iommu, dev);
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
 err_free_master:
 	kfree(master);
 	fwspec->iommu_priv = NULL;
@@ -2880,6 +2928,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_disable_pasid(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
