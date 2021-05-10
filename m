Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB1EC433B4
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 14:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB1B610F8
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 14:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB1B610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A70F40537;
	Mon, 10 May 2021 14:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9lyc3cwL3XcB; Mon, 10 May 2021 14:22:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 189E84052F;
	Mon, 10 May 2021 14:22:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB3C6C000D;
	Mon, 10 May 2021 14:22:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E131C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C88C8424C
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OjIJvSdzI5FM for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 14:22:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DE3B83EAE
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00A61688;
 Mon, 10 May 2021 07:22:31 -0700 (PDT)
Received: from [10.57.59.124] (unknown [10.57.59.124])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF79E3F719;
 Mon, 10 May 2021 07:22:29 -0700 (PDT)
Subject: Re: [PATCH v3 08/10] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-9-shameerali.kolothum.thodi@huawei.com>
 <7ec85477-9c02-17de-9620-f0b153adcc82@arm.com>
 <241042b6d1ea45f790e0766c6f5d3542@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f7b586e4-f77c-e20b-dcf6-c383d7a7f2f4@arm.com>
Date: Mon, 10 May 2021 15:22:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <241042b6d1ea45f790e0766c6f5d3542@huawei.com>
Content-Language: en-GB
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
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

T24gMjAyMS0wNS0xMCAxMDoxOSwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToKPiBI
aSBSb2JpbiwKPiAKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogUm9iaW4g
TXVycGh5IFttYWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dCj4+IFNlbnQ6IDA3IE1heSAyMDIx
IDExOjAyCj4+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+Owo+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOwo+PiBpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwo+PiBDYzogTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBsb3Jl
bnpvLnBpZXJhbGlzaUBhcm0uY29tOwo+PiBqb3JvQDhieXRlcy5vcmc7IHdhbmdodWlxaWFuZyA8
d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyBHdW9oYW5qdW4KPj4gKEhhbmp1biBHdW8pIDxndW9o
YW5qdW5AaHVhd2VpLmNvbT47IHN0ZXZlbi5wcmljZUBhcm0uY29tOwo+PiBTYW1pLk11amF3YXJA
YXJtLmNvbTsgam9uQHNvbGlkLXJ1bi5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbQo+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDA4LzEwXSBpb21tdS9hcm0tc21tdS12MzogUmVzZXJ2ZSBhbnkg
Uk1SIHJlZ2lvbnMKPj4gYXNzb2NpYXRlZCB3aXRoIGEgZGV2Cj4+Cj4+IE9uIDIwMjEtMDQtMjAg
MDk6MjcsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6Cj4+PiBHZXQgUk1SIHJlZ2lvbnMgYXNzb2Np
YXRlZCB3aXRoIGEgZGV2wqByZXNlcnZlZCBzbyB0aGF0IHRoZXJlIGlzCj4+PiBhIHVuaXR5IG1h
cHBpbmcgZm9yIHRoZW0gaW7CoFNNTVUuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBL
b2xvdGh1bQo+PiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPgo+Pj4gLS0t
Cj4+PiAgICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHwgMjkK
Pj4gKysrKysrKysrKysrKysrKysrKysrCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0
aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12
My9hcm0tc21tdS12My5jCj4+IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNt
bXUtdjMuYwo+Pj4gaW5kZXggMTRlOWM3MDM0YzA0Li44YmFjZWRmN2JiMzQgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+PiArKysg
Yi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+PiBAQCAtMjUz
MSw2ICsyNTMxLDM0IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVfb2ZfeGxhdGUoc3RydWN0IGRldmlj
ZSAqZGV2LAo+PiBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzICphcmdzKQo+Pj4gICAgCXJldHVybiBp
b21tdV9md3NwZWNfYWRkX2lkcyhkZXYsIGFyZ3MtPmFyZ3MsIDEpOwo+Pj4gICAgfQo+Pj4KPj4+
ICtzdGF0aWMgYm9vbCBhcm1fc21tdV9kZXZfaGFzX3JtcihzdHJ1Y3QgYXJtX3NtbXVfbWFzdGVy
ICptYXN0ZXIsCj4+PiArCQkJCSBzdHJ1Y3QgaW9tbXVfcm1yICplKQo+Pj4gK3sKPj4+ICsJaW50
IGk7Cj4+PiArCj4+PiArCWZvciAoaSA9IDA7IGkgPCBtYXN0ZXItPm51bV9zaWRzOyBpKyspIHsK
Pj4+ICsJCWlmIChlLT5zaWQgPT0gbWFzdGVyLT5zaWRzW2ldKQo+Pj4gKwkJCXJldHVybiB0cnVl
Owo+Pj4gKwl9Cj4+PiArCj4+PiArCXJldHVybiBmYWxzZTsKPj4+ICt9Cj4+PiArCj4+PiArc3Rh
dGljIHZvaWQgYXJtX3NtbXVfcm1yX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2
LAo+Pj4gKwkJCQkJICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQo+Pj4gK3sKPj4+ICsJc3RydWN0
IGFybV9zbW11X21hc3RlciAqbWFzdGVyID0gZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7Cj4+PiAr
CXN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUgPSBtYXN0ZXItPnNtbXU7Cj4+PiArCXN0cnVj
dCBpb21tdV9ybXIgKnJtcjsKPj4+ICsKPj4+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShybXIsICZz
bW11LT5ybXJfbGlzdCwgbGlzdCkgewo+Pj4gKwkJaWYgKCFhcm1fc21tdV9kZXZfaGFzX3Jtciht
YXN0ZXIsIHJtcikpCj4+PiArCQkJY29udGludWU7Cj4+PiArCj4+PiArCQlpb21tdV9kbWFfZ2V0
X3Jtcl9yZXN2X3JlZ2lvbnMoZGV2LCBybXIsIGhlYWQpOwo+Pj4gKwl9Cj4+PiArfQo+Pj4gKwo+
Pgo+PiBUQkggSSB3b3VsZG4ndCBoYXZlIHRob3VnaHQgd2UgbmVlZCBhIGRyaXZlci1zcGVjaWZp
YyBob29rIGZvciB0aGlzLCBvcgo+PiBpcyBpdCB0b28gcGFpbmZ1bCB0byBjb3JyZWxhdGUgZndz
cGVjLT5pb21tdV9md25vZGUgYmFjayB0byB0aGUgcmVsZXZhbnQKPj4gSU9SVCBub2RlIGdlbmVy
aWNhbGx5Pwo+IAo+ICBGcm9tIGEgcXVpY2sgbG9vaywgSSB0aGluayBJIGNvdWxkIGdldCByaWQg
b2YgdGhlIGFib3ZlIHdpdGggc29tZXRoaW5nIGxpa2UgYmVsb3csCj4gCj4gLS0tLS0tODwtLS0t
Cj4gK3N0YXRpYyBib29sIGlvbW11X2RtYV9kZXZfaGFzX3JtcihzdHJ1Y3QgaW9tbXVfZndzcGVj
ICpmd3NwZWMsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpb21t
dV9ybXIgKmUpCj4gK3sKPiArICAgICAgIGludCBpOwo+ICsKPiArICAgICAgIGZvciAoaSA9IDA7
IGkgPCBmd3NwZWMtPm51bV9pZHM7IGkrKykgewo+ICsgICAgICAgICAgICAgICAgaWYgKGUtPnNp
ZCA9PSBmd3NwZWMtPmlkc1tpXSkKPiArICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRy
dWU7Cj4gKyAgICAgICAgfQo+ICsKPiArICAgICAgICByZXR1cm4gZmFsc2U7Cj4gK30KPiArCj4g
Kwo+ICt2b2lkIGlvbW11X2RtYV9nZXRfcm1yX3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmxpc3QpCj4gK3sKPiArICAgICAgIHN0cnVjdCBpb21tdV9m
d3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7Cj4gKyAgICAgICBzdHJ1
Y3QgbGlzdF9oZWFkIHJtcl9saXN0Owo+ICsgICAgICAgc3RydWN0IGlvbW11X3JtciAqcm1yOwo+
ICsKPiArICAgICAgIElOSVRfTElTVF9IRUFEKCZybXJfbGlzdCk7Cj4gKyAgICAgICBpZiAoaW9t
bXVfZG1hX2dldF9ybXJzKGZ3c3BlYy0+aW9tbXVfZndub2RlLCAmcm1yX2xpc3QpKQo+ICsgICAg
ICAgICAgICAgICByZXR1cm47Cj4gICAgICAgICAgLi4uCj4gKyAgICAgICBsaXN0X2Zvcl9lYWNo
X2VudHJ5KHJtciwgJnJtcl9saXN0LCBsaXN0KSB7Cj4gKwo+ICsgICAgICAgaWYgKCFpb21tdV9k
bWFfZGV2X2hhc19ybXIoZndzcGVjLCBybXIpCj4gKyAgICAgICAgICAgY29udGludWU7Cj4gKyAg
ICAgICAgICAuLi4KPiArICAgICAgICAgICAgICAgcmVnaW9uID0gaW9tbXVfYWxsb2NfcmVzdl9y
ZWdpb24ocm1yLT5iYXNlX2FkZHJlc3MsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJtci0+bGVuZ3RoLCBwcm90LAo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlKTsKPiAgICAgICAgICAgLi4uCj4g
KyAgICAgICB9Cj4gK30KPiAgIC8qKgo+ICAgICogaW9tbXVfZG1hX2dldF9yZXN2X3JlZ2lvbnMg
LSBSZXNlcnZlZCByZWdpb24gZHJpdmVyIGhlbHBlcgo+ICAgICogQGRldjogRGV2aWNlIGZyb20g
aW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCj4gQEAgLTE4OCwxMCArMjQyLDExIEBAIHZvaWQgaW9t
bXVfZG1hX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9o
ZWFkICpsaXN0KQo+ICAgICAgICAgIGlmICghaXNfb2Zfbm9kZShkZXZfaW9tbXVfZndzcGVjX2dl
dChkZXYpLT5pb21tdV9md25vZGUpKQo+ICAgICAgICAgICAgICAgICAgaW9ydF9pb21tdV9tc2lf
Z2V0X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3QpOwo+ICAgCj4gKyAgICAgICBpb21tdV9kbWFfZ2V0
X3Jtcl9yZXN2X3JlZ2lvbnMoZGV2LCBsaXN0KTsKPiAgIH0KPiAKPiAtLS0tODwtLS0tCj4gCj4g
QnV0IGxvb2tpbmcgYXQgdGhlIFNNTVV2MiBjb2RlLCB0aGUgZndzcGVjLT5pZHMgaXMgTUFTSzpT
SUQsIHNvIEkgYW0gbm90Cj4gc3VyZSB0aGUgUk1SIHNpZCBjYW4gYmUgY29tcGFyZWQgZGlyZWN0
bHkgdG8gZndzcGVjLT5pZHMgYWJvdmUuIFJpZ2h0PyBPcgo+IGlzIHRoZXJlIGEgYmV0dGVyIHdh
eSBoZXJlPwoKQWgsIGJ1dCBjb25zaWRlciBob3cgdGhlIElEcyBnb3QgdGhlcmUgaW4gdGhlIGZp
cnN0IHBsYWNlIDspCgpBIG1hc2sgd2lsbCBuZXZlciBiZSBzZXQgb24gQUNQSSBzeXN0ZW1zLCBz
aW5jZSBJT1JUIChpbnRlbnRpb25hbGx5KSAKb25seSBjYXRlcnMgZm9yIHN0cmFpZ2h0Zm9yd2Fy
ZCBtYXBwaW5ncyByYXRoZXIgdGhhbiBhcmJpdHJhcnkgCmNvbXBsZXhpdHksIHNvIHRoZSBhc3N1
bXB0aW9uIG9mIGZ3c3BlYyBJRCA9PSBTSUQgaXMgYWxyZWFkeSBiYWtlZCBpbiBieSAKdmlydHVl
IG9mIGFybV9zbW11X2lvcnRfeGxhdGUoKS4gVGhlIElPUlQgY29kZSBpcyBmcmVlIHRvIGFzc3Vt
ZSBpdHMgb3duIApiZWhhdmlvdXIhCgpSb2Jpbi4KCj4gCj4gVGhhbmtzLAo+IFNoYW1lZXIKPiAK
PiAKPj4KPj4+ICAgIHN0YXRpYyB2b2lkIGFybV9zbW11X2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0
IGRldmljZSAqZGV2LAo+Pj4gICAgCQkJCSAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCj4+
PiAgICB7Cj4+PiBAQCAtMjU0NSw2ICsyNTczLDcgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfZ2V0
X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QKPj4gZGV2aWNlICpkZXYsCj4+PiAgICAJbGlzdF9hZGRfdGFp
bCgmcmVnaW9uLT5saXN0LCBoZWFkKTsKPj4+Cj4+PiAgICAJaW9tbXVfZG1hX2dldF9yZXN2X3Jl
Z2lvbnMoZGV2LCBoZWFkKTsKPj4+ICsJYXJtX3NtbXVfcm1yX2dldF9yZXN2X3JlZ2lvbnMoZGV2
LCBoZWFkKTsKPj4+ICAgIH0KPj4+Cj4+PiAgICBzdGF0aWMgYm9vbCBhcm1fc21tdV9kZXZfaGFz
X2ZlYXR1cmUoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
