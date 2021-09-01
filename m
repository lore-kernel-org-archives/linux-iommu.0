Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC106C432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 11:32:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B22860F6C
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 11:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B22860F6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36407613A8;
	Wed,  1 Sep 2021 11:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id poPL_ZD4qhBK; Wed,  1 Sep 2021 11:32:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 38CBF60730;
	Wed,  1 Sep 2021 11:32:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5735C001A;
	Wed,  1 Sep 2021 11:32:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01E5EC000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 11:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE4ED4078F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 11:32:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4WaV0YxVuonA for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 11:32:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9081540783
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=xETUREejxUvl6a5dRIWIEFCqvkaaKABc39aXkgvr63Y=; b=vH2+/GPZVX8/y6zvjy1vfT0Qsy
 YX6og6+N2IaYDZu9VDj6T0IrRyQlhlZA95q/RukfN61MZQt4PnjkceBpr0kp5JLiqZiutI3eBaNzu
 sBlqrZPTwixSJOHB/6Yl89ySc95fqbCyNmaWkwKvgOEq53RexF3IiZZKtgKp/6TkM8qsfBr5xeInS
 o23ig7kSE1Xkrvy7wvHoQyCPO/o4u3Z+VntxIIv8NfqZa6vJRxLwapkIaQbEfsLhGtvbumg3IoUmp
 ZTglGsu9O4Iysh3Z76zNx9aVXKJhwJ9KamQLkiBc/JZLePzDa3Is8b+vBrVDrRR4GYFlM+rv3zuut
 e7DEksvw==;
Received: from [2001:4bb8:180:a30:2deb:705a:5588:bf7d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLOSp-002Eq0-9Q; Wed, 01 Sep 2021 11:31:48 +0000
Date: Wed, 1 Sep 2021 13:31:30 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for Linux 5.15
Message-ID: <YS9kkqNhU0TPA9Fr@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

W05vdGUgdGhhdCB0aGVyZSBpcyBhIGNvbmZsaWN0IHdpdGggY2hhbmdlcyBmcm9tIHRoZSBzd2lv
dGxiIHRyZWUgZHVlCiBkbWFfZGlyZWN0X3thbGxvYyxmcmVlfS4gIFRoZSBzb2x1dGlvbiBpcyB0
byBiYXNpY2FsbHkgdGFrZSB0aGUgY2hhbmdlcwogZnJvbSBib3RoIHRyZWVzIGFuZCBhcHBseSB0
aGVtIG1hbnVhbGx5Ll0KClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMzZhMjFk
NTE3MjVhZjJjZTA3MDBjNmViY2I2Yjk1OTRhYWM2NThhNjoKCiAgTGludXggNS4xNC1yYzUgKDIw
MjEtMDgtMDggMTM6NDk6MzEgLTA3MDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoKCiAgZ2l0Oi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL2RtYS1tYXBwaW5n
LmdpdCB0YWdzL2RtYS1tYXBwaW5nLTUuMTUKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
byBjMWRlYzM0M2Q3YWJkZjhlNzFhYWIyYTI4OWFiNDVjZThiMWFmYjdlOgoKICBoZXhhZ29uOiB1
c2UgdGhlIGdlbmVyaWMgZ2xvYmFsIGNvaGVyZW50IHBvb2wgKDIwMjEtMDgtMTkgMDk6MDI6NDAg
KzAyMDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCmRtYS1tYXBwaW5nIHVwZGF0ZXMgZm9yIExpbnV4IDUuMTUKCiAtIGZp
eCBkZWJ1Z2ZzIGluaXRpYWxpemF0aW9uIG9yZGVyIChBbnRob255IElsaW9wb3Vsb3MpCiAtIHVz
ZSBtZW1vcnlfaW50ZXJzZWN0cygpIGRpcmVjdGx5IChLZWZlbmcgV2FuZykKIC0gYWxsb3cgdG8g
cmV0dXJuIHNwZWNpZmljIGVycm9ycyBmcm9tIC0+bWFwX3NnCiAgIChMb2dhbiBHdW50aG9ycGUs
IE1hcnRpbiBPbGl2ZWlyYSkKIC0gdHVybiB0aGUgZG1hX21hcF9zZyByZXR1cm4gdmFsdWUgaW50
byBhbiB1bnNpZ25lZCBpbnQgKG1lKQogLSBwcm92aWRlIGEgY29tbW9uIGdsb2JhbCBjb2hlcmVu
dCBwb29sINGWbXBsZW1lbnRhdGlvbiAobWUpCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkFudGhvbnkgSWxpb3BvdWxvcyAo
MSk6CiAgICAgIGRtYS1kZWJ1ZzogZml4IGRlYnVnZnMgaW5pdGlhbGl6YXRpb24gb3JkZXIKCkNo
cmlzdG9waCBIZWxsd2lnICg4KToKICAgICAgZG1hLW1hcHBpbmc6IHJldHVybiBhbiB1bnNpZ25l
ZCBpbnQgZnJvbSBkbWFfbWFwX3NneyxfYXR0cnN9CiAgICAgIGRtYS1kaXJlY3Q6IGFkZCBzdXBw
b3J0IGZvciBkbWFfY29oZXJlbnRfZGVmYXVsdF9tZW1vcnkKICAgICAgQVJNL25vbW11OiB1c2Ug
dGhlIGdlbmVyaWMgZG1hLWRpcmVjdCBjb2RlIGZvciBub24tY29oZXJlbnQgZGV2aWNlcwogICAg
ICBkbWEtbWFwcGluZzogYWxsb3cgdXNpbmcgdGhlIGdsb2JhbCBjb2hlcmVudCBwb29sIGZvciAh
QVJNCiAgICAgIGRtYS1tYXBwaW5nOiBzaW1wbGlmeSBkbWFfaW5pdF9jb2hlcmVudF9tZW1vcnkK
ICAgICAgZG1hLW1hcHBpbmc6IGFkZCBhIGRtYV9pbml0X2dsb2JhbF9jb2hlcmVudCBoZWxwZXIK
ICAgICAgZG1hLW1hcHBpbmc6IG1ha2UgdGhlIGdsb2JhbCBjb2hlcmVudCBwb29sIGNvbmRpdGlv
bmFsCiAgICAgIGhleGFnb246IHVzZSB0aGUgZ2VuZXJpYyBnbG9iYWwgY29oZXJlbnQgcG9vbAoK
S2VmZW5nIFdhbmcgKDEpOgogICAgICBkbWEtZGVidWc6IHVzZSBtZW1vcnlfaW50ZXJzZWN0cygp
IGRpcmVjdGx5CgpMb2dhbiBHdW50aG9ycGUgKDEwKToKICAgICAgZG1hLW1hcHBpbmc6IGFsbG93
IG1hcF9zZygpIG9wcyB0byByZXR1cm4gbmVnYXRpdmUgZXJyb3IgY29kZXMKICAgICAgZG1hLWRp
cmVjdDogcmV0dXJuIGFwcHJvcHJpYXRlIGVycm9yIGNvZGUgZnJvbSBkbWFfZGlyZWN0X21hcF9z
ZygpCiAgICAgIGlvbW11OiByZXR1cm4gZnVsbCBlcnJvciBjb2RlIGZyb20gaW9tbXVfbWFwX3Nn
W19hdG9taWNdKCkKICAgICAgaW9tbXUvZG1hOiByZXR1cm4gZXJyb3IgY29kZSBmcm9tIGlvbW11
X2RtYV9tYXBfc2coKQogICAgICBBUk0vZG1hLW1hcHBpbmc6IGRvbid0IHNldCBmYWlsZWQgc2cg
ZG1hX2FkZHJlc3MgdG8gRE1BX01BUFBJTkdfRVJST1IKICAgICAgcG93ZXJwYy9pb21tdTogZG9u
J3Qgc2V0IGZhaWxlZCBzZyBkbWFfYWRkcmVzcyB0byBETUFfTUFQUElOR19FUlJPUgogICAgICBz
MzkwL3BjaTogZG9uJ3Qgc2V0IGZhaWxlZCBzZyBkbWFfYWRkcmVzcyB0byBETUFfTUFQUElOR19F
UlJPUgogICAgICBzcGFyYy9pb21tdTogZG9uJ3Qgc2V0IGZhaWxlZCBzZyBkbWFfYWRkcmVzcyB0
byBETUFfTUFQUElOR19FUlJPUgogICAgICB4ODYvYW1kX2dhcnQ6IGRvbid0IHNldCBmYWlsZWQg
c2cgZG1hX2FkZHJlc3MgdG8gRE1BX01BUFBJTkdfRVJST1IKICAgICAgZG1hLW1hcHBpbmc6IGRp
c2FsbG93IC5tYXBfc2cgb3BlcmF0aW9ucyBmcm9tIHJldHVybmluZyB6ZXJvIG9uIGVycm9yCgpN
YXJ0aW4gT2xpdmVpcmEgKDExKToKICAgICAgYWxwaGE6IHJldHVybiBlcnJvciBjb2RlIGZyb20g
YWxwaGFfcGNpX21hcF9zZygpCiAgICAgIEFSTS9kbWEtbWFwcGluZzogcmV0dXJuIGVycm9yIGNv
ZGUgZnJvbSAubWFwX3NnKCkgb3BzCiAgICAgIGlhNjQvc2JhX2lvbW11OiByZXR1cm4gZXJyb3Ig
Y29kZSBmcm9tIHNiYV9tYXBfc2dfYXR0cnMoKQogICAgICBNSVBTL2phenpkbWE6IHJldHVybiBl
cnJvciBjb2RlIGZyb20gamF6el9kbWFfbWFwX3NnKCkKICAgICAgcG93ZXJwYy9pb21tdTogcmV0
dXJuIGVycm9yIGNvZGUgZnJvbSAubWFwX3NnKCkgb3BzCiAgICAgIHMzOTAvcGNpOiByZXR1cm4g
ZXJyb3IgY29kZSBmcm9tIHMzOTBfZG1hX21hcF9zZygpCiAgICAgIHNwYXJjL2lvbW11OiByZXR1
cm4gZXJyb3IgY29kZXMgZnJvbSAubWFwX3NnKCkgb3BzCiAgICAgIHBhcmlzYzogcmV0dXJuIGVy
cm9yIGNvZGUgZnJvbSAubWFwX3NnKCkgb3BzCiAgICAgIHhlbjogc3dpb3RsYjogcmV0dXJuIGVy
cm9yIGNvZGUgZnJvbSB4ZW5fc3dpb3RsYl9tYXBfc2coKQogICAgICB4ODYvYW1kX2dhcnQ6IHJl
dHVybiBlcnJvciBjb2RlIGZyb20gZ2FydF9tYXBfc2coKQogICAgICBkbWEtbWFwcGluZzogcmV0
dXJuIGVycm9yIGNvZGUgZnJvbSBkbWFfZHVtbXlfbWFwX3NnKCkKCiBhcmNoL2FscGhhL2tlcm5l
bC9wY2lfaW9tbXUuYyAgICAgICAgICAgfCAgMTAgKy0KIGFyY2gvYXJtL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNSArLQogYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmctbm9tbXUu
YyAgICAgICAgIHwgMTczICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBhcmNoL2Fy
bS9tbS9kbWEtbWFwcGluZy5jICAgICAgICAgICAgICAgfCAgMjYgKysrLS0KIGFyY2gvaGV4YWdv
bi9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiBhcmNoL2hleGFnb24va2VybmVs
L2RtYS5jICAgICAgICAgICAgICAgfCAgNTcgKystLS0tLS0tLS0KIGFyY2gvaWE2NC9ocC9jb21t
b24vc2JhX2lvbW11LmMgICAgICAgICB8ICAgNCArLQogYXJjaC9taXBzL2phenovamF6emRtYS5j
ICAgICAgICAgICAgICAgIHwgICAyICstCiBhcmNoL3Bvd2VycGMva2VybmVsL2lvbW11LmMgICAg
ICAgICAgICAgfCAgIDYgKy0KIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHMzL3N5c3RlbS1idXMu
YyB8ICAgMiArLQogYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3Zpby5jICAgIHwgICA1
ICstCiBhcmNoL3MzOTAvcGNpL3BjaV9kbWEuYyAgICAgICAgICAgICAgICAgfCAgMTMgKy0tCiBh
cmNoL3NwYXJjL2tlcm5lbC9pb21tdS5jICAgICAgICAgICAgICAgfCAgIDYgKy0KIGFyY2gvc3Bh
cmMva2VybmVsL3BjaV9zdW40di5jICAgICAgICAgICB8ICAgNiArLQogYXJjaC9zcGFyYy9tbS9p
b21tdS5jICAgICAgICAgICAgICAgICAgIHwgICAyICstCiBhcmNoL3g4Ni9rZXJuZWwvYW1kX2dh
cnRfNjQuYyAgICAgICAgICAgfCAgMTggKystLQogZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYyAg
ICAgICAgICAgICAgIHwgIDIyICsrLS0KIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyAgICAgICAgICAg
ICAgICAgICB8ICAxNSArKy0KIGRyaXZlcnMvcGFyaXNjL2NjaW8tZG1hLmMgICAgICAgICAgICAg
ICB8ICAgMiArLQogZHJpdmVycy9wYXJpc2Mvc2JhX2lvbW11LmMgICAgICAgICAgICAgIHwgICAy
ICstCiBkcml2ZXJzL3hlbi9zd2lvdGxiLXhlbi5jICAgICAgICAgICAgICAgfCAgIDIgKy0KIGlu
Y2x1ZGUvbGludXgvZG1hLW1hcC1vcHMuaCAgICAgICAgICAgICB8ICAyMyArKystLQogaW5jbHVk
ZS9saW51eC9kbWEtbWFwcGluZy5oICAgICAgICAgICAgIHwgIDQ0ICsrKy0tLS0tCiBpbmNsdWRl
L2xpbnV4L2lvbW11LmggICAgICAgICAgICAgICAgICAgfCAgMjIgKystLQoga2VybmVsL2RtYS9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsKIGtlcm5lbC9kbWEvY29oZXJlbnQu
YyAgICAgICAgICAgICAgICAgICB8IDE2MSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQog
a2VybmVsL2RtYS9kZWJ1Zy5jICAgICAgICAgICAgICAgICAgICAgIHwgIDIxICsrLS0KIGtlcm5l
bC9kbWEvZGlyZWN0LmMgICAgICAgICAgICAgICAgICAgICB8ICAxNyArKystCiBrZXJuZWwvZG1h
L2R1bW15LmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KIGtlcm5lbC9kbWEvbWFwcGlu
Zy5jICAgICAgICAgICAgICAgICAgICB8ICA4MCArKysrKysrKysrKysrLS0KIDMwIGZpbGVzIGNo
YW5nZWQsIDMxMCBpbnNlcnRpb25zKCspLCA0NDMgZGVsZXRpb25zKC0pCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
