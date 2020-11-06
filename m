Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C1EC2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 13:06:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CABE20702
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 13:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CABE20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B66C681E8B;
	Fri,  6 Nov 2020 13:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t+9THrLGEQCV; Fri,  6 Nov 2020 13:06:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B69FF86C7A;
	Fri,  6 Nov 2020 13:06:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98928C1AD5;
	Fri,  6 Nov 2020 13:06:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD79C0893
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 69F16868FA
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LRva7eZaxEW0 for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 13:06:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5CB83868F4
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:06:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E041474;
 Fri,  6 Nov 2020 05:06:16 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B143F718;
 Fri,  6 Nov 2020 05:06:14 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
 helper
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "devel@acpica.org" <devel@acpica.org>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
 <327e6475-eb48-33a1-ef38-fae9df3bf0cb@arm.com>
 <66c52ba92d274adb818d03d2e6813f0a@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0123797-4b49-8256-1080-36b9a6f7eee6@arm.com>
Date: Fri, 6 Nov 2020 13:06:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <66c52ba92d274adb818d03d2e6813f0a@huawei.com>
Content-Language: en-GB
Cc: "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
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

T24gMjAyMC0xMS0wNiAwODozMCwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToKPiAK
PiAKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dCj4+IFNlbnQ6IDA1IE5vdmVtYmVyIDIwMjAgMTg6
MDQKPj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT47Cj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7Cj4+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnOyBkZXZlbEBhY3BpY2Eub3JnCj4+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVh
d2VpLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207Cj4+IGpvcm9AOGJ5dGVzLm9yZzsg
d2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IEd1b2hhbmp1bgo+PiAoSGFu
anVuIEd1bykgPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbgo+PiA8am9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPgo+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAzLzRd
IEFDUEkvSU9SVDogQWRkIFJNUiBtZW1vcnkgcmVnaW9ucyByZXNlcnZhdGlvbgo+PiBoZWxwZXIK
Pj4KPj4gT24gMjAyMC0xMC0yNyAxMToyNiwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPj4+IEFk
ZCBhIGhlbHBlciBmdW5jdGlvbiB0aGF0IHJldHJpZXZlcyBSTVIgbWVtb3J5IGRlc2NyaXB0b3Jz
Cj4+PiBhc3NvY2lhdGVkIHdpdGggYSBnaXZlbiBlbmRwb2ludCBkZXYuIFRoZXNlIG1lbW9yeSBy
ZWdpb25zCj4+PiBzaG91bGQgaGF2ZSBhIHVuaXR5wqBtYXBwaW5nIGluIHRoZSBTTU1VLiBTbyBy
ZXNlcnZlIHRoZW0gYXMKPj4+IElPTU1VX1JFU1ZfRElSRUNULgo+Pgo+PiBBcyBhIGdlbmVyYWwg
b2JzZXJ2YXRpb24sIHdlIGFsc28gbmVlZCBhIHdheSBpbnRvIHRoaXMgdGhhdCBpc24ndCBmcm9t
Cj4+IHRoZSBwZXJzcGVjdGl2ZSBvZiBlbmRwb2ludCBkZXZpY2VzLiBXaXRoIFNNTVV2MyB3ZSBu
ZWVkIHRvIGtub3cgYWxsIHRoZQo+PiBhY3RpdmUgc3RyZWFtIElEcyByZWxldmFudCB0byBhIGdp
dmVuIFNNTVUgaW5zdGFuY2UgYXQgcHJvYmUgdGltZSwgc28KPj4gdGhhdCB3ZSBjYW4gc2V0IHVw
IHNvbWUga2luZCBvZiB2YWxpZCBzdHJlYW0gdGFibGUgZW50cmllcyAqYmVmb3JlKgo+PiBlbmFi
bGluZyB0aGUgU01NVSBpbiB0aGUgcmVzZXQgcm91dGluZS4KPiAKPiBTbyBJIGd1ZXNzLCB0aGUg
aWRlYSBpcyB0byBwcm92aWRlIGFuIGludGVyZmFjZSBoZXJlIHRvIHJldHJpZXZlIHRob3NlIGFj
dGl2ZQo+IHN0cmVhbSBJZHM/IFRoZSBwcm9ibGVtIGlzLCBhdCBwcmVzZW50KEFGQUlDUyksIFJN
UiBkb2VzbuKAmXQgaGF2ZSBhbnkKPiBtZWFucyB0byBzcGVjaWZ5IHN1Y2ggZGV2aWNlcy4KCkkn
bSB0aGlua2luZyB3ZSBuZWVkIHRvIGNoZWNrIGlmIGFueSBSTVJzIGV4aXN0IGluIHRoZSBJT1JU
LCBpZiBzbyBmaW5kIAp0aGUgZGV2aWNlcyB0aGF0IG1hcCB0byB0aGVtLCB0aGVuIHJlc29sdmUg
dGhvc2UgZGV2aWNlcycgSUQgbWFwcGluZ3MuIApJbiB0ZXJtcyBvZiB0aGUgaW50ZXJmYWNlLCBt
YXliZSB0aGUgYmV0dGVyIG9wdGlvbiBpcyB0byBkbyBzb21ldGhpbmcgCmNsb3NlciB0byB3aGF0
IGludGVsLWlvbW11IGRvZXMgYW5kIGhhbmRsZSAqYWxsKiB0aGUgcHJvY2Vzc2luZyB1cC1mcm9u
dCAKLSBsZXQgdGhlIElPTU1VIGRyaXZlciBqdXN0IGNhbGwgaW50byB0aGUgZmlybXdhcmUgY29k
ZSBvbmNlIHRvIHJldHJpZXZlIAphIGNvbXBsZXRlIGxpc3Qgb2YgYWxsIHRoZSByZWxldmFudCBh
YnN0cmFjdGVkIFJNUiAob3IgRFQgZXF1aXZhbGVudCkgCmluZm9ybWF0aW9uLCBzbyBpdCBjYW4g
dGhlbiByZXNvbHZlIGJvdGggaXRzIG93biBlYXJseSBpbml0aWFsaXNhdGlvbiAKYW5kIHRoZSBs
YXRlciBwZXItZGV2aWNlIHNldHVwIHdpdGhvdXQgY2FsbGluZyBiYWNrIGludG8gZmlybXdhcmUg
Y29kZSAKYWdhaW4uCgo+ICAgT3RoZXJ3aXNlIHdlJ3JlIGp1c3QgZ29pbmcgdG8KPj4ga2lsbCBv
bmdvaW5nIHRyYWZmaWMgKGUuZy4gRUZJIEdPUCkgd2l0aCBDX0JBRF9TVEUgbG9uZyBiZWZvcmUg
d2UgZXZlcgo+PiBzdGFydCBhZGRpbmcgZGV2aWNlcyBhbmQgd29ycnlpbmcgYWJvdXQgcmVzZXJ2
ZWQgcmVnaW9ucyBmb3IgdGhlbS4KPj4gU2ltaWxhcmx5IGZvciB0aGUgaW5pdGlhbCBTTVIvUzJD
UiBzdGF0ZSBvbiBTTU1VdjIgd2l0aCBkaXNhYmxlX2J5cGFzcy4KPiAKPiBPay4gSSBzZWUgdGhl
IGRpc2N1c3Npb24gaGVyZSwKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS80
ODRiOWU5MC03Mzk1LTYxNjEtNTc3Yy00ZDNmMzcxNjk5N2VAYXJtLmNvbS8KPiAKPiAgRnJvbSB3
aGF0IEkgZ2F0aGVyLCB0aGUgcGxhbiBpcyB0byBzZXR1cCBhIGRlZmF1bHQgSURFTlRJVFlfRE9N
QUlOIGZvcgo+IGRldmljZXMgdGhhdCBoYXZlIGxpdmUgc3RyZWFtIGdvaW5nIG9uIGR1cmluZyBi
b290L1NNTVUgcHJvYmUgdGltZS4KCldlbGwsIHdoZXRoZXIgd2UgdXNlIGJ5cGFzcyBvciBhIHRl
bXBvcmFyeSB0cmFuc2xhdGlvbiBjb250ZXh0IGZvciB0aGUgCnBlcmlvZCBiZWZvcmUgd2UgZXZl
biBnZXQgdG8gZGVmYXVsdCBkb21haW5zLi4uIHRoYXQncyBhIGRpc2N1c3Npb24gdGhhdCAKY2Fu
IHdhaXQgdW50aWwgd2UgaGF2ZSB0aGUgYWJpbGl0eSB0byBzZXQgdXAgdGhlIFNURXMgYXQgYWxs
IDspCgpSb2Jpbi4KCj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvYWNw
aS9hcm02NC9pb3J0LmMgfCA1Ngo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPj4+ICAgIGluY2x1ZGUvbGludXgvYWNwaV9pb3J0LmggfCAgNCArKysKPj4+ICAgIDIg
ZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2FjcGkvYXJtNjQvaW9ydC5jIGIvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYwo+Pj4gaW5k
ZXggYjMyY2Q1M2NjYTA4Li5jMDcwMDE0OWU2MGIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2Fj
cGkvYXJtNjQvaW9ydC5jCj4+PiArKysgYi9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCj4+PiBA
QCAtODQyLDYgKzg0Miw2MCBAQCBzdGF0aWMgaW5saW5lIGludCBpb3J0X2FkZF9kZXZpY2VfcmVw
bGF5KHN0cnVjdAo+PiBkZXZpY2UgKmRldikKPj4+ICAgIAlyZXR1cm4gZXJyOwo+Pj4gICAgfQo+
Pj4KPj4+ICtzdGF0aWMgYm9vbCBpb3J0X2Rldl9oYXNfcm1yKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGlvcnRfcm1yX2VudHJ5ICplKQo+Pj4gK3sKPj4+ICsJc3RydWN0IGlvbW11X2Z3c3Bl
YyAqZndzcGVjID0gZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2KTsKPj4+ICsJc3RydWN0IGFjcGlf
aW9ydF9ub2RlICppb21tdTsKPj4+ICsJc3RydWN0IGlvcnRfcm1yX2lkICpybXJfaWRzID0gZS0+
cm1yX2lkczsKPj4+ICsJaW50IGksIGo7Cj4+PiArCj4+PiArCWlvbW11ID0gaW9ydF9nZXRfaW9y
dF9ub2RlKGZ3c3BlYy0+aW9tbXVfZndub2RlKTsKPj4+ICsKPj4+ICsJZm9yIChpID0gMDsgaSA8
IGUtPnJtcl9pZHNfbnVtOyBpKyssIHJtcl9pZHMrKykgewo+Pj4gKwkJZm9yIChqID0gMDsgaiA8
IGZ3c3BlYy0+bnVtX2lkczsgaisrKSB7Cj4+PiArCQkJaWYgKHJtcl9pZHMtPnNpZCA9PSBmd3Nw
ZWMtPmlkc1tqXSAmJgo+Pj4gKwkJCSAgICBybXJfaWRzLT5zbW11ID09IGlvbW11KQo+Pj4gKwkJ
CQlyZXR1cm4gdHJ1ZTsKPj4+ICsJCX0KPj4+ICsJfQo+Pj4gKwo+Pj4gKwlyZXR1cm4gZmFsc2U7
Cj4+PiArfQo+Pj4gKwo+Pj4gKy8qKgo+Pj4gKyAqIGlvcnRfZGV2X3Jtcl9nZXRfcmVzdl9yZWdp
b25zIC0gUk1SIFJlc2VydmVkIHJlZ2lvbiBkcml2ZXIgaGVscGVyCj4+PiArICogQGRldjogRGV2
aWNlIGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCj4+PiArICogQGhlYWQ6IFJlc2VydmVk
IHJlZ2lvbiBsaXN0IGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCj4+PiArICoKPj4+ICsg
KiBSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIDwwIGZhaWx1cmUKPj4+ICsgKi8KPj4+ICtpbnQgaW9y
dF9kZXZfcm1yX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlz
dF9oZWFkCj4+ICpoZWFkKQo+Pj4gK3sKPj4+ICsJc3RydWN0IGlvcnRfcm1yX2VudHJ5ICplOwo+
Pj4gKwo+Pj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGUsICZpb3J0X3Jtcl9saXN0LCBsaXN0KSB7
Cj4+PiArCQlzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKnJlZ2lvbjsKPj4+ICsJCXN0cnVjdCBh
Y3BpX2lvcnRfcm1yX2Rlc2MgKnJtcjsKPj4+ICsJCWludCBwcm90ID0gSU9NTVVfUkVBRCB8IElP
TU1VX1dSSVRFIHwKPj4+ICsJCQkgICBJT01NVV9OT0VYRUMgfCBJT01NVV9NTUlPOwo+Pj4gKwo+
Pj4gKwkJaWYgKCFpb3J0X2Rldl9oYXNfcm1yKGRldiwgZSkpCj4+PiArCQkJY29udGludWU7Cj4+
PiArCj4+PiArCQlybXIgPSBlLT5ybXJfZGVzYzsKPj4+ICsJCXJlZ2lvbiA9IGlvbW11X2FsbG9j
X3Jlc3ZfcmVnaW9uKHJtci0+YmFzZV9hZGRyZXNzLAo+Pj4gKwkJCQkJCSBybXItPmxlbmd0aCwg
cHJvdCwKPj4+ICsJCQkJCQkgSU9NTVVfUkVTVl9ESVJFQ1QpOwo+Pj4gKwkJaWYgKCFyZWdpb24p
IHsKPj4+ICsJCQlkZXZfZXJyKGRldiwgIk91dCBvZiBtZW1vcnkgYWxsb2NhdGluZyBSTVIgcmVn
aW9uc1xuIik7Cj4+PiArCQkJcmV0dXJuIC1FTk9NRU07Cj4+PiArCQl9Cj4+PiArCQlsaXN0X2Fk
ZF90YWlsKCZyZWdpb24tPmxpc3QsIGhlYWQpOwo+Pj4gKwl9Cj4+PiArCj4+PiArCXJldHVybiAw
Owo+Pj4gK30KPj4+ICsKPj4+ICAgIC8qKgo+Pj4gICAgICogaW9ydF9pb21tdV9tc2lfZ2V0X3Jl
c3ZfcmVnaW9ucyAtIFJlc2VydmVkIHJlZ2lvbiBkcml2ZXIgaGVscGVyCj4+PiAgICAgKiBAZGV2
OiBEZXZpY2UgZnJvbSBpb21tdV9nZXRfcmVzdl9yZWdpb25zKCkKPj4+IEBAIC0xMTEyLDYgKzEx
NjYsOCBAQCBpbnQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QKPj4gZGV2
aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCj4+PiAgICBjb25zdCBzdHJ1Y3QgaW9t
bXVfb3BzICppb3J0X2lvbW11X2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+PiAg
ICAJCQkJCQljb25zdCB1MzIgKmlucHV0X2lkKQo+Pj4gICAgeyByZXR1cm4gTlVMTDsgfQo+Pj4g
K2ludCBpb3J0X2Rldl9ybXJfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBsaXN0X2hlYWQKPj4gKmhlYWQpCj4+PiAreyByZXR1cm4gMDsgfQo+Pj4gICAgI2VuZGlm
Cj4+Pgo+Pj4gICAgc3RhdGljIGludCBuY19kbWFfZ2V0X3JhbmdlKHN0cnVjdCBkZXZpY2UgKmRl
diwgdTY0ICpzaXplKQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYWNwaV9pb3J0Lmgg
Yi9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oCj4+PiBpbmRleCAyMGEzMjEyMGJiODguLjZkZDg5
ZmFmMzQwYyAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvYWNwaV9pb3J0LmgKPj4+ICsr
KyBiL2luY2x1ZGUvbGludXgvYWNwaV9pb3J0LmgKPj4+IEBAIC0zOCw2ICszOCw3IEBAIHZvaWQg
aW9ydF9kbWFfc2V0dXAoc3RydWN0IGRldmljZSAqZGV2LCB1NjQKPj4gKmRtYV9hZGRyLCB1NjQg
KnNpemUpOwo+Pj4gICAgY29uc3Qgc3RydWN0IGlvbW11X29wcyAqaW9ydF9pb21tdV9jb25maWd1
cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4gICAgCQkJCQkJY29uc3QgdTMyICppZF9pbik7
Cj4+PiAgICBpbnQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQKPj4gKmhlYWQpOwo+Pj4gK2ludCBpb3J0X2Rldl9ybXJf
Z2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQKPj4g
KmhlYWQpOwo+Pj4gICAgI2Vsc2UKPj4+ICAgIHN0YXRpYyBpbmxpbmUgdm9pZCBhY3BpX2lvcnRf
aW5pdCh2b2lkKSB7IH0KPj4+ICAgIHN0YXRpYyBpbmxpbmUgdTMyIGlvcnRfbXNpX21hcF9pZChz
dHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBpZCkKPj4+IEBAIC01NSw2ICs1Niw5IEBAIHN0YXRpYyBp
bmxpbmUgY29uc3Qgc3RydWN0IGlvbW11X29wcwo+PiAqaW9ydF9pb21tdV9jb25maWd1cmVfaWQo
Cj4+PiAgICBzdGF0aWMgaW5saW5lCj4+PiAgICBpbnQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3Zf
cmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQKPj4gKmhlYWQpCj4+
PiAgICB7IHJldHVybiAwOyB9Cj4+PiArc3RhdGljIGlubGluZQo+Pj4gK2ludCBpb3J0X2Rldl9y
bXJfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQK
Pj4gKmhlYWQpCj4+PiAreyByZXR1cm4gMDsgfQo+Pj4gICAgI2VuZGlmCj4+Pgo+Pj4gICAgI2Vu
ZGlmIC8qIF9fQUNQSV9JT1JUX0hfXyAqLwo+Pj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
