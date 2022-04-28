Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6298C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 09:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8051A41A5E;
	Thu, 28 Apr 2022 09:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2uwm8TKo-7uZ; Thu, 28 Apr 2022 09:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 38C6041A51;
	Thu, 28 Apr 2022 09:55:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11724C0039;
	Thu, 28 Apr 2022 09:55:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0769C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9053A60E2B
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c8JItZhqWBjv for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:55:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07A4C60D89
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:55:48 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id E22FF2FB; Thu, 28 Apr 2022 11:55:46 +0200 (CEST)
Date: Thu, 28 Apr 2022 11:55:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 01/37] iommu/amd: Update struct iommu_dev_data
 defination
Message-ID: <YmpkoYbwu0g4+BAA@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-2-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220425113415.24087-2-vasant.hegde@amd.com>
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

On Mon, Apr 25, 2022 at 05:03:39PM +0530, Vasant Hegde wrote:

Subject: iommu/amd: Update struct iommu_dev_data defination
                                                 ^^^^^^^^^^ Typo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
