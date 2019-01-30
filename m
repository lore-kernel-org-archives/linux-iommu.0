From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Wed, 30 Jan 2019 17:47:05 -0500
Message-ID: <20190130224705.GI5061@redhat.com>
References: <20190130192234.GD5061@redhat.com>
 <20190130193759.GE17080@mellanox.com>
 <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
 <20190130201114.GB17915@mellanox.com>
 <20190130204332.GF5061@redhat.com>
 <20190130204954.GI17080@mellanox.com>
 <20190130214525.GG5061@redhat.com>
 <20190130215600.GM17080@mellanox.com>
 <20190130223027.GH5061@redhat.com>
 <20190130223258.GB25486@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190130223258.GB25486@mellanox.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Joerg Roedel <jroedel@suse.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felix Kuehling <Felix.Kuehling@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe <logang@deltatee.com>, Christian Koenig <christian.koenig@amd.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCBKYW4gMzAsIDIwMTkgYXQgMTA6MzM6MDRQTSArMDAwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIFdlZCwgSmFuIDMwLCAyMDE5IGF0IDA1OjMwOjI3UE0gLTA1MDAsIEplcm9t
ZSBHbGlzc2Ugd3JvdGU6Cj4gCj4gPiA+IFdoYXQgaXMgdGhlIHByb2JsZW0gaW4gdGhlIEhNTSBt
aXJyb3IgdGhhdCBpdCBuZWVkcyB0aGlzIHJlc3RyaWN0aW9uPwo+ID4gCj4gPiBObyByZXN0cmlj
dGlvbiBhdCBhbGwgaGVyZS4gSSB0aGluayBpIGp1c3Qgd2Fzbid0IHVuZGVyc3Rvb2QuCj4gCj4g
QXJlIHlvdSBhcmUgdGFsa2luZyBhYm91dCBmcm9tIHRoZSBleHBvcnRpbmcgc2lkZSAtIHdoZXJl
IHRoZSB0aGluZwo+IGNyZWF0aW5nIHRoZSBWTUEgY2FuIHJlYWxseSBvbmx5IHB1dCBvbmUgZGlz
dGluY3Qgb2JqZWN0IGludG8gaXQ/CgpUaGUgbWVzc2FnZSBpIHdhcyB0cnlpbmcgdG8gZ2V0IGFj
Y3Jvc3MgaXMgdGhhdCBITU0gbWlycm9yIHdpbGwKYWx3YXlzIHN1Y2NlZWQgZm9yIGV2ZXJ5dGhp
bmcqIGV4Y2VwdCBmb3Igc3BlY2lhbCB2bWEgaWUgbW1hcCBvZgpkZXZpY2UgZmlsZS4gRm9yIHRo
b3NlIGl0IGNhbiBvbmx5IHN1Y2NlZWQgaWYgYSBwMnBfbWFwKCkgY2FsbApzdWNjZWVkLgoKU28g
YW55IHVzZXIgb2YgSE1NIG1pcnJvciBtaWdodCB0byBrbm93IHdoeSB0aGUgbWlycm9yaW5nIGZh
aWwgaWUKd2FzIGl0IGJlY2F1c2Ugc29tZXRoaW5nIGV4Y2VwdGlvbmFsIGlzIGhhcHBlbmluZyA/
IE9yIGlzIGl0IGJlY2F1c2UKaSB3YXMgdHJ5aW5nIHRvIG1hcCBhIHNwZWNpYWwgdm1hIHdoaWNo
IGNhbiBiZSBmb3JiaWRlbi4KCkhlbmNlIHdoeSBpIGFzc3VtZSB0aGF0IHlvdSBtaWdodCB3YW50
IHRvIGtub3cgYWJvdXQgc3VjaCBwMnBfbWFwCmZhaWx1cmUgYXQgdGhlIHRpbWUgeW91IGNyZWF0
ZSB0aGUgdW1lbSBvZHAgb2JqZWN0IGFzIGl0IG1pZ2h0IGJlCnNvbWUgZmFpbHVyZSB5b3UgbWln
aHQgd2FudCB0byByZXBvcnQgZGlmZmVyZW50bHkgYW5kIGhhbmRsZQpkaWZmZXJlbnRseS4gSWYg
eW91IGRvIG5vdCBjYXJlIGFib3V0IGRpZmZlcmVudGlhdGluZyBPT00gb3IKZXhjZXB0aW9uYWwg
ZmFpbHVyZSBmcm9tIHAycF9tYXAgZmFpbHVyZSB0aGFuIHlvdSBoYXZlIG5vdGhpbmcgdG8Kd29y
cnkgYWJvdXQgeW91IHdpbGwgZ2V0IHRoZSBzYW1lIGVycm9yIGZyb20gSE1NIGZvciBib3RoLgoK
Q2hlZXJzLApKw6lyw7RtZQoKKiBFdmVyeXRoaW5nIGV4Y2VwdCB3aGVuIHRoZXkgYXJlIGV4Y2Vw
dGlvbmFsIGNvbmRpdGlvbiBsaWtlIE9PTSBvcgogIHBvaXNvbm91cyBtZW1vcnkuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
