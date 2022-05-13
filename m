Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C09C433FE
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 18:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 199AF83F5C;
	Fri, 13 May 2022 18:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4t-XOOig9VAJ; Fri, 13 May 2022 18:59:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 182EA83F48;
	Fri, 13 May 2022 18:59:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E62F9C0039;
	Fri, 13 May 2022 18:59:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8768C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88CA683F5B
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Roo_OVGBZRsA for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 18:59:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 039FD83F48
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652468386; x=1684004386;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8jZEDO0wap/S70A6rQv+pSQuvwOwjW4+QKi9OH+Emho=;
 b=ac9aM8Zg47tLGpyOKiO4nKCAPmUBl/OaXqPnFiBRXvwdcQ8enguuriDO
 uuHH36M4a56KCWsKfahfrqEiQRmRQCeSXJpb64gn4Cxq5pOEtWmTeTnPp
 NPHDiFtA0S7dAP/NxTznjbPtQa0Q6sa44FSaadCGRq1dLgYim5qLNJCSJ
 hEDxzgTkki9ucfQvvp3cQf45oZQnXQfkV0JUKjV6ZJvv+10c0IhsM8XeE
 T14SdoT5t8oivBkQZ3QTuwiKZ8lGk1Y2fWYwd9e8v+uyUPOvtzxaj4gcK
 f2KkWW176VFPKBWDFRRng9/IdwwQGQiwofqzjigFHBTqgcZLZl3PsGWRA g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250914349"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="250914349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 11:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="698603603"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga004.jf.intel.com with ESMTP; 13 May 2022 11:59:44 -0700
Date: Fri, 13 May 2022 12:03:19 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 13/29] iommu/amd: Compose MSI messages for NMI irqs in
 non-IR format
Message-ID: <20220513190319.GD22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
 <87r156fiur.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r156fiur.ffs@tglx>
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

On Fri, May 06, 2022 at 11:31:56PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > +	 *
> > +	 * Also, NMIs do not have an associated vector. No need for cleanup.
> 
> They have a vector and what the heck is this cleanup comment for here?
> There is nothing cleanup alike anywhere near.
> 
> Adding confusing comments is worse than adding no comments at all.

I will remove the comment regarding cleanup. I will clarify that NMI has a
fixed vector.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
