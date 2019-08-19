Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D3C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 18:47:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F37206C1
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 18:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YRXAzjmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F37206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39FA4E58;
	Mon, 19 Aug 2019 18:47:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 68F74B7D
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 18:37:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 863568A6
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1566239822;
	bh=1xCul6zwPmZZRQ4Hk0O8eMuvQRr/ezY6a8EcKhQqNwA=;
	h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
	b=YRXAzjmuiTtjYs226IumoiPxsySwotZK2OAVcxl8Bj4egyVFpEK3UyzIIokOGcDLV
	lcoKmd2saAgp1zyQ6onkTFjbq+MojLreY93hfHadTT18xeItpaDLnYLyHaVHbEa+8d
	HVmWa65LMS1Hf3YZfU7tXb5AH+kWFzHZZ7SGyTFY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx002
	[212.227.17.190]) with ESMTPSA (Nemesis) id 0M7pI0-1iCnAj46Bk-00vNFT;
	Mon, 19 Aug 2019 20:37:02 +0200
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Build regression in Linux 5.3-rc5 with CONFIG_XEN=y
Message-ID: <ebd95b7c-d265-cbf1-be50-945db1dd06ad@gmx.net>
Date: Mon, 19 Aug 2019 20:37:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:PXSezvioHjOWM3FW5GhhO7bssXXU1pX4rHzuycJ4nabtUC1dPE1
	9yhxVGcmplCo15uXJUkoTo4q9ybWrK42A0QnQAhD6cBma6/a8mAaETBFkI5uCGC2/y42IeP
	tsMzID6cUVzvoJPmOHz+lco3L4zqyDK73uhBJlnx5QIdkKS/hCLo4IAz+PzIGsaTxejucNH
	Q2PuHjGVYwbWya0B6tp/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ETOfyFohsCY=:xO2hAum5Mr5bkOoM1fi7Gv
	UONzQ74Wh/0lhBwosxbGx3v100p9dJTCd6ExSca8OSihTP2lZJ0hvKfhLJKYH7yo4fpnRiU08
	BemCoqmI/nuvdg9CjzMbR5qK8EwP5tmNbiHLqjiotKhnkGxJQ5VMuQnmuUn+dHeuzcaqziQub
	4es8KpzkMZeU9EIfFGdsvDtWFNfgjK9KEd4k8zvBBujiXHm6f+HXCbVZ4vOW7xwkj9c7+XM9m
	XEOHyRDY/I/aQUNq9OSlP4gdR9rd/c29gqiDtty6iimMht2OdAlEFQxtZ6ocq6T5Kyf6X8l9g
	oFs+Zayo+y0Y9mOLdQw3ltOU6IVYTEQ7f52DCdKlulNZRImDEIPHMN+zoDevMnBNspppjv9p/
	So3I5NJjkkm9sVN8ogK6wJlFgZpiv8t2r7/tWrgm7BUmWriNEOcSNkhLv5Lh91yBzyP/fMqFW
	yZJYyITllPfzaohnx5Hq33LbrTRZerCzv4g1+k0X/8anRtv/lMeEW1tqsNA7WfA8ss2JRwyc5
	hD7dehqTiO9qDlywbTyNnU8JLaTo2/OZK0zqpCs7n2cm1FwdaRmHVhl+q9lSUTYwUPRZjpVk8
	sct1MtYJ2xI7TUY3Np7aaSpLOvwtSqR+714+Tebq9AVGHNmbY8pmoCRfoiOaN9Xu2b9UkIo3Z
	UT6yTjfnXhEGiMnuymomKnZ2+w6Aaok64L8C/2f1u41TMQQIaDk9CMJb/cQqs0KGlyGPUaxFK
	tsD9suj7hfY/WC6u4/3SpyplG4IiY/QoZuGSPwndPpRFwe0NaoRM9hRx/Y8JxE0Q9pa5LdX7L
	8BJoAg6T07CzMkwZ6DwDKYneDLpM99fnoIhk73b+QP8R5CmWQoVGgoHHAG2CMZ1Fn1eoPAGHz
	h1w9AXZb16HHdBP0jjsIr60Do5wDV/ZO5kRq0BSCRHpgsqh5qS7Lpqr/QWILeTL5P9l1V1iB+
	DVwkZsUY/Baj9PC+Q+Ia/q9rVSl2CG+itr6ByfUeBzNyO1OogC197k68uE7i6cC/xESj7TY7d
	or6SbJseWGZv0+ftyei2S5XdX9gKgZdwVvm2R0U3fh0Vlbx0x4REFAF2NNc72vXlphjfTMtqI
	D6Bl9M2NjL4aXYbCXKW/5NpAQCd2XUiS7c4xy60TtszOUWRSdl0Abg2EUk7jOamujLQC5NgNg
	++Ki0WRy43wegr+zbbjnqZUlydqIU0lHUf8NHJoXzBJwZsGA==
X-Mailman-Approved-At: Mon, 19 Aug 2019 18:47:04 +0000
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

SGksDQoNCmkgdHJpZWQgdG8gY3Jvc3MgY29tcGlsZSBhcm0vbXVsdGlfdjdfZGVmY29uZmlnIHdp
dGggQ09ORklHX1hFTj15IHdpdGgNCkxpbnV4IDUuMy1yYzUgYW5kIGknbSBnZXR0aW5nIHRoaXM6
DQoNCmFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmM6IEluIGZ1bmN0aW9uIOKAmGFyY2hfc2V0dXBf
ZG1hX29wc+KAmToNCmFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmM6MjM0Nzo1OiBlcnJvcjog4oCY
c3RydWN0IGRldmljZeKAmSBoYXMgbm8gbWVtYmVyDQpuYW1lZCDigJhkbWFfY29oZXJlbnTigJkN
CsKgIGRldi0+ZG1hX2NvaGVyZW50ID0gY29oZXJlbnQ7DQrCoMKgwqDCoCBefg0KYXJjaC9hcm0v
bW0vZG1hLW1hcHBpbmcuYzogQXQgdG9wIGxldmVsOg0KYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcu
YzoyMzg1OjY6IGVycm9yOiByZWRlZmluaXRpb24gb2YNCuKAmGFyY2hfc3luY19kbWFfZm9yX2Rl
dmljZeKAmQ0KwqB2b2lkIGFyY2hfc3luY19kbWFfZm9yX2RldmljZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHBoeXNfYWRkcl90IHBhZGRyLA0KwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4NCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNoL2FybS9tbS9kbWEtbWFwcGluZy5jOjE4OjA6
DQouL2luY2x1ZGUvbGludXgvZG1hLW5vbmNvaGVyZW50Lmg6Njc6MjA6IG5vdGU6IHByZXZpb3Vz
IGRlZmluaXRpb24gb2YNCuKAmGFyY2hfc3luY19kbWFfZm9yX2RldmljZeKAmSB3YXMgaGVyZQ0K
wqBzdGF0aWMgaW5saW5lIHZvaWQgYXJjaF9zeW5jX2RtYV9mb3JfZGV2aWNlKHN0cnVjdCBkZXZp
Y2UgKmRldiwNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KYXJjaC9hcm0vbW0vZG1hLW1hcHBpbmcuYzoyMzkyOjY6IGVycm9y
OiByZWRlZmluaXRpb24gb2YNCuKAmGFyY2hfc3luY19kbWFfZm9yX2NwdeKAmQ0KwqB2b2lkIGFy
Y2hfc3luY19kbWFfZm9yX2NwdShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHBhZGRy
LA0KwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+fn5+fn4NCkluIGZpbGUgaW5jbHVkZWQgZnJv
bSBhcmNoL2FybS9tbS9kbWEtbWFwcGluZy5jOjE4OjA6DQouL2luY2x1ZGUvbGludXgvZG1hLW5v
bmNvaGVyZW50Lmg6Nzc6MjA6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2YNCuKAmGFyY2hf
c3luY19kbWFfZm9yX2NwdeKAmSB3YXMgaGVyZQ0KwqBzdGF0aWMgaW5saW5lIHZvaWQgYXJjaF9z
eW5jX2RtYV9mb3JfY3B1KHN0cnVjdCBkZXZpY2UgKmRldiwNCsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIC4vYXJjaC9hcm0vaW5jbHVkZS9hc20vcGFnZS5oOjE0OTowLA0KwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAuL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3RocmVhZF9p
bmZvLmg6MTQsDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVk
ZS9saW51eC90aHJlYWRfaW5mby5oOjM4LA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZnJvbSAuL2luY2x1ZGUvYXNtLWdlbmVyaWMvcHJlZW1wdC5oOjUsDQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vYXJjaC9hcm0vaW5jbHVkZS9nZW5lcmF0ZWQvYXNt
L3ByZWVtcHQuaDoxLA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAuL2lu
Y2x1ZGUvbGludXgvcHJlZW1wdC5oOjc4LA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZnJvbSAuL2luY2x1ZGUvbGludXgvc3BpbmxvY2suaDo1MSwNCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3NlcWxvY2suaDozNiwNCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3RpbWUuaDo2
LA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAuL2luY2x1ZGUvbGludXgv
c3RhdC5oOjE5LA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAuL2luY2x1
ZGUvbGludXgvbW9kdWxlLmg6MTAsDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBm
cm9tIGFyY2gvYXJtL21tL2RtYS1tYXBwaW5nLmM6OToNCg0KVGhlcmUgaXMgbm8gYnVpbGQgaXNz
dWUgd2l0aCBMaW51eCA1LjIsIHNvIHRoaXMgbXVzdCBiZSBpbnRyb2R1Y2VkIHdpdGgNCjUuMy1y
Yy4gSSBob3BlIHlvdSBoYXZlIGEgY2x1ZSB3aXRob3V0IGJpc2VjdGluZyB0aGlzLg0KDQpSZWdh
cmRzDQpTdGVmYW4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
