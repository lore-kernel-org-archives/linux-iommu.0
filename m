Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70975C433DF
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 21:20:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3173820737
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 21:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pvKvB1AM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oWrjSaUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3173820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E014E87954;
	Wed, 26 Aug 2020 21:20:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A50yyhWNk0Li; Wed, 26 Aug 2020 21:20:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3BB548789A;
	Wed, 26 Aug 2020 21:20:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB5AC07FF;
	Wed, 26 Aug 2020 21:20:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E23C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 21:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1A71986BA4
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 21:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ogV6RxW3PtYx for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 21:19:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 77B9586BA1
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 21:19:59 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598476797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYZnB7uf4zw+g6DBBef5reqPEj8a0j4M5RX3zdOOKzc=;
 b=pvKvB1AMMg61vF3fuuFlE/MjubeGYv3ru+dZbTvHajwgBVYvAEQefT04IBXFOezkguPQmN
 /CZWOdtXKlQmE8ObjUoPwGvTbYZfMrTtdvjVYhynH8BTWRfQ0kCVBtP+xO5yNuaFZlTyoB
 YfFVLUqTCqkdxpR7lkPmYqNGoB43zk5UlwhM33f8pFT3UDs0fKUTc+N48y18DXhTyrikLB
 Cn4e2VBH7/Fb0KqpKDKd2gzoGZZSVES7hQWMowj45Xk7MA5bYvJBJMqC5hQufiBX92bva3
 oTxipIX/Q7LReXbW3YfAemOe94IuUH+vGtqhQh0JAvhW7MdTZUObynzmLOAwFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598476797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYZnB7uf4zw+g6DBBef5reqPEj8a0j4M5RX3zdOOKzc=;
 b=oWrjSaUuvxZFWVKpzIddniXB4pV/MwolflT+zDiuc64L+U6Z6uqVmYilcDAgH4c1Moq+9p
 bsm+zr1NkfquxRCw==
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [patch V2 04/46] genirq/chip: Use the first chip in
 irq_chip_compose_msi_msg()
In-Reply-To: <87a6yh2nln.wl-maz@kernel.org>
References: <20200826111628.794979401@linutronix.de>
 <20200826112331.047917603@linutronix.de> <87a6yh2nln.wl-maz@kernel.org>
Date: Wed, 26 Aug 2020 23:19:56 +0200
Message-ID: <87o8mxt88z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 x86@kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
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

On Wed, Aug 26 2020 at 20:50, Marc Zyngier wrote:
> On Wed, 26 Aug 2020 12:16:32 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> ---
>> V2: New patch. Note, that this might break other stuff which relies on the
>>     current behaviour, but the hierarchy composition of DT based chips is
>>     really hard to follow.
>
> Grepping around, I don't think there is any occurrence of two irqchips
> providing irq_compose_msi() that can share a hierarchy on any real
> system, so we should be fine. Famous last words.

Knocking on wood :)

>>  #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>> -	for (; data; data = data->parent_data)
>> -#endif
>> -		if (data->chip && data->chip->irq_compose_msi_msg)
>> +	for (; data; data = data->parent_data) {
>> +		if (data->chip && data->chip->irq_compose_msi_msg) {
>>  			pos = data;
>> +			break;
>> +		}
>> +	}
>> +#else
>> +	if (data->chip && data->chip->irq_compose_msi_msg)
>> +		pos = data;
>> +#endif
>>  	if (!pos)
>>  		return -ENOSYS;
>
> Is it just me, or is this last change more complex than it ought to
> be?

Kinda.

> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 857f5f4c8098..25e18b73699c 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1544,7 +1544,7 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct irq_data *pos = NULL;
>  
>  #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
> -	for (; data; data = data->parent_data)
> +	for (; data && !pos; data = data->parent_data)
>  #endif
>  		if (data->chip && data->chip->irq_compose_msi_msg)
>  			pos = data;
>
> Though the for loop in a #ifdef in admittedly an acquired taste...

Checking !pos is simpler obviously. That doesn't make me hate the loop
in the #ifdef less. :)

What about the below?

Thanks,

        tglx
---
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -473,6 +473,15 @@ static inline void irq_domain_deactivate
 }
 #endif
 
+static inline struct irq_data *irqd_get_parent_data(struct irq_data *irqd)
+{
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irqd->parent_data;
+#else
+	return NULL;
+#endif
+}
+
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 #include <linux/debugfs.h>
 
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1541,18 +1541,17 @@ EXPORT_SYMBOL_GPL(irq_chip_release_resou
  */
 int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_data *pos = NULL;
+	struct irq_data *pos;
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	for (; data; data = data->parent_data)
-#endif
+	for (pos = NULL; !pos && data; data = irqd_get_parent_data(data)) {
 		if (data->chip && data->chip->irq_compose_msi_msg)
 			pos = data;
+	}
+
 	if (!pos)
 		return -ENOSYS;
 
 	pos->chip->irq_compose_msi_msg(pos, msg);
-
 	return 0;
 }
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
