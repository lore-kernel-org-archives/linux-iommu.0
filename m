From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
Date: Wed, 2 May 2018 18:59:42 +0200
Message-ID: <ba310210-6f3c-f4e6-29e5-5ae6e791ebeb@daenzer.net>
References: <20180501132411.2311-1-michel@daenzer.net>
 <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com>
 <CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com>
 <20180502124151.GA22857@lst.de>
 <1066dfa2-2f78-815d-c65a-9d09eb35458c@daenzer.net>
 <20180502162145.GA26787@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180502162145.GA26787@lst.de>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: iommu@lists.linux-foundation.org

T24gMjAxOC0wNS0wMiAwNjoyMSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gV2Vk
LCBNYXkgMDIsIDIwMTggYXQgMDQ6MzE6MDlQTSArMDIwMCwgTWljaGVsIETDpG56ZXIgd3JvdGU6
Cj4+PiBOby4gIF9fR0ZQX05PV0FSTiAoYW5kIGdmcF90IGZsYWdzIGluIGdlbmVyYWwpIGFyZSB0
aGUgd3JvbmcgaW50ZXJmYWNlCj4+PiBmb3IgZG1hIGFsbG9jYXRpb25zIGFuZCBqdXN0IGNhdXNl
IHByb2JsZW1zLiAgSSBhY3R1YWxseSBwbGFuIHRvCj4+PiBnZXQgcmlkIG9mIHRoZSBnZnBfdCBh
cmd1bWVudCBpbiBkbWFfYWxsb2NfYXR0cnMgc29vbmVyLCBhbmQgb25seQo+Pj4gYWxsb3cgZWl0
aGVyIEdGUF9LRVJORUwgb3IgR0ZQX0RNQSBwYXNzZWQgaW4gZG1hX2FsbG9jX2NvaGVyZW50Lgo+
Pgo+PiBIb3cgYWJvdXQgR0ZQX1RSQU5TSFVHRV9MSUdIVD8gVFRNIHVzZXMgdGhhdCB0byBvcHBv
cnR1bmlzdGljYWxseQo+PiBhbGxvY2F0ZSBodWdlIHBhZ2VzIChHRlBfVFJBTlNIVUdFIGNhbiBy
ZXN1bHQgaW4gdW5hY2NlcHRhYmx5IGxvbmcKPj4gZGVsYXlzIHdpdGggbWVtb3J5IHByZXNzdXJl
KS4KPiAKPiBXZWxsLCB0aGF0IGlzIGV4YWN0bHkgd2hhdCBJIGRvbid0IHdhbnQgZHJpdmVycyB0
byBkbyAtIHNhbWUgZm9yCj4gX19HRlBfQ09NUCBpbiBzb21lIGRybSBjb2RlLiAgVGhpcyB2ZXJ5
IG11Y2ggYXNzdW1lcyB0aGUgcGFnZSBhbGxvY2F0b3IKPiBpcyB1c2VkIHRvIGJhY2sgZG1hIGFs
bG9jYXRpb25zLCB3aGljaCB2ZXJ5IG9mdGVuIGl0IGFjdHVhbGx5IGlzbid0LCBhbmQKPiBhbnkg
dXNlIG9mIG1hZ2ljIGdmcCBmbGFncyBjcmVhdGVzIGEgdGlnaHQgY291cGxpbmcgb2YgY29uc3Vt
ZXJzIHdpdGggYQo+IHNwZWNpZmljIGltcGxlbWVudGF0aW9uLgo+IAo+IEluIGdlbmVyYWwgSSBj
YW4ndCB0aGluayBvZiBhIGdvb2QgcmVhc29uIG5vdCB0byBhY3R1YWxseSB1c2UKPiBHRlBfVFJB
TlNIVUdFX0xJR0hUIGJ5IGRlZmF1bHQgaW4gdGhlIGRtYSBhbGxvY2F0b3IgdW5sZXNzCj4gRE1B
X0FUVFJfQUxMT0NfU0lOR0xFX1BBR0VTIGlzIHNldC4gIENhbiB5b3UgcHJlcGFyZSBhIHBhdGNo
IGZvciB0aGF0PwoKSSdtIGFmcmFpZCBJJ2xsIGhhdmUgdG8gbGVhdmUgdGhhdCB0byBzb21lYm9k
eSBlbHNlLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3Qg
ICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
