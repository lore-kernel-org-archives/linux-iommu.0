Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9AFC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 09:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6959A41078;
	Tue, 19 Apr 2022 09:04:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o4UdelgdPVas; Tue, 19 Apr 2022 09:04:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37BAA41077;
	Tue, 19 Apr 2022 09:04:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09475C002F;
	Tue, 19 Apr 2022 09:04:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 524E8C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 09:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28C2F83FFC
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 09:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g07bxNjficom for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 09:04:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D391183FFB
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QWoz5w92bsn0XGI4LeiFcttEdCIBZSDFKXBIU0wXer4=; b=BIzQRnisGfTGDfL97WMA3PzLmc
 xsDJTaLV0nKgzVAu11WPScdZwynMwIualnkmCLH3RYwFx1g/L9p4X1cBVHxy2TDjvxDZ/2PMg0BQn
 hA53WFBIauHqH1rAgstK/5Bo5Itkxv/lLD3oSVZkogndd58/9KzLJmN5NNRXwB6+TJBKxrvfwsw/m
 mnD/WGhJMO3Am8hW5hQqwgpa20fZD6JDsyt+4k5cw8a4olQbFbseHYmSTxYVqNb84Xu9ejpzYUFJu
 +QgBMw7oLphyHLQnTsXCNdTSDPFsgvsANBK6hYxaid9YkmHLawdVXuVhi/mH++qYaApcdAzT2pogp
 2rsJ2BAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ngjmw-002Txg-KW; Tue, 19 Apr 2022 09:04:46 +0000
Date: Tue, 19 Apr 2022 02:04:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <Yl57LuiR0JC4AZrw@infradead.org>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
 <Yk7m8oDPtusDzReK@infradead.org>
 <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
 <Yk7uRPG1TwGFPbyY@infradead.org>
 <955601f02f3b474da3327963fb1630f0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <955601f02f3b474da3327963fb1630f0@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "will@kernel.org" <will@kernel.org>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Tue, Apr 19, 2022 at 08:31:55AM +0000, Shameerali Kolothum Thodi via iommu wrote:
> Sorry for the delayed response(was on holidays). So if we move the
> iommu_dma_put_resv_region() call to generic_iommu_put_resv_regions() ,
> will that address the concerns here?
> 
> I think it will resolve the issue in 05/11 as well pointed out by Christoph
> where we end up not releasing reserved regions when
> CONFIG_IOMMU_DMA is not set.

As Robin pointed out we might not really deduct that ACPI means RMR.

I suspect the best would be to just attach a free callback to the
regions.  Either by adding it directly to struct iommu_resv_region
if we thing there are few enough regions to not be worried about
the memory use, or other by adding a container struct for the list_head
that contains the free callback.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
