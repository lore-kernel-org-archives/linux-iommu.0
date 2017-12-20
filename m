From: "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/5] Add Intel IOMMU debugfs support
Date: Wed, 20 Dec 2017 01:47:13 +0000
Message-ID: <1513734464.31078.33.camel@intel.com>
References: <1513717687-82420-1-git-send-email-sohil.mehta@intel.com>
	<1513718710.7000.230.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1513718710.7000.230.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Content-ID: <C9710C156439B74FA81910E3F520D89B-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Shankar, Ravi V" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Kammela,
	Gayatri" <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gVHVlLCAyMDE3LTEyLTE5IGF0IDIzOjI1ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+wqANCj4gUGVyaGFwcyB5b3UgbmVlZCB0byBzd2l0Y2ggdG8gU1BEWCBsaWNlbnNlIHBvaW50
ZXIuDQo+IEkgZHVubm8gaWYgVGhvbWFzJyBwYXRjaCB3aXRoIGRvY3VtZW50YXRpb24gaG93IHRv
IGRvIHRoaXMgbWFkZQ0KPiB1cHN0cmVhbQ0KPiDCoC8gbGludXgtbmV4dCB5ZXQuDQo+IA0KDQpU
aGFua3MuIEkgZm91bmQgdGhlIGluZm9ybWF0aW9uIGF0wqBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3BhdGNoLzENCjAwOTE2MDcvLsKgDQpJJ2xsIHJlcGxhY2UgdGhlIEdQTCAyLjAgbGlj
ZW5zZSBpbmZvcm1hdGlvbiBpbiBpbnRlbC1pb21tdS1kZWJ1Zy5jDQp3aXRoIHRoZSB0YWc6DQov
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
