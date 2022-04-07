Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C02BC433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 13:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3881E61208;
	Thu,  7 Apr 2022 13:28:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sdOYf6X0JLqd; Thu,  7 Apr 2022 13:28:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1020E61216;
	Thu,  7 Apr 2022 13:28:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA29CC002C;
	Thu,  7 Apr 2022 13:28:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB0BC0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE09C61216
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jmra5-a6rzbg for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 13:28:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E13661208
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WXMXF9kTfNByY6iB1S9IPFjIYZPUguzDj/Fd9M8O6GQ=; b=hfsYuBCTQR2kUqLL08ZDAMLkKI
 xOS2Smt2JxMOzsBm4Cj3Xd1TuoOo5JqDLDh6GkEQRT9ejahjJ3gzXMPRBF9u42R8epj99Oiqj/lMs
 FshlyVYurXZ1aj3cnQk6Jo2MiKokkjHrJUoRKBX8GCXjISeu2s33uUiHpuRuIL2vxoJ8dBHqdCn5B
 qHiGvdkX7W16zh4tY0qg8WMrSGkQYWoMPb3wUrOxtWh+Mc4o/2QLAJvJsN8eWA0l4cj+d0TsmQ1oz
 Eo5KRcq3nKQhfw54ZPv3M8FXeCAzIycDXfVuM6PFTBLb6i2dKFVoA6AVM0qF3J0FlOpgzmKTRZV4t
 Z669NKpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ncSBO-00C8Ri-Az; Thu, 07 Apr 2022 13:28:18 +0000
Date: Thu, 7 Apr 2022 06:28:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <Yk7m8oDPtusDzReK@infradead.org>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

> +static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)

Overly long line.

>  void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list)
>  {
> +	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> +		iort_iommu_put_resv_regions(dev, list);
> +
>  	generic_iommu_put_resv_regions(dev, list);
>  }

Why can't this just go into generic_iommu_put_resv_regions?  The idea
that the iommu low-level drivers need to call into dma-iommu which is
a consumer of the IOMMU API is odd.  Especially if that just calls out
to ACPI code and generic IOMMU code only anyway.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
