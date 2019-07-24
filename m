Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF8EC7618F
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:10:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645D522ADC
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxpmsx6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645D522ADC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 47CF5B8F;
	Wed, 24 Jul 2019 14:10:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8BD60B6D
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:09:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CE34AFE
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:09:57 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id q26so32096246lfc.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=5TDhFld/eHS7IYB60yUBetfgICBgTmFxknVZGppAKVY=;
	b=cxpmsx6uLdsw/bi3AUvQq74Ww0ft0zqDkE3E2M0XpOcl4d8LkUCY8osX8eCgUmAuJo
	97osGTWiQotVc/jqUlLU0HkmnJ5tieJdvz396iTeiMa58ryVZVqapLIe0Hav+EgFyMmU
	+9eGt90wvLTF5BvibV1Q21U7szJSArumW31ZMaX/R3yOQhnAAINOGAuXC2OAt6vJOopV
	d38MxAXLa0p/5Jz8uUSvB3RRWjK9PQbhHVqec5YHlbcGcSb98m6CrYlIkhdC0gEIG+mv
	vCbBpGLuo3S2lEI4ud7o0gzMjt9rWzuQG5fT3ZAHKzdluYnmIgvwSdawdsIsE/28pABs
	hmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5TDhFld/eHS7IYB60yUBetfgICBgTmFxknVZGppAKVY=;
	b=s4H3baHaUiV3rPhqlm4yBXQjhjv559xiOIP9LZONo+ZrJmKAJz/88bfRQ7OhXC872l
	sdS+kE3j9qM2FblDUVTnV3UXmbo1hQoPTUuPpLDGbdAHkhpsOvIQVsj12SB1nI/Z59kj
	TzeHrfZq8z9uR+ylbA0dsBjATlZ1vdUpcc3rlBRlEM1HHANB0vNcUPvZzNp/BJh2alMC
	V8f710i67muBKiA8vpIJoEeRz1m8OT4NexOeeUx5t4EhW2IOl+TpY/57TgYVdEgAfeZ7
	FQ4bAZu8taA4XJYUlUP7/LdY8nzQER+dYHBCPCi0dW0DTiKWt2U3lvPCZE2GVO6tevNA
	C0LQ==
X-Gm-Message-State: APjAAAVJWz4uV/50VcTYhRFe7Bcj9LuFeEIRzq4Kzb9cEhgqsErSLikO
	iQu7kMnP72JpmqR4XCFHUXg=
X-Google-Smtp-Source: APXvYqxK1fG+r2FGv25yZ1DPzjciv2L5EMqpAScm54D7ySJTLFckDaUho8RmvveLM6wOUsw87x2pvw==
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr27772968lfm.87.1563977396265; 
	Wed, 24 Jul 2019 07:09:56 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru.
	[91.78.220.99]) by smtp.googlemail.com with ESMTPSA id
	c12sm6989583lfj.58.2019.07.24.07.09.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Jul 2019 07:09:55 -0700 (PDT)
Subject: Re: [PATCH] media: staging: ipu3: Enable IOVA API only when IOMMU
	support is enabled
To: Yuehaibing <yuehaibing@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20190722134749.21580-1-yuehaibing@huawei.com>
	<20190724103027.GD21370@paasikivi.fi.intel.com>
	<e48fc180-06cc-eac7-d8ca-9be1699c8677@arm.com>
	<0c08bdae-facc-0f28-0e58-17a65172587a@huawei.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <491dbca1-8a58-b26e-cf56-a1a419da288f@gmail.com>
Date: Wed, 24 Jul 2019 17:09:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0c08bdae-facc-0f28-0e58-17a65172587a@huawei.com>
Content-Language: en-US
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	yong.zhi@intel.com, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
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

MjQuMDcuMjAxOSAxNzowMywgWXVlaGFpYmluZyDQv9C40YjQtdGCOgo+IE9uIDIwMTkvNy8yNCAy
MTo0OSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyNC8wNy8yMDE5IDExOjMwLCBTYWthcmkg
QWlsdXMgd3JvdGU6Cj4+PiBIaSBZdWUsCj4+Pgo+Pj4gT24gTW9uLCBKdWwgMjIsIDIwMTkgYXQg
MDk6NDc6NDlQTSArMDgwMCwgWXVlSGFpYmluZyB3cm90ZToKPj4+PiBJZiBJT01NVV9TVVBQT1JU
IGlzIG5vdCBzZXQsIGlwdTMgZHJpdmVyIG1heSBzZWxlY3QgSU9NTVVfSU9WQSB0byBtLgo+Pj4+
IEJ1dCBmb3IgbWFueSBkcml2ZXJzLCB0aGV5IHVzZSAic2VsZWN0IElPTU1VX0lPVkEgaWYgSU9N
TVVfU1VQUE9SVCIKPj4+PiBpbiB0aGUgS2NvbmZpZywgZm9yIGV4YW1wbGUsIENPTkZJR19URUdS
QV9WREUgaXMgc2V0IHRvIHkgYnV0IElPTU1VX0lPVkEKPj4+PiBpcyBtLCB0aGVuIHRoZSBidWls
ZGluZyBmYWlscyBsaWtlIHRoaXM6Cj4+Pj4KPj4+PiBkcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVn
cmEtdmRlL2lvbW11Lm86IEluIGZ1bmN0aW9uIGB0ZWdyYV92ZGVfaW9tbXVfbWFwJzoKPj4+PiBp
b21tdS5jOigudGV4dCsweDQxKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYWxsb2NfaW92YScK
Pj4+PiBpb21tdS5jOigudGV4dCsweDU2KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX19mcmVl
X2lvdmEnCj4+Pj4KPj4+PiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5j
b20+Cj4+Pj4gRml4ZXM6IDdmYzdhZjY0OWNhNyAoIm1lZGlhOiBzdGFnaW5nL2ludGVsLWlwdTM6
IEFkZCBpbWd1IHRvcCBsZXZlbCBwY2kgZGV2aWNlIGRyaXZlciIpCj4+Pj4gU2lnbmVkLW9mZi1i
eTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgZHJp
dmVycy9zdGFnaW5nL21lZGlhL2lwdTMvS2NvbmZpZyB8IDIgKy0KPj4+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3RhZ2luZy9tZWRpYS9pcHUzL0tjb25maWcgYi9kcml2ZXJzL3N0YWdpbmcvbWVk
aWEvaXB1My9LY29uZmlnCj4+Pj4gaW5kZXggNGI1MWM2Ny4uYjdkZjE4ZiAxMDA2NDQKPj4+PiAt
LS0gYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvaXB1My9LY29uZmlnCj4+Pj4gKysrIGIvZHJpdmVy
cy9zdGFnaW5nL21lZGlhL2lwdTMvS2NvbmZpZwo+Pj4+IEBAIC00LDcgKzQsNyBAQCBjb25maWcg
VklERU9fSVBVM19JTUdVCj4+Pj4gICAgICAgZGVwZW5kcyBvbiBQQ0kgJiYgVklERU9fVjRMMgo+
Pj4+ICAgICAgIGRlcGVuZHMgb24gTUVESUFfQ09OVFJPTExFUiAmJiBWSURFT19WNEwyX1NVQkRF
Vl9BUEkKPj4+PiAgICAgICBkZXBlbmRzIG9uIFg4Ngo+Pj4+IC0gICAgc2VsZWN0IElPTU1VX0lP
VkEKPj4+PiArICAgIHNlbGVjdCBJT01NVV9JT1ZBIGlmIElPTU1VX1NVUFBPUlQKPj4+Cj4+PiBU
aGlzIGRvZXNuJ3Qgc2VlbSByaWdodDogdGhlIGlwdTMtY2lvMiBkcml2ZXIgbmVlZHMgSU9NTVVf
SU9WQQo+Pj4gaW5kZXBlbmRlbnRseSBvZiBJT01NVV9TVVBQT1JULgo+Pj4KPj4+IExvb2tpbmcg
YXQgdGVncmEtdmRlLCBpdCBzZWVtcyB0byBkZXBlbmQgb24gSU9NTVVfU1VQUE9SVCBidXQgdGhh
dCdzIG5vdAo+Pj4gZGVjbGFyZWQgaW4gaXRzIEtjb25maWcgZW50cnkuIEkgd29uZGVyIGlmIGFk
ZGluZyB0aGF0IHdvdWxkIGJlIHRoZSByaWdodAo+Pj4gd2F5IHRvIGZpeCB0aGlzLgo+Pj4KPj4+
IENjJ2luZyB0aGUgSU9NTVUgbGlzdC4KSU9NTVVfU1VQUE9SVCBpcyBvcHRpb25hbCBmb3IgdGhl
IFRlZ3JhLVZERSBkcml2ZXIuCgo+PiBSaWdodCwgSSBhbHNvIGhhZCB0aGUgaW1wcmVzc2lvbiB0
aGF0IHdlJ2QgbWFkZSB0aGUgSU9WQSBsaWJyYXJ5IGNvbXBsZXRlbHkgc3RhbmRhbG9uZS4gQW5k
IHdoYXQgZG9lcyB0aGUgSVBVMyBkcml2ZXIncyBLY29uZmlnIGhhdmUgdG8gZG8gd2l0aCBzb21l
ICpvdGhlciogZHJpdmVyIGZhaWxpbmcgdG8gbGluayBhbnl3YXk/CgpJIGNhbiBzZWUgaXQgZmFp
bGluZyBpZiBJUFUzIGlzIGNvbXBpbGVkIGFzIGEgbG9hZGFibGUgbW9kdWxlLCB3aGlsZQpUZWdy
YS1WREUgaXMgYSBidWlsdC1pbiBkcml2ZXIuIEhlbmNlIElPVkEgbGliIHNob3VsZCBiZSBhbHNv
IGEga2VybmVsCm1vZHVsZSBhbmQgdGh1cyB0aGUgSU9WQSBzeW1ib2xzIHdpbGwgYmUgbWlzc2lu
ZyBkdXJpbmcgb2YgbGlua2FnZSBvZgp0aGUgVkRFIGRyaXZlci4KCj4gT2gsIEkgbWlzdW5kZXJz
dGFuZCB0aGF0IElPTU1VX0lPVkEgaXMgZGVwZW5kIG9uIElPTU1VX1NVUFBPUlQsIHRoYW5rIHlv
dSBmb3IgY2xhcmlmaWNhdGlvbi4KPiAKPiBJIHdpbGwgdHJ5IHRvIGZpeCB0aGlzIGluIHRlZ3Jh
LXZkZS4KClByb2JhYmx5IElPVkEgY291bGQgYmUgc2VsZWN0ZWQgaW5kZXBlbmRlbnRseSBvZiBJ
T01NVV9TVVBQT1JULCBidXQgSU9WQQpsaWJyYXJ5IGlzbid0IG5lZWRlZCBmb3IgdGhlIFZERSBk
cml2ZXIgaWYgSU9NTVVfU1VQUE9SVCBpcyBkaXNhYmxlZC4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
