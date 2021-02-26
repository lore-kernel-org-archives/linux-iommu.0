Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20FAC433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 21:44:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9887864F1F
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 21:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9887864F1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4118E8439B;
	Fri, 26 Feb 2021 21:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1gCpQNzCwcx5; Fri, 26 Feb 2021 21:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B042B8439C;
	Fri, 26 Feb 2021 21:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D50DC000A;
	Fri, 26 Feb 2021 21:44:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B10E5C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89FBB4F0C4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sl-jhzeuQL64 for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 21:44:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E6454F0C2
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:44:12 +0000 (UTC)
Received: from [192.168.0.5] (ip5f5aed0c.dynamic.kabel-deutschland.de
 [95.90.237.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 527DD20647910;
 Fri, 26 Feb 2021 22:44:09 +0100 (CET)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To: Alexander Monakov <amonakov@ispras.ru>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
 <c0f9f676-eff8-572d-9174-4c22c6095a3d@linuxfoundation.org>
 <alpine.LNX.2.20.13.2006030935570.3181@monopod.intra.ispras.ru>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <4aba4c61-1878-3d4e-d52e-3ccac9715010@molgen.mpg.de>
Date: Fri, 26 Feb 2021 22:44:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2006030935570.3181@monopod.intra.ispras.ru>
Content-Language: en-US
Cc: David Coe <david.coe@live.co.uk>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, "Tj \(Elloe Linux\)" <ml.linux@elloe.vision>
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

W2NjOiArc3VyYXZlZSwgK2rDtnJnXQoKRGVhciBBbGV4LCBkZWFyIFNodWFoLCBkZWFyIFN1cmF2
ZWUsIGRlYXIgSsO2cmcsCgoKQW0gMDMuMDYuMjAgdW0gMDg6NTQgc2NocmllYiBBbGV4YW5kZXIg
TW9uYWtvdjoKPiBPbiBUdWUsIDIgSnVuIDIwMjAsIFNodWFoIEtoYW4gd3JvdGU6Cj4gCj4+IEkg
Y2hhbmdlZCB0aGUgbG9naWMgdG8gcmVhZCBjb25maWcgdG8gZ2V0IG1heCBiYW5rcyBhbmQgY291
bnRlcnMKPj4gYmVmb3JlIGNoZWNraW5nIGlmIGNvdW50ZXJzIGFyZSB3cml0YWJsZSBhbmQgdHJp
ZWQgd3JpdGluZyB0byBhbGwuCj4+IFRoZSByZXN1bHQgaXMgdGhlIHNhbWUgYW5kIGFsbCBvZiB0
aGVtIGFyZW4ndCB3cml0YWJsZS4gSG93ZXZlciwKPj4gd2hlbiBkaXNhYmxlIHRoZSB3cml0YWJs
ZSBjaGVjayBhbmQgYXNzdW1lIHRoZXkgYXJlLCBJIGNhbiBydW4KPiBbc25pcF0KPiAKPiBUaGlz
IGlzIHNpbWlsYXIgdG8gd2hhdCBJIGRpZC4gSSBhbHNvIG5vdGljZWQgdGhhdCBjb3VudGVycyBj
YW4KPiBiZSBzdWNjZXNzZnVsbHkgdXNlZCB3aXRoIHBlcmYgaWYgdGhlIGluaXRpYWwgY2hlY2sg
aXMgaWdub3JlZC4KPiBJIHdhcyBjb25zaWRlcmluZyBzZW5kaW5nIGEgcGF0Y2ggdG8gcmVtb3Zl
IHRoZSBjaGVjayBhbmQgYWRqdXN0Cj4gdGhlIGV2ZW50IGNvdW50aW5nIGxvZ2ljIHRvIHVzZSBj
b3VudGVycyBhcyByZWFkLW9ubHksIGJ1dCBhZnRlcgo+IGEgYml0IG1vcmUgaW52ZXN0aWdhdGlv
biBJJ3ZlIG5vdGljZWQgaG93IGxhdGUgcGNpX2VuYWJsZV9kZXZpY2UKPiBpcyBkb25lLCBhbmQg
Y2FtZSB1cCB3aXRoIHRoaXMgcGF0Y2guIEl0J3MgYSBwYXRoIG9mIGxlc3MgcmVzaXN0YW5jZToK
PiBJJ2QgZXhwZWN0IG1haW50YWluZXJzIHRvIGJlIG1vcmUgYXZlcnNlIHRvIHJlbW92aW5nIHRo
ZSBjaGVjawo+IHJhdGhlciB0aGFuIGZpeGluZyBpdCBzbyBpdCB3b3JrcyBhcyBpbnRlbmRlZCAo
ZXZlbiB0aG91Z2ggSSB0aGluawo+IHRoZSBjaGVjayBzaG91bGQgbm90IGJlIHRoZXJlIGluIHRo
ZSBmaXJzdCBwbGFjZSkuCj4gCj4gSG93ZXZlcjoKPiAKPiBUaGUgYWJpbGl0eSB0byBtb2RpZnkg
dGhlIGNvdW50ZXJzIGlzIG5lZWRlZCBvbmx5IGZvciBzYW1wbGluZyB0aGUKPiBldmVudHMgKGdl
dHRpbmcgYW4gaW50ZXJydXB0IHdoZW4gYSBjb3VudGVyIG92ZXJmbG93cykuIFRoZXJlJ3Mgbm8K
PiBjb2RlIHRvIGRvIHRoYXQgZm9yIHRoZXNlIEFNRCBJT01NVSBjb3VudGVycy4gQSBzb2x1dGlv
biBJIHdvdWxkCj4gcHJlZmVyIGlzIHRvIG5vdCB3cml0ZSB0byB0aG9zZSBjb3VudGVycyBhdCBh
bGwuIEl0IHdvdWxkIHNpbXBsaWZ5IG9yCj4gZXZlbiByZW1vdmUgYSBidW5jaCBvZiBjb2RlLiBJ
IGNhbiBzdWJtaXQgYSBjb3JyZXNwb25kaW5nIHBhdGNoIGlmCj4gdGhlcmUncyBnZW5lcmFsIGFn
cmVlbWVudCB0aGlzIHBhdGggaXMgb2suCj4gCj4gV2hhdCBkbyB5b3UgdGhpbms/CgpJIGxpa2Ug
dGhpcyBpZGVhLiBTdXJhdmVlLCBKw7ZyZywgd2hhdCBkbyB5b3UgdGhpbms/CgpDb21taXQgNjc3
OGZmNWIyMWIgKGlvbW11L2FtZDogRml4IHBlcmZvcm1hbmNlIGNvdW50ZXIgaW5pdGlhbGl6YXRp
b24pIApkZWxheXMgdGhlIGJvb3QgdXAgdG8gMTAwIG1zLCB3aGljaCBpcyBvdmVyIDIwICUgb24g
ZmFzdCBzeXN0ZW1zLCBhbmQgCmFsc28ganVzdCBhIHdvcmthcm91bmQsIGFuZCBkb2VzIG5vdCBz
ZWVtIHRvIHdvcmsgYWx3YXlzLiBUaGUgZGVsYXkgaXMgCmFsc28gbm90IG1lbnRpb25lZCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UuCgoKS2luZCByZWdhcmRzLAoKUGF1bAoKClsxXTogCmh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC9jb21taXQvP2lkPTY3NzhmZjViMjFiZDhlNzhjOGJkNTQ3ZmQ2NjQzN2NmMjY1N2ZkOWIKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
