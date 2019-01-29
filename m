From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer
 capability
Date: Tue, 29 Jan 2019 16:00:08 -0500
Message-ID: <20190129210007.GO3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-2-jglisse@redhat.com>
 <f66ba584-9c4a-f6cd-c647-9b32a93be807@deltatee.com>
 <20190129194426.GB32069@kroah.com>
 <8b4e0157-4eaf-c79a-28d0-7a266abe2207@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <8b4e0157-4eaf-c79a-28d0-7a266abe2207@deltatee.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Joerg Roedel <jroedel@suse.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Christian Koenig <christian.koenig@amd.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

T24gVHVlLCBKYW4gMjksIDIwMTkgYXQgMDE6NDQ6MDlQTSAtMDcwMCwgTG9nYW4gR3VudGhvcnBl
IHdyb3RlOgo+IAo+IAo+IE9uIDIwMTktMDEtMjkgMTI6NDQgcC5tLiwgR3JlZyBLcm9haC1IYXJ0
bWFuIHdyb3RlOgo+ID4gT24gVHVlLCBKYW4gMjksIDIwMTkgYXQgMTE6MjQ6MDlBTSAtMDcwMCwg
TG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+ID4+Cj4gPj4KPiA+PiBPbiAyMDE5LTAxLTI5IDEwOjQ3
IGEubS4sIGpnbGlzc2VAcmVkaGF0LmNvbSB3cm90ZToKPiA+Pj4gK2Jvb2wgcGNpX3Rlc3RfcDJw
KHN0cnVjdCBkZXZpY2UgKmRldkEsIHN0cnVjdCBkZXZpY2UgKmRldkIpCj4gPj4+ICt7Cj4gPj4+
ICsJc3RydWN0IHBjaV9kZXYgKnBjaUEsICpwY2lCOwo+ID4+PiArCWJvb2wgcmV0Owo+ID4+PiAr
CWludCB0bXA7Cj4gPj4+ICsKPiA+Pj4gKwkvKgo+ID4+PiArCSAqIEZvciBub3cgd2Ugb25seSBz
dXBwb3J0IFBDSUUgcGVlciB0byBwZWVyIGJ1dCBvdGhlciBpbnRlci1jb25uZWN0Cj4gPj4+ICsJ
ICogY2FuIGJlIGFkZGVkLgo+ID4+PiArCSAqLwo+ID4+PiArCXBjaUEgPSBmaW5kX3BhcmVudF9w
Y2lfZGV2KGRldkEpOwo+ID4+PiArCXBjaUIgPSBmaW5kX3BhcmVudF9wY2lfZGV2KGRldkIpOwo+
ID4+PiArCWlmIChwY2lBID09IE5VTEwgfHwgcGNpQiA9PSBOVUxMKSB7Cj4gPj4+ICsJCXJldCA9
IGZhbHNlOwo+ID4+PiArCQlnb3RvIG91dDsKPiA+Pj4gKwl9Cj4gPj4+ICsKPiA+Pj4gKwl0bXAg
PSB1cHN0cmVhbV9icmlkZ2VfZGlzdGFuY2UocGNpQSwgcGNpQiwgTlVMTCk7Cj4gPj4+ICsJcmV0
ID0gdG1wIDwgMCA/IGZhbHNlIDogdHJ1ZTsKPiA+Pj4gKwo+ID4+PiArb3V0Ogo+ID4+PiArCXBj
aV9kZXZfcHV0KHBjaUIpOwo+ID4+PiArCXBjaV9kZXZfcHV0KHBjaUEpOwo+ID4+PiArCXJldHVy
biBmYWxzZTsKPiA+Pj4gK30KPiA+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKHBjaV90ZXN0X3AycCk7
Cj4gPj4KPiA+PiBUaGlzIGZ1bmN0aW9uIG9ubHkgZXZlciByZXR1cm5zIGZhbHNlLi4uLgo+ID4g
Cj4gPiBJIGd1ZXNzIGl0IHdhcyBuZXZyIGFjdHVhbGx5IHRlc3RlZCA6KAo+ID4gCj4gPiBJIGZl
ZWwgcmVhbGx5IHdvcnJpZWQgYWJvdXQgcGFzc2luZyByYW5kb20gJ3N0cnVjdCBkZXZpY2UnIHBv
aW50ZXJzIGludG8KPiA+IHRoZSBQQ0kgbGF5ZXIuICBBcmUgd2UgX3N1cmVfIGl0IGNhbiBoYW5k
bGUgdGhpcyBwcm9wZXJseT8KPiAKPiBZZXMsIHRoZXJlIGFyZSBhIGNvdXBsZSBvZiBwY2lfcDJw
ZG1hIGZ1bmN0aW9ucyB0aGF0IHRha2Ugc3RydWN0IGRldmljZXMKPiBkaXJlY3RseSBzaW1wbHkg
YmVjYXVzZSBpdCdzIHdheSBtb3JlIGNvbnZlbmllbnQgZm9yIHRoZSBjYWxsZXIuIFRoYXQncwo+
IHdoYXQgZmluZF9wYXJlbnRfcGNpX2RldigpIHRha2VzIGNhcmUgb2YgKGl0IHJldHVybnMgZmFs
c2UgaWYgdGhlIGRldmljZQo+IGlzIG5vdCBhIFBDSSBkZXZpY2UpLiBXaGV0aGVyIHRoYXQncyBh
cHByb3ByaWF0ZSBoZXJlIGlzIGhhcmQgdG8gc2F5Cj4gc2VlaW5nIHdlIGhhdmVuJ3Qgc2VlbiBh
bnkgY2FsbGVyIGNvZGUuCgpDYWxsZXIgY29kZSBhcyBhIHJlZmVyZW5jZSAoaSBhbHJlYWR5IGdp
dmVuIHRoYXQgbGluayBpbiBvdGhlciBwYXJ0IG9mCnRocmVhZCBidXQganVzdCBzbyB0aGF0IHBl
b3BsZSBkb24ndCBoYXZlIHRvIGZvbGxvdyBhbGwgYnJhbmNoZXMpLgoKaHR0cHM6Ly9jZ2l0LmZy
ZWVkZXNrdG9wLm9yZy9+Z2xpc3NlL2xpbnV4L2NvbW1pdC8/aD1obW0tcDJwJmlkPTQwMWE1Njc2
OTZlYWZiMWQ0ZmFmNzA1NGFiMGQ3YzNhMTZhNWVmMDYKCkNoZWVycywKSsOpcsO0bWUKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
