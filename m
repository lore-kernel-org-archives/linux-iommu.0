Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F590C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 11:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8C1540A1E;
	Tue, 28 Jun 2022 11:31:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8C1540A1E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S9ev2a8N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zqR_CMhOR-X9; Tue, 28 Jun 2022 11:31:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EFFD5400BF;
	Tue, 28 Jun 2022 11:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFFD5400BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2917C0032;
	Tue, 28 Jun 2022 11:31:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9C1AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A58E181CFE
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:31:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A58E181CFE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=S9ev2a8N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O8n9eQidGUIg for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 11:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10BC0817ED
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10BC0817ED
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:31:49 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4201661AB0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC4CC341D3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656415908;
 bh=mGQ17FxEruXP1Se/YhPh1NXTTafvPHopAQxVYAQOAng=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=S9ev2a8N8YQmk0FkOdWFCB7fzksaF3TDIqbfcHvGcwSqAPQBjVarw4vw9M3l6HHmL
 ssCxgmsI8FHt9fG0XtnHdMUgr0QiYRCSQ79IVVpF+/C1G6eLSjq//dde0lc2VRCRaS
 1FOEBaNxnclo7b2FYkWs82psE+DIlzk94a+i0CS0kc4yOVpaZiit6FGLCMgT4MtfTp
 CwGZaSPgvhkEFi/ozVYkEbtrBOACwSSrasTZCqcPAk1+8mx2bwdjGw8Jo6F9FVGxwT
 aWToqKSq2ntJ+svOn8tdm9iL+aJ6hyyGwGM/YXBZrhOMDyTMuQVPNXGFsy/i9skP/1
 Bv9FMX2w5oSmA==
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-31bf3656517so22825477b3.12
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 04:31:48 -0700 (PDT)
X-Gm-Message-State: AJIora8Bv8uHdvrRx65+hdCdKMwPryakztS7Yz5/B+akUdhjNISqBK3Q
 7TlnnVRoBJ0NrNrt6ew+RBmIDv7bzONP8Pg8NwE=
X-Google-Smtp-Source: AGRyM1u6alRW6DNpLAw2CjiZONF/08UESoBCXDxfJxZHbJGIZ8WIqxSBVa0RkxHHh4KQrTbwBfw484vqcSO7R67ID6s=
X-Received: by 2002:a81:230c:0:b0:31b:f368:d0b0 with SMTP id
 j12-20020a81230c000000b0031bf368d0b0mr4904055ywj.249.1656415907046; Tue, 28
 Jun 2022 04:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220624155226.2889613-1-arnd@kernel.org>
 <yq1bkudh4va.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1bkudh4va.fsf@ca-mkp.ca.oracle.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 28 Jun 2022 13:31:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-D_Ct1jBpKzv7OPZ3Mfkx4iD1QG8ELuib02aGXUAS6A@mail.gmail.com>
Message-ID: <CAK8P3a3-D_Ct1jBpKzv7OPZ3Mfkx4iD1QG8ELuib02aGXUAS6A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] phase out CONFIG_VIRT_TO_BUS
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Matt Wang <wwentao@vmware.com>, Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, Jun 28, 2022 at 4:59 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> Hi Arnd!
>
> > If there are no more issues identified with this series, I'll merge it
> > through the asm-generic tree. The SCSI patches can also get merged
> > separately through the SCSI maintainers' tree if they prefer.
>
> I put patches 1 and 2 in scsi-staging to see if anything breaks...

Ok, thanks!

I have just the third patch in the asm-generic tree now. As long as it all
make it into the merge window, this should work out fine without build
issues, though there is a small bisection window during which the buslogic
driver becomes hidden. I think that's ok here.

       Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
