Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4DACA9ECF
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 12:18:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C986421E6F
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 12:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C986421E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B2B59EC0;
	Mon,  4 Nov 2019 12:18:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DBF44E78
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 12:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 57DCA710
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 12:18:04 +0000 (UTC)
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
	by Forcepoint Email with ESMTP id 10DD0AD4A230D753F85C;
	Mon,  4 Nov 2019 12:18:03 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
	lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP
	Server (TLS) id 14.3.408.0; Mon, 4 Nov 2019 12:18:02 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
	(10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5;
	Mon, 4 Nov 2019 12:18:02 +0000
Subject: Re: arm64 iommu groups issue
From: John Garry <john.garry@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>, "Will
	Deacon" <will@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Guohanjun (Hanjun Guo)"
	<guohanjun@huawei.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
	<4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
	<a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
Message-ID: <abea92b0-7e6c-a3c8-fef3-bc8aabe93436@huawei.com>
Date: Mon, 4 Nov 2019 12:18:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
	lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Saravana Kannan <saravanak@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Linuxarm <linuxarm@huawei.com>, iommu <iommu@lists.linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

KwoKT24gMTkvMDkvMjAxOSAxNTozNSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxOS8wOS8yMDE5
IDE0OjI1LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBXaGVuIHRoZSBwb3J0IGV2ZW50dWFsbHkg
cHJvYmVzIGl0IGdldHMgYSBuZXcsIHNlcGFyYXRlIGdyb3VwLgo+Pj4KPj4+IFRoaXMgYWxsIHNl
ZW1zIHRvIGJlIGFzIHRoZSBidWlsdC1pbiBtb2R1bGUgaW5pdCBvcmRlcmluZyBpcyBhcwo+Pj4g
Zm9sbG93czogcGNpZXBvcnQgZHJ2LCBzbW11IGRydiwgbWx4NSBkcnYKPj4+Cj4+PiBJIG5vdGlj
ZSB0aGF0IGlmIEkgYnVpbGQgdGhlIG1seDUgZHJ2IGFzIGEga28gYW5kIGluc2VydCBhZnRlciBi
b290LAo+Pj4gYWxsIGZ1bmN0aW9ucyArIHBjaWVwb3J0IGFyZSBpbiB0aGUgc2FtZSBncm91cDoK
Pj4+Cj4+PiBbwqDCoCAxMS41MzAwNDZdIGhpc2lfc2FzX3YyX2h3IEhJU0kwMTYyOjAxOiBBZGRp
bmcgdG8gaW9tbXUgZ3JvdXAgMAo+Pj4gW8KgwqAgMTcuMzAxMDkzXSBobnNfZHNhZiBISVNJMDBC
MjowMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDEKPj4+IFvCoMKgIDE4Ljc0MzYwMF0gZWhjaS1w
bGF0Zm9ybSBQTlAwRDIwOjAwOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMgo+Pj4gW8KgwqAgMjAu
MjEyMjg0XSBwY2llcG9ydCAwMDAyOmY4OjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAzCj4+
PiBbwqDCoCAyMC4zNTYzMDNdIHBjaWVwb3J0IDAwMDQ6ODg6MDAuMDogQWRkaW5nIHRvIGlvbW11
IGdyb3VwIDQKPj4+IFvCoMKgIDIwLjQ5MzMzN10gcGNpZXBvcnQgMDAwNTo3ODowMC4wOiBBZGRp
bmcgdG8gaW9tbXUgZ3JvdXAgNQo+Pj4gW8KgwqAgMjAuNzAyOTk5XSBwY2llcG9ydCAwMDBhOjEw
OjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCA2Cj4+PiBbwqDCoCAyMC44NTkxODNdIHBjaWVw
b3J0IDAwMGM6MjA6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDcKPj4+IFvCoMKgIDIwLjk5
NjE0MF0gcGNpZXBvcnQgMDAwZDozMDowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgOAo+Pj4g
W8KgwqAgMjEuMTUyNjM3XSBzZXJpYWwgMDAwMjpmOTowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3Jv
dXAgMwo+Pj4gW8KgwqAgMjEuMzQ2OTkxXSBzZXJpYWwgMDAwMjpmOTowMC4xOiBBZGRpbmcgdG8g
aW9tbXUgZ3JvdXAgMwo+Pj4gW8KgIDEwMC43NTQzMDZdIG1seDVfY29yZSAwMDBhOjExOjAwLjA6
IEFkZGluZyB0byBpb21tdSBncm91cCA2Cj4+PiBbwqAgMTAxLjQyMDE1Nl0gbWx4NV9jb3JlIDAw
MGE6MTE6MDAuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDYKPj4+IFvCoCAyOTIuNDgxNzE0XSBt
bHg1X2NvcmUgMDAwYToxMTowMC4yOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNgo+Pj4gW8KgIDI5
My4yODEwNjFdIG1seDVfY29yZSAwMDBhOjExOjAwLjM6IEFkZGluZyB0byBpb21tdSBncm91cCA2
Cj4+Pgo+Pj4gVGhpcyBkb2VzIHNlZW0gbGlrZSBhIHByb2JsZW0gZm9yIGFybTY0IHBsYXRmb3Jt
cyB3aGljaCBkb24ndCBzdXBwb3J0Cj4+PiBBQ1MsIHlldCBlbmFibGUgYW4gU01NVS4gTWF5YmUg
YWxzbyBhIHByb2JsZW0gZXZlbiBpZiB0aGV5IGRvIHN1cHBvcnQKPj4+IEFDUy4KPj4+Cj4+PiBP
cGluaW9uPwo+Pgo+IAo+IEhpIFJvYmluLAo+IAo+PiBZZWFoLCB0aGlzIGlzIGxlc3MgdGhhbiBp
ZGVhbC4KPiAKPiBGb3Igc3VyZS4gT3VyIHByb2R1Y3Rpb24gRDA1IGJvYXJkcyBkb24ndCBzaGlw
IHdpdGggdGhlIFNNTVUgZW5hYmxlZCBpbiAKPiBCSU9TLCBidXQgaXQgd291bGQgYmUgc2xpZ2h0
bHkgY29uY2VybmluZyBpbiB0aGlzIHJlZ2FyZCBpZiB0aGV5IGRpZC4KPiAKPiAgPiBPbmUgd2F5
IHRvIGJvZGdlIGl0IG1pZ2h0IGJlIHRvIG1ha2UKPj4gcGNpX2RldmljZV9ncm91cCgpIGFsc28g
d2FsayBkb3dud2FyZHMgdG8gc2VlIGlmIGFueSBub24tQUNTLWlzb2xhdGVkCj4+IGNoaWxkcmVu
IGFscmVhZHkgaGF2ZSBhIGdyb3VwLCByYXRoZXIgdGhhbiBhc3N1bWluZyB0aGF0IGdyb3VwcyBn
ZXQKPj4gYWxsb2NhdGVkIGluIGhpZXJhcmNoaWNhbCBvcmRlciwgYnV0IHRoYXQncyBmYXIgZnJv
bSBpZGVhbC4KPiAKPiBBZ3JlZS4KPiAKPiBNeSBvd24gd29ya2Fyb3VuZCB3YXMgdG8gaGFjayB0
aGUgbWVudGlvbmVkIGlvcnQgY29kZSB0byBkZWZlciB0aGUgUEYgCj4gcHJvYmUgaWYgdGhlIHBh
cmVudCBwb3J0IGhhZCBhbHNvIHlldCB0byBwcm9iZS4KPiAKPj4KPj4gVGhlIHVuZGVybHlpbmcg
aXNzdWUgaXMgdGhhdCwgZm9yIGhpc3RvcmljYWwgcmVhc29ucywgT0YvSU9SVC1iYXNlZAo+PiBJ
T01NVSBkcml2ZXJzIGhhdmUgZW5kZWQgdXAgd2l0aCBncm91cCBhbGxvY2F0aW9uIGJlaW5nIHRp
ZWQgdG8gZW5kcG9pbnQKPj4gZHJpdmVyIHByb2JpbmcgdmlhIHRoZSBkbWFfY29uZmlndXJlKCkg
bWVjaGFuaXNtIChsb25nIHN0b3J5IHNob3J0LAo+PiBkcml2ZXIgcHJvYmUgaXMgdGhlIG9ubHkg
dGhpbmcgd2hpY2ggY2FuIGJlIGRlbGF5ZWQgaW4gb3JkZXIgdG8gd2FpdCBmb3IKPj4gYSBzcGVj
aWZpYyBJT01NVSBpbnN0YW5jZSB0byBiZSByZWFkeSkuSG93ZXZlciwgaW4gdGhlIG1lYW50aW1l
LCB0aGUKPj4gSU9NTVUgQVBJIGludGVybmFscyBoYXZlIGV2b2x2ZWQgc3VmZmljaWVudGx5IHRo
YXQgSSB0aGluayB0aGVyZSdzIGEgd2F5Cj4+IHRvIHJlYWxseSBwdXQgdGhpbmdzIHJpZ2h0IC0g
SSBoYXZlIHRoZSBzcGFyayBvZiBhbiBpZGVhIHdoaWNoIEknbGwgdHJ5Cj4+IHRvIHNrZXRjaCBv
dXQgQVNBUC4uLgo+Pgo+IAo+IE9LLCBncmVhdC4KPiAKPiBUaGFua3MsCj4gSm9obgo+IAo+PiBS
b2Jpbi4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
