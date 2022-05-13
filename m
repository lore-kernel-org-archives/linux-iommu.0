Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926CCC433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 23:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1705540420;
	Fri, 13 May 2022 23:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7KLaYWUwte1Z; Fri, 13 May 2022 23:14:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E1E5F40235;
	Fri, 13 May 2022 23:14:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9CCAC0032;
	Fri, 13 May 2022 23:14:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 497B8C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2886283E96
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gzK9Kz4kAnq4 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 23:14:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA5A482849
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652483662; x=1684019662;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+wjfqOqIYe6TZTMHFU68r4+WktU+l0Y6oPd5aHItbaM=;
 b=LmpkmlaRZMlYWmEKReMaZJBxJrFOmFxq46JAXeiHl5prp6A/b/QwTFYA
 9V/GKuc9thnUCvH5FIrr6NeBgAycESwwebjv7FhYzhUzUudrrc1XHEorn
 YI/s7qwa0DYFA3IBsvGWou6q9xA0KqvP2Ba+GplOlsmAczdn883ISV28r
 +v1znY8NWWKwpp3zkT9zzEmO8KM3K+YR1CPWTh7S+3wLIVCigDru2oRF8
 pzdUh7vIKsvGa/SyG6d5mq4Sl3Jr2V+23BTkXQAhs2t+QX3t5OjB8cIup
 OriFbMALHjg0eTkHYtihi3ObpsGSm196Ys3HXuM3ZynA4ZAyrzAKXPGuF g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="333465800"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="333465800"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 16:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="815594245"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga006.fm.intel.com with ESMTP; 13 May 2022 16:14:19 -0700
Date: Fri, 13 May 2022 16:17:54 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 24/29] watchdog/hardlockup: Use parse_option_str() to
 handle "nmi_watchdog"
Message-ID: <20220513231754.GB9074@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-25-ricardo.neri-calderon@linux.intel.com>
 <1652179333.fnu2fjiffn.astroid@bobo.none>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1652179333.fnu2fjiffn.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Tue, May 10, 2022 at 08:46:41PM +1000, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> > Prepare hardlockup_panic_setup() to handle a comma-separated list of
> > options. Thus, it can continue parsing its own command-line options while
> > ignoring parameters that are relevant only to specific implementations of
> > the hardlockup detector. Such implementations may use an early_param to
> > parse their own options.
> 
> It can't really handle comma separated list though, until the next
> patch. nmi_watchdog=panic,0 does not make sense, so you lost error
> handling of that.

Yes that is true. All possible combinations need to be checked.

> 
> And is it kosher to double handle options like this? I'm sure it
> happens but it's ugly.
> 
> Would you consider just add a new option for x86 and avoid changing
> this? Less code and patches.

Sure, I can not modify this code and add a x86-specific command-line
option.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
