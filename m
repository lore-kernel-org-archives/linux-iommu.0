Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC6FC2BA2B
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 07:29:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4714B206D5
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 07:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQMTfiSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4714B206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 48A4E2013C;
	Thu, 16 Apr 2020 07:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lq98JSiL6ViG; Thu, 16 Apr 2020 07:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 784CE2036D;
	Thu, 16 Apr 2020 07:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A9CAC089E;
	Thu, 16 Apr 2020 07:29:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D50C3C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 07:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D0F498471C
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 07:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8SBuM1pnwRb7 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 07:28:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 84C968401E
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 07:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jphD0QxUkx58Leqoht9un+IW160yDSl4a16sN6p0wp0=; b=ZQMTfiSf0WNZaROzM2Vhq2JZIW
 flXWEldz7UFTJIRSqBk3edg5nQSUF6LsWtPN+mawKB4PsOsdkxYadKG8t1s+1HIyvjGViM+/4u9XJ
 sgPwv3FT/YG+CfgsVteNEl5xbrhxqk9RuXFgnRaUgaEUWVkwUoI4/jt/bXvBlrJVdXXG3LOUI7axo
 EZJxFj7JnlE9kwMDzkbS/YdTknhS9MaRxElQ9Zw+X7NQaTkjHzqWCOaA3K7u8MzLxFSeFj+5JpGfy
 g45mkULRGMxSAE63aQiVISOPNMz3DDBt98u/jefGfgi26MakebbHZn+tDgCIHIRaECC9QSl/RRB5L
 zV3sruZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jOyxA-00058d-St; Thu, 16 Apr 2020 07:28:52 +0000
Date: Thu, 16 Apr 2020 00:28:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200416072852.GA32000@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200414170252.714402-3-jean-philippe@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
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

> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> +				       start, end - start);
> +	rcu_read_unlock();
> +}

What is the reason that the devices don't register their own notifiers?
This kinds of multiplexing is always rather messy, and you do it for
all the methods.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
