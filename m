From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Mon, 30 Apr 2018 14:57:58 -0500
Message-ID: <d4534417-0fc0-5e38-ab80-2ffc9cfee2fa@amd.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
	<152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
	<1523664612.2747.13.camel@intel.com>
	<efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <efa2b7a3-04a7-20b1-3651-89ebafa85c27-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>, "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMDQvMTcvMjAxOCAxMjozOCBQTSwgSG9vaywgR2FyeSB3cm90ZToKPiBPbiA0LzEzLzIwMTgg
ODowOCBQTSwgTWVodGEsIFNvaGlsIHdyb3RlOgo+PiBPbiBGcmksIDIwMTgtMDQtMDYgYXQgMDg6
MTcgLTA1MDAsIEdhcnkgUiBIb29rIHdyb3RlOgo+Pj4gKwo+Pj4gKwo+Pj4gK8KgwqDCoCBtdXRl
eF9sb2NrKCZhbWRfaW9tbXVfZGVidWdmc19sb2NrKTsKPj4+ICvCoMKgwqAgaWYgKCFhbWRfaW9t
bXVfZGVidWdmcykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIGRfdG9wID0gaW9tbXVfZGVidWdmc19z
ZXR1cCgpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChkX3RvcCkKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGFtZF9pb21tdV9kZWJ1Z2ZzID0KPj4+IGRlYnVnZnNfY3JlYXRlX2RpcigiYW1k
IiwgZF90b3ApOwo+Pj4gK8KgwqDCoCB9Cj4+PiArwqDCoMKgIG11dGV4X3VubG9jaygmYW1kX2lv
bW11X2RlYnVnZnNfbG9jayk7Cj4+Cj4+Cj4+IFlvdSBjYW4gZG8gdGhlIGFib3ZlIG9ubHkgb25j
ZSBpZiB5b3UgaXRlcmF0ZSBvdmVyIHRoZSBJT01NVXMgaGVyZQo+PiDCoMKgaW5zdGVhZCBvZiBk
b2luZyBpdCBpbsKgYW1kX2lvbW11X2luaXQuCj4gCj4gSSdtIG5vdCBzdXJlIGl0IG1hdHRlcnMs
IGdpdmVuIHRoZSBmaW5pdGUgbnVtYmVyIG9mIElPTU1VcyBpbiBhIHN5c3RlbSwgCj4gYW5kIHRo
ZSBmYWN0IHRoYXQgdGhpcyB3b3JrIGlzIGRvbmUgZXhhY3RseSBvbmNlLiBIb3dldmVyLCByZW1v
dmFsIG9mIGEgCj4gbG9jayBpcyBmaW5lIHRoaW5nLCBzbyBJJ2xsIG1vdmUgdGhpcyBhcm91bmQu
CgpBZnRlciB0aGlua2luZyBhYm91dCB0aGlzLCBhbmQgbG9va2luZyBhdCB0aGUgY29kZSwgSSd2
ZSBkZWNpZGVkIHRvIApsZWF2ZSB0aGlzIGFsb25lLgoKdjQgaXMgb24gaXRzIHdheS4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
