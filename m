Return-Path: <SRS0=Ze3H=LT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ECEC2B9F4
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 15:47:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C47B6194F
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C47B6194F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 557CE6070F;
	Fri, 25 Jun 2021 15:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YfIfB7dw_Kwb; Fri, 25 Jun 2021 15:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5294F60632;
	Fri, 25 Jun 2021 15:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36588C001A;
	Fri, 25 Jun 2021 15:47:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 052B7C000E
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 15:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D267583E04
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 15:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmr42WIZJvp9 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 15:47:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73ED283DFD
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 15:47:14 +0000 (UTC)
IronPort-SDR: 1zarBE0OZIEiC0R3rsSE2QNLM6pvkaKUozx4GxdR1ELtC9LSvHpUKy1ZJFoSgI1MOPwx/d92Bu
 89cZmoI4mk7w==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="194836431"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; d="scan'208";a="194836431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2021 08:46:43 -0700
IronPort-SDR: naYMx/2TuUTBUpSSAraBxCgF3wfQbSHEMQLlxRd9OQDOkMswUSaqNBbXUMJPpPzxc941VjHmG9
 quwb4ls5X/2A==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; d="scan'208";a="557733938"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2021 08:46:42 -0700
Date: Fri, 25 Jun 2021 08:46:41 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <20210625154641.GA1206684@agluck-desk2.amr.corp.intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLShmFEzddfm7WQs@zn.tnic>
 <87y2bv438p.ffs@nanos.tec.linutronix.de>
 <36866b38ec92425b879881a88acf547b@intel.com>
 <db552f51-76ee-b7f5-20f1-14f1c703d423@kernel.org>
 <7d8788a9e04d4901a03bcea11e8e842b@intel.com>
 <bd5bb38c-0b81-a302-dd20-ef56fd970c9e@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd5bb38c-0b81-a302-dd20-ef56fd970c9e@kernel.org>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, "Hansen, Dave" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Jun 09, 2021 at 04:34:31PM -0700, Andy Lutomirski wrote:
> On 6/9/21 10:32 AM, Luck, Tony wrote:
> >>> I've told Fenghua to dig out the previous iteration of this patch where
> >>> the plan was to lazily fix the PASID_MSR in other threads in the #GP
> >>> handler.
> >>
> >> Blech.  Also this won't work for other PASID-like features.
> >>
> >> I have a half-written patch to fix this up for real.  Stay tuned.
> > 
> > Andy: Any update on this?
> > 
> > -Tony
> > 
> 
> Let me try to merge my pile with tglx's pile and come up with something
> halfway sane.

Looks like Thomas' pile is done (well done enough to be queued in TIP).

Can we see your "pile" soon?

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
