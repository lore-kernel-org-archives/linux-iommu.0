From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer
 capability
Date: Tue, 29 Jan 2019 20:44:26 +0100
Message-ID: <20190129194426.GB32069@kroah.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-2-jglisse@redhat.com>
 <f66ba584-9c4a-f6cd-c647-9b32a93be807@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <f66ba584-9c4a-f6cd-c647-9b32a93be807@deltatee.com>
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
Cc: Joerg Roedel <jroedel@suse.de>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, jglisse@redhat.com, Jason Gunthorpe <jgg@mellanox.com>, Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christian Koenig <christian.koenig@amd.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

T24gVHVlLCBKYW4gMjksIDIwMTkgYXQgMTE6MjQ6MDlBTSAtMDcwMCwgTG9nYW4gR3VudGhvcnBl
IHdyb3RlOgo+IAo+IAo+IE9uIDIwMTktMDEtMjkgMTA6NDcgYS5tLiwgamdsaXNzZUByZWRoYXQu
Y29tIHdyb3RlOgo+ID4gK2Jvb2wgcGNpX3Rlc3RfcDJwKHN0cnVjdCBkZXZpY2UgKmRldkEsIHN0
cnVjdCBkZXZpY2UgKmRldkIpCj4gPiArewo+ID4gKwlzdHJ1Y3QgcGNpX2RldiAqcGNpQSwgKnBj
aUI7Cj4gPiArCWJvb2wgcmV0Owo+ID4gKwlpbnQgdG1wOwo+ID4gKwo+ID4gKwkvKgo+ID4gKwkg
KiBGb3Igbm93IHdlIG9ubHkgc3VwcG9ydCBQQ0lFIHBlZXIgdG8gcGVlciBidXQgb3RoZXIgaW50
ZXItY29ubmVjdAo+ID4gKwkgKiBjYW4gYmUgYWRkZWQuCj4gPiArCSAqLwo+ID4gKwlwY2lBID0g
ZmluZF9wYXJlbnRfcGNpX2RldihkZXZBKTsKPiA+ICsJcGNpQiA9IGZpbmRfcGFyZW50X3BjaV9k
ZXYoZGV2Qik7Cj4gPiArCWlmIChwY2lBID09IE5VTEwgfHwgcGNpQiA9PSBOVUxMKSB7Cj4gPiAr
CQlyZXQgPSBmYWxzZTsKPiA+ICsJCWdvdG8gb3V0Owo+ID4gKwl9Cj4gPiArCj4gPiArCXRtcCA9
IHVwc3RyZWFtX2JyaWRnZV9kaXN0YW5jZShwY2lBLCBwY2lCLCBOVUxMKTsKPiA+ICsJcmV0ID0g
dG1wIDwgMCA/IGZhbHNlIDogdHJ1ZTsKPiA+ICsKPiA+ICtvdXQ6Cj4gPiArCXBjaV9kZXZfcHV0
KHBjaUIpOwo+ID4gKwlwY2lfZGV2X3B1dChwY2lBKTsKPiA+ICsJcmV0dXJuIGZhbHNlOwo+ID4g
K30KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChwY2lfdGVzdF9wMnApOwo+IAo+IFRoaXMgZnVuY3Rp
b24gb25seSBldmVyIHJldHVybnMgZmFsc2UuLi4uCgpJIGd1ZXNzIGl0IHdhcyBuZXZyIGFjdHVh
bGx5IHRlc3RlZCA6KAoKSSBmZWVsIHJlYWxseSB3b3JyaWVkIGFib3V0IHBhc3NpbmcgcmFuZG9t
ICdzdHJ1Y3QgZGV2aWNlJyBwb2ludGVycyBpbnRvCnRoZSBQQ0kgbGF5ZXIuICBBcmUgd2UgX3N1
cmVfIGl0IGNhbiBoYW5kbGUgdGhpcyBwcm9wZXJseT8KCnRoYW5rcywKCmdyZWcgay1oCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
