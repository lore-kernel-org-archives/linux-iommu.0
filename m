Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641EDC433FE
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 00:44:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A58615E0
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 00:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5A58615E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CAC742529;
	Thu, 30 Sep 2021 00:44:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNcvK8lDEhlT; Thu, 30 Sep 2021 00:44:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 87D2D4253B;
	Thu, 30 Sep 2021 00:44:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC2FC000F;
	Thu, 30 Sep 2021 00:44:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 104F6C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 00:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDCE5607C1
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 00:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EuUZLUA2pEUq for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 00:44:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4214C60794
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 00:44:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="221867570"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; d="scan'208";a="221867570"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 17:44:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; d="scan'208";a="479585082"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 17:44:01 -0700
Date: Thu, 30 Sep 2021 00:44:00 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVUIUIQcMxydYLQ9@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <3156573d-0d25-db0f-57ae-b6406763a8e9@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3156573d-0d25-db0f-57ae-b6406763a8e9@linux.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

Hi, Baolu,

On Thu, Sep 23, 2021 at 01:43:32PM +0800, Lu Baolu wrote:
> On 9/21/21 3:23 AM, Fenghua Yu wrote:
> > +void pasid_put(struct task_struct *tsk, struct mm_struct *mm)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> > +		return;
> > +
> > +	/*
> > +	 * Nothing to do if this task doesn't have a reference to the PASID.
> > +	 */
> > +	if (tsk->has_valid_pasid) {
> > +		mutex_lock(&pasid_mutex);
> > +		/*
> > +		 * The PASID's reference was taken during fix up. Release it
> > +		 * now. If the reference count is 0, the PASID is freed.
> > +		 */
> > +		iommu_sva_free_pasid(mm);
> > +		mutex_unlock(&pasid_mutex);
> > +	}
> > +}
> > 
> 
> It looks odd that both __fixup_pasid_exception() and pasid_put() are
> defined in the vendor IOMMU driver, but get called in the arch/x86
> code.
> 
> Is it feasible to move these two helpers to the files where they are
> called? The IA32_PASID MSR fixup and release are not part of the IOMMU
> implementation.

Sure. The functions will be removed in the next version. And new functions
will not be called in IOMMU driver.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
