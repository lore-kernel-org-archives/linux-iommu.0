Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F65C433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6936860E99;
	Tue,  4 Jan 2022 15:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bkn5mbbtJ-XE; Tue,  4 Jan 2022 15:03:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 542C060BFF;
	Tue,  4 Jan 2022 15:03:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24AB3C0030;
	Tue,  4 Jan 2022 15:03:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 027C2C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC78760E21
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJos8BIutYQZ for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:03:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2B3E60BFF
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:03:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B659568AFE; Tue,  4 Jan 2022 16:03:07 +0100 (CET)
Date: Tue, 4 Jan 2022 16:03:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap()
 in the swiotlb_mem_remap()
Message-ID: <20220104150307.GA23792@lst.de>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
 <YdKrxgnpT0Dc0t2T@infradead.org>
 <20220104145155.hm7j5byhddn4zhb2@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104145155.hm7j5byhddn4zhb2@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: parri.andrea@gmail.com, michael.h.kelley@microsoft.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, kernel test robot <lkp@intel.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 Tianyu Lan <ltykernel@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, vkuznets@redhat.com, kys@microsoft.com,
 robin.murphy@arm.com, hch@lst.de
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

On Tue, Jan 04, 2022 at 02:51:55PM +0000, Wei Liu wrote:
> > Please stub out all of swiotlb_mem_remap instead of the ifdef inside the
> > function.
> 
> Does this look okay to you?

Yes, thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
