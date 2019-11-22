Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD4C432C3
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 14:59:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8000820706
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 14:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XbGG7IUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8000820706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4CB5D88A98;
	Fri, 22 Nov 2019 14:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VdWnjjuuKe+b; Fri, 22 Nov 2019 14:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC8F0888B0;
	Fri, 22 Nov 2019 14:59:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC810C1DD8;
	Fri, 22 Nov 2019 14:59:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37FAFC18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 14:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 259CA8825F
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 14:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8xJ-0NMJVHl4 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 14:59:24 +0000 (UTC)
X-Greylist: delayed 12:04:02 by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3A99288217
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 14:59:24 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id m125so6496355qkd.8
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=czmRFawPbRA4wPPyXKr/45ohSDBaFeSUF30l90PueKM=;
 b=XbGG7IUMCmvWd+2Zfh4Z0zzCFA2YV9Yk+qwUrcoqfwiSOEtswc8NG0bzARjBR78kiH
 hLb8AV81UBoA8FtccPYG4v/yLV//ZNkm1u3EEzcciUrmcKt6ohVHbE/f/ctoKSBy/ASi
 Z9XsVYrMHoPtFkr3OVpIlc7TvtjnA8BtHxI72MjvHJnn03urkucOhHS3B87CpoTzlP+O
 cdRJcMcmTCp7vvt5aQhm21ls6lvUhdZmRKnraFhGm3/NnVk9FbP1v0Shmy7/aByw8ohz
 JK4k7eow7o64LXPM5WE2cQN0KV8APCyDDkZYfDiRkOCosZWeF1FAFLaJ/20UPDf7t0Ag
 T0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=czmRFawPbRA4wPPyXKr/45ohSDBaFeSUF30l90PueKM=;
 b=L9uA+FbsMN3UejHThkbSHtmX1oHV4Db3jSvegKp1iOdR0mx6XAM5bpD0dwI9qxHQGU
 PCkzhq7M/lIB8b9WzGUuozn2eilziPJyjfSU4QGA/1jpnl9DSM3Y+JRNUcPZgTuMN8JS
 itbmGuBsrGPB6vHY73OSCqX+QZqvudZr1Nf2G6rcz5WxL0hQLhEtNSSPpOHbRhT6KEIb
 TZOx9yn+egKCwTZ8fuCRDIWKO7LJWqYryR/eemRmoQyXnpbVjCevNyBrqQPkhvOgQ/mf
 ezCritHzFB/LVF/gnbuw2SZ1rkF4jP2lT5QNferVZKqOVHhTrA1fXjdb+ku9pze1FGxt
 ApZw==
X-Gm-Message-State: APjAAAWTP+sZYubwbvmuOgSoWdAfPuFJR3cjTzsbzkqcXiHQiFZQWefT
 pEngquEUd9FguvZ027Fbrrmd8w==
X-Google-Smtp-Source: APXvYqxM/Mq/oZx9N3SQRd4yH7GRI8jHA57x9C0cgRY6OyHUe5QZyZcJZVN9LAmaC1fIu8T/1NRQWA==
X-Received: by 2002:a37:a642:: with SMTP id p63mr5872287qke.85.1574434763130; 
 Fri, 22 Nov 2019 06:59:23 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id j89sm3496929qte.72.2019.11.22.06.59.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Nov 2019 06:59:22 -0800 (PST)
Message-ID: <1574434760.9585.18.camel@lca.pw>
Subject: Re: [PATCH v2] iommu/iova: silence warnings under memory pressure
From: Qian Cai <cai@lca.pw>
To: Joe Perches <joe@perches.com>, jroedel@suse.de
Date: Fri, 22 Nov 2019 09:59:20 -0500
In-Reply-To: <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
References: <20191122025510.4319-1-cai@lca.pw>
 <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
 linux-kernel@vger.kernel.org
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

T24gVGh1LCAyMDE5LTExLTIxIGF0IDIwOjM3IC0wODAwLCBKb2UgUGVyY2hlcyB3cm90ZToKPiBP
biBUaHUsIDIwMTktMTEtMjEgYXQgMjE6NTUgLTA1MDAsIFFpYW4gQ2FpIHdyb3RlOgo+ID4gV2hl
biBydW5uaW5nIGhlYXZ5IG1lbW9yeSBwcmVzc3VyZSB3b3JrbG9hZHMsIHRoaXMgNSsgb2xkIHN5
c3RlbSBpcwo+ID4gdGhyb3dpbmcgZW5kbGVzcyB3YXJuaW5ncyBiZWxvdyBiZWNhdXNlIGRpc2sg
SU8gaXMgdG9vIHNsb3cgdG8gcmVjb3Zlcgo+ID4gZnJvbSBzd2FwcGluZy4gU2luY2UgdGhlIHZv
bHVtZSBmcm9tIGFsbG9jX2lvdmFfZmFzdCgpIGNvdWxkIGJlIGxhcmdlLAo+ID4gb25jZSBpdCBj
YWxscyBwcmludGsoKSwgaXQgd2lsbCB0cmlnZ2VyIGRpc2sgSU8gKHdyaXRpbmcgdG8gdGhlIGxv
Zwo+ID4gZmlsZXMpIGFuZCBwZW5kaW5nIHNvZnRpcnFzIHdoaWNoIGNvdWxkIGNhdXNlIGFuIGlu
ZmluaXRlIGxvb3AgYW5kIG1ha2UKPiA+IG5vIHByb2dyZXNzIGZvciBkYXlzIGJ5IHRoZSBvbmdv
aW1uZyBtZW1vcnkgcmVjbGFpbS4gVGhpcyBpcyB0aGUgY291bnRlcgo+ID4gcGFydCBmb3IgSW50
ZWwgd2hlcmUgdGhlIEFNRCBwYXJ0IGhhcyBhbHJlYWR5IGJlZW4gbWVyZ2VkLiBTZWUgdGhlCj4g
PiBjb21taXQgM2Q3MDg4OTUzMjViICgiaW9tbXUvYW1kOiBTaWxlbmNlIHdhcm5pbmdzIHVuZGVy
IG1lbW9yeQo+ID4gcHJlc3N1cmUiKS4gU2luY2UgdGhlIGFsbG9jYXRpb24gZmFpbHVyZSB3aWxs
IGJlIHJlcG9ydGVkIGluCj4gPiBpbnRlbF9hbGxvY19pb3ZhKCksIHNvIGp1c3QgY2FsbCBwcmlu
dGtfcmF0ZWxpbXRlZCgpIHRoZXJlIGFuZCBzaWxlbmNlCj4gPiB0aGUgb25lIGluIGFsbG9jX2lv
dmFfbWVtKCkgdG8gYXZvaWQgdGhlIGV4cGVuc2l2ZSB3YXJuX2FsbG9jKCkuCj4gCj4gW10KPiA+
IHYyOiB1c2UgZGV2X2Vycl9yYXRlbGltaXRlZCgpIGFuZCBpbXByb3ZlIHRoZSBjb21taXQgbWVz
c2FnZXMuCj4gCj4gW10KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11
LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMKPiAKPiBbXQo+ID4gQEAgLTM0MDEsNyAr
MzQwMSw4IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGludGVsX2FsbG9jX2lvdmEoc3RydWN0IGRl
dmljZSAqZGV2LAo+ID4gIAlpb3ZhX3BmbiA9IGFsbG9jX2lvdmFfZmFzdCgmZG9tYWluLT5pb3Zh
ZCwgbnJwYWdlcywKPiA+ICAJCQkJICAgSU9WQV9QRk4oZG1hX21hc2spLCB0cnVlKTsKPiA+ICAJ
aWYgKHVubGlrZWx5KCFpb3ZhX3BmbikpIHsKPiA+IC0JCWRldl9lcnIoZGV2LCAiQWxsb2NhdGlu
ZyAlbGQtcGFnZSBpb3ZhIGZhaWxlZCIsIG5ycGFnZXMpOwo+ID4gKwkJZGV2X2Vycl9yYXRlbGlt
aXRlZChkZXYsICJBbGxvY2F0aW5nICVsZC1wYWdlIGlvdmEgZmFpbGVkIiwKPiA+ICsJCQkJICAg
IG5ycGFnZXMpOwo+IAo+IFRyaXZpYToKPiAKPiBUaGlzIHNob3VsZCByZWFsbHkgaGF2ZSBhIFxu
IHRlcm1pbmF0aW9uIG9uIHRoZSBmb3JtYXQgc3RyaW5nCj4gCj4gCQlkZXZfZXJyX3JhdGVsaW1p
dGVkKGRldiwgIkFsbG9jYXRpbmcgJWxkLXBhZ2UgaW92YSBmYWlsZWRcbiIsCj4gCj4gCgpXaHkg
ZG8geW91IHNheSBzbz8gSXQgaXMgcmlnaHQgbm93IHByaW50aW5nIHdpdGggYSBuZXdsaW5lIGFk
ZGVkIGFueXdheS4KCsKgaHBzYSAwMDAwOjAzOjAwLjA6IERNQVI6IEFsbG9jYXRpbmcgMS1wYWdl
IGlvdmEgZmFpbGVkCsKgaHBzYSAwMDAwOjAzOjAwLjA6IERNQVI6IEFsbG9jYXRpbmcgMS1wYWdl
IGlvdmEgZmFpbGVkCsKgaHBzYSAwMDAwOjAzOjAwLjA6IERNQVI6IEFsbG9jYXRpbmcgMS1wYWdl
IGlvdmEgZmFpbGVkCsKgaHBzYSAwMDAwOjAzOjAwLjA6IERNQVI6IEFsbG9jYXRpbmcgMS1wYWdl
IGlvdmEgZmFpbGVkCsKgaHBzYSAwMDAwOjAzOjAwLjA6IERNQVI6IEFsbG9jYXRpbmcgMS1wYWdl
IGlvdmEgZmFpbGVkCsKgaHBzYSAwMDAwOjAzOjAwLjA6IERNQVI6IEFsbG9jYXRpbmcgMS1wYWdl
IGlvdmEgZmFpbGVkCsKgaHBzYSAwMDAwOjAzOjAwLjA6IERNQVI6IEFsbG9jYXRpbmcgMS1wYWdl
IGlvdmEgZmFpbGVkCsKgaHBzYSAwMDAwOjAzOjAwLjA6IERNQVI6IEFsbG9jYXRpbmcgMS1wYWdl
IGlvdmEgZmFpbGVkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
