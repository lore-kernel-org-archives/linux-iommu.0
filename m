From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Date: Fri, 27 Jul 2018 11:13:31 -0600
Message-ID: <CAL_JsqJCE+8hZ-xCajUaW4ScY8VmaZ3nN4U-_AKJL+063sLBpw@mail.gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
 <20180727082512.lpvmeuvxnw3mpeym@8bytes.org>
 <20180727090328.GH28088@arm.com> <4164951.xGHfcFJ9uZ@dimapc>
 <20180727142000.76zgficpta473snl@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180727142000.76zgficpta473snl@8bytes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: devicetree@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>, "Rafael J. Wysocki" <rafael@kernel.org>, kwizart@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, dri-devel <dri-devel@lists.freedesktop.org>, Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, Linux IOMMU <iommu@lists.linux-foundation.org>, Thierry Reding <thierry.reding@gmail.com>, bskeggs@redhat.com, Catalin Marinas <catalin.marinas@arm.com>, nouveau@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>, Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

T24gRnJpLCBKdWwgMjcsIDIwMTggYXQgODoyMCBBTSBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVz
Lm9yZz4gd3JvdGU6Cj4KPiBPbiBGcmksIEp1bCAyNywgMjAxOCBhdCAwNToxMDoyMlBNICswMzAw
LCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4gPiBJJ20gbm90IHN1cmUgd2hhdCB5b3UgZ3V5cyBh
cmUgbWVhbmluZyBieSB0aGUgImZpcm13YXJlIiwgY291bGQgeW91IGVsYWJvcmF0ZQo+ID4gcGxl
YXNlPyBEbyB5b3UgbWVhbiB0aGUgT3BlbiBGaXJtd2FyZSBhbmQgaGVuY2UgdGhlIGRldmljZXRy
ZWUgb3Igd2hhdD8KPgo+IFllcywgSSB0aGluayB0aGUgYmVzdCB3YXkgdG8gcmVxdWVzdCB0aGlz
IGlzIHVzaW5nIGEgZGV2aWNlLXRyZWUKPiBwcm9wZXJ0eS4gTGV0dGluZyB0aGUgZGV2aWNlIGRy
aXZlciByZXF1ZXN0IGl0IGlzIGRlZmluaXRseSBhIGJhZCBpZGVhLgoKSSBkb24ndCBmb2xsb3cg
d2h5IHdlIG5lZWQgYSBwcm9wZXJ0eSByYXRoZXIgdGhhbiBiZWluZyBpbXBsaWVkIGJ5IHRoZQpk
ZXZpY2UncyAodGhlIEdQVSkgY29tcGF0aWJsZSBzdHJpbmcuCgpSb2IKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
