From: Christoph Hellwig <hch@lst.de>
Subject: fix DMA ops layering violations in vmwgfx
Date: Sat,  5 Jan 2019 09:01:04 +0100
Message-ID: <20190105080108.14837-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: thellstrom@vmware.com
Cc: iommu@lists.linux-foundation.org, linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: iommu@lists.linux-foundation.org

SGkgVGhvbWFzLAoKdm13Z2Z4IGhhcyBiZWVuIGRvaW5nIHNvbWUgb2RkIGNoZWNrcyBiYXNlZCBv
biBETUEgb3BzIHdoaWNoIHJlbHkKb24gZGVlcCBETUEgbWFwcGluZyBsYXllciBpbnRlcm5hbHMs
IGFuZCBJIHRoaW5rIHRoZSBjaGFuZ2VzIGluCkxpbnV4IDQuMjEgZmluYWxseSBicm9rZSBtb3N0
IG9mIHRoZXNlIGltcGxpY2l0IGFzc3VtcHRpb25zLgoKVGhlIHJlYWwgZml4IGlzIGluIHBhdGNo
IDMsIGJ1dCBJIHRoaW5rIHRoZSBvdGhlcnMgYXJlIGltcG9ydGFudAp0byBtYWtlIGl0IGNsZWFy
IHdoYXQgaXMgYWN0dWFsbHkgZ29pbmcgb24uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
