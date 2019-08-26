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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A4AC3A59F
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 15:20:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A0220828
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD954qxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A0220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 75C67182E;
	Mon, 26 Aug 2019 15:20:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CAACB1828
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 15:18:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 252F31FB
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 15:18:51 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id n19so12550909lfe.13
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=50mv38tNDYl/ZA4wnFVjnzU9tnzotrbGWCLUfU9Ss9U=;
	b=DD954qxFZhSRbJXXAWT8UGI78Qw8ddSTsJ57rK3XJ2/Wkv3WEez0EMD7YmJN/2ZyOa
	lHwom4XrlZmbf1KZeQLf7asnloWFOOVQf5xcoWVTpcs1szbaGxrmsAO0GkI3d+aVs+tS
	45DW701tM8vydRxSmqzFNoVGNFbONfoNF0eFihwp/hHhOgmbmtHCvxq0ShKSH9bK4uVZ
	lWRizjWpZp076tU3UDHdesfEOgSmRxcFr2Q3vf20XLtbKjWauLGo6ia5FwENMqkF2Pnt
	2si39G/XXBu4K0XjMggmMk0bTE/w5zakucAW0rL5geUPbRtC+zO8WmLsph6xVKz/nJqS
	Q4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=50mv38tNDYl/ZA4wnFVjnzU9tnzotrbGWCLUfU9Ss9U=;
	b=T7stJBVKks7DcnhYOnMQOvJ2O3708e+MLG+vV4lSYRqn9l8viqMfDQERwxXSbL5NJh
	QnoPmZ76ydGHrOqjGC3rhLyqOEVEy4pEqV3atrPS8z+Anx6InBESpu6E/LSSXGEeAyyx
	y+X9ZgWsnD8rmzL82CP+iEbmqafgqYOyyBUb91z/94dPPvHte+E4sJdWnY8TOcPv5hdF
	04YS3Dv/ZwwJvVwV9XKjWJAIT3qY0Fep6fjJI1Y8VbKAGmSFmysRyQlfIybRw3QhmV/h
	XyOnx0IU+MNgzejSO76RhSAT7WDQFbFsqLB7tK3LrztTE/F0VczhQvAj2DDdfUqIO42p
	fa0A==
X-Gm-Message-State: APjAAAUAjzVQfRb+mt4jSxnBkA4WJLIBtlrlNZTko4bdTPG3hKcSJohy
	NFvGtKuI7M2ymihoZ1vfXUK/JxHC
X-Google-Smtp-Source: APXvYqxwBaKVRDZOzhOVbJvIe3ncrV9/xEPeURbvLz9/UhsnEu7vyFngUol6rQSCZMHo+7dD8ZFuQg==
X-Received: by 2002:a19:674d:: with SMTP id e13mr11176375lfj.176.1566832729324;
	Mon, 26 Aug 2019 08:18:49 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
	by smtp.googlemail.com with ESMTPSA id
	m74sm2356165lje.72.2019.08.26.08.18.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Aug 2019 08:18:48 -0700 (PDT)
Subject: Re: [PATCH] media: staging: tegra-vde: Disable building with
	COMPILE_TEST
To: YueHaibing <yuehaibing@huawei.com>, mchehab@kernel.org,
	gregkh@linuxfoundation.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, robin.murphy@arm.com, hverkuil-cisco@xs4all.nl
References: <20190826133140.13456-1-yuehaibing@huawei.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <58a8c62c-a45e-77e4-d2cb-99f95b847a73@gmail.com>
Date: Mon, 26 Aug 2019 18:18:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826133140.13456-1-yuehaibing@huawei.com>
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

SGVsbG8gWXVlLAoKMjYuMDguMjAxOSAxNjozMSwgWXVlSGFpYmluZyDQv9C40YjQtdGCOgo+IElm
IENPTVBJTEVfVEVTVCBpcyB5IGFuZCBJT01NVV9TVVBQT1JUIGlzIG4sIHNlbGVjdGluZyBURUdS
QV9WREUKPiB0byBtIHdpbGwgc2V0IElPTU1VX0lPVkEgdG8gbSwgdGhpcyBmYWlscyB0aGUgYnVp
bGRpbmcgb2YKPiBURUdSQV9IT1NUMVggYW5kIERSTV9URUdSQSB3aGljaCBpcyB5IGxpa2UgdGhp
czoKPiAKPiBkcml2ZXJzL2dwdS9ob3N0MXgvY2RtYS5vOiBJbiBmdW5jdGlvbiBgaG9zdDF4X2Nk
bWFfaW5pdCc6Cj4gY2RtYS5jOigudGV4dCsweDY2Yyk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YGFsbG9jX2lvdmEnCj4gY2RtYS5jOigudGV4dCsweDY5OCk6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYF9fZnJlZV9pb3ZhJwo+IAo+IGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9kcm0ubzogSW4gZnVu
Y3Rpb24gYHRlZ3JhX2RybV91bmxvYWQnOgo+IGRybS5jOigudGV4dCsweGViMCk6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYHB1dF9pb3ZhX2RvbWFpbicKPiBkcm0uYzooLnRleHQrMHhlYjQpOiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBpb3ZhX2NhY2hlX3B1dCcKPiAKPiBSZXBvcnRlZC1ieTog
SHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+Cj4gRml4ZXM6IDZiMjI2NTk3NTIzOSAoIm1l
ZGlhOiBzdGFnaW5nOiB0ZWdyYS12ZGU6IEZpeCBidWlsZCBlcnJvciIpCj4gRml4ZXM6IGIzMDFm
OGRlMTkyNSAoIm1lZGlhOiBzdGFnaW5nOiBtZWRpYTogdGVncmEtdmRlOiBBZGQgSU9NTVUgc3Vw
cG9ydCIpCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29t
Pgo+IC0tLQo+ICBkcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL0tjb25maWcgfCA0ICsr
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9LY29uZmlnIGIv
ZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS9LY29uZmlnCj4gaW5kZXggYmE0OWVhNS4u
YTQxZDMwYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL0tj
b25maWcKPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL0tjb25maWcKPiBA
QCAtMSw5ICsxLDkgQEAKPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+ICBj
b25maWcgVEVHUkFfVkRFCj4gIAl0cmlzdGF0ZSAiTlZJRElBIFRlZ3JhIFZpZGVvIERlY29kZXIg
RW5naW5lIGRyaXZlciIKPiAtCWRlcGVuZHMgb24gQVJDSF9URUdSQSB8fCBDT01QSUxFX1RFU1QK
PiArCWRlcGVuZHMgb24gQVJDSF9URUdSQQo+ICAJc2VsZWN0IERNQV9TSEFSRURfQlVGRkVSCj4g
LQlzZWxlY3QgSU9NTVVfSU9WQSBpZiAoSU9NTVVfU1VQUE9SVCB8fCBDT01QSUxFX1RFU1QpCj4g
KwlzZWxlY3QgSU9NTVVfSU9WQSBpZiBJT01NVV9TVVBQT1JUCj4gIAlzZWxlY3QgU1JBTQo+ICAJ
aGVscAo+ICAJICAgIFNheSBZIGhlcmUgdG8gZW5hYmxlIHN1cHBvcnQgZm9yIHRoZSBOVklESUEg
VGVncmEgdmlkZW8gZGVjb2Rlcgo+IAoKV2hhdCBhYm91dCB0aGlzIHZhcmlhbnQ6CgoJc2VsZWN0
IElPTU1VX0lPVkEgaWYgKElPTU1VX1NVUFBPUlQgJiYgIUNPTVBJTEVfVEVTVCkKCndoaWNoIHNo
b3VsZCBmaXggdGhlIGJ1aWxkaW5nIGFuZCBwcmVzZXJ2ZSBjb21waWxlLXRlc3RpbmcuCgpJdCBz
aG91bGRuJ3QgbWF0dGVyIGF0IGFsbCB3aGV0aGVyIElPVkEgaXMgZW5hYmxlZCBvciBub3QgZm9y
CmNvbXBpbGUtdGVzdGluZyBvZiB0aGUgZHJpdmVyLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
