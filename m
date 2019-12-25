Return-Path: <SRS0=lUsJ=2P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AC0C2D0C3
	for <iommu@archiver.kernel.org>; Wed, 25 Dec 2019 02:38:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0755206CB
	for <iommu@archiver.kernel.org>; Wed, 25 Dec 2019 02:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0755206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 842A184542;
	Wed, 25 Dec 2019 02:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bn2j1_TquSgA; Wed, 25 Dec 2019 02:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CD3BA8453B;
	Wed, 25 Dec 2019 02:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1DE2C18DD;
	Wed, 25 Dec 2019 02:38:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB582C0881
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D009584789
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aIZwX4ws19za for <iommu@lists.linux-foundation.org>;
 Wed, 25 Dec 2019 02:38:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 00651847E6
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:38:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Dec 2019 18:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; d="scan'208";a="417703430"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga005.fm.intel.com with ESMTP; 24 Dec 2019 18:38:43 -0800
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSN?=
 =?UTF-8?Q?=3a_=5bPATCH=5d_iommu/vt-d=3a_Don=27t_reject_nvme_host_due_to_sco?=
 =?UTF-8?Q?pe_mismatch?=
To: "Jim,Yan" <jimyan@baidu.com>, Jerry Snitselaar <jsnitsel@redhat.com>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
 <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
 <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
 <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
 <062f5fd1611940b083ec34603eca94e1@baidu.com>
 <46d15bd6-4b50-d0cb-e0b8-763a808c4de8@linux.intel.com>
 <eccacec618c04a58be66809a541a95bf@baidu.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f5ceee32-4a21-a09c-1e1b-d3f0539ace4c@linux.intel.com>
Date: Wed, 25 Dec 2019 10:37:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <eccacec618c04a58be66809a541a95bf@baidu.com>
Content-Language: en-US
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

SGksCgpPbiAxMi8yNS8xOSAxMDowNSBBTSwgSmltLFlhbiB3cm90ZToKPiBIaSwKPiAKPj4gLS0t
LS3pgq7ku7bljp/ku7YtLS0tLQo+PiDlj5Hku7bkuro6IEx1IEJhb2x1IFttYWlsdG86YmFvbHUu
bHVAbGludXguaW50ZWwuY29tXQo+PiDlj5HpgIHml7bpl7Q6IDIwMTnlubQxMuaciDI15pelIDEw
OjAxCj4+IOaUtuS7tuS6ujogSmltLFlhbiA8amlteWFuQGJhaWR1LmNvbT47IEplcnJ5IFNuaXRz
ZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+Cj4+IOaKhOmAgTogaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPj4g5Li76aKYOiBS
ZTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERv
bid0IHJlamVjdCBudm1lCj4+IGhvc3QgZHVlIHRvIHNjb3BlIG1pc21hdGNoCj4+Cj4+IEhpLAo+
Pgo+PiBPbiAyMDE5LzEyLzI1IDk6NTIsIEppbSxZYW4gd3JvdGU6Cj4+PiBIaSwKPj4+Cj4+Pj4g
LS0tLS3pgq7ku7bljp/ku7YtLS0tLQo+Pj4+IOWPkeS7tuS6ujogTHUgQmFvbHUgW21haWx0bzpi
YW9sdS5sdUBsaW51eC5pbnRlbC5jb21dCj4+Pj4g5Y+R6YCB5pe26Ze0OiAyMDE55bm0MTLmnIgy
NOaXpSAxOToyNwo+Pj4+IOaUtuS7tuS6ujogSmltLFlhbiA8amlteWFuQGJhaWR1LmNvbT47IEpl
cnJ5IFNuaXRzZWxhYXIKPj4+PiA8anNuaXRzZWxAcmVkaGF0LmNvbT4KPj4+PiDmioTpgIE6IGlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnCj4+Pj4g5Li76aKYOiBSZTog562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBpb21t
dS92dC1kOiBEb24ndCByZWplY3QgbnZtZSBob3N0Cj4+IGR1ZSB0bwo+Pj4+IHNjb3BlIG1pc21h
dGNoCj4+Pj4KPj4+PiBIaSwKPj4+Pgo+Pj4+IE9uIDIwMTkvMTIvMjQgMTY6MTgsIEppbSxZYW4g
d3JvdGU6Cj4+Pj4+Pj4+IEZvciBib3RoIGNhc2VzLCBhIHF1aXJrIGZsYWcgc2VlbXMgdG8gYmUg
bW9yZSByZWFzb25hYmxlLCBzbyB0aGF0Cj4+Pj4+Pj4+IHVucmVsYXRlZCBkZXZpY2VzIHdpbGwg
bm90IGJlIGltcGFjdGVkLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBCZXN0IHJlZ2FyZHMsCj4+Pj4+Pj4+
IGJhb2x1Cj4+Pj4+Pj4gSGkgQmFvbHUsCj4+Pj4+Pj4gCVRoYW5rcyBmb3IgeW91ciBhZHZpY2Uu
IEFuZCBJIG1vZGlmeSB0aGUgcGF0Y2ggYXMgZm9sbG93Lgo+Pj4+Pj4gSSBqdXN0IHBvc3RlZCBh
IHBhdGNoIGZvciBib3RoIE5URyBhbmQgTlZNRSBjYXNlcy4gQ2FuIHlvdSBwbGVhc2UKPj4+Pj4+
IHRha2UgYQo+Pj4+IGxvb2s/Cj4+Pj4+PiBEb2VzIGl0IHdvcmsgZm9yIHlvdT8KPj4+Pj4+Cj4+
Pj4+PiBCZXN0IHJlZ2FyZHMsCj4+Pj4+PiBiYW9sdQo+Pj4+Pj4KPj4+Pj4gSSBoYXZlIHRlc3Rl
ZCB5b3VyIHBhdGNoLiBJdCBkb2VzIHdvcmsgZm9yIG1lLiBCdXQgSSBwcmVmZXIgbXkKPj4+Pj4g
c2Vjb25kIHZlcnNpb24sCj4+Pj4gaXQgaXMgbW9yZSBmbGV4aWJsZSwgYW5kIG1heSB1c2UgZm9y
IHNpbWlsYXIgdW5rbm93biBkZXZpY2VzLgo+Pj4+Pgo+Pj4+Cj4+Pj4gSSBkaWRuJ3QgZ2V0IHlv
dXIgcG9pbnQuIERvIHlvdSBtaW5kIGV4cGxhaW5pbmcgd2h5IGl0J3MgbW9yZSBmbGV4aWJsZT8K
Pj4+Pgo+Pj4+IEJlc3QgcmVnYXJkcywKPj4+PiBCYW9sdQo+Pj4gRm9yIGV4YW1wbGUsIGFuIHVu
a25vd24gZGV2aWNlIGhhcyBhIG5vcm1hbCBQQ0kgaGVhZGVyIGFuZCBicmlkZ2Ugc2NvcGUKPj4g
YW5kIGEgY2xhc3Mgb2YgUENJX0NMQVNTX0JSSURHRV9QQ0kuCj4+PiBUaGVzZSBkZXZpY2VzIGRv
IGhhdmUgYSBjbGFzcyBvZiBQQ0lfQkFTRV9DTEFTU19CUklER0UgaW4gY29tbW9uLgo+Pgo+PiBU
aGlzIGlzIG5vdCBhIGNvbW1vbiBjYXNlLiBJdCdzIG9ubHkgZm9yIGRldmljZXMgb24gdGhlIG1h
cmtldGluZyBhbmQgaGFyZCBmb3IKPj4gdGhlIFZULWQgdXNlcnMgdG8gZ2V0IGl0IGZpeGVkIGlu
IHRoZSBPRU0gZmlybXdhcmUuCj4+Cj4+IEJlc3QgcmVnYXJkcywKPj4gQmFvbHUKPiAKPiBHb3Qg
aXQuIFRoZW4gSSBhbSBPSyB3aXRoIHRoaXMgcGF0Y2guIEkgaGF2ZSB0ZXN0ZWQgaXQgeWVzdGVy
ZGF5LiBJdCBkb2VzIHdvcmsgZm9yIG1lLgo+IFRoYW5rcy4KCkNhbiBJIGFkZCB5b3VyIFRlc3Rl
ZC1ieT8KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
