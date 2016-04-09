From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT v2] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Fri, 8 Apr 2016 17:25:49 -0700
Message-ID: <CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw@mail.gmail.com>
References: <20160316171719.GE2195@8bytes.org>
	<1459273313-5139-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1459273313-5139-1-git-send-email-mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gVHVlLCBNYXIgMjksIDIwMTYgYXQgMTA6NDEgQU0sIEx1aXMgUi4gUm9kcmlndWV6IDxtY2dy
b2ZAa2VybmVsLm9yZz4gd3JvdGU6Cj4gV2UgbmVlZCB0byBlbnN1cmUgYW1kIGlvbW11IHYyIGlu
aXRpYWxpemVzIGJlZm9yZQo+IGRyaXZlciB1c2VzIHN1Y2ggYXMgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21vZHVsZS5jLAo+IHRvIGRvIHRoaXMgbWFrZSBpdHMgaW5pdCByb3V0aW5l
IGEgc3Vic3lzX2luaXRjYWxsKCkgd2hpY2gKPiBlbnN1cmVzIGl0cyBsb2FkIGluaXQgaXMgY2Fs
bGVkIGZpcnN0IHRoYW4gbW9kdWxlcyB3aGVuCj4gYnVpbHQtaW4uCj4KPiBUaGlzIHJldmVydHMg
dGhlIG9sZCB3b3JrIGFyb3VuZCBpbXBsZW1lbnRlZCB0aHJvdWdoIGNvbW1pdAo+IDFiYWNjODk0
YzIyN2ZhZDhhNyAoImRyaXZlcnM6IE1vdmUgaW9tbXUvIGJlZm9yZSBncHUvIGluIE1ha2VmaWxl
IiksCj4gaW5zdGVhZCBvZiBtYWtpbmcgdGhlIGRlcGVuZGVuY3kgaW1wbGljaXQgYnkgbGlua2Vy
IG9yZGVyIHRoaXMKPiBtYWtlcyB0aGUgb3JkZXJpbmcgcmVxdWlyZW1lbnQgZXhwbGljaXQgdGhy
b3VnaCBwcm9wZXIga2VybmVsCj4gQVBJcy4KPgo+IENjOiBPZGVkIEdhYmJheSA8b2RlZC5nYWJi
YXlAYW1kLmNvbT4KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IEx1aXMgUi4gUm9kcmlndWV6IDxtY2dyb2ZAa2VybmVsLm9y
Zz4KCipwb2tlKgoKIEx1aXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
