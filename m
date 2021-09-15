Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F0C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 01:51:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D9461214
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 01:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97D9461214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 631D16077D;
	Wed, 15 Sep 2021 01:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UaDsxeP8TmYN; Wed, 15 Sep 2021 01:51:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 520EF60676;
	Wed, 15 Sep 2021 01:51:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1CDC0011;
	Wed, 15 Sep 2021 01:51:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12E20C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 01:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F078660778
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 01:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DbrBHQtYhJFB for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 01:51:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82E4160676
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 01:51:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDF8061211;
 Wed, 15 Sep 2021 01:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631670662;
 bh=z0W70Z4JOetSa7g8CfvjNwgRWC4qCwo9bmhv6sh9Bxs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=DhJ6GOb1z9RF8MoKZiSnxeXdJKNkyxJ7YyiEn0qQubMzT9FZtSjTJUt/KUr+QwVKI
 +frjDgFVeOdxWz9IZc7wervGNYWJ63gSfCERzcvLkSnA46r3ypahZL2U/4IHNXcntT
 /DqRf5MOYuMRlQ77Uv0SNMsaDJzboDdlLxIhocqe0R7UgiEK7ZBy99L8v0w5K3bX72
 sJ48QhBWhdiCuNKFPKWm/Qjfkv8EiwrcYFd4jtxEycZyiFEiLrwMg1PFndT/7dOiPM
 zl0gJLYf7yi4Oohaksg8j8XTXXQSSgFUXRaPI/wIqRfum+bBu2e2ldXr9TpWz6n+3M
 stAUSLvG5uH7w==
Date: Tue, 14 Sep 2021 18:51:01 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: rm.skakun@gmail.com
Subject: Re: [PATCH] swiotlb: set IO TLB segment size via cmdline
In-Reply-To: <20210914153046.GB815@lst.de>
Message-ID: <alpine.DEB.2.21.2109141838290.21985@sstabellini-ThinkPad-T480s>
References: <20210914151016.3174924-1-Roman_Skakun@epam.com>
 <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com> <20210914153046.GB815@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Roman Skakun <rm.skakun@gmail.com>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Jan Beulich <jbeulich@suse.com>, Will Deacon <will@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>, hch@lst.de,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrii Anisov <andrii_anisov@epam.com>, linuxppc-dev@lists.ozlabs.org,
 Randy Dunlap <rdunlap@infradead.org>, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Roman Skakun <roman_skakun@epam.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Mike Rapoport <rppt@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
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

On Tue, 14 Sep 2021, Christoph Hellwig wrote:
> On Tue, Sep 14, 2021 at 05:29:07PM +0200, Jan Beulich wrote:
> > I'm not convinced the swiotlb use describe there falls under "intended
> > use" - mapping a 1280x720 framebuffer in a single chunk? (As an aside,
> > the bottom of this page is also confusing, as following "Then we can
> > confirm the modified swiotlb size in the boot log:" there is a log
> > fragment showing the same original size of 64Mb.
> 
> It doesn't.  We also do not add hacks to the kernel for whacky out
> of tree modules.

Also, Option 1 listed in the webpage seems to be a lot better. Any
reason you can't do that? Because that option both solves the problem
and increases performance.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
