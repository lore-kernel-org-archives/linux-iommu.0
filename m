Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE15C0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:53:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9762051A
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FA/FOpOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9762051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 095EF8846C;
	Mon, 16 Mar 2020 15:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NWr55OEbkjVI; Mon, 16 Mar 2020 15:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8EBCF8844B;
	Mon, 16 Mar 2020 15:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BCC0C1D7C;
	Mon, 16 Mar 2020 15:53:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36A4DC013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 31DE4872DF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYIFaN9VbEcw for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:53:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C5E1E872C6
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=x8zdJsqd2TuNRvG2kYCqg4zk6EDgjEiGz4509vOWtU8=; b=FA/FOpOag848GQSEBQ39K+RPIr
 9956vGJi4GNnoM3CPyi3prUgjsfDzWYxfhWPrEzaQj/rFRNAD9zq1IITPXTwzagEy9lnefAJd7DSJ
 W3KfRAjQvGATQKacCOT/0KfBw7e2HTV8jM2oJBtJ/dbpjOpInzeh3k6IW9XxpGiGZXU2/vWBdZesP
 q1MJ34whatk74l8N2FmnP8fqGP2HB1kfsuArONClwjvLoSPDmei22GMspaIZ5q58OBvnBGK6fv2Yy
 Mb1xGXkAFhp13x7aayyQdXgis/+JpPg/gq9rgg9nE0ajHVJ7TmRvTS94IAPfasGDNgMyd5Hk/176N
 UsBqgbtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jDs3A-0005ro-Nm; Mon, 16 Mar 2020 15:53:08 +0000
Date: Mon, 16 Mar 2020 08:53:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Ignore devices with out-of-spec domain
 number
Message-ID: <20200316155308.GC18704@infradead.org>
References: <20200312060955.8523-1-baolu.lu@linux.intel.com>
 <20200312060955.8523-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200312060955.8523-3-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Drake <drake@endlessm.com>
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

On Thu, Mar 12, 2020 at 02:09:55PM +0800, Lu Baolu wrote:
> @@ -128,6 +129,13 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
>  
>  	BUG_ON(dev->is_virtfn);
>  
> +	/*
> +	 * Ignore devices that have a domain number higher than what can
> +	 * be looked up in DMAR, e.g. VMD subdevices with domain 0x10000
> +	 */
> +	if (pci_domain_nr(dev->bus) > U16_MAX)

I think this needs a well documented core PCI layer function, as that
is where these "fake" domains are create.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
