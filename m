Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB07C433FE
	for <iommu@archiver.kernel.org>; Thu, 25 Nov 2021 15:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 137F3408FB;
	Thu, 25 Nov 2021 15:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMoQeOR52af9; Thu, 25 Nov 2021 15:49:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD986408F8;
	Thu, 25 Nov 2021 15:49:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B87B4C0012;
	Thu, 25 Nov 2021 15:49:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E73AC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Nov 2021 15:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D8C6403E3
 for <iommu@lists.linux-foundation.org>; Thu, 25 Nov 2021 15:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_tdEZUZiSrJ for <iommu@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 15:49:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93367400C6
 for <iommu@lists.linux-foundation.org>; Thu, 25 Nov 2021 15:49:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8819E1FB;
 Thu, 25 Nov 2021 07:49:34 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77B2A3F73B;
 Thu, 25 Nov 2021 07:49:30 -0800 (PST)
Message-ID: <38bfa372-54c8-2e81-adab-ca24051a0fe6@arm.com>
Date: Thu, 25 Nov 2021 15:49:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/6] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
Content-Language: en-GB
To: Yicong Yang <yangyicong@hisilicon.com>, gregkh@linuxfoundation.org,
 helgaas@kernel.org, alexander.shishkin@linux.intel.com,
 lorenzo.pieralisi@arm.com, will@kernel.org, mark.rutland@arm.com,
 mathieu.poirier@linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org,
 leo.yan@linaro.org, jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
 joro@8bytes.org, john.garry@huawei.com,
 shameerali.kolothum.thodi@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-3-yangyicong@hisilicon.com>
 <0b67745c-13dd-1fea-1b8b-d55212bad232@arm.com>
 <3644ad6e-d800-c84b-9d62-6dda8462450f@hisilicon.com>
 <e7d4afb7-e4e4-e581-872b-2477850ad8da@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e7d4afb7-e4e4-e581-872b-2477850ad8da@hisilicon.com>
Cc: zhangshaokun@hisilicon.com, liuqi115@huawei.com, linuxarm@huawei.com,
 prime.zeng@huawei.com
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

T24gMjAyMS0xMS0xOCAwOTowMSwgWWljb25nIFlhbmcgdmlhIGlvbW11IHdyb3RlOgo+IEhpIFJv
YmluLAo+IAo+IE9uIDIwMjEvMTEvMTYgMTk6MzcsIFlpY29uZyBZYW5nIHdyb3RlOgo+PiBPbiAy
MDIxLzExLzE2IDE4OjU2LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBPbiAyMDIxLTExLTE2IDA5
OjA2LCBZaWNvbmcgWWFuZyB2aWEgaW9tbXUgd3JvdGU6Cj4+PiBbLi4uXQo+Pj4+ICsvKgo+Pj4+
ICsgKiBHZXQgUk1SIGFkZHJlc3MgaWYgcHJvdmlkZWQgYnkgdGhlIGZpcm13YXJlLgo+Pj4+ICsg
KiBSZXR1cm4gMCBpZiB0aGUgSU9NTVUgZG9lc24ndCBwcmVzZW50IG9yIHRoZSBwb2xpY3kgb2Yg
dGhlCj4+Pj4gKyAqIElPTU1VIGRvbWFpbiBpcyBwYXNzdGhyb3VnaCBvciB3ZSBnZXQgYSB1c2Fi
bGUgUk1SIHJlZ2lvbi4KPj4+PiArICogT3RoZXJ3aXNlIGEgbmVnYXRpdmUgdmFsdWUgaXMgcmV0
dXJuZWQuCj4+Pj4gKyAqLwo+Pj4+ICtzdGF0aWMgaW50IGhpc2lfcHR0X2dldF9ybXIoc3RydWN0
IGhpc2lfcHR0ICpoaXNpX3B0dCkKPj4+PiArewo+Pj4+ICvCoMKgwqAgc3RydWN0IHBjaV9kZXYg
KnBkZXYgPSBoaXNpX3B0dC0+cGRldjsKPj4+PiArwqDCoMKgIHN0cnVjdCBpb21tdV9kb21haW4g
KmlvbW11X2RvbWFpbjsKPj4+PiArwqDCoMKgIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiAqcmVn
aW9uOwo+Pj4+ICvCoMKgwqAgTElTVF9IRUFEKGxpc3QpOwo+Pj4+ICsKPj4+PiArwqDCoMKgIC8q
Cj4+Pj4gK8KgwqDCoMKgICogVXNlIGRpcmVjdCBETUEgaWYgSU9NTVUgZG9lcyBub3QgcHJlc2Vu
dCBvciB0aGUgcG9saWN5IG9mIHRoZQo+Pj4+ICvCoMKgwqDCoCAqIElPTU1VIGRvbWFpbiBpcyBw
YXNzdGhyb3VnaC4KPj4+PiArwqDCoMKgwqAgKi8KPj4+PiArwqDCoMKgIGlvbW11X2RvbWFpbiA9
IGlvbW11X2dldF9kb21haW5fZm9yX2RldigmcGRldi0+ZGV2KTsKPj4+PiArwqDCoMKgIGlmICgh
aW9tbXVfZG9tYWluIHx8IGlvbW11X2RvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fSURFTlRJ
VFkpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+ICsKPj4+PiArwqDCoMKgIGlv
bW11X2dldF9yZXN2X3JlZ2lvbnMoJnBkZXYtPmRldiwgJmxpc3QpOwo+Pj4+ICvCoMKgwqAgbGlz
dF9mb3JfZWFjaF9lbnRyeShyZWdpb24sICZsaXN0LCBsaXN0KQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBpZiAocmVnaW9uLT50eXBlID09IElPTU1VX1JFU1ZfRElSRUNUICYmCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVnaW9uLT5sZW5ndGggPj0gSElTSV9QVFRfVFJBQ0VfQlVGRkVSX1NJ
WkUpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoaXNpX3B0dC0+dHJhY2VfY3RybC5o
YXNfcm1yID0gdHJ1ZTsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoaXNpX3B0dC0+dHJh
Y2VfY3RybC5ybXJfYWRkciA9IHJlZ2lvbi0+c3RhcnQ7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaGlzaV9wdHQtPnRyYWNlX2N0cmwucm1yX2xlbmd0aCA9IHJlZ2lvbi0+bGVuZ3RoOwo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9
Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucygmcGRldi0+ZGV2LCAm
bGlzdCk7Cj4+Pj4gK8KgwqDCoCByZXR1cm4gaGlzaV9wdHQtPnRyYWNlX2N0cmwuaGFzX3JtciA/
IDAgOiAtRU5PTUVNOwo+Pj4+ICt9Cj4+Pgo+Pj4gTm8uCj4+Pgo+Pj4gVGhlIHdob2xlIHBvaW50
IG9mIFJNUnMgaXMgZm9yIGRldmljZXMgdGhhdCBhcmUgYWxyZWFkeSBjb25maWd1cmVkIHRvIGFj
Y2VzcyB0aGUgZ2l2ZW4gYWRkcmVzcyByYW5nZSBpbiBhIG1hbm5lciBiZXlvbmQgdGhlIGtlcm5l
bCdzIGNvbnRyb2wuIElmIHlvdSBjYW4gZG8gdGhpcywgaXQgcHJvdmVzIHRoYXQgeW91IHNob3Vs
ZCBub3QgaGF2ZSBhbiBSTVIgaW4gdGhlIGZpcnN0IHBsYWNlLgo+Pj4KPj4+IFRoZSBub3Rpb24g
b2YgYSBrZXJuZWwgZHJpdmVyIGV4cGxpY2l0bHkgY29uZmlndXJpbmcgaXRzIGRldmljZSB0byBE
TUEgaW50byBhbnkgcmFuZG9tIFJNUiB0aGF0IGxvb2tzIGJpZyBlbm91Z2ggaXMgc28gZWdyZWdp
b3VzbHkgd3JvbmcgdGhhdCBJJ20gYWxtb3N0IGxvc3QgZm9yIHdvcmRzLi4uCj4+Pgo+Pgo+PiBv
dXIgYmlvcyB3aWxsIHJlc2VydmUgc3VjaCBhIHJlZ2lvbiBhbmQgcmVwb3J0ZWQgaXQgdGhyb3Vn
aCBpb3J0LiB0aGUgZGV2aWNlIHdpbGwgd3JpdGUgdG8gdGhlIHJlZ2lvbiBhbmQgaW4gdGhlIGRy
aXZlciB3ZSBuZWVkIHRvIGFjY2VzcyB0aGUgcmVnaW9uCj4+IHRvIGdldCB0aGUgdHJhY2VkIGRh
dGEuIHRoZSByZWdpb24gaXMgcmVzZXJ2ZWQgZXhjbHVzaXZlbHkgYW5kIHdpbGwgbm90IGJlIGFj
Y2Vzc2VkIGJ5IGtlcm5lbCBvciBvdGhlciBkZXZpY2VzLgo+Pgo+PiBpcyBpdCBvayB0byBsZXQg
YmlvcyBjb25maWd1cmUgdGhlIGFkZHJlc3MgdG8gdGhlIGRldmljZSBhbmQgZnJvbSBDUFUgc2lk
ZSB3ZSBqdXN0IHJlYWQgaXQ/Cj4+Cj4gCj4gQW55IHN1Z2dlc3Rpb24/ICBJcyB0aGlzIHN0aWxs
IGFuIGlzc3VlIHlvdSBjb25jZXJuIGlmIHdlIG1vdmUgdGhlIGNvbmZpZ3VyYXRpb24gb2YgdGhl
IGRldmljZSBhZGRyZXNzIHRvIEJJT1MgYW5kIGp1c3QgcmVhZCBmcm9tIHRoZSBDUFUgc2lkZT8K
CklmIHRoZSBmaXJtd2FyZSBjb25maWd1cmVzIHRoZSBkZXZpY2Ugc28gdGhhdCBpdCdzIGFjdGl2
ZWx5IHRyYWNpbmcgYW5kIAp3cml0aW5nIG91dCB0byBtZW1vcnkgd2hpbGUgdGhlIGtlcm5lbCBi
b290cywgdGhlbiB0aGF0IGlzIGEgdmFsaWQgCnJlYXNvbiB0byBoYXZlIGFuIFJNUi4gSG93ZXZl
ciB3aGF0IHlvdSdyZSBkb2luZyBpbiB0aGUgZHJpdmVyIGlzIHN0aWxsIApjb21wbGV0ZSBub25z
ZW5zZS4gQXMgZmFyIGFzIEkgY2FuIGZvbGxvdywgdGhlIHdheSBpdCdzIHdvcmtpbmcgaXMgdGhp
czoKCi0gQXQgcHJvYmUgdGltZSwgdGhlIGluaXRpYWwgc3RhdGUgb2YgdGhlIGhhcmR3YXJlIGlz
IGVudGlyZWx5IGlnbm9yZWQuIApJZiBpdCAqaXMqIGFscmVhZHkgYWN0aXZlLCB0aGVyZSBhcHBl
YXJzIHRvIGJlIGEgZnVuIGNoYW5jZSBvZiBjcmFzaGluZyAKaWYgVFJBQ0VfSU5UX01BU0sgaXMg
Y2xlYXIgYW5kIGFuIGludGVycnVwdCBoYXBwZW5zIHRvIGZpcmUgYmVmb3JlIAphbnlvbmUgaGFz
IGdvdCByb3VuZCB0byBjYWxsaW5nIHBlcmZfYXV4X291dHB1dF9iZWdpbigpIHRvIG1ha2UgCnRy
YWNlX2N0cmwuaGFuZGxlLnJiIG5vbi1OVUxMLgoKLSBMYXRlciwgb25jZSB0aGUgdXNlciBzdGFy
dHMgYSB0cmFjaW5nIHNlc3Npb24sIGEgYnVmZmVyIGlzIHNldCB1cCAKKmVpdGhlciogYXMgYSBj
b21wbGV0ZWx5IG5vcm1hbCBETUEgYWxsb2NhdGlvbiwgb3IgYnkgbWVtcmVtYXAoKWluZyBzb21l
IApyYW5kb20gSU9WQSBjYXJ2ZW91dCB3aGljaCBtYXkgb3IgbWF5IG5vdCBiZSB3aGF0ZXZlciBt
ZW1vcnkgdGhlIApmaXJtd2FyZSB3YXMgdHJhY2luZyB0by4KCi0gVGhlIGhhcmR3YXJlIGlzIHRo
ZW4gcmVzZXQgYW5kIGNvbXBsZXRlbHkgcmVwcm9ncmFtbWVkIHRvIHVzZSB0aGUgbmV3IApidWZm
ZXIsIGFnYWluIHdpdGhvdXQgYW55IGNvbnNpZGVyYXRpb24gb2YgaXRzIHByZXZpb3VzIHN0YXRl
IChvdGhlciAKdGhhbiBwb3NzaWJseSB0aW1pbmcgb3V0IGFuZCBmYWlsaW5nIGlmIGl0J3MgYWxy
ZWFkeSBydW5uaW5nIGFuZCB0aGF0IAptZWFucyBpdCBuZXZlciBnb2VzIGlkbGUpLgoKVGhlcmVm
b3JlIHRoZSBkcml2ZXIgZG9lcyBub3Qgc2VlbSB0byByZXNwZWN0IGFueSBwcmlvciBjb25maWd1
cmF0aW9uIG9mIAp0aGUgZGV2aWNlIGJ5IGZpcm13YXJlLCBkb2VzIG5vdCBzZWVtIHRvIGV4cGVj
dCBpdCB0byBiZSBydW5uaW5nIGF0IGJvb3QgCnRpbWUsIGRvZXMgbm90IHNlZW0gdG8gaGF2ZSBh
bnkgd2F5IHRvIHByZXNlcnZlIGFuZCBleHBvcnQgYW55IHRyYWNlIApkYXRhIGNhcHR1cmVkIGlu
IGFuIFJNUiBpZiBpdCAqd2FzKiBydW5uaW5nIGF0IGJvb3QgdGltZSwgYW5kIHRodXMgCndpdGhv
dXQgbG9zcyBvZiBnZW5lcmFsaXR5IGNvdWxkIHNpbXBseSB1c2UgdGhlIGRtYV9hbGxvY19jb2hl
cmVudCgpIApwYXRoIGFsbCB0aGUgdGltZS4gQW0gSSBtaXNzaW5nIGFueXRoaW5nPwoKQXMgdGhp
bmdzIHN0YW5kLCBSTVJzIGFyZSBub3QgeWV0IHN1cHBvcnRlZCB1cHN0cmVhbSAoRllJIHdlJ3Jl
IHN0aWxsIAp3b3JraW5nIG9uIGZpeGluZyB0aGUgc3BlYy4uLiksIHNvIHRoZSBjb2RlIGFib3Zl
IGlzIGF0IGJlc3QgZGVhZCwgYW5kIAphdCB3b3JzdCBhY3RpdmVseSB3cm9uZy4gRnVydGhlcm1v
cmUsIGlmIHRoZSBleHBlY3RlZCB1c2FnZSBtb2RlbCAqaXMqIAp0aGF0IHRoZSBrZXJuZWwgZHJp
dmVyIGNvbXBsZXRlbHkgcmVzZXRzIGFuZCByZXByb2dyYW1zIHRoZSBoYXJkd2FyZSwgCnRoZW4g
ZXZlbiBpZiB0aGVyZSBpcyBhbiBSTVIgZm9yIGJvb3QtdGltZSB0cmFjaW5nIEkgd291bGQgcmF0
aGVyIGV4cGVjdCAKaXQgdG8gYmUgZmxhZ2dlZCBhcyByZW1hcHBhYmxlLCBhbmQgdGh1cyBwb3Rl
bnRpYWxseSBlbmQgdXAgYXMgYW4gCklPTU1VX1JFU1ZfRElSRUNUX1JFTEFYQUJMRSByZXNlcnZh
dGlvbiB3aGljaCB5b3Ugd291bGRuJ3QgbWF0Y2ggYW55d2F5LgoKQW5kIGFmdGVyIGFsbCB0aGF0
LCBpZiB5b3UgcmVhbGx5IGRvIGhhdmUgYSBnZW51aW5lIG5lZWQgdG8gcmVzcGVjdCBhbmQgCnBy
ZXNlcnZlIHByaW9yIGZpcm13YXJlIGNvbmZpZ3VyYXRpb24gb2YgdGhlIGRldmljZSwgdGhlbiBJ
IHdvdWxkIHN1cmVseSAKZXhwZWN0IHRvIHNlZSB0aGUgZHJpdmVyIGFjdHVhbGx5IGRvaW5nIGV4
YWN0bHkgdGhhdC4gUHJlc3VtYWJseTogYXQgCnByb2JlIHRpbWUsIGxvb2sgYXQgVFJBQ0VfQ1RS
TDsgaWYgdGhlIGRldmljZSBpcyBhbHJlYWR5IGNvbmZpZ3VyZWQsIApyZWFkIG91dCB0aGF0IGNv
bmZpZ3VyYXRpb24gLSBlc3BlY2lhbGx5IGluY2x1ZGluZyBUUkFDRV9BRERSXyogLSBhbmQgCm1h
a2Ugc3VyZSB0byByZXVzZSBpdC4gTm90IGdvIG9mZiBvbiBhIHRhbmdlbnQgYmxpbmRseSBwb2tp
bmcgaW50byAKaW50ZXJuYWwgSU9NTVUgQVBJIGFic3RyYWN0aW9ucyBpbiB0aGUgdmFpbiBob3Bl
IHRoYXQgdGhlIGZpcnN0IHRoaW5nIAp5b3UgZmluZCBoYXBwZW5zIHRvIGJlIHNvcnQtb2YtcmVs
YXRlZCB0byB0aGUgaW5mb3JtYXRpb24gdGhhdCB5b3UgCmFjdHVhbGx5IGNhcmUgYWJvdXQuCgpU
aGFua3MsClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
