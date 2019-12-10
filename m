Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D005C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 02:50:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6F1206E0
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 02:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2RNUSwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6F1206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5496F86208;
	Tue, 10 Dec 2019 02:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kXWCyYPjLvq; Tue, 10 Dec 2019 02:50:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4DD11861A1;
	Tue, 10 Dec 2019 02:50:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28631C1796;
	Tue, 10 Dec 2019 02:50:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6982C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 02:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B9D9587C72
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 02:50:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lBCE+QnUT5eF for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 02:50:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4859087C30
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 02:50:08 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id c13so6017589pls.0
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 18:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W9XtgUwCaqLhMYMb2ALmzrvWt2lsT7N00PF81eXUGSY=;
 b=Y2RNUSwAXifJcQebUPMgVLxf/MudfCJaiOKVS3Ae26rZaAh6MymPdTdO4VoQrfMxVK
 IYKXAga4IeE37eq/4LxHdQ6qu4uNCZZpOEkeDCfBNc1kbbR2/9TKYRbSdN8UMu3dKBMC
 mPLiY9gBOjp81TQjQR1z9/vd33QGfFPrJeX5v6Z+fmV/p4APogD9ScTCoMGO5vbVooHm
 TnjwvC6pze8E+kaJ3obAxvVJ+MUGFYRSlF7gmFoGi5MyD8wDc0wQ94OYPLwcA88cADvm
 OHXIZIqYYLXpMvHrN9NUw4CNGKRdU2+3mIAjJbqDdCUw8r56wgL/LBR+keX70INz6Xqp
 xtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W9XtgUwCaqLhMYMb2ALmzrvWt2lsT7N00PF81eXUGSY=;
 b=R4TpWdGxrgNEvdt9IoowkpTF2auRumKGtWM0zAEOFe94FqIP/h7VXHQM54+2jHiVkw
 tbIxY95EF2WhTQKLqz1G1OXMr3tMFDL/MPWrYkSBLjdlDgzvjgC9btbmZ1TB7g8ETK1e
 i/KeVUBIyGATLO9Isy/oVfDADomfmjs+xpNOwK9mUkaANc0Ek5U6hWGD442RJm9U6trT
 O9poZR/F06VwWAJnkXcddd4OO/FtJUjwIPaCvwUkMXNv455qT1+ciPX97xKO8fjSkhWI
 9nXQKA6XnQ0S/54/Cc5CgT4oB6b0GcwhyylihB1sZwYm3db9qP07sKoiWgLZZJHOEzBF
 igqQ==
X-Gm-Message-State: APjAAAWGrdP8pBN6F9DUuQ076fg34hhX25TTLAWkYC6+CiCI4olxOvH+
 5o75VpYP6iqUpd1mJR3z5Mioz5FaRVtNCw==
X-Google-Smtp-Source: APXvYqxBqtx8iA2DT4qIA5nj1lktg2CQY6/O9s2mldV+OZ5S9h9gqqGn4i0CA56hzavR1lMONxwQhA==
X-Received: by 2002:a17:902:c58e:: with SMTP id
 p14mr32342459plx.202.1575945835911; 
 Mon, 09 Dec 2019 18:43:55 -0800 (PST)
Received: from localhost.localdomain ([240e:362:417:e00:ed89:9d55:8cd5:6d38])
 by smtp.gmail.com with ESMTPSA id
 r6sm826422pfh.91.2019.12.09.18.43.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 09 Dec 2019 18:43:55 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>,
 Jerome Glisse <jglisse@redhat.com>, ilias.apalodimas@linaro.org,
 francois.ozog@linaro.org, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
Subject: [RESEND PATCH v9 3/4] crypto: hisilicon - Remove module_param
 uacce_mode
Date: Tue, 10 Dec 2019 10:42:34 +0800
Message-Id: <1575945755-27380-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575945755-27380-1-git-send-email-zhangfei.gao@linaro.org>
References: <1575945755-27380-1-git-send-email-zhangfei.gao@linaro.org>
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
index e1bab1a..93345f0 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -297,9 +297,6 @@ static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
 MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
 
-static int uacce_mode;
-module_param(uacce_mode, int, 0);
-
 static u32 vfs_num;
 module_param(vfs_num, uint, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63)");
@@ -791,6 +788,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, hisi_zip);
 
 	qm = &hisi_zip->qm;
+	qm->use_dma_api = true;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
@@ -798,20 +796,6 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -1010,12 +994,10 @@ static int __init hisi_zip_init(void)
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
@@ -1030,8 +1012,7 @@ static int __init hisi_zip_init(void)
 
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
