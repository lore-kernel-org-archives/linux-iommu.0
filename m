Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3305C4742C
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 13:52:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE762078D
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 13:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ayNoDTQA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8h7nBkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE762078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2A58A87820;
	Fri, 13 Nov 2020 13:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3Oc4sd8xCRD; Fri, 13 Nov 2020 13:52:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 97B68877E6;
	Fri, 13 Nov 2020 13:52:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79369C0891;
	Fri, 13 Nov 2020 13:52:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E73F1C0800
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 13:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D18BE87816
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 13:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-UfofHDxbre for <iommu@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:52:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3760E877E6
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 13:52:31 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1605275547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xsSnKN0Y2j/jQ2IRBao4uClTn5UrQq6Zg7g/UkqX+lo=;
 b=ayNoDTQA8qN45li0yGYUyxDleZJkOg5NfkWvLrESAsBTP7HmGH+rsHryn2bNTDxixwa5H7
 UmIPAIT1Hacp/6y9T8dmqEt6Bvhspdyb06B6qG0TOEECmj+hlLfGqkOdQvfb0iSc5gak4J
 oBcUXRxTY2W9ABYeWH0ECE7h42DLdDApf+ow7Sr2U7HVZy3kXUWcoZKEOgJQc61hJyygFC
 C86gRbCf9R81w17QQmbm1X0bphCgaakqz4VhVEEMeRTKnFFXH2m4zJHkVapUcojXJDSDzf
 5/MGaf2atprYOuKwQopa03uoDwZi7/7blEcq2I7a1OeY9rFD7gqjfVXM8NQvFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1605275547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xsSnKN0Y2j/jQ2IRBao4uClTn5UrQq6Zg7g/UkqX+lo=;
 b=X8h7nBkZIVQfOzZvoYR42UafxIu8Yci8xE9VWP/nM/wn3IGE5v2RPyiosOcb53/JPb8fNi
 m1VFqaGW00FwpFDw==
To: Marc Zyngier <maz@kernel.org>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <2196b03a44a15fdc37223040197c4ac5@kernel.org>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
 <87a6vmmf8h.fsf@nanos.tec.linutronix.de>
 <2196b03a44a15fdc37223040197c4ac5@kernel.org>
Date: Fri, 13 Nov 2020 14:52:27 +0100
Message-ID: <87wnypl5yc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Itay Aveksis <itayav@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>,
 linux-pci@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, Nov 13 2020 at 09:19, Marc Zyngier wrote:
> On 2020-11-12 21:34, Thomas Gleixner wrote:
>> That would allow to add a irq_find_matching_fwspec() based lookup to
>> pci_msi_get_device_domain().
>
> Just so that I understand the issue: is the core of the problem that
> there is no 1:1 mapping between a PCI bus and a DMAR unit, and no
> firmware topology information to indicate which one to pick?

Yes, we don't have a 1:1 mapping and there is some info, but that's all
a horrible mess.

>> Though I'm not yet convinced that the outcome would be less horrible
>> than the hack in the DMAR driver when I'm taking all the other horrors
>> of x86 (including XEN) into account :)
>
> I tried to follow the notifier into the DMAR driver, ended up in the
> IRQ remapping code, and lost the will to live.

Please just don't look at that and stay alive :)

> I have a question though:
>
> In the bus notifier callback, you end-up in dmar_pci_bus_add_dev(),
> which calls intel_irq_remap_add_device(), which tries to set the MSI
> domain. Why isn't that enough? Are we still missing any information at
> that stage?

That works, but this code is not reached for VF devices ... See the
patch which cures that.

If we want to get rid of that mess we'd need to rewrite the DMAR IOMMU
device registration completely. I'll leave it as is for now. My will to
live is more important :)

Thanks

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
