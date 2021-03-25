Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7FDC433E1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 18:59:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAC061A1A
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 18:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAC061A1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3080D40F04;
	Thu, 25 Mar 2021 18:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6QWWBGTPrqN; Thu, 25 Mar 2021 18:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBA1740645;
	Thu, 25 Mar 2021 18:59:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 895E4C000E;
	Thu, 25 Mar 2021 18:59:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68A83C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 492B340F04
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IGa33it3jmhO for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 18:59:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6491E40645
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:59:51 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1616698788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/p64BufgVH9g51vdo+tdjRTIo004u23/9QlrIozmDs=;
 b=Tz9I0ZCzmEcJ0RLWv4hoKx04BqEYq6oH8MBEaejHx534tWCfSODFAFXp96n3GQkUMsFoG1
 r6X9S5Sf8Xy+Qi7IUmU3s+cSXBTY8q6lBOre9EOMr5JPtt+dl9SmV+Gwa2b1xulOLq+NyW
 dHi7TSFcS+eKXobxhdGBnZoF5P9UBpFTE20bRBS0chIq3A95tPYv//HbbLuW8w8A3RQZ6K
 knzBCFnv3XrsYl6SF/a2yhfbM5r/lvhJiD19au5RbsZwvUohe7MoE1bjFTWVt9zkaGQ8Vx
 6YAM3e1uD3AP7tpeu5a7EXaxnopU0G7jhfym5Ne5VUllr0J1oa9+lHaVavwHIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1616698788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/p64BufgVH9g51vdo+tdjRTIo004u23/9QlrIozmDs=;
 b=zm2kjDs/iCzE5MKpJJ1nUJ/2rivtSgTWniubBpLqQAw39kWsdPDVZU1Pko+Aom4Bj965YF
 q+h7jShqaTt8mtBA==
To: Marc Zyngier <maz@kernel.org>, Megha Dey <megha.dey@intel.com>
Subject: Re: [Patch V2 08/13] genirq: Set auxiliary data for an interrupt
In-Reply-To: <871rc3rvuc.wl-maz@kernel.org>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
 <1614370277-23235-9-git-send-email-megha.dey@intel.com>
 <871rc3rvuc.wl-maz@kernel.org>
Date: Thu, 25 Mar 2021 19:59:48 +0100
Message-ID: <87im5fvz2z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, bhelgaas@google.com, dan.j.williams@intel.com,
 dwmw@amazon.co.uk
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

On Thu, Mar 25 2021 at 17:23, Marc Zyngier wrote:
>> +/**
>> + * irq_set_auxdata - Set auxiliary data
>> + * @irq:	Interrupt to update
>> + * @which:	Selector which data to update
>> + * @auxval:	Auxiliary data value
>> + *
>> + * Function to update auxiliary data for an interrupt, e.g. to update data
>> + * which is stored in a shared register or data storage (e.g. IMS).
>> + */
>> +int irq_set_auxdata(unsigned int irq, unsigned int which, u64 val)
>
> This looks to me like a massively generalised version of
> irq_set_irqchip_state(), only without any defined semantics when it
> comes to the 'which' state, making it look like the irqchip version of
> an ioctl.
>
> We also have the irq_set_vcpu_affinity() callback that is used to
> perpetrate all sort of sins (and I have abused this interface more
> than I should admit it).
>
> Can we try and converge on a single interface that allows for
> "side-band state" to be communicated, with documented state?
>
>> +{
>> +	struct irq_desc *desc;
>> +	struct irq_data *data;
>> +	unsigned long flags;
>> +	int res = -ENODEV;
>> +
>> +	desc = irq_get_desc_buslock(irq, &flags, 0);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	for (data = &desc->irq_data; data; data = irqd_get_parent_data(data)) {
>> +		if (data->chip->irq_set_auxdata) {
>> +			res = data->chip->irq_set_auxdata(data, which, val);
>
> And this is where things can break: because you don't define what
> 'which' is, you can end-up with two stacked layers clashing in their
> interpretation of 'which', potentially doing the wrong thing.
>
> Short of having a global, cross architecture definition of all the
> possible states, this is frankly dodgy.

My bad, I suggested this in the first place.

So what you suggest is to make 'which' an enum and have that in
include/linux/whatever.h so we end up with unique identifiers accross
architectures, irqdomains and whatever, right?

That makes a lot of sense.

Though that leaves the question of the data type for 'val'. While u64 is
probably good enough for most stuff, anything which needs more than that
is left out (again). union as arguments are horrible especially if you
need the counterpart irq_get_auxdata() for which you need a pointer and
then you can't do a forward declaration. Something like this might work
though and avoid to make the pointer business unconditional:

        struct irq_auxdata {
               union {
        	     u64        val;
                     struct foo *foo;
               };
        };

Thanks,

        tglx




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
