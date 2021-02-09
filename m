Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F933C433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 11:58:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC5464E8B
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 11:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC5464E8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DDFA287363;
	Tue,  9 Feb 2021 11:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m9UHRVFmriUQ; Tue,  9 Feb 2021 11:58:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6AF8D86B47;
	Tue,  9 Feb 2021 11:58:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FD8AC0891;
	Tue,  9 Feb 2021 11:58:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 175FFC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 11:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0D1E187302
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 11:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tfhWtfF01zoy for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 11:58:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 877F2872ED
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 11:58:26 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZhFm2lTgz7hpn;
 Tue,  9 Feb 2021 19:57:00 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Feb 2021
 19:58:15 +0800
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
To: Greg KH <gregkh@linuxfoundation.org>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
 <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
 <YCJX6QFQ4hsNRrFj@kroah.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <f73951ba-84be-b7f8-8c79-db84bc9081f3@hisilicon.com>
Date: Tue, 9 Feb 2021 19:58:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YCJX6QFQ4hsNRrFj@kroah.com>
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Sihang Chen <chensihang1@hisilicon.com>, jgg@ziepe.ca,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 zhangfei.gao@linaro.org, Andrew
 Morton <akpm@linux-foundation.org>, liguozhu@hisilicon.com,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS8yLzkgMTc6MzcsIEdyZWcgS0ggd3JvdGU6Cj4gT24gVHVlLCBGZWIgMDksIDIwMjEg
YXQgMDU6MTc6NDZQTSArMDgwMCwgWmhvdSBXYW5nIHdyb3RlOgo+PiBPbiAyMDIxLzIvOCA2OjAy
LCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+Pgo+Pj4KPj4+PiBPbiBGZWIgNywgMjAyMSwgYXQg
MTI6MzEgQU0sIFpob3UgV2FuZyA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+IHdyb3RlOgo+Pj4+
Cj4+Pj4g77u/U1ZBKHNoYXJlIHZpcnR1YWwgYWRkcmVzcykgb2ZmZXJzIGEgd2F5IGZvciBkZXZp
Y2UgdG8gc2hhcmUgcHJvY2VzcyB2aXJ0dWFsCj4+Pj4gYWRkcmVzcyBzcGFjZSBzYWZlbHksIHdo
aWNoIG1ha2VzIG1vcmUgY29udmVuaWVudCBmb3IgdXNlciBzcGFjZSBkZXZpY2UKPj4+PiBkcml2
ZXIgY29kaW5nLiBIb3dldmVyLCBJTyBwYWdlIGZhdWx0cyBtYXkgaGFwcGVuIHdoZW4gZG9pbmcg
RE1BCj4+Pj4gb3BlcmF0aW9ucy4gQXMgdGhlIGxhdGVuY3kgb2YgSU8gcGFnZSBmYXVsdCBpcyBy
ZWxhdGl2ZWx5IGJpZywgRE1BCj4+Pj4gcGVyZm9ybWFuY2Ugd2lsbCBiZSBhZmZlY3RlZCBzZXZl
cmVseSB3aGVuIHRoZXJlIGFyZSBJTyBwYWdlIGZhdWx0cy4KPj4+PiBGcm9tIGEgbG9uZyB0ZXJt
IHZpZXcsIERNQSBwZXJmb3JtYW5jZSB3aWxsIGJlIG5vdCBzdGFibGUuCj4+Pj4KPj4+PiBJbiBo
aWdoLXBlcmZvcm1hbmNlIEkvTyBjYXNlcywgYWNjZWxlcmF0b3JzIG1pZ2h0IHdhbnQgdG8gcGVy
Zm9ybQo+Pj4+IEkvTyBvbiBhIG1lbW9yeSB3aXRob3V0IElPIHBhZ2UgZmF1bHRzIHdoaWNoIGNh
biByZXN1bHQgaW4gZHJhbWF0aWNhbGx5Cj4+Pj4gaW5jcmVhc2VkIGxhdGVuY3kuIEN1cnJlbnQg
bWVtb3J5IHJlbGF0ZWQgQVBJcyBjb3VsZCBub3QgYWNoaWV2ZSB0aGlzCj4+Pj4gcmVxdWlyZW1l
bnQsIGUuZy4gbWxvY2sgY2FuIG9ubHkgYXZvaWQgbWVtb3J5IHRvIHN3YXAgdG8gYmFja3VwIGRl
dmljZSwKPj4+PiBwYWdlIG1pZ3JhdGlvbiBjYW4gc3RpbGwgdHJpZ2dlciBJTyBwYWdlIGZhdWx0
Lgo+Pj4+Cj4+Pj4gVmFyaW91cyBkcml2ZXJzIHdvcmtpbmcgdW5kZXIgdHJhZGl0aW9uYWwgbm9u
LVNWQSBtb2RlIGFyZSB1c2luZwo+Pj4+IHRoZWlyIG93biBzcGVjaWZpYyBpb2N0bCB0byBkbyBw
aW4uIFN1Y2ggaW9jdGwgY2FuIGJlIHNlZW4gaW4gdjRsMiwKPj4+PiBncHUsIGluZmluaWJhbmQs
IG1lZGlhLCB2ZmlvLCBldGMuIERyaXZlcnMgYXJlIHVzdWFsbHkgZG9pbmcgZG1hCj4+Pj4gbWFw
cGluZyB3aGlsZSBkb2luZyBwaW4uCj4+Pj4KPj4+PiBCdXQsIGluIFNWQSBtb2RlLCBwaW4gY291
bGQgYmUgYSBjb21tb24gbmVlZCB3aGljaCBpc24ndCBuZWNlc3NhcmlseQo+Pj4+IGJvdW5kIHdp
dGggYW55IGRyaXZlcnMsIGFuZCBuZWl0aGVyIGlzIGRtYSBtYXBwaW5nIG5lZWRlZCBieSBkcml2
ZXJzCj4+Pj4gc2luY2UgZGV2aWNlcyBhcmUgdXNpbmcgdGhlIHZpcnR1YWwgYWRkcmVzcyBvZiBD
UFUuIFRodXMsIEl0IGlzIGJldHRlcgo+Pj4+IHRvIGludHJvZHVjZSBhIG5ldyBjb21tb24gc3lz
Y2FsbCBmb3IgaXQuCj4+Pj4KPj4+PiBUaGlzIHBhdGNoIGxldmVyYWdlcyB0aGUgZGVzaWduIG9m
IHVzZXJmYXVsdGZkIGFuZCBhZGRzIG1lbXBpbmZkIGZvciBwaW4KPj4+PiB0byBhdm9pZCBtZXNz
aW5nIHVwIG1tX3N0cnVjdC4gQSBmZCB3aWxsIGJlIGdvdCBieSBtZW1waW5mZCwgdGhlbiB1c2Vy
Cj4+Pj4gc3BhY2UgY2FuIGRvIHBpbi91bnBpbiBwYWdlcyBieSBpb2N0bHMgb2YgdGhpcyBmZCwg
YWxsIHBpbm5lZCBwYWdlcyB1bmRlcgo+Pj4+IG9uZSBmaWxlIHdpbGwgYmUgdW5waW5uZWQgaW4g
ZmlsZSByZWxlYXNlIHByb2Nlc3MuIExpa2UgcGluIHBhZ2UgY2FzZXMgaW4KPj4+PiBvdGhlciBw
bGFjZXMsIGNhbl9kb19tbG9jayBpcyB1c2VkIHRvIGNoZWNrIHBlcm1pc3Npb24gYW5kIGlucHV0
Cj4+Pj4gcGFyYW1ldGVycy4KPj4+Cj4+Pgo+Pj4gQ2FuIHlvdSBkb2N1bWVudCB3aGF0IHRoZSBz
eXNjYWxsIGRvZXM/Cj4+Cj4+IFdpbGwgYWRkIHJlbGF0ZWQgZG9jdW1lbnQgaW4gRG9jdW1lbnRh
dGlvbi92bS4KPiAKPiBBIG1hbnBhZ2UgaXMgYWx3YXlzIGdvb2QsIGFuZCB3aWxsIGJlIHJlcXVp
cmVkIGV2ZW50dWFsbHkgOikKCm1hbnBhZ2UgaXMgbWFpbnRhaW5lZCBpbiBhbm90aGVyIHJlcG8u
IERvIHlvdSBtZWFuIGFkZCBhIG1hbnBhZ2UKcGF0Y2ggaW4gdGhpcyBzZXJpZXM/CgpCZXN0LApa
aG91Cgo+IAo+IHRoYW5rcywKPiAKPiBncmVnIGstaAo+IAo+IC4KPiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
