Return-Path: <SRS0=4upI=CB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08188C433E1
	for <iommu@archiver.kernel.org>; Sun, 23 Aug 2020 08:03:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26F920767
	for <iommu@archiver.kernel.org>; Sun, 23 Aug 2020 08:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OSUGo4PT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMc6ZKpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26F920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6211920371;
	Sun, 23 Aug 2020 08:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsFp91EK9mUD; Sun, 23 Aug 2020 08:03:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 290CA2014A;
	Sun, 23 Aug 2020 08:03:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBD8C016F;
	Sun, 23 Aug 2020 08:03:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50198C0051
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 08:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 481C585F55
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 08:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3CjOHmizLQ07 for <iommu@lists.linux-foundation.org>;
 Sun, 23 Aug 2020 08:03:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AA3E785F53
 for <iommu@lists.linux-foundation.org>; Sun, 23 Aug 2020 08:03:11 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598169788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1r81LXAzLVDLyLks6MQQbnmtJ0OK+dyyaovYHtczdF8=;
 b=OSUGo4PT4Ot+VGZW7JgEcWsC8MLwYCCnwHNCt3TYiEzvYBVXe45Rvl3FX/Y0isC1ShdQQ3
 RIh/bv3QSwwzvd8iYJBo7gkkwrPBgPqWBWG0qyIj42/W8ULqyGPqdtcmY9SWXIe6qo1A1Q
 G8rQ4XqyV5X9tf+kKzjK0R1QN5bjpdFSWtGLnHuCi+FXplbjlm/gIBBAoZuWJKD4qsyf1+
 E4sJhAD2xn/VQyYp3NoK60i70Z16VK3CVNEGe2YhdqoIM5dCPu+czaZXI3Of9hT7hNOiiq
 KycdvEqCmdiPmuLVuylio+jeqSn+LdOfVq0686G5ly9H6MwoSrM+c5IPwwJFcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598169788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1r81LXAzLVDLyLks6MQQbnmtJ0OK+dyyaovYHtczdF8=;
 b=tMc6ZKpqYdgSdwXa7ZmkDUuCxCEpdWuXt4VgP89zL1RSX0c8gVXVItieBv1Rh/DCd8vqw0
 Q7nUMe69k9VLtDAQ==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch RFC 38/38] irqchip: Add IMS array driver - NOT FOR MERGING
In-Reply-To: <20200822230511.GD1152540@nvidia.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002949.049867339@linutronix.de>
 <20200821124547.GY1152540@nvidia.com>
 <874kovsrvk.fsf@nanos.tec.linutronix.de>
 <20200821201705.GA2811871@nvidia.com>
 <87pn7jr27z.fsf@nanos.tec.linutronix.de>
 <20200822005125.GB1152540@nvidia.com>
 <874kovqx8q.fsf@nanos.tec.linutronix.de>
 <20200822230511.GD1152540@nvidia.com>
Date: Sun, 23 Aug 2020 10:03:07 +0200
Message-ID: <875z99ssas.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Wei Liu <wei.liu@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Sat, Aug 22 2020 at 20:05, Jason Gunthorpe wrote:
> On Sat, Aug 22, 2020 at 03:34:45AM +0200, Thomas Gleixner wrote:
> As a silicon design it might work, but it means existing devices can't
> be used with this dev_msi. It is also the sort of thing that would
> need a standard document to have any hope of multiple vendors fitting
> into it. Eg at PCI-SIG or something.

Fair enough.

>> If you don't do that then you simply can't write to that space from the
>> CPU and you have to transport this kind information always via command
>> queues.
>
> Yes, exactly. This is part of the architectural design of the device,
> has been for a long time. Has positives and negatives.

As always and it clearly follows the general HW design rule "we can fix
that in software".

>> > I suppose the core code could provide this as a service? Sort of a
>> > varient of the other lazy things above?
>> 
>> Kinda. That needs a lot of thought for the affinity setting stuff
>> because it can be called from contexts which do not allow that. It's
>> solvable though, but I clearly need to stare at the corner cases for a
>> while.
>
> If possible, this would be ideal, as we could use the dev_msi on a big
> installed base of existing HW.

I'll have a look, but I'm surely not going to like the outcome.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
