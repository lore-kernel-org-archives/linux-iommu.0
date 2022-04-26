Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF63C433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 12:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C42060ADC;
	Tue, 26 Apr 2022 12:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VrN5t5eVudOn; Tue, 26 Apr 2022 12:21:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FFB060A4F;
	Tue, 26 Apr 2022 12:21:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 239DBC0032;
	Tue, 26 Apr 2022 12:21:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D81DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 12:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C78F607FE
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 12:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ADSG3nYsP2wS for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 12:21:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA1C2605A7
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650975656;
 bh=xlHfVV/WpfjpyQEaevLyX8+2tF55t8eXuS19NIZzbls=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=I+ywxQwPCzT0dPfpJJ0iCv90dT0zZrs+5LKmblYowGqYMGwMeMSSPb6ulNIucHG0x
 sSP3jf9nby7pK2lv3tWa+vhBkEfLsqPgkc+q6jYUA072L5GGRtUpHTiP2vI+j5il8d
 iPqvsENSe++olZLVrVLMNsPD3Ie2fi1wt0JX4m/4=
Received: from [192.168.0.110] ([36.57.135.33])
 by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
 id 535B90EB; Tue, 26 Apr 2022 20:20:53 +0800
X-QQ-mid: xmsmtpt1650975653tqcwcd372
Message-ID: <tencent_FAED72B58E26A4B4D706CE8EF4C1B408ED07@qq.com>
X-QQ-XMAILINFO: NwU0tZNR0OQKIh9JsIaxc2Tp5qBSWIN8rGsi4T3dG7y+R5Nl7NBp8/+iigJVUR
 QmKCVBJWydn8tm6wtu9N0vXaFT5bSucWn45GSn4g9UcwQo2z/5U0qQB56PX9ASgA0a/eYJul2jsC
 CDlwHDDkB+mn79qpTrDQCHF2XAf+0CT8Ma23xpoM/63cPO+0XG6na90VJhsA5h/59HeCzf8jj6IS
 bb29woWRF2CRPaq2Vq2i+Bgz6EHDPT8LoKCd2oAVM8VicD7+wH67N3YhmWPVPwJ5KwSmn0ZVQe2H
 7Xu/LQx5XnrR1Pvv/Kd55+gmDOUKJAvIDE2iiDA6N29DxVJwYRExC3YbFcPsbQd7xZwLwetE3Ajz
 mAyAPUb6Efqp9Z09KSXhOq1k1H+4YAb+VrAGQm20IZT8/zBVz3+KYVLy7PSw1ykxuZ6xSNoVo3Ys
 XuqcA3AAUwx5PTfTNeh5jX1hMo9V3h+TvBrvazoaA+lqNn7EQBQt22RQiHo/ZeQOz7jwNjtuNjtl
 r8FBrFXMrk1ldKioDwYlfQSAdl78hh61CUIvpZvY8SAxMHOA+gMH8hUSHkUqm1hYOw/RjKYU34G6
 YHsXhm7KGCO/IqHciCxEcvfS8GpLEQA39e2npPDfvTzSI6pH6THxRuAmBU2G5Fuys+PUG5GYYKkg
 kF+p5sut4GJ+qLI5olhtc9FQ3MWfDsv97260eO4Tw6nvIXLW4bwDWSBLQxhBH/cSEA/zGjSExr8c
 Dimxlek2uUVffDwC5PSq5e4J0LRfGOzzWaCnnUkN0nxPUzgjR8b1Q2A/9+UNfCV0mqMRtflbV0t4
 31sNLq48yhUsCCz9yaFNI02MVnClw0Etva9tTk0q+AY7IGVJfcHyYU8hPdGrAPxrFjpfjeVQsw1V
 /7jHjLzaqeHpnycd1m3GVSbZGQcFRlKgnceRjDT/iwVEkiHbrbQnylNEVtqKIfLg==
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Fix mm use-after-free
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org
References: <20220426100400.147482-1-jean-philippe@linaro.org>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <c8463ed8-888e-4a7a-8db0-e71e5b79c009@foxmail.com>
Date: Tue, 26 Apr 2022 20:20:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220426100400.147482-1-jean-philippe@linaro.org>
Content-Language: en-US
Cc: zhangfei.gao@linaro.org, iommu@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksIEplYW4KCk9uIDIwMjIvNC8yNiDkuIvljYg2OjA0LCBKZWFuLVBoaWxpcHBlIEJydWNrZXIg
d3JvdGU6Cj4gV2UgY3VycmVudGx5IGNhbGwgYXJtNjRfbW1fY29udGV4dF9wdXQoKSB3aXRob3V0
IGhvbGRpbmcgYSByZWZlcmVuY2UgdG8KPiB0aGUgbW0sIHdoaWNoIGNhbiByZXN1bHQgaW4gdXNl
LWFmdGVyLWZyZWUuIENhbGwgbW1ncmFiKCkvbW1kcm9wKCkgdG8KPiBlbnN1cmUgdGhlIG1tIG9u
bHkgZ2V0cyBmcmVlZCBhZnRlciB3ZSB1bnBpbm5lZCB0aGUgQVNJRC4KPgo+IEZpeGVzOiAzMjc4
NGE5NTYyZmIgKCJpb21tdS9hcm0tc21tdS12MzogSW1wbGVtZW50IGlvbW11X3N2YV9iaW5kL3Vu
YmluZCgpIikKPiBTaWduZWQtb2ZmLWJ5OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhp
bGlwcGVAbGluYXJvLm9yZz4KPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLXN2YS5jIHwgMTIgKysrKysrKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKTWlzc2luZyArI2luY2x1ZGUgPGxpbnV4
L3NjaGVkL21tLmg+IGZvciBjb21waWxlLgoKV2Ugc3RpbGwgbmVlZCB0aGUgZml4IG1vdmUgbW1f
cGFzaWRfZHJvcCBmcm9tIF9fbW1wdXQgdG8gX19tbWRyb3AsIHJpZ2h0PwoKMS4gVGVzdCBPSyB3
aXRoIHRoZSBtbV9wYXNpZF9kcm9wIHBhdGNoLgoKMi4gVGVzdCBmYWlsIGlmIHJldmVydCB0aGUg
bW1fcGFzaWRfZHJvcCBwYXRjaCwKdWFjY2VfZm9wc19yZWxlYXNlClVuYWJsZSB0byBoYW5kbGUg
a2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyBmZmZmMDAwODNjYzZmZmMw
CgpCeSB0aGUgd2F5LCB3ZSB1c2UgbW1ncmFiIGluIGJpbmQgYW5kIG1tcHV0IGluIHVuYmluZCBi
ZWZvcmUsCnRoZW4gdGhlIGZvcHNfcmVsZWFzZSBpcyBub3QgYmUgY2FsbGVkIGlmIGV4aXQgd2l0
aG91dCBjbG9zZShmZCkuCgpUaGlzIHBhdGNoIGRvZXMgbm90IGhhdmUgdGhpcyBpc3N1ZSwgc3Rp
bGwgbm90IHVuZGVyc3RhbmQgd2h5LgoKVGhhbmtzCgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEuYyBiL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5jCj4gaW5kZXggNTgyMTE0Zjk0ZGEwLi5jOTM0
NzdhMmQ3ZjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJt
LXNtbXUtdjMtc3ZhLmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0t
c21tdS12My1zdmEuYwo+IEBAIC05OCw5ICs5OCwxNCBAQCBzdGF0aWMgc3RydWN0IGFybV9zbW11
X2N0eF9kZXNjICphcm1fc21tdV9hbGxvY19zaGFyZWRfY2Qoc3RydWN0IG1tX3N0cnVjdCAqbW0p
Cj4gICAJc3RydWN0IGFybV9zbW11X2N0eF9kZXNjICpjZDsKPiAgIAlzdHJ1Y3QgYXJtX3NtbXVf
Y3R4X2Rlc2MgKnJldCA9IE5VTEw7Cj4gICAKPiArCS8qIERvbid0IGZyZWUgdGhlIG1tIHVudGls
IHdlIHJlbGVhc2UgdGhlIEFTSUQgKi8KPiArCW1tZ3JhYihtbSk7Cj4gKwo+ICAgCWFzaWQgPSBh
cm02NF9tbV9jb250ZXh0X2dldChtbSk7Cj4gLQlpZiAoIWFzaWQpCj4gLQkJcmV0dXJuIEVSUl9Q
VFIoLUVTUkNIKTsKPiArCWlmICghYXNpZCkgewo+ICsJCWVyciA9IC1FU1JDSDsKPiArCQlnb3Rv
IG91dF9kcm9wX21tOwo+ICsJfQo+ICAgCj4gICAJY2QgPSBremFsbG9jKHNpemVvZigqY2QpLCBH
RlBfS0VSTkVMKTsKPiAgIAlpZiAoIWNkKSB7Cj4gQEAgLTE2Nyw2ICsxNzIsOCBAQCBzdGF0aWMg
c3RydWN0IGFybV9zbW11X2N0eF9kZXNjICphcm1fc21tdV9hbGxvY19zaGFyZWRfY2Qoc3RydWN0
IG1tX3N0cnVjdCAqbW0pCj4gICAJa2ZyZWUoY2QpOwo+ICAgb3V0X3B1dF9jb250ZXh0Ogo+ICAg
CWFybTY0X21tX2NvbnRleHRfcHV0KG1tKTsKPiArb3V0X2Ryb3BfbW06Cj4gKwltbWRyb3AobW0p
Owo+ICAgCXJldHVybiBlcnIgPCAwID8gRVJSX1BUUihlcnIpIDogcmV0Owo+ICAgfQo+ICAgCj4g
QEAgLTE3NSw2ICsxODIsNyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV9mcmVlX3NoYXJlZF9jZChz
dHJ1Y3QgYXJtX3NtbXVfY3R4X2Rlc2MgKmNkKQo+ICAgCWlmIChhcm1fc21tdV9mcmVlX2FzaWQo
Y2QpKSB7Cj4gICAJCS8qIFVucGluIEFTSUQgKi8KPiAgIAkJYXJtNjRfbW1fY29udGV4dF9wdXQo
Y2QtPm1tKTsKPiArCQltbWRyb3AoY2QtPm1tKTsKPiAgIAkJa2ZyZWUoY2QpOwo+ICAgCX0KPiAg
IH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
