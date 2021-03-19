Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B2FC433C1
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 18:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4C361981
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 18:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4C361981
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C690C6F642;
	Fri, 19 Mar 2021 18:20:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gjX2vPVQB6he; Fri, 19 Mar 2021 18:20:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98EFA6F4DA;
	Fri, 19 Mar 2021 18:20:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEF5C000B;
	Fri, 19 Mar 2021 18:20:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42293C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 18:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 360528354D
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 18:19:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxjvXV2JeG7m for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 18:19:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7447982FF9
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 18:19:58 +0000 (UTC)
IronPort-SDR: yWlQ6B2YAZUxEx7Wu5EWzRPm1hHBxOrLf/KSfTiUvuKwzfqvNfFJG3f9Meeqjx9NdnSK7lR2tF
 IncAiKo1P9RA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="169250534"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; d="scan'208";a="169250534"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2021 11:19:57 -0700
IronPort-SDR: DaGp9VUiyAWOZGeJ59SlsgzZCYqJUVXG870PSyjGfjzTXCQPSSvNJ/3R6rY4fh0uK1NNYzRbnF
 iTJPUQsbE37w==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; d="scan'208";a="375032714"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2021 11:19:56 -0700
Date: Fri, 19 Mar 2021 11:22:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210319112221.5123b984@jacob-builder>
In-Reply-To: <20210319135432.GT2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
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

SGkgSmFzb24sCgpPbiBGcmksIDE5IE1hciAyMDIxIDEwOjU0OjMyIC0wMzAwLCBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToKCj4gT24gRnJpLCBNYXIgMTksIDIwMjEgYXQg
MDI6NDE6MzJQTSArMDEwMCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+ID4gT24gRnJp
LCBNYXIgMTksIDIwMjEgYXQgMDk6NDY6NDVBTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3Rl
OiAgCj4gPiA+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0IDEwOjU4OjQxQU0gKzAxMDAsIEplYW4t
UGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToKPiA+ID4gICAKPiA+ID4gPiBBbHRob3VnaCB0aGVyZSBp
cyBubyB1c2UgZm9yIGl0IGF0IHRoZSBtb21lbnQgKG9ubHkgdHdvIHVwc3RyZWFtCj4gPiA+ID4g
dXNlcnMgYW5kIGl0IGxvb2tzIGxpa2UgYW1ka2ZkIGFsd2F5cyB1c2VzIGN1cnJlbnQgdG9vKSwg
SSBxdWl0ZQo+ID4gPiA+IGxpa2UgdGhlIGNsaWVudC1zZXJ2ZXIgbW9kZWwgd2hlcmUgdGhlIHBy
aXZpbGVnZWQgcHJvY2VzcyBkb2VzCj4gPiA+ID4gYmluZCgpIGFuZCBwcm9ncmFtcyB0aGUgaGFy
ZHdhcmUgcXVldWUgb24gYmVoYWxmIG9mIHRoZSBjbGllbnQKPiA+ID4gPiBwcm9jZXNzLiAgCj4g
PiA+IAo+ID4gPiBUaGlzIGNyZWF0ZXMgYSBsb3QgY29tcGxleGl0eSwgaG93IGRvIGRvZXMgcHJv
Y2VzcyBBIGdldCBhIHNlY3VyZQo+ID4gPiByZWZlcmVuY2UgdG8gQj8gSG93IGRvZXMgaXQgYWNj
ZXNzIHRoZSBtZW1vcnkgaW4gQiB0byBzZXR1cCB0aGUgSFc/ICAKPiA+IAo+ID4gbW1fYWNjZXNz
KCkgZm9yIGV4YW1wbGUsIGFuZCBwYXNzaW5nIGFkZHJlc3NlcyB2aWEgSVBDICAKPiAKPiBJJ2Qg
cmF0aGVyIHRoZSBzb3VyY2UgcHJvY2VzcyBlc3RhYmxpc2ggaXRzIG93biBQQVNJRCBhbmQgdGhl
biBwYXNzCj4gdGhlIHJpZ2h0cyB0byB1c2UgaXQgdG8gc29tZSBvdGhlciBwcm9jZXNzIHZpYSBG
RCBwYXNzaW5nIHRoYW4gdHJ5IHRvCj4gZ28gdGhlIG90aGVyIHdheS4gVGhlcmUgYXJlIGxvdHMg
b2Ygc2VjdXJpdHkgcXVlc3Rpb25zIHdpdGggc29tZXRoaW5nCj4gbGlrZSBtbV9hY2Nlc3MuCj4g
CgpUaGFuayB5b3UgYWxsIGZvciB0aGUgaW5wdXQsIGl0IHNvdW5kcyBsaWtlIHdlIGFyZSBPSyB0
byByZW1vdmUgbW0gYXJndW1lbnQKZnJvbSBpb21tdV9zdmFfYmluZF9kZXZpY2UoKSBhbmQgaW9t
bXVfc3ZhX2FsbG9jX3Bhc2lkKCkgZm9yIG5vdz8KCkxldCBtZSB0cnkgdG8gc3VtbWFyaXplIFBB
U0lEIGFsbG9jYXRpb24gYXMgYmVsb3c6CgpJbnRlcmZhY2VzCXwgVXNhZ2UJfCAgTGltaXQJfCBi
aW5kwrkgfFVzZXIgdmlzaWJsZQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQovZGV2L2lvYXNpZMKyCXwgRy1TVkEvSU9W
QQl8ICBjZ3JvdXAJfCBObwl8WWVzCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCmNoYXIgZGV2wrMJfCBTVkEJCXwgIGNn
cm91cAl8IFllcwl8Tm8KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KaW9tbXUgZHJpdmVyCXwgZGVmYXVsdCBQQVNJRHwg
IG5vCQl8IE5vCXxObwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQprZXJuZWwJCXwgc3VwZXIgU1ZBCXwgbm8JCXwgeWVz
ICAgfE5vCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCgrCuSBBbGxvY2F0ZWQgZHVyaW5nIFNWQSBiaW5kCsKyIFBBU0lE
cyBhbGxvY2F0ZWQgdmlhIC9kZXYvaW9hc2lkIGFyZSBub3QgYm91bmQgdG8gYW55IG1tLiBCdXQg
aXRzCiAgb3duZXJzaGlwIGlzIGFzc2lnbmVkIHRvIHRoZSBwcm9jZXNzIHRoYXQgZG9lcyB0aGUg
YWxsb2NhdGlvbi4KwrMgSW5jbHVkZSB1YWNjZSwgb3RoZXIgcHJpdmF0ZSBkZXZpY2UgZHJpdmVy
IGNoYXIgZGV2IHN1Y2ggYXMgaWR4ZAoKQ3VycmVudGx5LCB0aGUgcHJvcG9zZWQgL2Rldi9pb2Fz
aWQgaW50ZXJmYWNlIGRvZXMgbm90IG1hcCBpbmRpdmlkdWFsIFBBU0lECndpdGggYW4gRkQuIFRo
ZSBGRCBpcyBhdCB0aGUgaW9hc2lkX3NldCBncmFudWxhcml0eSBhbmQgYm9uZCB0byB0aGUgY3Vy
cmVudAptbS4gV2UgY291bGQgZXh0ZW5kIHRoZSBJT0NUTHMgdG8gY292ZXIgaW5kaXZpZHVhbCBQ
QVNJRC1GRCBwYXNzaW5nIGNhc2UKd2hlbiB1c2UgY2FzZXMgYXJpc2UuIFdvdWxkIHRoaXMgd29y
az8KClRoYW5rcywKCkphY29iCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
