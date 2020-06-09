Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB8C433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 16:49:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABDA2078C
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 16:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvG4keri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABDA2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 646B6873E3;
	Tue,  9 Jun 2020 16:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CrKLHm70-q6; Tue,  9 Jun 2020 16:49:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C2C68873AD;
	Tue,  9 Jun 2020 16:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5A2EC088C;
	Tue,  9 Jun 2020 16:49:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CAE3C016F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 16:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E892D873BB
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 16:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UQetAyMrlk6V for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 16:49:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D5C3F873AD
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 16:49:28 +0000 (UTC)
Received: from localhost (mobile-166-170-222-206.mycingular.net
 [166.170.222.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D1D420737;
 Tue,  9 Jun 2020 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591721368;
 bh=5Q7RvyofmbZbrB/I38g1tWmxg8QS/w1w0oFGJk1TAAE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=dvG4keriVYERu7ME7jmTxlggF24dPHuT8ZHwsHgyeBv8aHb5TopY1KdfJVDndSoXl
 RxQiw2j9xiinR8ke3p9Ltba3X4AhyTf4XbSb9RwT2AqKWdKTjRg+cV7DgApD257z37
 fAvyNM3ngOAOHRMuIGrK7cGIhRs7rGlN9Hoz8zWA=
Date: Tue, 9 Jun 2020 11:49:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200609164926.GA1452092@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a38bhE_VO_eVcsfsGKgED=gmSEntQmrhwbLkeA6Si0qaw@mail.gmail.com>
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-pci <linux-pci@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 kenneth-lee-2012@foxmail.com,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
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

T24gVHVlLCBKdW4gMDksIDIwMjAgYXQgMTE6MTU6MDZBTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3
cm90ZToKPiBPbiBUdWUsIEp1biA5LCAyMDIwIGF0IDY6MDIgQU0gWmhhbmdmZWkgR2FvIDx6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZz4gd3JvdGU6Cj4gPiBPbiAyMDIwLzYvOSDkuIrljYgxMjo0MSwg
Qmpvcm4gSGVsZ2FhcyB3cm90ZToKPiA+ID4gT24gTW9uLCBKdW4gMDgsIDIwMjAgYXQgMTA6NTQ6
MTVBTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+ID4gPj4gT24gMjAyMC82LzYg5LiK5Y2I
NzoxOSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToKPiA+ID4+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9p
b21tdS5jCj4gPiA+Pj4+IEBAIC0yNDE4LDYgKzI0MTgsMTAgQEAgaW50IGlvbW11X2Z3c3BlY19p
bml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0Cj4gPiA+Pj4+IGZ3bm9kZV9oYW5kbGUgKmlv
bW11X2Z3bm9kZSwKPiA+ID4+Pj4gICAgICAgICAgIGZ3c3BlYy0+aW9tbXVfZndub2RlID0gaW9t
bXVfZndub2RlOwo+ID4gPj4+PiAgICAgICAgICAgZndzcGVjLT5vcHMgPSBvcHM7Cj4gPiA+Pj4+
ICAgICAgICAgICBkZXZfaW9tbXVfZndzcGVjX3NldChkZXYsIGZ3c3BlYyk7Cj4gPiA+Pj4+ICsK
PiA+ID4+Pj4gKyAgICAgICBpZiAoZGV2X2lzX3BjaShkZXYpKQo+ID4gPj4+PiArICAgICAgICAg
ICAgICAgcGNpX2ZpeHVwX2RldmljZShwY2lfZml4dXBfZmluYWwsIHRvX3BjaV9kZXYoZGV2KSk7
Cj4gPiA+Pj4+ICsKPiA+ID4+Pj4KPiA+ID4+Pj4gVGhlbiBwY2lfZml4dXBfZmluYWwgd2lsbCBi
ZSBjYWxsZWQgdHdpY2UsIHRoZSBmaXJzdCBpbiBwY2lfYnVzX2FkZF9kZXZpY2UuCj4gPiA+Pj4+
IEhlcmUgaW4gaW9tbXVfZndzcGVjX2luaXQgaXMgdGhlIHNlY29uZCB0aW1lLCBzcGVjaWZpY2Fs
bHkgZm9yIGlvbW11X2Z3c3BlYy4KPiA+ID4+Pj4gV2lsbCBzZW5kIHRoaXMgd2hlbiA1LjgtcmMx
IGlzIG9wZW4uCj4gPiA+Pj4gV2FpdCwgdGhpcyB3aG9sZSBmaXh1cCBhcHByb2FjaCBzZWVtcyB3
cm9uZyB0byBtZS4gIE5vIG1hdHRlciBob3cgeW91Cj4gPiA+Pj4gZG8gdGhlIGZpeHVwLCBpdCdz
IHN0aWxsIGEgZml4dXAsIHdoaWNoIG1lYW5zIGl0IHJlcXVpcmVzIG9uZ29pbmcKPiA+ID4+PiBt
YWludGVuYW5jZS4gIFN1cmVseSB3ZSBkb24ndCB3YW50IHRvIGhhdmUgdG8gYWRkIHRoZSBWZW5k
b3IvRGV2aWNlIElECj4gPiA+Pj4gZm9yIGV2ZXJ5IG5ldyBBTUJBIGRldmljZSB0aGF0IGNvbWVz
IGFsb25nLCBkbyB3ZT8KPiA+ID4+Pgo+ID4gPj4gSGVyZSB0aGUgZmFrZSBwY2kgZGV2aWNlIGhh
cyBzdGFuZGFyZCBQQ0kgY2ZnIHNwYWNlLCBidXQgcGh5c2ljYWwKPiA+ID4+IGltcGxlbWVudGF0
aW9uIGlzIGJhc2Ugb24gQU1CQQo+ID4gPj4gVGhleSBjYW4gcHJvdmlkZSBwYXNpZCBmZWF0dXJl
Lgo+ID4gPj4gSG93ZXZlciwKPiA+ID4+IDEsIGRvZXMgbm90IHN1cHBvcnQgdGxwIHNpbmNlIHRo
ZXkgYXJlIG5vdCByZWFsIHBjaSBkZXZpY2VzLgo+ID4gPj4gMi4gZG9lcyBub3Qgc3VwcG9ydCBw
cmksIGluc3RlYWQgc3VwcG9ydCBzdGFsbCAocHJvdmlkZWQgYnkgc21tdSkKPiA+ID4+IEFuZCBz
dGFsbCBpcyBub3QgYSBwY2kgZmVhdHVyZSwgc28gaXQgaXMgbm90IGRlc2NyaWJlZCBpbiBzdHJ1
Y3QgcGNpX2RldiwKPiA+ID4+IGJ1dCBpbiBzdHJ1Y3QgaW9tbXVfZndzcGVjLgo+ID4gPj4gU28g
d2UgdXNlIHRoaXMgZml4dXAgdG8gdGVsbCBwY2kgc3lzdGVtIHRoYXQgdGhlIGRldmljZXMgY2Fu
IHN1cHBvcnQgc3RhbGwsCj4gPiA+PiBhbmQgaGVyZWJ5IHN1cHBvcnQgcGFzaWQuCj4gPiA+IFRo
aXMgZGlkIG5vdCBhbnN3ZXIgbXkgcXVlc3Rpb24uICBBcmUgeW91IHByb3Bvc2luZyB0aGF0IHdl
IHVwZGF0ZSBhCj4gPiA+IHF1aXJrIGV2ZXJ5IHRpbWUgYSBuZXcgQU1CQSBkZXZpY2UgaXMgcmVs
ZWFzZWQ/ICBJIGRvbid0IHRoaW5rIHRoYXQKPiA+ID4gd291bGQgYmUgYSBnb29kIG1vZGVsLgo+
ID4KPiA+IFllcywgeW91IGFyZSByaWdodCwgYnV0IHdlIGRvIG5vdCBoYXZlIGFueSBiZXR0ZXIg
aWRlYSB5ZXQuCj4gPiBDdXJyZW50bHkgd2UgaGF2ZSB0aHJlZSBmYWtlIHBjaSBkZXZpY2VzLCB3
aGljaCBzdXBwb3J0IHN0YWxsIGFuZCBwYXNpZC4KPiA+IFdlIGhhdmUgdG8gbGV0IHBjaSBzeXN0
ZW0ga25vdyB0aGUgZGV2aWNlIGNhbiBzdXBwb3J0IHBhc2lkLCBiZWNhdXNlIG9mCj4gPiBzdGFs
bCBmZWF0dXJlLCB0aG91Z2ggbm90IHN1cHBvcnQgcHJpLgo+ID4gRG8geW91IGhhdmUgYW55IG90
aGVyIGlkZWFzPwo+IAo+IEl0IHNvdW5kcyBsaWtlIHRoZSBiZXN0IHdheSB3b3VsZCBiZSB0byBh
bGxvY2F0ZSBhIFBDSSBjYXBhYmlsaXR5IGZvciBpdCwgc28KPiBkZXRlY3Rpb24gY2FuIGJlIGRv
bmUgdGhyb3VnaCBjb25maWcgc3BhY2UsIGF0IGxlYXN0IGluIGZ1dHVyZSBkZXZpY2VzLAo+IG9y
IHBvc3NpYmx5IGFmdGVyIGEgZmlybXdhcmUgdXBkYXRlIGlmIHRoZSBjb25maWcgc3BhY2UgaW4g
eW91ciBzeXN0ZW0KPiBpcyBjb250cm9sbGVkIGJ5IGZpcm13YXJlIHNvbWV3aGVyZS4gIE9uY2Ug
dGhlcmUgaXMgYSBwcm9wZXIgbWVjaGFuaXNtCj4gdG8gZG8gdGhpcywgdXNpbmcgZml4dXBzIHRv
IGRldGVjdCB0aGUgZWFybHkgZGV2aWNlcyB0aGF0IGRvbid0IHVzZSB0aGF0Cj4gc2hvdWxkIGJl
IHVuY29udHJvdmVyc2lhbC4gSSBoYXZlIG5vIGlkZWEgd2hhdCB0aGUgcHJvY2VzcyBvciB0aW1l
bGluZQo+IGlzIHRvIGFkZCBuZXcgY2FwYWJpbGl0aWVzIGludG8gdGhlIFBDSWUgc3BlY2lmaWNh
dGlvbiwgb3IgaWYgdGhpcyBvbmUKPiB3b3VsZCBiZSBhY2NlcHRhYmxlIHRvIHRoZSBQQ0kgU0lH
IGF0IGFsbC4KClRoYXQgc291bmRzIGxpa2UgYSBwb3NzaWJpbGl0eS4gIFRoZSBzcGVjIGFscmVh
ZHkgZGVmaW5lcyBhClZlbmRvci1TcGVjaWZpYyBFeHRlbmRlZCBDYXBhYmlsaXR5IChQQ0llIHI1
LjAsIHNlYyA3LjkuNSkgdGhhdCBtaWdodApiZSBhIGNhbmRpZGF0ZS4KCj4gSWYgZGV0ZWN0aW9u
IGNhbm5vdCBiZSBkb25lIHRocm91Z2ggUENJIGNvbmZpZyBzcGFjZSwgdGhlIG5leHQgYmVzdAo+
IGFsdGVybmF0aXZlIGlzIHRvIHBhc3MgYXV4aWxpYXJ5IGRhdGEgdGhyb3VnaCBmaXJtd2FyZS4g
T24gRFQgYmFzZWQKPiBtYWNoaW5lcywgeW91IGNhbiBsaXN0IG5vbi1ob3RwbHVnZ2FibGUgUENJ
ZSBkZXZpY2VzIGFuZCBhZGQgY3VzdG9tCj4gcHJvcGVydGllcyB0aGF0IGNvdWxkIGJlIHJlYWQg
ZHVyaW5nIGRldmljZSBlbnVtZXJhdGlvbi4gSSBhc3N1bWUKPiBBQ1BJIGhhcyBzb21ldGhpbmcg
c2ltaWxhciwgYnV0IEkgaGF2ZSBub3QgZG9uZSB0aGF0LgoKQUNQSSBoYXMgX0RTTSAoQUNQSSB2
Ni4zLCBzZWMgOS4xLjEpLCB3aGljaCBtaWdodCBiZSBhIGNhbmRpZGF0ZS4gIEkKbGlrZSB0aGlz
IGJldHRlciB0aGFuIGEgUENJIGNhcGFiaWxpdHkgYmVjYXVzZSB0aGUgcHJvcGVydHkgeW91IG5l
ZWQKdG8gZXhwb3NlIGlzIG5vdCBhIFBDSSBwcm9wZXJ0eS4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
