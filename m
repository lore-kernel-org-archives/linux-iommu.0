Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB2C33CA2
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 10:10:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F01E2064C
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 10:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F01E2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31EC884589;
	Fri, 10 Jan 2020 10:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KvQHk5USzaav; Fri, 10 Jan 2020 10:10:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EE72F844E0;
	Fri, 10 Jan 2020 10:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D212CC1796;
	Fri, 10 Jan 2020 10:10:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD713C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 10:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D8BF688166
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 10:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gXA9yAm7v-3p for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 10:10:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2CB5088046
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 10:10:54 +0000 (UTC)
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id EE70A448CAE2B84B8243;
 Fri, 10 Jan 2020 10:10:51 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 10 Jan 2020 10:10:51 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 10 Jan
 2020 10:10:51 +0000
Date: Fri, 10 Jan 2020 10:10:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v10 2/4] uacce: add uacce driver
Message-ID: <20200110101049.00004e6d@Huawei.com>
In-Reply-To: <8a9b535f-ce48-f991-ecd7-44fdf6ebdfe7@foxmail.com>
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
 <1576465697-27946-3-git-send-email-zhangfei.gao@linaro.org>
 <20200109173819.00003cbf@Huawei.com>
 <8a9b535f-ce48-f991-ecd7-44fdf6ebdfe7@foxmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome
 Glisse <jglisse@redhat.com>, grant.likely@arm.com,
 "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gRnJpLCAxMCBKYW4gMjAyMCAxNDo1NTozOSArMDgwMAoiemhhbmdmZWkuZ2FvQGZveG1haWwu
Y29tIiA8emhhbmdmZWkuZ2FvQGZveG1haWwuY29tPiB3cm90ZToKCj4gT24gMjAyMC8xLzEwIOS4
iuWNiDE6MzgsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6Cj4gPiBPbiBNb24sIDE2IERlYyAyMDE5
IDExOjA4OjE1ICswODAwCj4gPiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5hcm8ub3Jn
PiB3cm90ZToKPiA+ICAKPiA+PiBGcm9tOiBLZW5uZXRoIExlZSA8bGlndW96aHVAaGlzaWxpY29u
LmNvbT4KPiA+Pgo+ID4+IFVhY2NlIChVbmlmaWVkL1VzZXItc3BhY2UtYWNjZXNzLWludGVuZGVk
IEFjY2VsZXJhdG9yIEZyYW1ld29yaykgdGFyZ2V0cyB0bwo+ID4+IHByb3ZpZGUgU2hhcmVkIFZp
cnR1YWwgQWRkcmVzc2luZyAoU1ZBKSBiZXR3ZWVuIGFjY2VsZXJhdG9ycyBhbmQgcHJvY2Vzc2Vz
Lgo+ID4+IFNvIGFjY2VsZXJhdG9yIGNhbiBhY2Nlc3MgYW55IGRhdGEgc3RydWN0dXJlIG9mIHRo
ZSBtYWluIGNwdS4KPiA+PiBUaGlzIGRpZmZlcnMgZnJvbSB0aGUgZGF0YSBzaGFyaW5nIGJldHdl
ZW4gY3B1IGFuZCBpbyBkZXZpY2UsIHdoaWNoIHNoYXJlCj4gPj4gb25seSBkYXRhIGNvbnRlbnQg
cmF0aGVyIHRoYW4gYWRkcmVzcy4KPiA+PiBTaW5jZSB1bmlmaWVkIGFkZHJlc3MsIGhhcmR3YXJl
IGFuZCB1c2VyIHNwYWNlIG9mIHByb2Nlc3MgY2FuIHNoYXJlIHRoZQo+ID4+IHNhbWUgdmlydHVh
bCBhZGRyZXNzIGluIHRoZSBjb21tdW5pY2F0aW9uLgo+ID4+Cj4gPj4gVWFjY2UgY3JlYXRlIGEg
Y2hyZGV2IGZvciBldmVyeSByZWdpc3RyYXRpb24sIHRoZSBxdWV1ZSBpcyBhbGxvY2F0ZWQgdG8K
PiA+PiB0aGUgcHJvY2VzcyB3aGVuIHRoZSBjaHJkZXYgaXMgb3BlbmVkLiBUaGVuIHRoZSBwcm9j
ZXNzIGNhbiBhY2Nlc3MgdGhlCj4gPj4gaGFyZHdhcmUgcmVzb3VyY2UgYnkgaW50ZXJhY3Qgd2l0
aCB0aGUgcXVldWUgZmlsZS4gQnkgbW1hcCB0aGUgcXVldWUKPiA+PiBmaWxlIHNwYWNlIHRvIHVz
ZXIgc3BhY2UsIHRoZSBwcm9jZXNzIGNhbiBkaXJlY3RseSBwdXQgcmVxdWVzdHMgdG8gdGhlCj4g
Pj4gaGFyZHdhcmUgd2l0aG91dCBzeXNjYWxsIHRvIHRoZSBrZXJuZWwgc3BhY2UuCj4gPj4KPiA+
PiBUaGUgSU9NTVUgY29yZSBvbmx5IHRyYWNrcyBtbTwtPmRldmljZSBib25kcyBhdCB0aGUgbW9t
ZW50LCBiZWNhdXNlIGl0Cj4gPj4gb25seSBuZWVkcyB0byBoYW5kbGUgSU9UTEIgaW52YWxpZGF0
aW9uIGFuZCBQQVNJRCB0YWJsZSBlbnRyaWVzLiBIb3dldmVyCj4gPj4gdWFjY2UgbmVlZHMgYSBm
aW5lciBncmFudWxhcml0eSBzaW5jZSBtdWx0aXBsZSBxdWV1ZXMgZnJvbSB0aGUgc2FtZQo+ID4+
IGRldmljZSBjYW4gYmUgYm91bmQgdG8gYW4gbW0uIFdoZW4gdGhlIG1tIGV4aXRzLCBhbGwgYm91
bmQgcXVldWVzIG11c3QKPiA+PiBiZSBzdG9wcGVkIHNvIHRoYXQgdGhlIElPTU1VIGNhbiBzYWZl
bHkgY2xlYXIgdGhlIFBBU0lEIHRhYmxlIGVudHJ5IGFuZAo+ID4+IHJlYWxsb2NhdGUgdGhlIFBB
U0lELgo+ID4+Cj4gPj4gQW4gaW50ZXJtZWRpYXRlIHN0cnVjdCB1YWNjZV9tbSBsaW5rcyB1YWNj
ZSBkZXZpY2VzIGFuZCBxdWV1ZXMuCj4gPj4gTm90ZSB0aGF0IGFuIG1tIG1heSBiZSBib3VuZCB0
byBtdWx0aXBsZSBkZXZpY2VzIGJ1dCBhbiB1YWNjZV9tbQo+ID4+IHN0cnVjdHVyZSBvbmx5IGV2
ZXIgYmVsb25ncyB0byBhIHNpbmdsZSBkZXZpY2UsIGJlY2F1c2Ugd2UgZG9uJ3QgbmVlZAo+ID4+
IGFueXRoaW5nIG1vcmUgY29tcGxleCAoaWYgbXVsdGlwbGUgZGV2aWNlcyBhcmUgYm91bmQgdG8g
b25lIG1tLCB0aGVuCj4gPj4gd2UnbGwgY3JlYXRlIG9uZSB1YWNjZV9tbSBmb3IgZWFjaCBib25k
KS4KPiA+Pgo+ID4+ICAgICAgICAgIHVhY2NlX2RldmljZSAtLSstLSB1YWNjZV9tbSAtLSstLSB1
YWNjZV9xdWV1ZQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICct
LSB1YWNjZV9xdWV1ZQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIHwKPiA+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAnLS0gdWFjY2VfbW0gLS0rLS0gdWFjY2VfcXVldWUKPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLS0gdWFjY2VfcXVldWUKPiA+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnLS0gdWFjY2VfcXVldWUKPiA+
Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IEtlbm5ldGggTGVlIDxsaWd1b3podUBoaXNpbGljb24uY29t
Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IFphaWJvIFh1IDx4dXphaWJvQGh1YXdlaS5jb20+Cj4gPj4g
U2lnbmVkLW9mZi1ieTogWmhvdSBXYW5nIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT4KPiA+PiBT
aWduZWQtb2ZmLWJ5OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZz4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5h
cm8ub3JnPiAgCj4gPiBIaSwKPiA+Cj4gPiBUd28gc21hbGwgdGhpbmdzIEknZCBtaXNzZWQgcHJl
dmlvdXNseS4gIEZpeCB0aG9zZSBhbmQgZm9yCj4gPiB3aGF0IGl0J3Mgd29ydGgKPiA+Cj4gPiBS
ZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29t
PiAgCj4gVGhhbmtzIEpvbmF0aGFuCj4gPiAgCj4gPj4gLS0tCj4gPj4gICBEb2N1bWVudGF0aW9u
L0FCSS90ZXN0aW5nL3N5c2ZzLWRyaXZlci11YWNjZSB8ICAzNyArKwo+ID4+ICAgZHJpdmVycy9t
aXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ID4+ICAgZHJpdmVy
cy9taXNjL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ID4+ICAgZHJp
dmVycy9taXNjL3VhY2NlL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgMTMgKwo+ID4+ICAg
ZHJpdmVycy9taXNjL3VhY2NlL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDIgKwo+ID4+
ICAgZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMgICAgICAgICAgICAgICAgICAgfCA2MjggKysr
KysrKysrKysrKysrKysrKysrKysrKysrCj4gPj4gICBpbmNsdWRlL2xpbnV4L3VhY2NlLmggICAg
ICAgICAgICAgICAgICAgICAgICB8IDE2MSArKysrKysrCj4gPj4gICBpbmNsdWRlL3VhcGkvbWlz
Yy91YWNjZS91YWNjZS5oICAgICAgICAgICAgICB8ICAzOCArKwo+ID4+ICAgOCBmaWxlcyBjaGFu
Z2VkLCA4ODEgaW5zZXJ0aW9ucygrKQo+ID4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLXVhY2NlCj4gPj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9taXNjL3VhY2NlL0tjb25maWcKPiA+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL21pc2MvdWFjY2UvTWFrZWZpbGUKPiA+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYwo+ID4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvbGludXgvdWFjY2UuaAo+ID4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvdWFwaS9t
aXNjL3VhY2NlL3VhY2NlLmgKPiA+PiAgCj4gPiAuLi4gIAo+ID4+ICsKPiA+PiArV2hhdDogICAg
ICAgICAgIC9zeXMvY2xhc3MvdWFjY2UvPGRldl9uYW1lPi9hdmFpbGFibGVfaW5zdGFuY2VzCj4g
Pj4gK0RhdGU6ICAgICAgICAgICBEZWMgMjAxOQo+ID4+ICtLZXJuZWxWZXJzaW9uOiAgNS42Cj4g
Pj4gK0NvbnRhY3Q6ICAgICAgICBsaW51eC1hY2NlbGVyYXRvcnNAbGlzdHMub3psYWJzLm9yZwo+
ID4+ICtEZXNjcmlwdGlvbjogICAgQXZhaWxhYmxlIGluc3RhbmNlcyBsZWZ0IG9mIHRoZSBkZXZp
Y2UKPiA+PiArICAgICAgICAgICAgICAgIFJldHVybiAtRU5PREVWIGlmIHVhY2NlX29wcyBnZXRf
YXZhaWxhYmxlX2luc3RhbmNlcyBpcyBub3QgcHJvdmlkZWQKPiA+PiArICAKPiA+IFNlZSBiZWxv
dy4gIEl0IGRvZXNuJ3QgInJldHVybiIgaXQgcHJpbnRzIGl0IGN1cnJlbnRseS4gIAo+IFdpbGwg
dXBkYXRlIHRvCj4gJ3Vua25vd24nIGlmIHVhY2NlX29wcyBnZXRfYXZhaWxhYmxlX2luc3RhbmNl
cyBpcyBub3QgcHJvdmlkZWQKPiA+Cj4gPiAuLi4KPiA+ICAKPiA+PiArc3RhdGljIGludCB1YWNj
ZV9mb3BzX21tYXAoc3RydWN0IGZpbGUgKmZpbGVwLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSkKPiA+PiArewo+ID4+ICsJc3RydWN0IHVhY2NlX3F1ZXVlICpxID0gZmlsZXAtPnByaXZhdGVf
ZGF0YTsKPiA+PiArCXN0cnVjdCB1YWNjZV9kZXZpY2UgKnVhY2NlID0gcS0+dWFjY2U7Cj4gPj4g
KwlzdHJ1Y3QgdWFjY2VfcWZpbGVfcmVnaW9uICpxZnI7Cj4gPj4gKwllbnVtIHVhY2NlX3FmcnQg
dHlwZSA9IFVBQ0NFX01BWF9SRUdJT047Cj4gPj4gKwlpbnQgcmV0ID0gMDsKPiA+PiArCj4gPj4g
KwlpZiAodm1hLT52bV9wZ29mZiA8IFVBQ0NFX01BWF9SRUdJT04pCj4gPj4gKwkJdHlwZSA9IHZt
YS0+dm1fcGdvZmY7Cj4gPj4gKwllbHNlCj4gPj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gPj4gKwo+
ID4+ICsJcWZyID0ga3phbGxvYyhzaXplb2YoKnFmciksIEdGUF9LRVJORUwpOwo+ID4+ICsJaWYg
KCFxZnIpCj4gPj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4gPj4gKwo+ID4+ICsJdm1hLT52bV9mbGFn
cyB8PSBWTV9ET05UQ09QWSB8IFZNX0RPTlRFWFBBTkQgfCBWTV9XSVBFT05GT1JLOwo+ID4+ICsJ
dm1hLT52bV9vcHMgPSAmdWFjY2Vfdm1fb3BzOwo+ID4+ICsJdm1hLT52bV9wcml2YXRlX2RhdGEg
PSBxOwo+ID4+ICsJcWZyLT50eXBlID0gdHlwZTsKPiA+PiArCj4gPj4gKwltdXRleF9sb2NrKCZ1
YWNjZV9tdXRleCk7Cj4gPj4gKwo+ID4+ICsJaWYgKHEtPnN0YXRlICE9IFVBQ0NFX1FfSU5JVCAm
JiBxLT5zdGF0ZSAhPSBVQUNDRV9RX1NUQVJURUQpIHsKPiA+PiArCQlyZXQgPSAtRUlOVkFMOwo+
ID4+ICsJCWdvdG8gb3V0X3dpdGhfbG9jazsKPiA+PiArCX0KPiA+PiArCj4gPj4gKwlpZiAocS0+
cWZyc1t0eXBlXSkgewo+ID4+ICsJCXJldCA9IC1FRVhJU1Q7Cj4gPj4gKwkJZ290byBvdXRfd2l0
aF9sb2NrOwo+ID4+ICsJfQo+ID4+ICsKPiA+PiArCXN3aXRjaCAodHlwZSkgewo+ID4+ICsJY2Fz
ZSBVQUNDRV9RRlJUX01NSU86Cj4gPj4gKwkJaWYgKCF1YWNjZS0+b3BzLT5tbWFwKSB7Cj4gPj4g
KwkJCXJldCA9IC1FSU5WQUw7Cj4gPj4gKwkJCWdvdG8gb3V0X3dpdGhfbG9jazsKPiA+PiArCQl9
Cj4gPj4gKwo+ID4+ICsJCXJldCA9IHVhY2NlLT5vcHMtPm1tYXAocSwgdm1hLCBxZnIpOwo+ID4+
ICsJCWlmIChyZXQpCj4gPj4gKwkJCWdvdG8gb3V0X3dpdGhfbG9jazsKPiA+PiArCj4gPj4gKwkJ
YnJlYWs7Cj4gPj4gKwo+ID4+ICsJY2FzZSBVQUNDRV9RRlJUX0RVUzoKPiA+PiArCQlpZiAodWFj
Y2UtPmZsYWdzICYgVUFDQ0VfREVWX1NWQSkgewo+ID4+ICsJCQlpZiAoIXVhY2NlLT5vcHMtPm1t
YXApIHsKPiA+PiArCQkJCXJldCA9IC1FSU5WQUw7Cj4gPj4gKwkJCQlnb3RvIG91dF93aXRoX2xv
Y2s7Cj4gPj4gKwkJCX0KPiA+PiArCj4gPj4gKwkJCXJldCA9IHVhY2NlLT5vcHMtPm1tYXAocSwg
dm1hLCBxZnIpOwo+ID4+ICsJCQlpZiAocmV0KQo+ID4+ICsJCQkJZ290byBvdXRfd2l0aF9sb2Nr
Owo+ID4+ICsJCX0gIAo+ID4gU2xpZ2h0bHkgb2RkIGNvcm5lciBjYXNlLCBidXQgd2hhdCBzdG9w
cyB1cyBnZXR0aW5nIGhlcmUgd2l0aAo+ID4gdGhlIFVBQ0NFX0RFVl9TVkEgZmxhZyBub3Qgc2V0
PyAgSWYgdGhhdCBoYXBwZW5lZCBJJ2QgZXhwZWN0IHRvCj4gPiByZXR1cm4gYW4gZXJyb3IgYnV0
IGxvb2tzIGxpa2Ugd2UgcmV0dXJuIDAuICAKPiBUaGUgY2hlY2sgd2l0aCBmbGFnIFVBQ0NFX0RF
Vl9TVkEgY2FuIGJlIHJlbW92ZWQgaGVyZSwgbm9uLXN2YSBhbHNvIGhhcyAKPiBkdXMgcmVnaW9u
Lgo+IFdlIGhhdmUgcmVtb3ZlZCB0aGUgY2hlY2sgd2hlbiB3ZSBhZGQgbm9uLXN2YSBzdXBwb3J0
Lgo+ID4gLi4uCj4gPiAgCj4gPj4gK3N0YXRpYyBzc2l6ZV90IGF2YWlsYWJsZV9pbnN0YW5jZXNf
c2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPj4gKwkJCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsCj4gPj4gKwkJCQkJY2hhciAqYnVmKQo+ID4+ICt7Cj4gPj4gKwlzdHJ1Y3QgdWFj
Y2VfZGV2aWNlICp1YWNjZSA9IHRvX3VhY2NlX2RldmljZShkZXYpOwo+ID4+ICsJaW50IHZhbCA9
IC1FTk9ERVY7Cj4gPj4gKwo+ID4+ICsJaWYgKHVhY2NlLT5vcHMtPmdldF9hdmFpbGFibGVfaW5z
dGFuY2VzKQo+ID4+ICsJCXZhbCA9IHVhY2NlLT5vcHMtPmdldF9hdmFpbGFibGVfaW5zdGFuY2Vz
KHVhY2NlKTsKPiA+PiArCj4gPj4gKwlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgdmFsKTsg
IAo+ID4gSXQncyB1bnVzdWFsIHRvIHBhc3MgYW4gZXJyb3IgdmFsdWUgYmFjayBhcyBhIHN0cmlu
Zy4KPiA+IEknZCBleHBlY3Qgc29tZSBsb2dpYyBsaWtlLi4KPiA+Cj4gPiAJaWYgKHZhbCA8IDAp
Cj4gPiAJCXJldHVybiB2YWw7Cj4gPgo+ID4gCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCB2
YWwpOwo+ID4KPiA+IE5vdGUgdGhpcyBpcyB0aGUgZG9jdW1lbnRlZCBiZWhhdmlvciAicmV0dXJu
cyAtRU5PREVWIi4gIAo+IElmIHJldHVybiAtRU5PREVWLAo+IGNhdCAvc3lzL2NsYXNzL3VhY2Nl
L2hpc2lfemlwLTAvYXZhaWxhYmxlX2luc3RhbmNlcwo+IGNhdDogL3N5cy9jbGFzcy91YWNjZS9o
aXNpX3ppcC0wL2F2YWlsYWJsZV9pbnN0YW5jZXM6IE5vIHN1Y2ggZGV2aWNlCj4gCj4gSSB0aGlu
ayBwcmludCAidW5rbm93biIgbWF5YmUgYmV0dGVyLCBsaWtlIGNwdWZyZXEuYwo+IAo+ICDCoMKg
wqDCoMKgwqDCoCBpZiAodWFjY2UtPm9wcy0+Z2V0X2F2YWlsYWJsZV9pbnN0YW5jZXMpCj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwK
PiB1YWNjZS0+b3BzLT5nZXRfYXZhaWxhYmxlX2luc3RhbmNlcyh1YWNjZSkpOwo+IAo+ICDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gc3ByaW50ZihidWYsICJ1bmtub3duXG4iKTsKCkZyb20gdXNlcnNw
YWNlIGNvZGUgcG9pbnQgYSBzaW1wbGUgZXJyb3IgY29kZSByZXR1cm4gaXMgYmV0dGVyIHRoYW4K
YSAnbWFnaWMnIHN0cmluZyBpbiB0aGUgZmlsZS4KCllvdSdsbCBmaW5kIHBlb3BsZSBqdXN0IHRy
eSB0byByZWFkIGFuIGludGVnZXIgd2l0aG91dCBjaGVja2luZwpmb3IgdW5rbm93biBhbmQgaGVu
Y2UgZ2V0IGEgdmVyeSBvZGQgcmVzdWx0LiBNdWNoIGJldHRlciB0byB0aHJvdwp0aGVtIGFuIGVy
cm9yIGNvZGUuCgpKb25hdGhhbgoKCj4gCj4gVGhhbmtzCj4gCj4gCj4gCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
