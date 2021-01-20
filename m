Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC6C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 14:15:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748A123340
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 14:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748A123340
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 14189870E8;
	Wed, 20 Jan 2021 14:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enqbOe6LWjdY; Wed, 20 Jan 2021 14:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3EF3787014;
	Wed, 20 Jan 2021 14:15:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2578DC08A1;
	Wed, 20 Jan 2021 14:15:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAFD8C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 14:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B6C0687128
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 14:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vx6ck-zdqmhY for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 14:15:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 76B2387014
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 14:15:22 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DLSDq6CRjzj9vB;
 Wed, 20 Jan 2021 22:13:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 20 Jan 2021 22:14:44 +0800
Subject: Re: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that
 overlaps with the SMMUv3
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-2-thunder.leizhen@huawei.com>
 <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
 <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
 <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
 <f6fde527-8c87-1128-52ca-77d096194eb6@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2a577c5e-25bb-5feb-d745-f25007b5a213@huawei.com>
Date: Wed, 20 Jan 2021 22:14:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f6fde527-8c87-1128-52ca-77d096194eb6@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

CgpPbiAyMDIxLzEvMjAgMjE6MjcsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAxLTIw
IDA5OjI2LCBMZWl6aGVuIChUaHVuZGVyVG93bikgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIwMjEvMS8y
MCAxMTozNywgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMDIx
LzEvMTkgMjA6MzIsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+PiBPbiAyMDIxLTAxLTE5IDAxOjU5
LCBaaGVuIExlaSB3cm90ZToKPj4+Pj4gU29tZSBTTU1VdjMgaW1wbGVtZW50YXRpb24gZW1iZWQg
dGhlIFBlcmYgTW9uaXRvciBHcm91cCBSZWdpc3RlcnMgKFBNQ0cpCj4+Pj4+IGluc2lkZSB0aGUg
Zmlyc3QgNjRrQiByZWdpb24gb2YgdGhlIFNNTVUuIFNpbmNlIFNNTVUgYW5kIFBNQ0cgYXJlIG1h
bmFnZWQKPj4+Pj4gYnkgdHdvIHNlcGFyYXRlIGRyaXZlcnMsIGFuZCB0aGlzIGRyaXZlciBkZXBl
bmRzIG9uIEFSTV9TTU1VX1YzLCBzbyB0aGUKPj4+Pj4gU01NVSBkcml2ZXIgcmVzZXJ2ZXMgdGhl
IGNvcnJlc3BvbmRpbmcgcmVzb3VyY2UgZmlyc3QsIHRoaXMgZHJpdmVyIHNob3VsZAo+Pj4+PiBu
b3QgcmVzZXJ2ZSB0aGUgY29ycmVzcG9uZGluZyByZXNvdXJjZSBhZ2Fpbi4gT3RoZXJ3aXNlLCBh
IHJlc291cmNlCj4+Pj4+IHJlc2VydmF0aW9uIGNvbmZsaWN0IGlzIHJlcG9ydGVkIGR1cmluZyBi
b290Lgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuIExlaSA8dGh1bmRlci5sZWl6aGVu
QGh1YXdlaS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDCoMKgIGRyaXZlcnMvcGVyZi9hcm1fc21tdXYz
X3BtdS5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4+
Pj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYyBi
L2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jCj4+Pj4+IGluZGV4IDc0NDc0YmIzMjJjM2Yy
Ni4uZGNjZTA4NTQzMWM2Y2U4IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3BlcmYvYXJtX3Nt
bXV2M19wbXUuYwo+Pj4+PiArKysgYi9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+Pj4+
PiBAQCAtNzYxLDYgKzc2MSw0NCBAQCBzdGF0aWMgdm9pZCBzbW11X3BtdV9nZXRfYWNwaV9vcHRp
b25zKHN0cnVjdCBzbW11X3BtdSAqc21tdV9wbXUpCj4+Pj4+IMKgwqDCoMKgwqDCoCBkZXZfbm90
aWNlKHNtbXVfcG11LT5kZXYsICJvcHRpb24gbWFzayAweCV4XG4iLCBzbW11X3BtdS0+b3B0aW9u
cyk7Cj4+Pj4+IMKgwqAgfQo+Pj4+PiDCoMKgICtzdGF0aWMgdm9pZCBfX2lvbWVtICoKPj4+Pj4g
K3NtbXVfcG11X2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2LAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBpbnQgaW5kZXgsCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCByZXNvdXJjZSAqKm91dF9yZXMpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqAgaW50IHJldDsK
Pj4+Pj4gK8KgwqDCoCB2b2lkIF9faW9tZW0gKmJhc2U7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IHJl
c291cmNlICpyZXM7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCByZXMgPSBwbGF0Zm9ybV9nZXRfcmVz
b3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIGluZGV4KTsKPj4+Pj4gK8KgwqDCoCBpZiAoIXJl
cykgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZGV2X2VycigmcGRldi0+ZGV2LCAiaW52YWxpZCBy
ZXNvdXJjZVxuIik7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gSU9NRU1fRVJSX1BUUigt
RUlOVkFMKTsKPj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+ICvCoMKgwqAgaWYgKG91dF9yZXMpCj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCAqb3V0X3JlcyA9IHJlczsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIHJl
dCA9IHJlZ2lvbl9pbnRlcnNlY3RzKHJlcy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSwKPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJT1JFU09VUkNFX01FTSwgSU9SRVNf
REVTQ19OT05FKTsKPj4+Pj4gK8KgwqDCoCBpZiAocmV0ID09IFJFR0lPTl9JTlRFUlNFQ1RTKSB7
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAvKgo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBy
ZXNvdXJjZSBoYXMgYWxyZWFkeSBiZWVuIHJlc2VydmVkIGJ5IHRoZSBTTU1VdjMgZHJpdmVyLgo+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIERvbid0IHJlc2VydmUgaXQgYWdhaW4sIGp1c3QgZG8g
ZGV2bV9pb3JlbWFwKCkuCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICovCj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoCBiYXNlID0gZGV2bV9pb3JlbWFwKCZwZGV2LT5kZXYsIHJlcy0+c3RhcnQsIHJlc291
cmNlX3NpemUocmVzKSk7Cj4+Pj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIC8qCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogVGhlIHJlc291cmNlIG1heSBoYXZlIG5v
dCBiZWVuIHJlc2VydmVkIGJ5IGFueSBkcml2ZXIsIG9yCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
ICogaGFzIGJlZW4gcmVzZXJ2ZWQgYnV0IG5vdCB0eXBlIElPUkVTT1VSQ0VfTUVNLiBJbiB0aGUg
bGF0dGVyCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogY2FzZSwgZGV2bV9pb3JlbWFwX3Jlc291
cmNlKCkgcmVwb3J0cyBhIGNvbmZsaWN0IGFuZCByZXR1cm5zCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgICogSU9NRU1fRVJSX1BUUigtRUJVU1kpLgo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+
ZGV2LCByZXMpOwo+Pj4+PiArwqDCoMKgIH0KPj4+Pgo+Pj4+IFdoYXQgaWYgdGhlIFBNQ0cgZHJp
dmVyIHNpbXBseSBoYXBwZW5zIHRvIHByb2JlIGZpcnN0Pwo+Pj4KPj4+IFRoZXJlIGFyZSA0IGNh
c2VzOgo+Pj4gMSkgQVJNX1NNTVVfVjM9bSwgQVJNX1NNTVVfVjNfUE1VPXkKPj4+IMKgwqDCoCBJ
dCdzIG5vdCBhbGxvd2VkLiBCZWNhc2U6IEFSTV9TTU1VX1YzX1BNVSBkZXBlbmRzIG9uIEFSTV9T
TU1VX1YzCj4+PiDCoMKgwqAgY29uZmlnIEFSTV9TTU1VX1YzX1BNVQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHRyaXN0YXRlICJBUk0gU01NVXYzIFBlcmZvcm1hbmNlIE1vbml0b3JzIEV4dGVuc2lv
biIKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkZXBlbmRzIG9uIEFSTTY0ICYmIEFDUEkgJiYgQVJN
X1NNTVVfVjMKPj4+Cj4+PiAyKSBBUk1fU01NVV9WMz15LCBBUk1fU01NVV9WM19QTVU9bQo+Pj4g
wqDCoMKgIE5vIHByb2JsZW0sIFNNTVV2MyB3aWxsIGJlIGluaXRpYWxpemVkIGZpcnN0Lgo+Pj4K
Pj4+IDMpIEFSTV9TTU1VX1YzPXksIEFSTV9TTU1VX1YzX1BNVT15Cj4+PiDCoMKgwqAgdmkgZHJp
dmVycy9NYWtlZmlsZQo+Pj4gwqDCoMKgIDYwIG9iai15wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCArPSBpb21tdS8KPj4+IMKgwqDCoCAxNzIgb2Jq
LSQoQ09ORklHX1BFUkZfRVZFTlRTKcKgwqDCoMKgwqDCoCArPSBwZXJmLwo+Pj4KPj4+IMKgwqDC
oCBUaGlzIGxpbmsgc2VxdWVuY2UgZW5zdXJlIHRoYXQgU01NVXYzIGRyaXZlciB3aWxsIGJlIGlu
aXRpYWxpemVkIGZpcnN0Lgo+Pj4gwqDCoMKgIFRoZXkgYXJlIGN1cnJlbnRseSBhdCB0aGUgc2Ft
ZSBpbml0aWFsaXphdGlvbiBsZXZlbC4KPj4+Cj4+PiA0KSBBUk1fU01NVV9WMz1tLCBBUk1fU01N
VV9WM19QTVU9bQo+Pj4gwqDCoMKgIFNvcnJ5LCBJIHRob3VnaHQgbW9kdWxlIGRlcGVuZGVuY2ll
cyB3ZXJlIGdlbmVyYXRlZCBiYXNlZCBvbiAiZGVwZW5kcyBvbiIuCj4+PiDCoMKgwqAgQnV0IEkg
dHJpZWQgaXQgdG9kYXnvvIxtb2R1bGUgZGVwZW5kZW5jaWVzIGFyZSBnZW5lcmF0ZWQgb25seSB3
aGVuIHN5bWJvbAo+Pj4gwqDCoMKgIGRlcGVuZGVuY2llcyBleGlzdC4gSSBzaG91bGQgdXNlIE1P
RFVMRV9TT0ZUREVQKCkgdG8gZXhwbGljaXRseSBtYXJrIHRoZQo+Pj4gwqDCoMKgIGRlcGVuZGVu
Y3kuIEkgd2lsbCBzZW5kIFYyIGxhdGVyLgo+Pj4KPj4KPj4gSGkgUm9iaW46Cj4+IMKgwqAgSSB0
aGluayBJIG1pc3VuZGVyc3Rvb2QgeW91ciBxdWVzdGlvbi4gVGhlIHByb2JlKCkgaW5zdGVhZCBv
ZiBtb2R1bGVfaW5pdCgpCj4+IGRldGVybWluZXMgdGhlIHRpbWUgZm9yIHJlc2VydmluZyByZWdp
c3RlciBzcGFjZSByZXNvdXJjZXMuwqAgU28gd2UnZCBiZXR0ZXIKPj4gcmVzZXJ2ZSBtdWx0aXBs
ZSBzbWFsbCBibG9ja3Mgb2YgcmVzb3VyY2VzIGluIFNNTVV2MyBidXQgcGVyZm9ybSBpb3JlbWFw
KCkgZm9yCj4+IHRoZSBlbnRpcmUgcmVzb3VyY2UsIGlmIHRoZSBwcm9iZSgpIG9mIHRoZSBQTUNH
IG9jY3VycyBmaXJzdC4KPj4gwqDCoCBJJ2xsIHJlZmluZSB0aGVzZSBwYXRjaGVzIHRvIG1ha2Ug
Ym90aCBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZXMgd29yayB3ZWxsLgo+PiBJJ20gdHJ5aW5nIHRv
IHNlbmQgVjIgdGhpcyB3ZWVrLgo+IAo+IFRoZXJlJ3Mgc3RpbGwgdGhlIHBvc3NpYmlsaXR5IHRo
YXQgYSBQTUNHIGlzIGltcGxlbWVudGVkIGluIGEgcm9vdCBjb21wbGV4IG9yIHNvbWUgb3RoZXIg
ZGV2aWNlIHRoYXQgaXNuJ3QgYW4gU01NVSwgc28gYXMgSSd2ZSBzYWlkIGJlZm9yZSwgbm9uZSBv
ZiB0aGlzIHRyaWNrZXJ5IHJlYWxseSBzY2FsZXMuCj4gCj4gQXMgZmFyIGFzIEkgdW5kZXJzdGFu
ZCBpdCwgdGhlIG1haW4gcG9pbnQgb2YgcmVzZXJ2aW5nIHJlc291cmNlcyBpcyB0byBjYXRjaCBi
dWdzIHdoZXJlIHRoaW5ncyBkZWZpbml0ZWx5IHNob3VsZCBub3QgYmUgb3ZlcmxhcHBpbmcuIFBN
Q0dzIGFyZSBieSBkZWZpbml0aW9uIHBhcnQgb2Ygc29tZSBvdGhlciBkZXZpY2UsIHNvIGluIGdl
bmVyYWwgdGhleSAqY2FuKiBiZSBleHBlY3RlZCB0byBvdmVybGFwIHdpdGggd2hhdGV2ZXIgZGV2
aWNlIHRoYXQgaXMuIEkgc3RpbGwgdGhpbmsgaXQncyBtb3N0IGxvZ2ljYWwgdG8gc2ltcGx5ICpu
b3QqIHRyeSB0byByZXNlcnZlIFBNQ0cgcmVzb3VyY2VzIGF0IGFsbC4KCklmIFBNQ0cgcmVzb3Vy
Y2VzIG1heSBvdmVybGFwIHdpdGggb3RoZXIgZGV2aWNlcywgdGhhdCdzIHJlYWxseSBnb2luZyB0
byBiZSBhIHZlcnkgdHJpY2t5IHRoaW5nLiBPSywgSSdsbCBmb2xsb3cgeW91ciBhZHZpY2XvvIxq
dXN0IGRvIGlvcmVtYXAoKSBmb3IgdGhlIFBNQ0cgcmVzb3VyY2VzLgoKSSBrbm93IHRoYXQgSS9P
IHJlc291cmNlIGluZm9ybWF0aW9uIGNhbiBiZSBxdWVyaWVkIGJ5IHJ1bm5pbmcgImNhdCAvcHJv
Yy9pb21lbSIuIElmIHdlIGRvIG5vdCByZXNlcnZlIFBNQ0cgcmVzb3VyY2VzLCBzaG91bGQgd2Ug
cHJvdmlkZSBhbiBhZGRpdGlvbmFsIGZzIHF1ZXJ5IGludGVyZmFjZT8KCj4gCj4gUm9iaW4uCj4g
Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCByZXR1cm4gYmFzZTsKPj4+Pj4gK30KPj4+Pj4gKwo+Pj4+
PiDCoMKgIHN0YXRpYyBpbnQgc21tdV9wbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKPj4+Pj4gwqDCoCB7Cj4+Pj4+IMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc21tdV9wbXUgKnNt
bXVfcG11Owo+Pj4+PiBAQCAtNzkzLDcgKzgzMSw3IEBAIHN0YXRpYyBpbnQgc21tdV9wbXVfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLmNhcGFiaWxpdGllc8KgwqDCoCA9IFBFUkZfUE1VX0NBUF9OT19FWENMVURFLAo+Pj4+PiDC
oMKgwqDCoMKgwqAgfTsKPj4+Pj4gwqDCoCAtwqDCoMKgIHNtbXVfcG11LT5yZWdfYmFzZSA9IGRl
dm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsICZyZXNfMCk7Cj4+
Pj4+ICvCoMKgwqAgc21tdV9wbXUtPnJlZ19iYXNlID0gc21tdV9wbXVfZ2V0X2FuZF9pb3JlbWFw
X3Jlc291cmNlKHBkZXYsIDAsICZyZXNfMCk7Cj4+Pj4+IMKgwqDCoMKgwqDCoCBpZiAoSVNfRVJS
KHNtbXVfcG11LT5yZWdfYmFzZSkpCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQ
VFJfRVJSKHNtbXVfcG11LT5yZWdfYmFzZSk7Cj4+Pj4+IMKgwqAgQEAgLTgwMSw3ICs4MzksNyBA
QCBzdGF0aWMgaW50IHNtbXVfcG11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCAvKiBEZXRlcm1pbmUgaWYgcGFnZSAxIGlzIHByZXNlbnQg
Ki8KPj4+Pj4gwqDCoMKgwqDCoMKgIGlmIChjZmdyICYgU01NVV9QTUNHX0NGR1JfUkVMT0NfQ1RS
Uykgewo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgc21tdV9wbXUtPnJlbG9jX2Jhc2UgPSBkZXZtX3Bs
YXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMSk7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBz
bW11X3BtdS0+cmVsb2NfYmFzZSA9IHNtbXVfcG11X2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShw
ZGV2LCAxLCBOVUxMKTsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihzbW11
X3BtdS0+cmVsb2NfYmFzZSkpCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIFBUUl9FUlIoc21tdV9wbXUtPnJlbG9jX2Jhc2UpOwo+Pj4+PiDCoMKgwqDCoMKgwqAgfSBl
bHNlIHsKPj4+Pj4KPj4+Pgo+Pj4+IC4KPj4+Pgo+Pgo+IAo+IC4KPiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
