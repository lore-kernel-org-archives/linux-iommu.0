Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FDEC56202
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 09:19:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F6F217A0
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 09:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v+5H7kN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F6F217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9C3432E1DD;
	Fri, 13 Nov 2020 09:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwg6uShcjbpB; Fri, 13 Nov 2020 09:19:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0B06520349;
	Fri, 13 Nov 2020 09:19:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEFB5C163C;
	Fri, 13 Nov 2020 09:19:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F0BC0FAA
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 09:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 71793878D5
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 09:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SuPb0wVfubaP for <iommu@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 09:19:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE643878D4
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 09:19:13 +0000 (UTC)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21D4E217A0;
 Fri, 13 Nov 2020 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605259153;
 bh=4WfWbAlavSUu5PlR51nGUJzILHY5zJO40KyO7oEp2x0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=v+5H7kN+M6Sx/diM7jt8WdPp+z/ENWnjqo0Mt7jppePx8mOt6BV3zrXRG9C2ULikU
 h9y7cqmKqm+YjgJ4ZrirPtHXISgCrx9lvuZxQAnqFsHFzVDfJdBD7oFnw9u7vpLI/6
 EgYK3U+iopdz/Fm1SkJdgZyUFi6bNIhmOz1Og6J8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kdVEc-00AHye-HD; Fri, 13 Nov 2020 09:19:10 +0000
MIME-Version: 1.0
Date: Fri, 13 Nov 2020 09:19:10 +0000
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <87a6vmmf8h.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com>
 <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
 <87a6vmmf8h.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <2196b03a44a15fdc37223040197c4ac5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jgg@nvidia.com, ziyadat@nvidia.com,
 itayav@nvidia.com, moshe@nvidia.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, dwmw2@infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-11-12 21:34, Thomas Gleixner wrote:
> On Thu, Nov 12 2020 at 20:15, Thomas Gleixner wrote:
>> The recent changes to store the MSI irqdomain pointer in struct device
>> missed that Intel DMAR does not register virtual function devices.  
>> Due to
>> that a VF device gets the plain PCI-MSI domain assigned and then 
>> issues
>> compat MSI messages which get caught by the interrupt remapping unit.
>> 
>> Cure that by inheriting the irq domain from the physical function
>> device.
>> 
>> That's a temporary workaround. The correct fix is to inherit the irq 
>> domain
>> from the bus, but that's a larger effort which needs quite some other
>> changes to the way how x86 manages PCI and MSI domains.
> 
> Bah, that's not really going to work with the way how irq remapping
> works on x86 because at least Intel/DMAR can have more than one DMAR
> unit on a bus.
> 
> So the alternative solution would be to assign the domain per device,
> but the current ordering creates a hen and egg problem. Looking the
> domain up in pci_set_msi_domain() does not work because at that point
> the device is not registered in the IOMMU. That happens from
> device_add().
> 
> Marc, is there any problem to reorder the calls in pci_device_add():
> 
>       device_add();
>       pci_set_msi_domain();

I *think* it works as long as we keep the "match_driver = false" hack.
Otherwise, we risk binding to a driver early, and game over.

> That would allow to add a irq_find_matching_fwspec() based lookup to
> pci_msi_get_device_domain().

Just so that I understand the issue: is the core of the problem that
there is no 1:1 mapping between a PCI bus and a DMAR unit, and no
firmware topology information to indicate which one to pick?

> Though I'm not yet convinced that the outcome would be less horrible
> than the hack in the DMAR driver when I'm taking all the other horrors
> of x86 (including XEN) into account :)

I tried to follow the notifier into the DMAR driver, ended up in the
IRQ remapping code, and lost the will to live. I have a question though:

In the bus notifier callback, you end-up in dmar_pci_bus_add_dev(),
which calls intel_irq_remap_add_device(), which tries to set the
MSI domain. Why isn't that enough? Are we still missing any information
at that stage?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
