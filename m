Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D6C48BE8
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 10:29:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C4B61453
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 10:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C4B61453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A084583218;
	Tue, 15 Jun 2021 10:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0wHvV5498M2; Tue, 15 Jun 2021 10:29:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A67183133;
	Tue, 15 Jun 2021 10:29:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 623C8C000D;
	Tue, 15 Jun 2021 10:29:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8083EC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 10:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60E72405C0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 10:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ysRjvP1aTLN5 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 10:29:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F4F9405BF
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 10:29:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EF4F61443;
 Tue, 15 Jun 2021 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623752992;
 bh=37hVSbyeuLGiLfoCe6jAMxyuGxvuaW5ZN4LcqohlOI4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TQBHdPJsVBmJJIMkoRrJsu7fO7YG5XyErKt70kFxjlZailSmnD7XXPvBz5m2dDbVY
 Hzo7DrD3jtCNiY+WWr/KSp72PvVbsDgMBCg63vkT5pS9Zn4/zBuLnDtybZ/Tva0Yao
 siOvNtJ04C4ylkNKTHYHUSDR7lYWBFp9AdRp8GpozL7Z4rDZwVLiA27wPfZNfApHTe
 EW59F0B2TLXs8A/6dGhsYGsQ69ICJKv0G5DA3tTqeSUw9ZnGF8yiEap85V4Dbjp2MA
 6zf7FfA+ML9UPp/GV1F10kwX1ZvmQN9m4krJPmpXC6oDNeBLRMJpbqZfcFNMAoATxz
 gxkcmIXenKXXQ==
Date: Tue, 15 Jun 2021 11:29:48 +0100
From: Will Deacon <will@kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Message-ID: <20210615102947.GB20225@willie-the-truck>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-5-namit@vmware.com>
 <20210611135746.GC15776@willie-the-truck>
 <D76DA59C-023F-43D1-B4ED-BFA65D9D064F@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D76DA59C-023F-43D1-B4ED-BFA65D9D064F@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jiajun Cao <caojiajun@vmware.com>, Robin Murphy <robin.murphy@arm.com>
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

T24gRnJpLCBKdW4gMTEsIDIwMjEgYXQgMDk6NTA6MzFBTSAtMDcwMCwgTmFkYXYgQW1pdCB3cm90
ZToKPiAKPiAKPiA+IE9uIEp1biAxMSwgMjAyMSwgYXQgNjo1NyBBTSwgV2lsbCBEZWFjb24gPHdp
bGxAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiAKPiA+IE9uIE1vbiwgSnVuIDA3LCAyMDIxIGF0IDEx
OjI1OjM5QU0gLTA3MDAsIE5hZGF2IEFtaXQgd3JvdGU6Cj4gPj4gRnJvbTogTmFkYXYgQW1pdCA8
bmFtaXRAdm13YXJlLmNvbT4KPiA+PiAKPiA+PiBSZWZhY3RvciBpb21tdV9pb3RsYl9nYXRoZXJf
YWRkX3BhZ2UoKSBhbmQgZmFjdG9yIG91dCB0aGUgbG9naWMgdGhhdAo+ID4+IGRldGVjdHMgd2hl
dGhlciBJT1RMQiBnYXRoZXIgcmFuZ2UgYW5kIGEgbmV3IHJhbmdlIGFyZSBkaXNqb2ludC4gVG8g
YmUKPiA+PiB1c2VkIGJ5IHRoZSBuZXh0IHBhdGNoIHRoYXQgaW1wbGVtZW50cyBkaWZmZXJlbnQg
Z2F0aGVyaW5nIGxvZ2ljIGZvcgo+ID4+IEFNRC4KPiA+PiAKPiA+PiBDYzogSm9lcmcgUm9lZGVs
IDxqb3JvQDhieXRlcy5vcmc+Cj4gPj4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+
Cj4gPj4gQ2M6IEppYWp1biBDYW8gPGNhb2ppYWp1bkB2bXdhcmUuY29tPgo+ID4+IENjOiBSb2Jp
biBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+ID4+IENjOiBMdSBCYW9sdSA8YmFvbHUu
bHVAbGludXguaW50ZWwuY29tPgo+ID4+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwo+ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPgo+ID4+IFNpZ25lZC1v
ZmYtYnk6IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+Cj4gPj4gLS0tCj4gPj4gaW5jbHVk
ZS9saW51eC9pb21tdS5oIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0KPiA+PiAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkKPiA+IAo+ID4gWy4uLl0KPiA+IAo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lv
bW11LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiA+PiBpbmRleCBmMjU0YzYyZjM3MjAuLmI1
YTJiZmM2OGZiMCAxMDA2NDQKPiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiA+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiA+PiBAQCAtNDk3LDYgKzQ5NywyOCBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgaW9tbXVfaW90bGJfc3luYyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21h
aW4sCj4gPj4gCWlvbW11X2lvdGxiX2dhdGhlcl9pbml0KGlvdGxiX2dhdGhlcik7Cj4gPj4gfQo+
ID4+IAo+ID4+ICsvKioKPiA+PiArICogaW9tbXVfaW90bGJfZ2F0aGVyX2lzX2Rpc2pvaW50IC0g
Q2hlY2tzIHdoZXRoZXIgYSBuZXcgcmFuZ2UgaXMgZGlzam9pbnQKPiA+PiArICoKPiA+PiArICog
QGdhdGhlcjogVExCIGdhdGhlciBkYXRhCj4gPj4gKyAqIEBpb3ZhOiBzdGFydCBvZiBwYWdlIHRv
IGludmFsaWRhdGUKPiA+PiArICogQHNpemU6IHNpemUgb2YgcGFnZSB0byBpbnZhbGlkYXRlCj4g
Pj4gKyAqCj4gPj4gKyAqIEhlbHBlciBmb3IgSU9NTVUgZHJpdmVycyB0byBjaGVjayB3aGV0aGVy
IGEgbmV3IHJhbmdlIGlzIGFuZCB0aGUgZ2F0aGVyZWQKPiA+PiArICogcmFuZ2UgYXJlIGRpc2pv
aW50Lgo+ID4gCj4gPiBJIGNhbid0IHF1aXRlIHBhcnNlIHRoaXMuIERlbGV0ZSB0aGUgImlzIj8K
PiAKPiBJbmRlZWQuIFdpbGwgZG8gKEkgbWVhbiBJIHdpbGwgZG8gOy0pICkKPiAKPiA+IAo+ID4+
ICAgIEZvciBtYW55IElPTU1VcywgZmx1c2hpbmcgdGhlIElPTU1VIGluIHRoaXMgY2FzZSBpcwo+
ID4+ICsgKiBiZXR0ZXIgdGhhbiBtZXJnaW5nIHRoZSB0d28sIHdoaWNoIG1pZ2h0IGxlYWQgdG8g
dW5uZWNlc3NhcnkgaW52YWxpZGF0aW9ucy4KPiA+PiArICovCj4gPj4gK3N0YXRpYyBpbmxpbmUK
PiA+PiArYm9vbCBpb21tdV9pb3RsYl9nYXRoZXJfaXNfZGlzam9pbnQoc3RydWN0IGlvbW11X2lv
dGxiX2dhdGhlciAqZ2F0aGVyLAo+ID4+ICsJCQkJICAgIHVuc2lnbmVkIGxvbmcgaW92YSwgc2l6
ZV90IHNpemUpCj4gPj4gK3sKPiA+PiArCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSBpb3ZhLCBlbmQg
PSBzdGFydCArIHNpemUgLSAxOwo+ID4+ICsKPiA+PiArCXJldHVybiBnYXRoZXItPmVuZCAhPSAw
ICYmCj4gPj4gKwkJKGVuZCArIDEgPCBnYXRoZXItPnN0YXJ0IHx8IHN0YXJ0ID4gZ2F0aGVyLT5l
bmQgKyAxKTsKPiA+PiArfQo+ID4+ICsKPiA+PiArCj4gPj4gLyoqCj4gPj4gICogaW9tbXVfaW90
bGJfZ2F0aGVyX2FkZF9yYW5nZSAtIEdhdGhlciBmb3IgYWRkcmVzcy1iYXNlZCBUTEIgaW52YWxp
ZGF0aW9uCj4gPj4gICogQGdhdGhlcjogVExCIGdhdGhlciBkYXRhCj4gPj4gQEAgLTUzMywyMCAr
NTU1LDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpb21tdV9pb3RsYl9nYXRoZXJfYWRkX3BhZ2Uo
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+ID4+IAkJCQkJICAgICAgIHN0cnVjdCBpb21t
dV9pb3RsYl9nYXRoZXIgKmdhdGhlciwKPiA+PiAJCQkJCSAgICAgICB1bnNpZ25lZCBsb25nIGlv
dmEsIHNpemVfdCBzaXplKQo+ID4+IHsKPiA+PiAtCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSBpb3Zh
LCBlbmQgPSBzdGFydCArIHNpemUgLSAxOwo+ID4+IC0KPiA+PiAJLyoKPiA+PiAJICogSWYgdGhl
IG5ldyBwYWdlIGlzIGRpc2pvaW50IGZyb20gdGhlIGN1cnJlbnQgcmFuZ2Ugb3IgaXMgbWFwcGVk
IGF0Cj4gPj4gCSAqIGEgZGlmZmVyZW50IGdyYW51bGFyaXR5LCB0aGVuIHN5bmMgdGhlIFRMQiBz
byB0aGF0IHRoZSBnYXRoZXIKPiA+PiAJICogc3RydWN0dXJlIGNhbiBiZSByZXdyaXR0ZW4uCj4g
Pj4gCSAqLwo+ID4+IC0JaWYgKGdhdGhlci0+cGdzaXplICE9IHNpemUgfHwKPiA+PiAtCSAgICBl
bmQgKyAxIDwgZ2F0aGVyLT5zdGFydCB8fCBzdGFydCA+IGdhdGhlci0+ZW5kICsgMSkgewo+ID4+
IC0JCWlmIChnYXRoZXItPnBnc2l6ZSkKPiA+PiAtCQkJaW9tbXVfaW90bGJfc3luYyhkb21haW4s
IGdhdGhlcik7Cj4gPj4gLQkJZ2F0aGVyLT5wZ3NpemUgPSBzaXplOwo+ID4+IC0JfQo+ID4+ICsJ
aWYgKChnYXRoZXItPnBnc2l6ZSAmJiBnYXRoZXItPnBnc2l6ZSAhPSBzaXplKSB8fAo+ID4+ICsJ
ICAgIGlvbW11X2lvdGxiX2dhdGhlcl9pc19kaXNqb2ludChnYXRoZXIsIGlvdmEsIHNpemUpKQo+
ID4+ICsJCWlvbW11X2lvdGxiX3N5bmMoZG9tYWluLCBnYXRoZXIpOwo+ID4+IAo+ID4+ICsJZ2F0
aGVyLT5wZ3NpemUgPSBzaXplOwo+ID4gCj4gPiBXaHkgaGF2ZSB5b3UgbWFkZSB0aGlzIHVuY29u
ZGl0aW9uYWw/IEkgdGhpbmsgaXQncyBvaywgYnV0IGp1c3Qgbm90IHN1cmUKPiA+IGlmIGl0J3Mg
bmVjZXNzYXJ5IG9yIG5vdC4KPiAKPiBJbiByZWdhcmQgdG8gZ2F0aGVyLT5wZ3NpemUsIHRoaXMg
ZnVuY3Rpb24gaGFkIChhbmQgaGFzKSBhbgo+IGludmFyaWFudCwgaW4gd2hpY2ggZ2F0aGVyLT5w
Z3NpemUgYWx3YXlzIHJlcHJlc2VudHMgdGhlIGZsdXNoaW5nCj4gZ3JhbnVsYXJpdHkgb2YgaXRz
IHJhbmdlLiBBcmd1YWJseSwg4oCcc2l6ZSIgc2hvdWxkIG5ldmVyIGJlCj4gemVybywgYnV0IGxl
dHMgYXNzdW1lIGZvciB0aGUgbWF0dGVyIG9mIGRpc2N1c3Npb24gdGhhdCBpdCBtaWdodC4KPiAK
PiBJZiDigJxzaXpl4oCdIGVxdWFscyB0byDigJxnYXRoZXItPnBnc2l6ZeKAnSwgdGhlbiB0aGUg
YXNzaWdubWVudCBpbgo+IHF1ZXN0aW9uIGhhcyBubyBpbXBhY3QuCj4gCj4gT3RoZXJ3aXNlLCBp
ZiDigJxzaXpl4oCdIGlzIG5vbi16ZXJvLCB0aGVuIGlvbW11X2lvdGxiX3N5bmMoKSB3b3VsZAo+
IGluaXRpYWxpemUgdGhlIHNpemUgYW5kIHJhbmdlIChzZWUgaW9tbXVfaW90bGJfZ2F0aGVyX2lu
aXQoKSksCj4gYW5kIHRoZSBpbnZhcmlhbnQgaXMga2VwdC4KPiAKPiBPdGhlcndpc2UsIOKAnHNp
emXigJ0gaXMgemVybywgYW5kIOKAnGdhdGhlcuKAnSBhbHJlYWR5IGhvbGRzIGEgcmFuZ2UsCj4g
c28gZ2F0aGVyLT5wZ3NpemUgaXMgbm9uLXplcm8gYW5kCj4gKGdhdGhlci0+cGdzaXplICYmIGdh
dGhlci0+cGdzaXplICE9IHNpemUpIGlzIHRydWUuIFRoZXJlZm9yZSwKPiBhZ2FpbiwgaW9tbXVf
aW90bGJfc3luYygpIHdvdWxkIGJlIGNhbGxlZCBhbmQgaW5pdGlhbGl6ZSB0aGUKPiBzaXplLgo+
IAo+IEkgdGhpbmsgdGhhdCB0aGlzIGNoYW5nZSBtYWtlcyB0aGUgY29kZSBtdWNoIHNpbXBsZXIg
dG8gcmVhZC4KPiBJdCBwcm9iYWJseSBoYXMgbm8gcGVyZm9ybWFuY2UgaW1wYWN0IGFzIOKAnGdh
dGhlcuKAnSBpcyBwcm9iYWJseQo+IGNhY2hlZCBhbmQgYW55aG93IGFjY2Vzc2VkIHNob3J0bHkg
YWZ0ZXIuCgpUaGFua3MuIEkgd2FzIGp1c3QgaW50ZXJlc3RlZCBpbiB3aGV0aGVyIGl0IGhhZCBh
IGZ1bmN0aW9uYWwgaW1wYWN0IChJIGRvbid0CnRoaW5rIGl0IGRvZXMpIG9yIHdoZXRoZXIgaXQg
d2FzIGp1c3QgY2xlYW51cC4KCldpdGggdGhlIHVwZGF0ZWQgY29tbWVudDoKCkFja2VkLWJ5OiBX
aWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPgoKV2lsbApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
