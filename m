From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Thu, 16 Aug 2018 11:21:44 -0600
Message-ID: <0d3f48c3-8c4f-4dfb-e883-23c168f12b9b@deltatee.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
	<CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
	<b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
	<CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
	<7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
	<695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <695826a6-e10c-5a30-a51f-7cc61ba6e640-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
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
To: Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

CgpPbiAxNi8wOC8xOCAxMToxNiBBTSwgS2l0IENob3cgd3JvdGU6Cj4gSSBvbmx5IGhhdmUgYWNj
ZXNzIHRvIGludGVsIGhvc3RzIGZvciB0ZXN0aW5nIChhbmQgcG9zc2libHkgYW4gQU1ECj4gaG9z
dCBjdXJyZW50bHkgY29sbGVjdGluZyBkdXN0KSBhbmQgYW0gbm90IHN1cmUgaG93IHRvIGdvIGFi
b3V0IGdldHRpbmcKPiB0aGUgcHJvcGVyIHRlc3QgY292ZXJhZ2UgZm9yIG90aGVyIGFyY2hpdGVj
dHVyZXMuCgpXZWxsLCBJIHRob3VnaHQgeW91IHdlcmUgb25seSBjaGFuZ2luZyB0aGUgSW50ZWwg
SU9NTVUgaW1wbGVtZW50YXRpb24uLi4KU28gdGVzdGluZyBvbiBJbnRlbCBoYXJkd2FyZSBzZWVt
cyBmaW5lIHRvIG1lLgoKPiBBbnkgc3VnZ2VzdGlvbnM/IERvIHlvdSBhbnRpY2lwYXRlIGFueSBp
c3N1ZXMgd2l0aCBkbWEgbWFwcGluZyB0aGUgcGNpIGJhcgo+IGFkZHJlc3MgaW4gbnRiX2FzeW5j
X3R4X3N1Ym1pdCBvbiBub24teDg2IGFyY2hzP8KgIERvIHlvdSBvciBrbm93IG9mIGZvbGtzCj4g
d2hvIGhhdmUgbnRiIHRlc3Qgc2V0dXBzIHdpdGggbm9uLXg4NiBob3N0cyB3aG8gbWlnaHQgYmUg
YWJsZSB0byBoZWxwPwoKSSBleHBlY3Qgb3RoZXIgSU9NTVVzIHdpbGwgbmVlZCB0byBiZSB1cGRh
dGVkIHRvIHByb3Blcmx5IHN1cHBvcnQKZG1hX21hcF9yZXNvdXJjZSBidXQgdGhhdCB3aWxsIHBy
b2JhYmx5IG5lZWQgdG8gYmUgZG9uZSBvbiBhIGNhc2UgYnkKY2FzZSBiYXNpcyBhcyB0aGUgbmVl
ZCBhcmlzZXMuIFVuZm9ydHVuYXRlbHkgaXQgc2VlbXMgdGhlIHdvcmsgdG8gYWRkCmRtYV9tYXBf
cmVzb3VyY2UoKSBkaWRuJ3QgcmVhbGx5IGNvbnNpZGVyIHRoYXQgdGhlIElPTU1VcyBoYWQgdG8g
aGF2ZQpwcm9wZXIgc3VwcG9ydCBhbmQgcHJvYmFibHkgc2hvdWxkIGhhdmUgZXJyb3JlZCBvdXQg
aW5zdGVhZCBvZiBqdXN0CnBhc3NpbmcgYWxvbmcgdGhlIHBoeXNpY2FsIGFkZHJlc3MgaWYgdGhl
IElPTU1VIGRpZG4ndCBoYXZlIHN1cHBvcnQuCgpJIGRvbid0IGtub3cgb2YgYW55b25lIHdpdGgg
YW4gTlRCIHNldHVwIG9uIGFueXRoaW5nIGJ1dCB4ODYgYXQgdGhlIG1vbWVudC4KCkxvZ2FuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
