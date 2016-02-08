From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix incorrect PPC32 PAMU dependency
Date: Mon, 08 Feb 2016 22:13:16 +1100
Message-ID: <1454929996.1562.3.camel@ellerman.id.au>
References: <1454638566-1953-1-git-send-email-afleming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1454638566-1953-1-git-send-email-afleming@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Andy Fleming <afleming@gmail.com>, joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

T24gVGh1LCAyMDE2LTAyLTA0IGF0IDIwOjE2IC0wNjAwLCBBbmR5IEZsZW1pbmcgd3JvdGU6Cgo+
IFRoZSBGcmVlc2NhbGUgUEFNVSBjYW4gYWxzbyBiZSBlbmFibGVkIG9uIDY0LWJpdCBwb3dlcgo+
IGNoaXBzLiBDb21taXQgNDc3YWI3YTE5Y2VjODQwOWU0ZTJkZDEwZTczNDhlNGNhYzNjMDZlNQo+
IChpb21tdTogTWFrZSBtb3JlIGRyaXZlcnMgZGVwZW5kIG9uIENPTVBJTEVfVEVTVCkKPiBhZGRl
ZCB0aGlzIGZhbHNlIGRlcGVuZGVuY3kuIEZpeGVkIGl0IGJ5IGFsbG93aW5nIFBQQzY0LCB0b28u
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IEZsZW1pbmcgPGFmbGVtaW5nQGdtYWlsLmNvbT4KPiAt
LS0KPiAgZHJpdmVycy9pb21tdS9LY29uZmlnIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L0tjb25maWcgYi9kcml2ZXJzL2lvbW11L0tjb25maWcKPiBpbmRleCBhMWU3NWNiLi42M2VjN2Fl
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvaW9t
bXUvS2NvbmZpZwo+IEBAIC01Nyw3ICs1Nyw3IEBAIGNvbmZpZyBJT01NVV9ETUEKPgo+ICBjb25m
aWcgRlNMX1BBTVUKPiAgCWJvb2wgIkZyZWVzY2FsZSBJT01NVSBzdXBwb3J0Igo+IC0JZGVwZW5k
cyBvbiBQUEMzMgo+ICsJZGVwZW5kcyBvbiBQUEMzMiB8fCBQUEM2NAoKVGhhdCdzID09IFBQQy4K
Cj4gIAlkZXBlbmRzIG9uIFBQQ19FNTAwTUMgfHwgQ09NUElMRV9URVNUCgpCdXQgdGhlbiB5b3Ug
aGF2ZSB0aGF0IF4KCk11bHRpcGxlIGRlcGVuZHMgYXJlIGpvaW5lZCB3aXRoICYmLCBzbyB5b3Ug
Z2V0OgoKCWRlcGVuZHMgb24gUFBDICYmIChQUENfRTUwME1DIHx8IENPTVBJTEVfVEVTVCkKClBQ
Q19FNTAwTUMgZGVwZW5kcyAoaW5kaXJlY3RseSkgb24gUFBDLCBzbyBJIHRoaW5rIGl0IHdvdWxk
IGJlIGNsZWFyZXIgYXM6CgoJZGVwZW5kcyBvbiBQUENfRTUwME1DIHx8IChDT01QSUxFX1RFU1Qg
JiYgUFBDKQoKV2hpY2ggSSAvdGhpbmsvIG1hdGNoZXMgdGhlIG9yaWdpbmFsIGludGVudGlvbj8K
CmNoZWVycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpo
dHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
