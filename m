Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBBC433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 14:36:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBCF611C6
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 14:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EBCF611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05FDA6078F;
	Thu, 23 Sep 2021 14:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-TtYLKdrujG; Thu, 23 Sep 2021 14:36:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F224860779;
	Thu, 23 Sep 2021 14:36:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC9B4C000F;
	Thu, 23 Sep 2021 14:36:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 791AEC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 14:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 682E26078F
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 14:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4IhuK_SRY5LW for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 14:36:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C660D60779
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 14:36:54 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1632407811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qk5SWtvWztav1d34rimp+axwz2uAlkSCirHPCi6SGlY=;
 b=g7Ek/TeFULsF7sK6OQfwNWOX61vf8REKAJRK7IzhTXeBgOdV/Diko4a0P5+bQYnb07elR0
 s4ILsOk9KJsvfxL22o7/g/MPCbxlEvFa+0QeN91yGuF2dmYeNYy/k9vC84EJ3Hoajn2v1K
 WcIiM/nIav37yMi6oFosTp93wFq+qzFfi9tdwoG8pSEvXFOO1X/YqGOdx8LPLEujT54F4o
 q6zuR8YcaHraOlkIYkj8tThSId7POAlsuQKadr1x777hR72nYITCYMG88C0BOJO3ug0Tqe
 sx8fGggxr6c3LRp2oSd86MaIK+H9fpdZZbmCCoQF9W1A7ELAXs+fs/abt7khnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1632407811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qk5SWtvWztav1d34rimp+axwz2uAlkSCirHPCi6SGlY=;
 b=H6dvkkN47bCyZzwlY0JUFQ7uATY2ql1mGO4cHSy6395KBmgE8LpdjVgsY+g0mML0arQgcv
 ryxelQSmTKi+KUCQ==
To: Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Tony Luck <tony.luck@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Dave
 Jiang <dave.jiang@intel.com>, Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <20210920192349.2602141-6-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
Date: Thu, 23 Sep 2021 16:36:50 +0200
Message-ID: <87y27nfjel.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Sep 20 2021 at 19:23, Fenghua Yu wrote:
>  
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +void pasid_put(struct task_struct *tsk, struct mm_struct *mm);
> +#else
> +static inline void pasid_put(struct task_struct *tsk, struct mm_struct *mm) { }
> +#endif

This code is again defining that PASID is entirely restricted to
INTEL. It's true, that no other vendor supports this, but PASID is
a non-vendor specific concept.

Sticking this into INTEL code means that any other PASID implementation
has to rip it out again from INTEL code and make it a run time property.

The refcounting issue should be the same for all PASID mechanisms which
attach PASID to a mm. What's INTEL specific about that?

So can we pretty please do that correct right away?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
