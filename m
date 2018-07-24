From: Ley Foon Tan <ley.foon.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] nios2: use generic dma_noncoherent_ops
Date: Tue, 24 Jul 2018 10:21:55 +0800
Message-ID: <1532398915.5695.1.camel@intel.com>
References: <20180619070137.25841-1-hch@lst.de>
	<20180711153252.GA31946@lst.de> <1531979335.36945.0.camel@intel.com>
	<20180719122204.GA8606@lst.de> <1532334042.124578.1.camel@intel.com>
	<20180723082717.GA19548@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180723082717.GA19548-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gTW9uLCAyMDE4LTA3LTIzIGF0IDEwOjI3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiBPbiBNb24sIEp1bCAyMywgMjAxOCBhdCAwNDoyMDo0MlBNICswODAwLCBMZXkgRm9vbiBU
YW4gd3JvdGU6Cj4gPiAKPiA+IE9uIFRodSwgMjAxOC0wNy0xOSBhdCAxNDoyMiArMDIwMCwgQ2hy
aXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiA+IAo+ID4gPiBPbiBUaHUsIEp1bCAxOSwgMjAxOCBh
dCAwMTo0ODo1NVBNICswODAwLCBMZXkgRm9vbiBUYW4gd3JvdGU6Cj4gPiA+ID4gCj4gPiA+ID4g
Cj4gPiA+ID4gRG8geW91IGhhdmUgZ2l0IHJlcG8gZm9yIHRoaXMgc2VyaWVzIG9mIHBhdGNoZXM/
Cj4gPiA+IFRoaXMgcGF0Y2ggc2hvdWxkIGFwcGx5IHdpdGhvdXQgdGhlIG5lZWQgZm9yIGFueSBv
dGhlciBwYXRjaAo+ID4gPiB0byBMaW51cycgbGF0ZXN0IHRyZWUsIGJ1dCBJIGhhdmUgYSB0cmVl
IHdpdGggYWxsIHRoZSBjb252ZXJzaW9ucwo+ID4gPiBoZXJlOgo+ID4gPiAKPiA+ID4gwqDCoMKg
wqBodHRwOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0L3Nob3J0bG9nL3Jl
ZnMvaGVhCj4gPiA+IGRzL2cKPiA+ID4gZW5lcmljLWRtYS1ub25jb2hlcmVudC4zCj4gPiBIaQo+
ID4gCj4gPiBDb21waWxhdGlvbiwgc3lzdGVtIGJvb3R1cCBhbmQgRXRoZXJuZXQgYXJlIHdvcmtp
bmcgZmluZSB3aXRoIHRoaXMKPiA+IHBhdGNoLgo+IERvIHlvdSB3YW50IHRvIG1lcmdlIGl0IHRo
cm91Z2ggdGhlIG5pb3MgdHJlZSBvciBzaG91bGQgSSBwaWNrIGl0IHVwPwpIaQoKUGxlYXNlIHBp
Y2sgaXQgdXAgd2l0aCB5b3VyIGdpdCB0cmVlLgoKVGhhbmtzLgoKUmVnYXJkcwpMZXkgRm9vbgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
