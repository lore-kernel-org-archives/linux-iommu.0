From: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
	leaving critical section
Date: Mon, 15 Apr 2019 14:50:49 +0800
Message-ID: <38f6f868-013e-5619-b939-a8273fc64ee4@oracle.com>
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
	<5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5bdc3265-e5a4-e8c8-9098-0bba18a66f19-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
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
To: Joe Jin <joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: haakon.bugge-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

QXMgdGhlIHBhdGNoIHRvIGJlIGZpeGVkIGlzIHN0aWxsIGluIEtvbnJhZCdzIG93biB0cmVlLCBJ
IHdpbGwgc2VuZCB0aGUgdjIgZm9yCnRoZSBwYXRjaCB0byBiZSBmaXhlZCwgaW5zdGVhZCBvZiBh
biBpbmNyZW1lbnRhbCBmaXguCgpEb25nbGkgWmhhbmcKCk9uIDQvMTIvMTkgMTA6MTMgUE0sIEpv
ZSBKaW4gd3JvdGU6Cj4gSSdtIGdvb2QgdG8gaGF2ZSB0aGlzIHBhdGNoLCB3aGljaCBoZWxwcyBp
ZGVudGlmeSB0aGUgY2F1c2Ugb2YgZmFpbHVyZSBpcwo+IGZyYWdtZW50YXRpb24gb3IgaXQgcmVh
bGx5IGJlZW4gdXNlZCB1cC4KPiAKPiBPbiA0LzEyLzE5IDQ6MzggQU0sIERvbmdsaSBaaGFuZyB3
cm90ZToKPj4gV2hlbiBzd2lvdGxiIGlzIGZ1bGwsIHRoZSBrZXJuZWwgd291bGQgcHJpbnQgaW9f
dGxiX3VzZWQuIEhvd2V2ZXIsIHRoZQo+PiByZXN1bHQgbWlnaHQgYmUgaW5hY2N1cmF0ZSBhdCB0
aGF0IHRpbWUgYmVjYXVzZSB3ZSBoYXZlIGxlZnQgdGhlIGNyaXRpY2FsCj4+IHNlY3Rpb24gcHJv
dGVjdGVkIGJ5IHNwaW5sb2NrLgo+Pgo+PiBUaGVyZWZvcmUsIHdlIGJhY2t1cCB0aGUgaW9fdGxi
X3VzZWQgaW50byBsb2NhbCB2YXJpYWJsZSBiZWZvcmUgbGVhdmluZwo+PiBjcml0aWNhbCBzZWN0
aW9uLgo+Pgo+PiBGaXhlczogODNjYTI1OTQ4OTQwICgic3dpb3RsYjogZHVtcCB1c2VkIGFuZCB0
b3RhbCBzbG90cyB3aGVuIHN3aW90bGIgYnVmZmVyIGlzIGZ1bGwiKQo+PiBTdWdnZXN0ZWQtYnk6
IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6
IERvbmdsaSBaaGFuZyA8ZG9uZ2xpLnpoYW5nQG9yYWNsZS5jb20+Cj4gCj4gUmV2aWV3ZWQtYnk6
IEpvZSBKaW4gPGpvZS5qaW5Ab3JhY2xlLmNvbT4gCj4gCj4gVGhhbmtzLAo+IEpvZQo+IApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
