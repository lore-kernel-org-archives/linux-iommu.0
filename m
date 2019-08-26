Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2493DC3A59F
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 15:30:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE5C23405
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 15:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvuVyXHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE5C23405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A7A781893;
	Mon, 26 Aug 2019 15:30:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8D07F1880
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 15:28:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0D17542D
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 15:28:22 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id x4so15482514ljj.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=NL6fJrZIKeO5LGB29dZn2JLD+LBKfQdeed3wOTeWK7w=;
	b=NvuVyXHSK5exUD1YgfbCAfe8fX7FvWxN50g0xhgm48XRzkkAsV+gCA//2RnpvU5dt+
	VUQmPamsrQunReSVqYmvp2LjcSCffcgzRbEbIjKCzz7DrSLF6ebx196Q8oHuQ9HfKmZL
	8P++PXOWOhT98dGOums7Id+m06nPf5irwX0VvnGRuicr8hMj0HuNwAsH+tVr0qXQm3CM
	1Kyre+jnYiYwD86v+L9BRza8KmAC28aff/lUu90t0+xKq3mXJZrKsTLglEHylSy22Wqa
	YTgk0JWxHTmO8jwrcXUI47gT/ZJP6T8WzOIPPleh+MquZwl4LG7GOStKjolW3TqnTpYF
	bwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NL6fJrZIKeO5LGB29dZn2JLD+LBKfQdeed3wOTeWK7w=;
	b=R8gGz27ujUN6FOYwfh+0Az9Fi64BRFx5HuQvxMdo8J5WCLi4ocKKF6yWDunp004DhD
	DcUzkX3ZQC22KItsnWBrsHe4NEFXkFORxdO27yjG5rOwK6DMLSvzsfCVKtkzedssgTMM
	WPixRYg9QwCCgUbFKHt7x4I3BwC7dHyEA2dnQh0XrOFaP+n8tIDIK+kSVUutNQyvUWZu
	pJNwxdkvCIlUZtGP72gK/xuE0Fz+5iUUv07nGIvTT4myW0uASslladY3pgAYyg9UDg9Z
	m3TOEXtawgUQS/F1yBznAFkF7qBcXxZqW2SP+QqUD0wc1n4l0BW4cudRMm25l6RLPLuQ
	AIdw==
X-Gm-Message-State: APjAAAU5zi8BdXYiTsOlMSv3bW2xqV7IBwj8/9zWI1YiYYcWIuanLmZr
	GTTAZYStKvQYTgl/ipCBh2ZxWo5A
X-Google-Smtp-Source: APXvYqyN125me/ufP2gB3KH6hLVYyHqP5k4wmDOSNNvM8HI/uxSSqmN/fKMcvMHs/LE2mut6sluJcg==
X-Received: by 2002:a2e:8591:: with SMTP id b17mr10833631lji.200.1566833300226;
	Mon, 26 Aug 2019 08:28:20 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
	by smtp.googlemail.com with ESMTPSA id
	r12sm2404801ljg.36.2019.08.26.08.28.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Aug 2019 08:28:19 -0700 (PDT)
Subject: Re: [PATCH] media: staging: tegra-vde: Disable building with
	COMPILE_TEST
From: Dmitry Osipenko <digetx@gmail.com>
To: YueHaibing <yuehaibing@huawei.com>, mchehab@kernel.org,
	gregkh@linuxfoundation.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, robin.murphy@arm.com, hverkuil-cisco@xs4all.nl
References: <20190826133140.13456-1-yuehaibing@huawei.com>
	<58a8c62c-a45e-77e4-d2cb-99f95b847a73@gmail.com>
Message-ID: <79dacfcc-9407-bac6-8e9b-bb8f890994ee@gmail.com>
Date: Mon, 26 Aug 2019 18:28:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <58a8c62c-a45e-77e4-d2cb-99f95b847a73@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
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

MjYuMDguMjAxOSAxODoxOCwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gSGVsbG8gWXVl
LAo+IAo+IDI2LjA4LjIwMTkgMTY6MzEsIFl1ZUhhaWJpbmcg0L/QuNGI0LXRgjoKPj4gSWYgQ09N
UElMRV9URVNUIGlzIHkgYW5kIElPTU1VX1NVUFBPUlQgaXMgbiwgc2VsZWN0aW5nIFRFR1JBX1ZE
RQo+PiB0byBtIHdpbGwgc2V0IElPTU1VX0lPVkEgdG8gbSwgdGhpcyBmYWlscyB0aGUgYnVpbGRp
bmcgb2YKPj4gVEVHUkFfSE9TVDFYIGFuZCBEUk1fVEVHUkEgd2hpY2ggaXMgeSBsaWtlIHRoaXM6
Cj4+Cj4+IGRyaXZlcnMvZ3B1L2hvc3QxeC9jZG1hLm86IEluIGZ1bmN0aW9uIGBob3N0MXhfY2Rt
YV9pbml0JzoKPj4gY2RtYS5jOigudGV4dCsweDY2Yyk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YGFsbG9jX2lvdmEnCj4+IGNkbWEuYzooLnRleHQrMHg2OTgpOiB1bmRlZmluZWQgcmVmZXJlbmNl
IHRvIGBfX2ZyZWVfaW92YScKPj4KPj4gZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2RybS5vOiBJbiBm
dW5jdGlvbiBgdGVncmFfZHJtX3VubG9hZCc6Cj4+IGRybS5jOigudGV4dCsweGViMCk6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYHB1dF9pb3ZhX2RvbWFpbicKPj4gZHJtLmM6KC50ZXh0KzB4ZWI0
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgaW92YV9jYWNoZV9wdXQnCj4+Cj4+IFJlcG9ydGVk
LWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4KPj4gRml4ZXM6IDZiMjI2NTk3NTIz
OSAoIm1lZGlhOiBzdGFnaW5nOiB0ZWdyYS12ZGU6IEZpeCBidWlsZCBlcnJvciIpCj4+IEZpeGVz
OiBiMzAxZjhkZTE5MjUgKCJtZWRpYTogc3RhZ2luZzogbWVkaWE6IHRlZ3JhLXZkZTogQWRkIElP
TU1VIHN1cHBvcnQiKQo+PiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9LY29u
ZmlnIHwgNCArKy0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZk
ZS9LY29uZmlnIGIvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9LY29uZmlnCj4+IGlu
ZGV4IGJhNDllYTUuLmE0MWQzMGMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9tZWRp
YS90ZWdyYS12ZGUvS2NvbmZpZwo+PiArKysgYi9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEt
dmRlL0tjb25maWcKPj4gQEAgLTEsOSArMSw5IEBACj4+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wCj4+ICBjb25maWcgVEVHUkFfVkRFCj4+ICAJdHJpc3RhdGUgIk5WSURJQSBU
ZWdyYSBWaWRlbyBEZWNvZGVyIEVuZ2luZSBkcml2ZXIiCj4+IC0JZGVwZW5kcyBvbiBBUkNIX1RF
R1JBIHx8IENPTVBJTEVfVEVTVAo+PiArCWRlcGVuZHMgb24gQVJDSF9URUdSQQo+PiAgCXNlbGVj
dCBETUFfU0hBUkVEX0JVRkZFUgo+PiAtCXNlbGVjdCBJT01NVV9JT1ZBIGlmIChJT01NVV9TVVBQ
T1JUIHx8IENPTVBJTEVfVEVTVCkKPj4gKwlzZWxlY3QgSU9NTVVfSU9WQSBpZiBJT01NVV9TVVBQ
T1JUCj4+ICAJc2VsZWN0IFNSQU0KPj4gIAloZWxwCj4+ICAJICAgIFNheSBZIGhlcmUgdG8gZW5h
YmxlIHN1cHBvcnQgZm9yIHRoZSBOVklESUEgVGVncmEgdmlkZW8gZGVjb2Rlcgo+Pgo+IAo+IFdo
YXQgYWJvdXQgdGhpcyB2YXJpYW50Ogo+IAo+IAlzZWxlY3QgSU9NTVVfSU9WQSBpZiAoSU9NTVVf
U1VQUE9SVCAmJiAhQ09NUElMRV9URVNUKQo+IAo+IHdoaWNoIHNob3VsZCBmaXggdGhlIGJ1aWxk
aW5nIGFuZCBwcmVzZXJ2ZSBjb21waWxlLXRlc3RpbmcuCj4gCj4gSXQgc2hvdWxkbid0IG1hdHRl
ciBhdCBhbGwgd2hldGhlciBJT1ZBIGlzIGVuYWJsZWQgb3Igbm90IGZvcgo+IGNvbXBpbGUtdGVz
dGluZyBvZiB0aGUgZHJpdmVyLgo+IAoKQWgsIGFjdHVhbGx5IHRoaXMgd29uJ3Qgd29yayBpZiBU
RUdSQV9WREU9eSBhbmQgSU9NTVVfSU9WQT1tLiBJJ20gc3RpbGwKbm90IHN1cmUgdGhhdCBkaXNh
YmxpbmcgY29tcGlsZS10ZXN0aW5nIGlzIGEgZ29vZCBzb2x1dGlvbiwgbWF5YmUKRFJNX1RFR1JB
IGFuZCBURUdSQV9IT1NUMVggc2hvdWxkIGJlIGZpeGVkIGluc3RlYWQuIEFsdGhvdWdoLCBJJ20g
ZmluZQp3aXRoIGJvdGggdmFyaWFudHMuCgpBY2tlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdl
dHhAZ21haWwuY29tPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
