From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu/vt-d: fix overflow of
	iommu->domains array
Date: Mon, 27 Jun 2016 13:23:32 +0200
Message-ID: <20160627112332.GB13539@8bytes.org>
References: <CAHMfzJkuRBCMtkGniODGxfrZrmthx9nHog8vq-jCTMVJb_64Bw@mail.gmail.com>
 <20160606103209.GA30777@mcvlad-wk.rb.intel.com>
 <20160606122010.GA3048@x61s.reliablesolutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20160606122010.GA3048@x61s.reliablesolutions.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jan Niehusmann <jan@gondor.com>
Cc: Omer Peleg <omer@cs.technion.ac.il>, David.Woodhouse@intel.com, intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org, Adam Morrison <mad@cs.technion.ac.il>
List-Id: iommu@lists.linux-foundation.org

T24gTW9uLCBKdW4gMDYsIDIwMTYgYXQgMDI6MjA6MTFQTSArMDIwMCwgSmFuIE5pZWh1c21hbm4g
d3JvdGU6Cj4gVGhlIHZhbGlkIHJhbmdlIG9mICdkaWQnIGluIGdldF9pb21tdV9kb21haW4oKmlv
bW11LCBkaWQpCj4gaXMgMC4uY2FwX25kb21zKGlvbW11LT5jYXApLCBzbyBkb24ndCBleGNlZWQg
dGhhdAo+IHJhbmdlIGluIGZyZWVfYWxsX2NwdV9jYWNoZWRfaW92YXMoKS4KPiAKPiBUaGUgdXNl
ci12aXNpYmxlIGltcGFjdCBvZiB0aGUgb3V0LW9mLWJvdW5kcyBhY2Nlc3MgaXMgdGhlIG1hY2hp
bmUKPiBoYW5naW5nIG9uIHN1c3BlbmQtdG8tcmFtLiBJdCBpcywgaW4gZmFjdCwgYSBrZXJuZWwg
cGFuaWMsIGJ1dCBkdWUKPiB0byBhbHJlYWR5IHN1c3BlbmRlZCBkZXZpY2VzLCB0aGF0J3Mgb2Z0
ZW4gbm90IHZpc2libGUgdG8gdGhlIHVzZXIuCj4gCj4gRml4ZXM6IDIyZTJmOWZhNjNiMCAoImlv
bW11L3Z0LWQ6IFVzZSBwZXItY3B1IElPVkEgY2FjaGluZyIpCj4gU2lnbmVkLW9mZi1ieTogSmFu
IE5pZWh1c21hbm4gPGphbkBnb25kb3IuY29tPgo+IFRlc3RlZC1CeTogTWFyaXVzIFZsYWQgPG1h
cml1cy5jLnZsYWRAaW50ZWwuY29tPgoKUXVldWVkIHRvIGlvbW11L2ZpeGVzIGJyYW5jaCwgdGhh
bmtzIEphbi4KCgoKCUpvZXJnCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9p
bnRlbC1nZngK
