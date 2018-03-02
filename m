From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
Date: Fri, 2 Mar 2018 16:42:25 +0000
Message-ID: <ebd22a3b-8507-8fd1-3efb-357931613c47@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-4-jean-philippe.brucker@arm.com>
	<5A97A324.9050605@linux.intel.com>
	<cd4d7a98-e45e-7066-345f-52d8eef926a2@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cd4d7a98-e45e-7066-345f-52d8eef926a2-5C7GfCeVMHo@public.gmane.org>
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
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gMDEvMDMvMTggMDg6MDQsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDEuMDMuMjAx
OCB1bSAwNzo1MiBzY2hyaWViIEx1IEJhb2x1Ogo+PiBIaSBKZWFuLAo+Pgo+PiBPbiAwMi8xMy8y
MDE4IDAyOjMzIEFNLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4+PiBbU05JUF0KPj4+
ICsJcGFzaWQgPSBpZHJfYWxsb2NfY3ljbGljKCZpb21tdV9wYXNpZF9pZHIsIGlvX21tLCBkZXZf
cGFyYW0tPm1pbl9wYXNpZCwKPj4+ICsJCQkJIGRldl9wYXJhbS0+bWF4X3Bhc2lkICsgMSwgR0ZQ
X0FUT01JQyk7Cj4+IENhbiB0aGUgcGFzaWQgbWFuYWdlbWVudCBjb2RlIGJlIG1vdmVkIGludG8g
YSBjb21tb24gbGlicmFyeT8KPj4gUEFTSUQgaXMgbm90IHN0aWNrIHRvIFNWQS4gQW4gSU9NTVUg
bW9kZWwgZGV2aWNlIGNvdWxkIGJlIGRlc2lnbmVkCj4+IHRvIHVzZSBQQVNJRCBmb3Igc2Vjb25k
IGxldmVsIHRyYW5zbGF0aW9uIChjbGFzc2ljYWwgRE1BIHRyYW5zbGF0aW9uKQo+PiBhcyB3ZWxs
Lgo+IAo+IFllYWgsIHdlIGhhdmUgdGhlIHNhbWUgcHJvYmxlbSBvbiBhbWRncHUuCj4gCj4gV2Ug
YXNzaWduIFBBU0lEcyB0byBjbGllbnRzIGV2ZW4gd2hlbiBJT01NVSBpc24ndCBwcmVzZW50IGlu
IHRoZSBzeXN0ZW0gCj4ganVzdCBiZWNhdXNlIHdlIG5lZWQgaXQgZm9yIGRlYnVnZ2luZy4KPiAK
PiBFLmcuIHdoZW4gdGhlIGhhcmR3YXJlIGRldGVjdHMgdGhhdCBzb21lIHNoYWRlciBwcm9ncmFt
IGlzIGRvaW5nIAo+IHNvbWV0aGluZyBuYXN0eSB3ZSBnZXQgdGhlIFBBU0lEIGluIHRoZSBpbnRl
cnJ1cHQgYW5kIGNvdWxkIGZvciBleGFtcGxlIAo+IHVzZSBpdCB0byBpbmZvcm0gdGhlIGNsaWVu
dCBhYm91dCB0aGUgZmF1bHQuCgpUaGlzIHNlZW1zIGxpa2UgYSBuZXcgcmVxdWlyZW1lbnQgYWx0
b2dldGhlciwgYW5kIGEgYml0IG91dHNpZGUgdGhlCnNjb3BlIG9mIHRoaXMgc2VyaWVzIHRvIGJl
IGhvbmVzdC4gSXMgdGhlIGNsaWVudCB1c2Vyc3BhY2UgaW4gdGhpcwpjb250ZXh0PyBJIGd1ZXNz
IGl0IHdvdWxkIGJlIG1vc3RseSBmb3IgcHJvdG90eXBpbmcgdGhlbj8gT3RoZXJ3aXNlIHlvdQpw
cm9iYWJseSBkb24ndCB3YW50IHRvIGhhbmQgR1BVIGNvbnRleHRzIHRvIHVzZXJzcGFjZSB3aXRo
b3V0IGFuIElPTU1VCmlzb2xhdGluZyB0aGVtPwoKSWYgeW91IGRvbid0IG5lZWQgbW0gdHJhY2tp
bmcvc2hhcmluZyBvciBpb21tdV9tYXAvdW5tYXAsIHRoZW4gbWF5YmUgYW4KSURSIHByaXZhdGUg
dG8gdGhlIEdQVSBkcml2ZXIgd291bGQgYmUgZW5vdWdoPyBJZiB5b3UgZG8gbmVlZCBtbQp0cmFj
a2luZywgSSBzdXBwb3NlIHdlIGNvdWxkIG1vZGlmeSBpb21tdV9zdmFfYmluZCgpIHRvIGFsbG9j
YXRlIGFuZAp0cmFjayBpb19tbSBldmVuIGlmIHRoZSBnaXZlbiBkZXZpY2UgZG9lc24ndCBoYXZl
IGFuIElPTU1VLCBidXQgaXQgc2VlbXMKYSBiaXQgYmFja3dhcmQuCgpUaGFua3MsCkplYW4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
