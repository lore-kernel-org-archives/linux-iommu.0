From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Panic when cpu hot-remove
Date: Wed, 17 Jun 2015 08:36:40 -0600
Message-ID: <1434551800.5628.5.camel@redhat.com>
References: <42BB8332972FC149B81C55A0D41E3A79C07469@jtjnmailbox06.home.langchao.com>
	<20150617115238.GC27750@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150617115238.GC27750-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedeljoro <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Roland Dreier <roland-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?=E9=97=AB=E6=99=93=E5=B3=B0?= <yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>, "jiang.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <jiang.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?=E5=88=98=E9=95=BF=E7=94=9F?= <liuchangsheng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, =?UTF-8?Q?=E8=8C=83=E5=86=AC=E5=86=AC?= <fandd-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCAyMDE1LTA2LTE3IGF0IDEzOjUyICswMjAwLCBKb2VyZyBSb2VkZWxqb3JvIHdyb3Rl
Ogo+IE9uIFdlZCwgSnVuIDE3LCAyMDE1IGF0IDEwOjQyOjQ5QU0gKzAwMDAsIOiMg+WGrOWGrCB3
cm90ZToKPiA+IEhpIG1haW50YWluZXIsCj4gPiAKPiA+IFdlIGZvdW5kIGEgcHJvYmxlbSB0aGF0
IGEgcGFuaWMgaGFwcGVuIHdoZW4gY3B1IHdhcyBob3QtcmVtb3ZlZC4gV2UgYWxzbyB0cmFjZSB0
aGUgcHJvYmxlbSBhY2NvcmRpbmcgdG8gdGhlIGNhbGx0cmFjZSBpbmZvcm1hdGlvbi4KPiA+IEFu
IGVuZGxlc3MgbG9vcCBoYXBwZW4gYmVjYXVzZSB2YWx1ZSBoZWFkIGlzIG5vdCBlcXVhbCB0byB2
YWx1ZSB0YWlsIGZvcmV2ZXIgaW4gdGhlIGZ1bmN0aW9uIHFpX2NoZWNrX2ZhdWx0KCApLgo+ID4g
VGhlIGxvY2F0aW9uIGNvZGUgaXMgYXMgZm9sbG93czoKPiA+IAo+ID4gCj4gPiBkbyB7Cj4gPiAg
ICAgICAgIGlmIChxaS0+ZGVzY19zdGF0dXNbaGVhZF0gPT0gUUlfSU5fVVNFKQo+ID4gICAgICAg
ICBxaS0+ZGVzY19zdGF0dXNbaGVhZF0gPSBRSV9BQk9SVDsKPiA+ICAgICAgICAgaGVhZCA9ICho
ZWFkIC0gMiArIFFJX0xFTkdUSCkgJSBRSV9MRU5HVEg7Cj4gPiAgICAgfSB3aGlsZSAoaGVhZCAh
PSB0YWlsKTsKPiAKPiBIbW0sIHRoaXMgY29kZSBpbnRlcmF0ZXMgb25seSBvdmVyIGV2ZXJ5IHNl
Y29uZCBRSSBkZXNjcmlwdG9yLCBhbmQgdGFpbAo+IHByb2JhYmx5IHBvaW50cyB0byBhIGRlc2Ny
aXB0b3IgdGhhdCBpcyBub3QgaXRlcmF0ZWQgb3Zlci4KPiAKPiBKaWFuZywgY2FuIHlvdSBwbGVh
c2UgaGF2ZSBhIGxvb2s/CgpJIHRoaW5rIHRoYXQgcGFydCBpcyBub3JtYWwsIHRoZSB3YXkgd2Ug
dXNlIHRoZSBxdWV1ZSBpcyB0byBhbHdheXMKc3VibWl0IGEgd29yayBvcGVyYXRpb24gZm9sbG93
ZWQgYnkgYSB3YWl0IG9wZXJhdGlvbiBzbyB0aGF0IHdlIGNhbgpkZXRlcm1pbmUgdGhlIHdvcmsg
b3BlcmF0aW9uIGlzIGNvbXBsZXRlLiAgVGhhdCdzIGRvbmUgdmlhCnFpX3N1Ym1pdF9zeW5jKCku
ICBXZSBoYXZlIGhhZCBzcHVyaW91cyByZXBvcnRzIG9mIHRoZSBxdWV1ZSBnZXR0aW5nCmltcG9z
c2libHkgb3V0IG9mIHN5bmMgdGhvdWdoLiAgSSBzYXcgb25lIHRoYXQgd2FzIHNvbWVob3cgbGlu
a2VkIHRvIHRoZQpJL08gQVQgRE1BIGVuZ2luZS4gIFJvbGFuZCBEcmVpZXIgc2F3IHNvbWV0aGlu
ZyBzaW1pbGFyWzFdLiAgSSdtIG5vdApzdXJlIGlmIHRoZXkncmUgcmVsYXRlZCB0byB0aGlzLCBi
dXQgbWF5YmUgd29ydGggY29tcGFyaW5nLiAgVGhhbmtzLAoKQWxleAoKWzFdIGh0dHA6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL3BpcGVybWFpbC9pb21tdS8yMDE1LUphbnVhcnkvMDExNTAy
Lmh0bWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
