Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BE9C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 09:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25ABB409D5;
	Wed, 22 Jun 2022 09:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25ABB409D5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oyx9TT3E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ztFSrkYCjWZ; Wed, 22 Jun 2022 09:09:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4BAB403BF;
	Wed, 22 Jun 2022 09:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4BAB403BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87D8EC0039;
	Wed, 22 Jun 2022 09:09:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCE92C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6D00409A6
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6D00409A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyCCQVQg-s3u for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 09:09:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF83D403BF
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF83D403BF
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655888988; x=1687424988;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=YqWiE296DtyHyhO+yyiOrk24VL3NMTPdoeON0AXOges=;
 b=Oyx9TT3E3o+aOoSrEEGUshmFN/Dz3cLnPScJGOTinvTis71KfVtGkcA4
 K+juSXWgcen/3Z8NGL+dmvPmdFUoW6Y2SQkzSvSFLWlCRcOZA4MhTw08M
 cWP+WdPRv375JgCFt6zysCq5T6j+GxY4ubGvexKsu04KbEhzwsDoKNpY3
 L36xU02NlOMrPViO8slPfTpHW88MXM8OEsRTP94pVlDSLkddxMldbG0tj
 61l1Z9yDt7lSWwwa0rYQD8J0U79NVC9lEwbB8oXsCjfT5aG+hgbnMMn/T
 BKgYPAvEceJVVjLsdawCB/MleHjMChXz0ZkG+Cd3fCnwoQbmh2Sg6jQaH A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="279131304"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="279131304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 02:09:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="644091091"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.210.186])
 ([10.254.210.186])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 02:09:35 -0700
Message-ID: <b7834cb5-4836-fb2d-1570-a46440341bed@linux.intel.com>
Date: Wed, 22 Jun 2022 17:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix RID2PASID setup failure
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220622044120.21813-1-baolu.lu@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20220622044120.21813-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

SGksCgrlnKggMjAyMi82LzIyIDEyOjQxLCBMdSBCYW9sdSDlhpnpgZM6Cj4gVGhlIElPTU1VIGRy
aXZlciBzaGFyZXMgdGhlIHBhc2lkIHRhYmxlIGZvciBQQ0kgYWxpYXMgZGV2aWNlcy4gV2hlbiB0
aGUKPiBSSUQyUEFTSUQgZW50cnkgb2YgdGhlIHNoYXJlZCBwYXNpZCB0YWJsZSBoYXMgYmVlbiBm
aWxsZWQgYnkgdGhlIGZpcnN0Cj4gZGV2aWNlLCB0aGUgc3Vic2VxdWVudCBkZXZpY2VzIHdpbGwg
ZW5jb3VudGVyIHRoZSAiRE1BUjogU2V0dXAgUklEMlBBU0lECj4gZmFpbGVkIiBmYWlsdXJlIGFz
IHRoZSBwYXNpZCBlbnRyeSBoYXMgYWxyZWFkeSBiZWVuIG1hcmtlZCBhcyBwcmVzZW50LiBBcwo+
IHRoZSByZXN1bHQsIHRoZSBJT01NVSBwcm9iaW5nIHByb2Nlc3Mgd2lsbCBiZSBhYm9ydGVkLgo+
Cj4gVGhpcyBmaXhlcyBpdCBieSBza2lwcGluZyBSSUQyUEFTSUQgc2V0dGluZyBpZiB0aGUgcGFz
aWQgZW50cnkgaGFzIGJlZW4KPiBwb3B1bGF0ZWQuIFRoaXMgd29ya3MgYmVjYXVzZSB0aGUgSU9N
TVUgY29yZSBlbnN1cmVzIHRoYXQgb25seSB0aGUgc2FtZQo+IElPTU1VIGRvbWFpbiBjYW4gYmUg
YXR0YWNoZWQgdG8gYWxsIFBDSSBhbGlhcyBkZXZpY2VzIGF0IHRoZSBzYW1lIHRpbWUuCj4gVGhl
cmVmb3JlIHRoZSBzdWJzZXF1ZW50IGRldmljZXMganVzdCB0cnkgdG8gc2V0dXAgdGhlIFJJRDJQ
QVNJRCBlbnRyeQo+IHdpdGggdGhlIHNhbWUgZG9tYWluLCB3aGljaCBpcyBuZWdsaWdpYmxlLiBU
aGlzIGFsc28gYWRkcyBkb21haW4gdmFsaWRpdHkKPiBjaGVja3MgZm9yIG1vcmUgY29uZmlkZW5j
ZSBhbnl3YXkuCj4KPiBGaXhlczogZWY4NDhiN2U1YTZhMCAoImlvbW11L3Z0LWQ6IFNldHVwIHBh
c2lkIGVudHJ5IGZvciBSSUQyUEFTSUQgc3VwcG9ydCIpCj4gUmVwb3J0ZWQtYnk6IENoZW55aSBR
aWFuZyA8Y2hlbnlpLnFpYW5nQGludGVsLmNvbT4KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zwo+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4g
LS0tCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMgfCAyMiArKysrKysrKysrKysrKysr
LS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkKPgo+IENoYW5nZSBsb2c6Cj4gdjI6Cj4gICAtIEFkZCBkb21haW4gdmFsaWRpdHkgY2hlY2sg
aW4gUklEMlBBU0lEIGVudHJ5IHNldHVwLgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aW50ZWwvcGFzaWQuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYwo+IGluZGV4IGNiNGMx
ZDBjZjI1Yy4uNGYzNTI1ZjMzNDZmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwv
cGFzaWQuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYwo+IEBAIC01NzUsNiAr
NTc1LDE5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHBhc2lkX2VuYWJsZV93cGUoc3RydWN0IHBhc2lk
X2VudHJ5ICpwdGUpCj4gICAJcmV0dXJuIDA7Cj4gICB9Owo+ICAgCj4gKy8qCj4gKyAqIFJldHVy
biB0cnVlIGlmIEBwYXNpZCBpcyBSSUQyUEFTSUQgYW5kIHRoZSBkb21haW4gQGRpZCBoYXMgYWxy
ZWFkeQo+ICsgKiBiZWVuIHNldHVwIHRvIHRoZSBAcHRlLiBPdGhlcndpc2UsIHJldHVybiBmYWxz
ZS4gUENJIGFsaWFzIGRldmljZXMKPiArICogcHJvYmFibHkgc2hhcmUgdGhlIHNpbmdsZSBSSUQy
UEFTSUQgcGFzaWQgZW50cnkgaW4gdGhlIHNoYXJlZCBwYXNpZAo+ICsgKiB0YWJsZS4gSXQncyBy
ZWFzb25hYmxlIHRoYXQgdGhvc2UgZGV2aWNlcyB0cnkgdG8gc2V0IGEgc2hhcmUgZG9tYWluCj4g
KyAqIGluIHRoZWlyIHByb2JlIHBhdGhzLgo+ICsgKi8KCkkgYW0gdGhpbmtpbmcgYWJvdXQgdGhl
IGNvdW50ZXItcGFydCwgdGhlIGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeSgpLAoKTXVsdGkg
ZGV2aWNlcyBzaGFyZSB0aGUgc2FtZSBQQVNJRCBlbnRyeSwgdGhlbiBvbmUgd2FzIGRldGFjaGVk
IGZyb20gdGhlIApkb21haW4sCgpzbyB0aGUgZW50cnkgZG9lc24ndCBleGlzdCBhbnltb3JlLCB3
aGlsZSBhbm90aGVyIGRldmljZXMgZG9uJ3Qga25vdyAKYWJvdXQgdGhlIGNoYW5nZSwKCmFuZCB0
aGV5IGFyZSB1c2luZyB0aGUgbWFwcGluZywgaXMgaXQgcG9zc2libGUgY2FzZSDvvJ9zaGFyZWQg
dGhpbmcsIG5vIApyZWZlci1jb3VudGVyLAoKYW0gSSBtaXNzaW5nIHNvbWV0aGluZyA/CgoKVGhh
bmtz77yMCgpFdGhhbgoKCj4gK3N0YXRpYyBpbmxpbmUgYm9vbAo+ICtyaWQycGFzaWRfZG9tYWlu
X3ZhbGlkKHN0cnVjdCBwYXNpZF9lbnRyeSAqcHRlLCB1MzIgcGFzaWQsIHUxNiBkaWQpCj4gK3sK
PiArCXJldHVybiBwYXNpZCA9PSBQQVNJRF9SSUQyUEFTSUQgJiYgcGFzaWRfZ2V0X2RvbWFpbl9p
ZChwdGUpID09IGRpZDsKPiArfQo+ICsKPiAgIC8qCj4gICAgKiBTZXQgdXAgdGhlIHNjYWxhYmxl
IG1vZGUgcGFzaWQgdGFibGUgZW50cnkgZm9yIGZpcnN0IG9ubHkKPiAgICAqIHRyYW5zbGF0aW9u
IHR5cGUuCj4gQEAgLTU5NSw5ICs2MDgsOCBAQCBpbnQgaW50ZWxfcGFzaWRfc2V0dXBfZmlyc3Rf
bGV2ZWwoc3RydWN0IGludGVsX2lvbW11ICppb21tdSwKPiAgIAlpZiAoV0FSTl9PTighcHRlKSkK
PiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAtCS8qIENhbGxlciBtdXN0IGVuc3VyZSBQQVNJ
RCBlbnRyeSBpcyBub3QgaW4gdXNlLiAqLwo+ICAgCWlmIChwYXNpZF9wdGVfaXNfcHJlc2VudChw
dGUpKQo+IC0JCXJldHVybiAtRUJVU1k7Cj4gKwkJcmV0dXJuIHJpZDJwYXNpZF9kb21haW5fdmFs
aWQocHRlLCBwYXNpZCwgZGlkKSA/IDAgOiAtRUJVU1k7Cj4gICAKPiAgIAlwYXNpZF9jbGVhcl9l
bnRyeShwdGUpOwo+ICAgCj4gQEAgLTY5OCw5ICs3MTAsOCBAQCBpbnQgaW50ZWxfcGFzaWRfc2V0
dXBfc2Vjb25kX2xldmVsKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsCj4gICAJCXJldHVybiAt
RU5PREVWOwo+ICAgCX0KPiAgIAo+IC0JLyogQ2FsbGVyIG11c3QgZW5zdXJlIFBBU0lEIGVudHJ5
IGlzIG5vdCBpbiB1c2UuICovCj4gICAJaWYgKHBhc2lkX3B0ZV9pc19wcmVzZW50KHB0ZSkpCj4g
LQkJcmV0dXJuIC1FQlVTWTsKPiArCQlyZXR1cm4gcmlkMnBhc2lkX2RvbWFpbl92YWxpZChwdGUs
IHBhc2lkLCBkaWQpID8gMCA6IC1FQlVTWTsKPiAgIAo+ICAgCXBhc2lkX2NsZWFyX2VudHJ5KHB0
ZSk7Cj4gICAJcGFzaWRfc2V0X2RvbWFpbl9pZChwdGUsIGRpZCk7Cj4gQEAgLTczOCw5ICs3NDks
OCBAQCBpbnQgaW50ZWxfcGFzaWRfc2V0dXBfcGFzc190aHJvdWdoKHN0cnVjdCBpbnRlbF9pb21t
dSAqaW9tbXUsCj4gICAJCXJldHVybiAtRU5PREVWOwo+ICAgCX0KPiAgIAo+IC0JLyogQ2FsbGVy
IG11c3QgZW5zdXJlIFBBU0lEIGVudHJ5IGlzIG5vdCBpbiB1c2UuICovCj4gICAJaWYgKHBhc2lk
X3B0ZV9pc19wcmVzZW50KHB0ZSkpCj4gLQkJcmV0dXJuIC1FQlVTWTsKPiArCQlyZXR1cm4gcmlk
MnBhc2lkX2RvbWFpbl92YWxpZChwdGUsIHBhc2lkLCBkaWQpID8gMCA6IC1FQlVTWTsKPiAgIAo+
ICAgCXBhc2lkX2NsZWFyX2VudHJ5KHB0ZSk7Cj4gICAJcGFzaWRfc2V0X2RvbWFpbl9pZChwdGUs
IGRpZCk7CgotLSAKQUZBSUsgPSBBcyBGYXIgQXMgSSBLbm93CkFLQSA9IEFsc28gS25vd24gQXMK
QVNBUCA9IEFzIFNvb24gQXMgUG9zc2libGUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
