From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Fail to boot Dom0 on Xen Arm64 after "dma-mapping:
 bypass indirect calls for dma-direct"
Date: Thu, 17 Jan 2019 06:11:58 -0800
Message-ID: <20190117141157.GA5184@infradead.org>
References: <d3e4984f-f996-c38f-3cf1-c16450ef7a99@arm.com>
 <20190116181904.GA6228@infradead.org>
 <1855c743-becd-fd52-50b9-86398f6cb985@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
Content-Disposition: inline
In-Reply-To: <1855c743-becd-fd52-50b9-86398f6cb985@arm.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Julien Grall <julien.grall@arm.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, leo.yan@linaro.org, xen-devel <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

T24gVGh1LCBKYW4gMTcsIDIwMTkgYXQgMTE6NDM6NDlBTSArMDAwMCwgSnVsaWVuIEdyYWxsIHdy
b3RlOgo+IExvb2tpbmcgYXQgdGhlIGNoYW5nZSBmb3IgYXJtNjQsIHlvdSB3aWxsIGFsd2F5cyBj
YWxsIGRtYS1kaXJlY3QgQVBJLiBJbgo+IHByZXZpb3VzIExpbnV4IHZlcnNpb24sIHhlbi1zd2lv
dGxiIHdpbGwgY2FsbCBkZXYtPmFyY2hkYXRhLmRldl9kbWFfb3BzIChhCj4gY29weSBvZiBkZXYt
PmRtYV9vcHMgYmVmb3JlIHNldHRpbmcgWGVuIERNQSBvcHMpIGlmIG5vdCBOVUxMLiBEb2VzIGl0
IG1lYW4KPiB3ZSBleHBlY3QgZGV2LT5kbWFfb3BzIHRvIGFsd2F5cyBiZSBOVUxMIGFuZCBoZW5j
ZSB1c2luZyBkbWEtZGlyZWN0IEFQST8KClRoZSB3YXkgSSB1bmRlcnN0b29kIHRoZSBjb2RlIGZy
b20gaW5zcGVjdGluZyBpdCBhbmQgc2tpbmcgdGhlCm1haW50YWluZXJzIGEgZmV3IGFza2luZ3Mg
aXMgdGhhdCBmb3IgRE9NMCB3ZSBhbHdheXMgdXNlIHhlbi1zd2lvdGxiCmFzIHRoZSBhY3R1YWwg
ZG1hX21hcF9vcHMsIGJ1dCB0aGVuIHVzZSB0aGUgZnVuY3Rpb25zIGluIHBhZ2UtY29oZXJlbnQu
aApvbmx5IHRvIGRlYWwgd2l0aCBjYWNoZSBtYWludGFpbmFuY2UsIHNvIGl0IHNob3VsZCBiZSBz
YWZlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVu
LWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKaHR0cHM6
Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZlbA==
