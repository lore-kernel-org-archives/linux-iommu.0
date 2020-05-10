Return-Path: <SRS0=ml75=6Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD3C54E8D
	for <iommu@archiver.kernel.org>; Sun, 10 May 2020 22:25:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81DF20720
	for <iommu@archiver.kernel.org>; Sun, 10 May 2020 22:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81DF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7B49186366;
	Sun, 10 May 2020 22:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OiUXhznTfAsY; Sun, 10 May 2020 22:25:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 279C8863AC;
	Sun, 10 May 2020 22:25:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B028C0178;
	Sun, 10 May 2020 22:25:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 919A9C016F
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 22:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 79A5387969
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 22:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4NTTjDrZGMV for <iommu@lists.linux-foundation.org>;
 Sun, 10 May 2020 22:25:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E2FE3878C0
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 22:25:45 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id DA7F12C8; Mon, 11 May 2020 00:25:42 +0200 (CEST)
Date: Mon, 11 May 2020 00:25:41 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc4
Message-ID: <20200510222540.GF18353@8bytes.org>
References: <20200510122634.GA32616@8bytes.org>
 <CAHk-=wht3yDtJ6zka=DNaB8Nymh-zmUMZhGaC8yFz29nuW-EsA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wht3yDtJ6zka=DNaB8Nymh-zmUMZhGaC8yFz29nuW-EsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, May 10, 2020 at 11:34:49AM -0700, Linus Torvalds wrote:
> On Sun, May 10, 2020 at 5:26 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> >            The first race condition was around
> >           the non-atomic update of the domain page-table root pointer
> >           and the variable containing the page-table depth (called
> >           mode). This is fixed now be merging page-table root and mode
> >           into one 64-bit field which is read/written atomically.
> 
> This seems a bit odd.
> 
> The pointer part is always page-aligned, and the "mode" is just three bits.
> 
> Why isn't it just encoded as one pointer with the low three bits being the mode?
> 
> The thing is, the 64-bit atomic reads/writes are very expensive on
> 32-bit x86. If it was just a native pointer, it would be much cheaper
> than an "atomic64_t".

Yeah, when I think about it again, you are right. I think I used
atomic64_t just to be on the safe side with memory odering and all. But
in this case it doesn't really matter when a reader observes the
update, it is only important that the reader does not observe one field
updated while the other is not. And that should already be fullfilled
with 64-bit writes on x86-64, like a native pointer write.

I'll send a patch to Qian to test this, just to be sure I am not missing
anything.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
