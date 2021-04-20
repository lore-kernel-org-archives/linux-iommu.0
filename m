Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80619C43462
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 14:37:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DDD613C9
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 14:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DDD613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78F7483ADE;
	Tue, 20 Apr 2021 14:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pu0z9jRbzX5g; Tue, 20 Apr 2021 14:37:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7414B83AE0;
	Tue, 20 Apr 2021 14:37:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32179C000F;
	Tue, 20 Apr 2021 14:37:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 347E0C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 14:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BE53606CF
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 14:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t3SQWGSfB_Xe for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 14:37:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B44DD60695
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 14:37:34 +0000 (UTC)
IronPort-SDR: 7SxR8vQ4BA/DjlveCN8YmoOob5DcYGcpixNy4UTALRVhjfW4aNk4MT/eVnFcbo6IiXjHm+IDQR
 4KXZMKRgH5Cg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="182648139"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; d="scan'208";a="182648139"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 07:37:33 -0700
IronPort-SDR: WOahohYnePFwn7YJfMFaThS/W2tYoLkboNGRjY409sn0xa4wjpCsL1rwuIB8kq6sErXpiCGwQP
 x719Z0MFkTKA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; d="scan'208";a="454810435"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 07:37:29 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
 by paasikivi.fi.intel.com (Postfix) with SMTP id 8B6202051E;
 Tue, 20 Apr 2021 17:37:27 +0300 (EEST)
Date: Tue, 20 Apr 2021 17:37:27 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
Message-ID: <20210420143727.GP3@paasikivi.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
 <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
 <20210420105640.GI3@paasikivi.fi.intel.com>
 <YH7BNbk/mhq6VXPo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YH7BNbk/mhq6VXPo@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Tue, Apr 20, 2021 at 02:55:33PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 20, 2021 at 01:56:40PM +0300, Sakari Ailus wrote:
> > On Tue, Apr 20, 2021 at 06:34:26PM +0800, Bingbu Cao wrote:
> > > On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> > > > On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> 
> ...
> 
> > > > This misses the changelog from v1 followed by the explanation why resent.
> > > > 
> > > I noticed there was a typo in the recipient list:
> > > stable.vger.kernel.org -> stable@vger.kernel.org
> > > 
> > > no code change for resent.
> > 
> > When you're submitting a patch and want it reach the stable kernels, you'll
> > need to add a Cc tag:
> > 
> > 	Cc: stable@vger.kernel.org
> > 
> > But not actually add the address to cc. I dropped stable@vger address from
> > distribution.
> 
> Does it really matter?

Usually aligning what you're doing with
Documentation/process/submitting-patches.rst is not a bad idea.

-- 
Sakari Ailus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
