Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19618C433B4
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 06:52:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6B0611BD
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 06:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6B0611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 76B1B40376;
	Tue, 18 May 2021 06:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VqMmW67j0LH8; Tue, 18 May 2021 06:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50367400BE;
	Tue, 18 May 2021 06:52:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27481C000E;
	Tue, 18 May 2021 06:52:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8D9AC0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9FBA606D6
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rCgEtPOxZUs8 for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 06:52:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1697860670
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:52:06 +0000 (UTC)
Received: by mail-io1-xd2a.google.com with SMTP id o21so8343593iow.13
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=okFGSzwxy3Xl1EDwrbsZ6bJWGdPaUEKxSezi4/SE71A=;
 b=KvboTWH6SCfdQ7LLxm6vH9xhTNNbPkylAhr3iqPQWH1QNODKOLIbMt/OYjboWMwVvr
 +KD/UQeQoUETk6OK7TCWS0Utmt5EvBfWbA4IzzRRuwJkDy5Qi3ICeWOTChp1Py6zaNQt
 fa1WHS9ymuIo1ivMcIga1N5vVpkmfX46UnGI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=okFGSzwxy3Xl1EDwrbsZ6bJWGdPaUEKxSezi4/SE71A=;
 b=DDBu9MAmKbBt8CcsUXvwy7A7ZoWaXsv0Lc0ArswNQ5j52nxOmwuYyI8NiOthV96ilX
 H5VS0tmfRNQZnNWKP9p6lRhjlTEm+HITSH7qN/JxsoxiZqd02Au/OZkyJKvB7vM+ManT
 pADIwFMIchtoNJL9hOj6GKqR7lPO5Ej0T/4IvMwxO+Wvccj2AO4Vc/XY3my+7yGyrFv7
 PlZcLqJzwtJplh3oD+7QDXceHoUVdZlKyx8E+nTd1jLbsmyN08WymK4WIdf0RyJLbQPc
 zr0nwH2P/1ceioi/FElnt/EB7L2AelLOLXIREIvQHwCUwKUlLd8GAcmgCMEjSD9e0WS2
 yL1Q==
X-Gm-Message-State: AOAM532qVavrZ5I4ZYwpXsH+Ah759Rkh+yb1xoNU5RVIX1THjYmNoFbq
 ueolPC+hfOlp/+R5/a7K1F5HWwDYDzV51g==
X-Google-Smtp-Source: ABdhPJyR85HZ6Iq+WUlihwpnR8BN16oTh60Np+p5C3jRtyoluHGrNPVKVxOCbdw+Eimf/w1Z2FvR0A==
X-Received: by 2002:a6b:b48a:: with SMTP id d132mr3104589iof.167.1621320726098; 
 Mon, 17 May 2021 23:52:06 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com.
 [209.85.166.172])
 by smtp.gmail.com with ESMTPSA id d16sm10018909ilo.12.2021.05.17.23.52.04
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 23:52:04 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id o10so7227363ilm.13
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 23:52:04 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a4d:: with SMTP id
 u13mr3011800ilv.64.1621320723564; 
 Mon, 17 May 2021 23:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-6-tientzu@chromium.org>
In-Reply-To: <20210518064215.2856977-6-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 18 May 2021 14:51:52 +0800
X-Gmail-Original-Message-ID: <CALiNf28ke3c91Y7xaHUgvJePKXqYA7UmsYJV9yaeZc3-4Lzs8Q@mail.gmail.com>
Message-ID: <CALiNf28ke3c91Y7xaHUgvJePKXqYA7UmsYJV9yaeZc3-4Lzs8Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] swiotlb: Add a new get_io_tlb_mem getter
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, 
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
 maarten.lankhorst@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Nicolas Boichat <drinkcat@chromium.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
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

Still keep this function because directly using dev->dma_io_tlb_mem
will cause issues for memory allocation for existing devices. The pool
can't support atomic coherent allocation so we need to distinguish the
per device pool and the default pool in swiotlb_alloc.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
