Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C30C46477
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 16:55:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2682E2086A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 16:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OL1jUgfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2682E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E47E1D7C;
	Tue, 11 Jun 2019 16:55:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 09C35BDC
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 16:55:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
	[209.85.222.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 821E6887
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 16:55:05 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id c70so8086962qkg.7
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=76dGMyglhXIsHGduaiPit7Yovd6U12laTtR7hEdIMdc=;
	b=OL1jUgfL0jAs6zZk6ToeEaJbui6K/kJxO24Dras7vvbEwdw10HQlGQJmeKwxqw1RYI
	H9c2vHctd4kgnT/SYNlvHqIDxcgeBRtv5FyFEGu55DRXK+e4igcDbsYor7Jm6iiMTaMg
	szZ7Pvo4vAo2FdCKROGVBCWn3KwakSTNFyCUuVlVe63yMHoJn7sragF2fiIFTr/1MFMJ
	6/NDgbE2IxmbJNY66yce5ivyWvpzKxuhd6Zd8Hwd62wV6gEAKCbODj/FBWS1vyBGDyT2
	EROzl8WZUKYsjGSW65AAQYTt7rhCyvAO7FgJ5Mna4KKultQ9CNdvbXr32NrL6TO8aJ4Z
	ThKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=76dGMyglhXIsHGduaiPit7Yovd6U12laTtR7hEdIMdc=;
	b=HOA3AQcv6xDVRIfqtfXQPGL/wsqhSSb8A95BvDsipWIfApBS1Wk3XST/xdndHzBuIc
	oMlNabZO6V3nhFEkJ1nLmywczBaZp53BgZpMRIzjRyTFGHsiG9ZsP/djf0cjHcEIMm6B
	yaJ+y6EMG7ppCQ363g/jaXwsVN18wryfXuK4K3RYfjpYCqS4CNYKcPd+I6iAF0cxMykl
	1DD1CBDLr06HgnjzkoPftDXYLiYzM73hlx1KdQ9eEjVwmpSPg8wksfUErkKP7SejWS0f
	5+VGYhiviwpS44uOKkGBtKcTJnM4Xya4wogCCu5lBYv1JWf+iByacLu+g9lQLp4WHMKG
	nbog==
X-Gm-Message-State: APjAAAVtipohaOLarI9RgBCuGapVz716x3umZBK04VzMvZcje27Uqukd
	punhCF0ZEmNJ/Yb2bRZhLxO5qw==
X-Google-Smtp-Source: APXvYqzzOvJxoNk6oZBt7kaaRhFu3Q3TUFRBnhY1YkR+FSaESbk9O/SCseAezdGJ7aYDKNKo/Mz8sQ==
X-Received: by 2002:a37:670d:: with SMTP id b13mr59509027qkc.47.1560272104515; 
	Tue, 11 Jun 2019 09:55:04 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	t30sm6527461qkm.39.2019.06.11.09.55.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 11 Jun 2019 09:55:03 -0700 (PDT)
Message-ID: <1560272102.5154.1.camel@lca.pw>
Subject: Re: [PATCH 0/6] iommu/vt-d: Fixes and cleanups for linux-next
From: Qian Cai <cai@lca.pw>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>
Date: Tue, 11 Jun 2019 12:55:02 -0400
In-Reply-To: <20190609023803.23832-1-baolu.lu@linux.intel.com>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

T24gU3VuLCAyMDE5LTA2LTA5IGF0IDEwOjM3ICswODAwLCBMdSBCYW9sdSB3cm90ZToKPiBIaSBK
b2VyZywKPiAKPiBUaGlzIHNlcmllcyBpbmNsdWRlcyBzZXZlcmFsIGZpeGVzIGFuZCBjbGVhbnVw
cyBhZnRlciBkZWxlZ2F0aW5nCj4gRE1BIGRvbWFpbiB0byBnZW5lcmljIGlvbW11LiBQbGVhc2Ug
cmV2aWV3IGFuZCBjb25zaWRlciB0aGVtIGZvcgo+IGxpbnV4LW5leHQuCj4gCj4gQmVzdCByZWdh
cmRzLAo+IEJhb2x1Cj4gCj4gTHUgQmFvbHUgKDUpOgo+IMKgIGlvbW11L3Z0LWQ6IERvbid0IHJl
dHVybiBlcnJvciB3aGVuIGRldmljZSBnZXRzIHJpZ2h0IGRvbWFpbgo+IMKgIGlvbW11L3Z0LWQ6
IFNldCBkb21haW4gdHlwZSBmb3IgYSBwcml2YXRlIGRvbWFpbgo+IMKgIGlvbW11L3Z0LWQ6IERv
bid0IGVuYWJsZSBpb21tdSdzIHdoaWNoIGhhdmUgYmVlbiBpZ25vcmVkCj4gwqAgaW9tbXUvdnQt
ZDogRml4IHN1c3BpY2lvdXMgUkNVIHVzYWdlIGluIHByb2JlX2FjcGlfbmFtZXNwYWNlX2Rldmlj
ZXMoKQo+IMKgIGlvbW11L3Z0LWQ6IENvbnNvbGlkYXRlIGRvbWFpbl9pbml0KCkgdG8gYXZvaWQg
ZHVwbGljYXRpb24KPiAKPiBTYWkgUHJhbmVldGggUHJha2h5YSAoMSk6Cj4gwqAgaW9tbXUvdnQt
ZDogQ2xlYW51cCBhZnRlciBkZWxlZ2F0aW5nIERNQSBkb21haW4gdG8gZ2VuZXJpYyBpb21tdQo+
IAo+IMKgZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIHwgMjEwICsrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyks
IDE1NyBkZWxldGlvbnMoLSkKPiAKCkJUVywgdGhlIGxpbnV4LW5leHQgY29tbWl0ICJpb21tdS92
dC1kOiBFeHBvc2UgSVNBIGRpcmVjdCBtYXBwaW5nIHJlZ2lvbiB2aWEKaW9tbXVfZ2V0X3Jlc3Zf
cmVnaW9ucyIgWzFdIGFsc28gaW50cm9kdWNlZCBhIG1lbW9yeSBsZWFrIGJlbG93LCBhcyBpdCBm
b3JnZXRzCnRvIGFzayBpbnRlbF9pb21tdV9wdXRfcmVzdl9yZWdpb25zKCkgdG8gY2FsbCBrZnJl
ZSgpIHdoZW4KQ09ORklHX0lOVEVMX0lPTU1VX0ZMT1BQWV9XQT15LgoKWzFdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDc4OTYzLwoKdW5yZWZlcmVuY2VkIG9iamVj
dCAweGZmZmY4ODkxMmVmNzg5YzggKHNpemUgNjQpOgrCoCBjb21tICJzd2FwcGVyLzAiLCBwaWQg
MSwgamlmZmllcyA0Mjk0OTQ2MjMyIChhZ2UgNTM5OS41MzBzKQrCoCBoZXggZHVtcCAoZmlyc3Qg
MzIgYnl0ZXMpOgrCoMKgwqDCoDQ4IDgzIGY3IDJlIDkxIDg4IGZmIGZmIDMwIGZhIGUzIDAwIDgy
IDg4IGZmIGZmwqDCoEguLi4uLi4uMC4uLi4uLi4KwqDCoMKgwqAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMSAwMCAwMCAwMCAwMMKgwqAuLi4uLi4uLi4uLi4uLi4uCsKgIGJhY2t0
cmFjZToKwqDCoMKgwqBbPDAwMDAwMDAwZDI2N2Y0YmU+XSBrbWVtX2NhY2hlX2FsbG9jX3RyYWNl
KzB4MjY2LzB4MzgwCsKgwqDCoMKgWzwwMDAwMDAwMGQzODNkMTViPl0gaW9tbXVfYWxsb2NfcmVz
dl9yZWdpb24rMHg0MC8weGIwCsKgwqDCoMKgWzwwMDAwMDAwMGRiOGJlMzFiPl0gaW50ZWxfaW9t
bXVfZ2V0X3Jlc3ZfcmVnaW9ucysweDI1ZS8weDJkMArCoMKgwqDCoFs8MDAwMDAwMDAyMWZiYzZj
Mz5dIGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MrMHgxNTkvMHgzZDAKwqDCoMKg
wqBbPDAwMDAwMDAwMjIyNTkyNjg+XSBpb21tdV9ncm91cF9hZGRfZGV2aWNlKzB4MTdiLzB4NGYw
CsKgwqDCoMKgWzwwMDAwMDAwMDI4YjkxMDkzPl0gaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9kZXYrMHgx
NTMvMHg0NjAKwqDCoMKgwqBbPDAwMDAwMDAwNTc3YzMzYjQ+XSBpbnRlbF9pb21tdV9hZGRfZGV2
aWNlKzB4YzQvMHgyMTAKwqDCoMKgwqBbPDAwMDAwMDAwNTg3Yjc0OTI+XSBpb21tdV9wcm9iZV9k
ZXZpY2UrMHg2My8weDgwCsKgwqDCoMKgWzwwMDAwMDAwMDRhYTk5N2QxPl0gYWRkX2lvbW11X2dy
b3VwKzB4ZS8weDIwCsKgwqDCoMKgWzwwMDAwMDAwMGM5M2E5Y2Q2Pl0gYnVzX2Zvcl9lYWNoX2Rl
disweGYwLzB4MTUwCsKgwqDCoMKgWzwwMDAwMDAwMGEyZTVmMGNiPl0gYnVzX3NldF9pb21tdSsw
eGM2LzB4MTAwCsKgwqDCoMKgWzwwMDAwMDAwMGRiYWQ1ZGIwPl0gaW50ZWxfaW9tbXVfaW5pdCsw
eDY4Mi8weGIwYQrCoMKgwqDCoFs8MDAwMDAwMDAyMjZmNzQ0ND5dIHBjaV9pb21tdV9pbml0KzB4
MjYvMHg2MgrCoMKgwqDCoFs8MDAwMDAwMDAyZDg2OTRmNT5dIGRvX29uZV9pbml0Y2FsbCsweGU1
LzB4M2VhCsKgwqDCoMKgWzwwMDAwMDAwMDRiYzYwMTAxPl0ga2VybmVsX2luaXRfZnJlZWFibGUr
MHg1YWQvMHg2NDAKwqDCoMKgwqBbPDAwMDAwMDAwOTFiMGJhZDY+XSBrZXJuZWxfaW5pdCsweDEx
LzB4MTM4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
