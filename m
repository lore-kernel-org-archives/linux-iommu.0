From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with
 IOMMU
Date: Fri, 27 Jul 2018 23:02:01 +0300
Message-ID: <4850389.K9ByBxYttl@dimapc>
References: <20180726231624.21084-1-digetx@gmail.com>
 <CAL_JsqJCE+8hZ-xCajUaW4ScY8VmaZ3nN4U-_AKJL+063sLBpw@mail.gmail.com>
 <20180727183134.GD6738@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180727183134.GD6738-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gRnJpZGF5LCAyNyBKdWx5IDIwMTggMjE6MzE6MzQgTVNLIEpvZXJnIFJvZWRlbCB3cm90ZToK
PiBPbiBGcmksIEp1bCAyNywgMjAxOCBhdCAxMToxMzozMUFNIC0wNjAwLCBSb2IgSGVycmluZyB3
cm90ZToKPiA+IEkgZG9uJ3QgZm9sbG93IHdoeSB3ZSBuZWVkIGEgcHJvcGVydHkgcmF0aGVyIHRo
YW4gYmVpbmcgaW1wbGllZCBieSB0aGUKPiA+IGRldmljZSdzICh0aGUgR1BVKSBjb21wYXRpYmxl
IHN0cmluZy4KPiAKPiBUaGVyZSBtaWdodCBiZSBkZXZpY2VzIHdoZXJlIGVpdGhlciBzZXR1cCB3
b3Jrcywgd2l0aCBvciB3aXRob3V0IElPTU1VCj4gdHJhbnNsYXRpb24sIGFuZCB0aGUgZmlybXdh
cmUgY2FuIHNldCB0aGUgcHJvcGVydHkgZGVwZW5kaW5nIG9uIHdoZXRoZXIKPiB0aGUgdXNlciB3
YW50cyBtb3JlIHBlcmZvcm1hbmNlIG9yIG1vcmUgc2VjdXJpdHkuCj4gCj4gSWYgd2UgaGF2ZSBh
IHdoaXRlbGlzdCBpbiB0aGUga2VybmVsIHRoaXMgZ2V0cyBtb3JlIGNvbXBsaWNhdGVkLCB3ZQo+
IHByb2JhYmx5IG5lZWQgYWRkaXRpb25hbCBrZXJuZWwtcGFyYW1ldGVycyB0byBvdmVyd3JpdGUg
dGhvc2Ugd2hpdGVsaXN0Cj4gZW50cmllcy4gSGF2aW5nIGEgcHJvcGVydHkgaW4gdGhlIGRldmlj
ZS10cmVlIHNlZW1zIHRvIGJlIGEgYmV0dGVyIHdheQo+IGhlcmUsIGltaG8uCgpJSVVDLCBkZXZp
Y2UtdHJlZSBzaG91bGQgYmUgY29uc2lkZXJlZCB0byBiZSAid3JpdHRlbiBpbiBzdG9uZSIgZm9y
IGEgY29uc3VtZXIgCmRldmljZSBhbmQgaGVuY2UgZmlybXdhcmUgcHJvcGVydHkgaXNuJ3Qgc29t
ZXRoaW5nIHRoYXQgY291bGQgYmUgZWFzaWx5IApjaGFuZ2VkLiBUaGUga2VybmVsLXBhcmFtZXRl
ciB3aWxsIGJlIG11Y2ggbW9yZSB1bml2ZXJzYWwuIEFueXdheSB0aGUgZ2xvYmFsIAp3aGl0ZWxp
c3Rpbmcgc2hvdWxkIGJlIGEgZGlmZmVyZW50IHRvcGljIGZvciBkaXNjdXNzaW9uLCByaWdodCBu
b3cgd2UgbmVlZCBhIApraW5kIG9mIHByaXZhdGUgd2hpdGVsaXN0aW5nIHRoYXQgaXMgaW50ZXJu
YWwgdG8ga2VybmVsLgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpOb3V2ZWF1IG1haWxpbmcgbGlzdApOb3V2ZWF1QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL25vdXZlYXUK
