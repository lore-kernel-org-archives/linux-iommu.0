Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0435DC433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 09:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DBBD4064B;
	Tue, 15 Feb 2022 09:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auaIDCTNiLtK; Tue, 15 Feb 2022 09:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4340940530;
	Tue, 15 Feb 2022 09:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A74BC0011;
	Tue, 15 Feb 2022 09:52:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BAAAC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AF0B81D65
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEOWjpXtKKsx for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:52:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AE7F81D3A
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644918728; x=1676454728;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oe4YO6EvDJseL0z7C+Rpj3omkU3reoCERPtvQmTBO+k=;
 b=WGxXGexia/WvE0puO3bMEdX6Bw29xq56dUcUhqHY/ed7PospDTc3htCV
 v+wgJe/KeoVWUAzdOfRz9dfnyRfDvpJ+ognTXmcinwI9AWu1Or+PhZfE3
 auC+RQgSLVXGvOK+tAQEGtgSpr5F6ICY8c9fRQBvyYdG9T4qJgE7sEwqo
 lPD70n4jhW4HKeh5emxNrqZBvEgNy8TQgyYmFqGUzPvNptMsTUAuABk8R
 XfIrya++DXBjy9jAv3tF75F0LcM/WLJeDEpQBL8v59pMB9hzLAT8Fwj5k
 JGmZ3cOLqvFxpQFnkLKhqixYsHwuZkjG+Q9zmHfbMFNTggHS36ZoAB3L8 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="311049195"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; d="scan'208";a="311049195"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2022 01:52:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; d="scan'208";a="635765473"
Received: from smile.fi.intel.com ([10.237.72.59])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2022 01:52:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1nJuUI-004s5J-9I; Tue, 15 Feb 2022 11:51:10 +0200
Date: Tue, 15 Feb 2022 11:51:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Message-ID: <Ygt3jibBVRyCn909@smile.fi.intel.com>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
 <YgpY1IIBkFIxxjbm@8bytes.org>
 <30e45a7e-088d-7479-a284-68effadf3cbe@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30e45a7e-088d-7479-a284-68effadf3cbe@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Joerg Roedel <jroedel@suse.de>, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On Tue, Feb 15, 2022 at 09:31:37AM +0800, Lu Baolu wrote:
> On 2/14/22 9:27 PM, Joerg Roedel wrote:
> > On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:

...

> > > +extern const struct iommu_ops intel_iommu_ops;

> > The intel_iommu_ops symbol is only used in drivers/iommu/intel, so I
> > would prefer a header in that directory. But I leave that up to Baolu to
> > decide.
> 
> Agreed. I also have a plan to split them out into a internal header.

The above change is hanging for more than a year, can we apply it and then
you can do a split?

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
