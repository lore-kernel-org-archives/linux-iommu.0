Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E202CCA479
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F54F404E2;
	Tue, 28 Jun 2022 07:08:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F54F404E2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qC+UQmph
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvTTDz9dGVU6; Tue, 28 Jun 2022 07:08:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7C4D64027A;
	Tue, 28 Jun 2022 07:08:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C4D64027A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD9CC0032;
	Tue, 28 Jun 2022 07:08:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56A6FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2311A4048C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:08:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2311A4048C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hkGeyePkz58D for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:08:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 646C04027A
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 646C04027A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:08:35 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1E23F619E3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84016C341D8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656400112;
 bh=Dm+i1ahm5JO1Y0z9h4uqTDK4kJt3Abm9W7KKXWn4iRE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qC+UQmphl8Hd+1T1U0QD9tDpqj4RMtyFkgyHY4s5qIB7gRI+xS50dQLQF60N4d53a
 pt8nrB+n/0dsGBpX9rzm604Cauhg2V1pGMdOs9Z8ftj1edDPVWFevjoguG98IqrTXI
 ivqLmEwSVJigzb4BvjUY8SyP2jqcLYvPGrfQt0+Lb4o5OGtjK05l74oqdAtZe6v+RV
 EiZUgKYNvTN+ggir5o2MPXO4/eJKq2WsfCAQvCsHp1NxR2fH/lMZBuGL6JAF9vspsB
 biRI4WdoUfZ8vhFQRuwocB5PEe84qldt+0c/fmHu+92iK9/LCneqYIva5kjHPnQFrz
 CH1QITDOJFbvA==
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-317710edb9dso107753737b3.0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 00:08:32 -0700 (PDT)
X-Gm-Message-State: AJIora+4FADoM4qkzQNlCDHDPLV+NGtx2swEl8Tu/Fi7pHmhhbKQEqJQ
 MUqkU9kl5vdrLXThonf6Rsb3tuVTsL/diqfLH9o=
X-Google-Smtp-Source: AGRyM1vKbt5VKtzdC4XgmSFOrmSiRmjlG5/FEc3iJTDP+CtgJE9woQ9uDs2lLsQ8604dHCHHG6u5L7MmI7NPb3gwZE4=
X-Received: by 2002:a81:1d43:0:b0:318:638d:2ca with SMTP id
 d64-20020a811d43000000b00318638d02camr20536106ywd.135.1656400111255; Tue, 28
 Jun 2022 00:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
In-Reply-To: <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 28 Jun 2022 09:08:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
Message-ID: <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>, scsi <linux-scsi@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>,
 Matt Wang <wwentao@vmware.com>
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

On Tue, Jun 28, 2022 at 5:25 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.2022 um 09:12 schrieb Michael Schmitz:
>
> Leaving the bounce buffer handling in place, and taking a few other
> liberties - this is what converting the easiest case (a3000 SCSI) might
> look like. Any obvious mistakes? The mvme147 driver would be very
> similar to handle (after conversion to a platform device).
>
> The driver allocates bounce buffers using kmalloc if it hits an
> unaligned data buffer - can such buffers still even happen these days?
> If I understand dma_map_single() correctly, the resulting dma handle
> would be equally misaligned?
>
> To allocate a bounce buffer, would it be OK to use dma_alloc_coherent()
> even though AFAIU memory used for DMA buffers generally isn't consistent
> on m68k?

I think it makes sense to skip the bounce buffering as you do here:
the only standardized way we have for integrating that part is to
use the swiotlb infrastructure, but as you mentioned earlier that
part is probably too resource-heavy here for Amiga.

I see two other problems with your patch though:

a) you still duplicate the cache handling: the cache_clear()/cache_push()
is supposed to already be done by dma_map_single() when the device
is not cache-coherent.

b) The bounce buffer is never mapped here, instead you have the
virt_to_phys() here, which is not the same. I think you need to map
the pointer that actually gets passed down to the device after deciding
to use a bouce buffer or not.

     Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
