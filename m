Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BB4C433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 09:39:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FFF6117A
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 09:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FFF6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AA6484300;
	Thu, 15 Apr 2021 09:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TXFKMDQaMCsh; Thu, 15 Apr 2021 09:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA50083F4E;
	Thu, 15 Apr 2021 09:39:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D300C000B;
	Thu, 15 Apr 2021 09:39:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82033C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7005440F46
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CdfsswGkgeQp for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 09:39:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1602540436
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618479568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYfUyG4SfAr00Lsm1KqY9DuAuxzdrP7zVBgWh191mM8=;
 b=eCcX7ndtygo1wixE3DrjnOeByMzs+jFGfqVwYypz5pktL83kOTh65xY9AAZw0V/lHRIdms
 gBrsC83Y/EoIHJURYLb3/Fz50gpVv6zPZ4ZgP0CqevPOFqTtbvi3Vc4lQb1OKl9nMDIIA2
 Zmd12paV6iTfV3B943eHEXNKQwzETPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-DWNGSzP_PSKcJiIMK28M_w-1; Thu, 15 Apr 2021 05:39:26 -0400
X-MC-Unique: DWNGSzP_PSKcJiIMK28M_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF26A6D246;
 Thu, 15 Apr 2021 09:39:24 +0000 (UTC)
Received: from [10.36.114.81] (ovpn-114-81.ams2.redhat.com [10.36.114.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F267A1A874;
 Thu, 15 Apr 2021 09:39:20 +0000 (UTC)
Subject: Re: [RFC PATCH v2 2/8] ACPI/IORT: Add support for RMR node parsing
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, devel@acpica.org
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-3-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a64025cd-3312-9621-1771-8e0430220ed8@redhat.com>
Date: Thu, 15 Apr 2021 11:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20201119121150.3316-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: linuxarm@huawei.com, steven.price@arm.com, guohanjun@huawei.com,
 Sami.Mujawar@arm.com, robin.murphy@arm.com, wanghuiqiang@huawei.com
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

SGkgU2hhbWVlciwKT24gMTEvMTkvMjAgMToxMSBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToK
PiBBZGQgc3VwcG9ydCBmb3IgcGFyc2luZyBSTVIgbm9kZSBpbmZvcm1hdGlvbiBmcm9tIEFDUEku
Cj4gRmluZCBhc3NvY2lhdGVkIHN0cmVhbSBpZHMgYW5kIHNtbXUgbm9kZcKgaW5mbyBmcm9tIHRo
ZQo+IFJNUiBub2RlIGFuZCBwb3B1bGF0ZSBhIGxpbmtlZCBsaXN0IHdpdGggUk1SIG1lbW9yeQo+
IGRlc2NyaXB0b3JzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNoYW1l
ZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9hY3BpL2Fy
bTY0L2lvcnQuYyB8IDEyMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTIxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyBiL2RyaXZlcnMvYWNwaS9hcm02
NC9pb3J0LmMKPiBpbmRleCA5OTI5ZmY1MGMwYzAuLmE5NzA1YWEzNTAyOCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCj4gKysrIGIvZHJpdmVycy9hY3BpL2FybTY0L2lv
cnQuYwo+IEBAIC00MCw2ICs0MCwyNSBAQCBzdHJ1Y3QgaW9ydF9md25vZGUgewo+ICBzdGF0aWMg
TElTVF9IRUFEKGlvcnRfZndub2RlX2xpc3QpOwo+ICBzdGF0aWMgREVGSU5FX1NQSU5MT0NLKGlv
cnRfZndub2RlX2xvY2spOwo+ICAKPiArc3RydWN0IGlvcnRfcm1yX2lkIHsKPiArCXUzMiAgc2lk
Owo+ICsJc3RydWN0IGFjcGlfaW9ydF9ub2RlICpzbW11Owo+ICt9Owo+ICsKPiArLyoKPiArICog
T25lIGVudHJ5IGZvciBJT1JUIFJNUi4KPiArICovCj4gK3N0cnVjdCBpb3J0X3Jtcl9lbnRyeSB7
Cj4gKwlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7Cj4gKwo+ICsJdW5zaWduZWQgaW50IHJtcl9pZHNf
bnVtOwo+ICsJc3RydWN0IGlvcnRfcm1yX2lkICpybXJfaWRzOwo+ICsKPiArCXN0cnVjdCBhY3Bp
X2lvcnRfcm1yX2Rlc2MgKnJtcl9kZXNjOwo+ICt9Owo+ICsKPiArc3RhdGljIExJU1RfSEVBRChp
b3J0X3Jtcl9saXN0KTsgICAgICAgICAvKiBsaXN0IG9mIFJNUiByZWdpb25zIGZyb20gQUNQSSAq
Lwo+ICsKPiAgLyoqCj4gICAqIGlvcnRfc2V0X2Z3bm9kZSgpIC0gQ3JlYXRlIGlvcnRfZndub2Rl
IGFuZCB1c2UgaXQgdG8gcmVnaXN0ZXIKPiAgICoJCSAgICAgICBpb21tdSBkYXRhIGluIHRoZSBp
b3J0X2Z3bm9kZV9saXN0Cj4gQEAgLTM5Myw3ICs0MTIsOCBAQCBzdGF0aWMgc3RydWN0IGFjcGlf
aW9ydF9ub2RlICppb3J0X25vZGVfZ2V0X2lkKHN0cnVjdCBhY3BpX2lvcnRfbm9kZSAqbm9kZSwK
PiAgCQlpZiAobm9kZS0+dHlwZSA9PSBBQ1BJX0lPUlRfTk9ERV9OQU1FRF9DT01QT05FTlQgfHwK
PiAgCQkgICAgbm9kZS0+dHlwZSA9PSBBQ1BJX0lPUlRfTk9ERV9QQ0lfUk9PVF9DT01QTEVYIHx8
Cj4gIAkJICAgIG5vZGUtPnR5cGUgPT0gQUNQSV9JT1JUX05PREVfU01NVV9WMyB8fAo+IC0JCSAg
ICBub2RlLT50eXBlID09IEFDUElfSU9SVF9OT0RFX1BNQ0cpIHsKPiArCQkgICAgbm9kZS0+dHlw
ZSA9PSBBQ1BJX0lPUlRfTk9ERV9QTUNHIHx8Cj4gKwkJICAgIG5vZGUtPnR5cGUgPT0gQUNQSV9J
T1JUX05PREVfUk1SKSB7Cj4gIAkJCSppZF9vdXQgPSBtYXAtPm91dHB1dF9iYXNlOwo+ICAJCQly
ZXR1cm4gcGFyZW50Owo+ICAJCX0KPiBAQCAtMTY0Nyw2ICsxNjY3LDEwMyBAQCBzdGF0aWMgdm9p
ZCBfX2luaXQgaW9ydF9lbmFibGVfYWNzKHN0cnVjdCBhY3BpX2lvcnRfbm9kZSAqaW9ydF9ub2Rl
KQo+ICAjZWxzZQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgaW9ydF9lbmFibGVfYWNzKHN0cnVjdCBh
Y3BpX2lvcnRfbm9kZSAqaW9ydF9ub2RlKSB7IH0KPiAgI2VuZGlmCj4gK3N0YXRpYyBpbnQgaW9y
dF9ybXJfZGVzY192YWxpZChzdHJ1Y3QgYWNwaV9pb3J0X3Jtcl9kZXNjICpkZXNjKQo+ICt7Cj4g
KwlzdHJ1Y3QgaW9ydF9ybXJfZW50cnkgKmU7Cj4gKwl1NjQgZW5kLCBzdGFydCA9IGRlc2MtPmJh
c2VfYWRkcmVzcywgbGVuZ3RoID0gZGVzYy0+bGVuZ3RoOwo+ICsKPiArCWlmICghSVNfQUxJR05F
RChzdGFydCwgU1pfNjRLKSB8fCAhSVNfQUxJR05FRChsZW5ndGgsIFNaXzY0SykpCj4gKwkJcmV0
dXJuIC1FSU5WQUw7Cj4gKwo+ICsJZW5kID0gc3RhcnQgKyBsZW5ndGggLSAxOwo+ICsKPiArCS8q
IENoZWNrIGZvciBhZGRyZXNzIG92ZXJsYXAgKi8KSSBkb24ndCBnZXQgdGhpcyBjaGVjay4gV2hh
dCBpcyB0aGUgcHJvYmxlbSBpZiB5b3UgYXR0YWNoIHRoZSBzYW1lIHJhbmdlCnRvIGRpZmZlcmVu
dCBzdHJlYW0gaWRzLiBTaG91bGRuJ3QgeW91IGNoZWNrIHRoZXJlIGlzIG5vIG92ZXJsYXAgZm9y
IHRoZQpzYW1lIHNpZD8KCgo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAmaW9ydF9ybXJfbGlz
dCwgbGlzdCkgewo+ICsJCXU2NCBlX3N0YXJ0ID0gZS0+cm1yX2Rlc2MtPmJhc2VfYWRkcmVzczsK
PiArCQl1NjQgZV9lbmQgPSBlX3N0YXJ0ICsgZS0+cm1yX2Rlc2MtPmxlbmd0aCAtIDE7Cj4gKwo+
ICsJCWlmIChzdGFydCA8PSBlX2VuZCAmJiBlbmQgPj0gZV9zdGFydCkKPiArCQkJcmV0dXJuIC1F
SU5WQUw7Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgX19p
bml0IGlvcnRfcGFyc2Vfcm1yKHN0cnVjdCBhY3BpX2lvcnRfbm9kZSAqaW9ydF9ub2RlKQo+ICt7
Cj4gKwlzdHJ1Y3QgaW9ydF9ybXJfaWQgKnJtcl9pZHMsICppZHM7Cj4gKwlzdHJ1Y3QgaW9ydF9y
bXJfZW50cnkgKmU7Cj4gKwlzdHJ1Y3QgYWNwaV9pb3J0X3JtciAqcm1yOwo+ICsJc3RydWN0IGFj
cGlfaW9ydF9ybXJfZGVzYyAqcm1yX2Rlc2M7Cj4gKwl1MzIgbWFwX2NvdW50ID0gaW9ydF9ub2Rl
LT5tYXBwaW5nX2NvdW50Owo+ICsJaW50IGksIHJldCA9IDAsIGRlc2NfY291bnQgPSAwOwo+ICsK
PiArCWlmIChpb3J0X25vZGUtPnR5cGUgIT0gQUNQSV9JT1JUX05PREVfUk1SKQo+ICsJCXJldHVy
biAwOwo+ICsKPiArCWlmICghaW9ydF9ub2RlLT5tYXBwaW5nX29mZnNldCB8fCAhbWFwX2NvdW50
KSB7Cj4gKwkJcHJfZXJyKEZXX0JVRyAiSW52YWxpZCBJRCBtYXBwaW5nLCBza2lwcGluZyBSTVIg
bm9kZSAlcFxuIiwKPiArCQkgICAgICAgaW9ydF9ub2RlKTsKPiArCQlyZXR1cm4gLUVJTlZBTDsK
PiArCX0KPiArCj4gKwlybXJfaWRzID0ga21hbGxvYyhzaXplb2YoKnJtcl9pZHMpICogbWFwX2Nv
dW50LCBHRlBfS0VSTkVMKTsKPiArCWlmICghcm1yX2lkcykKPiArCQlyZXR1cm4gLUVOT01FTTsK
PiArCj4gKwkvKiBSZXRyaWV2ZSBhc3NvY2lhdGVkIHNtbXUgYW5kIHN0cmVhbSBpZCAqLwo+ICsJ
aWRzID0gcm1yX2lkczsKbml0OiBkbyB5b3UgbmVlZCBib3RoIHJtcl9pZHMgYW5kIGlkcz8KPiAr
CWZvciAoaSA9IDA7IGkgPCBtYXBfY291bnQ7IGkrKywgaWRzKyspIHsKPiArCQlpZHMtPnNtbXUg
PSBpb3J0X25vZGVfZ2V0X2lkKGlvcnRfbm9kZSwgJmlkcy0+c2lkLCBpKTsKPiArCQlpZiAoIWlk
cy0+c21tdSkgewo+ICsJCQlwcl9lcnIoRldfQlVHICJJbnZhbGlkIFNNTVUgcmVmZXJlbmNlLCBz
a2lwcGluZyBSTVIgbm9kZSAlcFxuIiwKPiArCQkJICAgICAgIGlvcnRfbm9kZSk7Cj4gKwkJCXJl
dCA9IC1FSU5WQUw7Cj4gKwkJCWdvdG8gb3V0Owo+ICsJCX0KPiArCX0KPiArCj4gKwkvKiBSZXRy
aWV2ZSBSTVIgZGF0YSAqLwo+ICsJcm1yID0gKHN0cnVjdCBhY3BpX2lvcnRfcm1yICopaW9ydF9u
b2RlLT5ub2RlX2RhdGE7Cj4gKwlpZiAoIXJtci0+cm1yX29mZnNldCB8fCAhcm1yLT5ybXJfY291
bnQpIHsKPiArCQlwcl9lcnIoRldfQlVHICJJbnZhbGlkIFJNUiBkZXNjcmlwdG9yIGFycmF5LCBz
a2lwcGluZyBSTVIgbm9kZSAlcFxuIiwKPiArCQkgICAgICAgaW9ydF9ub2RlKTsKPiArCQlyZXQg
PSAtRUlOVkFMOwo+ICsJCWdvdG8gb3V0Owo+ICsJfQo+ICsKPiArCXJtcl9kZXNjID0gQUNQSV9B
RERfUFRSKHN0cnVjdCBhY3BpX2lvcnRfcm1yX2Rlc2MsIGlvcnRfbm9kZSwKPiArCQkJCXJtci0+
cm1yX29mZnNldCk7Cj4gKwo+ICsJZm9yIChpID0gMDsgaSA8IHJtci0+cm1yX2NvdW50OyBpKyss
IHJtcl9kZXNjKyspIHsKPiArCQlyZXQgPSBpb3J0X3Jtcl9kZXNjX3ZhbGlkKHJtcl9kZXNjKTsK
PiArCQlpZiAocmV0KSB7Cj4gKwkJCXByX2VycihGV19CVUcgIkludmFsaWQgUk1SIGRlc2NyaXB0
b3JbJWRdIGZvciBub2RlICVwLCBza2lwcGluZy4uLlxuIiwKPiArCQkJICAgICAgIGksIGlvcnRf
bm9kZSk7Cj4gKwkJCWdvdG8gb3V0OwpzbyBJIHVuZGVyc3RhbmQgeW91IHNraXAgdGhlIHdob2xl
IG5vZGUgYW5kIG5vdCBqdXN0IHRoYXQgcm1yIGRlc2MsCm90aGVyd2lzZSB5b3Ugd291bGQgY29u
dGludWUuIHNvIGluIHRoYXQgY2FzZSBkb24ndCB5b3UgbmVlZCB0byBmcmVlCmJvdGggcm1yX2lk
cyBhbmQgYWxyZWFkeSBhbGxvY2F0ZWQgJ2UnPwo+ICsJCX0KPiArCj4gKwkJZSA9IGttYWxsb2Mo
c2l6ZW9mKCplKSwgR0ZQX0tFUk5FTCk7Cj4gKwkJaWYgKCFlKSB7Cj4gKwkJCXJldCA9IC1FTk9N
RU07Cj4gKwkJCWdvdG8gb3V0Owo+ICsJCX0KPiArCj4gKwkJZS0+cm1yX2lkc19udW0gPSBtYXBf
Y291bnQ7Cj4gKwkJZS0+cm1yX2lkcyA9IHJtcl9pZHM7Cj4gKwkJZS0+cm1yX2Rlc2MgPSBybXJf
ZGVzYzsKPiArCj4gKwkJbGlzdF9hZGRfdGFpbCgmZS0+bGlzdCwgJmlvcnRfcm1yX2xpc3QpOwo+
ICsJCWRlc2NfY291bnQrKzsKPiArCX0KPiArCj4gKwlyZXR1cm4gMDsKPiArCj4gK291dDoKPiAr
CWlmICghZGVzY19jb3VudCkKZG9uJ3QgeW91IHdhbnQgdG8gdGVzdCByZXQgaW5zdGVhZD8gc2Vl
IGNvbW1lbnQgYWJvdmUuICsgZnJlZSBhbGxvY2F0ZWQgJydlJwo+ICsJCWtmcmVlKHJtcl9pZHMp
Owo+ICsJcmV0dXJuIHJldDsKPiArfQo+ICAKPiAgc3RhdGljIHZvaWQgX19pbml0IGlvcnRfaW5p
dF9wbGF0Zm9ybV9kZXZpY2VzKHZvaWQpCj4gIHsKPiBAQCAtMTY3Niw2ICsxNzkzLDkgQEAgc3Rh
dGljIHZvaWQgX19pbml0IGlvcnRfaW5pdF9wbGF0Zm9ybV9kZXZpY2VzKHZvaWQpCj4gIAo+ICAJ
CWlvcnRfZW5hYmxlX2Fjcyhpb3J0X25vZGUpOwo+ICAKPiArCQlpZiAoaW9ydF90YWJsZS0+cmV2
aXNpb24gPT0gMSkKPiArCQkJaW9ydF9wYXJzZV9ybXIoaW9ydF9ub2RlKTsKPiArCj4gIAkJb3Bz
ID0gaW9ydF9nZXRfZGV2X2NmZyhpb3J0X25vZGUpOwo+ICAJCWlmIChvcHMpIHsKPiAgCQkJZndu
b2RlID0gYWNwaV9hbGxvY19md25vZGVfc3RhdGljKCk7Cj4gClRoYW5rcwoKRXJpYwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
