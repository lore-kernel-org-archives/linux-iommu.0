Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B0C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 20:09:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EF960F41
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 20:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35EF960F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC8EE40253;
	Tue, 10 Aug 2021 20:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CLM2WIcYRP6s; Tue, 10 Aug 2021 20:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AED71403C7;
	Tue, 10 Aug 2021 20:09:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DAB5C001A;
	Tue, 10 Aug 2021 20:09:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9339C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7D30403C7
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYcsCsKQCOo6 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 20:09:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F24E340253
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:09:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="202152496"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; d="scan'208";a="202152496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2021 13:09:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; d="scan'208";a="515971399"
Received: from pdmuelle-desk2.amr.corp.intel.com (HELO
 skuppusw-mobl5.amr.corp.intel.com) ([10.213.166.202])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2021 13:09:05 -0700
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4f9effcb-055b-51ee-6722-c9f0cc1d8acf@linux.intel.com>
Date: Tue, 10 Aug 2021 13:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
Content-Language: en-US
Cc: Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Daniel Vetter <daniel@ffwll.ch>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
 Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

CgpPbiA4LzEwLzIxIDEyOjQ4IFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4gT24gOC8xMC8yMSAx
OjQ1IFBNLCBLdXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDcv
MjcvMjEgMzoyNiBQTSwgVG9tIExlbmRhY2t5IHdyb3RlOgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2tlcm5lbC9oZWFkNjQuYyBiL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYwo+Pj4gaW5kZXgg
ZGUwMTkwM2MzNzM1Li5jYWZlZDY0NTZkNDUgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvaGVhZDY0LmMKPj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYwo+Pj4gQEAgLTE5
LDcgKzE5LDcgQEAKPj4+ICDCoCAjaW5jbHVkZSA8bGludXgvc3RhcnRfa2VybmVsLmg+Cj4+PiAg
wqAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+Cj4+PiAgwqAgI2luY2x1ZGUgPGxpbnV4L21lbWJsb2Nr
Lmg+Cj4+PiAtI2luY2x1ZGUgPGxpbnV4L21lbV9lbmNyeXB0Lmg+Cj4+PiArI2luY2x1ZGUgPGxp
bnV4L3Byb3RlY3RlZF9ndWVzdC5oPgo+Pj4gIMKgICNpbmNsdWRlIDxsaW51eC9wZ3RhYmxlLmg+
Cj4+PiAgwqAgwqAgI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KPj4+IEBAIC0yODUsNyArMjg1
LDcgQEAgdW5zaWduZWQgbG9uZyBfX2hlYWQgX19zdGFydHVwXzY0KHVuc2lnbmVkIGxvbmcKPj4+
IHBoeXNhZGRyLAo+Pj4gIMKgwqDCoMKgwqDCoCAqIHRoZXJlIGlzIG5vIG5lZWQgdG8gemVybyBp
dCBhZnRlciBjaGFuZ2luZyB0aGUgbWVtb3J5IGVuY3J5cHRpb24KPj4+ICDCoMKgwqDCoMKgwqAg
KiBhdHRyaWJ1dGUuCj4+PiAgwqDCoMKgwqDCoMKgICovCj4+PiAtwqDCoMKgIGlmIChtZW1fZW5j
cnlwdF9hY3RpdmUoKSkgewo+Pj4gK8KgwqDCoCBpZiAocHJvdF9ndWVzdF9oYXMoUEFUVFJfTUVN
X0VOQ1JZUFQpKSB7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyID0gKHVuc2lnbmVkIGxv
bmcpX19zdGFydF9ic3NfZGVjcnlwdGVkOwo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCB2YWRkcl9l
bmQgPSAodW5zaWduZWQgbG9uZylfX2VuZF9ic3NfZGVjcnlwdGVkOwo+Pgo+Pgo+PiBTaW5jZSB0
aGlzIGNoYW5nZSBpcyBzcGVjaWZpYyB0byBBTUQsIGNhbiB5b3UgcmVwbGFjZSBQQVRUUl9NRU1f
RU5DUllQVCB3aXRoCj4+IHByb3RfZ3Vlc3RfaGFzKFBBVFRSX1NNRSkgfHwgcHJvdF9ndWVzdF9o
YXMoUEFUVFJfU0VWKS4gSXQgaXMgbm90IHVzZWQgaW4KPj4gVERYLgo+IAo+IFRoaXMgaXMgYSBk
aXJlY3QgcmVwbGFjZW1lbnQgZm9yIG5vdy4gSSB0aGluayB0aGUgY2hhbmdlIHlvdSdyZSByZXF1
ZXN0aW5nCj4gc2hvdWxkIGJlIGRvbmUgYXMgcGFydCBvZiB0aGUgVERYIHN1cHBvcnQgcGF0Y2hl
cyBzbyBpdCdzIGNsZWFyIHdoeSBpdCBpcwo+IGJlaW5nIGNoYW5nZWQuCgpPay4gSSB3aWxsIGlu
Y2x1ZGUgaXQgcGFydCBvZiBURFggY2hhbmdlcy4KCj4gCj4gQnV0LCB3b3VsZG4ndCBURFggc3Rp
bGwgbmVlZCB0byBkbyBzb21ldGhpbmcgd2l0aCB0aGlzIHNoYXJlZC91bmVuY3J5cHRlZAo+IGFy
ZWEsIHRob3VnaD8gT3Igc2luY2UgaXQgaXMgc2hhcmVkLCB0aGVyZSdzIGFjdHVhbGx5IG5vdGhp
bmcgeW91IG5lZWQgdG8KPiBkbyAodGhlIGJzcyBkZWNycHl0ZWQgc2VjdGlvbiBleGlzdHMgZXZl
biBpZiBDT05GSUdfQU1EX01FTV9FTkNSWVBUIGlzIG5vdAo+IGNvbmZpZ3VyZWQpPwoKS2lyaWxs
IGhhZCBhIHJlcXVpcmVtZW50IHRvIHR1cm4gb24gQ09ORklHX0FNRF9NRU1fRU5DUllQVCBmb3Ig
YWRkaW5nIGxhenkKYWNjZXB0IHN1cHBvcnQgaW4gVERYIGd1ZXN0IGtlcm5lbC4gS2lyaWxsLCBj
YW4geW91IGFkZCBkZXRhaWxzIGhlcmU/Cgo+IAo+IFRoYW5rcywKPiBUb20KPiAKPj4KCi0tIApT
YXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQpMaW51eCBLZXJuZWwgRGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
