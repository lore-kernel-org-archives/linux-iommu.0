Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE894C433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 18:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5DD15400E7;
	Tue, 17 May 2022 18:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xgf25f7GOKik; Tue, 17 May 2022 18:38:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35EC5405E2;
	Tue, 17 May 2022 18:38:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E69E5C0039;
	Tue, 17 May 2022 18:38:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 602FBC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 18:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54ED341A21
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 18:38:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Maa4xrTFRa03 for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:38:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 665F941A1B
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 18:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652812693; x=1684348693;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FTTY9ZFMfeTd8CI19p2u5YEYLQvqFSdIkPKeSEcRj4U=;
 b=YUuJ/uUKTbiDNFd4y++5VrAtg9TpHLmaQenw1VguwtX41VOsbhYcMRF/
 +WV0jZz/ovTh+WHJfS7eQRHhBgYjW+E8ObYQgDD0n7CfZOzOp8KeKP4Fe
 VYbasYy4TvlRO7GunlbYTbiEkFfGWN9jqVa275WZBao3zWJUM6JdUEeGS
 wwNSrmswYoqYhBDSfdikZlBQtDBiz6ZTjH6SyfPxWhCU/dvRPiBJeUOYZ
 QGskWD3gpuE6SjUsaml91/F7Ork3NINy/Q9NA4CSxLKovZaGw83ziWULl
 8bN9fKRiUZPr3iWIzLVMvNFZs4sWOAi/nUmcbAcNKejAp2N0+8d/tYKlM Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270974385"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; d="scan'208";a="270974385"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2022 11:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; d="scan'208";a="555910452"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga002.jf.intel.com with ESMTP; 17 May 2022 11:38:12 -0700
Date: Tue, 17 May 2022 11:41:54 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 21/29] x86/nmi: Add an NMI_WATCHDOG NMI handler category
Message-ID: <20220517184154.GA6711@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-22-ricardo.neri-calderon@linux.intel.com>
 <87a6bqrelv.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6bqrelv.ffs@tglx>
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

On Mon, May 09, 2022 at 03:59:40PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 17:00, Ricardo Neri wrote:
> > Add a NMI_WATCHDOG as a new category of NMI handler. This new category
> > is to be used with the HPET-based hardlockup detector. This detector
> > does not have a direct way of checking if the HPET timer is the source of
> > the NMI. Instead, it indirectly estimates it using the time-stamp counter.
> >
> > Therefore, we may have false-positives in case another NMI occurs within
> > the estimated time window. For this reason, we want the handler of the
> > detector to be called after all the NMI_LOCAL handlers. A simple way
> > of achieving this with a new NMI handler category.
> >
> > @@ -379,6 +385,10 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
> >  	}
> >  	raw_spin_unlock(&nmi_reason_lock);
> >  
> > +	handled = nmi_handle(NMI_WATCHDOG, regs);
> > +	if (handled == NMI_HANDLED)
> > +		goto out;
> > +
> 
> How is this supposed to work reliably?
> 
> If perf is active and the HPET NMI and the perf NMI come in around the
> same time, then nmi_handle(LOCAL) can swallow the NMI and the watchdog
> won't be checked. Because MSI is strictly edge and the message is only
> sent once, this can result in a stale watchdog, no?

This is true. Instead, at the end of each NMI I should _also_ check if the TSC
is within the expected value of the HPET NMI watchdog. In this way, unrelated
NMIs (e.g., perf NMI) are handled and we don't miss the NMI from the HPET
channel.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
