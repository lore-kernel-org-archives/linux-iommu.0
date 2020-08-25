Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50765C433DF
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 21:28:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA0F20738
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 21:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOoYjJYv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQR1S/0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA0F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3176875CD;
	Tue, 25 Aug 2020 21:28:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WjloR6XFxI4T; Tue, 25 Aug 2020 21:28:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 51402875D1;
	Tue, 25 Aug 2020 21:28:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37062C07FF;
	Tue, 25 Aug 2020 21:28:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9C04C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D8362875D1
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:28:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pcKEoiJR8Bbj for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 21:28:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 11D1B875CD
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:28:33 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598390910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DM8kbYiy7ZvYakB3fMHVSwg1j58bcLwh1sILIYH/AFI=;
 b=tOoYjJYvUPFZDmOguQPFJDhQeHuqRavvHi/bJrAyTkchveyhC+en4z3ohJa6FmPIHI2vow
 qc9HQ8/FTpaHEhGVpgURbiV1lVl+XKejxCXJmH2j3Sj2h8nwPHrrK3/Kb6Do9W3PTncSXY
 TOuqFSROfKTujH662yP4shxjPWBDkywHOauPnwUWRRiR+DHAaP2psLdtuzSJtmNFJD79PB
 hjeXftohGgS9rC9Xb2dZuw6mNwzd/d9QfmdUvlkZy88Ftt7fM3r9rWu4L7KrgJ8gocSx1K
 eGa2PZEjfsTIQ/LxJMcJsM3xNXGuHKDY89giMPP0/QzKHuUEf3bJ22fUusSPsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598390910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DM8kbYiy7ZvYakB3fMHVSwg1j58bcLwh1sILIYH/AFI=;
 b=oQR1S/0DMHh75hr94qI0low3SKHVQ7r24k+kTQlDcy/nGiegnvAQmFWoo65Pv64XBO7xgV
 AXir3AUyBr42qvBg==
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [patch RFC 30/38] PCI/MSI: Allow to disable arch fallbacks
In-Reply-To: <20200825200742.GA1924669@bjorn-Precision-5520>
References: <20200825200742.GA1924669@bjorn-Precision-5520>
Date: Tue, 25 Aug 2020 23:28:30 +0200
Message-ID: <87a6yixvnl.fsf@nanos.tec.linutronix.de>
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

On Tue, Aug 25 2020 at 15:07, Bjorn Helgaas wrote:
>> + * The arch hooks to setup up msi irqs. Default functions are implemented
>> + * as weak symbols so that they /can/ be overriden by architecture specific
>> + * code if needed.
>> + *
>> + * They can be replaced by stubs with warnings via
>> + * CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS when the architecture fully
>> + * utilizes direct irqdomain based setup.
>
> Do you expect *all* arches to eventually use direct irqdomain setup?

Ideally that happens some day. We have five left when x86 is converted:

IA64, MIPS, POWERPC, S390, SPARC

IA64 is unlikely to be fixed, but might be solved naturally by removal.

For the others I don't know, but it's not on the horizon anytime soon I
fear.

> And in that case, to remove the config option?

Yes, and all the code which depends on it.

> If not, it seems like it'd be nicer to have the burden on the arches
> that need/want to use arch-specific code instead of on the arches that
> do things generically.

Right, but they still share the common code there and some of them
provide only parts of the weak callbacks. I'm not sure whether it's a
good idea to copy all of this into each affected architecture.

Or did you just mean that those architectures should select
CONFIG_I_WANT_THE CRUFT instead of opting out on the fully irq domain
based ones?

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
