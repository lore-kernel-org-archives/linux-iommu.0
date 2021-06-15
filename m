Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC08C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 13:54:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7462D61474
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 13:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7462D61474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42D31405E9;
	Tue, 15 Jun 2021 13:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFfNySrMprIJ; Tue, 15 Jun 2021 13:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 22B7240456;
	Tue, 15 Jun 2021 13:53:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0FA9C000E;
	Tue, 15 Jun 2021 13:53:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA407C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 13:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BF74607BE
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 13:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2HSSOOzEZIZp for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 13:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9AA496002E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 13:53:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DECF312FC;
 Tue, 15 Jun 2021 06:53:51 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01003F719;
 Tue, 15 Jun 2021 06:53:50 -0700 (PDT)
Subject: Re: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Krishna Reddy <vdumpa@nvidia.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
 <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
 <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
 <12067ffb8243b220cf03e83aaac3e823@codeaurora.org>
 <266f190e-99ae-9175-cf13-7a77730af389@arm.com>
 <dfdabcdec99a4c6e3bf2b3c5eebe067f@codeaurora.org>
 <61c69d23-324a-85d7-2458-dfff8df9280b@arm.com>
 <BY5PR12MB37646698F37C00381EFF7C77B3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <07001b4ed6c0a491eacce6e4dc13ab5e@codeaurora.org>
 <BY5PR12MB376480219C42E5FCE0FE0FFBB3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <f749ba0957b516ab5f0ea57033d308c7@codeaurora.org>
 <BY5PR12MB376433B3FD0A59EF57C4522DB3319@BY5PR12MB3764.namprd12.prod.outlook.com>
 <5eb5146ab51a8fe0b558680d479a26cd@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <da62ff1c-9b49-34d3-69a1-1a674e4a30f7@arm.com>
Date: Tue, 15 Jun 2021 14:53:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5eb5146ab51a8fe0b558680d479a26cd@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thierry Reding <treding@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wNi0xNSAxMjo1MSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+IEhpIEtyaXNo
bmEsCj4gCj4gT24gMjAyMS0wNi0xNCAyMzoxOCwgS3Jpc2huYSBSZWRkeSB3cm90ZToKPj4+IFJp
Z2h0IGJ1dCB3ZSB3b24ndCBrbm93IHVudGlsIHdlIHByb2ZpbGUgdGhlIHNwZWNpZmljIHVzZWNh
c2VzIG9yIHRyeSAKPj4+IHRoZW0gaW4KPj4+IGdlbmVyaWMgd29ya2xvYWQgdG8gc2VlIGlmIHRo
ZXkgYWZmZWN0IHRoZSBwZXJmb3JtYW5jZS4gU3VyZSwgb3ZlciAKPj4+IGludmFsaWRhdGlvbiBp
cwo+Pj4gYSBjb25jZXJuIHdoZXJlIG11bHRpcGxlIGJ1ZmZlcnMgY2FuIGJlIG1hcHBlZCB0byBz
YW1lIGNvbnRleHQgYW5kIAo+Pj4gdGhlIGNhY2hlCj4+PiBpcyBub3QgdXNhYmxlIGF0IHRoZSB0
aW1lIGZvciBsb29rdXAgYW5kIHN1Y2ggYnV0IHdlIGRvbid0IGRvIGl0IGZvciAKPj4+IHNtYWxs
IGJ1ZmZlcnMKPj4+IGFuZCBvbmx5IGZvciBsYXJnZSBidWZmZXJzIHdoaWNoIG1lYW5zIHRob3Vz
YW5kcyBvZiBUTEIgZW50cnkgCj4+PiBtYXBwaW5ncyBpbgo+Pj4gd2hpY2ggY2FzZSBUTEJJQVNJ
RCBpcyBwcmVmZXJyZWQgKG5vdGU6IEkgbWVudGlvbmVkIHRoZSBIVyB0ZWFtCj4+PiByZWNvbW1l
bmRhdGlvbiB0byB1c2UgaXQgZm9yIGFueXRoaW5nIGdyZWF0ZXIgdGhhbiAxMjggVExCIGVudHJp
ZXMpIAo+Pj4gaW4gbXkKPj4+IGVhcmxpZXIgcmVwbHkuIEFuZCBhbHNvIG5vdGUgdGhhdCB3ZSBk
byB0aGlzIG9ubHkgZm9yIHBhcnRpYWwgd2FsayAKPj4+IGZsdXNoLCB3ZSBhcmUgbm90Cj4+PiBh
cmJpdHJhcmlseSBjaGFuZ2luZyBhbGwgdGhlIFRMQklzIHRvIEFTSUQgYmFzZWQuCj4+Cj4+IE1v
c3Qgb2YgdGhlIGhlYXZ5IGJ3IHVzZSBjYXNlcyBkb2VzIGludm9sdmUgcHJvY2Vzc2luZyBsYXJn
ZXIgYnVmZmVycy4KPj4gV2hlbiB0aGUgcGh5c2ljYWwgbWVtb3J5IGlzIGFsbG9jYXRlZCBkaXMt
Y29udGlndW91c2x5IGF0IHBhZ2Vfc2l6ZQo+PiAobGV0J3MgdXNlIDRLQiBoZXJlKQo+PiBncmFu
dWxhcml0eSwgZWFjaCBhbGlnbmVkIDJNQiBjaHVua3MgSU9WQSB1bm1hcCB3b3VsZCBpbnZvbHZl
Cj4+IHBlcmZvcm1pbmcgYSBUTEJJQVNJRAo+PiBhcyAyTUIgaXMgbm90IGEgbGVhZi4gRXNzZW50
aWFsbHksIEl0IGhhcHBlbnMgYWxsIHRoZSB0aW1lIGR1cmluZwo+PiBsYXJnZSBidWZmZXIgdW5t
YXBzIGFuZAo+PiBwb3RlbnRpYWxseSBpbXBhY3QgYWN0aXZlIHRyYWZmaWMgb24gb3RoZXIgbGFy
Z2UgYnVmZmVycy4gRGVwZW5kaW5nIG9uIAo+PiBob3cgbXVjaAo+PiBsYXRlbmN5IEhXIGVuZ2lu
ZXMgY2FuIGFic29yYiwgdGhlIG92ZXJmbG93L3VuZGVyZmxvdyBpc3N1ZXMgZm9yIElTTwo+PiBl
bmdpbmVzIGNhbiBiZQo+PiBzcG9yYWRpYyBhbmQgdmVuZG9yIHNwZWNpZmljLgo+PiBQZXJmb3Jt
aW5nIFRMQklBU0lEIGFzIGRlZmF1bHQgZm9yIGFsbCBTb0NzIGlzIG5vdCBhIHNhZmUgb3BlcmF0
aW9uLgo+Pgo+IAo+IE9rIHNvIGZyb20gd2hhdCBJIGdhdGhlciBmcm9tIHRoaXMgaXMgdGhhdCBp
dHMgbm90IGVhc3kgdG8gdGVzdCBmb3IgdGhlCj4gbmVnYXRpdmUgaW1wYWN0IGFuZCB5b3UgZG9u
J3QgaGF2ZSBkYXRhIG9uIHN1Y2ggeWV0IGFuZCB0aGUgYmVoYXZpb3VyIGlzCj4gdmVyeSB2ZW5k
b3Igc3BlY2lmaWMuIFRvIGFkZCBvbiBxY29tIGltcGwsIHdlIGhhdmUgc2V2ZXJhbCBwZXJmb3Jt
YW5jZQo+IGltcHJvdmVtZW50cyBmb3IgVExCIGNhY2hlIGludmFsaWRhdGlvbnMgaW4gSFcgbGlr
ZSB3YWl0LWZvci1zYWZlKGZvciAKPiByZWFsdGltZQo+IGNsaWVudHMgc3VjaCBhcyBjYW1lcmEg
YW5kIGRpc3BsYXkpIGFuZCBmZXcgb3RoZXJzIHRvIGFsbG93IGZvciBjYWNoZQo+IGxvb2t1cHMv
dXBkYXRlcyB3aGVuIFRMQkkgaXMgaW4gcHJvZ3Jlc3MgZm9yIHRoZSBzYW1lIGNvbnRleHQgYmFu
aywgc28gCj4gYXRsZWFzdAo+IHdlIGFyZSBnb29kIGhlcmUuCj4gCj4+Cj4+PiBJIGFtIG5vIGNh
bWVyYSBleHBlcnQgYnV0IGZyb20gd2hhdCB0aGUgY2FtZXJhIHRlYW0gbWVudGlvbmVkIGlzIHRo
YXQgCj4+PiB0aGVyZQo+Pj4gaXMgYSB0aHJlYWQgd2hpY2ggZnJlZXMgbWVtb3J5KGxhcmdlIHVu
dXNlZCBtZW1vcnkgYnVmZmVycykgCj4+PiBwZXJpb2RpY2FsbHkgd2hpY2gKPj4+IGVuZHMgdXAg
dGFraW5nIGFyb3VuZCAxMDArbXMgYW5kIGNhdXNpbmcgc29tZSBjYW1lcmEgdGVzdCBmYWlsdXJl
cyB3aXRoCj4+PiBmcmFtZSBkcm9wcy4gUGFyYWxsZWwgZWZmb3J0cyBhcmUgYWxyZWFkeSBiZWlu
ZyBtYWRlIHRvIG9wdGltaXplIHRoaXMgCj4+PiB1c2FnZSBvZgo+Pj4gdGhyZWFkIGJ1dCBhcyBJ
IG1lbnRpb25lZCBwcmV2aW91c2x5LCB0aGlzIGlzICpub3QgYSBjYW1lcmEgCj4+PiBzcGVjaWZp
YyosIGxldHMgc2F5Cj4+PiBzb21lb25lIGVsc2UgaW52b2tlcyBzdWNoIGxhcmdlIHVubWFwcywg
aXQncyBnb2luZyB0byBmYWNlIHRoZSBzYW1lIAo+Pj4gaXNzdWUuCj4+Cj4+IEZyb20gdGhlIGFi
b3ZlLCBJdCBkb2Vzbid0IGxvb2sgbGlrZSB0aGUgcm9vdCBjYXVzZSBvZiBmcmFtZSBkcm9wcyBp
cwo+PiBmdWxseSB1bmRlcnN0b29kLgo+PiBXaHkgaXMgMTAwK21zIGRlbGF5IGNhdXNpbmcgY2Ft
ZXJhIGZyYW1lIGRyb3A/wqAgSXMgdGhlIHNhbWUgdGhyZWFkCj4+IHN1Ym1pdHRpbmcgdGhlIGJ1
ZmZlcnMKPj4gdG8gY2FtZXJhIGFmdGVyIHVubWFwIGlzIGNvbXBsZXRlPyBJZiBub3QsIGhvdyBp
cyB0aGUgdW5tYXAgbGF0ZW5jeQo+PiBjYXVzaW5nIGlzc3VlIGhlcmU/Cj4+Cj4gCj4gT2sgc2lu
Y2UgeW91IGFyZSBpbnRlcmVzdGVkIGluIGNhbWVyYSB1c2VjYXNlLCBJIGhhdmUgcmVxdWVzdGVk
IGZvciBtb3JlIAo+IGRldGFpbHMKPiBmcm9tIHRoZSBjYW1lcmEgdGVhbSBhbmQgd2lsbCBnaXZl
IGl0IG9uY2UgdGhleSBjb21lYmFjay4gSG93ZXZlciBJIAo+IGRvbid0IHRoaW5rCj4gaXRzIGdv
b2QgdG8gaGF2ZSB1bm1hcCBsYXRlbmN5IGF0IGFsbCBhbmQgdGhhdCBpcyBiZWluZyBhZGRyZXNz
ZWQgYnkgCj4gdGhpcyBwYXRjaC4KPiAKPj4KPj4+ID4gSWYgdW5tYXAgaXMgcXVldWVkIGFuZCBw
ZXJmb3JtZWQgb24gYSBiYWNrIGdyb3VuZCB0aHJlYWQsIHdvdWxkIGl0Cj4+PiA+IHJlc29sdmUg
dGhlIGZyYW1lIGRyb3BzPwo+Pj4KPj4+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBt
ZWFuIGJ5IHF1ZXVpbmcgb24gYmFja2dyb3VuZCB0aHJlYWQgCj4+PiBidXQgd2l0aAo+Pj4gdGhh
dCBvciBub3QsIHdlIHN0aWxsIGRvIHRoZSBzYW1lIG51bWJlciBvZiBUTEJJcyBhbmQgaG9wIHRo
cm91Z2gKPj4+IGlvbW11LT5pby1wZ3RhYmxlLT5hcm0tc21tdSB0byBwZXJmb3JtIHRoZSB0aGUg
dW5tYXAsIHNvIGhvdyB3aWxsIHRoYXQKPj4+IGhlbHA/Cj4+Cj4+IEkgbWVhbiBhZGRpbmcgdGhl
IHVubWFwIHJlcXVlc3RzIGludG8gYSBxdWV1ZSBhbmQgcHJvY2Vzc2luZyB0aGVtIGZyb20KPj4g
YSBkaWZmZXJlbnQgdGhyZWFkLgo+PiBJdCBpcyBub3QgdG8gcmVkdWNlIHRoZSBUTEJJcy4gQnV0
LCBub3QgdG8gYmxvY2sgc3Vic2VxdWVudCBidWZmZXIKPj4gYWxsb2NhdGlvbiwgSU9WQSBtYXAg
cmVxdWVzdHMsIGlmIHRoZXkKPj4gYXJlIGJlaW5nIHJlcXVlc3RlZCBmcm9tIHNhbWUgdGhyZWFk
IHRoYXQgaXMgcGVyZm9ybWluZyB1bm1hcC4gSWYKPj4gdW5tYXAgaXMgYWxyZWFkeSBwZXJmb3Jt
ZWQgZnJvbQo+PiBhIGRpZmZlcmVudCB0aHJlYWQsIHRoZW4gdGhlIGlzc3VlIHN0aWxsIG5lZWQg
dG8gYmUgcm9vdCBjYXVzZWQgdG8KPj4gdW5kZXJzdGFuZCBpdCBmdWxseS4gQ2hlY2sgZm9yIGFu
eQo+PiBzZXJpYWxpemF0aW9uIGlzc3Vlcy4KPj4KPiAKPiBUaGlzIHBhdGNoIGlzIHRvIG9wdGlt
aXplIHVubWFwIGxhdGVuY3kgYmVjYXVzZSBvZiBsYXJnZSBudW1iZXIgb2YgbW1pbyAKPiB3cml0
ZXMoVExCSVZBcykKPiB3YXN0aW5nIENQVSBjeWNsZXMgYW5kIG5vdCB0byBmaXggY2FtZXJhIGlz
c3VlIHdoaWNoIGNhbiBwcm9iYWJseSBiZSAKPiBzb2x2ZWQgYnkKPiBwYXJhbGxlbGl6YXRpb24u
IEl0IHNlZW1zIHRvIG1lIGxpa2UgeW91IGFyZSBvayB3aXRoIHRoZSB1bm1hcCBsYXRlbmN5IAo+
IGluIGdlbmVyYWwKPiB3aGljaCB3ZSBhcmUgbm90IGFuZCB3YW50IHRvIGF2b2lkIHRoYXQgbGF0
ZW5jeS4KPiAKPiBIaSBAUm9iaW4sIGZyb20gdGhlc2UgZGlzY3Vzc2lvbnMgaXQgc2VlbXMgdGhl
eSBhcmUgbm90IG9rIHdpdGggdGhlIGNoYW5nZQo+IGZvciBhbGwgU29DIHZlbmRvciBpbXBsZW1l
bnRhdGlvbnMgYW5kIGRvIG5vdCBoYXZlIGFueSBkYXRhIG9uIHN1Y2ggaW1wYWN0Lgo+IEFzIEkg
bWVudGlvbmVkIGFib3ZlLCBvbiBRQ09NIHBsYXRmb3JtcyB3ZSBkbyBoYXZlIHNldmVyYWwgb3B0
aW1pemF0aW9ucyAKPiBpbiBIVwo+IGZvciBUTEJJcyBhbmQgd291bGQgbGlrZSB0byBtYWtlIHVz
ZSBvZiBpdCBhbmQgcmVkdWNlIHRoZSB1bm1hcCBsYXRlbmN5Lgo+IFdoYXQgZG8geW91IHRoaW5r
LCBzaG91bGQgdGhpcyBiZSBtYWRlIGltcGxlbWVudGF0aW9uIHNwZWNpZmljPwoKWWVzLCBpdCBz
b3VuZHMgbGlrZSB0aGVyZSdzIGVub3VnaCB1bmNlcnRhaW50eSBmb3Igbm93IHRoYXQgdGhpcyBu
ZWVkcyAKdG8gYmUgYW4gb3B0LWluIGZlYXR1cmUuIEhvd2V2ZXIsIEkgc3RpbGwgdGhpbmsgdGhh
dCBub24tc3RyaWN0IG1vZGUgCmNvdWxkIHVzZSBpdCBnZW5lcmljYWxseSwgc2luY2UgdGhhdCdz
IGFsbCBhYm91dCBvdmVyLWludmFsaWRhdGluZyB0byAKc2F2ZSB0aW1lIG9uIGluZGl2aWR1YWwg
dW5tYXBzIC0gYW5kIHJlbGF0aXZlbHkgbm9uLWRldGVybWluaXN0aWMgLSBhbHJlYWR5LgoKU28g
bWF5YmUgd2UgaGF2ZSBhIHNlY29uZCBzZXQgb2YgaW9tbXVfZmx1c2hfb3BzLCBvciBqdXN0IGEg
ZmxhZyAKc29tZXdoZXJlIHRvIGNvbnRyb2wgdGhlIHRsYl9mbHVzaF93YWxrIGZ1bmN0aW9ucyBp
bnRlcm5hbGx5LCBhbmQgdGhlIApjaG9pY2UgY2FuIGJlIG1hZGUgaW4gdGhlIGlvbW11X2dldF9k
bWFfc3RyaWN0KCkgdGVzdCwgYnV0IGFsc28gZm9yY2VkIApvbiBhbGwgdGhlIHRpbWUgYnkgeW91
ciBpbml0X2NvbnRleHQgaG9vay4gV2hhdCBkbyB5b3UgcmVja29uPwoKUm9iaW4uCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
