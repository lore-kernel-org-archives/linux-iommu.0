Return-Path: <SRS0=DkpR=AJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DBC433E2
	for <iommu@archiver.kernel.org>; Sun, 28 Jun 2020 17:16:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39BB20768
	for <iommu@archiver.kernel.org>; Sun, 28 Jun 2020 17:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39BB20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A4F0E88091;
	Sun, 28 Jun 2020 17:16:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 92BjXmBDh9Yy; Sun, 28 Jun 2020 17:16:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B9ACE87DBA;
	Sun, 28 Jun 2020 17:16:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7CA3C0865;
	Sun, 28 Jun 2020 17:16:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8A1BC016E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 17:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9201120411
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 17:16:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7BxbiljVehE1 for <iommu@lists.linux-foundation.org>;
 Sun, 28 Jun 2020 17:16:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 1BD28203F2
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 17:16:40 +0000 (UTC)
IronPort-SDR: czluCaUcjDoB/XkL0nY0WOotfX2Kv1xEaWSpe35XIVfWA5CGfKTsGa2EwITuOA7ca+KS+pbEgN
 /2V+s6fKX81A==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147404173"
X-IronPort-AV: E=Sophos;i="5.75,291,1589266800"; d="scan'208";a="147404173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2020 10:16:38 -0700
IronPort-SDR: s/CaFswzkV9uLr+zFxqweD+BHz4N478o0Avg93xSnrVl+Mvwb54GAnFPN8KiQhUTMFnXdTGpBB
 1JKO8wlMnqdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,291,1589266800"; d="scan'208";a="453934416"
Received: from unknown (HELO btopel-mobl.ger.intel.com) ([10.252.54.42])
 by orsmga005.jf.intel.com with ESMTP; 28 Jun 2020 10:16:34 -0700
Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
To: Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
Date: Sun, 28 Jun 2020 19:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627070406.GB11854@lst.de>
Content-Language: en-US
Cc: maximmi@mellanox.com, konrad.wilk@oracle.com, jonathan.lemon@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 magnus.karlsson@intel.com
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

Ck9uIDIwMjAtMDYtMjcgMDk6MDQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFNhdCwg
SnVuIDI3LCAyMDIwIGF0IDAxOjAwOjE5QU0gKzAyMDAsIERhbmllbCBCb3JrbWFubiB3cm90ZToK
Pj4gR2l2ZW4gdGhlcmUgaXMgcm91Z2hseSBhIH41IHdlZWtzIHdpbmRvdyBhdCBtYXggd2hlcmUg
dGhpcyByZW1vdmFsIGNvdWxkCj4+IHN0aWxsIGJlIGFwcGxpZWQgaW4gdGhlIHdvcnN0IGNhc2Us
IGNvdWxkIHdlIGNvbWUgdXAgd2l0aCBhIGZpeCAvIHByb3Bvc2FsCj4+IGZpcnN0IHRoYXQgbW92
ZXMgdGhpcyBpbnRvIHRoZSBETUEgbWFwcGluZyBjb3JlPyBJZiB0aGVyZSBpcyBzb21ldGhpbmcg
dGhhdAo+PiBjYW4gYmUgYWdyZWVkIHVwb24gYnkgYWxsIHBhcnRpZXMsIHRoZW4gd2UgY291bGQg
YXZvaWQgcmUtYWRkaW5nIHRoZSA5JQo+PiBzbG93ZG93bi4gOi8KPiAKPiBJJ2QgcmF0aGVyIHR1
cm4gaXQgdXBzaWRlIGRvd24gLSB0aGlzIGFidXNlIG9mIHRoZSBpbnRlcm5hbHMgYmxvY2tzIHdv
cmsKPiB0aGF0IGhhcyBiYXNpY2FsbHkganVzdCBtaXNzZWQgdGhlIHByZXZpb3VzIHdpbmRvdyBh
bmQgSSdtIG5vdCBnb2luZwo+IHRvIHdhaXQgd2Vla3MgdG8gc29ydCBvdXQgdGhlIEFQSSBtaXN1
c2UuICBCdXQgd2UgY2FuIGFkZCBvcHRpbWl6YXRpb25zCj4gYmFjayBsYXRlciBpZiB3ZSBmaW5k
IGEgc2FuZSB3YXkuCj4KCkknbSBub3Qgc3VwZXIgZXhjaXRlZCBhYm91dCB0aGUgcGVyZm9ybWFu
Y2UgbG9zcywgYnV0IEkgZG8gZ2V0CkNocmlzdG9waCdzIGZydXN0cmF0aW9uIGFib3V0IGd1dHRp
bmcgdGhlIERNQSBBUEkgbWFraW5nIGl0IGhhcmRlciBmb3IKRE1BIHBlb3BsZSB0byBnZXQgd29y
ayBkb25lLiBMZXRzIHRyeSB0byBzb2x2ZSB0aGlzIHByb3Blcmx5IHVzaW5nCnByb3BlciBETUEg
QVBJcy4KCgo+IFRoYXQgYmVpbmcgc2FpZCBJIHJlYWxseSBjYW4ndCBzZWUgaG93IHRoaXMgd291
bGQgbWFrZSBzbyBtdWNoIG9mIGEKPiBkaWZmZXJlbmNlLiAgV2hhdCBhcmNoaXRlY3R1cmUgYW5k
IHdoYXQgZG1hX29wcyBhcmUgeW91IHVzaW5nIGZvcgo+IHRob3NlIG1lYXN1cmVtZW50cz8gIFdo
YXQgaXMgdGhlIHdvcmtsb2FkPwo+IAoKVGhlIDklIGlzIGZvciBhbiBBRl9YRFAgKEZhc3QgcmF3
IEV0aGVybmV0IHNvY2tldC4gVGhpbmsgQUZfUEFDS0VULCBidXQgCmZhc3Rlci4pIGJlbmNobWFy
azogcmVjZWl2ZSB0aGUgcGFja2V0IGZyb20gdGhlIE5JQywgYW5kIGRyb3AgaXQuIFRoZSAKRE1B
IHN5bmNzIHN0YW5kIG91dCBpbiB0aGUgcGVyZiB0b3A6CgogICAyOC42MyUgIFtrZXJuZWxdICAg
ICAgICAgICAgICAgICAgIFtrXSBpNDBlX2NsZWFuX3J4X2lycV96YwogICAxNy4xMiUgIFtrZXJu
ZWxdICAgICAgICAgICAgICAgICAgIFtrXSB4cF9hbGxvYwogICAgOC44MCUgIFtrZXJuZWxdICAg
ICAgICAgICAgICAgICAgIFtrXSBfX3hza19yY3ZfemMKICAgIDcuNjklICBba2VybmVsXSAgICAg
ICAgICAgICAgICAgICBba10geGRwX2RvX3JlZGlyZWN0CiAgICA1LjM1JSAgYnBmX3Byb2dfOTky
ZDlkZGM4MzVlNTYyOSAgW2tdIGJwZl9wcm9nXzk5MmQ5ZGRjODM1ZTU2MjkKICAgIDQuNzclICBb
a2VybmVsXSAgICAgICAgICAgICAgICAgICBba10geHNrX3Jjdi5wYXJ0LjAKICAgIDQuMDclICBb
a2VybmVsXSAgICAgICAgICAgICAgICAgICBba10gX194c2tfbWFwX3JlZGlyZWN0CiAgICAzLjgw
JSAgW2tlcm5lbF0gICAgICAgICAgICAgICAgICAgW2tdIGRtYV9kaXJlY3Rfc3luY19zaW5nbGVf
Zm9yX2NwdQogICAgMy4wMyUgIFtrZXJuZWxdICAgICAgICAgICAgICAgICAgIFtrXSBkbWFfZGly
ZWN0X3N5bmNfc2luZ2xlX2Zvcl9kZXZpY2UKICAgIDIuNzYlICBba2VybmVsXSAgICAgICAgICAg
ICAgICAgICBba10gaTQwZV9hbGxvY19yeF9idWZmZXJzX3pjCiAgICAxLjgzJSAgW2tlcm5lbF0g
ICAgICAgICAgICAgICAgICAgW2tdIHhza19mbHVzaAouLi4KCkZvciB0aGlzIGJlbmNobWFyayB0
aGUgZG1hX29wcyBhcmUgTlVMTCAoZG1hX2lzX2RpcmVjdCgpID09IHRydWUpLCBhbmQKdGhlIG1h
aW4gaXNzdWUgaXMgdGhhdCBTV0lPVExCIGlzIG5vdyB1bmNvbmRpdGlvbmFsbHkgZW5hYmxlZCBb
MV0gZm9yCng4NiwgYW5kIGZvciBlYWNoIHN5bmMgd2UgaGF2ZSB0byBjaGVjayB0aGF0IGlmIGlz
X3N3aW90bGJfYnVmZmVyKCkKd2hpY2ggaW52b2x2ZXMgYSBzb21lIGNvc3RseSBpbmRpcmVjdGlv
bi4KClRoYXQgd2FzIHByZXR0eSBtdWNoIHdoYXQgbXkgaGFjayBhdm9pZGVkLiBJbnN0ZWFkIHdl
IGRpZCBhbGwgdGhlIGNoZWNrcwp1cGZyb250LCBzaW5jZSBBRl9YRFAgaGFzIGxvbmctdGVybSBE
TUEgbWFwcGluZ3MsIGFuZCBqdXN0IHNldCBhIGZsYWcKZm9yIHRoYXQuCgpBdm9pZGluZyB0aGUg
d2hvbGUgImlzIHRoaXMgYWRkcmVzcyBzd2lvdGxiIiBpbgpkbWFfZGlyZWN0X3N5bmNfc2luZ2xl
X2Zvcl97Y3B1LCBkZXZpY2VdKCkgcGVyLXBhY2tldAp3b3VsZCBoZWxwIGEgbG90LgoKU29tZXdo
YXQgcmVsYXRlZCB0byB0aGUgRE1BIEFQSTsgSXQgd291bGQgaGF2ZSBwZXJmb3JtYW5jZSBiZW5l
Zml0cyBmb3IKQUZfWERQIGlmIHRoZSBETUEgcmFuZ2Ugb2YgdGhlIG1hcHBlZCBtZW1vcnkgd2Fz
IGxpbmVhciwgaS5lLiBieSBJT01NVQp1dGlsaXphdGlvbi4gSSd2ZSBzdGFydGVkIGhhY2tpbmcg
YSB0aGluZyBhIGxpdHRsZSBiaXQsIGJ1dCBpdCB3b3VsZCBiZQpuaWNlIGlmIHN1Y2ggQVBJIHdh
cyBwYXJ0IG9mIHRoZSBtYXBwaW5nIGNvcmUuCgpJbnB1dDogYXJyYXkgb2YgcGFnZXMgT3V0cHV0
OiBhcnJheSBvZiBkbWEgYWRkcnMgKGFuZCBvYnZpb3VzbHkgZGV2LApmbGFncyBhbmQgc3VjaCkK
CkZvciBub24tSU9NTVUgbGVuKGFycmF5IG9mIHBhZ2VzKSA9PSBsZW4oYXJyYXkgb2YgZG1hIGFk
ZHJzKQpGb3IgYmVzdC1jYXNlIElPTU1VIGxlbihhcnJheSBvZiBkbWEgYWRkcnMpID09IDEgKGxh
cmdlIGxpbmVhciBzcGFjZSkKCkJ1dCB0aGF0J3MgZm9yIGxhdGVyLiA6LSkKCgpCasO2cm4KCgpb
MV0gY29tbWl0OiAwOTIzMGNiYzFiYWIgKCJzd2lvdGxiOiBtb3ZlIHRoZSBTV0lPVExCIGNvbmZp
ZyBzeW1ib2wgdG8gCmxpYi9LY29uZmlnIikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
