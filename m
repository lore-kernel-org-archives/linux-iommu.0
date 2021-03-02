Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169FAC433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 18:45:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECC064F2A
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 18:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECC064F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B0CE431AA;
	Tue,  2 Mar 2021 18:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p8mtrWNrARMl; Tue,  2 Mar 2021 18:45:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3CC9D431A6;
	Tue,  2 Mar 2021 18:45:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C8F3C000D;
	Tue,  2 Mar 2021 18:45:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 346ACC0012
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24510838B3
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HsULy3hOPQUk for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 18:45:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85EE2838AB
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:48 +0000 (UTC)
IronPort-SDR: 2KgMm1tlxc+nvgsfekG/nLeftmflCefPGLXNhRY8zaLWnsAOsOhbNIH87skay5EueW92IQmp41
 XLaNLaTr75ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174575586"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174575586"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 10:45:47 -0800
IronPort-SDR: HAfdzkGPXCjfG1XdJaLDYcrnfRu0D8eePJaFpVbln/KYNF6988EV61wEsfbAhYO3e0glqeAPiF
 +mTlz6vBvn2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="406158814"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga007.jf.intel.com with ESMTP; 02 Mar 2021 10:45:47 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 4/4] iommu/vt-d: Calculate and set flags for handle_mm_fault
Date: Tue,  2 Mar 2021 02:14:00 -0800
Message-Id: <1614680040-1989-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

UGFnZSByZXF1ZXN0cyBhcmUgb3JpZ2luYXRlZCBmcm9tIHRoZSB1c2VyIHBhZ2UgZmF1bHQuIFRo
ZXJlZm9yZSwgd2UKc2hhbGwgc2V0wqBGQVVMVF9GTEFHX1VTRVIuwqAKCkZBVUxUX0ZMQUdfUkVN
T1RFIGluZGljYXRlcyB0aGF0IHdlIGFyZcKgd2Fsa2luZyBhbiBtbSB3aGljaCBpcyBub3QKZ3Vh
cmFudGVlZCB0byBiZSB0aGUgc2FtZSBhcyB0aGXCoGN1cnJlbnQtPm1tIGFuZCBzaG91bGQgbm90
IGJlIHN1YmplY3QKdG8gcHJvdGVjdGlvbiBrZXnCoGVuZm9yY2VtZW50LiBUaGVyZWZvcmUsIHdl
IHNob3VsZCBzZXTCoEZBVUxUX0ZMQUdfUkVNT1RFCnRvIGF2b2lkIGZhdWx0cyB3aGVuIGJvdGgg
U1ZNIGFuZCBQS0VZIGFyZSB1c2VkLgoKUmVmZXJlbmNlczogY29tbWl0IDFiMmVlMTI2NmVhNiAo
Im1tL2NvcmU6IERvIG5vdCBlbmZvcmNlIFBLRVkgcGVybWlzc2lvbnMgb24gcmVtb3RlIG1tIGFj
Y2VzcyIpClJldmlld2VkLWJ5OiBSYWogQXNob2sgPGFzaG9rLnJhakBpbnRlbC5jb20+CkFja2Vk
LWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBK
YWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvaW9t
bXUvaW50ZWwvc3ZtLmMgfCA5ICsrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2
bS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYwppbmRleCBmZjdhZTdjYzE3ZDUuLjdiZmQy
MGEyNGE2MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYworKysgYi9kcml2
ZXJzL2lvbW11L2ludGVsL3N2bS5jCkBAIC0xMDg2LDYgKzEwODYsNyBAQCBzdGF0aWMgaXJxcmV0
dXJuX3QgcHJxX2V2ZW50X3RocmVhZChpbnQgaXJxLCB2b2lkICpkKQogCXN0cnVjdCBpbnRlbF9p
b21tdSAqaW9tbXUgPSBkOwogCXN0cnVjdCBpbnRlbF9zdm0gKnN2bSA9IE5VTEw7CiAJaW50IGhl
YWQsIHRhaWwsIGhhbmRsZWQgPSAwOworCXVuc2lnbmVkIGludCBmbGFncyA9IDA7CiAKIAkvKiBD
bGVhciBQUFIgYml0IGJlZm9yZSByZWFkaW5nIGhlYWQvdGFpbCByZWdpc3RlcnMsIHRvCiAJICog
ZW5zdXJlIHRoYXQgd2UgZ2V0IGEgbmV3IGludGVycnVwdCBpZiBuZWVkZWQuICovCkBAIC0xMTg2
LDkgKzExODcsMTEgQEAgc3RhdGljIGlycXJldHVybl90IHBycV9ldmVudF90aHJlYWQoaW50IGly
cSwgdm9pZCAqZCkKIAkJaWYgKGFjY2Vzc19lcnJvcih2bWEsIHJlcSkpCiAJCQlnb3RvIGludmFs
aWQ7CiAKLQkJcmV0ID0gaGFuZGxlX21tX2ZhdWx0KHZtYSwgYWRkcmVzcywKLQkJCQkgICAgICBy
ZXEtPndyX3JlcSA/IEZBVUxUX0ZMQUdfV1JJVEUgOiAwLAotCQkJCSAgICAgIE5VTEwpOworCQlm
bGFncyA9IEZBVUxUX0ZMQUdfVVNFUiB8IEZBVUxUX0ZMQUdfUkVNT1RFOworCQlpZiAocmVxLT53
cl9yZXEpCisJCQlmbGFncyB8PSBGQVVMVF9GTEFHX1dSSVRFOworCisJCXJldCA9IGhhbmRsZV9t
bV9mYXVsdCh2bWEsIGFkZHJlc3MsIGZsYWdzLCBOVUxMKTsKIAkJaWYgKHJldCAmIFZNX0ZBVUxU
X0VSUk9SKQogCQkJZ290byBpbnZhbGlkOwogCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
