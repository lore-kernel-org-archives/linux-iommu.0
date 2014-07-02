From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
Date: Wed, 2 Jul 2014 02:46:01 -0500
Message-ID: <53B3B8B9.30400@Freescale.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
 <1403618237-26248-2-git-send-email-Varun.Sethi__13822.953499812$1403630309$gmane$org@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1403618237-26248-2-git-send-email-Varun.Sethi__13822.953499812$1403630309$gmane$org@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Varun Sethi <Varun.Sethi@Freescale.com>, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org

T24gMDYvMjQvMjAxNCAwODo1NyBBTSwgVmFydW4gU2V0aGkgd3JvdGU6Cj4gaXNfcG93ZXJfb2Zf
MiByZXF1aXJlcyBhbiB1bnNpZ25lZCBsb25nIHBhcmFtZXRlciB3aGljaCB3b3VsZAo+IGxlYWQg
dG8gdHJ1bmNhdGlvbiBvZiA2NCBiaXQgdmFsdWVzIG9uIDMyIGJpdCBhcmNoaXRlY3R1cmVzLgo+
IAo+IF9fZmZzIGFsc28gZXhwZWN0cyBhbiB1bnNpZ25lZCBsb25nIHBhcmFtZXRlciB0aHVzIHdv
bid0IHdvcmsKPiBmb3IgNjQgYml0IHZhbHVlcyBvbiAzMiBiaXQgYXJjaGl0ZWN0dXJlcy4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBWYXJ1biBTZXRoaSA8VmFydW4uU2V0aGlAZnJlZXNjYWxlLmNvbT4K
PiAtLS0KPiAgZHJpdmVycy9pb21tdS9mc2xfcGFtdS5jICAgICAgICB8ICAgIDggKysrKy0tLS0K
PiAgZHJpdmVycy9pb21tdS9mc2xfcGFtdV9kb21haW4uYyB8ICAgIDIgKy0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpUZXN0ZWQtYnk6IEVtaWwg
TWVkdmUgPEVtaWxpYW4uTWVkdmVARnJlZXNjYWxlLmNvbT4KCk9uIGEgUDQwODAgRFMgKGkuZS4g
MzItYml0IFNvQykKCgpDaGVlcnMsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3Rz
Lm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRl
dg==
