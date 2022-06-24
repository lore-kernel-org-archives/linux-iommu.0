Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFD5C43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 12:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F6E961477;
	Fri, 24 Jun 2022 12:59:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F6E961477
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e9VIrFRS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ekVUmVi0lVSA; Fri, 24 Jun 2022 12:59:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4BA360BB8;
	Fri, 24 Jun 2022 12:59:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4BA360BB8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3E95C0039;
	Fri, 24 Jun 2022 12:59:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86B86C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 12:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ABF360BB8
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 12:59:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ABF360BB8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eN6xTDIVGLCd for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 12:59:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5994260A6C
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5994260A6C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vMOXdBy5q0jneD6eagGKUyxYDxjR9s5ISqYNMfmQSLs=; b=e9VIrFRSAoJIFu8bsXbrZyRRTc
 i0XRBruZXdofziujw65WQJCUaxKA2cynWytHcpHtsukfz1JLZwagaQIlgR56v/CWe7tnG+vbzzotD
 0aMsikP80AhoEI7hiEUBajzmFOTf6jRTzhz994vFGETTgH5J0VSUNccEo+LT5qKkFVTBkDF/d83XA
 wsvpi9S/qpTTwNJHnKJiEhFWx7eZME93DJB04Lw3dpSTOLZBg94XsXvfPj21CDJ3WMifj55kxHDMB
 edLRo7xTly67AzTxZqdwl7sFY2hMlu7c0BloaHDnS/2dH5QsuRAp8ZN8P40Byj5mO+b6lZNNwoQhT
 41RxiRww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o4iuR-002GrT-UF; Fri, 24 Jun 2022 12:59:39 +0000
Date: Fri, 24 Jun 2022 05:59:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] MAINTAINERS: Add new IOMMU development mailing list
Message-ID: <YrW1Oy0ojM5pXREB@infradead.org>
References: <20220624125139.412-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220624125139.412-1-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org
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

On Fri, Jun 24, 2022 at 02:51:39PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The IOMMU mailing list will move from lists.linux-foundation.org to
> lists.linux.dev. The hard switch of the archive will happen on July
> 5th, but add the new list now already so that people start using the
> list when sending patches. After July 5th the old list will disappear.

Shouldn't this also remove the old list given it has only a few days
to live?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
