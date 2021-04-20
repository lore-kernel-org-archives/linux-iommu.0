Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C0C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 14:55:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45996024A
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 14:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45996024A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DED483B50;
	Tue, 20 Apr 2021 14:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WKnVUju_zRpo; Tue, 20 Apr 2021 14:55:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BEF183B51;
	Tue, 20 Apr 2021 14:55:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12DA2C000F;
	Tue, 20 Apr 2021 14:55:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48D49C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 14:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A74740231
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 14:55:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08xKaZkNRqf7 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 14:55:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 192E640207
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 14:55:05 +0000 (UTC)
IronPort-SDR: 1XM6AAQkdRWnlGv2C1EB/ni5kBkJRwGKhMEMRZUYDzMmtQwTEJLU1W7z6mObYCrfwh0YogtjBh
 7yMHoE+Jq1tQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="192331417"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; d="scan'208";a="192331417"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 07:55:04 -0700
IronPort-SDR: dM4sAtHmAvUU0E/HzIJpF1Mxak3MPMiOy+ImXYzhL5aHCBDkR23wTvaoNfscCd0JbCnAbyS9RB
 3YHvWIhpSSbg==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; d="scan'208";a="534523129"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 07:55:00 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1lYrmD-005mvJ-7F; Tue, 20 Apr 2021 17:54:57 +0300
Date: Tue, 20 Apr 2021 17:54:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
Message-ID: <YH7rQbDzQAlY5Z7R@smile.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
 <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
 <20210420105640.GI3@paasikivi.fi.intel.com>
 <YH7BNbk/mhq6VXPo@smile.fi.intel.com>
 <20210420143727.GP3@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420143727.GP3@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: rajatja@google.com, will@kernel.org, grundler@chromium.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 senozhatsky@chromium.org, iommu@lists.linux-foundation.org,
 bhelgaas@google.com, Bingbu Cao <bingbu.cao@intel.com>, dwmw2@infradead.org,
 Bingbu Cao <bingbu.cao@linux.intel.com>
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

On Tue, Apr 20, 2021 at 05:37:27PM +0300, Sakari Ailus wrote:
> On Tue, Apr 20, 2021 at 02:55:33PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 20, 2021 at 01:56:40PM +0300, Sakari Ailus wrote:
> > > On Tue, Apr 20, 2021 at 06:34:26PM +0800, Bingbu Cao wrote:
> > > > On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> > > > > On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> > 
> > ...
> > 
> > > > > This misses the changelog from v1 followed by the explanation why resent.
> > > > > 
> > > > I noticed there was a typo in the recipient list:
> > > > stable.vger.kernel.org -> stable@vger.kernel.org
> > > > 
> > > > no code change for resent.
> > > 
> > > When you're submitting a patch and want it reach the stable kernels, you'll
> > > need to add a Cc tag:
> > > 
> > > 	Cc: stable@vger.kernel.org
> > > 
> > > But not actually add the address to cc. I dropped stable@vger address from
> > > distribution.
> > 
> > Does it really matter?
> 
> Usually aligning what you're doing with
> Documentation/process/submitting-patches.rst is not a bad idea.

True, my point is that technically both ways will give the same result, no?

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
