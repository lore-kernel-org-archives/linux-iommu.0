Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CCC4346E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 08:28:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C85B2376F
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 08:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C85B2376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 29138874CF;
	Thu, 24 Sep 2020 08:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7OPvxgJMy2EI; Thu, 24 Sep 2020 08:28:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F19DF874BF;
	Thu, 24 Sep 2020 08:28:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA6C4C0889;
	Thu, 24 Sep 2020 08:28:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC603C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BF1922E0DA
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:28:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W57LSpxJ7Nay for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:28:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 979CD2DFF8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:28:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9CBAC295; Thu, 24 Sep 2020 10:28:36 +0200 (CEST)
Date: Thu, 24 Sep 2020 10:28:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: IOVA allocation dependency between firmware buffer and remaining
 buffers
Message-ID: <20200924082830.GB27174@8bytes.org>
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
 <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
 <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
 <CGME20200424161534eucas1p29177cad5b4790d392acb69a335a3992e@eucas1p2.samsung.com>
 <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
 <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, will@kernel.org, linux-mm@kvack.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Ajay kumar <ajaynumb@gmail.com>,
 Shaik Ameer Basha <shaik.ameer@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, hch@lst.de
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

On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
> It allows to remap given buffer at the specific IOVA address, although 
> it doesn't guarantee that those specific addresses won't be later used 
> by the IOVA allocator. Probably it would make sense to add an API for 
> generic IOMMU-DMA framework to mark the given IOVA range as 
> reserved/unused to protect them.

There is an API for that, the IOMMU driver can return IOVA reserved
regions per device and the IOMMU core code will take care of mapping
these regions and reserving them in the IOVA allocator, so that
DMA-IOMMU code will not use it for allocations.

Have a look at the iommu_ops->get_resv_regions() and
iommu_ops->put_resv_regions().

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
