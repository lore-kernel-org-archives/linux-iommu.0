Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08801C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 11:01:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE0B64F2B
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 11:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE0B64F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FA494ED72;
	Thu, 18 Mar 2021 11:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JvDhXKCMPUcp; Thu, 18 Mar 2021 11:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D778F4ED39;
	Thu, 18 Mar 2021 11:01:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5BE8C000B;
	Thu, 18 Mar 2021 11:01:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61E1DC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 11:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FF3D4ED49
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 11:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2mr0rE76IYpr for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 11:01:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D9B94ED39
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 11:01:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 345E2ED1;
 Thu, 18 Mar 2021 04:01:40 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843983F792;
 Thu, 18 Mar 2021 04:01:39 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Fix a typo in a comment
To: "chenxiang (M)" <chenxiang66@hisilicon.com>, Will Deacon <will@kernel.org>
References: <1616037684-59399-1-git-send-email-chenxiang66@hisilicon.com>
 <20210318093410.GA6574@willie-the-truck>
 <c378734f-33d5-1426-fa41-2bd8064ceec4@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8eef75b4-8f69-3dff-d46a-170aa8b30a53@arm.com>
Date: Thu, 18 Mar 2021 11:01:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c378734f-33d5-1426-fa41-2bd8064ceec4@hisilicon.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org
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

T24gMjAyMS0wMy0xOCAwOTo1NSwgY2hlbnhpYW5nIChNKSB3cm90ZToKPiBIaSB3aWxsLAo+IAo+
IAo+IOWcqCAyMDIxLzMvMTggMTc6MzQsIFdpbGwgRGVhY29uIOWGmemBkzoKPj4gT24gVGh1LCBN
YXIgMTgsIDIwMjEgYXQgMTE6MjE6MjRBTSArMDgwMCwgY2hlbnhpYW5nIHdyb3RlOgo+Pj4gRnJv
bTogWGlhbmcgQ2hlbiA8Y2hlbnhpYW5nNjZAaGlzaWxpY29uLmNvbT4KPj4+Cj4+PiBGaXggYSB0
eXBlICJTQUMiIHRvICJEQUMiIGluIHRoZSBjb21tZW50IG9mIGZ1bmN0aW9uCj4+PiBpb21tdV9k
bWFfYWxsb2NfaW92YSgpLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFhpYW5nIENoZW4gPGNoZW54
aWFuZzY2QGhpc2lsaWNvbi5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvZG1hLWlv
bW11LmMgfCAyICstCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYyBi
L2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4+IGluZGV4IGFmNzY1YzguLjNiYzE3ZWUgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4+PiArKysgYi9kcml2ZXJz
L2lvbW11L2RtYS1pb21tdS5jCj4+PiBAQCAtNDQzLDcgKzQ0Myw3IEBAIHN0YXRpYyBkbWFfYWRk
cl90IGlvbW11X2RtYV9hbGxvY19pb3ZhKHN0cnVjdCAKPj4+IGlvbW11X2RvbWFpbiAqZG9tYWlu
LAo+Pj4gwqDCoMKgwqDCoCBpZiAoZG9tYWluLT5nZW9tZXRyeS5mb3JjZV9hcGVydHVyZSkKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfbGltaXQgPSBtaW4oZG1hX2xpbWl0LCAKPj4+ICh1NjQp
ZG9tYWluLT5nZW9tZXRyeS5hcGVydHVyZV9lbmQpOwo+Pj4gLcKgwqDCoCAvKiBUcnkgdG8gZ2V0
IFBDSSBkZXZpY2VzIGEgU0FDIGFkZHJlc3MgKi8KPj4+ICvCoMKgwqAgLyogVHJ5IHRvIGdldCBQ
Q0kgZGV2aWNlcyBhIERBQyBhZGRyZXNzICovCj4+PiDCoMKgwqDCoMKgIGlmIChkbWFfbGltaXQg
PiBETUFfQklUX01BU0soMzIpICYmIGRldl9pc19wY2koZGV2KSkKPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBpb3ZhID0gYWxsb2NfaW92YV9mYXN0KGlvdmFkLCBpb3ZhX2xlbiwKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBETUFfQklUX01BU0soMzIp
ID4+IHNoaWZ0LCBmYWxzZSk7Cj4+IFRoaXMgZG9lc24ndCBsb29rIGxpa2UgYSB0eXBvIHRvIG1l
Li4uIFBsZWFzZSBleHBsYWluLgoKQXMgdGhlIGF1dGhvciBvZiBzYWlkIGNvbW1lbnQsIGl0IGlz
IGRlZmluaXRlbHkgbm90IGEgdHlwby4KCj4gSSB0aGluayBpdCBtZWFucyBkb3VibGUtYWRkcmVz
cyBjeWNsZShEQUMpLCBhbmQgaW4gTExEMyA0NTIgcGFnZSwgdGhlcmUgCj4gaXMgYSBkZXNjcmlw
dGlvbiBhYm91dCBpdCAiUENJIGRvdWJsZS1hZGRyZXNzIGN5Y2xlIG1hcHBpbmdzIE5vcm1hbGx5
LAo+IHRoZSBETUEgc3VwcG9ydCBsYXllciB3b3JrcyB3aXRoIDMyLWJpdCBidXMgYWRkcmVzc2Vz
LCBwb3NzaWJseSAKPiByZXN0cmljdGVkIGJ5IGEgc3BlY2lmaWMgZGV2aWNl4oCZcyBETUEgbWFz
ay4gVGhlIFBDSSBidXMsIGhvd2V2ZXIsIGFsc28gCj4gc3VwcG9ydHMgYSA2NC1iaXQgYWRkcmVz
c2luZyBtb2RlLCB0aGUgZG91YmxlLWFkZHJlc3MgY3ljbGUgKERBQykuIgo+IFBsZWFzZSBwb2lu
dCBpdCBvdXQgaWYgaSBhbSB3cm9uZyA6KQoKWWVzLCBub3cgbG9vayBhdCB3aGF0IHRoZSBjb2Rl
IGFib3ZlIGRvZXM6ICppZiogYSBQQ0kgZGV2aWNlIGhhcyBhIERNQSAKbWFzayBncmVhdGVyIHRo
YW4gMzIgYml0cyAoaS5lLiBjYW4gc3VwcG9ydCBkdWFsIGFkZHJlc3MgY3ljbGVzKSwgd2UgCmZp
cnN0IHRyeSBhbiBJT1ZBIGFsbG9jYXRpb24gd2l0aCBhbiBleHBsaWNpdCAzMi1iaXQgbGltaXQg
KGkuZS4gdGhhdCAKY2FuIGJlIGV4cHJlc3NlZCBpbiBhIHNpbmdsZSBhZGRyZXNzIGN5Y2xlKSwg
aW4gdGhlIGhvcGUgdGhhdCB3ZSBkb24ndCAKaGF2ZSB0byBmYWxsIGJhY2sgdG8gYWxsb2NhdGlu
ZyBmcm9tIHRoZSB1cHBlciByYW5nZSBhbmQgZm9yY2luZyB0aGUgCmRldmljZSB0byBhY3R1YWxs
eSB1c2UgREFDIChhbmQgc3VmZmVyIHRoZSBwb3RlbnRpYWwgcGVyZm9ybWFuY2UgaW1wYWN0KS4K
ClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
