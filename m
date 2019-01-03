From: Tony Luck <tony.luck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/15] swiotlb: remove dma_mark_clean
Date: Thu, 3 Jan 2019 09:35:08 -0800
Message-ID: <CA+8MBbKXTRGLn1Wvpp1avQCZ186i5Cbo0puvSoNNuKO7_AcwZg@mail.gmail.com>
References: <20181207190720.18517-1-hch@lst.de>
	<20181207190720.18517-3-hch@lst.de>
	<CA+8MBb+9prWYSmp25K-LMUv1_0eekvFqXhoj87CV9zcaXfMDGg@mail.gmail.com>
	<20190103072356.GA24163@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190103072356.GA24163-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke-LJ9M9ZcSy1A@public.gmane.org>, "linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Ilias Apalodimas <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, X86-ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jonathan Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tariq Toukan <tariqt-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCBKYW4gMiwgMjAxOSBhdCAxMToyMyBQTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4gd3JvdGU6Cj4gSSB0aGluayBzb21ldGhpbmcgbGlrZSB0aGUgcGF0Y2ggYmVsb3cgc2hv
dWxkIGZpeCBpdDoKPgo+IGRpZmYgLS1naXQgYS9hcmNoL2lhNjQvS2NvbmZpZyBiL2FyY2gvaWE2
NC9LY29uZmlnCj4gaW5kZXggY2NkNTZmNWRmOGNkLi44ZDczOTZiZDE3OTAgMTAwNjQ0Cj4gLS0t
IGEvYXJjaC9pYTY0L0tjb25maWcKPiArKysgYi9hcmNoL2lhNjQvS2NvbmZpZwo+IEBAIC0zMSw3
ICszMSw3IEBAIGNvbmZpZyBJQTY0Cj4gICAgICAgICBzZWxlY3QgSEFWRV9NRU1CTE9DS19OT0RF
X01BUAo+ICAgICAgICAgc2VsZWN0IEhBVkVfVklSVF9DUFVfQUNDT1VOVElORwo+ICAgICAgICAg
c2VsZWN0IEFSQ0hfSEFTX0RNQV9DT0hFUkVOVF9UT19QRk4gaWYgU1dJT1RMQgo+IC0gICAgICAg
c2VsZWN0IEFSQ0hfSEFTX1NZTkNfRE1BX0ZPUl9DUFUKPiArICAgICAgIHNlbGVjdCBBUkNIX0hB
U19TWU5DX0RNQV9GT1JfQ1BVIGlmIFNXSU9UTEIKCkNsb3NlLiBCdXQgbm8gY2lnYXIuIE5vdyBJ
IGdldDoKCiAgQ0MgICAgICBhcmNoL2lhNjQvbW0vaW5pdC5vCmFyY2gvaWE2NC9tbS9pbml0LmM6
NzU6NjogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhhcmNoX3N5bmNfZG1hX2Zvcl9jcHXigJkK
Li9pbmNsdWRlL2xpbnV4L2RtYS1ub25jb2hlcmVudC5oOjYxOjIwOiBub3RlOiBwcmV2aW91cyBk
ZWZpbml0aW9uIG9mCuKAmGFyY2hfc3luY19kbWFfZm9yX2NwdeKAmSB3YXMgaGVyZQptYWtlWzFd
OiAqKiogW2FyY2gvaWE2NC9tbS9pbml0Lm9dIEVycm9yIDEKbWFrZTogKioqIFthcmNoL2lhNjQv
bW0vaW5pdC5vXSBFcnJvciAyCgoKLVRvbnkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
