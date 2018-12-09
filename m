From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 07/10] sparc64/pci_sun4v: move code around a bit
Date: Sat, 08 Dec 2018 20:58:47 -0800 (PST)
Message-ID: <20181208.205847.1994202125580037481.davem@davemloft.net>
References: <20181208173702.15158-1-hch@lst.de>
 <20181208173702.15158-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181208173702.15158-8-hch@lst.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: hch@lst.de
Cc: linux-parisc@vger.kernel.org, ezequiel@collabora.com, vgupta@synopsys.com, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, matwey@sai.msu.ru, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, laurent.pinchart@ideasonboard.com, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, robin.murphy@arm.com, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

RnJvbTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CkRhdGU6IFNhdCwgIDggRGVjIDIw
MTggMDk6MzY6NTkgLTA4MDAKCj4gTW92ZSB0aGUgYWxsb2MgLyBmcmVlIHJvdXRpbmVzIGRvd24g
dGhlIGZpbGUgc28gdGhhdCB3ZSBjYW4gZWFzaWx5IHVzZQo+IHRoZSBtYXAgLyB1bm1hcCBoZWxw
ZXJzIHRvIGltcGxlbWVudCBub24tY29uc2lzdGVudCBhbGxvY2F0aW9ucy4KPiAKPiBBbHNvIGRy
b3AgdGhlIF9jb2hlcmVudCBwb3N0Zml4IHRvIG1hdGNoIHRoZSBtZXRob2QgbmFtZS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KCkFja2VkLWJ5OiBE
YXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
