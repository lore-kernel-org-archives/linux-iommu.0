Return-Path: <SRS0=gpVu=HW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E45AC433E0
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:27:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE24464EDF
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE24464EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88E218403E
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSY5UUV4VoZe for <iommu@archiver.kernel.org>;
	Sat, 20 Feb 2021 02:27:41 +0000 (UTC)
Received: by smtp1.osuosl.org (Postfix, from userid 1001)
	id 8A02F84078; Sat, 20 Feb 2021 02:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 471B184014;
	Sat, 20 Feb 2021 02:27:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13B49C000A;
	Sat, 20 Feb 2021 02:27:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05A6EC0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E58936E5F7
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1imHrt10QXAz for <iommu@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:27:37 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 024C66F59F; Sat, 20 Feb 2021 02:27:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A85716E5F7
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:27:35 +0000 (UTC)
IronPort-SDR: m5FG+P5jYq5YD4spA+XT+7OpDRcKprNsfNRQ8AzrSv2lLRXZZMhmT6IY9WOPqXnVRu76u/2u3x
 FH3QpQSVWp+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="163806106"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="163806106"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 18:27:35 -0800
IronPort-SDR: GcL94HWIGLluk7WpNMjG61xGyie8AgY/sonXVxtDaxY+1xdJP8g63g0aFMbzpzn5U2hFzn7ppp
 J+hRQJlDM6EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="420617217"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2021 18:27:31 -0800
Subject: Re: [PATCH 4/4] iommu/vt-d: Calculate and set flags for
 handle_mm_fault
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-5-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <96124ae0-8d7e-864c-3de9-f8c0f2d7fffd@linux.intel.com>
Date: Sat, 20 Feb 2021 10:18:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1613683878-89946-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Yi Sun <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

T24gMi8xOS8yMSA1OjMxIEFNLCBKYWNvYiBQYW4gd3JvdGU6Cj4gUGFnZSByZXF1ZXN0cyBhcmUg
b3JpZ2luYXRlZCBmcm9tIHRoZSB1c2VyIHBhZ2UgZmF1bHQuIFRoZXJlZm9yZSwgd2UKPiBzaGFs
bCBzZXTCoEZBVUxUX0ZMQUdfVVNFUi4KPiAKPiBGQVVMVF9GTEFHX1JFTU9URSBpbmRpY2F0ZXMg
dGhhdCB3ZSBhcmXCoHdhbGtpbmcgYW4gbW0gd2hpY2ggaXMgbm90Cj4gZ3VhcmFudGVlZCB0byBi
ZSB0aGUgc2FtZSBhcyB0aGXCoGN1cnJlbnQtPm1tIGFuZCBzaG91bGQgbm90IGJlIHN1YmplY3QK
PiB0byBwcm90ZWN0aW9uIGtlecKgZW5mb3JjZW1lbnQuIFRoZXJlZm9yZSwgd2Ugc2hvdWxkIHNl
dMKgRkFVTFRfRkxBR19SRU1PVEUKPiB0byBhdm9pZCBmYXVsdHMgd2hlbiBib3RoIFNWTSBhbmQg
UEtFWSBhcmUgdXNlZC4KPiAKPiBSZWZlcmVuY2VzOiBjb21taXQgMWIyZWUxMjY2ZWE2ICgibW0v
Y29yZTogRG8gbm90IGVuZm9yY2UgUEtFWSBwZXJtaXNzaW9ucyBvbiByZW1vdGUgbW0gYWNjZXNz
IikKPiBSZXZpZXdlZC1ieTogUmFqIEFzaG9rIDxhc2hvay5yYWpAaW50ZWwuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+CgpBY2tl
ZC1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KCkJlc3QgcmVnYXJkcywK
YmFvbHUKCj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jIHwgOSArKysrKystLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvc3ZtLmMgYi9kcml2ZXJzL2lvbW11L2lu
dGVsL3N2bS5jCj4gaW5kZXggZmY3YWU3Y2MxN2Q1Li43YmZkMjBhMjRhNjAgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwv
c3ZtLmMKPiBAQCAtMTA4Niw2ICsxMDg2LDcgQEAgc3RhdGljIGlycXJldHVybl90IHBycV9ldmVu
dF90aHJlYWQoaW50IGlycSwgdm9pZCAqZCkKPiAgIAlzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11
ID0gZDsKPiAgIAlzdHJ1Y3QgaW50ZWxfc3ZtICpzdm0gPSBOVUxMOwo+ICAgCWludCBoZWFkLCB0
YWlsLCBoYW5kbGVkID0gMDsKPiArCXVuc2lnbmVkIGludCBmbGFncyA9IDA7Cj4gICAKPiAgIAkv
KiBDbGVhciBQUFIgYml0IGJlZm9yZSByZWFkaW5nIGhlYWQvdGFpbCByZWdpc3RlcnMsIHRvCj4g
ICAJICogZW5zdXJlIHRoYXQgd2UgZ2V0IGEgbmV3IGludGVycnVwdCBpZiBuZWVkZWQuICovCj4g
QEAgLTExODYsOSArMTE4NywxMSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgcHJxX2V2ZW50X3RocmVh
ZChpbnQgaXJxLCB2b2lkICpkKQo+ICAgCQlpZiAoYWNjZXNzX2Vycm9yKHZtYSwgcmVxKSkKPiAg
IAkJCWdvdG8gaW52YWxpZDsKPiAgIAo+IC0JCXJldCA9IGhhbmRsZV9tbV9mYXVsdCh2bWEsIGFk
ZHJlc3MsCj4gLQkJCQkgICAgICByZXEtPndyX3JlcSA/IEZBVUxUX0ZMQUdfV1JJVEUgOiAwLAo+
IC0JCQkJICAgICAgTlVMTCk7Cj4gKwkJZmxhZ3MgPSBGQVVMVF9GTEFHX1VTRVIgfCBGQVVMVF9G
TEFHX1JFTU9URTsKPiArCQlpZiAocmVxLT53cl9yZXEpCj4gKwkJCWZsYWdzIHw9IEZBVUxUX0ZM
QUdfV1JJVEU7Cj4gKwo+ICsJCXJldCA9IGhhbmRsZV9tbV9mYXVsdCh2bWEsIGFkZHJlc3MsIGZs
YWdzLCBOVUxMKTsKPiAgIAkJaWYgKHJldCAmIFZNX0ZBVUxUX0VSUk9SKQo+ICAgCQkJZ290byBp
bnZhbGlkOwo+ICAgCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
