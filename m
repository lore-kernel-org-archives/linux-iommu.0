Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7EAC433DF
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 20:50:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3BA2078D
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 20:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4YbUFCt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aS6JntOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3BA2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA9E18829B;
	Wed, 26 Aug 2020 20:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JF4igqFDh4RN; Wed, 26 Aug 2020 20:50:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0C315882B0;
	Wed, 26 Aug 2020 20:50:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D732FC016F;
	Wed, 26 Aug 2020 20:50:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63DA0C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 20:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 51E3A86ACE
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 20:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GD6VqtzipBck for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 20:50:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A93EA8073A
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 20:50:17 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598475014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JG/TkMq9NWC6OfHgPC/IbFpW4xr9Kt9L0ix/14aZbxc=;
 b=s4YbUFCtbJEMrLqgKd7OwtYh18vHyM4HfQLj0mVtwmVQVO9mPe+rbcu9/9RQcu7BDqxIXq
 4SC8x5F55ReokeL0LN8UUQFD5m3BjRCcVnOHVA++cJ3n9iGLghzLvQHLb6sr4Opghelyw7
 wtiHRsopz/7aQ7mxdNa4ubr9zMjw6kUfb9G723x0mquWT/8sbYu95BnkyTknE0X6c2XJfj
 G2IbL55VnbnoeT093T8n8BdlC4i9HNmIpjyrPxF0OWHJtvkDyBhZ80We7p7G5tVUd/JFYJ
 lndw1zv+U67ElbvOK78N7X9qxyNKvPXDl0P5nwVk071fVAGS++QK4AuCw0xoVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598475014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JG/TkMq9NWC6OfHgPC/IbFpW4xr9Kt9L0ix/14aZbxc=;
 b=aS6JntODH9ZvZZJHE2vQuw6G8LnzzNi8bSa6D1XA+HMxu+eOePiLVi0SGkTN8Uz37jCbMJ
 TOeuyIqSX/IO5mCA==
To: "Dey\, Megha" <megha.dey@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch V2 15/46] x86/irq: Consolidate DMAR irq allocation
In-Reply-To: <878se1uulb.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.163462706@linutronix.de>
 <812d9647-ad2e-95e9-aa99-b54ff7ebc52d@intel.com>
 <878se1uulb.fsf@nanos.tec.linutronix.de>
Date: Wed, 26 Aug 2020 22:50:13 +0200
Message-ID: <87r1rtt9mi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
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

On Wed, Aug 26 2020 at 20:32, Thomas Gleixner wrote:
> On Wed, Aug 26 2020 at 09:50, Megha Dey wrote:
>>> @@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
>>>   static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
>>>   					  msi_alloc_info_t *arg)
>>>   {
>>> -	return arg->dmar_id;
>>> +	return arg->hwirq;
>>
>> Shouldn't this return the arg->devid which gets set in dmar_alloc_hwirq?
>
> Indeed.

But for simplicity we can set arg->hwirq to the dmar id right in the
alloc function and then once the generic ops are enabled remove the dmar
callback completely.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
