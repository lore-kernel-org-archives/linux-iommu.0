Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB3C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 23:22:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE2C6023B
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 23:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BE2C6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF3C8414B9;
	Thu, 23 Sep 2021 23:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MbZv1yDHfoRv; Thu, 23 Sep 2021 23:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCB54407C5;
	Thu, 23 Sep 2021 23:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD7D6C0011;
	Thu, 23 Sep 2021 23:22:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B70CC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04FBF40134
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9HBCYC1bKQSN for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 23:22:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55FF040004
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 23:22:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="246425420"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; d="scan'208";a="246425420"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 16:22:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; d="scan'208";a="514303216"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 16:22:37 -0700
Date: Thu, 23 Sep 2021 16:22:35 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YU0MO/WJO4rkcl0c@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <d5f00e34-f9fc-4421-8571-48c45237141c@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5f00e34-f9fc-4421-8571-48c45237141c@www.fastmail.com>
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

On Thu, Sep 23, 2021 at 04:09:18PM -0700, Andy Lutomirski wrote:
> On Mon, Sep 20, 2021, at 12:23 PM, Fenghua Yu wrote:

> I think this is unnecessarily complicated because it's buying in to the
> existing ISA misconception that PASID has anything to do with a task.
> A PASID belongs to an mm, full stop.  Now the ISA is nasty and we have
> tasks that have *noticed* that their mm has a PASID and tasks that have
> not noticed this fact, but that should be irrelevant to essentially
> everything except the fault handler.
> 
> So just refcount the thing the obvious way: take a reference when you
> stick the PASID in the mm_struct and drop the reference in __mmdrop().
> Problem solved.  You could probably drop it more aggressively in
> __mmput(), and the comment explaining why is left as an exercise to the
> reader -- if a kernel thread starts doing ENQCMD, we have worse things
> to worry about :)

That doesn't match well with the non-x86 usage of PASIDs. The code there
bumps the reference count on each device bind, and decrements on each
device unbind.

If we don't keep a reference count for each task that has IA32_PASID
set up we could have this sequence

1) Process binds to a PASID capable device
2) Task uses ENQCMD, so PASID MSR is set up.
3) Process unbinds the device, reference count on PASID
   goes to zero. PASID is freed. PASID is reallocated to
   another task.
4) Task from step #2 uses ENQCMD to submit a descriptor
   and device now processes virtual addresses based on mappings
   in the new task.

Now you might say that at step 3 we need to hunt down all the
tasks that have PASID enabled and disabled ... but that's the
same painful code that we avoided when we said that we would
not make Linux hand out a PASID to all existing tasks in a
process on the first bind operation.

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
