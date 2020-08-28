Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E779CC433E2
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 18:42:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B3720737
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 18:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WpnVo7bV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChwUrHsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B3720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9CDDD882F6;
	Fri, 28 Aug 2020 18:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H+WmqJAcE3tS; Fri, 28 Aug 2020 18:42:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CDC9882F3;
	Fri, 28 Aug 2020 18:42:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B4D3C07FF;
	Fri, 28 Aug 2020 18:42:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B57A5C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 18:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9AFCB882F6
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 18:42:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mpq5YHiWING8 for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 18:42:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F1544882F3
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 18:42:23 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598640142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9PL1UZyrvXtvYwXm50JgVKEMKlhclTur/QaPxXNrW4=;
 b=WpnVo7bVNT/b8XQDt+j58pe6KdQuC0AaMuaG96ld2pT19xmZmgIfhwIL2aToKAQCuHplbl
 babtlLWVtGtJoKe554lnL+lrSbC+m2P80aoFcGewVi1cvJw89TLCA+RKvIpl3nB1tz+atR
 Rpt1UAY/0C2Jh7S/HVLrWc1d3i6FRctcoggPvOgispeAzX31o/e0KIecYrxPcVTe02glak
 xvt/5cf0eEZL35Cs55nb+A3Mx+nimOdxcufa2dUvIghy3OgLuWzePAHaWMcUDkE7FZclcC
 P6D3MhploGKAumda2RRUUhTFcp/3dtDRczfHHNjGZzGxRU3c3M1LzqDqHVmpHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598640142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9PL1UZyrvXtvYwXm50JgVKEMKlhclTur/QaPxXNrW4=;
 b=ChwUrHsMyAvL0EU/Y4hgs1mQPBN+7Zk3PLK+0Sz5YppkJGFQXT2iBnk0EWmZfwq4Jm1Lwb
 mDs4YAIFWBPd+5CQ==
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [patch V2 43/46] genirq/msi: Provide and use
 msi_domain_set_default_info_flags()
In-Reply-To: <b80607e87e43730133dd9f619c6464dc@kernel.org>
References: <20200826111628.794979401@linutronix.de>
 <20200826112334.889315931@linutronix.de>
 <b80607e87e43730133dd9f619c6464dc@kernel.org>
Date: Fri, 28 Aug 2020 20:42:21 +0200
Message-ID: <87zh6ek3xu.fsf@nanos.tec.linutronix.de>
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

On Thu, Aug 27 2020 at 09:17, Marc Zyngier wrote:
> On 2020-08-26 12:17, Thomas Gleixner wrote:
>>  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> +void msi_domain_set_default_info_flags(struct msi_domain_info *info)
>> +{
>> +	/* Required so that a device latches a valid MSI message on startup 
>> */
>> +	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
>
> As far as I remember the story behind this flag (it's been a while),
> it was working around a PCI-specific issue, hence being located in
> the PCI code.

Yes. Some cards misbehave when there is no valid message programmed and
MSI is enabled.

> Now, the "program the MSI before enabling it" concept makes sense no
> matter what bus this is on, and I wonder why we are even keeping this
> flag around.

> Can't we just drop it together with the check in
> msi_domain_alloc_irqs()?

I'm fine with that.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
