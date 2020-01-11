Return-Path: <SRS0=xAAD=3A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A352C33CA3
	for <iommu@archiver.kernel.org>; Sat, 11 Jan 2020 02:49:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2BC2082E
	for <iommu@archiver.kernel.org>; Sat, 11 Jan 2020 02:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuzS4eUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2BC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC23484798;
	Sat, 11 Jan 2020 02:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QIjoCY0rjjHl; Sat, 11 Jan 2020 02:49:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3D5748775B;
	Sat, 11 Jan 2020 02:49:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AE43C1796;
	Sat, 11 Jan 2020 02:49:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 560E6C0881
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jan 2020 02:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4527884F4F
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jan 2020 02:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5q0TWgWCXgl for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jan 2020 02:49:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA84C84798
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jan 2020 02:49:40 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id p14so2044275pfn.4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 18:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gt6F4uTsWktpFFyX7CiQDNWqBR7Eg8dmS5mipvr7KTw=;
 b=BuzS4eUvOv/lhca+jR2XNxv29Xk0K8XQWpKgw3B6udBY132JvhuXBRE/kladDkwxYR
 aaZea4znzHpeHW+nADfJFyC1SOn1tIQnLMyZBIHs5aUh8O8izQOU2mAWoqRBZFEcsjug
 Z7/eidmHjaG6WHi8MPp4HL/48LWKjFxqDxyeymaSuDq7hPJXrbnJpQfBgcg8SuFbq+U/
 OPzLMPV4lI7BqHR7bSJrHhFlIj+vAhl5uFKCMAuyTUKDACOpp4jCuALokLQV0XNv4is2
 s5s1rFOcw7R4n8xsmQRgX2VhHy1ssc17xQdH9ABbFZ8+Pb9hL0pW8um2ym06jsoqu41+
 HEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gt6F4uTsWktpFFyX7CiQDNWqBR7Eg8dmS5mipvr7KTw=;
 b=tGBcyoBBrAptxvsy41fwYXDWcM5jYipTSXFqM2sEzMUYCUKLsPTENTN+Qa8Qpgffyv
 1Gw8EuGQxfIoL2rfWwe+w5MoZ2CRoknysmcA5WoYJNPtnJnTqMO2YBDkuY7sWZ04i4px
 oUD/ZGVmzfSBij4wLlj8oq0FQ6pLoircwt1PaORnOI3mqXaGnjWsj42jADhyaeTN3fOx
 CKkzvgHnqVmHaNTDTGBl2TbralgauTp4uiEM3ECuaXTNPIMiGGIL3SX5La9PwM3qgjOw
 cRcqa4Ex/HudIcLlkPotzR65w+qBwMKkfdNhG4vFwSDwZyf3R9u2FpQ9ZUjqMrgpJjuq
 cjZg==
X-Gm-Message-State: APjAAAVqwm2ZRlPH/oZ3UaAGzuHsQXyW50rgnajDSfcgpeJGkmsFZ3F7
 nHE9s7pE3yW89p97+BZ9tHJ0PA==
X-Google-Smtp-Source: APXvYqxUTpxgXhP/QozBen7/IpqFv6gFvrift6Iqxe8kTCwZcjYNtE65ze1fgs8sK/N//6WTFktdHg==
X-Received: by 2002:aa7:96c7:: with SMTP id h7mr7548359pfq.211.1578710980442; 
 Fri, 10 Jan 2020 18:49:40 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.78])
 by smtp.gmail.com with ESMTPSA id r7sm4778472pfg.34.2020.01.10.18.49.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 10 Jan 2020 18:49:40 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>,
 Jerome Glisse <jglisse@redhat.com>, ilias.apalodimas@linaro.org,
 francois.ozog@linaro.org, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
Subject: [PATCH v11 3/4] crypto: hisilicon - Remove module_param uacce_mode
Date: Sat, 11 Jan 2020 10:48:38 +0800
Message-Id: <1578710919-12141-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 31ae6a7..853b97e 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -298,9 +298,6 @@ static u32 pf_q_num = HZIP_PF_DEF_Q_NUM;
 module_param_cb(pf_q_num, &pf_q_num_ops, &pf_q_num, 0444);
 MODULE_PARM_DESC(pf_q_num, "Number of queues in PF(v1 1-4096, v2 1-1024)");
 
-static int uacce_mode;
-module_param(uacce_mode, int, 0);
-
 static u32 vfs_num;
 module_param(vfs_num, uint, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63)");
@@ -796,6 +793,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, hisi_zip);
 
 	qm = &hisi_zip->qm;
+	qm->use_dma_api = true;
 	qm->pdev = pdev;
 	qm->ver = rev_id;
 
@@ -803,20 +801,6 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -1015,12 +999,10 @@ static int __init hisi_zip_init(void)
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
@@ -1035,8 +1017,7 @@ static int __init hisi_zip_init(void)
 
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
