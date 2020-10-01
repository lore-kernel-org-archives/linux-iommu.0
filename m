Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1DBC4727C
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 12:58:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307C62075F
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 12:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307C62075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B5385204B0;
	Thu,  1 Oct 2020 12:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yz2ibiJBxQ4v; Thu,  1 Oct 2020 12:58:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2DB982049B;
	Thu,  1 Oct 2020 12:58:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A77BC0889;
	Thu,  1 Oct 2020 12:58:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8F52C0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 12:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9A706204A9
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 12:58:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uc8nZIZY3BHJ for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 12:58:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id EF6C42049B
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 12:58:43 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8451526F; Thu,  1 Oct 2020 14:58:42 +0200 (CEST)
Date: Thu, 1 Oct 2020 14:58:41 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V8 0/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <20201001125841.GF30426@8bytes.org>
References: <20200925190620.18732-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925190620.18732-1-ashok.raj@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Ashok,

On Fri, Sep 25, 2020 at 12:06:17PM -0700, Ashok Raj wrote:
> Sai Praneeth Prakhya (3):
>   iommu: Add support to change default domain of an iommu group
>   iommu: Take lock before reading iommu group default domain type
>   iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file
> 
>  .../ABI/testing/sysfs-kernel-iommu_groups          |  30 +++
>  drivers/iommu/iommu.c                              | 227 ++++++++++++++++++++-
>  2 files changed, 256 insertions(+), 1 deletion(-)

Thanks for the repost, I can grab it just fine with b4. But this nees
some more testing on my side and some time in linux-next, so it is too
late now to queue it for v5.10. Can you please remind me after the next
merge window? I'll pick it up then and do the testing and it will
hopefully spend enough time in linux-next.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
