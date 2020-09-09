Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690BFC433E2
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 07:06:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9C821532
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 07:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QWCA9gPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9C821532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C33052E11D;
	Wed,  9 Sep 2020 07:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eQ38X0tlQG6t; Wed,  9 Sep 2020 07:06:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 44ED5204B5;
	Wed,  9 Sep 2020 07:06:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30BA3C0052;
	Wed,  9 Sep 2020 07:06:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25F2CC0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 07:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1FEA986DAE
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 07:06:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cVAQoUQDTenF for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 07:06:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2F1DF86D9C
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hCw8xGdlNdOCLWn3JTGudEyCmE42OPi648sQ0UReuL4=; b=QWCA9gPZCZ3wzIlKZV6poclcFq
 LzfIY4lmnE8VjlKQlNvIxOZhHe41lSL2CEaz90i97YxxVXfVK2X9ipiCtBI5MxDA/GrklQLLksV9N
 A+Npi3L42x5yATBqMul+YVCITK1IZThjOn0EUXnndO9qp7cPI0FFjw4jGkioLYG7yo+OIXJ90SVhh
 p828BaX8dZFZEzYrjLX+PcMmEzTQ4QaFDIf9VTMHiOulzyKvRLp4LgQRkKE6IWheY0Qo2AZRcG4t/
 E31RYqm6VXEyf9QSWC6uKFR7sdjlY3BZMedrpiAOMTsUbtVtomspvCxcQvlyn4mr8HghIktPWnf/d
 Z5aMpAyA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kFuBQ-0007rM-HR; Wed, 09 Sep 2020 07:06:20 +0000
Date: Wed, 9 Sep 2020 08:06:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
Message-ID: <20200909070620.GB28245@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org>
 <20200908055510.GA19078@infradead.org>
 <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
 <20200908062326.GB20774@infradead.org>
 <a10026ea-6de5-b7b1-80af-8000dfd4601b@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a10026ea-6de5-b7b1-80af-8000dfd4601b@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Tom Murphy <murphyt7@tcd.ie>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, Sep 09, 2020 at 09:43:09AM +0800, Lu Baolu wrote:
> +       /*
> +        * The Intel graphic device driver is used to assume that the
> returned
> +        * sg list is not combound. This blocks the efforts of converting
> the

This adds pointless overly long lines.

> +        * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
> +        * device driver work and should be removed once it's fixed in i915
> +        * driver.
> +        */
> +       if (dev_is_pci(dev) &&
> +           to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
> +           (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
> +               for_each_sg(sg, s, nents, i) {
> +                       unsigned int s_iova_off = sg_dma_address(s);
> +                       unsigned int s_length = sg_dma_len(s);
> +                       unsigned int s_iova_len = s->length;
> +
> +                       s->offset += s_iova_off;
> +                       s->length = s_length;
> +                       sg_dma_address(s) = dma_addr + s_iova_off;
> +                       sg_dma_len(s) = s_length;
> +                       dma_addr += s_iova_len;
> +               }
> +
> +               return nents;
> +       }

This wants an IS_ENABLED() check.  And probably a pr_once reminding
of the workaround.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
