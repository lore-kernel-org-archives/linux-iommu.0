Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CEEC433B4
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 09:41:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4712261448
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 09:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712261448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E280683A96;
	Mon, 10 May 2021 09:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nn6eohzjBTlj; Mon, 10 May 2021 09:41:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 875B283B60;
	Mon, 10 May 2021 09:41:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9244C0028;
	Mon, 10 May 2021 09:41:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84006C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A05D40326
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I8XsbtZuUXJK for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 09:04:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C530C40323
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:04:25 +0000 (UTC)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210510090423epoutp02759b4779e00b689de4a4e5ea275e0505~9qS_6CS7G2754327543epoutp02q
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:04:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210510090423epoutp02759b4779e00b689de4a4e5ea275e0505~9qS_6CS7G2754327543epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1620637463;
 bh=LyJ2/vrXA79R2bIzxqX+Panl8BD71MJWRMa3PlB7Z6c=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=mhSzJb+hfjCmCd2HQJ7ZGiBcREUWeTOpARrqhpi3tpTP3LTDWWoyzIku6Vy98wGeV
 7flKUUpzkhs00v1rXEUBBxX//FMYSUpFLtxfo0ihk6WcOeATyCdYUCKzwNFN0Qvnq3
 kqAUU1WY1HsY2DL5krTPXWhayWFZN6fTQcgb+FfE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20210510090422epcas2p152c5088255ca59e456d325018be031eb~9qS_jFj100043500435epcas2p1d;
 Mon, 10 May 2021 09:04:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.181]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Fdw906g0gz4x9QS; Mon, 10 May
 2021 09:04:20 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 5A.83.09433.217F8906; Mon, 10 May 2021 18:04:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20210510090417epcas2p39cbc55bfe85c5b22aedac38c62d54c5e~9qS55jlxD3141131411epcas2p39;
 Mon, 10 May 2021 09:04:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210510090417epsmtrp254f93fe9b4cae2ed9e925c438ec1fa66~9qS54xgzu2598725987epsmtrp2c;
 Mon, 10 May 2021 09:04:17 +0000 (GMT)
X-AuditID: b6c32a47-f4bff700000024d9-7b-6098f7122b8b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 82.9C.08637.117F8906; Mon, 10 May 2021 18:04:17 +0900 (KST)
Received: from KORCO039056 (unknown [10.229.8.156]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20210510090417epsmtip18096a2fa52447a4807b551688872e665~9qS5s2TS20529505295epsmtip1L;
 Mon, 10 May 2021 09:04:17 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Christoph Hellwig'" <hch@lst.de>
In-Reply-To: <20210510084406.GA1093@lst.de>
Subject: RE: [PATCH] swiotlb: manipulate orig_addr when tlb_addr has offset
Date: Mon, 10 May 2021 18:04:17 +0900
Message-ID: <002401d7457b$75171560$5f454020$@samsung.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHf+D/7GCiM8g+JpPf60X7uhtFZNAFoIg0LAnrz/3Wqq+y8MA==
Content-Language: ko
x-msg-type: PERSONAL
x-drm-type: PERSONAL
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmma7Q9xkJBj/faVjsPW1hsXL1USaL
 BfutLZYtfspocXnXHDaLtUfuslsc/PCE1YHdY828NYwek28sZ/TYfbOBzePj01ssHn1bVjF6
 fN4kF8AWlWOTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZ
 A3SJkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0LBArzgxt7g0L10vOT/XytDA
 wMgUqDIhJ2PyjjaWgp+cFbPWrmVvYHzA3sXIySEhYCJxZkE7UxcjF4eQwA5GiWcvD0I5nxgl
 9v2YyAzhfGOUuHazgw2m5XjPUlaIxF5GiYe3WxkhnBeMEh+vbGMCqWIT0Jd42bGNFcQWEVCT
 OPOzjR2kiFmglUmiYesdRpAEp4C2RMPlPhYQW1jAW+LXzQtgcRYBVYmDX1rA1vEKWEr0zDvK
 CGELSpyc+QSsnllAXmL72znMECcpSPx8ugxqmZPE/rY5rBA1IhKzO9ugakQkurfcBjqOA8y+
 sycF5B4JgSMcErt272OBqHGR2LdwG9SbwhKvjm+BhpKUxOd3e9kgGroZJVof/YdKrGaU6Gz0
 gbDtJX5N38IKsoBZQFNi/S59iF3KEkduQZ3MJ9Fx+C87RJhXoqNNaAKjyiwkj81C8tgsJA/M
 Qpi5gJFlFaNYakFxbnpqsVGBMXJsb2IEJ1Mt9x2MM95+0DvEyMTBeIhRgoNZSYRXtGNaghBv
 SmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3OB6bzvJJ4Q1MjMzMDS1MLUzMjCyVx3p+pdQlCAumJ
 JanZqakFqUUwfUwcnFINTNwNchfU4tpnBPhu72jNPfB5duOUbtlmv6obpyXU0/qea6kuWBE0
 uVMqzcnJ4mN8R+Ycne17lboFKsNaF3gLXYvYnSN4xYFbqNGJP8tmk/xuIW6D3q+rS5dbW35q
 mmZZH34u6CfTWonCyrt3PS9JmWoYvopeu9G/ksH4vURyhFf9ksyypvvrt6zeaRr79HBfmoVq
 dKF8asLcR+dkj3+aytzy9KL+7aMb7KW8guz/PH97bgfPd3GJlMprcbdd1W1d5Dof1HN3BaZ3
 nvhXNf+Q2k3GXYLJ3O1Ocepys0RDOHd/ff3ZcqrDhBMLZ3xVqKnu+cX1dCHn4tiHp7u3eDz0
 V8tSjpFUt6pTTK2b26PEUpyRaKjFXFScCADPuGPuLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSnK7g9xkJBn9+m1rsPW1hsXL1USaL
 BfutLZYtfspocXnXHDaLtUfuslsc/PCE1YHdY828NYwek28sZ/TYfbOBzePj01ssHn1bVjF6
 fN4kF8AWxWWTkpqTWZZapG+XwJUxeUcbS8FPzopZa9eyNzA+YO9i5OSQEDCRON6zlLWLkYtD
 SGA3o8S5+R+ZIRKyEs/e7YAqEpa433IEqugZo0TH1ccsIAk2AX2Jlx3bWEFsEQE1iTM/28Aa
 mAU6mSQaTnKB2EIC6xklen95g9icAtoSDZf7wHqFBbwlft28wAhiswioShz80sIGYvMKWEr0
 zDvKCGELSpyc+QSongNopp5E20ZGiPHyEtvfzoG6U0Hi59NlrBC2qcSFryuYYG5+dXwLO8Rp
 ThL72+awQvSKSMzubIPqFZHo3nKbCWQ8iH1nT8oERvFZSBbPQlg8C8niWUgGLWBkWcUomVpQ
 nJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyvWpo7GLev+qB3iJGJg/EQowQHs5IIr2jHtAQh
 3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamHRXxU5aH3v3
 3pKqaT9r//+Y9Fvv4ew80dlHs8XNJBLX5Heb3D/vvTamn/ndLIeHuozMZ9c6mS6d/u/H5n8T
 +WNi3RssDycvWFNTvWv3jqYpKv0vQ50f7Diy5H1g5Xa/y31vtK6df/Gsjs3CyWZzB5fahjmr
 N/J61jQyPw+QCFNZOmWDNd/UcP4dyl5JfyrNtZJuHTH+enxHyh+/G3cz7/HY3d959WTGpYfr
 Fv1aNrfRrsYvqubsJI9ekdWtsqlH59sIPXm83mnmB5+A1nUVaSEdh9yD/OUEE11zLQ7Fa99K
 XnSkR/DtvZsn7W5xTlRmDp3Y8pFd/NFbyxt+z1kr+M41PViu4l04v3z2VcvVYcuVWIozEg21
 mIuKEwHCi91ARgMAAA==
X-CMS-MailID: 20210510090417epcas2p39cbc55bfe85c5b22aedac38c62d54c5e
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55
References: <CGME20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55@epcas2p2.samsung.com>
 <20210510083057.46476-1-chanho61.park@samsung.com>
 <20210510084406.GA1093@lst.de>
X-Mailman-Approved-At: Mon, 10 May 2021 09:41:45 +0000
Cc: 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, 'Bumyong Lee' <bumyong.lee@samsung.com>,
 iommu@lists.linux-foundation.org, 'Robin Murphy' <robin.murphy@arm.com>
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

(RESEND due to wrong encrypted message setting)

Hi,

> On Mon, May 10, 2021 at 05:30:57PM +0900, Chanho Park wrote:
> > +static unsigned int swiotlb_align_offset(struct device *dev, u64
> > +addr);
> 
> Please just move swiotlb_align_offset up to avoid the forward declaration.

Okay. I'll move the position of the function next patch.

> 
> >  /*
> >   * Bounce: copy the swiotlb buffer from or back to the original dma
> location
> >   */
> > @@ -346,10 +347,17 @@ static void swiotlb_bounce(struct device *dev,
> phys_addr_t tlb_addr, size_t size
> >  	size_t alloc_size = mem->slots[index].alloc_size;
> >  	unsigned long pfn = PFN_DOWN(orig_addr);
> >  	unsigned char *vaddr = phys_to_virt(tlb_addr);
> > +	unsigned int tlb_offset;
> >
> >  	if (orig_addr == INVALID_PHYS_ADDR)
> >  		return;
> >
> > +	tlb_offset = (unsigned int)tlb_addr & (IO_TLB_SIZE - 1);
> > +	tlb_offset -= swiotlb_align_offset(dev, orig_addr);
> 
> Nit: I'd write this as:
> 
> 	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
> 			swiotlb_align_offset(dev, orig_addr);
> 
> as there is no need for the cast, and just having a single assignment is
> easier to follow.

Great. It can be a single assignment as you suggested.

Best Regards,
Chanho Park

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
