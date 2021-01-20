Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FEDC433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:04:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3914E233E2
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3914E233E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF7CB84AD2;
	Wed, 20 Jan 2021 17:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ijiSJnZDurfB; Wed, 20 Jan 2021 17:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05B4784A0B;
	Wed, 20 Jan 2021 17:04:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8A0AC088B;
	Wed, 20 Jan 2021 17:04:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB054C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C00E684A0B
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZKmqJvSPTm7W for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:04:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 538928495A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:04:20 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DBA72137B;
 Wed, 20 Jan 2021 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1611162260;
 bh=caeQFJb0TACo4Z1f02CFkwI8apxVCibwEWvBI0FGyGo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qQ34fOy1MEe1UULlEne1AghHIc2h2k1rm2puWnqYJDVOG/HJgEj7wdvNPP6HtKP16
 0W1Meby87U9oxd45rsd4o8tf/VQroGzb2HNVzxRWpj0iHTY1J+7oLlWVMPUZTHK7UU
 Q8493TR+gsuswXMl8dXq/9/bPnNiMDPPuatFR7bY=
Date: Wed, 20 Jan 2021 18:04:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] iommu/vt-d: gracefully handle DMAR units with no
 supported address widths
Message-ID: <YAhikV3sOsyRVDyh@kroah.com>
References: <549928db2de6532117f36c9c810373c14cf76f51.camel@infradead.org>
 <5414a3e3cdbd24ba707153584d13f06ed5dbba76.camel@infradead.org>
 <YAgc2MX2c2N/rGDM@kroah.com>
 <61f3f0a09f015707eb727109cf3a4d97d41e3675.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61f3f0a09f015707eb727109cf3a4d97d41e3675.camel@infradead.org>
Cc: "Mendoza-jonas, Samuel" <samjonas@amazon.com>, "Sironi,
 Filippo" <sironi@amazon.de>, stable@vger.kernel.org,
 iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>
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

T24gV2VkLCBKYW4gMjAsIDIwMjEgYXQgMDM6NTU6MDVQTSArMDAwMCwgRGF2aWQgV29vZGhvdXNl
IHdyb3RlOgo+IE9uIFdlZCwgMjAyMS0wMS0yMCBhdCAxMzowNiArMDEwMCwgR3JlZyBLSCB3cm90
ZToKPiA+IE9uIFdlZCwgSmFuIDIwLCAyMDIxIGF0IDA5OjQyOjQzQU0gKzAwMDAsIERhdmlkIFdv
b2Rob3VzZSB3cm90ZToKPiA+ID4gT24gVGh1LCAyMDIwLTA5LTI0IGF0IDE1OjA4ICswMTAwLCBE
YXZpZCBXb29kaG91c2Ugd3JvdGU6Cj4gPiA+ID4gRnJvbTogRGF2aWQgV29vZGhvdXNlIDxkd213
QGFtYXpvbi5jby51az4KPiA+ID4gPiAKPiA+ID4gPiBJbnN0ZWFkIG9mIGJhaWxpbmcgb3V0IGNv
bXBsZXRlbHksIHN1Y2ggYSB1bml0IGNhbiBzdGlsbCBiZSB1c2VkIGZvcgo+ID4gPiA+IGludGVy
cnVwdCByZW1hcHBpbmcuCj4gPiA+ID4gCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgV29v
ZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4KPiA+ID4gCj4gPiA+IENvdWxkIHdlIGhhdmUgdGhp
cyBmb3Igc3RhYmxlIHRvbyBwbGVhc2UsIGFsb25nIHdpdGggdGhlIHRyaXZpYWwKPiA+ID4gc3Vi
c2VxdWVudCBmaXh1cC4gVGhleSBhcmU6Cj4gPiA+IAo+ID4gPiBjNDBhYWFhYzEwMTggKCJpb21t
dS92dC1kOiBHcmFjZWZ1bGx5IGhhbmRsZSBETUFSIHVuaXRzIHdpdGggbm8gc3VwcG9ydGVkIGFk
ZHJlc3Mgd2lkdGhzIikKPiA+ID4gOWRlZjNiMWEwN2M0ICgiaW9tbXUvdnQtZDogRG9uJ3QgZGVy
ZWZlcmVuY2UgaW9tbXVfZGV2aWNlIGlmIElPTU1VX0FQSSBpcyBub3QgYnVpbHQiKQo+ID4gPiAK
PiA+ID4gVGhleSBhcHBseSBmYWlybHkgc3RyYWlnaHRmb3J3YXJkbHkgd2hlbiBiYWNrcG9ydGVk
OyBsZXQgbWUga25vdyBpZiB5b3UKPiA+ID4gd2FudCB1cyB0byBzZW5kIHBhdGNoZXMuCj4gPiAK
PiA+IFdoYXQgc3RhYmxlIGtlcm5lbChzKSBkbyB5b3Ugd2FudCB0aGlzIGluPyAgVGhlIGFib3Zl
IHBhdGNoZXMgYXJlCj4gPiBhbHJlYWR5IGluIDUuMTAuCj4gCj4gSXQncyBhIGZhaXJseSBzaW1w
bGUgYnVnIGZpeCwgdG8gc3RpbGwgdXNlIGEgZ2l2ZW4gSU9NTVUgZm9yIGludGVycnVwdAo+IHJl
bWFwcGluZyBldmVuIGlmIGl0IGNhbid0IGJlIHVzZWQgZm9yIERNQSBtYXBwaW5nLgo+IAo+IFRo
b3NlIGZlYXR1cmVzIGFyZSBzb21ld2hhdCBvcnRob2dvbmFsLCBhbmQgaXQgd2FzIHdyb25nIGZv
ciB0aGUga2VybmVsCj4gdG8gYmFpbCBvdXQgb24gdGhlIElPTU1VIGhhcmR3YXJlIGNvbXBsZXRl
bHkuCj4gCj4gVGhlIGludGVycnVwdCByZW1hcHBpbmcgc3VwcG9ydCBpcyB3aGF0J3MgcmVxdWly
ZWQgZm9yIEludGVsIGJveGVzIChvcgo+IFZNcykgdG8gcnVuIHdpdGggbW9yZSB0aGFuIDI1NSBD
UFVzLiBJdCBzaG91bGQgYmUgZmFpcmx5IHNpbXBsZSB0byBmaXgKPiB0aGUgc2FtZSBidWcgYXQg
bGVhc3QgYXMgZmFyIGJhY2sgYXMgNC4xNC4KCkkgdHJpZWQgYXBwbHlpbmcgdGhlc2UgdG8gNS40
LCA0LjE5LCBhbmQgNC4xNCwgYW5kIHRoZXkgYWxsIGZhaWwgdG8KYnVpbGQ6Cgpkcml2ZXJzL2lv
bW11L2RtYXIuYzogSW4gZnVuY3Rpb24g4oCYZnJlZV9pb21tdeKAmToKZHJpdmVycy9pb21tdS9k
bWFyLmM6MTE0MDozNTogZXJyb3I6IOKAmHN0cnVjdCBpbnRlbF9pb21tdeKAmSBoYXMgbm8gbWVt
YmVyIG5hbWVkIOKAmGRyaGTigJkKIDExNDAgfCAgaWYgKGludGVsX2lvbW11X2VuYWJsZWQgJiYg
IWlvbW11LT5kcmhkLT5pZ25vcmVkKSB7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5+CgpTbyBpZiB5b3UgY291bGQgcHJvdmlkZSBhIHdvcmtpbmcgc2V0IG9mIHBh
dGNoZXMgYmFja3BvcnRlZCwgSSB3aWxsIGJlCmdsYWQgdG8gcXVldWUgdGhlbSB1cC4KCnRoYW5r
cywKCmdyZWcgay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
