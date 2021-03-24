Return-Path: <SRS0=zuxH=IW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD7C433DB
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 19:03:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9368C619F3
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 19:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9368C619F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E33E40E77;
	Wed, 24 Mar 2021 19:03:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WgxeJSkKUOje; Wed, 24 Mar 2021 19:03:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAE9540F00;
	Wed, 24 Mar 2021 19:03:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82D24C000D;
	Wed, 24 Mar 2021 19:03:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58342C000A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 19:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CC9940EF9
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 19:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DqEcDYkYv9BF for <iommu@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 19:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68CBA40EF8
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 19:03:02 +0000 (UTC)
IronPort-SDR: qqFvpoc/FO4HtSO+1+utlI85WwQeVRSu0VvAVx5ypOl7IYfm350M860jknyQ93gLDMnTLDjGgw
 ai34MO3rS6mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188473599"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="188473599"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 12:03:01 -0700
IronPort-SDR: vEVuZEgytcldetjUfo6Sl5MqAEoBbiZloTVAaWxshrn8DYwryViiHiE4G3TH6o/qH6X0x6iK7x
 GHD4R+R+6rhw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="525345239"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 12:03:01 -0700
Date: Wed, 24 Mar 2021 12:05:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210324120528.24d82dbd@jacob-builder>
In-Reply-To: <20210322120300.GU2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

SGkgSmFzb24sCgpPbiBNb24sIDIyIE1hciAyMDIxIDA5OjAzOjAwIC0wMzAwLCBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToKCj4gT24gRnJpLCBNYXIgMTksIDIwMjEgYXQg
MTE6MjI6MjFBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3RlOgo+ID4gSGkgSmFzb24sCj4gPiAKPiA+
IE9uIEZyaSwgMTkgTWFyIDIwMjEgMTA6NTQ6MzIgLTAzMDAsIEphc29uIEd1bnRob3JwZSA8amdn
QG52aWRpYS5jb20+Cj4gPiB3cm90ZTogCj4gPiA+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0IDAy
OjQxOjMyUE0gKzAxMDAsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlcgo+ID4gPiB3cm90ZTogIAo+ID4g
PiA+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0IDA5OjQ2OjQ1QU0gLTAzMDAsIEphc29uIEd1bnRo
b3JwZSB3cm90ZTogICAgCj4gPiA+ID4gPiBPbiBGcmksIE1hciAxOSwgMjAyMSBhdCAxMDo1ODo0
MUFNICswMTAwLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIKPiA+ID4gPiA+IHdyb3RlOiAKPiA+ID4g
PiA+ID4gQWx0aG91Z2ggdGhlcmUgaXMgbm8gdXNlIGZvciBpdCBhdCB0aGUgbW9tZW50IChvbmx5
IHR3byB1cHN0cmVhbQo+ID4gPiA+ID4gPiB1c2VycyBhbmQgaXQgbG9va3MgbGlrZSBhbWRrZmQg
YWx3YXlzIHVzZXMgY3VycmVudCB0b28pLCBJIHF1aXRlCj4gPiA+ID4gPiA+IGxpa2UgdGhlIGNs
aWVudC1zZXJ2ZXIgbW9kZWwgd2hlcmUgdGhlIHByaXZpbGVnZWQgcHJvY2VzcyBkb2VzCj4gPiA+
ID4gPiA+IGJpbmQoKSBhbmQgcHJvZ3JhbXMgdGhlIGhhcmR3YXJlIHF1ZXVlIG9uIGJlaGFsZiBv
ZiB0aGUgY2xpZW50Cj4gPiA+ID4gPiA+IHByb2Nlc3MuICAgIAo+ID4gPiA+ID4gCj4gPiA+ID4g
PiBUaGlzIGNyZWF0ZXMgYSBsb3QgY29tcGxleGl0eSwgaG93IGRvIGRvZXMgcHJvY2VzcyBBIGdl
dCBhIHNlY3VyZQo+ID4gPiA+ID4gcmVmZXJlbmNlIHRvIEI/IEhvdyBkb2VzIGl0IGFjY2VzcyB0
aGUgbWVtb3J5IGluIEIgdG8gc2V0dXAgdGhlCj4gPiA+ID4gPiBIVz8gICAgCj4gPiA+ID4gCj4g
PiA+ID4gbW1fYWNjZXNzKCkgZm9yIGV4YW1wbGUsIGFuZCBwYXNzaW5nIGFkZHJlc3NlcyB2aWEg
SVBDICAgIAo+ID4gPiAKPiA+ID4gSSdkIHJhdGhlciB0aGUgc291cmNlIHByb2Nlc3MgZXN0YWJs
aXNoIGl0cyBvd24gUEFTSUQgYW5kIHRoZW4gcGFzcwo+ID4gPiB0aGUgcmlnaHRzIHRvIHVzZSBp
dCB0byBzb21lIG90aGVyIHByb2Nlc3MgdmlhIEZEIHBhc3NpbmcgdGhhbiB0cnkgdG8KPiA+ID4g
Z28gdGhlIG90aGVyIHdheS4gVGhlcmUgYXJlIGxvdHMgb2Ygc2VjdXJpdHkgcXVlc3Rpb25zIHdp
dGggc29tZXRoaW5nCj4gPiA+IGxpa2UgbW1fYWNjZXNzLgo+ID4gPiAgIAo+ID4gCj4gPiBUaGFu
ayB5b3UgYWxsIGZvciB0aGUgaW5wdXQsIGl0IHNvdW5kcyBsaWtlIHdlIGFyZSBPSyB0byByZW1v
dmUgbW0KPiA+IGFyZ3VtZW50IGZyb20gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKCkgYW5kIGlvbW11
X3N2YV9hbGxvY19wYXNpZCgpIGZvcgo+ID4gbm93Pwo+ID4gCj4gPiBMZXQgbWUgdHJ5IHRvIHN1
bW1hcml6ZSBQQVNJRCBhbGxvY2F0aW9uIGFzIGJlbG93Ogo+ID4gCj4gPiBJbnRlcmZhY2VzCXwg
VXNhZ2UJfCAgTGltaXQJfCBiaW5kwrkgfFVzZXIgdmlzaWJsZQo+ID4gL2Rldi9pb2FzaWTCsgl8
IEctU1ZBL0lPVkEJfCAgY2dyb3VwCXwgTm8KPiA+IHxZZXMgY2hhciBkZXbCswl8IFNWQQkJfCAg
Y2dyb3VwCXwKPiA+IFllcwl8Tm8gaW9tbXUgZHJpdmVyCXwgZGVmYXVsdCBQQVNJRHwgIG5vCj4g
PiB8IE5vCXxObyBrZXJuZWwJCXwgc3VwZXIgU1ZBCXwgbm8KPiA+IAl8IHllcyAgIHxObwo+ID4g
Cj4gPiDCuSBBbGxvY2F0ZWQgZHVyaW5nIFNWQSBiaW5kCj4gPiDCsiBQQVNJRHMgYWxsb2NhdGVk
IHZpYSAvZGV2L2lvYXNpZCBhcmUgbm90IGJvdW5kIHRvIGFueSBtbS4gQnV0IGl0cwo+ID4gICBv
d25lcnNoaXAgaXMgYXNzaWduZWQgdG8gdGhlIHByb2Nlc3MgdGhhdCBkb2VzIHRoZSBhbGxvY2F0
aW9uLiAgCj4gCj4gV2hhdCBkb2VzICJub3QgYm91bmQgdG8gYSBtbSIgbWVhbj8KPiAKSSBtZWFu
dCwgdGhlIElPQVNJRCBhbGxvY2F0ZWQgdmlhIC9kZXYvaW9hc2lkIGlzIGluIGEgY2xlYW4gc3Rh
dGUgKGp1c3QgYQpudW1iZXIpLiBJdCdzIGluaXRpYWwgc3RhdGUgaXMgbm90IGJvdW5kIHRvIGFu
IG1tLiBVbmxpa2UsIHN2YV9iaW5kX2RldmljZSgpCndoZXJlIHRoZSBJT0FTSUQgaXMgYWxsb2Nh
dGVkIGR1cmluZyBiaW5kIHRpbWUuCgpUaGUgdXNlIGNhc2UgaXMgdG8gc3VwcG9ydCBndWVzdCBT
VkEgYmluZCwgd2hlcmUgYWxsb2NhdGlvbiBhbmQgYmluZCBhcmUgaW4KdHdvIHNlcGFyYXRlIHN0
ZXBzLgoKPiBJTUhPIGEgdXNlIGNyZWF0ZWQgUEFTSUQgaXMgZWl0aGVyIGJvdW5kIHRvIGEgbW0g
KGN1cnJlbnQpIGF0IGNyZWF0aW9uCj4gdGltZSwgb3IgaXQgd2lsbCBuZXZlciBiZSBib3VuZCB0
byBhIG1tIGFuZCBpdHMgcGFnZSB0YWJsZSBpcyB1bmRlcgo+IHVzZXIgY29udHJvbCB2aWEgL2Rl
di9pb2FzaWQuCj4gClRydWUgZm9yIFBBU0lEIHVzZWQgaW4gbmF0aXZlIFNWQSBiaW5kLiBCdXQg
Zm9yIGJpbmRpbmcgd2l0aCBhIGd1ZXN0IG1tLApQQVNJRCBpcyBhbGxvY2F0ZWQgZmlyc3QgKFZU
LWQgdmlydHVhbCBjbWQgaW50ZXJmYWNlIFNwZWMgMTAuNC40NCksIHRoZQpiaW5kIHdpdGggdGhl
IGhvc3QgSU9NTVUgd2hlbiB2SU9NTVUgUEFTSUQgY2FjaGUgaXMgaW52YWxpZGF0ZWQuCgpPdXIg
aW50ZW50aW9uIGlzIHRvIGhhdmUgdHdvIHNlcGFyYXRlIGludGVyZmFjZXM6CjEuIC9kZXYvaW9h
c2lkIChhbGxvY2F0aW9uL2ZyZWUgb25seSkKMi4gL2Rldi9zdmEgKGhhbmRsZXMgYWxsIFNWQSBy
ZWxhdGVkIGFjdGl2aXRpZXMgaW5jbHVkaW5nIHBhZ2UgdGFibGVzKQoKPiBJIHRob3VnaHQgdGhl
IHdob2xlIHBvaW50IG9mIHNvbWV0aGluZyBsaWtlIGEgL2Rldi9pb2FzaWQgd2FzIHRvIGdldAo+
IGF3YXkgZnJvbSBlYWNoIGFuZCBldmVyeSBkZXZpY2UgY3JlYXRpbmcgaXRzIG93biBQQVNJRCBp
bnRlcmZhY2U/Cj4gCnllcywgYnV0IG9ubHkgZm9yIHRoZSB1c2UgY2FzZXMgdGhhdCBuZWVkIHRv
IGV4cG9zZSBQQVNJRCB0byB0aGUgdXNlcnNwYWNlLgpBRkFJQ1QsIHRoZSBjYXNlcyBhcmU6CjEu
IGd1ZXN0IFNWQSAoYmluZCBndWVzdCBtbSkKMi4gZnVsbCBQRi9WRiBhc3NpZ25tZW50KG5vdCBt
ZWRpYXRlZCkgd2hlcmUgZ3Vlc3QgZHJpdmVyIHdhbnQgdG8gcHJvZ3JhbQp0aGUgYWN0dWFsIFBB
U0lEIG9udG8gdGhlIGRldmljZS4KCj4gSXQgbWF5YmUgc29tZXdoYXQgcmVhc29uYWJsZSB0aGF0
IHNvbWUgZGV2aWNlcyBjb3VsZCBoYXZlIHNvbWUgZWFzeQo+ICdtYWtlIGEgU1ZBIFBBU0lEIG9u
IGN1cnJlbnQnIGludGVyZmFjZSBidWlsdCBpbiwKSSBhZ3JlZSwgdGhpcyBpcyB0aGUgY2FzZSBQ
QVNJRCBpcyBoaWRkZW4gZnJvbSB0aGUgdXNlcnNwYWNlLCByaWdodD8gZS5nLgp1YWNjZS4KCj4g
YnV0IGFueXRoaW5nIG1vcmUKPiBjb21wbGljYXRlZCBzaG91bGQgdXNlIC9kZXYvaW9hc2lkLCBh
bmQgYW55dGhpbmcgY29uc3VtaW5nIFBBU0lECj4gc2hvdWxkIGFsc28gaGF2ZSBhbiBBUEkgdG8g
aW1wb3J0IGFuZCBhdHRhY2ggYSBQQVNJRCBmcm9tIC9kZXYvaW9hc2lkLgo+IApXb3VsZCB0aGUg
YWJvdmUgdHdvIHVzZSBjYXNlcyBjb25zdGl0dXRlIHRoZSAiY29tcGxpY2F0ZWQiIGNyaXRlcmlh
PyBPciB3ZQpzaG91bGQgc2F5IGFueXRoaW5nIHRoYXQgbmVlZCB0aGUgZXhwbGljaXQgUEFTSUQg
dmFsdWUgaGFzIHRvIHRocm91Z2gKL2Rldi9pb2FzaWQ/CgpDb3VsZCB5b3UgZ2l2ZSBzb21lIGhp
Z2hsZXZlbCBoaW50IG9uIHRoZSBBUElzIHRoYXQgaG9vayB1cCBJT0FTSUQKYWxsb2NhdGVkIGZy
b20gL2Rldi9pb2FzaWQgYW5kIHVzZSBjYXNlcyB0aGF0IGNvbWJpbmUgZGV2aWNlIGFuZCBkb21h
aW4KaW5mb3JtYXRpb24/IFlpIGlzIHdvcmtpbmcgb24gL2Rldi9zdmEgUkZDLCBpdCB3b3VsZCBi
ZSBnb29kIHRvIGhhdmUgYQpkaXJlY3Rpb24gY2hlY2suCgo+ID4gQ3VycmVudGx5LCB0aGUgcHJv
cG9zZWQgL2Rldi9pb2FzaWQgaW50ZXJmYWNlIGRvZXMgbm90IG1hcCBpbmRpdmlkdWFsCj4gPiBQ
QVNJRCB3aXRoIGFuIEZELiBUaGUgRkQgaXMgYXQgdGhlIGlvYXNpZF9zZXQgZ3JhbnVsYXJpdHkg
YW5kIGJvbmQgdG8KPiA+IHRoZSBjdXJyZW50IG1tLiBXZSBjb3VsZCBleHRlbmQgdGhlIElPQ1RM
cyB0byBjb3ZlciBpbmRpdmlkdWFsIFBBU0lELUZECj4gPiBwYXNzaW5nIGNhc2Ugd2hlbiB1c2Ug
Y2FzZXMgYXJpc2UuIFdvdWxkIHRoaXMgd29yaz8gIAo+IAo+IElzIGl0IGEgZ29vZCBpZGVhIHRo
YXQgdGhlIEZEIGlzIHBlciBpb2FzaWRfc2V0ID8KV2Ugd2VyZSB0aGlua2luZyB0aGUgYWxsb2Nh
dGlvbiBJT0NUTCBpcyBvbiBhIHBlciBzZXQgYmFzaXMsIHRoZW4gd2Uga25vdwp0aGUgb3duZXJz
aGlwIG9mIGJldHdlZW4gUEFTSURzIGFuZCBpdHMgc2V0LiBJZiBwZXIgUEFTSUQgRkQgaXMgbmVl
ZGVkLCB3ZQpjYW4gZXh0ZW5kLgoKPiBXaGF0IGlzIHRoZSBzZXQgdXNlZAo+IGZvcj8KPiAKSSB0
cmllZCB0byBkb2N1bWVudCB0aGUgY29uY2VwdCBpbgpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzE2MTQ0NjMyODYtOTc2MTgtMi1naXQtc2VuZC1lbWFpbC1qYWNvYi5qdW4ucGFuQGxpbnV4
LmludGVsLmNvbS8KCkluIHRlcm1zIG9mIHVzYWdlIGZvciBndWVzdCBTVkEsIGFuIGlvYXNpZF9z
ZXQgaXMgbW9zdGx5IHRpZWQgdG8gYSBob3N0IG1tLAp0aGUgdXNlIGNhc2UgaXMgYXMgdGhlIGZv
bGxvd2luZzoKMS4gSWRlbnRpZnkgYSBwb29sIG9mIFBBU0lEcyBmb3IgcGVybWlzc2lvbiBjaGVj
a2luZyAoYmVsb3cgdG8gdGhlIHNhbWUgVk0pLAplLmcuIG9ubHkgYWxsb3cgU1ZBIGJpbmRpbmcg
Zm9yIFBBU0lEcyBhbGxvY2F0ZWQgZnJvbSB0aGUgc2FtZSBzZXQuCgoyLiBBbGxvdyBkaWZmZXJl
bnQgUEFTSUQtYXdhcmUga2VybmVsIHN1YnN5c3RlbXMgdG8gYXNzb2NpYXRlLCBlLmcuIEtWTSwK
ZGV2aWNlIGRyaXZlcnMsIGFuZCBJT01NVSBkcml2ZXIuIGkuZS4gZWFjaCBLVk0gaW5zdGFuY2Ug
b25seSBjYXJlcyBhYm91dAp0aGUgaW9hc2lkX3NldCBhc3NvY2lhdGVkIHdpdGggdGhlIFZNLiBF
dmVudHMgbm90aWZpY2F0aW9ucyBhcmUgYWxzbyB3aXRoaW4KdGhlIGlvYXNpZF9zZXQgdG8gc3lu
Y2hyb25pemUgUEFTSUQgc3RhdGVzLgoKMy4gR3Vlc3QtSG9zdCBQQVNJRCBsb29rIHVwIChlYWNo
IHNldCBoYXMgaXRzIG93biBYQXJyYXkgdG8gc3RvcmUgdGhlCm1hcHBpbmcpCgo0LiBRdW90YSBj
b250cm9sIChnb2luZyBhd2F5IG9uY2Ugd2UgaGF2ZSBjZ3JvdXApCgo+IFVzdWFsbHkga2VybmVs
IGludGVyZmFjZXMgd29yayBuaWNlciB3aXRoIGEgb25lIGZkL29uZSBvYmplY3QgbW9kZWwuCj4g
Cj4gQnV0IGV2ZW4gaWYgaXQgaXMgYSBzZXQsIHlvdSBjb3VsZCBwYXNzIHRoZSBzZXQgYmV0d2Vl
biBjby1vcGVyYXRpbmcKPiBwcm9jZXNzZXMgYW5kIHRoZSBQQVNJRCBjYW4gYmUgY3JlYXRlZCBp
biB0aGUgY29ycmVjdCAnY3VycmVudCcuIEJ1dAo+IHRoZXJlIGlzIGFsbCBraW5kcyBvZiBzZWN1
cml0eSBxdWVzdHNpb25zIGFzIHNvb24gYXMgeW91IHN0YXJ0IGRvaW5nCj4gYW55dGhpbmcgbGlr
ZSB0aGlzIC0gaXMgdGhlcmUgcmVhbGx5IGEgdXNlIGNhc2U/Cj4gCldlIGRvbid0IHNlZSBhIHVz
ZSBjYXNlIGZvciBwYXNzaW5nIGlvYXNpZF9zZXQgdG8gYW5vdGhlciBwcm9jZXNzLiBBbGwgdGhl
CmZvdXIgdXNlIGNhc2VzIGFib3ZlIGFyZSBmb3IgdGhlIGN1cnJlbnQgcHJvY2Vzcy4KCj4gSmFz
b24KCgpUaGFua3MsCgpKYWNvYgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
