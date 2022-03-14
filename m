Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04F7C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 10:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 856268136C;
	Mon, 14 Mar 2022 10:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BX9wAsQECB_0; Mon, 14 Mar 2022 10:44:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55BEC81366;
	Mon, 14 Mar 2022 10:44:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D4E3C0033;
	Mon, 14 Mar 2022 10:44:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76302C0012
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 10:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 561828136C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 10:44:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLbkQK7to0Ak for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 10:44:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68C2981366
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 10:44:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1081F60FEB
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 10:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7608AC340F6
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647254644;
 bh=uvT7cU81YIqJYT+cVhR9x1v9dJvyUVAe9djV4LzrujM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=i2EUXEY1Fo27lNy0cAuSx6VOXrec+7nYpdzsIL3ASVQRcYKDc1CzTseG3U/77zBbP
 KQ27ceMraG19eze0yDpy6QS9lUsdaGQyzxcLKxgbhdD5lH2Oq9qKMiQ0pG2BZ+4Kjf
 uDKz+PgMVDOeTOZ4GGL/5kWuqNMeGWmYAdngDf4ZcoWuDHZwSlpnOGvgZEuDbl62uk
 tU8glwOJeiujYXdKKxdrvw1GRChCG0yXFs8A2ks3tpfhGHL9xmTSmQdm6Sp8Xkv9mM
 t7ihwEYflM+I/cwxvYHRBFcZbIiRpc9RecHD80CqZNq/o5BalXfipjdyKO8l5apW9x
 U09PqNlMdzdoA==
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-2d07ae0b1c4so157049767b3.11
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 03:44:04 -0700 (PDT)
X-Gm-Message-State: AOAM5307zf6FFZGxGdQDMRvaOCXkGQyOR4AxcWKm2PiUi9ZnOSNivJ10
 A6QtoWb+o4oqfCzjWcWNzPgCi7DzKzDXfIKjyuc=
X-Google-Smtp-Source: ABdhPJzP53rsKKCg9qV4VsUmz7jL/PEPygwkKuSbsi4+znY1kUz24XWdAJ8TzEoDjQiyQ6uv7ejl/KzDM5P6h65RKfU=
X-Received: by 2002:a81:e90c:0:b0:2db:d63e:56ff with SMTP id
 d12-20020a81e90c000000b002dbd63e56ffmr18727137ywm.60.1647254643455; Mon, 14
 Mar 2022 03:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com>
 <8ecce421-e2ee-1a19-ae2d-a8454a8a5844@arm.com>
 <0cde239c-8d30-33a8-6e5b-792e30e20462@redhat.com>
In-Reply-To: <0cde239c-8d30-33a8-6e5b-792e30e20462@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Mar 2022 11:43:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEn8RhmHcCxpKeDy_B8-072wvbsZzc-78XNFJdtaKPWBQ@mail.gmail.com>
Message-ID: <CAMj1kXEn8RhmHcCxpKeDy_B8-072wvbsZzc-78XNFJdtaKPWBQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
To: Eric Auger <eric.auger@redhat.com>
Cc: Will Deacon <will@kernel.org>, Jon Nettleton <jon@solid-run.com>,
 Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Mon, 14 Mar 2022 at 11:37, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Robin
>
> On 3/11/22 11:34 AM, Robin Murphy wrote:
> > On 2022-03-11 08:19, Eric Auger wrote:
> >> Hi guys,
> >>
> >> On 2/21/22 4:43 PM, Shameer Kolothum wrote:
> >>> Hi,
> >>>
> >>> Since we now have an updated verion[0] of IORT spec(E.d) which
> >>> addresses the memory attributes issues discussed here [1],
> >>> this series now make use of it.
> >>>
> >>> The pull request for ACPICA E.d related changes are already
> >>> raised and can be found here,
> >>> https://github.com/acpica/acpica/pull/752
> >>>
> >>> v7 --> v8
> >>>    - Patch #1 has temp definitions for RMR related changes till
> >>>      the ACPICA header changes are part of kernel.
> >>>    - No early parsing of RMR node info and is only parsed at the
> >>>      time of use.
> >>>    - Changes to the RMR get/put API format compared to the
> >>>      previous version.
> >>>    - Support for RMR descriptor shared by multiple stream IDs.
> >>>
> >>> Please take a look and let me know your thoughts.
> >>>
> >>> Thanks,
> >>> Shameer
> >>> [0] https://developer.arm.com/documentation/den0049/ed/
> >> I still have a question on the IORT E.d spec (unrelated to this series).
> >>
> >> The spec mandates that if RMR nodes are presented in the IORT,
> >> _DSM function #5 for the PCIe host bridge ACPI device object must return
> >> 0, indicating the OS must honour the PCI config that the FW computed at
> >> boot time.
> >>
> >> However implementing this _DSM #5 as above is known to prevent PCI
> >> devices with IO ports from working, on aarch64 linux.
> >>
> >> "
> >> The reason is that EFI creates I/O port mappings below
> >>      0x1000 (in fact, at 0). However Linux, for legacy reasons, does not
> >>      support I/O ports <= 0x1000 on PCI, so the I/O assignment
> >> created by EFI
> >>      is rejected.
> >>          EFI creates the mappings primarily for itself, and up until
> >> DSM #5
> >>      started to be enforced, all PCI resource allocations that
> >> existed at
> >>      boot were ignored by Linux and recreated from scratch.
> >> "
> >>
> >> This is an excerpt of a qemu commit message that reverted the _DMS #5
> >> change (Revert "acpi/gpex: Inform os to keep firmware resource map").
> >> Has the situation changed since July 2021 (ie. has UEFI been reworked?).
> >> [+ Ard]
> >
> > FWIW I wasn't aware of that, but if it's an issue then it will need to
> > be fixed in Linux or UEFI's PCI resource code (arguably if UEFI has
> > already allocated from the bottom of I/O space then Linux should be
> > safe to assume that there are no legacy PC I/O resources to worry
> > about). The DSM is required to prevent bus numbers being reassigned,
> > because if that happens then any PCI StreamIDs referenced in IORT may
> > suddenly become meaningless and the association of root complex nodes
> > and RMRs to physical hardware lost.
>
> Thank you for confirming and explaining the need for DSM #5. Ard, please
> could you confirm that the incompatibility with PCI devices with IO
> ports is still there?
>

Yes, and this needs to be fixed in Linux. The firmware complies with
the pertinent specifications, and it is Linux that deviates from this
for legacy reasons.

IIRC, this came up on the mailing list at some point, and one of the
issues is that I/O port 0x0 is mistaken for 'no resource' or some
other exceptional case like that, so even if we fix the arbitrary
limit of 0x1000, we may still run into trouble when devices uses I/O
port 0x0.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
