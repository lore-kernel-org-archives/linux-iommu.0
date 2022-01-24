Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD38C4332F
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 20:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 600C660AE1;
	Mon, 24 Jan 2022 20:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3RhWLOHPnTg; Mon, 24 Jan 2022 20:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5789960803;
	Mon, 24 Jan 2022 20:52:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 395CEC0039;
	Mon, 24 Jan 2022 20:52:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4093C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CAF6160AE1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gS_DoV5fSseY for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 20:52:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05D1960803
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643057569; x=1674593569;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zk4FsO8id3AQmClLhfi5ct2JYeKgImL1nYfcJmgal4M=;
 b=ISQmz5ZC7dABwtqs/V4uRbl40ghBD6gktxNw+f9TmrA+vS2Da2E6Aset
 u1mr0yCsrYis6XSMoMI3EPnChMJShy5FiG99jJfZUyMt0D52AvedDmOHX
 tkSW033R3m3bTLfizkCY5tF3GBCnnCCIkWFGHxMlyNld9mgS39Cz+oqdg
 2IxTlR5kkbSzR4VJyWM3fKGmMRlkUR3v4XRnjibjQ4HEaUC7seH2Buwo5
 MhWOnTYMPvXc0agh0Vky0Qyo4MvDNFYI3+9eaEtdR3cgJ/wmJdvh5b8Oz
 c4kbRzQQNw3dy7wAo40n9YZkqzr6LnDJ659TJEFElHPTA0lzbnBfwRpMH g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226818764"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="226818764"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 12:52:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="479226615"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 12:52:47 -0800
Date: Mon, 24 Jan 2022 12:52:42 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
 <87ee4w6g1n.ffs@tglx> <87bl006fdb.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bl006fdb.ffs@tglx>
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

On Mon, Jan 24, 2022 at 09:36:00PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 21:21, Thomas Gleixner wrote:
> >
> > Hrm. This is odd.
> >
> >> +/* Associate a PASID with an mm_struct: */
> >> +static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
> >> +{
> >> +	mm->pasid = pasid;
> >> +}
> >
> > This does not get anything. It sets the allocated PASID in the mm. The
> > refcount on the PASID was already taken by the allocation. So this
> > should be mm_pasid_set() or mm_pasid_install(), right?
> 
> And as a result of all this ioasid_get() is now left without users...
> 
> Thanks,

Ah. This patch should remove ioasid_get(). So I will change this patch
as follows:

1. Remove ioasid_get() because it's not used any more when IOASID's
   refcount is set to 1 once the IOASID is allocated and is freed on mm exit.
2. Change mm_pasid_get() to mm_pasid_set().

Will that work?

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
