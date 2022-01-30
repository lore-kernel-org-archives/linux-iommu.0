Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53C6C433EF
	for <iommu@archiver.kernel.org>; Sun, 30 Jan 2022 07:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 797F840294;
	Sun, 30 Jan 2022 07:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RExG803P8TR4; Sun, 30 Jan 2022 07:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F3FE340243;
	Sun, 30 Jan 2022 07:43:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D61B5C0011;
	Sun, 30 Jan 2022 07:43:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81D2FC000B
 for <iommu@lists.linux-foundation.org>; Sun, 30 Jan 2022 07:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70DB26064D
 for <iommu@lists.linux-foundation.org>; Sun, 30 Jan 2022 07:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c6GPZh6sjU90 for <iommu@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 07:43:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E36F60644
 for <iommu@lists.linux-foundation.org>; Sun, 30 Jan 2022 07:43:26 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B307B387; Sun, 30 Jan 2022 08:43:22 +0100 (CET)
Date: Sun, 30 Jan 2022 08:43:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI bus rescan device hot add
Message-ID: <YfZBlzYTN/RfCGnE@8bytes.org>
References: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
 <20220128031002.2219155-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128031002.2219155-2-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Guoqing Jiang <guoqing.jiang@linux.dev>,
 Bernice <bernice.zhang@intel.com>, Zhang@8bytes.org
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

Hi Jacob, Baolu,

On Fri, Jan 28, 2022 at 11:10:01AM +0800, Lu Baolu wrote:
> During PCI bus rescan, adding new devices involve two notifiers.
> 1. dmar_pci_bus_notifier()
> 2. iommu_bus_notifier()
> The current code sets #1 as low priority (INT_MIN) which resulted in #2
> being invoked first. The result is that struct device pointer cannot be
> found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
> device is put under the "catch-all" IOMMU instead of the correct one.

There are actually iommu_ops pointers invoked from iommu_bus_notifier()
into IOMMU driver code. Can those be used to enforce the ordering in a
more reliable way?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
