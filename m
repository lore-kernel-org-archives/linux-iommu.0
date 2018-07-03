From: lijiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
	AMD sme enabled
Date: Tue, 3 Jul 2018 19:44:40 +0800
Message-ID: <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
References: <20180702072639.10110-1-lijiang@redhat.com>
	<20180702072639.10110-2-lijiang@redhat.com>
	<20180702101451.GB28730@zn.tnic>
	<4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
	<895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
	<20180703111428.GB5748@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180703111428.GB5748-Jj63ApZU6fQ@public.gmane.org>
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
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

5ZyoIDIwMTjlubQwN+aciDAz5pelIDE5OjE0LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFR1ZSwgSnVsIDAzLCAyMDE4IGF0IDA2OjU4OjE0UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEZvciBrZHVtcCwgdGhlIGVsZiBoZWFkZXIgZmluYWxseSB1c2UgdGhlIGNyYXNoIGtlcm5lbCBy
ZXNlcnZlZCBtZW1vcnksIGl0IGlzIG5vdCBhbiBvbGQgbWVtb3J5Lgo+IAo+IExhbW1lIHJlcGVh
dCBteSBzdWdnZXN0aW9uOgo+IAo+IFNvIGJlZWYgdXAgdGhlIGxvZ2ljIGluIF9faW9yZW1hcF9j
YWxsZXIoKSB0byBmaWd1cmUgb3V0IGJhc2VkIG9uIHRoZQo+IGFkZHJlc3Mgd2hldGhlciB0byBh
Y2Nlc3MgdGhlIG1lbW9yeSBlbmNyeXB0ZWQgb3Igbm90LiBJbiBnZW5lcmFsLCB5b3UKPiBjYW4g
ZGVkdWNlLCBiYXNlZCBvbiB0aGUgcmVnaW9uIHlvdSdyZSBtYXBwaW5nLCB3aGV0aGVyIHlvdSBu
ZWVkIHRvIG1hcAo+IGluIGVuY3J5cHRlZCBvciBkZWNyeXB0ZWQuCj4gCj4gRm9yIGV4YW1wbGU6
Cj4gCj4gICAgICAgICBhZGRyID0gZWxmY29yZWhkcl9hZGRyOwo+IAo+ICAgICAgICAgLyogUmVh
ZCBFbGYgaGVhZGVyICovCj4gICAgICAgICByYyA9IGVsZmNvcmVoZHJfcmVhZCgoY2hhciAqKSZl
aGRyLCBzaXplb2YoRWxmNjRfRWhkciksICZhZGRyKTsKPiAgICAgICAgIGlmIChyYyA8IDApCj4g
ICAgICAgICAgICAgICAgIHJldHVybiByYzsKPiAKPiBlbGZjb3JlaGRyX2FkZHIgaGFzIHRoYXQg
ZWxmY29yZWhkciBhZGRyZXNzLiBTbyB5b3UgY2FuIGNoZWNrIHdoaWNoIGFkZHJlc3MKPiB5b3Un
cmUgbWFwcGluZyBhbmQgZG86Cj4gCj4gX19pb3JlbWFwX2NhbGxlcjoKPiAKPiAuLi4KPiAJcHJv
dCA9IF9faW9yZW1hcF9jb21wdXRlX3Byb3QoLi4uKTsKPiAKPiBhbmQgdGhhdCBfX2lvcmVtYXBf
Y29tcHV0ZV9wcm90KCkgZnVuY3Rpb24gd2hpY2ggeW91IHdpbGwgYWRkIHdpbGwgaGF2ZQo+IGFs
bCB0aGF0IGxvZ2ljIHRvIGRldGVybWluZSBlbmNyeXB0ZWQgb3Igbm90IGJ5IGNvbXBhcmluZyBh
ZGRyZXNzZXMgZXRjLgo+IAo+IERvZXMgdGhhdCBtYWtlIG1vcmUgc2Vuc2U/Cj4gClRoYW5rIHlv
dSwgQm9yaXMuIEdvb2QgaWRlYSwgSSB3aWxsIHJldGhpbmsgYWJvdXQgdGhpcyBpc3N1ZSBhbmQg
cG9zdCBpdCBhZ2Fpbi4KClJlZ2FyZHMsCkxpYW5ibwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
