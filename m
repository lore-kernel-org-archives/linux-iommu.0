Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D1C2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 12:45:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B84A24653
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 12:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B84A24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 11E0F204DF;
	Tue, 21 Jan 2020 12:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6iXI4Znwn0y; Tue, 21 Jan 2020 12:45:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 55C502037A;
	Tue, 21 Jan 2020 12:45:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 388D7C0176;
	Tue, 21 Jan 2020 12:45:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4065EC0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 12:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2967783527
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 12:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0UxJs9YjD_zE for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 12:45:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E3848844FF
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 12:45:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370E730E;
 Tue, 21 Jan 2020 04:45:11 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3F8B3F6C4;
 Tue, 21 Jan 2020 04:45:09 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] iommu: Preallocate iommu group when probing
 devices
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
 <20200101052648.14295-4-baolu.lu@linux.intel.com>
 <20200117102151.GF15760@8bytes.org>
 <25e2e7fa-487c-f951-4b2c-27bac5e30815@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b721d3f7-6292-35d6-a9eb-154d3233dcc0@arm.com>
Date: Tue, 21 Jan 2020 12:45:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <25e2e7fa-487c-f951-4b2c-27bac5e30815@linux.intel.com>
Content-Language: en-GB
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
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

T24gMTkvMDEvMjAyMCA2OjI5IGFtLCBMdSBCYW9sdSB3cm90ZToKPiBIaSBKb2VyZywKPiAKPiBP
biAxLzE3LzIwIDY6MjEgUE0sIEpvZXJnIFJvZWRlbCB3cm90ZToKPj4gT24gV2VkLCBKYW4gMDEs
IDIwMjAgYXQgMDE6MjY6NDdQTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4+PiBUaGlzIHNwbGl0
cyBpb21tdSBncm91cCBhbGxvY2F0aW9uIGZyb20gYWRkaW5nIGRldmljZXMuIFRoaXMgbWFrZXMK
Pj4+IGl0IHBvc3NpYmxlIHRvIGRldGVybWluZSB0aGUgZGVmYXVsdCBkb21haW4gdHlwZSBmb3Ig
ZWFjaCBncm91cCBhcwo+Pj4gYWxsIGRldmljZXMgYmVsb25naW5nIHRvIHRoZSBncm91cCBoYXZl
IGJlZW4gZGV0ZXJtaW5lZC4KPj4KPj4gSSB0aGluayBpdHMgYmV0dGVyIHRvIGtlZXAgZ3JvdXAg
YWxsb2NhdGlvbiBhcyBpdCBpcyBhbmQganVzdCBkZWZlcgo+PiBkZWZhdWx0IGRvbWFpbiBhbGxv
Y2F0aW9uIGFmdGVyIGVhY2ggZGV2aWNlIGlzIGluIGl0cyBncm91cC4gQnV0IHRha2UKPiAKPiBJ
IHRyaWVkIGRlZmVyaW5nIGRlZmF1bHQgZG9tYWluIGFsbG9jYXRpb24sIGJ1dCBpdCBzZWVtcyBu
b3QgcG9zc2libGUuCj4gCj4gVGhlIGNhbGwgcGF0aCBvZiBhZGRpbmcgZGV2aWNlcyBpbnRvIHRo
ZWlyIGdyb3VwczoKPiAKPiBpb21tdV9wcm9iZV9kZXZpY2UKPiAtPiBvcHMtPmFkZF9kZXZpY2Uo
ZGV2KQo+ICDCoMKgIC0+IChpb21tdSB2ZW5kb3IgZHJpdmVyKSBpb21tdV9ncm91cF9nZXRfZm9y
X2RldihkZXYpCj4gCj4gQWZ0ZXIgZG9pbmcgdGhpcywgdGhlIHZlbmRvciBkcml2ZXIgd2lsbCBn
ZXQgdGhlIGRlZmF1bHQgZG9tYWluIGFuZAo+IGFwcGx5IGRtYV9vcHMgYWNjb3JkaW5nIHRvIHRo
ZSBkb21haW4gdHlwZS4gSWYgd2UgZGVmZXIgdGhlIGRvbWFpbgo+IGFsbG9jYXRpb24sIHRoZXkg
d2lsbCBnZXQgYSBOVUxMIGRlZmF1bHQgZG9tYWluIGFuZCBjYXVzZSBwYW5pYyBpbgo+IHRoZSB2
ZW5kb3IgZHJpdmVyLgo+IAo+IEFueSBzdWdnZXN0aW9ucz8KCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWlvbW11LzZkYmJmYzEwLTMyNDctNzQ0Yy1hZThkLTQ0M2EzMzZlMGM1MEBsaW51
eC5pbnRlbC5jb20vCgpIYXZlbid0IHdlIGJlZW4gaGVyZSBiZWZvcmU/IDspCgpTaW5jZSB3ZSBj
YW4ndCAoc2FmZWx5IG9yIHJlYXNvbmFibHkpIGNoYW5nZSBhIGdyb3VwJ3MgZGVmYXVsdCBkb21h
aW4gCmFmdGVyIG9wcy0+YWRkX2RldmljZSgpIGhhcyByZXR1cm5lZCwgYW5kIGluIGdlbmVyYWwg
aXQgZ2V0cyBpbXByYWN0aWNhbCAKdG8gZXZhbHVhdGUgImFsbCBkZXZpY2UgaW4gYSBncm91cCIg
b25jZSB5b3UgbG9vayBiZXlvbmQgJnBjaV9idXNfdHlwZSAKKG9yIGNvbnNpZGVyIGhvdHBsdWcg
YXMgbWVudGlvbmVkKSwgdGhlbiBBRkFJQ1MgdGhlcmUncyBubyByZWFzb25hYmxlIAp3YXkgdG8g
Z2V0IGF3YXkgZnJvbSB0aGUgZGVmYXVsdCBkb21haW4gdHlwZSBiZWluZyBkZWZpbmVkIGJ5IHRo
ZSBmaXJzdCAKZGV2aWNlIHRvIGF0dGFjaC4gQnV0IGluIHByYWN0aWNlIGl0J3MgaGFyZGx5IGEg
cHJvYmxlbSBhbnl3YXkgLSBpZiAKZXZlcnkgZGV2aWNlIGluIGEgZ2l2ZW4gZ3JvdXAgcmVxdWVz
dHMgdGhlIHNhbWUgZG9tYWluIHR5cGUgdGhlbiBpdCAKZG9lc24ndCBtYXR0ZXIgd2hpY2ggY29t
ZXMgZmlyc3QsIGFuZCBpZiB0aGV5IGRvbid0IHRoZW4gd2UgdWx0aW1hdGVseSAKZW5kIHVwIHdp
dGggYW4gaW1wb3NzaWJsZSBzZXQgb2YgY29uc3RyYWludHMsIHNvIGFyZSBkb29tZWQgdG8gZG8g
dGhlIAond3JvbmcnIHRoaW5nIHJlZ2FyZGxlc3MuCgpUaHVzIHVubGVzcyBhbnlvbmUgd2FudHMg
dG8gc3RhcnQgcmVkZWZpbmluZyB0aGUgd2hvbGUgZ3JvdXAgY29uY2VwdCB0byAKc2VwYXJhdGUg
dGhlIG5vdGlvbnMgb2YgSUQgYWxpYXNpbmcgYW5kIHBlZXItdG8tcGVlciBpc29sYXRpb24gKHdo
aWNoIApzdGlsbCB3b3VsZG4ndCBuZWNlc3NhcmlseSBoZWxwKSwgSSB0aGluayB0aGlzIHVzZXIg
b3ZlcnJpZGUgZWZmZWN0aXZlbHkgCmJvaWxzIGRvd24gdG8ganVzdCBhbm90aGVyIGZsYXZvdXIg
b2YgaW9tbXVfcmVxdWVzdF8qX2Zvcl9kZXYoKSwgYW5kIGFzIApzdWNoIGNvbWVzIHJpZ2h0IGJh
Y2sgdG8gdGhlICJqdXN0IHBhc3MgdGhlIGJsb29keSBkZXZpY2UgdG8gCm9wcy0+ZG9tYWluX2Fs
bG9jKCkgYW5kIHJlc29sdmUgZXZlcnl0aGluZyB1cC1mcm9udCIgYXJndW1lbnQuCgpSb2Jpbi4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
