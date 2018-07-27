From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Date: Fri, 27 Jul 2018 20:31:34 +0200
Message-ID: <20180727183134.GD6738@8bytes.org>
References: <20180726231624.21084-1-digetx@gmail.com>
 <20180727082512.lpvmeuvxnw3mpeym@8bytes.org>
 <20180727090328.GH28088@arm.com> <4164951.xGHfcFJ9uZ@dimapc>
 <20180727142000.76zgficpta473snl@8bytes.org>
 <CAL_JsqJCE+8hZ-xCajUaW4ScY8VmaZ3nN4U-_AKJL+063sLBpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJCE+8hZ-xCajUaW4ScY8VmaZ3nN4U-_AKJL+063sLBpw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>, "Rafael J. Wysocki" <rafael@kernel.org>, kwizart@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, dri-devel <dri-devel@lists.freedesktop.org>, Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, Linux IOMMU <iommu@lists.linux-foundation.org>, Thierry Reding <thierry.reding@gmail.com>, bskeggs@redhat.com, Catalin Marinas <catalin.marinas@arm.com>, nouveau@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>, Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

T24gRnJpLCBKdWwgMjcsIDIwMTggYXQgMTE6MTM6MzFBTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6Cj4gSSBkb24ndCBmb2xsb3cgd2h5IHdlIG5lZWQgYSBwcm9wZXJ0eSByYXRoZXIgdGhhbiBi
ZWluZyBpbXBsaWVkIGJ5IHRoZQo+IGRldmljZSdzICh0aGUgR1BVKSBjb21wYXRpYmxlIHN0cmlu
Zy4KClRoZXJlIG1pZ2h0IGJlIGRldmljZXMgd2hlcmUgZWl0aGVyIHNldHVwIHdvcmtzLCB3aXRo
IG9yIHdpdGhvdXQgSU9NTVUKdHJhbnNsYXRpb24sIGFuZCB0aGUgZmlybXdhcmUgY2FuIHNldCB0
aGUgcHJvcGVydHkgZGVwZW5kaW5nIG9uIHdoZXRoZXIKdGhlIHVzZXIgd2FudHMgbW9yZSBwZXJm
b3JtYW5jZSBvciBtb3JlIHNlY3VyaXR5LgoKSWYgd2UgaGF2ZSBhIHdoaXRlbGlzdCBpbiB0aGUg
a2VybmVsIHRoaXMgZ2V0cyBtb3JlIGNvbXBsaWNhdGVkLCB3ZQpwcm9iYWJseSBuZWVkIGFkZGl0
aW9uYWwga2VybmVsLXBhcmFtZXRlcnMgdG8gb3ZlcndyaXRlIHRob3NlIHdoaXRlbGlzdAplbnRy
aWVzLiBIYXZpbmcgYSBwcm9wZXJ0eSBpbiB0aGUgZGV2aWNlLXRyZWUgc2VlbXMgdG8gYmUgYSBi
ZXR0ZXIgd2F5CmhlcmUsIGltaG8uCgoKCUpvZXJnCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
