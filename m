From: "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/6] iommu/vt-d: Add Intel IOMMU debugfs to show
	context internals
Date: Wed, 13 Dec 2017 04:30:43 +0000
Message-ID: <1513139481.16043.2.camel@intel.com>
References: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
	<1512531807-24268-3-git-send-email-sohil.mehta@intel.com>
	<5A27A74C.9070201@linux.intel.com>
	<1512678006.120652.17.camel@intel.com>
	<5A30905D.9000303@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5A30905D.9000303-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Content-ID: <3801C21E6576734F8FD1DAA3DCBE4EF8-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shevchenko,
	Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shankar,
	Ravi V" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Kammela,
	Gayatri" <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCAyMDE3LTEyLTEzIGF0IDEwOjI4ICswODAwLCBMdSBCYW9sdSB3cm90ZToNCj7CoA0K
PiA+IFdvdWxkIHRoZSByZWNvbW1lbmRhdGlvbiBiZSB0byB1c2UgcHJfd2FybiBpbnN0ZWFkIG9m
IHByX2VyciBvcg0KPiA+IHNob3VsZA0KPiA+IHdlIGVudGlyZWx5IHNraXAgdGhlIG1lc3NhZ2Ug
YWx0b2dldGhlcj8NCj4gR3JlZyBldmVyIGVkdWNhdGVkIG1lIGFib3V0IHRoZSB1c2Ugb2YgZGVi
dWdmc18gZnVuY3Rpb25zIGluDQo+IHRoaXMgdGhyZWFkLg0KPiANCj4gaHR0cHM6Ly9zcGluaWNz
Lm5ldC9saXN0cy9saW51eC11c2IvbXNnMTU5Mzg0Lmh0bWwNCj4gDQo+IEF0IGxlYXN0IHdlIHNo
b3VsZCBhdm9pZCB0aGUgd2FybmluZy9lcnJvciBtZXNzYWdlcyBoZXJlLg0KPiANCg0KVGhhbmtz
LiBXZSdsbCByZW1vdmUgdGhlIGVycm9yIG1lc3NhZ2VzLgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
