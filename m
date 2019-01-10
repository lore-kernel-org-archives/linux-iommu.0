From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: amdgpu/TTM oopses since merging swiotlb_dma_ops into the
 dma_direct code
Date: Thu, 10 Jan 2019 15:00:31 +0100
Message-ID: <a3f0fd49-2286-ee2a-f0e8-dfe82aac73fb@gmail.com>
References: <61f8f660-005c-190c-c08f-b563de2eae18@daenzer.net>
 <20190110135741.GA9255@lst.de>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190110135741.GA9255@lst.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@lst.de>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc: Sibren Vasse <freedesktop@sibrenvasse.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, amd-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

QW0gMTAuMDEuMTkgdW0gMTQ6NTcgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoKPiBPbiBUaHUs
IEphbiAxMCwgMjAxOSBhdCAxMDo1OTowMkFNICswMTAwLCBNaWNoZWwgRMOkbnplciB3cm90ZToK
Pj4gSGkgQ2hyaXN0b3BoLAo+Pgo+Pgo+PiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnLzEw
OTIzNCAocGxlYXNlIGlnbm9yZSBjb21tZW50cyAjNi0jOSkgd2FzCj4+IGJpc2VjdGVkIHRvIHlv
dXIgY29tbWl0IDU1ODk3YWY2MzA5MSAiZG1hLWRpcmVjdDogbWVyZ2Ugc3dpb3RsYl9kbWFfb3Bz
Cj4+IGludG8gdGhlIGRtYV9kaXJlY3QgY29kZSIuIEFueSBpZGVhcz8KPiAgRnJvbSB0aGUgdHJh
Y2UgaXQgbG9va3MgbGlrZSB3ZSBnaXQgdGhlIGNhc2Ugd2hlcmUgc3dpb3RsYiB0cmllcwo+IHRv
IGNvcHkgYmFjayBkYXRhIGZyb20gYSBib3VuY2UgYnVmZmVyLCBidXQgaGl0cyBhIGRhbmdsaW5n
IG9yIE5VTEwKPiBwb2ludGVyLiAgU28gYSBjb3VwbGUgcXVlc3Rpb25zIGZvciB0aGUgc3VibWl0
dGVyOgo+Cj4gICAtIGRvZXMgdGhlIHN5c3RlbSBoYXZlIG1vcmUgdGhhbiA0R0IgbWVtb3J5IGFu
ZCB0aHVzIHVzZSBzd2lvdGxiPwo+ICAgICAoY2hlY2sgL3Byb2MvbWVtaW5mbywgYW5kIGlmIHNv
bWV0aGluZyBTV0lPVExCIGFwcGVhcnMgaW4gZG1lc2cpCj4gICAtIGRvZXMgdGhlIGRldmljZSB0
aGlzIGhhcHBlbnMgb24gaGF2ZSBhIERNQSBtYXNrIHNtYWxsZXIgdGhhbgo+ICAgICB0aGUgYXZh
aWxhYmxlIG1lbW9yeSwgdGhhdCBpcyBzaG91bGQgc3dpb3RsYiBiZSB1c2VkIGhlcmUgdG8gc3Rh
cnQKPiAgICAgd2l0aD8KClJhdGhlciB1bmxpa2VseS4gVGhlIGRldmljZSBpcyBhbiBBTUQgR1BV
LCBzbyB3ZSBjYW4gYWRkcmVzcyBtZW1vcnkgdXAgCnRvIDFUQi4KCkNocmlzdGlhbi4KCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwg
bWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
