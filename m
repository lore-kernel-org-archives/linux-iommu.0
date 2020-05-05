Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58744C47254
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 10:52:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFB7206A5
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 10:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n9pEqCvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFB7206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E508987DB8;
	Tue,  5 May 2020 10:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yn9t8daT+fV; Tue,  5 May 2020 10:52:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D57D387D5C;
	Tue,  5 May 2020 10:52:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD1E3C0859;
	Tue,  5 May 2020 10:52:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27A22C0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0F27D87DB4
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1LbrCNsKWq-9 for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 10:52:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5AAF387D5C
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:52:02 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200505105159euoutp016874b23179d0ed2809c75588479b79fe~MHFT-uLG61052910529euoutp01j
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 10:51:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200505105159euoutp016874b23179d0ed2809c75588479b79fe~MHFT-uLG61052910529euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588675919;
 bh=yMyzoBogPw6/n1rpQDeBRxUwooVdKS0ckX3oXuZ31Gs=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=n9pEqCvgIdXgwRkn/S8vJWOkA7kgQo9PssCow77WZf48maX9xlcPeNPXiHkqcK5S+
 NIX2W+V0U0pCOAzNwdJFMTEfD6x8wYQft3xwqtcLC25s12xbFmmJ8BU+L+9G5EGTBw
 nsx9IdZnk+c0EH96H+giCg0ubsAyFjqnjcJarAnw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200505105159eucas1p2e3417a908d5bdeaa73d3b629279ddda5~MHFTtvAJo0098600986eucas1p2j;
 Tue,  5 May 2020 10:51:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 7A.61.61286.F4541BE5; Tue,  5
 May 2020 11:51:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200505105158eucas1p2188fe0a38af9dc0195c9f1f5927761d5~MHFTD8nBA0658106581eucas1p2i;
 Tue,  5 May 2020 10:51:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200505105158eusmtrp12f82351d230d5cab13dcdc992691e1b2~MHFTDKTMU2856128561eusmtrp1E;
 Tue,  5 May 2020 10:51:58 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-9b-5eb1454fa229
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.82.07950.E4541BE5; Tue,  5
 May 2020 11:51:58 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200505105158eusmtip2279b8eab8ea11ac35b06618ad8e6334c~MHFSYOBrz3039930399eusmtip2t;
 Tue,  5 May 2020 10:51:58 +0000 (GMT)
Subject: Re: [PATCH v3 02/25] drm: core: fix common struct sg_table related
 issues
To: Christoph Hellwig <hch@lst.de>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5dd1cb55-accb-0dc6-4ca5-90c57cd19527@samsung.com>
Date: Tue, 5 May 2020 12:51:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505101508.GA14860@lst.de>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH973fw/06fnwddp/F2M7TSNFk+21hmrLfJtLWzJg4/MS663JX
 EhspTp2KHk45yWVW5KHc5bIwutGpprWy5Pkpix6EOtS4dPfz0H+vz/vz/uz7fm9fhpD3UL7M
 rrgEQRenUitpGWmvG2zyjwi7Fr3wpmkWl9VUL+GuFVZQ3LA9h+Aeufpo7uKl+xLOcieYG3j0
 RsJZ37VRXGtNEc2VfLlOcoaMUoqr/dxBcVU9OdRylr9cfBnxt79ZSN5ankHz1d9eU3xxfST/
 6phTwtvOH+Sfud8RfF57GeJvPkmh+eyqcsTbGvfz/dZpa9kNsiXbBfWuPYJuwbItsp1um5OO
 H5buPdR6V5qC7tJG5MMADgJzwxfSiGSMHF9AYGoe/DMMIKhNN0vFoR/B++4jxN+T5wPHkYfl
 uAxBRRYnmvoQZOekSTyLiTgKrrc4vTwJK+F910PkMRG4jQD7RyfpWdA4EIy9Rm8QFi+D/Ft3
 vDqJZ8LFuqMjxwwzGW+CgrYo0TIB6k91eC0+eD4YTrsoDxN4OlT3FhEiK+Bpx1mJGNTEwL2G
 xSKHQp+rhhR5InQ5q6QiT4XGvExvZcBpCN40XZGKQyaC1tRCJLqC4XnTEO0JROC5UFGzQJRD
 wJ3Z45UBj4P23glihnGQay8gRJmFdINcdM8Gs/Pqv2drm1uIE0hpHtXMPKqNeVQb8/93LYgs
 RwohUa+JEfSBcUJSgF6l0SfGxQRs02qsaOQPNrqdX28gV8tWB8IMUo5l1/dXRMsp1R59ssaB
 gCGUk9jSH5XRcna7KnmfoNNu1iWqBb0DTWFIpYJddO7jJjmOUSUIsYIQL+j+biWMj28KyqIc
 nd3JB5tpiOhck0qdXdEwmT0Rnj3Fr1jhXuWMDT3grzApgzZsK7hQsiNtR+fKkF/awwbeb5ZG
 5o+1lsgPhSGfLOPnDb5wqJPzk8a2/yqpXnrjTJctOJyPyN0YUPn9Z9dhpnDG4/3r5swcGrP6
 bcLxl/YHSXt3C2Gak6b1CluUktTvVAXOI3R61W+h15eOfwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xe7p+rhvjDO5/MLPoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrHw41YWi7bOZawWBz88YbXY
 8mYiqwOvx5p5axg99n5bwOKxaVUnm8f2bw9YPeadDPS4332cyWPzknqP2/8eM3tMvrGc0WP3
 zQY2j74tqxg9Np+u9vi8SS6AN0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshU
 Sd/OJiU1J7MstUjfLkEv49/m42wF/9krGi8fYG9gPMDWxcjJISFgInHnSz8jiC0ksJRRYuVK
 Roi4jMTJaQ2sELawxJ9rXUD1XEA1bxkl1hxfyQKSEBYIkdh66TgTiC0ioCTx9NVZRpAiZoEb
 zBLfNveyQ3TMZpJY3TgPbCybgKFE19susNW8AnYSU/bsB5vEIqAisfJYO9AkDg5RgViJloua
 ECWCEidnPgEr4RTQkWib/RXsImYBM4l5mx8yQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYh
 aZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwMjfduznlh2MXe+CDzEKcDAq8fBu
 +Lo+Tog1say4MvcQowQHs5II77IfG+KEeFMSK6tSi/Lji0pzUosPMZoC/TaRWUo0OR+YlPJK
 4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTAu/Zj24MUfVz3/Poea
 0hulT25wlU9Ypq3cd7k5wLzwlUjziYBk2WU3+yJcU9h+R4l47p5x9dNFy0NHJPJmmz6bv8W5
 9wp7V7/ZzF3TOI/+K7uw+GFA+GrDucqrshSjE/z7pl1YvNXNZFvwly8ijNcjki/eduvISnj4
 sdCkUZrP3KfLQPnstCQlluKMREMt5qLiRADg0UVbEgMAAA==
X-CMS-MailID: 20200505105158eucas1p2188fe0a38af9dc0195c9f1f5927761d5
X-Msg-Generator: CA
X-RootMTR: 20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454@eucas1p1.samsung.com>
 <20200505084614.30424-2-m.szyprowski@samsung.com>
 <20200505101508.GA14860@lst.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
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

On 05.05.2020 12:15, Christoph Hellwig wrote:
>> -		for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
>> +		for_each_sg_page(st->sgl, &sg_iter, st->orig_nents, 0)
> Would it make sense to also add a for_each_sgtable_page helper that
> hides the use of orig_nents?  To be used like:
>
> 		for_each_sgtable_page(st, &sg_iter, 0) {

We would need two helpers:

for_each_sgtable_cpu_page() and for_each_sgtable_dma_page().

I considered them, but then I found that there are already 
for_each_sg_page(), for_each_sg_dma_page() and various special iterators 
like sg_page_iter, sg_dma_page_iter and sg_mapping_iter. Too bad that 
they are almost not used, at least in the DRM subsystem. I wonder if it 
make sense to apply them or simply provide the two above mentioned 
wrappers?

>> +	for_each_sg(sgt->sgl, sg, sgt->orig_nents, count) {
> Same here, e.g.
>
> 	for_each_sgtable_entry(sgt, sg, count) {
>
> ?
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
