Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBE3FA3728
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 15:53:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986DA21A49
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 15:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="g/UCtlkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986DA21A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 526EBDA6;
	Wed, 16 Oct 2019 15:53:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D2E4ED98
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 15:53:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5B2BC89D
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 15:53:36 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id h126so23205746qke.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=oq8S8FNdMSuL/j2d44Hg8fdfb7pmW+shnprb4O6S0Ms=;
	b=g/UCtlklSOkAfjTb2IAewWlunaRFdtYuwHMWE8nNLQ52+TqEcZ1qL/XW462jg80nGS
	KgDr+S/7Ei+ZW3CubrhL/AZUB2dUkGZzRCsFdN2MVKjRJG/YjZqpH+PvFASc6LYmK0AV
	eBHPtw7EOXqppjPq93B0t0I97Ize+AuCMiLcqrngzlHh1rUiiBwrWIglzOyukM5QRquH
	WtjzZj5U379YG5DAQ5ONkHvx/Wv6zd7Mik+szBaEsyj3bQOex+aDDyWrcVE8wgvzxin0
	At9cChuOxbOABCJSuRc8svEWhU/2I+YbDjEnlbq2Dg2cU+GxIwZ/YCoyID/ZdzI2s8nP
	Cl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oq8S8FNdMSuL/j2d44Hg8fdfb7pmW+shnprb4O6S0Ms=;
	b=bC/zAFL6zdaZbKEnHgiRPVSpTVanmPCu970FSaaGKkwTapxWiKK3GqM82dnPxd9nJf
	KZE7EbHCjEuUvVx0dA1sQ3hzNcovQaMwhmNgA3Jnd6fMgIm7PmbPp/QQIFGrUJmkNAle
	aJGKx6SM4N6Vu7MPKrGWh5paMmRkWwkLi3VLgjwSB55pLHEryaJEjfr0J53aJ9DDsA5J
	FU3YyHUCKMfYliLFq6L3Y89jwVMZ2HRcWGBoaUANRArYI++69/f0LwGmB8uohVZqiP6h
	O7svurwmRcJph2RPn/b3s/0FA2ymxvTZWQv5/FBDbG2sWwqBUO5m/7A9mo4HjbYLc/Rr
	qAsQ==
X-Gm-Message-State: APjAAAWtV//bbF2TPadwYMp+nXDXdhAczWI+axxPrtW2Jda98ud0rm3F
	Frwb6f9hivikuOxDTodVmmL4Ow==
X-Google-Smtp-Source: APXvYqxrfQDTp4TMHFewBROXx/2TDqe/t+wvoX4f1U9HFPFkND2wBump3a4cR8SrdyIuEfiv6K6V2Q==
X-Received: by 2002:a37:2ec5:: with SMTP id u188mr41488023qkh.94.1571241215231;
	Wed, 16 Oct 2019 08:53:35 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	d10sm1683190qko.29.2019.10.16.08.53.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 16 Oct 2019 08:53:34 -0700 (PDT)
Message-ID: <1571241213.5937.64.camel@lca.pw>
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
From: Qian Cai <cai@lca.pw>
To: Joerg Roedel <jroedel@suse.de>
Date: Wed, 16 Oct 2019 11:53:33 -0400
In-Reply-To: <20191016153112.GF4695@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
	<1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Tom Murphy <murphyt7@tcd.ie>,
	linux-kernel@vger.kernel.org
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

T24gV2VkLCAyMDE5LTEwLTE2IGF0IDE3OjMxICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6Cj4g
SGkgUWlhbiwKPiAKPiB0aGFua3MgZm9yIHRoZSByZXBvcnQhCj4gCj4gT24gV2VkLCBPY3QgMTYs
IDIwMTkgYXQgMTA6NTk6NDJBTSAtMDQwMCwgUWlhbiBDYWkgd3JvdGU6Cj4gPiBPbiBXZWQsIDIw
MTktMTAtMTYgYXQgMTA6NTUgLTA0MDAsIFFpYW4gQ2FpIHdyb3RlOgo+ID4gPiBUb2RheSdzIGxp
bnV4LW5leHQgZ2VuZXJhdGVzIGEgbG90IG9mIHdhcm5pbmdzIG9uIG11bHRpcGxlIHNlcnZlcnMg
ZHVyaW5nIGJvb3QKPiA+ID4gZHVlIHRvIHRoZSBzZXJpZXMgImlvbW11L2FtZDogQ29udmVydCB0
aGUgQU1EIGlvbW11IGRyaXZlciB0byB0aGUgZG1hLWlvbW11IGFwaSIKPiA+ID4gWzFdLiBSZXZl
cnRlZCB0aGUgd2hvbGUgdGhpbmdzIGZpeGVkIHRoZW0uCj4gPiA+IAo+ID4gPiBbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDkwODE2NTY0Mi4yMjI1My0xLW11cnBoeXQ3QHRj
ZC5pZS8KPiA+ID4gCj4gPiAKPiA+IEJUVywgdGhlIHByZXZpb3VzIHg4NiB3YXJuaW5nIHdhcyBm
cm9tIG9ubHkgcmV2ZXJ0ZWQgb25lIHBhdGNoICJpb21tdTogQWRkIGdmcAo+ID4gcGFyYW1ldGVy
IHRvIGlvbW11X29wczo6bWFwIiB3aGVyZSBwcm92ZWQgdG8gYmUgaW5zdWZmaWNpZW50LiBOb3cs
IHBhc3RpbmcgdGhlCj4gPiBjb3JyZWN0IHdhcm5pbmcuCgpUaGUgeDg2IG9uZSBtaWdodCBqdXN0
IGJlIGEgbWlzdGFrZS4KCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIGIv
ZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYwppbmRleCBhZDA1NDg0ZDBjODAuLjYzYzRiODk0NzUx
ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYworKysgYi9kcml2ZXJzL2lv
bW11L2FtZF9pb21tdS5jCkBAIC0yNTQyLDcgKzI1NDIsNyBAQCBzdGF0aWMgaW50IGFtZF9pb21t
dV9tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tLAp1bnNpZ25lZCBsb25nIGlvdmEsCsKgwqDC
oMKgwqDCoMKgwqBpZiAoaW9tbXVfcHJvdCAmIElPTU1VX1dSSVRFKQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHByb3QgfD0gSU9NTVVfUFJPVF9JVzsKwqAKLcKgwqDCoMKgwqDCoMKg
cmV0ID0gaW9tbXVfbWFwX3BhZ2UoZG9tYWluLCBpb3ZhLCBwYWRkciwgcGFnZV9zaXplLCBwcm90
LCBHRlBfS0VSTkVMKTsKK8KgwqDCoMKgwqDCoMKgcmV0ID0gaW9tbXVfbWFwX3BhZ2UoZG9tYWlu
LCBpb3ZhLCBwYWRkciwgcGFnZV9zaXplLCBwcm90LCBnZnApOwrCoArCoMKgwqDCoMKgwqDCoMKg
ZG9tYWluX2ZsdXNoX25wX2NhY2hlKGRvbWFpbiwgaW92YSwgcGFnZV9zaXplKTsKClRoZSBhcm02
NCAtLSBkb2VzIGl0IGZvcmdldCB0byBkbyB0aGlzPwoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCmluZGV4IGVjYzA4YWVm
OWI1OC4uOGRkMGVmMDY1NmY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5j
CisrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKQEAgLTExODUsNyArMTE4NSw3IEBAIHN0
YXRpYyBzdHJ1Y3QgaW9tbXVfZG1hX21zaV9wYWdlCippb21tdV9kbWFfZ2V0X21zaV9wYWdlKHN0
cnVjdCBkZXZpY2UgKmRldiwKwqDCoMKgwqDCoMKgwqDCoGlmICghaW92YSkKwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9mcmVlX3BhZ2U7CsKgCi3CoMKgwqDCoMKgwqDC
oGlmIChpb21tdV9tYXAoZG9tYWluLCBpb3ZhLCBtc2lfYWRkciwgc2l6ZSwgcHJvdCkpCivCoMKg
wqDCoMKgwqDCoGlmIChpb21tdV9tYXBfYXRvbWljKGRvbWFpbiwgaW92YSwgbXNpX2FkZHIsIHNp
emUsIHByb3QpKQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2ZyZWVf
aW92YTsKwqAKwqDCoMKgwqDCoMKgwqDCoElOSVRfTElTVF9IRUFEKCZtc2lfcGFnZS0+bGlzdCk7
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
