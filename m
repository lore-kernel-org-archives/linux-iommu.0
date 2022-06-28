Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FD8C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 14:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94FED40C3C;
	Tue, 28 Jun 2022 14:21:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94FED40C3C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M4Yy8bip
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nFROIS39syrS; Tue, 28 Jun 2022 14:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 621C14014D;
	Tue, 28 Jun 2022 14:21:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 621C14014D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35AC9C0039;
	Tue, 28 Jun 2022 14:21:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D14B4C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B236240608
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:21:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B236240608
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E0OV77W7tjRj for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 14:21:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B07274014D
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B07274014D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:21:09 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id pk21so26158203ejb.2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=AZ1tY/fbYnbotdriO5S1rk84v9dQ1fc1bIXXi25ViSs=;
 b=M4Yy8biplcD6xIbSik7Fcanj3qmtX6uFR9Lkcg9HY9n8g3FbAUo/QCyipVsW7Jci/W
 76nJc0C4Qpa49bHjnodI8YHf+WPa5SaGG+EjfkUFHOKnlUtuQ6CROXVHEuKZnX/CpnBb
 mX6lu4SJJksUAqA5Mt/x2GJW7I+b6qEIW+PXpPA/+w2YWkE+9QRCSUIvYGi5xprrKF9D
 rVQ3kf6SiheUWDlrr/LE0VkX54WLqK4BZIiUu0tzWsts/0WbnNKrk0IqYkokD3unorO7
 V0ZCyCwpJtlkSobho6Ucmi7hZHCLLGDYI8FgiZaC5zhiI7DhrFhYUjIn7/mV5L1eDGZb
 V2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AZ1tY/fbYnbotdriO5S1rk84v9dQ1fc1bIXXi25ViSs=;
 b=ppbaGIJEED0ZuymIREyUculkPLD+SN2v3gLZxXWfgJTxO0Bruz9Xq0YMv0h+tDa6Q7
 Sngig++4BOYWaIObhpqkw8o5vX9/dYOA0DxT8iJAohdPntq+c4IAspMO3YS3Nob70KSm
 r7f8euHuEImwF2988UT1+UDNCx1+HS0wvSLJdzH9ZmoUTlTq4HMpOh4EObMD7YyLrrJ5
 NuSGBn9urB2eVvnlGZ70DBos/ZtiGTRnDPzqLWAx4fE8Q9QSJQ6bqY7h3vFNhXBKe54f
 Du1lPwmKMlJMe8ERTa0bI29SgOFbsp5tDQone3q7sdmRpHvsmhp0g1olyiZiAPYvGLJL
 Edug==
X-Gm-Message-State: AJIora/vzeRBNY465v5L23jgCAuDpyE1wKR3c+Pssi0YCl6XBPIKwLWu
 X01XoAM92p28pOvEMgwlknM75Q==
X-Google-Smtp-Source: AGRyM1vBIfDF8EgzPZnXgOQ5Ii/P2pbYxSeydCSmLWtpDh0bAERdGZisVP2CiMBF+dMiaZzFptnbAw==
X-Received: by 2002:a17:907:8a25:b0:726:c9f2:2f5e with SMTP id
 sc37-20020a1709078a2500b00726c9f22f5emr4317430ejc.286.1656426067781; 
 Tue, 28 Jun 2022 07:21:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 w16-20020a1709061f1000b0071d3b6ed4eesm6518768ejj.160.2022.06.28.07.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 07:21:07 -0700 (PDT)
Date: Tue, 28 Jun 2022 15:20:43 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Message-ID: <YrsOO9E+j+CMgKMA@myrica>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVHVlLCBKdW4gMjgsIDIwMjIgYXQgMDc6NTM6MzlQTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6
Cj4gPiA+ID4gT25jZSB0aGUgaW9wZl9oYW5kbGVfc2luZ2xlKCkgaXMgcmVtb3ZlZCwgdGhlIG5h
bWUgb2YKPiA+ID4gPiBpb3BmX2hhbmRsZV9ncm91cCgpIGxvb2tzIGEgbGl0dGxlIHdlaXJlZAo+
ID4gPiA+IAo+ID4gPiA+IGFuZCBjb25mdXNlZCwgZG9lcyB0aGlzIGdyb3VwIG1lYW4gdGhlIGlv
bW11IGdyb3VwIChkb21haW4pID8KPiA+ID4gPiB3aGlsZSBJIHRha2Ugc29tZSBtaW51dGVzIHRv
Cj4gPiA+IAo+ID4gPiBOby4gVGhpcyBpcyBub3QgdGhlIGlvbW11IGdyb3VwLiBJdCdzIHBhZ2Ug
cmVxdWVzdCBncm91cCBkZWZpbmVkIGJ5IHRoZQo+ID4gPiBQQ0kgU0lHIHNwZWMuIE11bHRpcGxl
IHBhZ2UgcmVxdWVzdHMgY291bGQgYmUgcHV0IGluIGEgZ3JvdXAgd2l0aCBhCj4gPiA+IHNhbWUg
Z3JvdXAgaWQuIEFsbCBwYWdlIHJlcXVlc3RzIGluIGEgZ3JvdXAgY291bGQgYmUgcmVzcG9uZGVk
IHRvIGRldmljZQo+ID4gPiBpbiBvbmUgc2hvdC4KPiA+IAo+ID4gVGhhbmtzIHlvdXIgZXhwbGFp
bmF0aW9uLCB1bmRlcnN0YW5kIHRoZSBjb25jZXB0IG9mIFBDSWUgUFJHLsKgIEkgbWVhbnQKPiA+
IAo+ID4gZG8gd2Ugc3RpbGwgaGF2ZSB0aGUgbmVjZXNzaXR5IHRvIG1lbnRpb24gdGhlICJncm91
cCIgaGVyZSBpbiB0aGUgbmFtZQo+ID4gCj4gPiBpb3BmX2hhbmRsZV9ncm91cCgpLMKgIHdoaWNo
IG9uZSBpcyBiZXR0ZXIgPyBpb3BmX2hhbmRsZV9wcmcoKSBvcgo+ID4gCj4gPiBpb3BmX2hhbmRs
ZXIoKSzCoCBwZXJoYXBzIG5vbmUgb2YgdGhlbSA/IDopCj4gCj4gT2ghIFNvcnJ5IGZvciB0aGUg
bWlzdW5kZXJzdGFuZGluZy4KPiAKPiBJIGhhdmUgbm8gc3Ryb25nIGZlZWxpbmcgdG8gY2hhbmdl
IHRoaXMgbmFtaW5nLiA6LSkgQWxsIHRoZSBuYW1lcwo+IGV4cHJlc3Mgd2hhdCB0aGUgaGVscGVy
IGRvZXMuIEplYW4gaXMgdGhlIGF1dGhvciBvZiB0aGlzIGZyYW1ld29yay4gSWYKPiBoZSBoYXMg
dGhlIHNhbWUgaWRlYSBhcyB5b3UsIEkgZG9uJ3QgbWluZCByZW5hbWluZyBpdCBpbiB0aGlzIHBh
dGNoLgoKSSdtIG5vdCBhdHRhY2hlZCB0byB0aGUgbmFtZSwgYW5kIEkgc2VlIGhvdyBpdCBjb3Vs
ZCBiZSBjb25mdXNpbmcuIEdpdmVuCnRoYXQgaW8tcGdmYXVsdCBpcyBub3Qgb25seSBmb3IgUENJ
ZSwgJ3ByZycgaXMgbm90IHRoZSBiZXN0IGhlcmUgZWl0aGVyLgppb3BmX2hhbmRsZV9mYXVsdHMo
KSwgb3IganVzdCBpb3BmX2hhbmRsZXIoKSwgc2VlbSBtb3JlIHN1aXRhYmxlLgoKVGhhbmtzLApK
ZWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
