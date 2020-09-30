Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46043C4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 18:11:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928102076A
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 18:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aalLhxTT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+0cpSGl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928102076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2554685A2E;
	Wed, 30 Sep 2020 18:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WnEN5RLgVcC7; Wed, 30 Sep 2020 18:11:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 98F4F8594B;
	Wed, 30 Sep 2020 18:11:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D43FC016F;
	Wed, 30 Sep 2020 18:11:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43C55C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 18:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 301B2867E3
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 18:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jOcDaWpd+6FV for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 18:11:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CE1ED849A6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 18:11:46 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1601489503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eXtBXXhiMVMdTYSCyK9KnC71AtIKQfsWx/V0UzZjSqs=;
 b=aalLhxTTFAUQOEA4S+jPMN0XZ7VE8ERlzT82B+AOWxenX32nsqgLWa/bYiqvfiOxx0w1Dc
 sV9R+Hp52bFesJRNB+HmHnqCYvBJXznlZPPdx+d9EwYl8ewLltm1Hcym/Ph1xDZyzKjJhL
 ZVs5Cw93bo+IiNxdmuCp3JcjzVSx6XSx551yPOrwgtVK/KEsPd0HKXZqyH23xMbaok4fD5
 my8dTS5Y90I/giCW/fia+Yn5S/NE4gRRwcr5l+mByPUetyDTSTO15kuyfJ0C1TdjqTXL+l
 vicJtFiTWlmeiyaxl2Tbjh5IEvtXABQE3fDj45VcPymN9gXwFrPKlNHV6tPRrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1601489503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eXtBXXhiMVMdTYSCyK9KnC71AtIKQfsWx/V0UzZjSqs=;
 b=+0cpSGl+ZP0wOxBV5o33UW0ETwb2OixJ9wUOzToxF/4Yxscw/i8EIRz4QPlc5qG84wdWZD
 QI0HtoTSaEP0J8Dg==
To: "Dey\, Megha" <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <e07aa723-12cd-7eb7-392a-642f96b98f79@intel.com>
References: <20200826111628.794979401@linutronix.de>
 <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
 <87v9fvix5f.fsf@nanos.tec.linutronix.de> <20200930114301.GD816047@nvidia.com>
 <87k0wbi94b.fsf@nanos.tec.linutronix.de>
 <e07aa723-12cd-7eb7-392a-642f96b98f79@intel.com>
Date: Wed, 30 Sep 2020 20:11:43 +0200
Message-ID: <878scri17k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, xen-devel@lists.xenproject.org,
 ravi.v.shankar@intel.com, Kevin Tian <kevin.tian@intel.com>,
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

Megha,

On Wed, Sep 30 2020 at 10:25, Megha Dey wrote:
> On 9/30/2020 8:20 AM, Thomas Gleixner wrote:
>>>> Your IMS patches? Why do you need something special again?
>
> By IMS patches, I meant your IMS driver patch that was updated (as it 
> was untested, it had some compile errors and we removed the IMS_QUEUE
> parts) :

Ok.

> The whole patchset can be found here:
>
> https://lore.kernel.org/lkml/f4a085f1-f6de-2539-12fe-c7308d243a4a@intel.com/
>
> It would be great if you could review the IMS patches :)

It somehow slipped through the cracks. I'll have a look.

> We were hoping to get IMS in the 5.10 merge window :)

Hope dies last, right?

>>> We might be able to put together a mockup just to prove it
>> If that makes Megha's stuff going that would of course be appreciated,
>> but we can defer the IMS_QUEUE part for later. It's orthogonal to the
>> IMS_ARRAY stuff.
>
> In our patch series, we have removed the IMS_QUEUE stuff and retained 
> only the IMS_ARRAY parts > as that was sufficient for us.

That works. We can add that back when Jason has his puzzle pieces
sorted.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
