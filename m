Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B36C54FC9
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 02:14:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF4B2087E
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 02:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WZTr54ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF4B2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E0B58568D;
	Mon, 20 Apr 2020 02:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njvmcuymM0R4; Mon, 20 Apr 2020 02:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A40685608;
	Mon, 20 Apr 2020 02:14:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2D56C07FF;
	Mon, 20 Apr 2020 02:14:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90A26C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 02:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7D0558568D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 02:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WdqJaTXx8Ozm for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 02:14:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A9F0B85608
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 02:14:26 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id w24so7282919qts.11
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 19:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=yqjihutydDvQo11dTTaNbqLtFlhQeTAYw+F5rbSQSTA=;
 b=WZTr54niV8KeWypn7ohk85mM+004n48qWbS3qzgRnG4uRgWPrUgAS9R9KMuerDsyrW
 S1V9BI7cHOyWWxkUWIt5vexMXgGCK2phpmXMEqCt5O3epB7fFPwJtCAq2vl8eP0xZjY/
 qilgCSpIjU8OcSqzleGt1xR8TB75YHaWU7TtU6nvSxATYbE85F/M2LzxNYT5eeRkM0PE
 5Zm4ZOw5nEhy3UOMiDrXIlgHp+FyNXVNWoMhKNOu1sAgFfgz72TRLrSseL7F24ttDKZW
 Xy4x9BB+2FlnhPmVzsjQY+wT2bvk2GA00rR7aVjyRkJR+EoWjz1eT+H7IErIP/qGZz+/
 PBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=yqjihutydDvQo11dTTaNbqLtFlhQeTAYw+F5rbSQSTA=;
 b=lpARF0yrq5DM/a1G7fTbAOkhq0S3Bae57cq1akIcvKTZKU3Eexk3BzDEILSszUEiE1
 ElUFeWGY7i/Kl79np/4La/Nm18GwzeypRCZJ3e50YCWPXEJBY2ykDw/9KIHqMfoc1Zrp
 oKObQGZj7ZZvNY3otAQSYGDYDtLr1C5Gb63vgwhd/6iUD4pKJg91MSueZJw8Eyhm6LXA
 EsFHi7f0KlMLq8H3me3ol7OmamaD1HFYmwBunW/na+FjeQVKlRstjR3pRbqtCGpWOADj
 FUASAd1bEfGxUSupLXBWGierrX8mmte+4Dh2ATEXaDvCNlfqskb+TyTA0IFmWS2RqMC1
 K+jA==
X-Gm-Message-State: AGi0PuaokmftTVDwc7gidDQqHUB2Sf3NNrTtFTUzMLtJn/SUOOZNNeaD
 aDCFweJaMwgrrNFlOn/oBDTmYrnwOG2XdQ==
X-Google-Smtp-Source: APiQypLgQElZuN6XHG32UaZDzLy9QHj15+TowgyKg8sizZ9OTdaCKxTJpslCMyzP0V4aUbsgYyQKew==
X-Received: by 2002:a37:4d5:: with SMTP id 204mr14240558qke.176.1587348442429; 
 Sun, 19 Apr 2020 19:07:22 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id v27sm14242935qtb.35.2020.04.19.19.07.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 19 Apr 2020 19:07:21 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20200418183429.GH21900@8bytes.org>
Date: Sun, 19 Apr 2020 22:07:19 -0400
Message-Id: <3733C20F-46C0-4C4F-9E37-94D361377D51@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Cgo+IE9uIEFwciAxOCwgMjAyMCwgYXQgMjozNCBQTSwgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRl
cy5vcmc+IHdyb3RlOgo+IAo+IE9uIFNhdCwgQXByIDE4LCAyMDIwIGF0IDA5OjAxOjM1QU0gLTA0
MDAsIFFpYW4gQ2FpIHdyb3RlOgo+PiBIYXJkIHRvIHRlbGwgd2l0aG91dCB0ZXN0aW5nIGZ1cnRo
ZXIuIEnigJlsbCBsZWF2ZSB0aGF0IG9wdGltaXphdGlvbiBpbgo+PiB0aGUgZnV0dXJlLCBhbmQg
Zm9jdXMgb24gZml4aW5nIHRob3NlIHJhY2VzIGZpcnN0Lgo+IAo+IFllYWggcmlnaHQsIHdlIHNo
b3VsZCBmaXggdGhlIGV4aXN0aW5nIHJhY2VzIGZpcnN0IGJlZm9yZSBpbnRyb2R1Y2luZwo+IG5l
dyBvbmVzIDspCj4gCj4gQnR3LCBUSEFOS1MgQSBMT1QgZm9yIHRyYWNraW5nIGRvd24gYWxsIHRo
ZXNlIHJhY2UgY29uZGl0aW9uIGJ1Z3MsIEkgYW0KPiBub3QgZXZlbiByZW1vdGVseSBhYmxlIHRv
IHRyaWdnZXIgdGhlbSB3aXRoIHRoZSBoYXJkd2FyZSBJIGhhdmUgYXJvdW5kLgo+IAo+IEkgZGlk
IHNvbWUgaGFja2luZyBhbmQgdGhlIGF0dGFjaGVkIGRpZmYgc2hvd3MgaG93IEkgdGhpbmsgdGhp
cyByYWNlCj4gY29uZGl0aW9uIG5lZWRzIHRvIGJlIGZpeGVkLiBJIGJvb3QtdGVzdGVkIHRoaXMg
Zml4IG9uLXRvcCBvZiB2NS43LXJjMSwKPiBidXQgZGlkIG5vIGZ1cnRoZXIgdGVzdGluZy4gQ2Fu
IHlvdSB0ZXN0IGl0IHBsZWFzZT8KClN1cmUsIGdpdmUgaXQgYSBmZXcgZGF5cyB0byBzZWUgaWYg
aXQgY291bGQgc3Vydml2ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
