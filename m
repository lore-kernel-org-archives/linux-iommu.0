Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029C7C3F2D4
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 15:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9498C404C4;
	Fri, 24 Jun 2022 15:43:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9498C404C4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i9DTlTGA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jvu_GJ8D2qS4; Fri, 24 Jun 2022 15:43:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A8D940377;
	Fri, 24 Jun 2022 15:43:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A8D940377
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D1DCC0032;
	Fri, 24 Jun 2022 15:43:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71084C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 15:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4484F8485F
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 15:43:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4484F8485F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=i9DTlTGA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZIa2c5nbsRBX for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 15:43:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 960DC84856
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 960DC84856
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 15:43:42 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0A6CE62222
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 15:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6CBC341CD
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656085420;
 bh=ZrmSkwlqS2brnFN5Iry4JvejPq5gajOP5sg4Z4I3Hws=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=i9DTlTGAF2BSmIOGQb/gQyl7aMHalsUj8NoMTbK5Fd4cCyIuwAgENb43b1h9IH48h
 qp06qkk0zTx1HwRItvR0GItuPv+lz/7ChUX2E9qCxtTjXMu4b192guwea5c4SjI521
 4+UtTh2cv+kB26alAMsm83DdMDj5HP1Dh3uN2MA4aDR81torLsE+iHB1xV9EKT5lIO
 YEBYFhN226Zo4lYaEZEdr9mkWZhgmYyh//FjHYkPt20RneGhxwqQqJoNaBsRywsipP
 0iHfl24ek2rhJLBp6JuP3w86bddR2dx3a1MCX9Er4aQzEcWmIImB57bGTJCYzWnVbz
 3KOVO6Rr8xY7w==
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-317a66d62dfso28585937b3.7
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 08:43:40 -0700 (PDT)
X-Gm-Message-State: AJIora8s2Se3ky9CJ4KzP+ulNGRGHEOW4OshF9EyevRQgBF3FDLkGIfj
 LmJod9Wymx6I51lKYjcx+X5JNLH5rZHP3pgnOns=
X-Google-Smtp-Source: AGRyM1tAwe56Z5fVE7/SpL81F9wGW1RUV71QXwxRBZMigOoQ0lhjNRQtgXoHzM5M7/mN527O+TQVqWtjCC96MjmmS9c=
X-Received: by 2002:a81:2f84:0:b0:314:2bfd:bf1f with SMTP id
 v126-20020a812f84000000b003142bfdbf1fmr17066465ywv.320.1656085419237; Fri, 24
 Jun 2022 08:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-3-arnd@kernel.org>
 <7a6df2da-95e8-b2fd-7565-e4b7a51c5b63@gonehiking.org>
 <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
 <c955bf95-838f-cc0a-8496-322b831e5648@gonehiking.org>
In-Reply-To: <c955bf95-838f-cc0a-8496-322b831e5648@gonehiking.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 24 Jun 2022 17:43:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0onDqNtteOjGu7R8vUvy_ycYSYnxJURCcoyxtZDcji=g@mail.gmail.com>
Message-ID: <CAK8P3a0onDqNtteOjGu7R8vUvy_ycYSYnxJURCcoyxtZDcji=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scsi: BusLogic remove bus_to_virt
To: Khalid Aziz <khalid@gonehiking.org>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Matt Wang <wwentao@vmware.com>, Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>, Robin Murphy <robin.murphy@arm.com>
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

On Fri, Jun 24, 2022 at 5:38 PM Khalid Aziz <khalid@gonehiking.org> wrote:
> On 6/23/22 08:47, Arnd Bergmann wrote:
>
> Driver works with this change. next_inbox is the correct pointer to pass.

Ok, great! I'll add a 'Tested-by' line then. I was already in the process of
preparing a v3 patch set, will send out the fixed patch in a bit.

         Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
