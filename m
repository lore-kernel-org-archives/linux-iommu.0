Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CFFC433EF
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 20:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B3C483F38;
	Mon, 24 Jan 2022 20:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqt1X3gEnP7Q; Mon, 24 Jan 2022 20:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC82A82FA9;
	Mon, 24 Jan 2022 20:33:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEC0AC0039;
	Mon, 24 Jan 2022 20:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAC5DC002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA29340283
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XRPtzNiVjTCG for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 20:33:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A18B7400CD
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643056398; x=1674592398;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ujacmyO/PuoKNYdTwG8FMRiUMSIRWymHhVuwGwF59xk=;
 b=QsMZtKkl0jMEDVeKcCTZfHUSQEW1LxWDz5/PJ1BJBJFg0ynR92v4vtmY
 Fo4LzS/D61BpxVTXj2hNWomduK/jvzY+e1xfzfCHuNZ1SVG16UtJ1aYDL
 odhuInVpF1QK+a2cj7quVBJZnW5KDBR/tmg4qpgyYzL2cDV3os5jpqSC/
 JsmsFbY3/klM7bNZ4nt/iWenAbsQEOv152dNAAEJdJC37enYXibd52Y6U
 4RSvNMTV1xAlHigvDg2oMP092T+Hy0HkglN5VGMGFS3RwnAH3enCFIsi+
 MDIlH0WFw4lEdRcwdjlQUQV8i4ID99g3DmXHpQUeatneaIxaAyg0UOee0 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="309463884"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="309463884"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 12:33:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="494750089"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 12:33:16 -0800
Date: Mon, 24 Jan 2022 12:33:12 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ye8NCAKoGF/AsLfs@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
 <87ee4w6g1n.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ee4w6g1n.ffs@tglx>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
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

Hi, Thomas,

On Mon, Jan 24, 2022 at 09:21:24PM +0100, Thomas Gleixner wrote:
> On Fri, Dec 17 2021 at 22:01, Fenghua Yu wrote:
> > diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> > index bd41405d34e9..ee2294e02716 100644
> > --- a/drivers/iommu/iommu-sva-lib.c
> > +++ b/drivers/iommu/iommu-sva-lib.c
> > @@ -18,8 +18,7 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
> >   *
> >   * Try to allocate a PASID for this mm, or take a reference to the existing one
> >   * provided it fits within the [@min, @max] range. On success the PASID is
> > - * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> > - * @min must be greater than 0, because 0 indicates an unused mm->pasid.
> > + * available in mm->pasid and will be available for the lifetime of the mm.
> >   *
> >   * Returns 0 on success and < 0 on error.
> >   */
> > @@ -33,38 +32,24 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&iommu_sva_lock);
> > -	if (mm->pasid) {
> > -		if (mm->pasid >= min && mm->pasid <= max)
> > -			ioasid_get(mm->pasid);
> > -		else
> > +	/* Is a PASID already associated with this mm? */
> > +	if (pasid_valid(mm->pasid)) {
> > +		if (mm->pasid < min || mm->pasid >= max)
> >  			ret = -EOVERFLOW;
> > -	} else {
> > -		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > -		if (pasid == INVALID_IOASID)
> > -			ret = -ENOMEM;
> > -		else
> > -			mm->pasid = pasid;
> > +		goto out;
> >  	}
> > +
> > +	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > +	if (!pasid_valid(pasid))
> > +		ret = -ENOMEM;
> > +	else
> > +		mm_pasid_get(mm, pasid);
> 
> Hrm. This is odd.
> 
> > +/* Associate a PASID with an mm_struct: */
> > +static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
> > +{
> > +	mm->pasid = pasid;
> > +}
> 
> This does not get anything. It sets the allocated PASID in the mm. The
> refcount on the PASID was already taken by the allocation. So this
> should be mm_pasid_set() or mm_pasid_install(), right?

Ok. Will change mm_pasid_get() to mm_pasid_set().

Thank you very much for your review!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
