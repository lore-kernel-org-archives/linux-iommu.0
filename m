From: Joe Jin <joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
	leaving critical section
Date: Fri, 12 Apr 2019 07:13:59 -0700
Message-ID: <5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1555069106-2964-1-git-send-email-dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
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
To: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: haakon.bugge-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

SSdtIGdvb2QgdG8gaGF2ZSB0aGlzIHBhdGNoLCB3aGljaCBoZWxwcyBpZGVudGlmeSB0aGUgY2F1
c2Ugb2YgZmFpbHVyZSBpcwpmcmFnbWVudGF0aW9uIG9yIGl0IHJlYWxseSBiZWVuIHVzZWQgdXAu
CgpPbiA0LzEyLzE5IDQ6MzggQU0sIERvbmdsaSBaaGFuZyB3cm90ZToKPiBXaGVuIHN3aW90bGIg
aXMgZnVsbCwgdGhlIGtlcm5lbCB3b3VsZCBwcmludCBpb190bGJfdXNlZC4gSG93ZXZlciwgdGhl
Cj4gcmVzdWx0IG1pZ2h0IGJlIGluYWNjdXJhdGUgYXQgdGhhdCB0aW1lIGJlY2F1c2Ugd2UgaGF2
ZSBsZWZ0IHRoZSBjcml0aWNhbAo+IHNlY3Rpb24gcHJvdGVjdGVkIGJ5IHNwaW5sb2NrLgo+IAo+
IFRoZXJlZm9yZSwgd2UgYmFja3VwIHRoZSBpb190bGJfdXNlZCBpbnRvIGxvY2FsIHZhcmlhYmxl
IGJlZm9yZSBsZWF2aW5nCj4gY3JpdGljYWwgc2VjdGlvbi4KPiAKPiBGaXhlczogODNjYTI1OTQ4
OTQwICgic3dpb3RsYjogZHVtcCB1c2VkIGFuZCB0b3RhbCBzbG90cyB3aGVuIHN3aW90bGIgYnVm
ZmVyIGlzIGZ1bGwiKQo+IFN1Z2dlc3RlZC1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VA
b3JhY2xlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBEb25nbGkgWmhhbmcgPGRvbmdsaS56aGFuZ0Bv
cmFjbGUuY29tPgoKUmV2aWV3ZWQtYnk6IEpvZSBKaW4gPGpvZS5qaW5Ab3JhY2xlLmNvbT4gCgpU
aGFua3MsCkpvZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
