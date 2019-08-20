Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5965C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 05:44:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07EC214DA
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 05:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CvaP38Ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07EC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 43A91DC9;
	Tue, 20 Aug 2019 05:44:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DA1ABB6C
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 05:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CF6F787
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 05:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1566279834;
	bh=uzPHdZKUqYcn2hxSYbRWKZy5QOPpWc9pqFPWXolcQaE=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=CvaP38KseayEeQU59fMkrgn/QqAnX9jFFz09h8ewuCt6xdRXHk1hhmCKK73FhUNz9
	oYMcGuKyZqhtsIONSUnDv9LBj1a7+pSh+WRsBNKV+2eYLPvymxyrK589FFHMKzqTV2
	5IbOXQfSvWI5oIzdajjvqD9QSWA/Wa1EqUVmigHU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx004
	[212.227.17.190]) with ESMTPSA (Nemesis) id 1MxlzI-1iBRdU02zG-00zDu5;
	Tue, 20 Aug 2019 07:43:54 +0200
Subject: Re: Build regression in Linux 5.3-rc5 with CONFIG_XEN=y
To: Christoph Hellwig <hch@lst.de>
References: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
	<825549ed-8aa4-b418-8812-15a9d3cc153e@arm.com>
	<0b019cdc-6f0e-c37f-2be7-c24293acb8cd@gmx.net>
	<20190820012415.GA21178@lst.de>
From: Stefan Wahren <wahrenst@gmx.net>
Message-ID: <a69cce68-8c41-2030-b011-cdfacfeae421@gmx.net>
Date: Tue, 20 Aug 2019 07:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820012415.GA21178@lst.de>
Content-Language: en-US
X-Provags-ID: V03:K1:F1Hh4JVVCp9ffNxQI/lDuOJKjko4RUYBLmrflndVI3a4YXXy7fY
	7kmCegpactMhyNkHQSH1bz1+g0GlzzoSvpRbttOrptzLmjm36kGvGRv8op7+9yPH3mszz2D
	NBrWGnKpoA0EInwopjEIqweEgmSkhwJgMIFtsv9nvURxn2Esb5Bp2jWZfSq3wVLQ/Ee+qB0
	uQEVZaEtvBjtd1dnzoDow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zAzFlUSICW4=:alfsWQKOMedYw8VY4LG6sc
	uMM1VRWPjLOw978CJ9AloP4M/hHIamj8G82IcdVdIhXqb4ZAyxo5yAtTT7Ljs7RCz2OZ4uCs4
	XXSdPZK4ATrNIceAAKRhj1kYjBEw8ZULHTANCnw4aP1xNPCy5lVJsSth+S2/1g16UB7st000+
	2R5LApmqfagjLp2tHS9OXWkRrLFFsPFgJV8Nuw7tkCWAqO7iYvVcBjO9GH3qGpmsYT2BTNBoO
	4wVsyUyJS6I/qgUlZpbNsats3p6tq2Pe7LV81G67h8SEVoRK3XlprXjWuhmQaTSgSFadkbaao
	7Cw21PwbM7mMm4msgX8kFFSBCbrMfBFTU67fiG68e4o5BYT48w60wsPNydIlM9LGxSwjG7Eg1
	Tusi2eOildtYXHfUQFrc1vZlLrPdr2BYhU3OyxSuvyTSYxPxGPqtiG7TX4G58oBBrM7kMSG17
	r6Xojhzmkm1pZApaIpPXneRinOoa0W9CuAKZ5OtUzG4aBDY3IBp7i55W4wRWjeUP7mmJb23tL
	KqbpUJEuj/n+WX2vevXgiiu81R0VoUwTbXLiV0i65l3oHzlcwA0QOUZ0S3x7LAi9S88uny1Pj
	xTcoV0Kv2dfMIfNqF16xjOwi6ChCWNP58cYMPTPNwcMFjNePV+h9Wqr+V/x8sWwO/r5r0MLVF
	6sEkBBfP+2sFP2fgj77XKOPZORzWQsYUvXsytJGyfsdOPs2cJxqcYW+95H0HM/x1BwkyDJ5qE
	PhoR7oUh9ffYP//WmVFiE28Z4MNdhXbiA3b3vwIa7KFeYkNm/S0QDK6SvY7ghiLCieg34jtue
	Qs5a7lqdJZJbS9Aui0JZoIRXxOr6hQOtAWvl+rz6MG56P7OwBkaav5nzRz4f8TtXQjMpgEaWZ
	u1XJfY0vlXoEzhgK/Z1vyE3RssoZhhLd2MaThl2wMgq/wHiz/7UuLeCASxfa/x8DhbvBRMRFm
	8aUqGXS/H1LPQuGDlfWE7oZd8PVZ6coiuS7wP7rhIRvB7SvEuHXgyFqK9GL5wkPrGFut7NvqB
	xg2H5QklXh4yDnS8oNbX6ACT0TLGbr84ktKHbu2jtpW0RGbJ4Tll9WHR/hH5/tfIrzKnG96ne
	1f9oMDtFGGLZM9pjpoKAi3NBBsQjm6NN5rOpZ5KDPC5cbNRI/VGHCceTCqkoBfqje9CHLSHP2
	7j11zFcBtE/thGZ6fyquNvIwiFu6iC4uFbmqWzxmwuR/gczQ==
Cc: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	iommu@lists.linux-foundation.org, Ian Jackson <ian.jackson@citrix.com>,
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
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

SGkgQ2hyaXN0b3BoLAoKQW0gMjAuMDguMTkgdW0gMDM6MjQgc2NocmllYiBDaHJpc3RvcGggSGVs
bHdpZzoKPiBIaSBTdGVmYW4sCj4KPiBwbGVhc2UgdHJ5IHRoZSBwYXRjaCBiZWxvdy4KPgo+IC0t
LQo+IEZyb20gZTA1NzA2MjhkOTZmYWE1MGViZmM5NGNlOGU1NDU5NjgzMzZkYjIyNSBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDEKPiBGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4K
PiBEYXRlOiBUdWUsIDIwIEF1ZyAyMDE5IDEwOjA4OjM4ICswOTAwCj4gU3ViamVjdDogYXJtOiBz
ZWxlY3QgdGhlIGRtYS1ub25jb2hlcmVudCBzeW1ib2xzIGZvciBhbGwgc3dpb3RsYiBidWlsZHMK
Pgo+IFdlIG5lZWQgdG8gcHJvdmlkZSB0aGUgYXJjaCBob29rcyBmb3Igbm9uLWNvaGVyZW50IGRt
YS1kaXJlY3QKPiBhbmQgc3dpb3RsYiBmb3IgYWxsIHN3aW90bGIgYnVpbGRzLCBub3QganVzdCB3
aGVuIExQQVMgaXMgZW5hYmxlZC4Kcy9MUEFTL0xQQUUvCj4gV2l0aG91dCB0aGF0IHRoZSBYZW4g
YnVpbGQgdGhhdCBzZWxlY3RzIFNXSU9UTEIgaW5kaXJlY3RseSB0aHJvdWdoCj4gU1dJT1RMQl9Y
RU4gZmFpbHMgdG8gYnVpbGQuCj4KPiBGaXhlczogYWQzYzdiMThjNWIzICgiYXJtOiB1c2Ugc3dp
b3RsYiBmb3IgYm91bmNlIGJ1ZmZlcmluZyBvbiBMUEFFIGNvbmZpZ3MiKQo+IFJlcG9ydGVkLWJ5
OiBTdGVmYW4gV2FocmVuIDx3YWhyZW5zdEBnbXgubmV0Pgo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgoKaSBhcHBsaWVkIHRoaXMgcGF0Y2ggYW5kIGl0IGZp
eGVzIHRoZSBidWlsZCBpc3N1ZSBpIHJlcG9ydGVkIGJlZm9yZS4gQnV0CnRoaXMgc2VlbXMgdG8g
cmV2ZWFsIGFub3RoZXIgYnVpbGQgaXNzdWUgaW4gZHJpdmVycy9maXJtd2FyZS9xY29tX3NjbS5j
OgoKZHJpdmVycy9maXJtd2FyZS9xY29tX3NjbS5jOiBJbiBmdW5jdGlvbiDigJhxY29tX3NjbV9h
c3NpZ25fbWVt4oCZOgpkcml2ZXJzL2Zpcm13YXJlL3Fjb21fc2NtLmM6NDYwOjQ3OiBlcnJvcjog
cGFzc2luZyBhcmd1bWVudCAzIG9mCuKAmGRtYV9hbGxvY19jb2hlcmVudOKAmSBmcm9tIGluY29t
cGF0aWJsZSBwb2ludGVyIHR5cGUKWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNd
CsKgIHB0ciA9IGRtYV9hbGxvY19jb2hlcmVudChfX3NjbS0+ZGV2LCBwdHJfc3osICZwdHJfcGh5
cywgR0ZQX0tFUk5FTCk7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF4KSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZmlybXdhcmUvcWNvbV9zY20uYzoxMjowOgouL2lu
Y2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaDo2MzY6MjE6IG5vdGU6IGV4cGVjdGVkIOKAmGRtYV9h
ZGRyX3QgKiB7YWthCmxvbmcgbG9uZyB1bnNpZ25lZCBpbnQgKn3igJkgYnV0IGFyZ3VtZW50IGlz
IG9mIHR5cGUg4oCYcGh5c19hZGRyX3QgKiB7YWthCnVuc2lnbmVkIGludCAqfeKAmQrCoHN0YXRp
YyBpbmxpbmUgdm9pZCAqZG1hX2FsbG9jX2NvaGVyZW50KHN0cnVjdCBkZXZpY2UgKmRldiwgc2l6
ZV90IHNpemUsCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+
fn5+fn5+fn5+fn5+CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpz
Y3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI4MDogZGllIFJlZ2VsIGbDvHIgWmllbArigJ5kcml2ZXJz
L2Zpcm13YXJlL3Fjb21fc2NtLm/igJwgc2NoZWl0ZXJ0ZQoKTHVja2lseSB0aGVyZSBpcyBhbHJl
YWR5IGEgcGF0Y2ggdG8gZml4IHRoaXMgaW4gbGludXgtbmV4dDoKCmZpcm13YXJlOiBxY29tX3Nj
bTogVXNlIHByb3BlciB0eXBlcyBmb3IgZG1hIG1hcHBpbmdzCgpJdCBzZWVtcyB0aGF0IGl0IG1p
c3NlcyB0aGUgZml4ZXMgdGFnLgoKUmVnYXJkcwpTdGVmYW4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
