Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DE9C282CE
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 13:48:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FB8242DD
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 13:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FB8242DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1E3BBD8F;
	Mon,  3 Jun 2019 13:48:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2D6A32F
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 13:48:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BEDA583A
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 13:48:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6583E15A2;
	Mon,  3 Jun 2019 06:48:04 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45F5B3F246;
	Mon,  3 Jun 2019 06:48:03 -0700 (PDT)
Subject: Re: [PATCH] iommu: replace single-char identifiers in macros
To: Qian Cai <cai@lca.pw>, jroedel@suse.de
References: <1559566783-13627-1-git-send-email-cai@lca.pw>
	<fe5e8da4-38d2-c663-c2e2-70e6d4f7640f@arm.com>
	<1559568571.6132.42.camel@lca.pw>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <deedf85a-35bc-e8be-dd94-6acb775af019@arm.com>
Date: Mon, 3 Jun 2019 14:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559568571.6132.42.camel@lca.pw>
Content-Language: en-GB
Cc: akpm@linux-foundation.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMDMvMDYvMjAxOSAxNDoyOSwgUWlhbiBDYWkgd3JvdGU6Cj4gT24gTW9uLCAyMDE5LTA2LTAz
IGF0IDE0OjA3ICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDAzLzA2LzIwMTkgMTM6
NTksIFFpYW4gQ2FpIHdyb3RlOgo+Pj4gVGhlcmUgYXJlIGEgZmV3IG1hY3JvcyBpbiBJT01NVSBo
YXZlIHNpbmdsZS1jaGFyIGlkZW50aWZpZXJzIG1ha2UgdGhlCj4+PiBjb2RlIGhhcmQgdG8gcmVh
ZCBhbmQgZGVidWcuIFJlcGxhY2UgdGhlbSB3aXRoIG1lYW5pbmdmdWwgbmFtZXMuCj4+Pgo+Pj4g
U3VnZ2VzdGVkLWJ5OiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgo+
Pj4gU2lnbmVkLW9mZi1ieTogUWlhbiBDYWkgPGNhaUBsY2EucHc+Cj4+PiAtLS0KPj4+ICDCoCBp
bmNsdWRlL2xpbnV4L2RtYXIuaCB8IDE0ICsrKysrKysrLS0tLS0tCj4+PiAgwqAgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9kbWFyLmggYi9pbmNsdWRlL2xpbnV4L2RtYXIuaAo+Pj4gaW5kZXgg
ZjhhZjFkNzcwNTIwLi5lYjYzNDkxMmY0NzUgMTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4
L2RtYXIuaAo+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9kbWFyLmgKPj4+IEBAIC0xMDQsMTIgKzEw
NCwxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgZG1hcl9yY3VfY2hlY2sodm9pZCkKPj4+ICAgIAo+
Pj4gIMKgICNkZWZpbmUJZG1hcl9yY3VfZGVyZWZlcmVuY2UocCkJcmN1X2RlcmVmZXJlbmNlX2No
ZWNrKChwKSwKPj4+IGRtYXJfcmN1X2NoZWNrKCkpCj4+PiAgICAKPj4+IC0jZGVmaW5lCWZvcl9l
YWNoX2Rldl9zY29wZShhLCBjLCBwLCBkKQlcCj4+PiAtCWZvciAoKHApID0gMDsgKChkKSA9IChw
KSA8IChjKSA/IGRtYXJfcmN1X2RlcmVmZXJlbmNlKChhKVsocCldLmRldikKPj4+IDogXAo+Pj4g
LQkJCU5VTEwsIChwKSA8IChjKSk7IChwKSsrKQo+Pj4gLQo+Pj4gLSNkZWZpbmUJZm9yX2VhY2hf
YWN0aXZlX2Rldl9zY29wZShhLCBjLCBwLCBkKQlcCj4+PiAtCWZvcl9lYWNoX2Rldl9zY29wZSgo
YSksIChjKSwgKHApLCAoZCkpCWlmICghKGQpKSB7IGNvbnRpbnVlOwo+Pj4gfSBlbHNlCj4+PiAr
I2RlZmluZSBmb3JfZWFjaF9kZXZfc2NvcGUoZGV2cywgY250LCBpLCB0bXApCQkJCQo+Pj4gXAo+
Pj4gKwlmb3IgKChpKSA9IDA7ICgodG1wKSA9IChpKSA8IChjbnQpID8JCQkJCj4+PiBcCj4+Cj4+
IEdpdmVuIHRoYXQgInRtcCIgYWN0dWFsbHkgYXBwZWFycyB0byBiZSBzb21lIHNvcnQgb2YgZGV2
aWNlIGN1cnNvciwgSSdtCj4+IG5vdCBzdXJlIHRoYXQgdGhhdCBuYW1pbmcgcmVhbGx5IGFjaGll
dmVzIHRoZSBzdGF0ZWQgZ29hbCBvZiBjbGFyaXR5IDovCj4gCj4gInRtcCIgaXMgdXNlZCBpbiB0
aGUgY2FsbGVycyBldmVyeXdoZXJlIHRob3VnaCwgYWx0aG91Z2ggSSBzdXBwb3NlIHNvbWV0aGlu
Zwo+IGxpa2UgInRtcF9kZXYiIGNhbiBiZSB1c2VkIGlmIHlvdSBwcmVmZXIuCgpJIGRvbid0IGhh
dmUgYW55IHByZWZlcmVuY2UsIEknbSBqdXN0IHF1ZXN0aW9uaW5nIHRoZSBhc3NlcnRpb24gaW4g
dGhlIApjb21taXQgbWVzc2FnZSAtIGFzIGEgcmVhZGVyIG5vdCBpbnRpbWF0ZWx5IGZhbWlsaWFy
IHdpdGggdGhpcyBjb2RlLCAKInRtcCIgaXMgaG9uZXN0bHkgbm8gbW9yZSBtZWFuaW5nZnVsIHRo
YW4gImQiIHdhcy4KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
