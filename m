Return-Path: <SRS0=D+h4=F2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7226C433E0
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 06:53:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C992311D
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 06:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C992311D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=liamekaens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8D935271D9;
	Tue, 22 Dec 2020 06:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XHdg4xEMbzmi; Tue, 22 Dec 2020 06:53:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8229B21507;
	Tue, 22 Dec 2020 06:53:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6826AC1787;
	Tue, 22 Dec 2020 06:53:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1FC8C0893
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 06:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B3F8285FAD
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 06:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iLIHTQlxPwLb for <iommu@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 06:53:00 +0000 (UTC)
X-Greylist: delayed 00:09:23 by SQLgrey-1.7.6
Received: from sneak2.sneakemail.com (sneak2.sneakemail.com [64.46.159.148])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4610185FAC
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 06:53:00 +0000 (UTC)
Received: (sneakemail censored 23508-1608619415-327143 #2); 22 Dec 2020
 06:43:35 -0000
Received: (sneakemail censored 23508-1608619415-327143 #1); 22 Dec 2020
 06:43:35 -0000
Date: Tue, 22 Dec 2020 06:43:34 +0000
From: t9d5ndssym@liamekaens.com
To: iommu@lists.linux-foundation.org
Message-ID: <23508-1608619415-327143@sneakemail.com>
Subject: >16VFs fail on Xeon-E3 x16 Root Complex, work on Southbridge PCIe
 ; ACS or ARI issues?
MIME-Version: 1.0
X-Mailer: Perl5 Mail::Internet v
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

Hi all,

[Short version]
I'm trying enable 16 VFs on a Mellanox ConnectX-3 Gen3x8 PCIe card, which only enumerates <=8VFs if the card is used in the CPU's x16 PCIe slot but enumerates 16 VFs (or more) if placed into a Southbridge PCIe connector.  Tried with two differnet generations of Xeons, (1) Xeon E3-1240V3 / Asrock E3C222D4U (2) Xeon E3-1240LV5 / Asrock E3C236D4U and the results are same -- 16VFs fail if I use the PCIe x16 slot but works when using Southbridge PCIe.

To cover bases, the CX3 card has latest firmware (2.42.5000), configured for 
dual 10/40 GbE (not IB), SR-IOV & 16VFs enabled in the card, VT-x/VT-d enabled in the 
BIOS, kernel booted with intel_iommu=on.  Using Debian Buster 10 / have also 
tested with Arch Linux, default kernel driver and latest (4.9-2.2.4.0) driver 
from Mellanox, same errors.

Is this a kernel bug, a BIOS issue, a driver bug or a hardware limitation of the 
x16 PCIe Root Complex on these Xeon CPUs?  Could it be related to lack of ACS on the x16 interface or ARI not being properly enabled?

[Long version]
When using the the x16 slot after the first 8 total Virtual Functions, dmesg 
shows errors enumerating the further VFs there are complaints about "INTx" 
interrupts for these VFs (should be using MSI-X) and lspci shows (ff) for the 
additional VF devices.  CPUs has no internal GFX, system has ASPEED 
GFX/IPMI (attached via Southrbridge) and the CPU's x16 PCIe isn't occupied by 
anything else, have also tried the other x8 slot on motherboard which can be 
bifurcated from the x16 port with no positive difference.

However, if the CX3 card is placed into the Southbridge's PCIe, I CAN 
successfully allocate the 16 VFs I am looking for, lspci shows the devices as 
expected and there are no complaints about use of INTx interrupts and 
/proc/interrupts shows MSI-X for everything.

To further ensure this is not a user / driver configuration problem, I used the same 
Linux install between the two machines and a third Dell Precision Tower 5810 (Xeon E5)
(which could also enumerate >8 VFs) and have also tried building the Mellanox / 
nVidia "proprietary" driver and making sure the module is loaded with msi_x=1, 
the failure mode is exactly the same.

I can share dmesg, modprobe, lspci results but figured I'd abbreviate the mail if the answer is obvious.

Thank you!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
