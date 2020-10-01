Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CADDC4727C
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 13:51:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D587D20B1F
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 13:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D587D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7530286940;
	Thu,  1 Oct 2020 13:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-F+y4osVCq8; Thu,  1 Oct 2020 13:51:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5DB1E868DB;
	Thu,  1 Oct 2020 13:51:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40057C016F;
	Thu,  1 Oct 2020 13:51:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60EDAC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 13:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3B27B2048F
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 13:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V6ka5WvcnQS3 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 13:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 2BD16203D5
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 13:51:35 +0000 (UTC)
IronPort-SDR: DEd1Wg/qZ+KHZOAeOMd8G6eirpiwMHxxFoBgsJeJl7gzO/OV7lezKQJN7vguYRkEPr20mRSMZ0
 xOWghhDwCN0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="180882293"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; d="scan'208";a="180882293"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 06:51:33 -0700
IronPort-SDR: mR2L3z5zRXJ1Bt62W7wINSWAeyfZtQR1B3LD07WUocKjfA0aHsZtw8lAaOq9NFrZdfsAQBxVR9
 deKYSIdv8YcQ==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; d="scan'208";a="385535258"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 06:51:33 -0700
Date: Thu, 1 Oct 2020 06:51:32 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [Patch V8 0/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <20201001135132.GA32553@otc-nc-03>
References: <20200925190620.18732-1-ashok.raj@intel.com>
 <20201001125841.GF30426@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201001125841.GF30426@8bytes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

On Thu, Oct 01, 2020 at 02:58:41PM +0200, Joerg Roedel wrote:
> Hi Ashok,
> 
> On Fri, Sep 25, 2020 at 12:06:17PM -0700, Ashok Raj wrote:
> > Sai Praneeth Prakhya (3):
> >   iommu: Add support to change default domain of an iommu group
> >   iommu: Take lock before reading iommu group default domain type
> >   iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file
> > 
> >  .../ABI/testing/sysfs-kernel-iommu_groups          |  30 +++
> >  drivers/iommu/iommu.c                              | 227 ++++++++++++++++++++-
> >  2 files changed, 256 insertions(+), 1 deletion(-)
> 
> Thanks for the repost, I can grab it just fine with b4. But this nees
> some more testing on my side and some time in linux-next, so it is too
> late now to queue it for v5.10. Can you please remind me after the next
> merge window? I'll pick it up then and do the testing and it will
> hopefully spend enough time in linux-next.

Yes, I'll try to remind you after the next merge window.

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
