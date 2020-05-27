Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2664C433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 09:16:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E9A2084C
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 09:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDm8HrrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E9A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A129381B11;
	Wed, 27 May 2020 09:16:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rdsqNUE8iRah; Wed, 27 May 2020 09:16:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 92AC787CFB;
	Wed, 27 May 2020 09:06:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF19C0881;
	Wed, 27 May 2020 09:06:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0ED5C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB8D22047C
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NKSya9jx9z6r for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 09:06:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 907C720432
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 09:06:21 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EEB5620787;
 Wed, 27 May 2020 09:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590570381;
 bh=FAvCknzoTGPImAY3eT0P2nnO/0J1mHHX86dLH7iV/1s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QDm8HrrC/9YB0B/oFjVIItGTyqhBTZraHt2UEFTqoRDF2OXZlnYtuMQ2/4Lj4PIVa
 Drio0vQjl5sCV6qqPHsS8jdpUkMXkg51jL1Wzof8P5xUu6EDWLCuLDdR11NI5u0kNI
 N4TmitUblhzBxyKwFqfpmdcTDDO0iyAPupBpvmS4=
Date: Wed, 27 May 2020 11:06:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Dahl <post@lespocky.de>
Subject: Re: [PATCH v3] dma: Fix max PFN arithmetic overflow on 32 bit systems
Message-ID: <20200527090618.GF179718@kroah.com>
References: <20200526175749.20742-1-post@lespocky.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200526175749.20742-1-post@lespocky.de>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Florian Wolters <florian@florian-wolters.de>
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

T24gVHVlLCBNYXkgMjYsIDIwMjAgYXQgMDc6NTc6NDlQTSArMDIwMCwgQWxleGFuZGVyIERhaGwg
d3JvdGU6Cj4gVGhlIGludGVybWVkaWF0ZSByZXN1bHQgb2YgdGhlIG9sZCB0ZXJtICg0VUwgKiAx
MDI0ICogMTAyNCAqIDEwMjQpIGlzCj4gNCAyOTQgOTY3IDI5NiBvciAweDEwMDAwMDAwMCB3aGlj
aCBpcyBubyBwcm9ibGVtIG9uIDY0IGJpdCBzeXN0ZW1zLiAgVGhlCj4gcGF0Y2ggZG9lcyBub3Qg
Y2hhbmdlIHRoZSBsYXRlciBvdmVyYWxsIHJlc3VsdCBvZiAweDEwMDAwMCBmb3IKPiBNQVhfRE1B
MzJfUEZOLiAgVGhlIG5ldyBjYWxjdWxhdGlvbiB5aWVsZHMgdGhlIHNhbWUgcmVzdWx0LCBidXQg
ZG9lcyBub3QKPiByZXF1aXJlIDY0IGJpdCBhcml0aG1ldGljLgo+IAo+IE9uIDMyIGJpdCBzeXN0
ZW1zIHRoZSBvbGQgY2FsY3VsYXRpb24gc3VmZmVycyBmcm9tIGFuIGFyaXRobWV0aWMKPiBvdmVy
ZmxvdyBpbiB0aGF0IGludGVybWVkaWF0ZSB0ZXJtIGluIGJyYWNlczogNFVMIGFrYSB1bnNpZ25l
ZCBsb25nIGludAo+IGlzIDQgYnl0ZSB3aWRlIGFuZCBhbiBhcml0aG1ldGljIG92ZXJmbG93IGhh
cHBlbnMgKHRoZSAweDEwMDAwMDAwMCBkb2VzCj4gbm90IGZpdCBpbiA0IGJ5dGVzKSwgdGhlIGlu
IGJyYWNlcyByZXN1bHQgaXMgdHJ1bmNhdGVkIHRvIHplcm8sIHRoZQo+IGZvbGxvd2luZyByaWdo
dCBzaGlmdCBkb2VzIG5vdCBhbHRlciB0aGF0LCBzbyBNQVhfRE1BMzJfUEZOIGV2YWx1YXRlcyB0
bwo+IDAgb24gMzIgYml0IHN5c3RlbXMuCj4gCj4gVGhhdCB3cm9uZyB2YWx1ZSBpcyBhIHByb2Js
ZW0gaW4gYSBjb21wYXJpc2lvbiBhZ2FpbnN0IE1BWF9ETUEzMl9QRk4gaW4KPiB0aGUgaW5pdCBj
b2RlIGZvciBzd2lvdGxiIGluICdwY2lfc3dpb3RsYl9kZXRlY3RfNGdiKCknIHRvIGRlY2lkZSBp
Zgo+IHN3aW90bGIgc2hvdWxkIGJlIGFjdGl2ZS4gIFRoYXQgY29tcGFyaXNvbiB5aWVsZHMgdGhl
IG9wcG9zaXRlIHJlc3VsdCwKPiB3aGVuIGNvbXBpbGluZyBvbiAzMiBiaXQgc3lzdGVtcy4KPiAK
PiBUaGlzIHdhcyBub3QgcG9zc2libGUgYmVmb3JlIDFiN2UwM2VmNzU3MCAoIng4NiwgTlVNQTog
RW5hYmxlIGVtdWxhdGlvbgo+IG9uIDMyYml0IHRvbyIpIHdoZW4gdGhhdCBNQVhfRE1BMzJfUEZO
IHdhcyBmaXJzdCBtYWRlIHZpc2libGUgdG8geDg2XzMyCj4gKGFuZCB3aGljaCBsYW5kZWQgaW4g
djMuMCkuCj4gCj4gSW4gcHJhY3RpY2UgdGhpcyB3YXNuJ3QgYSBwcm9ibGVtLCB1bmxlc3MgeW91
IGFjdGl2YXRlZCBDT05GSUdfU1dJT1RMQgo+IG9uIHg4NiAoMzIgYml0KS4KPiAKPiBIb3dldmVy
IGZvciBBUkNIPXg4NiAoMzIgYml0KSBhbmQgaWYgeW91IGhhdmUgc2V0IENPTkZJR19JT01NVV9J
TlRFTCwKPiBzaW5jZSBjNWE1ZGM0Y2JiZjQgKCJpb21tdS92dC1kOiBEb24ndCBzd2l0Y2ggb2Zm
IHN3aW90bGIgaWYgYm91bmNlIHBhZ2UKPiBpcyB1c2VkIikgdGhlcmUncyBhIGRlcGVuZGVuY3kg
b24gQ09ORklHX1NXSU9UTEIsIHdoaWNoIHdhcyBub3QKPiBuZWNlc3NhcmlseSBhY3RpdmUgYmVm
b3JlLiAgVGhhdCBsYW5kZWQgaW4gdjUuNCwgd2hlcmUgd2Ugbm90aWNlZCBpdCBpbgo+IHRoZSBm
bGk0bCBMaW51eCBkaXN0cmlidXRpb24uICBXZSBoYXZlIENPTkZJR19JT01NVV9JTlRFTCBhY3Rp
dmUgb24gYm90aAo+IDMyIGFuZCA2NCBiaXQga2VybmVsIGNvbmZpZ3MgdGhlcmUgKEkgY291bGQg
bm90IGZpbmQgb3V0IHdoeSwgc28gbGV0J3MKPiBqdXN0IHNheSBoaXN0b3JpY2FsIHJlYXNvbnMp
Lgo+IAo+IFRoZSBlZmZlY3QgaXMgYXQgYm9vdCB0aW1lIDY0IE1pQiAoZGVmYXVsdCBzaXplKSB3
ZXJlIGFsbG9jYXRlZCBmb3IKPiBib3VuY2UgYnVmZmVycyBub3csIHdoaWNoIGlzIGEgbm90aWNl
YWJsZSBhbW91bnQgb2YgbWVtb3J5IG9uIHNtYWxsCj4gc3lzdGVtcyBsaWtlIHBjZW5naW5lcyBB
TElYIDJEMyB3aXRoIDI1NiBNaUIgbWVtb3J5LCB3aGljaCBhcmUgc3RpbGwKPiBmcmVxdWVudGx5
IHVzZWQgYXMgaG9tZSByb3V0ZXJzLgo+IAo+IFdlIG5vdGljZWQgdGhpcyBlZmZlY3Qgd2hlbiBt
aWdyYXRpbmcgZnJvbSBrZXJuZWwgdjQuMTkgKExUUykgdG8gdjUuNAo+IChMVFMpIGluIGZsaTRs
IGFuZCBnb3QgdGhhdCBrZXJuZWwgbWVzc2FnZXMgZm9yIGV4YW1wbGU6Cj4gCj4gICBMaW51eCB2
ZXJzaW9uIDUuNC4yMiAoYnVpbGRyb290QGJ1aWxkcm9vdCkgKGdjYyB2ZXJzaW9uIDcuMy4wIChC
dWlsZHJvb3QgMjAxOC4wMi44KSkgIzEgU01QIE1vbiBOb3YgMjYgMjM6NDA6MDAgQ0VUIDIwMTgK
PiAgIOKApgo+ICAgTWVtb3J5OiAxODM0ODRLLzI2MTc1NksgYXZhaWxhYmxlICg0NTk0SyBrZXJu
ZWwgY29kZSwgMzkzSyByd2RhdGEsIDE2NjBLIHJvZGF0YSwgNTM2SyBpbml0LCA0NTZLIGJzcyAs
IDc4MjcySyByZXNlcnZlZCwgMEsgY21hLXJlc2VydmVkLCAwSyBoaWdobWVtKQo+ICAg4oCmCj4g
ICBQQ0ktRE1BOiBVc2luZyBzb2Z0d2FyZSBib3VuY2UgYnVmZmVyaW5nIGZvciBJTyAoU1dJT1RM
QikKPiAgIHNvZnR3YXJlIElPIFRMQjogbWFwcGVkIFttZW0gMHgwYmI3ODAwMC0weDBmYjc4MDAw
XSAoNjRNQikKPiAKPiBUaGUgaW5pdGlhbCBhbmFseXNpcyBhbmQgdGhlIHN1Z2dlc3RlZCBmaXgg
d2FzIGRvbmUgYnkgdXNlciAnc291cmNlamVkaScKPiBhdCBzdGFja292ZXJmbG93IGFuZCBleHBs
aWNpdGx5IG1hcmtlZCBhcyBHUEx2MiBmb3IgaW5jbHVzaW9uIGluIHRoZQo+IExpbnV4IGtlcm5l
bDoKPiAKPiAgIGh0dHBzOi8vdW5peC5zdGFja2V4Y2hhbmdlLmNvbS9hLzUyMDUyNS81MDAwNwo+
IAo+IFRoZSBuZXcgY2FsY3VsYXRpb24sIHdoaWNoIGRvZXMgbm90IHN1ZmZlciBmcm9tIHRoYXQg
b3ZlcmZsb3csIGlzIHRoZQo+IHNhbWUgYXMgZm9yIGFyY2gvbWlwcyBub3cgYXMgc3VnZ2VzdGVk
IGJ5IFJvYmluIE11cnBoeS4KPiAKPiBUaGUgZml4IHdhcyB0ZXN0ZWQgYnkgZmxpNGwgdXNlcnMg
b24gcm91bmQgYWJvdXQgdHdvIGRvemVuIGRpZmZlcmVudAo+IHN5c3RlbXMsIGluY2x1ZGluZyBi
b3RoIDMyIGFuZCA2NCBiaXQgYXJjaHMsIGJhcmUgbWV0YWwgYW5kIHZpcnR1YWxpemVkCj4gbWFj
aGluZXMuCj4gCj4gRml4ZXM6IDFiN2UwM2VmNzU3MCAoIng4NiwgTlVNQTogRW5hYmxlIGVtdWxh
dGlvbiBvbiAzMmJpdCB0b28iKQo+IEZpeGVzOiBodHRwczovL3dlYi5uZXR0d29ya3Mub3JnL2J1
Z3MvYnJvd3NlL0ZGTC0yNTYwCj4gRml4ZXM6IGh0dHBzOi8vdW5peC5zdGFja2V4Y2hhbmdlLmNv
bS9xLzUyMDA2NS81MDAwNwo+IFJlcG9ydGVkLWJ5OiBBbGFuIEplbmtpbnMgPGFsYW4uY2hyaXN0
b3BoZXIuamVua2luc0BnbWFpbC5jb20+Cj4gU3VnZ2VzdGVkLWJ5OiBSb2JpbiBNdXJwaHkgPHJv
YmluLm11cnBoeUBhcm0uY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBEYWhsIDxwb3N0
QGxlc3BvY2t5LmRlPgo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCgpSZXZpZXdlZC1ieTog
R3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
