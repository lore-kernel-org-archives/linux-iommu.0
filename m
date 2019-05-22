Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE1DC282CE
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 19:27:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBE0204FD
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA0cNliQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBE0204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1A529AF0;
	Wed, 22 May 2019 19:27:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E6CDF9EE
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 19:27:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 35B165D0
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 19:27:20 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
	[209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CDFC32173C
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553239;
	bh=hlAVIiOpRcQkmn1FUyVhG2T73UvpIg1zkjRYmBGZFbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mA0cNliQfDBj0+UVgJLx/wKtngqh8fH5E7uIoRuKRxD4mAU1ytjis2yftM+NGxqTi
	5KKM3Tc4PCAhULMdB3ddUJbi5MQhd6E9ISfzZFEcgsrmdlv/jhZJQCyCRqy2BklKTe
	bNhVsQaZMwPJXSLJWz+fxKwvcZeiKdUCucPiA1OQ=
Received: by mail-qt1-f182.google.com with SMTP id h1so3852989qtp.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 12:27:19 -0700 (PDT)
X-Gm-Message-State: APjAAAX24axeKUWF+kFEZyDTeKYYVSxN5M/6b8P3mFBNd96pdFaa+jyL
	SQ75iJnbXvpihrMt0NtmTa64IHyNQdo5XvlarA==
X-Google-Smtp-Source: APXvYqy+PeJM7o3ppEVTbfv/xeDCVQT0aKFYAppgCGRW5RshOFOrnfI1FkipG2N2RO8u2GCiHsgMEikYAzbvgjw3ptY=
X-Received: by 2002:ac8:7688:: with SMTP id g8mr48798907qtr.224.1558553239094; 
	Wed, 22 May 2019 12:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com>
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 22 May 2019 14:27:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
Message-ID: <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Steven Price <steven.price@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
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

T24gVHVlLCBNYXkgMjEsIDIwMTkgYXQgMTE6MTEgQU0gQ2zDqW1lbnQgUMOpcm9uIDxwZXJvbi5j
bGVtQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSwKPgo+IFRoZSBBbGx3aW5uZXIgSDYgaGFzIGEg
TWFsaS1UNzIwIE1QMiB3aGljaCBzaG91bGQgYmUgc3VwcG9ydGVkIGJ5Cj4gdGhlIG5ldyBwYW5m
cm9zdCBkcml2ZXIuIFRoaXMgc2VyaWVzIGZpeCB0d28gaXNzdWVzIGFuZCBpbnRyb2R1Y2UgdGhl
Cj4gZHQtYmluZGluZ3MgYnV0IGEgc2ltcGxlIGJlbmNobWFyayBzaG93IHRoYXQgaXQncyBzdGls
bCBOT1QgV09SS0lORy4KPgo+IEknbSBwdXNoaW5nIGl0IGluIGNhc2Ugc29tZW9uZSB3YW50IHRv
IGNvbnRpbnVlIHRoZSB3b3JrLgo+Cj4gVGhpcyBoYXMgYmVlbiB0ZXN0ZWQgd2l0aCBNZXNhM0Qg
MTkuMS4wLVJDMiBhbmQgYSBHUFUgYml0bmVzcyBwYXRjaFsxXS4KPgo+IE9uZSBwYXRjaCBpcyBm
cm9tIEljZW5vd3kgWmhlbmcgd2hlcmUgSSBjaGFuZ2VkIHRoZSBvcmRlciBhcyByZXF1aXJlZAo+
IGJ5IFJvYiBIZXJyaW5nWzJdLgo+Cj4gVGhhbmtzLAo+IENsZW1lbnQKPgo+IFsxXSBodHRwczov
L2dpdGxhYi5mcmVlZGVza3RvcC5vcmcva3N6YXEvbWVzYS90cmVlL3BhbmZyb3N0XzY0XzMyCj4g
WzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA2OTk4MjkvCj4KPgo+IFsg
IDM0NS4yMDQ4MTNdIHBhbmZyb3N0IDE4MDAwMDAuZ3B1OiBtbXUgaXJxIHN0YXR1cz0xCj4gWyAg
MzQ1LjIwOTYxN10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IFVuaGFuZGxlZCBQYWdlIGZhdWx0IGlu
IEFTMCBhdCBWQQo+IDB4MDAwMDAwMDAwMjQwMDQwMAo+IFsgIDM0NS4yMDk2MTddIFJlYXNvbjog
VE9ETwo+IFsgIDM0NS4yMDk2MTddIHJhdyBmYXVsdCBzdGF0dXM6IDB4ODAwMDAyQzEKPiBbICAz
NDUuMjA5NjE3XSBkZWNvZGVkIGZhdWx0IHN0YXR1czogU0xBVkUgRkFVTFQKPiBbICAzNDUuMjA5
NjE3XSBleGNlcHRpb24gdHlwZSAweEMxOiBUUkFOU0xBVElPTl9GQVVMVF9MRVZFTDEKPiBbICAz
NDUuMjA5NjE3XSBhY2Nlc3MgdHlwZSAweDI6IFJFQUQKPiBbICAzNDUuMjA5NjE3XSBzb3VyY2Ug
aWQgMHg4MDAwCj4gWyAgMzQ1LjcyOTk1N10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IGdwdSBzY2hl
ZCB0aW1lb3V0LCBqcz0wLAo+IHN0YXR1cz0weDgsIGhlYWQ9MHgyNDAwNDAwLCB0YWlsPTB4MjQw
MDQwMCwgc2NoZWRfam9iPTAwMDAwMDAwOWUyMDRkZTkKPiBbICAzNDYuMDU1ODc2XSBwYW5mcm9z
dCAxODAwMDAwLmdwdTogbW11IGlycSBzdGF0dXM9MQo+IFsgIDM0Ni4wNjA2ODBdIHBhbmZyb3N0
IDE4MDAwMDAuZ3B1OiBVbmhhbmRsZWQgUGFnZSBmYXVsdCBpbiBBUzAgYXQgVkEKPiAweDAwMDAw
MDAwMDJDMDBBMDAKPiBbICAzNDYuMDYwNjgwXSBSZWFzb246IFRPRE8KPiBbICAzNDYuMDYwNjgw
XSByYXcgZmF1bHQgc3RhdHVzOiAweDgxMDAwMkMxCj4gWyAgMzQ2LjA2MDY4MF0gZGVjb2RlZCBm
YXVsdCBzdGF0dXM6IFNMQVZFIEZBVUxUCj4gWyAgMzQ2LjA2MDY4MF0gZXhjZXB0aW9uIHR5cGUg
MHhDMTogVFJBTlNMQVRJT05fRkFVTFRfTEVWRUwxCj4gWyAgMzQ2LjA2MDY4MF0gYWNjZXNzIHR5
cGUgMHgyOiBSRUFECj4gWyAgMzQ2LjA2MDY4MF0gc291cmNlIGlkIDB4ODEwMAo+IFsgIDM0Ni41
NjE5NTVdIHBhbmZyb3N0IDE4MDAwMDAuZ3B1OiBncHUgc2NoZWQgdGltZW91dCwganM9MSwKPiBz
dGF0dXM9MHg4LCBoZWFkPTB4MmMwMGEwMCwgdGFpbD0weDJjMDBhMDAsIHNjaGVkX2pvYj0wMDAw
MDAwMGI1NWE5YTg1Cj4gWyAgMzQ2LjU3MzkxM10gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IG1tdSBp
cnEgc3RhdHVzPTEKPiBbICAzNDYuNTc4NzA3XSBwYW5mcm9zdCAxODAwMDAwLmdwdTogVW5oYW5k
bGVkIFBhZ2UgZmF1bHQgaW4gQVMwIGF0IFZBCj4gMHgwMDAwMDAwMDAyQzAwQjgwCj4KPiBDaGFu
Z2UgaW4gdjU6Cj4gIC0gUmVtb3ZlIGZpeCBpbmRlbnQKPgo+IENoYW5nZXMgaW4gdjQ6Cj4gIC0g
QWRkIGJ1c19jbG9jayBwcm9iZQo+ICAtIEZpeCBzYW5pdHkgY2hlY2sgaW4gaW8tcGd0YWJsZQo+
ICAtIEFkZCB2cmFtcC1kZWxheQo+ICAtIE1lcmdlIGFsbCBib2FyZHMgaW50byBvbmUgcGF0Y2gK
PiAgLSBSZW1vdmUgdXBzdHJlYW1lZCBOZWlsIEEuIHBhdGNoCj4KPiBDaGFuZ2UgaW4gdjMgKFRo
YW5rcyB0byBNYXhpbWUgUmlwYXJkKToKPiAgLSBSZWF1dGhvciBJY2Vub3d5IGZvciBoZXIgcGF0
aAo+Cj4gQ2hhbmdlcyBpbiB2MiAoVGhhbmtzIHRvIE1heGltZSBSaXBhcmQpOgo+ICAtIERyb3Ag
R1BVIE9QUCBUYWJsZQo+ICAtIEFkZCBjbG9ja3MgYW5kIGNsb2NrLW5hbWVzIGluIHJlcXVpcmVk
Cj4KPiBDbMOpbWVudCBQw6lyb24gKDUpOgo+ICAgZHJtOiBwYW5mcm9zdDogYWRkIG9wdGlvbmFs
IGJ1c19jbG9jawo+ICAgaW9tbXU6IGlvLXBndGFibGU6IGZpeCBzYW5pdHkgY2hlY2sgZm9yIG5v
biA0OC1iaXQgbWFsaSBpb21tdQo+ICAgZHQtYmluZGluZ3M6IGdwdTogbWFsaS1taWRnYXJkOiBB
ZGQgSDYgbWFsaSBncHUgY29tcGF0aWJsZQo+ICAgYXJtNjQ6IGR0czogYWxsd2lubmVyOiBBZGQg
QVJNIE1hbGkgR1BVIG5vZGUgZm9yIEg2Cj4gICBhcm02NDogZHRzOiBhbGx3aW5uZXI6IEFkZCBt
YWxpIEdQVSBzdXBwbHkgZm9yIEg2IGJvYXJkcwo+Cj4gSWNlbm93eSBaaGVuZyAoMSk6Cj4gICBk
dC1iaW5kaW5nczogZ3B1OiBhZGQgYnVzIGNsb2NrIGZvciBNYWxpIE1pZGdhcmQgR1BVcwoKSSd2
ZSBhcHBsaWVkIHBhdGNoZXMgMSBhbmQgMyB0byBkcm0tbWlzYy4gSSB3YXMgZ29pbmcgdG8gZG8g
cGF0Y2ggNAp0b28sIGJ1dCBpdCBkb2Vzbid0IGFwcGx5LgoKUGF0Y2ggMiBjYW4gZ28gaW4gdmlh
IHRoZSBpb21tdSB0cmVlIGFuZCB0aGUgcmVzdCB2aWEgdGhlIGFsbHdpbm5lciB0cmVlLgoKUm9i
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
