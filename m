Return-Path: <SRS0=vV0e=JS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585E0C43460
	for <iommu@archiver.kernel.org>; Wed, 21 Apr 2021 11:53:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA9360FE5
	for <iommu@archiver.kernel.org>; Wed, 21 Apr 2021 11:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA9360FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F4B6405D8;
	Wed, 21 Apr 2021 11:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id erdC2U2D4zLk; Wed, 21 Apr 2021 11:53:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2017E405E9;
	Wed, 21 Apr 2021 11:53:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04377C000F;
	Wed, 21 Apr 2021 11:53:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A446AC000B
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 11:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8630C607BD
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 11:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUrFSiwE-HtJ for <iommu@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 11:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B86BC60B74
 for <iommu@lists.linux-foundation.org>; Wed, 21 Apr 2021 11:53:17 +0000 (UTC)
IronPort-SDR: XThhbnP+L0li7SUM3xk8jl0qHRCR4tbcb2pCT9UmRyILroTv4G5UFM1c1y/8n7XEj2BIZydR4Q
 ebvWcDhrRFAQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="259482203"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; d="scan'208";a="259482203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 08:27:48 -0700
IronPort-SDR: VE0ZHW+dE8/dljSH/NnQfcj4YuIYvbQFSObNTUMZ6j7UyMlkLb1E559cOwR/VObfTIZVdIZ5L8
 af44Y8czr+aA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; d="scan'208";a="523848457"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 08:27:45 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
 by paasikivi.fi.intel.com (Postfix) with SMTP id 5BA292051E;
 Tue, 20 Apr 2021 18:27:43 +0300 (EEST)
Date: Tue, 20 Apr 2021 18:27:43 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
Message-ID: <20210420152743.GQ3@paasikivi.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
 <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
 <20210420105640.GI3@paasikivi.fi.intel.com>
 <YH7BNbk/mhq6VXPo@smile.fi.intel.com>
 <20210420143727.GP3@paasikivi.fi.intel.com>
 <YH7rQbDzQAlY5Z7R@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YH7rQbDzQAlY5Z7R@smile.fi.intel.com>
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

On Tue, Apr 20, 2021 at 05:54:57PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 20, 2021 at 05:37:27PM +0300, Sakari Ailus wrote:
> > On Tue, Apr 20, 2021 at 02:55:33PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 20, 2021 at 01:56:40PM +0300, Sakari Ailus wrote:
> > > > On Tue, Apr 20, 2021 at 06:34:26PM +0800, Bingbu Cao wrote:
> > > > > On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> > > > > > On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> > > 
> > > ...
> > > 
> > > > > > This misses the changelog from v1 followed by the explanation why resent.
> > > > > > 
> > > > > I noticed there was a typo in the recipient list:
> > > > > stable.vger.kernel.org -> stable@vger.kernel.org
> > > > > 
> > > > > no code change for resent.
> > > > 
> > > > When you're submitting a patch and want it reach the stable kernels, you'll
> > > > need to add a Cc tag:
> > > > 
> > > > 	Cc: stable@vger.kernel.org
> > > > 
> > > > But not actually add the address to cc. I dropped stable@vger address from
> > > > distribution.
> > > 
> > > Does it really matter?
> > 
> > Usually aligning what you're doing with
> > Documentation/process/submitting-patches.rst is not a bad idea.
> 
> True, my point is that technically both ways will give the same result, no?

If you get your patch merged this way, then yes. :-)

-- 
Sakari Ailus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
