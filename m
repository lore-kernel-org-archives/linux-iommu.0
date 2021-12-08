Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62A8C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 17:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79CC5607B1;
	Wed,  8 Dec 2021 17:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FOXYDInpgWcH; Wed,  8 Dec 2021 17:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6EC266069E;
	Wed,  8 Dec 2021 17:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F660C002F;
	Wed,  8 Dec 2021 17:53:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 740AFC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 17:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62429402B2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 17:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="yVnW54g9";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="tcPpBzNA"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqHkrgbs2ZEi for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 17:53:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1370402B1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 17:53:11 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638985988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3VE0nNlLZyDP2MmX/vYQZeWgKNo5Uy6Cr5E5oEyE//0=;
 b=yVnW54g9mJPoCSUF2QVZDU2f/xrPC/IYtzosNqipMCrUE3ublT0WkCXcFyPVrEXNiDojbG
 WW1CUtpK3VyoAq9fSgOMsdsrptfY0amXBwna/GvfaJqkTvsyAVL5hI1SpplK1OmRnxMVrX
 L5hSSsO8qCmLbj+GpNXsAcp58GYvqbj2Cej56RVnAFHSASUWcdaICSkYgNnc4MXsVS22aL
 8yNx41somh4ngRIGaL6Bs8mvddn976wAff7JClugcbIPHTmhPJafFg/+oWVQNEXsavVz8Q
 ECHb4fzOEv458qXYE4Q7kYbod/VikxJKFLy0KA5gkzv0UDl1V1bDcOOf7ps2JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638985988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3VE0nNlLZyDP2MmX/vYQZeWgKNo5Uy6Cr5E5oEyE//0=;
 b=tcPpBzNArpjTicF6DwnR6v7vnK+DexgwPINycnkhbizry34b4Yd5f7r99TAQsJpmyDoy7E
 NsIoYzOvgoObEZDg==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch V2 20/36] x86/pci/XEN: Use device MSI properties
In-Reply-To: <20211208155314.GX6385@nvidia.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.742297272@linutronix.de>
 <20211208155314.GX6385@nvidia.com>
Date: Wed, 08 Dec 2021 18:53:07 +0100
Message-ID: <877dcf0yrg.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Dec 08 2021 at 11:53, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 11:39:28PM +0100, Thomas Gleixner wrote:
>>  static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
>>  {
>> -	struct msi_desc *msidesc = first_pci_msi_entry(dev);
>> -
>> -	if (msidesc->pci.msi_attrib.is_msix)
>> +	if (msi_device_has_property(&dev->dev, MSI_PROP_PCI_MSIX))
>>  		xen_pci_frontend_disable_msix(dev);
>>  	else
>>  		xen_pci_frontend_disable_msi(dev);
>
> Same remark as for power, we have a pci_dev, so can it be
> dev->msix_enabled?

Yes, let me rework that.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
