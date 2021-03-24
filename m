Return-Path: <SRS0=zuxH=IW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ACEC433DB
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 17:00:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A6061A10
	for <iommu@archiver.kernel.org>; Wed, 24 Mar 2021 17:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A6061A10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B590C849B8;
	Wed, 24 Mar 2021 17:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZnJBjxcCuXTN; Wed, 24 Mar 2021 17:00:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9394C849AA;
	Wed, 24 Mar 2021 17:00:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63779C000D;
	Wed, 24 Mar 2021 17:00:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 106F9C000A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 17:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAD9B400D3
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 17:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IKSjNFucAm1j for <iommu@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 17:00:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B202E4013C
 for <iommu@lists.linux-foundation.org>; Wed, 24 Mar 2021 17:00:34 +0000 (UTC)
IronPort-SDR: /eFbE4FsR6Xmc0vYLloPQV5kyuBy6I7RSpbxYY4OBcGnHMHjnKRjCcnNhIyhQU87+Va92ZWS4e
 ElaXRY/4u4Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178301799"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="178301799"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 10:00:33 -0700
IronPort-SDR: YaXrQdlMK3wx/87Gouc8P/JcmCFUnmxlV9XMFtnEUTpfgHtOYwd8VKOOu4hPqOQ8ocZEoUbDJh
 55GbULgN11QA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="593442260"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 10:00:32 -0700
Date: Wed, 24 Mar 2021 10:02:46 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210324100246.4e6b8aa1@jacob-builder>
In-Reply-To: <YFhiMLR35WWMW/Hu@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <YFhiMLR35WWMW/Hu@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
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

SGkgSmVhbi1QaGlsaXBwZSwKCk9uIE1vbiwgMjIgTWFyIDIwMjEgMTA6MjQ6MDAgKzAxMDAsIEpl
YW4tUGhpbGlwcGUgQnJ1Y2tlcgo8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPiB3cm90ZToKCj4g
T24gRnJpLCBNYXIgMTksIDIwMjEgYXQgMTE6MjI6MjFBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
Ogo+ID4gSGkgSmFzb24sCj4gPiAKPiA+IE9uIEZyaSwgMTkgTWFyIDIwMjEgMTA6NTQ6MzIgLTAz
MDAsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+Cj4gPiB3cm90ZTogCj4gPiA+IE9u
IEZyaSwgTWFyIDE5LCAyMDIxIGF0IDAyOjQxOjMyUE0gKzAxMDAsIEplYW4tUGhpbGlwcGUgQnJ1
Y2tlcgo+ID4gPiB3cm90ZTogIAo+ID4gPiA+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0IDA5OjQ2
OjQ1QU0gLTAzMDAsIEphc29uIEd1bnRob3JwZSB3cm90ZTogICAgCj4gPiA+ID4gPiBPbiBGcmks
IE1hciAxOSwgMjAyMSBhdCAxMDo1ODo0MUFNICswMTAwLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIK
PiA+ID4gPiA+IHdyb3RlOiAKPiA+ID4gPiA+ID4gQWx0aG91Z2ggdGhlcmUgaXMgbm8gdXNlIGZv
ciBpdCBhdCB0aGUgbW9tZW50IChvbmx5IHR3byB1cHN0cmVhbQo+ID4gPiA+ID4gPiB1c2VycyBh
bmQgaXQgbG9va3MgbGlrZSBhbWRrZmQgYWx3YXlzIHVzZXMgY3VycmVudCB0b28pLCBJIHF1aXRl
Cj4gPiA+ID4gPiA+IGxpa2UgdGhlIGNsaWVudC1zZXJ2ZXIgbW9kZWwgd2hlcmUgdGhlIHByaXZp
bGVnZWQgcHJvY2VzcyBkb2VzCj4gPiA+ID4gPiA+IGJpbmQoKSBhbmQgcHJvZ3JhbXMgdGhlIGhh
cmR3YXJlIHF1ZXVlIG9uIGJlaGFsZiBvZiB0aGUgY2xpZW50Cj4gPiA+ID4gPiA+IHByb2Nlc3Mu
ICAgIAo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGlzIGNyZWF0ZXMgYSBsb3QgY29tcGxleGl0eSwg
aG93IGRvIGRvZXMgcHJvY2VzcyBBIGdldCBhIHNlY3VyZQo+ID4gPiA+ID4gcmVmZXJlbmNlIHRv
IEI/IEhvdyBkb2VzIGl0IGFjY2VzcyB0aGUgbWVtb3J5IGluIEIgdG8gc2V0dXAgdGhlCj4gPiA+
ID4gPiBIVz8gICAgCj4gPiA+ID4gCj4gPiA+ID4gbW1fYWNjZXNzKCkgZm9yIGV4YW1wbGUsIGFu
ZCBwYXNzaW5nIGFkZHJlc3NlcyB2aWEgSVBDICAgIAo+ID4gPiAKPiA+ID4gSSdkIHJhdGhlciB0
aGUgc291cmNlIHByb2Nlc3MgZXN0YWJsaXNoIGl0cyBvd24gUEFTSUQgYW5kIHRoZW4gcGFzcwo+
ID4gPiB0aGUgcmlnaHRzIHRvIHVzZSBpdCB0byBzb21lIG90aGVyIHByb2Nlc3MgdmlhIEZEIHBh
c3NpbmcgdGhhbiB0cnkgdG8KPiA+ID4gZ28gdGhlIG90aGVyIHdheS4gVGhlcmUgYXJlIGxvdHMg
b2Ygc2VjdXJpdHkgcXVlc3Rpb25zIHdpdGggc29tZXRoaW5nCj4gPiA+IGxpa2UgbW1fYWNjZXNz
Lgo+ID4gPiAgIAo+ID4gCj4gPiBUaGFuayB5b3UgYWxsIGZvciB0aGUgaW5wdXQsIGl0IHNvdW5k
cyBsaWtlIHdlIGFyZSBPSyB0byByZW1vdmUgbW0KPiA+IGFyZ3VtZW50IGZyb20gaW9tbXVfc3Zh
X2JpbmRfZGV2aWNlKCkgYW5kIGlvbW11X3N2YV9hbGxvY19wYXNpZCgpIGZvcgo+ID4gbm93PyAg
Cj4gCj4gRmluZSBieSBtZS4gQnkgdGhlIHdheSB0aGUgSURYRCBjdXJyZW50bHkgbWlzc3VlcyB0
aGUgYmluZCBBUEkgZm9yCj4gc3VwZXJ2aXNvciBQQVNJRCwgYW5kIHRoZSBkcnZkYXRhIHBhcmFt
ZXRlciBpc24ndCBvdGhlcndpc2UgdXNlZC4gVGhpcwo+IHdvdWxkIGJlIGEgZ29vZCBvY2Nhc2lv
biB0byBjbGVhbiBib3RoLiBUaGUgbmV3IGJpbmQgcHJvdG90eXBlIGNvdWxkIGJlOgo+IAo+IHN0
cnVjdCBpb21tdV9zdmEgKmlvbW11X3N2YV9iaW5kX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IGludCBmbGFncykKPiAKeWVzLCB3ZSByZWFsbHkganVzdCBoaWphY2tlZCBkcnZkYXRhIGFzIGZs
YWdzLCBpdCB3b3VsZCBiZSBjbGVhbmVyIHRvIHVzZQpmbGFncyBleHBsaWNpdGx5LgoKPiBBbmQg
YSBmbGFnIElPTU1VX1NWQV9CSU5EX1NVUEVSVklTT1IgKG5vdCB0aGF0IEkgcGxhbiB0byBpbXBs
ZW1lbnQgaXQgaW4KPiB0aGUgU01NVSwgYnV0IEkgdGhpbmsgd2UgbmVlZCB0byBjbGVhbiB0aGUg
Y3VycmVudCB1c2FnZSkKPiAKWW91IG1lYW4gbW92ZSAjZGVmaW5lIFNWTV9GTEFHX1NVUEVSVklT
T1JfTU9ERSBvdXQgb2YgSW50ZWwgY29kZSB0byBiZSBhCmdlbmVyaWMgZmxhZyBpbiBpb21tdS1z
dmEtbGliLmggY2FsbGVkIElPTU1VX1NWQV9CSU5EX1NVUEVSVklTT1I/CgpJIGFncmVlIGlmIHRo
YXQgaXMgdGhlIHByb3Bvc2FsLgoKPiA+IAo+ID4gTGV0IG1lIHRyeSB0byBzdW1tYXJpemUgUEFT
SUQgYWxsb2NhdGlvbiBhcyBiZWxvdzoKPiA+IAo+ID4gSW50ZXJmYWNlcwl8IFVzYWdlCXwgIExp
bWl0CXwgYmluZMK5IHxVc2VyIHZpc2libGUKPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiAvZGV2L2lvYXNp
ZMKyCXwgRy1TVkEvSU9WQQl8ICBjZ3JvdXAJfCBObwo+ID4gfFllcwo+ID4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
PiA+IGNoYXIgZGV2wrMJfCBTVkEJCXwgIGNncm91cAl8IFllcwl8Tm8KPiA+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gPiBpb21tdSBkcml2ZXIJfCBkZWZhdWx0IFBBU0lEfCAgbm8JCXwgTm8JfE5vCj4gPiAgCj4g
Cj4gSXMgdGhpcyBQQVNJRCAjMD8KPiAKVHJ1ZSBmb3IgbmF0aXZlIGNhc2UgYnV0IG5vdCBsaW1p
dGVkIHRvIFBBU0lEIzAgZm9yIGd1ZXN0IGNhc2UuIEUuZy4gZm9yCm1kZXYgYXNzaWdubWVudCB3
aXRoIGd1ZXN0IElPVkEsIHRoZSBndWVzdCBQQVNJRCB3b3VsZCAjMCwgYnV0IHRoZSBob3N0IGF1
eApkb21haW4gZGVmYXVsdCBQQVNJRCBjYW4gYmUgbm9uLXplcm8uIEhlcmUgSSBtZWFudCB0byBp
bmNsdWRlIGJvdGggY2FzZXMuCgo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+IGtlcm5lbAkJfCBzdXBlciBT
VkEJfCBubwkJfCB5ZXMgICB8Tm8KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICAKPiAKPiBBbHNvIHdvbmRlcmlu
ZyBhYm91dCBkZXZpY2UgZHJpdmVyIGFsbG9jYXRpbmcgYXV4aWxpYXJ5IGRvbWFpbnMgZm9yIHRo
ZWlyCj4gcHJpdmF0ZSB1c2UsIHRvIGRvIGlvbW11X21hcC91bm1hcCBvbiBwcml2YXRlIFBBU0lE
cyAoYSBjbGVhbiByZXBsYWNlbWVudAo+IHRvIHN1cGVyIFNWQSwgZm9yIGV4YW1wbGUpLiBXb3Vs
ZCB0aGF0IGdvIHRocm91Z2ggdGhlIHNhbWUgcGF0aCBhcwo+IC9kZXYvaW9hc2lkIGFuZCB1c2Ug
dGhlIGNncm91cCBvZiBjdXJyZW50IHRhc2s/Cj4KRm9yIHRoZSBpbi1rZXJuZWwgcHJpdmF0ZSB1
c2UsIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIHJlc3RyaWN0IGJhc2VkIG9uCmNncm91cCwgc2lu
Y2UgdGhlcmUgaXMgbm8gYWZmaW5pdHkgdG8gdXNlciBwcm9jZXNzZXMuIEkgYWxzbyB0aGluayB0
aGUKUEFTSUQgYWxsb2NhdGlvbiBzaG91bGQganVzdCB1c2Uga2VybmVsIEFQSSBpbnN0ZWFkIG9m
IC9kZXYvaW9hc2lkLiBXaHkKd291bGQgdXNlciBzcGFjZSBuZWVkIHRvIGtub3cgdGhlIGFjdHVh
bCBQQVNJRCAjIGZvciBkZXZpY2UgcHJpdmF0ZSBkb21haW5zPwpNYXliZSBJIG1pc3NlZCB5b3Vy
IGlkZWE/Cgo+IFRoYW5rcywKPiBKZWFuCj4gCj4gPiAKPiA+IMK5IEFsbG9jYXRlZCBkdXJpbmcg
U1ZBIGJpbmQKPiA+IMKyIFBBU0lEcyBhbGxvY2F0ZWQgdmlhIC9kZXYvaW9hc2lkIGFyZSBub3Qg
Ym91bmQgdG8gYW55IG1tLiBCdXQgaXRzCj4gPiAgIG93bmVyc2hpcCBpcyBhc3NpZ25lZCB0byB0
aGUgcHJvY2VzcyB0aGF0IGRvZXMgdGhlIGFsbG9jYXRpb24uCj4gPiDCsyBJbmNsdWRlIHVhY2Nl
LCBvdGhlciBwcml2YXRlIGRldmljZSBkcml2ZXIgY2hhciBkZXYgc3VjaCBhcyBpZHhkCj4gPiAK
PiA+IEN1cnJlbnRseSwgdGhlIHByb3Bvc2VkIC9kZXYvaW9hc2lkIGludGVyZmFjZSBkb2VzIG5v
dCBtYXAgaW5kaXZpZHVhbAo+ID4gUEFTSUQgd2l0aCBhbiBGRC4gVGhlIEZEIGlzIGF0IHRoZSBp
b2FzaWRfc2V0IGdyYW51bGFyaXR5IGFuZCBib25kIHRvCj4gPiB0aGUgY3VycmVudCBtbS4gV2Ug
Y291bGQgZXh0ZW5kIHRoZSBJT0NUTHMgdG8gY292ZXIgaW5kaXZpZHVhbCBQQVNJRC1GRAo+ID4g
cGFzc2luZyBjYXNlIHdoZW4gdXNlIGNhc2VzIGFyaXNlLiBXb3VsZCB0aGlzIHdvcms/Cj4gPiAK
PiA+IFRoYW5rcywKPiA+IAo+ID4gSmFjb2IgIAoKClRoYW5rcywKCkphY29iCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
