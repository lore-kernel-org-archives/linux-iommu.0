Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA9FC433E1
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 08:28:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B82920DD4
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 08:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B82920DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 186AC8968E;
	Wed,  8 Jul 2020 08:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sLz3V-UxToiZ; Wed,  8 Jul 2020 08:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34C0E8952C;
	Wed,  8 Jul 2020 08:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1A88C08A9;
	Wed,  8 Jul 2020 08:28:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC6DFC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 06:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B2DB18898E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 06:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xve2ameTJYm5 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 06:29:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 31AD0885D2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 06:29:02 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.75,326,1589234400"; d="scan'208";a="353892050"
Received: from 91-160-5-165.subs.proxad.net (HELO [192.168.44.21])
 ([91.160.5.165])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA;
 08 Jul 2020 08:28:59 +0200
Subject: Re: [PATCH] iommu/arm-smmu-v3: expose numa_node attribute to users in
 sysfs
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
References: <20200530091505.56664-1-song.bao.hua@hisilicon.com>
 <20200703162137.GA19780@willie-the-truck>
 <B926444035E5E2439431908E3842AFD25559F2@DGGEMI525-MBS.china.huawei.com>
 <20200706092649.0000676d@Huawei.com>
From: Brice Goglin <Brice.Goglin@inria.fr>
Autocrypt: addr=Brice.Goglin@inria.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1b731c0a-d5ad-ce1e-9489-f616671959cc@inria.fr>
Date: Wed, 8 Jul 2020 08:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200706092649.0000676d@Huawei.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 08 Jul 2020 08:28:28 +0000
Cc: Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CkxlIDA2LzA3LzIwMjAgw6AgMTA6MjYsIEpvbmF0aGFuIENhbWVyb24gYSDDqWNyaXTCoDoKPiBP
biBTdW4sIDUgSnVsIDIwMjAgMDk6NTM6NTggKzAwMDAKPiAiU29uZyBCYW8gSHVhIChCYXJyeSBT
b25nKSIgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPiB3cm90ZToKPgo+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPj4+IEZyb206IFdpbGwgRGVhY29uIFttYWlsdG86d2lsbEBrZXJu
ZWwub3JnXQo+Pj4gU2VudDogU2F0dXJkYXksIEp1bHkgNCwgMjAyMCA0OjIyIEFNCj4+PiBUbzog
U29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+Cj4+
PiBDYzogcm9iaW4ubXVycGh5QGFybS5jb207IGhjaEBsc3QuZGU7IG0uc3p5cHJvd3NraUBzYW1z
dW5nLmNvbTsKPj4+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7Cj4+PiBMaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT4KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlvbW11L2FybS1zbW11LXYzOiBleHBvc2Ug
bnVtYV9ub2RlIGF0dHJpYnV0ZSB0bwo+Pj4gdXNlcnMgaW4gc3lzZnMKPj4+Cj4+PiBPbiBTYXQs
IE1heSAzMCwgMjAyMCBhdCAwOToxNTowNVBNICsxMjAwLCBCYXJyeSBTb25nIHdyb3RlOiAgCj4+
Pj4gQXMgdGVzdHMgc2hvdyB0aGUgbGF0ZW5jeSBvZiBkbWFfdW5tYXAgY2FuIGluY3JlYXNlIGRy
YW1hdGljYWxseSB3aGlsZQo+Pj4+IGNhbGxpbmcgdGhlbSBjcm9zcyBOVU1BIG5vZGVzLCBlc3Bl
Y2lhbGx5IGNyb3NzIENQVSBwYWNrYWdlcywgZWcuCj4+Pj4gMzAwbnMgdnMgODAwbnMgd2hpbGUg
d2FpdGluZyBmb3IgdGhlIGNvbXBsZXRpb24gb2YgQ01EX1NZTkMgaW4gYW4KPj4+PiBlbXB0eSBj
b21tYW5kIHF1ZXVlLiBUaGUgbGFyZ2UgbGF0ZW5jeSBjYXVzaW5nIGJ5IHJlbW90ZSBub2RlIHdp
bGwKPj4+PiBpbiB0dXJuIG1ha2UgY29udGVudGlvbiBvZiB0aGUgY29tbWFuZCBxdWV1ZSBtb3Jl
IHNlcmlvdXMsIGFuZCBlbmxhcmdlCj4+Pj4gdGhlIGxhdGVuY3kgb2YgRE1BIHVzZXJzIHdpdGhp
biBsb2NhbCBOVU1BIG5vZGVzLgo+Pj4+Cj4+Pj4gVXNlcnMgbWlnaHQgaW50ZW5kIHRvIGVuZm9y
Y2UgTlVNQSBsb2NhbGl0eSB3aXRoIHRoZSBjb25zaWRlcmF0aW9uIG9mCj4+Pj4gdGhlIHBvc2l0
aW9uIG9mIFNNTVUuIFRoZSBwYXRjaCBwcm92aWRlcyBtaW5vciBiZW5lZml0IGJ5IHByZXNlbnRp
bmcKPj4+PiB0aGlzIGluZm9ybWF0aW9uIHRvIHVzZXJzIGRpcmVjdGx5LCBhcyB0aGV5IG1pZ2h0
IHdhbnQgdG8ga25vdyBpdCB3aXRob3V0Cj4+Pj4gY2hlY2tpbmcgaGFyZHdhcmUgc3BlYyBhdCBh
bGwuICAKPj4+IEkgZG9uJ3QgdGhpbmsgdGhhdCdzIGEgdmVyeSBnb29kIHJlYXNvbiB0byBleHBv
c2UgdGhpbmdzIHRvIHVzZXJzcGFjZS4KPj4+IEkga25vdyBzeXNmcyBzaG91bGRuJ3QgYmUgdHJl
YXRlZCBhcyBBQkksIGJ1dCB0aGUgZ3JpbSByZWFsaXR5IGlzIHRoYXQKPj4+IG9uY2Ugc29tZWJv
ZHkgcmVsaWVzIG9uIHRoaXMgc3R1ZmYgdGhlbiB3ZSBjYW4ndCBjaGFuZ2UgaXQsIHNvIEknZAo+
Pj4gcmF0aGVyIGF2b2lkIGV4cG9zaW5nIGl0IHVubGVzcyBpdCdzIGFic29sdXRlbHkgbmVjZXNz
YXJ5LiAgCj4+IFdpbGwsIHRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayEKPj4KPj4gSSBhbSBub3Qg
c3VyZSBpZiBpdCBpcyBhYnNvbHV0ZWx5IG5lY2Vzc2FyeSwgYnV0IGl0IGlzIHVzZWZ1bCB0byB1
c2Vycy4gVGhlIHdob2xlIHN0b3J5IHN0YXJ0ZWQKPj4gZnJvbSBzb21lIHVzZXJzIHdobyB3YW50
ZWQgdG8ga25vdyB0aGUgaGFyZHdhcmUgdG9wb2xvZ3kgdmVyeSBjbGVhciBieSByZWFkaW5nIHNv
bWUKPj4gc3lzZnMgbm9kZSBqdXN0IGxpa2UgdGhleSBhcmUgYWJsZSB0byBkbyB0aGF0IGZvciBw
Y2kgZGV2aWNlcy4gVGhlIGludGVudGlvbiBpcyB0aGF0IHVzZXJzIGNhbgo+PiBrbm93IGhhcmR3
YXJlIHRvcG9sb2d5IG9mIHZhcmlvdXMgZGV2aWNlcyBlYXNpbHkgZnJvbSBsaW51eCBzaW5jZSB0
aGV5IG1heWJlIGRvbid0IGtub3cKPj4gYWxsIHRoZSBoYXJkd2FyZSBkZXRhaWxzLgo+Pgo+PiBG
b3IgcGNpIGRldmljZXMsIGtlcm5lbCBoYXMgZG9uZSB0aGF0LiBBbmQgdGhlcmUgYXJlIHNvbWUg
b3RoZXIgZHJpdmVycyBvdXQgb2YgcGNpCj4+IGV4cG9zaW5nIG51bWFfbm9kZSBhcyB3ZWxsLiBJ
dCBzZWVtcyBpdCBpcyBoYXJkIHRvIHNheSBpdCBpcyBhYnNvbHV0ZWx5IG5lY2Vzc2FyeQo+PiBm
b3IgdGhlbSB0b28gc2luY2Ugc3lzZnMgc2hvdWxkbid0IGJlIHRyZWF0ZWQgYXMgQUJJLiAKPiBC
cmljZSwKPgo+IEdpdmVuIGh3bG9jIGlzIHByb2JhYmx5IHRoZSBtb3N0IGRlbWFuZGluZyB1c2Vy
IG9mIHRvcG9sb2d5IGluZm9ybWF0aW9uCj4gY3VycmVudGx5Li4uCj4KPiBIb3cgdXNlZnVsIHdv
dWxkIHRoaXMgaW5mbyBiZSBmb3IgaHdsb2MgYW5kIGh3bG9jIHVzZXJzPwo+IFNvcnQgb2YgZmVl
bHMgbGlrZSBpdCBtaWdodCBiZSB1c2VmdWwgaW4gc29tZSBjYXNlcy4KPgo+IFRoZSB2ZXJ5IGJy
aWVmIGRlc2NyaXB0aW9uIG9mIHdoYXQgd2UgaGF2ZSBoZXJlIGlzIGV4cG9zaW5nIHRoZSBudW1h
IG5vZGUKPiBvZiBhbiBJT01NVS4gIFRoZSBkaXNjdXNzaW9uIGFsc28gZGl2ZXJ0ZWQgaW50byB3
aGV0aGVyIGl0IGp1c3QgbWFrZXMgc2Vuc2UKPiB0byBleHBvc2UgdGhpcyBmb3IgYWxsIHBsYXRm
b3JtIGRldmljZXMgb3IgZXZlbiBkbyBpdCBhdCB0aGUgZGV2aWNlIGxldmVsLgoKCkhlbGxvCgpX
ZSBkb24ndCBoYXZlIGFueXRoaW5nIGFib3V0IElPTU1VIGluIGh3bG9jIHNvIGZhciwgbGlrZWx5
IGJlY2F1c2UgaXRzCmxvY2FsaXR5IG5ldmVyIG1hdHRlcmVkIGluIHRoZSBwYXN0PyBJIGd1ZXNz
IHdlJ2xsIGdldCBzb21lIHVzZXIKcmVxdWVzdHMgZm9yIGl0IG9uY2UgbW9yZSBwbGF0Zm9ybXMg
c2hvdyB0aGlzIGlzc3VlIGFuZCBzb21lCnBlcmZvcm1hbmNlLWNyaXRpY2FsIGFwcGxpY2F0aW9u
cyBhcmUgbm90IGhhcHB5IHdpdGggaXQuCgpDYW4geW91IGNsYXJpZnkgd2hhdCB0aGUgd2hvbGUg
bWFjaGluZSB0b3BvbG9neSBsb29rIGxpa2U/IEFyZSB3ZQp0YWxraW5nIGFib3V0IHNvbWUgUENJ
IGRldmljZXMgYmVpbmcgYXR0YWNoZWQgdG8gb25lIHNvY2tldCBidXQgdGFsa2luZwp0byB0aGUg
SU9NTVUgb2YgdGhlIG90aGVyIHNvY2tldD8KCkJyaWNlCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
