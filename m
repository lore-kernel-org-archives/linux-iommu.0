Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF8C433B4
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 17:26:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A88613E1
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 17:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A88613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EAF1608EF;
	Thu, 22 Apr 2021 17:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E31WtbmBwCDS; Thu, 22 Apr 2021 17:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA835605F9;
	Thu, 22 Apr 2021 17:26:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A007DC000E;
	Thu, 22 Apr 2021 17:26:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28CD9C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 17:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02A3483EF9
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 17:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIamdjH70suI for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 17:26:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A988C83E1E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 17:26:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id A3A6B1F4359E
Message-ID: <7557bc8aaaa1924ad39676b32ba6a3f6474a3722.camel@collabora.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iommu: rockchip: Convert IOMMU to
 DT schema
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org, 
 will@kernel.org, robh+dt@kernel.org, heiko@sntech.de, xxm@rock-chips.com
Date: Thu, 22 Apr 2021 14:16:53 -0300
In-Reply-To: <20210422141602.350746-2-benjamin.gaignard@collabora.com>
References: <20210422141602.350746-1-benjamin.gaignard@collabora.com>
 <20210422141602.350746-2-benjamin.gaignard@collabora.com>
Organization: Collabora
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kever Yang <kever.yang@rock-chips.com>, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

KEFkZGluZyBLZXZlcikKCkhpIEJlbmphbWluLAoKVGhhbmtzIGEgbG90IGZvciB3b3JraW5nIG9u
IHRoaXMsIGl0IGxvb2tzIGFtYXppbmcuIFRvZ2V0aGVyIHdpdGggdGhlIGdyZWF0IHdvcmsKdGhh
dCBSb2NrY2hpcCBpcyBkb2luZywgaXQgc2VlbXMgUkszNTY2L1JLMzU2OCB3aWxsIGhhdmUgZGVj
ZW50IHN1cHBvcnQgdmVyeSBzb29uLgoKT25lIGNvbW1lbnQgaGVyZToKCk9uIFRodSwgMjAyMS0w
NC0yMiBhdCAxNjoxNSArMDIwMCwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6Cj4gQ29udmVydCBS
b2NrY2hpcCBJT01NVSB0byBEVCBzY2hlbWEKPiAKPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBH
YWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAY29sbGFib3JhLmNvbT4KPiAtLS0KPiB2ZXJzaW9u
IDI6Cj4gwqAtIENoYW5nZSBtYWludGFpbmVyCj4gwqAtIENoYW5nZSByZWcgbWF4SXRlbXMKPiDC
oC0gQ2hhbmdlIGludGVycnVwdCBtYXhJdGVtcwo+IAo+IMKgLi4uL2JpbmRpbmdzL2lvbW11L3Jv
Y2tjaGlwLGlvbW11LnR4dMKgwqDCoMKgwqDCoMKgwqAgfCAzOCAtLS0tLS0tLS0KPiDCoC4uLi9i
aW5kaW5ncy9pb21tdS9yb2NrY2hpcCxpb21tdS55YW1swqDCoMKgwqDCoMKgwqAgfCA3OSArKysr
KysrKysrKysrKysrKysrCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKyksIDM4
IGRlbGV0aW9ucygtKQo+IMKgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9pb21tdS9yb2NrY2hpcCxpb21tdS50eHQKPiDCoGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvcm9ja2NoaXAsaW9t
bXUueWFtbAo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaW9tbXUvcm9ja2NoaXAsaW9tbXUudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lvbW11L3JvY2tjaGlwLGlvbW11LnR4dAo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0
NAo+IGluZGV4IDZlY2VmZWExYzZmOS4uMDAwMDAwMDAwMDAwCj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L3JvY2tjaGlwLGlvbW11LnR4dAo+ICsrKyAvZGV2
L251bGwKPiBAQCAtMSwzOCArMCwwIEBACj4gLVJvY2tjaGlwIElPTU1VCj4gLT09PT09PT09PT09
PT09Cj4gLQo+IC1BIFJvY2tjaGlwIERSTSBpb21tdSB0cmFuc2xhdGVzIGlvIHZpcnR1YWwgYWRk
cmVzc2VzIHRvIHBoeXNpY2FsIGFkZHJlc3NlcyBmb3IKPiAtaXRzIG1hc3RlciBkZXZpY2UuwqAg
RWFjaCBzbGF2ZSBkZXZpY2UgaXMgYm91bmQgdG8gYSBzaW5nbGUgbWFzdGVyIGRldmljZSwgYW5k
Cj4gLXNoYXJlcyBpdHMgY2xvY2tzLCBwb3dlciBkb21haW4gYW5kIGlycS4KPiAtCj4gLVJlcXVp
cmVkIHByb3BlcnRpZXM6Cj4gLS0gY29tcGF0aWJsZcKgwqDCoMKgwqAgOiBTaG91bGQgYmUgInJv
Y2tjaGlwLGlvbW11Igo+IC0tIHJlZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IEFkZHJlc3Mg
c3BhY2UgZm9yIHRoZSBjb25maWd1cmF0aW9uIHJlZ2lzdGVycwo+IC0tIGludGVycnVwdHPCoMKg
wqDCoMKgIDogSW50ZXJydXB0IHNwZWNpZmllciBmb3IgdGhlIElPTU1VIGluc3RhbmNlCj4gLS0g
aW50ZXJydXB0LW5hbWVzIDogSW50ZXJydXB0IG5hbWUgZm9yIHRoZSBJT01NVSBpbnN0YW5jZQo+
IC0tICNpb21tdS1jZWxsc8KgwqDCoCA6IFNob3VsZCBiZSA8MD4uwqAgVGhpcyBpbmRpY2F0ZXMg
dGhlIGlvbW11IGlzIGEKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
InNpbmdsZS1tYXN0ZXIiIGRldmljZSwgYW5kIG5lZWRzIG5vIGFkZGl0aW9uYWwgaW5mb3JtYXRp
b24KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG8gYXNzb2NpYXRl
IHdpdGggaXRzIG1hc3RlciBkZXZpY2UuwqAgU2VlOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUv
aW9tbXUudHh0Cj4gLS0gY2xvY2tzwqDCoMKgwqDCoMKgwqDCoMKgIDogQSBsaXN0IG9mIGNsb2Nr
cyByZXF1aXJlZCBmb3IgdGhlIElPTU1VIHRvIGJlIGFjY2Vzc2libGUgYnkKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGhlIGhvc3QgQ1BVLgo+IC0tIGNsb2NrLW5h
bWVzwqDCoMKgwqAgOiBTaG91bGQgY29udGFpbiB0aGUgZm9sbG93aW5nOgo+IC3CoMKgwqDCoMKg
wqDCoCJpZmFjZSIgLSBNYWluIHBlcmlwaGVyYWwgYnVzIGNsb2NrIChQQ0xLL0hDTCkgKHJlcXVp
cmVkKQo+IC3CoMKgwqDCoMKgwqDCoCJhY2xrIsKgIC0gQVhJIGJ1cyBjbG9jayAocmVxdWlyZWQp
Cj4gLQo+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOgo+IC0tIHJvY2tjaGlwLGRpc2FibGUtbW11LXJl
c2V0IDogRG9uJ3QgdXNlIHRoZSBtbXUgcmVzZXQgb3BlcmF0aW9uLgo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNvbWUgbW11IGlu
c3RhbmNlcyBtYXkgcHJvZHVjZSB1bmV4cGVjdGVkIHJlc3VsdHMKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aGVuIHRoZSByZXNl
dCBvcGVyYXRpb24gaXMgdXNlZC4KPiAtCj4gLUV4YW1wbGU6Cj4gLQo+IC3CoMKgwqDCoMKgwqDC
oHZvcGxfbW11OiBpb21tdUBmZjk0MDMwMCB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGNvbXBhdGlibGUgPSAicm9ja2NoaXAsaW9tbXUiOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZWcgPSA8MHhmZjk0MDMwMCAweDEwMD47Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGludGVycnVwdHMgPSA8R0lDX1NQSSAxNiBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LW5hbWVzID0gInZv
cGxfbW11IjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvY2tzID0gPCZjcnUg
QUNMS19WT1AxPiwgPCZjcnUgSENMS19WT1AxPjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY2xvY2stbmFtZXMgPSAiYWNsayIsICJpZmFjZSI7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCNpb21tdS1jZWxscyA9IDwwPjsKPiAtwqDCoMKgwqDCoMKgwqB9Owo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvcm9ja2No
aXAsaW9tbXUueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9y
b2NrY2hpcCxpb21tdS55YW1sCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAw
MDAwMDAuLjBkYjIwOGNmNzI0YQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvcm9ja2NoaXAsaW9tbXUueWFtbAo+IEBAIC0wLDAg
KzEsNzkgQEAKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5Cj4gKyVZ
QU1MIDEuMgo+ICstLS0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9pb21t
dS9yb2NrY2hpcCxpb21tdS55YW1sIwo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCMKPiArCj4gK3RpdGxlOiBSb2NrY2hpcCBJT01NVQo+ICsK
PiArbWFpbnRhaW5lcnM6Cj4gK8KgIC0gSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4K
PiArCj4gK2Rlc2NyaXB0aW9uOiB8Kwo+ICvCoCBBIFJvY2tjaGlwIERSTSBpb21tdSB0cmFuc2xh
dGVzIGlvIHZpcnR1YWwgYWRkcmVzc2VzIHRvIHBoeXNpY2FsIGFkZHJlc3NlcyBmb3IKPiArwqAg
aXRzIG1hc3RlciBkZXZpY2UuIEVhY2ggc2xhdmUgZGV2aWNlIGlzIGJvdW5kIHRvIGEgc2luZ2xl
IG1hc3RlciBkZXZpY2UgYW5kCj4gK8KgIHNoYXJlcyBpdHMgY2xvY2tzLCBwb3dlciBkb21haW4g
YW5kIGlycS4KPiArCj4gK8KgIEZvciBpbmZvcm1hdGlvbiBvbiBhc3NpZ25pbmcgSU9NTVUgY29u
dHJvbGxlciB0byBpdHMgcGVyaXBoZXJhbCBkZXZpY2VzLAo+ICvCoCBzZWUgZ2VuZXJpYyBJT01N
VSBiaW5kaW5ncy4KPiArCj4gK3Byb3BlcnRpZXM6Cj4gK8KgIGNvbXBhdGlibGU6Cj4gK8KgwqDC
oCBjb25zdDogcm9ja2NoaXAsaW9tbXUKPiArCj4gK8KgIHJlZzoKPiArwqDCoMKgIG1pbkl0ZW1z
OiAxCj4gK8KgwqDCoCBtYXhJdGVtczogMgo+ICsKPiArwqAgaW50ZXJydXB0czoKPiArwqDCoMKg
IG1pbkl0ZW1zOiAxCj4gK8KgwqDCoCBtYXhJdGVtczogMgo+ICsKPiArwqAgaW50ZXJydXB0LW5h
bWVzOgo+ICvCoMKgwqAgbWluSXRlbXM6IDEKPiArwqDCoMKgIG1heEl0ZW1zOiAyCj4gKwoKQUZB
SUNTLCB0aGUgZHJpdmVyIHN1cHBvcnRzIGhhbmRsaW5nIG11bHRpcGxlIE1NVXMsIGFuZCB0aGVy
ZSdzIG9uZSByZWcgYW5kCmludGVycnVwdCBjZWxsIGZvciBlYWNoIE1NVS4gSU9XLCB0aGVyZSdz
IG5vIHJlcXVpcmVtZW50IHRoYXQgbWF4SXRlbXMgaXMgMi4KCklzIHRoZXJlIGFueSB3YXkgd2Ug
Y2FuIGRlc2NyaWJlIHRoYXQ/IE9yIG1heWJlIGp1c3QgYWxsb3cgYSBiaWdnZXIgbWF4aW11bT8K
ClRoYW5rcywKRXplcXVpZWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
