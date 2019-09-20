Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEEBC4CEC9
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 22:26:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D142086A
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiX3xeQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D142086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 17BFFBBC;
	Fri, 20 Sep 2019 22:26:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A458DBA9
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 22:26:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AED82108
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 22:26:32 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id f5so8499406ljg.8
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=NCRwLUskdzV7gHTBmxNv4l39hBOLgSQ0mOSFdrxw3Z4=;
	b=oiX3xeQ0MNmmn5mM3EZkkEJkRlIy3l6sUSK6Bc0T7crcx0ziuZGRkuXypQJh7ZEOrh
	7ZSAWAE6uudRQPD2YI6d2gfbd90BQUiwsd7uBebVi75hQCxyMivAibyE/WPyRAS3Pzap
	+1/MgjgILz5Wvj3+ljs2MLCY1VVW4JTbBlscBmSsoo2tggbLnFAejToXHF6qQYgwBdnt
	HsSOSNQ+sAchY3R2WETinc0jkM0L+x8Ol6V3C4crjqeHX5o1LrZ55KEz7/4AzZu7CpZ9
	95+C7zJOYF6wZBBqmPwuaZcdT5ykBAtX+TjGX+NHq+vj9ioJiLl2qtVxB91+3O5ulNYO
	nzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NCRwLUskdzV7gHTBmxNv4l39hBOLgSQ0mOSFdrxw3Z4=;
	b=n+BSh5T27LMXuTLle0WDWCHWYZGDXY6I7dPpeizPAy4hV949onSQZ4HGB7JAiQZAWi
	CD2lztS/q9DdIHeRpFjLHoCmh6ueqKB1fp6aEcbtM1XgDVgQNzHUJgqADeg6M82Tox1T
	RxJcScAEVzY5KCjYkhcHae5WqLhljAQuhWauQjVuJl6zc4Gl5LDmaP0AP98Btz96pinq
	VJZpDPDFTSgfINTiHhhA4H/C9pV/KIAST9YHhclegiCNFRem6+i4XDWm2AgjUyPpC7TO
	v2MF41Xd//tTkSDyYarTSknKwIzBD3v1qUjIlAGXo7dd1b+1zvRP2uTzCwXSRAuFe1fn
	xg3Q==
X-Gm-Message-State: APjAAAVQJJFvSYJck3cHwagmgELBwI9ZgyHXJZNwhP+PHbL/RZUZUyP7
	5Rg0z9DWQCr5frduDz8BGRfY56Qp
X-Google-Smtp-Source: APXvYqwxm/7zrCbHka/7eCQpm/oQUiH78xadO7fAr2TpiKXlOB/a4hiVWmiEHeHIi9DYOPMS0IXkVw==
X-Received: by 2002:a05:651c:110f:: with SMTP id
	d15mr10653261ljo.43.1569018390799; 
	Fri, 20 Sep 2019 15:26:30 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.45.178])
	by smtp.googlemail.com with ESMTPSA id
	z30sm806218lfj.63.2019.09.20.15.26.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Sep 2019 15:26:29 -0700 (PDT)
Subject: Re: [PATCH] media: staging: tegra-vde: Fix build error
To: Arnd Bergmann <arnd@arndb.de>
References: <dc354ede-5963-cd7f-ee53-f3df3061d39a@gmail.com>
	<20190725024129.22664-1-yuehaibing@huawei.com>
	<dd547b44-7abb-371f-aeee-a82b96f824e2@gmail.com>
	<CAK8P3a2Lxv6Wz3jv0eeNc7mfvNzSvh37QEx51W39eUnYPsxaYw@mail.gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ed818d0c-2d5a-d9a4-e99d-43fe4eba4357@gmail.com>
Date: Sat, 21 Sep 2019 01:26:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Lxv6Wz3jv0eeNc7mfvNzSvh37QEx51W39eUnYPsxaYw@mail.gmail.com>
Content-Language: en-US
Cc: driverdevel <devel@driverdev.osuosl.org>,
	gregkh <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>
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

MjAuMDkuMjAxOSAyMjozMiwgQXJuZCBCZXJnbWFubiDQv9C40YjQtdGCOgo+IE9uIFRodSwgSnVs
IDI1LCAyMDE5IGF0IDI6MjQgUE0gRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPiB3
cm90ZToKPj4KPj4gMjUuMDcuMjAxOSA1OjQxLCBZdWVIYWliaW5nINC/0LjRiNC10YI6Cj4+PiBJ
ZiBJT01NVV9TVVBQT1JUIGlzIG5vdCBzZXQsIGFuZCBDT01QSUxFX1RFU1QgaXMgeSwKPj4+IElP
TU1VX0lPVkEgbWF5IGJlIHNldCB0byBtLiBTbyBidWlsZGluZyB3aWxsIGZhaWxzOgo+Pj4KPj4+
IGRyaXZlcnMvc3RhZ2luZy9tZWRpYS90ZWdyYS12ZGUvaW9tbXUubzogSW4gZnVuY3Rpb24gYHRl
Z3JhX3ZkZV9pb21tdV9tYXAnOgo+Pj4gaW9tbXUuYzooLnRleHQrMHg0MSk6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYGFsbG9jX2lvdmEnCj4+PiBpb21tdS5jOigudGV4dCsweDU2KTogdW5kZWZp
bmVkIHJlZmVyZW5jZSB0byBgX19mcmVlX2lvdmEnCj4+Pgo+Pj4gU2VsZWN0IElPTU1VX0lPVkEg
d2hpbGUgQ09NUElMRV9URVNUIGlzIHNldCB0byBmaXggdGhpcy4KPiAKPj4+IEBAIC0zLDcgKzMs
NyBAQCBjb25maWcgVEVHUkFfVkRFCj4+PiAgICAgICB0cmlzdGF0ZSAiTlZJRElBIFRlZ3JhIFZp
ZGVvIERlY29kZXIgRW5naW5lIGRyaXZlciIKPj4+ICAgICAgIGRlcGVuZHMgb24gQVJDSF9URUdS
QSB8fCBDT01QSUxFX1RFU1QKPj4+ICAgICAgIHNlbGVjdCBETUFfU0hBUkVEX0JVRkZFUgo+Pj4g
LSAgICAgc2VsZWN0IElPTU1VX0lPVkEgaWYgSU9NTVVfU1VQUE9SVAo+Pj4gKyAgICAgc2VsZWN0
IElPTU1VX0lPVkEgaWYgKElPTU1VX1NVUFBPUlQgfHwgQ09NUElMRV9URVNUKQo+Pj4gICAgICAg
c2VsZWN0IFNSQU0KPj4+ICAgICAgIGhlbHAKPj4+ICAgICAgICAgICBTYXkgWSBoZXJlIHRvIGVu
YWJsZSBzdXBwb3J0IGZvciB0aGUgTlZJRElBIFRlZ3JhIHZpZGVvIGRlY29kZXIKPj4+Cj4+Cj4+
IFRoaXMgcmVzdWx0cyBpbiBtaXNzaW5nIHRoZSBjYXNlIG9mIGNvbXBpbGUtdGVzdGluZyAhSU9N
TVVfSU9WQSBmb3IgdGhlCj4+IGRyaXZlciwgYnV0IHByb2JhYmx5IHRoYXQncyBub3QgYSBiaWcg
ZGVhbC4KPj4KPj4gQWNrZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4K
PiAKPiBJIGRvbid0IGtub3cgd2hhdCBoYXBwZW5lZCBoZXJlLCBidXQgdGhlIHBhdGNoIGZyb20g
WXVlSGFpYmluZyBjYXVzZWQgdGhpcwo+IGVycm9yIGZvciBtZSwgd2hpY2ggaXMgdmVyeSBtdWNo
IGxpa2UgdGhlIHByb2JsZW0gaXQgd2FzIG1lYW50IHRvIGZpeDoKPiAKPiBkcml2ZXJzL2dwdS9o
b3N0MXgvZGV2Lm86IEluIGZ1bmN0aW9uIGBob3N0MXhfcHJvYmUnOgo+IGRldi5jOigudGV4dCsw
eDE3MzQpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBwdXRfaW92YV9kb21haW4nCj4gZGV2LmM6
KC50ZXh0KzB4MTc0NCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGlvdmFfY2FjaGVfcHV0Jwo+
IGRyaXZlcnMvZ3B1L2hvc3QxeC9kZXYubzogSW4gZnVuY3Rpb24gYGhvc3QxeF9yZW1vdmUnOgo+
IGRldi5jOigudGV4dCsweDE4OTQpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBwdXRfaW92YV9k
b21haW4nCj4gZGV2LmM6KC50ZXh0KzB4MTg5OCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGlv
dmFfY2FjaGVfcHV0Jwo+IGRyaXZlcnMvZ3B1L2hvc3QxeC9jZG1hLm86IEluIGZ1bmN0aW9uIGBo
b3N0MXhfY2RtYV9pbml0JzoKPiBjZG1hLmM6KC50ZXh0KzB4NWQwKTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgYWxsb2NfaW92YScKPiBjZG1hLmM6KC50ZXh0KzB4NjFjKTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgX19mcmVlX2lvdmEnCj4gZHJpdmVycy9ncHUvaG9zdDF4L2NkbWEubzogSW4g
ZnVuY3Rpb24gYGhvc3QxeF9jZG1hX2RlaW5pdCc6Cj4gY2RtYS5jOigudGV4dCsweDZjOCk6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYGZyZWVfaW92YScKPiBkcml2ZXJzL2dwdS9ob3N0MXgvam9i
Lm86IEluIGZ1bmN0aW9uIGBob3N0MXhfam9iX3Bpbic6Cj4gam9iLmM6KC50ZXh0KzB4NTE0KTog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYWxsb2NfaW92YScKPiBqb2IuYzooLnRleHQrMHg1Mjgp
OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBfX2ZyZWVfaW92YScKPiBkcml2ZXJzL2dwdS9ob3N0
MXgvam9iLm86IEluIGZ1bmN0aW9uIGBob3N0MXhfam9iX3VucGluJzoKPiBqb2IuYzooLnRleHQr
MHg1YmMpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBmcmVlX2lvdmEnCj4gCj4gQWZ0ZXIgcmV2
ZXJ0aGluZyBjb21taXQgNmIyMjY1OTc1MjM5ICgibWVkaWE6IHN0YWdpbmc6Cj4gdGVncmEtdmRl
OiBGaXggYnVpbGQgZXJyb3IiKSwgSSBjYW4gbm8gbG9uZ2VyIHJlcHJvZHVjZSB0aGUKPiBpc3N1
ZS4KClRoZXJlIGlzIGEgZm9sbG93IHVwIGhlcmU6IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcGF0Y2gvMTE1MzE3Ni8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
