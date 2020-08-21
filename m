Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F30C433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB1820FC3
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KiXQi33X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNTKZwPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB1820FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0550D2309D;
	Fri, 21 Aug 2020 19:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bplmYtGgXRBV; Fri, 21 Aug 2020 19:47:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B55DA230FB;
	Fri, 21 Aug 2020 19:47:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CE48C0889;
	Fri, 21 Aug 2020 19:47:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72207C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 615BF887D3
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlTcrgSHtI1Q for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 19:47:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AB001887D1
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:47:47 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598039264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oc6rWuK4RWluEJBMD17wpMBfxGYcOFdDWSkk5lcadvw=;
 b=KiXQi33Xg/nd2cc5p/iAKtPJMeJNOzlCIzhWjWEbDdZsQcUjTDcZub6BshDwVTeuzhZGv3
 zw2QKFIaV6T0xnr0tMl0umwZIX8sVQuHMEUfRQUVCSNH+RS3Ctu3yRElL1RDrH9OSkUBvR
 Tsr3wMNO6B9xByzMz6gnGKvZsy58iZhaXxtRYkjnJJ3WTiyQxefyan9gZqT9mGBT6u+xX7
 879KRDH1ZIZQf7iaP+awji6DDAUxA8bYq12w27+m5dPt9dX2xBuAi7ENRI59fAae7fEgGi
 t8GgtNuJOLOuihUaToMYiDcn5kSYsxXPj3V4PLzYavwP+TAnb34LXNCN2fVjfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598039264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oc6rWuK4RWluEJBMD17wpMBfxGYcOFdDWSkk5lcadvw=;
 b=ZNTKZwPc7JAJl8Qd563jtK8cr0w4Fu55mv5EH+kVE+8/1HT5hcM/atj4LWnPcJrRJGhXkM
 niAVH0dbiv4S6wAA==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch RFC 38/38] irqchip: Add IMS array driver - NOT FOR MERGING
In-Reply-To: <20200821124547.GY1152540@nvidia.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002949.049867339@linutronix.de>
 <20200821124547.GY1152540@nvidia.com>
Date: Fri, 21 Aug 2020 21:47:43 +0200
Message-ID: <874kovsrvk.fsf@nanos.tec.linutronix.de>
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

On Fri, Aug 21 2020 at 09:45, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2020 at 02:25:02AM +0200, Thomas Gleixner wrote:
>> +static void ims_mask_irq(struct irq_data *data)
>> +{
>> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
>> +	struct ims_array_slot __iomem *slot = desc->device_msi.priv_iomem;
>> +	u32 __iomem *ctrl = &slot->ctrl;
>> +
>> +	iowrite32(ioread32(ctrl) & ~IMS_VECTOR_CTRL_UNMASK, ctrl);
>
> Just to be clear, this is exactly the sort of operation we can't do
> with non-MSI interrupts. For a real PCI device to execute this it
> would have to keep the data on die.

We means NVIDIA and your new device, right?

So if I understand correctly then the queue memory where the MSI
descriptor sits is in RAM.

How is that supposed to work if interrupt remapping is disabled?

That means irq migration and proper disabling of an interrupt become an
interesting exercise. I'm so not looking forward to that.

If interrupt remapping is enabled then both are trivial because then the
irq chip can delegate everything to the parent chip, i.e. the remapping
unit.

Can you please explain that a bit more precise?

> I saw the idxd driver was doing something like this, I assume it
> avoids trouble because it is a fake PCI device integrated with the
> CPU, not on a real PCI bus?

That's how it is implemented as far as I understood the patches. It's
device memory therefore iowrite32().

> It is really nice to see irq_domain used properly in x86!

If you ignore the abuse in XEN :)

And to be fair proper and usable (hierarchical) irq domains originate
from x86 and happened to solve quite a few horrorshows on the ARM side.

Just back then when we converted the original maze, nobody had a good
idea and the stomach to touch XEN.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
