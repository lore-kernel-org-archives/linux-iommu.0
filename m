Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B547AC433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 09:54:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89960206B5
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jj7KvZKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89960206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4C4CB203A0;
	Tue, 18 Aug 2020 09:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OvnNmPJFW2oe; Tue, 18 Aug 2020 09:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 668A920380;
	Tue, 18 Aug 2020 09:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A427C07FF;
	Tue, 18 Aug 2020 09:54:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E43A8C0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 09:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D84BE8702D
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 09:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0c0xDtHGVIH for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 09:54:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0A8B786E6E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 09:54:22 +0000 (UTC)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20200818095420epoutp039b1a9c32b6a94b8b5bad08a0cd5dfbd5~sVB8YCELG2117621176epoutp03e
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 09:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20200818095420epoutp039b1a9c32b6a94b8b5bad08a0cd5dfbd5~sVB8YCELG2117621176epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1597744460;
 bh=PqTAVqNZO7gmXW9amGyPm4l3DQomy2su52Yjy7w8S38=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jj7KvZKdvI5J1v8npFmI6xeFBP7/BYmM5rAPFFSe/QnXujCo+D66NxKdZVM5AFY12
 8aSUu/y4L5wzGnWSeGuzrsTyV2jEPBxhUI13GRJ3RfszJ3xYQJIay6G4Eb1p093UIm
 7rR6oavsGLAyAgZ9ppRgmtMuK1Gws2nuLz4ccDvo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20200818095419epcas2p3e0a72b0746f16dbef89a498c8d3c408b~sVB7sDEO80748807488epcas2p3q;
 Tue, 18 Aug 2020 09:54:19 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.183]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4BW5px27nBzMqYkV; Tue, 18 Aug
 2020 09:54:17 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 CD.6D.27013.845AB3F5; Tue, 18 Aug 2020 18:54:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20200818095415epcas2p3739385676d95712deedfa7ce234d6788~sVB4QILwW0996809968epcas2p3N;
 Tue, 18 Aug 2020 09:54:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200818095415epsmtrp2d1b1197ec53be9d80bf40b515bdff6e2~sVB4PUU0M0063800638epsmtrp2U;
 Tue, 18 Aug 2020 09:54:15 +0000 (GMT)
X-AuditID: b6c32a48-d35ff70000006985-73-5f3ba54802b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 83.6D.08382.745AB3F5; Tue, 18 Aug 2020 18:54:15 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20200818095415epsmtip211786235a3e63a47c359a0f2a344d41e~sVB4C0Y8p2057420574epsmtip2Y;
 Tue, 18 Aug 2020 09:54:15 +0000 (GMT)
Date: Tue, 18 Aug 2020 18:46:46 +0900
From: Cho KyongHo <pullip.cho@samsung.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818094646.GC191752@KEI>
MIME-Version: 1.0
In-Reply-To: <20200818083720.GA9451@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTZxzH9/R6x9XR7awCzyobzYkEqmBbKRxCmVHUWzAGw7aQJVI6eoNm
 fVuv7M1MNDoFgwSGboK8hYEtCJFAcQxFoXQyxtzINpERCSkwkzFbQTbiyErW4zThv8/z+31/
 7w+OSLoxKW4w2xmbWWcksQ3C60Nx6ni6JVWr8HWlUY+vlAFqtKJJQAVKx1Cq8XYq1V3LUqWX
 O0OortlxlPq1rxajOjxTIdTgwhxKnX6g3vMiPTdYL6Db69sB3e2U011tpRjd3VxMV004AF3u
 agP0UtdrWfg7xrRCRqdnbDLGnG/RG8wFGjIzW7tPq05SKOOVKVQyKTPrTIyGzDiUFX/AYAw2
 Sco+1BmLgqYsHcuSO9PTbJYiOyMrtLB2DclY9UarUmlNYHUmtshckJBvMe1WKhQqdVCZZyy8
 +aAMsQ4QH4/+3Sw8AYbE54AIh0QifDTdITwHNuASohfA5mtulHNIiCcA3m5J4B3LAJ781xlU
 4WsRzocRvL0fQO9yp4B/eAEs/8kPOJGQ2AYHRzK4RBghh1frhgHHm4k4OOk4i3B6hKgWwEBN
 LcI5NhGZsN15SsCxOCgqudiB8bwRjlTPCTkWESo4fvc8yuUPI6Lh/GAxlwcSHTica6nH+OYy
 YOV/Bn6yTXB+2BXCsxQu+fsxXv8VgP4GN8Y7ugFcvrGR512w5uHZtUYRohA6R53Pcm6Fnkkh
 b34JlgwFQnizGJackfCR0fDbi+PC56XK+yeerYqGgUoJvx0/gK2+ZrQCRNWsG6xmXTGed8DG
 G0+CjAd5C3Ss4jzGwWt9OxsB2gbCGStrKmBYlTVx/aW7wNrvldO94LJvIcENBDhwA4gj5Gbx
 u98nayVive6TTxmbRWsrMjKsG6iDV6pEpGH5luD3N9u1SrUqKUmRoqbUSSqKjBD7d4/lSogC
 nZ15n2GsjO15nAAXSU8IomYmjyySv0XMytBLsZLQdFz/Deq4/ljaGxn6C3X86urKWF4k89ee
 g29U1/2pqZPfedoz8Z5n++uyzLEepik0Rn50+otB34B90WF/OXGvBjnesGKILU5WULdE7QWx
 Ob0rcZ+9+fSDveHpFy69cMZbPhCTXXHhO+9NaoRIXIo8MN+nVUw1LGCe1a25ZRGzRTtenY+R
 3W/Ni8IPPvojILKR4xVbSo79Lt2fuxh9ZDjHOXWrapvctO8tEblfL8ypeuW813MHvf+z915t
 wnYmyxOe8uMPna63T379kTngOtqUnCydOXVMHX8aSb2XHXa3B9+V/uXk5y5nq6XynxmFD4VX
 Dk97SSFbqFPKERur+x8L19mHRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvK77Uut4g7sbDCzeL+thtDg9YRGT
 xd/OC6wWC/ZbW2yeU2zROXsDu8Wmx9dYLS7vmsNmsfbIXXaLgx+esFq03DF14PZ4cnAek8ea
 eWsYPTav0PLYtKqTzWPzknqPyTeWM3r0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxpb7B5gK
 GvgqJj7oY29gnMPdxcjBISFgIrHimXgXIxeHkMBuRonPU64ydzFyAsWlJOZ1r2WCsIUl7rcc
 YYUous8ocX7KKWaQZhYBVYmDJ11AatgEtCRWzz3OCGKLCGhK3FrezgxSzywwm0ni6IxjYEOF
 Bbwl1qxoBhvKC1TUMXUtG8TQd4wShw9tZIVICEqcnPmEBcRmBpp6499LJpBlzALSEsv/cYCE
 OQWMJK6d7WUFCYsKqEi8Olg/gVFwFpLmWUiaZyE0L2BkXsUomVpQnJueW2xYYJiXWq5XnJhb
 XJqXrpecn7uJERw9Wpo7GLev+qB3iJGJg/EQowQHs5IIb9IJ83gh3pTEyqrUovz4otKc1OJD
 jNIcLErivDcKF8YJCaQnlqRmp6YWpBbBZJk4OKUamDa+N+IKSG7ZKzlVPbnnt8ebmfyWMdOa
 nvz4HTqxvLpYTmVhumhaTtXMGu2uzD+9hrkP3q1wvFt9+koRd1HO1djb7DEaH77q+S5u7t5T
 8TP//W2td+Gum3Ilk1dNOqT92owt4u7OSwxMK1QSfmRPFjR6sptdVHzxpilTfhXrHXmo9Clf
 zyXpx9wd1hVFrPnMonlbLuysXNLC6PXmctDVhEl2DiFfWhduf3ai8ealVzN/R19Z8qAr5lb0
 7Lf6U9/vidTfpfwlYdKZHtkj+jlv5//e7G5rbnhhsZKYnuqO+eu6VYPLqvaEvRbec/GmafGc
 2//byp6tOrrpU2OJiczaiw88mg0Ws6y4cq/397IX6r5KLMUZiYZazEXFiQDYt+BDDQMAAA==
X-CMS-MailID: 20200818095415epcas2p3739385676d95712deedfa7ce234d6788
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----lWUYs60uNheWdrlwd5Sxb-jVEnyT8vPvqGqUNsoxLEsY2Otg=_2a297_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
 <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
 <20200818082852.GA15145@willie-the-truck>
 <20200818083720.GA9451@infradead.org>
Cc: janghyuck.kim@samsung.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, hyesoo.yu@samsung.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

------lWUYs60uNheWdrlwd5Sxb-jVEnyT8vPvqGqUNsoxLEsY2Otg=_2a297_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Aug 18, 2020 at 09:37:20AM +0100, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 09:28:53AM +0100, Will Deacon wrote:
> > On Tue, Aug 18, 2020 at 04:43:10PM +0900, Cho KyongHo wrote:
> > > Cache maintenance operations in the most of CPU architectures needs
> > > memory barrier after the cache maintenance for the DMAs to view the
> > > region of the memory correctly. The problem is that memory barrier is
> > > very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
> > > involves the memory barrier per every single cache sg entry. In some
> > > CPU micro-architecture, a single memory barrier consumes more time than
> > > cache clean on 4KiB. It becomes more serious if the number of CPU cores
> > > are larger.
> > 
> > Have you got higher-level performance data for this change? It's more likely
> > that the DSB is what actually forces the prior cache maintenance to
> > complete, so it's important to look at the bigger picture, not just the
> > apparent relative cost of these instructions.
> > 
> > Also, it's a miracle that non-coherent DMA even works, so I'm not sure
> > that we should be complicating the implementation like this to try to
> > make it "fast".
> 
> And without not just an important in-tree user but one that actually
> matters and can show how this is correct the whole proposal is complete
> nonstarter.
> 
The patch introduces new kernel configurations
ARCH_HAS_SYNC_DMA_FOR_CPU_RELAXED and ARCH_HAS_SYNC_DMA_FOR_CPU_RELAXED
not to affect the rest of the system. I also confirmed that the patch
does not break some other architectures including arm and x86 which do
not define the new kernel configurations.

Would you let me know some other things to confirm this patch is
correct?

Thank you.

------lWUYs60uNheWdrlwd5Sxb-jVEnyT8vPvqGqUNsoxLEsY2Otg=_2a297_
Content-Type: text/plain; charset="utf-8"


------lWUYs60uNheWdrlwd5Sxb-jVEnyT8vPvqGqUNsoxLEsY2Otg=_2a297_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
------lWUYs60uNheWdrlwd5Sxb-jVEnyT8vPvqGqUNsoxLEsY2Otg=_2a297_--
