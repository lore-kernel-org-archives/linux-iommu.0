Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9757DC3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 16:14:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B702087E
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 16:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B702087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 38EE7E40;
	Tue, 20 Aug 2019 16:14:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 39074DA7
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 16:14:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9040812E
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 16:14:00 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id n4so3520558pgv.2
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 09:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=rfpTxm0NAlEy8xKy4wmYmwInXk2X4QMQ21G/QjPhbGQ=;
	b=CEGEXcMXkqI3zyFB/GWQhFji6MxCZjzdmAu/szsnMDI5qxaBgIUpRhtqiU3N6PBC/g
	q4jso853UzrxeqcNcYcetUn+92KgUmUHQHXy1tz62wsfNyLS+cpij0sJcX3e0gCXS6I6
	S8JgW+VaVSJa2dEBkYme6wdCYej1lnYFCswe9pDYWmbJ99pypvvx3MN5IBIM0o8X0l+d
	/naVQp6aR6fO70IZlXbbnESoIpoG2NKsiM+u8qKfy8Y/VZf/TqdZNTcH2B2a7d1JAYcc
	1ANlX+9yNRgmTnba9OTBe5zqsgD3UPBbKLboiV3/dHz6UNQw0Oircx05R1l83AAWCuOj
	76sQ==
X-Gm-Message-State: APjAAAVRFDQFO9Jkc9CSPvSRdAhLcx6CV43D43hhDtn0OYownJyrBFsG
	CXxlgPWpH9kQ7B0LBmefWAU=
X-Google-Smtp-Source: APXvYqxTIV3zuOXqQRI/JI1qaV7Iq/Y4nRwsb5qOUjTnvGS327RD0amGzW/WoGsdRxyFRjBQUAbgOA==
X-Received: by 2002:a65:514c:: with SMTP id g12mr25438710pgq.76.1566317639818; 
	Tue, 20 Aug 2019 09:13:59 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
	by smtp.gmail.com with ESMTPSA id
	u23sm19759252pgj.58.2019.08.20.09.13.58
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 20 Aug 2019 09:13:59 -0700 (PDT)
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/vt-d: Fix wrong analysis whether devices share the same
	bus
Date: Tue, 20 Aug 2019 01:53:17 -0700
Message-Id: <20190820085317.29458-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, iommu@lists.linux-foundation.org,
	Nadav Amit <namit@vmware.com>, Logan Gunthorpe <logang@deltatee.com>
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
From: Nadav Amit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nadav Amit <namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

set_msi_sid_cb() is used to determine whether device aliases share the
same bus, but it can provide false indications that aliases use the same
bus when in fact they do not. The reason is that set_msi_sid_cb()
assumes that pdev is fixed, while actually pci_for_each_dma_alias() can
call fn() when pdev is set to a subordinate device.

As a result, running an VM on ESX with VT-d emulation enabled can
results in the log warning such as:

  DMAR: [INTR-REMAP] Request device [00:11.0] fault index 3b [fault reason 38] Blocked an interrupt request due to source-id verification failure

This seems to cause additional ata errors such as:
  ata3.00: qc timeout (cmd 0xa1)
  ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)

These timeouts also cause boot to be much longer and other errors.

Fix it by checking comparing the alias with the previous one instead.

Fixes: 3f0c625c6ae71 ("iommu/vt-d: Allow interrupts from the entire bus for aliased devices")
Cc: stable@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/intel_irq_remapping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 4786ca061e31..81e43c1df7ec 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -376,13 +376,13 @@ static int set_msi_sid_cb(struct pci_dev *pdev, u16 alias, void *opaque)
 {
 	struct set_msi_sid_data *data = opaque;
 
+	if (data->count == 0 || PCI_BUS_NUM(alias) == PCI_BUS_NUM(data->alias))
+		data->busmatch_count++;
+
 	data->pdev = pdev;
 	data->alias = alias;
 	data->count++;
 
-	if (PCI_BUS_NUM(alias) == pdev->bus->number)
-		data->busmatch_count++;
-
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
