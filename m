From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V5] drm/i915: Disable stolen memory when
 i915 runs on qemu
Date: Thu, 13 Apr 2017 07:23:25 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190CA9803@SHSMSX101.ccr.corp.intel.com>
References: <1491358106-26329-1-git-send-email-xiong.y.zhang@intel.com>
 <1491999600-4406-1-git-send-email-xiong.y.zhang@intel.com>
 <1492003316.3274.44.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1492003316.3274.44.camel@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

PiBGcm9tOiBKb29uYXMgTGFodGluZW4gW21haWx0bzpqb29uYXMubGFodGluZW5AbGludXguaW50
ZWwuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDEyLCAyMDE3IDk6MjIgUE0NCj4gDQpb
Li4uXQ0KPiBCeSBteSBsaW1pdGVkIHVuZGVyc3RhbmRpbmcgb2YgVlQtZCBkZXRhaWxzOiBUaGUg
c3RvbGVuIG1lbW9yeSBpcyBuZXZlcg0KPiBkaXJlY3RseSBhY2Nlc3NlZCBieSBpOTE1IGRyaXZl
ciAoYmVjYXVzZSBDUFUgYWNjZXNzIGRvZXNuJ3Qgd29yayBldmVuDQo+IGluIERPTTApLiBJdCBp
cyBvbmx5IHVzZWQgdGhyb3VnaCB0aGUgYXBlcnR1cmUsIHdoaWNoIGp1c3QgcmVxdWlyZXMgZm9y
DQo+IHRoZSBHVCBkZXZpY2UgdG8gaGF2ZSBhY2Nlc3MgdG8gdGhlIFJNUlIuIEZ1cnRoZXIsIHRo
ZSBHVCBkZXZpY2UgbmVlZHMNCj4gdG8gaGF2ZSBhY2Nlc3MgdG8gc3RvbGVuIG1lbW9yeSwgYmVj
YXVzZSB0aGF0J3Mgd2hhdCBHdUMgdXNlcyBmb3INCj4gYmFja2luZyBzdG9yYWdlIGZvciBmb3Ig
V09QQ00uDQo+IA0KPiBBbmQgZXZlbiBpZiBhZnRlciBhbGwgb2YgdGhlIGFib3ZlIGlzIGFkZHJl
c3NlZCwgc2hvdWxkbid0IHdlIHJhdGhlcg0KPiB0cnkgdG8gZGV0ZWN0IHRoZSBsYWNrIG9mIFJN
UlIsIHRoYW4gcHJlc2VuY2Ugb2YgUUVNVSBJU0E/DQo+IA0KPiBXaGF0IGNvbWVzIHRvIG15IG1p
bmQgaXMgZXhwb3J0aW5nIGZ1bmN0aW9uIGxpa2UgZGV2aWNlX2hhc19ybXJyKCkgZnJvbQ0KPiBp
bnRlbC1pb21tdS5jb20gYW5kIGNvbnN1bWluZyB0aGF0LCBpZiB3ZSBlbmQgdXAgZG9pbmcgdGhp
cy4gVGhhdCB3YXksDQo+IGlmIHNvbWVib2R5LCBzb21lIGRheSwgZ29lcyBhbmQgd3JpdGUgUk1S
UiBwYXNzLXRocm91Z2ggY29kZSBjdXJyZW50bHkNCj4gbWlzc2luZywgaXQnbGwgc3RhcnQgd29y
a2luZywganVzdCBsaWtlIGl0IHNob3VsZC4NCj4gDQoNCkkgbGlrZSB3aGF0IHlvdSBwcm9wb3Nl
ZCBpbiB0aGUgbG9uZyBydW4sIGUuZy4gaW4gYSBuZXN0ZWQgdmlydHVhbGl6YXRpb24NCmVudmly
b25tZW50IEwwLVZNTSBhc3NpZ25zIHRoZSBkZXZpY2UgdG8gTDEtVk1NIHdoaWNoIGZ1cnRoZXIN
CndhbnRzIHRvIGFzc2lnbiBkZXZpY2UgdG8gTDItVk0uIEluIHN1Y2ggY2FzZSBSTVJSIGluZm9y
bWF0aW9uIA0KbXVzdCBiZSBwcm9wYWdhdGVkIHRocm91Z2ggdGhlIHBhdGggdG8gTDEtVk1NLg0K
DQpIb3dldmVyIEkgY2FuIHNlZSBvbmUgbGltaXRhdGlvbiBoZXJlIG9uIHlvdXIgcHJvcG9zYWwu
IFRoZXJlIGlzIG5vIA0KUk1SUiBpZiBWVC1kIGlzIGRpc2FibGVkIGluIEJJT1MuIFRoZW4geW91
IGNhbm5vdCB1c2Ugc3RvbGVuIG1lbW9yeSANCmV2ZW4gb24gYmFyZSBtZXRhbCBpbiBzdWNoIGNv
bmZpZ3VyYXRpb24sIHdoaWNoIGlzIHBvc3NpYmx5IG5vdCBkZXNpcmVkLg0KDQpBbHNvIHRoZSBs
b25nIHRlcm0gZGlyZWN0aW9uIGlzIHRvIG1vdmUgYXdheSBmcm9tIFJNUlIgZm9yIEludGVsDQpp
bnRlZ3JhdGVkIGRldmljZXMuIFBlb3BsZSByZWFsaXplZCBpdHMgbGltaXRhdGlvbiAoZXNwZWNp
YWxseSB0aGUNCm9iamVjdGlvbiBmcm9tIEtWTSBjb21tdW5pdHkuIEkgZG9uJ3QgdGhpbmsgUk1S
UiBwYXNzdGhyb3VnaA0Kd291bGQgYmUgYW4gb3B0aW9uIHRoZXJlKS4gU28gSSdkIGJlIHdpdGgg
WGlvbmcncyBzaW1wbGUgd29ya2Fyb3VuZA0KaGVyZS4gOi0pDQoNClRoYW5rcw0KS2V2aW4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBt
YWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
