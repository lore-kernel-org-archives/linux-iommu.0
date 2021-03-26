Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCAEC433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 15:09:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7086861A18
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 15:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7086861A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 196A740EA6;
	Fri, 26 Mar 2021 15:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3eNIm_j3WzJ; Fri, 26 Mar 2021 15:09:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACE6140555;
	Fri, 26 Mar 2021 15:09:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8029AC000E;
	Fri, 26 Mar 2021 15:09:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD93CC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 15:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B4E1A60C32
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 15:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="lFvg9nhC";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="runoOFyP"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TjZUuYpm10hf for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 15:09:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E559E6061B
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 15:09:15 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1616771352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=dSjIjx5Eeeu+KcGyXD3UGOYIXdlOREmUvOo1OvKWnzk=;
 b=lFvg9nhCllr59HQqFWmfeMeD/jj3su6D1ArVpw2Kw9ry0wCADyvNkxlV7P9fpFDvZ0stD8
 UUWMQaMPkOozEMcomZHk1KDxOTd9ltTMcK1J49eMmBqQ48ob1HK3dHdFRamC4Vq7rW1DxM
 pD7KVhD08pLYvtjWzdQ01/tzkw5YMXob/Jzaiedy5iQnGYhYGeibB1H/5Pk0hwp3yGM5mk
 TjhsS/l/a8JVhEEEkTdyujiX2GQlE8ugFFt17EpxgFIfoanPaE/x7HCBpP7b6MZ+fjIFZp
 4CGLYW6LvaRFkM1QwIJRNVNffhElVDwjERhKg8WbVx49drVAMmLwHOTNvzjdkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1616771352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=dSjIjx5Eeeu+KcGyXD3UGOYIXdlOREmUvOo1OvKWnzk=;
 b=runoOFyPk1go3143pg71blr13Xyuo/S3yL1dBJTZ5lpapTOGsab+6IsaGUvxa/G1HaAS3u
 KRMIcl+WfLfKcsCw==
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [Patch V2 08/13] genirq: Set auxiliary data for an interrupt
In-Reply-To: <87v99efbn6.wl-maz@kernel.org>
Date: Fri, 26 Mar 2021 16:09:11 +0100
Message-ID: <87h7kydka0.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, Megha Dey <megha.dey@intel.com>, bhelgaas@google.com,
 dan.j.williams@intel.com, dwmw@amazon.co.uk
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

On Fri, Mar 26 2021 at 10:32, Marc Zyngier wrote:
> On Thu, 25 Mar 2021 18:59:48 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> Though that leaves the question of the data type for 'val'. While u64 is
>> probably good enough for most stuff, anything which needs more than that
>> is left out (again). union as arguments are horrible especially if you
>> need the counterpart irq_get_auxdata() for which you need a pointer and
>> then you can't do a forward declaration. Something like this might work
>> though and avoid to make the pointer business unconditional:
>> 
>>         struct irq_auxdata {
>>                union {
>>         	     u64        val;
>>                      struct foo *foo;
>>                };
>>         };
>
> I guess that at some point, irq_get_auxdata() will become a
> requirement so we might as well bite the bullet now, and the above
> looks like a good start to me.

And because it's some time until rustification, we can come up with
something nasty like the below:

#define IRQ_AUXTYPE(t, m)       IRQ_AUXTYPE_ ## t

enum irq_auxdata_type {
        IRQ_AUXTYPE(U64,		val64),
        IRQ_AUXTYPE(IRQSTATE,		istate),
        IRQ_AUXTYPE(VCPU_AFFINITY,	vaff),
};

struct irq_auxdata {
        union {
                u64             val64;
                u8              istate;
                struct vcpu_aff *vaff;
       };
};

This does not protect you from accessing the wrong union member, but it
allows an analyzer to map IRQ_AUXTYPE_U64 to irq_auxdata::val64 and then
check both the call site and the implementation whether they fiddle with
some other member of irq_auxdata or do weird casts.

Maybe it's just nuts and has no value, but I had the urge to write some
nasty macros.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
