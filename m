Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4016C433DF
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989C021775
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jSenzh6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C8u5XcoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989C021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77C1786A95;
	Wed, 26 Aug 2020 12:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GHbQ49eQY2YE; Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8DD70864EC;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC56C0891;
	Wed, 26 Aug 2020 12:01:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6911BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2D2BE228DB
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iAL7LytGi4Dc for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 5E832228E7
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:29 +0000 (UTC)
Message-Id: <20200826112333.234097629@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=s4SeYBthv8w4UR8KrcCzunKzBoXJmS11W4/9Ii+wPwg=;
 b=0jSenzh6VMcbo5+9rHYdiJaVUtSyatLMPnP8UId36opBJ9reS21zWdvIP9laqMLP72TxHN
 qJyfblVrn8J8N517J1EWmCfktvN/NZ1CtZN8nlF7bZid5zFAegxBMcdfQHQgHC+Gp90H7n
 9sESDryS5HzKppZp1LW/c/8dAAsikLDjI2lZJqftZV6DBFcT+b9vqq03XohIEfOcxWc38J
 6ES89Am49KT0SjmgVddjV0/u3LM1wfI75S6yDON/Jm2XufuKdlV2oFDfwlySAbkxdY492a
 CHmqsE5ke05SYtf5Cmr0DlQ88El+cd+cFGaXihvD7PXFoDTGLuoQC9YRKVzlDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=s4SeYBthv8w4UR8KrcCzunKzBoXJmS11W4/9Ii+wPwg=;
 b=C8u5XcoTZYCozPWWBT669Nb/bz2gzhwadoicELlzkl29EJb0qX+wUaZv2O6m5j6Ql9skbp
 WYNcQvMK17AqSGCQ==
Date: Wed, 26 Aug 2020 13:16:54 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 26/46] x86/xen: Make xen_msi_init() static and rename it to
 xen_hvm_msi_init()
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
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
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
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

From: Thomas Gleixner <tglx@linutronix.de>

The only user is in the same file and the name is too generic because this
function is only ever used for HVM domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross<jgross@suse.com>


---
 arch/x86/pci/xen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -420,7 +420,7 @@ int __init pci_xen_init(void)
 }
 
 #ifdef CONFIG_PCI_MSI
-void __init xen_msi_init(void)
+static void __init xen_hvm_msi_init(void)
 {
 	if (!disable_apic) {
 		/*
@@ -460,7 +460,7 @@ int __init pci_xen_hvm_init(void)
 	 * We need to wait until after x2apic is initialized
 	 * before we can set MSI IRQ ops.
 	 */
-	x86_platform.apic_post_init = xen_msi_init;
+	x86_platform.apic_post_init = xen_hvm_msi_init;
 #endif
 	return 0;
 }

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
