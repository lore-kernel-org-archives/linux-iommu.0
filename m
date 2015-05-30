From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Sat, 30 May 2015 11:23:36 +0000
Message-ID: <3085F41B-FE6D-4E39-916A-F7B539B28BCB@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>,
	<20150529162151.GB20384@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150529162151.GB20384-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: zh-CN
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Vaden,
	Tom (HP Server OS Architecture)" <tom.vaden-VXdhtT5mjnY@public.gmane.org>, "Wright,
	Randy (HP Servers Linux)" <rwright-VXdhtT5mjnY@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mitchell, Lisa (MCLinux in Fort Collins)" <lisa.mitchell-VXdhtT5mjnY@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Hatch, Douglas B (HPS Linux PM)" <doug.hatch-VXdhtT5mjnY@public.gmane.org>, "ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org" <ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhang, Li
	(Zoe@HPservers-Core-OE-PSC)" <li.zhang6-VXdhtT5mjnY@public.gmane.org>, "dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

DQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB0aGlzLg0KDQp6aGVuaHVhDQoNCkZyb20gTXkgaVBo
b25lDQoNCj4g1NogMjAxNcTqNdTCMzDI1aOsMDA6MjKjrEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0
ZXMub3JnPiDQtLXAo7oNCj4gDQo+PiBPbiBNb24sIE1heSAxMSwgMjAxNSBhdCAwNTo1Mjo0NFBN
ICswODAwLCBMaSwgWmhlbi1IdWEgd3JvdGU6DQo+PiBMaSwgWmhlbi1IdWEgKDEwKToNCj4+ICBp
b21tdS92dC1kOiBOZXcgZnVuY3Rpb24gdG8gYXR0YWNoIGRvbWFpbiB3aXRoIGlkDQo+PiAgaW9t
bXUvdnQtZDogSXRlbXMgcmVxdWlyZWQgZm9yIGtkdW1wDQo+PiAgaW9tbXUvdnQtZDogRnVuY3Rp
b24gdG8gZ2V0IGV4aXN0aW5nIGNvbnRleHQgZW50cnkNCj4+ICBpb21tdS92dC1kOiBmdW5jdGlv
bnMgdG8gY29weSBkYXRhIGZyb20gb2xkIG1lbQ0KPj4gIGlvbW11L3Z0LWQ6IEFkZCBmdW5jdGlv
bnMgdG8gbG9hZCBhbmQgc2F2ZSBvbGQgcmUNCj4+ICBpb21tdS92dC1kOiBkYXRhdHlwZXMgYW5k
IGZ1bmN0aW9ucyB1c2VkIGZvciBrZHVtcA0KPj4gIGlvbW11L3Z0LWQ6IGVuYWJsZSBrZHVtcCBz
dXBwb3J0IGluIGlvbW11IG1vZHVsZQ0KPj4gIGlvbW11L3Z0LWQ6IGFzc2lnbiBuZXcgcGFnZSB0
YWJsZSBmb3IgZG1hX21hcA0KPj4gIGlvbW11L3Z0LWQ6IENvcHkgZnVuY3Rpb25zIGZvciBpcnRl
DQo+PiAgaW9tbXUvdnQtZDogVXNlIG9sZCBpcnRlIGluIGtkdW1wIGtlcm5lbA0KPj4gDQo+PiBk
cml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgICAgICAgICB8IDUzNiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4+IGRyaXZlcnMvaW9tbXUvaW50ZWxfaXJxX3JlbWFwcGlu
Zy5jIHwgIDk2ICsrKysrKy0NCj4+IGluY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaCAgICAgICAg
IHwgIDE2ICsrDQo+PiAzIGZpbGVzIGNoYW5nZWQsIDYyMyBpbnNlcnRpb25zKCspLCAyNSBkZWxl
dGlvbnMoLSkNCj4gDQo+IEFwcGxpZWQgd2l0aCBhIGZldyBtaW5vciBjaGFuZ2VzLCB0aGFua3Mu
DQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
