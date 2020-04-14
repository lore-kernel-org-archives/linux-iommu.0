Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC63BC55193
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:05:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E835206A2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQc1HJyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E835206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B1FD86E55;
	Tue, 14 Apr 2020 17:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xj0Wv3waXg79; Tue, 14 Apr 2020 17:05:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E04C986E77;
	Tue, 14 Apr 2020 17:05:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCC6EC089E;
	Tue, 14 Apr 2020 17:05:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D391C089E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7C51687E24
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8A26WZs2yG6t for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 06FB387E14
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:54 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id o81so8231580wmo.2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vE2itLZu3hqvC4LzqU2NUCFx+9C8ab/nGgmunlfocw4=;
 b=GQc1HJySAIFGl4e9JGBFURgN/vl21Fb+oCGY0ghVUDlr5r96ZmZmw/X83yVkMwCMvt
 DVAASgUR/v3/ZKBKl9O60CQVrNvn4oMMVLsH3g9JXWg+IeYIxVCppffgWVDw7kFLs+SL
 qL185/o63pqZqsBw6EgV8XD0/UHJpB1qI+n6vwa7Qv2mwO4fdLqiqOvJiR2hZWZH7Me1
 eoakZAu9sIB1oOiShcxlx+56zauDP7aBZBVxrI01fRfnSKCQXLcXyLhFUPuBdcSxvOTp
 gidl1cZtbaXu5tx9otKpXSBohIzzToXZC0tS5fggLOAxV0+H42kV0oHqDEtXsMF2hNlm
 qwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vE2itLZu3hqvC4LzqU2NUCFx+9C8ab/nGgmunlfocw4=;
 b=eif7Q8wErLYfXeSPF0dMOEql0tih+8UjWB6eb1gXPYWsQZXcrxyb9LjiSh3jVRWbQl
 rwjqd4sr08rcOvPBxFOXTbTcTF3aQiyAfanpxTVxhQ8saChbTbv90mjYEN/sVVrBU8kW
 n2E23JOg9X9BKa9qOmBG12aEK5DWCUTUlRW+zbw89MhpX/XzV/j6cqlmMzUdGEXIDhZc
 i8rei3MQWk0U36sD3VO4qYtqiGDsIjZ1nHJXPObFrz2t6b4a79IfqbbY6lYUY/XG568M
 6V9+L9Yegy7FCvc8TuZfJovIToy2t4rC0IlsrTOKn8u2KDOItP+m94iNRJ6w7B27vjqk
 eolg==
X-Gm-Message-State: AGi0PuYbtzdSxndXIsvTAmT5mCglToJsU8LXTrXe2g7Xzui+YvKdxWhq
 KQyzxhUsM641BdZ7rAkux9fA9KVk19xwHA==
X-Google-Smtp-Source: APiQypIBMdNPHOZOhnCMJH0FJPJY2Rdi+r/VG4B2wmIYz2z44PksUMUJ1Q8ZKmB8ryyXqmfTYJG52Q==
X-Received: by 2002:a1c:3c08:: with SMTP id j8mr814017wma.30.1586883892098;
 Tue, 14 Apr 2020 10:04:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:51 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 24/25] PCI/ATS: Export PRI functions
Date: Tue, 14 Apr 2020 19:02:52 +0200
Message-Id: <20200414170252.714402-25-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
 Bjorn Helgaas <bhelgaas@google.com>, zhangfei.gao@linaro.org, will@kernel.org,
 christian.koenig@amd.com
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

The SMMUv3 driver uses pci_{enable,disable}_pri() and related
functions. Export those functions to allow the driver to be built as a
module.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index bbfd0d42b8b97..fc8fc6fc8bd55 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -197,6 +197,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -243,6 +244,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -322,6 +324,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -337,6 +340,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
