Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B3C49361
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 02:13:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249B3611ED
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 02:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249B3611ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEFE16084D;
	Mon, 21 Jun 2021 02:13:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IZtdfJuubIcX; Mon, 21 Jun 2021 02:13:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 98D2D6069F;
	Mon, 21 Jun 2021 02:13:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68404C0010;
	Mon, 21 Jun 2021 02:13:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8C4FC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 02:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2E9482E71
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 02:13:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yHIiftsM7KyS for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 02:13:20 +0000 (UTC)
X-Greylist: delayed 00:09:57 by SQLgrey-1.8.0
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B7CF82E19
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 02:13:20 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by gw2.atmark-techno.com (Postfix) with ESMTPS id 6BAF720D04
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 11:03:22 +0900 (JST)
Received: by mail-pj1-f72.google.com with SMTP id
 g19-20020a17090adb13b029016f4a877b4fso7484557pjv.8
 for <iommu@lists.linux-foundation.org>; Sun, 20 Jun 2021 19:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cPF5UweySrMkbBj5zDiR8HRka2TADsWzHftasg98zJs=;
 b=aN+o1wXk9MEaWjnrGxN8rWOjBpWSTjr0jyRELUqrTYzZG1XQBHRRDe/HhNK4/W8aCt
 P87B3Iorg0K4sHaNOtNAcEJb/StOoQNzuPpL6nsPFvc1OZia2aaTWd7AZkhQnv4q4m0E
 dkb53wqGv2Gq2AtdeybmkMFNv5+twAyYz/2+0NX4xYrqDtJugz5n1yILufcEHbs8bEFw
 p2W4/YrddxBJWot4hIoHyaXVWw9np+rgMazsZpqVjNCPQ85Qo2T5F9SEEHY+J7vA8qyP
 h2ptt6MLHZfBu6HxzeCxyTLypMto8s8Tg8AP89Yl2QYP5uRf5QWeBrJP5PVPhuidQW4f
 CSZQ==
X-Gm-Message-State: AOAM530oW6eZvzKI5d97dderDPFb8VNUp/q7LQxn+1hBpd/2hCJDlUzY
 idualW4C6t+8y+bbevjATtvzmkaSGlt6LGi7XDEp3VNHd6SYJpfAIdq4xFYsmDmrJnPSqxAmuqP
 euuxB3DWz9eLVXbYDdwMj/yAQRQ7MS/0=
X-Received: by 2002:a17:902:e54c:b029:124:5738:cd9b with SMTP id
 n12-20020a170902e54cb02901245738cd9bmr4032566plf.37.1624241001471; 
 Sun, 20 Jun 2021 19:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx8Jdi39fuUyMjJ1Kb1I8R8bWjY0P4PsRzQ0H9QhFuNwbpgfwmRCUN81esvdU5Up0p8pQdeA==
X-Received: by 2002:a17:902:e54c:b029:124:5738:cd9b with SMTP id
 n12-20020a170902e54cb02901245738cd9bmr4032535plf.37.1624241001191; 
 Sun, 20 Jun 2021 19:03:21 -0700 (PDT)
Received: from pc-0115 (35.112.198.104.bc.googleusercontent.com.
 [104.198.112.35])
 by smtp.gmail.com with ESMTPSA id jz10sm4710917pjb.4.2021.06.20.19.03.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Jun 2021 19:03:20 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
 (envelope-from <martinet@pc-0115>)
 id 1lv9HR-0013P4-QI; Mon, 21 Jun 2021 11:03:17 +0900
Date: Mon, 21 Jun 2021 11:03:07 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YM/zWyZlk1bzHWgI@atmark-techno.com>
References: <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
 <20210611062153.GA30906@lst.de> <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora> <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hJa3fgBh5wrqenuN"
Content-Disposition: inline
In-Reply-To: <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Peter Gonda <pgonda@google.com>, Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
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


--hJa3fgBh5wrqenuN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Jianxiong Gao wrote on Fri, Jun 18, 2021 at 11:01:59AM -0700:
> > Jianxiong Gao, before spending more time on this, could you also try
> > Chanho Park's patch?
> > https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d0df6490350a08dcc24c9086c8edc165b402d6f
> >
> I have tested Chanho Parks's patch and it works for us.
> The NVMe driver performs correctly with the patch.
> 
> I have teste the patch on 06af8679449d

Thanks!
(a bit late, but added Chanho Park in Cc...)

I can confirm it also works for our caam problem, as Horia said.

I've also come to term with the use of swiotlb_align_offset() through
testing, or rather many devices seem to have a 0 mask so it will almost
always be cancelled out, so if it works for Jianxiong then it's probably
good enough and I'll just assume that's how the orig_addr has been
designed...

I think it's missing a couple of checks like the one Linus had in his
patch, and would be comfortable with something like the attached patch
(in practice for me exactly the same as the original patch, except I've
added two checks: offsets smaller than orig addr offset are refused as
well as offsets bigger than the mapping size)

I'm sorry Jianxiong but would you be willing to take the time to test
again just to make sure there were no such offsets in your case?


If we're good with that I'll send it as an official v2 keeping Chanho's
from, unless he wants to.


Thanks everyone,
-- 
Dominique



--hJa3fgBh5wrqenuN
Content-Type: text/x-diff; charset=utf-8
Content-Description: swiotlb.patch
Content-Disposition: attachment; filename="swiotlb.patch"

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..23f8d0b168c5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -334,6 +334,14 @@ void __init swiotlb_exit(void)
 	io_tlb_default_mem = NULL;
 }
 
+/*
+ * Return the offset into a iotlb slot required to keep the device happy.
+ */
+static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
+{
+	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
+}
+
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
@@ -346,10 +354,31 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
+	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
+	orig_addr_offset = swiotlb_align_offset(dev, orig_addr);
+	if (tlb_offset < orig_addr_offset) {
+		dev_WARN_ONCE(dev, 1,
+			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
+			orig_addr_offset, tlb_offset);
+		return;
+	}
+
+	tlb_offset -= orig_addr_offset;
+	if (tlb_offset > alloc_size) {
+		dev_WARN_ONCE(dev, 1,
+			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
+			alloc_size, size, tlb_offset);
+		return;
+	}
+
+	orig_addr += tlb_offset;
+	alloc_size -= tlb_offset;
+
 	if (size > alloc_size) {
 		dev_WARN_ONCE(dev, 1,
 			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu.\n",
@@ -390,14 +419,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 
 #define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
 
-/*
- * Return the offset into a iotlb slot required to keep the device happy.
- */
-static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
-{
-	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
-}
-
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
  */

--hJa3fgBh5wrqenuN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--hJa3fgBh5wrqenuN--
