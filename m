Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA9C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:20:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7572964F2A
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7572964F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28E7B4ED7C;
	Thu, 18 Mar 2021 09:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cAwMr2-I3228; Thu, 18 Mar 2021 09:20:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D43834ED2C;
	Thu, 18 Mar 2021 09:20:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87E64C000A;
	Thu, 18 Mar 2021 09:20:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27BD7C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08F5B4309A
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TplbrtnyGfe for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 09:20:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1A2141566
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:20:19 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aea9f.dynamic.kabel-deutschland.de
 [95.90.234.159])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7AAEF2064AF11;
 Thu, 18 Mar 2021 10:20:16 +0100 (CET)
Subject: Re: [PATCH] Revert "iommu/amd: Fix performance counter initialization"
To: Alexander Monakov <amonakov@ispras.ru>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20210303121156.76621-1-pmenzel@molgen.mpg.de>
 <a803de32-eec8-a0b1-69e6-43259ba5c656@amd.com>
 <alpine.LNX.2.20.13.2103031648190.15170@monopod.intra.ispras.ru>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <0a910a80-5783-1f3d-a8ea-5e10cba0e206@molgen.mpg.de>
Date: Thu, 18 Mar 2021 10:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2103031648190.15170@monopod.intra.ispras.ru>
Content-Language: en-US
Cc: Sasha Levin <sashal@kernel.org>, David Coe <david.coe@live.co.uk>,
 Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Shuah Khan <skhan@linuxfoundation.org>,
 Tj <ml.linux@elloe.vision>
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

RGVhciBKw7ZyZywgZGVhciBTdXJhdmVlLAoKCkFtIDAzLjAzLjIxIHVtIDE1OjEwIHNjaHJpZWIg
QWxleGFuZGVyIE1vbmFrb3Y6Cj4gT24gV2VkLCAzIE1hciAyMDIxLCBTdXJhdmVlIFN1dGhpa3Vs
cGFuaXQgd3JvdGU6Cj4gCj4+PiBBZGRpdGlvbmFsbHksIGFsdGVybmF0aXZlIHByb3Bvc2VkIHNv
bHV0aW9ucyBbMV0gd2VyZSBub3QgY29uc2lkZXJlZCBvcgo+Pj4gZGlzY3Vzc2VkLgo+Pj4KPj4+
IFsxXTpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS9hbHBpbmUuTE5YLjIuMjAu
MTMuMjAwNjAzMDkzNTU3MC4zMTgxQG1vbm9wb2QuaW50cmEuaXNwcmFzLnJ1Lwo+Pgo+PiBUaGlz
IGNoZWNrIGhhcyBiZWVuIGludHJvZHVjZWQgZWFybHkgb24gdG8gZGV0ZWN0IGEgSFcgaXNzdWUg
Zm9yCj4+IGNlcnRhaW4gcGxhdGZvcm1zIGluIHRoZSBwYXN0LCB3aGVyZSB0aGUgcGVyZm9ybWFu
Y2UgY291bnRlcnMgYXJlIG5vdAo+PiBhY2Nlc3NpYmxlIGFuZCB3b3VsZCByZXN1bHQgaW4gc2ls
ZW50IGZhaWx1cmUgd2hlbiB0cnkgdG8gdXNlIHRoZQo+PiBjb3VudGVycy4gVGhpcyBpcyBjb25z
aWRlcmVkIGxlZ2FjeSBjb2RlLCBhbmQgY2FuIGJlIHJlbW92ZWQgaWYgd2UKPj4gZGVjaWRlIHRv
IG5vIGxvbmdlciBwcm92aWRlIHNhbml0eSBjaGVjayBmb3Igc3VjaCBjYXNlLgo+IAo+IFdoaWNo
IHBsYXRmb3Jtcz8gVGhlcmUgaXMgbm8gc3VjaCBpbmZvcm1hdGlvbiBpbiB0aGUgY29kZSBvciB0
aGUgY29tbWl0Cj4gbWVzc2FnZXMgdGhhdCBpbnRyb2R1Y2VkIHRoaXMuCj4gCj4gQWNjb3JkaW5n
IHRvIEFNRCdzIGRvY3VtZW50YXRpb24sIHByZXNlbmNlIG9mIHBlcmZvcm1hbmNlIGNvdW50ZXJz
IGlzCj4gaW5kaWNhdGVkIGJ5ICJQQ1N1cCIgYml0IGluIHRoZSAiRUZSIiByZWdpc3Rlci4gSSBk
b24ndCB0aGluayB0aGUgZHJpdmVyCj4gc2hvdWxkIHNlY29uZC1ndWVzcyB0aGF0LiBJZiB0aGVy
ZSB3ZXJlIHBsYXRmb3JtcyB3aGVyZSB0aGUgQ1BVIG9yIHRoZQo+IGZpcm13YXJlIGxpZWQgdG8g
dGhlIE9TIChFRlJbUENTdXBdIHdhcyAxLCBidXQgY291bnRlcnMgd2VyZSBub3QgcHJlc2VudCks
Cj4gSSB0aGluayB0aGF0IHNob3VsZCBoYXZlIGJlZW4gaGFuZGxlZCBpbiBhIG1vcmUgZXhwbGlj
aXQgbWFubmVyLCBlLmcuCj4gdmlhIG1hdGNoaW5nIGJyb2tlbiBDUFVzIGJ5IGNwdWlkLgoKU3Vy
YXZlZSwgY291bGQgeW91IHBsZWFzZSBhbnN3ZXIgdGhlIHF1ZXN0aW9ucz8KCkrDtnJnLCBJIGtu
b3cgeW91IGFyZSBwcm9iYWJseSBidXN5LCBidXQgdGhlIHBhdGNoIHdhcyBhcHBsaWVkIHRvIHRo
ZSAKc3RhYmxlIHNlcmllcyAodjUuMTEuNykuIFRoZXJlIGFyZSBzdGlsbCB0b28gbWFueSBxdWVz
dGlvbiBvcGVuIApyZWdhcmRpbmcgdGhlIHBhdGNoLCBhbmQgU3VyYXZlZSBoYXMgbm90IHlldCBh
ZGRyZXNzZWQgdGhlIGNvbW1lbnRzLiAKSXTigJlkIGJlIGdyZWF0LCBpZiB5b3UgY291bGQgcmV2
ZXJ0IGl0LgoKCktpbmQgcmVnYXJkcywKClBhdWwKCkNvdWxkIHlvdSBwbGVhc2UKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
