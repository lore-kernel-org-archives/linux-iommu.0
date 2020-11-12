Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0FAC5519F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 21:34:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF18C22253
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 21:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJbMMRpQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xq9LmDFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF18C22253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2291C20372;
	Thu, 12 Nov 2020 21:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yajCajP++sCv; Thu, 12 Nov 2020 21:34:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BA68E2034A;
	Thu, 12 Nov 2020 21:34:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89BB4C088B;
	Thu, 12 Nov 2020 21:34:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94462C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 21:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8EB4E86E9C
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 21:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XfGvDyXk2E3E for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 21:34:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DC752810F6
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 21:34:25 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1605216862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bvy6rDTiG+QSb2CokdJjOXSIYS896H/oY3ZXOQcXt0=;
 b=rJbMMRpQB0plHKNFT2WVlgdjh5wsG8JwhP/s32stblDYnw7UlWg9M1ZgCiVFJhjwrQxQvt
 tH23ew8WhZ5CaKMYrP/4l6FbUC+K9ZvT8d90qSJ2ik3xuv4swo/jk1RLuIUTOASLSGL26C
 16U2HhDRxyeGGo9z3KC0x38oVNF6CfRc59pfNw/6LgDlgK1N+73A2kyRBr1IKrsSLZJo1b
 +pZPHj5iZRZ+Ex1I/L5tx87PvJFMXlk6dm4HxN8QR325LL8sz6jakYIB4hMiMC3cio4jOK
 iNr5e3ZwzBFboX5bIBDI50/T2kI9d932UBWG4a8eX+fS9vphMWTDXClH13zM3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1605216862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bvy6rDTiG+QSb2CokdJjOXSIYS896H/oY3ZXOQcXt0=;
 b=Xq9LmDFhJBGSzWGVcacQbRi35G9jreAOd9xuxmg6+RGDOE+vFzV0KZoEixn/hqWVODq9ou
 ibkTyhbw1Qi4ryDQ==
To: Jason Gunthorpe <jgg@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>,
 Itay Aveksis <itayav@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <87d00imlop.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
Date: Thu, 12 Nov 2020 22:34:22 +0100
Message-ID: <87a6vmmf8h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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

On Thu, Nov 12 2020 at 20:15, Thomas Gleixner wrote:
> The recent changes to store the MSI irqdomain pointer in struct device
> missed that Intel DMAR does not register virtual function devices.  Due to
> that a VF device gets the plain PCI-MSI domain assigned and then issues
> compat MSI messages which get caught by the interrupt remapping unit.
>
> Cure that by inheriting the irq domain from the physical function
> device.
>
> That's a temporary workaround. The correct fix is to inherit the irq domain
> from the bus, but that's a larger effort which needs quite some other
> changes to the way how x86 manages PCI and MSI domains.

Bah, that's not really going to work with the way how irq remapping
works on x86 because at least Intel/DMAR can have more than one DMAR
unit on a bus.

So the alternative solution would be to assign the domain per device,
but the current ordering creates a hen and egg problem. Looking the
domain up in pci_set_msi_domain() does not work because at that point
the device is not registered in the IOMMU. That happens from
device_add().

Marc, is there any problem to reorder the calls in pci_device_add():

      device_add();
      pci_set_msi_domain();

That would allow to add a irq_find_matching_fwspec() based lookup to
pci_msi_get_device_domain().

Though I'm not yet convinced that the outcome would be less horrible
than the hack in the DMAR driver when I'm taking all the other horrors
of x86 (including XEN) into account :)

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
