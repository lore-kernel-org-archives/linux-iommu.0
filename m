From: Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
	VT-d PI
Date: Tue, 20 Jan 2015 23:04:14 +0200
Message-ID: <6A3B67DA-EDAA-4DE5-BE59-96B693D7BB86@gmail.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-14-git-send-email-feng.wu@intel.com>
	<20150109145435.GA22469@potion.brq.redhat.com>
	<54AFEC00.80507@redhat.com>
	<E959C4978C3B6342920538CF579893F002341102@SHSMSX104.ccr.corp.intel.com>
	<20150113161716.GA12941@potion.brq.redhat.com>
	<E959C4978C3B6342920538CF579893F00234E4CD@SHSMSX104.ccr.corp.intel.com>
	<20150114165909.GA1283@potion.brq.redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150114165909.GA1283-KfRq7+sF/6zkZJWtSm8s3NvLeJWuRmrY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?utf-8?Q?Radim_Kr=3Fm=C3=A1=3F?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

UmFkaW0gS3I/bcOhPyA8cmtyY21hckByZWRoYXQuY29tPiB3cm90ZToKCj4gMjAxNS0wMS0xNCAw
MToyNyswMDAwLCBXdSwgRmVuZzoKPj4+IHRoZSBuZXcKPj4+PiBoYXJkd2FyZSBldmVuIGRvZXNu
J3QgY29uc2lkZXIgdGhlIFRQUiBmb3IgbG93ZXN0IHByaW9yaXR5IGludGVycnVwdHMKPj4+IGRl
bGl2ZXJ5Lgo+Pj4gCj4+PiBBIGJvbGQgbW92ZSAuLi4gd2hhdCBoYXJkd2FyZSB3YXMgdGhlIGZp
cnN0IHRvIGRvIHNvPwo+PiAKPj4gSSB0aGluayBpdCB3YXMgc3RhcnRpbmcgd2l0aCBOZWhhbGVt
Lgo+IAo+IFRoYW5rcywgIChDb3VsZCBiZSB0aGF0IFFQSSBjYW4ndCBpbmZvcm0gYWJvdXQgVFBS
IGNoYW5nZXMgYW55bW9yZSAuLi4pCj4gCj4gSSBwbGF5ZWQgd2l0aCBMaW51eCdzIFRQUiBvbiBI
YXN3ZWxsIGFuZCBmb3VuZCB0aGF0IGlzIGhhcyBubyBlZmZlY3QuCgpTb3JyeSBmb3IganVtcGlu
ZyBpbnRvIHRoZSBkaXNjdXNzaW9uLCBidXQgZG9lc27igJl0IGl0IGRlcGVuZCBvbgpJQTMyX01J
U0NfRU5BQkxFWzIzXT8gVGhpcyBiaXQgZGlzYWJsZXMgeFRQUiBtZXNzYWdlcy4gT24gbXkgbWFj
aGluZSBpdCBpcwpzZXQgKHByb2JhYmx5IGJ5IHRoZSBCSU9TKSwgYnV0IHNpbmNlIHRoZXJlIGlz
IG5vIElBMzJfTUlTQ19FTkFCTEUgaXMgbm90CmxvY2tlZCBmb3IgY2hhbmdlcywgdGhlIE9TIGNh
biBjb250cm9sIGl0LgoKTmFkYXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
