Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB89AC433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 18:37:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F89C217BA
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 18:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F89C217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D435D87168;
	Mon, 14 Sep 2020 18:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJHtmedOsDEJ; Mon, 14 Sep 2020 18:37:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 182478711E;
	Mon, 14 Sep 2020 18:37:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA614C0859;
	Mon, 14 Sep 2020 18:37:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E8ACC0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 18:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 65CF62001E
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 18:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id woHihl1IMGu8 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 18:37:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by silver.osuosl.org (Postfix) with ESMTPS id 158962000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 18:37:17 +0000 (UTC)
IronPort-SDR: atnwvRj/SAISJL1SLEqueyavqMOHep20g+RHfJwhy+b0gIcyzA6aH9YuBaE5NyC9rUeUWcD71k
 M1rvy49RC/5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="138648356"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; d="scan'208";a="138648356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 11:37:15 -0700
IronPort-SDR: e/dhGeM/ItpH4ZIYXtuXHtLqGxZdXvqTHP2RqlUNODU6NosrOaLvBXuJBici5oxhBNwzyjQiMa
 +dFWGGZNtLzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; d="scan'208";a="330852067"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
 by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2020 11:37:15 -0700
Date: Mon, 14 Sep 2020 18:37:15 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 9/9] x86/mmu: Allocate/free PASID
Message-ID: <20200914183715.GA437309@otcwcpicx6.sc.intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
 <20200907111843.GC16029@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200907111843.GC16029@zn.tnic>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
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

Hi, Boris,

On Mon, Sep 07, 2020 at 01:18:43PM +0200, Borislav Petkov wrote:
> On Thu, Aug 27, 2020 at 08:06:34AM -0700, Fenghua Yu wrote:
> > +		 */
> > +		xsave = &fpu->state.xsave;
> > +		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
> > +		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
> > +		if (ppasid_state) {
> > +			/*
> > +			 * Only update the task's PASID state when it's
> > +			 * different from the mm's pasid.
> > +			 */
> > +			if (ppasid_state->pasid != pasid_state) {
> > +				/*
> > +				 * Invalid fpregs so that xrstors will pick up
> 							  ^^^^^^^
> 
> Not "xrstors" but the "state restoring" or so.

Fixed.

> > +				 * the PASID state.
> > +				 */
> > +				__fpu_invalidate_fpregs_state(fpu);
> > +				ppasid_state->pasid = pasid_state;
> > +			}
> 
> What happens if get_xsave_addr() returns NULL? A WARN_ONCE maybe?

get_xsave_addr() will not return NULL because xsave->header.xfeatures has
XFEATURE_MASK_PASID set. I will remove the unnecessary check "if (ppasid_state)"
to optimize the function and add a comment on why the check is unnecessary.

> Ok, done with review.

I addressed all of your comments and will send out the updated series soon.

Thank you very much for your review!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
