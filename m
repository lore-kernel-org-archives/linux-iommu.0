Return-Path: <SRS0=3QBT=L5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C864C07E99
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 19:04:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C18461987
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 19:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C18461987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4978605D7;
	Mon,  5 Jul 2021 19:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HOtdjPANgaW8; Mon,  5 Jul 2021 19:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B985A60674;
	Mon,  5 Jul 2021 19:04:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 848AEC0010;
	Mon,  5 Jul 2021 19:04:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D13ECC000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 19:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB9A883A92
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 19:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FcyRDKUSAdrJ for <iommu@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:04:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F16683A8E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 19:04:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D07161978;
 Mon,  5 Jul 2021 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625511844;
 bh=o012umLuvyjggdb73nB1nx1kOYsPv1SNeUIs18hDcAw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GRwf1cGaUQnGNSK48BMiS8/L53RP5G/QW+0L7WarqJg3vdXhPi76IMHEfxJBcIPa3
 O/IVWGS61Gw63qZ6P/lu+E1G7lOjBRQgMMYZUlxciRBcXpXeaEm0Nt8VlI20vyORW0
 5Yt77iWQoVMzfxA0eNrndYooJS41ndFVzjZWCxmusBkktvSuT3rDjxcvXFg+FyE3zq
 Tiys8WKwLxyKU0wwkmXs/VX0V/xsNc/cZvd76dhCDw80UkiEfPmHKQyUCziEG4n9+X
 zngjj2Bp6GquWJbjoHo8XOCLo60dYdheBX5hvWTEA+kb21c5xQf9Khdj2j/E3DZMQq
 mzeeqFIjv4raA==
Date: Mon, 5 Jul 2021 20:03:52 +0100
From: Will Deacon <will@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <20210705190352.GA19461@willie-the-truck>
References: <20210624155526.2775863-7-tientzu@chromium.org>
 <YNvMDFWKXSm4LRfZ@Ryzen-9-3900X.localdomain>
 <CALiNf2-a-haQN0-4+gX8+wa++52-0CnO2O4BEkxrQCxoTa_47w@mail.gmail.com>
 <20210630114348.GA8383@willie-the-truck>
 <YNyUQwiagNeZ9YeJ@Ryzen-9-3900X.localdomain>
 <20210701074045.GA9436@willie-the-truck>
 <ea28db1f-846e-4f0a-4f13-beb67e66bbca@kernel.org>
 <20210702135856.GB11132@willie-the-truck>
 <0f7bd903-e309-94a0-21d7-f0e8e9546018@arm.com>
 <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Claire Chang <tientzu@chromium.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Qian Cai <quic_qiancai@quicinc.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, mpe@ellerman.id.au,
 Tom Lendacky <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

Hi Nathan,

I may have just spotted something in these logs...

On Fri, Jul 02, 2021 at 10:55:17PM -0700, Nathan Chancellor wrote:
> [    2.340956] pci 0000:0c:00.1: Adding to iommu group 4
> [    2.340996] pci 0000:0c:00.2: Adding to iommu group 4
> [    2.341038] pci 0000:0c:00.3: Adding to iommu group 4
> [    2.341078] pci 0000:0c:00.4: Adding to iommu group 4
> [    2.341122] pci 0000:0c:00.6: Adding to iommu group 4
> [    2.341163] pci 0000:0d:00.0: Adding to iommu group 4
> [    2.341203] pci 0000:0d:00.1: Adding to iommu group 4
> [    2.361821] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [    2.361839] pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
> [    2.361846]  PPR X2APIC NX GT IA GA PC GA_vAPIC
> [    2.361861] AMD-Vi: Interrupt remapping enabled
> [    2.361865] AMD-Vi: Virtual APIC enabled
> [    2.361870] AMD-Vi: X2APIC enabled
> [    2.362272] AMD-Vi: Lazy IO/TLB flushing enabled

So at this point, the AMD IOMMU driver does:

	swiotlb        = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;

where 'swiotlb' is a global variable indicating whether or not swiotlb
is in use. It's picked up a bit later on by pci_swiotlb_late_init(), which
will call swiotlb_exit() if 'swiotlb' is false.

Now, that used to work fine, because swiotlb_exit() clears
'io_tlb_default_mem' to NULL, but now with the restricted DMA changes, I
think that all the devices which have successfully probed beforehand will
have stale pointers to the freed structure in their 'dev->dma_io_tlb_mem'
field.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
