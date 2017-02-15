From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 2/6] iommu/dmar: Rectify return code handling in
	detect_intel_iommu()
Date: Wed, 15 Feb 2017 16:58:52 +0200
Message-ID: <1487170732.2133.487.camel@linux.intel.com>
References: <20170215144226.34519-1-andriy.shevchenko@linux.intel.com>
	<20170215144226.34519-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170215144226.34519-2-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCAyMDE3LTAyLTE1IGF0IDE2OjQyICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gVGhlcmUgaXMgaW5jb25zaXN0ZW5jeSBpbiByZXR1cm4gY29kZXMgYWNyb3NzIHRoZSBmdW5j
dGlvbnMgY2FsbGVkCj4gZnJvbQo+IGRldGVjdF9pbnRlbF9pb21tdSgpLgo+IAo+IE1ha2UgaXQg
Y29uc2lzdGVudCBhbmQgcHJvcGFnYXRlIHJldHVybiBjb2RlIHRvIHRoZSBjYWxsZXIuCgrCoAo+
IEBAIC05MTEsMTAgKzkxMSw5IEBAIGludCBfX2luaXQgZGV0ZWN0X2ludGVsX2lvbW11KHZvaWQp
Cj4gwqAJfQo+IMKgCXVwX3dyaXRlKCZkbWFyX2dsb2JhbF9sb2NrKTsKPiDCoAo+IC0JcmV0dXJu
IHJldCA/IDEgOiAtRU5PREVWOwo+ICsJcmV0dXJuIHJldDsKCkFjY2lkZW50YWxseSBpdCB3b3Jr
cyBzaW5jZSB3ZSBoYXZlIG5vIGxhdGVfaW5pdCgpIGRlZmluZWQuCgpJIHdpbGwgZml4IHRoaXMg
aW4gdjIsIGJ1dCB3aWxsIHdhaXQgZm9yIHRoZSBjb21tZW50cyByZWdhcmRpbmcgdGhlIHJlc3QK
b2YgdGhlIHNlcmllcy4KCi0tIApBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbT4KSW50ZWwgRmlubGFuZCBPeQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
