From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 00/21] DT cpu node iterator
Date: Fri, 7 Sep 2018 08:58:41 -0500
Message-ID: <CAL_JsqLvLoekvxcaBMxrboJzqS=NyB69NHLShos+LhETj7zNwQ@mail.gmail.com>
References: <20180905193738.19325-1-robh@kernel.org>
 <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, SH-Linux <linux-sh@vger.kernel.org>, vitb@kernel.crashing.org, Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-clk <linux-clk@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Salter <msalter@redhat.com>, devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, Bartlomiej
List-Id: iommu@lists.linux-foundation.org

T24gRnJpLCBTZXAgNywgMjAxOCBhdCA3OjU0IEFNIE1pY2hhbCBTaW1layA8bW9uc3RyQG1vbnN0
ci5ldT4gd3JvdGU6Cj4KPiBIaSBSb2IsCj4KPiAyMDE4LTA5LTA1IDIxOjM3IEdNVCswMjowMCBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjoKPj4KPj4gVGhpcyBzZXJpZXMgYWRkcyBhbiBp
dGVyYXRvciBmb3IgY3B1IG5vZGVzIGFuZCBjb252ZXJ0cyB1c2VycyBvdmVyIHRvIHVzZQo+PiBp
dCBvciBvZl9nZXRfY3B1X25vZGUgaW4gc29tZSBjYXNlcy4gVGhpcyBhbGxvd3MgdXMgdG8gcmVt
b3ZlIHRoZQo+PiBkZXBlbmRlbmN5IG9uIGRldmljZV90eXBlIHByb3BlcnR5IGZvciBjcHUgbm9k
ZXMgdGhvdWdoIHJlbW92aW5nIHRoYXQKPj4gZnJvbSBEVFMgZmlsZXMgd2lsbCBoYXZlIHRvIHdh
aXQgZm9yIHNvbWUgdGltZS4gSW4gc29tZSBjYXNlcywgdGhpcyBtYWtlcwo+PiB0aGUgRFQgc2Vh
cmNoIG1vcmUgc3RyaWN0IGJ5IG9ubHkgbG9va2luZyBpbiAvY3B1cyBjaGlsZCBub2RlcyByYXRo
ZXIKPj4gdGhhbiBhbnkgbm9kZSB3aXRoIHRoZSBkZXZpY2VfdHlwZSA9PSBjcHUuIFRoZSBpdGVy
YXRvciBhbHNvIGhvbm9ycyB0aGUKPj4gc3RhdHVzIHByb3BlcnR5IHdoaWNoIGlzIG9mdGVuIGZv
cmdvdHRlbi4KPj4KPj4gSSd2ZSBvbmx5IHRlc3RlZCBvbiBBUk0gdW5kZXIgUUVNVSBhbmQgY29t
cGlsZWQgcG93ZXJwYy4KPgo+Cj4KPiBEbyB5b3UgaGF2ZSB0aGlzIHNvbWV3aGVyZSBpbiB5b3Vy
IHRyZWUgbm90IHRvIGFwcGx5IDIxIHBhdGNoZXMgYnkgaGFuZD8KClllcywgZHQvY3B1LXR5cGUg
YnJhbmNoIG9uIG15IGtlcm5lbC5vcmcgdHJlZS4KClJvYgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
