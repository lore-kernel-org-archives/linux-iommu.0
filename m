Return-Path: <SRS0=Zw9n=BL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C780C433E3
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 15:54:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0172083E
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 15:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc2zKFpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0172083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0C7F2858B3;
	Sat,  1 Aug 2020 15:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCbCO1rVhdY7; Sat,  1 Aug 2020 15:54:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 776AF85DF7;
	Sat,  1 Aug 2020 15:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 627AFC0053;
	Sat,  1 Aug 2020 15:54:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A9C4C004D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 12:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A1B7203E7
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 12:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hk7c9plSlVYM for <iommu@lists.linux-foundation.org>;
 Sat,  1 Aug 2020 12:24:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by silver.osuosl.org (Postfix) with ESMTPS id EC07B203D2
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 12:24:45 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id bs17so5368514edb.1
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9SS/6geyX0ClI4ij6hB9TxwrDh/zKm7zopv5L3r5c8s=;
 b=Vc2zKFpSPflxIgkXb2/9foXDeDygDY7Eh7RBpe+OBhcwG9txlHhUTADSY0zl+WxwY9
 Kfb8ubabl5bXf5t+me8h6LOdOVgNx3RWTh3l9nvD62Hj4C+HVNM0yzL81CZDIgWKuQsM
 1RFCX6qT0RpcjIQnrRuZ+3NoxXgbeGY86tdkUxocr8VnSr4sDLHBSzv4ELIsnoN3tr0L
 hOwCWxwXz+8O/GBTJW2I4CAR3b25+gDsusQFJbca/CnQOa+THu4aXP6LLU9OXqdAxiiZ
 M7CVKh2dwCjyd35SrdHeY97TUAPQMrUxfslEBfgVTDcSjqpTy0I/VAdWHS1thQpVA/Af
 dnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9SS/6geyX0ClI4ij6hB9TxwrDh/zKm7zopv5L3r5c8s=;
 b=W7OoqJnqmpF2MUTh9aEI01qIHisMxPY1AeBB3kILeJqvBXysYFk+F9E6m5niDQTHov
 li1SMbhbDdtXWhNly1dQix/5YV6b0OUX+Gx0OAS/+WT7gclR8PujQM2sCc1R1z2bX3fs
 8okkbNMyA99HGh2dqmIk3uXIsf/YhEWrBQPskZ3mXlForejz66a5gICDTGNTkkckjU9/
 2I2c3fCjMPL05wG9Lq71jMfHwFfNVoyp90sg9U2PE3DHzW6nCZlvPUzWlJ3FbF2Bcp59
 4twBlrJ7PNK7hUTJSv0r/JCK4YEWKisO/pnwqtAFSmjsU/+OL4hEeyDWL0FTHJyFpBlc
 +Zww==
X-Gm-Message-State: AOAM530qsOip7CqdWpNIjwVyF1wTbxOm9zCt2PoNhkfvUX/xIpD2eOQt
 NsasROrzfFNwfMD6JUWiDNk=
X-Google-Smtp-Source: ABdhPJxCb6w1gVLD3rEZyWpaLmof4X4XsjraNm+7kSy1/q7MbTUqjWvl5aU3W4jrAAp2UMmQx6JGjA==
X-Received: by 2002:a50:d80c:: with SMTP id o12mr8165291edj.265.1596284684386; 
 Sat, 01 Aug 2020 05:24:44 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
 by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2020 05:24:43 -0700 (PDT)
From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To: helgaas@kernel.org,
	Joerg Roedel <joro@8bytes.org>
Subject: [RFC PATCH 15/17] iommu/vt-d: Drop uses of pci_read_config_*() return
 value
Date: Sat,  1 Aug 2020 13:24:44 +0200
Message-Id: <20200801112446.149549-16-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
X-Mailman-Approved-At: Sat, 01 Aug 2020 15:54:38 +0000
Cc: "Saheed O. Bolarinwa" <refactormyself@gmail.com>, skhan@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, bjorn@helgaas.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e98..aad3c065e4a0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6165,7 +6165,8 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	if (risky_device(dev))
 		return;
 
-	if (pci_read_config_word(dev, GGC, &ggc))
+	pci_read_config_word(dev, GGC, &ggc);
+	if (ggc == (u16)~0)
 		return;
 
 	if (!(ggc & GGC_MEMORY_VT_ENABLED)) {
@@ -6218,7 +6219,8 @@ static void __init check_tylersburg_isoch(void)
 		return;
 	}
 
-	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
+	pci_read_config_dword(pdev, 0x188, &vtisochctrl);
+	if (vtisochctrl == (uint32_t)~0) {
 		pci_dev_put(pdev);
 		return;
 	}
-- 
2.18.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
