Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7DEC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 09:00:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5675613A6
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 09:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5675613A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 900926069E;
	Wed, 29 Sep 2021 09:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQvQuDOFBToe; Wed, 29 Sep 2021 09:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72C2B60669;
	Wed, 29 Sep 2021 09:00:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 514C5C000F;
	Wed, 29 Sep 2021 09:00:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF3C4C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DDBD60663
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3kd9ZK-NUOdZ for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 09:00:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5F286065F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=pHipk2Cz3G9EnP66HxC1PEdxlMMCy85ylZCusFz7JX8=; b=L2xBKMCBCbqkPhULXQnAf/DB/B
 bROMSR+f43tHOq/eYeFHLkKZn1Pk/y5gW3IrCVfl7d6eN4psA+tO/5zk5f6KFbGjDxVOU+fN6MVY9
 +uCWD0iwIlzcIMeEqIylwygihyu/69yJlPiF/7DoovPPq5tws71ZfddvLvr7I6KMu//PQuXXUiKYZ
 3SeOrI0MoGwFyYPSltKq8xVFNlaI8W1mKyE91ZVyi9vagKB4SbAezx4crOIMzohhzv6twbfoxL+98
 mZ1Bp5eC48Jte5ZUkraixWMamffwPKDEPZhM1SOK6mnP3LusiK/LfUUSaggTQrThqws3VSMxUG6Wx
 y7jpSh/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVVS5-006g5d-O5; Wed, 29 Sep 2021 09:00:33 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0128E30029A;
 Wed, 29 Sep 2021 11:00:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 9DC2D2DC92D0A; Wed, 29 Sep 2021 11:00:32 +0200 (CEST)
Date: Wed, 29 Sep 2021 11:00:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVQrMHXBzEpJmqRy@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <20210922210722.GV4323@worktop.programming.kicks-ass.net>
 <YUy2AmabA4ODOgAC@agluck-desk2.amr.corp.intel.com>
 <YU3UkvNdzCqAANSY@hirez.programming.kicks-ass.net>
 <YU3xLNJsSjIEpocT@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YU3xLNJsSjIEpocT@agluck-desk2.amr.corp.intel.com>
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

On Fri, Sep 24, 2021 at 08:39:24AM -0700, Luck, Tony wrote:

> If you have ctags installed then a ctrl-] on that
> __fixup_pasid_exception() will take you to the function with
> the comments. No electron microscope needed.

I to use ctags, but when reading the #GP handler, this is a whole
different file. Also, I don't find any of those comments explaining the
not-our-#GP-but-harmless-cycle issue.

The current->has_valid_pasid one comes close, but just misses it. But
really the place to put this is in the #GP handler itself so we don't
have to dig through every call there to figure out how it's supposed to
work.

> +
> +/*
> + * Try to figure out if there is a PASID MSR value to propagate to the
> + * thread taking the #GP.
> + */
> +bool __fixup_pasid_exception(void)
> +{
> +       u32 pasid;
> +
> +       /*
> +        * This function is called only when this #GP was triggered from user
> +        * space. So the mm cannot be NULL.
> +        */
> +       pasid = current->mm->pasid;
> +
> +       /* If no PASID is allocated, there is nothing to propagate. */
> +       if (pasid == PASID_DISABLED)
> +               return false;
> +
> +       /*
> +        * If the current task already has a valid PASID MSR, then the #GP
> +        * fault must be for some non-ENQCMD related reason.
> +        */
> +       if (current->has_valid_pasid)
> +               return false;
> +
> +       /* Fix up the MSR by the PASID in the mm. */
> +       fpu__pasid_write(pasid);
> +       current->has_valid_pasid = 1;
> +
> +       return true;
> +}
> 
> -Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
