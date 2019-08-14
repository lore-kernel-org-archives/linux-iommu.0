Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330A3C32753
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 08:56:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECDB205F4
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 08:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECDB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D7287C6A;
	Wed, 14 Aug 2019 08:56:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 15544C51
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 08:56:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9773DCF
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 08:56:01 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 2F9242E2; Wed, 14 Aug 2019 10:55:59 +0200 (CEST)
Date: Wed, 14 Aug 2019 10:55:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge
	systems
Message-ID: <20190814085557.GB24321@8bytes.org>
References: <20190808101707.16783-1-kai.heng.feng@canonical.com>
	<20190809153931.GG12930@8bytes.org>
	<9CDD544D-DE4C-4AC6-B0DC-CD30C99EA71C@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9CDD544D-DE4C-4AC6-B0DC-CD30C99EA71C@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gVHVlLCBBdWcgMTMsIDIwMTkgYXQgMTE6NTg6NDhBTSArMDgwMCwgS2FpLUhlbmcgRmVuZyB3
cm90ZToKPiBhdCAyMzozOSwgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+IHdyb3RlOgo+
IAo+ID4gT24gVGh1LCBBdWcgMDgsIDIwMTkgYXQgMDY6MTc6MDdQTSArMDgwMCwgS2FpLUhlbmcg
RmVuZyB3cm90ZToKPiA+ID4gUmF2ZW4gUmlkZ2Ugc3lzdGVtcyBtYXkgaGF2ZSBtYWxmdW5jdGlv
biB0b3VjaHBhZCBvciBoYW5nIGF0IGJvb3QgaWYKPiA+ID4gaW5jb3JyZWN0IElWUlMgSU9BUElD
IGlzIHByb3ZpZGVkIGJ5IEJJT1MuCj4gPiA+IAo+ID4gPiBVc2VycyBhbHJlYWR5IGZvdW5kIGNv
cnJlY3QgIml2cnNfaW9hcGljPSIgdmFsdWVzLCBsZXQncyBwdXQgdGhlbSBpbnNpZGUKPiA+ID4g
a2VybmVsIHRvIHdvcmthcm91bmQgYnVnZ3kgQklPUy4KPiA+IAo+ID4gV2lsbCB0aGF0IHN0aWxs
IHdvcmsgd2hlbiBhIGZpeGVkIEJJT1MgZm9yIHRoZXNlIGxhcHRvcHMgaXMgcmVsZWFzZWQ/Cj4g
Cj4gRG8geW91IG1lYW4gdGhhdCB3ZSBzaG91bGQgc3RvcCBhcHBseWluZyB0aGVzZSBxdWlya3Mg
b25jZSBhIEJJT1MgZml4IGlzCj4gY29uZmlybWVkPwoKTXkgY29uY2VybiBpcyBqdXN0IHRoYXQg
dGhlc2UgcXVpcmtzIGJyZWFrIHNvbWUgc3lzdGVtcyB0aGF0IGRvbid0IG5lZWQKdGhlbS4KCj4g
V2UgY2FuIG1vZGlmeSB0aGUgcXVpcmsgdG8gY29tcGFyZSBCSU9TIHZlcnNpb24sIGlmIHRoZXJl
4oCZcyBhbiB1bmxpa2VseSBCSU9TCj4gdXBkYXRlIHJlYWxseSBmaXhlcyB0aGUgaXNzdWUuCj4g
QmVmb3JlIHRoYXQgaGFwcGVucywgSSB0aGluayBpdOKAmXMgT0sgdG8gbGV0IHRoZSBxdWlya3Mg
c3RheSB0aGlzIHdheS4KCkEgQklPUyB2ZXJzaW9uIGNoZWNrIGlzIG5vdCBtYWtpbmcgdGhpbmdz
IGJldHRlciBoZXJlIGFzIGl0IG1pZ2h0IGxvY2sKb3V0IHN5c3RlbXMgdGhhdCBuZWVkIHRoZSBx
dWlyay4gSSB0aGluayB3ZSBjYW4gbGVhdmUgaXQgYXMgaXQgZm9yIG5vdywKYnV0IGNhbiB5b3Ug
Y3JlYXRlIGEgbmV3IGZpbGUgYW1kX2lvbW11X3F1aXJrcy5jIGFuZCBtb3ZlIHRoZSBjb2RlCnRo
ZXJlLiBBbmQgaW4gdGhlIHN0cnVjdCBhbmQgZnVuY3Rpb24gbmFtZXMgcGxlYXNlIG1ha2UgY2xl
YXIgdGhhdCBpdCBpcwphYm91dCBpdnJzLXF1aXJrcy4KCgpSZWdhcmRzLAoKCUpvZXJnCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
