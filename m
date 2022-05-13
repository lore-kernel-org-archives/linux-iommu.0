Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490C7C433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 18:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D99CC83F53;
	Fri, 13 May 2022 18:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GZcPan9_kHIe; Fri, 13 May 2022 18:58:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDC1383F32;
	Fri, 13 May 2022 18:58:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D026C0039;
	Fri, 13 May 2022 18:58:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42EDAC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30C0460ABD
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H_ld-kF4iL4Y for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 18:58:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 944E060640
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652468284; x=1684004284;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rCKiBLo5JPRevaGfzEi2/7NKS4ODTjaZmZIfll5payA=;
 b=m7V3TdZzMVvZQs83ySuNqOqLe/NCledAY42qfvfBJ6ATLVMp8RYyLTFa
 iCK/QEtSQlAFL87Ko/aRY1O9VCnUFYH6tkIXsTIADis88n6sglghhUEiA
 0ZWfqPjF8nHvvPJryMYPKrY/EcLfQleYBbSxdmVb3dm8vFL03D7TO/33M
 Re7ZcT8zF8bcgvUysq/TYvoa3T9SOQtneRWFoMIaFp+WQCYlfbMgu7cMc
 wqgxloNsrTU9DM8GnQ2quci1JPIYqDv8p9XoXfE5CarlASefVCqJ+7y9h
 zQGzEUxQFi/O59rLiy55NkMoWdCrtPAx49DpwK9DEvCvELk/leN9ZgH5X Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="267977520"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="267977520"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 11:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="521535494"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga003.jf.intel.com with ESMTP; 13 May 2022 11:58:02 -0700
Date: Fri, 13 May 2022 12:01:37 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 12/29] iommu/amd: Enable NMIPass when allocating an
 NMI irq
Message-ID: <20220513190137.GC22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-13-ricardo.neri-calderon@linux.intel.com>
 <87tua2fj41.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tua2fj41.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, May 06, 2022 at 11:26:22PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> >  
> > +	if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
> > +		/* Only one IRQ per NMI */
> > +		if (nr_irqs != 1)
> > +			return -EINVAL;
> 
> See previous reply.

I remove this check.

Thanks and BR,
Ricardo
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
