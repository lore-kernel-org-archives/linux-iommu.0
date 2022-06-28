Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE96C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 21:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 244D74032A;
	Tue, 28 Jun 2022 21:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 244D74032A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b9uS1y9z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P5nzS6DomVDF; Tue, 28 Jun 2022 21:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CC8F8400F3;
	Tue, 28 Jun 2022 21:55:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC8F8400F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD38C0032;
	Tue, 28 Jun 2022 21:55:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C64BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 224F78145A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:55:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 224F78145A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=b9uS1y9z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5YXc9kq7CvGU for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 21:55:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BEF181449
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BEF181449
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:55:40 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4F69AB82060
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3DFC36AE2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656453335;
 bh=Ih9a5Om/MmEIX4v6ClfaGsYY95Thx/a8Y6asrG6fwXg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=b9uS1y9zZH5shNehIU788hla2D3cqHzEuOf4ntBz7MxqozEJwfWJnE7Ks7x80vJUW
 8kv3pqmsjiCee09PX0yvTGcEx2Cut7rd5VUEPi1Ok/r71Li89UIa9lEeJs5lir3L9G
 dn4sMp8EjadD8vyN158bB9WMKMo5ug00j2hr3Rw0LFCkWa1OVhmADFgMiyWCAjhqeq
 2pPGkYfNIcwUIJa/2IbGbgiBIvXriXV6e543WcMEwsN7/jAf15mGlk3t/07+apGlTT
 9sZR5rPOipfKd8HT5ntaMBYuQG73aLI/777pK3YIaE2zifWvCB2udwOFws1KKx4vlJ
 kWfB059WXYR2A==
Received: by mail-yb1-f182.google.com with SMTP id h187so22341025ybg.0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:55:35 -0700 (PDT)
X-Gm-Message-State: AJIora8IW1WYsTTikuWWP6e10A1/9BA1q11flCsnL2OQvrThvMVWyrBZ
 mxZR2etz3p++1qNX/BwYHUOYAq0QLrjIuJ5q1HE=
X-Google-Smtp-Source: AGRyM1tb4BjbkpD5w5tudBkGYRK/cIE8Bb7XiI/EYhHGbLLjj5dThHoetSIfSlMkV4AlJod7kkGZlzoBKXhTY7DLP7I=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr22801646ybu.134.1656453334640; Tue, 28
 Jun 2022 14:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
 <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
In-Reply-To: <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 28 Jun 2022 23:55:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jvFQBvKfdR5ivDBECN5tEej6Ja4=7Loze646hrQ5wzg@mail.gmail.com>
Message-ID: <CAK8P3a2jvFQBvKfdR5ivDBECN5tEej6Ja4=7Loze646hrQ5wzg@mail.gmail.com>
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

On Tue, Jun 28, 2022 at 11:38 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 28/06/22 19:08, Arnd Bergmann wrote:
> > I see two other problems with your patch though:
> >
> > a) you still duplicate the cache handling: the cache_clear()/cache_push()
> > is supposed to already be done by dma_map_single() when the device
> > is not cache-coherent.
>
> That's one of the 'liberties' I alluded to. The reason I left these in
> is that I'm none too certain what device feature the DMA API uses to
> decide a device isn't cache-coherent. If it's dev->coherent_dma_mask,
> the way I set up the device in the a3000 driver should leave the
> coherent mask unchanged. For the Zorro drivers, devices are set up to
> use the same storage to store normal and coherent masks - something we
> most likely want to change. I need to think about the ramifications of
> that.
>
> Note that zorro_esp.c uses dma_sync_single_for_device() and uses a 32
> bit coherent DMA mask which does work OK. I might  ask Adrian to test a
> change to only set dev->dma_mask, and drop the
> dma_sync_single_for_device() calls if there's any doubt on this aspect.

The "coherent_mask" is independent of the cache flushing. On some
architectures, a device can indicate whether it needs cache management
or not to guarantee coherency, but on m68k it appears that we always
assume it does, see arch/m68k/kernel/dma.c

> > b) The bounce buffer is never mapped here, instead you have the
> > virt_to_phys() here, which is not the same. I think you need to map
> > the pointer that actually gets passed down to the device after deciding
> > to use a bouce buffer or not.
>
> I hadn't realized that I can map the bounce buffer just as it's done for
> the SCp data buffer. Should have been obvious, but I'm still learning
> about the DMA API.
>
> I've updated the patch now, will re-send as part of a complete series
> once done.

I suppose you can just drop the bounce buffer if this just comes
from kmalloc().

       Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
