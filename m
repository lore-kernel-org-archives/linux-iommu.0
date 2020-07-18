Return-Path: <SRS0=IIdK=A5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD25C433E3
	for <iommu@archiver.kernel.org>; Sat, 18 Jul 2020 21:07:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9904122CAF
	for <iommu@archiver.kernel.org>; Sat, 18 Jul 2020 21:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9904122CAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 74E1E845CB;
	Sat, 18 Jul 2020 21:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RcXQZtFrbJwe; Sat, 18 Jul 2020 21:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 189BE8459E;
	Sat, 18 Jul 2020 21:07:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E63E5C0865;
	Sat, 18 Jul 2020 21:07:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D10C0C0733
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jul 2020 21:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BA53D87ABF
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jul 2020 21:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ft5F4NCBhS3G for <iommu@lists.linux-foundation.org>;
 Sat, 18 Jul 2020 21:07:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 30A1C87A80
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jul 2020 21:07:32 +0000 (UTC)
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
 (Authenticated sender: gregory.clement@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 15AD2200004;
 Sat, 18 Jul 2020 21:07:29 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
In-Reply-To: <CAPv3WKc5hNhDCjgrX8uuJJm9MRS520QcD1NYTY1LWFHEBqJMfg@mail.gmail.com>
References: <20200715070649.18733-1-tn@semihalf.com>
 <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
 <20200716120202.GA7485@willie-the-truck>
 <CAPv3WKc5hNhDCjgrX8uuJJm9MRS520QcD1NYTY1LWFHEBqJMfg@mail.gmail.com>
Date: Sat, 18 Jul 2020 23:07:29 +0200
Message-ID: <87mu3w352m.fsf@FE-laptop>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, kernel-team@android.com,
 Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org
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

SGVsbG8sCgo+IGN6dy4sIDE2IGxpcCAyMDIwIG8gMTQ6MDIgV2lsbCBEZWFjb24gPHdpbGxAa2Vy
bmVsLm9yZz4gbmFwaXNhxYIoYSk6Cj4+Cj4+IE9uIFRodSwgSnVsIDE2LCAyMDIwIGF0IDAxOjAw
OjQzUE0gKzAxMDAsIFdpbGwgRGVhY29uIHdyb3RlOgo+PiA+IE9uIFdlZCwgMTUgSnVsIDIwMjAg
MDk6MDY6NDUgKzAyMDAsIFRvbWFzeiBOb3dpY2tpIHdyb3RlOgo+PiA+ID4gVGhlIHNlcmllcyBp
cyBtZWFudCB0byBzdXBwb3J0IFNNTVUgZm9yIEFQODA2IGFuZCBhIHdvcmthcm91bmQKPj4gPiA+
IGZvciBhY2Nlc3NpbmcgQVJNIFNNTVUgNjRiaXQgcmVnaXN0ZXJzIGlzIHRoZSBnaXN0IG9mIGl0
Lgo+PiA+ID4KPj4gPiA+IEZvciB0aGUgcmVjb3JkLCBBUC04MDYgY2FuJ3QgYWNjZXNzIFNNTVUg
cmVnaXN0ZXJzIHdpdGggNjRiaXQgd2lkdGguCj4+ID4gPiBUaGlzIHBhdGNoZXMgc3BsaXQgdGhl
IHJlYWRxL3dyaXRlcSBpbnRvIHR3byAzMmJpdCBhY2Nlc3NlcyBpbnN0ZWFkCj4+ID4gPiBhbmQg
dXBkYXRlIERUIGJpbmRpbmdzLgo+PiA+ID4KPj4gPiA+IFsuLi5dCj4+ID4KPj4gPiBBcHBsaWVk
IHRvIHdpbGwgKGZvci1qb2VyZy9hcm0tc21tdS91cGRhdGVzKSwgdGhhbmtzIQo+PiA+Cj4+ID4g
WzEvM10gaW9tbXUvYXJtLXNtbXU6IENhbGwgY29uZmlndXJhdGlvbiBpbXBsIGhvb2sgYmVmb3Jl
IGNvbnN1bWluZyBmZWF0dXJlcwo+PiA+ICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvd2ls
bC9jLzZhNzlhNWEzODQyYgo+PiA+IFsyLzNdIGlvbW11L2FybS1zbW11OiBXb3JrYXJvdW5kIGZv
ciBNYXJ2ZWxsIEFybWFkYS1BUDgwNiBTb0MgZXJyYXR1bSAjNTgyNzQzCj4+ID4gICAgICAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy93aWxsL2MvZjJkOTg0OGFlYjlmCj4+ID4gWzMvM10gZHQtYmlu
ZGluZ3M6IGFybS1zbW11OiBhZGQgY29tcGF0aWJsZSBzdHJpbmcgZm9yIE1hcnZlbGwgQXJtYWRh
LUFQODA2IFNNTVUtNTAwCj4+ID4gICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy93aWxsL2Mv
ZTg1ZTg0ZDE5YjlkCj4+Cj4+IChub3RlIHRoYXQgSSBsZWZ0IHBhdGNoIDQgZm9yIGFybS1zb2Ms
IGFzIHRoYXQncyBqdXN0IHVwZGF0aW5nIC5kdHMgZmlsZXMpCj4+Cj4KPiBIaSBHcmVnb3J5LAo+
Cj4gQ2FuIHlvdSBwbGVhc2UgaGVscCB3aXRoIHRoZSByZXZpZXcvbWVyZ2Ugb2YgcGF0Y2ggIzQ/
CgpTdXJlIQoKSSd2ZSBmb2xsb3dlZCB0aGUgc2VyaWVzIHNpbmNlIHRoZSB2MSBldmVuIGlmIEkg
ZGlkbid0IGNvbW1ldG4gYW5kIEkgYW0KaGFwcHkgdGhhdCBpdCBmaW5hbGx5IG1hbmFnZWQgdG8g
YmUgbWVyZ2VkLiBJIGNhbiBub3cgcmVtb3ZlIGl0IGZyb20KbXkgVE9ETyBsaXN0ISA6KQoKR3Jl
Z29yeQoKCj4KPiBCZXN0IHJlZ2FyZHMsCj4gTWFyY2luCgotLSAKR3JlZ29yeSBDbGVtZW50LCBC
b290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2Jvb3Rs
aW4uY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
