Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A71C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 08:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A62D34026E;
	Mon, 14 Feb 2022 08:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVDyd_H8eQQH; Mon, 14 Feb 2022 08:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 514E44019E;
	Mon, 14 Feb 2022 08:19:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DFB1C0011;
	Mon, 14 Feb 2022 08:19:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51BD9C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 08:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E1F54024F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 08:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bc0N3lE9DYx5 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:19:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0E374023C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 08:19:23 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 38CEE68AA6; Mon, 14 Feb 2022 09:19:19 +0100 (CET)
Date: Mon, 14 Feb 2022 09:19:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Message-ID: <20220214081919.GA18337@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220209122302.213882-2-ltykernel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, hch@lst.de,
 hch@infradead.org, wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com
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

Adding a function to set the flag doesn't really change much.  As Robin
pointed out last time you should fine a way to just call
swiotlb_init_with_tbl directly with the memory allocated the way you
like it.  Or given that we have quite a few of these trusted hypervisor
schemes maybe add an argument to swiotlb_init that specifies how to
allocate the memory.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
