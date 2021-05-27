Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75145C47089
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:29:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15559613D3
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 11:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15559613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCAA06082C;
	Thu, 27 May 2021 11:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rlS_8PgbmRP5; Thu, 27 May 2021 11:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA34260793;
	Thu, 27 May 2021 11:29:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6ABEC000D;
	Thu, 27 May 2021 11:29:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4139C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9491D60817
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7i_CSqYRFrlW for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 11:29:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC392607E5
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 11:29:34 +0000 (UTC)
Received: by mail-io1-xd2f.google.com with SMTP id d25so97685ioe.1
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XepQkdRFyf5QwVg1KdPLbhegPooaNHd/1JiifJ+YyHM=;
 b=J39qajy3UJ3qAzWqGeZGEnwMoSI9LW5BjibS8fd+Acudu4FxBAXa2OhDGjuMcgqW0/
 wo/z5L5WO21v6biwP7ZKEgtIJf223PVujpTOF4zDsL3aPOmxJx+dxaS3A0oSwB4zv/i6
 Jb0bh8tNiRStD2FZiusMVkFxa8G1teBBpM9vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XepQkdRFyf5QwVg1KdPLbhegPooaNHd/1JiifJ+YyHM=;
 b=AUzzubCaJOhmqK/mAdR/2U0HLlDda3KZvKHUl5Opx+DT6ERwQzaQCpsH5ku3qpJ1dL
 h/bx3VHgHiNHk6/OmVOKsMt9OZnH7lvEhmiHb9sEt+gZdcUD/dB+amImZpHGAGocWRq8
 6mwXT+mHuVQ1BnmdfAUFXprax+Q8F29td0VWIQ3soZWZvWwpyfH1ug08ciOYZUOIdLqJ
 bdV26VcOdjb579TTX/HbgBDsj/tWVJCVOj4OQ0147nrXDK17TPyjbeo7W1hSbYbAZZCD
 HpOgQBsNusHmsuuGWL/8s/d4IHz8Oo1dE7X69fQ+N63GPjZeuOlVyvbyEznYrlvg8wWD
 m/xA==
X-Gm-Message-State: AOAM533Xc6TNlkFwpoowgxLTuN9J9fLJ/A1x9F/ypG5ATEtvV7267KJM
 vVJGTPcymwg5i4iYKYgmMH2xaYtXamyJ6g==
X-Google-Smtp-Source: ABdhPJzJma+vbRjL8R/542OqZal5G7iaOCAsKNO0Dvy3yhp1yqkCksjBzpIhlHTLOnxIr4sx1j4GVw==
X-Received: by 2002:a05:6602:2186:: with SMTP id
 b6mr2425948iob.128.1622114973442; 
 Thu, 27 May 2021 04:29:33 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com.
 [209.85.166.174])
 by smtp.gmail.com with ESMTPSA id s4sm1042513ilp.4.2021.05.27.04.29.31
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 04:29:32 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id o9so3775161ilh.6
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 04:29:31 -0700 (PDT)
X-Received: by 2002:a05:6e02:e42:: with SMTP id
 l2mr2536928ilk.189.1622114971302; 
 Thu, 27 May 2021 04:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-15-tientzu@chromium.org>
 <20210526121322.GA19313@willie-the-truck>
 <20210526155321.GA19633@willie-the-truck>
In-Reply-To: <20210526155321.GA19633@willie-the-truck>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 27 May 2021 19:29:20 +0800
X-Gmail-Original-Message-ID: <CALiNf2_sVXnb97++yWusB5PWz8Pzfn9bCKZc6z3tY4bx6-nW8w@mail.gmail.com>
Message-ID: <CALiNf2_sVXnb97++yWusB5PWz8Pzfn9bCKZc6z3tY4bx6-nW8w@mail.gmail.com>
Subject: Re: [PATCH v7 14/15] dt-bindings: of: Add restricted DMA pool
To: Will Deacon <will@kernel.org>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
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
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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

On Wed, May 26, 2021 at 11:53 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 26, 2021 at 01:13:22PM +0100, Will Deacon wrote:
> > On Tue, May 18, 2021 at 02:42:14PM +0800, Claire Chang wrote:
> > > @@ -138,4 +160,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > >             memory-region = <&multimedia_reserved>;
> > >             /* ... */
> > >     };
> > > +
> > > +   pcie_device: pcie_device@0,0 {
> > > +           memory-region = <&restricted_dma_mem_reserved>;
> > > +           /* ... */
> > > +   };
> >
> > I still don't understand how this works for individual PCIe devices -- how
> > is dev->of_node set to point at the node you have above?
> >
> > I tried adding the memory-region to the host controller instead, and then
> > I see it crop up in dmesg:
> >
> >   | pci-host-generic 40000000.pci: assigned reserved memory node restricted_dma_mem_reserved
> >
> > but none of the actual PCI devices end up with 'dma_io_tlb_mem' set, and
> > so the restricted DMA area is not used. In fact, swiotlb isn't used at all.
> >
> > What am I missing to make this work with PCIe devices?
>
> Aha, looks like we're just missing the logic to inherit the DMA
> configuration. The diff below gets things working for me.

I guess what was missing is the reg property in the pcie_device node.
Will update the example dts.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
