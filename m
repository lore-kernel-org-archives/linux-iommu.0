From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Date: Mon, 10 Dec 2018 11:33:10 -0800 (PST)
Message-ID: <20181210.113310.460303100337934249.davem@davemloft.net>
References: <20181210163256.GA27331@lst.de>
 <20181210.101039.1882227517259366533.davem@davemloft.net>
 <20181210192228.GB31178@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181210192228.GB31178@lst.de>
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
MTggMjA6MjI6MjggKzAxMDAKCj4gT24gTW9uLCBEZWMgMTAsIDIwMTggYXQgMTA6MTA6MzlBTSAt
MDgwMCwgRGF2aWQgTWlsbGVyIHdyb3RlOgo+PiBGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4KPj4gRGF0ZTogTW9uLCAxMCBEZWMgMjAxOCAxNzozMjo1NiArMDEwMAo+PiAKPj4g
PiBEYXZlLCBjYW4geW91IHBpY2sgdGhlIHNlcmllcyB1cCB0aHJvdWdoIHRoZSBzcGFyYyB0cmVl
PyAgSSBjb3VsZCBhbHNvCj4+ID4gbWVyZ2UgaXQgdGhyb3VnaCB0aGUgZG1hLW1hcHBpbmcgdHJl
ZSwgYnV0IGdpdmVuIHRoYXQgdGhlcmUgaXMgbm8KPj4gPiBkZXBlbmRlbmN5IG9uIGl0IHRoZSBz
cGFyYyB0cmVlIHNlZW0gbGlrZSB0aGUgYmV0dGVyIGZpdC4KPj4gCj4+IEkgdGhvdWdodCB0aGF0
IHNvbWUgb2YgdGhpcyBpcyBhIHByZXJlcXVpc2l0ZSBmb3IgdGhlIERNQSBtYXBwaW5nCj4+IHdv
cmsgYW5kIG92ZXJhbGwgY29uc29saWRhdGlvbiB5b3UgYXJlIGRvaW5nLiAgU28gSSBraW5kYSBh
c3N1bWVkCj4+IHlvdSB3YW50ZWQgdG8gbWVyZ2UgaXQgdmlhIHlvdXIgdHJlZS4KPj4gCj4+IEkg
YW50aWNpcGF0ZSBubyBjb25mbGljdHMgYXQgYWxsLCBldmVuIHVudGlsIHRoZSBuZXh0IG1lcmdl
IHdpbmRvdywKPj4gc28gaXQgY291bGQgdmVyeSBlYXNpbHkgZ28gdGhyb3VnaCB5b3VyIHRyZWUu
Cj4+IAo+PiBMZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgd2FudCBtZSB0byBtZXJnZSB0aGlzLgo+
IAo+IFRoZXNlIHBhdGNoZXMgYXJlIHB1cmVseSBjbGVhbnVwcyBJIGZvdW5kIHdoaWxlIGF1ZGl0
aW5nIHRoZSBETUEKPiBtYXBwaW5nIGNvZGUsIGF0IGxlYXN0IGFzIG9mIG5vdyB0aGVyZSBhcmUg
bm8gZGVwZW5kZW5jaWVzLgo+IAo+IFRoYXQgYmVpbmcgc2FpZCBub3cgdGhhdCBJIGxvb2tlZCBp
bnRvIGl0IGEgYml0IG1vcmUgdGhleSBkbyBob3dldmVyCj4gZGVwZW5kIG9uIHRoZSAtPm1hcHBp
bmdfZXJyb3IgcmVtb3ZhbCwgc28gSSdsbCB0YWtlIHRoZW0gdGhyb3VnaAo+IHRoZSBkbWEtbWFw
cGluZyB0cmVlLgoKT2ssIHRoYW5rcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
