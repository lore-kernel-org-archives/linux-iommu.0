Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C898DC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 17:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 789CE408CC;
	Tue, 14 Dec 2021 17:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svWtjW46lHJl; Tue, 14 Dec 2021 17:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 589CC40246;
	Tue, 14 Dec 2021 17:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B2DDC001E;
	Tue, 14 Dec 2021 17:03:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2985C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9E6160BFE
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="4P9YNy0E";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="NEaZQwUV"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zvasSvlJK2KM for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 17:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2327D60BCC
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:03:53 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639501430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RXDy+gEt+jM/GLA+wNxlJEuBnWYy8r3p2Ru1kkxGm4Q=;
 b=4P9YNy0ES7591XCDm5PSWup8bN4QZP7lauZPNqzguglGF810Qx6tlHC+ni+cCTXT//bRrL
 8sy8xtbBW2WNueS1zjqp8h8A0yb4naQSxUV7RBh2hqT1tsFq6begUYU0evqtkPzN01b278
 fd9gHbaeywBmVDCmDPd2qQ/zpjMiaB9wQAqsRoE0OI6pkTd0Mdkr8wct9zyvWczqltcPfP
 gVFurKQstARHhwA4cqkMjQuwW0a240akK7UOWCq2KqJXtL/Zk07hDvbDB6Geb3dHg82+ku
 rQEa7JysFMGTutJcrfi+Bj+sn5C4cesBd4+iCf7oAFV+qmPbWW589QvaRwSxBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639501430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RXDy+gEt+jM/GLA+wNxlJEuBnWYy8r3p2Ru1kkxGm4Q=;
 b=NEaZQwUVupGSoHFBC83jQ5nykyNdZrjtpZRBFsQka5WyTgqzd9VoqFy4Lrz/ewIMzZW0fK
 mYumgixv6qanTNBQ==
To: Nishanth Menon <nm@ti.com>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <87wnk7rvnz.ffs@tglx>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider> <87wnk7rvnz.ffs@tglx>
Date: Tue, 14 Dec 2021 18:03:50 +0100
Message-ID: <87tufbrudl.ffs@tglx>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>, Johannes Berg <johannes.berg@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Marc Zygnier <maz@kernel.org>,
 dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

On Tue, Dec 14 2021 at 17:36, Thomas Gleixner wrote:
> On Tue, Dec 14 2021 at 10:22, Nishanth Menon wrote:
>> On 10:41-20211214, Thomas Gleixner wrote:
> [   13.478122] Call trace:
> [   13.509042]  msi_device_destroy_sysfs+0x18/0x88
> [   13.509058]  msi_domain_free_irqs+0x34/0x58
> [   13.509064]  pci_msi_teardown_msi_irqs+0x30/0x3c
> [   13.509072]  free_msi_irqs+0x78/0xd4
> [   13.509077]  pci_disable_msix+0x138/0x164
> [   13.529930]  pcim_release+0x70/0x238
> [   13.529942]  devres_release_all+0x9c/0xfc
> [   13.529951]  device_release_driver_internal+0x1a0/0x244
> [   13.542725]  device_release_driver+0x18/0x24
> [   13.542741]  iwl_req_fw_callback+0x1a28/0x1ddc [iwlwifi]
> [   13.552308]  request_firmware_work_func+0x50/0x9c
> [   13.552320]  process_one_work+0x194/0x25c
>
> That's not a driver problem, that's an ordering issue vs. the devres
> muck. Let me go back to the drawing board. Sigh...

Which is pretty obvious why:

   pcim_enable_device()
        devres_alloc(pcim_release...);
        ...
        pci_irq_alloc()
          msi_setup_device_data()
             devres_alloc(msi_device_data_release, ...)

and once the device is released:

    msi_device_data_release()
    ...
    pcim_release()
       pci_disable_msi[x]()

Groan....
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
