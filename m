Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DB3C432BE
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 16:58:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2074D608FB
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 16:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2074D608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF1CF4062C;
	Thu, 29 Jul 2021 16:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfC0h_jOIo19; Thu, 29 Jul 2021 16:58:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B706740628;
	Thu, 29 Jul 2021 16:58:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6B6C001A;
	Thu, 29 Jul 2021 16:58:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C74F3C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A85164012D
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2TUcG68fJJlA for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 16:58:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 873AC40001
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:58:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A298F1FB;
 Thu, 29 Jul 2021 09:58:10 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AF463F73D;
 Thu, 29 Jul 2021 09:58:08 -0700 (PDT)
Subject: Re: [PATCH v7 3/4] iommu: rockchip: Add internal ops to handle
 variants
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, xxm@rock-chips.com,
 Ezequiel Garcia <ezequiel@collabora.com>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
References: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
 <20210525121551.606240-4-benjamin.gaignard@collabora.com>
 <c6175f3d-a324-9fb5-bd39-cfe0447ee5e7@collabora.com>
 <3544194.oiGErgHkdL@diego>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <06cdd178-66af-9ff7-5100-3da4e901040f@arm.com>
Date: Thu, 29 Jul 2021 17:58:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3544194.oiGErgHkdL@diego>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wNy0yOSAxNzowOCwgSGVpa28gU3TDvGJuZXIgd3JvdGU6Cj4gSGkgRGFmbmEsCj4g
Cj4gQW0gRG9ubmVyc3RhZywgMjkuIEp1bGkgMjAyMSwgMTc6NTk6MjYgQ0VTVCBzY2hyaWViIERh
Zm5hIEhpcnNjaGZlbGQ6Cj4+IE9uIDI1LjA1LjIxIDE0OjE1LCBCZW5qYW1pbiBHYWlnbmFyZCB3
cm90ZToKPj4+IEBAIC04NzksNyArODk1LDcgQEAgc3RhdGljIGludCBya19pb21tdV9lbmFibGUo
c3RydWN0IHJrX2lvbW11ICppb21tdSkKPj4+ICAgIAo+Pj4gICAgCWZvciAoaSA9IDA7IGkgPCBp
b21tdS0+bnVtX21tdTsgaSsrKSB7Cj4+PiAgICAJCXJrX2lvbW11X3dyaXRlKGlvbW11LT5iYXNl
c1tpXSwgUktfTU1VX0RURV9BRERSLAo+Pj4gLQkJCSAgICAgICBya19kb21haW4tPmR0X2RtYSk7
Cj4+PiArCQkJICAgICAgIHJrX29wcy0+ZG1hX2FkZHJfZHRlKHJrX2RvbWFpbi0+ZHRfZG1hKSk7
Cj4+Cj4+IEhpLAo+PiBUaGlzIGlzIG5vdCByZWxhdGVkIHRvIHRoYXQgcGF0Y2gsIEkgd2FzIHdv
bmRyaW5nIHdoeSBhcmUgYWxsIG1tdSBkZXZpY2VzIGluaXRpYWxpemVkCj4+IHdpdGggdGhlIHNh
bWUgZHRfZG1hPwo+PiBJIHNlZSBmb3IgZXhhbXBsZSB0aGF0IHRoZSBpc3AwX21tdSBpbiByazMz
OTkuZHRzaSBoYXMgdHdvIHJlc291cmNlcy4gQ2FuJ3QgZWFjaCByZXNvdXJjZQo+PiBiZSBpbml0
aWFsaXplZCB3aXRoIGRpZmZlcmVudCBkdF9kbWEgYW5kIHRoaXMgd2F5IHRoZXJlIGFyZSB0d28g
ZHQgdGFibGVzIGluc3RlYWQgb2YgdGhlIHR3byBtbXVzIHBvaW50aW5nCj4+IHRvIHRoZSBzYW1l
IGR0IHRhYmxlLgo+IAo+IG1heWJlCj4gZ2l0IGxvZyAtMSBjZDY0MzhjNWY4NDQ2NjkxYWZhNDgy
OWZlMWE5ZDdiNjU2MjA0ZjExCj4gCj4gImlvbW11L3JvY2tjaGlwOiBSZWNvbnN0cnVjdCB0byBz
dXBwb3J0IG11bHRpIHNsYXZlcwo+ICAgICAgCj4gVGhlcmUgYXJlIHNvbWUgSVBzLCBzdWNoIGFz
IHZpZGVvIGVuY29kZXIvZGVjb2RlciwgY29udGFpbnMgMiBzbGF2ZSBpb21tdXMsCj4gb25lIGZv
ciByZWFkaW5nIGFuZCB0aGUgb3RoZXIgZm9yIHdyaXRpbmcuIFRoZXkgc2hhcmUgdGhlIHNhbWUg
aXJxIGFuZAo+IGNsb2NrIHdpdGggbWFzdGVyLgo+ICAgICAgCj4gVGhpcyBwYXRjaCByZWNvbnN0
cnVjdHMgdG8gc3VwcG9ydCB0aGlzIGNhc2UgYnkgbWFraW5nIHRoZW0gc2hhcmUgdGhlIHNhbWUK
PiBQYWdlIERpcmVjdG9yeSwgUGFnZSBUYWJsZXMgYW5kIGV2ZW4gdGhlIHJlZ2lzdGVyIG9wZXJh
dGlvbnMuCj4gVGhhdCBtZWFucyBldmVyeSBpbnN0cnVjdGlvbiB0byB0aGUgcmVhZGluZyBNTVUg
cmVnaXN0ZXJzIHdvdWxkIGJlCj4gZHVwbGljYXRlZCB0byB0aGUgd3JpdGluZyBNTVUgYW5kIHZp
Y2UgdmVyc2EuIgoKUmlnaHQuIEluIHRoZW9yeSB3ZSAqY291bGQqIG1haW50YWluIGEgc2VwYXJh
dGUgcGFnZXRhYmxlIGZvciBlYWNoIElPTU1VIAppbnN0YW5jZSwgYnV0IGl0IHdvdWxkIGp1c3Qg
bGVhZCB0byBhIGxvYWQgb2YgY29tcGxleGl0eSBhbmQgb3ZlcmhlYWQuIApGb3IgYSBtYXAgcmVx
dWVzdCwgd2UnZCBoYXZlIHRvIGRvIGV4dHJhIHdvcmsgdG8gZGVjaWRlIHdoaWNoIHRhYmxlKHMp
IApuZWVkIG1vZGlmeWluZywgYW5kIGR1cGxpY2F0ZSBhbGwgdGhlIHdvcmsgb2YgdGhlIGFjdHVh
bCBtYXBwaW5nIGlmIGl0J3MgCm1vcmUgdGhhbiBvbmUuIEZvciBhbiB1bm1hcCByZXF1ZXN0LCB3
ZSdkIGhhdmUgbm8gY2hvaWNlIGJ1dCB0byB3YWxrIAoqYWxsKiB0aGUgdGFibGVzIGJhY2tpbmcg
dGhhdCBkb21haW4gdG8gZmlndXJlIG91dCB3aGljaCAoaWYgYW55KSAKYWN0dWFsbHkgaGFkIGl0
IG1hcHBlZCBpbiB0aGUgZmlyc3QgcGxhY2UuCgpHaXZlbiB0aGF0IHdlIGFscmVhZHkgaGF2ZSBk
aXN0aW5jdCByZWFkIGFuZCB3cml0ZSBwZXJtaXNzaW9ucyBmb3IgCm1hcHBpbmdzIHdpdGhpbiBh
IHNpbmdsZSB0YWJsZSwgdGhlcmUncyBub3QgZXZlbiBhbnkgZnVuY3Rpb25hbCBiZW5lZml0IAp0
aGF0IGNvdWxkIGJlIGdhaW5lZCBpbiB0aGlzIGNhc2UgKGFuZCBpbiB0aGUgbW9yZSBnZW5lcmFs
IGNhc2Ugd2hlcmUgCnRoZSBkZXZpY2UgbWlnaHQgZW1pdCBhbGwga2luZHMgb2YgdHJhbnNhY3Rp
b25zIGZyb20gYWxsIGl0cyBpbnRlcmZhY2VzIAp5b3UnZCBoYXZlIHRvIG1haW50YWluIGlkZW50
aWNhbCBtYXBwaW5ncyBmb3IgYWxsIGl0cyBJT01NVXMgYW55d2F5KS4gClNhdmluZyBtZW1vcnkg
YW5kIGNvZGUgY29tcGxleGl0eSBieSBwaHlzaWNhbGx5IHNoYXJpbmcgb25lIHBhZ2V0YWJsZSAK
YW5kIG5vdCB3b3JyeWluZyBhYm91dCB0cnlpbmcgdG8gZG8gc2VsZWN0aXZlIFRMQiBtYWludGVu
YW5jZSBpcyBhIApiaWdnZXIgd2luIHRoYW4gYW55dGhpbmcgZWxzZSBjb3VsZCBiZS4KClJvYmlu
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
