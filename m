Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC0C432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 07:22:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD9120715
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 07:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD9120715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E16CB87D86;
	Mon,  2 Dec 2019 07:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WFqeEo3KDlag; Mon,  2 Dec 2019 07:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E87BA87D7B;
	Mon,  2 Dec 2019 07:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBD25C1798;
	Mon,  2 Dec 2019 07:22:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80AFCC087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 07:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 76B3B204A7
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 07:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ytVcTK-JfnM for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 07:22:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 115BD20109
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 07:22:22 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6F6D268B05; Mon,  2 Dec 2019 08:22:18 +0100 (CET)
Date: Mon, 2 Dec 2019 08:22:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: lijiazi <jqqlijiazi@gmail.com>
Subject: Re: [PATCH] dma-mapping: do not mapping module memory
Message-ID: <20191202072218.GB29554@lst.de>
References: <d6a63ad37b2556b8ba2fda16fc4dde95aa721741.1574997534.git.lijiazi@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6a63ad37b2556b8ba2fda16fc4dde95aa721741.1574997534.git.lijiazi@xiaomi.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 lijiazi <lijiazi@xiaomi.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Nov 29, 2019 at 07:03:40PM +0800, lijiazi wrote:
> On ARM, x86_64, sparc64 platform, virt_to_page only convert a
> _valid_ virtual address to struct page *, virt_addr_valid(x)
> indicates whether a virtual address is valid. If ptr is point
> to a static variable in module area, virt_to_page will return
> a invalid value.

While the path isn't wrong, why bother? 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
