Return-Path: <SRS0=68Au=FS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D957EC4361B
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 13:43:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDD7229C6
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 13:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDD7229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1823D869AA;
	Mon, 14 Dec 2020 13:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zs8M1Z9S--2d; Mon, 14 Dec 2020 13:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E29A38679C;
	Mon, 14 Dec 2020 13:43:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A81A3C088E;
	Mon, 14 Dec 2020 13:43:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE117C013B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 13:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E1A4A867AC
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 13:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffDrkvMTWlhj for <iommu@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 13:42:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id BEB748679C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 13:42:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF4831FB;
 Mon, 14 Dec 2020 05:42:55 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 386903F66B;
 Mon, 14 Dec 2020 05:42:54 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
To: Robin Murphy <robin.murphy@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "devel@acpica.org" <devel@acpica.org>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com>
 <67cb563d19114f609348dc9f8b4307e9@huawei.com>
 <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <6dcf51b2-cad5-d377-a34c-4e64fd3acbb8@arm.com>
Date: Mon, 14 Dec 2020 13:42:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com>
Content-Language: en-GB
Cc: "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
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

T24gMTQvMTIvMjAyMCAxMjozMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMTItMTQg
MTA6NTUsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgd3JvdGU6Cj4+IEhpIFN0ZXZlLAo+Pgo+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+IEZyb206IFN0ZXZlbiBQcmljZSBbbWFp
bHRvOnN0ZXZlbi5wcmljZUBhcm0uY29tXQo+Pj4gU2VudDogMTAgRGVjZW1iZXIgMjAyMCAxMDoy
Ngo+Pj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT47Cj4+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOwo+Pj4gaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmc7IGRldmVsQGFjcGljYS5vcmcKPj4+IENjOiBMaW51eGFybSA8bGludXhhcm1A
aHVhd2VpLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207Cj4+PiBqb3JvQDhieXRlcy5v
cmc7IHJvYmluLm11cnBoeUBhcm0uY29tOyB3YW5naHVpcWlhbmcKPj4+IDx3YW5naHVpcWlhbmdA
aHVhd2VpLmNvbT47IEd1b2hhbmp1biAoSGFuanVuIEd1bykKPj4+IDxndW9oYW5qdW5AaHVhd2Vp
LmNvbT47IEpvbmF0aGFuIENhbWVyb24KPj4+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
OyBTYW1pLk11amF3YXJAYXJtLmNvbQo+Pj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMC84
XSBBQ1BJL0lPUlQ6IFN1cHBvcnQgZm9yIElPUlQgUk1SIG5vZGUKPj4+Cj4+PiBPbiAxOS8xMS8y
MDIwIDEyOjExLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOgo+Pj4+IFJGQyB2MSAtLT4gdjI6Cj4+
Pj4gwqAgwqAtIEFkZGVkIGEgZ2VuZXJpYyBpbnRlcmZhY2UgZm9yIElPTU1VIGRyaXZlcnMgdG8g
cmV0cmlldmUgYWxsIHRoZQo+Pj4+IMKgIMKgIMKgUk1SIGluZm8gYXNzb2NpYXRlZCB3aXRoIGEg
Z2l2ZW4gSU9NTVUuCj4+Pj4gwqAgwqAtIFNNTVV2MyBkcml2ZXIgZ2V0cyB0aGUgUk1SIGxpc3Qg
ZHVyaW5nIHByb2JlKCkgYW5kIGluc3RhbGxzCj4+Pj4gwqAgwqDCoCBieXBhc3MgU1RFcyBmb3Ig
YWxsIHRoZSBTSURzIGluIHRoZSBSTVIgbGlzdC4gVGhpcyBpcyB0byBrZWVwCj4+Pj4gwqDCoCDC
oCB0aGUgb25nb2luZyB0cmFmZmljIGFsaXZlKGlmIGFueSkgZHVyaW5nIFNNTVV2MyByZXNldC4g
VGhpcyBpcwo+Pj4+IMKgwqDCoMKgIGJhc2VkIG9uIHRoZSBzdWdnZXN0aW9ucyByZWNlaXZlZCBm
b3IgdjEgdG8gdGFrZSBjYXJlIG9mIHRoZQo+Pj4+IMKgwqDCoMKgIEVGSSBmcmFtZWJ1ZmZlciB1
c2UgY2FzZS4gT25seSBzYW5pdHkgdGVzdGVkIGZvciBub3cuCj4+Pgo+Pj4gSGkgU2hhbWVlciwK
Pj4+Cj4+PiBTb3JyeSBmb3Igbm90IGxvb2tpbmcgYXQgdGhpcyBiZWZvcmUuCj4+Pgo+Pj4gRG8g
eW91IGhhdmUgYW55IHBsYW5zIHRvIGltcGxlbWVudCBzdXBwb3J0IGluIHRoZSBTTU1VdjIgZHJp
dmVyPyBUaGUKPj4+IHBsYXRmb3JtIEkndmUgYmVlbiB0ZXN0aW5nIHRoZSBFRkkgZnJhbWVidWZm
ZXIgc3VwcG9ydCBvbiBoYXMgdGhlCj4+PiBkaXNwbGF5IGNvbnRyb2xsZXIgYmVoaW5kIFNNTVV2
Miwgc28gYXMgaXQgc3RhbmRzIHRoaXMgc2VyaWVzIGRvZXNuJ3QKPj4+IHdvcmsuIEkgZGlkIGhh
Y2sgc29tZXRoaW5nIHVwIGZvciBTTU1VdjIgc28gSSB3YXMgYWJsZSB0byB0ZXN0IHRoZSBmaXJz
dAo+Pj4gNCBwYXRjaGVzLgo+Pgo+PiBUaGFua3MgZm9yIHRha2luZyBhIGxvb2suIFN1cmUsIEkg
Y2FuIGxvb2sgaW50byBhZGRpbmcgdGhlIHN1cHBvcnQgZm9yIAo+PiBTTU1VdjIuCgpHcmVhdCwg
dGhhbmtzIQoKPj4+Cj4+Pj4gwqAgwqAtIER1cmluZyB0aGUgcHJvYmUvYXR0YWNoIGRldmljZSwg
U01NVXYzIGRyaXZlciByZXNlcnZlcyBhbnkKPj4+PiDCoCDCoCDCoFJNUiByZWdpb24gYXNzb2Np
YXRlZCB3aXRoIHRoZSBkZXZpY2Ugc3VjaCB0aGF0IHRoZXJlIGlzIGEgdW5pdHkKPj4+PiDCoCDC
oCDCoG1hcHBpbmcgZm9yIHRoZW0gaW4gU01NVS4KPj4+Cj4+PiBGb3IgdGhlIEVGSSBmcmFtZWJ1
ZmZlciB1c2UgY2FzZSB0aGVyZSBpcyBubyBkZXZpY2UgdG8gYXR0YWNoIHNvIEkKPj4+IGJlbGll
dmUgd2UgYXJlIGxlZnQgd2l0aCBqdXN0IHRoZSBzdHJlYW0gSUQgaW4gYnlwYXNzIG1vZGUgLSB3
aGljaCBpcwo+Pj4gZGVmaW5pdGVseSBhbiBpbXByb3ZlbWVudCAodGhlIGRpc3BsYXkgd29ya3Mh
KQo+Pgo+PiBDb29sLiBUaGF04oCZcyBnb29kIHRvIGtub3cuCj4+Cj4+IMKgIGJ1dCBub3QgYWN0
dWFsbHkgYSB1bml0eQo+Pj4gbWFwcGluZyBvZiB0aGUgUk1SIHJhbmdlLiBJJ20gbm90IHN1cmUg
d2hldGhlciBpdCdzIHdvcnRoIGZpeGluZyB0aGlzIG9yCj4+PiBub3QsIGJ1dCBJIGp1c3Qgd2Fu
dGVkIHRvIHBvaW50IG91dCB0aGVyZSdzIHN0aWxsIGEgbmVlZCBmb3IgYSBkcml2ZXIKPj4+IGZv
ciB0aGUgZGV2aWNlIGJlZm9yZSB0aGUgYnlwYXNzIG1vZGUgaXMgcmVwbGFjZWQgd2l0aCB0aGUg
dW5pdHkgCj4+PiBtYXBwaW5nLgo+Pgo+PiBJIGFtIG5vdCBzdXJlIGVpdGhlci4gTXkgaWRlYSB3
YXMgd2Ugd2lsbCBoYXZlIGJ5cGFzcyBTVEUgc2V0dXAgZm9yIAo+PiBhbGwgZGV2aWNlcwo+PiB3
aXRoIFJNUiBpbml0aWFsbHkgYW5kIHdoZW4gdGhlIGNvcnJlc3BvbmRpbmcgZHJpdmVyIHRha2Vz
IG92ZXIoaWYgCj4+IHRoYXQgaGFwcGVucykKPj4gd2Ugd2lsbCBoYXZlIHRoZSB1bml0eSBtYXBw
aW5nIHNldHVwIHByb3Blcmx5IGZvciB0aGUgUk1SIHJlZ2lvbnMuIEFuZCAKPj4gZm9yIGNhc2Vz
Cj4+IGxpa2UgdGhlIGFib3ZlLCBpdCB3aWxsIHJlbWFpbiBpbiB0aGUgYnlwYXNzIG1vZGUuCj4+
Cj4+IERvIHlvdSBzZWUgYW55IHByb2JsZW0oc2VjdXJpdHk/KSBpZiB0aGUgZGV2IHN0cmVhbXMg
cmVtYWluIGluIGJ5cGFzcyAKPj4gbW9kZSBmb3IKPj4gdGhpcyBkZXY/IE9yIGlzIGl0IHBvc3Np
YmxlIHRvIGhhdmUgYSBzdHViIGRyaXZlciBmb3IgdGhpcyBkZXYsIHNvIAo+PiB0aGF0IHdlIHdp
bGwgaGF2ZQo+PiB0aGUgcHJvYmUvYXR0YWNoIGludm9rZWQgYW5kIGV2ZXJ5dGhpbmcgd2lsbCBm
YWxsIGluIHBsYWNlPwo+IAo+IFRoZSBkb3duc2lkZSBpcyB0aGF0IGlmIGEgZHJpdmVyIG5ldmVy
IGJpbmRzIHRvIHRoYXQgZGV2aWNlLCBpdCByZW1haW5zIAo+IGJ5cGFzc2VkLiBJZiBzb21lIG90
aGVyIGV4dGVybmFsbHktY29udHJvbGxlZCBtYWxpY2lvdXMgZGV2aWNlIGNvdWxkIAo+IG1hbmFn
ZSB0byBzcG9vZiB0aGF0IGRldmljZSdzIHJlcXVlc3RlciBJRCwgdGhhdCBjb3VsZCBwb3RlbnRp
YWxseSBiZSAKPiBleHBsb2l0ZWQuCj4gCj4+IFRCSCwgSSBoYXZlbid0IGxvb2tlZCBpbnRvIGNy
ZWF0aW5nIGEgdGVtcCBkb21haW4gZm9yIHRoZXNlIHR5cGVzIG9mIAo+PiB0aGUgZGV2aWNlcwo+
PiBhbmQgYWxzbyBub3Qgc3VyZSBob3cgd2UgYmVuZWZpdCBmcm9tIHRoYXQgY29tcGFyZWQgdG8g
dGhlIFNURSBieXBhc3MgCj4+IG1vZGUuCj4gCj4gVGhhdCBzYWlkLCBzZXR0aW5nIHVwIHRlbXBv
cmFyeSB0cmFuc2xhdGlvbiBjb250ZXh0cyB0aGF0IGVuc3VyZSBhbnkgCj4gYWNjZXNzIGNhbiAq
b25seSogYmUgdG8gUk1SIHJlZ2lvbnMgdW50aWwgYSBkcml2ZXIgdGFrZXMgb3ZlciBpcyBhbiAK
PiBhd2Z1bCBsb3QgbW9yZSB3b3JrLiBJJ20gaW5jbGluZWQgdG8gYmUgcHJhZ21hdGljIGhlcmUg
YW5kIHNheSB3ZSBzaG91bGQgCj4gZ2V0IHRoaW5ncyB3b3JraW5nIGF0IGFsbCB3aXRoIHRoZSBz
aW1wbGUgYnlwYXNzIFNURS9TMkNSIG1ldGhvZCwgdGhlbiAKPiBsb29rIGF0IGFkZGluZyB0aGUg
aGlnaGVyLXNlY3VyaXR5IGVmZm9ydCBvbiB0b3AuCj4gCj4gUmlnaHQgbm93IHN5c3RlbXMgdGhh
dCBuZWVkIHRoaXMgYXJlIGVpdGhlciBicm9rZW4gKGJ1dCBlZmZlY3RpdmVseSAKPiBzZWN1cmUp
IG9yIHVzaW5nIGRlZmF1bHQgYnlwYXNzIHdpdGggU01NVXYyLiBQZW9wbGUgd2hvIHByZWZlciB0
byAKPiBtYWludGFpbiBzZWN1cml0eSBvdmVyIGZ1bmN0aW9uYWxpdHkgaW4gdGhlIGludGVyaW0g
Y2FuIG1haW50YWluIHRoYXQgCj4gc3RhdHVzIHF1byBieSBzaW1wbHkgY29udGludWluZyB0byBu
b3QgZGVzY3JpYmUgYW55IFJNUnMuCgpJIGFncmVlIHdpdGggUm9iaW4sIGxldCdzIGdldCB0aGlz
IHdvcmtpbmcgd2l0aCB0aGUgYnlwYXNzIG1vZGUgKHVudGlsIAp0aGUgZGV2aWNlIGJpbmRzKSBs
aWtlIHlvdSd2ZSBjdXJyZW50bHkgZ290LiBJdCdzIG11Y2ggYmV0dGVyIHRoYW4gd2hhdCAKd2Ug
aGF2ZSBvdGhlcndpc2UuIFRoZW4gb25jZSB0aGF0IGlzIG1lcmdlZCB3ZSBjYW4gbG9vayBhdCB0
aGUgdGVtcG9yYXJ5IAp0cmFuc2xhdGlvbiBjb250ZXh0IG9yIHN0dWIgZHJpdmVyLiBUaGUgdGVt
cG9yYXJ5IHRyYW5zbGF0aW9uIGNvbnRleHQgCndvdWxkIGJlICduZWF0ZXN0JywgYnV0IEknbSBv
bmx5IGF3YXJlIG9mIHRoZSBFRkkgZnJhbWVidWZmZXIgdXNlIGNhc2UgCmFuZCBmb3IgdGhhdCBp
dCBtaWdodCBiZSBwb3NzaWJsZSB0byBkbyBzb21ldGhpbmcgc2ltcGxlciAtIGlmIGluZGVlZCAK
YW55dGhpbmcgaXMgbmVlZGVkIGF0IGFsbC4gSSdtIG5vdCBzdXJlIGhvdyBtdWNoIHdlIG5lZWQg
dG8gYmUgd29ycmllZCAKYWJvdXQgbWFsaWNpb3VzIGRldmljZXMgc3Bvb2ZpbmcgcmVxdWVzdGVy
IElEcy4KClRoYW5rcywKClN0ZXZlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
