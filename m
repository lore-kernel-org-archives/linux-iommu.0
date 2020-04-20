Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDCC54FCB
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E3921744
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CZBJhyvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E3921744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5ECA685C06;
	Mon, 20 Apr 2020 11:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IZJZok5skqOL; Mon, 20 Apr 2020 11:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3DC7984FFF;
	Mon, 20 Apr 2020 11:55:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30F37C07FF;
	Mon, 20 Apr 2020 11:55:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BB97C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 11:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 54F9D855D3
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 11:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rOLfxa2lVZmk for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 11:55:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A90868559F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=u/v02NGC1oFgel1iBcflEpVS3DgIiIJMM0PTdku3nhQ=; b=CZBJhyvq0qUv3KTenjC17+groE
 HnljLoftFJKoNw5UOVlCYJYof/UFLtQmL5/bX9LjqyUMTo4QRE86om9NvcRONyDDMnOGVceoX+gxR
 7skTn5ckWCZHYOoqhWpc3hd4V0HDNyIsFAeYa6bSvpq+bEiu36bK96SxuGk8hfmwqr6BmJyvF1Agl
 HpKhYqUL4S0RwC/jfr0C4LVaGSMhF+rV//Dtv4Y+Z4h74jcigb+DMo9NGcvEiyfLss4bI4oEpwBN3
 Xpok6CGILMN9GEeWX+JNL2XSTrGhDYNJ1ex2JKAcJsF3nBgda4YwkG6sQ2olGScYX1ORh8O6xszEf
 Esp1wo2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jQV0y-0006P9-DC; Mon, 20 Apr 2020 11:55:04 +0000
Date: Mon, 20 Apr 2020 04:55:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420115504.GA20664@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica>
 <20200420081034.GA17305@infradead.org>
 <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 devicetree@vger.kernel.org, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, will@kernel.org,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Apr 20, 2020 at 01:44:56PM +0200, Christian K=F6nig wrote:
> Am 20.04.20 um 10:10 schrieb Christoph Hellwig:
> > On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> > > Right, I can see the appeal. I still like having a single mmu notifie=
r per
> > > mm because it ensures we allocate a single PASID per mm (as required =
by
> > > x86). I suppose one alternative is to maintain a hashtable of mm->pas=
id,
> > > to avoid iterating over all bonds during allocation.
> > Given that the PASID is a pretty generic and important concept can
> > we just add it directly to the mm_struct and allocate it lazily once
> > we first need it?
> =

> Well the problem is that the PASID might as well be device specific. E.g.
> some devices use 16bit PASIDs, some 15bit, some other only 12bit.
> =

> So what could (at least in theory) happen is that you need to allocate
> different PASIDs for the same process because different devices need one.

This directly contradicts the statement from Jean-Philippe above that
x86 requires a single PASID per mm_struct.  If we may need different
PASIDs for different devices and can actually support this just
allocating one per [device, mm_struct] would make most sense of me, as
it doesn't couple otherwise disjoint state.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
