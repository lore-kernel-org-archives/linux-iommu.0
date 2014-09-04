From: Varun Sethi <Varun.Sethi@freescale.com>
Subject: RE: [PATCH] iommu/fsl: Fix warning resulting from adding PCI device
 twice
Date: Thu, 4 Sep 2014 10:57:59 +0000
Message-ID: <332f3406b1974ff38aef45cc4f55373a@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1409810622-742-1-git-send-email-Varun.Sethi@freescale.com>
 <20140904101402.GM28786@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20140904101402.GM28786@8bytes.org>
Content-Language: en-US
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
To: Joerg Roedel <joro@8bytes.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Emilian Medve <Emilian.Medve@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Cgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogSm9lcmcgUm9lZGVsIFttYWls
dG86am9yb0A4Ynl0ZXMub3JnXQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMDQsIDIwMTQg
Mzo0NCBQTQo+IFRvOiBTZXRoaSBWYXJ1bi1CMTYzOTUKPiBDYzogaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmc7IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBNZWR2ZQo+IEVtaWxp
YW4tRU1NRURWRTE7IGxpbnV4cHBjLWRldkBvemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW9tbXUvZnNsOiBGaXggd2FybmluZyBy
ZXN1bHRpbmcgZnJvbSBhZGRpbmcgUENJIGRldmljZQo+IHR3aWNlCj4gCj4gT24gVGh1LCBTZXAg
MDQsIDIwMTQgYXQgMTE6MzM6NDJBTSArMDUzMCwgVmFydW4gU2V0aGkgd3JvdGU6Cj4gPiArCWlm
ICghaW9tbXVfZ3JvdXBfZ2V0KGRldikpCj4gPiArCQlyZXQgPSBpb21tdV9ncm91cF9hZGRfZGV2
aWNlKGdyb3VwLCBkZXYpOwo+ID4KPiA+ICAJaW9tbXVfZ3JvdXBfcHV0KGdyb3VwKTsKPiA+ICAJ
cmV0dXJuIHJldDsKPiAKPiBEb2Vzbid0IHRoaXMgYWRkaXRpb25hbCBjYWxsIHRvIGlvbW11X2dy
b3VwX2dldCB0YWtlIGEgcmVmZXJlbmNlIHRvIHRoZQo+IGlvbW11X2dyb3VwIHRoYXQgbmVlZHMg
dG8gYmUgcmVsZWFzZWQ/ClllcywgeW91IGFyZSByaWdodCB0aGlzIHdvdWxkIHRha2UgYSByZWZl
cmVuY2UgdG8gdGhlIGdyb3VwIHRoYXQgc2hvdWxkIGJlIHJlbGVhc2VkLiBJIG5lZWQgdG8gYWRk
IGlvbW11X2dyb3VwX3B1dCBmb3IgZGVjcmVtZW50aW5nIHRoZSByZWZlcmVuY2UgY291bnQuIFdp
bGwgcG9zdCBhIG5ldyBwYXRjaC4KClRoYW5rcywKVmFydW4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0Ckxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0
aW5mby9saW51eHBwYy1kZXY=
