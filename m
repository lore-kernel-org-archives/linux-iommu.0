Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF88C433F5
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EE261242
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06EE261242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF7E140650;
	Fri, 24 Sep 2021 15:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jb7226Khf0m; Fri, 24 Sep 2021 15:39:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8108940502;
	Fri, 24 Sep 2021 15:39:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67EB4C000F;
	Fri, 24 Sep 2021 15:39:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83877C000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 15:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6557E60760
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 15:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPK_y-l0qAyP for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 15:39:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 919B76074A
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 15:39:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="287766990"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; d="scan'208";a="287766990"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2021 08:39:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; d="scan'208";a="551854501"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2021 08:39:28 -0700
Date: Fri, 24 Sep 2021 08:39:24 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YU3xLNJsSjIEpocT@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <YUy2AmabA4ODOgAC@agluck-desk2.amr.corp.intel.com>
 <YU3UkvNdzCqAANSY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YU3UkvNdzCqAANSY@hirez.programming.kicks-ass.net>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Fri, Sep 24, 2021 at 03:37:22PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 23, 2021 at 10:14:42AM -0700, Luck, Tony wrote:
> > On Wed, Sep 22, 2021 at 11:07:22PM +0200, Peter Zijlstra wrote:
> > > On Mon, Sep 20, 2021 at 07:23:45PM +0000, Fenghua Yu wrote:
> > > > @@ -538,6 +547,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> > > >  
> > > >  	cond_local_irq_enable(regs);
> > > >  
> > > > +	if (user_mode(regs) && fixup_pasid_exception())
> > > > +		goto exit;
> > > > +
> > 
> > > So you're eating any random #GP that might or might not be PASID
> > > related. And all that witout a comment... Enlighten?
> > 
> > This is moderately well commented inside the fixup_pasid_exception()
> > function. Another copy of the comments here at the call-site seems
> > overkill.
> 
> +static bool fixup_pasid_exception(void)
> +{
> +       if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +               return false;
> +
> +       return __fixup_pasid_exception();
> +}
> 
> /me goes looking for comments in that function, lemme get out the
> electron microscope, because I can't seem to spot them with the naked
> eye.

If you have ctags installed then a ctrl-] on that
__fixup_pasid_exception() will take you to the function with
the comments. No electron microscope needed.

+
+/*
+ * Try to figure out if there is a PASID MSR value to propagate to the
+ * thread taking the #GP.
+ */
+bool __fixup_pasid_exception(void)
+{
+       u32 pasid;
+
+       /*
+        * This function is called only when this #GP was triggered from user
+        * space. So the mm cannot be NULL.
+        */
+       pasid = current->mm->pasid;
+
+       /* If no PASID is allocated, there is nothing to propagate. */
+       if (pasid == PASID_DISABLED)
+               return false;
+
+       /*
+        * If the current task already has a valid PASID MSR, then the #GP
+        * fault must be for some non-ENQCMD related reason.
+        */
+       if (current->has_valid_pasid)
+               return false;
+
+       /* Fix up the MSR by the PASID in the mm. */
+       fpu__pasid_write(pasid);
+       current->has_valid_pasid = 1;
+
+       return true;
+}

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
