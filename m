Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26242C3F68F
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 10:24:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0403920716
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 10:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0403920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D2D9685C11;
	Tue, 17 Dec 2019 10:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TeDrUZwIcSia; Tue, 17 Dec 2019 10:24:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A61E85BD5;
	Tue, 17 Dec 2019 10:24:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66A08C1AE8;
	Tue, 17 Dec 2019 10:24:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8708C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9E6B487919
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vs+HCy-KmhsA for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 10:24:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E754F8778F
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:24:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 6A0DD286; Tue, 17 Dec 2019 11:24:43 +0100 (CET)
Date: Tue, 17 Dec 2019 11:24:42 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
Message-ID: <20191217102441.GN8689@8bytes.org>
References: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
 <20191210223745.GA167002@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191210223745.GA167002@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Safonov <dima@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
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

Hi Bjorn,

On Tue, Dec 10, 2019 at 04:37:45PM -0600, Bjorn Helgaas wrote:
> Heads up Joerg: I also updated drivers/iommu/amd_iommu.c (this is the
> one reported by the kbuild test robot) and removed the printk there
> that prints the same thing as the one in pci_add_dma_alias(), and I
> updated a PCI quirk that was merged after this patch was posted.

Fine with me, thanks for the heads up.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
