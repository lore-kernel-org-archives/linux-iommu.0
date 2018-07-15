From: John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>
Subject: Re: convert parisc to the generic dma-noncoherent code
Date: Sun, 15 Jul 2018 12:29:37 -0400
Message-ID: <e29f9140-0d47-e074-1609-d6ae8f8869b3@bell.net>
References: <20180619070455.26624-1-hch@lst.de> <20180711153445.GC31946@lst.de>
	<e2b653d8-cc04-7a81-89a0-9d286c5cc0ca@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e2b653d8-cc04-7a81-89a0-9d286c5cc0ca-Mmb7MZpHnFY@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

T24gMjAxOC0wNy0xMyA0OjE0IEFNLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4gT24gMTEuMDcuMjAx
OCAxNzozNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IHBpbmc/ICBBbnkgY29tbWVudHM/
Cj4gSSBhcHBsaWVkIHRob3NlIDMgcGF0Y2hlcyBvbiB0b3Agb2YgZ2l0IGhlYWQsIGFuZCBib290
ZWQgdGhlCj4gMzItYml0IGtlcm5lbCBvbiBhIEhQIDcxNS82NCAoUENYLUwpIGFuZCBhIEhQIEIx
NjBMIChQQ1gtTDIpLgo+IE9uIGJvdGggbWFjaGluZXMgSSBoYWQgcHJvYmxlbXMgd2l0aCB0aG9z
ZSBkcml2ZXJzIHdoaWNoIHVzZQo+IERNQSAoSSBjaGVja2VkIHNwZWNpZmljYWxseSB0aGUgbGFz
aSBOSUMgY2FyZCwgd2hpY2ggaXMgdGhlCj4gbWFpbiBvbmJvYXJkIE5JQyBjYXJkIGluIGJvdGgg
bWFjaGluZXMpLgo+IEdldHRpbmcgSVAgdmlhIERIQ1Agd2FzIHVucmVsaWFibGUsIHBpbmdzIG9u
IHRoZSBzYW1lIG5ldHdvcmsKPiB0byBib3RoIG1hY2hpbmVzIGdhdmUgbG9zdCBwYWNrZXRzLCBs
b2dpbiB2aWEgc3NoIHNvbWV0aW1lcyBmYWlsZWQKPiBhbmQgc28gb24uCj4KPiBTbywgdGhlcmUg
aXMgZGVmaW5pdGl2ZWx5IHNvbWUgY2FjaGUtZmx1c2ggbWlzc2luZyBpbiB0aGlzIHBhdGNoc2V0
LgpQb3NzaWJseSwgdGhlIGNvZGUgc2hvdWxkIHVzZSBmbHVzaF9rZXJuZWxfdm1hcF9yYW5nZSgp
IGFzIGl0IHB1cmdlcyB0aGUgClRMQiBlbnRyaWVzIHVzZWQKZm9yIHRoZSBjYWNoZSBmbHVzaC7C
oCBTb21lIG9mIHRoZSByb3V0aW5lcyBpbiBwY2ktZG1hLmMgY3VycmVudGx5IHVzZSBpdC4KCkRh
dmUKCi0tIApKb2huIERhdmlkIEFuZ2xpbiAgZGF2ZS5hbmdsaW5AYmVsbC5uZXQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
