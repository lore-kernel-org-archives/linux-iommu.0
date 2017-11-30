From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: BSOD with [PATCH 00/13] mmu_notifier kill invalidate_page callback
Date: Thu, 30 Nov 2017 12:20:47 +0100
Message-ID: <39823aee-4918-f87c-8342-89eff622ee43@redhat.com>
References: <20170829235447.10050-1-jglisse@redhat.com>
	<20171130093320.66cxaoj45g2ttzoh@nora.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171130093320.66cxaoj45g2ttzoh-aVfaTQcAavps8ZkLLAvlZtBPR1lH4CV8@public.gmane.org>
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
To: =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, "Kirill A . Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dimitri Sivanich <sivanich-sJ/iWh9BUns@public.gmane.org>, Jack Steiner <steiner-sJ/iWh9BUns@public.gmane.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gMzAvMTEvMjAxNyAxMDozMywgRmFiaWFuIEdyw7xuYmljaGxlciB3cm90ZToKPiAKPiBJdCB3
YXMgcmV2ZXJ0ZWQgaW4gNzg1MzczYjRjMzg3MTlmNGFmNjc3NTg0NWRmNmJlMWRmYWVhMTIwZiBh
ZnRlciB3aGljaAo+IHRoZSBzeW1wdG9tcyBkaXNhcHBlYXJlZCB1bnRpbCB0aGlzIHNlcmllcyB3
YXMgbWVyZ2VkLCB3aGljaCBjb250YWlucwo+IAo+IDM2OWVhODI0MmMwZmI1MjM5YjRkZGYwZGM1
NjhmNjk0YmQyNDRkZTQgbW0vcm1hcDogdXBkYXRlIHRvIG5ldyBtbXVfbm90aWZpZXIgc2VtYW50
aWMgdjIKPiAKPiBXZSBoYXZlbid0IGJpc2VjdGVkIHRoZSBpbmRpdmlkdWFsIGNvbW1pdHMgb2Yg
dGhlIHNlcmllcyB5ZXQsIGJ1dCB0aGUKPiBjb21taXQgaW1tZWRpYXRlbHkgcHJlY2VkaW5nIGl0
cyBtZXJnZSBleGhpYml0cyBubyBwcm9ibGVtcywgd2hpbGUKPiBldmVyeXRoaW5nIGFmdGVyIGRv
ZXMuIEl0IGlzIG5vdCBrbm93biB3aGV0aGVyIHRoZSBidWcgaXMgYWN0dWFsbHkgaW4KPiB0aGUg
c2VyaWVzIGl0c2VsZiwgb3Igd2hldGhlciBpbmNyZWFzaW5nIHRoZSBsaWtlbGlob29kIG9mIHRy
aWdnZXJpbmcgaXQKPiBpcyBqdXN0IGEgc2lkZS1lZmZlY3QuIFRoZXJlIGlzIGEgc2ltaWxhciBy
ZXBvcnRbMl0gY29uY2VybmluZyBhbgo+IHVwZ3JhZGUgZnJvbSA0LjEyLjEyIHRvIDQuMTIuMTMs
IHdoaWNoIGRvZXMgbm90IGNvbnRhaW4gdGhpcyBzZXJpZXMgaW4KPiBhbnkgZm9ybSBBRkFJQ1Qg
YnV0IG1pZ2h0IGJlIHdvcnRoIGFub3RoZXIgbG9vayBhcyB3ZWxsLgoKSSBrbm93IG9mIG9uZSBp
c3N1ZSBpbiB0aGlzIHNlcmllcyAoaW52YWxpZGF0ZV9wYWdlIHdhcyByZW1vdmVkIGZyb20gS1ZN
CndpdGhvdXQgcmVpbXBsZW1lbnRpbmcgaXQgYXMgaW52YWxpZGF0ZV9yYW5nZSkuICBJJ2xsIHRy
eSB0byBwcmlvcml0aXplCnRoZSBmaXgsIGJ1dCBJIGRvbid0IHRoaW5rIEkgY2FuIGRvIGl0IGJl
Zm9yZSBNb25kYXkuCgpUaGFua3MsCgpQYW9sbwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
