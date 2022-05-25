Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F6BC433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 11:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2260B82FA2;
	Wed, 25 May 2022 11:07:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k7FTfR-KSx5m; Wed, 25 May 2022 11:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F02C082628;
	Wed, 25 May 2022 11:07:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEC6AC0032;
	Wed, 25 May 2022 11:07:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83A48C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 11:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7123B40A65
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 11:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C9t85OIhFf98 for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 11:07:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CB6240A42
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 11:07:10 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id s28so29480215wrb.7
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=joRdFOrikAvLBCPLRckLtagnr5zAnbbJe1mok1pXiSw=;
 b=ZUCXEQxRycox4CR+XIe37Y/zMHlkCMd0dT68FX0waAx1GkzWURFMnfELqyxuQGZR/T
 mg+fiyemIz0D8Y/JwhX8LiTotWRgJ7/381Qc3jxsJ1kyAh0jrdY0i3I0MMjN2PYCfY4X
 tmjLRKQ9uh1RJsyLlfHrUmtCu6tsXRxb5dpf8pG4/mOhvcewaJs1AqWTCYkEQn9dGe5f
 k/M7rP1GoX9dH2gH2aRjUUMrrg/meRnh/kJNy+C0uerR6Mc2VSgpkGDTV7QjUckM+4jZ
 oHGOsxAUkFsW+xnn2zbXR7/5EbdF3sifZs6Th0VlQ0bQubEelqdaIh9fVg0nROLEwZus
 pUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=joRdFOrikAvLBCPLRckLtagnr5zAnbbJe1mok1pXiSw=;
 b=et+3K7HA4U4M8euMGQHe78Uy46q+k8Ys7Gk7ItEWfjH4+/KwTxlBbro6OvVSLp1tt2
 jD9o+4xj0Of6QTuoO9vTzflJ5R6DXLbLkBJL4lAu9BZCWCnrQlqDWFkcaMui8Hz1xFG2
 3+63nE2JzZZcnMqzZvryFkIgFnmhpT3SumpNDceDyV2z0JC7boDl6Rl/EIXkTGfDDi9f
 SL0HH1F7fZR+aBnfYAh+AEamTy8+ovbK2Ti4vW9z/3LDVYIrJvgqR6J5QBS5eDLfF1T9
 pnApJWr7awaq2P7n3TyUvPgwbOF48amHsm3dUNK9uP8KbNsKkuWuFRFoTS78t/wDlaki
 ZmKw==
X-Gm-Message-State: AOAM531GPV1crf3o+oDNYYyWmrjzOfcre1r1ViNkS5tDdkkzxZc6BGSa
 hJm8KyrztTTY2Kd7c2e4i+lSkg==
X-Google-Smtp-Source: ABdhPJzrYJnqGw1yZiQCDAklTrlieqOiqwchoSzelXSLzjGcwtCmct9j1gilMqHVnxUp+Q5VzeMrEA==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id
 b9-20020adfd1c9000000b0020fc3dce980mr18878297wrd.552.1653476828879; 
 Wed, 25 May 2022 04:07:08 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 i7-20020a5d55c7000000b0020c5253d8d3sm1797656wrw.31.2022.05.25.04.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 May 2022 04:07:08 -0700 (PDT)
Date: Wed, 25 May 2022 12:06:43 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Message-ID: <Yo4Nw9QyllT1RZbd@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
 <ff8f23c0-8763-1fac-6526-9095101ca0e5@linux.intel.com>
 <567dffd4-8f15-ffb2-da69-4f47017c35fd@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <567dffd4-8f15-ffb2-da69-4f47017c35fd@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

T24gV2VkLCBNYXkgMjUsIDIwMjIgYXQgMTE6MDc6NDlBTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+ID4gRGlkIHlvdSBtZWFuIEBoYW5kbGVyIGFuZCBAaGFuZGxlcl90b2tlbiBzdGFmZnMg
YmVsb3c/Cj4gPiAKPiA+IHN0cnVjdCBpb21tdV9kb21haW4gewo+ID4gIMKgwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIHR5cGU7Cj4gPiAgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IGlvbW11X2Rv
bWFpbl9vcHMgKm9wczsKPiA+ICDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBnc2l6ZV9i
aXRtYXA7wqDCoMKgIC8qIEJpdG1hcCBvZiBwYWdlIHNpemVzIGluIHVzZSAqLwo+ID4gIMKgwqDC
oMKgwqDCoMKgIGlvbW11X2ZhdWx0X2hhbmRsZXJfdCBoYW5kbGVyOwo+ID4gIMKgwqDCoMKgwqDC
oMKgIHZvaWQgKmhhbmRsZXJfdG9rZW47Cj4gPiAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvbW11
X2RvbWFpbl9nZW9tZXRyeSBnZW9tZXRyeTsKPiA+ICDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW9t
bXVfZG1hX2Nvb2tpZSAqaW92YV9jb29raWU7Cj4gPiB9Owo+ID4gCj4gPiBJcyBpdCBvbmx5IGZv
ciBETUEgZG9tYWlucz8gRnJvbSB0aGUgcG9pbnQgdmlldyBvZiBJT01NVSBmYXVsdHMsIGl0Cj4g
PiBzZWVtcyB0byBiZSBnZW5lcmljLgo+IAo+IFllcywgaXQncyB0aGUgb2xkIGNvbW1vbiBpb21t
dV9zZXRfZmF1bHRfaGFuZGxlcigpIHN0dWZmICh3aGljaCBhcmd1YWJseSBpcwo+IG1vcmUgb2Yg
YSAibm90aWZpZXIiIHRoYW4gYSAiaGFuZGxlciIpLCBidXQgSSBhc3N1bWUgdGhhdCB0aGF0J3Mg
aXJyZWxldmFudAo+IGlmIFNWQSBpcyB1c2luZyBJT1BGIGluc3RlYWQ/CgpZZXMgSU9NTVUgZHJp
dmVycyBjYWxsIGVpdGhlciB0aGUgbmV3ZXIgaW9tbXVfcmVwb3J0X2RldmljZV9mYXVsdCgpIG9y
IHRoZQpvbGQgcmVwb3J0X2lvbW11X2ZhdWx0KCksIGFuZCBvbmx5IHRoZSBmb3JtZXIgY2FuIHN1
cHBvcnQgSU9QRi9TVkEuIEkndmUKdHJpZWQgdG8gbWVyZ2UgdGhlbSBiZWZvcmUgYnV0IG5ldmVy
IGNvbXBsZXRlZCBpdC4gSSB0aGluayB0aGUgbWFpbiBpc3N1ZQp3YXMgd2l0aCBmaW5kaW5nIHRo
ZSBlbmRwb2ludCB0aGF0IGNhdXNlZCB0aGUgZmF1bHQgZnJvbSB0aGUgZmF1bHQKaGFuZGxlci4g
U29tZSBJT01NVSBkcml2ZXJzIGp1c3QgcGFzcyB0aGUgSU9NTVUgZGV2aWNlIHRvCnJlcG9ydF9p
b21tdV9mYXVsdCgpLiBJJ2xsIHByb2JhYmx5IHBpY2sgdGhhdCB1cCBhdCBzb21lIHBvaW50LgoK
VGhhbmtzLApKZWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
