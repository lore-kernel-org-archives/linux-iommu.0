Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E8C2B9F7
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 03:08:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002C461415
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 03:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002C461415
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5EAF606EC;
	Tue, 25 May 2021 03:08:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDRTYFH2nCgK; Tue, 25 May 2021 03:08:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE21360762;
	Tue, 25 May 2021 03:08:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93232C000D;
	Tue, 25 May 2021 03:08:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38A84C0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19D6C83C2A
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:08:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZN9FegSgjwbl for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 03:08:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 747DE83C25
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:08:17 +0000 (UTC)
Received: by mail-il1-x12a.google.com with SMTP id m1so25161406ilg.10
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 20:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VHDFyefEfXv2T1h/kXDPOn5vVw8tSm/6FW05x+E2j40=;
 b=merHIeKNi5Uu6C9TAUujDNIN9FxrI34YUx7aW4WyFELIyYppIt99C4UwGvzWaArcmu
 9EaYZFbnrmtDjrMZ7c8349ke6DKJjWiZDCUD5epOu2PqMIr5kYM1CoXZ0XNE1vQ3QFiu
 bvf2bDyHaIMES3MNNrHcengJbyjgwpDl3VY20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VHDFyefEfXv2T1h/kXDPOn5vVw8tSm/6FW05x+E2j40=;
 b=CRecBvPfOlM0cu2BNzFl+vH36AokFRbUUVeGQVIJWTPIUAcNeGn1n4wWsm08/f6mLr
 VKjtfEdY0UUae5zR58y5K0pu7aFttMdd7odbmJATttOMeeFGK5Jusqc/jTxfHoRCtB7i
 SS7lll8+eBhxtM51/F04Ri4Tb8erphdWLFZyO6bhcpib23q8NhXFCy+QLhz19C6EPmR8
 GtMMxx81qUSQIn4+ucYw5H+9fVNDaxbMBC94oHvdIVpRMvKF1pM2c64LPwxwUeeMhsM8
 YwJSSsLTiQq88qOglaHlhycx9g9lEEZSkDM1SdigTEa52QJP9mr1BsYV180cWapu3YPy
 jj8w==
X-Gm-Message-State: AOAM5308o7Pb6v/voCxLQplDBtGTMGUU1nmOTeURpjrnz/Kdi5RP0x6e
 Fo2qevKVfKApLrEs1/VaDzFN4LTxWmZZVg==
X-Google-Smtp-Source: ABdhPJy4TU3PM51f3K3kmgDMEOVi+nUBPrsBPSe9V+5xSFJBVaSwx5+EJW0gAsE4mqLxagwwDFsypw==
X-Received: by 2002:a92:cc43:: with SMTP id t3mr21821810ilq.250.1621912096031; 
 Mon, 24 May 2021 20:08:16 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com.
 [209.85.166.53])
 by smtp.gmail.com with ESMTPSA id d15sm12177284ila.86.2021.05.24.20.08.14
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 20:08:15 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id a6so2780924ioe.0
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 20:08:14 -0700 (PDT)
X-Received: by 2002:a6b:7b08:: with SMTP id l8mr16990516iop.50.1621912094090; 
 Mon, 24 May 2021 20:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-2-tientzu@chromium.org>
 <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
 <CALiNf2-9fRbH3Xs=fA+N1iRztFxeC0iTsyOSZFe=F42uwXS0Sg@mail.gmail.com>
 <YKvL865kutnHqkVc@0xbeefdead.lan>
In-Reply-To: <YKvL865kutnHqkVc@0xbeefdead.lan>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 25 May 2021 11:08:03 +0800
X-Gmail-Original-Message-ID: <CALiNf2_iq3OS+95as4fj+AOMDVYgGL71A1811QLaZ=5T7TRjww@mail.gmail.com>
Message-ID: <CALiNf2_iq3OS+95as4fj+AOMDVYgGL71A1811QLaZ=5T7TRjww@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] swiotlb: Refactor swiotlb init functions
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, maarten.lankhorst@linux.intel.com,
 airlied@linux.ie, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 sstabellini@kernel.org, Jim Quinlan <james.quinlan@broadcom.com>,
 xypron.glpk@gmx.de, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, May 24, 2021 at 11:53 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> > > do the set_memory_decrypted()+memset(). Is this okay or should
> > > swiotlb_init_io_tlb_mem() add an additional argument to do this
> > > conditionally?
> >
> > I'm actually not sure if this it okay. If not, will add an additional
> > argument for it.
>
> Any observations discovered? (Want to make sure my memory-cache has the
> correct semantics for set_memory_decrypted in mind).

It works fine on my arm64 device.

> >
> > > --
> > > Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
