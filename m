Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CA0C433E5
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 14:02:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867E42065F
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 14:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867E42065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4352187FC3;
	Mon, 24 Aug 2020 14:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QWGdEygjaUbH; Mon, 24 Aug 2020 14:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17A8C87FB5;
	Mon, 24 Aug 2020 14:02:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2F55C07FF;
	Mon, 24 Aug 2020 14:02:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8201DC0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 14:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6EBDA87746
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 14:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gqRqmFoxamtj for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 14:01:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id B1FB886B33
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 14:01:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6AE61FB;
 Mon, 24 Aug 2020 07:01:58 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A711F3F71F;
 Mon, 24 Aug 2020 07:01:52 -0700 (PDT)
Subject: Re: [PATCH 16/18] staging/media/tegra-vde: Clean up IOMMU workaround
To: Dmitry Osipenko <digetx@gmail.com>, hch@lst.de, joro@8bytes.org,
 linux@armlinux.org.uk
References: <cover.1597931875.git.robin.murphy@arm.com>
 <3535c205b9bce52556abbf2f63384fb38e009df9.1597931876.git.robin.murphy@arm.com>
 <07135a55-cbc9-83e5-60dc-731282192554@gmail.com>
 <cb12808b-7316-19db-7413-b7f852a6f8ae@arm.com>
 <62a72187-442b-2103-46c3-39d3cd999f54@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <affe2cfb-19e8-8e55-acd0-7170e274ab34@arm.com>
Date: Mon, 24 Aug 2020 15:01:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <62a72187-442b-2103-46c3-39d3cd999f54@gmail.com>
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

T24gMjAyMC0wOC0yMyAyMjozNCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDIxLjA4LjIwMjAg
MDM6MTEsIFJvYmluIE11cnBoeSDQv9C40YjQtdGCOgo+IC4uLgo+Pj4gSGVsbG8sIFJvYmluISBU
aGFuayB5b3UgZm9yIHlvdXJzIHdvcmshCj4+Pgo+Pj4gU29tZSBkcml2ZXJzLCBsaWtlIHRoaXMg
VGVncmEgVkRFIChWaWRlbyBEZWNvZGVyIEVuZ2luZSkgZHJpdmVyIGZvcgo+Pj4gZXhhbXBsZSwg
ZG8gbm90IHdhbnQgdG8gdXNlIGltcGxpY2l0IElPTU1VIGRvbWFpbi4KPj4KPj4gVGhhdCBpc24n
dCAoaW50ZW50aW9uYWxseSkgY2hhbmdpbmcgaGVyZSAtIHRoZSBvbmx5IGRpZmZlcmVuY2Ugc2hv
dWxkIGJlCj4+IHRoYXQgaW5zdGVhZCBvZiBoYXZpbmcgdGhlIEFSTS1zcGVjaWFsIGltcGxpY2l0
IGRvbWFpbiwgd2hpY2ggeW91IGhhdmUKPj4gdG8ga2ljayBvdXQgb2YgdGhlIHdheSB3aXRoIHRo
ZSBBUk0tc3BlY2lmaWMgQVBJIGJlZm9yZSB5b3UncmUgYWJsZSB0bwo+PiBhdHRhY2ggeW91ciBv
d24gZG9tYWluLCB0aGUgaW1wbGljaXQgZG9tYWluIGlzIG5vdyBhIHByb3BlciBJT01NVSBBUEkK
Pj4gZGVmYXVsdCBkb21haW4sIHdoaWNoIGF1dG9tYXRpY2FsbHkgZ2V0cyBidW1wZWQgYnkgeW91
ciBhdHRhY2guIFRoZQo+PiBkZWZhdWx0IGRvbWFpbnMgc2hvdWxkIHN0aWxsIG9ubHkgYmUgY3Jl
YXRlZCBpbiB0aGUgc2FtZSBjYXNlcyB0aGF0IHRoZQo+PiBBUk0gZG1hX2lvbW11X21hcHBpbmdz
IHdlcmUuCj4+Cj4+PiBUZWdyYSBWREUgZHJpdmVyCj4+PiByZWxpZXMgb24gZXhwbGljaXQgSU9N
TVUgZG9tYWluIGluIGEgY2FzZSBvZiBUZWdyYSBTTU1VIGJlY2F1c2UgVkRFCj4+PiBoYXJkd2Fy
ZSBjYW4ndCBhY2Nlc3MgbGFzdCBwYWdlIG9mIHRoZSBBUyBhbmQgYmVjYXVzZSBkcml2ZXIgd2Fu
dHMgdG8KPj4+IHJlc2VydmUgc29tZSBmaXhlZCBhZGRyZXNzZXMgWzFdLgo+Pj4KPj4+IFsxXQo+
Pj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuOS1yYzEvc291cmNlL2RyaXZl
cnMvc3RhZ2luZy9tZWRpYS90ZWdyYS12ZGUvaW9tbXUuYyNMMTAwCj4+Pgo+Pj4KPj4+IFRlZ3Jh
MzAgU29DIHN1cHBvcnRzIHVwIHRvIDQgZG9tYWlucywgaGVuY2UgaXQncyBub3QgcG9zc2libGUg
dG8gYWZmb3JkCj4+PiB3YXN0aW5nIHVudXNlZCBpbXBsaWNpdCBkb21haW5zLiBJIHRoaW5rIHRo
aXMgbmVlZHMgdG8gYmUgYWRkcmVzc2VkCj4+PiBiZWZvcmUgdGhpcyBwYXRjaCBjb3VsZCBiZSBh
cHBsaWVkLgo+Pgo+PiBZZWFoLCB0aGVyZSBpcyBvbmUgc3VidGxlIGNoYW5nZSBpbiBiZWhhdmlv
dXIgZnJvbSByZW1vdmluZyB0aGUgQVJNCj4+IGxheWVyIG9uIHRvcCBvZiB0aGUgY29yZSBBUEks
IGluIHRoYXQgdGhlIElPTU1VIGRyaXZlciB3aWxsIG5vIGxvbmdlcgo+PiBzZWUgYW4gZXhwbGlj
aXQgZGV0YWNoIGNhbGwuIFRodXMgaXQgZG9lcyBzdGFuZCB0byBiZW5lZml0IGZyb20gYmVpbmcg
YQo+PiBiaXQgY2xldmVyZXIgYWJvdXQgbm90aWNpbmcgZGV2aWNlcyBiZWluZyBtb3ZlZCBmcm9t
IG9uZSBkb21haW4gdG8KPj4gYW5vdGhlciBieSBhbiBhdHRhY2ggY2FsbCwgZWl0aGVyIGJ5IHJl
bGVhc2luZyB0aGUgaGFyZHdhcmUgY29udGV4dCBmb3IKPj4gdGhlIGluYWN0aXZlIGRvbWFpbiBv
bmNlIHRoZSBkZXZpY2UocykgYXJlIG1vdmVkIGFjcm9zcyB0byB0aGUgbmV3IG9uZSwKPj4gb3Ig
Ynkgc2ltcGx5IHJlcHJvZ3JhbW1pbmcgdGhlIGhhcmR3YXJlIGNvbnRleHQgaW4tcGxhY2UgZm9y
IHRoZSBuZXcKPj4gZG9tYWluJ3MgYWRkcmVzcyBzcGFjZSB3aXRob3V0IGFsbG9jYXRpbmcgYSBu
ZXcgb25lIGF0IGFsbCAobW9zdCBvZiB0aGUKPj4gZHJpdmVycyB0aGF0IGRvbid0IGhhdmUgbXVs
dGlwbGUgY29udGV4dHMgYWxyZWFkeSBoYW5kbGUgdGhlIGxhdHRlcgo+PiBhcHByb2FjaCBxdWl0
ZSB3ZWxsKS4KPj4KPj4+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIGZvciBJT01NVSBkcml2ZXJzIHRv
IGdhaW4gc3VwcG9ydCBmb3IgZmlsdGVyaW5nIG91dAo+Pj4gZGV2aWNlcyBpbiBpb21tdV9kb21h
aW5fYWxsb2MoZGV2LCB0eXBlKT8gVGhlbiBwZXJoYXBzIFRlZ3JhIFNNTVUgZHJpdmVyCj4+PiBj
b3VsZCBzaW1wbHkgcmV0dXJuIE5VTEwgaW4gYSBjYXNlIG9mIHR5cGU9SU9NTVVfRE9NQUlOX0RN
QSBhbmQKPj4+IGRldj10ZWdyYS12ZGUuCj4+Cj4+IElmIHlvdSBjYW4gaW1wbGVtZW50IElPTU1V
X0RPTUFJTl9JREVOVElUWSBieSBhbGxvd2luZyB0aGUgcmVsZXZhbnQKPj4gZGV2aWNlcyB0byBi
eXBhc3MgdHJhbnNsYXRpb24gZW50aXJlbHkgd2l0aG91dCBuZWVkaW5nIGEgaGFyZHdhcmUKPj4g
Y29udGV4dCAob3IgYXQgd29yc3QsIGNhbiBzcGFyZSBvbmUgY29udGV4dCB3aGljaCBhbGwgaWRl
bnRpdHktbWFwcGVkCj4+IGxvZ2ljYWwgZG9tYWlucyBjYW4gc2hhcmUpLCB0aGVuIHlvdSBjb3Vs
ZCBjZXJ0YWlubHkgZG8gdGhhdCBraW5kIG9mCj4+IGZpbHRlcmluZyB3aXRoIHRoZSAuZGVmX2Rv
bWFpbl90eXBlIGNhbGxiYWNrIGlmIHlvdSByZWFsbHkgd2FudGVkIHRvLiBBcwo+PiBhYm92ZSwg
dGhlIGludGVudCBpcyB0aGF0IHRoYXQgc2hvdWxkbid0IGJlIG5lY2Vzc2FyeSBmb3IgdGhpcwo+
PiBwYXJ0aWN1bGFyIGNhc2UsIHNpbmNlIG9ubHkgb25lIG9mIGEgZ3JvdXAncyBkZWZhdWx0IGRv
bWFpbiBhbmQKPj4gZXhwbGljaXRseSBhdHRhY2hlZCBkb21haW4gY2FuIGJlIGxpdmUgYXQgYW55
IGdpdmVuIHRpbWUsIHNvIHRoZSBkcml2ZXIKPj4gc2hvdWxkIGJlIGFibGUgdG8gdGFrZSBhZHZh
bnRhZ2Ugb2YgdGhhdC4KPj4KPj4gSWYgeW91IHNpbXBseSBoYXZlIG1vcmUgYWN0aXZlIGRldmlj
ZXMgKGdyb3VwcykgdGhhbiBhdmFpbGFibGUgY29udGV4dHMKPj4gdGhlbiB5ZXMsIHlvdSBwcm9i
YWJseSB3b3VsZCB3YW50IHRvIGRvIHNvbWUgZmlsdGVyaW5nIHRvIGRlY2lkZSB3aG8KPj4gZGVz
ZXJ2ZXMgYSB0cmFuc2xhdGlvbiBkb21haW4gYW5kIHdobyBkb2Vzbid0LCBidXQgaW4gdGhhdCBj
YXNlIHlvdQo+PiBzaG91bGQgYWxyZWFkeSBoYXZlIGhhZCBhIGxvbmctc3RhbmRpbmcgcHJvYmxl
bSB3aXRoIHRoZSBBUk0gaW1wbGljaXQKPj4gZG9tYWlucy4KPj4KPj4+IEFsdGVybmF0aXZlbHks
IHRoZSBUZWdyYSBTTU1VIGNvdWxkIGJlIGNoYW5nZWQgc3VjaCB0aGF0IHRoZSBkZXZpY2VzCj4+
PiB3aWxsIGJlIGF0dGFjaGVkIHRvIGEgZG9tYWluIGF0IHRoZSB0aW1lIG9mIGEgZmlyc3QgSU9N
TVUgbWFwcGluZwo+Pj4gaW52b2NhdGlvbiBpbnN0ZWFkIG9mIGF0dGFjaGluZyBhdCB0aGUgdGlt
ZSBvZiBhdHRhY2hfZGV2KCkgY2FsbGJhY2sKPj4+IGludm9jYXRpb24uCj4+Pgo+Pj4gT3IgbWF5
YmUgZXZlbiBJT01NVSBjb3JlIGNvdWxkIGJlIGNoYW5nZWQgdG8gYXR0YWNoIGRldmljZXMgYXQg
dGhlIHRpbWUKPj4+IG9mIHRoZSBmaXJzdCBJT01NVSBtYXBwaW5nIGludm9jYXRpb24/IFRoaXMg
Y291bGQgYmUgYSB1bml2ZXJzYWwKPj4+IHNvbHV0aW9uIGZvciBhbGwgZHJpdmVycy4KPj4KPj4g
SSBzdXBwb3NlIHRlY2huaWNhbGx5IHlvdSBjb3VsZCBkbyB0aGF0IHdpdGhpbiBhbiBJT01NVSBk
cml2ZXIgYWxyZWFkeQo+PiAoc2ltaWxhciB0byBob3cgc29tZSBkZWZlciBtb3N0IG9mIHNldHVw
IHRoYXQgbG9naWNhbGx5IGJlbG9uZ3MgdG8KPj4gLT5kb21haW5fYWxsb2MgdW50aWwgdGhlIGZp
cnN0IC0+YXR0YWNoX2RldikuIEl0J3MgYSBiaXQgZ3JpbSBmcm9tIHRoZQo+PiBjYWxsZXIncyBQ
b1YgdGhvdWdoLCBpbiB0ZXJtcyBvZiB0aGUgZmFpbHVyZSBtb2RlIGJlaW5nIG5vbi1vYnZpb3Vz
IGFuZAo+PiBoYXZpbmcgbm8gcmVhbCB3YXkgdG8gcmVjb3Zlci4gQWdhaW4sIHlvdSdkIGJlIGJl
dHRlciBvZmYgc2ltcGx5IG1ha2luZwo+PiBkZWNpc2lvbnMgdXAtZnJvbnQgYXQgZG9tYWluX2Fs
bG9jIG9yIGF0dGFjaCB0aW1lIGJhc2VkIG9uIHRoZSBkb21haW4gdHlwZS4KPiAKPiBSb2Jpbiwg
dGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIGNsYXJpZmljYXRpb25zIQo+IAo+IEluIGFjY29y
ZGFuY2UgdG8geW91cnMgY29tbWVudHMsIHRoaXMgcGF0Y2ggY2FuJ3QgYmUgYXBwbGllZCB1bnRp
bCBUZWdyYQo+IFNNTVUgd2lsbCBzdXBwb3J0IElPTU1VX0RPTUFJTl9JREVOVElUWSBhbmQgaW1w
bGVtZW50IGRlZl9kb21haW5fdHlwZSgpCj4gY2FsbGJhY2sgdGhhdCByZXR1cm5zIElPTU1VX0RP
TUFJTl9JREVOVElUWSBmb3IgdGhlIFZERSBkZXZpY2UuCj4gCj4gT3RoZXJ3aXNlIHlvdSdyZSBi
cmVha2luZyB0aGUgVkRFIGRyaXZlciBiZWNhdXNlCj4gZG1hX2J1Zl9tYXBfYXR0YWNobWVudCgp
IFsxXSByZXR1cm5zIHRoZSBJT01NVSBTR1Qgb2YgdGhlIGltcGxpY2l0Cj4gZG9tYWluIHdoaWNo
IGlzIHRoZW4gbWFwcGVkIGludG8gdGhlIFZERSdzIGV4cGxpY2l0IGRvbWFpbiBbMl0sIGFuZCB0
aGlzCj4gaXMgYSBub25zZW5zZS4KCkl0J3MgdHJ1ZSB0aGF0IGlvbW11X2RtYV9vcHMgd2lsbCBk
byBzb21lIHdvcmsgaW4gdGhlIHVuYXR0YWNoZWQgZGVmYXVsdCAKZG9tYWluLCBidXQgbm9uLWNv
aGVyZW50IGNhY2hlIG1haW50ZW5hbmNlIHdpbGwgc3RpbGwgYmUgcGVyZm9ybWVkIApjb3JyZWN0
bHkgb24gdGhlIHVuZGVybHlpbmcgbWVtb3J5LCB3aGljaCBpcyByZWFsbHkgYWxsIHRoYXQgeW91
IGNhcmUgCmFib3V0IGZvciB0aGlzIGNhc2UuIEFzIGZvciB0ZWdyYV92ZGVfaW9tbXVfbWFwKCks
IHRoYXQgc2VlbXMgdG8gZG8gdGhlIApyaWdodCB0aGluZyBpbiBvbmx5IHJlZmVyZW5jaW5nIHRo
ZSBwaHlzaWNhbCBzaWRlIG9mIHRoZSBzY2F0dGVybGlzdCAKKHZpYSBpb21tdV9tYXBfc2coKSkg
YW5kIGlnbm9yaW5nIHRoZSBETUEgc2lkZSwgc28gdGhpbmdzIG91Z2h0IHRvIHdvcmsgCm91dCBP
SyBldmVuIGlmIGl0IGlzIGEgbGl0dGxlIG5vbi1vYnZpb3VzLgoKPiBbMV0KPiBodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC92NS45LXJjMS9zb3VyY2UvZHJpdmVycy9zdGFnaW5nL21l
ZGlhL3RlZ3JhLXZkZS9kbWFidWYtY2FjaGUuYyNMMTAyCj4gCj4gWzJdCj4gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjUuOS1yYzEvc291cmNlL2RyaXZlcnMvc3RhZ2luZy9tZWRp
YS90ZWdyYS12ZGUvZG1hYnVmLWNhY2hlLmMjTDEyMgo+IAo+IEhlbmNlLCBlaXRoZXIgVkRFIGRy
aXZlciBzaG91bGQgYnlwYXNzIGlvbW11X2RtYV9vcHMgZnJvbSB0aGUgc3RhcnQgb3IKPiBpdCBu
ZWVkcyBhIHdheSB0byBraWNrIG91dCB0aGUgb3BzLCBsaWtlIGl0IGRvZXMgdGhpcyB1c2luZyBB
Uk0ncwo+IGFybV9pb21tdV9kZXRhY2hfZGV2aWNlKCkuCj4gCj4gCj4gVGhlIHNhbWUgYXBwbGll
cyB0byB0aGUgVGVncmEgR1BVIGRldmljZXMsIG90aGVyd2lzZSB5b3UncmUgYnJlYWtpbmcKPiB0
aGVtIGFzIHdlbGwgYmVjYXVzZSBUZWdyYSBEUk0gaXMgc2Vuc2libGUgdG8gaW1wbGljaXQgdnMg
ZXhwbGljaXQgZG9tYWluLgoKTm90ZSB0aGF0IFRlZ3JhIERSTSB3aWxsIG9ubHkgYmUgYXMgYnJv
a2VuIGFzIGl0cyBjdXJyZW50IHN0YXRlIG9uIAphcm02NCwgYW5kIEkgd2FzIHVuZGVyIHRoZSBp
bXByZXNzaW9uIHRoYXQgdGhhdCB3YXMgT0sgbm93IC0gYXQgbGVhc3QgSSAKZG9uJ3QgcmVjYWxs
IHNlZWluZyBhbnkgY29tcGxhaW50cyBzaW5jZSA0M2M1YmYxMWE2MTAuIEFsdGhvdWdoIHRoYXQg
CmNvbW1pdCBhbmQgdGhlIG9uZSBiZWZvcmUgaXQgYXJlIHJlc29sdmluZyB0aGUgc2NhbGFiaWxp
dHkgaXNzdWUgdGhhdCAKdGhleSBkZXNjcmliZSwgaXQgd2FzIHZlcnkgbXVjaCBpbiBteSBtaW5k
IGF0IHRoZSB0aW1lIHRoYXQgdGhleSBhbHNvIApoYXZlIHRoZSBoYXBweSBzaWRlLWVmZmVjdCBk
ZXNjcmliZWQgYWJvdmUgLSB0aGUgZGVmYXVsdCBkb21haW4gaXNuJ3QgCipjb21wbGV0ZWx5KiBv
dXQgb2YgdGhlIHdheSwgYnV0IGl0J3MgZmFyIGVub3VnaCB0aGF0IHNlbnNpYmxlIGNhc2VzIApz
aG91bGQgYmUgYWJsZSB0byB3b3JrIGFzIGV4cGVjdGVkLgoKPiBCVFcsIEkgdHJpZWQgdG8gYXBw
bHkgdGhpcyBzZXJpZXMgYW5kIFQzMCBkb2Vzbid0IGJvb3QgYW55bW9yZS4gSSBkb24ndAo+IGhh
dmUgbW9yZSBpbmZvIGZvciBub3cuCgpZZWFoLCBJJ20gc3RpbGwgdHJ5aW5nIHRvIGdldCB0byB0
aGUgYm90dG9tIG9mIHdoZXRoZXIgaXQncyBhY3R1YWxseSAKd29ya2luZyBhcyBpbnRlbmRlZCBh
dCBhbGwsIGV2ZW4gb24gbXkgUkszMjg4LiBTbyBmYXIgbXkgZGVidWdnaW5nIAppbnN0cnVtZW50
YXRpb24gaGFzIGJlZW4gY29uZnVzaW5nbHkgaW5jb25jbHVzaXZlIDovCgpSb2Jpbi4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
