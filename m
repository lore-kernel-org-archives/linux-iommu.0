Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911E7C4332F
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 16:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B0C3408F9;
	Thu, 10 Feb 2022 16:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kIn6WA9zbZk; Thu, 10 Feb 2022 16:28:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 15121408AD;
	Thu, 10 Feb 2022 16:28:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF185C0011;
	Thu, 10 Feb 2022 16:28:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D492C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 16:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C2F082A6C
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 16:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s0AsFZaVuQyS for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 16:28:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC27482A53
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644510494; x=1676046494;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DGhm09HzjY8rDyG0mR3sFd/viujCm4K2akDYcHlitZo=;
 b=M5/EZc67DX7To/SxDbew/htzeWOrR2CqiFBoWW9Jg63Ij8EnrHoZRSOW
 g1ePUP3GHtVoTLGENSfzqsrT7xbAXQywTxs1YfIgRfmCLfDp/I6drsGw8
 fW53vFRMf8xqBu7ZGyFz+edjVEvPAUbIwn9faMPUNV89HNlH8H3hUu7su
 rdia/nE6AxR7LNvrW5UdufjUkEAwE61X81/lIUW8M1Ye8iWU8qwrU5JcD
 IAfVBwYf0BdVveESjXd/GUHMQJfQ/IIhbKkCqrudeSEomehIl0uiXDO4m
 GGzsgdgnpUXLiHGTKD5UFzDrZBOiVkD1An5Yz/84YK2UkUp6pZjwROAlq g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247115431"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="247115431"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 08:27:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="701747201"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 08:27:56 -0800
Date: Thu, 10 Feb 2022 08:27:50 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgU9Bsq8a2NWzBvE@otcwcpicx3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <20220209191614.5a3b42d4@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220209191614.5a3b42d4@jacob-builder>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
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

Hi, Jacob,

On Wed, Feb 09, 2022 at 07:16:14PM -0800, Jacob Pan wrote:
> Hi Fenghua,
> 
> On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:
> 
> > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > *dev, struct mm_struct *mm, void }
> >  
> >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > -	if (IS_ERR_OR_NULL(sva))
> > -		intel_svm_free_pasid(mm);
> If bind fails, the PASID has no IOMMU nor CPU context. It should be safe to
> free here.

The PASID can not be freed even if bind fails. The PASID allocated earlier
(either in this thread or in another thread) might be populated to other
threads already and being used now.

Without freeing the PASID on bind failure, the worst case is the PASID might
not be used in the process (and will be freed on process exit anyway).

This all matches with the PASID life time described in the commit message.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
