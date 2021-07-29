Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1138BC4320A
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 15:43:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE1260F42
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 15:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFE1260F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 704D66062B;
	Thu, 29 Jul 2021 15:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9yyg8o9coLvP; Thu, 29 Jul 2021 15:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A054F605A8;
	Thu, 29 Jul 2021 15:43:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70905C0010;
	Thu, 29 Jul 2021 15:43:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 669C7C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F56D4058E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qKvaaw3OCwwX for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 15:43:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03B2B4058B
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:43:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E076D;
 Thu, 29 Jul 2021 08:43:16 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A26983F73D;
 Thu, 29 Jul 2021 08:43:13 -0700 (PDT)
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, joro@8bytes.org,
 will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <2947762.k3LOHGUjKi@diego>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ade9f10e-836c-f29e-030b-23fe0a3187fb@arm.com>
Date: Thu, 29 Jul 2021 16:43:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2947762.k3LOHGUjKi@diego>
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

T24gMjAyMS0wNy0yOSAxNjowNCwgSGVpa28gU3TDvGJuZXIgd3JvdGU6Cj4gSGkgUm9iaW4sCj4g
Cj4gQW0gTWl0dHdvY2gsIDI4LiBKdWxpIDIwMjEsIDE3OjU4OjIxIENFU1Qgc2NocmllYiBSb2Jp
biBNdXJwaHk6Cj4+IEhpIGFsbCwKPj4KPj4gSGVyZSdzIHYyIHdoZXJlIHRoaW5ncyBzdGFydCB0
byBsb29rIG1vcmUgcmVhbGlzdGljLCBoZW5jZSB0aGUgZXhwYW5kZWQKPj4gQ0MgbGlzdC4gVGhl
IHBhdGNoZXMgYXJlIG5vdyBiYXNlZCBvbiB0aGUgY3VycmVudCBpb21tdS9jb3JlIGJyYW5jaCB0
bwo+PiB0YWtlIEpvaG4ncyBpb21tdV9zZXRfZG1hX3N0cmljdCgpIGNsZWFudXAgaW50byBhY2Nv
dW50Lgo+Pgo+PiBUaGUgc2VyaWVzIHJlbWlhaW5zIGluIHR3byAob3IgcG9zc2libHkgMykgbG9n
aWNhbCBwYXJ0cyAtIGZvciBwZW9wbGUKPj4gQ0MnZCBvbiBjb29raWUgY2xlYW51cCBwYXRjaGVz
LCB0aGUgbGF0ZXIgcGFydHMgc2hvdWxkIG5vdCBhZmZlY3QgeW91Cj4+IHNpbmNlIHlvdXIgZHJp
dmVycyBkb24ndCBpbXBsZW1lbnQgbm9uLXN0cmljdCBtb2RlIGFueXdheTsgdGhlIGNsZWFudXAK
Pj4gaXMgYWxsIHByZXR0eSBzdHJhaWdodGZvcndhcmQsIGJ1dCBwbGVhc2UgZG8geWVsbCBhdCBt
ZSBpZiBJJ3ZlIG1hbmFnZWQKPj4gdG8gbGV0IGEgc2lsbHkgbWlzdGFrZSBzbGlwIHRocm91Z2gg
YW5kIGJyb2tlbiB5b3VyIGRyaXZlci4KPj4KPj4gVGhpcyB0aW1lIEkgaGF2ZSBhbHNvIGJ1aWxk
LXRlc3RlZCB4ODYgYXMgd2VsbCBhcyBhcm02NCA6KQo+IAo+IFRMO0RSOiBhcm02NCB5YXksIGFy
bTMyIG5heSA7LSkKCkNoZWVycyBIZWlrbyEKCj4gdGVzdGNhc2U6Cj4gNS4xNC1yYzMKPiArIGlv
bW11L25leHQKPiArIHBhdGNoZXMgMSs4ICh0aGUgb25lcyB5b3UgY2MnZCBtZSBvbikKPiAgICBp
b21tdTogUHVsbCBJT1ZBIGNvb2tpZSBtYW5hZ2VtZW50IGludG8gdGhlIGNvcmUKPiAgICBpb21t
dS9yb2NrY2hpcDogRHJvcCBJT1ZBIGNvb2tpZSBtYW5hZ2VtZW50Cj4gCj4gcmszMzk5K2hkbWkg
KHB1bWEpOiBib290cyB3aXRoIGdyYXBoaWNzCj4gcmszMzk5K2VkcCAoa2V2aW4pOiBib290cyB3
aXRoIGdyYXBoaWNzCj4gcHgzMCtkc2kgKG1pbmlldmIpOiBib290cyB3aXRoIGdyYXBoaWNzCj4g
Cj4gcmszMjg4IChhcm0zMiwgdmV5cm9uLXBpbmt5KTogaGFuZ3Mgd2hlbiB0cnlpbmcgdG8gc3Rh
cnQgdGhlIHJvY2tjaGlwLWRybQo+IGF0IHNvbWUgcG9pbnRzIHRoZSByZXN0IG9mIHRoZSBzeXN0
ZW0gcmVjb3ZlcnMgYW5kIGZpbGxzIHRoZSBsb2cgd2l0aAo+IAo+IFsgICA0Ny4xOTM3NzZdIFtk
cm06ZHJtX2NydGNfY29tbWl0X3dhaXRdICpFUlJPUiogZmxpcF9kb25lIHRpbWVkIG91dAo+IFsg
ICA0Ny4xOTM4NjddIFtkcm06ZHJtX2F0b21pY19oZWxwZXJfd2FpdF9mb3JfZGVwZW5kZW5jaWVz
XSAqRVJST1IqIFtQTEFORTozMTpwbGFuZS0wXSBjb21taXQgd2FpdCB0aW1lZCBvdXQKPiBbICAg
NTcuNDMzNzQzXSBbZHJtOmRybV9jcnRjX2NvbW1pdF93YWl0XSAqRVJST1IqIGZsaXBfZG9uZSB0
aW1lZCBvdXQKPiBbICAgNTcuNDMzODI4XSBbZHJtOmRybV9hdG9taWNfaGVscGVyX3dhaXRfZm9y
X2RlcGVuZGVuY2llc10gKkVSUk9SKiBbUExBTkU6NDA6cGxhbmUtNF0gY29tbWl0IHdhaXQgdGlt
ZWQgb3V0Cj4gCj4gc3Bld3MKPiAKPiB0ZXN0Y2FzZSAyOgo+IDUuMTQtcmMzCj4gKyBpb21tdS9u
ZXh0Cj4gCj4gYWxsIHdvcmtzIGZpbmUgb24gYm90aCBhcm0zMithcm02NAo+IAo+IAo+IFRoYXQg
d2hvbGUgaW9tbXUgdm9vZG9vIGlzIGEgYml0IG92ZXIgbXkgaGVhZCByaWdodCBub3csIHNvIEkn
bSBub3Qgc3VyZQo+IHdoYXQgdG8gcG9rZSB0byBkaWFnbm9zZSB0aGlzLgoKRGFuZywgdGhpcyB3
YXNuJ3Qgc3VwcG9zZWQgdG8gYWZmZWN0IDMyLWJpdCBBcm0gYXQgYWxsLCBzaW5jZSB0aGF0IApk
b2Vzbid0IHRvdWNoIGFueSBvZiB0aGUgZGVmYXVsdCBkb21haW4gc3R1ZmYgZWl0aGVyIHdheS4g
SSBoYXZlIGJvdGggbXkgClJLMzI4OCBib3ggKHdoaWNoIElJUkMgZG9lc24ndCBjdXJyZW50bHkg
Ym9vdCkgYW5kIGFuIE9kcm9pZC1VMyBpbiB0aGUgCiJkZXNrIHBpbGUiIHJpZ2h0IGluIGZyb250
IG9mIG1lLCBzbyBhdCB3b3JzdCBJJ2xsIHRyeSBicmluZ2luZyBvbmUgb2YgCnRob3NlIHRvIGxp
ZmUgdG8gc2VlIHdoYXQgc2lsbHkgdGhpbmcgSSBoYXZlIGluZGVlZCBkb25lIHRvIGJyZWFrIDMy
LWJpdC4KCkkgaGF2ZSBhIHZhZ3VlIGlkZWEgZm9ybWluZyBhbHJlYWR5LCB3aGljaCBzdWdnZXN0
cyB0aGF0IGl0IG1pZ2h0IGdldCAKYmV0dGVyIGFnYWluIG9uY2UgcGF0Y2ggIzEyIGlzIGFwcGxp
ZWQsIGJ1dCBldmVuIGlmIHNvIHRoZXJlJ3Mgbm8gZXhjdXNlIApub3QgdG8gYmUgYmlzZWN0YWJs
ZSwgc28gSSBuZWVkIHRvIGRpZyBpbiBhbmQgZml4IGl0IC0gbWFueSB0aGFua3MgZm9yIAp5ZWxs
aW5nIGFzIHJlcXVlc3RlZCA6RAoKUm9iaW4uCgo+IAo+IAo+IEhlaWtvCj4gCj4gCj4+IENoYW5n
ZXMgaW4gdjI6Cj4+Cj4+IC0gQWRkIGlvbW11X2lzX2RtYV9kb21haW4oKSBoZWxwZXIgdG8gYWJz
dHJhY3QgZmxhZyBjaGVjayAoYW5kIGhlbHAKPj4gICAgYXZvaWQgc2lsbHkgdHlwb3MgbGlrZSB0
aGUgb25lIGluIHYxKS4KPj4gLSBUd2VhayBhIGZldyBjb21taXQgbWVzc2FnZXMgZm9yIHNwZWxs
aW5nIGFuZCAoaG9wZWZ1bGx5KSBjbGFyaXR5Lgo+PiAtIE1vdmUgdGhlIGlvbW11X2NyZWF0ZV9k
ZXZpY2VfZGlyZWN0X21hcHBpbmdzKCkgdXBkYXRlIHRvIHBhdGNoICMxNAo+PiAgICB3aGVyZSBp
dCBzaG91bGQgaGF2ZSBiZWVuLgo+PiAtIFJld3JpdGUgcGF0Y2ggIzIwIGFzIGEgY29udmVyc2lv
biBvZiB0aGUgbm93LWV4aXN0aW5nIG9wdGlvbi4KPj4gLSBDbGVhbiB1cCB0aGUgb3BzLT5mbHVz
aF9pb3RsYl9hbGwgY2hlY2sgd2hpY2ggaXMgYWxzbyBtYWRlIHJlZHVuZGFudAo+PiAgICBieSB0
aGUgbmV3IGRvbWFpbiB0eXBlCj4+IC0gQWRkIHBhdGNoICMyNCwgd2hpY2ggaXMgYXJndWFibHkg
dGFuZ2VudGlhbCwgYnV0IGl0IHdhcyBzb21ldGhpbmcgSQo+PiAgICBzcG90dGVkIGR1cmluZyB0
aGUgcmViYXNlLCBzby4uLgo+Pgo+PiBPbmNlIGFnYWluLCB0aGUgd2hvbGUgbG90IGlzIGF2YWls
YWJsZSBvbiBhIGJyYW5jaCBoZXJlOgo+Pgo+PiBodHRwczovL2dpdGxhYi5hcm0uY29tL2xpbnV4
LWFybS9saW51eC1ybS8tL3RyZWUvaW9tbXUvZnEKPj4KPj4gVGhhbmtzLAo+PiBSb2Jpbi4KPj4K
Pj4KPj4gQ0M6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KPj4g
Q0M6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4K
Pj4gQ0M6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+Cj4+IEND
OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4KPj4gQ0M6IEhlaWtvIFN0dWVibmVyIDxo
ZWlrb0BzbnRlY2guZGU+Cj4+IENDOiBDaHVueWFuIFpoYW5nIDxjaHVueWFuLnpoYW5nQHVuaXNv
Yy5jb20+Cj4+IENDOiBDaHVueWFuIFpoYW5nIDxjaHVueWFuLnpoYW5nQHVuaXNvYy5jb20+Cj4+
IENDOiBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5vcmc+Cj4+IENDOiBKZWFuLVBoaWxp
cHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4KPj4KPj4gUm9iaW4gTXVycGh5
ICgyNCk6Cj4+ICAgIGlvbW11OiBQdWxsIElPVkEgY29va2llIG1hbmFnZW1lbnQgaW50byB0aGUg
Y29yZQo+PiAgICBpb21tdS9hbWQ6IERyb3AgSU9WQSBjb29raWUgbWFuYWdlbWVudAo+PiAgICBp
b21tdS9hcm0tc21tdTogRHJvcCBJT1ZBIGNvb2tpZSBtYW5hZ2VtZW50Cj4+ICAgIGlvbW11L3Z0
LWQ6IERyb3AgSU9WQSBjb29raWUgbWFuYWdlbWVudAo+PiAgICBpb21tdS9leHlub3M6IERyb3Ag
SU9WQSBjb29raWUgbWFuYWdlbWVudAo+PiAgICBpb21tdS9pcG1tdS12bXNhOiBEcm9wIElPVkEg
Y29va2llIG1hbmFnZW1lbnQKPj4gICAgaW9tbXUvbXRrOiBEcm9wIElPVkEgY29va2llIG1hbmFn
ZW1lbnQKPj4gICAgaW9tbXUvcm9ja2NoaXA6IERyb3AgSU9WQSBjb29raWUgbWFuYWdlbWVudAo+
PiAgICBpb21tdS9zcHJkOiBEcm9wIElPVkEgY29va2llIG1hbmFnZW1lbnQKPj4gICAgaW9tbXUv
c3VuNTBpOiBEcm9wIElPVkEgY29va2llIG1hbmFnZW1lbnQKPj4gICAgaW9tbXUvdmlydGlvOiBE
cm9wIElPVkEgY29va2llIG1hbmFnZW1lbnQKPj4gICAgaW9tbXUvZG1hOiBVbmV4cG9ydCBJT1ZB
IGNvb2tpZSBtYW5hZ2VtZW50Cj4+ICAgIGlvbW11L2RtYTogUmVtb3ZlIHJlZHVuZGFudCAiIWRl
diIgY2hlY2tzCj4+ICAgIGlvbW11OiBJbnRyb2R1Y2UgZXhwbGljaXQgdHlwZSBmb3Igbm9uLXN0
cmljdCBETUEgZG9tYWlucwo+PiAgICBpb21tdS9hbWQ6IFByZXBhcmUgZm9yIG11bHRpcGxlIERN
QSBkb21haW4gdHlwZXMKPj4gICAgaW9tbXUvYXJtLXNtbXU6IFByZXBhcmUgZm9yIG11bHRpcGxl
IERNQSBkb21haW4gdHlwZXMKPj4gICAgaW9tbXUvdnQtZDogUHJlcGFyZSBmb3IgbXVsdGlwbGUg
RE1BIGRvbWFpbiB0eXBlcwo+PiAgICBpb21tdTogRXhwcmVzcyBETUEgc3RyaWN0bmVzcyB2aWEg
dGhlIGRvbWFpbiB0eXBlCj4+ICAgIGlvbW11OiBFeHBvc2UgRE1BIGRvbWFpbiBzdHJpY3RuZXNz
IHZpYSBzeXNmcwo+PiAgICBpb21tdTogTWVyZ2Ugc3RyaWN0bmVzcyBhbmQgZG9tYWluIHR5cGUg
Y29uZmlncwo+PiAgICBpb21tdS9kbWE6IEZhY3RvciBvdXQgZmx1c2ggcXVldWUgaW5pdAo+PiAg
ICBpb21tdTogQWxsb3cgZW5hYmxpbmcgbm9uLXN0cmljdCBtb2RlIGR5bmFtaWNhbGx5Cj4+ICAg
IGlvbW11L2FybS1zbW11OiBBbGxvdyBub24tc3RyaWN0IGluIHBndGFibGVfcXVpcmtzIGludGVy
ZmFjZQo+PiAgICBpb21tdTogT25seSBsb2cgc3RyaWN0bmVzcyBmb3IgRE1BIGRvbWFpbnMKPj4K
Pj4gICAuLi4vQUJJL3Rlc3Rpbmcvc3lzZnMta2VybmVsLWlvbW11X2dyb3VwcyAgICAgfCAgMiAr
Cj4+ICAgZHJpdmVycy9pb21tdS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgIHwgODAg
KysrKysrKysrLS0tLS0tLS0tLQo+PiAgIGRyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMgICAgICAg
ICAgICAgICAgICAgICB8IDIxICstLS0tCj4+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYyAgIHwgMjUgKysrKy0tCj4+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJt
LXNtbXUvYXJtLXNtbXUuYyAgICAgICAgIHwgMjkgKysrKy0tLQo+PiAgIGRyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11L3Fjb21faW9tbXUuYyAgICAgICB8ICA4IC0tCj4+ICAgZHJpdmVycy9pb21t
dS9kbWEtaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgIHwgNDQgKysrKystLS0tLQo+PiAgIGRy
aXZlcnMvaW9tbXUvZXh5bm9zLWlvbW11LmMgICAgICAgICAgICAgICAgICB8IDE4ICstLS0tCj4+
ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jICAgICAgICAgICAgICAgICAgIHwgMjMgKyst
LS0tCj4+ICAgZHJpdmVycy9pb21tdS9pb21tdS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwg
NTMgKysrKysrKy0tLS0tCj4+ICAgZHJpdmVycy9pb21tdS9pcG1tdS12bXNhLmMgICAgICAgICAg
ICAgICAgICAgIHwgMjcgKy0tLS0tLQo+PiAgIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgICAg
ICAgICAgICAgICAgICAgICB8ICA2IC0tCj4+ICAgZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21t
dS5jICAgICAgICAgICAgICAgIHwgMTEgKy0tCj4+ICAgZHJpdmVycy9pb21tdS9zcHJkLWlvbW11
LmMgICAgICAgICAgICAgICAgICAgIHwgIDYgLS0KPj4gICBkcml2ZXJzL2lvbW11L3N1bjUwaS1p
b21tdS5jICAgICAgICAgICAgICAgICAgfCAxMiArLS0KPj4gICBkcml2ZXJzL2lvbW11L3ZpcnRp
by1pb21tdS5jICAgICAgICAgICAgICAgICAgfCAgOCAtLQo+PiAgIGluY2x1ZGUvbGludXgvZG1h
LWlvbW11LmggICAgICAgICAgICAgICAgICAgICB8ICA5ICsrLQo+PiAgIGluY2x1ZGUvbGludXgv
aW9tbXUuaCAgICAgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKy0KPj4gICAxOCBmaWxlcyBj
aGFuZ2VkLCAxNzEgaW5zZXJ0aW9ucygrKSwgMjI2IGRlbGV0aW9ucygtKQo+Pgo+Pgo+IAo+IAo+
IAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
