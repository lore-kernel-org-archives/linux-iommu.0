From: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 1 May 2019 09:18:41 -0600
Message-ID: <4a47cf86-a05d-3de5-0320-eda06101cc75@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <35c4635e-8214-7dde-b4ec-4cb266b2ea10@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <35c4635e-8214-7dde-b4ec-4cb266b2ea10@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave@sr71.net>, linux-doc@vger.kernel.org, linux-mm@kvack.org, deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, tycho@tycho.ws, x86@kernel.org, iommu@lists.linux-foundation.org, jsteckli@amazon.de, Arjan van de Ven <arjan@infradead.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, konrad.wilk@oracle.com, jcm@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, boris.ostrovsky@oracle.com, chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com, linux-security-module@vger.kernel.org, Juerg Haefliger <juerg.haefliger@canonical.com>, keescook@google.com, Andrew Morton <akpm@linux-foundation.org>, Linus
List-Id: iommu@lists.linux-foundation.org

T24gNS8xLzE5IDg6NDkgQU0sIFdhaW1hbiBMb25nIHdyb3RlOgo+IE9uIFdlZCwgQXByIDAzLCAy
MDE5IGF0IDExOjM0OjA0QU0gLTA2MDAsIEtoYWxpZCBBeml6IHdyb3RlOgo+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQKPiBiL0Rv
Y3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0Cj4gCj4+IGluZGV4
IDg1OGI2YzBiOWExNS4uOWIzNmRhOTQ3NjBlIDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAo+PiArKysgYi9Eb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAo+PiBAQCAtMjk5Nyw2ICsyOTk3LDEy
IEBACj4+Cj4+IMKgwqDCoMKgwqAgbm94MmFwaWPCoMKgwqAgW1g4Ni02NCxBUElDXSBEbyBub3Qg
ZW5hYmxlIHgyQVBJQyBtb2RlLgo+Pgo+PiArwqDCoMKgIG5veHBmb8KgwqDCoMKgwqDCoMKgIFtY
UEZPXSBEaXNhYmxlIGVYY2x1c2l2ZSBQYWdlIEZyYW1lIE93bmVyc2hpcCAoWFBGTykKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgd2hlbiBDT05GSUdfWFBGTyBpcyBvbi4gUGh5c2ljYWwgcGFn
ZXMgbWFwcGVkIGludG8KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXNlciBhcHBsaWNhdGlv
bnMgd2lsbCBhbHNvIGJlIG1hcHBlZCBpbiB0aGUKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
a2VybmVsJ3MgYWRkcmVzcyBzcGFjZSBhcyBpZiBDT05GSUdfWFBGTyB3YXMgbm90Cj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVuYWJsZWQuCj4+ICsKPj4gwqDCoMKgwqDCoCBjcHUwX2hvdHBs
dWfCoMKgwqAgW1g4Nl0gVHVybiBvbiBDUFUwIGhvdHBsdWcgZmVhdHVyZSB3aGVuCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIENPTkZJR19CTyBPVFBBUkFNX0hPVFBMVUdfQ1BVMCBpcyBv
ZmYuCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNvbWUgZmVhdHVyZXMgZGVwZW5kIG9u
IENQVTAuIEtub3duIGRlcGVuZGVuY2llcyBhcmU6Cj4gCj4gR2l2ZW4gdGhlIGJpZyBwZXJmb3Jt
YW5jZSBpbXBhY3QgdGhhdCBYUEZPIGNhbiBoYXZlLiBJdCBzaG91bGQgYmUgb2ZmIGJ5Cj4gZGVm
YXVsdCB3aGVuIGNvbmZpZ3VyZWQuIEluc3RlYWQsIHRoZSB4cGZvIG9wdGlvbiBzaG91bGQgYmUg
dXNlZCB0bwo+IGVuYWJsZSBpdC4KCkFncmVlZC4gSSBwbGFuIHRvIGRpc2FibGUgaXQgYnkgZGVm
YXVsdCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZQpwYXRjaC4gVGhpcyBpcyBsaWtlbHkgdG8g
ZW5kIHVwIGJlaW5nIGEgZmVhdHVyZSBmb3IgZXh0cmVtZSBzZWN1cml0eQpjb25zY2lvdXMgZm9s
a3Mgb25seSwgdW5sZXNzIEkgb3Igc29tZW9uZSBlbHNlIGNvbWVzIHVwIHdpdGggZnVydGhlcgpz
aWduaWZpY2FudCBwZXJmb3JtYW5jZSBib29zdC4KClRoYW5rcywKS2hhbGlkCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
