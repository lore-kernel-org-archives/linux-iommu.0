Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB688C43460
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 04:56:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EAB610E7
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 04:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EAB610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9F7360A3C;
	Fri,  2 Apr 2021 04:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmoDOF2PMAth; Fri,  2 Apr 2021 04:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0EBB60679;
	Fri,  2 Apr 2021 04:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C22DC000B;
	Fri,  2 Apr 2021 04:56:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9678CC000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 04:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 762E36090C
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 04:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Em3tKiukjaFP for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 04:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6121560679
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 04:56:29 +0000 (UTC)
IronPort-SDR: ZFvHVWOWd33vU3VVaXjC3aHh1MqqKBC8zGNVqCDBOuO+rIRrSi3OjnWRunGq08sVBP4bNwUExR
 B2ow88S0Q4rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189132551"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; d="scan'208";a="189132551"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 21:56:28 -0700
IronPort-SDR: mWB3118uCTIINZMPTNfhyU6fTxUfHNLgsqmUDa3qh+RGGuzEGIOR0lOcO2Sr/gffdufCMtZxMW
 tKW7FQrCglww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; d="scan'208";a="439477089"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 01 Apr 2021 21:56:26 -0700
Subject: Re: [PATCH] iommu/vt-d: Force to flush iotlb before creating superpage
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20210401071834.1639-1-longpeng2@huawei.com>
 <af470760-04c1-0929-7304-0879ca7af542@linux.intel.com>
 <b4ddcefa-9492-326f-e717-b6623bc824c1@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <94a6bd76-7382-8fc2-b398-b3d9a2146194@linux.intel.com>
Date: Fri, 2 Apr 2021 12:47:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <b4ddcefa-9492-326f-e717-b6623bc824c1@huawei.com>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gNC8yLzIxIDExOjQxIEFNLCBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUg
U2VydmljZSBQcm9kdWN0IApEZXB0Likgd3JvdGU6Cj4gSGkgQmFvbHUsCj4gCj4g5ZyoIDIwMjEv
NC8yIDExOjA2LCBMdSBCYW9sdSDlhpnpgZM6Cj4+IEhpIExvbmdwZW5nLAo+Pgo+PiBPbiA0LzEv
MjEgMzoxOCBQTSwgTG9uZ3BlbmcoTWlrZSkgd3JvdGU6Cj4+PiBUaGUgdHJhbnNsYXRpb24gY2Fj
aGVzIG1heSBwcmVzZXJ2ZSBvYnNvbGV0ZSBkYXRhIHdoZW4gdGhlCj4+PiBtYXBwaW5nIHNpemUg
aXMgY2hhbmdlZCwgc3VwcG9zZSB0aGUgZm9sbG93aW5nIHNlcXVlbmNlIHdoaWNoCj4+PiBjYW4g
cmV2ZWFsIHRoZSBwcm9ibGVtIHdpdGggaGlnaCBwcm9iYWJpbGl0eS4KPj4+Cj4+PiAxLm1tYXAo
NEdCLE1BUF9IVUdFVExCKQo+Pj4gMi4KPj4+ICDCoMKgIHdoaWxlICgxKSB7Cj4+PiAgwqDCoMKg
IChhKcKgwqDCoCBETUEgTUFQwqDCoCAwLDB4YTAwMDAKPj4+ICDCoMKgwqAgKGIpwqDCoMKgIERN
QSBVTk1BUCAwLDB4YTAwMDAKPj4+ICDCoMKgwqAgKGMpwqDCoMKgIERNQSBNQVDCoMKgIDAsMHhj
MDAwMDAwMAo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogRE1BIHJlYWQgSU9WQSAw
IG1heSBmYWlsdXJlIGhlcmUgKE5vdCBwcmVzZW50KQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogaWYgdGhlIHByb2JsZW0gb2NjdXJzLgo+Pj4gIMKgwqDCoCAoZCnCoMKgwqAgRE1B
IFVOTUFQIDAsMHhjMDAwMDAwMAo+Pj4gIMKgwqAgfQo+Pj4KPj4+IFRoZSBwYWdlIHRhYmxlKG9u
bHkgZm9jdXMgb24gSU9WQSAwKSBhZnRlciAoYSkgaXM6Cj4+PiAgwqAgUE1MNDogMHgxOWRiNWMx
MDAzwqDCoCBlbnRyeToweGZmZmY4OTliZGNkMmYwMDAKPj4+ICDCoMKgIFBEUEU6IDB4MWExY2Fj
YjAwM8KgIGVudHJ5OjB4ZmZmZjg5YjM1YjVjMTAwMAo+Pj4gIMKgwqDCoCBQREU6IDB4MWEzMGE3
MjAwM8KgIGVudHJ5OjB4ZmZmZjg5YjM5Y2FjYjAwMAo+Pj4gIMKgwqDCoMKgIFBURTogMHgyMWQy
MDA4MDPCoCBlbnRyeToweGZmZmY4OWIzYjBhNzIwMDAKPj4+Cj4+PiBUaGUgcGFnZSB0YWJsZSBh
ZnRlciAoYikgaXM6Cj4+PiAgwqAgUE1MNDogMHgxOWRiNWMxMDAzwqDCoCBlbnRyeToweGZmZmY4
OTliZGNkMmYwMDAKPj4+ICDCoMKgIFBEUEU6IDB4MWExY2FjYjAwM8KgIGVudHJ5OjB4ZmZmZjg5
YjM1YjVjMTAwMAo+Pj4gIMKgwqDCoCBQREU6IDB4MWEzMGE3MjAwM8KgIGVudHJ5OjB4ZmZmZjg5
YjM5Y2FjYjAwMAo+Pj4gIMKgwqDCoMKgIFBURTogMHgwwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5
OjB4ZmZmZjg5YjNiMGE3MjAwMAo+Pj4KPj4+IFRoZSBwYWdlIHRhYmxlIGFmdGVyIChjKSBpczoK
Pj4+ICDCoCBQTUw0OiAweDE5ZGI1YzEwMDPCoMKgIGVudHJ5OjB4ZmZmZjg5OWJkY2QyZjAwMAo+
Pj4gIMKgwqAgUERQRTogMHgxYTFjYWNiMDAzwqAgZW50cnk6MHhmZmZmODliMzViNWMxMDAwCj4+
PiAgwqDCoMKgIFBERTogMHgyMWQyMDA4ODPCoMKgIGVudHJ5OjB4ZmZmZjg5YjM5Y2FjYjAwMCAo
KikKPj4+Cj4+PiBCZWNhdXNlIHRoZSBQREUgZW50cnkgYWZ0ZXIgKGIpIGlzIHByZXNlbnQsIGl0
IHdvbid0IGJlCj4+PiBmbHVzaGVkIGV2ZW4gaWYgdGhlIGlvbW11IGRyaXZlciBmbHVzaCBjYWNo
ZSB3aGVuIHVubWFwLAo+Pj4gc28gdGhlIG9ic29sZXRlIGRhdGEgbWF5IGJlIHByZXNlcnZlZCBp
biBjYWNoZSwgd2hpY2gKPj4+IHdvdWxkIGNhdXNlIHRoZSB3cm9uZyB0cmFuc2xhdGlvbiBhdCBl
bmQuCj4+Pgo+Pj4gSG93ZXZlciwgd2UgY2FuIHNlZSB0aGUgUERFIGVudHJ5IGlzIGZpbmFsbHkg
c3dpdGNoIHRvCj4+PiAyTS1zdXBlcnBhZ2UgbWFwcGluZywgYnV0IGl0IGRvZXMgbm90IHRyYW5z
Zm9ybQo+Pj4gdG8gMHgyMWQyMDA4ODMgZGlyZWN0bHk6Cj4+Pgo+Pj4gMS4gUERFOiAweDFhMzBh
NzIwMDMKPj4+IDIuIF9fZG9tYWluX21hcHBpbmcKPj4+ICDCoMKgwqDCoMKgIGRtYV9wdGVfZnJl
ZV9wYWdldGFibGUKPj4+ICDCoMKgwqDCoMKgwqDCoCBTZXQgdGhlIFBERSBlbnRyeSB0byBaRVJP
Cj4+PiAgwqDCoMKgwqDCoCBTZXQgdGhlIFBERSBlbnRyeSB0byAweDIxZDIwMDg4Mwo+Pj4KPj4+
IFNvIHdlIG11c3QgZmx1c2ggdGhlIGNhY2hlIGFmdGVyIHRoZSBlbnRyeSBzd2l0Y2ggdG8gWkVS
Two+Pj4gdG8gYXZvaWQgdGhlIG9ic29sZXRlIGluZm8gYmUgcHJlc2VydmVkLgo+Pj4KPj4+IENj
OiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+Cj4+PiBDYzogTHUgQmFvbHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4+IENjOiBOYWRhdiBBbWl0IDxuYWRhdi5hbWl0
QGdtYWlsLmNvbT4KPj4+IENjOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRo
YXQuY29tPgo+Pj4gQ2M6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPgo+Pj4gQ2M6
IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT4KPj4+Cj4+PiBGaXhlczog
NjQ5MWQ0ZDAyODkzICgiaW50ZWwtaW9tbXU6IEZyZWUgb2xkIHBhZ2UgdGFibGVzIGJlZm9yZSBj
cmVhdGluZwo+Pj4gc3VwZXJwYWdlIikKPj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4g
IyB2My4wKwo+Pj4gTGluazoKPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11
LzY3MGJhYWY4LTRmZjgtNGU4NC00YmUzLTAzMGI5NWFiNWE1ZUBodWF3ZWkuY29tLwo+Pj4KPj4+
IFN1Z2dlc3RlZC1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4+IFNp
Z25lZC1vZmYtYnk6IExvbmdwZW5nKE1pa2UpIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPj4+IC0t
LQo+Pj4gIMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDE1ICsrKysrKysrKysrKyst
LQo+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2
ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4+IGluZGV4IGVlMDkzMjMuLmNiY2I0MzQgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvaW50ZWwvaW9tbXUuYwo+Pj4gQEAgLTIzNDIsOSArMjM0MiwyMCBAQCBzdGF0aWMgaW5s
aW5lIGludCBoYXJkd2FyZV9sYXJnZXBhZ2VfY2FwcyhzdHJ1Y3QKPj4+IGRtYXJfZG9tYWluICpk
b21haW4sCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcmVtb3Zl
ZCB0byBtYWtlIHJvb20gZm9yIHN1cGVycGFnZShzKS4KPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBXZSdyZSBhZGRpbmcgbmV3IGxhcmdlIHBhZ2VzLCBzbyBtYWtl
IHN1cmUKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB3ZSBkb24n
dCByZW1vdmUgdGhlaXIgcGFyZW50IHRhYmxlcy4KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXZSBh
bHNvIG5lZWQgdG8gZmx1c2ggdGhlIGlvdGxiIGJlZm9yZSBjcmVhdGluZwo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogc3VwZXJwYWdlIHRvIGVuc3VyZSBpdCBkb2VzIG5v
dCBwZXJzZXJ2ZXMgYW55Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBv
YnNvbGV0ZSBpbmZvLgo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
Lwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfcHRlX2ZyZWVfcGFnZXRh
YmxlKGRvbWFpbiwgaW92X3BmbiwgZW5kX3BmbiwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGFyZ2VwYWdlX2x2bCArIDEp
Owo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZG1hX3B0ZV9wcmVzZW50
KHB0ZSkpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQg
aTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFf
cHRlX2ZyZWVfcGFnZXRhYmxlKGRvbWFpbiwgaW92X3BmbiwgZW5kX3BmbiwKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBsYXJnZXBhZ2VfbHZsICsgMSk7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZm9yX2VhY2hfZG9tYWluX2lvbW11KGksIGRvbWFpbikKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2ZsdXNoX2lvdGxi
X3BzaShnX2lvbW11c1tpXSwgZG9tYWluLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvdl9wZm4s
IG5yX3BhZ2VzLCAwLCAwKTsKPj4KPj4gVGhhbmtzIGZvciBwYXRjaCEKPj4KPj4gSG93IGFib3V0
IG1ha2luZyB0aGUgZmx1c2hlZCBwYWdlIHNpemUgYWNjdXJhdGU/IEZvciBleGFtcGxlLAo+Pgo+
PiBAQCAtMjM2NSw4ICsyMzY1LDggQEAgX19kb21haW5fbWFwcGluZyhzdHJ1Y3QgZG1hcl9kb21h
aW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZwo+PiBpb3ZfcGZuLAo+PiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRtYV9wdGVfZnJlZV9wYWdldGFibGUoZG9tYWluLCBpb3ZfcGZuLAo+PiBlbmRfcGZu
LAo+Pgo+PiBsYXJnZXBhZ2VfbHZsICsgMSk7Cj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9y
X2VhY2hfZG9tYWluX2lvbW11KGksIGRvbWFpbikKPj4gLSBpb21tdV9mbHVzaF9pb3RsYl9wc2ko
Z19pb21tdXNbaV0sIGRvbWFpbiwKPj4gLSBpb3ZfcGZuLCBucl9wYWdlcywgMCwgMCk7Cj4+ICsg
aW9tbXVfZmx1c2hfaW90bGJfcHNpKGdfaW9tbXVzW2ldLCBkb21haW4sIGlvdl9wZm4sCj4+ICsg
QUxJR05fRE9XTihucl9wYWdlcywgbHZsX3BhZ2VzKSwgMCwgMCk7Cj4+Cj4gWWVzLCBtYWtlIHNl
bnNlLgo+IAo+IE1heWJlIGFub3RoZXIgYWx0ZXJuYXRpdmUgaXMgJ2VuZF9wZm4gLSBpb3ZhX3Bm
biArIDEnLCBpdCdzIHJlYWRhYmxlIGJlY2F1c2Ugd2UKPiBmcmVlIHBhZ2V0YWJsZSB3aXRoIChp
b3ZhX3BmbiwgZW5kX3BmbikgYWJvdmUuIFdoaWNoIG9uZSBkbyB5b3UgcHJlZmVyPwoKWW91cnMg
bG9va3MgYmV0dGVyLgoKQnkgdGhlIHdheSwgaWYgeW91IGFyZSB3aWxsaW5nIHRvIHByZXBhcmUg
YSB2MiwgcGxlYXNlIG1ha2Ugc3VyZSB0byBhZGQKSm9lcmcgKElPTU1VIHN1YnN5c3RlbSBtYWlu
dGFpbmVyKSB0byB0aGUgbGlzdC4KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
