From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Date: Mon, 10 Dec 2018 10:10:39 -0800 (PST)
Message-ID: <20181210.101039.1882227517259366533.davem@davemloft.net>
References: <20181208174115.16237-7-hch@lst.de>
 <20181208.205806.42785512174962944.davem@davemloft.net>
 <20181210163256.GA27331@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181210163256.GA27331@lst.de>
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

RnJvbTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CkRhdGU6IE1vbiwgMTAgRGVjIDIw
MTggMTc6MzI6NTYgKzAxMDAKCj4gRGF2ZSwgY2FuIHlvdSBwaWNrIHRoZSBzZXJpZXMgdXAgdGhy
b3VnaCB0aGUgc3BhcmMgdHJlZT8gIEkgY291bGQgYWxzbwo+IG1lcmdlIGl0IHRocm91Z2ggdGhl
IGRtYS1tYXBwaW5nIHRyZWUsIGJ1dCBnaXZlbiB0aGF0IHRoZXJlIGlzIG5vCj4gZGVwZW5kZW5j
eSBvbiBpdCB0aGUgc3BhcmMgdHJlZSBzZWVtIGxpa2UgdGhlIGJldHRlciBmaXQuCgpJIHRob3Vn
aHQgdGhhdCBzb21lIG9mIHRoaXMgaXMgYSBwcmVyZXF1aXNpdGUgZm9yIHRoZSBETUEgbWFwcGlu
Zwp3b3JrIGFuZCBvdmVyYWxsIGNvbnNvbGlkYXRpb24geW91IGFyZSBkb2luZy4gIFNvIEkga2lu
ZGEgYXNzdW1lZAp5b3Ugd2FudGVkIHRvIG1lcmdlIGl0IHZpYSB5b3VyIHRyZWUuCgpJIGFudGlj
aXBhdGUgbm8gY29uZmxpY3RzIGF0IGFsbCwgZXZlbiB1bnRpbCB0aGUgbmV4dCBtZXJnZSB3aW5k
b3csCnNvIGl0IGNvdWxkIHZlcnkgZWFzaWx5IGdvIHRocm91Z2ggeW91ciB0cmVlLgoKTGV0IG1l
IGtub3cgaWYgeW91IHN0aWxsIHdhbnQgbWUgdG8gbWVyZ2UgdGhpcy4KClRoYW5rcy4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
