Return-Path: <SRS0=Gm0N=3S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C164EC2D0DB
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 17:27:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912562082E
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 17:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="knH7SXZ2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vURkPiIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912562082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6A14F87F8E;
	Wed, 29 Jan 2020 17:27:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UWlnCml3nO-8; Wed, 29 Jan 2020 17:27:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5940D87F3F;
	Wed, 29 Jan 2020 17:27:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D645C0881;
	Wed, 29 Jan 2020 17:27:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A84CC0171
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 17:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4327D85F49
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 17:27:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Fp5qCmxwidh for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jan 2020 17:27:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F009C85E40
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 17:27:41 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id BD78F21FA9;
 Wed, 29 Jan 2020 12:27:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Wed, 29 Jan 2020 12:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=A
 TygRAmR8d0jm0J6iRWxiOTnzUg+8li3NtuuF+gdI88=; b=knH7SXZ2Ky9/jgpjW
 qsSyPhtCAzEVMXmtvWjHXObc465bJai1kiB+E8W5Aq/QUk3uKBHAkUH3V4atBYND
 QjNnAHkFJwBPn/g4jMqMw+KP1wjJUM0JNowwrC9Mf7mhcJZAp8fuvEfoKKtUzTaO
 nLWlwPKeAXGmhnOXdZcg5WGG78+PuqlS+U/RNDJxBP7ziObaKUJSKUnafs2mOLyy
 RQIMgpqmWKzCiOn0fmxFNegTqBrJu1hspKKg1cqWu1E2KhDya79kZoxfxVyDPrHy
 gKEBuxVDhMRcrlkmkMTtTjCu3S0FRnfi5PUT4Qp16FMSUa3gIJpSaPDdgcAl6uz8
 mR6vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=ATygRAmR8d0jm0J6iRWxiOTnzUg+8li3NtuuF+gdI
 88=; b=vURkPiIP/F2udeKUc3p/VuDwL0RPeNtU5avUVS3mvad1nksQr/GMip53y
 AHwWpxG0tCRgwo3xTHdvEt9pedN5jcHVnki8lts9xU/INm5LeoLFdKYL2S/JrHgB
 KS53MvkfPe3K34+DfDbkEVIqW6qhUhzfxTZp6QmMyFPuMIWvkvzLWwkT5XnbHpUt
 Ngok+eOiIdSQJQyzF46DueYr0hk7hIjyUyF9o+IHHmsiJzWMU6Awiropclsaq9As
 LogLW3kVKjoMQvA2asNE4ui7xgd2u1hqSDSPvazBQbOAEc0WiSFwYCaXfS40+rOM
 nbCgCoU7hozntAaEXzgiW++vKY6lg==
X-ME-Sender: <xms:i8AxXmt5TzlnOWXJ3tqS7NdviWXw0A-TKshPlsjHp-ZG5iy1YM66ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeeigdellecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttdejnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
 drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:i8AxXtSiXAirVtD8MDZwBJYybRy1nsoaSa52025S95lxc9aqZpyzVg>
 <xmx:i8AxXg7qMNQ4XXZcaqFpRtbLs-NmSYejulSIHRXCiNG_EqE0xmkDEg>
 <xmx:i8AxXkjF3QcRjtQR_z11Zzb8RbOIVYgf2QTpfgmiOaIUIrZJOqaZxw>
 <xmx:jMAxXrkr3wysvoBaE8BuFczY-AdOI0V2oEG5VbsBPv9ZRTdhuwNnIA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8346E3280059;
 Wed, 29 Jan 2020 12:27:39 -0500 (EST)
Date: Wed, 29 Jan 2020 18:27:38 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h6: Add IOMMU
Message-ID: <20200129172738.c53f5du2byreze2n@gilmour.lan>
References: <cover.b2a9e1507135d81e726fcbb65137665a7f0ab74f.1579696927.git-series.maxime@cerno.tech>
 <5320339.DvuYhMxLoT@jernej-laptop>
 <20200127142339.crxsuunzec5drfe2@gilmour.lan>
 <2140600.ElGaqSPkdT@jernej-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2140600.ElGaqSPkdT@jernej-laptop>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Chen-Yu Tsai <wens@csie.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksCgpPbiBNb24sIEphbiAyNywgMjAyMCBhdCAwODowNDowMlBNICswMTAwLCBKZXJuZWogxaBr
cmFiZWMgd3JvdGU6Cj4gRG5lIHBvbmVkZWxqZWssIDI3LiBqYW51YXIgMjAyMCBvYiAxNToyMzoz
OSBDRVQgamUgTWF4aW1lIFJpcGFyZCBuYXBpc2FsKGEpOgo+ID4gSGkgSmVybmVqLAo+ID4KPiA+
IE9uIEZyaSwgSmFuIDI0LCAyMDIwIGF0IDA5OjU0OjIzUE0gKzAxMDAsIEplcm5laiDFoGtyYWJl
YyB3cm90ZToKPiA+ID4gRG5lIHNyZWRhLCAyMi4gamFudWFyIDIwMjAgb2IgMTM6NDQ6MDkgQ0VU
IGplIE1heGltZSBSaXBhcmQgbmFwaXNhbChhKToKPiA+ID4gPiBOb3cgdGhhdCB3ZSBoYXZlIGEg
ZHJpdmVyIGZvciB0aGUgSU9NTVUsIGxldCdzIHN0YXJ0IHVzaW5nIGl0Lgo+ID4gPiA+Cj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogTWF4aW1lIFJpcGFyZCA8bWF4aW1lQGNlcm5vLnRlY2g+Cj4gPiA+
ID4gLS0tCj4gPiA+ID4KPiA+ID4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3Vu
NTBpLWg2LmR0c2kgfCAxMSArKysrKysrKysrKwo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvYWxsd2lubmVyL3N1bjUwaS1oNi5kdHNpCj4gPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRzaSBpbmRleAo+ID4gPiA+IDI5ODI0MDgxYjQzYi4u
ODYwOGJjZjFjNTJjIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYWxs
d2lubmVyL3N1bjUwaS1oNi5kdHNpCj4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9h
bGx3aW5uZXIvc3VuNTBpLWg2LmR0c2kKPiA+ID4gPiBAQCAtNTMsNiArNTMsNyBAQAo+ID4gPiA+
Cj4gPiA+ID4gIAlkZTogZGlzcGxheS1lbmdpbmUgewo+ID4gPiA+Cj4gPiA+ID4gIAkJY29tcGF0
aWJsZSA9ICJhbGx3aW5uZXIsc3VuNTBpLWg2LWRpc3BsYXktZW5naW5lIjsKPiA+ID4gPiAgCQlh
bGx3aW5uZXIscGlwZWxpbmVzID0gPCZtaXhlcjA+Owo+ID4gPiA+Cj4gPiA+ID4gKwkJaW9tbXVz
ID0gPCZpb21tdSAwPjsKPiA+ID4gPgo+ID4gPiA+ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4g
PiA+ID4KPiA+ID4gPiAgCX07Cj4gPiA+Cj4gPiA+IElzbid0IGlvbW11IHByb3BlcnR5IG9mIHRo
ZSBtaXhlciBub2RlPyBBZnRlciBhbGwsIG1peGVyIGlzIHRoZSBvbmUgd2hpY2gKPiA+ID4gcmVh
ZHMgb25lIG9yIG1vcmUgZnJhbWVidWZmZXJzLiBPbmNlIHNlY29uZCBtaXhlciBpcyBkZWZpbmVk
LCB3b3VsZCB5b3UKPiA+ID4gcHV0Cj4gPiA+IGFub3RoZXIgaW9tbXUgcGhhbmRsZSBoZXJlPwo+
ID4KPiA+IFlvdSdyZSByaWdodC4gSSBhZGRlZCBpdCBkdXJpbmcgdGhlIGVhcmx5IGRldiwgYW5k
IGZvcmdvdCB0byByZW1vdmUKPiA+IGl0LiBUaGFua3MhCj4KPiBSZW1vdmUgaXQgb3IgbW92ZSBp
dD8gSSBndWVzcyBlbmFibGluZyBpb21tdSBzdXBwb3J0IGluIGVhY2ggZHJpdmVyIG5lZWRzIGEK
PiBiaXQgbW9yZSB3b3JrIHRoYW4ganVzdCByZWZlcmVuY2luZyBpb21tdSBub2RlLCByaWdodD8g
QXQgbGVhc3QgaW4gc3VjaCBjYXNlCj4gYnVmZmVycyBkb24ndCBuZWVkIHRvIGJlIGFsbG9jYXRl
ZCBieSBDTUEsIHdoaWNoIHN1bjRpLWRybSBkcml2ZXIgY3VycmVudGx5Cj4gdXNlLgo+Cj4gSSBq
dXN0IHRha2UgYW5vdGhlciBsb29rIGF0IEJTUCBrZXJuZWwgYW5kIGl0IHNlZW1zIHRoYXQgb25s
eSBvbmUgY2hhbm5lbCBpcwo+IHVzZWQgZm9yIHdob2xlIGRpc3BsYXkgc3RhY2suIFRoYXQgd291
bGQgbWVhbiB0aGF0IGJvdGggbWl4ZXJzIHdvdWxkIGhhdmUgc2FtZQo+IGlvbW11IHBoYW5kbGUs
IHJpZ2h0PyBDb25mdXNpbmdseSBlbm91Z2gsIERFMiBpb21tdSBjaGFubmVsIHNlZW1zIHRvIGJl
IGZvcgo+IGRlaW50ZXJsYWNlIGNvcmUuCgpUbyBhZGQgb24gUm9iaW4ncyBhbnN3ZXIsIHllYWgs
IGl0IGxvb2tzIGxpa2UgdGhlIGRpc3BsYXkgZW5naW5lIGlzCmNhbGxlZCBERSAoYW5kIEkndmUg
Y2hlY2tlZCB0aGF0IHRoaXMgaXMgaW5kZWVkIHRoZSBtYXN0ZXIgMCksIHdoaWxlCnRoZSBkZWlu
dGVybGFjZSBpcyBjYWxsZWQgREUyIChhbmQgcHJvYmFibHkgaXMgdGhlIG1hc3RlciAyKS4KCk1h
eGltZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
