Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6CFC433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 11:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30260405E0;
	Mon, 14 Feb 2022 11:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qWZq5ogG0p7s; Mon, 14 Feb 2022 11:53:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C27A140472;
	Mon, 14 Feb 2022 11:53:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99B49C0021;
	Mon, 14 Feb 2022 11:53:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3129C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAD3F4018C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ANHtbFQRKAQL for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 11:52:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 191084016D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:52:57 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BE7412FB; Mon, 14 Feb 2022 12:52:54 +0100 (CET)
Date: Mon, 14 Feb 2022 12:52:53 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix I/O page table memory leak
Message-ID: <YgpClRRdOR/1DXJE@8bytes.org>
References: <20220210154745.11524-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220210154745.11524-1-suravee.suthikulpanit@amd.com>
Cc: wei.huang2@amd.com, terry.bowman@amd.com, Jon.Grimm@amd.com,
 linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
 iommu@lists.linux-foundation.org
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

On Thu, Feb 10, 2022 at 09:47:45AM -0600, Suravee Suthikulpanit wrote:
> The current logic updates the I/O page table mode for the domain
> before calling the logic to free memory used for the page table.
> This results in IOMMU page table memory leak, and can be observed
> when launching VM w/ pass-through devices.
> 
> Fix by freeing the memory used for page table before updating the mode.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Reported-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Tested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Fixes: e42ba0633064 ("iommu/amd: Restructure code for freeing page table")
> Link: https://lore.kernel.org/all/20220118194720.urjgi73b7c3tq2o6@oracle.com/
> ---
>  drivers/iommu/amd/io_pgtable.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
