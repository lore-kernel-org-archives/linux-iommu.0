Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06493C4338F
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 06:43:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC6C60F35
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 06:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BC6C60F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BFD54062C;
	Wed,  4 Aug 2021 06:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zlgI8aCaT21V; Wed,  4 Aug 2021 06:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3555A40613;
	Wed,  4 Aug 2021 06:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 071F6C0010;
	Wed,  4 Aug 2021 06:43:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C3ADC000E;
 Wed,  4 Aug 2021 06:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6574F40178;
 Wed,  4 Aug 2021 06:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux.microsoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HpgX3CkjVExc; Wed,  4 Aug 2021 06:43:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0129C400FD;
 Wed,  4 Aug 2021 06:43:49 +0000 (UTC)
Received: from [192.168.1.87] (unknown [223.178.56.171])
 by linux.microsoft.com (Postfix) with ESMTPSA id DADCE209DD4A;
 Tue,  3 Aug 2021 23:43:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DADCE209DD4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1628059428;
 bh=V/XYsXsYVsA5Pb1ntrRBOWS6XD7DTF+fjpdIcug4aCw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Cj5PvOhjHeKFOHz1X1tSzo8ZfZqL0lX6n3/1G8fOiix2DXh/xdkddfTDhgC8RMhHF
 TmcseRM1Soe4Rl5V4AwJe3G+VYxGCWd+m1OGKZE0eu9IuOOMnhjHFjyw8iJh8rv0ZE
 oey+Badv593cyQMjtl0kxCnP/vyJ2Cb6aAGXneHo=
Subject: Re: [RFC v1 5/8] mshv: add paravirtualized IOMMU support
To: Wei Liu <wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-6-wei.liu@kernel.org>
 <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
 <20210803214718.hnp3ejs35lh455fw@liuwe-devbox-debian-v2>
From: Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <562f4c31-1ea5-ea56-ac0a-6bd80b61c3df@linux.microsoft.com>
Date: Wed, 4 Aug 2021 12:13:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803214718.hnp3ejs35lh455fw@liuwe-devbox-debian-v2>
Content-Language: en-US
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 Will Deacon <will@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
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

T24gMDQtMDgtMjAyMSAwMzoxNywgV2VpIExpdSB3cm90ZToKPj4+ICtzdGF0aWMgc2l6ZV90IGh2
X2lvbW11X3VubWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmQsIHVuc2lnbmVkIGxvbmcgaW92YSwK
Pj4+ICsJCQkgICBzaXplX3Qgc2l6ZSwgc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqZ2F0aGVy
KQo+Pj4gK3sKPj4+ICsJc2l6ZV90IHVubWFwcGVkOwo+Pj4gKwlzdHJ1Y3QgaHZfaW9tbXVfZG9t
YWluICpkb21haW4gPSB0b19odl9pb21tdV9kb21haW4oZCk7Cj4+PiArCXVuc2lnbmVkIGxvbmcg
ZmxhZ3MsIG5wYWdlczsKPj4+ICsJc3RydWN0IGh2X2lucHV0X3VubWFwX2RldmljZV9ncGFfcGFn
ZXMgKmlucHV0Owo+Pj4gKwl1NjQgc3RhdHVzOwo+Pj4gKwo+Pj4gKwl1bm1hcHBlZCA9IGh2X2lv
bW11X2RlbF9tYXBwaW5ncyhkb21haW4sIGlvdmEsIHNpemUpOwo+Pj4gKwlpZiAodW5tYXBwZWQg
PCBzaXplKQo+Pj4gKwkJcmV0dXJuIDA7Cj4+IElzIHRoZXJlIGEgY2FzZSB3aGVyZSB1bm1hcHBl
ZCA+IDAgJiYgdW5tYXBwZWQgPCBzaXplID8KPj4KPiBUaGVyZSBjb3VsZCBiZSBzdWNoIGEgY2Fz
ZSAtLSBodl9pb21tdV9kZWxfbWFwcGluZ3MnIHJldHVybiB2YWx1ZSBpcyA+PSAwLgo+IElzIHRo
ZXJlIGEgcHJvYmxlbSB3aXRoIHRoaXMgcHJlZGljYXRlPwoKV2hhdCBJIHVuZGVyc3RhbmQsIGlm
IHdlIGFyZSB1bm1hcHBpbmcgYW5kIHJldHVybiAwLCBtZWFucyBub3RoaW5nIHdhcyB1bm1hcHBl
ZCwgYW5kIHdpbGwgdGhhdCBub3QgY2F1c2UgYW55IGNvcnJ1cHRpb24gb3IgaWxsZWdhbCBhY2Nl
c3Mgb2YgdW5tYXBwZWQgbWVtb3J5IGxhdGVyPwpGcm9tIF9faW9tbXVfdW5tYXAKLi4uCiAgICAx
MyAgICAgICAgIHdoaWxlICh1bm1hcHBlZCA8IHNpemUpIHsKICAgIDEyICAgICAgICAgICAgICAg
ICBzaXplX3QgcGdzaXplID0gaW9tbXVfcGdzaXplKGRvbWFpbiwgaW92YSwgc2l6ZSAtIHVubWFw
cGVkKTsKICAgIDExCiAgICAxMCAgICAgICAgICAgICAgICAgdW5tYXBwZWRfcGFnZSA9IG9wcy0+
dW5tYXAoZG9tYWluLCBpb3ZhLCBwZ3NpemUsIGlvdGxiX2dhdGhlcik7CiAgICAgOSAgICAgICAg
ICAgICAgICAgaWYgKCF1bm1hcHBlZF9wYWdlKQogICAgIDggICAgICAgICAgICAgICAgICAgICAg
ICAgYnJlYWs7CQk8PDwgd2UganVzdCBicmVhayBoZXJlLCB0aGlua2luZyB0aGVyZSBpcyBub3Ro
aW5nIHVubWFwcGVkLCBidXQgYWN0dWFsbHkgaHZfaW9tbXVfZGVsX21hcHBpbmdzIGhhcyByZW1v
dmVkIHNvbWUgcGFnZXMuCiAgICAgNwogICAgIDYgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJ1
bm1hcHBlZDogaW92YSAweCVseCBzaXplIDB4JXp4XG4iLAogICAgIDUgICAgICAgICAgICAgICAg
ICAgICAgICAgwqZpb3ZhLCB1bm1hcHBlZF9wYWdlKTsKICAgICA0CiAgICAgMyAgICAgICAgICAg
ICAgICAgaW92YSArPSB1bm1hcHBlZF9wYWdlOwogICAgIDIgICAgICAgICAgICAgICAgIHVubWFw
cGVkICs9IHVubWFwcGVkX3BhZ2U7CiAgICAgMSAgICAgICAgIH0KLi4uCgpBbSBJIG1pc3Npbmcg
c29tZXRoaW5nID8KClJlZ2FyZHMsCgp+UHJhdmVlbi4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
