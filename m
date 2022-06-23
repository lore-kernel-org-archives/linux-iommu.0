Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3508DC43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 07:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9CC5340123;
	Thu, 23 Jun 2022 07:54:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CC5340123
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LcN_kHNORlut; Thu, 23 Jun 2022 07:54:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 666AF4051D;
	Thu, 23 Jun 2022 07:54:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 666AF4051D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48700C0039;
	Thu, 23 Jun 2022 07:54:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B6CDC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1035261356
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:54:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1035261356
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hbs7yDOFMk04 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 07:54:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EF5B6102A
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EF5B6102A
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:54:56 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9F887447; Thu, 23 Jun 2022 09:54:54 +0200 (CEST)
Date: Thu, 23 Jun 2022 09:54:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
Message-ID: <YrQcTUuGtav+ueTe@8bytes.org>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
Cc: iommu@lists.linux-foundation.org
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

Hi Vasant,

On Wed, May 11, 2022 at 12:51:06PM +0530, Vasant Hegde wrote:
>  .../admin-guide/kernel-parameters.txt         |  34 +-
>  drivers/iommu/amd/amd_iommu.h                 |  13 +-
>  drivers/iommu/amd/amd_iommu_types.h           | 133 +++-
>  drivers/iommu/amd/init.c                      | 687 +++++++++++-------
>  drivers/iommu/amd/iommu.c                     | 563 ++++++++------
>  drivers/iommu/amd/iommu_v2.c                  |  67 +-
>  drivers/iommu/amd/quirks.c                    |   4 +-
>  7 files changed, 904 insertions(+), 597 deletions(-)

So this is applied now to the IOMMU tree, thanks for the work. Something
that bothered me while looking at this was the almost complete lack of
locking while accessing the global data structures. Some of them are
lock-less, so it is partially fine, and most of them are used read-only
during system runtime. But I would appreciate if you and/or Suravee
could look over that again and check again if there needs to be more
locking.

The current situation will fire back at the point where you want to
implement IOMMU hotplug. Note that device hotplug is already possible
today, either with real devices or SR-IOV.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
