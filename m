Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F69C433FE
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 23:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B7544055D;
	Thu, 10 Feb 2022 23:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RdNpIjpk6aX6; Thu, 10 Feb 2022 23:15:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1CDCA401C9;
	Thu, 10 Feb 2022 23:15:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0C91C001A;
	Thu, 10 Feb 2022 23:15:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3936EC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 23:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 277B940874
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 23:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JskiA1v8tf63 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 23:15:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9254340873
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 23:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644534916; x=1676070916;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Lh6tjCWAtV9Sv/IHSE2GQfvx+Z+uUWNu3HE21O/Ggpo=;
 b=YyDEIyPfT4zHrvVlbpaR7QvU7mc4TuNTKlSowSHhVwCmaRIdUlgc2Zr0
 ++MwaAoBo8K7hfzloEoSS9t65xhxavULJDl8tkR100g02KQNThqoGSKsp
 10JoINDPEMqboDh1+4c/SfvmEXBCOFpq0mf/unfCJ8nKtobbkUayCVQQv
 veT9mB17LdSopOzz4B39GCG/mJdFW+4iugn4G1LCUedymC0dwgucE0nDA
 7xChMYrhmgYMezZsqfdhP1S/1/UoVeOyGHnPraNRZ1WDVUmmMtQN1oGFc
 662juvD5MuKrv1Bmue2pnHTB3CedoZKnZWC9erOCnkafa3sVOqhiFbreX w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="233171630"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="233171630"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 15:15:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="633862803"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 15:15:15 -0800
Date: Thu, 10 Feb 2022 15:15:10 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgWcfhbu3o5C6jQT@otcwcpicx3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <20220209191614.5a3b42d4@jacob-builder>
 <20220210104904.6c6131f2@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220210104904.6c6131f2@jacob-builder>
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

On Thu, Feb 10, 2022 at 10:49:04AM -0800, Jacob Pan wrote:
> 
> On Wed, 9 Feb 2022 19:16:14 -0800, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Hi Fenghua,
> > 
> > On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com>
> > wrote:
> > 
> > > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > > *dev, struct mm_struct *mm, void }
> > >  
> > >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > > -	if (IS_ERR_OR_NULL(sva))
> > > -		intel_svm_free_pasid(mm);  
> > If bind fails, the PASID has no IOMMU nor CPU context. It should be safe
> > to free here.
> > 
> Actually, here we cannot tell if the bind is the first of the mm so I think
> this is fine.
> 
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thank you very much for your review, Jacob!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
