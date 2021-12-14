Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D17C433FE
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6FB660BD9;
	Tue, 14 Dec 2021 15:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZmSR5tkw551w; Tue, 14 Dec 2021 15:39:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 608F760BE4;
	Tue, 14 Dec 2021 15:39:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47817C002F;
	Tue, 14 Dec 2021 15:39:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD54C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D716260BDD
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bRaTCdEKqAA1 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:39:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id F403960BE5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:38:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40EBBD6E;
 Tue, 14 Dec 2021 07:38:59 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 549423F774;
 Tue, 14 Dec 2021 07:38:54 -0800 (PST)
Message-ID: <a1c8c438-72e6-0938-1b05-09694983164d@arm.com>
Date: Tue, 14 Dec 2021 15:38:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
Content-Language: en-GB
To: Mikko Perttunen <cyndis@kapsi.fi>, Mikko Perttunen
 <mperttunen@nvidia.com>, thierry.reding@gmail.com, jonathanh@nvidia.com,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0xMS0wOCAxMDozNiwgTWlra28gUGVydHR1bmVuIHdyb3RlOgo+IE9uIDkvMTYvMjEg
NTozMiBQTSwgTWlra28gUGVydHR1bmVuIHdyb3RlOgo+PiBIaSBhbGwsCj4+Cj4+ICoqKgo+PiBO
ZXcgaW4gdjI6Cj4+Cj4+IEFkZGVkIHN1cHBvcnQgZm9yIFRlZ3JhMTk0Cj4+IFVzZSBzdGFuZGFy
ZCBpb21tdS1tYXAgcHJvcGVydHkgaW5zdGVhZCBvZiBjdXN0b20gbWVjaGFuaXNtCj4+ICoqKgo+
Pgo+PiB0aGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIEhvc3QxeCAnY29udGV4dCBpc29sYXRp
b24nLiBTaW5jZQo+PiB3aGVuIHByb2dyYW1taW5nIGVuZ2luZXMgdGhyb3VnaCBIb3N0MXgsIHVz
ZXJzcGFjZSBjYW4gcHJvZ3JhbSBpbgo+PiBhbnkgYWRkcmVzc2VzIGl0IHdhbnRzLCB3ZSBuZWVk
IHNvbWUgd2F5IHRvIGlzb2xhdGUgdGhlIGVuZ2luZXMnCj4+IG1lbW9yeSBzcGFjZXMuIFRyYWRp
dGlvbmFsbHkgdGhpcyBoYXMgZWl0aGVyIGJlZW4gZG9uZSBpbXBlcmZlY3RseQo+PiB3aXRoIGEg
c2luZ2xlIHNoYXJlZCBJT01NVSBkb21haW4sIG9yIGJ5IGNvcHlpbmcgYW5kIHZlcmlmeWluZyB0
aGUKPj4gcHJvZ3JhbW1pbmcgY29tbWFuZCBzdHJlYW0gYXQgc3VibWl0IHRpbWUgKEhvc3QxeCBm
aXJld2FsbCkuCj4+Cj4+IFNpbmNlIFRlZ3JhMTg2IHRoZXJlIGlzIGEgcHJpdmlsZWdlZCAob25s
eSB1c2FibGUgYnkga2VybmVsKQo+PiBIb3N0MXggb3Bjb2RlIHRoYXQgYWxsb3dzIHNldHRpbmcg
dGhlIHN0cmVhbSBJRCBzZW50IGJ5IHRoZSBlbmdpbmUKPj4gdG8gdGhlIFNNTVUuIFNvLCBieSBh
bGxvY2F0aW5nIGEgbnVtYmVyIG9mIGNvbnRleHQgYmFua3MgYW5kIHN0cmVhbQo+PiBJRHMgZm9y
IHRoaXMgcHVycG9zZSwgYW5kIHVzaW5nIHRoaXMgb3Bjb2RlIGF0IHRoZSBiZWdpbm5pbmcgb2YK
Pj4gZWFjaCBqb2IsIHdlIGNhbiBpbXBsZW1lbnQgaXNvbGF0aW9uLiBEdWUgdG8gdGhlIGxpbWl0
ZWQgbnVtYmVyIG9mCj4+IGNvbnRleHQgYmFua3Mgb25seSBlYWNoIHByb2Nlc3MgZ2V0cyBpdHMg
b3duIGNvbnRleHQsIGFuZCBub3QKPj4gZWFjaCBjaGFubmVsLgo+Pgo+PiBUaGlzIGZlYXR1cmUg
YWxzbyBhbGxvd3Mgc2hhcmluZyBlbmdpbmVzIGFtb25nIG11bHRpcGxlIFZNcyB3aGVuCj4+IHVz
ZWQgd2l0aCBIb3N0MXgncyBoYXJkd2FyZSB2aXJ0dWFsaXphdGlvbiBzdXBwb3J0IC0gdXAgdG8g
OCBWTXMKPj4gY2FuIGJlIGNvbmZpZ3VyZWQgd2l0aCBhIHN1YnNldCBvZiBhbGxvd2VkIHN0cmVh
bSBJRHMsIGVuZm9yY2VkCj4+IGF0IGhhcmR3YXJlIGxldmVsLgo+Pgo+PiBUbyBpbXBsZW1lbnQg
dGhpcywgdGhpcyBzZXJpZXMgYWRkcyBhIG5ldyBob3N0MXggY29udGV4dCBidXMsIHdoaWNoCj4+
IHdpbGwgY29udGFpbiB0aGUgJ3N0cnVjdCBkZXZpY2UncyBjb3JyZXNwb25kaW5nIHRvIGVhY2gg
Y29udGV4dAo+PiBiYW5rIC8gc3RyZWFtIElELCBjaGFuZ2VzIHRvIGRldmljZSB0cmVlIGFuZCBT
TU1VIGNvZGUgdG8gYWxsb3cKPj4gcmVnaXN0ZXJpbmcgdGhlIGRldmljZXMgYW5kIHVzaW5nIHRo
ZSBidXMsIGFzIHdlbGwgYXMgdGhlIEhvc3QxeAo+PiBzdHJlYW0gSUQgcHJvZ3JhbW1pbmcgY29k
ZSBhbmQgc3VwcG9ydCBpbiBUZWdyYURSTS4KPj4KPj4gRGV2aWNlIHRyZWUgYmluZGluZ3MgYXJl
IG5vdCB1cGRhdGVkIHlldCBwZW5kaW5nIGNvbnNlbnN1cyB0aGF0IHRoZQo+PiBwcm9wb3NlZCBj
aGFuZ2VzIG1ha2Ugc2Vuc2UuCj4+Cj4+IFRoYW5rcywKPj4gTWlra28KPj4KPj4gTWlra28gUGVy
dHR1bmVuICg4KToKPj4gwqDCoCBncHU6IGhvc3QxeDogQWRkIGNvbnRleHQgYnVzCj4+IMKgwqAg
Z3B1OiBob3N0MXg6IEFkZCBjb250ZXh0IGRldmljZSBtYW5hZ2VtZW50IGNvZGUKPj4gwqDCoCBn
cHU6IGhvc3QxeDogUHJvZ3JhbSBjb250ZXh0IHN0cmVhbSBJRCBvbiBzdWJtaXNzaW9uCj4+IMKg
wqAgaW9tbXUvYXJtLXNtbXU6IEF0dGFjaCB0byBob3N0MXggY29udGV4dCBkZXZpY2UgYnVzCj4+
IMKgwqAgYXJtNjQ6IHRlZ3JhOiBBZGQgSG9zdDF4IGNvbnRleHQgc3RyZWFtIElEcyBvbiBUZWdy
YTE4NisKPj4gwqDCoCBkcm0vdGVncmE6IGZhbGNvbjogU2V0IERNQUNUWCBmaWVsZCBvbiBETUEg
dHJhbnNhY3Rpb25zCj4+IMKgwqAgZHJtL3RlZ3JhOiB2aWM6IEltcGxlbWVudCBnZXRfc3RyZWFt
aWRfb2Zmc2V0Cj4+IMKgwqAgZHJtL3RlZ3JhOiBTdXBwb3J0IGNvbnRleHQgaXNvbGF0aW9uCj4+
Cj4+IMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlhL3RlZ3JhMTg2LmR0c2nCoCB8wqAgMTIg
KysKPj4gwqAgYXJjaC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmExOTQuZHRzacKgIHzCoCAx
MiArKwo+PiDCoCBkcml2ZXJzL2dwdS9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICstCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9k
cm0uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS90ZWdyYS9mYWxjb24uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOCArCj4+
IMKgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9mYWxjb24uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgMSArCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9zdWJtaXQuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDEzICsrCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS91YXBpLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzQgKysrKy0KPj4gwqAgZHJpdmVycy9ncHUv
ZHJtL3RlZ3JhL3ZpYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzggKysrKysK
Pj4gwqAgZHJpdmVycy9ncHUvaG9zdDF4L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNSArCj4+IMKgIGRyaXZlcnMvZ3B1L2hvc3QxeC9NYWtlZmlsZcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArCj4+IMKgIGRyaXZlcnMvZ3B1L2hvc3QxeC9j
b250ZXh0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE3NCArKysrKysrKysrKysrKysr
KysrKysrCj4+IMKgIGRyaXZlcnMvZ3B1L2hvc3QxeC9jb250ZXh0LmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMjcgKysrKwo+PiDCoCBkcml2ZXJzL2dwdS9ob3N0MXgvY29udGV4dF9i
dXMuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzEgKysrKwo+PiDCoCBkcml2ZXJzL2dwdS9ob3N0
MXgvZGV2LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMiArLQo+PiDC
oCBkcml2ZXJzL2dwdS9ob3N0MXgvZGV2LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgIDIgKwo+PiDCoCBkcml2ZXJzL2dwdS9ob3N0MXgvaHcvY2hhbm5lbF9ody5jwqDC
oMKgwqDCoMKgwqAgfMKgIDUyICsrKysrKy0KPj4gwqAgZHJpdmVycy9ncHUvaG9zdDF4L2h3L2hv
c3QxeDA2X2hhcmR3YXJlLmggfMKgIDEwICsrCj4+IMKgIGRyaXZlcnMvZ3B1L2hvc3QxeC9ody9o
b3N0MXgwN19oYXJkd2FyZS5oIHzCoCAxMCArKwo+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0t
c21tdS9hcm0tc21tdS5jwqDCoMKgwqAgfMKgIDEzICsrCj4+IMKgIGluY2x1ZGUvbGludXgvaG9z
dDF4LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjEgKysrCj4+
IMKgIGluY2x1ZGUvbGludXgvaG9zdDF4X2NvbnRleHRfYnVzLmjCoMKgwqDCoMKgwqDCoCB8wqAg
MTUgKysKPj4gwqAgMjIgZmlsZXMgY2hhbmdlZCwgNDg4IGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9ob3N0MXgvY29udGV4
dC5jCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9ob3N0MXgvY29udGV4dC5o
Cj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9ob3N0MXgvY29udGV4dF9idXMu
Ywo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9ob3N0MXhfY29udGV4dF9i
dXMuaAo+Pgo+IAo+IElPTU1VL0RUIGZvbGtzLCBhbnkgdGhvdWdodHMgYWJvdXQgdGhpcyBhcHBy
b2FjaD8gVGhlIHBhdGNoZXMgdGhhdCBhcmUgCj4gb2YgaW50ZXJlc3Qgb3V0c2lkZSBvZiBIb3N0
MXgvVGVncmFEUk0gc3BlY2lmaWNzIGFyZSBwYXRjaGVzIDEsIDIsIDQsIAo+IGFuZCA1LgoKRldJ
VyBpdCBsb29rcyBmYWlybHkgaW5ub2N1b3VzIHRvIG1lLiBJIGRvbid0IHVuZGVyc3RhbmQgaG9z
dDF4IC0gCm5laXRoZXIgaGFyZHdhcmUgbm9yIGRyaXZlciBhYnN0cmFjdGlvbnMgLSB3ZWxsIGVu
b3VnaCB0byBtZWFuaW5nZnVsbHkgCnJldmlldyBpdCBhbGwgKGUuZy4gbWF5YmUgaXQncyBkZWxp
YmVyYXRlIHRoYXQgdGhlIGJ1cyAuZG1hX2NvbmZpZ3VyZSAKbWV0aG9kIGlzbid0IHVzZWQ/KSwg
YnV0IHRoZSBTTU1VIHBhdGNoIHNlZW1zIGZpbmUgZ2l2ZW4gdGhlIEtjb25maWcgCnNvbHV0aW9u
IHRvIGF2b2lkIG1vZHVsZSBsaW5rYWdlIHByb2JsZW1zLgoKQ2hlZXJzLApSb2Jpbi4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
