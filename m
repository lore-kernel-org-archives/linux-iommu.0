Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D16C433E4
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACBF20B1F
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cRxNY6q4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qSPUnSes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACBF20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CEF8A86FE7;
	Wed, 26 Aug 2020 12:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tt-Wm6gDh-Gn; Wed, 26 Aug 2020 12:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A7BB87B94;
	Wed, 26 Aug 2020 12:01:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB1B2C0051;
	Wed, 26 Aug 2020 12:01:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB671C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AA2C68633E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FwKPhozucaY8 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E964886AF2
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:21 +0000 (UTC)
Message-Id: <20200826112332.658496557@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=b4bGIil7bipa/5kRCGwLR6ysbuS705o3f6zVCEpgylA=;
 b=cRxNY6q4LD/qHQC5Xo0FZAvJhkMhdFi+cHQ4Jj7FlYWljEI49HYpMgeULtRuZ4BnVjs7du
 mvAren+Txod753wg+6pyzdEQg/Z596Zf0s0EImMYDPCN0TucaGcDFZKa31K6/ZQaZZxVRW
 6bVlvZWqJTEAHcTNGb+tNnOVHkP07vPvDT3DOSv+m0qWFbLWC5Jtn1AcRGfjyw5aDwIttl
 dM2ajV3sBaH8zQbs3Qga0yV5zHBpraCiSLRPf/aA3sRPVyszjgcqimWSj6lJoWyexV70yT
 QCRcEx+/PcnvfQwSHz2Ju6mwxxFx7nKha8ZZYUB5hr1Vq52e6/uSd6XA9Ikx5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=b4bGIil7bipa/5kRCGwLR6ysbuS705o3f6zVCEpgylA=;
 b=qSPUnSeslpA0/D/c0Wds3lF32+rYjaFAhwCnjhz0P2c0Mmhu1EcCv1mmL4jo7S0ApmHD+F
 95+es/w/dVUH7hDQ==
Date: Wed, 26 Aug 2020 13:16:48 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 20/46] x86/irq: Move apic_post_init() invocation to one
 place
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

No point to call it from both 32bit and 64bit implementations of
default_setup_apic_routing(). Move it to the caller.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/apic/apic.c     |    3 +++
 arch/x86/kernel/apic/probe_32.c |    3 ---
 arch/x86/kernel/apic/probe_64.c |    3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1429,6 +1429,9 @@ void __init apic_intr_mode_init(void)
 		break;
 	}
 
+	if (x86_platform.apic_post_init)
+		x86_platform.apic_post_init();
+
 	apic_bsp_setup(upmode);
 }
 
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -170,9 +170,6 @@ void __init default_setup_apic_routing(v
 
 	if (apic->setup_apic_routing)
 		apic->setup_apic_routing();
-
-	if (x86_platform.apic_post_init)
-		x86_platform.apic_post_init();
 }
 
 void __init generic_apic_probe(void)
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -32,9 +32,6 @@ void __init default_setup_apic_routing(v
 			break;
 		}
 	}
-
-	if (x86_platform.apic_post_init)
-		x86_platform.apic_post_init();
 }
 
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
