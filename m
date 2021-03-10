Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22778C433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 21:41:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7643E64E33
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 21:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7643E64E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C2404EC69;
	Wed, 10 Mar 2021 21:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sqJoS2pLYUOV; Wed, 10 Mar 2021 21:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D121447135;
	Wed, 10 Mar 2021 21:41:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0133C000B;
	Wed, 10 Mar 2021 21:41:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B4AC0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 21:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94F22414D4
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 21:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dPefin-Svjmp for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 21:40:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE58D40001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 21:40:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02CB664FD7
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615412454;
 bh=lljbEm8y6jNcxvIMoB+J261BTyFdid0U0j/1mSpgrns=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=eDXX9I0rBca4D2age7wm+DtVv6geacxhoDXnt5SysKVhym9aYBoOULiDV+ts4rOLP
 jxqSr5B0vX0/o/NShM/j+kwlnb4hGRATSr0mEhy2fTgb4b/f9TFkN0sucrguP/wUnN
 VpsdkpA2+bkS7oY10zU2zq+j59iH8lNhIYLI61shYJGWLghrHuyig30tcjLo3fTgbB
 3DEVFLncbcg+C2B9HtVOo3SUvsmkNa+xgZXWZi3ZI5a2G3Gno+oUiLdB0wFYwj7D9V
 li5Sma9VH3O9evfauK7N3UwWSXURG5BK+1LBH0BYK5Vbx589vAqinspwZjQAwTmkXH
 mjJKT2LCYnF3Q==
Received: by mail-qk1-f177.google.com with SMTP id a9so18515072qkn.13
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 13:40:53 -0800 (PST)
X-Gm-Message-State: AOAM532avGFBN4xRAIaCPaXqg4Ha29/jkrF8az+4irbrgKif6/ynDMAF
 2iv5FQZUmitTgR4n6BiG+5Mt5wzFldaUGVtkrQ==
X-Google-Smtp-Source: ABdhPJwvOHv4sjXRoS+j4qWhL9MVaGJgYMXKyxBDilpUrwUXgxjhTnULwJ7kIho0KdWOn0m+qzW6exxxNwLS3x7GxZU=
X-Received: by 2002:a05:620a:1001:: with SMTP id
 z1mr4659415qkj.364.1615412453005; 
 Wed, 10 Mar 2021 13:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <20210209062131.2300005-14-tientzu@chromium.org>
 <20210310160747.GA29834@willie-the-truck>
In-Reply-To: <20210310160747.GA29834@willie-the-truck>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 10 Mar 2021 14:40:41 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJE6A4awYCvqzw3qk2uAJEKgkSOKbk9tPaMKup8zes8cA@mail.gmail.com>
Message-ID: <CAL_JsqJE6A4awYCvqzw3qk2uAJEKgkSOKbk9tPaMKup8zes8cA@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] dt-bindings: of: Add restricted DMA pool
To: Will Deacon <will@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Grant Likely <grant.likely@arm.com>, Paul Mackerras <paulus@samba.org>,
 Frank Rowand <frowand.list@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicolas Boichat <drinkcat@chromium.org>, Claire Chang <tientzu@chromium.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Juergen Gross <jgross@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

On Wed, Mar 10, 2021 at 9:08 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Claire,
>
> On Tue, Feb 09, 2021 at 02:21:30PM +0800, Claire Chang wrote:
> > Introduce the new compatible string, restricted-dma-pool, for restricted
> > DMA. One can specify the address and length of the restricted DMA memory
> > region by restricted-dma-pool in the reserved-memory node.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > index e8d3096d922c..fc9a12c2f679 100644
> > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > @@ -51,6 +51,20 @@ compatible (optional) - standard definition
> >            used as a shared pool of DMA buffers for a set of devices. It can
> >            be used by an operating system to instantiate the necessary pool
> >            management subsystem if necessary.
> > +        - restricted-dma-pool: This indicates a region of memory meant to be
> > +          used as a pool of restricted DMA buffers for a set of devices. The
> > +          memory region would be the only region accessible to those devices.
> > +          When using this, the no-map and reusable properties must not be set,
> > +          so the operating system can create a virtual mapping that will be used
> > +          for synchronization. The main purpose for restricted DMA is to
> > +          mitigate the lack of DMA access control on systems without an IOMMU,
> > +          which could result in the DMA accessing the system memory at
> > +          unexpected times and/or unexpected addresses, possibly leading to data
> > +          leakage or corruption. The feature on its own provides a basic level
> > +          of protection against the DMA overwriting buffer contents at
> > +          unexpected times. However, to protect against general data leakage and
> > +          system memory corruption, the system needs to provide way to lock down
> > +          the memory access, e.g., MPU.
>
> As far as I can tell, these pools work with both static allocations (which
> seem to match your use-case where firmware has preconfigured the DMA ranges)
> but also with dynamic allocations where a 'size' property is present instead
> of the 'reg' property and the kernel is responsible for allocating the
> reservation during boot. Am I right and, if so, is that deliberate?

I believe so. I'm not keen on having size only reservations in DT.
Yes, we allowed that already, but that's back from the days of needing
large CMA carveouts to be reserved early in boot. I've read that the
kernel is much better now at contiguous allocations, so do we really
need this in DT anymore?

> I ask because I think that would potentially be useful to us for the
> Protected KVM work, where we need to bounce virtio memory accesses via
> guest-determined windows because the guest memory is generally inaccessible
> to the host. We've been hacking this using a combination of "swiotlb=force"
> and set_memory_{decrypted,encrypted}() but it would be much better to
> leverage the stuff you have here.
>
> Also:
>
> > +
> > +             restricted_dma_mem_reserved: restricted_dma_mem_reserved {
> > +                     compatible = "restricted-dma-pool";
> > +                     reg = <0x50000000 0x400000>;
> > +             };
> >       };
> >
> >       /* ... */
> > @@ -138,4 +157,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> >               memory-region = <&multimedia_reserved>;
> >               /* ... */
> >       };
> > +
> > +     pcie_device: pcie_device@0,0 {
> > +             memory-region = <&restricted_dma_mem_reserved>;
> > +             /* ... */
> > +     };
>
> I find this example a bit weird, as I didn't think we usually had DT nodes
> for PCI devices; rather they are discovered as a result of probing config
> space. Is the idea that you have one reserved memory region attached to the
> RC and all the PCI devices below that share the region, or is there a need
> for a mapping mechanism?

We can have DT nodes for PCI. AIUI, IBM power systems always do. For
FDT, it's only if there are extra non-discoverable resources. It's
particularly fun when it's resources which need to be enabled for the
PCI device to be discovered. That seems to be a growing problem as PCI
becomes more common on embedded systems.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
