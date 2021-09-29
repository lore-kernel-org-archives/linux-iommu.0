Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF86C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 09:55:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE97D613CD
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 09:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE97D613CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B7C182771;
	Wed, 29 Sep 2021 09:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7y2HK1lEDKVc; Wed, 29 Sep 2021 09:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 743D38272C;
	Wed, 29 Sep 2021 09:55:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29DD3C0011;
	Wed, 29 Sep 2021 09:55:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64C9CC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4759F414C0
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QhALc7EnwLdy for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 09:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF883407A8
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=F1ZLDmFr3JLFI67mtkM8Oy3hemi9FH59+C4PCq5sths=; b=Bx9A2ZQm8vmqJMBPFMuIDNxMyB
 eOMl3ZkUiyslKrodeaEND2oczaTUs42se3v0AbZZkabbDvqckedmQ8L+J85fqlOiVeJDs0kNvY8QX
 gg2Dctz7UPC7xqcjyILXT3RMCNHaEHiIN2f0o5WXO2+maOa4JxqX6/QfV9oQd5IFjPA/VQmgrQ8XH
 limRSmVdVjwo6nh13WHuGZiNbH5w/wDd8I8qFDngAe51PGGFtIL9bxvRB6P44/3dHKhR6YAYGai5x
 IeD9wuwyZU0xBLqt+QM/1wdr7TcAm+qJiKfZZF2z4MVWDyXCigfyAhr/vwQNxRiDByIV+uS7HDdsp
 I6DSRJHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVWHz-00BhuC-Sr; Wed, 29 Sep 2021 09:54:17 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD91C30023F;
 Wed, 29 Sep 2021 11:54:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id BAAE02DC92D07; Wed, 29 Sep 2021 11:54:09 +0200 (CEST)
Date: Wed, 29 Sep 2021 11:54:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx> <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>, the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Sep 24, 2021 at 04:03:53PM -0700, Andy Lutomirski wrote:
> I think the perfect and the good are a bit confused here. If we go for
> "good", then we have an mm owning a PASID for its entire lifetime.  If
> we want "perfect", then we should actually do it right: teach the
> kernel to update an entire mm's PASID setting all at once.  This isn't
> *that* hard -- it involves two things:
> 
> 1. The context switch code needs to resync PASID.  Unfortunately, this
> adds some overhead to every context switch, although a static_branch
> could minimize it for non-PASID users.

> 2. A change to an mm's PASID needs to sent an IPI, but that IPI can't
> touch FPU state.  So instead the IPI should use task_work_add() to
> make sure PASID gets resynced.

What do we need 1 for? Any PASID change can be achieved using 2 no?

Basically, call task_work_add() on all relevant tasks [1], then IPI
spray the current running of those and presto.

[1] it is nigh on impossible to find all tasks sharing an mm in any sane
way due to CLONE_MM && !CLONE_THREAD.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
