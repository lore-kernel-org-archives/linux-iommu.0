Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E8C04AB5
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 17:28:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45CE242DD
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 17:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAN+/Qb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45CE242DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 86DE3CD1;
	Mon,  3 Jun 2019 17:28:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CF80D265
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 17:28:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com
	[209.85.219.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 06B2486E
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 17:28:03 +0000 (UTC)
Received: by mail-yb1-f196.google.com with SMTP id l66so6872726ybf.4
	for <iommu@lists.linux-foundation.org>;
	Mon, 03 Jun 2019 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=/CnmclOqeFitdxQUE9bLrTl+THj0klsLpLvs2FULiUc=;
	b=SAN+/Qb9AVqYn57ZhyRBvnABldr92BWgtJKUyDxZUVDegfg6Hg/wW2NTGAgFOnyE63
	dBdT9OM2aaDM6qQbtrdiPqk5pTS3O2IHLuGjFcdRja7a7i0/c34FEWldCJTns/IJpvML
	LM23y4Y5Aq2EIIUcvbR+MqqHW/tZb2ggEG5WnbMne3zHqowjYDxINP5TEoXckHWZzHwa
	JpOWMO78/dyuTFrkYsvQNXInVy8WqA6UHCjTZOT8K68WVsNdiGHozgliJY4ZTHfHdMni
	eq8JyMQ5/LtpsQeMS5Kn6VTelTQadx7VXG9B3JGK4unIGTZaycj9jjsTvfUEz89TGvAa
	2ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=/CnmclOqeFitdxQUE9bLrTl+THj0klsLpLvs2FULiUc=;
	b=WbiaMACdsI6Yao526J+p7camIDLPIfnZezs0/kf0X+oDADm4T5FHjNjYL5nB7LHcSN
	mVzEXnPf00p0KGcEe1Vacxk4SGLvbJmY0k8BPudolreWO73RZH7AktQJB7rbAiAT4LtG
	08L0poDpJdtnA6cokuNPn/4PUvd2BMZ64QqtrK/1ko1lKBXi6Z312oYQKn8KGK/kBYgp
	odiButCnACZwLvSDZGa0UKZcYGF3lDM+uxk6QyS3/Ud9pPDr8fNMsLixdlVwLqcd35gF
	oUwS3Zuoily0J1zCY2QKvPEg349xLN/NUCw8wWG6+F7EJD+aPnJeNj2NBmyFkHTLVe0y
	U02w==
X-Gm-Message-State: APjAAAXxDVTjlIboywlPopLvU2KQTjsWIzKyXEEd3l9vWjRlLRmCkD3O
	Cr1Jmmf1HTpVxjL4aK39j1uThID61F90CcC96g4=
X-Google-Smtp-Source: APXvYqwv36MV1EgjPM95jwDVnT/xOnPPHBe6w8IiRRT+qX6s8O/bgXKCVn5NKbfL9AQHj/f+E9bKbWM0yveHM2T4UZ4=
X-Received: by 2002:a25:ca8d:: with SMTP id a135mr9276509ybg.438.1559582882942;
	Mon, 03 Jun 2019 10:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com>
	<CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Mon, 3 Jun 2019 19:27:51 +0200
Message-ID: <CAJiuCcchRZZ-Wwy3_fo_aq=GuCaCW8RHS8nBtB2br4n5Qtu-MA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To: Maxime Ripard <maxime.ripard@bootlin.com>, Joerg Roedel <joro@8bytes.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	devicetree <devicetree@vger.kernel.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Steven Price <steven.price@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgTWF4aW1lLCBKb2VyZywKCk9uIFdlZCwgMjIgTWF5IDIwMTkgYXQgMjE6MjcsIFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gVHVlLCBNYXkgMjEsIDIwMTkg
YXQgMTE6MTEgQU0gQ2zDqW1lbnQgUMOpcm9uIDxwZXJvbi5jbGVtQGdtYWlsLmNvbT4gd3JvdGU6
Cj4gPgo+ID4gSGksCj4gPgo+ID4gVGhlIEFsbHdpbm5lciBINiBoYXMgYSBNYWxpLVQ3MjAgTVAy
IHdoaWNoIHNob3VsZCBiZSBzdXBwb3J0ZWQgYnkKPiA+IHRoZSBuZXcgcGFuZnJvc3QgZHJpdmVy
LiBUaGlzIHNlcmllcyBmaXggdHdvIGlzc3VlcyBhbmQgaW50cm9kdWNlIHRoZQo+ID4gZHQtYmlu
ZGluZ3MgYnV0IGEgc2ltcGxlIGJlbmNobWFyayBzaG93IHRoYXQgaXQncyBzdGlsbCBOT1QgV09S
S0lORy4KPiA+Cj4gPiBJJ20gcHVzaGluZyBpdCBpbiBjYXNlIHNvbWVvbmUgd2FudCB0byBjb250
aW51ZSB0aGUgd29yay4KPiA+Cj4gPiBUaGlzIGhhcyBiZWVuIHRlc3RlZCB3aXRoIE1lc2EzRCAx
OS4xLjAtUkMyIGFuZCBhIEdQVSBiaXRuZXNzIHBhdGNoWzFdLgo+ID4KPiA+IE9uZSBwYXRjaCBp
cyBmcm9tIEljZW5vd3kgWmhlbmcgd2hlcmUgSSBjaGFuZ2VkIHRoZSBvcmRlciBhcyByZXF1aXJl
ZAo+ID4gYnkgUm9iIEhlcnJpbmdbMl0uCj4gPgo+ID4gVGhhbmtzLAo+ID4gQ2xlbWVudAo+ID4K
PiA+IFsxXSBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcva3N6YXEvbWVzYS90cmVlL3Bh
bmZyb3N0XzY0XzMyCj4gPiBbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MDY5OTgyOS8KPiA+Cj4gPgo+ID4gWyAgMzQ1LjIwNDgxM10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6
IG1tdSBpcnEgc3RhdHVzPTEKPiA+IFsgIDM0NS4yMDk2MTddIHBhbmZyb3N0IDE4MDAwMDAuZ3B1
OiBVbmhhbmRsZWQgUGFnZSBmYXVsdCBpbiBBUzAgYXQgVkEKPiA+IDB4MDAwMDAwMDAwMjQwMDQw
MAo+ID4gWyAgMzQ1LjIwOTYxN10gUmVhc29uOiBUT0RPCj4gPiBbICAzNDUuMjA5NjE3XSByYXcg
ZmF1bHQgc3RhdHVzOiAweDgwMDAwMkMxCj4gPiBbICAzNDUuMjA5NjE3XSBkZWNvZGVkIGZhdWx0
IHN0YXR1czogU0xBVkUgRkFVTFQKPiA+IFsgIDM0NS4yMDk2MTddIGV4Y2VwdGlvbiB0eXBlIDB4
QzE6IFRSQU5TTEFUSU9OX0ZBVUxUX0xFVkVMMQo+ID4gWyAgMzQ1LjIwOTYxN10gYWNjZXNzIHR5
cGUgMHgyOiBSRUFECj4gPiBbICAzNDUuMjA5NjE3XSBzb3VyY2UgaWQgMHg4MDAwCj4gPiBbICAz
NDUuNzI5OTU3XSBwYW5mcm9zdCAxODAwMDAwLmdwdTogZ3B1IHNjaGVkIHRpbWVvdXQsIGpzPTAs
Cj4gPiBzdGF0dXM9MHg4LCBoZWFkPTB4MjQwMDQwMCwgdGFpbD0weDI0MDA0MDAsIHNjaGVkX2pv
Yj0wMDAwMDAwMDllMjA0ZGU5Cj4gPiBbICAzNDYuMDU1ODc2XSBwYW5mcm9zdCAxODAwMDAwLmdw
dTogbW11IGlycSBzdGF0dXM9MQo+ID4gWyAgMzQ2LjA2MDY4MF0gcGFuZnJvc3QgMTgwMDAwMC5n
cHU6IFVuaGFuZGxlZCBQYWdlIGZhdWx0IGluIEFTMCBhdCBWQQo+ID4gMHgwMDAwMDAwMDAyQzAw
QTAwCj4gPiBbICAzNDYuMDYwNjgwXSBSZWFzb246IFRPRE8KPiA+IFsgIDM0Ni4wNjA2ODBdIHJh
dyBmYXVsdCBzdGF0dXM6IDB4ODEwMDAyQzEKPiA+IFsgIDM0Ni4wNjA2ODBdIGRlY29kZWQgZmF1
bHQgc3RhdHVzOiBTTEFWRSBGQVVMVAo+ID4gWyAgMzQ2LjA2MDY4MF0gZXhjZXB0aW9uIHR5cGUg
MHhDMTogVFJBTlNMQVRJT05fRkFVTFRfTEVWRUwxCj4gPiBbICAzNDYuMDYwNjgwXSBhY2Nlc3Mg
dHlwZSAweDI6IFJFQUQKPiA+IFsgIDM0Ni4wNjA2ODBdIHNvdXJjZSBpZCAweDgxMDAKPiA+IFsg
IDM0Ni41NjE5NTVdIHBhbmZyb3N0IDE4MDAwMDAuZ3B1OiBncHUgc2NoZWQgdGltZW91dCwganM9
MSwKPiA+IHN0YXR1cz0weDgsIGhlYWQ9MHgyYzAwYTAwLCB0YWlsPTB4MmMwMGEwMCwgc2NoZWRf
am9iPTAwMDAwMDAwYjU1YTlhODUKPiA+IFsgIDM0Ni41NzM5MTNdIHBhbmZyb3N0IDE4MDAwMDAu
Z3B1OiBtbXUgaXJxIHN0YXR1cz0xCj4gPiBbICAzNDYuNTc4NzA3XSBwYW5mcm9zdCAxODAwMDAw
LmdwdTogVW5oYW5kbGVkIFBhZ2UgZmF1bHQgaW4gQVMwIGF0IFZBCj4gPiAweDAwMDAwMDAwMDJD
MDBCODAKPiA+Cj4gPiBDaGFuZ2UgaW4gdjU6Cj4gPiAgLSBSZW1vdmUgZml4IGluZGVudAo+ID4K
PiA+IENoYW5nZXMgaW4gdjQ6Cj4gPiAgLSBBZGQgYnVzX2Nsb2NrIHByb2JlCj4gPiAgLSBGaXgg
c2FuaXR5IGNoZWNrIGluIGlvLXBndGFibGUKPiA+ICAtIEFkZCB2cmFtcC1kZWxheQo+ID4gIC0g
TWVyZ2UgYWxsIGJvYXJkcyBpbnRvIG9uZSBwYXRjaAo+ID4gIC0gUmVtb3ZlIHVwc3RyZWFtZWQg
TmVpbCBBLiBwYXRjaAo+ID4KPiA+IENoYW5nZSBpbiB2MyAoVGhhbmtzIHRvIE1heGltZSBSaXBh
cmQpOgo+ID4gIC0gUmVhdXRob3IgSWNlbm93eSBmb3IgaGVyIHBhdGgKPiA+Cj4gPiBDaGFuZ2Vz
IGluIHYyIChUaGFua3MgdG8gTWF4aW1lIFJpcGFyZCk6Cj4gPiAgLSBEcm9wIEdQVSBPUFAgVGFi
bGUKPiA+ICAtIEFkZCBjbG9ja3MgYW5kIGNsb2NrLW5hbWVzIGluIHJlcXVpcmVkCj4gPgo+ID4g
Q2zDqW1lbnQgUMOpcm9uICg1KToKPiA+ICAgZHJtOiBwYW5mcm9zdDogYWRkIG9wdGlvbmFsIGJ1
c19jbG9jawo+ID4gICBpb21tdTogaW8tcGd0YWJsZTogZml4IHNhbml0eSBjaGVjayBmb3Igbm9u
IDQ4LWJpdCBtYWxpIGlvbW11Cj4gPiAgIGR0LWJpbmRpbmdzOiBncHU6IG1hbGktbWlkZ2FyZDog
QWRkIEg2IG1hbGkgZ3B1IGNvbXBhdGlibGUKPiA+ICAgYXJtNjQ6IGR0czogYWxsd2lubmVyOiBB
ZGQgQVJNIE1hbGkgR1BVIG5vZGUgZm9yIEg2Cj4gPiAgIGFybTY0OiBkdHM6IGFsbHdpbm5lcjog
QWRkIG1hbGkgR1BVIHN1cHBseSBmb3IgSDYgYm9hcmRzCj4gPgo+ID4gSWNlbm93eSBaaGVuZyAo
MSk6Cj4gPiAgIGR0LWJpbmRpbmdzOiBncHU6IGFkZCBidXMgY2xvY2sgZm9yIE1hbGkgTWlkZ2Fy
ZCBHUFVzCj4KPiBJJ3ZlIGFwcGxpZWQgcGF0Y2hlcyAxIGFuZCAzIHRvIGRybS1taXNjLiBJIHdh
cyBnb2luZyB0byBkbyBwYXRjaCA0Cj4gdG9vLCBidXQgaXQgZG9lc24ndCBhcHBseS4KPgo+IFBh
dGNoIDIgY2FuIGdvIGluIHZpYSB0aGUgaW9tbXUgdHJlZSBhbmQgdGhlIHJlc3QgdmlhIHRoZSBh
bGx3aW5uZXIgdHJlZS4KCklzIHRoaXMgT0sgZm9yIHlvdSB0byBwaWNrIHVwIHRoaXMgc2VyaWVz
PwoKVGhhbmtzLApDbMOpbWVudAoKPgo+IFJvYgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
