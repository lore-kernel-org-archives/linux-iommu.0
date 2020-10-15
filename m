Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B79C433E7
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 18:03:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B2520797
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 18:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B2520797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 175D58849E;
	Thu, 15 Oct 2020 18:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXt3BpxXo3bo; Thu, 15 Oct 2020 18:03:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ED3CF8849B;
	Thu, 15 Oct 2020 18:03:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4E5AC0052;
	Thu, 15 Oct 2020 18:03:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C406C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 18:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 91B5C1FEAB
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 18:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RqJKa62fbd+Y for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 18:03:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id F40492E317
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 18:03:47 +0000 (UTC)
Received: from gaia (unknown [95.149.105.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCEC820797;
 Thu, 15 Oct 2020 18:03:43 +0000 (UTC)
Date: Thu, 15 Oct 2020 19:03:41 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
Message-ID: <20201015180340.GB2624@gaia>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
 <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, ardb@kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
 robin.murphy@arm.com, hch@lst.de, linux-rpi-kernel@lists.infradead.org
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

On Thu, Oct 15, 2020 at 10:26:18PM +0800, Hanjun Guo wrote:
> On 2020/10/15 3:12, Nicolas Saenz Julienne wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> > incorporating masters that can address less than 32 bits of DMA, in
> > particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> > peripherals that can only address up to 1 GB (and its PCIe host
> > bridge can only access the bottom 3 GB)
> > 
> > Instructing the DMA layer about these limitations is straight-forward,
> > even though we had to fix some issues regarding memory limits set in
> > the IORT for named components, and regarding the handling of ACPI _DMA
> > methods. However, the DMA layer also needs to be able to allocate
> > memory that is guaranteed to meet those DMA constraints, for bounce
> > buffering as well as allocating the backing for consistent mappings.
> > 
> > This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> > it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> > problems with kdump, and potentially in other places where allocations
> > cannot cross zone boundaries. Therefore, we should avoid having two
> > separate DMA zones when possible.
> > 
> > So let's do an early scan of the IORT, and only create the ZONE_DMA
> > if we encounter any devices that need it. This puts the burden on
> > the firmware to describe such limitations in the IORT, which may be
> > redundant (and less precise) if _DMA methods are also being provided.
> > However, it should be noted that this situation is highly unusual for
> > arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> > the _DMA method if implemented, and so we will not lose the ability to
> > perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> > it.
> 
> Sorry, I'm still a little bit confused. With this patch, if we have
> a device which set the right _DMA method (DMA size >= 32), but with the
> wrong DMA size in IORT, we still have the ZONE_DMA created which
> is actually not needed?

With the current kernel, we get a ZONE_DMA already with an arbitrary
size of 1GB that matches what RPi4 needs. We are trying to eliminate
such unnecessary ZONE_DMA based on some heuristics (well, something that
looks "better" than a OEM ID based quirk). Now, if we learn that IORT
for platforms in the field is that broken as to describe few bits-wide
DMA masks, we may have to go back to the OEM ID quirk.

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
