Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F830C433DB
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 20:29:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD81823120
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 20:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD81823120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 25120859D9;
	Tue, 12 Jan 2021 20:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OSPINexZrqy4; Tue, 12 Jan 2021 20:29:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8180F85792;
	Tue, 12 Jan 2021 20:29:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D863C0893;
	Tue, 12 Jan 2021 20:29:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA8FC013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 20:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1B01285BB0
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 20:29:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E7u5c+iaojuD for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:29:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2965385B7C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 20:29:49 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id j18so1541730qvu.3
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 12:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jpVWwEPUmolljz0bygjZEnHC+kQY90YrQfm8bas35/A=;
 b=ZqQdSWXFn78oCcz2KV8xPQb/CHeriM/t6XdeHAXl1kQ4+L8e/qR1NGczyGd3R3Bwyi
 9EHz54uNMI3JmuBvRKrRakJ3b/872Qg5FcN3akkPTEbUhn0UM0R6hEz5mt4sUXmxfnIb
 +2UeLZiJy6CTbsdGdlcV1rtBzFHjf09ZCKM9mOcoHeJyWX74H9n8Tysgs2xCIRApPCF4
 nfVWVyzKeAYocOGxP+wtA7+ucMHZ1CZ8JhvUxQnI/VAvNjDMAdMKtS9SIMXXzP+rByL9
 3DGwsTlgE91BMPPlS/ZK1rbWXwXSH4T2KTT4oJ4vPc8X0gnB14fgOF1UIWY97mMsPv1n
 jwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jpVWwEPUmolljz0bygjZEnHC+kQY90YrQfm8bas35/A=;
 b=NAyWVVPnJ8TiAr7unlfndIdYRfgNXJDXR+hfHLi1FDnJqldpncvVB7a2NO7hK5r5mi
 QtMpjlb7sWKooyB17eRH63WqwBV/gNAbyCeMpYDweu/Z1e3TPUaPL3B7YSemmIh6gZ5L
 0/C8GGIkKxBh2p+Uqat4NMw4u5AIzTwl9ZdGaQ523FqMKD/5nLHtHT7f5hoIrnbcQYPt
 /EdJ0I8vKz0XvTiaASQR7tJ5Yfy68//QUNbwhMJi1lFZlm+SRWauc/YPYB/4jAwyQXco
 DzA9bcnXYcXN6T0z/zPtj7urMpKCILl6ZyM0FB49/uqN6C/bqqhzj6duFLSNAVmWdhsf
 uM/A==
X-Gm-Message-State: AOAM532hZkwIlSifA6jJeeLjeZstnU6XpuqZS9l91m0zZQdB7iE5Aw4D
 VzMXPXlxEMI93LzjQjpvECJts/bkTY5F5ZOySX0=
X-Google-Smtp-Source: ABdhPJzzNhvbzPuZ+g8DPiRoyU2S3Jx0eslstzY3LMxX8uPmaKtgx3akxR8UHh8ZXD5kye0yZ/rgJu7U9xupBM3WwpU=
X-Received: by 2002:a0c:cc12:: with SMTP id r18mr845366qvk.51.1610483388234;
 Tue, 12 Jan 2021 12:29:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b@epcas5p1.samsung.com>
 <20210107093340.15279-1-ajaykumar.rs@samsung.com>
 <20210107130319.GA2986@willie-the-truck>
 <5e047da1-6619-c716-927c-ae07a90f1597@arm.com>
In-Reply-To: <5e047da1-6619-c716-927c-ae07a90f1597@arm.com>
From: Ajay Kumar <ajaykumar.rs1989@gmail.com>
Date: Wed, 13 Jan 2021 01:59:37 +0530
Message-ID: <CADe9J7Er0wnP5ZZbWM1CkUx7ry0znKr05Lvx7PEMdHuwKr_RZQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Handle duplicated Stream IDs from
 other masters
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>, robh+dt@kernel.org,
 Will Deacon <will@kernel.org>, Ajay Kumar <ajaykumar.rs@samsung.com>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Jan 12, 2021 at 12:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-07 13:03, Will Deacon wrote:
> > On Thu, Jan 07, 2021 at 03:03:40PM +0530, Ajay Kumar wrote:
> >> When PCI function drivers(ex:pci-endpoint-test) are probed for already
> >> initialized PCIe-RC(Root Complex), and PCIe-RC is already bound to SMMU,
> >> then we encounter a situation where the function driver tries to attach
> >> itself to the smmu with the same stream-id as PCIe-RC and re-initialize
> >> an already initialized STE. This causes ste_live BUG_ON() in the driver.
>
> Note that this is actually expected behaviour, since Stream ID aliasing
> has remained officially not supported until a sufficiently compelling
> reason to do so appears. I always thought the most likely scenario would
> be a legacy PCI bridge with multiple devices behind it, but even that
> seems increasingly improbable for a modern SMMUv3-based system to ever see.
Thanks to Will and Robin for reviewing this. I am pretty new to PCI,
sorry about that.
I assumed that the support for stream-id alias is already handled as
part of this patch:
https://www.spinics.net/lists/arm-kernel/msg626087.html
which prevents STE re-initialization. But, what I do not understand is
why the path
taken by the arm-smmu-v3 driver misses the aforementioned check for my usecase.

> > I don't understand why the endpoint is using the same stream ID as the root
> > complex in this case. Why is that? Is the grouping logic not working
> > properly?
>
> It's not so much that it isn't working properly, it's more that it needs
> to be implemented at all ;)
The pci_endpoint_test picks up the same of_ DMA config node as the PCI RC
because they sit on the same PCI bus [via pci_dma_configure( )]
While in the arm-smmu-v3 driver, I can see that the pci_device_group( ) hands
over the same iommu group as the Root Complex to the newly added master
device (pci_endpoint_test in our case) because they share the same stream ID.
Shouldn't they?

> >> There is an already existing check in the driver to manage duplicated ids
> >> if duplicated ids are added in same master device, but there can be
> >> scenarios like above where we need to extend the check for other masters
> >> using the same stream-id.
> >>
> >> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
> >>   1 file changed, 33 insertions(+)
> >
> > It doesn't feel like the driver is the right place to fix this, as the same
> > issue could surely occur for other IOMMUs too, right? In which case, I think
> > we should avoid getting into the situation where different groups have
> > overlapping stream IDs.
>
> Yes, this patch does not represent the correct thing to do either way.
> The main reason that Stream ID aliasing hasn't been supported so far is
> that the required Stream ID to group lookup is rather awkward, and
> adding all of that complexity just for the sake of a rather unlikely
> possibility seemed dubious. However, PRI support has always had a more
> pressing need to implement almost the same thing (Stream ID to device),
> so once that lands we can finally get round to adding the rest of proper
> group support relatively easily.
I hope the support will be added soon. Also, can you point me to few drivers
which already handle this type of stream-ID aliasing?

Thanks,
Ajay Kumar
> ______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
