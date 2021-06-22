Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE32C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 22:25:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2BE60FF2
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 22:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2BE60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 350F9401C7;
	Tue, 22 Jun 2021 22:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXi1cpnMeL9b; Tue, 22 Jun 2021 22:25:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 09D26400BE;
	Tue, 22 Jun 2021 22:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEBBFC001A;
	Tue, 22 Jun 2021 22:25:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBEBC000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 22:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C67836073A
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 22:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l3jY1dtNzrBp for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 22:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC0866071B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 22:25:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB477ED1;
 Tue, 22 Jun 2021 15:25:21 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08D383F694;
 Tue, 22 Jun 2021 15:25:19 -0700 (PDT)
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: Lu Baolu <baolu.lu@linux.intel.com>, John Garry <john.garry@huawei.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
 <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
 <5564e4b7-99af-c357-594a-1a6efe0c1464@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <cff9f6ef-0f51-797d-0853-5237f5c10555@arm.com>
Date: Tue, 22 Jun 2021 23:25:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5564e4b7-99af-c357-594a-1a6efe0c1464@linux.intel.com>
Content-Language: en-GB
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

T24gMjAyMS0wNi0yMSAxNTozMiwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4gCj4gT24g
MjAyMS82LzIxIDE5OjU5LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjEtMDYtMjEgMTE6
MzQsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+PiBPbiAyMS8wNi8yMDIxIDExOjAwLCBMdSBCYW9sdSB3
cm90ZToKPj4+Pj4gdm9pZCBpb21tdV9zZXRfZG1hX3N0cmljdChib29sIGZvcmNlKQo+Pj4+PiB7
Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZm9yY2UgPT0gdHJ1ZSkKPj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoCBpb21tdV9kbWFfc3RyaWN0ID0gdHJ1ZTsKPj4+Pj4gwqDCoMKgwqDCoGVsc2Ug
aWYgKCEoaW9tbXVfY21kX2xpbmUgJiBJT01NVV9DTURfTElORV9TVFJJQ1QpKQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSB0cnVlOwo+Pj4+PiB9Cj4+Pj4+Cj4+Pj4+
IFNvIHdlIHdvdWxkIHVzZSBpb21tdV9zZXRfZG1hX3N0cmljdCh0cnVlKSBmb3IgYSkgYW5kIGIp
LCBidXQgCj4+Pj4+IGlvbW11X3NldF9kbWFfc3RyaWN0KGZhbHNlKSBmb3IgYykuCj4+Pj4KPj4+
PiBZZXMuIFdlIG5lZWQgdG8gZGlzdGluZ3Vpc2ggdGhlICJtdXN0IiBhbmQgIm5pY2UtdG8taGF2
ZSIgY2FzZXMgb2YKPj4+PiBzZXR0aW5nIHN0cmljdCBtb2RlLgo+Pj4+Cj4+Pj4+Cj4+Pj4+IFRo
ZW4gSSBhbSBub3Qgc3VyZSB3aGF0IHlvdSB3YW50IHRvIGRvIHdpdGggdGhlIGFjY29tcGFueWlu
ZyBwcmludCAKPj4+Pj4gZm9yIGMpLiBJdCB3YXM6Cj4+Pj4+ICJJT01NVSBiYXRjaGluZyBpcyBk
aXNhYmxlZCBkdWUgdG8gdmlydHVhbGl6YXRpb24iCj4+Pj4+Cj4+Pj4+IEFuZCBub3cgaXMgZnJv
bSB0aGlzIHNlcmllczoKPj4+Pj4gIklPTU1VIGJhdGNoaW5nIGRpc2FsbG93ZWQgZHVlIHRvIHZp
cnR1YWxpemF0aW9uIgo+Pj4+Pgo+Pj4+PiBVc2luZyBpb21tdV9nZXRfZG1hX3N0cmljdChkb21h
aW4pIGlzIG5vdCBhcHByb3ByaWF0ZSBoZXJlIHRvIGtub3cgCj4+Pj4+IHRoZSBjdXJyZW50IG1v
ZGUgKHNvIHdlIGtub3cgd2hldGhlciB0byBwcmludCkuCj4+Pj4+Cj4+Pj4+IE5vdGUgdGhhdCB0
aGlzIGNoYW5nZSB3b3VsZCBtZWFuIHRoYXQgdGhlIGN1cnJlbnQgc2VyaWVzIHdvdWxkIAo+Pj4+
PiByZXF1aXJlIG5vbi10cml2aWFsIHJld29yaywgd2hpY2ggd291bGQgYmUgdW5mb3J0dW5hdGUg
c28gbGF0ZSBpbiAKPj4+Pj4gdGhlIGN5Y2xlLgo+Pj4+Cj4+Pj4gVGhpcyBwYXRjaCBzZXJpZXMg
bG9va3MgZ29vZCB0byBtZSBhbmQgSSBoYXZlIGFkZGVkIGJ5IHJldmlld2VkLWJ5Lgo+Pj4+IFBy
b2JhYmx5IHdlIGNvdWxkIG1ha2UgYW5vdGhlciBwYXRjaCBzZXJpZXMgdG8gaW1wcm92ZSBpdCBz
byB0aGF0IHRoZQo+Pj4+IGtlcm5lbCBvcHRpbWl6YXRpb24gc2hvdWxkIG5vdCBvdmVycmlkZSB0
aGUgdXNlciBzZXR0aW5nLgo+Pj4KPj4+IE9uIGEgcGVyc29uYWwgbGV2ZWwgSSB3b3VsZCBiZSBo
YXBweSB3aXRoIHRoYXQgYXBwcm9hY2gsIGJ1dCBJIHRoaW5rIAo+Pj4gaXQncyBiZXR0ZXIgdG8g
bm90IHN0YXJ0IGNoYW5naW5nIHRoaW5ncyByaWdodCBhd2F5IGluIGEgZm9sbG93LXVwIAo+Pj4g
c2VyaWVzLgo+Pj4KPj4+IFNvIGhvdyBhYm91dCB3ZSBhZGQgdGhpcyBwYXRjaCAod2hpY2ggcmVw
bGFjZXMgNi82ICJpb21tdTogUmVtb3ZlIAo+Pj4gbW9kZSBhcmd1bWVudCBmcm9tIGlvbW11X3Nl
dF9kbWFfc3RyaWN0KCkiKT8KPj4+Cj4+PiBSb2JpbiwgYW55IG9waW5pb24/Cj4+Cj4+IEZvciBt
ZSBpdCBib2lscyBkb3duIHRvIHdoZXRoZXIgdGhlcmUgYXJlIGFueSByZWFsaXN0aWMgd29ya2xv
YWRzIAo+PiB3aGVyZSBub24tc3RyaWN0IG1vZGUgKndvdWxkKiBzdGlsbCBwZXJmb3JtIGJldHRl
ciB1bmRlciAKPj4gdmlydHVhbGlzYXRpb24uIFRoZSAKPiAKPiBBdCBwcmVzZW50LCB3ZSBzZWUg
dGhhdCBzdHJpY3QgbW9kZSBoYXMgYmV0dGVyIHBlcmZvcm1hbmNlIGluIHRoZQo+IHZpcnR1YWxp
emF0aW9uIGVudmlyb25tZW50IGJlY2F1c2UgaXQgd2lsbCBtYWtlIHRoZSBzaGFkb3cgcGFnZSB0
YWJsZQo+IG1hbmFnZW1lbnQgbW9yZSBlZmZpY2llbnQuIFdoZW4gdGhlIGhhcmR3YXJlIHN1cHBv
cnRzIG5lc3RlZAo+IHRyYW5zbGF0aW9uLCB3ZSBtYXkgaGF2ZSB0byByZS1ldmFsdWF0ZSB0aGlz
IHNpbmNlIHRoZXJlJ3Mgbm8gbmVlZCBmb3IKPiBhIHNoYWRvd2luZyBwYWdlIHRhYmxlIGFueW1v
cmUuCgpJIGd1ZXNzIEkgd2FzIGFzc3VtaW5nIHRoYXQgaW4gbW9zdCBjYXNlcywgcHJvcGVyIG5l
c3RlZCBtb2RlIGNvdWxkIGxvb2sgCmRpc3RpbmN0IGVub3VnaCB0aGF0IHdlJ2QgYmUgYWJsZSB0
byB0cmVhdCBpdCBkaWZmZXJlbnRseSBpbiB0aGUgZmlyc3QgCnBsYWNlLiBGb3IgaW5zdGFuY2Us
IGlmIGl0J3MgaGFuZGluZyBndWVzdCB0YWJsZXMgZGlyZWN0bHkgdG8gdGhlIApoYXJkd2FyZSwg
d291bGQgdGhlIGhvc3QgaGF2ZSBhbnkgcmVhc29uIHRvIHN0aWxsIHNldCB0aGUgImNhY2hpbmcg
bW9kZSIgCklEIGJpdD8KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
