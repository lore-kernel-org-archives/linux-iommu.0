From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
Date: Mon, 15 Dec 2014 15:38:04 +0000
Message-ID: <20141215153804.GK20738@arm.com>
References: <1418648413-32013-1-git-send-email-broonie@kernel.org>
	<548EDDCD.4060203@samsung.com>
	<20141215153529.GC11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141215153529.GC11764-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gTW9uLCBEZWMgMTUsIDIwMTQgYXQgMDM6MzU6MjlQTSArMDAwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBNb24sIERlYyAxNSwgMjAxNCBhdCAwMjoxMDozN1BNICswMTAwLCBLcnp5c3p0b2Yg
S296xYJvd3NraSB3cm90ZToKPiA+IEZldyBkYXlzIGFnbyBJIHBvc3RlZCBzaW1pbGFyIHBhdGNo
Ogo+ID4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTQvMTIvNS8yNjgKPiA+IGJ1dCBubyBvbmUg
aGF2ZSBwaWNrZWQgaXQgdXAuCj4gCj4gPiBBbnl3YXkgdGhlIGZpeCBvZiB5b3VycyBzZWVtcyBm
aW5lIHRvIG1lLgo+IAo+IEkgZG9uJ3QgbWluZCBlaXRoZXIgd2F5LCBpdCBqdXN0IHNlZW1lZCB0
byBiZSBlYXNpZXIgdG8gcmVwb3J0IHRoZSBidWcKPiB3aXRoIGEgcGF0Y2guICBJZiBKZW9yZyBp
cyBidXN5IHBlcmhhcHMgaXQgY2FuIGdvIHZpYSB0aGUgYXJtNjQgdHJlZSwKPiB0aGUgaXNzdWUg
aXMgdHJpZ2dlcmVkIGJ5IHRoZSBhZGRpdGlvbiBvZiB0aGUgcGxhdGZvcm0gdGhlcmU/CgpDYW4g
SSBwYXNzIHRoZSBidWNrIHRvIGFybS1zb2MsIGFzIHRoZXkncmUgaGFuZGxpbmcgYXJtNjQgcGxh
dGZvcm0gY29kZT8KCkl0IHNlZW1zIHNlbnNpYmxlIHRvIG1lcmdlIHRoZSBmaXggdmlhIHRoZSBz
YW1lIHRyZWUgdGhhdCBpbnRyb2R1Y2VkIHRoZQpicmVha2FnZS4KCldpbGwKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
