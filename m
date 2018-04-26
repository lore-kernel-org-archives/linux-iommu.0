From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [Linaro-mm-sig] noveau vs arm dma ops
Date: Thu, 26 Apr 2018 11:39:09 +0200
Message-ID: <CAKMK7uEK_KjjWUwsiFPW1KmUkjy2j8tA_R4zc5u1gJ6BHRfAVw@mail.gmail.com>
References: <20180425054855.GA17038@infradead.org>
 <CAKMK7uEFitkNQrD6cLX5Txe11XhVO=LC4YKJXH=VNdq+CY=DjQ@mail.gmail.com>
 <CAKMK7uFx=KB1vup=WhPCyfUFairKQcRR4BEd7aXaX1Pj-vj3Cw@mail.gmail.com>
 <20180425064335.GB28100@infradead.org> <20180425074151.GA2271@ulmo>
 <20180425085439.GA29996@infradead.org>
 <20180425100429.GR25142@phenom.ffwll.local>
 <20180425153312.GD27076@infradead.org>
 <20180425225443.GQ16141@n2100.armlinux.org.uk>
 <CAKMK7uG9R6paoP4BmvqDVUP_4Db4Dz8MSXeLwUBMYaORa5-kVw@mail.gmail.com>
 <20180426092422.GA26825@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180426092422.GA26825@infradead.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Jerome Glisse <jglisse@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, Dan Williams <dan.j.williams@intel.com>, Thierry Reding <treding@nvidia.com>, Logan Gunthorpe <logang@deltatee.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

T24gVGh1LCBBcHIgMjYsIDIwMTggYXQgMTE6MjQgQU0sIENocmlzdG9waCBIZWxsd2lnIDxoY2hA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gT24gVGh1LCBBcHIgMjYsIDIwMTggYXQgMTE6MjA6NDRB
TSArMDIwMCwgRGFuaWVsIFZldHRlciB3cm90ZToKPj4gVGhlIGFib3ZlIGlzIGFscmVhZHkgd2hh
dCB3ZSdyZSBpbXBsZW1lbnRpbmcgaW4gaTkxNSwgYXQgbGVhc3QKPj4gY29uY2VwdHVhbGx5IChp
dCBhbGwgYm9pbHMgZG93biB0byBjbGZsdXNoIGluc3RydWN0aW9ucyBiZWNhdXNlIHRob3NlCj4+
IGJvdGggaW52YWxpZGF0ZSBhbmQgZmx1c2gpLgo+Cj4gVGhlIGNsd2IgaW5zdHJ1Y3Rpb24gdGhh
dCBqdXN0IHdyaXRlcyBiYWNrIGRpcnR5IGNhY2hlIGxpbmVzIG1pZ2h0Cj4gYmUgdmVyeSBpbnRl
cmVzdGluZyBmb3IgdGhlIHg4NiBub24tY29oZXJlbnQgZG1hIGNhc2UuICBBIGxvdCBvZgo+IGFy
Y2hpdGVjdHVyZXMgdXNlIHRoZWlyIGVxdWl2YWxlbnQgdG8gcHJlcGFyZSB0byB0byBkZXZpY2Ug
dHJhbnNmZXJzLgoKSWlyYyBkaWRuJ3QgaGVscCBmb3IgaTkxNSB1c2UtY2FzZXMgbXVjaC4gRWl0
aGVyIGRhdGEgZ2V0cyBzdHJlYW1lZApiZXR3ZWVuIGNwdSBhbmQgZ3B1LCBhbmQgdGhlbiBrZWVw
aW5nIHRoZSBjbGVhbiBjYWNoZWxpbmUgYXJvdW5kCmRvZXNuJ3QgYnV5IHlvdSBhbnl0aGluZy4g
SW4gb3RoZXIgY2FzZXMgd2UgbmVlZCB0byBmbHVzaCBiZWNhdXNlIHRoZQpncHUgcmVhbGx5IHdh
bnRzIHRvIHVzZSBub24tc25vb3BlZCB0cmFuc2FjdGlvbnMgKGZhc3Rlci9sb3dlcgpsYXRlbmN5
L2xlc3MgcG93ZXIgcmVxdWlyZWQgZm9yIGRpc3BsYXkgYmVjYXVzZSB5b3UgY2FuIHNodXQgZG93
biB0aGUKY2FjaGVzKSwgYW5kIHRoZW4gdGhlcmUncyBhbHNvIG5vIGJlbmVmaXQgd2l0aCBrZWVw
aW5nIHRoZSBjYWNoZWxpbmUKYXJvdW5kIChubyBvbmUgd2lsbCBldmVyIG5lZWQgaXQgYWdhaW4p
LgoKSSB0aGluayBjbHdiIGlzIG1vcmUgZm9yIHBlcnNpc3RlbnQgbWVtb3J5IGFuZCBzdHVmZiBs
aWtlIHRoYXQsIG5vdCBzbwptdWNoIGZvciBncHVzLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVy
ClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgorNDEgKDApIDc5IDM2NSA1NyA0
OCAtIGh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbAo=
