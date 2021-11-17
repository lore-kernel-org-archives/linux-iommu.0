Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE1C433F5
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 10:05:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90C761AED
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 10:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B90C761AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8070E60A5D;
	Wed, 17 Nov 2021 10:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FLnw26VUk8Ck; Wed, 17 Nov 2021 10:05:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 56CD260628;
	Wed, 17 Nov 2021 10:05:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E9AEC002E;
	Wed, 17 Nov 2021 10:05:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A693BC0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 10:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 858DE401A4
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 10:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XFR4xkN5SpRj for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 10:05:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84F4140112
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9xc3t/i++I6ZSvgabyN8b1xNPjuadKnTYzFKCHa2W98=; b=kDQL48/1Or/EEQ7xgm6UWU9cIT
 oZf7XWgbuA2H59eFP5qbPJYEc55FK96oxCfwkF9ocigyZVRvOjLXG/aYyqzwsF7XVaLiElhFF03yZ
 mnCRLTMoSqiph7YZzvnGzQiS4KuH6nRjDmKJIUARK8FTx6yCytI8JbDvS7ru7qpdQdczadcfkhpeB
 BAANC4jrLTMFowrXL15LjELzMrfKogiQxGHlo3DWDAo5eRlpZDfiixQxYAPiRMNW3Dp4LhWkyVSsP
 PQhgvPkPZcJeRTWIRPWDuezeU32/gtF0YNDZcE76BWJ03cIM7FM5oQcpn5G8EIw/skWRe3a54G5bB
 wkO+F60A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mnHoG-004OST-KF; Wed, 17 Nov 2021 10:04:56 +0000
Date: Wed, 17 Nov 2021 02:04:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Subject: Re: [RFC 1/2] arm64: Add support for system cache memory type
Message-ID: <YZTTyErX4bb+dlEV@infradead.org>
References: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: arnd@arndb.de, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, maz@kernel.org,
 sean@poorly.run, linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
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

On Tue, Nov 16, 2021 at 03:15:59PM -0800, Georgi Djakov wrote:
>  include/linux/dma-map-ops.h      | 8 ++++++++

Your forgot to CC the maintainer.  Also don't try to ever hide DMA
core changes in arch specific patches ever again.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
