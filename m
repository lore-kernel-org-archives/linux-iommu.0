Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC52FC433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 18:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44E124177C;
	Mon, 18 Apr 2022 18:08:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KG7MdZtikEti; Mon, 18 Apr 2022 18:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 72E2241752;
	Mon, 18 Apr 2022 18:08:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FBA4C0033;
	Mon, 18 Apr 2022 18:08:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3376C002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 18:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D177040438
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 18:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgzedoqMKm7f for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 18:08:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3E3340111
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650305282; x=1681841282;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dyyMH0xpZtsmvKPKBHxyzRSqFnhpIBPEXWOqpua1DEE=;
 b=YQj2Wk+wvtCBxdy+uZDZsMmnM0HC+CaZ4JM8XrwDBqAtWtSEEEgzaY9o
 VtBn5qPE5K0tuAPDvRvBO0JF7BkCeZy2MgeN94ENWwM9ywGbNRdVGvOwv
 oNZv8rTk8dSt8Y2rFmcWN4sDiBsttCkZGS5IP5UUm/m85RfATpJJhNqb1
 kY4Uf/Y6EzY4BOwgdIZpmIIS9AcoCSuMfJoYxQNiuBvi7rfDCNOlSja5s
 zwjYDHwTBg8b/2XCNwzGGrPG+8s/x/fJfw8/GtU61vztofUqVpnD2wWXQ
 FvORxNpSxfox6zdCiwpNJMST+dFO0PetUx2wdyxdHVHLcJ/+06m1SOV/c A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="261183549"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; d="scan'208";a="261183549"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 11:08:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; d="scan'208";a="529659339"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 11:08:01 -0700
Date: Mon, 18 Apr 2022 11:11:35 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220418111135.6260d450@jacob-builder>
In-Reply-To: <BN9PR11MB52765490BFC5F08CD4F7A9208CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <20220415140002.7c12b0d2@jacob-builder>
 <BN9PR11MB52765490BFC5F08CD4F7A9208CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>, jean-philippe <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Hansen, 
 Dave" <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Lutomirski,
 Andy" <luto@kernel.org>, "Poimboe, Josh" <jpoimboe@redhat.com>,
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

Hi Kevin,

On Mon, 18 Apr 2022 06:34:19 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, April 16, 2022 5:00 AM
> > 
> > Hi zhangfei.gao@foxmail.com,
> > 
> > On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
> > <zhangfei.gao@foxmail.com> wrote:
> >   
> > > >>> A PASID might be still used even though it is freed on mm exit.
> > > >>>
> > > >>> process A:
> > > >>> 	sva_bind();
> > > >>> 	ioasid_alloc() = N; // Get PASID N for the mm
> > > >>> 	fork(): // spawn process B
> > > >>> 	exit();
> > > >>> 	ioasid_free(N);
> > > >>>
> > > >>> process B:
> > > >>> 	device uses PASID N -> failure
> > > >>> 	sva_unbind();
> > > >>>
> > > >>> Dave Hansen suggests to take a refcount on the mm whenever
> > > >>> binding  
> > the  
> > > >>> PASID to a device and drop the refcount on unbinding. The mm
> > > >>> won't  
> > be  
> > > >>> dropped if the PASID is still bound to it.
> > > >>>
> > > >>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
> > > >>> allocation and free it on mm exit")
> > > >>>  
> > Is process A's mm intended to be used by process B? Or you really should
> > use PASID N on process B's mm? If the latter, it may work for a while
> > until B changes mapping.
> > 
> > It seems you are just extending the life of a defunct mm?
> >   
> 
> IMHO the intention is not to allow B to access A's mm.
> 
> The problem is that PASID N is released on exit() of A and then
> reallocated to B before iommu driver gets the chance to quiesce
> the device and clear the PASID entry. According to the discussion
> the quiesce operation must be done when driver calls unbind()
> instead of in mm exit. In this case a failure is reported when
> B tries to call bind() on PASID N due to an already-present entry.
> 
> Dave's patch extending the life of A's mm until unbind() is called.
> With it B either gets a different PASID before A's unbind() is 
> completed or same PASID N pointing to B's mm after A's unbind().
> 
As long as B gets a different PASID, that is fine. It seems PASID N has no
use then.

> Thanks
> Kevin


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
