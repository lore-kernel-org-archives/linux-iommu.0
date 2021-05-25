Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE5C2B9F7
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 03:14:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836A961404
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 03:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836A961404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E20A4031F;
	Tue, 25 May 2021 03:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MIwZrg8wm04d; Tue, 25 May 2021 03:14:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4F2B40268;
	Tue, 25 May 2021 03:14:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 861FBC000D;
	Tue, 25 May 2021 03:14:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 331C1C0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 200DA40204
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:14:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZhDC16Q2LssR for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 03:14:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA9CA400B5
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:14:09 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id i5so21636000pgm.0
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ibLnJElvlxlVpclpJPUNJ2cC/oiUOQSOujwiFR/Tp+s=;
 b=UieisilkjhqvCv5TM4Uhta7TWRN2Fo+qizEnyHuJxA4va8bXfSD+rLVykfuHhWprMs
 LshPVy4dFsoXIkmd56qov4ggYtlL759ArIJ4nJdiIlOu+d8oU3Tdh/1w/BJ1fDxfpbcA
 V3s9TTUmNV6cOGqUjcXpB0nmY9PGjsUH8vbqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ibLnJElvlxlVpclpJPUNJ2cC/oiUOQSOujwiFR/Tp+s=;
 b=QqlBR11nMDIvH38AHCB4NY+xq2W3nt1qe71Wzf3oI0EHmKmXIJE2L312fI9gAZSVS0
 gkJy3EJT/60qsu/Wi59XIqIJnFQ4r+eRK5eGSiBYYk5u2okA/QOHpNILqp413hetj3rf
 2cGXeMyT/v6I97C9/7DIsJIxVn12GLIxWwu1+4TgMHNUuOQoR+V2tPwbh3IhDRSd4QZL
 5FKiT0uaetE3HBzhywruLW7++2RZbi2OzAjEF4jihYqm/EkgwtJprAMGwZYet4jnGHbE
 EAsUvELZBL1NZWGpEWm3QFL+nRrUW+wVF69CnOw08PqOAhg+QmwqQ0KI1gF/PDAWhiuN
 lsiQ==
X-Gm-Message-State: AOAM532lw3mIMI88fbO+CUePOprpBOOi3W/9KZRx/ekUVSurA+2ud7Kh
 lb4fjJtB/OZvk4CvUxB36yTQVYNpCtpyZg==
X-Google-Smtp-Source: ABdhPJyDlbU8zN4Op/MXDPsB64ryvVoKPV89fonTvyFxOkiSEqRxlnslg351HPIRx7K6sS5YN3Bb5g==
X-Received: by 2002:a62:e908:0:b029:2db:8791:c217 with SMTP id
 j8-20020a62e9080000b02902db8791c217mr28225911pfh.28.1621912449023; 
 Mon, 24 May 2021 20:14:09 -0700 (PDT)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com.
 [209.85.210.174])
 by smtp.gmail.com with ESMTPSA id y13sm12801463pgp.16.2021.05.24.20.14.08
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 20:14:08 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id j21so105958pfj.6
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 20:14:08 -0700 (PDT)
X-Received: by 2002:a05:6e02:b:: with SMTP id
 h11mr18955732ilr.18.1621912124990; 
 Mon, 24 May 2021 20:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-6-tientzu@chromium.org>
 <CALiNf28ke3c91Y7xaHUgvJePKXqYA7UmsYJV9yaeZc3-4Lzs8Q@mail.gmail.com>
 <YKvLc9onyqdsINP7@0xbeefdead.lan>
In-Reply-To: <YKvLc9onyqdsINP7@0xbeefdead.lan>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 25 May 2021 11:08:34 +0800
X-Gmail-Original-Message-ID: <CALiNf28=fn5r_O8ET0TNM6cS7WO0mwXiMzR5z=eJXmNKFWKdzA@mail.gmail.com>
Message-ID: <CALiNf28=fn5r_O8ET0TNM6cS7WO0mwXiMzR5z=eJXmNKFWKdzA@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] swiotlb: Add a new get_io_tlb_mem getter
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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
 Will Deacon <will@kernel.org>, maarten.lankhorst@linux.intel.com,
 airlied@linux.ie, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, boris.ostrovsky@oracle.com,
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

On Mon, May 24, 2021 at 11:51 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Tue, May 18, 2021 at 02:51:52PM +0800, Claire Chang wrote:
> > Still keep this function because directly using dev->dma_io_tlb_mem
> > will cause issues for memory allocation for existing devices. The pool
> > can't support atomic coherent allocation so we need to distinguish the
> > per device pool and the default pool in swiotlb_alloc.
>
> This above should really be rolled in the commit. You can prefix it by
> "The reason it was done this way was because directly using .."
>

Will add it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
