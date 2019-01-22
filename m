From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] arm64/xen: fix xen-swiotlb cache flushing
Date: Tue, 22 Jan 2019 18:22:55 +0100
Message-ID: <20190122172255.GA10879@lst.de>
References: <20190117171842.26173-1-hch@lst.de>
 <alpine.DEB.2.10.1901181612150.18561@sstabellini-ThinkPad-X260>
 <20190119094301.GB21653@lst.de>
 <alpine.DEB.2.10.1901211554300.12685@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901211554300.12685@sstabellini-ThinkPad-X260>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: jgross@suse.com, iommu@lists.linux-foundation.org, julien.grall@arm.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, Christoph Hellwig <hch@lst.de>
List-Id: iommu@lists.linux-foundation.org

T24gTW9uLCBKYW4gMjEsIDIwMTkgYXQgMDM6NTY6MjlQTSAtMDgwMCwgU3RlZmFubyBTdGFiZWxs
aW5pIHdyb3RlOgo+ID4gV2hlcmUgc2hvdWxkIHdlIHBpY2sgdGhpcyB1cD8gIEkgY291bGQgcGlj
ayBpdCB1cCB0aHJvdWdoIHRoZSBkbWEtbWFwcGluZwo+ID4gdHJlZSBnaXZlbiB0aGF0IGlzIHdo
ZXJlIHRoZSBwcm9ibGVtIGlzIGludHJvZHVjZWQsIGJ1dCB0aGUgWGVuIG9yIGFybTY0Cj4gPiB0
cmVlcyB3b3VsZCBhbHNvIGZpdC4KPiAKPiBJIGFtIGhhcHB5IGZvciB5b3UgdG8gY2FycnkgaXQg
aW4gdGhlIGRtYS1tYXBwaW5nIHRyZWUsIGVzcGVjaWFsbHkgaWYKPiB5b3UgaGF2ZSBvdGhlciBm
aXhlcyB0byBzZW5kLiBPdGhlcndpc2UsIGxldCBtZSBrbm93LgoKVGhhbmtzLCBJJ3ZlIHF1ZXVl
ZCBpdCB1cCBmb3IgTGludXMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW5wcm9q
ZWN0Lm9yZwpodHRwczovL2xpc3RzLnhlbnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8veGVu
LWRldmVs
