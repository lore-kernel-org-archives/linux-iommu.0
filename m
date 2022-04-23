Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6D3C433FE
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 05:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E51141C6C;
	Sat, 23 Apr 2022 05:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e056-P7R8y66; Sat, 23 Apr 2022 05:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B3CA41C67;
	Sat, 23 Apr 2022 05:14:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFC90C0039;
	Sat, 23 Apr 2022 05:14:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5517C002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 05:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E18740242
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 05:14:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5d5IsQHd7jxr for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 05:14:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 304C74012E
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 05:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=u4JtFCq+KhE1NWmHJFTGoIgxVTQAJnln2oyi+cNip2U=; b=o2G32xQoAunS3XeRbIXIPCi+Tn
 NTVakwVpG3T2ytZB8EQ2I9S6cP0FQXw/Gjwb/qN1hwVo4lS2fVlTGSuVlzkhaysbTUnTkZVshbIUp
 0aMbzylEtEYIzcyZ+54AgXhP9P7nkqwD8RyDKdI8LWSKSQkviARvxSQ+S/bzeaHIraRTYKiN71K9T
 qMpSPXsckHKo3P4huFIMrGUhVpqNJpjnsMcmEH+ULxJtQcjmHr8/Wl/Ro70WiMxwdYKIEkoZeeWEI
 qNovEAVRNk+3MI0r6o8ZK3RgIcEaGe8yke0gVfTNqmq9wvY+HS/lw1kcZ8eg5peqJ2MPH37rgXyR5
 WTdnGq4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ni85q-003SMm-Dr; Sat, 23 Apr 2022 05:14:02 +0000
Date: Fri, 22 Apr 2022 22:14:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v11 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Message-ID: <YmOLGsaMa7hCjMzx@infradead.org>
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
 <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
 <03e94ba9-f558-954f-e84b-cd8a9e693aea@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03e94ba9-f558-954f-e84b-cd8a9e693aea@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
 guohanjun@huawei.com, Sami.Mujawar@arm.com, robin.murphy@arm.com,
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

On Sat, Apr 23, 2022 at 10:04:39AM +0800, Lu Baolu wrote:
> The generic_iommu_put_resv_regions() itself is a callback. Why bothering
> adding another callback from the same iommu driver in it? Or, you are
> going to remove the put_resv_regions from the iommu ops?

It is a driver method, but these reserved entries are not actually
allocated by the driver.  And I do have a patch pending removing this
driver method that should never have been a driver method, check
the iomm list archives for

    iommu: remove the put_resv_regions method

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
