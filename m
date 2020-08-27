Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4642C433DF
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 10:02:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784ED2075B
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 10:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784ED2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4AF408842A;
	Thu, 27 Aug 2020 10:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KYMG-uuHRUW; Thu, 27 Aug 2020 10:02:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 752C38840E;
	Thu, 27 Aug 2020 10:02:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5270EC07FF;
	Thu, 27 Aug 2020 10:02:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79EABC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 10:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5F4FC2042D
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 10:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-CJ5GkUUSyh for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 10:02:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS1.zhaoxin.com (unknown [203.148.12.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 057EC21FA9
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 10:02:35 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 27 Aug
 2020 18:02:26 +0800
Received: from localhost.localdomain (61.148.245.65) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 27 Aug
 2020 18:02:24 +0800
From: FelixCuioc <FelixCui-oc@zhaoxin.com>
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 <kbuild@lists.01.org>
Subject: [PATCH v3 0/2] Add support for ACPI device in RMRR 
Date: Thu, 27 Aug 2020 06:02:15 -0400
Message-ID: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [61.148.245.65]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Cc: TonyWWang-oc@zhaoxin.com, CobeChen-oc@zhaoxin.com
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

BIOS allocate reserved memory ranges that may be DMA targets.
BIOS may report each such reserved memory region through the
RMRR structures,along with the devices that requires access to
the specified reserved memory region.

The purpose of this series is to achieve ACPI device in RMRR
access reserved memory.Therefore,it is necessary to increase
the analysis of acpi device in RMRR and establish a mapping
for this device.

The first patch adds interfaces for detecting ACPI device
in RMRR and in order to distinguish it from pci device,
some interface functions are modified.

The second patch adds support for probing ACPI device in RMRR.
In probe_acpi_namespace_devices(),add support for direct mapping
of ACPI device and add support for physical node of acpi device
to be NULL.

v2->v3:
   - Add the blank line between functions.
   - Make dmar_acpi_insert_dev_scope() bool,change the 1/0 to true/false
     and add a comment explaining.
   - Delete unused initialization.
   - if dmar_acpi_insert_dev_scope() always returns zero,will not
     call dmar_rmrr_add_acpi_dev().
   - Use a proper error code.
   - Use if(!pdev).
   - Use goto unlock instead of mutex_unlock().


FelixCuioc (2):
  iommu/vt-d:Add support for detecting ACPI device in RMRR
  iommu/vt-d:Add support for probing ACPI device in RMRR

 drivers/iommu/intel/dmar.c  | 76 +++++++++++++++++++++----------------
 drivers/iommu/intel/iommu.c | 52 ++++++++++++++++++++++++-
 drivers/iommu/iommu.c       |  6 +++
 include/linux/dmar.h        | 12 +++++-
 include/linux/iommu.h       |  3 ++
 5 files changed, 114 insertions(+), 35 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
