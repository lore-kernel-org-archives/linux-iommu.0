Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05635C433E3
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8A120665
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQQMWS26";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWC9wT9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8A120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 70CBB2155F;
	Tue, 25 Aug 2020 21:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xE-QycHTIaeJ; Tue, 25 Aug 2020 21:12:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 00D982034F;
	Tue, 25 Aug 2020 21:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8FA2C07FF;
	Tue, 25 Aug 2020 21:12:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5A46C0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B40562153D
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XYZHazTGEHIs for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 21:11:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id A083A2034F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 21:11:59 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598389916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1frHZHutANeGhNvELKAlZV7ZBIw0Dqsl4tEEvrOnRU4=;
 b=rQQMWS26Jt5LaZuxdrMUZgNfuNew2mCXTFepS37C35I6xAhJ3rEo9Nx2wJCVYo9FS/Pgcj
 zMK/jubxjmgOMukHjD1+whg0AyErL8YAwjSJxzS+B1PMq4RdTvHJO6lnQ8zCroL34GT5hw
 5/rfeY4s2ADMm35tAfb/mXN9dBB+PDzSGhJTbYCAYlaBzlpg8xMguI6MXbjreLqFtXNCau
 bsIWnmpXS6t/YonQ/7LmA5QV8SpSh4TrFs2TkYIhUy6U4rcc0A8vIF1QUkDGf2mbfLYdBM
 gsUXIxYqmPwtfL3S4OeTd+L815+ua7i1Gq/tsUgXEKLDUxlqgI3fswjFMqzoNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598389916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1frHZHutANeGhNvELKAlZV7ZBIw0Dqsl4tEEvrOnRU4=;
 b=hWC9wT9/QuU4/otH2U3KHZ3pSL+StkJoqjJVoH3bzCOAJhuscP4cb126Q52YIHKMSI5RAk
 NlcAG4imPXq613BA==
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [patch RFC 13/38] PCI: MSI: Rework pci_msi_domain_calc_hwirq()
In-Reply-To: <20200825200329.GA1923406@bjorn-Precision-5520>
References: <20200825200329.GA1923406@bjorn-Precision-5520>
Date: Tue, 25 Aug 2020 23:11:56 +0200
Message-ID: <87d03exwf7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
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

On Tue, Aug 25 2020 at 15:03, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2020 at 02:24:37AM +0200, Thomas Gleixner wrote:
>> Retrieve the PCI device from the msi descriptor instead of doing so at the
>> call sites.
>
> I'd like it *better* with "PCI/MSI: " in the subject (to match history

Duh, yes.

> and other patches in this series) and "MSI" here in the commit log,
> but nice cleanup and:
>> --- a/arch/x86/kernel/apic/msi.c
>> +++ b/arch/x86/kernel/apic/msi.c
>> @@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(pci_msi_prepare);
>>  
>>  void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>>  {
>> -	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
>> +	arg->msi_hwirq = pci_msi_domain_calc_hwirq(desc);
>
> I guess it's safe to assume that "arg->msi_dev ==
> msi_desc_to_pci_dev(desc)"?  I didn't try to verify that.

It is.

>> +irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>>  {
>> +	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
>
> If you named this "struct pci_dev *dev" (not "pdev"), the diff would
> be a little smaller and it would match other usage in the file.

Ok. I'm always happy to see pdev because that doesn't make me wonder
which type of dev it is :) But, yeah lets keep it consistent.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
