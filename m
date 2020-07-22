Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5BFC433E1
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 13:52:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083722071A
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 13:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083722071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B661B2046C;
	Wed, 22 Jul 2020 13:52:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DiTL0cBec1Jb; Wed, 22 Jul 2020 13:52:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 14308203A0;
	Wed, 22 Jul 2020 13:52:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1EBAC004D;
	Wed, 22 Jul 2020 13:52:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0A60C004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 13:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9D404878A4
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 13:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3NvE-bjVzDiS for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 13:52:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1488987820
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 13:52:48 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 207A62C8; Wed, 22 Jul 2020 15:52:45 +0200 (CEST)
Date: Wed, 22 Jul 2020 15:52:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH V4 1/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <20200722135244.GH27672@8bytes.org>
References: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
 <3d7f5cf067437593e681751108860ea692bb10b1.1591290586.git.sai.praneeth.prakhya@intel.com>
 <20200630091601.GB28824@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573D8042@ORSMSX114.amr.corp.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F573DB164@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F573DB164@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will.deacon@arm.com>, "Raj, Ashok" <ashok.raj@intel.com>,
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

On Tue, Jul 14, 2020 at 06:23:54PM +0000, Prakhya, Sai Praneeth wrote:
> Q1:
> > Presently, iommu_change_dev_def_domain() checks if the iommu group still has
> > only one device or not. Hence, checking if iommu group has one device or not is
> > done twice, once before taking device_lock() and the other, after taking
> > device_lock().
> > 
> > I agree that the code isn't checking if the iommu group still has the _same_
> > device or not.
> > One way, I could think of doing it is by storing "dev" temporarily and checking
> > for it.
> > Do you think that's ok? Or would you rather suggest something else?

That sounds reasonable, get the device from the group, lock it, take
group->mutex, and check whether the same device is still alone in the
group.


> Q2:
> > The reason for taking iommu_group->mutex in the beginning of
> > iommu_change_dev_def_domain() is that the function
> > 
> > 1. Checks if the group is being directly used by user level drivers (i.e. if (group-
> > >default_domain != group->domain))
> > 
> > 2. Uses iommu_ops
> > (prev_dom = group->default_domain;
> > if (!prev_dom || !prev_dom->ops || !prev_dom->ops->def_domain_type))
> > 
> > 3. Sets iomu_group->domain to iommu_group->default_domain
> > 
> > I wanted to make sure that iommu_group->domain and iommu_group-
> > >default_domain aren't changed by some other thread while this thread is
> > working on it. So, please let me know if I misunderstood something.

This looks correct as well.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
