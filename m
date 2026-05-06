Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282745BD7F
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079996; cv=none; b=DpNfUipW6qGBdKHgKic1HUCRx8OZGw3TlhWKxq/io5kCxIvKMiJr7HAgtNlxYIIr+0sxSzIxofTxl8CAPVOs1V2LODivRLz+6AYhFiEOu6DPYOk2XSk8kytVvHnFofjeguND+hLvvAQJe7ESqtjqBwYKYzLtpUhFziZJfEqm1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079996; c=relaxed/simple;
	bh=Qt2HGrXPLQycWQQy/Cjb5HlQSRkdj/GSEKb5kpr7+68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nARqOOKDQEx6SxqvF/xMXm1gpsCdNTsglgUU8IezN6hnECDcLVDyOfVDfKNjLPbCoeApchaRV5BjFSCtKqEwtXX7dJz93ot2jP3l4reFTsdbJJq8ubZiX7HmN1gGWDbYVB1Z7MI1a08klm6QYyEWnqb7zlDyvAtJOAskYvr9mYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=RqPahn+a; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="RqPahn+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1778079995; x=1809615995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qt2HGrXPLQycWQQy/Cjb5HlQSRkdj/GSEKb5kpr7+68=;
  b=RqPahn+agZ7Tn0Qwz0qq9FzRxS8ldRIjy9qJUDtNkByK8XWwp91wi2sY
   QqzlB7zLUJXhyD8n8DbbljKL/oz+fm0VHkt7h3mA8eHQ3xCFUhcQnZrGv
   hgx95UhLpU3W9FEOiam1tRTBGc3cRsgnxEph8SJpLDShAH0mHS8z/9YLW
   T4WDQfBUH/XTChROCZQFElOW4itNaPjFLA9Xfm2DNrPNOplRgiz4L0riF
   /QnmfLpdzXXjS5rM2/JOsz31JmINNL2CKaPPx/Ub9DgA+xTtIOiawOVLt
   l76DDL4boh4ONO7ji6t90FYvEtO+GdrPOu0XgEOWt/goP+R1wX6/sr0XM
   Q==;
X-CSE-ConnectionGUID: FpKGDPPDTbilxUFbQUb+oA==
X-CSE-MsgGUID: TlIn3Q7eRwyi2ArP7bf0oA==
X-IronPort-AV: E=Sophos;i="6.23,219,1770595200"; 
   d="scan'208";a="18791000"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 15:06:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:24373]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.153:2525] with esmtp (Farcaster)
 id 25a03849-80ff-445e-8e23-f965dc2a85fc; Wed, 6 May 2026 15:06:31 +0000 (UTC)
X-Farcaster-Flow-ID: 25a03849-80ff-445e-8e23-f965dc2a85fc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 6 May 2026 15:06:31 +0000
Received: from dev-dsk-yigitogu-1a-d17f6574.eu-west-1.amazon.com
 (172.19.100.7) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 6 May 2026
 15:06:29 +0000
From: Yigit Oguz <yigitogu@amazon.de>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<suravee.suthikulpanit@amd.com>
CC: <jgg@ziepe.ca>, <nicolinc@nvidia.com>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Lilit Janpoladyan" <lilitj@amazon.com>, Yigit Oguz <yigitogu@amazon.de>
Subject: [PATCH 1/3] iommu/arm-smmu-v3: Print PCI vendor:device ID in SMMU translation fault logs
Date: Wed, 6 May 2026 15:05:37 +0000
Message-ID: <20260506150541.60467-2-yigitogu@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506150541.60467-1-yigitogu@amazon.de>
References: <20260506150541.60467-1-yigitogu@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RnJvbTogTGlsaXQgSmFucG9sYWR5YW4gPGxpbGl0akBhbWF6b24uY29tPgoKRm9yIHRyYW5zbGF0
aW9uLCBhZGRyZXNzLXNpemUsIGFjY2VzcywgYW5kIHBlcm1pc3Npb24gZmF1bHRzLCBsb29rIHVw
CnRoZSBwY2lfZGV2IGZyb20gdGhlIGV2ZW50IGFuZCBhcHBlbmQgdGhlIFBDSSB2ZW5kb3I6ZGV2
aWNlIElEIGFmdGVyCnRoZSBkZXZpY2UgbmFtZSwgZS5nLjoKCiAgZXZlbnQ6IEZfVFJBTlNMQVRJ
T04gY2xpZW50OiAwMDAxOjAyOjAyLjQgWzFkMGY6ODA2MV0gc2lkOiAuLi4KCkZvciBub24tUENJ
IGRldmljZXMgb3IgdW5hc3NpZ25lZCBTSURzIHRoZSBvdXRwdXQgaXMgdW5jaGFuZ2VkLgoKU2ln
bmVkLW9mZi1ieTogTGlsaXQgSmFucG9sYWR5YW4gPGxpbGl0akBhbWF6b24uY29tPgpTaWduZWQt
b2ZmLWJ5OiBZaWdpdCBPZ3V6IDx5aWdpdG9ndUBhbWF6b24uZGU+Ci0tLQogZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8IDI5ICsrKysrKysrKysrKysrKysrKy0t
LQogMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyBiL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKaW5kZXggZThkN2RiZTQ5
NWYwLi5hYjFhZmEzNjk2NWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
LXYzL2FybS1zbW11LXYzLmMKKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJt
LXNtbXUtdjMuYwpAQCAtMjIxMywxMiArMjIxMywzMCBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV9k
dW1wX3Jhd19ldmVudChzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LCB1NjQgKnJhdywKIAog
I2RlZmluZSBBUk1fU01NVV9FVlRfS05PV04oZSkJKChlKS0+aWQgPCBBUlJBWV9TSVpFKGV2ZW50
X3N0cikgJiYgZXZlbnRfc3RyWyhlKS0+aWRdKQogI2RlZmluZSBBUk1fU01NVV9MT0dfRVZUX1NU
UihlKSBBUk1fU01NVV9FVlRfS05PV04oZSkgPyBldmVudF9zdHJbKGUpLT5pZF0gOiAiVU5LTk9X
TiIKLSNkZWZpbmUgQVJNX1NNTVVfTE9HX0NMSUVOVChlKQkoZSktPmRldiA/IGRldl9uYW1lKChl
KS0+ZGV2KSA6ICIodW5hc3NpZ25lZCBzaWQpIgorCisvKiAiU1NTUzpCQjpERC5GIFtWVlZWOkRE
RERdXDAiIOKAlCAxMiArIDEgKyAxMSArIDEgPSAyNTsgcm91bmQgdG8gcG93ZXIgb2YgMiAqLwor
I2RlZmluZSBBUk1fU01NVV9DTElFTlRfTEVOCTMyCisKK3N0YXRpYyBjb25zdCBjaGFyICphcm1f
c21tdV9mbXRfY2xpZW50KHN0cnVjdCBhcm1fc21tdV9ldmVudCAqZSwgY2hhciAqYnVmLCBzaXpl
X3Qgc3opCit7CisJc3RydWN0IHBjaV9kZXYgKnA7CisKKwlpZiAoIWUtPmRldikKKwkJcmV0dXJu
ICIodW5hc3NpZ25lZCBzaWQpIjsKKwlpZiAoIWRldl9pc19wY2koZS0+ZGV2KSkKKwkJcmV0dXJu
IGRldl9uYW1lKGUtPmRldik7CisKKwlwID0gdG9fcGNpX2RldihlLT5kZXYpOworCXNucHJpbnRm
KGJ1Ziwgc3osICIlcyBbJTA0eDolMDR4XSIsIGRldl9uYW1lKGUtPmRldiksIHAtPnZlbmRvciwg
cC0+ZGV2aWNlKTsKKwlyZXR1cm4gYnVmOworfQogCiBzdGF0aWMgdm9pZCBhcm1fc21tdV9kdW1w
X2V2ZW50KHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUsIHU2NCAqcmF3LAogCQkJCXN0cnVj
dCBhcm1fc21tdV9ldmVudCAqZXZ0LAogCQkJCXN0cnVjdCByYXRlbGltaXRfc3RhdGUgKnJzKQog
eworCWNoYXIgY2xpZW50YnVmW0FSTV9TTU1VX0NMSUVOVF9MRU5dOworCiAJaWYgKCFfX3JhdGVs
aW1pdChycykpCiAJCXJldHVybjsKIApAQCAtMjIzMCw3ICsyMjQ4LDggQEAgc3RhdGljIHZvaWQg
YXJtX3NtbXVfZHVtcF9ldmVudChzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LCB1NjQgKnJh
dywKIAljYXNlIEVWVF9JRF9BQ0NFU1NfRkFVTFQ6CiAJY2FzZSBFVlRfSURfUEVSTUlTU0lPTl9G
QVVMVDoKIAkJZGV2X2VycihzbW11LT5kZXYsICJldmVudDogJXMgY2xpZW50OiAlcyBzaWQ6ICUj
eCBzc2lkOiAlI3ggaW92YTogJSNsbHggaXBhOiAlI2xseCIsCi0JCQlBUk1fU01NVV9MT0dfRVZU
X1NUUihldnQpLCBBUk1fU01NVV9MT0dfQ0xJRU5UKGV2dCksCisJCQlBUk1fU01NVV9MT0dfRVZU
X1NUUihldnQpLAorCQkJYXJtX3NtbXVfZm10X2NsaWVudChldnQsIGNsaWVudGJ1ZiwgQVJNX1NN
TVVfQ0xJRU5UX0xFTiksCiAJCQlldnQtPnNpZCwgZXZ0LT5zc2lkLCBldnQtPmlvdmEsIGV2dC0+
aXBhKTsKIAogCQlkZXZfZXJyKHNtbXUtPmRldiwgIiVzICVzICVzICVzIFwiJXNcIiVzJXMgc3Rh
ZzogJSN4IiwKQEAgLTIyNDcsMTQgKzIyNjYsMTYgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfZHVt
cF9ldmVudChzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LCB1NjQgKnJhdywKIAljYXNlIEVW
VF9JRF9DRF9GRVRDSF9GQVVMVDoKIAljYXNlIEVWVF9JRF9WTVNfRkVUQ0hfRkFVTFQ6CiAJCWRl
dl9lcnIoc21tdS0+ZGV2LCAiZXZlbnQ6ICVzIGNsaWVudDogJXMgc2lkOiAlI3ggc3NpZDogJSN4
IGZldGNoX2FkZHI6ICUjbGx4IiwKLQkJCUFSTV9TTU1VX0xPR19FVlRfU1RSKGV2dCksIEFSTV9T
TU1VX0xPR19DTElFTlQoZXZ0KSwKKwkJCUFSTV9TTU1VX0xPR19FVlRfU1RSKGV2dCksCisJCQlh
cm1fc21tdV9mbXRfY2xpZW50KGV2dCwgY2xpZW50YnVmLCBBUk1fU01NVV9DTElFTlRfTEVOKSwK
IAkJCWV2dC0+c2lkLCBldnQtPnNzaWQsIGV2dC0+ZmV0Y2hfYWRkcik7CiAKIAkJYnJlYWs7CiAK
IAlkZWZhdWx0OgogCQlkZXZfZXJyKHNtbXUtPmRldiwgImV2ZW50OiAlcyBjbGllbnQ6ICVzIHNp
ZDogJSN4IHNzaWQ6ICUjeCIsCi0JCQlBUk1fU01NVV9MT0dfRVZUX1NUUihldnQpLCBBUk1fU01N
VV9MT0dfQ0xJRU5UKGV2dCksCisJCQlBUk1fU01NVV9MT0dfRVZUX1NUUihldnQpLAorCQkJYXJt
X3NtbXVfZm10X2NsaWVudChldnQsIGNsaWVudGJ1ZiwgQVJNX1NNTVVfQ0xJRU5UX0xFTiksCiAJ
CQlldnQtPnNpZCwgZXZ0LT5zc2lkKTsKIAl9CiB9Ci0tIAoyLjQ3LjMKCgoKCkFtYXpvbiBXZWIg
U2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIu
IDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxtaXMsIEFu
ZHJlYXMgU3RpZWdlcgpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1
bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK

