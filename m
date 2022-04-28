Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8237C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 10:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 552A182BA7;
	Thu, 28 Apr 2022 10:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ILwCjgRzp5kE; Thu, 28 Apr 2022 10:14:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C7848175A;
	Thu, 28 Apr 2022 10:14:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EA6AC0032;
	Thu, 28 Apr 2022 10:14:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E428CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 10:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC909400C1
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 10:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1xP5v4yXJ2-d for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 10:14:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CC9440012
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 10:14:55 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 31A9D374; Thu, 28 Apr 2022 12:14:53 +0200 (CEST)
Date: Thu, 28 Apr 2022 12:14:52 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 11/37] iommu/amd: Introduce per PCI segment device
 table size
Message-ID: <YmppHMqpN08yxdFs@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-12-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220425113415.24087-12-vasant.hegde@amd.com>
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

On Mon, Apr 25, 2022 at 05:03:49PM +0530, Vasant Hegde wrote:
> +	/* Size of the device table */
> +	u32 dev_table_size;

Same here and with all other size indicators. If they are always going
to have their maximum value anyways, we can drop them.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
