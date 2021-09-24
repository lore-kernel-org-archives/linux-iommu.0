Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD0C433FE
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 00:57:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDF061214
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 00:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FDF061214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55AD260687;
	Fri, 24 Sep 2021 00:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AUbR9MbiMBak; Fri, 24 Sep 2021 00:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C9986064B;
	Fri, 24 Sep 2021 00:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1405EC000F;
	Fri, 24 Sep 2021 00:57:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91A4FC000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 00:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D54960687
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 00:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eQ8Of42J94uW for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 00:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3BE06064B
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 00:57:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211051501"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; d="scan'208";a="211051501"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 17:57:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; d="scan'208";a="514332940"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 17:57:46 -0700
Date: Fri, 24 Sep 2021 00:57:40 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <YU0ihC6EYBZCSylV@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
 <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
 <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
 <YUycliX+lPSMhWfR@otcwcpicx3.sc.intel.com>
 <20210924005540.kunsfif7hdta6dlp@treble>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924005540.kunsfif7hdta6dlp@treble>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
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

Hi, Josh,

On Thu, Sep 23, 2021 at 05:55:40PM -0700, Josh Poimboeuf wrote:
> On Thu, Sep 23, 2021 at 03:26:14PM +0000, Fenghua Yu wrote:
> > > > +		} else if (op2 == 0x38 && op3 == 0xf8) {
> > > > +			if (insn.prefixes.nbytes == 1 &&
> > > > +			    insn.prefixes.bytes[0] == 0xf2) {
> > > > +				/* ENQCMD cannot be used in the kernel. */
> > > > +				WARN("ENQCMD instruction at %s:%lx", sec->name,
> > > > +				     offset);
> > > > +
> > > > +				return -1;
> > > > +			}
> > > 
> > > The only concern here is if we want it to be fatal or not. But otherwise
> > > this seems to be all that's required.
> > 
> > objtool doesn't fail kernel build on this fatal warning.
> > 
> > Returning -1 here stops checking the rest of the file and won't report any
> > further warnings unless this ENQCMD warning is fixed. Not returning -1
> > continues checking the rest of the file and may report more warnings.
> > Seems that's the only difference b/w them.
> > 
> > Should I keep this "return -1" or not? Please advice.
> 
> I'd say remove the "return -1" since it's not a fatal-type analysis
> error and there's nothing to prevent objtool from analyzing the rest of
> the file.

Sure. It does make sense to remove "return -1". I will remove it.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
