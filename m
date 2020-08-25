Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF896C433E1
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 21:30:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4DE206EB
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 21:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZVFEoRRl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x70sLQs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4DE206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5976B86B1F;
	Tue, 25 Aug 2020 21:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f3DSjW0mEwws; Tue, 25 Aug 2020 21:30:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E66AC86B13;
	Tue, 25 Aug 2020 21:30:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C096CC07FF;
	Tue, 25 Aug 2020 21:30:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EAEDC0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 137B0875CD
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XUlYeAxNFUMb for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 21:30:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B020E8696A
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:30:43 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598391042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=laLU5yxufmnFbi5ts+Ew5ZowSakjcO5PUqgrvOPNK+M=;
 b=ZVFEoRRlNJXFUgq6mQ2rduXlE2yad4xOmO34uYv0zEgHs0EncfZCre9kecOLZD0qyCUmIm
 fK/IA91Xv4YdestP0rW84OW5ZZqMJjbjso9OohwlJurrsXdtw0ybCtY6AJQtoUHjVvlvpz
 YMUdF+VrZgCxpTtiriD1TFTT0mADfgDYfGO0mJ/ZJWuV5BgLjH+scZb6eYP5Gg6K5n8dfA
 zzArbSiNPOkDqe2ro8oObhpqB71UKiq2qGT5YKQfOuP+ihQy5K+0KcqrFFA4jQkfQoRB9K
 cLIrHEKf3zeejhobeqwNwZWz6IoWsSqpvafIyP2+XFH9zXiVQCwVctTHzYueGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598391042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=laLU5yxufmnFbi5ts+Ew5ZowSakjcO5PUqgrvOPNK+M=;
 b=x70sLQs+vhFrFlF+FHbXLrFMyKKxpeRA9gYzPYp3g2ps1QJSE2dXtMNyCBRtV1YY3fSv8d
 R8wzoviTHQJFosAw==
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [patch RFC 34/38] x86/msi: Let pci_msi_prepare() handle non-PCI
 MSI
In-Reply-To: <20200825202419.GA1925250@bjorn-Precision-5520>
References: <20200825202419.GA1925250@bjorn-Precision-5520>
Date: Tue, 25 Aug 2020 23:30:41 +0200
Message-ID: <877dtmxvjy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
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
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

On Tue, Aug 25 2020 at 15:24, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2020 at 02:24:58AM +0200, Thomas Gleixner wrote:
>> Rename it to x86_msi_prepare() and handle the allocation type setup
>> depending on the device type.
>
> I see what you're doing, but the subject reads a little strangely

Yes :(

> ("pci_msi_prepare() handling non-PCI" stuff) since it doesn't mention
> the rename.  Maybe not practical or worthwhile to split into a rename
> + make generic, I dunno.

What about

x86/msi: Rename and rework pci_msi_prepare() to cover non-PCI MSI

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
