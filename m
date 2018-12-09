From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/6] sparc: factor the dma coherent mapping into helper
Date: Sat, 08 Dec 2018 20:57:40 -0800 (PST)
Message-ID: <20181208.205740.890560451086576856.davem@davemloft.net>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181208174115.16237-3-hch@lst.de>
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
Cc: linux-parisc@vger.kernel.org, ezequiel@collabora.com, vgupta@synopsys.com, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, matwey@sai.msu.ru, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, laurent.pinchart@ideasonboard.com, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

RnJvbTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CkRhdGU6IFNhdCwgIDggRGVjIDIw
MTggMDk6NDE6MTEgLTA4MDAKCj4gRmFjdG9yIHRoZSBjb2RlIHRvIHJlbWFwIG1lbW9yeSByZXR1
cm5lZCBmcm9tIHRoZSBETUEgY29oZXJlbnQgYWxsb2NhdG9yCj4gaW50byB0d28gaGVscGVycyB0
aGF0IGNhbiBiZSBzaGFyZWQgYnkgdGhlIElPTU1VIGFuZCBkaXJlY3QgbWFwcGluZyBjb2RlLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgoKQWNrZWQt
Ynk6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
