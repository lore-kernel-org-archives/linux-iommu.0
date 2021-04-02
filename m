Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A87EC433ED
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 03:41:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E94610EA
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 03:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E94610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABAA46061B;
	Fri,  2 Apr 2021 03:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HL2Eq5urzYDH; Fri,  2 Apr 2021 03:41:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A29360905;
	Fri,  2 Apr 2021 03:41:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28311C000B;
	Fri,  2 Apr 2021 03:41:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BACF1C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 03:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A19BB84C0F
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 03:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GztpL2D3VkkN for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 03:41:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1611384C0D
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 03:41:19 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBQkb4pJ0zNsD0;
 Fri,  2 Apr 2021 11:38:31 +0800 (CST)
Received: from [10.174.151.207] (10.174.151.207) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 11:41:05 +0800
Subject: Re: [PATCH] iommu/vt-d: Force to flush iotlb before creating superpage
To: Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
References: <20210401071834.1639-1-longpeng2@huawei.com>
 <af470760-04c1-0929-7304-0879ca7af542@linux.intel.com>
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Message-ID: <b4ddcefa-9492-326f-e717-b6623bc824c1@huawei.com>
Date: Fri, 2 Apr 2021 11:41:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <af470760-04c1-0929-7304-0879ca7af542@linux.intel.com>
X-Originating-IP: [10.174.151.207]
X-CFilter-Loop: Reflected
Cc: Kevin Tian <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 stable@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>
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

SGkgQmFvbHUsCgrlnKggMjAyMS80LzIgMTE6MDYsIEx1IEJhb2x1IOWGmemBkzoKPiBIaSBMb25n
cGVuZywKPiAKPiBPbiA0LzEvMjEgMzoxOCBQTSwgTG9uZ3BlbmcoTWlrZSkgd3JvdGU6Cj4+IFRo
ZSB0cmFuc2xhdGlvbiBjYWNoZXMgbWF5IHByZXNlcnZlIG9ic29sZXRlIGRhdGEgd2hlbiB0aGUK
Pj4gbWFwcGluZyBzaXplIGlzIGNoYW5nZWQsIHN1cHBvc2UgdGhlIGZvbGxvd2luZyBzZXF1ZW5j
ZSB3aGljaAo+PiBjYW4gcmV2ZWFsIHRoZSBwcm9ibGVtIHdpdGggaGlnaCBwcm9iYWJpbGl0eS4K
Pj4KPj4gMS5tbWFwKDRHQixNQVBfSFVHRVRMQikKPj4gMi4KPj4gwqDCoCB3aGlsZSAoMSkgewo+
PiDCoMKgwqAgKGEpwqDCoMKgIERNQSBNQVDCoMKgIDAsMHhhMDAwMAo+PiDCoMKgwqAgKGIpwqDC
oMKgIERNQSBVTk1BUCAwLDB4YTAwMDAKPj4gwqDCoMKgIChjKcKgwqDCoCBETUEgTUFQwqDCoCAw
LDB4YzAwMDAwMDAKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBETUEgcmVhZCBJT1ZB
IDAgbWF5IGZhaWx1cmUgaGVyZSAoTm90IHByZXNlbnQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogaWYgdGhlIHByb2JsZW0gb2NjdXJzLgo+PiDCoMKgwqAgKGQpwqDCoMKgIERNQSBV
Tk1BUCAwLDB4YzAwMDAwMDAKPj4gwqDCoCB9Cj4+Cj4+IFRoZSBwYWdlIHRhYmxlKG9ubHkgZm9j
dXMgb24gSU9WQSAwKSBhZnRlciAoYSkgaXM6Cj4+IMKgIFBNTDQ6IDB4MTlkYjVjMTAwM8KgwqAg
ZW50cnk6MHhmZmZmODk5YmRjZDJmMDAwCj4+IMKgwqAgUERQRTogMHgxYTFjYWNiMDAzwqAgZW50
cnk6MHhmZmZmODliMzViNWMxMDAwCj4+IMKgwqDCoCBQREU6IDB4MWEzMGE3MjAwM8KgIGVudHJ5
OjB4ZmZmZjg5YjM5Y2FjYjAwMAo+PiDCoMKgwqDCoCBQVEU6IDB4MjFkMjAwODAzwqAgZW50cnk6
MHhmZmZmODliM2IwYTcyMDAwCj4+Cj4+IFRoZSBwYWdlIHRhYmxlIGFmdGVyIChiKSBpczoKPj4g
wqAgUE1MNDogMHgxOWRiNWMxMDAzwqDCoCBlbnRyeToweGZmZmY4OTliZGNkMmYwMDAKPj4gwqDC
oCBQRFBFOiAweDFhMWNhY2IwMDPCoCBlbnRyeToweGZmZmY4OWIzNWI1YzEwMDAKPj4gwqDCoMKg
IFBERTogMHgxYTMwYTcyMDAzwqAgZW50cnk6MHhmZmZmODliMzljYWNiMDAwCj4+IMKgwqDCoMKg
IFBURTogMHgwwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5OjB4ZmZmZjg5YjNiMGE3MjAwMAo+Pgo+
PiBUaGUgcGFnZSB0YWJsZSBhZnRlciAoYykgaXM6Cj4+IMKgIFBNTDQ6IDB4MTlkYjVjMTAwM8Kg
wqAgZW50cnk6MHhmZmZmODk5YmRjZDJmMDAwCj4+IMKgwqAgUERQRTogMHgxYTFjYWNiMDAzwqAg
ZW50cnk6MHhmZmZmODliMzViNWMxMDAwCj4+IMKgwqDCoCBQREU6IDB4MjFkMjAwODgzwqDCoCBl
bnRyeToweGZmZmY4OWIzOWNhY2IwMDAgKCopCj4+Cj4+IEJlY2F1c2UgdGhlIFBERSBlbnRyeSBh
ZnRlciAoYikgaXMgcHJlc2VudCwgaXQgd29uJ3QgYmUKPj4gZmx1c2hlZCBldmVuIGlmIHRoZSBp
b21tdSBkcml2ZXIgZmx1c2ggY2FjaGUgd2hlbiB1bm1hcCwKPj4gc28gdGhlIG9ic29sZXRlIGRh
dGEgbWF5IGJlIHByZXNlcnZlZCBpbiBjYWNoZSwgd2hpY2gKPj4gd291bGQgY2F1c2UgdGhlIHdy
b25nIHRyYW5zbGF0aW9uIGF0IGVuZC4KPj4KPj4gSG93ZXZlciwgd2UgY2FuIHNlZSB0aGUgUERF
IGVudHJ5IGlzIGZpbmFsbHkgc3dpdGNoIHRvCj4+IDJNLXN1cGVycGFnZSBtYXBwaW5nLCBidXQg
aXQgZG9lcyBub3QgdHJhbnNmb3JtCj4+IHRvIDB4MjFkMjAwODgzIGRpcmVjdGx5Ogo+Pgo+PiAx
LiBQREU6IDB4MWEzMGE3MjAwMwo+PiAyLiBfX2RvbWFpbl9tYXBwaW5nCj4+IMKgwqDCoMKgwqAg
ZG1hX3B0ZV9mcmVlX3BhZ2V0YWJsZQo+PiDCoMKgwqDCoMKgwqDCoCBTZXQgdGhlIFBERSBlbnRy
eSB0byBaRVJPCj4+IMKgwqDCoMKgwqAgU2V0IHRoZSBQREUgZW50cnkgdG8gMHgyMWQyMDA4ODMK
Pj4KPj4gU28gd2UgbXVzdCBmbHVzaCB0aGUgY2FjaGUgYWZ0ZXIgdGhlIGVudHJ5IHN3aXRjaCB0
byBaRVJPCj4+IHRvIGF2b2lkIHRoZSBvYnNvbGV0ZSBpbmZvIGJlIHByZXNlcnZlZC4KPj4KPj4g
Q2M6IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4KPj4gQ2M6IEx1IEJhb2x1
IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+IENjOiBOYWRhdiBBbWl0IDxuYWRhdi5hbWl0
QGdtYWlsLmNvbT4KPj4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhh
dC5jb20+Cj4+IENjOiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4KPj4gQ2M6IEdv
bmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT4KPj4KPj4gRml4ZXM6IDY0OTFk
NGQwMjg5MyAoImludGVsLWlvbW11OiBGcmVlIG9sZCBwYWdlIHRhYmxlcyBiZWZvcmUgY3JlYXRp
bmcKPj4gc3VwZXJwYWdlIikKPj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHYzLjAr
Cj4+IExpbms6Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzY3MGJhYWY4
LTRmZjgtNGU4NC00YmUzLTAzMGI5NWFiNWE1ZUBodWF3ZWkuY29tLwo+Pgo+PiBTdWdnZXN0ZWQt
Ynk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6
IExvbmdwZW5nKE1pa2UpIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDE1ICsrKysrKysrKysrKystLQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9t
bXUuYwo+PiBpbmRleCBlZTA5MzIzLi5jYmNiNDM0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+
IEBAIC0yMzQyLDkgKzIzNDIsMjAgQEAgc3RhdGljIGlubGluZSBpbnQgaGFyZHdhcmVfbGFyZ2Vw
YWdlX2NhcHMoc3RydWN0Cj4+IGRtYXJfZG9tYWluICpkb21haW4sCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJlbW92ZWQgdG8gbWFrZSByb29tIGZvciBzdXBlcnBh
Z2UocykuCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFdlJ3JlIGFk
ZGluZyBuZXcgbGFyZ2UgcGFnZXMsIHNvIG1ha2Ugc3VyZQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiB3ZSBkb24ndCByZW1vdmUgdGhlaXIgcGFyZW50IHRhYmxlcy4K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogV2UgYWxzbyBuZWVkIHRvIGZsdXNoIHRoZSBpb3RsYiBiZWZv
cmUgY3JlYXRpbmcKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogc3VwZXJw
YWdlIHRvIGVuc3VyZSBpdCBkb2VzIG5vdCBwZXJzZXJ2ZXMgYW55Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIG9ic29sZXRlIGluZm8uCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRtYV9wdGVfZnJlZV9wYWdldGFibGUoZG9tYWluLCBpb3ZfcGZuLCBlbmRfcGZuLAo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGxhcmdlcGFnZV9sdmwgKyAxKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoZG1hX3B0ZV9wcmVzZW50KHB0ZSkpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGludCBpOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkbWFfcHRlX2ZyZWVfcGFnZXRhYmxlKGRvbWFpbiwgaW92X3BmbiwgZW5kX3Bm
biwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGxhcmdlcGFnZV9sdmwgKyAxKTsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvcl9lYWNoX2RvbWFpbl9pb21tdShpLCBkb21haW4p
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11
X2ZsdXNoX2lvdGxiX3BzaShnX2lvbW11c1tpXSwgZG9tYWluLAo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaW92X3BmbiwgbnJfcGFnZXMsIDAsIDApOwo+IAo+IFRoYW5rcyBmb3IgcGF0Y2ghCj4gCj4g
SG93IGFib3V0IG1ha2luZyB0aGUgZmx1c2hlZCBwYWdlIHNpemUgYWNjdXJhdGU/IEZvciBleGFt
cGxlLAo+IAo+IEBAIC0yMzY1LDggKzIzNjUsOCBAQCBfX2RvbWFpbl9tYXBwaW5nKHN0cnVjdCBk
bWFyX2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBsb25nCj4gaW92X3BmbiwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZG1hX3B0ZV9mcmVlX3BhZ2V0YWJsZShkb21haW4sIGlvdl9wZm4sCj4gZW5k
X3BmbiwKPiAKPiBsYXJnZXBhZ2VfbHZsICsgMSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZv
cl9lYWNoX2RvbWFpbl9pb21tdShpLCBkb21haW4pCj4gLSBpb21tdV9mbHVzaF9pb3RsYl9wc2ko
Z19pb21tdXNbaV0sIGRvbWFpbiwKPiAtIGlvdl9wZm4sIG5yX3BhZ2VzLCAwLCAwKTsKPiArIGlv
bW11X2ZsdXNoX2lvdGxiX3BzaShnX2lvbW11c1tpXSwgZG9tYWluLCBpb3ZfcGZuLAo+ICsgQUxJ
R05fRE9XTihucl9wYWdlcywgbHZsX3BhZ2VzKSwgMCwgMCk7Cj4gClllcywgbWFrZSBzZW5zZS4K
Ck1heWJlIGFub3RoZXIgYWx0ZXJuYXRpdmUgaXMgJ2VuZF9wZm4gLSBpb3ZhX3BmbiArIDEnLCBp
dCdzIHJlYWRhYmxlIGJlY2F1c2Ugd2UKZnJlZSBwYWdldGFibGUgd2l0aCAoaW92YV9wZm4sIGVu
ZF9wZm4pIGFib3ZlLiBXaGljaCBvbmUgZG8geW91IHByZWZlcj8KCj4gCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVs
c2Ugewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB0ZXZhbCAmPSB+KHVp
bnQ2NF90KURNQV9QVEVfTEFSR0VfUEFHRTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fQo+Pgo+IAo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQo+IC4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
