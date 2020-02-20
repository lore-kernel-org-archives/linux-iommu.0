Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A1BC7619D
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 02:49:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150C421D56
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 02:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150C421D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D1DAE20768;
	Thu, 20 Feb 2020 02:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zMPmwX2cct-K; Thu, 20 Feb 2020 02:49:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ED29D203A8;
	Thu, 20 Feb 2020 02:49:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E51DEC1D80;
	Thu, 20 Feb 2020 02:49:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF3D6C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D68F5805DC
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RdmQIvUtXcD7 for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 02:49:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8BD5481E6F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 02:49:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 18:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; d="scan'208";a="228782315"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.162.231])
 ([10.249.162.231])
 by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2020 18:49:39 -0800
Subject: Re: question about iommu_need_mapping
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20200219235516.zl44y7ydgqqja6x5@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
Date: Thu, 20 Feb 2020 10:49:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219235516.zl44y7ydgqqja6x5@cantor>
Content-Language: en-US
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

SGkgSmVycnksCgpPbiAyMDIwLzIvMjAgNzo1NSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPiBJ
cyBpdCBwb3NzaWJsZSBmb3IgYSBkZXZpY2UgdG8gZW5kIHVwIHdpdGggZGV2LT5hcmNoZGF0YS5p
b21tdSA9PSBOVUxMCj4gb24gaW9tbXVfbmVlZF9tYXBwaW5nIGluIHRoZSBmb2xsb3dpbmcgaW5z
dGFuY2U6Cj4gCj4gMS4gaW9tbXVfZ3JvdXAgaGFzIGRtYSBkb21haW4gZm9yIGRlZmF1bHQKPiAy
LiBkZXZpY2UgZ2V0cyBwcml2YXRlIGlkZW50aXR5IGRvbWFpbiBpbiBpbnRlbF9pb21tdV9hZGRf
ZGV2aWNlCj4gMy4gaW9tbXVfbmVlZF9tYXBwaW5nIGdldHMgY2FsbGVkIHdpdGggdGhhdCBkZXZp
Y2UuCj4gNC4gZG1hcl9yZW1vdmVfb25lX2Rldl9pbmZvIHNldHMgZGV2LT5hcmNoZGF0YS5pb21t
dSA9IE5VTEwgdmlhIAo+IHVubGlua19kb21haW5faW5mby4KPiA1LiByZXF1ZXN0X2RlZmF1bHRf
ZG9tYWluX2Zvcl9kZXYgZXhpdHMgYWZ0ZXIgY2hlY2tpbmcgdGhhdCAKPiBncm91cC0+ZGVmYXVs
dF9kb21haW4KPiAgwqDCoCBleGlzdHMsIGFuZCBncm91cC0+ZGVmYXVsdF9kb21haW4tPnR5cGUg
aXMgZG1hLgo+IDYuIGlvbW11X3JlcXVlc3RfZG1hX2RvbWFpbl9mb3JfZGV2IHJldHVybnMgMCBm
cm9tIAo+IHJlcXVlc3RfZGVmYXVsdF9kb21haW5fZm9yX2Rldgo+ICDCoMKgIGFuZCBhIHByaXZh
dGUgZG1hIGRvbWFpbiBpc24ndCBjcmVhdGVkIGZvciB0aGUgZGV2aWNlLgo+IAoKWWVzLiBJdCdz
IHBvc3NpYmxlLgoKPiBUaGUgY2FzZSBJIHdhcyBzZWVpbmcgd2VudCBhd2F5IHdpdGggY29tbWl0
IDkyMzVjYjEzZDdkMSAoImlvbW11L3Z0LWQ6Cj4gQWxsb3cgZGV2aWNlcyB3aXRoIFJNUlJzIHRv
IHVzZSBpZGVudGl0eSBkb21haW4iKSwgYmVjYXVzZSBpdCBjaGFuZ2VkCj4gd2hpY2ggZG9tYWlu
IHRoZSBncm91cCBhbmQgZGV2aWNlcyB3ZXJlIHVzaW5nLCBidXQgaXQgc2VlbXMgbGlrZSBpdCBp
cwo+IHN0aWxsIGEgcG9zc2liaWxpdHkgd2l0aCB0aGUgY29kZS4gQmFvbHUsIHlvdSBtZW50aW9u
ZWQgcG9zc2libHkKPiByZW1vdmluZyB0aGUgZG9tYWluIHN3aXRjaC4gQ29tbWl0IDk4YjJmZmZi
NWUyNyAoImlvbW11L3Z0LWQ6IEhhbmRsZQo+IDMyYml0IGRldmljZSB3aXRoIGlkZW50aXR5IGRl
ZmF1bHQgZG9tYWluIikgbWFrZXMgaXQgc291bmQgbGlrZSB0aGUKPiBkb21haW4gc3dpdGNoIGlz
IHJlcXVpcmVkLgoKSXQncyBtb3JlICJuaWNlIHRvIGhhdmUiIHRoYW4gInJlcXVpcmVkIiBpZiB0
aGUgaW9tbXUgZHJpdmVyIGRvZXNuJ3QKZGlzYWJsZSBzd2lvdGxiIGV4cGxpY2l0bHkuIFRoZSBk
ZXZpY2UgYWNjZXNzIG9mIHN5c3RlbSBtZW1vcnkgaGlnaGVyCnRoYW4gdGhlIGRldmljZSdzIGFk
ZHJlc3NpbmcgY2FwYWJpbGl0eSBjb3VsZCBnbyB0aHJvdWdoIHRoZSBib3VuY2VkCmJ1ZmZlciBp
bXBsZW1lbnRlZCBpbiBzd2lvdGxiLgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
