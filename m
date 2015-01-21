From: Radim =?utf-8?B?S3I/bcOhPw==?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for
	VT-d PI
Date: Wed, 21 Jan 2015 22:16:23 +0100
Message-ID: <20150121211620.GA27504@potion.brq.redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-14-git-send-email-feng.wu@intel.com>
	<20150109145435.GA22469@potion.brq.redhat.com>
	<54AFEC00.80507@redhat.com>
	<E959C4978C3B6342920538CF579893F002341102@SHSMSX104.ccr.corp.intel.com>
	<20150113161716.GA12941@potion.brq.redhat.com>
	<E959C4978C3B6342920538CF579893F00234E4CD@SHSMSX104.ccr.corp.intel.com>
	<20150114165909.GA1283@potion.brq.redhat.com>
	<6A3B67DA-EDAA-4DE5-BE59-96B693D7BB86@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6A3B67DA-EDAA-4DE5-BE59-96B693D7BB86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

MjAxNS0wMS0yMCAyMzowNCswMjAwLCBOYWRhdiBBbWl0Ogo+IFJhZGltIEtyP23DoT8gPHJrcmNt
YXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAyMDE1LTAxLTE0IDAxOjI3KzAwMDAsIFd1LCBGZW5n
Ogo+ID4+PiB0aGUgbmV3Cj4gPj4+PiBoYXJkd2FyZSBldmVuIGRvZXNuJ3QgY29uc2lkZXIgdGhl
IFRQUiBmb3IgbG93ZXN0IHByaW9yaXR5IGludGVycnVwdHMKPiA+Pj4gZGVsaXZlcnkuCj4gPj4+
IAo+ID4+PiBBIGJvbGQgbW92ZSAuLi4gd2hhdCBoYXJkd2FyZSB3YXMgdGhlIGZpcnN0IHRvIGRv
IHNvPwo+ID4+IAo+ID4+IEkgdGhpbmsgaXQgd2FzIHN0YXJ0aW5nIHdpdGggTmVoYWxlbS4KPiA+
IAo+ID4gVGhhbmtzLCAgKENvdWxkIGJlIHRoYXQgUVBJIGNhbid0IGluZm9ybSBhYm91dCBUUFIg
Y2hhbmdlcyBhbnltb3JlIC4uLikKPiA+IAo+ID4gSSBwbGF5ZWQgd2l0aCBMaW51eCdzIFRQUiBv
biBIYXN3ZWxsIGFuZCBmb3VuZCB0aGF0IGlzIGhhcyBubyBlZmZlY3QuCj4gCj4gU29ycnkgZm9y
IGp1bXBpbmcgaW50byB0aGUgZGlzY3Vzc2lvbiwgYnV0IGRvZXNu4oCZdCBpdCBkZXBlbmQgb24K
PiBJQTMyX01JU0NfRU5BQkxFWzIzXT8gVGhpcyBiaXQgZGlzYWJsZXMgeFRQUiBtZXNzYWdlcy4g
T24gbXkgbWFjaGluZSBpdCBpcwo+IHNldCAocHJvYmFibHkgYnkgdGhlIEJJT1MpLCBidXQgc2lu
Y2UgdGhlcmUgaXMgbm8gSUEzMl9NSVNDX0VOQUJMRSBpcyBub3QKPiBsb2NrZWQgZm9yIGNoYW5n
ZXMsIHRoZSBPUyBjYW4gY29udHJvbCBpdC4KClRoYW5rcywgSSBkaWRuJ3Qga25vdyBhYm91dCBp
dC4KT24gSXZ5IEJyaWRnZSBFUCAodGhlIG9ubHkgbW9kZXJuIG1hY2hpbmUgYXQgaGFuZCksIHRo
ZSBiaXQgd2FzIHNldCBieQpkZWZhdWx0LiAgQWZ0ZXIgY2xlYXJpbmcgaXQsIFRQUiBzdGlsbCBo
YWQgbm8gZWZmZWN0LgoKVGhlIG1vc3QgcmVsZXZhbnQgbWVudGlvbiBvZiB4VFBSIEkgZm91bmQg
aXMgcmVsYXRlZCB0byBGU0IgWzFdLgpbMl0gaXNuJ3QgZW5saWdodGVuaW5nLCBzbyB0aGVyZSBt
aWdodCBiZSBtb3JlIGZyb20gUVBJLWVyYSAuLi4KCgotLS0KMTogSW50ZWzCriBFNzMyMCBNZW1v
cnkgQ29udHJvbGxlciBIdWIgKE1DSCkgRGF0YXNoZWV0CiAgIGh0dHA6Ly93d3cuaW50ZWwuY29t
L2NvbnRlbnQvZGFtL2RvYy9kYXRhc2hlZXQvZTczMjAtbWVtb3J5LWNvbnRyb2xsZXItaHViLWRh
dGFzaGVldC5wZGYKICAgNS4yLjIgU3lzdGVtIEJ1cyBJbnRlcnJ1cHRzCjI6IEludGVswq4gWGVv
bsKuIFByb2Nlc3NvciBFNSB2MiBGYW1pbHk6IERhdGFzaGVldCwgVm9sLiAyCiAgIGh0dHA6Ly93
d3cuaW50ZWwuY29tL2NvbnRlbnQvZGFtL3d3dy9wdWJsaWMvdXMvZW4vZG9jdW1lbnRzL2RhdGFz
aGVldHMveGVvbi1lNS12Mi1kYXRhc2hlZXQtdm9sLTIucGRmCiAgIDYuMS4yIEludENvbnRyb2wK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
