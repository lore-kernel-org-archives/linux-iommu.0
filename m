Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3257AC433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 22:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2788830FB;
	Tue, 17 May 2022 22:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5OdRtatmcg7H; Tue, 17 May 2022 22:51:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AFF1A83004;
	Tue, 17 May 2022 22:51:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90B14C0039;
	Tue, 17 May 2022 22:51:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD50C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E26B6111F
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mX1UX2TisfI3 for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 22:51:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F68D6110E
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652827863; x=1684363863;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Zzsg2WuJh6uzhJovq8XCrnmcAqakpF47E+0Mjk8izlQ=;
 b=MUd+a8j2oJK49tECsVGys2NxjSAiyzZJHP59Et0v3pNSiOLQjCUUuUo5
 +w0MtIwVTOR7E53pNxXqRvBT/XRixEdCTL08W0SB3U4Tw3RqC3H8VzxnX
 44pU5iwvUIsjbsoXs/c0jGJ4rBESc3l9wlPH3vW5Ebk7gWuBVwHJdMVPe
 z+bLt62TyVKuaIoSvp07dMP6jC2xAsXRAVPtABgQGWUVZjlOJQpqvekms
 SXTNsyK9c9FQJmFnIPYQLwMYTcQq2K9rtls9qoVa84ZmsALT90KUUYVuh
 XOXRzOA3A10lAGSQM6gMArk55ODNOvuLq0d2qPGiFtKbfShGddvxvkaum w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251879808"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; d="scan'208";a="251879808"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2022 15:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; d="scan'208";a="660835593"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 15:51:00 -0700
Date: Tue, 17 May 2022 15:54:43 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
Message-ID: <20220517225443.GA8069@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx>
 <20220513211944.GE22683@ranerica-svr.sc.intel.com>
 <87pmkgsf31.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pmkgsf31.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Sat, May 14, 2022 at 10:17:38AM +0200, Thomas Gleixner wrote:
> On Fri, May 13 2022 at 14:19, Ricardo Neri wrote:
> > On Fri, May 06, 2022 at 11:41:13PM +0200, Thomas Gleixner wrote:
> >> The argument about not bloating the code
> >> with an "obvious???" function which is quite small is slightly beyond my
> >> comprehension level.
> >
> > That obvious function would look like this:
> >
> > void hpet_set_comparator_one_shot(int channel, u32 delta)
> > {
> > 	u32 count;
> >
> > 	count = hpet_readl(HPET_COUNTER);
> > 	count += delta;
> > 	hpet_writel(count, HPET_Tn_CMP(channel));
> > }
> 
> This function only works reliably when the delta is large. See
> hpet_clkevt_set_next_event().

That is a good point. One more reason to not have a
hpet_set_comparator_one_shot(), IMO.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
