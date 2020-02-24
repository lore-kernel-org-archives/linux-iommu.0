Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B70C38C00
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83F12080D
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83F12080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7162B860A8;
	Mon, 24 Feb 2020 23:21:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WFse-VKd5K0R; Mon, 24 Feb 2020 23:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 379E985D21;
	Mon, 24 Feb 2020 23:21:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3174C07FF;
	Mon, 24 Feb 2020 23:21:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A128C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 23:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 34397204FE
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 23:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id scG1L81SPomM for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 23:21:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by silver.osuosl.org (Postfix) with ESMTPS id 37BA5203DF
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 23:21:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 15:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; d="scan'208";a="255749662"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga002.jf.intel.com with ESMTP; 24 Feb 2020 15:21:10 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 0/2] Replace Intel SVM with IOMMU SVA APIs
Date: Mon, 24 Feb 2020 15:26:34 -0800
Message-Id: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Shared virtual address (SVA) capable accelerator device drivers on Intel
platform are required to call VT-d driver directly to bind a device with
a given address space. It is conceptually incorrect with the following
reasons:
- A device driver is bypassing IOMMU generic layer
- Device driver cannot be reused across architectures
- Opens a door to duplicated code

Generic SVA APIs was introduced[1] and partially merged upstream which
created a common ground for vendor IOMMU driver to consolidate SVA code.

On the other hand, Uacce (Unified/User-space-access-intended Accelerator
Framework) [2] is emerging to be a generic user-kernel interface for SVA
capable devices.

IOMMU generic SVA APIs are used by Uacce. Therefore, replacing VT-d SVM
code with IOMMU SVA APIs are required by device drivers want to use
Uacce.

The features below will continue to work but are not included in this patch
in that they are handled mostly within the IOMMU subsystem.
- IO page fault
- mmu notifier

Consolidation of the above will come after generic IOMMU sva code[1].
There should not be any changes needed for accelerator device drivers
during this time.

References:
[1] http://jpbrucker.net/sva/
[2] https://lkml.org/lkml/2020/1/15/604

Jacob Pan (2):
  iommu/vt-d: Report SVA feature with generic flag
  iommu/vt-d: Replace intel SVM APIs with generic SVA APIs

 drivers/iommu/intel-iommu.c |   8 +++
 drivers/iommu/intel-svm.c   | 123 ++++++++++++++++++++++++--------------------
 include/linux/intel-iommu.h |   7 +++
 include/linux/intel-svm.h   |  85 ------------------------------
 4 files changed, 83 insertions(+), 140 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
