Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B7EC433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 05:43:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73E46124A
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 05:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A73E46124A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 642198405B;
	Thu, 30 Sep 2021 05:43:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mOV8pyqIewFm; Thu, 30 Sep 2021 05:43:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57B8E84056;
	Thu, 30 Sep 2021 05:43:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 186A4C000F;
	Thu, 30 Sep 2021 05:43:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F31DC000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 05:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88D5C40183
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 05:43:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HCF9oxSmsZ2P for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 05:43:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78E2340174
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 05:43:33 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C56D867373; Thu, 30 Sep 2021 07:43:28 +0200 (CEST)
Date: Thu, 30 Sep 2021 07:43:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/iommu: Report the correct most
 efficient DMA mask for PCI devices
Message-ID: <20210930054328.GA22181@lst.de>
References: <20210930034454.95794-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210930034454.95794-1-aik@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Carol L Soto <clsoto@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Sep 30, 2021 at 01:44:54PM +1000, Alexey Kardashevskiy wrote:
> and returns the IOMMU table mask on the pseries platform which makes some
> drivers (mpt3sas is one example) choose 32bit DMA even though bypass is
> supported. The powernv platform sort of handles it by having a bigger
> default window with a mask >=40 but it only works as drivers choose
> 63/64bit if the required mask is >32 which is rather pointless.
> 
> This reintroduces the bypass capability check to let drivers make
> a better choice of the DMA mask.
> 
> Fixes: f1565c24b596 ("powerpc: use the generic dma_ops_bypass mode")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
