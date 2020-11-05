Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CD4C4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 18:04:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C492C20936
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 18:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C492C20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E46985C20;
	Thu,  5 Nov 2020 18:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlaEHKNTeHIn; Thu,  5 Nov 2020 18:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0E993834E6;
	Thu,  5 Nov 2020 18:04:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E743AC0893;
	Thu,  5 Nov 2020 18:04:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C4EDC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6B29587159
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id piIqYRJB4EWC for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 18:04:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id CD48A87158
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:04:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC0014BF;
 Thu,  5 Nov 2020 10:04:06 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C558F3F719;
 Thu,  5 Nov 2020 10:03:59 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
 helper
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, devel@acpica.org
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <327e6475-eb48-33a1-ef38-fae9df3bf0cb@arm.com>
Date: Thu, 5 Nov 2020 18:03:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: guohanjun@huawei.com, linuxarm@huawei.com, wanghuiqiang@huawei.com
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

T24gMjAyMC0xMC0yNyAxMToyNiwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBBZGQgYSBoZWxw
ZXIgZnVuY3Rpb24gdGhhdCByZXRyaWV2ZXMgUk1SIG1lbW9yeSBkZXNjcmlwdG9ycwo+IGFzc29j
aWF0ZWQgd2l0aCBhIGdpdmVuIGVuZHBvaW50IGRldi4gVGhlc2UgbWVtb3J5IHJlZ2lvbnMKPiBz
aG91bGQgaGF2ZSBhIHVuaXR5wqBtYXBwaW5nIGluIHRoZSBTTU1VLiBTbyByZXNlcnZlIHRoZW0g
YXMKPiBJT01NVV9SRVNWX0RJUkVDVC4KCkFzIGEgZ2VuZXJhbCBvYnNlcnZhdGlvbiwgd2UgYWxz
byBuZWVkIGEgd2F5IGludG8gdGhpcyB0aGF0IGlzbid0IGZyb20gCnRoZSBwZXJzcGVjdGl2ZSBv
ZiBlbmRwb2ludCBkZXZpY2VzLiBXaXRoIFNNTVV2MyB3ZSBuZWVkIHRvIGtub3cgYWxsIHRoZSAK
YWN0aXZlIHN0cmVhbSBJRHMgcmVsZXZhbnQgdG8gYSBnaXZlbiBTTU1VIGluc3RhbmNlIGF0IHBy
b2JlIHRpbWUsIHNvIAp0aGF0IHdlIGNhbiBzZXQgdXAgc29tZSBraW5kIG9mIHZhbGlkIHN0cmVh
bSB0YWJsZSBlbnRyaWVzICpiZWZvcmUqIAplbmFibGluZyB0aGUgU01NVSBpbiB0aGUgcmVzZXQg
cm91dGluZS4gT3RoZXJ3aXNlIHdlJ3JlIGp1c3QgZ29pbmcgdG8gCmtpbGwgb25nb2luZyB0cmFm
ZmljIChlLmcuIEVGSSBHT1ApIHdpdGggQ19CQURfU1RFIGxvbmcgYmVmb3JlIHdlIGV2ZXIgCnN0
YXJ0IGFkZGluZyBkZXZpY2VzIGFuZCB3b3JyeWluZyBhYm91dCByZXNlcnZlZCByZWdpb25zIGZv
ciB0aGVtLiAKU2ltaWxhcmx5IGZvciB0aGUgaW5pdGlhbCBTTVIvUzJDUiBzdGF0ZSBvbiBTTU1V
djIgd2l0aCBkaXNhYmxlX2J5cGFzcy4KClJvYmluLgoKPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVy
IEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gICBpbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oIHwgIDQgKysrCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hY3BpL2FybTY0L2lvcnQuYyBiL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMKPiBpbmRl
eCBiMzJjZDUzY2NhMDguLmMwNzAwMTQ5ZTYwYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2FjcGkv
YXJtNjQvaW9ydC5jCj4gKysrIGIvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYwo+IEBAIC04NDIs
NiArODQyLDYwIEBAIHN0YXRpYyBpbmxpbmUgaW50IGlvcnRfYWRkX2RldmljZV9yZXBsYXkoc3Ry
dWN0IGRldmljZSAqZGV2KQo+ICAgCXJldHVybiBlcnI7Cj4gICB9Cj4gICAKPiArc3RhdGljIGJv
b2wgaW9ydF9kZXZfaGFzX3JtcihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBpb3J0X3Jtcl9l
bnRyeSAqZSkKPiArewo+ICsJc3RydWN0IGlvbW11X2Z3c3BlYyAqZndzcGVjID0gZGV2X2lvbW11
X2Z3c3BlY19nZXQoZGV2KTsKPiArCXN0cnVjdCBhY3BpX2lvcnRfbm9kZSAqaW9tbXU7Cj4gKwlz
dHJ1Y3QgaW9ydF9ybXJfaWQgKnJtcl9pZHMgPSBlLT5ybXJfaWRzOwo+ICsJaW50IGksIGo7Cj4g
Kwo+ICsJaW9tbXUgPSBpb3J0X2dldF9pb3J0X25vZGUoZndzcGVjLT5pb21tdV9md25vZGUpOwo+
ICsKPiArCWZvciAoaSA9IDA7IGkgPCBlLT5ybXJfaWRzX251bTsgaSsrLCBybXJfaWRzKyspIHsK
PiArCQlmb3IgKGogPSAwOyBqIDwgZndzcGVjLT5udW1faWRzOyBqKyspIHsKPiArCQkJaWYgKHJt
cl9pZHMtPnNpZCA9PSBmd3NwZWMtPmlkc1tqXSAmJgo+ICsJCQkgICAgcm1yX2lkcy0+c21tdSA9
PSBpb21tdSkKPiArCQkJCXJldHVybiB0cnVlOwo+ICsJCX0KPiArCX0KPiArCj4gKwlyZXR1cm4g
ZmFsc2U7Cj4gK30KPiArCj4gKy8qKgo+ICsgKiBpb3J0X2Rldl9ybXJfZ2V0X3Jlc3ZfcmVnaW9u
cyAtIFJNUiBSZXNlcnZlZCByZWdpb24gZHJpdmVyIGhlbHBlcgo+ICsgKiBAZGV2OiBEZXZpY2Ug
ZnJvbSBpb21tdV9nZXRfcmVzdl9yZWdpb25zKCkKPiArICogQGhlYWQ6IFJlc2VydmVkIHJlZ2lv
biBsaXN0IGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCj4gKyAqCj4gKyAqIFJldHVybnM6
IDAgb24gc3VjY2VzcywgPDAgZmFpbHVyZQo+ICsgKi8KPiAraW50IGlvcnRfZGV2X3Jtcl9nZXRf
cmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkK
PiArewo+ICsJc3RydWN0IGlvcnRfcm1yX2VudHJ5ICplOwo+ICsKPiArCWxpc3RfZm9yX2VhY2hf
ZW50cnkoZSwgJmlvcnRfcm1yX2xpc3QsIGxpc3QpIHsKPiArCQlzdHJ1Y3QgaW9tbXVfcmVzdl9y
ZWdpb24gKnJlZ2lvbjsKPiArCQlzdHJ1Y3QgYWNwaV9pb3J0X3Jtcl9kZXNjICpybXI7Cj4gKwkJ
aW50IHByb3QgPSBJT01NVV9SRUFEIHwgSU9NTVVfV1JJVEUgfAo+ICsJCQkgICBJT01NVV9OT0VY
RUMgfCBJT01NVV9NTUlPOwo+ICsKPiArCQlpZiAoIWlvcnRfZGV2X2hhc19ybXIoZGV2LCBlKSkK
PiArCQkJY29udGludWU7Cj4gKwo+ICsJCXJtciA9IGUtPnJtcl9kZXNjOwo+ICsJCXJlZ2lvbiA9
IGlvbW11X2FsbG9jX3Jlc3ZfcmVnaW9uKHJtci0+YmFzZV9hZGRyZXNzLAo+ICsJCQkJCQkgcm1y
LT5sZW5ndGgsIHByb3QsCj4gKwkJCQkJCSBJT01NVV9SRVNWX0RJUkVDVCk7Cj4gKwkJaWYgKCFy
ZWdpb24pIHsKPiArCQkJZGV2X2VycihkZXYsICJPdXQgb2YgbWVtb3J5IGFsbG9jYXRpbmcgUk1S
IHJlZ2lvbnNcbiIpOwo+ICsJCQlyZXR1cm4gLUVOT01FTTsKPiArCQl9Cj4gKwkJbGlzdF9hZGRf
dGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsKPiArCX0KPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+
ICsKPiAgIC8qKgo+ICAgICogaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyAtIFJlc2Vy
dmVkIHJlZ2lvbiBkcml2ZXIgaGVscGVyCj4gICAgKiBAZGV2OiBEZXZpY2UgZnJvbSBpb21tdV9n
ZXRfcmVzdl9yZWdpb25zKCkKPiBAQCAtMTExMiw2ICsxMTY2LDggQEAgaW50IGlvcnRfaW9tbXVf
bXNpX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFk
ICpoZWFkKQo+ICAgY29uc3Qgc3RydWN0IGlvbW11X29wcyAqaW9ydF9pb21tdV9jb25maWd1cmVf
aWQoc3RydWN0IGRldmljZSAqZGV2LAo+ICAgCQkJCQkJY29uc3QgdTMyICppbnB1dF9pZCkKPiAg
IHsgcmV0dXJuIE5VTEw7IH0KPiAraW50IGlvcnRfZGV2X3Jtcl9nZXRfcmVzdl9yZWdpb25zKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKPiAreyByZXR1cm4gMDsg
fQo+ICAgI2VuZGlmCj4gICAKPiAgIHN0YXRpYyBpbnQgbmNfZG1hX2dldF9yYW5nZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHU2NCAqc2l6ZSkKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9hY3Bp
X2lvcnQuaCBiL2luY2x1ZGUvbGludXgvYWNwaV9pb3J0LmgKPiBpbmRleCAyMGEzMjEyMGJiODgu
LjZkZDg5ZmFmMzQwYyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oCj4g
KysrIGIvaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaAo+IEBAIC0zOCw2ICszOCw3IEBAIHZvaWQg
aW9ydF9kbWFfc2V0dXAoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgKmRtYV9hZGRyLCB1NjQgKnNp
emUpOwo+ICAgY29uc3Qgc3RydWN0IGlvbW11X29wcyAqaW9ydF9pb21tdV9jb25maWd1cmVfaWQo
c3RydWN0IGRldmljZSAqZGV2LAo+ICAgCQkJCQkJY29uc3QgdTMyICppZF9pbik7Cj4gICBpbnQg
aW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCBsaXN0X2hlYWQgKmhlYWQpOwo+ICtpbnQgaW9ydF9kZXZfcm1yX2dldF9yZXN2X3JlZ2lvbnMo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKTsKPiAgICNlbHNlCj4g
ICBzdGF0aWMgaW5saW5lIHZvaWQgYWNwaV9pb3J0X2luaXQodm9pZCkgeyB9Cj4gICBzdGF0aWMg
aW5saW5lIHUzMiBpb3J0X21zaV9tYXBfaWQoc3RydWN0IGRldmljZSAqZGV2LCB1MzIgaWQpCj4g
QEAgLTU1LDYgKzU2LDkgQEAgc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpp
b3J0X2lvbW11X2NvbmZpZ3VyZV9pZCgKPiAgIHN0YXRpYyBpbmxpbmUKPiAgIGludCBpb3J0X2lv
bW11X21zaV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3Rf
aGVhZCAqaGVhZCkKPiAgIHsgcmV0dXJuIDA7IH0KPiArc3RhdGljIGlubGluZQo+ICtpbnQgaW9y
dF9kZXZfcm1yX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlz
dF9oZWFkICpoZWFkKQo+ICt7IHJldHVybiAwOyB9Cj4gICAjZW5kaWYKPiAgIAo+ICAgI2VuZGlm
IC8qIF9fQUNQSV9JT1JUX0hfXyAqLwo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
