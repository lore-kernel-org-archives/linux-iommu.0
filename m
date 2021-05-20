Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D4C433ED
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 14:14:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFD06109F
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 14:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFD06109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1272A404BF;
	Thu, 20 May 2021 14:14:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sdb_kd7HwJu9; Thu, 20 May 2021 14:14:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB758400CC;
	Thu, 20 May 2021 14:14:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7BE3C000E;
	Thu, 20 May 2021 14:14:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 060B6C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB3FF402CF
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u8Fnl1OZP0nc for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:14:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FBBB401F1
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:14:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65EAF11D4;
 Thu, 20 May 2021 07:14:02 -0700 (PDT)
Received: from [10.57.66.179] (unknown [10.57.66.179])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9AD23F73B;
 Thu, 20 May 2021 07:14:00 -0700 (PDT)
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
References: <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
 <20210517133500.GP1096940@ziepe.ca> <YKKNLrdQ4QjhLrKX@8bytes.org>
 <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
 <20210519180635.GT1096940@ziepe.ca>
 <MWHPR11MB1886C64EAEB752DE9E1633358C2B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210519232459.GV1096940@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1d154445-f762-1147-0b8c-6e244e7c66dc@arm.com>
Date: Thu, 20 May 2021 15:13:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519232459.GV1096940@ziepe.ca>
Content-Language: en-GB
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

T24gMjAyMS0wNS0yMCAwMDoyNCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+IE9uIFdlZCwgTWF5
IDE5LCAyMDIxIGF0IDExOjEyOjQ2UE0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOgo+Pj4gRnJv
bTogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+Cj4+PiBTZW50OiBUaHVyc2RheSwgTWF5
IDIwLCAyMDIxIDI6MDcgQU0KPj4+Cj4+PiBPbiBXZWQsIE1heSAxOSwgMjAyMSBhdCAwNDoyMzoy
MVBNICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4gT24gMjAyMS0wNS0xNyAxNjozNSwg
Sm9lcmcgUm9lZGVsIHdyb3RlOgo+Pj4+PiBPbiBNb24sIE1heSAxNywgMjAyMSBhdCAxMDozNTow
MEFNIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4+Pj4+PiBXZWxsLCBJJ20gc29ycnks
IGJ1dCB0aGVyZSBpcyBhIGh1Z2Ugb3RoZXIgdGhyZWFkIHRhbGtpbmcgYWJvdXQgdGhlCj4+Pj4+
PiBJT0FTSUQgZGVzaWduIGluIGdyZWF0IGRldGFpbCBhbmQgd2h5IHRoaXMgaXMgYWxsIG5lZWRl
ZC4gSnVtcGluZyBpbnRvCj4+Pj4+PiB0aGlzIHRocmVhZCB3aXRob3V0IGNvbnRleHQgYW5kIGJh
c2ljYWxseSByZWplY3RpbmcgYWxsIHRoZQo+Pj4+Pj4gY29uY2x1c2lvbnMgdGhhdCB3ZXJlIHJl
YWNoZWQgb3ZlciB0aGUgbGFzdCBzZXZlcmFsIHdlZWtzIGlzIHJlYWxseQo+Pj4+Pj4gbm90IGhl
bHBmdWwgLSBlc3BlY2lhbGx5IHNpbmNlIHlvdXIgb2JqZWN0aW9uIGlzIG5vdCB0ZWNobmljYWwu
Cj4+Pj4+Pgo+Pj4+Pj4gSSB0aGluayB5b3Ugc2hvdWxkIHdhaXQgZm9yIEludGVsIHRvIHB1dCB0
b2dldGhlciB0aGUgL2Rldi9pb2FzaWQgdUFQSQo+Pj4+Pj4gcHJvcG9zYWwgYW5kIHRoZSBleGFt
cGxlIHVzZSBjYXNlcyBpdCBzaG91bGQgYWRkcmVzcyB0aGVuIHlvdSBjYW4gZ2l2ZQo+Pj4+Pj4g
ZmVlZGJhY2sgdGhlcmUsIHdpdGggcHJvcGVyIGNvbnRleHQuCj4+Pj4+Cj4+Pj4+IFllcywgSSB0
aGluayB0aGUgbmV4dCBzdGVwIGlzIHRoYXQgc29tZW9uZSB3aG8gcmVhZCB0aGUgd2hvbGUgdGhy
ZWFkCj4+Pj4+IHdyaXRlcyB1cCB0aGUgY29uY2x1c2lvbnMgYW5kIGEgcm91Z2ggL2Rldi9pb2Fz
aWQgQVBJIHByb3Bvc2FsLCBhbHNvCj4+Pj4+IG1lbnRpb25pbmcgdGhlIHVzZS1jYXNlcyBpdCBh
ZGRyZXNzZXMuIEJhc2VkIG9uIHRoYXQgd2UgY2FuIGRpc2N1c3MgdGhlCj4+Pj4+IGltcGxpY2F0
aW9ucyB0aGlzIG5lZWRzIHRvIGhhdmUgZm9yIElPTU1VLUFQSSBhbmQgY29kZS4KPj4+Pj4KPj4+
Pj4gICBGcm9tIHRoZSB1c2UtY2FzZXMgSSBrbm93IHRoZSBtZGV2IGNvbmNlcHQgaXMganVzdCBm
aW5lLiBCdXQgaWYgdGhlcmUgaXMKPj4+Pj4gYSBtb3JlIGdlbmVyaWMgb25lIHdlIGNhbiB0YWxr
IGFib3V0IGl0Lgo+Pj4+Cj4+Pj4gSnVzdCB0byBhZGQgYW5vdGhlciB2b2ljZSBoZXJlLCBJIGhh
dmUgc29tZSBjb2xsZWFndWVzIHdvcmtpbmcgb24gZHJpdmVycwo+Pj4+IHdoZXJlIHRoZXkgd2Fu
dCB0byB1c2UgU01NVSBTdWJzdHJlYW0gSURzIGZvciBhIHNpbmdsZSBoYXJkd2FyZSBibG9jawo+
Pj4gdG8KPj4+PiBvcGVyYXRlIG9uIG11bHRpcGxlIGlvbW11X2RvbWFpbnMgbWFuYWdlZCBlbnRp
cmVseSB3aXRoaW4gdGhlCj4+Pj4ga2VybmVsLgo+Pj4KPj4+IElmIGl0IGlzIGVudGlyZWx5IHdp
dGhpbiB0aGUga2VybmVsIEknbSBjb25mdXNlZCBob3cgbWRldiBnZXRzCj4+PiBpbnZvbHZlZD8g
bWRldiBpcyBvbmx5IGZvciB2ZmlvIHdoaWNoIGlzIHVzZXJzcGFjZS4KCkJ5ICJtZGV2LWxpa2Ui
IEkgbWVhbiBpdCdzIHZlcnkgc2ltaWxhciBpbiBzaGFwZSB0byB0aGUgZ2VuZXJhbCAKU0lPVi1z
dHlsZSBtZWRpYXRlZCBkZXZpY2UgY29uY2VwdCAtIGkuZS4gYSBwaHlzaWNhbCBkZXZpY2Ugd2l0
aCBhbiAKYXdhcmVuZXNzIG9mIG9wZXJhdGluZyBvbiBtdWx0aXBsZSBjb250ZXh0cyBhdCBvbmNl
LCB1c2luZyBhIFN1YnN0cmVhbSAKSUQvUEFTSUQgZm9yIGVhY2ggb25lIC0gYnV0IGluc3RlYWQg
b2YgZXhwb3NpbmcgY29udHJvbCBvZiB0aGUgY29udGV4dHMgCnRvIGFueW9uZSBlbHNlLCB0aGV5
IHJlbWFpbiBoaWRkZW4gYmVoaW5kIHRoZSBrZXJuZWwgZHJpdmVyIHdoaWNoIAphbHJlYWR5IGhh
cyBpdHMgb3duIGFic3RyYWN0ZWQgdUFQSSwgc28gb3ZlcmFsbCBpdCBlbmRzIHVwIGFzIG1vcmUg
anVzdCAKaW50ZXJuYWwgaG91c2VrZWVwaW5nIHRoYW4gYW55IGFjdHVhbCBtZWRpYXRpb24uIFdl
IHdlcmUgbG9va2luZyBhdCB0aGUgCm1kZXYgY29kZSBmb3IgaW5zcGlyYXRpb24sIGJ1dCBkaXJl
Y3RseSB1c2luZyBpdCB3YXMgbmV2ZXIgdGhlIHBsYW4uCgo+PiBKdXN0IGFkZCBzb21lIGJhY2tn
cm91bmQuIGF1eCBkb21haW4gaXMgdXNlZCB0byBzdXBwb3J0IG1kZXYgYnV0IHRoZXkKPj4gYXJl
IG5vdCB0aWVkIHRvZ2V0aGVyLgoKWyB5ZXMsIHRlY2huaWNhbGx5IG15IGNvbW1lbnRzIGFyZSBy
ZWxldmFudCB0byBwYXRjaCAjNCwgYnV0IHRoZSAKZGlzY3Vzc2lvbiB3YXMgaGVyZSwgc28uLi4g
OikgXQoKPj4gTGl0ZXJhbGx5IGF1eCBkb21haW4ganVzdCBpbXBsaWVzIHRoYXQgdGhlcmUgY291
bGQgYmUKPj4gbXVsdGlwbGUgZG9tYWlucyBhdHRhY2hlZCB0byBhIGRldmljZSB0aGVuIHdoZW4g
b25lIG9mIHRoZW0gYmVjb21lcwo+PiB0aGUgcHJpbWFyeSBhbGwgdGhlIHJlbWFpbmluZyBhcmUg
ZGVlbWVkIGFzIGF1eGlsaWFyeS4gRnJvbSB0aGlzIGFuZ2xlIGl0Cj4+IGRvZXNuJ3QgbWF0dGVy
IHdoZXRoZXIgdGhlIHJlcXVpcmVtZW50IG9mIG11bHRpcGxlIGRvbWFpbnMgY29tZSBmcm9tCj4+
IHVzZXIgb3Iga2VybmVsLgo+IAo+IFlvdSBjYW4ndCBlbnRpcmVseSB1c2UgYXV4IGRvbWFpbiBm
cm9tIGluc2lkZSB0aGUga2VybmVsIGJlY2F1c2UgeW91Cj4gY2FuJ3QgY29tcG9zZSBpdCB3aXRo
IHRoZSBETUEgQVBJIHVubGVzcyB5b3UgYWxzbyBhdHRhY2ggaXQgdG8gc29tZQo+IHN0cnVjdCBk
ZXZpY2UsIGFuZCB3aGVyZSB3aWxsIHRoZSBzdHJ1Y3QgZGV2aWNlIGNvbWUgZnJvbT8KCkRNQSBt
YXBwaW5nIHdvdWxkIHN0aWxsIGJlIGRvbmUgdXNpbmcgdGhlIHBoeXNpY2FsIGRldmljZSAtIHdo
ZXJlIHRoaXMgCm1vZGVsIGRpdmVyZ2VzIGZyb20gbWRldiBpcyB0aGF0IGl0IGRvZXNuJ3QgbmVl
ZCB0byBmYWtlIHVwIGEgc3RydWN0IApkZXZpY2UgdG8gcmVwcmVzZW50IGVhY2ggY29udGV4dCBz
aW5jZSB0aGV5IGFyZW4ndCBleHBvc2VkIHRvIGFueW9uZSAKZWxzZS4gQXNzdW1lIHRoZSBkcml2
ZXIgYWxyZWFkeSBoYXMgc29tZSBraW5kIG9mIHRva2VuIHRvIHJlcHJlc2VudCBlYWNoIApjbGll
bnQgcHJvY2Vzcywgc28gaXQganVzdCBhbGxvY2F0ZXMgYW4gaW9tbXVfZG9tYWluIGZvciBhIGNs
aWVudCAKY29udGV4dCBhbmQgZG9lcyBhbiBpb21tdV9hdXhfYXR0YWNoX2RldigpIHRvIGhvb2sg
aXQgdXAgdG8gc29tZSBQQVNJRCAKKHdoaWNoIGFnYWluIG5vYm9keSBlbHNlIGV2ZXIgc2Vlcyku
IFRoZSBkcml2ZXIgc2ltcGx5IG5lZWRzIHRvIGtlZXAgCnRyYWNrIG9mIHRoZSBkb21haW5zIGFu
ZCBQQVNJRHMgLSB3aGVuIGEgcHJvY2VzcyBzdWJtaXRzIHNvbWUgd29yaywgaXQgCmNhbiBsb29r
IHVwIHRoZSByZWxldmFudCBkb21haW4sIGlvbW11X21hcCgpIHRoZSB1c2VyIHBhZ2VzIHRvIHRo
ZSByaWdodCAKYWRkcmVzc2VzLCBkbWFfbWFwKCkgdGhlbSBmb3IgY29oZXJlbmN5LCB0aGVuIHBv
a2UgaW4gdGhlIFBBU0lEIGFzIHBhcnQgCm9mIHNjaGVkdWxpbmcgdGhlIHdvcmsgb24gdGhlIHBo
eXNpY2FsIGRldmljZS4KCj4gV2UgYWxyZWFkeSB0YWxrZWQgYWJvdXQgdGhpcyBvbiB0aGUgImhv
dyB0byB1c2UgUEFTSUQgZnJvbSB0aGUga2VybmVsIgo+IHRocmVhZC4KCkRvIHlvdSBoYXZlIGEg
cG9pbnRlciB0byB0aGUgcmlnaHQgdGhyZWFkIHNvIEkgY2FuIGNhdGNoIHVwPyBJdCdzIG5vdCAK
dGhlIGVhc2llc3QgdGhpbmcgdG8gc2VhcmNoIGZvciBvbiBsb3JlIGFtb25nc3QgYWxsIHRoZSBv
dGhlciAKUEFTSUQtcmVsYXRlZCBidXNpbmVzcyA6KAoKPiBJZiBSb2JpbiBqdXN0IHdhbnRzIHRv
IHVzZSBhIHN0cmVhbSBJRCBmcm9tIGEga2VybmVsIGRyaXZlciB0aGVuIHRoYXQKPiBBUEkgdG8g
bWFrZSBhIFBBU0lEID09IFJJRCBzZWVtcyBsaWtlIGEgYmV0dGVyIGFuc3dlciBmb3Iga2VybmVs
IERNQQo+IHRoYW4gYXV4IGRvbWFpbnMgaXMuCgpObywgdGhhdCdzIG5vdCB0aGUgbW9kZWwgLSB0
aGUgZGV2aWNlIGhhcyBhIHNpbmdsZSBTdHJlYW0gSUQgKFJJRCksIGFuZCAKaXQgd2FudHMgbXVs
dGlwbGUgU3Vic3RyZWFtIElEcyAoUEFTSURzKSBoYW5naW5nIG9mZiB0aGF0IGZvciBkaXN0aW5j
dCAKY2xpZW50IGNvbnRleHRzOyBpdCBjYW4gc3RpbGwgZ2VuZXJhdGUgbm9uLVBBU0lEIHRyYWZm
aWMgZm9yIHN0dWZmIGxpa2UgCmxvYWRpbmcgaXRzIGZpcm13YXJlICh0aGUgcmVndWxhciBpb21t
dV9kb21haW4gbWlnaHQgYmUgCmV4cGxpY2l0bHktbWFuYWdlZCBvciBtaWdodCBiZSBhdXRvbWF0
aWMgdmlhIGlvbW11LWRtYSAtIGl0IGRvZXNu4oCZdCAKcmVhbGx5IG1hdHRlciBpbiB0aGlzIGNv
bnRleHQpLiBBdXggZG9tYWlucyByZWFsbHkgd2VyZSBhIHBlcmZlY3QgZml0IApjb25jZXB0dWFs
bHksIGV2ZW4gaWYgdGhlIGVkZ2VzIHdlcmUgYSBiaXQgcm91Z2guCgpOb3csIG11Y2ggYXMgSeKA
mWQgbGlrZSBhIHN0YWJsZSB1cHN0cmVhbSBzb2x1dGlvbiwgSSBjYW4ndCBhcmd1ZSBiYXNlZCBv
biAKdGhpcyBwYXJ0aWN1bGFyIGRyaXZlciwgc2luY2UgdGhlIFBBU0lEIGZ1bmN0aW9uYWxpdHkg
aXMgc3RpbGwgaW4gCmRldmVsb3BtZW50LCBhbmQgdGhlcmUgc2VlbXMgbGl0dGxlIGxpa2VsaWhv
b2Qgb2YgaXQgYmVpbmcgdXBzdHJlYW1lZCAKZWl0aGVyIHdheSAodGhlIGRyaXZlciBiZWxvbmdz
IHRvIGEgcHJvZHVjdCB0ZWFtIHJhdGhlciB0aGFuIHRoZSBPU1MgCmdyb3VwIEknbSBwYXJ0IG9m
OyBJJ20ganVzdCBoZWxwaW5nIHRoZW0gd2l0aCB0aGUgU01NVSBhbmdsZSkuIElmIApkZXNpZ25p
bmcgc29tZXRoaW5nIGFyb3VuZCBhdXggZG9tYWlucyBpcyBhIGRlYWQtZW5kIHRoZW4gd2UgKEFy
bSkgd2lsbCAKcHJvYmFibHkganVzdCBwcm90b3R5cGUgb3VyIHRoaW5nIHVzaW5nIGRvd25zdHJl
YW0gcGF0Y2hlcyB0byB0aGUgU01NVSAKZHJpdmVyIGZvciBub3cuIEhvd2V2ZXIgZ2l2ZW4gdGhl
IGNsZWFyIG92ZXJsYXAgd2l0aCBTSU9WIG1kZXYgaW4gdGVybXMgCm9mIGltcGxlbWVudGF0aW9u
IGF0IHRoZSBJT01NVSBBUEkgbGV2ZWwgYW5kIGJlbG93LCBpdCBzZWVtcyBhIGdlbmVyYWwgCmVu
b3VnaCB1c2UtY2FzZSB0aGF0IEnigJltIHZlcnkga2VlbiBub3QgdG8gbG9zZSBzaWdodCBvZiBp
dCBpbiB3aGF0ZXZlciAKcmVwbGFjZW1lbnQgd2UgKHVwc3RyZWFtKSBkbyBjb21lIHVwIHdpdGgu
IEZXSVcgbXkgbm9uLVNWQSB2aWV3IGlzIHRoYXQgCmEgUEFTSUQgaXMgbWVyZWx5IGFuIGluZGV4
IGludG8gYSBzZXQgb2YgaW9tbXVfZG9tYWlucywgYW5kIGluIHRoYXQgCmNvbnRleHQgaXQgZG9l
c24ndCBldmVuIHJlYWxseSBtYXR0ZXIgKndobyogYWxsb2NhdGVzIHRoZW0sIG9ubHkgdGhhdCAK
dGhlIGRldmljZSBkcml2ZXIgYW5kIElPTU1VIGRyaXZlciBhcmUgaW4gc3luYyA6KQoKVGhhbmtz
LApSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
