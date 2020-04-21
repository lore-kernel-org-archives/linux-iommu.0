Return-Path: <SRS0=U628=6F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3608C55181
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 08:55:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD8E206E9
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 08:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LLXaj31F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD8E206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7838B228AE;
	Tue, 21 Apr 2020 08:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id upieD8Gl8Ybw; Tue, 21 Apr 2020 08:55:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0B8520527;
	Tue, 21 Apr 2020 08:55:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93954C1797;
	Tue, 21 Apr 2020 08:55:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 584F6C0175
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 08:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4BE9320527
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 08:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L8LApiBua68f for <iommu@lists.linux-foundation.org>;
 Tue, 21 Apr 2020 08:55:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by silver.osuosl.org (Postfix) with ESMTPS id 67CA72094B
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 08:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TpKuw/piS7tkOzNHb5163BQiSydgsqXnGL17Bi9pIXc=; b=LLXaj31F1SppFy6MghvYaRRE1+
 QqN2HC2nMR5iG9DkLgeCfPVGYcB4g4jeeLucL7dv26bQ8SVNgS3U9esD3F2Ge10NEC1XL8P1AvKUV
 Kx5PxSvAsln7Q5hWK6bySudtYQ3j1gReRrxf2EAFELegUA1Kmq2/+xUd9WUjMxkpNOueRqf3LyXuI
 HHvGbluS5RXGfgaXsdlFNN1aPeqMVrTJrYubQJ+gCQSB6JA0J1l2NrpGO6h7eyBbxJ0hkYbzdKY3Q
 6VKqB4BS0aoY1WQQgGz2pa/GMrSRSy40hCXicGCzTViwqYOBDw8NG3bdMKvluYftNIYbak9jqL9uu
 TriHhV6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jQogf-0005Gs-NA; Tue, 21 Apr 2020 08:55:25 +0000
Date: Tue, 21 Apr 2020 01:55:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200421085525.GA6900@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica> <20200420135727.GO26002@ziepe.ca>
 <20200420104850.60531cb6@jacob-builder>
 <20200420181437.GA229170@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200420181437.GA229170@romley-ivt3.sc.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, "Raj,
 Ashok" <ashok.raj@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, christian.koenig@amd.com,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Apr 20, 2020 at 11:14:37AM -0700, Fenghua Yu wrote:
> > Agreed, perhaps Fenghua can consider that in his patchset. It would
> > help align life cycles as well.
> > https://lkml.org/lkml/2020/3/30/910>
> 
> Seems we depend on each other: my patch defines pasid in mm_struct.
> I can free PASID in your detach() function.

Looks like this should go into the same series.  I also don't see any
good reason to have the pasid in the x86-specific context vs the common
mm_struct.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
