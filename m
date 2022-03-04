Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C404C433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 18:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B41EB40516;
	Fri,  4 Mar 2022 18:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id esPvQxdjt3L1; Fri,  4 Mar 2022 18:49:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4EAB740153;
	Fri,  4 Mar 2022 18:49:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26DE7C0012;
	Fri,  4 Mar 2022 18:49:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE3D4C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 18:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9CDD841A1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 18:49:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sxM5pRIqIynk for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 18:49:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F5F88419E
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vdCOfW9AA5pXpyysIv5oA6baxsdWJvIveo/FjSSwSb0=; b=OF7MGL/zQ7Zt2b8OOThljpYjTW
 ty2cu1wmG4x8JrCx4Qifj7YhWqJ6gt3qL2jRDZ2IrYkpR+FzNwOa2NL/uj2Ky7W0ps22YwLUHlanH
 EoMI6jlstrEUYM2l11LatKIp0GzBPwEO64nOYC1t1tmRTFPkWFiOGynAkLcvIk0n1A+M9KaX3CUQG
 82guEbNFyGF4Lqg9A5yRaHMCmcpcsCWJzpAJV6+RIDkkdJ+o+FvnS4QhS3AZY4xk2167Hv/K8Nbwb
 2Iln+dud1D8cD3q0rbyODLqsA8Q0wJhtUUccipr2ax2e88ISa7a0touBwuCfSThUagQqGrVgdXePM
 tFpLSabg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nQCzE-00CtOx-Bj; Fri, 04 Mar 2022 18:49:08 +0000
Date: Fri, 4 Mar 2022 18:49:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] swiotlb: rework fix info leak with DMA_FROM_DEVICE
Message-ID: <YiJfJEo4xvq/YIZW@casper.infradead.org>
References: <20220304135859.3521513-1-pasic@linux.ibm.com>
 <YiI2DPIrNLKwanZw@infradead.org>
 <20220304172908.43ab261d.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220304172908.43ab261d.pasic@linux.ibm.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-doc@vger.kernel.org,
 stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Doug Gilbert <dgilbert@interlog.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

On Fri, Mar 04, 2022 at 05:29:08PM +0100, Halil Pasic wrote:
> No problem, I can do that. It isn't hard to squash things together, but
> when I was about to write the commit message, I had the feeling doing
> a revert is cleaner.
> 
> Any other opinions?

One patch, not two.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
