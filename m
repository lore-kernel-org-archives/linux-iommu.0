Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DAFC433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 00:29:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9ED02087D
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 00:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ED02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B0F8D88574;
	Fri, 21 Aug 2020 00:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F25BJvndoIs8; Fri, 21 Aug 2020 00:29:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B7AEE883E0;
	Fri, 21 Aug 2020 00:29:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95C78C0889;
	Fri, 21 Aug 2020 00:29:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AE4BC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E0DAD22C6B
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TZ0lwg+hP35v for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 00:29:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 51AB22052F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:29:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E07930E;
 Thu, 20 Aug 2020 17:29:01 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09B773F71F;
 Thu, 20 Aug 2020 17:28:52 -0700 (PDT)
Subject: Re: [PATCH 12/18] iommu/tegra-gart: Add IOMMU_DOMAIN_DMA support
To: Dmitry Osipenko <digetx@gmail.com>, hch@lst.de, joro@8bytes.org,
 linux@armlinux.org.uk
References: <cover.1597931875.git.robin.murphy@arm.com>
 <516b33118d489e56499ff8c64c019709b744110c.1597931876.git.robin.murphy@arm.com>
 <081f7532-9ca0-0af3-35a1-cbaba0782237@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3a132bb0-f2e6-6f8d-6d0c-bc925dd23f06@arm.com>
Date: Fri, 21 Aug 2020 01:28:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <081f7532-9ca0-0af3-35a1-cbaba0782237@gmail.com>
Content-Language: en-GB
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
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

T24gMjAyMC0wOC0yMCAyMToxNiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDIwLjA4LjIwMjAg
MTg6MDgsIFJvYmluIE11cnBoeSDQv9C40YjQtdGCOgo+PiBOb3cgdGhhdCBhcmNoL2FybSBpcyB3
aXJlZCB1cCBmb3IgZGVmYXVsdCBkb21haW5zIGFuZCBpb21tdS1kbWEsCj4+IGltcGxlbWVudCB0
aGUgY29ycmVzcG9uZGluZyBkcml2ZXItc2lkZSBzdXBwb3J0IGZvciBETUEgZG9tYWlucy4KPj4K
Pj4gU2lnbmVkLW9mZi1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPj4g
LS0tCj4+ICAgZHJpdmVycy9pb21tdS90ZWdyYS1nYXJ0LmMgfCAxNyArKysrKysrKysrKystLS0t
LQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS90ZWdyYS1nYXJ0LmMgYi9kcml2ZXJzL2lv
bW11L3RlZ3JhLWdhcnQuYwo+PiBpbmRleCBmYWM3MjAyNzM4ODkuLmUwODEzODcwODBmNiAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS90ZWdyYS1nYXJ0LmMKPj4gKysrIGIvZHJpdmVycy9p
b21tdS90ZWdyYS1nYXJ0LmMKPj4gQEAgLTksNiArOSw3IEBACj4+ICAgCj4+ICAgI2RlZmluZSBk
ZXZfZm10KGZtdCkJImdhcnQ6ICIgZm10Cj4+ICAgCj4+ICsjaW5jbHVkZSA8bGludXgvZG1hLWlv
bW11Lmg+Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L2lv
bW11Lmg+Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZXBhcmFtLmg+Cj4+IEBAIC0xNDUsMTYg
KzE0NiwyMiBAQCBzdGF0aWMgc3RydWN0IGlvbW11X2RvbWFpbiAqZ2FydF9pb21tdV9kb21haW5f
YWxsb2ModW5zaWduZWQgdHlwZSkKPj4gICB7Cj4+ICAgCXN0cnVjdCBpb21tdV9kb21haW4gKmRv
bWFpbjsKPiAKPiBIZWxsbywgUm9iaW4hCj4gCj4gVGVncmEyMCBHQVJUIGlzbid0IGEgcmVhbCBJ
T01NVSwgYnV0IGEgc21hbGwgcmVsb2NhdGlvbiBhcGVydHVyZS4gV2UKPiB3b3VsZCBvbmx5IHdh
bnQgdG8gdXNlIGl0IGZvciBhIHRlbXBvcmFsIG1hcHBpbmdzIChtYW5hZ2VkIGJ5IEdQVQo+IGRy
aXZlcikgZm9yIHRoZSB0aW1lIHdoaWxlIEdQVSBoYXJkd2FyZSBpcyBidXN5IGFuZCB3b3JraW5n
IHdpdGggYQo+IHNwYXJzZSBETUEgYnVmZmVycywgdGhlIGRyaXZlciB3aWxsIHRha2UgY2FyZSBv
ZiB1bm1hcHBpbmcgdGhlIHNwYXJzZQo+IGJ1ZmZlcnMgb25jZSBHUFUgd29yayBpcyBmaW5pc2hl
ZCBbMV0uIEluIGEgY2FzZSBvZiBjb250aWd1b3VzIERNQQo+IGJ1ZmZlcnMsIHdlIHdhbnQgdG8g
YnlwYXNzIHRoZSBJT01NVSBhbmQgdXNlIGJ1ZmZlcidzIHBoeXMgYWRkcmVzcwo+IGJlY2F1c2Ug
R0FSVCBhcGVydHVyZSBpcyBzbWFsbCBhbmQgYWxsIGJ1ZmZlcnMgc2ltcGx5IGNhbid0IGZpdCBp
bnRvCj4gR0FSVCBmb3IgYSBjb21wbGV4IEdQVSBvcGVyYXRpb25zIHRoYXQgaW52b2x2ZSBtdWx0
aXBsZSBidWZmZXJzIFsyXVszXS4KPiBUaGUgdXBzdHJlYW0gR1BVIGRyaXZlciBzdGlsbCBkb2Vz
bid0IHN1cHBvcnQgR0FSVCwgYnV0IGV2ZW50dWFsbHkgaXQKPiBuZWVkcyB0byBiZSBjaGFuZ2Vk
Lgo+IAo+IFsxXQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9ncmF0ZS1kcml2ZXIvbGludXgvYmxvYi9t
YXN0ZXIvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2dhcnQuYyNMNDg5Cj4gCj4gWzJdCj4gaHR0cHM6
Ly9naXRodWIuY29tL2dyYXRlLWRyaXZlci9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL2dwdS9k
cm0vdGVncmEvZ2FydC5jI0w1NDIKPiAKPiBbM10KPiBodHRwczovL2dpdGh1Yi5jb20vZ3JhdGUt
ZHJpdmVyL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS91YXBpL3BhdGNo
aW5nLmMjTDkwCj4gCj4+IC0JaWYgKHR5cGUgIT0gSU9NTVVfRE9NQUlOX1VOTUFOQUdFRCkKPj4g
KwlpZiAodHlwZSAhPSBJT01NVV9ET01BSU5fVU5NQU5BR0VEICYmIHR5cGUgIT0gSU9NTVVfRE9N
QUlOX0RNQSkKPj4gICAJCXJldHVybiBOVUxMOwo+IAo+IFdpbGwgYSByZXR1cm5lZCBOVUxMIHRl
bGwgdG8gSU9NTVUgY29yZSB0aGF0IGltcGxpY2l0IGRvbWFpbiBzaG91bGRuJ3QKPiBiZSB1c2Vk
PyBJcyBpdCBwb3NzaWJsZSB0byBsZWF2ZSB0aGlzIGRyaXZlciBhcy1pcz8KClRoZSBhaW0gb2Yg
dGhpcyBwYXRjaCB3YXMganVzdCB0byBtYWtlIHRoZSBjb252ZXJzaW9uIHdpdGhvdXQgZnVuY3Rp
b25hbCAKY2hhbmdlcyB3aGVyZXZlciBwb3NzaWJsZSwgaS5lLiBtYWludGFpbiBhbiBlcXVpdmFs
ZW50IHRvIHRoZSBleGlzdGluZyAKQVJNIGJlaGF2aW91ciBvZiBhbGxvY2F0aW5nIGl0cyBvd24g
aW1wbGljaXQgZG9tYWlucyBmb3IgZXZlcnl0aGluZy4gSXQgCmRvZXNuJ3QgcmVwcmVzZW50IGFu
eSBqdWRnZW1lbnQgb2Ygd2hldGhlciB0aGF0IHdhcyBldmVyIGFwcHJvcHJpYXRlIGZvciAKdGhp
cyBkcml2ZXIgaW4gdGhlIGZpcnN0IHBsYWNlIDspCgpIb3BlZnVsbHkgbXkgb3RoZXIgcmVwbHkg
YWxyZWFkeSBjb3ZlcmVkIHRoZSBkZWdyZWUgb2YgY29udHJvbCBkcml2ZXJzIApjYW4gaGF2ZSB3
aXRoIHByb3BlciBkZWZhdWx0IGRvbWFpbnMsIGJ1dCBkbyBzaG91dCBpZiBhbnl0aGluZyB3YXNu
J3QgY2xlYXIuCgpDaGVlcnMsClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
