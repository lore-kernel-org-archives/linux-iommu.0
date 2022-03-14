Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBFEC433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 11:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9822408DE;
	Mon, 14 Mar 2022 11:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lh2i-ZoXqkxk; Mon, 14 Mar 2022 11:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8303C40884;
	Mon, 14 Mar 2022 11:30:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66B60C001D;
	Mon, 14 Mar 2022 11:30:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 704F9C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 11:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E0BD40376
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 11:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJCsavW7hl4l for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:30:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id C209F405F4
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 11:30:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC2B9106F;
 Mon, 14 Mar 2022 04:30:39 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.42.155])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578FF3F99C;
 Mon, 14 Mar 2022 04:30:37 -0700 (PDT)
Date: Mon, 14 Mar 2022 11:30:31 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Message-ID: <Yi8nV8H4Jjlpadmk@lpieralisi>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com>
 <8ecce421-e2ee-1a19-ae2d-a8454a8a5844@arm.com>
 <0cde239c-8d30-33a8-6e5b-792e30e20462@redhat.com>
 <CAMj1kXEn8RhmHcCxpKeDy_B8-072wvbsZzc-78XNFJdtaKPWBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXEn8RhmHcCxpKeDy_B8-072wvbsZzc-78XNFJdtaKPWBQ@mail.gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Jon Nettleton <jon@solid-run.com>,
 Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Mon, Mar 14, 2022 at 11:43:51AM +0100, Ard Biesheuvel wrote:
> On Mon, 14 Mar 2022 at 11:37, Eric Auger <eric.auger@redhat.com> wrote:
> >
> > Hi Robin
> >
> > On 3/11/22 11:34 AM, Robin Murphy wrote:
> > > On 2022-03-11 08:19, Eric Auger wrote:
> > >> Hi guys,
> > >>
> > >> On 2/21/22 4:43 PM, Shameer Kolothum wrote:
> > >>> Hi,
> > >>>
> > >>> Since we now have an updated verion[0] of IORT spec(E.d) which
> > >>> addresses the memory attributes issues discussed here [1],
> > >>> this series now make use of it.
> > >>>
> > >>> The pull request for ACPICA E.d related changes are already
> > >>> raised and can be found here,
> > >>> https://github.com/acpica/acpica/pull/752
> > >>>
> > >>> v7 --> v8
> > >>>    - Patch #1 has temp definitions for RMR related changes till
> > >>>      the ACPICA header changes are part of kernel.
> > >>>    - No early parsing of RMR node info and is only parsed at the
> > >>>      time of use.
> > >>>    - Changes to the RMR get/put API format compared to the
> > >>>      previous version.
> > >>>    - Support for RMR descriptor shared by multiple stream IDs.
> > >>>
> > >>> Please take a look and let me know your thoughts.
> > >>>
> > >>> Thanks,
> > >>> Shameer
> > >>> [0] https://developer.arm.com/documentation/den0049/ed/
> > >> I still have a question on the IORT E.d spec (unrelated to this series).
> > >>
> > >> The spec mandates that if RMR nodes are presented in the IORT,
> > >> _DSM function #5 for the PCIe host bridge ACPI device object must return
> > >> 0, indicating the OS must honour the PCI config that the FW computed at
> > >> boot time.
> > >>
> > >> However implementing this _DSM #5 as above is known to prevent PCI
> > >> devices with IO ports from working, on aarch64 linux.
> > >>
> > >> "
> > >> The reason is that EFI creates I/O port mappings below
> > >>      0x1000 (in fact, at 0). However Linux, for legacy reasons, does not
> > >>      support I/O ports <= 0x1000 on PCI, so the I/O assignment
> > >> created by EFI
> > >>      is rejected.
> > >>          EFI creates the mappings primarily for itself, and up until
> > >> DSM #5
> > >>      started to be enforced, all PCI resource allocations that
> > >> existed at
> > >>      boot were ignored by Linux and recreated from scratch.
> > >> "
> > >>
> > >> This is an excerpt of a qemu commit message that reverted the _DMS #5
> > >> change (Revert "acpi/gpex: Inform os to keep firmware resource map").
> > >> Has the situation changed since July 2021 (ie. has UEFI been reworked?).
> > >> [+ Ard]
> > >
> > > FWIW I wasn't aware of that, but if it's an issue then it will need to
> > > be fixed in Linux or UEFI's PCI resource code (arguably if UEFI has
> > > already allocated from the bottom of I/O space then Linux should be
> > > safe to assume that there are no legacy PC I/O resources to worry
> > > about). The DSM is required to prevent bus numbers being reassigned,
> > > because if that happens then any PCI StreamIDs referenced in IORT may
> > > suddenly become meaningless and the association of root complex nodes
> > > and RMRs to physical hardware lost.
> >
> > Thank you for confirming and explaining the need for DSM #5. Ard, please
> > could you confirm that the incompatibility with PCI devices with IO
> > ports is still there?
> >
> 
> Yes, and this needs to be fixed in Linux. The firmware complies with
> the pertinent specifications, and it is Linux that deviates from this
> for legacy reasons.
> 
> IIRC, this came up on the mailing list at some point, and one of the
> issues is that I/O port 0x0 is mistaken for 'no resource' or some
> other exceptional case like that, so even if we fix the arbitrary
> limit of 0x1000, we may still run into trouble when devices uses I/O
> port 0x0.

Yes, I need to go back to that thread to sort this out.

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
