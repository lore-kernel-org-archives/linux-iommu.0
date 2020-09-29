Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B83C4346E
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 05:28:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0795B2145D
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 05:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0795B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 987A1844AA;
	Tue, 29 Sep 2020 05:28:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mjYmBYhD0Bo; Tue, 29 Sep 2020 05:28:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2B5BA84494;
	Tue, 29 Sep 2020 05:28:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1692EC016F;
	Tue, 29 Sep 2020 05:28:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67E1AC0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 05:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 52E9820481
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 05:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12aS7jS4xLdw for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:28:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 38D802046A
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 05:28:52 +0000 (UTC)
IronPort-SDR: lq/AIa+s5YsV1rnwz5iKIdhDmeZH+1akd2PNQA9S5LLmv3fuIuM8vF0jWMwoAmfv0ie/9WNQAy
 2QbVR0cwolKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="226263187"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; d="scan'208";a="226263187"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 22:28:50 -0700
IronPort-SDR: d9oPvLNhVZEmQrvhaHfWvzfDnd69GSsCde7vn8tKZXXDlWtSFGOfBY1v4BByLZJd6kferU2YSR
 AIkbsbmxwzAQ==
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; d="scan'208";a="489059027"
Received: from brdaguma-mobl.amr.corp.intel.com (HELO araj-mobl1.jf.intel.com)
 ([10.254.89.207])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 22:28:50 -0700
Date: Mon, 28 Sep 2020 22:28:48 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH V7 0/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <20200929052848.GA26906@araj-mobl1.jf.intel.com>
References: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
 <20200924172148.GA85236@otc-nc-03>
 <20200925073423.GT27174@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925073423.GT27174@8bytes.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Joerg

On Fri, Sep 25, 2020 at 09:34:23AM +0200, Joerg Roedel wrote:
> Hi Ashok,
> 
> On Thu, Sep 24, 2020 at 10:21:48AM -0700, Raj, Ashok wrote:
> > Just trying to followup on this series.
> > 
> > Sai has moved out of Intel, hence I'm trying to followup on his behalf.
> > 
> > Let me know if you have queued this for the next release.
> 
> Not yet, but I think this is mostly ready. Can you please send a new
> version in a new mail thread so that I can pick it up with b4?

I reposted Sai's patches again here. 

https://lore.kernel.org/linux-iommu/20200925190620.18732-2-ashok.raj@intel.com/

Can you let me know if they are in a format you can pickup> via b4? 

With recent issues we have sending mails out of Intel, wanted to make sure everything
made it out in one piece.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
