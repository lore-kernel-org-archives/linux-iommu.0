Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FB2C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 17:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E3C642210;
	Thu,  9 Dec 2021 17:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BaIuLgsK3AI6; Thu,  9 Dec 2021 17:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1155A42209;
	Thu,  9 Dec 2021 17:53:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7C02C001E;
	Thu,  9 Dec 2021 17:53:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7745C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9523242207
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JA3dKWpm8hjN for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 17:53:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62ADA4220B
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:53:42 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639072418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/BG5QfqwWEb1VV/DgxhiFZ4nhZE79+Y1nkN0PAhNpQ=;
 b=kjE+xJbt1HY/8HBJlMzR3KY5f257GXq6wQiCb4ielSBtggUniQ1I3lNNdnraOwg0GEpMfu
 syIRikUXoAagvFD10A7VC8fdLi5KNDe8FVpgjdz238ahh5ThXTk0ftjn4sLjev21WbVmwN
 UdtH1rl6SMpGB3hFuvBYPFDDfZmvU6R1CRdrxcp40TncFcDN6uf+hzRVH9isczKiB43Nqg
 eOi5ptsv0tQWvH/JkuarfQxl1jTA329ul6SL57nsoRBvTSUj8ex83rJhKPX7X7TnTrq8uZ
 kYfRHVatnPWdhfVHrcCL0ZVnQkiJkHbcO3adPxb/1ct6S7VsxFetMxXinWNn4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639072418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/BG5QfqwWEb1VV/DgxhiFZ4nhZE79+Y1nkN0PAhNpQ=;
 b=W9fJDkfc99g7IIQhAnrz13+8F5imCs058D17+luFpISF83qVBUish7Usu7wFw9FwF+6ZoR
 uTKOefgne5k+wzAQ==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch V2 19/36] PCI/MSI: Store properties in device::msi::data
In-Reply-To: <20211208155816.GZ6385@nvidia.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.688216619@linutronix.de>
 <20211208155816.GZ6385@nvidia.com>
Date: Thu, 09 Dec 2021 18:53:37 +0100
Message-ID: <87k0gdzmu6.ffs@tglx>
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

On Wed, Dec 08 2021 at 11:58, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 11:39:26PM +0100, Thomas Gleixner wrote:
>> Store the properties which are interesting for various places so the MSI
>> descriptor fiddling can be removed.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>> V2: Use the setter function
>> ---
>>  drivers/pci/msi/msi.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>
> I took more time to look at this, to summarize my remarks on the other
> patches
>
> I think we don't need properties. The info in the msi_desc can come
> from the pci_dev which we have easy access to. This seems overall
> clearer

I fixed that now.

> The notable one is the sysfs, but that is probably better handled by
> storing a
>
>   const char *sysfs_label
>
> in the dev->msi and emitting that instead of computing it.

I just compute is for now via is_pci_dev() and
to_pci_dev()->msi_enabled.

We are still debating to remove the whole thing completely.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
