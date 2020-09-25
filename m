Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23849C4741F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 16:15:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E9020715
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 16:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E9020715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C8FF987581;
	Fri, 25 Sep 2020 16:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gRPxeUGWVuW3; Fri, 25 Sep 2020 16:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E41087588;
	Fri, 25 Sep 2020 16:15:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70870C0890;
	Fri, 25 Sep 2020 16:15:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B8FFC0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 16:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6062186E45
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 16:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9w743rZsV8D4 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 16:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2E93F86E44
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 16:15:50 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 9D747FC57CE208BCF606;
 Fri, 25 Sep 2020 17:15:47 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.140) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 17:15:46 +0100
Subject: Re: [PATCH 1/2] iommu/iova: Flush CPU rcache for when a depot fills
From: John Garry <john.garry@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
References: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
 <1601027469-221812-2-git-send-email-john.garry@huawei.com>
 <bede311f-9a07-98e1-e728-9acd4ad13b51@arm.com>
 <11d30dc2-0b2d-fc30-a07a-9c5f18064d2b@huawei.com>
Message-ID: <039894e1-63d7-54eb-9f17-14f94f884400@huawei.com>
Date: Fri, 25 Sep 2020 17:12:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <11d30dc2-0b2d-fc30-a07a-9c5f18064d2b@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.7.140]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: xiyou.wangcong@gmail.com, iommu@lists.linux-foundation.org,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org
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

T24gMjUvMDkvMjAyMCAxNTozNCwgSm9obiBHYXJyeSB3cm90ZToKPiBJbmRlZWQsIEkgdGhpbmsg
dGhhdCB0aGUgbWFpbmxpbmUgY29kZSBoYXMgYSBidWc6Cj4gCj4gSWYgdGhlIGluaXRpYWwgYWxs
b2NhdGlvbiBmb3IgdGhlIGxvYWRlZC9wcmV2IG1hZ2F6aW5lcyBmYWlsIChnaXZlIE5VTEwpIAo+
IGluIGluaXRfaW92YV9yY2FjaGVzKCksIHRoZW4gaW4gX19pb3ZhX3JjYWNoZV9pbnNlcnQoKToK
PiAKPiBpZiAoIWlvdmFfbWFnYXppbmVfZnVsbChjcHVfcmNhY2hlLT5sb2FkZWQpKSB7Cj4gIMKg
wqDCoMKgY2FuX2luc2VydCA9IHRydWU7Cj4gCj4gSWYgY3B1X3JjYWNoZS0+bG9hZGVkID09IE5V
TEwsIHRoZW4gY2FuX2luc2VydCBpcyBhc3NpZ25lZCB0cnVlIC0+IGJhbmcsIAo+IGFzIEkgZXhw
ZXJpbWVudGVkLCBiZWxvdy4gVGhpcyBuZWVkcyB0byBiZSBmaXhlZC4uLgo+IAoKVGhpcyBsb29r
cyBiZXR0ZXI6CgpTdWJqZWN0OiBbUEFUQ0hdIGlvbW11L2lvdmE6IEF2b2lkIGRvdWJsZS1uZWdh
dGl2ZXMgd2l0aCBtYWdhemluZSBoZWxwZXJzCgpFeHByZXNzaW9uICFpb3ZhX21hZ2F6aW5lX2Z1
bGwobWFnKSBldmFsdWF0ZXMgdHJ1ZSB3aGVuIG1hZyA9PSBOVUxMLgoKVGhpcyBmYWxscyBvdmVy
IGluIF9faW92YV9yY2FjaGVfaW5zZXJ0KCkgd2hlbiBsb2FkZWQgPT0gTlVMTDoKCmlmICghaW92
YV9tYWdhemluZV9mdWxsKGNwdV9yY2FjaGUtPmxvYWRlZCkpIHsKCWNhbl9pbnNlcnQgPSB0cnVl
OwoKLi4uCgppZiAoY2FuX2luc2VydCkKCWlvdmFfbWFnYXppbmVfcHVzaChjcHVfcmNhY2hlLT5s
b2FkZWQsIGlvdmFfcGZuKTsKCkhlcmUsIGNhbl9pbnNlcnQgaXMgZXZhbHVhdGVkIHRydWUsIHdo
aWNoIGlzIHdyb25nLiBNZW1iZXJzCmxvYWRlZC9wcmV2IGNhbiBwb3NzaWJseSBiZSBOVUxMIGlm
IHRoZSBpbml0aWFsIGFsbG9jYXRpb25zIGZhaWwgaW4KX19pb3ZhX3JjYWNoZV9pbnNlcnQoKS4K
CkxldCdzIHN0b3AgdXNpbmcgZG91YmxlLW5lZ2F0aXZlcywgbGlrZSAhaW92YV9tYWdhemluZV9m
dWxsKCksIGFuZCB1c2UKaW92YV9tYWdhemluZV9oYXNfc3BhY2UoKSBpbnN0ZWFkIGluIHRoaXMg
Y2FzZS4gQW5kIHNpbWlsYXIgZm9yCiFpb3ZhX21hZ2F6aW5lX2VtcHR5KCkuCgpTaWduZWQtb2Zm
LWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+CgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwppbmRleCA1YjRmZmFiNzE0
MGIuLjQyY2E5ZDBmMzliNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKKysrIGIv
ZHJpdmVycy9pb21tdS9pb3ZhLmMKQEAgLTgyNywxNCArODI3LDE4IEBAIGlvdmFfbWFnYXppbmVf
ZnJlZV9wZm5zKHN0cnVjdCBpb3ZhX21hZ2F6aW5lICptYWcsIApzdHJ1Y3QgaW92YV9kb21haW4g
KmlvdmFkKQogIAltYWctPnNpemUgPSAwOwogIH0KCi1zdGF0aWMgYm9vbCBpb3ZhX21hZ2F6aW5l
X2Z1bGwoc3RydWN0IGlvdmFfbWFnYXppbmUgKm1hZykKK3N0YXRpYyBib29sIGlvdmFfbWFnYXpp
bmVfaGFzX3NwYWNlKHN0cnVjdCBpb3ZhX21hZ2F6aW5lICptYWcpCiAgewotCXJldHVybiAobWFn
ICYmIG1hZy0+c2l6ZSA9PSBJT1ZBX01BR19TSVpFKTsKKwlpZiAoIW1hZykKKwkJcmV0dXJuIGZh
bHNlOworCXJldHVybiBtYWctPnNpemUgPCBJT1ZBX01BR19TSVpFOwogIH0KCi1zdGF0aWMgYm9v
bCBpb3ZhX21hZ2F6aW5lX2VtcHR5KHN0cnVjdCBpb3ZhX21hZ2F6aW5lICptYWcpCitzdGF0aWMg
Ym9vbCBpb3ZhX21hZ2F6aW5lX2hhc19wZm5zKHN0cnVjdCBpb3ZhX21hZ2F6aW5lICptYWcpCiAg
ewotCXJldHVybiAoIW1hZyB8fCBtYWctPnNpemUgPT0gMCk7CisJaWYgKCFtYWcpCisJCXJldHVy
biBmYWxzZTsKKwlyZXR1cm4gbWFnLT5zaXplOwogIH0KCiAgc3RhdGljIHVuc2lnbmVkIGxvbmcg
aW92YV9tYWdhemluZV9wb3Aoc3RydWN0IGlvdmFfbWFnYXppbmUgKm1hZywKQEAgLTg0Myw3ICs4
NDcsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBpb3ZhX21hZ2F6aW5lX3BvcChzdHJ1Y3QgCmlv
dmFfbWFnYXppbmUgKm1hZywKICAJaW50IGk7CiAgCXVuc2lnbmVkIGxvbmcgcGZuOwoKLQlCVUdf
T04oaW92YV9tYWdhemluZV9lbXB0eShtYWcpKTsKKwlCVUdfT04oIWlvdmFfbWFnYXppbmVfaGFz
X3BmbnMobWFnKSk7CgogIAkvKiBPbmx5IGZhbGwgYmFjayB0byB0aGUgcmJ0cmVlIGlmIHdlIGhh
dmUgbm8gc3VpdGFibGUgcGZucyBhdCBhbGwgKi8KICAJZm9yIChpID0gbWFnLT5zaXplIC0gMTsg
bWFnLT5wZm5zW2ldID4gbGltaXRfcGZuOyBpLS0pCkBAIC04NTksNyArODYzLDcgQEAgc3RhdGlj
IHVuc2lnbmVkIGxvbmcgaW92YV9tYWdhemluZV9wb3Aoc3RydWN0IAppb3ZhX21hZ2F6aW5lICpt
YWcsCgogIHN0YXRpYyB2b2lkIGlvdmFfbWFnYXppbmVfcHVzaChzdHJ1Y3QgaW92YV9tYWdhemlu
ZSAqbWFnLCB1bnNpZ25lZCAKbG9uZyBwZm4pCiAgewotCUJVR19PTihpb3ZhX21hZ2F6aW5lX2Z1
bGwobWFnKSk7CisJQlVHX09OKCFpb3ZhX21hZ2F6aW5lX2hhc19zcGFjZShtYWcpKTsKCiAgCW1h
Zy0+cGZuc1ttYWctPnNpemUrK10gPSBwZm47CiAgfQpAQCAtOTA1LDkgKzkwOSw5IEBAIHN0YXRp
YyBib29sIF9faW92YV9yY2FjaGVfaW5zZXJ0KHN0cnVjdCBpb3ZhX2RvbWFpbiAKKmlvdmFkLAog
IAljcHVfcmNhY2hlID0gcmF3X2NwdV9wdHIocmNhY2hlLT5jcHVfcmNhY2hlcyk7CiAgCXNwaW5f
bG9ja19pcnFzYXZlKCZjcHVfcmNhY2hlLT5sb2NrLCBmbGFncyk7CgotCWlmICghaW92YV9tYWdh
emluZV9mdWxsKGNwdV9yY2FjaGUtPmxvYWRlZCkpIHsKKwlpZiAoaW92YV9tYWdhemluZV9oYXNf
c3BhY2UoY3B1X3JjYWNoZS0+bG9hZGVkKSkgewogIAkJY2FuX2luc2VydCA9IHRydWU7Ci0JfSBl
bHNlIGlmICghaW92YV9tYWdhemluZV9mdWxsKGNwdV9yY2FjaGUtPnByZXYpKSB7CisJfSBlbHNl
IGlmIChpb3ZhX21hZ2F6aW5lX2hhc19zcGFjZShjcHVfcmNhY2hlLT5wcmV2KSkgewogIAkJc3dh
cChjcHVfcmNhY2hlLT5wcmV2LCBjcHVfcmNhY2hlLT5sb2FkZWQpOwogIAkJY2FuX2luc2VydCA9
IHRydWU7CiAgCX0gZWxzZSB7CkBAIC05MTUsNyArOTE5LDggQEAgc3RhdGljIGJvb2wgX19pb3Zh
X3JjYWNoZV9pbnNlcnQoc3RydWN0IGlvdmFfZG9tYWluIAoqaW92YWQsCgogIAkJaWYgKG5ld19t
YWcpIHsKICAJCQlzcGluX2xvY2soJnJjYWNoZS0+bG9jayk7Ci0JCQlpZiAocmNhY2hlLT5kZXBv
dF9zaXplIDwgTUFYX0dMT0JBTF9NQUdTKSB7CisJCQlpZiAocmNhY2hlLT5kZXBvdF9zaXplIDwg
TUFYX0dMT0JBTF9NQUdTICYmCisJCQkgICAgY3B1X3JjYWNoZS0+bG9hZGVkKSB7CiAgCQkJCXJj
YWNoZS0+ZGVwb3RbcmNhY2hlLT5kZXBvdF9zaXplKytdID0KICAJCQkJCQljcHVfcmNhY2hlLT5s
b2FkZWQ7CiAgCQkJfSBlbHNlIHsKQEAgLTk2OCw5ICs5NzMsOSBAQCBzdGF0aWMgdW5zaWduZWQg
bG9uZyBfX2lvdmFfcmNhY2hlX2dldChzdHJ1Y3QgCmlvdmFfcmNhY2hlICpyY2FjaGUsCiAgCWNw
dV9yY2FjaGUgPSByYXdfY3B1X3B0cihyY2FjaGUtPmNwdV9yY2FjaGVzKTsKICAJc3Bpbl9sb2Nr
X2lycXNhdmUoJmNwdV9yY2FjaGUtPmxvY2ssIGZsYWdzKTsKCi0JaWYgKCFpb3ZhX21hZ2F6aW5l
X2VtcHR5KGNwdV9yY2FjaGUtPmxvYWRlZCkpIHsKKwlpZiAoaW92YV9tYWdhemluZV9oYXNfcGZu
cyhjcHVfcmNhY2hlLT5sb2FkZWQpKSB7CiAgCQloYXNfcGZuID0gdHJ1ZTsKLQl9IGVsc2UgaWYg
KCFpb3ZhX21hZ2F6aW5lX2VtcHR5KGNwdV9yY2FjaGUtPnByZXYpKSB7CisJfSBlbHNlIGlmIChp
b3ZhX21hZ2F6aW5lX2hhc19wZm5zKGNwdV9yY2FjaGUtPnByZXYpKSB7CiAgCQlzd2FwKGNwdV9y
Y2FjaGUtPnByZXYsIGNwdV9yY2FjaGUtPmxvYWRlZCk7CiAgCQloYXNfcGZuID0gdHJ1ZTsKICAJ
fSBlbHNlIHsKLS0gCjIuMjYuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
