Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0565FC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 21:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E5354081F;
	Tue, 28 Jun 2022 21:51:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E5354081F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=elEeeKUD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4yfj-hiY00H2; Tue, 28 Jun 2022 21:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 235354059D;
	Tue, 28 Jun 2022 21:51:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 235354059D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9C0BC0032;
	Tue, 28 Jun 2022 21:51:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAD07C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF0B040611
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:51:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF0B040611
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7z7Akdtj0UrG for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 21:51:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACC454059D
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACC454059D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:51:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B1F66B82062
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E7EC385A2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656453055;
 bh=Eulr4Y0cWb7qjc6CpxCm3Vct1+OoFSfv0gPahuMP8H0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=elEeeKUDea9hk5aQmAteuIyRdHZZsKhLl3Vgkrf0ebuHMVDyxzs1owwkAc5icxtXR
 Tv3y3Ypg5BZfSAA4fm/1du/h9YT9oUMVvzdwBxhJY45v0cynFE7MH/FGecsgnZV2dk
 iPm6ogOEDIT42r9PUlRQz9dQNjh6tOzSwvfw+orYrQP8DJdAcBTb8Txl9TLsSqkRI5
 7J7GSf1511sS2KBwajo4lNLtrnzx6YNYJIcRb3aJarxomVr3XyXRVQbc5LQe6sATzH
 Szilv/6OGgYptkfbHHlymMEVoWlRUtOrH4DB1kh3spBftyplxnSoqxW2EfM72iufIW
 dnOIf5/XmvBRg==
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-31bf327d4b5so41577657b3.13
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:50:55 -0700 (PDT)
X-Gm-Message-State: AJIora+HFpbRnvsZObmkCQpUGmby11LXhplQSh/da2b5JQqfXRnWQ9QL
 NHjWOBV+EHxCelUo4XbpLKocnk/kpYqWNfkqQ7s=
X-Google-Smtp-Source: AGRyM1uiK3Jm9EI3ugNHld4Mw8359HNpN0AV60gdNeVzfnYPf20oZVN1walPYmvUh7o4VEBL7hhWBeeKgOlyyZ+Nc1k=
X-Received: by 2002:a0d:df0f:0:b0:31b:e000:7942 with SMTP id
 i15-20020a0ddf0f000000b0031be0007942mr283034ywe.320.1656453054172; Tue, 28
 Jun 2022 14:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
In-Reply-To: <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 28 Jun 2022 23:50:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
Message-ID: <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Denis Efremov <efremov@linux.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Khalid Aziz <khalid@gonehiking.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Matt Wang <wwentao@vmware.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Salyzyn <salyzyn@android.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>
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

On Tue, Jun 28, 2022 at 11:03 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 28/06/22 19:03, Geert Uytterhoeven wrote:
> >> The driver allocates bounce buffers using kmalloc if it hits an
> >> unaligned data buffer - can such buffers still even happen these days?
> > No idea.
> Hmmm - I think I'll stick a WARN_ONCE() in there so we know whether this
> code path is still being used.

kmalloc() guarantees alignment to the next power-of-two size or
KMALLOC_MIN_ALIGN, whichever is bigger. On m68k this means it
is cacheline aligned.

      Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
