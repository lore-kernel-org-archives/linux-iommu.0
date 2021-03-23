Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B67C433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 17:31:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CDF619C3
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 17:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CDF619C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1208C83F78;
	Tue, 23 Mar 2021 17:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ydYCFP_dVU0r; Tue, 23 Mar 2021 17:31:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11E0583F83;
	Tue, 23 Mar 2021 17:31:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDA5DC000A;
	Tue, 23 Mar 2021 17:31:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76D49C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 17:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6578983F8D
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 17:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DN5CczQHIzDE for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 17:31:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABB0883F80
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=A2jfbE86gmwbDsty01sEM1uPP2
 p5EQ+agBKw+qhZhVcZ12QwNZ9MWVwRWuFXo9CRwUqmAFh+W/ZqjxBZ+ufmx0n7dDIQ8/m2m+nEyjL
 1Qlenw9wmEqU1Nviz60Wlak5hPbJLaDpzfYazZJufS19xrAR/w2vzgwNmHwKgl5WEXRw+pcMana3N
 7FTIQM/TaRlyZOAD8qC9OwHna5orEUyvW7uMyu2XMUSOXDPmOAMe7vmOJhSrR7WQnIjnQGfXhWrPO
 IR4r0ouWX43WJ5gCqxafaac++9pCV7HDgIdhUFF4oYKRy2NkiCb64F8OYOvv8m6KEx5IonnkacXk9
 U1x8wjtQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lOkqA-00ALJ4-2L; Tue, 23 Mar 2021 17:29:34 +0000
Date: Tue, 23 Mar 2021 17:29:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove svm_dev_ops
Message-ID: <20210323172914.GC2463754@infradead.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
 <20210323010600.678627-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323010600.678627-3-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Will Deacon <will@kernel.org>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
