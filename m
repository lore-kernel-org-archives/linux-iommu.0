Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802BC64E69
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C9622201
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJNFqP/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C9622201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8C698870AF;
	Thu, 12 Nov 2020 13:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f8nxrX35rIqd; Thu, 12 Nov 2020 13:03:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 187E4870A9;
	Thu, 12 Nov 2020 13:03:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04BE7C0889;
	Thu, 12 Nov 2020 13:03:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE448C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AD6D7876BD
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UeQWd0a6QupL for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:03:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AEAA487786
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:28 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id w24so5477965wmi.0
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 05:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qVbQfn+wW1FJTP9+IaoEjGKkOhoG1CH1YVgrdlNJ6Sw=;
 b=AJNFqP/ZKhk6objxUUtP+6tvikca2WaZ6jTYQcqn0yvFmq93hZ3lVQHYyK7f33pXgE
 LMPNyvQtw49zSsYAQyGirgOmAjeKMdajdiJVAvrB0xvcpLKnNUh1Z8ZszvxyGNv+yFWO
 jRyaMPOhhzNbE3/mz7+lXJ3IhlCs6H3xrg7kN1+ZuHmW+evNoDn1JYTAFeNTCQVfBP6C
 UDXzfEZDz9yBRbmmCKA8RPN03ITbdvYu314gLJxyyi+H6Vek4EQpQ+DnwUjWmEWZQ4P7
 ecl6SKlD8ae4yC6bXIaFUH6JgCSMUZFZyPJSzMPNHa1vLYEGIy0ojNDIzjqoS0ABNNt4
 JmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qVbQfn+wW1FJTP9+IaoEjGKkOhoG1CH1YVgrdlNJ6Sw=;
 b=YBjq8gxWwtdCfmIOA7046UaVfW22SORahRB2Xk+M1bbgTk4hsH/GRKy6SN0/1G70N2
 S1R8OLyCIMrywBuoXUJvb2r+A49UnXP59op9T6Uz3n+yQpjKJlsczACV2pMVFKLuecTB
 6Tb2YRLV8IUn9h9V71HJx8xlK7pWWeYc3QXj/zIj5zTi+aTvaXhWrLByXPW1TnrvV2Wy
 a/y5UE8c54tes0IP3qZbvxNUZAifgqgHgr31/8qjHqLD8rLaeNVhjG6NA6rNS5C+ZK4I
 ly7e7+7RJovpngszBSGFY8NocHCGBSPQkzEC2B2Ui1v3sFczLIjdRzZW7dTiyeTBf6no
 lmKQ==
X-Gm-Message-State: AOAM530Ftn07nrcibAlgOCvx4CGbBVfwGZkdo/TGh/Ls3R6zd3OYrB9z
 JTRv7wZVrCRj76Wr7F8Nep7RNA==
X-Google-Smtp-Source: ABdhPJxsDYTMbvBnnj6uOORdu3x6BbabxcW+EJNp1tzj8KBQp5jtE8PRmp5+1detfGdDqBG6DaNgNA==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr10063043wmc.159.1605186207268; 
 Thu, 12 Nov 2020 05:03:27 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 05:03:26 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
 robh+dt@kernel.org
Subject: [PATCH v8 8/9] PCI/ATS: Export PRI functions
Date: Thu, 12 Nov 2020 13:55:20 +0100
Message-Id: <20201112125519.3987595-9-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, guohanjun@huawei.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, vivek.gautam@arm.com, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 46bc7f31fb4d..e36d601015d9 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -191,6 +191,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -238,6 +239,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -317,6 +319,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -332,6 +335,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 
 /**
  * pci_pri_supported - Check if PRI is supported.
-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
