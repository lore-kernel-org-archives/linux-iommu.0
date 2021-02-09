Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EEC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 08:47:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E000764EBE
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 08:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E000764EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89B9F6F8D5
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 08:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JyTTiMdgoO05 for <iommu@archiver.kernel.org>;
	Tue,  9 Feb 2021 08:47:07 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id AFDCE6F890; Tue,  9 Feb 2021 08:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53EA96F8BC;
	Tue,  9 Feb 2021 08:47:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1886C0174;
	Tue,  9 Feb 2021 08:47:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4949C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A9A14871CA
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UmdBWSyUwx2d for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 08:47:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3669787152
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 08:47:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52D3764E54;
 Tue,  9 Feb 2021 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612860421;
 bh=z/Bdck+IaHkIZeXXQMqQh3l+DYhl/FkuerjrS0Z4okU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O6K3hXvBw+0tB/PGcQXYmKY9Plixk3xp/I/YfiCfq/M62b48W8fvfkfGWVS4AoJjV
 5izxtFjdYMfv9yCc8RXWG7CIZnR7mqx8EgENWn+GeVN57nP8pNzawAzDhhTjFSDq9w
 b0WuNObJ3egYYnClmK62iL21NscRORo99j5Ur0Ew=
Date: Tue, 9 Feb 2021 09:46:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: preserve DMA offsets when using swiotlb v2
Message-ID: <YCJMAxPi1HlVedfL@kroah.com>
References: <20210207160327.2955490-1-hch@lst.de>
 <20210209084156.GA32320@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210209084156.GA32320@lst.de>
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com, jxgao@google.com
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

On Tue, Feb 09, 2021 at 09:41:56AM +0100, Christoph Hellwig wrote:
> Sorry for being a little pushy, any chance we could get this reviewed
> in time for the 5.12 merge window?

No objection from me, my ack is already on the patch that you need it
for :)

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
