Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58CAC433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 15:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E722606DC;
	Tue,  8 Feb 2022 15:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TLzJi9ZrFvD; Tue,  8 Feb 2022 15:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85B4760598;
	Tue,  8 Feb 2022 15:02:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 583D1C0011;
	Tue,  8 Feb 2022 15:02:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA7C2C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86C8F606FF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fop8MzO7B8No for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 15:01:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 428EC60598
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644332515; x=1675868515;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XpENSQQtkROfpCO6JNc1kJzZlo2IByE0DAYnUc+WpfQ=;
 b=ETWQZie5gJOOGKO/QCwgxsjnfObs+oLAyNLe1iELbVK2LoNTAQnKUxEi
 jVcLLZ752yutqSG9wU/z9mDDsYJ2AfxbEXPpegEJLG72jyYheMCVH4Key
 U/EYUDv7BQYrCVO/HZYg7P8zkZDVYZYYd08XWq7UCX/fyVbtV7O1KMdeI
 7A0V0pKOJ05BNa9SBjq+RlXJRyzxNXI6pxEupfALphqjP2GIumPVyKBBJ
 EsJHR3kh8HTV1UUhys2i1rt7IIckucmMaiG+QJvPoQgSdwFkfqGRgSP2V
 NK9LAVq0jnWDrsUqtmpYxwxgF2Z7Boddz+Ml1v3S1T7VRknvAQo9seDl8 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236369590"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; d="scan'208";a="236369590"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2022 07:01:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; d="scan'208";a="484835940"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2022 07:01:53 -0800
Date: Tue, 8 Feb 2022 07:01:44 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgKF2NDMURGq1JD1@otcwcpicx3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <139b9789-403f-c599-de02-3092847952c0@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <139b9789-403f-c599-de02-3092847952c0@linux.intel.com>
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

On Tue, Feb 08, 2022 at 10:41:39AM +0800, Lu Baolu wrote:
> On 2/8/22 7:02 AM, Fenghua Yu wrote:
> > PASIDs are process wide. It was attempted to use refcounted PASIDs to
> > free them when the last thread drops the refcount. This turned out to
> > be complex and error prone. Given the fact that the PASID space is 20
> > bits, which allows up to 1M processes to have a PASID associated
> > concurrently, PASID resource exhaustion is not a realistic concern.
> > 
> > Therefore it was decided to simplify the approach and stick with lazy
> > on demand PASID allocation, but drop the eager free approach and make
> > a allocated PASID lifetime bound to the life time of the process.
> > 
> > Get rid of the refcounting mechanisms and replace/rename the interfaces
> > to reflect this new approach.
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> > v4:
> > - Update the commit message (Thomas).
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thank you very much for your review, Baolu!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
