Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E784C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 13:16:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CBA64D9F
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 13:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CBA64D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 759B884640;
	Mon,  1 Feb 2021 13:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOxzJIUInF1a; Mon,  1 Feb 2021 13:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B34388374C;
	Mon,  1 Feb 2021 13:16:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 969B3C0FA7;
	Mon,  1 Feb 2021 13:16:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E9AEC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 13:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 39F538462E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 13:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mvSbhKzotMHF for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 13:16:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7A1D78374C
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612185390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V789mmFnjan6oLONdkqrHYRYSDll5I0KEccN8OhHrC8=;
 b=W08GpBQTpIWs2TxBxMEVj+4EDlQTuBBTga22AEy7SDUiZzq5URkG0xvJZtENDs2fxPpIVO
 88UISKuApt4CCFTyeoxoEbyVWayYHnEkGKt5jnqpwUIlOW96kDfC+G17OF/LLV7tPidEwE
 7lQe/l7kCARKjO+BOGExWyhB4gOKO3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-yqlUM8clMEiWAteaWVQLrg-1; Mon, 01 Feb 2021 08:16:26 -0500
X-MC-Unique: yqlUM8clMEiWAteaWVQLrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C4811935780;
 Mon,  1 Feb 2021 13:16:23 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA2B10016DB;
 Mon,  1 Feb 2021 13:16:18 +0000 (UTC)
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <0c609eeb-00b0-7573-fed7-5bc1e6c0b0d1@redhat.com> <YBfiIwdVP1dXg7Yt@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <47a65f65-26cb-de27-049a-48f2d083964a@redhat.com>
Date: Mon, 1 Feb 2021 14:16:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <YBfiIwdVP1dXg7Yt@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, robin.murphy@arm.com, rjw@rjwysocki.net,
 robh+dt@kernel.org, sudeep.holla@arm.com, vivek.gautam@arm.com,
 iommu@lists.linux-foundation.org, linux-accelerators@lists.ozlabs.org,
 guohanjun@huawei.com, zhangfei.gao@linaro.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

SGkgSmVhbiwKCk9uIDIvMS8yMSAxMjoxMiBQTSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3Rl
Ogo+IE9uIFN1biwgSmFuIDMxLCAyMDIxIGF0IDA3OjI5OjA5UE0gKzAxMDAsIEF1Z2VyIEVyaWMg
d3JvdGU6Cj4+IEhpIEplYW4sCj4+Cj4+IFNvbWUgcmF0aGVyIG1pbm9yIGNvbW1lbnRzwqdxdWVz
dGlvbnMgYmVsb3cgdGhhdCBtYXkgbm90IGp1c3RpZnkgYSByZXNwaW4uCj4+Cj4+IE9uIDEvMjcv
MjEgNDo0MyBQTSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+Pj4gLXN0YXRpYyBib29s
IGFybV9zbW11X2lvcGZfc3VwcG9ydGVkKHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIgKm1hc3RlcikK
Pj4+ICtib29sIGFybV9zbW11X21hc3Rlcl9pb3BmX3N1cHBvcnRlZChzdHJ1Y3QgYXJtX3NtbXVf
bWFzdGVyICptYXN0ZXIpCj4+PiAgewo+Pj4gLQlyZXR1cm4gZmFsc2U7Cj4+PiArCS8qIFdlJ3Jl
IG5vdCBrZWVwaW5nIHRyYWNrIG9mIFNJRHMgaW4gZmF1bHQgZXZlbnRzICovCj4+IHNoYWxsIHdl
PyBbKl0gYmVsb3cKPiAKPiBUaGF0IHdvdWxkIHJlcXVpcmUgc3RvcmluZyB0aGUgaW5jb21pbmcg
U0lEIGludG8gdGhlIGlvbW11X2ZhdWx0X2V2ZW50Cj4gc3RydWN0LCBhbmQgcmV0cmlldmUgaXQg
aW4gYXJtX3NtbXVfcGFnZV9yZXNwb25zZSgpLiBFYXN5IGVub3VnaCwgYnV0IEkKPiBkb24ndCB0
aGluayBpdCdzIG5lZWRlZCBmb3IgZXhpc3RpbmcgZGV2aWNlcy4KT0sKPiAKPj4+ICsJaWYgKG1h
c3Rlci0+bnVtX3N0cmVhbXMgIT0gMSkKPj4+ICsJCXJldHVybiBmYWxzZTsKPiBbLi4uXQo+Pj4g
K3N0YXRpYyBpbnQgYXJtX3NtbXVfcGFnZV9yZXNwb25zZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+
PiArCQkJCSAgc3RydWN0IGlvbW11X2ZhdWx0X2V2ZW50ICp1bnVzZWQsCj4+PiArCQkJCSAgc3Ry
dWN0IGlvbW11X3BhZ2VfcmVzcG9uc2UgKnJlc3ApCj4+PiArewo+Pj4gKwlzdHJ1Y3QgYXJtX3Nt
bXVfY21kcV9lbnQgY21kID0gezB9Owo+Pj4gKwlzdHJ1Y3QgYXJtX3NtbXVfbWFzdGVyICptYXN0
ZXIgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsKPj4+ICsJaW50IHNpZCA9IG1hc3Rlci0+c3Ry
ZWFtc1swXS5pZDsKPj4gWypdCj4+PiArCj4+PiArCWlmIChtYXN0ZXItPnN0YWxsX2VuYWJsZWQp
IHsKPj4+ICsJCWNtZC5vcGNvZGUJCT0gQ01EUV9PUF9SRVNVTUU7Cj4+PiArCQljbWQucmVzdW1l
LnNpZAkJPSBzaWQ7Cj4+PiArCQljbWQucmVzdW1lLnN0YWcJCT0gcmVzcC0+Z3JwaWQ7Cj4+PiAr
CQlzd2l0Y2ggKHJlc3AtPmNvZGUpIHsKPj4+ICsJCWNhc2UgSU9NTVVfUEFHRV9SRVNQX0lOVkFM
SUQ6Cj4+IGFkZCBmYWxsdGhyb3VnaD8KPiAKPiBJIHRoaW5rIGZhbGx0aHJvdWdoIGlzIG1haW5s
eSB1c2VmdWwgdG8gdGVsbCByZWFkZXIgYW5kIGNvbXBpbGVyIHRoYXQgYQo+IGJyZWFrIHdhcyBv
bWl0dGVkIG9uIHB1cnBvc2UuIFdoZW4gdHdvIGNhc2VzIGFyZSBzdHVjayB0b2dldGhlciB0aGUg
aW50ZW50Cj4gdG8gbWVyZ2UgdGhlIGZsb3cgaXMgY2xlYXIgZW5vdWdoIGluIG15IG9waW5pb24u
IEdDQydzCj4gLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCBkb2Vzbid0IHdhcm4gaW4gdGhpcyBjYXNl
LgpPSwo+IAo+Pj4gKwkJY2FzZSBJT01NVV9QQUdFX1JFU1BfRkFJTFVSRToKPj4+ICsJCQljbWQu
cmVzdW1lLnJlc3AgPSBDTURRX1JFU1VNRV8wX1JFU1BfQUJPUlQ7Cj4+PiArCQkJYnJlYWs7Cj4g
Wy4uLl0KPj4+ICtzdGF0aWMgaW50IGFybV9zbW11X2hhbmRsZV9ldnQoc3RydWN0IGFybV9zbW11
X2RldmljZSAqc21tdSwgdTY0ICpldnQpCj4+PiArewo+Pj4gKwlpbnQgcmV0Owo+Pj4gKwl1MzIg
cmVhc29uOwo+Pj4gKwl1MzIgcGVybSA9IDA7Cj4+PiArCXN0cnVjdCBhcm1fc21tdV9tYXN0ZXIg
Km1hc3RlcjsKPj4+ICsJYm9vbCBzc2lkX3ZhbGlkID0gZXZ0WzBdICYgRVZUUV8wX1NTVjsKPj4+
ICsJdTMyIHNpZCA9IEZJRUxEX0dFVChFVlRRXzBfU0lELCBldnRbMF0pOwo+Pj4gKwlzdHJ1Y3Qg
aW9tbXVfZmF1bHRfZXZlbnQgZmF1bHRfZXZ0ID0geyB9Owo+Pj4gKwlzdHJ1Y3QgaW9tbXVfZmF1
bHQgKmZsdCA9ICZmYXVsdF9ldnQuZmF1bHQ7Cj4+PiArCj4+PiArCS8qIFN0YWdlLTIgaXMgYWx3
YXlzIHBpbm5lZCBhdCB0aGUgbW9tZW50ICovCj4+PiArCWlmIChldnRbMV0gJiBFVlRRXzFfUzIp
Cj4+PiArCQlyZXR1cm4gLUVGQVVMVDsKPj4+ICsKPj4+ICsJbWFzdGVyID0gYXJtX3NtbXVfZmlu
ZF9tYXN0ZXIoc21tdSwgc2lkKTsKPj4+ICsJaWYgKCFtYXN0ZXIpCj4+PiArCQlyZXR1cm4gLUVJ
TlZBTDsKPj4+ICsKPj4+ICsJaWYgKGV2dFsxXSAmIEVWVFFfMV9SblcpCj4+PiArCQlwZXJtIHw9
IElPTU1VX0ZBVUxUX1BFUk1fUkVBRDsKPj4+ICsJZWxzZQo+Pj4gKwkJcGVybSB8PSBJT01NVV9G
QVVMVF9QRVJNX1dSSVRFOwo+Pj4gKwo+Pj4gKwlpZiAoZXZ0WzFdICYgRVZUUV8xX0luRCkKPj4+
ICsJCXBlcm0gfD0gSU9NTVVfRkFVTFRfUEVSTV9FWEVDOwo+Pj4gKwo+Pj4gKwlpZiAoZXZ0WzFd
ICYgRVZUUV8xX1BuVSkKPj4+ICsJCXBlcm0gfD0gSU9NTVVfRkFVTFRfUEVSTV9QUklWOwo+Pj4g
Kwo+Pj4gKwlzd2l0Y2ggKEZJRUxEX0dFVChFVlRRXzBfSUQsIGV2dFswXSkpIHsKPj4+ICsJY2Fz
ZSBFVlRfSURfVFJBTlNMQVRJT05fRkFVTFQ6Cj4+PiArCWNhc2UgRVZUX0lEX0FERFJfU0laRV9G
QVVMVDoKPj4+ICsJY2FzZSBFVlRfSURfQUNDRVNTX0ZBVUxUOgo+Pj4gKwkJcmVhc29uID0gSU9N
TVVfRkFVTFRfUkVBU09OX1BURV9GRVRDSDsKPj4gRG9lc24ndCBpdCByYXRoZXIgbWFwIHRvIElP
TU1VX0ZBVUxUX1JFQVNPTl9BQ0NFU1M/Cj4+IC8qIGFjY2VzcyBmbGFnIGNoZWNrIGZhaWxlZCAq
LyIKPiAKPiBHb29kIHBvaW50LCBJIGd1ZXNzIGl0IGRpZG4ndCBleGlzdCB3aGVuIEkgd3JvdGUg
dGhpcy4gQW5kIEFERFJfU0laRV9GQVVMVAo+IGNvcnJlc3BvbmRzIHRvIElPTU1VX0ZBVUxUX1JF
QVNPTl9PT1JfQUREUkVTUyBub3csIHJpZ2h0Pwp5ZXMgaXQgZGllcwo+IAo+IEJ5IHRoZSB3YXkg
dGhlIHdvcmRpbmcgb24gdGhvc2UgdHdvIGZhdWx0IHJlYXNvbnMsICJhY2Nlc3MgZmxhZyIgYW5k
Cj4gInN0YWdlIiwgc2VlbXMgYXJjaC1zcGVjaWZpYyAtIHg4NiBuYW1lcyBhcmUgImFjY2Vzc2Vk
IGZsYWciIGFuZCAibGV2ZWwiLgo+IAo+Pj4gKwkJYnJlYWs7Cj4+PiArCWNhc2UgRVZUX0lEX1BF
Uk1JU1NJT05fRkFVTFQ6Cj4+PiArCQlyZWFzb24gPSBJT01NVV9GQVVMVF9SRUFTT05fUEVSTUlT
U0lPTjsKPj4+ICsJCWJyZWFrOwo+Pj4gKwlkZWZhdWx0Ogo+Pj4gKwkJcmV0dXJuIC1FT1BOT1RT
VVBQOwo+Pj4gKwl9Cj4+PiArCj4+PiArCWlmIChldnRbMV0gJiBFVlRRXzFfU1RBTEwpIHsKPj4+
ICsJCWZsdC0+dHlwZSA9IElPTU1VX0ZBVUxUX1BBR0VfUkVROwo+Pj4gKwkJZmx0LT5wcm0gPSAo
c3RydWN0IGlvbW11X2ZhdWx0X3BhZ2VfcmVxdWVzdCkgewo+Pj4gKwkJCS5mbGFncyA9IElPTU1V
X0ZBVUxUX1BBR0VfUkVRVUVTVF9MQVNUX1BBR0UsCj4+PiArCQkJLmdycGlkID0gRklFTERfR0VU
KEVWVFFfMV9TVEFHLCBldnRbMV0pLAo+Pj4gKwkJCS5wZXJtID0gcGVybSwKPj4+ICsJCQkuYWRk
ciA9IEZJRUxEX0dFVChFVlRRXzJfQUREUiwgZXZ0WzJdKSwKPj4+ICsJCX07Cj4+PiArCj4+PiAr
CQlpZiAoc3NpZF92YWxpZCkgewo+Pj4gKwkJCWZsdC0+cHJtLmZsYWdzIHw9IElPTU1VX0ZBVUxU
X1BBR0VfUkVRVUVTVF9QQVNJRF9WQUxJRDsKPj4+ICsJCQlmbHQtPnBybS5wYXNpZCA9IEZJRUxE
X0dFVChFVlRRXzBfU1NJRCwgZXZ0WzBdKTsKPj4+ICsJCX0KPj4+ICsJfSBlbHNlIHsKPj4+ICsJ
CWZsdC0+dHlwZSA9IElPTU1VX0ZBVUxUX0RNQV9VTlJFQ09WOwo+Pj4gKwkJZmx0LT5ldmVudCA9
IChzdHJ1Y3QgaW9tbXVfZmF1bHRfdW5yZWNvdmVyYWJsZSkgewo+Pj4gKwkJCS5yZWFzb24gPSBy
ZWFzb24sCj4+PiArCQkJLmZsYWdzID0gSU9NTVVfRkFVTFRfVU5SRUNPVl9BRERSX1ZBTElEIHwK
Pj4+ICsJCQkJIElPTU1VX0ZBVUxUX1VOUkVDT1ZfRkVUQ0hfQUREUl9WQUxJRCwKPj4gbml0OiBz
aGFsbCBJT01NVV9GQVVMVF9VTlJFQ09WX0ZFVENIX0FERFJfVkFMSUQgYmUgc2V0IGhlcmU/IFN1
cHBvcnRlZAo+PiB1bnJlY292ZXJhYmxlIGZhdWx0cyBmZWF0dXJlIHRoZSBJUEEgZmllbGQgd2hp
Y2ggaXMgVU5LTk9XTiBmb3IgUzEKPj4gdHJhbnNsYXRpb25zLiBmZXRjaF9hZGRyIHJhdGhlciB3
YXMKPj4gY29ycmVzcG9uZGluZyB0byBXQUxLX0VBQlQuRmV0Y2hfYWRkciB0byBtZS4KPiAKPiBS
aWdodCBJIHNob3VsZCBkcm9wIHRoZSBJUEEgcGFydCBlbnRpcmVseSwgc2luY2Ugd2UgZG9uJ3Qg
cmVwb3J0IFMyIGZhdWx0cwo+IGluIHRoaXMgcGF0Y2guCk9LCgpCdXQgYXMgSSBtZW50aW9uZWQg
dGhpcyBjYW4gYmUgZml4ZWQgc2VwYXJhdGVseSBpZiB5b3UgZG9uJ3QgaGF2ZSBvdGhlcgpjb21t
ZW50cyBvbiB0aGlzIHZlcnNpb24uCgpUaGFua3MKCkVyaWMKPiAKPiBUaGFua3MsCj4gSmVhbgo+
IAo+Pj4gKwkJCS5wZXJtID0gcGVybSwKPj4+ICsJCQkuYWRkciA9IEZJRUxEX0dFVChFVlRRXzJf
QUREUiwgZXZ0WzJdKSwKPj4+ICsJCQkuZmV0Y2hfYWRkciA9IEZJRUxEX0dFVChFVlRRXzNfSVBB
LCBldnRbM10pLAo+Pj4gKwkJfTsKPiAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCj4gCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
