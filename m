From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 04/10] iommu/vt-d: functions to copy data from old mem
Date: Mon, 8 Jun 2015 17:21:47 +0200
Message-ID: <20150608152147.GV20384@8bytes.org>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
	<1431337974-545-5-git-send-email-zhen-hual@hp.com>
	<1433772935.2952.47.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433772935.2952.47.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

SGkgRGF2aWQsCgpPbiBNb24sIEp1biAwOCwgMjAxNSBhdCAwMzoxNTozNVBNICswMTAwLCBEYXZp
ZCBXb29kaG91c2Ugd3JvdGU6Cj4gU3VyZWx5IHRoaXMgaXNuJ3Qgc3BlY2lmaWMgdG8gdGhlIElu
dGVsIElPTU1VPyBTaG91bGRuJ3QgaXQgbGl2ZQo+IGVsc2V3aGVyZSDigJQgZWl0aGVyIGluIGdl
bmVyaWMgSU9NTVUgY29kZSBvciBwZXJoYXBzIGluIGdlbmVyaWMga2V4ZWMKPiBzdXBwb3J0IGNv
ZGU/CgpJIHB1dCBhIGJpZ2dlciByZXdvcmsgb2YgdGhpcyBvbi10b3Agb2YgWmhlbi1IdWEncyBw
YXRjaGVzLCB5b3UgY2FuIGZpbmQKdGhlIHJlc3VsdCBpbiBteSB4ODYvdnQtZCBicmFuY2guIFdp
dGggbXkgcGF0Y2hlcyBJIGFsc28gcmVtb3ZlZCB0aGlzCnBvaW50ZXIgY29sbGVjdGluZyBjb25j
ZXB0IGFuZCBkbyB0aGUgaW9tYXBfY2FjaGUgYW5kIGlvdW5tYXAgY2FsbHMKYmVmb3JlIHRoZSBz
cGluLWxvY2sgaXMgdGFrZW4sIHNvIHRoaXMgcHJvYmxlbSBpcyBub3cgc29sdmVkCmRpZmZlcmVu
dGx5LgoKPiBBbmQgSSB0aGluayB5b3UncmUgbWlzdXNpbmcgVlREX1BBR0Vfe1NISUZULE1BU0t9
IHdoZW4geW91IHNob3VsZCBiZQo+IHVzaW5nIHRoZSBub3JtYWwgUEFHRV97U0hJRlQsTUFTS30u
CgpJIHRoaW5rIFZUX1BBR0VfKiBpcyBjb3JyZWN0LCBzaW5jZSB0aGUgVlQtZCBkcml2ZXIgYWxz
byBydW5zIG9uIGlhNjQuClRoZXJlIHRoZSBzeXN0ZW0gcGFnZS1zaXplIGlzIGRpZmZlcmVudCBm
cm9tIHRoZSBWVC1kIHBhZ2Utc2l6ZS4KCj5BbmQgc2hvdWxkbid0IHBoeXNpY2FsIGFkZHJlc3Nl
cyBiZSBwaHlzX2FkZHJfdD8KClRoaXMgaXMgY2hhbmdlZCB3aGVyZSBhcHByb3ByaWF0ZSwgSSBo
b3BlLgoKCglKb2VyZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
