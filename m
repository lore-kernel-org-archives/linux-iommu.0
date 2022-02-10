Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96599C433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 18:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A91582977;
	Thu, 10 Feb 2022 18:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5cGI8Tq5N0o1; Thu, 10 Feb 2022 18:46:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DDE682907;
	Thu, 10 Feb 2022 18:46:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBFF6C0011;
	Thu, 10 Feb 2022 18:46:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3923C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 18:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B087340144
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 18:46:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zwUiFszERV4O for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 18:46:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E98F400C8
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644518768; x=1676054768;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rwYtZDJpiN5pbfbdwSd8f9sWHmJpVk7KWW+5mNsUYHk=;
 b=F7tmy2vBDwfS7DOk+vQdGY6TgPZzQVpBv/j1aZWQTjE57vwXStQV3jkU
 CGAy5C5nkq+WSoW4fbh54uqzfyv1Wpj5IexIj37Ovc8bGjwLodxnMKXNF
 1hVJtjDvFFI4Bem10pQfc9Ygkts9KBT/Hy59rNiEj+oRUQnKRKIQBtO+/
 +H0tb1xNKop3JfdLjZV5TKDOM9jNlUyKQ1wIfBIKHQLQPoEZOumN6HKiv
 ku7kRVWwQHunFfpaa810zCKYKQK+D6QbL10kfgQ6wbJ6QJycUvKXfaEbW
 x20Pv9qWEFjOz0szWcH/jqGPobwPp6Ggi1pdnx1se9WJzvuWsdmCn6IX2 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247149555"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="247149555"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 10:46:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="537402098"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 10:46:07 -0800
Date: Thu, 10 Feb 2022 10:49:04 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220210104904.6c6131f2@jacob-builder>
In-Reply-To: <20220209191614.5a3b42d4@jacob-builder>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <20220209191614.5a3b42d4@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy
 Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
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


On Wed, 9 Feb 2022 19:16:14 -0800, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Hi Fenghua,
> 
> On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com>
> wrote:
> 
> > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > *dev, struct mm_struct *mm, void }
> >  
> >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > -	if (IS_ERR_OR_NULL(sva))
> > -		intel_svm_free_pasid(mm);  
> If bind fails, the PASID has no IOMMU nor CPU context. It should be safe
> to free here.
> 
Actually, here we cannot tell if the bind is the first of the mm so I think
this is fine.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> Thanks,
> 
> Jacob


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
