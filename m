Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14380C432C2
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 05:46:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CDA207FF
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 05:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CDA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BA15F40B;
	Thu, 26 Sep 2019 05:46:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 95EAC3EE
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 05:46:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0FF468A
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 05:46:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id C3359447; Thu, 26 Sep 2019 07:46:51 +0200 (CEST)
Date: Thu, 26 Sep 2019 07:46:51 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH 0/6] iommu/amd: Locking Fixes
Message-ID: <20190926054651.GD4643@8bytes.org>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190926002515.3xjm3fb6z42dfhar@cantor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190926002515.3xjm3fb6z42dfhar@cantor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Filippo Sironi <sironi@amazon.de>, iommu@lists.linux-foundation.org,
	jroedel@suse.de
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

Hi Jerry,

On Wed, Sep 25, 2019 at 05:25:15PM -0700, Jerry Snitselaar wrote:
> On Wed Sep 25 19, Joerg Roedel wrote:
> > Joerg Roedel (6):
> >  iommu/amd: Remove domain->updated
> >  iommu/amd: Remove amd_iommu_devtable_lock
> >  iommu/amd: Take domain->lock for complete attach/detach path
> >  iommu/amd: Check for busy devices earlier in attach_device()
> >  iommu/amd: Lock dev_data in attach/detach code paths
> >  iommu/amd: Lock code paths traversing protection_domain->dev_list
> > 
> > drivers/iommu/amd_iommu.c       | 166 ++++++++++++++++----------------
> > drivers/iommu/amd_iommu_types.h |   4 +-
> > 2 files changed, 85 insertions(+), 85 deletions(-)
> 
> What branch is this on top of in your repo?

This is on-top of my iommu/fixes branch in the iommu-tree.

HTH,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
