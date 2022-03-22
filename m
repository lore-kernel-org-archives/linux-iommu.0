Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0024C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 19:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56CDD418DC;
	Tue, 22 Mar 2022 19:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zoqcRE9tZ09w; Tue, 22 Mar 2022 19:31:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3046D418CF;
	Tue, 22 Mar 2022 19:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D74ACC0012;
	Tue, 22 Mar 2022 19:31:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 447F2C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 322C840B0F
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qPOnPeqGZD5K for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 19:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1417C40004
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:31:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0299023A;
 Tue, 22 Mar 2022 12:31:37 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CD2D3F66F;
 Tue, 22 Mar 2022 12:31:35 -0700 (PDT)
Message-ID: <065a11de-da43-6854-f940-d1537227f191@arm.com>
Date: Tue, 22 Mar 2022 19:31:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 01/11] ACPI/IORT: Add temporary RMR node flag
 definitions
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-2-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221154344.2126-2-shameerali.kolothum.thodi@huawei.com>
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 will@kernel.org, wanghuiqiang@huawei.com
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

T24gMjAyMi0wMi0yMSAxNTo0MywgU2hhbWVlciBLb2xvdGh1bSB2aWEgaW9tbXUgd3JvdGU6Cj4g
SU9SVCByZXYgRS5kIGludHJvZHVjZXMgbW9yZSBkZXRhaWxzIGludG8gdGhlIFJNUiBub2RlIEZs
YWdzCj4gZmllbGQuIEFkZCB0ZW1wb3JhcnkgZGVmaW5pdGlvbnMgdG8gZGVzY3JpYmUgYW5kIGFj
Y2VzcyB0aGVzZQo+IEZsYWdzIGZpZWxkIHVudGlsIEFDUElDQSBoZWFkZXIgaXMgdXBkYXRlZCB0
byBzdXBwb3J0IEUuZC4KPiAKPiBUaGlzIHBhdGNoIGNhbiBiZSByZXZlcnRlZMKgb25jZSB0aGUg
aW5jbHVkZS9hY3BpL2FjdGJsMi5oIGhhcwo+IGFsbCB0aGUgcmVsZXZhbnTCoGRlZmluaXRpb25z
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNoYW1lZXJhbGkua29sb3Ro
dW0udGhvZGlAaHVhd2VpLmNvbT4KPiAtLS0KPiBQbGVhc2UgZmluZCB0aGUgQUNQSUNBIEUuZCBy
ZWxhdGVkIGNoYW5nZXMgcHVsbCByZXF1ZXN0IGhlcmUsCj4gaHR0cHM6Ly9naXRodWIuY29tL2Fj
cGljYS9hY3BpY2EvcHVsbC83NTIKPiAKPiAtLS0KPiAgIGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0
LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNCBp
bnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMg
Yi9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCj4gaW5kZXggZjJmOGYwNTY2MmRlLi4wNzMwYzRk
YmI3MDAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYwo+ICsrKyBiL2Ry
aXZlcnMvYWNwaS9hcm02NC9pb3J0LmMKPiBAQCAtMjUsNiArMjUsMzAgQEAKPiAgICNkZWZpbmUg
SU9SVF9JT01NVV9UWVBFCQkoKDEgPDwgQUNQSV9JT1JUX05PREVfU01NVSkgfAlcCj4gICAJCQkJ
KDEgPDwgQUNQSV9JT1JUX05PREVfU01NVV9WMykpCj4gICAKPiArLyoKPiArICogVGhlIGZvbGxv
d2luZyBSTVIgcmVsYXRlZCBkZWZpbml0aW9ucyBhcmUgdGVtcG9yYXJ5IGFuZAo+ICsgKiBjYW4g
YmUgcmVtb3ZlZCBvbmNlIEFDUElDQSBoZWFkZXJzIHN1cHBvcnQgSU9SVCByZXYgRS5kCj4gKyAq
Lwo+ICsjaWZuZGVmIEFDUElfSU9SVF9STVJfUkVNQVBfUEVSTUlUVEVECj4gKyNkZWZpbmUgQUNQ
SV9JT1JUX1JNUl9SRU1BUF9QRVJNSVRURUQJKDEpCj4gKyNlbmRpZgo+ICsKPiArI2lmbmRlZiBB
Q1BJX0lPUlRfUk1SX0FDQ0VTU19QUklWSUxFR0UKPiArI2RlZmluZSBBQ1BJX0lPUlRfUk1SX0FD
Q0VTU19QUklWSUxFR0UJKDEgPDwgMSkKPiArI2VuZGlmCj4gKwo+ICsjaWZuZGVmIEFDUElfSU9S
VF9STVJfQUNDRVNTX0FUVFJJQlVURVMKPiArI2RlZmluZSBBQ1BJX0lPUlRfUk1SX0FDQ0VTU19B
VFRSSUJVVEVTKGZsYWdzKQkoKChmbGFncykgPj4gMikgJiAweEZGKQo+ICsjZW5kaWYKPiArCj4g
KyNpZm5kZWYgQUNQSV9JT1JUX1JNUl9BVFRSX0RFVklDRV9HUkUKPiArI2RlZmluZSBBQ1BJX0lP
UlRfUk1SX0FUVFJfREVWSUNFX0dSRQkweDAzCj4gKyNlbmRpZgo+ICsKPiArI2lmbmRlZiBBQ1BJ
X0lPUlRfUk1SX0FUVFJfTk9STUFMCj4gKyNkZWZpbmUgQUNQSV9JT1JUX1JNUl9BVFRSX05PUk1B
TAkweDA1CgpGb3IgdGhlIHJlY29yZCwgSSd2ZSBjb21tZW50ZWQgZGlyZWN0bHkgb24gdGhlIEFD
UElDQSBwdWxsIHJlcXVlc3QgdGhhdCAKSSB0aGluayB0aGlzIHNob3VsZCBiZSBtb3JlIGNsZWFy
bHkgbmFtZWQgdG8gaW5kaWNhdGUgdGhhdCBpdCBtZWFucyAKTm9ybWFsIFdyaXRlLUJhY2sgQ2Fj
aGVhYmxlLCByYXRoZXIgdGhhbiBiZWluZyBwb3RlbnRpYWxseSBhbWJpZ3VvdXMgCmFib3V0IGNh
Y2hlYWJpbGl0eS4KClJvYmluLgoKPiArI2VuZGlmCj4gKwo+ICAgc3RydWN0IGlvcnRfaXRzX21z
aV9jaGlwIHsKPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkCWxpc3Q7Cj4gICAJc3RydWN0IGZ3bm9kZV9o
YW5kbGUJKmZ3X25vZGU7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
