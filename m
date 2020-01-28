Return-Path: <SRS0=+4f7=3R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BAC33CB2
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C9420716
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C9420716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D28948598A;
	Tue, 28 Jan 2020 14:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M3iTrZtx8KL0; Tue, 28 Jan 2020 14:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC83D859D6;
	Tue, 28 Jan 2020 14:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5A79C0175;
	Tue, 28 Jan 2020 14:41:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFD09C0171
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 14:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D4B3887A30
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 14:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QHw9ezlqtYqP for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jan 2020 14:41:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 81892879F0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 14:41:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4D8E31B;
 Tue, 28 Jan 2020 06:41:32 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D6D33F68E;
 Tue, 28 Jan 2020 06:41:23 -0800 (PST)
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h6: Add IOMMU
To: =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
 Maxime Ripard <maxime@cerno.tech>
References: <cover.b2a9e1507135d81e726fcbb65137665a7f0ab74f.1579696927.git-series.maxime@cerno.tech>
 <5320339.DvuYhMxLoT@jernej-laptop>
 <20200127142339.crxsuunzec5drfe2@gilmour.lan>
 <2140600.ElGaqSPkdT@jernej-laptop>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5543595c-4ef9-b67e-5dff-042fb1991194@arm.com>
Date: Tue, 28 Jan 2020 14:41:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2140600.ElGaqSPkdT@jernej-laptop>
Content-Language: en-GB
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

T24gMjcvMDEvMjAyMCA3OjA0IHBtLCBKZXJuZWogxaBrcmFiZWMgd3JvdGU6Cj4gSGkhCj4gCj4g
RG5lIHBvbmVkZWxqZWssIDI3LiBqYW51YXIgMjAyMCBvYiAxNToyMzozOSBDRVQgamUgTWF4aW1l
IFJpcGFyZCBuYXBpc2FsKGEpOgo+PiBIaSBKZXJuZWosCj4+Cj4+IE9uIEZyaSwgSmFuIDI0LCAy
MDIwIGF0IDA5OjU0OjIzUE0gKzAxMDAsIEplcm5laiDFoGtyYWJlYyB3cm90ZToKPj4+IERuZSBz
cmVkYSwgMjIuIGphbnVhciAyMDIwIG9iIDEzOjQ0OjA5IENFVCBqZSBNYXhpbWUgUmlwYXJkIG5h
cGlzYWwoYSk6Cj4+Pj4gTm93IHRoYXQgd2UgaGF2ZSBhIGRyaXZlciBmb3IgdGhlIElPTU1VLCBs
ZXQncyBzdGFydCB1c2luZyBpdC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1heGltZSBSaXBh
cmQgPG1heGltZUBjZXJuby50ZWNoPgo+Pj4+IC0tLQo+Pj4+Cj4+Pj4gICBhcmNoL2FybTY0L2Jv
b3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRzaSB8IDExICsrKysrKysrKysrCj4+Pj4gICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjUwaS1oNi5kdHNpCj4+Pj4gYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRzaSBpbmRleAo+Pj4+IDI5ODI0MDgx
YjQzYi4uODYwOGJjZjFjNTJjIDEwMDY0NAo+Pj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
YWxsd2lubmVyL3N1bjUwaS1oNi5kdHNpCj4+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9h
bGx3aW5uZXIvc3VuNTBpLWg2LmR0c2kKPj4+PiBAQCAtNTMsNiArNTMsNyBAQAo+Pj4+Cj4+Pj4g
ICAJZGU6IGRpc3BsYXktZW5naW5lIHsKPj4+PiAgIAkKPj4+PiAgIAkJY29tcGF0aWJsZSA9ICJh
bGx3aW5uZXIsc3VuNTBpLWg2LWRpc3BsYXktZW5naW5lIjsKPj4+PiAgIAkJYWxsd2lubmVyLHBp
cGVsaW5lcyA9IDwmbWl4ZXIwPjsKPj4+Pgo+Pj4+ICsJCWlvbW11cyA9IDwmaW9tbXUgMD47Cj4+
Pj4KPj4+PiAgIAkJc3RhdHVzID0gImRpc2FibGVkIjsKPj4+PiAgIAkKPj4+PiAgIAl9Owo+Pj4K
Pj4+IElzbid0IGlvbW11IHByb3BlcnR5IG9mIHRoZSBtaXhlciBub2RlPyBBZnRlciBhbGwsIG1p
eGVyIGlzIHRoZSBvbmUgd2hpY2gKPj4+IHJlYWRzIG9uZSBvciBtb3JlIGZyYW1lYnVmZmVycy4g
T25jZSBzZWNvbmQgbWl4ZXIgaXMgZGVmaW5lZCwgd291bGQgeW91Cj4+PiBwdXQKPj4+IGFub3Ro
ZXIgaW9tbXUgcGhhbmRsZSBoZXJlPwo+Pgo+PiBZb3UncmUgcmlnaHQuIEkgYWRkZWQgaXQgZHVy
aW5nIHRoZSBlYXJseSBkZXYsIGFuZCBmb3Jnb3QgdG8gcmVtb3ZlCj4+IGl0LiBUaGFua3MhCj4g
Cj4gUmVtb3ZlIGl0IG9yIG1vdmUgaXQ/IEkgZ3Vlc3MgZW5hYmxpbmcgaW9tbXUgc3VwcG9ydCBp
biBlYWNoIGRyaXZlciBuZWVkcyBhCj4gYml0IG1vcmUgd29yayB0aGFuIGp1c3QgcmVmZXJlbmNp
bmcgaW9tbXUgbm9kZSwgcmlnaHQ/IEF0IGxlYXN0IGluIHN1Y2ggY2FzZQo+IGJ1ZmZlcnMgZG9u
J3QgbmVlZCB0byBiZSBhbGxvY2F0ZWQgYnkgQ01BLCB3aGljaCBzdW40aS1kcm0gZHJpdmVyIGN1
cnJlbnRseQo+IHVzZS4KCk5vdGUgdGhhdCB0aGUgRFJNICJDTUEiIGhlbHBlcnMgYXJlIHNvbWV3
aGF0IG1pc25hbWVkLCBzaW5jZSB0aGV5J3JlIGluIApmYWN0IGJhc2VkIG9uIHRoZSBjb21tb24g
RE1BIEFQSSwgYW5kIHRodXMgdHJhbnNwYXJlbnQgSU9NTVUtYmFja2VkIERNQSAKb3BzIHdpbGwg
Imp1c3Qgd29yayIgd2l0aG91dCB0aGUgZHJpdmVycyBoYXZpbmcgdG8gY2FyZS4gU2luY2UgYWxs
IHRoZSAKZGlzcGxheSBjb21wb25lbnRzIGJlaGluZCB0aGUgSU9NTVUgd2lsbCBiZSBpbiB0aGUg
c2FtZSBJT01NVSBncm91cCwgCnRoZXkncmUgZ3VhcmFudGVlZCB0byBhbHdheXMgb3BlcmF0ZSBp
biB0aGUgc2FtZSBhZGRyZXNzIHNwYWNlIGFzIGVhY2ggCm90aGVyLCBzbyB0aGVyZSBzaG91bGQg
YmUgbm8gYWRkaXRpb25hbCBwcm9ibGVtcyB3aXRoIGJ1ZmZlciBzaGFyaW5nIAooYXNzdW1pbmcg
dGhlIGNvZGUgZG9lc24ndCBoYXZlIGJ1Z3MgdGhhdCBpdCdzIGN1cnJlbnRseSBqdXN0IGdldHRp
bmcgCmF3YXkgd2l0aCkuCgo+IEkganVzdCB0YWtlIGFub3RoZXIgbG9vayBhdCBCU1Aga2VybmVs
IGFuZCBpdCBzZWVtcyB0aGF0IG9ubHkgb25lIGNoYW5uZWwgaXMKPiB1c2VkIGZvciB3aG9sZSBk
aXNwbGF5IHN0YWNrLiBUaGF0IHdvdWxkIG1lYW4gdGhhdCBib3RoIG1peGVycyB3b3VsZCBoYXZl
IHNhbWUKPiBpb21tdSBwaGFuZGxlLCByaWdodD8gQ29uZnVzaW5nbHkgZW5vdWdoLCBERTIgaW9t
bXUgY2hhbm5lbCBzZWVtcyB0byBiZSBmb3IKPiBkZWludGVybGFjZSBjb3JlLgoKVGhhdCdzIGFs
c28gZmluZSAtIGFzIGRpc2N1c3NlZCBvbiB0aGUgZHJpdmVyIHRocmVhZCB0aGVyZSdzIG5vIHBv
aW50IAp0cnlpbmcgdG8gZXhwb3NlIGEgZGlzdGluY3Rpb24gYmV0d2VlbiBkZXZpY2VzIGF0IHRo
ZSBBUEkgbGV2ZWwsIHNvIHRoZSAKSURzIGFyZSByZWFsbHkgb25seSByZWxldmFudCB0byB0aGUg
ZHJpdmVyIGludGVybmFscyB0b3VjaGluZyB0aGUgCnZhcmlvdXMgZW5hYmxlIHJlZ2lzdGVycyAo
YW5kIGV2ZW4gdGhlbiBvbmx5IGlmIHlvdSB3YW50ZWQgdG8gcmVmaW5lIHRoZSAKY3VycmVudCAi
anVzdCBlbmFibGUgZXZlcnl0aGluZyIgYXBwcm9hY2gpLgoKUm9iaW4uCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
