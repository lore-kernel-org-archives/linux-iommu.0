Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE23C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 16:40:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD52A6103C
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 16:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD52A6103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98A704071F;
	Thu, 23 Sep 2021 16:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-kWMvkYCZlR; Thu, 23 Sep 2021 16:40:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6FAD540718;
	Thu, 23 Sep 2021 16:40:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EA91C000F;
	Thu, 23 Sep 2021 16:40:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4E2DC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 16:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD4E04071B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 16:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6B_z29Q7Ue5m for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 16:40:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE59F40718
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 16:40:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="309449050"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="309449050"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 09:40:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="551214763"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 09:40:51 -0700
Date: Thu, 23 Sep 2021 09:40:50 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y27nfjel.ffs@tglx>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>
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

On Thu, Sep 23, 2021 at 04:36:50PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 20 2021 at 19:23, Fenghua Yu wrote:
> >  
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +void pasid_put(struct task_struct *tsk, struct mm_struct *mm);
> > +#else
> > +static inline void pasid_put(struct task_struct *tsk, struct mm_struct *mm) { }
> > +#endif
> 
> This code is again defining that PASID is entirely restricted to
> INTEL. It's true, that no other vendor supports this, but PASID is
> a non-vendor specific concept.
> 
> Sticking this into INTEL code means that any other PASID implementation
> has to rip it out again from INTEL code and make it a run time property.
> 
> The refcounting issue should be the same for all PASID mechanisms which
> attach PASID to a mm. What's INTEL specific about that?
> 
> So can we pretty please do that correct right away?

It's a bit messy (surprise).

There are two reasons to hold a refcount on a PASID

1) The process has done a bind on a device that uses PASIDs

	This one isn't dependent on Intel.

2) A task within a process is using ENQCMD (and thus holds
   a reference on the PASID because IA32_PASID MSR for this
   task has the PASID value loaded with the enable bit set).

	This is (currently) Intel specific (until others
	implement an ENQCMD-like feature to allow apps to
	access PASID enabled devices without going through
	the OS).

Perhaps some better function naming might help?  E.g. have
a task_pasid_put() function that handles the process exit
case separatley from the device unbind case.

void task_pasid_put(void)
{
	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
		return;

	if (current->has_valid_pasid) {
		mutex_lock(&pasid_mutex);
		iommu_sva_free_pasid(mm);
		mutex_unlock(&pasid_mutex);
	}
}

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
