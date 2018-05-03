From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Date: Thu, 3 May 2018 14:21:47 +0200
Message-ID: <20180503122147.GB18590@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
 <20180430104124.GE2476@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180430104124.GE2476@ulmo>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: zajec5@gmail.com, linux-pci@vger.kernel.org, jarkko.sakkinen@linux.intel.com, david.brown@linaro.org, frowand.list@gmail.com, hch@lst.de, m.szyprowski@samsung.com, vinod.koul@intel.com, bharat.bhushan@nxp.com, rafael.j.wysocki@intel.com, linux@armlinux.org.uk, andy.gross@linaro.org, msuchanek@suse.de, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, johan@kernel.org, robh+dt@kernel.org, dri-devel@lists.freedesktop.org, Nipun Gupta <nipun.gupta@nxp.com>, bhelgaas@google.com, dan.j.williams@intel.com, linux-soc@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

T24gTW9uLCBBcHIgMzAsIDIwMTggYXQgMTI6NDE6MjRQTSArMDIwMCwgVGhpZXJyeSBSZWRpbmcg
d3JvdGU6Cj4gT24gU2F0LCBBcHIgMjgsIDIwMTggYXQgMDg6MjE6NThBTSArMDUzMCwgTmlwdW4g
R3VwdGEgd3JvdGU6Cj4gWy4uLl0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9ob3N0MXgv
YnVzLmMgYi9kcml2ZXJzL2dwdS9ob3N0MXgvYnVzLmMKPiA+IGluZGV4IDg4YTM1NTguLmE5ZWM5
OWQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9ob3N0MXgvYnVzLmMKPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2hvc3QxeC9idXMuYwo+ID4gQEAgLTMxNCw2ICszMTQsMTMgQEAgc3RhdGljIGlu
dCBob3N0MXhfZGV2aWNlX21hdGNoKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9k
cml2ZXIgKmRydikKPiA+ICAJcmV0dXJuIHN0cmNtcChkZXZfbmFtZShkZXYpLCBkcnYtPm5hbWUp
ID09IDA7Cj4gPiAgfQo+ID4gIAo+ID4gK3N0YXRpYyBpbnQgaG9zdDF4X2RtYV9jb25maWd1cmUo
c3RydWN0IGRldmljZSAqZGV2KQo+ID4gK3sKPiA+ICsJaWYgKGRldi0+b2Zfbm9kZSkKPiA+ICsJ
CXJldHVybiBvZl9kbWFfY29uZmlndXJlKGRldiwgZGV2LT5vZl9ub2RlKTsKPiAKPiBUaGUgY29u
ZGl0aW9uYWwgaGVyZSBpcyBzb21ld2hhdCBwb2ludGxlc3Mgc2luY2UgdGhlIG9mX25vZGUgc2hv
dWxkCj4gYWx3YXlzIGJlIHNldC4gSWYgaXQgd2VyZW4ndCBpdCBzaG91bGQgYmUgY29uc2lkZXJl
ZCBhIGJ1ZyBhbmQgdGhpcwo+IGZ1bmN0aW9uIHdlbGNvbWUgdG8gY3Jhc2ggdG8gbWFrZSB0aGF0
IHZlcnkgb2J2aW91cy4KCkFncmVlZC4gIFBsZWFzZSByZW1vdmUgdGhlIGNoZWNrIGZvciB0aGUg
cmVzZW5kLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
