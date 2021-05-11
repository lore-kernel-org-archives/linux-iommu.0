Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BEEC433ED
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:13:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51526188B
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51526188B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92E4A60664;
	Tue, 11 May 2021 16:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9J4l0qHFEUC6; Tue, 11 May 2021 16:12:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8007860674;
	Tue, 11 May 2021 16:12:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB59C000E;
	Tue, 11 May 2021 16:12:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98EA8C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79B1540574
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JeV5U2RSqxZs for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:12:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC24240572
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=BHBUlVYkvN7U/TbnhdmSfxdbBO7hmMx8+ZQaSS91pAY=; b=rsu7y4L6BqjnqY43bR2EjC+q8w
 I21N4GuEIsZtEN66HoQVR0eBUqXn9sLnhmeyjs1LmpX8ONK+4bR40It7S3HEyHUIadkFTRMjL6PnS
 bB0n5Fr7Zjp0fYF0PszR86jiQekrG0/YiMxjzKlvZ/EcoIT5WUU+u4BdzM71EtarOlouiAJGtNWbC
 OG0YRsSDn0akFPUGxxgbghzFEP500GKyJxOfhhP+VXZH6y4SdBhM2JjpjA9kGzUYu84S0WPnK8dl7
 8QQukFL6DMVaPGaBHKFNGJzPQm7aOqvldJK3cdI6OmASeQ1CBV71z6pmz8w0UZUeslplJDlf0fzGw
 VvW5QwDQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lgUzy-0006Xk-Lw; Tue, 11 May 2021 10:12:43 -0600
To: Don Dutile <ddutile@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
 <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
Date: Tue, 11 May 2021 10:12:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, robin.murphy@arm.com,
 ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com,
 dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com,
 andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com, ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

CgpPbiAyMDIxLTA1LTExIDEwOjA1IGEubS4sIERvbiBEdXRpbGUgd3JvdGU6Cj4gT24gNS8xLzIx
IDExOjU4IFBNLCBKb2huIEh1YmJhcmQgd3JvdGU6Cj4+IE9uIDQvOC8yMSAxMDowMSBBTSwgTG9n
YW4gR3VudGhvcnBlIHdyb3RlOgo+Pj4gSW4gb3JkZXIgdG8gY2FsbCB1cHN0cmVhbV9icmlkZ2Vf
ZGlzdGFuY2Vfd2FybigpIGZyb20gYSBkbWFfbWFwIGZ1bmN0aW9uLAo+Pj4gaXQgbXVzdCBub3Qg
c2xlZXAuIFRoZSBvbmx5IHJlYXNvbiBpdCBkb2VzIHNsZWVwIGlzIHRvIGFsbG9jYXRlIHRoZSBz
ZXFidWYKPj4+IHRvIHByaW50IHdoaWNoIGRldmljZXMgYXJlIHdpdGhpbiB0aGUgQUNTIHBhdGgu
Cj4+Pgo+Pj4gU3dpdGNoIHRoZSBrbWFsbG9jIGNhbGwgdG8gdXNlIGEgcGFzc2VkIGluIGdmcF9t
YXNrIGFuZCBkb24ndCBwcmludCB0aGF0Cj4+PiBtZXNzYWdlIGlmIHRoZSBidWZmZXIgZmFpbHMg
dG8gYmUgYWxsb2NhdGVkLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8
bG9nYW5nQGRlbHRhdGVlLmNvbT4KPj4+IEFja2VkLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fh
c0Bnb29nbGUuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL3BjaS9wMnBkbWEuYyB8IDIxICsr
KysrKysrKysrLS0tLS0tLS0tLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wMnBk
bWEuYyBiL2RyaXZlcnMvcGNpL3AycGRtYS5jCj4+PiBpbmRleCAxOTYzODI2MzAzNjMuLmJkODk0
MzdmYWYwNiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvcGNpL3AycGRtYS5jCj4+PiArKysgYi9k
cml2ZXJzL3BjaS9wMnBkbWEuYwo+Pj4gQEAgLTI2Nyw3ICsyNjcsNyBAQCBzdGF0aWMgaW50IHBj
aV9icmlkZ2VfaGFzX2Fjc19yZWRpcihzdHJ1Y3QgcGNpX2RldiAqcGRldikKPj4+IMKgIMKgIHN0
YXRpYyB2b2lkIHNlcV9idWZfcHJpbnRfYnVzX2RldmZuKHN0cnVjdCBzZXFfYnVmICpidWYsIHN0
cnVjdCBwY2lfZGV2ICpwZGV2KQo+Pj4gwqAgewo+Pj4gLcKgwqDCoCBpZiAoIWJ1ZikKPj4+ICvC
oMKgwqAgaWYgKCFidWYgfHwgIWJ1Zi0+YnVmZmVyKQo+Pgo+PiBUaGlzIGlzIG5vdCBncmVhdCwg
c29ydCBvZiBmcm9tIGFuIG92ZXJhbGwgZGVzaWduIHBvaW50IG9mIHZpZXcsIGV2ZW4gdGhvdWdo
Cj4+IGl0IG1ha2VzIHRoZSByZXN0IG9mIHRoZSBwYXRjaCB3b3JrLiBTZWUgYmVsb3cgZm9yIG90
aGVyIGlkZWFzLCB0aGF0IHdpbGwKPj4gYXZvaWQgdGhlIG5lZWQgZm9yIHRoaXMgc29ydCBvZiBv
ZGQgcG9pbnQgZml4Lgo+Pgo+ICsxLgo+IEluIGZhY3QsIEkgZGlkbid0IHNlZSBob3cgdGhlIGtt
YWxsb2Mgd2FzIGNoYW5nZWQuLi4geW91IHJlZmFjdG9yZWQgdGhlIGNvZGUgdG8gcGFzcy1pbiB0
aGUKPiBHRlBfS0VSTkVMIHRoYXQgd2FzIG9yaWdpbmFsbHkgaGFyZC1jb2RlZCBpbnRvIHVwc3Ry
ZWFtX2JyaWRnZV9kaXN0YW5jZV93YXJuKCk7Cj4gSSBkb24ndCBzZWUgaG93IHRoYXQgYXZvaWRl
ZCB0aGUga21hbGxvYygpIGNhbGwuCj4gaW4gZmFjdCwgSSBhbHNvIHNlZSB5b3UgbG9zdCBhIGZh
aWxlZCBrbWFsbG9jKCkgY2hlY2ssIHNvIGl0IHNlZW1zIHRvIGhhdmUgdGFrZW4gYSBzdGVwIGJh
Y2suCgpJJ3ZlIGNoYW5nZWQgdGhpcyBpbiB2MiB0byBqdXN0IHVzZSBzb21lIG1lbW9yeSBhbGxv
Y2F0ZWQgb24gdGhlIHN0YWNrLgpBdm9pZHMgdGhpcyBhcmd1bWVudCBhbGwgdG9nZXRoZXIuCgpM
b2dhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
