Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279FAC10F11
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 21:05:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0162B21738
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 21:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0162B21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C28B1CAD;
	Mon, 22 Apr 2019 21:05:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 17675C3F
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 21:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C19A0829
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 21:05:36 +0000 (UTC)
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <gunthorp@deltatee.com>)
	id 1hIg85-0004id-Rs; Mon, 22 Apr 2019 15:05:36 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
	(envelope-from <gunthorp@deltatee.com>)
	id 1hIg82-0003zh-UN; Mon, 22 Apr 2019 15:05:30 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Joerg Roedel <joro@8bytes.org>
Date: Mon, 22 Apr 2019 15:05:23 -0600
Message-Id: <20190422210528.15289-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422210528.15289-1-logang@deltatee.com>
References: <20190422210528.15289-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, jdmason@kudzu.us,
	joro@8bytes.org, bhelgaas@google.com, dave.jiang@intel.com,
	allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com,
	logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 05/10] NTB: Rename ntb.c to support multiple source files
	in the module
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190422210523.ee1nE2BEOC2s0FF-DzL33WbSdcoOj2FQ9VDquOTVB0o@z>

The kbuild system does not support having multiple source files in
a module if one of those source files has the same name as the module.

Therefore, we must rename ntb.c to core.c, while the module remains
ntb.ko.

This is similar to the way the nvme modules are structured.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 drivers/ntb/Makefile          | 2 ++
 drivers/ntb/{ntb.c => core.c} | 0
 2 files changed, 2 insertions(+)
 rename drivers/ntb/{ntb.c => core.c} (100%)

diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 1921dec1949d..537226f8e78d 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -1,2 +1,4 @@
 obj-$(CONFIG_NTB) += ntb.o hw/ test/
 obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
+
+ntb-y := core.o
diff --git a/drivers/ntb/ntb.c b/drivers/ntb/core.c
similarity index 100%
rename from drivers/ntb/ntb.c
rename to drivers/ntb/core.c
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
