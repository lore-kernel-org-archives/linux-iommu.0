Return-Path: <SRS0=acbz=LZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A256DC11F64
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 09:26:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F21561492
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 09:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F21561492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 046BF400D9;
	Thu,  1 Jul 2021 09:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ptfj6zKsGCP; Thu,  1 Jul 2021 09:26:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7B6340175;
	Thu,  1 Jul 2021 09:26:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B48FC001A;
	Thu,  1 Jul 2021 09:26:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34206C000E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 09:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B58583C1E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 09:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EN-Y5i2vOIJW for <iommu@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 09:26:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5691F83C1B
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 09:26:50 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210701092647euoutp01be219167ea909e834918857f2aed3af8~NoJYqr7HP2740727407euoutp01g
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 09:26:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210701092647euoutp01be219167ea909e834918857f2aed3af8~NoJYqr7HP2740727407euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1625131607;
 bh=pFxbu6W1zqy25WaKD6FvSezlWD7U/LTkGDdeKblBEzM=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=j0VBFNKSgsa55lg4n2Kgb3dgvZwoYE9AeGO0+GS4oC3OJxT5tdQrmibx6g8BcCn4o
 6rGqBuTFhYdYS7THR9Ldxar6VPrLJOft907pin0UrpYKiGRp2YNedjH8uj5wqdPocU
 gZhXTZVZbuBnHoVH+J/H/4kUCioiOws7m01xghlQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210701092647eucas1p1c583e6368c559eb0c0b1f7911efeca8b~NoJYbRUnK1162711627eucas1p1w;
 Thu,  1 Jul 2021 09:26:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.AF.45756.75A8DD06; Thu,  1
 Jul 2021 10:26:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210701092646eucas1p21e2b799d2c67f07dec29e696fbefaff9~NoJX6Q14c2716127161eucas1p2N;
 Thu,  1 Jul 2021 09:26:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210701092646eusmtrp1eb8c20bca6ac839a6b225805ec458284~NoJX5WhG00277002770eusmtrp1k;
 Thu,  1 Jul 2021 09:26:46 +0000 (GMT)
X-AuditID: cbfec7f2-7bdff7000002b2bc-72-60dd8a571f33
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.C2.20981.65A8DD06; Thu,  1
 Jul 2021 10:26:46 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210701092645eusmtip1f1d8d6caf01d05f2fb6ffe278c38f9d2~NoJXPGwS51915719157eusmtip1Z;
 Thu,  1 Jul 2021 09:26:45 +0000 (GMT)
Subject: Re: [PATCH] iommu/arm: Cleanup resources in case of probe error path
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a72b0a47-9de9-ebb9-e0eb-70e3bb20942a@samsung.com>
Date: Thu, 1 Jul 2021 11:26:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bf8d3101-1db7-ee5a-377c-2196e3ce84e3@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87rhXXcTDL58Z7a4tH0Zq8WC/dYW
 DasvsFq0zFrEYrHp8TVWi4n7z7JbXN41h83i4IcnQIk7pg6cHmvmrWH02DnrLrvHplWdbB53
 ru1h89i8pN5j8o3ljB69ze/YPD5vkgvgiOKySUnNySxLLdK3S+DK+HvjGUtBi3bF3uMrmBsY
 G1W6GDk5JARMJLa++8nYxcjFISSwglHi9JRN7BDOF0aJGy/mMEE4nxklXnfMYodpabh9ixUi
 sZxR4tqCD8wQzkdGiZ4Lf5hAqoQF/CU6v/1mBLFFBNwkzh+czAJSxCzQwyTxrOkYC0iCTcBQ
 outtFxuIzStgJ/H40UKwZhYBFYnXr6+DNYsKJEu8nzeDFaJGUOLkzCdAvRwcnALWEm/X+YKE
 mQXkJZq3zmaGsMUlbj2ZD3a2hEAzp8SaDTOYIM52kej+towZwhaWeHV8C9Q7MhKnJ/ewQDUw
 Sjw8t5YdwulhlLjcNIMRospa4s65X2wgm5kFNCXW79KHCDtKLOmfywwSlhDgk7jxVhDiCD6J
 SdumQ4V5JTrahCCq1SRmHV8Ht/bghUvMExiVZiH5bBaSd2YheWcWwt4FjCyrGMVTS4tz01OL
 DfNSy/WKE3OLS/PS9ZLzczcxAlPW6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8UTtvJwjxpiRW
 VqUW5ccXleakFh9ilOZgURLnXTV7TbyQQHpiSWp2ampBahFMlomDU6qBybmC4aCw/PTCEmWh
 6vCbLtE/1+/VWiDPy+72XCB35oQloYGye47YNm+r77oV4d8vOuuNtXNh9LTwrIO/vtjauUbs
 Zbr1Q7FZZnX/Zp9ug0nHNznJpX22fuQkHhY/u1/cu9Mv9x6j2ydVPi/ev0J+dm/npGnJvMh7
 t28LZ+767u1fFlZtfHfLfRfHhUlHnj5R2bDuTrn/GyW3/1yh71W1UoKyDI3OzUlYvG39BumH
 weofpN5NOGeznXFNzGIJ88e+U9RdDSJ+zprq7bigsuCxX3e5pPsy/tj41c++6HNxGHzWv33q
 mcHOtJNry++1n1ha7bB+pZzhdgH1tOXMbwzYAj7fOljyTezY1NgbQWW2SizFGYmGWsxFxYkA
 /gFBQMgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7phXXcTDCYfE7O4tH0Zq8WC/dYW
 DasvsFq0zFrEYrHp8TVWi4n7z7JbXN41h83i4IcnQIk7pg6cHmvmrWH02DnrLrvHplWdbB53
 ru1h89i8pN5j8o3ljB69ze/YPD5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
 No+1MjJV0rezSUnNySxLLdK3S9DL+HvjGUtBi3bF3uMrmBsYG1W6GDk5JARMJBpu32LtYuTi
 EBJYyijxZP1cdoiEjMTJaQ2sELawxJ9rXWwQRe8ZJRb2nmUGSQgL+EosPLKPEcQWEXCTOH9w
 MgtIEbNAD5PE2Vl/wYqEBF4ySyx5ZA5iswkYSnS9BZnEycErYCfx+NFCJhCbRUBF4vXr62CD
 RAWSJX6ub4eqEZQ4OfMJ0FAODk4Ba4m363xBwswCZhLzNj9khrDlJZq3zoayxSVuPZnPNIFR
 aBaS7llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwAjdduznlh2MK199
 1DvEyMTBeIhRgoNZSYQ3auftBCHelMTKqtSi/Pii0pzU4kOMpkDvTGSWEk3OB6aIvJJ4QzMD
 U0MTM0sDU0szYyVxXpMja+KFBNITS1KzU1MLUotg+pg4OKUamHi0xPXCnT9rfT9ese1OQGmV
 mO3Vxcv/85XkvNnsz7Q9vrP25a1V6SEspT97+vonOnGxH58poOEmuyvzNMu2+z/7f9yMeHzq
 6el6L/nqq9YGhueezM85NfuNtGlPXt30FYcM/mwpXNt6KUNfPcmeyeLTof+yCTt+WYmp3+NM
 +3ot8+fj+TrJfPt1Nf12by1iZMzQamvJT2R59NQteL7Toi/zlz/X1Su46H93yslFLK/Edwln
 6LYqBgeZHH/E4BS9ZfLJg1mO878e/cZaf3L6Mt2HK1Tezb4YEejVtmvTiyPTJPf4OEwPjTfX
 +H5Vs27zi6RCwQuPD/xY49owV2Ln7tl7ElTLKtJnnk1NLvxcLa7EUpyRaKjFXFScCADsGacR
 WQMAAA==
X-CMS-MailID: 20210701092646eucas1p21e2b799d2c67f07dec29e696fbefaff9
X-Msg-Generator: CA
X-RootMTR: 20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26
References: <20210608164559.204023-1-ameynarkhede03@gmail.com>
 <CGME20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26@eucas1p2.samsung.com>
 <26f6a765-37c8-d63a-a779-384f095d5770@samsung.com>
 <20210630125940.GA8515@willie-the-truck>
 <4e3b1685-323e-2a7e-3aae-7c21b28fc65f@samsung.com>
 <bc07bd52-ed2e-0a44-80a7-36b581018b40@arm.com>
 <d3fee5f3-a435-7aa8-62ae-060e9b2aa532@samsung.com>
 <20210701090112.GA9489@willie-the-truck>
 <bf8d3101-1db7-ee5a-377c-2196e3ce84e3@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, Amey Narkhede <ameynarkhede03@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMDEuMDcuMjAyMSAxMToxMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDctMDEg
MTA6MDEsIFdpbGwgRGVhY29uIHdyb3RlOgo+PiBPbiBUaHUsIEp1bCAwMSwgMjAyMSBhdCAxMDoy
OToyOUFNICswMjAwLCBNYXJlayBTenlwcm93c2tpIHdyb3RlOgo+Pj4gSGkgUm9iaW4sCj4+Pgo+
Pj4gT24gMzAuMDYuMjAyMSAxNjowMSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+IE9uIDIwMjEt
MDYtMzAgMTQ6NDgsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6Cj4+Pj4+IE9uIDMwLjA2LjIwMjEg
MTQ6NTksIFdpbGwgRGVhY29uIHdyb3RlOgo+Pj4+Pj4gT24gV2VkLCBKdW4gMzAsIDIwMjEgYXQg
MDI6NDg6MTVQTSArMDIwMCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPj4+Pj4+PiBPbiAwOC4w
Ni4yMDIxIDE4OjQ1LCBBbWV5IE5hcmtoZWRlIHdyb3RlOgo+Pj4+Pj4+PiBJZiBkZXZpY2UgcmVn
aXN0cmF0aW9uIGZhaWxzLCByZW1vdmUgc3lzZnMgYXR0cmlidXRlCj4+Pj4+Pj4+IGFuZCBpZiBz
ZXR0aW5nIGJ1cyBjYWxsYmFja3MgZmFpbHMsIHVucmVnaXN0ZXIgdGhlIGRldmljZQo+Pj4+Pj4+
PiBhbmQgY2xlYW51cCB0aGUgc3lzZnMgYXR0cmlidXRlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbWV5IE5hcmtoZWRlIDxhbWV5bmFya2hlZGUwM0BnbWFpbC5jb20+Cj4+Pj4+
Pj4gVGhpcyBwYXRjaCBsYW5kZWQgaW4gbGludXgtbmV4dCBzb21lIHRpbWUgYWdvIGFzIGNvbW1p
dCAKPj4+Pj4+PiAyNDljOWRjNmFhMGQKPj4+Pj4+PiAoImlvbW11L2FybTogQ2xlYW51cCByZXNv
dXJjZXMgaW4gY2FzZSBvZiBwcm9iZSBlcnJvciBwYXRoIikuIEFmdGVyCj4+Pj4+Pj4gYmlzZWN0
aW5nIGFuZCBzb21lIG1hbnVhbCBzZWFyY2hpbmcgSSBmaW5hbGx5IGZvdW5kIHRoYXQgaXQgaXMK
Pj4+Pj4+PiByZXNwb25zaWJsZSBmb3IgYnJlYWtpbmcgczJpZGxlIG9uIERyYWdvbkJvYXJkIDQx
MGMuIEhlcmUgaXMgdGhlIAo+Pj4+Pj4+IGxvZwo+Pj4+Pj4+IChjYXB0dXJlZCB3aXRoIG5vX2Nv
bnNvbGVfc3VzcGVuZCk6Cj4+Pj4+Pj4KPj4+Pj4+PiAjIHRpbWUgcnRjd2FrZSAtczEwIC1tbWVt
Cj4+Pj4+Pj4gcnRjd2FrZTogd2FrZXVwIGZyb20gIm1lbSIgdXNpbmcgL2Rldi9ydGMwIGF0IFRo
dSBKYW7Dr8K/wr0gMSAKPj4+Pj4+PiAwMDowMjoxMyAxOTcwCj4+Pj4+Pj4gUE06IHN1c3BlbmQg
ZW50cnkgKHMyaWRsZSkKPj4+Pj4+PiBGaWxlc3lzdGVtcyBzeW5jOiAwLjAwMiBzZWNvbmRzCj4+
Pj4+Pj4gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgLi4uIChlbGFwc2VkIDAuMDA2IHNl
Y29uZHMpIGRvbmUuCj4+Pj4+Pj4gT09NIGtpbGxlciBkaXNhYmxlZC4KPj4+Pj4+PiBGcmVlemlu
ZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIC4uLiAoZWxhcHNlZCAwLjAwNCBzZWNvbmRzKSAK
Pj4+Pj4+PiBkb25lLgo+Pj4+Pj4+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MKPj4+Pj4+PiAwMDAwMDAwMDAwMDAwMDcw
Cj4+Pj4+Pj4gTWVtIGFib3J0IGluZm86Cj4+Pj4+Pj4gw6/Cv8K9w6/Cv8K9IMOvwr/CvSBFU1Ig
PSAweDk2MDAwMDA2Cj4+Pj4+Pj4gw6/Cv8K9w6/Cv8K9IMOvwr/CvSBFQyA9IDB4MjU6IERBQlQg
KGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMKPj4+Pj4+PiDDr8K/wr3Dr8K/wr0gw6/Cv8K9IFNF
VCA9IDAsIEZuViA9IDAKPj4+Pj4+PiDDr8K/wr3Dr8K/wr0gw6/Cv8K9IEVBID0gMCwgUzFQVFcg
PSAwCj4+Pj4+Pj4gw6/Cv8K9w6/Cv8K9IMOvwr/CvSBGU0MgPSAweDA2OiBsZXZlbCAyIHRyYW5z
bGF0aW9uIGZhdWx0Cj4+Pj4+Pj4gRGF0YSBhYm9ydCBpbmZvOgo+Pj4+Pj4+IMOvwr/CvcOvwr/C
vSDDr8K/wr0gSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNgo+Pj4+Pj4+IMOvwr/CvcOvwr/CvSDD
r8K/wr0gQ00gPSAwLCBXblIgPSAwCj4+Pj4+Pj4gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgt
Yml0IFZBcywgcGdkcD0wMDAwMDAwMDhhZDA4MDAwCj4+Pj4+Pj4gWzAwMDAwMDAwMDAwMDAwNzBd
IHBnZD0wODAwMDAwMDg1YzNjMDAzLCBwNGQ9MDgwMDAwMDA4NWMzYzAwMywKPj4+Pj4+PiBwdWQ9
MDgwMDAwMDA4OGRjZjAwMywgcG1kPTAwMDAwMDAwMDAwMDAwMDAKPj4+Pj4+PiBJbnRlcm5hbCBl
cnJvcjogT29wczogOTYwMDAwMDYgWyMxXSBQUkVFTVBUIFNNUAo+Pj4+Pj4+IE1vZHVsZXMgbGlu
a2VkIGluOiBibHVldG9vdGggZWNkaF9nZW5lcmljIGVjYyByZmtpbGwgaXB2NiBheDg4Nzk2Ygo+
Pj4+Pj4+IHZlbnVzX2VuYyB2ZW51c19kZWMgdmlkZW9idWYyX2RtYV9jb250aWcgYXNpeCBjcmN0
MTBkaWZfY2UgYWR2NzUxMQo+Pj4+Pj4+IHNuZF9zb2NfbXNtODkxNl9hbmFsb2cgcWNvbV9zcG1p
X3RlbXBfYWxhcm0gcnRjX3BtOHh4eCBxY29tX3Bvbgo+Pj4+Pj4+IHFjb21fY2Ftc3MgcWNvbV9z
cG1pX3ZhZGMgdmlkZW9idWYyX2RtYV9zZyBxY29tX3ZhZGNfY29tbW9uIG1zbQo+Pj4+Pj4+IHZl
bnVzX2NvcmUgdjRsMl9md25vZGUgdjRsMl9hc3luYyBzbmRfc29jX21zbTg5MTZfZGlnaXRhbAo+
Pj4+Pj4+IHZpZGVvYnVmMl9tZW1vcHMgc25kX3NvY19scGFzc19hcHE4MDE2IHNuZF9zb2NfbHBh
c3NfY3B1IAo+Pj4+Pj4+IHY0bDJfbWVtMm1lbQo+Pj4+Pj4+IHNuZF9zb2NfbHBhc3NfcGxhdGZv
cm0gc25kX3NvY19hcHE4MDE2X3NiYyB2aWRlb2J1ZjJfdjRsMgo+Pj4+Pj4+IHNuZF9zb2NfcWNv
bV9jb21tb24gcWNvbV9ybmcgdmlkZW9idWYyX2NvbW1vbiBpMmNfcWNvbV9jY2kKPj4+Pj4+PiBx
bm9jX21zbTg5MTYKPj4+Pj4+PiB2aWRlb2RldiBtYyBpY2Nfc21kX3JwbSBtZHRfbG9hZGVyIHNv
Y2luZm8gZGlzcGxheV9jb25uZWN0b3IgCj4+Pj4+Pj4gcm10ZnNfbWVtCj4+Pj4+Pj4gQ1BVOiAx
IFBJRDogMTUyMiBDb21tOiBydGN3YWtlIE5vdCB0YWludGVkIDUuMTMuMC1uZXh0LTIwMjEwNjI5
IAo+Pj4+Pj4+ICMzNTkyCj4+Pj4+Pj4gSGFyZHdhcmUgbmFtZTogUXVhbGNvbW0gVGVjaG5vbG9n
aWVzLCBJbmMuIEFQUSA4MDE2IFNCQyAoRFQpCj4+Pj4+Pj4gcHN0YXRlOiA4MDAwMDAwNSAoTnpj
diBkYWlmIC1QQU4gLVVBTyAtVENPIEJUWVBFPS0tKQo+Pj4+Pj4+IHBjIDogbXNtX3J1bnRpbWVf
c3VzcGVuZCsweDFjLzB4NjAgW21zbV0KPj4+Pj4+PiBsciA6IG1zbV9wbV9zdXNwZW5kKzB4MTgv
MHgzOCBbbXNtXQo+Pj4+Pj4+IC4uLgo+Pj4+Pj4+IENhbGwgdHJhY2U6Cj4+Pj4+Pj4gw6/Cv8K9
w6/Cv8K9IMOvwr/CvW1zbV9ydW50aW1lX3N1c3BlbmQrMHgxYy8weDYwIFttc21dCj4+Pj4+Pj4g
w6/Cv8K9w6/Cv8K9IMOvwr/CvW1zbV9wbV9zdXNwZW5kKzB4MTgvMHgzOCBbbXNtXQo+Pj4+Pj4+
IMOvwr/CvcOvwr/CvSDDr8K/wr1kcG1fcnVuX2NhbGxiYWNrKzB4ODQvMHgzNzgKPj4+Pj4+IEkg
d29uZGVyIGlmIHdlJ3JlIG1pc3NpbmcgYSBwbV9ydW50aW1lX2Rpc2FibGUoKSBjYWxsIG9uIHRo
ZSBmYWlsdXJlCj4+Pj4+PiBwYXRoPwo+Pj4+Pj4gaS5lLiBzb21ldGhpbmcgbGlrZSB0aGUgZGlm
ZiBiZWxvdy4uLgo+Pj4+Pgo+Pj4+PiBJJ3ZlIGNoZWNrZWQgYW5kIGl0IGRvZXNuJ3QgZml4IGFu
eXRoaW5nLgo+Pj4+Cj4+Pj4gV2hhdCdzIGhhcHBlbmVkIHByZXZpb3VzbHk/IEhhcyBhbiBJT01N
VSBhY3R1YWxseSBmYWlsZWQgdG8gcHJvYmUsIG9yCj4+Pj4gaXMgdGhpcyBhIGZpZGRseSAiY29k
ZSBtb3ZlbWVudCB1bnZlaWxzIGxhdGVudCBidWcgZWxzZXdoZXJlIiBraW5kIG9mCj4+Pj4gdGhp
bmc/IFRoZXJlIGRvZXNuJ3QgbG9vayB0byBiZSBtdWNoIGNhcGFibGUgb2YgZ29pbmcgd3Jvbmcg
aW4KPj4+PiBtc21fcnVudGltZV9zdXNwZW5kKCkgaXRzZWxmLCBzbyBpcyB0aGUgRFJNIGRyaXZl
ciBhbHNvIGluIGEgYnJva2VuCj4+Pj4gaGFsZi1wcm9iZWQgc3RhdGUgd2hlcmUgaXQncyBsZWZ0
IGl0cyBwbV9ydW50aW1lX29wcyBiZWhpbmQgd2l0aG91dAo+Pj4+IGl0cyBkcnZkYXRhIGJlaW5n
IHZhbGlkPwo+Pj4+Cj4+PiBJIGZpbmFsbHkgaGFkIHNvbWUgdGltZSB0byBhbmFseXplIHRoaXMg
aXNzdWUuIEl0IHR1cm5lZCBvdXQgdGhhdCB3aXRoCj4+PiB0aGlzIHBhdGNoLCBpb21tdSBmYWls
cyB0byBwcm9iZSBmb3Igc29jOmlvbW11QDFmMDgwMDAgZGV2aWNlLCB3aGlsZSBpdAo+Pj4gd29y
a2VkIGZpbmUgYmVmb3JlLiBUaGlzIGhhcHBlbnMgYmVjYXVzZSB0aGlzIHBhdGNoIGFkZHMgYSBj
aGVjayBmb3IgCj4+PiB0aGUKPj4+IHJldHVybiB2YWx1ZSBvZiB0aGUgYnVzX3NldF9pb21tdSgp
IGluCj4+PiBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9xY29tX2lvbW11LmMuIFdoZW4gSSBy
ZW1vdmVkIHRoYXQgY2hlY2ssIGl0Cj4+PiBwcm9iZXMgc3VjY2Vzc2Z1bGx5IGFnYWluLiBJdCBs
b29rcyB0aGF0IHRoZXJlIGFyZSBhbHJlYWR5IGlvbW11IG9wcwo+Pj4gcmVnaXN0ZXJlZCBmb3Ig
cGxhdGZvcm0gYnVzLCBiZWZvcmUgcWNvbV9pb21tdSBwcm9iZXMuIE9uIHRoZSBvdGhlcgo+Pj4g
aGFuZCwgaWYgSSByZW1lbWJlciBjb3JyZWN0bHkgdGhleSBhcmUgbm90IHVzZWQgZHVyaW5nIHRo
ZSBkZXZpY2UKPj4+IHJlZ2lzdHJhdGlvbiwgYnV0IHRoZXkgYXJlIG5lZWRlZCBmb3Igc29tZSBs
ZWdhY3kgc3R1ZmYuIEkgY2FuIHNlbmQgYQo+Pj4gcGF0Y2ggcmVzdG9yaW5nIG9sZCBjb2RlIGZs
b3cgaWYgeW91IHRoaW5rIHRoYXQgdGhpcyBpcyBhIHJpZ2h0IAo+Pj4gc29sdXRpb24uCj4+Cj4+
IFllcywgbGV0J3MganVzdCByZXZlcnQgdGhlIHFjb21faW9tbXUuYyBjaGFuZ2VzIGZyb20gdGhh
dCBwYXRjaCBmb3Igbm93Lgo+PiBUaGUgcG0gcnVudGltZSBzdHVmZiBsb29rcyBkb2RneSBhbnl3
YXkgc28gSSB0aGluayB0aGlzIG5lZWRzIG1vcmUgCj4+IHRob3VnaHQuCj4KPiBPaCwgcmlnaHQs
IGJsaW5kbHkgcmV0dXJuaW5nIHRoZSAtRUJVU1kgZnJvbSBidXNfc2V0X2lvbW11KCkgYmVjYXVz
ZSAKPiB3ZSdyZSBub3QgdGhlIGZpcnN0IGluc3RhbmNlIHRvIHByb2JlIGlzIGRlZmluaXRlbHkg
dGhlIHdyb25nIHRoaW5nIHRvIAo+IGRvIGFzIHdlbGwuIEl0J3Mgc3RpbGwgbm90IGNsZWFyIHdo
eSBmYWlsaW5nIG1ha2VzIHRoZSBEUk0gZHJpdmVyIGZhbGwgCj4gb3ZlciwgYnV0ICsxIHRvIHFj
b20taW9tbXUgbmVlZGluZyBzb21lIGRlZXBlciBjb25zaWRlcmF0aW9uLgoKSSd2ZSBqdXN0IGNo
ZWNrZWQgYW5kIGJ1c19zZXRfaW9tbXUoKSBpcyBjYWxsZWQgZm9yIGV2ZXJ5IAoncWNvbSxtc20t
aW9tbXUtdjEnIGRldmljZSBpbiB0aGUgc3lzdGVtLCB0aHVzIGl0IGZhaWxzIGZvciB0aGUgc2Vj
b25kIAphbmQgbmV4dCBkZXZpY2VzLgoKQmVzdCByZWdhcmRzCi0tIApNYXJlayBTenlwcm93c2tp
LCBQaEQKU2Ftc3VuZyBSJkQgSW5zdGl0dXRlIFBvbGFuZAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
