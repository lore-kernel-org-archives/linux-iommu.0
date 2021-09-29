Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF4DC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 17:08:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4304B6142A
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 17:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4304B6142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C8484029A;
	Wed, 29 Sep 2021 17:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtvIXHVhgp9p; Wed, 29 Sep 2021 17:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39C284028C;
	Wed, 29 Sep 2021 17:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CAC5C0011;
	Wed, 29 Sep 2021 17:08:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6046AC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C0E282897
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ywtVxkimhyu3 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 17:08:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B7B580D0A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:08:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="247522720"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="247522720"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 10:07:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="538924770"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 10:07:55 -0700
Date: Wed, 29 Sep 2021 10:07:54 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVSdauvwzs1HJlLz@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
 <308a72e4-6aa9-0c84-21e6-ee613eea35a8@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <308a72e4-6aa9-0c84-21e6-ee613eea35a8@kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
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

On Wed, Sep 29, 2021 at 09:58:22AM -0700, Andy Lutomirski wrote:
> On 9/28/21 16:10, Luck, Tony wrote:
> > Moving beyond pseudo-code and into compiles-but-probably-broken-code.
> > 
> > 
> > The intent of the functions below is that Fenghua should be able to
> > do:
> > 
> > void fpu__pasid_write(u32 pasid)
> > {
> > 	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> > 	struct ia32_pasid_state *addr;
> > 
> > 	addr = begin_update_one_xsave_feature(current, XFEATURE_PASID, true);
> > 	addr->pasid = msr_val;
> > 	finish_update_one_xsave_feature(current);
> > }
> > 
> 
> This gets gnarly because we would presumably like to optimize the case where
> we can do the update directly in registers.  I wonder if we can do it with a
> bit of macro magic in a somewhat generic way:

Can we defere the optimizations until there is a use case that
cares? The existing use case (fixing up the #GP fault by setting
the PASID MSR) isn't performance critical.

Let's just have something that is clear (or as clear as any xsave
code can be) and correct.

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
