From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 7/7] iommu/vt-d: Implement page request
 handling
Date: Sat, 10 Oct 2015 17:54:48 +0100
Message-ID: <20151010165448.GA14122@nuc-i3427.alporthouse.com>
References: <1444348223.92154.22.camel@infradead.org>
 <1444348447.92154.35.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1444348447.92154.35.camel@infradead.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux-foundation.org, jesse.barnes@intel.com, intel-gfx@lists.freedesktop.org
List-Id: iommu@lists.linux-foundation.org

T24gRnJpLCBPY3QgMDksIDIwMTUgYXQgMTI6NTQ6MDdBTSArMDEwMCwgRGF2aWQgV29vZGhvdXNl
IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdvb2Rob3VzZSA8RGF2aWQuV29vZGhvdXNl
QGludGVsLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9pb21tdS9pbnRlbC1zdm0uYyAgIHwgMTE1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gIGluY2x1ZGUvbGlu
dXgvaW50ZWwtaW9tbXUuaCB8ICAyMSArKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDEzNCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2ludGVsLXN2bS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1zdm0uYwo+IGluZGV4IDEyNjBl
ODcuLmFjZTFlMzIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC1zdm0uYwo+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtc3ZtLmMKPiAgc3RhdGljIGlycXJldHVybl90IHBycV9l
dmVudF90aHJlYWQoaW50IGlycSwgdm9pZCAqZCkKPiAgewoKPiArCWlmIChzdm0pIHsKPiArCQlt
dXRleF9sb2NrKCZwYXNpZF9tdXRleCk7Cj4gKwkJa3JlZl9wdXQoJnN2bS0+a3JlZiwgJmludGVs
X21tX2ZyZWUpOwo+ICsJCW11dGV4X3VubG9jaygmcGFzaWRfbXV0ZXgpOwoKa3JlZl9wdXRfbXV0
ZXgoJnN2bS0+a3JlZiwgaW50ZWxfbW1fZnJlZSwgJnBhc2lkX211dGV4KTsgPwotQ2hyaXMKCi0t
IApDaHJpcyBXaWxzb24sIEludGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudHJlCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWls
aW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
