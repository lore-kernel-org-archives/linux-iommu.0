Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474F5C4332F
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 15:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5ABE60E69;
	Thu, 28 Apr 2022 15:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 34ee34wIQe0z; Thu, 28 Apr 2022 15:28:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9BCCD60F29;
	Thu, 28 Apr 2022 15:28:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 761EBC0039;
	Thu, 28 Apr 2022 15:28:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99C11C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77284417BE
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q0fv4xlkkkar for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:28:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCD9D417B6
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651159691; x=1682695691;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4JLBXpO7OFugdq0TzzwsqFbdF4JGMEv8lqRHVUp7dVA=;
 b=cX9SO6472Fho/2KsZZjmWaUc70zb4Egx2rxbVrjKogXRjyy8wHX5rr42
 AKT5/i/czr0rbm4yroUF7dbl7PeEMkF2hJRmt4BKbxAGXsTqbDf+24rMt
 sKBpMLSx6hrMsn/1UWBWfYIPr0hVuCrzcD6qOICTkLP17me4dAH2sgwg9
 9PLar2dcPBaL6bloX4U7RH0HRmesDMDxAj3jDJbmTZPRO+piXkRVnISLj
 1X6jWLBQ+vG9ViMwNvotkfvdkKclwQrM4cyI2lk3rIYYwsyt3zLF4+Bdi
 Ts4VYeG4Jcjw492KxfzRsXc/mQYbfhA1ULWoMLS+86D3OzmoeXY5hrAOH A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246240728"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="246240728"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:28:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="651263724"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:28:10 -0700
Date: Thu, 28 Apr 2022 08:28:41 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmqyeBfCuDXAMDlZ@fyu1.sc.intel.com>
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
 Thomas Gleixner <tglx@linutronix.de>, robin.murphy@arm.com,
 Ingo Molnar <mingo@redhat.com>
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

Hi, Dave,

On Thu, Apr 28, 2022 at 08:09:04AM -0700, Dave Hansen wrote:
> On 4/25/22 21:20, Fenghua Yu wrote:
> >>From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Date: Fri, 15 Apr 2022 00:51:33 -0700
> > Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
> > 
> > A PASID might be still used on ARM after it is freed in __mmput().
> 
> Is it really just ARM?

Actually it should happen on X86 as well. I will remove "on ARM" in the
changelog.

> 
> > process:
> > 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> > 	exit();
> > 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> > 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
> > 
> > To avoid the use-after-free issue, free the PASID after no device uses it,
> > i.e. after all devices are unbound from the mm.
> > 
> > sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> > __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> > in __mmdrop() guarantees the PASID is safely freed only after no device
> > is bound to the mm.
> 
> Does this changelog work for everyone?
> 
> ==
> 
> tl;dr: The PASID is being freed too early.  It needs to stay around
> until after device drivers that might be using it have had a chance to
> clear it out of the hardware.
> 

Do you want me to change the changlog to add both this paragraph and the
following paragraph?

> --
> 
> As a reminder:
> 
> mmget() /mmput()  refcount the mm's address space
> mmgrab()/mmdrop() refcount the mm itself
> 
> The PASID is currently tied to the life of the mm's address space and
> freed in __mmput().  This makes logical sense because the PASID can't be
> used once the address space is gone.
> 
> But, this misses an important point: even after the address space is
> gone, the PASID will still be programmed into a device.  Device drivers
> might, for instance, still need to flush operations that are outstanding
> and need to use that PASID.  They do this at ->release() time.
> 
> Device drivers hold a reference on the mm itself and drop it at
> ->release() time.  But, the device driver holds a reference mm itself,
> not the address space.  The address space (and the PASID) is long gone
> by the time the driver tries to clean up.  This is effectively a
> use-after-free bug on the PASID.
> 
> To fix this, move the PASID free operation from __mmput() to __mmdrop().
>  This ensures that the device drivers' existing mmgrab() keeps the PASID
> allocated until they drop their mm reference.
> 

Thank you very much!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
