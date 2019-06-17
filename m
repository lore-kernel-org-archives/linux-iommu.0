Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229B0C31E49
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 02:37:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05232089E
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 02:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3znGaqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05232089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A3316C6D;
	Mon, 17 Jun 2019 02:36:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9CADDB4B
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 02:36:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
	[209.85.160.175])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 27CC2E6
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 02:36:58 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id a15so9017309qtn.7
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=xwrHaBAQ4PIiRjCN9maPW3zKVAW4fgT9GFpBySgS+vY=;
	b=j3znGaqLHpxAXPt0s4/SrDpkcMy7T2JDq+EEDWJD4s4QtuS3VLMWAZmjRy7n9oy4Wc
	dH+E3+9btVundeHnOaSGutca3y/qhy50InZrUpC3RUN7L0Fx0EWaDQSOf5nIPT5HqTCs
	fMk7+Tzw2t6UyMAUJMSUufnJHMAfuml+X4vN2Z1fbwtEL/qtgOIjB2FjIut5HX4SdgdI
	miseZDTyKh8CHrxLx4rThcdCKHZ1ID++2l6+ffdXrSytrQt9RuhCsRIVIHf/DIODluTH
	CV+HPWDOUau63sWxFq27zYYUU3IHB208rtCOUmfovpeJdgvzsi6ulusD941Dxh8Gyoml
	vKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=xwrHaBAQ4PIiRjCN9maPW3zKVAW4fgT9GFpBySgS+vY=;
	b=KYTcbsbd3rAPeEHeTkR1o9hhtEPoBPA5PImJV7CBfLA1uLk0T3X0zc8yWZZaMrh4Nq
	zuJbuxb9uz4NheqHdNwey70JxkdsWcYShmZNZn/R7MoRCsrnBGAvGNRR/8ao6BqhY1Fs
	fS+mHGKbdxMCmlDnck1neEatC0GAEZebnrAXRtXibCS017Ygs6GGKaRsT5XYhlfcUJwi
	0AWJvCOzlS9/DW2g/HY1uecjw9KP0N1H0tSG6WP/XC5qdOXfh8dW1q4LhAkAyE7UbKdw
	8uk3eBVDfL9uQR/L3dqQbaFnUZwUNoxTNMvnQQEB3T8N4KVgpyno3p9kPimM41ZAQEH3
	0yXw==
X-Gm-Message-State: APjAAAWrudU/fl2dBHArFDjzcB07gtnXWV35Hdj1D4avUCVGX3jgItSk
	m3ITU2cXsXVE4kjoAqio0Ok9ddtdvxkhrfgdc/4=
X-Google-Smtp-Source: APXvYqzbJo9WCOEEnG1M9nfUvIjqxeMua1zxAfEuad5OV5asbi5wLhwB+ceabWvZWzSYLjm+HHbpp+1QfmTgdmdfs3Y=
X-Received: by 2002:ac8:7c7:: with SMTP id m7mr87020793qth.28.1560739017151;
	Sun, 16 Jun 2019 19:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190614100928.9791-1-hch@lst.de>
	<CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com>
	<20190614122143.GA26467@lst.de>
In-Reply-To: <20190614122143.GA26467@lst.de>
From: Greentime Hu <green.hu@gmail.com>
Date: Mon, 17 Jun 2019 10:36:21 +0800
Message-ID: <CAEbi=3dv=bfuFt0f3Pp4W8Cgir3zOO8gXO-5AYPgfZQF-g+yHw@mail.gmail.com>
Subject: Re: [RFC] switch nds32 to use the generic remapping DMA allocator
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Vincent Chen <deanbo422@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+IOaWvCAyMDE55bm0NuaciDE05pelIOmAseS6
lCDkuIvljYg4OjIy5a+r6YGT77yaCj4KPiBPbiBGcmksIEp1biAxNCwgMjAxOSBhdCAwNzozNToy
OVBNICswODAwLCBHcmVlbnRpbWUgSHUgd3JvdGU6Cj4gPiBJdCBsb29rcyBnb29kIHRvIG1lLiBJ
IGp1c3QgdmVyaWZpZWQgaW4gbmRzMzIgcGxhdGZvcm0gYW5kIGl0IHdvcmtzIGZpbmUuCj4gPiBT
aG91bGQgSSBwdXQgaXQgaW4gbXkgbmV4dC10cmVlIG9yIHlvdSB3aWxsIHBpY2sgaXQgdXAgaW4g
eW91ciB0cmVlPyA6KQo+Cj4gRWl0aGVyIHdheSB3b3JrcyBmb3IgbWUsIGxldCBtZSBrbm93IHdo
YXQgeW91IHByZWZlci4KCkkgcHJlZmVyIHRvIHB1dCBpbiB5b3VyIHRyZWUuIFRoYW5rcy4gOikK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
