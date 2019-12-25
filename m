Return-Path: <SRS0=lUsJ=2P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F80C2D0C3
	for <iommu@archiver.kernel.org>; Wed, 25 Dec 2019 02:01:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C272063A
	for <iommu@archiver.kernel.org>; Wed, 25 Dec 2019 02:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C272063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 949A084AE3;
	Wed, 25 Dec 2019 02:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PROWPBOs86M5; Wed, 25 Dec 2019 02:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 881A584607;
	Wed, 25 Dec 2019 02:01:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 644C1C1D80;
	Wed, 25 Dec 2019 02:01:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FE91C0881
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 384F28462A
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UtAK4LXtpV7z for <iommu@lists.linux-foundation.org>;
 Wed, 25 Dec 2019 02:00:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 805A1845D9
 for <iommu@lists.linux-foundation.org>; Wed, 25 Dec 2019 02:00:57 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Dec 2019 18:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; d="scan'208";a="223323252"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.115])
 ([10.254.214.115])
 by fmsmga001.fm.intel.com with ESMTP; 24 Dec 2019 18:00:55 -0800
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENI?=
 =?UTF-8?Q?=5d_iommu/vt-d=3a_Don=27t_reject_nvme_host_due_to_scope_mismatch?=
To: "Jim,Yan" <jimyan@baidu.com>, Jerry Snitselaar <jsnitsel@redhat.com>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
 <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
 <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
 <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
 <062f5fd1611940b083ec34603eca94e1@baidu.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <46d15bd6-4b50-d0cb-e0b8-763a808c4de8@linux.intel.com>
Date: Wed, 25 Dec 2019 10:00:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <062f5fd1611940b083ec34603eca94e1@baidu.com>
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

SGksCgpPbiAyMDE5LzEyLzI1IDk6NTIsIEppbSxZYW4gd3JvdGU6Cj4gSGksCj4gCj4+IC0tLS0t
6YKu5Lu25Y6f5Lu2LS0tLS0KPj4g5Y+R5Lu25Lq6OiBMdSBCYW9sdSBbbWFpbHRvOmJhb2x1Lmx1
QGxpbnV4LmludGVsLmNvbV0KPj4g5Y+R6YCB5pe26Ze0OiAyMDE55bm0MTLmnIgyNOaXpSAxOToy
Nwo+PiDmlLbku7bkuro6IEppbSxZYW4gPGppbXlhbkBiYWlkdS5jb20+OyBKZXJyeSBTbml0c2Vs
YWFyIDxqc25pdHNlbEByZWRoYXQuY29tPgo+PiDmioTpgIE6IGlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4+IOS4u+mimDogUmU6
IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRDSF0gaW9tbXUvdnQtZDogRG9uJ3QgcmVqZWN0
IG52bWUgaG9zdCBkdWUKPj4gdG8gc2NvcGUgbWlzbWF0Y2gKPj4KPj4gSGksCj4+Cj4+IE9uIDIw
MTkvMTIvMjQgMTY6MTgsIEppbSxZYW4gd3JvdGU6Cj4+Pj4+PiBGb3IgYm90aCBjYXNlcywgYSBx
dWlyayBmbGFnIHNlZW1zIHRvIGJlIG1vcmUgcmVhc29uYWJsZSwgc28gdGhhdAo+Pj4+Pj4gdW5y
ZWxhdGVkIGRldmljZXMgd2lsbCBub3QgYmUgaW1wYWN0ZWQuCj4+Pj4+Pgo+Pj4+Pj4gQmVzdCBy
ZWdhcmRzLAo+Pj4+Pj4gYmFvbHUKPj4+Pj4gSGkgQmFvbHUsCj4+Pj4+IAlUaGFua3MgZm9yIHlv
dXIgYWR2aWNlLiBBbmQgSSBtb2RpZnkgdGhlIHBhdGNoIGFzIGZvbGxvdy4KPj4+PiBJIGp1c3Qg
cG9zdGVkIGEgcGF0Y2ggZm9yIGJvdGggTlRHIGFuZCBOVk1FIGNhc2VzLiBDYW4geW91IHBsZWFz
ZSB0YWtlIGEKPj4gbG9vaz8KPj4+PiBEb2VzIGl0IHdvcmsgZm9yIHlvdT8KPj4+Pgo+Pj4+IEJl
c3QgcmVnYXJkcywKPj4+PiBiYW9sdQo+Pj4+Cj4+PiBJIGhhdmUgdGVzdGVkIHlvdXIgcGF0Y2gu
IEl0IGRvZXMgd29yayBmb3IgbWUuIEJ1dCBJIHByZWZlciBteSBzZWNvbmQgdmVyc2lvbiwKPj4g
aXQgaXMgbW9yZSBmbGV4aWJsZSwgYW5kIG1heSB1c2UgZm9yIHNpbWlsYXIgdW5rbm93biBkZXZp
Y2VzLgo+Pj4KPj4KPj4gSSBkaWRuJ3QgZ2V0IHlvdXIgcG9pbnQuIERvIHlvdSBtaW5kIGV4cGxh
aW5pbmcgd2h5IGl0J3MgbW9yZSBmbGV4aWJsZT8KPj4KPj4gQmVzdCByZWdhcmRzLAo+PiBCYW9s
dQo+IEZvciBleGFtcGxlLCBhbiB1bmtub3duIGRldmljZSBoYXMgYSBub3JtYWwgUENJIGhlYWRl
ciBhbmQgYnJpZGdlIHNjb3BlIGFuZCBhIGNsYXNzIG9mIFBDSV9DTEFTU19CUklER0VfUENJLgo+
IFRoZXNlIGRldmljZXMgZG8gaGF2ZSBhIGNsYXNzIG9mIFBDSV9CQVNFX0NMQVNTX0JSSURHRSBp
biBjb21tb24uCgpUaGlzIGlzIG5vdCBhIGNvbW1vbiBjYXNlLiBJdCdzIG9ubHkgZm9yIGRldmlj
ZXMgb24gdGhlIG1hcmtldGluZyBhbmQKaGFyZCBmb3IgdGhlIFZULWQgdXNlcnMgdG8gZ2V0IGl0
IGZpeGVkIGluIHRoZSBPRU0gZmlybXdhcmUuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
