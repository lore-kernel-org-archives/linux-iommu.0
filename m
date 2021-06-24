Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE7DC48BDF
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 06:06:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B03613B0
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 06:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B03613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 629D060B32;
	Thu, 24 Jun 2021 06:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 73zbTyql1X8c; Thu, 24 Jun 2021 06:06:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B8CD6079D;
	Thu, 24 Jun 2021 06:06:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49A46C0010;
	Thu, 24 Jun 2021 06:06:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EB1EC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 06:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E891F40154
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 06:06:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQ4lJ9nyijth for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 06:06:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 383AB4010E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 06:06:04 +0000 (UTC)
Received: by mail-il1-x12b.google.com with SMTP id b5so4929842ilc.12
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 23:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=osJqntoZHJL8VeQbE2d8Gx1TrOiajWQXazXH9w70kIY=;
 b=f09JHaTt6yY9HlwcujpzmyCJbvbUoIE0cZNa0aICkCK68T/rODYze/6/aKRkuFqgtc
 aQSgGc4CEL1bXaOSKVo+xlBop7hH5m1EqqxXbZi8VyWUJmFL6g6BM4X4ZMkMlYffhkXb
 itPPZk67YIl+8XjGG/C0lboNwjIIr80wXQ+NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=osJqntoZHJL8VeQbE2d8Gx1TrOiajWQXazXH9w70kIY=;
 b=aSxvuiHDVpPufMqyjAGXX7RJAmpInUKOQJpxyarOAHHMKNDnWbzZyKL9M34PU/wyS5
 MbcgSKCO50eR+qDzock6Wk0RLdii223U2qVNUnEWFdipJacuzP40KBRacLAZQBqHyzLn
 ys9HdLTPh9ed4jzv3L1buoC9MIBPQvvcNRnZNPmoeJntkKmlCfqLFu8ZiG6nI9hg1wLm
 +drPKT+V2q+KKzhVRilcvCPO2stclq2/wMkNknSTpj9h3JNuaVBgmWS6DzqF2d290H8u
 ltd5iTtQ88H0PeL35R+CtRpr1SnETOe09710zTMvOEbVeK+Tm9gdz/zzx883NSbZ4sXF
 TDZw==
X-Gm-Message-State: AOAM530WTaaaGcYcJN6KVfWLnh2luFcnfhzvVWEktRB6oJ6+qPENGaGW
 CONFEnWHJ+pkoC12Ua+5hMy2zQuHU10TdQ==
X-Google-Smtp-Source: ABdhPJwHhLMSQuUno6EkjT6o/QzZPMcqtfaRrManp8wQBJned3yRfZjIMO41+NCHwO9HqaiKUg0GWw==
X-Received: by 2002:a92:7d07:: with SMTP id y7mr2415586ilc.68.1624514763093;
 Wed, 23 Jun 2021 23:06:03 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com.
 [209.85.166.172])
 by smtp.gmail.com with ESMTPSA id x8sm1190476ila.36.2021.06.23.23.06.01
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 23:06:02 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id q9so4984626ilj.3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 23:06:01 -0700 (PDT)
X-Received: by 2002:a92:750c:: with SMTP id q12mr2332407ilc.303.1624514749926; 
 Wed, 23 Jun 2021 23:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210619034043.199220-1-tientzu@chromium.org>
 <20210619034043.199220-7-tientzu@chromium.org>
 <76c3343d-72e5-9df3-8924-5474ee698ef4@quicinc.com>
 <20210623183736.GA472@willie-the-truck>
 <19d4c7a2-744d-21e0-289c-a576e1f0e6f3@quicinc.com>
 <20210624054315.GA25381@lst.de>
In-Reply-To: <20210624054315.GA25381@lst.de>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 24 Jun 2021 14:05:39 +0800
X-Gmail-Original-Message-ID: <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
Message-ID: <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
Subject: Re: [PATCH v14 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
To: Christoph Hellwig <hch@lst.de>
Cc: heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Dan Williams <dan.j.williams@intel.com>, matthew.auld@intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, thomas.hellstrom@linux.intel.com,
 Jim Quinlan <james.quinlan@broadcom.com>, Will Deacon <will@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 Robin Murphy <robin.murphy@arm.com>, jani.nikula@linux.intel.com,
 Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 airlied@linux.ie, Thierry Reding <treding@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Qian Cai <quic_qiancai@quicinc.com>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, xypron.glpk@gmx.de,
 Tom Lendacky <thomas.lendacky@amd.com>, linuxppc-dev@lists.ozlabs.org,
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

On Thu, Jun 24, 2021 at 1:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jun 23, 2021 at 02:44:34PM -0400, Qian Cai wrote:
> > is_swiotlb_force_bounce at /usr/src/linux-next/./include/linux/swiotlb.h:119
> >
> > is_swiotlb_force_bounce() was the new function introduced in this patch here.
> >
> > +static inline bool is_swiotlb_force_bounce(struct device *dev)
> > +{
> > +     return dev->dma_io_tlb_mem->force_bounce;
> > +}
>
> To me the crash looks like dev->dma_io_tlb_mem is NULL.  Can you
> turn this into :
>
>         return dev->dma_io_tlb_mem && dev->dma_io_tlb_mem->force_bounce;
>
> for a quick debug check?

I just realized that dma_io_tlb_mem might be NULL like Christoph
pointed out since swiotlb might not get initialized.
However,  `Unable to handle kernel paging request at virtual address
dfff80000000000e` looks more like the address is garbage rather than
NULL?
I wonder if that's because dev->dma_io_tlb_mem is not assigned
properly (which means device_initialize is not called?).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
