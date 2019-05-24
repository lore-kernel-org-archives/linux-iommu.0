Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C8BC46460
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 17:25:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB4321773
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 17:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB4321773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D024E27;
	Fri, 24 May 2019 17:25:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 516CADB7
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 17:25:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CE7FE898
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 17:25:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D0AE80D;
	Fri, 24 May 2019 10:25:34 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB1173F703;
	Fri, 24 May 2019 10:25:31 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>, Will Deacon
	<will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <61088426-43cd-338b-ca77-50c00fcb7c5e@arm.com>
Date: Fri, 24 May 2019 18:25:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
Content-Language: en-GB
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMjEvMDUvMjAxOSAxNzoxMCwgQ2zDqW1lbnQgUMOpcm9uIHdyb3RlOgo+IEhpLAo+IAo+IFRo
ZSBBbGx3aW5uZXIgSDYgaGFzIGEgTWFsaS1UNzIwIE1QMiB3aGljaCBzaG91bGQgYmUgc3VwcG9y
dGVkIGJ5Cj4gdGhlIG5ldyBwYW5mcm9zdCBkcml2ZXIuIFRoaXMgc2VyaWVzIGZpeCB0d28gaXNz
dWVzIGFuZCBpbnRyb2R1Y2UgdGhlCj4gZHQtYmluZGluZ3MgYnV0IGEgc2ltcGxlIGJlbmNobWFy
ayBzaG93IHRoYXQgaXQncyBzdGlsbCBOT1QgV09SS0lORy4KPiAKPiBJJ20gcHVzaGluZyBpdCBp
biBjYXNlIHNvbWVvbmUgd2FudCB0byBjb250aW51ZSB0aGUgd29yay4KPiAKPiBUaGlzIGhhcyBi
ZWVuIHRlc3RlZCB3aXRoIE1lc2EzRCAxOS4xLjAtUkMyIGFuZCBhIEdQVSBiaXRuZXNzIHBhdGNo
WzFdLgo+IAo+IE9uZSBwYXRjaCBpcyBmcm9tIEljZW5vd3kgWmhlbmcgd2hlcmUgSSBjaGFuZ2Vk
IHRoZSBvcmRlciBhcyByZXF1aXJlZAo+IGJ5IFJvYiBIZXJyaW5nWzJdLgo+IAo+IFRoYW5rcywK
PiBDbGVtZW50Cj4gCj4gWzFdIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9rc3phcS9t
ZXNhL3RyZWUvcGFuZnJvc3RfNjRfMzIKPiBbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wYXRjaC8xMDY5OTgyOS8KPiAKPiAKPiBbICAzNDUuMjA0ODEzXSBwYW5mcm9zdCAxODAwMDAw
LmdwdTogbW11IGlycSBzdGF0dXM9MQo+IFsgIDM0NS4yMDk2MTddIHBhbmZyb3N0IDE4MDAwMDAu
Z3B1OiBVbmhhbmRsZWQgUGFnZSBmYXVsdCBpbiBBUzAgYXQgVkEKPiAweDAwMDAwMDAwMDI0MDA0
MDAKPiBbICAzNDUuMjA5NjE3XSBSZWFzb246IFRPRE8KPiBbICAzNDUuMjA5NjE3XSByYXcgZmF1
bHQgc3RhdHVzOiAweDgwMDAwMkMxCj4gWyAgMzQ1LjIwOTYxN10gZGVjb2RlZCBmYXVsdCBzdGF0
dXM6IFNMQVZFIEZBVUxUCj4gWyAgMzQ1LjIwOTYxN10gZXhjZXB0aW9uIHR5cGUgMHhDMTogVFJB
TlNMQVRJT05fRkFVTFRfTEVWRUwxCj4gWyAgMzQ1LjIwOTYxN10gYWNjZXNzIHR5cGUgMHgyOiBS
RUFECj4gWyAgMzQ1LjIwOTYxN10gc291cmNlIGlkIDB4ODAwMAo+IFsgIDM0NS43Mjk5NTddIHBh
bmZyb3N0IDE4MDAwMDAuZ3B1OiBncHUgc2NoZWQgdGltZW91dCwganM9MCwKPiBzdGF0dXM9MHg4
LCBoZWFkPTB4MjQwMDQwMCwgdGFpbD0weDI0MDA0MDAsIHNjaGVkX2pvYj0wMDAwMDAwMDllMjA0
ZGU5Cj4gWyAgMzQ2LjA1NTg3Nl0gcGFuZnJvc3QgMTgwMDAwMC5ncHU6IG1tdSBpcnEgc3RhdHVz
PTEKPiBbICAzNDYuMDYwNjgwXSBwYW5mcm9zdCAxODAwMDAwLmdwdTogVW5oYW5kbGVkIFBhZ2Ug
ZmF1bHQgaW4gQVMwIGF0IFZBCj4gMHgwMDAwMDAwMDAyQzAwQTAwCj4gWyAgMzQ2LjA2MDY4MF0g
UmVhc29uOiBUT0RPCj4gWyAgMzQ2LjA2MDY4MF0gcmF3IGZhdWx0IHN0YXR1czogMHg4MTAwMDJD
MQo+IFsgIDM0Ni4wNjA2ODBdIGRlY29kZWQgZmF1bHQgc3RhdHVzOiBTTEFWRSBGQVVMVAo+IFsg
IDM0Ni4wNjA2ODBdIGV4Y2VwdGlvbiB0eXBlIDB4QzE6IFRSQU5TTEFUSU9OX0ZBVUxUX0xFVkVM
MQo+IFsgIDM0Ni4wNjA2ODBdIGFjY2VzcyB0eXBlIDB4MjogUkVBRAo+IFsgIDM0Ni4wNjA2ODBd
IHNvdXJjZSBpZCAweDgxMDAKPiBbICAzNDYuNTYxOTU1XSBwYW5mcm9zdCAxODAwMDAwLmdwdTog
Z3B1IHNjaGVkIHRpbWVvdXQsIGpzPTEsCj4gc3RhdHVzPTB4OCwgaGVhZD0weDJjMDBhMDAsIHRh
aWw9MHgyYzAwYTAwLCBzY2hlZF9qb2I9MDAwMDAwMDBiNTVhOWE4NQo+IFsgIDM0Ni41NzM5MTNd
IHBhbmZyb3N0IDE4MDAwMDAuZ3B1OiBtbXUgaXJxIHN0YXR1cz0xCj4gWyAgMzQ2LjU3ODcwN10g
cGFuZnJvc3QgMTgwMDAwMC5ncHU6IFVuaGFuZGxlZCBQYWdlIGZhdWx0IGluIEFTMCBhdCBWQQo+
IDB4MDAwMDAwMDAwMkMwMEI4MAoKRldJVyBJIHNlZW0gdG8gaGF2ZSByZXByb2R1Y2VkIHRoZSBz
YW1lIGJlaGF2aW91ciBvbiBhIGRpZmZlcmVudCBUNzIwIApzZXR1cCwgc28gdGhpcyBtYXkgd2Vs
bCBiZSBtb3JlIGFib3V0IHRoZSBHUFUgdGhhbiB0aGUgcGxhdGZvcm0uIFRoZXJlIApkb2Vzbid0
IGxvb2sgdG8gYmUgYW55dGhpbmcgb2J2aW91c2x5IHdyb25nIHdpdGggdGhlIHBhZ2V0YWJsZXMs
IGJ1dCBpZiAKSSBjYW4gZmluZCBzb21lIG1vcmUgZnJlZSB0aW1lIEkgbWF5IGhhdmUgYSBiaXQg
bW9yZSBvZiBhIHBva2UgYXJvdW5kLgoKUm9iaW4uCgo+IAo+IENoYW5nZSBpbiB2NToKPiAgIC0g
UmVtb3ZlIGZpeCBpbmRlbnQKPiAKPiBDaGFuZ2VzIGluIHY0Ogo+ICAgLSBBZGQgYnVzX2Nsb2Nr
IHByb2JlCj4gICAtIEZpeCBzYW5pdHkgY2hlY2sgaW4gaW8tcGd0YWJsZQo+ICAgLSBBZGQgdnJh
bXAtZGVsYXkKPiAgIC0gTWVyZ2UgYWxsIGJvYXJkcyBpbnRvIG9uZSBwYXRjaAo+ICAgLSBSZW1v
dmUgdXBzdHJlYW1lZCBOZWlsIEEuIHBhdGNoCj4gCj4gQ2hhbmdlIGluIHYzIChUaGFua3MgdG8g
TWF4aW1lIFJpcGFyZCk6Cj4gICAtIFJlYXV0aG9yIEljZW5vd3kgZm9yIGhlciBwYXRoCj4gCj4g
Q2hhbmdlcyBpbiB2MiAoVGhhbmtzIHRvIE1heGltZSBSaXBhcmQpOgo+ICAgLSBEcm9wIEdQVSBP
UFAgVGFibGUKPiAgIC0gQWRkIGNsb2NrcyBhbmQgY2xvY2stbmFtZXMgaW4gcmVxdWlyZWQKPiAK
PiBDbMOpbWVudCBQw6lyb24gKDUpOgo+ICAgIGRybTogcGFuZnJvc3Q6IGFkZCBvcHRpb25hbCBi
dXNfY2xvY2sKPiAgICBpb21tdTogaW8tcGd0YWJsZTogZml4IHNhbml0eSBjaGVjayBmb3Igbm9u
IDQ4LWJpdCBtYWxpIGlvbW11Cj4gICAgZHQtYmluZGluZ3M6IGdwdTogbWFsaS1taWRnYXJkOiBB
ZGQgSDYgbWFsaSBncHUgY29tcGF0aWJsZQo+ICAgIGFybTY0OiBkdHM6IGFsbHdpbm5lcjogQWRk
IEFSTSBNYWxpIEdQVSBub2RlIGZvciBINgo+ICAgIGFybTY0OiBkdHM6IGFsbHdpbm5lcjogQWRk
IG1hbGkgR1BVIHN1cHBseSBmb3IgSDYgYm9hcmRzCj4gCj4gSWNlbm93eSBaaGVuZyAoMSk6Cj4g
ICAgZHQtYmluZGluZ3M6IGdwdTogYWRkIGJ1cyBjbG9jayBmb3IgTWFsaSBNaWRnYXJkIEdQVXMK
PiAKPiAgIC4uLi9iaW5kaW5ncy9ncHUvYXJtLG1hbGktbWlkZ2FyZC50eHQgICAgICAgICB8IDE1
ICsrKysrKysrKysrKy0KPiAgIC4uLi9kdHMvYWxsd2lubmVyL3N1bjUwaS1oNi1iZWVsaW5rLWdz
MS5kdHMgICB8ICA2ICsrKysrCj4gICAuLi4vZHRzL2FsbHdpbm5lci9zdW41MGktaDYtb3Jhbmdl
cGktMy5kdHMgICAgfCAgNiArKysrKwo+ICAgLi4uL2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LW9y
YW5nZXBpLmR0c2kgICAgIHwgIDYgKysrKysKPiAgIC4uLi9ib290L2R0cy9hbGx3aW5uZXIvc3Vu
NTBpLWg2LXBpbmUtaDY0LmR0cyB8ICA2ICsrKysrCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL2Fs
bHdpbm5lci9zdW41MGktaDYuZHRzaSAgfCAxNCArKysrKysrKysrKysKPiAgIGRyaXZlcnMvZ3B1
L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuYyAgICB8IDIyICsrKysrKysrKysrKysrKysr
KysKPiAgIGRyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuaCAgICB8ICAx
ICsKPiAgIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYyAgICAgICAgICAgICAgICB8ICAy
ICstCj4gICA5IGZpbGVzIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
