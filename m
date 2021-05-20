Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896BCC433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 06:40:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327DC6105A
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 06:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327DC6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECCC960623;
	Thu, 20 May 2021 06:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zy9X62H6wJ-X; Thu, 20 May 2021 06:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15D046061B;
	Thu, 20 May 2021 06:40:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0399C000D;
	Thu, 20 May 2021 06:40:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CFB8C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06F4783C6B
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mv6RPj_z3Jkp for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 06:40:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47C8182ED2
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:40:37 +0000 (UTC)
Received: by mail-il1-x135.google.com with SMTP id o10so13335718ilm.13
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oIhFsW3yOUmKSioHfdtl49xT1nsW2ymAOSCthcMXiio=;
 b=lM9veaUv42y4nXibj1lGSdifgvjsNbUKUEol+uJziWw6kVRwnZkDD52tXqcK/vhasS
 PUDj92pN5vsIbUfabcqexhaZYlSojZJ1wq1mzK9ZTms/+1Va4jsCnNJ6mu4u4DoMsmtY
 16/lsdYHKt3Z41zBC1z7c65B0IdsqOKp+QHbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oIhFsW3yOUmKSioHfdtl49xT1nsW2ymAOSCthcMXiio=;
 b=a/4yAs8DgA1crUvkzL2U2zknfPlYoKZ1xIzhMs63C5tJ9TlZx80u4FyeH+tYEPxF2U
 1X7yecuemzkEy5Ni2uC0PVRyH6rJud16whHNR4423ruJUDKoLyg/MLvnsdHsvXQlXR2+
 ueyVQWFKUp0NmluMbdgUnFSrrzCQzmUMQPjpjQTHZEuIs4JLXZ6g5XkvlpO/ZtejuWTM
 c50TylcCALez1X05RrzHNTcwqyvuP+qVn5bCtsWokjLZghfuJvAUNlWEMbM+9qBX5YYK
 b4rxEILpL8jFjhZjgv0fV3FTixu8hm4HkWye20WObwhY38igYGUYJ5q2bFFfA9jbiT6K
 wb0w==
X-Gm-Message-State: AOAM532ppOnszi4m208CbDfGAy/vbyCHGwa/jyR9tg4SSoMeNYdYrbCd
 obIwKR/MLpjHVp49UrFR/wEGx/X2unDyJg==
X-Google-Smtp-Source: ABdhPJxfZr3qDFM8RRfSXwy9UBM1V9EUGSHQG5wHCAiUi1IfAhQ/2gYTNfxRALNRXW/Paw4qygo3bw==
X-Received: by 2002:a05:6e02:1302:: with SMTP id
 g2mr3333651ilr.259.1621492835834; 
 Wed, 19 May 2021 23:40:35 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com.
 [209.85.166.43])
 by smtp.gmail.com with ESMTPSA id s14sm1959067iln.64.2021.05.19.23.40.34
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 23:40:35 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id e17so2961019iol.7
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:40:34 -0700 (PDT)
X-Received: by 2002:a5d:8c82:: with SMTP id g2mr3632711ion.34.1621492834046;
 Wed, 19 May 2021 23:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-2-tientzu@chromium.org>
 <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
In-Reply-To: <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 20 May 2021 14:40:23 +0800
X-Gmail-Original-Message-ID: <CALiNf2-9fRbH3Xs=fA+N1iRztFxeC0iTsyOSZFe=F42uwXS0Sg@mail.gmail.com>
Message-ID: <CALiNf2-9fRbH3Xs=fA+N1iRztFxeC0iTsyOSZFe=F42uwXS0Sg@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] swiotlb: Refactor swiotlb init functions
To: Florian Fainelli <f.fainelli@gmail.com>
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
 Will Deacon <will@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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

On Thu, May 20, 2021 at 2:50 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 5/17/2021 11:42 PM, Claire Chang wrote:
> > Add a new function, swiotlb_init_io_tlb_mem, for the io_tlb_mem struct
> > initialization to make the code reusable.
> >
> > Note that we now also call set_memory_decrypted in swiotlb_init_with_tbl.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >  kernel/dma/swiotlb.c | 51 ++++++++++++++++++++++----------------------
> >  1 file changed, 25 insertions(+), 26 deletions(-)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 8ca7d505d61c..d3232fc19385 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -168,9 +168,30 @@ void __init swiotlb_update_mem_attributes(void)
> >       memset(vaddr, 0, bytes);
> >  }
> >
> > -int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> > +static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> > +                                 unsigned long nslabs, bool late_alloc)
> >  {
> > +     void *vaddr = phys_to_virt(start);
> >       unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
> > +
> > +     mem->nslabs = nslabs;
> > +     mem->start = start;
> > +     mem->end = mem->start + bytes;
> > +     mem->index = 0;
> > +     mem->late_alloc = late_alloc;
> > +     spin_lock_init(&mem->lock);
> > +     for (i = 0; i < mem->nslabs; i++) {
> > +             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > +             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > +             mem->slots[i].alloc_size = 0;
> > +     }
> > +
> > +     set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> > +     memset(vaddr, 0, bytes);
>
> You are doing an unconditional set_memory_decrypted() followed by a
> memset here, and then:
>
> > +}
> > +
> > +int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> > +{
> >       struct io_tlb_mem *mem;
> >       size_t alloc_size;
> >
> > @@ -186,16 +207,8 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> >       if (!mem)
> >               panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
> >                     __func__, alloc_size, PAGE_SIZE);
> > -     mem->nslabs = nslabs;
> > -     mem->start = __pa(tlb);
> > -     mem->end = mem->start + bytes;
> > -     mem->index = 0;
> > -     spin_lock_init(&mem->lock);
> > -     for (i = 0; i < mem->nslabs; i++) {
> > -             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > -             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > -             mem->slots[i].alloc_size = 0;
> > -     }
> > +
> > +     swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
>
> You convert this call site with swiotlb_init_io_tlb_mem() which did not
> do the set_memory_decrypted()+memset(). Is this okay or should
> swiotlb_init_io_tlb_mem() add an additional argument to do this
> conditionally?

I'm actually not sure if this it okay. If not, will add an additional
argument for it.

> --
> Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
