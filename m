Return-Path: <SRS0=j10w=PY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A9C433EF
	for <iommu@archiver.kernel.org>; Fri,  5 Nov 2021 07:35:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A78A61262
	for <iommu@archiver.kernel.org>; Fri,  5 Nov 2021 07:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A78A61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0DE1400D3;
	Fri,  5 Nov 2021 07:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OpzGZKC0nOvn; Fri,  5 Nov 2021 07:35:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91A82400FA;
	Fri,  5 Nov 2021 07:35:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69D78C0012;
	Fri,  5 Nov 2021 07:35:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58EA3C000E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 07:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4198781B35
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 07:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XklvM3Zponcx for <iommu@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 07:35:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BD1F81B26
 for <iommu@lists.linux-foundation.org>; Fri,  5 Nov 2021 07:35:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1A09A3FF; Fri,  5 Nov 2021 08:35:47 +0100 (CET)
Date: Fri, 5 Nov 2021 08:35:40 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] IOMMU Updates for Linux v5.16
Message-ID: <YYTezKfKDCTiDcij@8bytes.org>
References: <YYPrNkweZahTdAbA@8bytes.org>
 <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
Cc: iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
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

On Thu, Nov 04, 2021 at 11:10:53AM -0700, Linus Torvalds wrote:
> That too seems to be stale and unused since commit 9bfecd058339
> ("x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove
> update_pasid()")
> 
> I left it alone because I didn't want to do any extra development in
> the merge commit itself, but it looks to me like there's some room for
> more cleanips. No?

Yes, looks like this define is unused now. I talk to Baolu whether this
can be cleaned up too, Baolu?

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
