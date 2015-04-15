From: Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Wed, 15 Apr 2015 11:20:51 +0900
Message-ID: <CAAFQd5Db+DacQYa1pdr=w5JpU76AYa-Xhd20wHBF=F6m=Efokw@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA@mail.gmail.com>
	<1426677749.22581.38.camel@mhfsdcap03>
	<CAAFQd5DOzFmfXki8GwUC75VQFEWzxBUNUgOtSuRtV6tc27kD2A@mail.gmail.com>
	<1428993067.13552.14.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1428993067.13552.14.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gVHVlLCBBcHIgMTQsIDIwMTUgYXQgMzozMSBQTSwgWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+IHdyb3RlOgo+PiA+Pgo+PiA+PiA+ICsKPj4gPj4gPiArICAgICAgIHBpb21tdS0+cHJv
dGVjdF92YSA9IGRldm1fa21hbGxvYyhwaW9tbXUtPmRldiwgTVRLX1BST1RFQ1RfUEFfQUxJR04q
MiwKPj4gPj4KPj4gPj4gc3R5bGU6IE9wZXJhdG9ycyBsaWtlICogc2hvdWxkIGhhdmUgc3BhY2Ug
b24gYm90aCBzaWRlcy4KPj4gPj4KPj4gPj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBHRlBfS0VSTkVMKTsKPj4gPj4KPj4gPj4gU2hvdWxkbid0IGRtYV9hbGxv
Y19jb2hlcmVudCgpIGJlIHVzZWQgZm9yIHRoaXM/Cj4+ID4gICAgICBXZSBkb24ndCBjYXJlIHRo
ZSBkYXRhIGluIGl0LiBJIHRoaW5rIHRoZXkgYXJlIHRoZSBzYW1lLiBDb3VsZCB5b3UKPj4gPiBo
ZWxwIHRlbGwgbWUgd2h5IGRtYV9hbGxvY19jb2hlcmVudCBtYXkgYmUgYmV0dGVyLgo+Pgo+PiBD
YW4geW91IGd1YXJhbnRlZSB0aGF0IGF0IHRoZSB0aW1lIHlvdSBhbGxvY2F0ZSB0aGUgbWVtb3J5
IHVzaW5nCj4+IGRldm1fa21hbGxvYygpIHRoZSBtZW1vcnkgaXMgbm90IGRpcnR5IChpLmUuIHNv
bWUgd3JpdGUgYmFjayBkYXRhIGFyZQo+PiBzdG9yZWQgaW4gQ1BVIGNhY2hlKSBhbmQgaXMgbm90
IGdvaW5nIHRvIGJlIHdyaXR0ZW4gYmFjayBpbiBzb21lIHRpbWUsCj4+IG92ZXJ3cml0aW5nIGRh
dGEgcHV0IHRoZXJlIGJ5IElPTU1VIGhhcmR3YXJlPwo+Pgo+IEFzIEkgbm90ZWQgaW4gdGhlIGZ1
bmN0aW9uICJtdGtfaW9tbXVfaHdfaW5pdCI6Cj4KPiAgICAgICAgLyogcHJvdGVjdCBtZW1vcnks
SFcgd2lsbCB3cml0ZSBoZXJlIHdoaWxlIHRyYW5zbGF0aW9uIGZhdWx0ICovCj4gICAgICAgIHBy
b3RlY3RwYSA9IF9fdmlydF90b19waHlzKHBpb21tdS0+cHJvdGVjdF92YSk7Cj4KPiAgICAgIFdl
IGRvbuKAmXQgY2FyZSB0aGUgY29udGVudCBvZiB0aGlzIGJ1ZmZlciwgSXQgaXMgb2sgZXZlbiB0
aG91Z2ggaXRzCj4gZGF0YSBpcyBkaXJ0eS4KPiAgICAgSXQgc2VlbSB0byBiZSBhIHRoZSBwcm90
ZWN0IG1lbW9yeS4gV2hpbGUgYSB0cmFuc2xhdGlvbiBmYXVsdAo+IGhhcHBlbmVkLCBUaGUgaW9t
bXUgSFcgd2lsbCBvdmVyd3JpdGUgaGVyZSBpbnN0ZWFkIG9mIHdyaXRpbmcgdG8gdGhlCj4gZmF1
bHQgcGh5c2ljYWwgYWRkcmVzcyB3aGljaCBtYXkgYmUgMCBvciBzb21lIHJhbmRvbSBhZGRyZXNz
Lgo+CgpEbyB5b3UgbWVhbiB0aGF0IGl0J3MganVzdCBhIGR1bW15IHBhZ2UgZm9yIGhhcmR3YXJl
IGJlaGluZCB0aGUgSU9NTVUKdG8gYWNjZXNzIHdoZW4gdGhlIG1hcHBpbmcgaXMgbm90IGF2YWls
YWJsZT8gSG93IHdvdWxkIHRoYXQgd29yayB3aXRoCnBvdGVudGlhbCBvbiBkZW1hbmQgcGFnaW5n
IHdoZW4gdGhlIGhhcmR3YXJlIG5lZWRzIHRvIGJlIGJsb2NrZWQgdW50aWwKdGhlIG1hcHBpbmcg
aXMgY3JlYXRlZD8KCkJlc3QgcmVnYXJkcywKVG9tYXN6Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
