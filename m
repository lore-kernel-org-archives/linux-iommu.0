Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74350C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 13:51:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DF8206C3
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 13:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Af7PYbiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DF8206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D18A0865D6;
	Mon,  8 Jun 2020 13:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsWsFd3cJJ1C; Mon,  8 Jun 2020 13:50:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A850862A0;
	Mon,  8 Jun 2020 13:50:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 712ABC0863;
	Mon,  8 Jun 2020 13:50:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE61C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 13:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A9AD18745D
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 13:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EyamyjQCyWfi for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 13:50:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A4AE087595
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 13:50:34 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1591624236; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BeW+XFvH8gEbAcXx9Jn4/gY3Kx/KL0fZNhe2EoXlSQQ=;
 b=Af7PYbiPRMgqxOcnL8qzff2TCOqCCBLOAEtFwAoJEQrywaRfp+Kvm8iio+cgP5M4jzXJwVoZ
 IMHBUxm++C5cqLHsgOhGIyckMt4lQQJUCa1DGwf3dCYxhU0zxB+nPMXxa/DBpbdlPGBugnJF
 9rXdSoA4q87DneGC7uvauWv8pQg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5ede421a3b3439f23ad58626 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Jun 2020 13:50:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 61E76C43391; Mon,  8 Jun 2020 13:50:18 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 376ACC433CA;
 Mon,  8 Jun 2020 13:50:17 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 08 Jun 2020 19:20:17 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu: Remove shutdown callback
In-Reply-To: <e072f61a-d6cf-2e34-efd5-c1db38c5c622@arm.com>
References: <20200607110918.1733-1-saiprakash.ranjan@codeaurora.org>
 <20200608081846.GA1542@willie-the-truck>
 <08c293eefc20bc2c67f2d2639b93f0a5@codeaurora.org>
 <e072f61a-d6cf-2e34-efd5-c1db38c5c622@arm.com>
Message-ID: <c5a86b3a5a8a6d32e094b6ebde23f869@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgUm9iaW4sCgpPbiAyMDIwLTA2LTA4IDE2OjU2LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MjAyMC0wNi0wOCAxMDoxMywgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+PiBIaSBXaWxsLAo+
PiAKPj4gT24gMjAyMC0wNi0wOCAxMzo0OCwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+PiBPbiBTdW4s
IEp1biAwNywgMjAyMCBhdCAwNDozOToxOFBNICswNTMwLCBTYWkgUHJha2FzaCBSYW5qYW4gd3Jv
dGU6Cj4+Pj4gUmVtb3ZlIFNNTVUgc2h1dGRvd24gY2FsbGJhY2sgc2luY2UgaXQgc2VlbXMgdG8g
Y2F1c2UgbW9yZQo+Pj4+IHByb2JsZW1zIHRoYW4gYmVuZWZpdHMuIFdpdGggdGhpcyBjYWxsYmFj
aywgd2UgbmVlZCB0byBtYWtlCj4+Pj4gc3VyZSB0aGF0IGFsbCBjbGllbnRzL2NvbnN1bWVycyBv
ZiBTTU1VIGRvIG5vdCBwZXJmb3JtIGFueQo+Pj4+IERNQSBhY3Rpdml0eSBvbmNlIHRoZSBTTU1V
IGlzIHNodXRkb3duIGFuZCB0cmFuc2xhdGlvbiBpcwo+Pj4+IGRpc2FibGVkLiBJbiBvdGhlciB3
b3JkcyB3ZSBuZWVkIHRvIGFkZCBzaHV0ZG93biBjYWxsYmFja3MKPj4+PiBmb3IgYWxsIHRob3Nl
IGNsaWVudHMgdG8gbWFrZSBzdXJlIHRoZXkgZG8gbm90IHBlcmZvcm0gYW55Cj4+Pj4gRE1BIG9y
IGVsc2Ugd2Ugc2VlIGFsbCBraW5kcyBvZiB3ZWlyZCBjcmFzaGVzIGR1cmluZyByZWJvb3QKPj4+
PiBvciBzaHV0ZG93bi4gVGhpcyBpcyBjbGVhcmx5IG5vdCBzY2FsYWJsZSBhcyB0aGUgbnVtYmVy
IG9mCj4+Pj4gY2xpZW50cyBvZiBTTU1VIHdvdWxkIHZhcnkgYWNyb3NzIFNvQ3MgYW5kIHdlIHdv
dWxkIG5lZWQgdG8KPj4+PiBhZGQgc2h1dGRvd24gY2FsbGJhY2tzIHRvIGFsbW9zdCBhbGwgZHJp
dmVycyBldmVudHVhbGx5Lgo+Pj4+IFRoaXMgY2FsbGJhY2sgd2FzIGFkZGVkIGZvciBrZXhlYyB1
c2VjYXNlIHdoZXJlIGl0IHdhcyBrbm93bgo+Pj4+IHRvIGNhdXNlIG1lbW9yeSBjb3JydXB0aW9u
cyB3aGVuIFNNTVUgd2FzIG5vdCBzaHV0ZG93biBidXQKPj4+PiB0aGF0IGRvZXMgbm90IGRpcmVj
dGx5IHJlbGF0ZSB0byBTTU1VIGJlY2F1c2UgdGhlIG1lbW9yeQo+Pj4+IGNvcnJ1cHRpb24gY291
bGQgYmUgYmVjYXVzZSBvZiB0aGUgY2xpZW50IG9mIFNNTVUgd2hpY2ggaXMKPj4+PiBub3Qgc2h1
dGRvd24gcHJvcGVybHkgYmVmb3JlIGJvb3RpbmcgaW50byBuZXcga2VybmVsLiBTbyBpbgo+Pj4+
IHRoYXQgY2FzZSwgd2UgbmVlZCB0byBpZGVudGlmeSB0aGUgY2xpZW50IG9mIFNNTVUgY2F1c2lu
Zwo+Pj4+IHRoZSBtZW1vcnkgY29ycnVwdGlvbiBhbmQgYWRkIGFwcHJvcHJpYXRlIHNodXRkb3du
IGNhbGxiYWNrCj4+Pj4gdG8gdGhlIGNsaWVudCByYXRoZXIgdGhhbiB0byB0aGUgU01NVS4KPj4+
PiAKPj4+PiBTaWduZWQtb2ZmLWJ5OiBTYWkgUHJha2FzaCBSYW5qYW4gPHNhaXByYWthc2gucmFu
amFuQGNvZGVhdXJvcmEub3JnPgo+Pj4+IC0tLQo+Pj4+IMKgZHJpdmVycy9pb21tdS9hcm0tc21t
dS12My5jIHwgNiAtLS0tLS0KPj4+PiDCoGRyaXZlcnMvaW9tbXUvYXJtLXNtbXUuY8KgwqDCoCB8
IDYgLS0tLS0tCj4+Pj4gwqAyIGZpbGVzIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQo+Pj4gCj4+
PiBUaGlzIGZlZWxzIGxpa2UgYSBnaWFudCBib2RnZSB0byBtZSBhbmQgSSB0aGluayB0aGF0IGFu
eSBkcml2ZXIgd2hpY2gKPj4+IGNvbnRpbnVlcyB0byBwZXJmb3JtIERNQSBhZnRlciBpdHMgLT5z
aHV0ZG93bigpIGZ1bmN0aW9uIGhhcyBiZWVuIAo+Pj4gaW52b2tlZAo+Pj4gaXMgYnVnZ3kuIFdv
dWxkbid0IHRoYXQgY2F1c2UgcHJvYmxlbXMgd2l0aCBrZXhlYygpLCBmb3IgZXhhbXBsZT8KPj4+
IAo+PiAKPj4gWWVzIGl0IGlzIGRlZmluaXRlbHkgYSBidWcgaW4gdGhlIGNsaWVudCBkcml2ZXIg
aWYgRE1BIGlzIHBlcmZvcm1lZAo+PiBhZnRlciBzaHV0ZG93biBjYWxsYmFjayBvZiB0aGF0IHJl
c3BlY3RpdmUgZHJpdmVyIGlzIGludm9rZWQgYW5kIGl0IAo+PiBtdXN0Cj4+IGJlIGZpeGVkIGlu
IHRoYXQgZHJpdmVyLiBCdXQgaGVyZSB0aGUgcHJvYmxlbSBJIHdhcyBkZXNjcmliaW5nIGlzIG5v
dCAKPj4gdGhhdCwKPj4gbW9zdCBvZiB0aGUgZHJpdmVycyBkbyBub3QgaGF2ZSBhIHNodXRkb3du
IGNhbGxiYWNrIHRvIGJlZ2luIHdpdGggYW5kIAo+PiBhZGRpbmcKPj4gaXQganVzdCBiZWNhdXNl
IG9mIHNodXRkb3duIGRlcGVuZGVuY3kgb24gU01NVSBkb2Vzbid0IHNlZW0gc28gd2VsbCAKPj4g
YmVjYXVzZQo+PiB3ZSBjYW4gaGF2ZSBtYW55IG1vcmUgc3VjaCBjbGllbnRzIGluIHRoZSBmdXR1
cmUgYW5kIHRoZW4gd2UgaGF2ZSB0byAKPj4ganVzdCBnbwo+PiBvbiBhZGRpbmcgdGhlIHNodXRk
b3duIGNhbGxiYWNrcyBldmVyeXdoZXJlLgo+IAo+IFllcywgaW5kZWVkIHdlIGRvLiBMaWtlIGl0
IG9yIG5vdCwga2V4ZWMgaXMgYSB0aGluZywgYW5kIGFib3V0IDk4JSBvZgo+IGRyaXZlcnMgd2ls
bCBoYXZlIGJlZW4gd3JpdHRlbiB3aXRob3V0IGNvbnNpZGVyaW5nIGl0Lgo+IAo+IElmIGZpeGlu
ZyBvbmUgcHJvYmxlbSBleHBvc2VzIGxvdHMgb2Ygb3RoZXIgcHJvYmxlbXMsIGNhbiB5b3UgaG9u
ZXN0bHkKPiBzYXkgdGhhdCB0aGUgYmVzdCBzb2x1dGlvbiBpcyB0byBnbyBiYWNrIGFuZCByZS1i
cmVhayB0aGUgb3JpZ2luYWwKPiB0aGluZz8KPiAKCk5vLCBkZWZpbml0ZWx5IG5vdC4gSSB3YXMg
dW5kZXIgdGhlIHdyb25nIGltcHJlc3Npb24gdGhhdCAqa2V4ZWMgdGhpbmcqCndhcyBtb3JlIGR1
ZSB0byB0aGUgY2xpZW50IGRyaXZlciBidWdzIHJhdGhlciB0aGFuIHRoZSBTTU1VLgoKPj4+IFRo
ZXJlJ3MgYSBjbGVhciBzaHV0ZG93biBkZXBlbmRlbmN5IG9yZGVyaW5nLCB3aGVyZSB0aGUgY2xp
ZW50cyBvZiAKPj4+IHRoZQo+Pj4gU01NVSBuZWVkIHRvIHNodXRkb3duIGJlZm9yZSB0aGUgU01N
VSBpdHNlbGYsIGJ1dCB0aGF0J3Mgbm90IHJlYWxseQo+Pj4gdGhlIFNNTVUgZHJpdmVyJ3MgcHJv
YmxlbSB0byBzb2x2ZS4KPj4+IAo+PiAKPj4gVGhlIHByb2JsZW0gd2l0aCBrZXhlYyBtYXkgbm90
IGJlIGRpcmVjdGx5IHJlbGF0ZWQgdG8gU01NVSBhcyB5b3Ugc2FpZAo+PiBhYm92ZSBpZiBETUEg
aXMgcGVyZm9ybWVkIGFmdGVyIHRoZSBjbGllbnQgc2h1dGRvd24gY2FsbGJhY2ssIHRoZW4gaXRz
IAo+PiBhCj4+IGJ1ZyBpbiB0aGUgY2xpZW50IGRyaXZlciwgc28gdGhhdCBuZWVkcyB0byBiZSBm
aXhlZCBpbiB0aGUgY2xpZW50IAo+PiBkcml2ZXIsCj4+IG5vdCB0aGUgU01NVS4gU28gaXMgdGhl
cmUgYW55IHBvaW50IGluIGhhdmluZyB0aGUgU01NVSBzaHV0ZG93biAKPj4gY2FsbGJhY2s/Cj4g
Cj4gVGhlIHBvaW50IGlzIHRoYXQga2V4ZWMgbmVlZHMgdG8gcmV0dXJuIHRoZSBzeXN0ZW0gdG8g
YSBzdGF0ZSBhcyBjbG9zZQo+IHRvIHJlc2V0IGFzIHBvc3NpYmxlLiBUaGUgU01NVSBpcyBhdCBs
ZWFzdCBhcyByZWxldmFudCBhcyBhbnkgb3RoZXIKPiBkZXZpY2UgaW4gdGhhdCByZWdhcmQsIGlm
IG5vdCBmYXIgbW9yZSBzbyAtIGNvbnNpZGVyIGlmIHRoZSBmaXJzdAo+IGtlcm5lbCAqZGlkKiBs
ZWF2ZSBpdCBlbmFibGVkIHdpdGggd2hhdGV2ZXIgbGVmdC1vdmVyIHRyYW5zbGF0aW9ucyBpbgo+
IHBsYWNlLCBhbmQga2V4ZWMnZWQgaW50byBhbm90aGVyIE9TIHRoYXQgd2Fzbid0IFNNTVUtYXdh
cmUuLi4KPiAKClllcyB1bmRlcnN0b29kLiBJIHdyb25nbHkgYXNzdW1lZCB0aGF0IHRoZSBrZXhl
YyBwcm9ibGVtIHdhcyBtb3JlCm9mIGEgY2xpZW50IGRyaXZlciBidWdzIHJhdGhlciB0aGFuIFNN
TVUuIEJ1dCBJIHNlZSB0aGF0IHdlIGluZGVlZApuZWVkIHRvIHNodXRkb3duIFNNTVUgYXMgYW55
IG90aGVyIGRyaXZlci4KCj4+IEFzIHlvdSBzZWUsIHdpdGggdGhpcyBTTU1VIHNodXRkb3duIGNh
bGxiYWNrLCB3ZSBuZWVkIHRvIGFkZCBzaHV0ZG93bgo+PiBjYWxsYmFja3MgaW4gYWxsIHRoZSBj
bGllbnQgZHJpdmVycy4KPiAKPiBZZXMuIEFuZCBpZiB5b3UgcmVhbGx5IHdhbnQgdG8gYXJndWUg
YWdhaW5zdCB0aGF0LCB0aGVuIGF0IGxlYXN0IGJlCj4gY29uc2lzdGVudCBhbmQgcHJvcG9zZSBy
ZW1vdmluZyBzaHV0ZG93biBmcm9tICphbGwqIHRoZSBJT01NVSBkcml2ZXJzLgo+IEFuZCB0aGVu
IHByb2JhYmx5IHByb3Bvc2UgcmVtb3Zpbmcga2V4ZWMgc3VwcG9ydCBmcm9tIGFsbCB0aGVpcgo+
IHJlc3BlY3RpdmUgYXJjaGl0ZWN0dXJlcy4uLiA7KQo+IAoKTm90IG15IGludGVudGlvbiB0byBi
cmVhayBvciByZW1vdmUga2V4ZWMsIGhlbmNlIHRoZSBSRkMgdGFnIDopCkFzIGZvciB0aGUgY29u
c2lzdGVudCBwYXJ0LCBvdXQgb2YgMTggaW9tbXUgZHJpdmVycyBvbmx5IDUKaGF2ZSBzaHV0ZG93
biBjYWxsYmFja3MsIHNvIG5vdGhpbmcgbXVjaCB0byByZW1vdmUgdGhlcmUgYW5kCmtleGVjIGlz
IGJyb2tlbiB0aGVyZSBwcm9iYWJseS4gSG93ZXZlciBJIGdvdCB5b3VyIHBvaW50IGFuZAp3aWxs
IGRyb3AgdGhpcyBwYXRjaC4KClRoYW5rcywKU2FpCgotLSAKUVVBTENPTU0gSU5ESUEsIG9uIGJl
aGFsZiBvZiBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIAptZW1iZXIKb2Yg
Q29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlvbgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
