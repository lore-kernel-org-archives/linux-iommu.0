Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796C8C3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 07:44:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B9E2339F
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 07:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B9E2339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CF4167F6;
	Wed, 21 Aug 2019 07:44:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 744EE8BF
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 06:01:09 +0000 (UTC)
X-Greylist: delayed 00:05:22 by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 73A76F8
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 06:01:08 +0000 (UTC)
Received: from [192.168.1.162] ([37.4.249.106]) by mrelayeu.kundenserver.de
	(mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
	1MCsHm-1i99IC3CKm-008qJZ; Wed, 21 Aug 2019 07:55:16 +0200
Subject: Re: Build regression in Linux 5.3-rc5 with CONFIG_XEN=y
To: Stefan Wahren <wahrenst@gmx.net>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>
References: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
	<825549ed-8aa4-b418-8812-15a9d3cc153e@arm.com>
	<0b019cdc-6f0e-c37f-2be7-c24293acb8cd@gmx.net>
	<20190820012415.GA21178@lst.de>
	<a69cce68-8c41-2030-b011-cdfacfeae421@gmx.net>
From: Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
	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
	AQ==
Message-ID: <0b4f05ab-6cc1-7805-ea99-021c2bdd41be@i2se.com>
Date: Wed, 21 Aug 2019 07:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a69cce68-8c41-2030-b011-cdfacfeae421@gmx.net>
Content-Language: en-US
X-Provags-ID: V03:K1:5l7VBDgpOJDI0RmlUxEEh9yD93ucKczDQT+mnPI3NwYI4Y9BAGG
	M+zrsuC5glSpY8JCd/8y2igRGT8+wUYKFDOulsUGJA9rB7BRp6z5zldDx4HhLz7BnvELNUj
	CCNxDROT+tg02BySZLXhKWSVfrvV8+3lNZOyOjr5Zek4wDjForjgQOjWd0OVGzqfD0DxS7b
	m5oRymYX+Ok63wuPWrmpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SZ4FFN91GZc=:r9eWKL2zi1QdYefhvGUin7
	qah4KhIsHLTtsvmejYbyOrNlrT/TfWpv5sSSq+fJ84DcwO6EesqJhFDfwJXZ8/nEeTomuQvHe
	gpygU6m2nuhJZ/GUa6uX2ghYPmFrd+NoANMHr63R0canj1tB40jwHe7JIFUUzTuptO19XwU5S
	/ImD5g13BiqhOjgIoPmBvC66iRRAhkbEXf4wwlP7UFqSa7fbyT3bMDGnXxI9OItPFxdgakd5k
	31o7E8k7sj+JwaDsyie72WYoUdtcSP3Gc5kHk10V1zU0pwO+DaV/8KL1xx0aZ/b32CfnfdQq1
	tohy9emcpbUrDbnfcshsVFfMDrStI4ilyGFhncUiyKifLeJRWRl+fbRNBnabBU9d+14pXKiyQ
	fATAS6U85FcWt3kQXqZb5PZW5Vhnz+cIc5Xt+eAG5oITv9qpLmPKx8Nc8pHDURVwaQZgXe1gi
	gMQWoD9X1rjY4b5fc7F7x+RxXwjiCt+pmf4OSSXKfkg6kuVKLPdM7PRpC+AUyTyDlsyIf1owF
	RjrKWrufLItyqHbFTRpAN7oeQ5f65V/3OnkyC4pZZ6fyBG1Py/eoSyOaW0RkHF39tszPsBT2v
	L++x9JaQf9h42HGX13hiGxsawK5oGhAzEargdNWvPFMioShat6EsWpE4AmatH/XPxdRkMNPVJ
	bvvogTy6jNlKcNqJ5IELlFhVlxJGwKH0sA30KXs+92f9/GbUYA7dfm8nTxdYXj/mBYjxCqUrD
	+uijylfFJt0QUI/OXDMiaQwFMejohvB9FaZzGiLoPnhpCHOPRlWvNAC6t+s=
X-Mailman-Approved-At: Wed, 21 Aug 2019 07:44:15 +0000
Cc: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
	iommu@lists.linux-foundation.org, Ian Jackson <ian.jackson@citrix.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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

SGkgQmpvcm4sCmhpIFN0ZXBoZW4sCgpBbSAyMC4wOC4xOSB1bSAwNzo0MyBzY2hyaWViIFN0ZWZh
biBXYWhyZW46Cj4gSGkgQ2hyaXN0b3BoLAo+Cj4gQW0gMjAuMDguMTkgdW0gMDM6MjQgc2Nocmll
YiBDaHJpc3RvcGggSGVsbHdpZzoKPj4gSGkgU3RlZmFuLAo+Pgo+PiBwbGVhc2UgdHJ5IHRoZSBw
YXRjaCBiZWxvdy4KPj4KPj4gLS0tCj4+IEZyb20gZTA1NzA2MjhkOTZmYWE1MGViZmM5NGNlOGU1
NDU5NjgzMzZkYjIyNSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKPj4gRnJvbTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4+IERhdGU6IFR1ZSwgMjAgQXVnIDIwMTkgMTA6MDg6Mzgg
KzA5MDAKPj4gU3ViamVjdDogYXJtOiBzZWxlY3QgdGhlIGRtYS1ub25jb2hlcmVudCBzeW1ib2xz
IGZvciBhbGwgc3dpb3RsYiBidWlsZHMKPj4KPj4gV2UgbmVlZCB0byBwcm92aWRlIHRoZSBhcmNo
IGhvb2tzIGZvciBub24tY29oZXJlbnQgZG1hLWRpcmVjdAo+PiBhbmQgc3dpb3RsYiBmb3IgYWxs
IHN3aW90bGIgYnVpbGRzLCBub3QganVzdCB3aGVuIExQQVMgaXMgZW5hYmxlZC4KPiBzL0xQQVMv
TFBBRS8KPj4gV2l0aG91dCB0aGF0IHRoZSBYZW4gYnVpbGQgdGhhdCBzZWxlY3RzIFNXSU9UTEIg
aW5kaXJlY3RseSB0aHJvdWdoCj4+IFNXSU9UTEJfWEVOIGZhaWxzIHRvIGJ1aWxkLgo+Pgo+PiBG
aXhlczogYWQzYzdiMThjNWIzICgiYXJtOiB1c2Ugc3dpb3RsYiBmb3IgYm91bmNlIGJ1ZmZlcmlu
ZyBvbiBMUEFFIGNvbmZpZ3MiKQo+PiBSZXBvcnRlZC1ieTogU3RlZmFuIFdhaHJlbiA8d2FocmVu
c3RAZ214Lm5ldD4KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+Cj4gaSBhcHBsaWVkIHRoaXMgcGF0Y2ggYW5kIGl0IGZpeGVzIHRoZSBidWlsZCBpc3N1ZSBp
IHJlcG9ydGVkIGJlZm9yZS4gQnV0Cj4gdGhpcyBzZWVtcyB0byByZXZlYWwgYW5vdGhlciBidWls
ZCBpc3N1ZSBpbiBkcml2ZXJzL2Zpcm13YXJlL3Fjb21fc2NtLmM6Cj4KPiBkcml2ZXJzL2Zpcm13
YXJlL3Fjb21fc2NtLmM6IEluIGZ1bmN0aW9uIOKAmHFjb21fc2NtX2Fzc2lnbl9tZW3igJk6Cj4g
ZHJpdmVycy9maXJtd2FyZS9xY29tX3NjbS5jOjQ2MDo0NzogZXJyb3I6IHBhc3NpbmcgYXJndW1l
bnQgMyBvZgo+IOKAmGRtYV9hbGxvY19jb2hlcmVudOKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2lu
dGVyIHR5cGUKPiBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KPiDCoCBwdHIg
PSBkbWFfYWxsb2NfY29oZXJlbnQoX19zY20tPmRldiwgcHRyX3N6LCAmcHRyX3BoeXMsIEdGUF9L
RVJORUwpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF4KPiBJbiBmaWxl
IGluY2x1ZGVkIGZyb20gZHJpdmVycy9maXJtd2FyZS9xY29tX3NjbS5jOjEyOjA6Cj4gLi9pbmNs
dWRlL2xpbnV4L2RtYS1tYXBwaW5nLmg6NjM2OjIxOiBub3RlOiBleHBlY3RlZCDigJhkbWFfYWRk
cl90ICoge2FrYQo+IGxvbmcgbG9uZyB1bnNpZ25lZCBpbnQgKn3igJkgYnV0IGFyZ3VtZW50IGlz
IG9mIHR5cGUg4oCYcGh5c19hZGRyX3QgKiB7YWthCj4gdW5zaWduZWQgaW50ICp94oCZCj4gwqBz
dGF0aWMgaW5saW5lIHZvaWQgKmRtYV9hbGxvY19jb2hlcmVudChzdHJ1Y3QgZGV2aWNlICpkZXYs
IHNpemVfdCBzaXplLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Xn5+fn5+fn5+fn5+fn5+fn5+Cj4gY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMg
ZXJyb3JzCj4gc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyODA6IGRpZSBSZWdlbCBmw7xyIFppZWwK
PiDigJ5kcml2ZXJzL2Zpcm13YXJlL3Fjb21fc2NtLm/igJwgc2NoZWl0ZXJ0ZQo+Cj4gTHVja2ls
eSB0aGVyZSBpcyBhbHJlYWR5IGEgcGF0Y2ggdG8gZml4IHRoaXMgaW4gbGludXgtbmV4dDoKPgo+
IGZpcm13YXJlOiBxY29tX3NjbTogVXNlIHByb3BlciB0eXBlcyBmb3IgZG1hIG1hcHBpbmdzCmNv
dWxkIHlvdSBwbGVhc2UgdGFrZSBjYXJlIHRoYXQgdGhpcyBwYXRjaCBpcyBhcHBsaWVkIHRvIDUu
My1maXhlcz8KPgo+IEl0IHNlZW1zIHRoYXQgaXQgbWlzc2VzIHRoZSBmaXhlcyB0YWcuCj4KPiBS
ZWdhcmRzCj4gU3RlZmFuCj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
