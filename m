Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF391C433FB
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FAF22B40
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Of+Oxpkc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k0Z1yJ4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FAF22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 70FD986CF3;
	Fri, 21 Aug 2020 02:17:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wq1x3ZFhM4Qo; Fri, 21 Aug 2020 02:17:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 274A186D10;
	Fri, 21 Aug 2020 02:17:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 197A8C0895;
	Fri, 21 Aug 2020 02:17:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4840DC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 37E558860A
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WM8f--4OSFOf for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:17:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ABB3A88607
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:20 +0000 (UTC)
Message-Id: <20200821002948.567751188@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=M8CXLVbtrCnxGI3OFdEQLd/7Ux+Id3N4Amh65gKqT6A=;
 b=Of+Oxpkc/LsAc1zkrOaY/uKmBg0Ssph3Hg8NPVLAZB6Rz4ocE9vRVizKVOKQId3+KRIf90
 EB2oJ0aLVFoOhDlYnQBiu7v/j21qk+X+niz+Cb3Cz5sDtTnwNd+48E+T8kfxxv3tt/1zDc
 wNumLL92ALO2+G7vNTpVvkuYV2b6mFMeonXF+86dMR7MNQFoHxp6ANnx8G/e5z5P1e7CTc
 8FdOnl0ommSUtSQgIMRghQmP9UOuDDmwzVhV5s7ULRCExH0baLYOY+/fem/p8fjnKcWXTR
 Fln/EO7YlEzne8pSeWCh4mQewsjAOK7KctGRD1IQO+fLPvTUfKsDmsUI6VUhSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=M8CXLVbtrCnxGI3OFdEQLd/7Ux+Id3N4Amh65gKqT6A=;
 b=k0Z1yJ4bJH/hCS7rfYd8jth/G93GUHenXzRI9GKdPxPIMVwzL0csUPbX2oiphTlZcgDgrW
 CzQcZs4FgbrM9lAg==
Date: Fri, 21 Aug 2020 02:24:57 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 33/38] x86/irq: Add DEV_MSI allocation type
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="x86-irq--Add-DEVMSI-allocation-type.patch"
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jonathan Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

For the upcoming device MSI support a new allocation type is
required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hw_irq.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -40,6 +40,7 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
 	X86_IRQ_ALLOC_TYPE_UV,
+	X86_IRQ_ALLOC_TYPE_DEV_MSI,
 	X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT,
 	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
