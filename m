Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDB2C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 09:44:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DE5610A6
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 09:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6DE5610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2B47605EF;
	Fri, 17 Sep 2021 09:44:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Xm1TEt8GKe2; Fri, 17 Sep 2021 09:44:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 58C7860B91;
	Fri, 17 Sep 2021 09:44:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27927C000F;
	Fri, 17 Sep 2021 09:44:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0B78C000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 09:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B730405E7
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 09:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qAjorRjE_tlG for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 09:44:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67FB3405D3
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 09:44:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EFAC101E;
 Fri, 17 Sep 2021 02:44:40 -0700 (PDT)
Received: from [10.57.24.25] (unknown [10.57.24.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29AC3F59C;
 Fri, 17 Sep 2021 02:44:35 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: set IO TLB segment size via cmdline
To: Roman Skakun <rm.skakun@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20210914151016.3174924-1-Roman_Skakun@epam.com>
 <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com>
 <CADu_u-Ou08tMFm5xU871ae8ct+2YOuvn4rQ=83CMTbg2bx87Pg@mail.gmail.com>
 <84ef7ff7-2c9c-113a-4a2c-cef54a6ded51@suse.com>
 <20210915135321.GA15216@lst.de>
 <CADu_u-OZzgVj+z=iD6kUQOZxUufF5QSMR6-MmpN_hLZ9PyQJhQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <eb98aeac-af61-0dd6-2052-5b55921746c1@arm.com>
Date: Fri, 17 Sep 2021 10:44:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CADu_u-OZzgVj+z=iD6kUQOZxUufF5QSMR6-MmpN_hLZ9PyQJhQ@mail.gmail.com>
Content-Language: en-GB
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jan Beulich <jbeulich@suse.com>,
 Will Deacon <will@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrii Anisov <andrii_anisov@epam.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-mips@vger.kernel.org, iommu <iommu@lists.linux-foundation.org>,
 Roman Skakun <roman_skakun@epam.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMS0wOS0xNyAxMDozNiwgUm9tYW4gU2tha3VuIHdyb3RlOgo+IEhpLCBDaHJpc3RvcGgK
PiAKPiBJIHVzZSBYZW4gUFYgZGlzcGxheS4gSW4gbXkgY2FzZSwgUFYgZGlzcGxheSBiYWNrZW5k
KERvbTApIGFsbG9jYXRlcwo+IGNvbnRpZ3VvdXMgYnVmZmVyIHZpYSBETUEtQVBJIHRvCj4gdG8g
aW1wbGVtZW50IHplcm8tY29weSBiZXR3ZWVuIERvbTAgYW5kIERvbVUuCgpXZWxsLCBzb21ldGhp
bmcncyBnb25lIGJhZGx5IHdyb25nIHRoZXJlIC0gaWYgeW91IGhhdmUgdG8gc2hhZG93IHRoZSAK
ZW50aXJlIHRoaW5nIGluIGEgYm91bmNlIGJ1ZmZlciB0byBpbXBvcnQgaXQgdGhlbiBpdCdzIGhh
cmRseSB6ZXJvLWNvcHksIAppcyBpdD8gSWYgeW91IHdhbnQgdG8gZG8gYnVmZmVyIHNoYXJpbmcg
dGhlIGJ1ZmZlciByZWFsbHkgbmVlZHMgdG8gYmUgCmFsbG9jYXRlZCBhcHByb3ByaWF0ZWx5IHRv
IGJlZ2luIHdpdGgsIHN1Y2ggdGhhdCBhbGwgcmVsZXZhbnQgZGV2aWNlcyAKY2FuIGFjY2VzcyBp
dCBkaXJlY3RseS4gVGhhdCBtaWdodCBiZSBzb21ldGhpbmcgd2hpY2ggbmVlZHMgZml4aW5nIGlu
IFhlbi4KClJvYmluLgoKPiBXaGVuIEkgc3RhcnQgV2VzdG9uIHVuZGVyIERvbVUsIEkgZ290IHRo
ZSBuZXh0IGxvZyBpbiBEb20wOgo+IGBgYAo+IFsgMTEyLjU1NDQ3MV0gQ1BVOiAwIFBJRDogMzY3
IENvbW06IHdlc3RvbiBUYWludGVkOiBHIE8KPiA1LjEwLjAteW9jdG8tc3RhbmRhcmQrICMzMTIK
PiBbIDExMi41NzUxNDldIENhbGwgdHJhY2U6Cj4gWyAxMTIuNTc3NjY2XSBkdW1wX2JhY2t0cmFj
ZSsweDAvMHgxYjAKPiBbIDExMi41ODEzNzNdIHNob3dfc3RhY2srMHgxOC8weDcwCj4gWyAxMTIu
NTg0NzQ2XSBkdW1wX3N0YWNrKzB4ZDAvMHgxMmMKPiBbIDExMi41ODgyMDBdIHN3aW90bGJfdGJs
X21hcF9zaW5nbGUrMHgyMzQvMHgzNjAKPiBbIDExMi41OTI3ODFdIHhlbl9zd2lvdGxiX21hcF9w
YWdlKzB4ZTQvMHg0YzAKPiBbIDExMi41OTcwOTVdIHhlbl9zd2lvdGxiX21hcF9zZysweDg0LzB4
MTJjCj4gWyAxMTIuNjAxMjQ5XSBkbWFfbWFwX3NnX2F0dHJzKzB4NTQvMHg2MAo+IFsgMTEyLjYw
NTEzOF0gdnNwMV9kdV9tYXBfc2crMHgzMC8weDYwCj4gWyAxMTIuNjA4ODUxXSByY2FyX2R1X3Zz
cF9tYXBfZmIrMHgxMzQvMHgxNzAKPiBbIDExMi42MTMwODJdIHJjYXJfZHVfdnNwX3BsYW5lX3By
ZXBhcmVfZmIrMHg0NC8weDY0Cj4gWyAxMTIuNjE4MDA3XSBkcm1fYXRvbWljX2hlbHBlcl9wcmVw
YXJlX3BsYW5lcysweGFjLzB4MTYwCj4gWyAxMTIuNjIzMzYyXSBkcm1fYXRvbWljX2hlbHBlcl9j
b21taXQrMHg4OC8weDM5MAo+IFsgMTEyLjYyODAyOV0gZHJtX2F0b21pY19ub25ibG9ja2luZ19j
b21taXQrMHg0Yy8weDYwCj4gWyAxMTIuNjMzMDQzXSBkcm1fbW9kZV9hdG9taWNfaW9jdGwrMHg5
YTgvMHhiMGMKPiBbIDExMi42Mzc1MzJdIGRybV9pb2N0bF9rZXJuZWwrMHhjNC8weDExYwo+IFsg
MTEyLjY0MTUwNl0gZHJtX2lvY3RsKzB4MjFjLzB4NDYwCj4gWyAxMTIuNjQ0OTY3XSBfX2FybTY0
X3N5c19pb2N0bCsweGE4LzB4ZjAKPiBbIDExMi42NDg5MzldIGVsMF9zdmNfY29tbW9uLmNvbnN0
cHJvcC4wKzB4NzgvMHgxYTAKPiBbIDExMi42NTM3NzVdIGRvX2VsMF9zdmMrMHgyNC8weDkwCj4g
WyAxMTIuNjU3MTQ4XSBlbDBfc3ZjKzB4MTQvMHgyMAo+IFsgMTEyLjY2MDI1NF0gZWwwX3N5bmNf
aGFuZGxlcisweDFhNC8weDFiMAo+IFsgMTEyLjY2NDMxNV0gZWwwX3N5bmMrMHgxNzQvMHgxODAK
PiBbIDExMi42NjgxNDVdIHJjYXItZmNwIGZlYTJmMDAwLmZjcDogc3dpb3RsYiBidWZmZXIgaXMg
ZnVsbCAoc3o6Cj4gMzY4NjQwMCBieXRlcyksIHRvdGFsIDY1NTM2IChzbG90cyksIHVzZWQgMTEy
IChzbG90cykKPiBgYGAKPiBUaGUgcHJvYmxlbSBpcyBoYXBwZW5lZCBoZXJlOgo+IGh0dHBzOi8v
ZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE0LjQvc291cmNlL2RyaXZlcnMvZ3B1L2RybS9y
Y2FyLWR1L3JjYXJfZHVfdnNwLmMjTDIwMgo+IAo+IFNndCB3YXMgY3JlYXRlZCBpbiBkbWFfZ2V0
X3NndGFibGUoKSBieSBkbWFfY29tbW9uX2dldF9zZ3RhYmxlKCkgYW5kCj4gaW5jbHVkZXMgYSBz
aW5nbGUgcGFnZSBjaHVuawo+IGFzIHNob3duIGhlcmU6Cj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjUuMTQuNS9zb3VyY2Uva2VybmVsL2RtYS9vcHNfaGVscGVycy5jI0wxOAo+
IAo+IEFmdGVyIGNyZWF0aW5nIGEgbmV3IHNndCwgd2UgdHJpZWQgdG8gbWFwIHRoaXMgc2d0IHRo
cm91Z2ggdnNwMV9kdV9tYXBfc2coKS4KPiBJbnRlcm5hbGx5LCB2c3AxX2R1X21hcF9zZygpIHVz
aW5nIG9wcy0+bWFwX3NnIChlLmcKPiB4ZW5fc3dpb3RsYl9tYXBfc2cpIHRvIHBlcmZvcm0KPiBt
YXBwaW5nLgo+IAo+IEkgcmVhbGl6ZWQgdGhhdCByZXF1aXJlZCBzZWdtZW50IGlzIHRvbyBiaWcg
dG8gYmUgZml0dGVkIHRvIGRlZmF1bHQKPiBzd2lvdGxiIHNlZ21lbnQgYW5kIGNvbmRpdGlvbgo+
IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2Uva2VybmVsL2Rt
YS9zd2lvdGxiLmMjTDQ3NAo+IGlzIGFsd2F5cyBmYWxzZS4KPiAKPiBJIGtub3cgdGhhdCBJIHVz
ZSBhIGxhcmdlIGJ1ZmZlciwgYnV0IHdoeSBjYW4ndCBJIG1hcCB0aGlzIGJ1ZmZlciBpbiBvbmUg
Y2h1bms/Cj4gCj4gVGhhbmtzIQo+IAo+INGB0YAsIDE1INGB0LXQvdGCLiAyMDIxINCzLiDQsiAx
Njo1MywgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Ogo+Pgo+PiBPbiBXZWQsIFNlcCAx
NSwgMjAyMSBhdCAwMzo0OTo1MlBNICswMjAwLCBKYW4gQmV1bGljaCB3cm90ZToKPj4+IEJ1dCB0
aGUgcXVlc3Rpb24gcmVtYWluczogV2h5IGRvZXMgdGhlIGZyYW1lYnVmZmVyIG5lZWQgdG8gYmUg
bWFwcGVkCj4+PiBpbiBhIHNpbmdsZSBnaWFudCBjaHVuaz8KPj4KPj4gTW9yZSBpbXBvcnRhbnRs
eTogaWYgeW91IHVzZSBkeW5hbWljIGRtYSBtYXBwaW5ncyBmb3IgeW91ciBmcmFtZWJ1ZmZlcgo+
PiB5b3UncmUgZG9pbmcgc29tZXRoaW5nIHdyb25nLgo+IAo+IAo+IApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
