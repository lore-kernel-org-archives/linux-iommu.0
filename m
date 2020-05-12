Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A86C54E8B
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 13:19:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54967206DD
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 13:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jn2uty/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54967206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0515126129;
	Tue, 12 May 2020 13:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Eozhr-C+s7h; Tue, 12 May 2020 13:19:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F121720513;
	Tue, 12 May 2020 13:19:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D985CC088A;
	Tue, 12 May 2020 13:19:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C4BCC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 13:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 67ED088D67
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 13:19:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UNavzyamxq1M for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 13:19:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9DB37893FE
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 13:19:24 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512131922euoutp01f86463bcb392562ff9856b453afb3dc9~OSm-FmOkX1467314673euoutp014
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 13:19:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512131922euoutp01f86463bcb392562ff9856b453afb3dc9~OSm-FmOkX1467314673euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589289562;
 bh=B/ciR2IpROe7ZVcb9QcrczNRLcFKZ9qwYAYyMFED23M=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=jn2uty/mX/bWxPPfLV248TzZvDItOv6iua5nMfJAI0icM5OvV60ItYHDx52eZyeUd
 uE0LnoigLMZlYgn/U0mgsOV5qC18TNVtcGURSG4Uz3RCDRC81jlTg5mpjebNPDVfXi
 HI+Rrh7GGmLapYd/WX6L/NB5JZHwcQaVlvy9Q/IA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200512131921eucas1p18615f296ecd645f9f3ac1691776ceb10~OSm_iyyov0125301253eucas1p1Q;
 Tue, 12 May 2020 13:19:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.11.61286.952AABE5; Tue, 12
 May 2020 14:19:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200512131921eucas1p184bae0d7f1fada53e5360dd7e4619ea1~OSm_NY8b72876228762eucas1p1P;
 Tue, 12 May 2020 13:19:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200512131921eusmtrp2c9b40f9b50e1c7126477f67a29bba9b7~OSm_MuG1h0525705257eusmtrp2A;
 Tue, 12 May 2020 13:19:21 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-29-5ebaa2595f43
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.2D.08375.952AABE5; Tue, 12
 May 2020 14:19:21 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200512131920eusmtip2d8cc7f17c653dac201ed916440f213ac~OSm9nZRz_2661726617eusmtip2b;
 Tue, 12 May 2020 13:19:20 +0000 (GMT)
Subject: Re: [PATCH v4 01/38] dma-mapping: add generic helpers for mapping
 sgtable objects
To: Christoph Hellwig <hch@lst.de>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <dc49c74d-d580-3659-9c93-f932b6d1124f@samsung.com>
Date: Tue, 12 May 2020 15:19:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512130936.GA24428@lst.de>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUgUYRjum9ljXFobV8UXy471SDOvLBjyoKWISQiCKNLSXHVQ0V1lV02F
 8OpiTc0KskHzKswrz7TdUlGoTdY2USmzQMUjFETLg7LS3B0s/z3fc3zP+8JL4JJ+vj0Rq0xi
 VEp5vFQg4rW9+Wn0CK7QhXlrxrypPGMvRjUVNfCp9bZCnBpanhdQ1bWvMaqsy49aGhrHqOaJ
 D3xqUFcsoLoXJvnHRHTdozpEd6yU8ej2lTE+PZqrx+iWxxn057UJnL43XIXol58yBXR+aw2i
 F5t3nxGFiPyjmPjYFEblFRguiqnpnMEStXjqatcIlokGMA2yIIA8DPm/K/kaJCIk5FMEiwsF
 uEmQkEsImt7KOLy4IXx13wy05i3yOL4KgbYA48LzCH7k6wQmwZq8BH2vGs0f2ZBSmJp9h0wm
 nDRiwBYMmNMC0gc0cxpzQEwGQv+vaTPmkc5guN4tNGFbMhQMlS2I81hB78NJc9aCPAgVeZ1m
 P07ugfa5YpzDdjAyWWqeCMg5Icw0ZOHc2Cegr22Fz2FrmNW3Cjm8C9a1m4EcBOPGeiH3uI1g
 MLsIcS4/+GJc3agjNircoEHnxdEy0OknhSYaSEsYnrPihrCEu20PcI4Ww60bEs7tAqz+2b/a
 7v4B/A6SsltWY7esw25Zh/3fW4Z4NciOSVYrohm1j5K54qmWK9TJymjPyARFM9q4M8Oa/vsL
 tDwQ0YNIAkm3i7dd1YVJ+PIUdZqiBwGBS23E12K1YRJxlDwtnVElXFYlxzPqHrST4EntxL4V
 M6ESMlqexMQxTCKj2lQxwsI+ExW6742cSVv2f+9RX2KgC09lXSiVjdY6KSMaq2eTOoLK2Ccl
 2Tm0IHco6dDR+06Coro/funHnQNsXYdtZOzJXH3j1Lfym4WKj5WOjvv8y1McLBPkFqfP78iR
 OYTELdmd83NrsnW9GBvkmxE13lLjciR1Orw6Mjx5v5sN08yeDQh+LuWpY+Q+B3CVWv4XN2CJ
 sGMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7qRi3bFGfxaLGXRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzeLghyesDlwea+atYfTY+20B
 i8f2bw9YPe53H2fy2Lyk3uP2v8fMHpNvLGf02H2zgc2jb8sqRo/Pm+QCuKL0bIryS0tSFTLy
 i0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mlbte8lUsJO54tf+W0wN
 jJeYuhg5OSQETCS29H5m6WLk4hASWMoo8eLkfmaIhIzEyWkNrBC2sMSfa11sEEVvGSV+7z4B
 1i0sECNxZs8GsAYRASWJp6/OMoIUMQtcYJK4sfMoM0THPiaJrXM3sIFUsQkYSnS97QKzeQXs
 JC78fgZmswioSpxuPcgOYosKxEqsvtbKCFEjKHFy5hMWEJtTQEdiUe8+sHpmATOJeZsfMkPY
 8hLb386BssUlbj2ZzzSBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k
 /NxNjMAo3nbs5+YdjJc2Bh9iFOBgVOLhZajdFSfEmlhWXJl7iFGCg1lJhLclc2ecEG9KYmVV
 alF+fFFpTmrxIUZToOcmMkuJJucDE0xeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU
 1ILUIpg+Jg5OqQbG/CdS6y0uK6U1OvnxXKk97nFaP3mDhE0B06cj7Fdt/y9Q4bz8VSpz1qOn
 74us+K7u8WifouegVScxdeKqk44aK9kis1LEtItEN8x7fqs1yEm2YfHBzAuJE5VLr290evVi
 Vnr50bgj5ZyZ8f0mtTvVMxMzIw9tfybeOpvRl6exTMztiJXDvOlKLMUZiYZazEXFiQC/O/cU
 +AIAAA==
X-CMS-MailID: 20200512131921eucas1p184bae0d7f1fada53e5360dd7e4619ea1
X-Msg-Generator: CA
X-RootMTR: 20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <CGME20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0@eucas1p1.samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <20200512121808.GA20393@lst.de>
 <1a80255d-81de-2c5d-6d06-ea126fd7f994@samsung.com>
 <20200512130936.GA24428@lst.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi Christoph,

On 12.05.2020 15:09, Christoph Hellwig wrote:
> On Tue, May 12, 2020 at 03:00:31PM +0200, Marek Szyprowski wrote:
>>> 	if (n <= 0)
>>> 		return -EINVAL;
>>> 	sgt->nents = n;
>>> 	return 0;
>>>
>> Indeed this version looks much better. I will resend it in a few minutes.
> I could also just fix it up when applying the patch.
Fine for me.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
