From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu/rockchip: add ARM64 cache flush operation for
 iommu
Date: Tue, 24 May 2016 10:31:17 +0800
Message-ID: <5743BCF5.8030607@rock-chips.com>
References: <1463967439-13354-1-git-send-email-zhengsq@rock-chips.com>
 <1463967439-13354-5-git-send-email-zhengsq@rock-chips.com>
 <5742DEFE.1040902@arm.com>
 <20160523133500.GF4892@e104818-lin.cambridge.arm.com>
Reply-To: zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160523133500.GF4892-M2fw3Uu6cmfZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Q2F0YWxpbiwgUm9iaW4sCgpPbiAyMDE25bm0MDXmnIgyM+aXpSAyMTozNSwgQ2F0YWxpbiBNYXJp
bmFzIHdyb3RlOgo+IE9uIE1vbiwgTWF5IDIzLCAyMDE2IGF0IDExOjQ0OjE0QU0gKzAxMDAsIFJv
YmluIE11cnBoeSB3cm90ZToKPj4gT24gMjMvMDUvMTYgMDI6MzcsIFNodW5xaWFuIFpoZW5nIHdy
b3RlOgo+Pj4gRnJvbTogU2ltb24gPHh4bUByb2NrLWNoaXBzLmNvbT4KPj4+Cj4+PiBTaWduZWQt
b2ZmLWJ5OiBTaW1vbiA8eHhtQHJvY2stY2hpcHMuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMv
aW9tbXUvcm9ja2NoaXAtaW9tbXUuYyB8IDQgKysrKwo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvcm9ja2NoaXAt
aW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvcm9ja2NoaXAtaW9tbXUuYwo+Pj4gaW5kZXggMDQzZDE4
Yy4uMTc0MWI2NSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvcm9ja2NoaXAtaW9tbXUu
Ywo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jCj4+PiBAQCAtOTUsMTIg
Kzk1LDE2IEBAIHN0cnVjdCBya19pb21tdSB7Cj4+Pgo+Pj4gICBzdGF0aWMgaW5saW5lIHZvaWQg
cmtfdGFibGVfZmx1c2godTMyICp2YSwgdW5zaWduZWQgaW50IGNvdW50KQo+Pj4gICB7Cj4+PiAr
I2lmIGRlZmluZWQoQ09ORklHX0FSTSkKPj4+ICAgCXBoeXNfYWRkcl90IHBhX3N0YXJ0ID0gdmly
dF90b19waHlzKHZhKTsKPj4+ICAgCXBoeXNfYWRkcl90IHBhX2VuZCA9IHZpcnRfdG9fcGh5cyh2
YSArIGNvdW50KTsKPj4+ICAgCXNpemVfdCBzaXplID0gcGFfZW5kIC0gcGFfc3RhcnQ7Cj4+Pgo+
Pj4gICAJX19jcHVjX2ZsdXNoX2RjYWNoZV9hcmVhKHZhLCBzaXplKTsKPj4+ICAgCW91dGVyX2Zs
dXNoX3JhbmdlKHBhX3N0YXJ0LCBwYV9lbmQpOwo+Pj4gKyNlbGlmIGRlZmluZWQoQ09ORklHX0FS
TTY0KQo+Pj4gKwlfX2RtYV9mbHVzaF9yYW5nZSh2YSwgdmEgKyBjb3VudCk7Cj4+PiArI2VuZGlm
Cj4+IFVnaCwgcGxlYXNlIGRvbid0IHVzZSBhcmNoLXByaXZhdGUgY2FjaGUgbWFpbnRlbmFuY2Ug
ZnVuY3Rpb25zIGRpcmVjdGx5IGZyb20KPj4gYSBkcml2ZXIuIEFsbG9jYXRpbmcvbWFwcGluZyBw
YWdlIHRhYmxlcyB0byBiZSByZWFkIGJ5IHRoZSBJT01NVSBpcyBzdGlsbAo+PiBETUEsIHNvIHVz
aW5nIHRoZSBETUEgQVBJcyBpcyB0aGUgY29ycmVjdCB3YXkgdG8gbWFuYWdlIHRoZW0sICplc3Bl
Y2lhbGx5Kgo+PiBpZiBpdCBuZWVkcyB0byB3b3JrIGFjcm9zcyBtdWx0aXBsZSBhcmNoaXRlY3R1
cmVzLgpJdCdzIGVhc2llciBmb3IgdXMgaWYgY2hhbmdpbmcgIHRoZSBfX2RtYV9mbHVzaF9yYW5n
ZSgpIHRvIApfX2ZsdXNoX2RjYWNoZV9hcmVhKCkgaXMgYWNjZXB0YWJsZSBoZXJlPwoKVGhhbmsg
eW91LAotIHNodW5xaWFuCj4gSSBmdWxseSBhZ3JlZSwgdGhlc2UgZnVuY3Rpb25zIHNob3VsZCBu
b3QgYmUgdXNlZCBpbiBkcml2ZXJzLgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGludXgtcm9ja2No
aXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
