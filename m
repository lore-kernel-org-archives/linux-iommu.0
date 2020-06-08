Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD25C433E2
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 16:41:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1508020774
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 16:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vcbz31UJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1508020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C324486F21;
	Mon,  8 Jun 2020 16:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uoTR6saAss7Z; Mon,  8 Jun 2020 16:41:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 31B60870DF;
	Mon,  8 Jun 2020 16:41:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FFEEC07FF;
	Mon,  8 Jun 2020 16:41:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC86EC016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 16:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CBA4B86130
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 16:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4gn5xQNZpzFN for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 16:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 45335860F9
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 16:41:55 +0000 (UTC)
Received: from localhost (mobile-166-175-190-200.mycingular.net
 [166.175.190.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94E0D206A4;
 Mon,  8 Jun 2020 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591634515;
 bh=9+wSpwKeMW/wdGvPemQJqQQABIsLkQPW2K8a1nmcHm0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=vcbz31UJVkE9u265rOeW3ymi3j4Td/cEnamY/yY9ERI7XDF6hwJNBbYLuVspo03w5
 +nCy5Z6r28j/PRn+D0ikGuvRbXbN8X1Cx89vEnnUVpdAtfUfJ5pVag/p6J2pakmzHc
 k/V+AhP42zscGFN8csMJ506cA5x/mPmtM2EEkY74=
Date: Mon, 8 Jun 2020 11:41:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200608164148.GA1394249@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be91b0f0-c685-789d-6868-1c8ebd62b770@linaro.org>
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kenneth-lee-2012@foxmail.com, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
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

T24gTW9uLCBKdW4gMDgsIDIwMjAgYXQgMTA6NTQ6MTVBTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+IE9uIDIwMjAvNi82IOS4iuWNiDc6MTksIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4gPiBP
biBUaHUsIEp1biAwNCwgMjAyMCBhdCAwOTozMzowN1BNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3Jv
dGU6Cj4gPiA+IE9uIDIwMjAvNi8yIOS4iuWNiDE6NDEsIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4g
PiA+ID4gT24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMDk6MzM6NDRBTSArMDIwMCwgSm9lcmcgUm9l
ZGVsIHdyb3RlOgo+ID4gPiA+ID4gT24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMDE6MTg6NDJQTSAt
MDUwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToKPiA+ID4gPiA+ID4gSXMgdGhpcyBzbG93ZG93biBz
aWduaWZpY2FudD8gIFdlIGFscmVhZHkgaXRlcmF0ZSBvdmVyIGV2ZXJ5IGRldmljZQo+ID4gPiA+
ID4gPiB3aGVuIGFwcGx5aW5nIFBDSV9GSVhVUF9GSU5BTCBxdWlya3MsIHNvIGlmIHdlIHVzZWQg
dGhlIGV4aXN0aW5nCj4gPiA+ID4gPiA+IFBDSV9GSVhVUF9GSU5BTCwgd2Ugd291bGRuJ3QgYmUg
YWRkaW5nIGEgbmV3IGxvb3AuICBXZSB3b3VsZCBvbmx5IGJlCj4gPiA+ID4gPiA+IGFkZGluZyB0
d28gbW9yZSBpdGVyYXRpb25zIHRvIHRoZSBsb29wIGluIHBjaV9kb19maXh1cHMoKSB0aGF0IHRy
aWVzCj4gPiA+ID4gPiA+IHRvIG1hdGNoIHF1aXJrcyBhZ2FpbnN0IHRoZSBjdXJyZW50IGRldmlj
ZS4gIEkgZG91YnQgdGhhdCB3b3VsZCBiZSBhCj4gPiA+ID4gPiA+IG1lYXN1cmFibGUgc2xvd2Rv
d24uCj4gPiA+ID4gPiBJIGRvbid0IGtub3cgaG93IHNpZ25pZmljYW50IGl0IGlzLCBidXQgSSBy
ZW1lbWJlciBwZW9wbGUgY29tcGxhaW5pbmcKPiA+ID4gPiA+IGFib3V0IGFkZGluZyBuZXcgUENJ
IHF1aXJrcyBiZWNhdXNlIGl0IHRha2VzIHRvbyBsb25nIGZvciB0aGVtIHRvIHJ1bgo+ID4gPiA+
ID4gdGhlbSBhbGwuIFRoYXQgd2FzIGluIHRoZSBkaXNjdXNzaW9uIGFib3V0IHRoZSBxdWlyayBk
aXNhYmxpbmcgQVRTIG9uCj4gPiA+ID4gPiBBTUQgU3RvbmV5IHN5c3RlbXMuCj4gPiA+ID4gPiAK
PiA+ID4gPiA+IFNvIGl0IHByb2JhYmx5IGRlcGVuZHMgb24gaG93IG1hbnkgUENJIGRldmljZXMg
YXJlIGluIHRoZSBzeXN0ZW0gd2hldGhlcgo+ID4gPiA+ID4gaXQgY2F1c2VzIGFueSBtZWFzdXJl
YWJsZSBzbG93ZG93bi4KPiA+ID4gPiBJIGZvdW5kIHRoaXMgWzFdIGZyb20gUGF1bCBNZW56ZWws
IHdoaWNoIHdhcyBhIHNsb3dkb3duIGNhdXNlZCBieQo+ID4gPiA+IHF1aXJrX3VzYl9lYXJseV9o
YW5kb2ZmKCkuICBJIHRoaW5rIHRoZSByZWFsIHByb2JsZW0gaXMgaW5kaXZpZHVhbAo+ID4gPiA+
IHF1aXJrcyB0aGF0IHRha2UgYSBsb25nIHRpbWUuCj4gPiA+ID4gCj4gPiA+ID4gVGhlIFBDSV9G
SVhVUF9JT01NVSB0aGluZ3Mgd2UncmUgdGFsa2luZyBhYm91dCBzaG91bGQgYmUgZmFzdCwgYW5k
IG9mCj4gPiA+ID4gY291cnNlLCB0aGV5J3JlIG9ubHkgcnVuIGZvciBtYXRjaGluZyBkZXZpY2Vz
IGFueXdheS4gIFNvIEknZCByYXRoZXIKPiA+ID4gPiBrZWVwIHRoZW0gYXMgUENJX0ZJWFVQX0ZJ
TkFMIHRoYW4gYWRkIGEgd2hvbGUgbmV3IHBoYXNlLgo+ID4gPiA+IAo+ID4gPiBUaGFua3MgQmpv
cm4gZm9yIHRha2luZyB0aW1lIGZvciB0aGlzLgo+ID4gPiBJZiBzbywgaXQgd291bGQgYmUgbXVj
aCBzaW1wbGVyLgo+ID4gPiAKPiA+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gPiA+
IEBAIC0yNDE4LDYgKzI0MTgsMTAgQEAgaW50IGlvbW11X2Z3c3BlY19pbml0KHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0Cj4gPiA+IGZ3bm9kZV9oYW5kbGUgKmlvbW11X2Z3bm9kZSwKPiA+ID4g
IMKgwqDCoMKgwqDCoMKgIGZ3c3BlYy0+aW9tbXVfZndub2RlID0gaW9tbXVfZndub2RlOwo+ID4g
PiAgwqDCoMKgwqDCoMKgwqAgZndzcGVjLT5vcHMgPSBvcHM7Cj4gPiA+ICDCoMKgwqDCoMKgwqDC
oCBkZXZfaW9tbXVfZndzcGVjX3NldChkZXYsIGZ3c3BlYyk7Cj4gPiA+ICsKPiA+ID4gK8KgwqDC
oMKgwqDCoCBpZiAoZGV2X2lzX3BjaShkZXYpKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwY2lfZml4dXBfZGV2aWNlKHBjaV9maXh1cF9maW5hbCwgdG9fcGNpX2RldihkZXYp
KTsKPiA+ID4gKwo+ID4gPiAKPiA+ID4gVGhlbiBwY2lfZml4dXBfZmluYWwgd2lsbCBiZSBjYWxs
ZWQgdHdpY2UsIHRoZSBmaXJzdCBpbiBwY2lfYnVzX2FkZF9kZXZpY2UuCj4gPiA+IEhlcmUgaW4g
aW9tbXVfZndzcGVjX2luaXQgaXMgdGhlIHNlY29uZCB0aW1lLCBzcGVjaWZpY2FsbHkgZm9yIGlv
bW11X2Z3c3BlYy4KPiA+ID4gV2lsbCBzZW5kIHRoaXMgd2hlbiA1LjgtcmMxIGlzIG9wZW4uCj4g
Pgo+ID4gV2FpdCwgdGhpcyB3aG9sZSBmaXh1cCBhcHByb2FjaCBzZWVtcyB3cm9uZyB0byBtZS4g
IE5vIG1hdHRlciBob3cgeW91Cj4gPiBkbyB0aGUgZml4dXAsIGl0J3Mgc3RpbGwgYSBmaXh1cCwg
d2hpY2ggbWVhbnMgaXQgcmVxdWlyZXMgb25nb2luZwo+ID4gbWFpbnRlbmFuY2UuICBTdXJlbHkg
d2UgZG9uJ3Qgd2FudCB0byBoYXZlIHRvIGFkZCB0aGUgVmVuZG9yL0RldmljZSBJRAo+ID4gZm9y
IGV2ZXJ5IG5ldyBBTUJBIGRldmljZSB0aGF0IGNvbWVzIGFsb25nLCBkbyB3ZT8KPiA+IAo+IEhl
cmUgdGhlIGZha2UgcGNpIGRldmljZSBoYXMgc3RhbmRhcmQgUENJIGNmZyBzcGFjZSwgYnV0IHBo
eXNpY2FsCj4gaW1wbGVtZW50YXRpb24gaXMgYmFzZSBvbiBBTUJBCj4gVGhleSBjYW4gcHJvdmlk
ZSBwYXNpZCBmZWF0dXJlLgo+IEhvd2V2ZXIsCj4gMSwgZG9lcyBub3Qgc3VwcG9ydCB0bHAgc2lu
Y2UgdGhleSBhcmUgbm90IHJlYWwgcGNpIGRldmljZXMuCj4gMi4gZG9lcyBub3Qgc3VwcG9ydCBw
cmksIGluc3RlYWQgc3VwcG9ydCBzdGFsbCAocHJvdmlkZWQgYnkgc21tdSkKPiBBbmQgc3RhbGwg
aXMgbm90IGEgcGNpIGZlYXR1cmUsIHNvIGl0IGlzIG5vdCBkZXNjcmliZWQgaW4gc3RydWN0IHBj
aV9kZXYsCj4gYnV0IGluIHN0cnVjdCBpb21tdV9md3NwZWMuCj4gU28gd2UgdXNlIHRoaXMgZml4
dXAgdG8gdGVsbCBwY2kgc3lzdGVtIHRoYXQgdGhlIGRldmljZXMgY2FuIHN1cHBvcnQgc3RhbGws
Cj4gYW5kIGhlcmVieSBzdXBwb3J0IHBhc2lkLgoKVGhpcyBkaWQgbm90IGFuc3dlciBteSBxdWVz
dGlvbi4gIEFyZSB5b3UgcHJvcG9zaW5nIHRoYXQgd2UgdXBkYXRlIGEKcXVpcmsgZXZlcnkgdGlt
ZSBhIG5ldyBBTUJBIGRldmljZSBpcyByZWxlYXNlZD8gIEkgZG9uJ3QgdGhpbmsgdGhhdAp3b3Vs
ZCBiZSBhIGdvb2QgbW9kZWwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
