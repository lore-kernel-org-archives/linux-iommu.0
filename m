Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614B2C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 16:29:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C8460EFD
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 16:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8C8460EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8854F6061C;
	Thu, 29 Jul 2021 16:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MApLgcMCjLoz; Thu, 29 Jul 2021 16:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 525DB60601;
	Thu, 29 Jul 2021 16:29:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2071AC001A;
	Thu, 29 Jul 2021 16:29:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97A28C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C4116061C
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EiSxUXYw9USD for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 16:29:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF58A60601
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:29:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAFD81FB;
 Thu, 29 Jul 2021 09:29:32 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F63C3F73D;
 Thu, 29 Jul 2021 09:29:30 -0700 (PDT)
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, joro@8bytes.org,
 will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <2947762.k3LOHGUjKi@diego> <ade9f10e-836c-f29e-030b-23fe0a3187fb@arm.com>
 <2152676.3VsfAaAtOV@diego>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ca9c5667-8f60-0d1c-6bca-323382e7a391@arm.com>
Date: Thu, 29 Jul 2021 17:29:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2152676.3VsfAaAtOV@diego>
Content-Language: en-GB
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wNy0yOSAxNjo1MywgSGVpa28gU3TDvGJuZXIgd3JvdGU6Cj4gQW0gRG9ubmVyc3Rh
ZywgMjkuIEp1bGkgMjAyMSwgMTc6NDM6MDcgQ0VTVCBzY2hyaWViIFJvYmluIE11cnBoeToKPj4g
T24gMjAyMS0wNy0yOSAxNjowNCwgSGVpa28gU3TDvGJuZXIgd3JvdGU6Cj4+PiBIaSBSb2JpbiwK
Pj4+Cj4+PiBBbSBNaXR0d29jaCwgMjguIEp1bGkgMjAyMSwgMTc6NTg6MjEgQ0VTVCBzY2hyaWVi
IFJvYmluIE11cnBoeToKPj4+PiBIaSBhbGwsCj4+Pj4KPj4+PiBIZXJlJ3MgdjIgd2hlcmUgdGhp
bmdzIHN0YXJ0IHRvIGxvb2sgbW9yZSByZWFsaXN0aWMsIGhlbmNlIHRoZSBleHBhbmRlZAo+Pj4+
IENDIGxpc3QuIFRoZSBwYXRjaGVzIGFyZSBub3cgYmFzZWQgb24gdGhlIGN1cnJlbnQgaW9tbXUv
Y29yZSBicmFuY2ggdG8KPj4+PiB0YWtlIEpvaG4ncyBpb21tdV9zZXRfZG1hX3N0cmljdCgpIGNs
ZWFudXAgaW50byBhY2NvdW50Lgo+Pj4+Cj4+Pj4gVGhlIHNlcmllcyByZW1pYWlucyBpbiB0d28g
KG9yIHBvc3NpYmx5IDMpIGxvZ2ljYWwgcGFydHMgLSBmb3IgcGVvcGxlCj4+Pj4gQ0MnZCBvbiBj
b29raWUgY2xlYW51cCBwYXRjaGVzLCB0aGUgbGF0ZXIgcGFydHMgc2hvdWxkIG5vdCBhZmZlY3Qg
eW91Cj4+Pj4gc2luY2UgeW91ciBkcml2ZXJzIGRvbid0IGltcGxlbWVudCBub24tc3RyaWN0IG1v
ZGUgYW55d2F5OyB0aGUgY2xlYW51cAo+Pj4+IGlzIGFsbCBwcmV0dHkgc3RyYWlnaHRmb3J3YXJk
LCBidXQgcGxlYXNlIGRvIHllbGwgYXQgbWUgaWYgSSd2ZSBtYW5hZ2VkCj4+Pj4gdG8gbGV0IGEg
c2lsbHkgbWlzdGFrZSBzbGlwIHRocm91Z2ggYW5kIGJyb2tlbiB5b3VyIGRyaXZlci4KPj4+Pgo+
Pj4+IFRoaXMgdGltZSBJIGhhdmUgYWxzbyBidWlsZC10ZXN0ZWQgeDg2IGFzIHdlbGwgYXMgYXJt
NjQgOikKPj4+Cj4+PiBUTDtEUjogYXJtNjQgeWF5LCBhcm0zMiBuYXkgOy0pCj4+Cj4+IENoZWVy
cyBIZWlrbyEKPj4KPj4+IHRlc3RjYXNlOgo+Pj4gNS4xNC1yYzMKPj4+ICsgaW9tbXUvbmV4dAo+
Pj4gKyBwYXRjaGVzIDErOCAodGhlIG9uZXMgeW91IGNjJ2QgbWUgb24pCj4+PiAgICAgaW9tbXU6
IFB1bGwgSU9WQSBjb29raWUgbWFuYWdlbWVudCBpbnRvIHRoZSBjb3JlCj4+PiAgICAgaW9tbXUv
cm9ja2NoaXA6IERyb3AgSU9WQSBjb29raWUgbWFuYWdlbWVudAo+Pj4KPj4+IHJrMzM5OStoZG1p
IChwdW1hKTogYm9vdHMgd2l0aCBncmFwaGljcwo+Pj4gcmszMzk5K2VkcCAoa2V2aW4pOiBib290
cyB3aXRoIGdyYXBoaWNzCj4+PiBweDMwK2RzaSAobWluaWV2Yik6IGJvb3RzIHdpdGggZ3JhcGhp
Y3MKPj4+Cj4+PiByazMyODggKGFybTMyLCB2ZXlyb24tcGlua3kpOiBoYW5ncyB3aGVuIHRyeWlu
ZyB0byBzdGFydCB0aGUgcm9ja2NoaXAtZHJtCj4+PiBhdCBzb21lIHBvaW50cyB0aGUgcmVzdCBv
ZiB0aGUgc3lzdGVtIHJlY292ZXJzIGFuZCBmaWxscyB0aGUgbG9nIHdpdGgKPj4+Cj4+PiBbICAg
NDcuMTkzNzc2XSBbZHJtOmRybV9jcnRjX2NvbW1pdF93YWl0XSAqRVJST1IqIGZsaXBfZG9uZSB0
aW1lZCBvdXQKPj4+IFsgICA0Ny4xOTM4NjddIFtkcm06ZHJtX2F0b21pY19oZWxwZXJfd2FpdF9m
b3JfZGVwZW5kZW5jaWVzXSAqRVJST1IqIFtQTEFORTozMTpwbGFuZS0wXSBjb21taXQgd2FpdCB0
aW1lZCBvdXQKPj4+IFsgICA1Ny40MzM3NDNdIFtkcm06ZHJtX2NydGNfY29tbWl0X3dhaXRdICpF
UlJPUiogZmxpcF9kb25lIHRpbWVkIG91dAo+Pj4gWyAgIDU3LjQzMzgyOF0gW2RybTpkcm1fYXRv
bWljX2hlbHBlcl93YWl0X2Zvcl9kZXBlbmRlbmNpZXNdICpFUlJPUiogW1BMQU5FOjQwOnBsYW5l
LTRdIGNvbW1pdCB3YWl0IHRpbWVkIG91dAo+Pj4KPj4+IHNwZXdzCj4+Pgo+Pj4gdGVzdGNhc2Ug
MjoKPj4+IDUuMTQtcmMzCj4+PiArIGlvbW11L25leHQKPj4+Cj4+PiBhbGwgd29ya3MgZmluZSBv
biBib3RoIGFybTMyK2FybTY0Cj4+Pgo+Pj4KPj4+IFRoYXQgd2hvbGUgaW9tbXUgdm9vZG9vIGlz
IGEgYml0IG92ZXIgbXkgaGVhZCByaWdodCBub3csIHNvIEknbSBub3Qgc3VyZQo+Pj4gd2hhdCB0
byBwb2tlIHRvIGRpYWdub3NlIHRoaXMuCj4+Cj4+IERhbmcsIHRoaXMgd2Fzbid0IHN1cHBvc2Vk
IHRvIGFmZmVjdCAzMi1iaXQgQXJtIGF0IGFsbCwgc2luY2UgdGhhdAo+PiBkb2Vzbid0IHRvdWNo
IGFueSBvZiB0aGUgZGVmYXVsdCBkb21haW4gc3R1ZmYgZWl0aGVyIHdheS4gSSBoYXZlIGJvdGgg
bXkKPj4gUkszMjg4IGJveCAod2hpY2ggSUlSQyBkb2Vzbid0IGN1cnJlbnRseSBib290KSBhbmQg
YW4gT2Ryb2lkLVUzIGluIHRoZQo+PiAiZGVzayBwaWxlIiByaWdodCBpbiBmcm9udCBvZiBtZSwg
c28gYXQgd29yc3QgSSdsbCB0cnkgYnJpbmdpbmcgb25lIG9mCj4+IHRob3NlIHRvIGxpZmUgdG8g
c2VlIHdoYXQgc2lsbHkgdGhpbmcgSSBoYXZlIGluZGVlZCBkb25lIHRvIGJyZWFrIDMyLWJpdC4K
Pj4KPj4gSSBoYXZlIGEgdmFndWUgaWRlYSBmb3JtaW5nIGFscmVhZHksIHdoaWNoIHN1Z2dlc3Rz
IHRoYXQgaXQgbWlnaHQgZ2V0Cj4+IGJldHRlciBhZ2FpbiBvbmNlIHBhdGNoICMxMiBpcyBhcHBs
aWVkLCBidXQgZXZlbiBpZiBzbyB0aGVyZSdzIG5vIGV4Y3VzZQo+PiBub3QgdG8gYmUgYmlzZWN0
YWJsZSwgc28gSSBuZWVkIHRvIGRpZyBpbiBhbmQgZml4IGl0IC0gbWFueSB0aGFua3MgZm9yCj4+
IHllbGxpbmcgYXMgcmVxdWVzdGVkIDpECj4gCj4gVGhhdCB2YWd1ZSBpZGVhIHdhcyBhY3R1YWxs
eSBxdWl0ZSBjb3JyZWN0LCBhcHBseWluZwo+IAlpb21tdS9kbWE6IFVuZXhwb3J0IElPVkEgY29v
a2llIG1hbmFnZW1lbnQKPiBvbiB0b3Agb2YgdGhlIHRoZSB0d28gcGF0Y2hlcyBtYWtlcyBteSBy
azMyODggYm9vdCBjb3JyZWN0bHkgYWdhaW4KPiBhbmQgdGhlIGRpc3BsYXkgYWxzbyB3b3JrcyBh
Z2Fpbi4KCll1cCwgc2luY2UgdGhlICFDT05GSUdfSU9NTVVfRE1BIHN0dWIgZm9yIGlvbW11X2dl
dF9kbWFfY29va2llKCkgcmV0dXJucyAKLUVOT0RFViwgcmF0aGVyIHRoYW4gdGhlIC1FTk9NRU0g
dGhhdCB0aGUgdGVtcG9yYXJ5IHNwZWNpYWwgY2FzZSBpcyAKZXhwZWN0aW5nIGZyb20gdGhlIHJl
YWwgZnVuY3Rpb24sIGl0IHdpbGwgaW5hZHZlcnRlbnRseSBhbGxvdyB0aGUgCmRlZmF1bHQgZG9t
YWluIHRvIGJlIGNyZWF0ZWQgKHdoZW4gaXQgd2Fzbid0IGJlZm9yZSkuIEkgc3RpbGwgaGF2ZSBu
byAKaWRlYSB3aHkgdGhhdCBjYXVzZXMgYSBwcm9ibGVtIHRob3VnaCwgc2luY2UgYXJtX2lvbW11
X2F0dGFjaF9kZXZpY2UoKSAKc2hvdWxkIGVuZCB1cCBraWNraW5nIGEgZGVmYXVsdCBkb21haW4g
b3V0IG9mIHRoZSB3YXkgZXZlbiBpZiBvbmUgZG9lcyAKZXhpc3QuLi4gOi8KCkVpdGhlciB3YXkg
SSdsbCBmaXggbXkgYnVnIC0gaW5kZWVkIGl0IHdhcyBhbiBvdmVyc2lnaHQgdGhhdCBJIGhhZG4n
dCAKY29uc2lkZXJlZCB3aGljaCBleGFjdCBlcnJvciBjb2RlIHRoZSBzdHViICJmYWlscyIgd2l0
aCAtIHRvIGF2b2lkIHRoZSAKdGVtcG9yYXJ5IGNoYW5nZSBpbiBiZWhhdmlvdXIsIGJ1dCBJJ2xs
IGhhdmUgdG8ga2VlcCBkaWdnaW5nIGludG8gdGhlIAphcmNoL2FybSBjb2RlIGFuZCByb2NrY2hp
cC1pb21tdSB0byBzZWUgaWYgc29tZXRoaW5nJ3MgYWxzbyBvZmYgdGhlcmUuCgpDaGVlcnMsClJv
YmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
