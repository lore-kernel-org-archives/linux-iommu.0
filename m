From: Ley Foon Tan <ley.foon.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] nios2: use generic dma_noncoherent_ops
Date: Thu, 19 Jul 2018 13:48:55 +0800
Message-ID: <1531979335.36945.0.camel@intel.com>
References: <20180619070137.25841-1-hch@lst.de> <20180711153252.GA31946@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180711153252.GA31946-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCAyMDE4LTA3LTExIGF0IDE3OjMyICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiBwaW5nP8KgwqBBbnkgY29tbWVudHM/Cj4gCj4gT24gVHVlLCBKdW4gMTksIDIwMTggYXQg
MDk6MDE6MzdBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiAKPiA+IFN3aXRj
aCB0byB0aGUgZ2VuZXJpYyBub25jb2hlcmVudCBkaXJlY3QgbWFwcGluZyBpbXBsZW1lbnRhdGlv
bi4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
Cj4gPiAtLS0KPiA+IMKgYXJjaC9uaW9zMi9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB8wqDCoMKgMyArCj4gPiDCoGFyY2gvbmlvczIvaW5jbHVkZS9hc20vS2J1
aWxkwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqAxICsKPiA+IMKgYXJjaC9uaW9zMi9pbmNsdWRlL2Fz
bS9kbWEtbWFwcGluZy5oIHzCoMKgMjAgLS0tLQo+ID4gwqBhcmNoL25pb3MyL21tL2RtYS1tYXBw
aW5nLmPCoMKgwqDCoMKgwqDCoMKgwqDCoHwgMTM5ICsrKy0tLS0tLS0tLS0tLS0tLS0tLQo+ID4g
LS0tLS0tCj4gPiDCoDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTQ2IGRlbGV0
aW9ucygtKQo+ID4gwqBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9uaW9zMi9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oCj4gPiAKSGkKCkRvIHlvdSBoYXZlIGdpdCByZXBvIGZvciB0aGlzIHNlcmll
cyBvZiBwYXRjaGVzPwoKUmVnYXJkcwpMZXkgRm9vbgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
