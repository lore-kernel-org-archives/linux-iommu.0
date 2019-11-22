Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565B3C432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 15:37:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264E420706
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 15:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKWsDluE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264E420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D83FB88C9C;
	Fri, 22 Nov 2019 15:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lB6vO+Abr2WI; Fri, 22 Nov 2019 15:37:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4657288B61;
	Fri, 22 Nov 2019 15:37:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DD4AC1D74;
	Fri, 22 Nov 2019 15:37:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8817C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A66F5882C0
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BcjUdEJu4YlH for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 15:37:28 +0000 (UTC)
X-Greylist: delayed 00:22:20 by SQLgrey-1.7.6
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E169D882BE
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:37:27 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id n12so3056948qvt.1
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 07:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tJZyhm43uf0Z/sgLghvh3C922Koet0UHje3bklWsAKA=;
 b=UKWsDluEmzAq6qXa6AyufiTRGS8uyeF/E1ybHYD2BhpdDKFu8ohyyhib+rGRL0RQk7
 6ETIuUpJ2xaqwB2fiuiVGCZy3dKYtLw4ilm7bKBvFo0k1evx8V5200VPDzwi6SQDvfAS
 RQE8wpNgi2am9UqvIZn0J2IUFN72HpRBwXKXVOvpOSXrVDP/lSerMxwT48/v2+So/0Qm
 i+o0x6UUNxTuzeDIxShfoRa5k/n57nBcPh7UUmA0jdjnrZCXQ8ov6R8OWZaNtPMBlbo6
 dJS23BrpU27x2DVkqaogYcAS1ebYO5COe1i+WXQbMAfhOzpANrVa5CsYlBDq2AUFlcxI
 mS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tJZyhm43uf0Z/sgLghvh3C922Koet0UHje3bklWsAKA=;
 b=j18GCnGaQQ3ySEunNLYFqf+mpFhSmF30YQValwDBOVIEpKR/CEi4Kuofq9Ui1ZPflR
 S+97hpEfDECCI44gY5AqU0czcXJ4elmFQt0SYqiVk0pqJveEFAtvNzlWFQ7Eq0h9W152
 xeheCCjiSF7cXmvphlgn4g+GYEvDyowH31/MC9SlKFgFuOLnCOygDw+Wr2cLsVvmOAwb
 2J+LOmvI/Tl4JiCZklTgGmwD50RL4TfP7vUxHsiYpvf7gQaqk67uv1GpZjFK2Z/lvHjJ
 261SXtCBoPv467k5flAv8ygJsWOWErsKmm2n78oSyWJguUb9Ejzse0zv+MlCSKWVLGv4
 7gKA==
X-Gm-Message-State: APjAAAVNU4+enaOi5gcjAAzu2styRxZwPI+ZfldWNhCGKXBLtTxcEA8A
 GscR8diDmncwS3BGng/3yLJgsy5cdtd9mQ==
X-Google-Smtp-Source: APXvYqxygXDW7MvUMbHe5yZ/Na9aSpFKod2LWOrlJw4kGXMdRrxeSlZHZL2DWVg1uoFERjnu1XLMaw==
X-Received: by 2002:a65:66c5:: with SMTP id c5mr16862228pgw.12.1574435393785; 
 Fri, 22 Nov 2019 07:09:53 -0800 (PST)
Received: from localhost.localdomain ([240e:362:496:8600:f5af:2744:25c3:d01a])
 by smtp.gmail.com with ESMTPSA id
 a19sm8066021pfn.144.2019.11.22.07.09.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 22 Nov 2019 07:09:53 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>,
 Jerome Glisse <jglisse@redhat.com>, ilias.apalodimas@linaro.org,
 francois.ozog@linaro.org, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
Subject: [PATCH v9 3/4] crypto: hisilicon - Remove module_param uacce_mode
Date: Fri, 22 Nov 2019 23:07:40 +0800
Message-Id: <1574435261-6031-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574435261-6031-1-git-send-email-zhangfei.gao@linaro.org>
References: <1574435261-6031-1-git-send-email-zhangfei.gao@linaro.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Remove the module_param uacce_mode, which is not used currently.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 1b2ee96..3de9412 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -264,9 +264,6 @@ static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
 MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
 
-static int uacce_mode;
-module_param(uacce_mode, int, 0);
-
 static const struct pci_device_id hisi_zip_dev_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_PF) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ZIP_VF) },
@@ -669,6 +666,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, hisi_zip);
 
 	qm = &hisi_zip->qm;
+	qm->use_dma_api = true;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
@@ -676,20 +674,6 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	qm->dev_name = hisi_zip_name;
 	qm->fun_type = (pdev->device == PCI_DEVICE_ID_ZIP_PF) ? QM_HW_PF :
 								QM_HW_VF;
-	switch (uacce_mode) {
-	case 0:
-		qm->use_dma_api = true;
-		break;
-	case 1:
-		qm->use_dma_api = false;
-		break;
-	case 2:
-		qm->use_dma_api = true;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	ret = hisi_qm_init(qm);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to init qm!\n");
@@ -976,12 +960,10 @@ static int __init hisi_zip_init(void)
 		goto err_pci;
 	}
 
-	if (uacce_mode == 0 || uacce_mode == 2) {
-		ret = hisi_zip_register_to_crypto();
-		if (ret < 0) {
-			pr_err("Failed to register driver to crypto.\n");
-			goto err_crypto;
-		}
+	ret = hisi_zip_register_to_crypto();
+	if (ret < 0) {
+		pr_err("Failed to register driver to crypto.\n");
+		goto err_crypto;
 	}
 
 	return 0;
@@ -996,8 +978,7 @@ static int __init hisi_zip_init(void)
 
 static void __exit hisi_zip_exit(void)
 {
-	if (uacce_mode == 0 || uacce_mode == 2)
-		hisi_zip_unregister_from_crypto();
+	hisi_zip_unregister_from_crypto();
 	pci_unregister_driver(&hisi_zip_pci_driver);
 	hisi_zip_unregister_debugfs();
 }
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
