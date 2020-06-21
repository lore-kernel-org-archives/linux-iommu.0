Return-Path: <SRS0=X07A=AC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3008C433DF
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 04:00:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6731E206B7
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 04:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8LYsDYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6731E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 18C848914A;
	Sun, 21 Jun 2020 04:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wP3mIbd3wa8F; Sun, 21 Jun 2020 04:00:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82BB98907F;
	Sun, 21 Jun 2020 04:00:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71742C0178;
	Sun, 21 Jun 2020 04:00:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBDD4C016E
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 04:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BD3C2204CB
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 04:00:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQ5sQuVPi36i for <iommu@lists.linux-foundation.org>;
 Sun, 21 Jun 2020 04:00:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 5F6AF20483
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 04:00:26 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id d27so7741306lfq.5
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JltmKVlnuo/vC27A3oTu5+r3QU8IRKlE54WmVpTd+6k=;
 b=s8LYsDYdjxem9SLD1lfB4S3L0wgiHScLHWSjUkMidXktbmXmoFoTDBs1IbY2RwA2F1
 EXug365lNfpf1c5EIkE19nWURBfp1SgHgRH1JFN1Y73oUrRxuyh3mU1EYkLaX1ivi8bq
 UmiKqb7y0GNzxSjVlDxQiNIe0bJDKEUNZ35GUG6kdqE8kpW7gGT86lBkEgHc1ctOXksG
 mWPblnYPDRqHCY8twJXwNrXzYVqGeCSxNOFjQ44nD5tzTN/b1DWhf9g3x2Ck0oI78twV
 JgTgWEfLztztE4ybodOqRtpugw1CA0r/7k5o8A4kXuiMuFEbV34XN4QHJrAWORLAzTqH
 wMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JltmKVlnuo/vC27A3oTu5+r3QU8IRKlE54WmVpTd+6k=;
 b=JHYORXN0RHTfqlrQJ0LnhCNTHszkNRJ933x9pfFom9Ubp1gaugviAFwaMF+eC5GO4A
 ujIWWpVRHIIlghUbKZ9SjXZqX/0rec9ru5M9hc+qc3XTZvP1AQIT1GsKMsg8Mtfujr0h
 Or+LJK4+BBkRGR/aSHUqQIg/l+gAhXSlmPCNtW7aMc3q0eTSpkAY8dNZKx97h08jYWmb
 22Hn1TlTzwPE/JKf1tHa2QbomEYXuVMKowDY9XYDzXJLRFrtV66kJXAwL3r6lf3oZ4JJ
 +3fbCgFYobbQRX2pRhHtaEioeXIOd86GaS9y3URsfp6sYvhgqg2dZhRAgsPGw+4TjyTC
 klUg==
X-Gm-Message-State: AOAM531s8rfyGQyRENz4i+yui8/po5abAUwYq95dYh2M+h7Yja9gvVF3
 0yi4u7q/8SXMHYfNDWMgO3s=
X-Google-Smtp-Source: ABdhPJwGO/7Iq+BmdzJ4PpOIxZuoSlejYAADJkdbMtQDjpHquFlMxJiDBs2BDDHDfF88d7fV7xZ03Q==
X-Received: by 2002:ac2:44cd:: with SMTP id d13mr5970328lfm.13.1592712024386; 
 Sat, 20 Jun 2020 21:00:24 -0700 (PDT)
Received: from dimatab (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
 by smtp.gmail.com with ESMTPSA id b25sm1977654ljo.16.2020.06.20.21.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 21:00:24 -0700 (PDT)
Date: Sun, 21 Jun 2020 07:00:15 +0300
From: Dmitry Osipenko <digetx@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v7 31/36] staging: tegra-vde: fix common struct sg_table
 related issues
Message-ID: <20200621070015.0cf833ab@dimatab>
In-Reply-To: <20200619103636.11974-32-m.szyprowski@samsung.com>
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103714eucas1p18db6efd1a380fc0bdb16174ee85036fa@eucas1p1.samsung.com>
 <20200619103636.11974-32-m.szyprowski@samsung.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Cc: devel@driverdev.osuosl.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jonathan Hunter <jonathanh@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-tegra@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

0JIgRnJpLCAxOSBKdW4gMjAyMCAxMjozNjozMSArMDIwMApNYXJlayBTenlwcm93c2tpIDxtLnN6
eXByb3dza2lAc2Ftc3VuZy5jb20+INC/0LjRiNC10YI6Cgo+IFRoZSBEb2N1bWVudGF0aW9uL0RN
QS1BUEktSE9XVE8udHh0IHN0YXRlcyB0aGF0IHRoZSBkbWFfbWFwX3NnKCkKPiBmdW5jdGlvbiBy
ZXR1cm5zIHRoZSBudW1iZXIgb2YgdGhlIGNyZWF0ZWQgZW50cmllcyBpbiB0aGUgRE1BIGFkZHJl
c3MKPiBzcGFjZS4gSG93ZXZlciB0aGUgc3Vic2VxdWVudCBjYWxscyB0byB0aGUKPiBkbWFfc3lu
Y19zZ19mb3Jfe2RldmljZSxjcHV9KCkgYW5kIGRtYV91bm1hcF9zZyBtdXN0IGJlIGNhbGxlZCB3
aXRoCj4gdGhlIG9yaWdpbmFsIG51bWJlciBvZiB0aGUgZW50cmllcyBwYXNzZWQgdG8gdGhlIGRt
YV9tYXBfc2coKS4KPiAKPiBzdHJ1Y3Qgc2dfdGFibGUgaXMgYSBjb21tb24gc3RydWN0dXJlIHVz
ZWQgZm9yIGRlc2NyaWJpbmcgYQo+IG5vbi1jb250aWd1b3VzIG1lbW9yeSBidWZmZXIsIHVzZWQg
Y29tbW9ubHkgaW4gdGhlIERSTSBhbmQgZ3JhcGhpY3MKPiBzdWJzeXN0ZW1zLiBJdCBjb25zaXN0
cyBvZiBhIHNjYXR0ZXJsaXN0IHdpdGggbWVtb3J5IHBhZ2VzIGFuZCBETUEKPiBhZGRyZXNzZXMg
KHNnbCBlbnRyeSksIGFzIHdlbGwgYXMgdGhlIG51bWJlciBvZiBzY2F0dGVybGlzdCBlbnRyaWVz
Ogo+IENQVSBwYWdlcyAob3JpZ19uZW50cyBlbnRyeSkgYW5kIERNQSBtYXBwZWQgcGFnZXMgKG5l
bnRzIGVudHJ5KS4KPiAKPiBJdCB0dXJuZWQgb3V0IHRoYXQgaXQgd2FzIGEgY29tbW9uIG1pc3Rh
a2UgdG8gbWlzdXNlIG5lbnRzIGFuZAo+IG9yaWdfbmVudHMgZW50cmllcywgY2FsbGluZyBETUEt
bWFwcGluZyBmdW5jdGlvbnMgd2l0aCBhIHdyb25nIG51bWJlcgo+IG9mIGVudHJpZXMgb3IgaWdu
b3JpbmcgdGhlIG51bWJlciBvZiBtYXBwZWQgZW50cmllcyByZXR1cm5lZCBieSB0aGUKPiBkbWFf
bWFwX3NnKCkgZnVuY3Rpb24uCj4gCj4gVG8gYXZvaWQgc3VjaCBpc3N1ZXMsIGxldHMgdXNlIGEg
Y29tbW9uIGRtYS1tYXBwaW5nIHdyYXBwZXJzIG9wZXJhdGluZwo+IGRpcmVjdGx5IG9uIHRoZSBz
dHJ1Y3Qgc2dfdGFibGUgb2JqZWN0cyBhbmQgdXNlIHNjYXR0ZXJsaXN0IHBhZ2UKPiBpdGVyYXRv
cnMgd2hlcmUgcG9zc2libGUuIFRoaXMsIGFsbW9zdCBhbHdheXMsIGhpZGVzIHJlZmVyZW5jZXMg
dG8gdGhlCj4gbmVudHMgYW5kIG9yaWdfbmVudHMgZW50cmllcywgbWFraW5nIHRoZSBjb2RlIHJv
YnVzdCwgZWFzaWVyIHRvIGZvbGxvdwo+IGFuZCBjb3B5L3Bhc3RlIHNhZmUuCj4gCj4gU2lnbmVk
LW9mZi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgo+IFJl
dmlld2VkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvc3RhZ2luZy9tZWRpYS90ZWdyYS12ZGUvaW9tbXUuYyB8IDQgKystLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL2lvbW11LmMKPiBiL2RyaXZlcnMvc3Rh
Z2luZy9tZWRpYS90ZWdyYS12ZGUvaW9tbXUuYyBpbmRleAo+IDZhZjg2M2Q5MjEyMy4uYWRmOGRj
N2VlMjVjIDEwMDY0NCAtLS0KPiBhL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS90ZWdyYS12ZGUvaW9t
bXUuYyArKysKPiBiL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS90ZWdyYS12ZGUvaW9tbXUuYyBAQCAt
MzYsOCArMzYsOCBAQCBpbnQKPiB0ZWdyYV92ZGVfaW9tbXVfbWFwKHN0cnVjdCB0ZWdyYV92ZGUg
KnZkZSwgCj4gIAlhZGRyID0gaW92YV9kbWFfYWRkcigmdmRlLT5pb3ZhLCBpb3ZhKTsKPiAgCj4g
LQlzaXplID0gaW9tbXVfbWFwX3NnKHZkZS0+ZG9tYWluLCBhZGRyLCBzZ3QtPnNnbCwgc2d0LT5u
ZW50cywKPiAtCQkJICAgIElPTU1VX1JFQUQgfCBJT01NVV9XUklURSk7Cj4gKwlzaXplID0gaW9t
bXVfbWFwX3NndGFibGUodmRlLT5kb21haW4sIGFkZHIsIHNndCwKPiArCQkJCSBJT01NVV9SRUFE
IHwgSU9NTVVfV1JJVEUpOwo+ICAJaWYgKCFzaXplKSB7Cj4gIAkJX19mcmVlX2lvdmEoJnZkZS0+
aW92YSwgaW92YSk7Cj4gIAkJcmV0dXJuIC1FTlhJTzsKCkFoaCwgSSBzYXcgdGhlIGJ1aWxkIGZh
aWx1cmUgcmVwb3J0LiBZb3UncmUgY2hhbmdpbmcgdGhlIERNQSBBUEkgaW4KdGhpcyBzZXJpZXMs
IHdoaWxlIERNQSBBUEkgaXNuJ3QgdXNlZCBieSB0aGlzIGRyaXZlciwgaXQgdXNlcyBJT01NVQpB
UEkuIEhlbmNlIHRoZXJlIGlzIG5vIG5lZWQgdG8gdG91Y2ggdGhpcyBjb2RlLiBTaW1pbGFyIHBy
b2JsZW0gaW4gdGhlCmhvc3QxeCBkcml2ZXIgcGF0Y2guCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
