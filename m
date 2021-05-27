Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA86CC4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:35:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64398613F0
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64398613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 307C340289;
	Thu, 27 May 2021 11:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id keU2lEbAxbfl; Thu, 27 May 2021 11:35:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8954401A4;
	Thu, 27 May 2021 11:35:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A858C000D;
	Thu, 27 May 2021 11:35:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE169C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB20540656
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HDUSoKAXm6sP for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 11:35:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0474C405A4
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:35:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2886A6113B;
 Thu, 27 May 2021 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622115307;
 bh=awWFyuDtGzTSFYuKnqnAwD8I2u8LvxPLkIedgwXpacY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p4bPfFCD5PrcmECQ/JmYfkoIQvGIdlvd3Xmt5WsLHiji5zjF5hUpY/7jV/AEVHJHW
 CB6f9oBS2X3aNGgQ3+WcdNwOGV1gPRmBycO/zJJUoapgziqu+7IL5STMx1dAhYz3+T
 0bM7UEMZILv76zqCaWO+pWXqjNmfb4VQ6CH4Qz9dn7I0OepvY2P5/VxhAaiFsn1JPd
 ce1hSAg7oNQpoYW+JbRsJjBqIARt3uf0TgyQ8bjr7saHdzXTBfM/jxaDHBHbhfTQ4Z
 nDFzJaE8tdL5MVg6406RffF7r/1Of9XzA/MNxWJkmUtb6zscbeJZBFAuG32Qt3uWbG
 DCkceG/OoqRLg==
Date: Thu, 27 May 2021 12:34:57 +0100
From: Will Deacon <will@kernel.org>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH v7 14/15] dt-bindings: of: Add restricted DMA pool
Message-ID: <20210527113456.GA22019@willie-the-truck>
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-15-tientzu@chromium.org>
 <20210526121322.GA19313@willie-the-truck>
 <20210526155321.GA19633@willie-the-truck>
 <CALiNf2_sVXnb97++yWusB5PWz8Pzfn9bCKZc6z3tY4bx6-nW8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALiNf2_sVXnb97++yWusB5PWz8Pzfn9bCKZc6z3tY4bx6-nW8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jim Quinlan <james.quinlan@broadcom.com>, heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jianxiong Gao <jxgao@google.com>,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 mingo@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 bskeggs@redhat.com, linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, matthew.auld@intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, thomas.hellstrom@linux.intel.com,
 jgross@suse.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 Robin Murphy <robin.murphy@arm.com>, jani.nikula@linux.intel.com,
 Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 boris.ostrovsky@oracle.com, airlied@linux.ie,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, xypron.glpk@gmx.de,
 linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
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

On Thu, May 27, 2021 at 07:29:20PM +0800, Claire Chang wrote:
> On Wed, May 26, 2021 at 11:53 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, May 26, 2021 at 01:13:22PM +0100, Will Deacon wrote:
> > > On Tue, May 18, 2021 at 02:42:14PM +0800, Claire Chang wrote:
> > > > @@ -138,4 +160,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > > >             memory-region = <&multimedia_reserved>;
> > > >             /* ... */
> > > >     };
> > > > +
> > > > +   pcie_device: pcie_device@0,0 {
> > > > +           memory-region = <&restricted_dma_mem_reserved>;
> > > > +           /* ... */
> > > > +   };
> > >
> > > I still don't understand how this works for individual PCIe devices -- how
> > > is dev->of_node set to point at the node you have above?
> > >
> > > I tried adding the memory-region to the host controller instead, and then
> > > I see it crop up in dmesg:
> > >
> > >   | pci-host-generic 40000000.pci: assigned reserved memory node restricted_dma_mem_reserved
> > >
> > > but none of the actual PCI devices end up with 'dma_io_tlb_mem' set, and
> > > so the restricted DMA area is not used. In fact, swiotlb isn't used at all.
> > >
> > > What am I missing to make this work with PCIe devices?
> >
> > Aha, looks like we're just missing the logic to inherit the DMA
> > configuration. The diff below gets things working for me.
> 
> I guess what was missing is the reg property in the pcie_device node.
> Will update the example dts.

Thanks. I still think something like my diff makes sense, if you wouldn't mind including
it, as it allows restricted DMA to be used for situations where the PCIe
topology is not static.

Perhaps we should prefer dev->of_node if it exists, but then use the node
of the host bridge's parent node otherwise?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
