Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D683C2D0EA
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:40:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1692072F
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1692072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B3E252048F;
	Wed,  8 Apr 2020 15:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXTqdETHsCGP; Wed,  8 Apr 2020 15:40:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 548B82041B;
	Wed,  8 Apr 2020 15:40:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C38BC1AE8;
	Wed,  8 Apr 2020 15:40:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E49CC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6D0AE20484
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AXci1pkPL0+M for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 15:40:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id D78DC2041B
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:40:38 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0BEE968C65; Wed,  8 Apr 2020 17:40:34 +0200 (CEST)
Date: Wed, 8 Apr 2020 17:40:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH 02/28] staging: android: ion: use vmap instead of
 vm_map_ram
Message-ID: <20200408154033.GA28499@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408124833.13032-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408124833.13032-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, syzkaller-bugs@googlegroups.com,
 bpf@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On Wed, Apr 08, 2020 at 08:48:33PM +0800, Hillf Danton wrote:
> > -	void *addr = vm_map_ram(pages, num, -1, pgprot);
> > +	void *addr = vmap(pages, num, VM_MAP);
> 
> A merge glitch?
> 
> void *vmap(struct page **pages, unsigned int count,
> 	   unsigned long flags, pgprot_t prot)

Yes, thanks for the headsup, you were as fast as the build bot :)

Fixed now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
