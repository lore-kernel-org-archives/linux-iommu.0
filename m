Return-Path: <SRS0=SXOE=XJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2208C49ED6
	for <iommu@archiver.kernel.org>; Sat, 14 Sep 2019 08:49:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3AC20717
	for <iommu@archiver.kernel.org>; Sat, 14 Sep 2019 08:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvC0HAkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3AC20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2D9C3AC7;
	Sat, 14 Sep 2019 08:49:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BAECD8DC
	for <iommu@lists.linux-foundation.org>;
	Sat, 14 Sep 2019 08:49:55 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 529192C6
	for <iommu@lists.linux-foundation.org>;
	Sat, 14 Sep 2019 08:49:55 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D371F214AF
	for <iommu@lists.linux-foundation.org>;
	Sat, 14 Sep 2019 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568450995;
	bh=J9o3/Ce1+YLaWOJS+1y9FmaoiXDLsFcat/B4OJD07xQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NvC0HAkbO+X0R/hUr5ElgQAkn9X+DlHgQCaI+WUT3QaLpkyww7ouKYCiu+gLQdPnN
	Zt2iNLvAcaA/7M7mBWG5GC72IVnUlLTjmJnBCwL8Gs+y4/DomRNvqSFSk4OlGnDjoe
	Dtl/nAegdQl/qfiWPrj/maTEs4oYOJwLv1kg+bio=
Received: by mail-wr1-f48.google.com with SMTP id o18so2980125wrv.13
	for <iommu@lists.linux-foundation.org>;
	Sat, 14 Sep 2019 01:49:54 -0700 (PDT)
X-Gm-Message-State: APjAAAV+kRmE0FCxmO5p1S5mcKSp+vaXcda0tczn11nL+hEKShI/STQO
	Mvuk09PyxbAm7hwwX89QwXRZP1Zp9a39GePelao=
X-Google-Smtp-Source: APXvYqxg6MtzWsHNFmLRbH0IHgwRMp+vQZNFO479wjLXexAnH2ZbcUXa06WI/GBB3zidLYAHo44uDXvnrwuUeLiSDAI=
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr5204507wrr.343.1568450992705; 
	Sat, 14 Sep 2019 01:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-12-julien.grall@arm.com>
	<0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
	<CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
	<c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
	<20190619091219.GB7767@fuggles.cambridge.arm.com>
	<CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
	<20190619123939.GF7767@fuggles.cambridge.arm.com>
	<CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
	<20190624104006.lvm32nahemaqklxc@willie-the-truck>
	<CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
	<20190912140256.fwbutgmadpjbjnab@willie-the-truck>
	<CAJF2gTT2c45HRfATF+=zs-HNToFAKgq1inKRmJMV3uPYBo4iVg@mail.gmail.com>
	<CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
In-Reply-To: <CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 14 Sep 2019 16:49:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTKFwRN6vG3+fQK8BRFskeURjv-Ziv_qb7nc9MSKw0bLA@mail.gmail.com>
Message-ID: <CAJF2gTTKFwRN6vG3+fQK8BRFskeURjv-Ziv_qb7nc9MSKw0bLA@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
	separate file
To: Will Deacon <will@kernel.org>
Cc: julien.thierry@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Will Deacon <will.deacon@arm.com>, christoffer.dall@arm.com,
	Atish Patra <Atish.Patra@wdc.com>,
	Julien Grall <julien.grall@arm.com>, gary@garyguo.net,
	linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
	Mike Rapoport <rppt@linux.ibm.com>, aou@eecs.berkeley.edu,
	Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
	Marc Zyngier <marc.zyngier@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-arm-kernel@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, james.morse@arm.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGVyZSBpcyB0aGUgcHJlc2VudGF0aW9uLCBhbnkgY29tbWVudHMgaXMgd2VsY29tZS4KCmh0dHBz
Oi8vZG9jcy5nb29nbGUuY29tL3ByZXNlbnRhdGlvbi9kLzFzYzI5NUp6blZBZkRJUGllQXF6amN5
VWtjSG5ORlFzSzhGRnFkb0NZODU0L2VkaXQ/dXNwPXNoYXJpbmcKCk9uIEZyaSwgU2VwIDEzLCAy
MDE5IGF0IDM6MTMgUE0gR3VvIFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gQW5v
dGhlciBpZGVhIGlzIHNlcGVyYXRlIHJlbW90ZSBUTEIgaW52YWxpZGF0ZSBpbnRvIHR3byBpbnN0
cnVjdGlvbnM6Cj4KPiAgLSBzZmVuY2Uudm1hLmIuYXN5Ywo+ICAtIHNmZW5jZS52bWEuYi5iYXJy
aWVyIC8vIHdhaXQgYWxsIGFzeW5jIFRMQiBpbnZhbGlkYXRlIG9wZXJhdGlvbnMgZmluaXNoZWQg
Zm9yIGFsbCBoYXJ0cy4KPgo+IChJIHJlbWVtYmVyIHdobyBtZW50aW9uZWQgbWUgc2VwYXJhdGUg
dGhlbSBpbnRvIHR3byBpbnN0cnVjdGlvbnMgYWZ0ZXIgc2Vzc2lvbi4gQW51cD8gSXMgdGhlIGlk
ZWEgcmlnaHQgPykKPgo+IEFjdHVhbGx5LCBJIG5ldmVyIGNvbnNpZGVyIGFzeWMgVExCIGludmFs
aWRhdGUgYmVmb3JlLCBiZWNhdXNlIGN1cnJlbnQgb3VyIGxpZ2h0IGlvbW11IGRpZCBub3QgbmVl
ZCBpdC4KPgo+IFRoeCBhbGwgcGVvcGxlIGF0dGVuZCB0aGUgc2Vzc2lvbiA6KSBMZXQncyBjb250
aW51ZSB0aGUgdGFsay4KPgo+Cj4gR3VvIFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+IOS6jiAyMDE5
5bm0OeaciDEy5pel5ZGo5ZubIDIyOjU55YaZ6YGT77yaCj4+Cj4+IFRoeCBXaWxsIGZvciByZXBs
eS4KPj4KPj4gT24gVGh1LCBTZXAgMTIsIDIwMTkgYXQgMzowMyBQTSBXaWxsIERlYWNvbiA8d2ls
bEBrZXJuZWwub3JnPiB3cm90ZToKPj4gPgo+PiA+IE9uIFN1biwgU2VwIDA4LCAyMDE5IGF0IDA3
OjUyOjU1QU0gKzA4MDAsIEd1byBSZW4gd3JvdGU6Cj4+ID4gPiBPbiBNb24sIEp1biAyNCwgMjAx
OSBhdCA2OjQwIFBNIFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+IHdyb3RlOgo+PiA+ID4g
PiA+IEknbGwga2VlcCBteSBzeXN0ZW0gdXNlIHRoZSBzYW1lIEFTSUQgZm9yIFNNUCArIElPTU1V
IDpQCj4+ID4gPiA+Cj4+ID4gPiA+IFlvdSB3aWxsIHdhbnQgYSBzZXBhcmF0ZSBhbGxvY2F0b3Ig
Zm9yIHRoYXQ6Cj4+ID4gPiA+Cj4+ID4gPiA+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAx
OTA2MTAxODQ3MTQuNjc4Ni0yLWplYW4tcGhpbGlwcGUuYnJ1Y2tlckBhcm0uY29tCj4+ID4gPgo+
PiA+ID4gWWVzLCBpdCBpcyBoYXJkIHRvIG1haW50YWluIEFTSUQgYmV0d2VlbiBJT01NVSBhbmQg
Q1BVTU1VIG9yIGRpZmZlcmVudAo+PiA+ID4gc3lzdGVtLCBiZWNhdXNlIGl0J3MgZGlmZmljdWx0
IHRvIHN5bmNocm9uaXplIHRoZSBJT19BU0lEIHdoZW4gdGhlIENQVQo+PiA+ID4gQVNJRCBpcyBy
b2xsb3Zlci4KPj4gPiA+IEJ1dCB3ZSBjb3VsZCBzdGlsbCB1c2UgaGFyZHdhcmUgYnJvYWRjYXN0
IFRMQiBpbnZhbGlkYXRpb24gaW5zdHJ1Y3Rpb24KPj4gPiA+IHRvIHVuaWZvcm1seSBtYW5hZ2Ug
dGhlIEFTSUQgYW5kIElPX0FTSUQsIG9yIE9USEVSX0FTSUQgaW4gb3VyIElPTU1VLgo+PiA+Cj4+
ID4gVGhhdCdzIHByb2JhYmx5IGEgYmFkIGlkZWEsIGJlY2F1c2UgeW91J2xsIGxpa2VseSBzdGFs
bCBleGVjdXRpb24gb24gdGhlCj4+ID4gQ1BVIHVudGlsIHRoZSBJT1RMQiBoYXMgY29tcGxldGVk
IGludmFsaWRhdGlvbi4gSW4gdGhlIGNhc2Ugb2YgQVRTLCBJIHRoaW5rCj4+ID4gYW4gZW5kcG9p
bnQgQVRDIGlzIHBlcm1pdHRlZCB0byB0YWtlIG92ZXIgYSBtaW51dGUgdG8gcmVzcG9uZC4gSW4g
cmVhbGl0eSwgSQo+PiA+IHN1c3BlY3QgdGhlIHdvcnN0IHlvdSdsbCBldmVyIHNlZSB3b3VsZCBi
ZSBpbiB0aGUgbXNlYyByYW5nZSwgYnV0IHRoYXQncwo+PiA+IHN0aWxsIGFuIHVuYWNjZXB0YWJs
ZSBwZXJpb2Qgb2YgdGltZSB0byBob2xkIGEgQ1BVLgo+PiBKdXN0IGFzIEkndmUgc2FpZCBpbiB0
aGUgc2Vzc2lvbiB0aGF0IElPVExCIGludmFsaWRhdGUgZGVsYXkgaXMKPj4gYW5vdGhlciB0b3Bp
YywgTXkgbWFpbiBwcm9wb3NhbCBpcyB0byBpbnRyb2R1Y2Ugc3RhZ2UxLnBnZCBhbmQKPj4gc3Rh
Z2UyLnBnZCBhcyBhZGRyZXNzIHNwYWNlIGlkZW50aWZpZXJzIGJldHdlZW4gZGlmZmVyZW50IFRM
QiBzeXN0ZW1zCj4+IGJhc2VkIG9uIHZtaWQsIGFzaWQuIE15IGxhc3QgcGFydCBvZiBzaWxkZXMg
d2lsbCBzaG93IHlvdSBob3cgdG8KPj4gdHJhbnNsYXRlIHN0YWdlMS8yLnBnZCB0byBhcy92bWlk
IGluIFBDSSBBVFMgc3lzdGVtIGFuZCB0aGUgbWV0aG9kCj4+IGNvdWxkIHdvcmsgd2l0aCBTTU1V
LXYzIGFuZCBpbnRlbCBWdC1kLiAoSXQncyByZWdyZXQgZm9yIG1lIHRoZXJlIGlzCj4+IG5vIHRp
bWUgdG8gc2hvdyB5b3UgdGhlIHdob2xlIHNsaWRlcy4pCj4+Cj4+IEluIG91ciBsaWdodCBJT01N
VSBpbXBsZW1lbnRhdGlvbiwgdGhlcmUncyBubyBJT1RMQiBpbnZhbGlkYXRlIGRlbGF5Cj4+IHBy
b2JsZW0uIEJlY2FzdWUgSU9NTVUgaXMgdmVyeSBjbG9zZSB0byBDUFUgTU1VIGFuZCBpbnRlcmNv
bm5lY3Qncwo+PiBkZWxheSBpcyB0aGUgc2FtZSB3aXRoIFNNUCBDUFVzIE1NVSAobm8gUENJLCBW
TSBzdXBwb3J0ZWQpLgo+Pgo+PiBUbyBzb2x2ZSB0aGUgcHJvYmxlbSwgd2UgY291bGQgZGVmaW5l
IGEgYXN5bmMgbW9kZSBpbiBzZmVuY2Uudm1hLmIgdG8KPj4gc2xvdmUgdGhlIHByb2JsZW0gYW5k
IGZpbmlzaGVkIHdpdGggcGVyX2NwdV9pcnEvZXhjZXB0aW9uLgo+Pgo+PiAtLQo+PiBCZXN0IFJl
Z2FyZHMKPj4gIEd1byBSZW4KPj4KPj4gTUw6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWNza3kvCgoKCi0tIApCZXN0IFJlZ2FyZHMKIEd1byBSZW4KCk1MOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1jc2t5LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
