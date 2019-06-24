Return-Path: <SRS0=0Jvo=UX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32E5C4646B
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 22:25:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D067B20674
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 22:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D067B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A50A6C6A;
	Mon, 24 Jun 2019 22:25:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5105FC3A
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 22:25:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E84A97FB
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 22:25:15 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Jun 2019 15:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; d="scan'208";a="359696051"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2019 15:25:15 -0700
Date: Mon, 24 Jun 2019 15:28:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 10/22] iommu: Fix compile error without IOMMU_API
Message-ID: <20190624152830.20bace1d@jacob-builder>
In-Reply-To: <20190618151031.00004bbd@huawei.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1560087862-57608-11-git-send-email-jacob.jun.pan@linux.intel.com>
	<20190618151031.00004bbd@huawei.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, 18 Jun 2019 15:10:31 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Sun, 9 Jun 2019 06:44:10 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > struct page_response_msg needs to be defined outside
> > CONFIG_IOMMU_API.  
> 
> What was the error? 
> 
struct page_response_msg can be undefined if under CONFIG_IOMMU_API.
This was resolved after Jean move it to uapi. Sorry, I could have made
it more clear, not a fix for mainline kernel bug just a patch for
previous patch in Jean's API tree.
> If this is a fix for an earlier patch in this series role it in there
> (or put it before it). If more general we should add a fixes tag.
> 
> Jonathan
>  [...]  
> 
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
