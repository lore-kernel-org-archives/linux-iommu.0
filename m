From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/2] drivers: remove force dma flag from buses
Date: Tue, 1 May 2018 07:34:48 -0500
Message-ID: <20180501123448.GA23861@rob-hp-laptop>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-2-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1524883919-29484-2-git-send-email-nipun.gupta@nxp.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: zajec5@gmail.com, linux-pci@vger.kernel.org, jarkko.sakkinen@linux.intel.com, david.brown@linaro.org, thierry.reding@gmail.com, frowand.list@gmail.com, hch@lst.de, m.szyprowski@samsung.com, vinod.koul@intel.com, bharat.bhushan@nxp.com, rafael.j.wysocki@intel.com, linux@armlinux.org.uk, andy.gross@linaro.org, msuchanek@suse.de, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, johan@kernel.org, dri-devel@lists.freedesktop.org, bhelgaas@google.com, dan.j.williams@intel.com, linux-soc@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

T24gU2F0LCBBcHIgMjgsIDIwMTggYXQgMDg6MjE6NTlBTSArMDUzMCwgTmlwdW4gR3VwdGEgd3Jv
dGU6Cj4gV2l0aCBlYWNoIGJ1cyBpbXBsZW1lbnRpbmcgaXRzIG93biBETUEgY29uZmlndXJhdGlv
biBjYWxsYmFjaywKPiB0aGVyZSBpcyBubyBuZWVkIGZvciBidXMgdG8gZXhwbGljaXRseSBoYXZl
IGZvcmNlX2RtYSBpbiBpdHMKPiBnbG9iYWwgc3RydWN0dXJlLiBUaGlzIHBhdGNoIG1vZGlmaWVz
IG9mX2RtYV9jb25maWd1cmUgQVBJIHRvCj4gYWNjZXB0IGFuIGlucHV0IHBhcmFtZXRlciB3aGlj
aCBzcGVjaWZpZXMgaWYgaW1wbGljaXQgRE1BCj4gY29uZmlndXJhdGlvbiBpcyByZXF1aXJlZCBl
dmVuIHdoZW4gaXQgaXMgbm90IGRlc2NyaWJlZCBieSB0aGUKPiBmaXJtd2FyZS4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAbnhwLmNvbT4KPiBBY2tlZC1ieTog
Qmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4gICMgUENJIHBhcnRzCj4gLS0tCj4g
Q2hhbmdlcyBpbiB2MjoKPiAgIC0gVGhpcyBpcyBhIG5ldyBjaGFuZ2Ugc3VnZ2VzdGVkIGJ5IFJv
YmluIGFuZCBDaHJpc3RvcGgKPiAgICAgYW5kIGlzIGFkZGVkIHRvIHRoZSBzZXJpZXMuCj4gCj4g
Q2hhbmdlcyBpbiB2MzoKPiAgIC0gUmViYXNlIGFuZCBjaGFuZ2VzIGNvcnJlc3BvbmRpbmcgdG8g
dGhlIGNoYW5nZXMgaW4gcGF0Y2ggMS8yCj4gCj4gQ2hhbmdlcyBpbiB2NDoKPiAgIC0gUmViYXNl
ZCBvbiB0b3Agb2YgNC4xNy1yYzIKPiAKPiAgZHJpdmVycy9hbWJhL2J1cy5jICAgICAgICAgICAg
fCAxIC0KPiAgZHJpdmVycy9iYXNlL3BsYXRmb3JtLmMgICAgICAgfCAzICstLQo+ICBkcml2ZXJz
L2JjbWEvbWFpbi5jICAgICAgICAgICB8IDIgKy0KPiAgZHJpdmVycy9kbWEvcWNvbS9oaWRtYV9t
Z210LmMgfCAyICstCj4gIGRyaXZlcnMvZ3B1L2hvc3QxeC9idXMuYyAgICAgIHwgNSArKy0tLQo+
ICBkcml2ZXJzL29mL2RldmljZS5jICAgICAgICAgICB8IDYgKysrKy0tCj4gIGRyaXZlcnMvb2Yv
b2ZfcmVzZXJ2ZWRfbWVtLmMgIHwgMiArLQo+ICBkcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMgICAg
ICB8IDMgKy0tCj4gIGluY2x1ZGUvbGludXgvZGV2aWNlLmggICAgICAgIHwgNCAtLS0tCj4gIGlu
Y2x1ZGUvbGludXgvb2ZfZGV2aWNlLmggICAgIHwgOCArKysrKystLQo+ICAxMCBmaWxlcyBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKClJldmlld2VkLWJ5OiBSb2Ig
SGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
