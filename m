Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A17C433DB
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 14:11:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA3D6196C
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 14:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA3D6196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB7B84024E;
	Mon, 22 Mar 2021 14:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id McY4nhoUzcdD; Mon, 22 Mar 2021 14:11:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8B9440139;
	Mon, 22 Mar 2021 14:11:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E7CAC000A;
	Mon, 22 Mar 2021 14:11:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFF85C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 14:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE9DA4027F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 14:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cRfMlTzsxDt3 for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 14:11:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D34240272
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 14:11:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638EB1042;
 Mon, 22 Mar 2021 07:11:07 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.31])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA75C3F719;
 Mon, 22 Mar 2021 07:11:05 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, Jon Derrick <jonathan.derrick@intel.com>,
 iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 0/2] VMD MSI Remapping Bypass
Date: Mon, 22 Mar 2021 14:11:00 +0000
Message-Id: <161642217049.2836.9881489151722165383.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210210161315.316097-1-jonathan.derrick@intel.com>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Cc: Krzysztof Wilczynski <kw@linux.com>, Nirmal Patel <nirmal.patel@intel.com>,
 Kapil Karkra <kapil.karkra@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
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

On Wed, 10 Feb 2021 09:13:13 -0700, Jon Derrick wrote:
> The Intel Volume Management Device acts similar to a PCI-to-PCI bridge in that
> it changes downstream devices' requester-ids to its own. As VMD supports PCIe
> devices, it has its own MSI-X table and transmits child device MSI-X by
> remapping child device MSI-X and handling like a demultiplexer.
> 
> Some newer VMD devices (Icelake Server) have an option to bypass the VMD MSI-X
> remapping table. This allows for better performance scaling as the child device
> MSI-X won't be limited by VMD's MSI-X count and IRQ handler.
> 
> [...]

Applied to pci/vmd, thanks!

[1/2] iommu/vt-d: Use Real PCI DMA device for IRTE
      https://git.kernel.org/lpieralisi/pci/c/9b4a824b88
[2/2] PCI: vmd: Disable MSI-X remapping when possible
      https://git.kernel.org/lpieralisi/pci/c/ee81ee84f8

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
