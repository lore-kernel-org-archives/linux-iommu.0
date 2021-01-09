Return-Path: <SRS0=vLlZ=GM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC0C433DB
	for <iommu@archiver.kernel.org>; Sat,  9 Jan 2021 09:10:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6959623A3A
	for <iommu@archiver.kernel.org>; Sat,  9 Jan 2021 09:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6959623A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08A4D874FA;
	Sat,  9 Jan 2021 09:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7yuB1S0i5Nns; Sat,  9 Jan 2021 09:10:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6AA6287492;
	Sat,  9 Jan 2021 09:10:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55390C088B;
	Sat,  9 Jan 2021 09:10:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23DF8C013A
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 09:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1918787492
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 09:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IAb7av93CYKc for <iommu@lists.linux-foundation.org>;
 Sat,  9 Jan 2021 09:10:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3C38287488
 for <iommu@lists.linux-foundation.org>; Sat,  9 Jan 2021 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oeFR1Ii2CLZIpiUQWYmQLIKPyDt1VC2/pWydszGRV/w=; b=LZxbf1Efb3bNU7b+f5f15xvaOt
 5j8L4J6R20ULrZTWXMp995e6CIY8qhN5/UNIpjjazBeK1xklHU6LrNVlmSt6v/xfKybx1v4GYDFMz
 AeW1ev7pb/Ite4VrBB4vFJv+3ccGeh/LbCyq3+S/LtBYm0Y2L+QgLK+G7HWDw5HcDw3TdzsfjM9xg
 jOb8TyUE4Q9vw1/URTs9QuSQIZD7EScVjVS3kJIdRI2ApeYw/qyfuHGMlF89RamJtZU6XutAegeTs
 ybYHZLyLjjsCCEMGTu6N5JU6oQt04R7fMrNRVkb+e0IlIB09hLfa7dXDpd58s//qRDrGGvArlLTaF
 RA+xHLqA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1kyAFN-000Odv-OC; Sat, 09 Jan 2021 09:09:26 +0000
Date: Sat, 9 Jan 2021 09:09:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 6/6] iommu: Delete iommu_dev_has_feature()
Message-ID: <20210109090921.GA93456@infradead.org>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
 <1609940111-28563-7-git-send-email-john.garry@huawei.com>
 <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: will@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Thu, Jan 07, 2021 at 09:18:06AM +0800, Lu Baolu wrote:
> The typical use case is
> 
>         if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
>                 rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_AUX);
>                 if (rc < 0) {
>                         dev_warn(dev, "Failed to enable aux-domain: %d\n",
> rc);
>                         return rc;
>                 }
>         }
> 
> So please don't remove it.

This doesn't have an upstream user, and did not have for years!  If
new users show up they can add it back.  Note that the above API with
a separate has vs enable is horrible anyway - the right way is to just
enable and fail it with a specific error code if not supported.

We have a general rule that APIs should only be introduced with their
users, and this example just confirms the reasons of why that rule is in
place once again.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
