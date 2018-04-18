From: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Wed, 18 Apr 2018 16:51:26 -0400
Message-ID: <151f3396-959b-86f6-e056-58d38682d858@amd.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
	<152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
	<1523664612.2747.13.camel@intel.com>
	<efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
	<1524031122.4031.5.camel@hxt-semitech.com>
	<1524036520.2747.31.camel@intel.com>
	<1524040290.4031.25.camel@hxt-semitech.com>
	<1524082659.2747.37.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1524082659.2747.37.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org" <shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org>, "gary.hook-5C7GfCeVMHo@public.gmane.org" <gary.hook-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gNC8xOC8yMDE4IDQ6MTYgUE0sIE1laHRhLCBTb2hpbCB3cm90ZToKPiBPbiBXZWQsIDIwMTgt
MDQtMTggYXQgMDg6MzEgKzAwMDAsIFlhbmcsIFNodW55b25nIHdyb3RlOgo+PiBNYXliZSB0aGUg
b3JpZ2luYWwgZGVzaWduIGlzIHRvIGNhbGzCoGRlYnVnZnNfaW5pdGlhbGl6ZWQoKSBiZWZvcmUK
Pj4gY2FsbGluZ8KgZGVidWdmc19jcmVhdGVfeHh4KCk/Cj4gCj4gSSBhbSB1bmF3YXJlIG9mIHRo
ZSBvcmlnaW5hbCBkZXNpZ24uIFNvbWVvbmUgZWxzZSB3b3VsZCBwcm9iYWJseSBoYXZlCj4gbW9y
ZSBjb250ZXh0LiBIb3dldmVyLCBsb29raW5nIGF0IG90aGVyIHBsYWNlcyBpbiB0aGUga2VybmVs
IHdoZXJlCj4gZGVidWdmc19jcmVhdGVfeHgoKSBpcyB1c2VkLCB0aGUgY29tbW9uIGNvbnZlbnRp
b24gc2VlbXMgdG8gYmUgdG8gYXZvaWQKPiBjYWxsaW5nwqBkZWJ1Z2ZzX2luaXRpYWxpemVkKCku
Cj4gCj4gIMKgU29oaWwKPiAKCmRlYnVnZnNfaW5pdGlhbGl6ZWQoKSB3YXMgaW50cm9kdWNlZCBp
biBjb21taXQgYzBmOTJiYTk5IGJhY2sgaW4gCjIuNi4zMC1yYzEuIEl0IHdhcyBpbnRlbmRlZCBh
cyBhIGhlbHBlciwgbm90IGFzIGEgZ2F0ZWtlZXBlciwgd2hpY2ggaXMgCndoeSBvbmUgZG9lc24n
dCBzZWUgaXQgdXNlZC4gR2l2ZW4gdGhhdCBteSB1c2UgaW4gdGhpcyBwcm9wb3NlZCBwYXRjaCBp
cyAKc3RyYWlnaHRmb3J3YXJkLCBJJ20gbm90IHNlZWluZyB0aGUgbmVlZCBoZXJlLiBJIGhhZCBq
dXN0IHNlZW4gc29tZSAKb3RoZXIgY29kZSB0aGF0IHVzZWQgaXQsIGFuZCBjb3BpZWQgdGhlIG1v
ZGVsLgoKVW5sZXNzIHNvbWVvbmUgY29tZXMgYWxvbmcgdG8gc2F5LCB5ZXMsIHVzZSBpdCwgSSds
bCBub3QuCgpHYXJ5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
