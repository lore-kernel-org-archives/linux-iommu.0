Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8383C433F5
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 17:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B46940236;
	Thu, 10 Feb 2022 17:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1HSEjjetech9; Thu, 10 Feb 2022 17:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1183F40184;
	Thu, 10 Feb 2022 17:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E690BC001A;
	Thu, 10 Feb 2022 17:25:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD4AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 17:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5114C8195D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 17:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jTKiZ5qOkXTY for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 17:24:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 149CD81826
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644513899; x=1676049899;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eagqL1AoUzAckRlZtQNOqTR4fbpXscTSKvxL87Obws8=;
 b=Q7r7t3B417exOqr23xVhGKQX5D3C4p3GYJFCmF7kD3hToH46Klkzyvpy
 5fZ3DDWfQ8inCzo7GZxjGIaYFwdceCMlDUujA8+rhDoK10yAdppgOknC5
 DD0swVVkX1VpSK9S6ClB5TFN2FFkcEvkeQTPGvT3Umd0ip/DQGrWbQjaL
 19RKoSfA5LXsVuV/EKnClp3FMi3NqQjNiKlMx40era4A82VhXQ3HH+uRL
 sEmKxTdDXzGLLBvBJMrXZZbgglufRAAMZzhGu0DrGJa/8Kw/9Ewd82K8h
 MJzI8zjPGC7X5PMJU7F/HhbIL9tMp/6h5kHH5F/mt1z8lulVnR5L5ivkT A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310284170"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="310284170"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 09:24:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="629764105"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 09:24:57 -0800
Date: Thu, 10 Feb 2022 09:24:50 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgVKYgby67brla9Z@agluck-desk3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <20220209191614.5a3b42d4@jacob-builder>
 <YgU9Bsq8a2NWzBvE@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgU9Bsq8a2NWzBvE@otcwcpicx3.sc.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Thu, Feb 10, 2022 at 08:27:50AM -0800, Fenghua Yu wrote:
> Hi, Jacob,
> 
> On Wed, Feb 09, 2022 at 07:16:14PM -0800, Jacob Pan wrote:
> > Hi Fenghua,
> > 
> > On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > 
> > > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > > *dev, struct mm_struct *mm, void }
> > >  
> > >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > > -	if (IS_ERR_OR_NULL(sva))
> > > -		intel_svm_free_pasid(mm);
> > If bind fails, the PASID has no IOMMU nor CPU context. It should be safe to
> > free here.
> 
> The PASID can not be freed even if bind fails. The PASID allocated earlier
> (either in this thread or in another thread) might be populated to other
> threads already and being used now.
> 
> Without freeing the PASID on bind failure, the worst case is the PASID might
> not be used in the process (and will be freed on process exit anyway).
> 
> This all matches with the PASID life time described in the commit message.

But what does this mean for the user that failed that intel_svm_bind_mm()?

Here's a scenario:

Process sets up to use PASID capable device #1. Everything works,
so the process has mm->pasid, and the IOMMU has the tables to map
virtual addresses coming from device #1 using that PASID.

Now the same process asks to start using PASID capable device #2,
but there is a failure at intel_svm_bind_mm().

Fenghua is right that we shouldn't free the PASID. It is in use
by at least one thread of the process to access device #1.

But what happens with device #2? Does the caller of intel_svm_bind()
do the right thing with the IS_ERR_OR_NULL return value to let the
user know that device #2 isn't accessible?

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
