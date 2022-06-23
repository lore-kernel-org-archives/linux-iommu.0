Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D880EC43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 11:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66C3384758;
	Thu, 23 Jun 2022 11:30:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66C3384758
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SGbXHJKKp2cM; Thu, 23 Jun 2022 11:30:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 220F58475A;
	Thu, 23 Jun 2022 11:30:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 220F58475A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDC88C0039;
	Thu, 23 Jun 2022 11:30:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DE76C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 11:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44B53613DB
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 11:30:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44B53613DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3hVJ1zqnO40Z for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 11:30:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A6BE60E66
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A6BE60E66
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 11:30:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B64474D2; Thu, 23 Jun 2022 13:30:37 +0200 (CEST)
Date: Thu, 23 Jun 2022 13:30:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 3/7] iommu/amd: Fix sparse warning
Message-ID: <YrRO21AvsFioAROB@8bytes.org>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <20220603112107.8603-4-vasant.hegde@amd.com>
 <YrQeXdR8yPOyv957@8bytes.org>
 <82767d0d-a04b-4432-0e7e-77bcca095e09@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82767d0d-a04b-4432-0e7e-77bcca095e09@arm.com>
Cc: iommu@lists.linux-foundation.org, Vasant Hegde <vasant.hegde@amd.com>
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

On Thu, Jun 23, 2022 at 10:42:52AM +0100, Robin Murphy wrote:
> TBH it's probably time to retire iommu_ops->pgsize_bitmap anyway. At the
> very least it would be logical to move it to iommu_domain_ops now, but maybe
> we could skip ahead and just rely on drivers initialising
> domain->pgsize_bitmap directly in their .domain_alloc?
> 
> (and FWIW I'm leaning towards the same for the domain->ops as well; the more
> I look at ops->default_domain_ops, the more it starts looking like a stupid
> mess... my stupid mess... sorry about that)

Good idea, that would be even better.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
