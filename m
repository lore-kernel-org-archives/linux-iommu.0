Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F392C11F69
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 06:55:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71A061C72
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 06:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71A061C72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9156260624;
	Wed, 30 Jun 2021 06:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U2A1vqtv1J5R; Wed, 30 Jun 2021 06:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8160E606FD;
	Wed, 30 Jun 2021 06:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50F31C0010;
	Wed, 30 Jun 2021 06:55:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11F1FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F06AA83AB2
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rbj6sWNbYdq7 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:55:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D02683AA9
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=f/Ss2iSM2QGOE0K5ddDAmgJLDWuc6gafnUUbn6I+ywE=; b=EjtYVsIFXW62/EkGI7hOZiVxWu
 WtQ1QOiJ+kE2LqSAajX/iny/lZxgDgpw4Lqlm87T+L3KdMUw9xtCm/qbkjnNm+n9HchMjHUuhlxdz
 w2OPufXyWbuv31Dot4DIGelHWZHewJ/p/raVKncRixUUmP7uchkRq1HvqmlhbTVJgHVFLODbv/YHA
 RNDQhV6qzSdLYF0g40BOD2Ta0/YGu2gzi83bR6eLmhaerMvfLzmNz8rtyEcmJ8Yhva1wvB3sNhoIm
 1xB1suxXnDYbBmr21iG+4XFobuyQO+ec3qti7Yrj8KfMA7I5Z33WvXyyfut+u94vA1XrYQhuXZ2+W
 lhuwYjjA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1lyU6N-0050fY-DH; Wed, 30 Jun 2021 06:53:46 +0000
Date: Wed, 30 Jun 2021 07:53:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YNwU801EDIJsfTqV@infradead.org>
References: <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <20210604230108.GB1002214@nvidia.com>
 <20210607094148.7e2341fc.alex.williamson@redhat.com>
 <20210607181858.GM1002214@nvidia.com>
 <20210607125946.056aafa2.alex.williamson@redhat.com>
 <20210607190802.GO1002214@nvidia.com>
 <20210607134128.58c2ea31.alex.williamson@redhat.com>
 <12631cf3-4ef8-7c38-73bb-649d57c0226b@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12631cf3-4ef8-7c38-73bb-649d57c0226b@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Tue, Jun 08, 2021 at 09:20:29AM +0800, Jason Wang wrote:
> "
> 
> 6.2.17 _CCA (Cache Coherency Attribute) The _CCA object returns whether or
> not a bus-master device supports hardware managed cache coherency. Expected
> values are 0 to indicate it is not supported, and 1 to indicate that it is
> supported. All other values are reserved.
> 
> ...
> 
> On Intel platforms, if the _CCA object is not supplied, the OSPM will assume
> the devices are hardware cache coherent.
> 
> "

_CCA is mostly used on arm/arm64 platforms to figure out if a device
needs non-coherent DMA handling in the DMA API or not.  It is not
related to the NoSnoop TLPs that override the setting for an otherwise
coherent device.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
