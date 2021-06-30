Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2527FC11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 13:48:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB484616ED
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 13:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB484616ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74A1F405D2;
	Wed, 30 Jun 2021 13:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n99Ho6GiAApn; Wed, 30 Jun 2021 13:48:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 141F340486;
	Wed, 30 Jun 2021 13:48:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA9BFC0010;
	Wed, 30 Jun 2021 13:48:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F2EFC000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F03883B5A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:48:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y7Pb0USH1YUS for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 13:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0C31834C6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:48:50 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210630134848euoutp0142b566759d94cf924c538a03989a6462~NYE3mz-XC3108031080euoutp01D
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:48:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210630134848euoutp0142b566759d94cf924c538a03989a6462~NYE3mz-XC3108031080euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1625060928;
 bh=eRkMIlI7MNeZRZM/CDKQFoyXAVJIRsZSaQjjDRu3RGg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=EWTIcGIHVONDwG1hfFso/+At73a/95gWL7diUvM3LW1NXyh6Iyr9jBESgaX/lj2We
 k1OPINkpkWT2uaPG3kaNBbDYQBBlYL26GC/s8guc6MLZJRlTn30DmFO3SaccPjeM9L
 G5d1x+XuOaLhAUFvl/6i4kzkJFfD3uB7w/sn0DI4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210630134847eucas1p26f5337fa968a8aed68ab76bf618eea06~NYE3VSyhs0526105261eucas1p2L;
 Wed, 30 Jun 2021 13:48:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 08.3A.42068.F367CD06; Wed, 30
 Jun 2021 14:48:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210630134847eucas1p1545a662e60fce487e35fa2c5248524ac~NYE21EC-z0948509485eucas1p1A;
 Wed, 30 Jun 2021 13:48:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210630134847eusmtrp264572f9c017ea8ff2d2db5f182e9e971~NYE20NBZu3264132641eusmtrp2J;
 Wed, 30 Jun 2021 13:48:47 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-8f-60dc763f8eb4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.C0.20981.F367CD06; Wed, 30
 Jun 2021 14:48:47 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210630134846eusmtip197037ac81be721ec5765ffa1bb88628f~NYE1_VEjF2323923239eusmtip1H;
 Wed, 30 Jun 2021 13:48:46 +0000 (GMT)
Subject: Re: [PATCH] iommu/arm: Cleanup resources in case of probe error path
To: Will Deacon <will@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4e3b1685-323e-2a7e-3aae-7c21b28fc65f@samsung.com>
Date: Wed, 30 Jun 2021 15:48:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630125940.GA8515@willie-the-truck>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7djP87r2ZXcSDDY8MLG4tH0Zq8WC/dYW
 DasvsFqsWniNzaJl1iIWi87ZG9gtNj2+xmoxcf9ZdovLu+awWTxf+IPZ4uCHJ6wWS6YeZLOY
 fO0bq0Xf3iCLljumFjeXbmB3EPB4cnAek8eaeWsYPS739TJ57Jx1l93j8dyN7B4tR96yemxa
 1cnmcefaHjaPzUvqPSbfWM7o0dv8js3j8ya5AJ4oLpuU1JzMstQifbsErozTNyawFDxXqGi4
 v4OpgfGrZBcjJ4eEgInEz+69LF2MXBxCAisYJXZ8esgG4XxhlLh/azEzhPOZUWLCzL2sMC2t
 PUuhEsuBWr4cYYRwPjJKTH65kgWkSljAX6Lz229GEFtEQFFix/Y/YB3MApdYJHat6GMGSbAJ
 GEp0ve1iA7F5BewkFhx7yw5iswioSmy7eRasWVQgWeL9vBmsEDWCEidnPgFbwClgKvFy8X+w
 emYBeYnmrbOZIWxxiVtP5jOBLJMQOMUpsXzNLqAFHECOi8TWeWEQLwhLvDq+hR3ClpH4vxOm
 vplR4uG5tewQTg+jxOWmGYwQVdYSd879AhvELKApsX6XPkTYUWJJ/1xmiPl8EjfeCkLcwCcx
 adt0qDCvREebEES1msSs4+vg1h68cIl5AqPSLCSfzULyzSwk38xC2LuAkWUVo3hqaXFuemqx
 UV5quV5xYm5xaV66XnJ+7iZGYHo8/e/4lx2My1991DvEyMTBeIhRgoNZSYQ3auftBCHelMTK
 qtSi/Pii0pzU4kOM0hwsSuK8SVvWxAsJpCeWpGanphakFsFkmTg4pRqYtl+3vDqreueb/1JC
 S1fd6Nt6+0eae7R2WtWP0y8npDvO/5d8P3C23z7D5/9iemS+ags2Sbda+65tYvPey6LR3HPD
 e/vnR6VbDl++cVppxylxL73Tixb6m2cd5J3AH3HxmIzalCnvah/sMsjtidSKnJ57vHfNupUv
 D5hN3M/NPeufXYT25rOXOdWOO6YbPBZjVxNNfn3rpe/k7mj5+cq5XKcTY4pbV+rUc2+Ym/5M
 rmhP+dzyqH4LxQqHF3vvNOb8jNuQdp+JP9Ej6/7UtetFbV2YXGYJCO3Kc6k7NVMh6/8sZtYN
 /dsF/rCdEv38n/Gtir/QE4Xbr4unndG/4/67pSq0ImhCkHe4BPc5354LSizFGYmGWsxFxYkA
 b4rk2v4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7r2ZXcSDKZ2CVtc2r6M1WLBfmuL
 htUXWC1WLbzGZtEyaxGLRefsDewWmx5fY7WYuP8su8XlXXPYLJ4v/MFscfDDE1aLJVMPsllM
 vvaN1aJvb5BFyx1Ti5tLN7A7CHg8OTiPyWPNvDWMHpf7epk8ds66y+7xeO5Gdo+WI29ZPTat
 6mTzuHNtD5vH5iX1HpNvLGf06G1+x+bxeZNcAE+Unk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
 iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbpGxNYCp4rVDTc38HUwPhVsouRk0NCwESitWcp
 cxcjF4eQwFJGiQUzX7FDJGQkTk5rYIWwhSX+XOtiA7GFBN4zSpxZYgliCwv4Siw8so8RxBYR
 UJTYsf0P2CBmgSssEjMv/2KCmPqJUWLr4+VgU9kEDCW63kJM4hWwk1hw7C1YnEVAVWLbzbNg
 k0QFkiV+rm+HqhGUODnzCQuIzSlgKvFy8X+wemYBM4l5mx8yQ9jyEs1bZ0PZ4hK3nsxnmsAo
 NAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYDrYduznlh2MK199
 1DvEyMTBeIhRgoNZSYQ3auftBCHelMTKqtSi/Pii0pzU4kOMpkD/TGSWEk3OByakvJJ4QzMD
 U0MTM0sDU0szYyVxXpMja+KFBNITS1KzU1MLUotg+pg4OKUamDwenT6anvr+0PWZqv+X7VNk
 35vaeLhtmuSrnxc+vJRW+fi5RLXNXHv2pOtqZdIRm1z5hY2/b/ebmdJW6uv/S7JygcmXj+4u
 9d8mfze8cWzK3sTuyTNud3JeXMdX2GCqxBit8mgXTzqDq/vyz9Xh358/ufa09TXXbRmurot8
 mv+TSvtfHBUsWC7beP1SsZbHpind1UedWlT/RNrN+jm9yef99see8270PL7VyX1f1mz5zhTz
 6/rrGw/KtDHutxM6/vCZylbrDTY/su4YsfUkXL77c6UfD4sOwy1TtS7LMp+P70KXGF25H3rQ
 zFFU9Z+PVUiW+zJZn2pmT4kVGuK24rmfJIBxsNzG8m1U3nVtJZbijERDLeai4kQAYf2qyZAD
 AAA=
X-CMS-MailID: 20210630134847eucas1p1545a662e60fce487e35fa2c5248524ac
X-Msg-Generator: CA
X-RootMTR: 20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26
References: <20210608164559.204023-1-ameynarkhede03@gmail.com>
 <CGME20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26@eucas1p2.samsung.com>
 <26f6a765-37c8-d63a-a779-384f095d5770@samsung.com>
 <20210630125940.GA8515@willie-the-truck>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Amey Narkhede <ameynarkhede03@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

T24gMzAuMDYuMjAyMSAxNDo1OSwgV2lsbCBEZWFjb24gd3JvdGU6Cj4gT24gV2VkLCBKdW4gMzAs
IDIwMjEgYXQgMDI6NDg6MTVQTSArMDIwMCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPj4gT24g
MDguMDYuMjAyMSAxODo0NSwgQW1leSBOYXJraGVkZSB3cm90ZToKPj4+IElmIGRldmljZSByZWdp
c3RyYXRpb24gZmFpbHMsIHJlbW92ZSBzeXNmcyBhdHRyaWJ1dGUKPj4+IGFuZCBpZiBzZXR0aW5n
IGJ1cyBjYWxsYmFja3MgZmFpbHMsIHVucmVnaXN0ZXIgdGhlIGRldmljZQo+Pj4gYW5kIGNsZWFu
dXAgdGhlIHN5c2ZzIGF0dHJpYnV0ZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbWV5IE5hcmto
ZWRlIDxhbWV5bmFya2hlZGUwM0BnbWFpbC5jb20+Cj4+IFRoaXMgcGF0Y2ggbGFuZGVkIGluIGxp
bnV4LW5leHQgc29tZSB0aW1lIGFnbyBhcyBjb21taXQgMjQ5YzlkYzZhYTBkCj4+ICgiaW9tbXUv
YXJtOiBDbGVhbnVwIHJlc291cmNlcyBpbiBjYXNlIG9mIHByb2JlIGVycm9yIHBhdGgiKS4gQWZ0
ZXIKPj4gYmlzZWN0aW5nIGFuZCBzb21lIG1hbnVhbCBzZWFyY2hpbmcgSSBmaW5hbGx5IGZvdW5k
IHRoYXQgaXQgaXMKPj4gcmVzcG9uc2libGUgZm9yIGJyZWFraW5nIHMyaWRsZSBvbiBEcmFnb25C
b2FyZCA0MTBjLiBIZXJlIGlzIHRoZSBsb2cKPj4gKGNhcHR1cmVkIHdpdGggbm9fY29uc29sZV9z
dXNwZW5kKToKPj4KPj4gIyB0aW1lIHJ0Y3dha2UgLXMxMCAtbW1lbQo+PiBydGN3YWtlOiB3YWtl
dXAgZnJvbSAibWVtIiB1c2luZyAvZGV2L3J0YzAgYXQgVGh1IEphbsKgIDEgMDA6MDI6MTMgMTk3
MAo+PiBQTTogc3VzcGVuZCBlbnRyeSAoczJpZGxlKQo+PiBGaWxlc3lzdGVtcyBzeW5jOiAwLjAw
MiBzZWNvbmRzCj4+IEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIC4uLiAoZWxhcHNlZCAw
LjAwNiBzZWNvbmRzKSBkb25lLgo+PiBPT00ga2lsbGVyIGRpc2FibGVkLgo+PiBGcmVlemluZyBy
ZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIC4uLiAoZWxhcHNlZCAwLjAwNCBzZWNvbmRzKSBkb25l
Lgo+PiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQg
dmlydHVhbCBhZGRyZXNzCj4+IDAwMDAwMDAwMDAwMDAwNzAKPj4gTWVtIGFib3J0IGluZm86Cj4+
ICAgwqAgRVNSID0gMHg5NjAwMDAwNgo+PiAgIMKgIEVDID0gMHgyNTogREFCVCAoY3VycmVudCBF
TCksIElMID0gMzIgYml0cwo+PiAgIMKgIFNFVCA9IDAsIEZuViA9IDAKPj4gICDCoCBFQSA9IDAs
IFMxUFRXID0gMAo+PiAgIMKgIEZTQyA9IDB4MDY6IGxldmVsIDIgdHJhbnNsYXRpb24gZmF1bHQK
Pj4gRGF0YSBhYm9ydCBpbmZvOgo+PiAgIMKgIElTViA9IDAsIElTUyA9IDB4MDAwMDAwMDYKPj4g
ICDCoCBDTSA9IDAsIFduUiA9IDAKPj4gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgtYml0IFZB
cywgcGdkcD0wMDAwMDAwMDhhZDA4MDAwCj4+IFswMDAwMDAwMDAwMDAwMDcwXSBwZ2Q9MDgwMDAw
MDA4NWMzYzAwMywgcDRkPTA4MDAwMDAwODVjM2MwMDMsCj4+IHB1ZD0wODAwMDAwMDg4ZGNmMDAz
LCBwbWQ9MDAwMDAwMDAwMDAwMDAwMAo+PiBJbnRlcm5hbCBlcnJvcjogT29wczogOTYwMDAwMDYg
WyMxXSBQUkVFTVBUIFNNUAo+PiBNb2R1bGVzIGxpbmtlZCBpbjogYmx1ZXRvb3RoIGVjZGhfZ2Vu
ZXJpYyBlY2MgcmZraWxsIGlwdjYgYXg4ODc5NmIKPj4gdmVudXNfZW5jIHZlbnVzX2RlYyB2aWRl
b2J1ZjJfZG1hX2NvbnRpZyBhc2l4IGNyY3QxMGRpZl9jZSBhZHY3NTExCj4+IHNuZF9zb2NfbXNt
ODkxNl9hbmFsb2cgcWNvbV9zcG1pX3RlbXBfYWxhcm0gcnRjX3BtOHh4eCBxY29tX3Bvbgo+PiBx
Y29tX2NhbXNzIHFjb21fc3BtaV92YWRjIHZpZGVvYnVmMl9kbWFfc2cgcWNvbV92YWRjX2NvbW1v
biBtc20KPj4gdmVudXNfY29yZSB2NGwyX2Z3bm9kZSB2NGwyX2FzeW5jIHNuZF9zb2NfbXNtODkx
Nl9kaWdpdGFsCj4+IHZpZGVvYnVmMl9tZW1vcHMgc25kX3NvY19scGFzc19hcHE4MDE2IHNuZF9z
b2NfbHBhc3NfY3B1IHY0bDJfbWVtMm1lbQo+PiBzbmRfc29jX2xwYXNzX3BsYXRmb3JtIHNuZF9z
b2NfYXBxODAxNl9zYmMgdmlkZW9idWYyX3Y0bDIKPj4gc25kX3NvY19xY29tX2NvbW1vbiBxY29t
X3JuZyB2aWRlb2J1ZjJfY29tbW9uIGkyY19xY29tX2NjaSBxbm9jX21zbTg5MTYKPj4gdmlkZW9k
ZXYgbWMgaWNjX3NtZF9ycG0gbWR0X2xvYWRlciBzb2NpbmZvIGRpc3BsYXlfY29ubmVjdG9yIHJt
dGZzX21lbQo+PiBDUFU6IDEgUElEOiAxNTIyIENvbW06IHJ0Y3dha2UgTm90IHRhaW50ZWQgNS4x
My4wLW5leHQtMjAyMTA2MjkgIzM1OTIKPj4gSGFyZHdhcmUgbmFtZTogUXVhbGNvbW0gVGVjaG5v
bG9naWVzLCBJbmMuIEFQUSA4MDE2IFNCQyAoRFQpCj4+IHBzdGF0ZTogODAwMDAwMDUgKE56Y3Yg
ZGFpZiAtUEFOIC1VQU8gLVRDTyBCVFlQRT0tLSkKPj4gcGMgOiBtc21fcnVudGltZV9zdXNwZW5k
KzB4MWMvMHg2MCBbbXNtXQo+PiBsciA6IG1zbV9wbV9zdXNwZW5kKzB4MTgvMHgzOCBbbXNtXQo+
PiAuLi4KPj4gQ2FsbCB0cmFjZToKPj4gICDCoG1zbV9ydW50aW1lX3N1c3BlbmQrMHgxYy8weDYw
IFttc21dCj4+ICAgwqBtc21fcG1fc3VzcGVuZCsweDE4LzB4MzggW21zbV0KPj4gICDCoGRwbV9y
dW5fY2FsbGJhY2srMHg4NC8weDM3OAo+IEkgd29uZGVyIGlmIHdlJ3JlIG1pc3NpbmcgYSBwbV9y
dW50aW1lX2Rpc2FibGUoKSBjYWxsIG9uIHRoZSBmYWlsdXJlIHBhdGg/Cj4gaS5lLiBzb21ldGhp
bmcgbGlrZSB0aGUgZGlmZiBiZWxvdy4uLgoKSSd2ZSBjaGVja2VkIGFuZCBpdCBkb2Vzbid0IGZp
eCBhbnl0aGluZy4KCj4gV2lsbAo+Cj4gLS0tPjgKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS9xY29tX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21t
dS9xY29tX2lvbW11LmMKPiBpbmRleCAyNWVkNDQ0ZmY5NGQuLmNlOGYzNTQ3NTVkMCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9xY29tX2lvbW11LmMKPiArKysgYi9k
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9xY29tX2lvbW11LmMKPiBAQCAtODM2LDE0ICs4MzYs
MTQgQEAgc3RhdGljIGludCBxY29tX2lvbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQo+ICAgICAgICAgIHJldCA9IGRldm1fb2ZfcGxhdGZvcm1fcG9wdWxhdGUo
ZGV2KTsKPiAgICAgICAgICBpZiAocmV0KSB7Cj4gICAgICAgICAgICAgICAgICBkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBwb3B1bGF0ZSBpb21tdSBjb250ZXh0c1xuIik7Cj4gLSAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7Cj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtX2Rpc2FibGU7Cj4g
ICAgICAgICAgfQo+ICAgCj4gICAgICAgICAgcmV0ID0gaW9tbXVfZGV2aWNlX3N5c2ZzX2FkZCgm
cWNvbV9pb21tdS0+aW9tbXUsIGRldiwgTlVMTCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9uYW1lKGRldikpOwo+ICAgICAgICAgIGlmIChyZXQpIHsKPiAgICAg
ICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIGlvbW11IGluIHN5
c2ZzXG4iKTsKPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKPiArICAgICAgICAgICAgICAg
Z290byBlcnJfcG1fZGlzYWJsZTsKPiAgICAgICAgICB9Cj4gICAKPiAgICAgICAgICByZXQgPSBp
b21tdV9kZXZpY2VfcmVnaXN0ZXIoJnFjb21faW9tbXUtPmlvbW11LCAmcWNvbV9pb21tdV9vcHMs
IGRldik7Cj4gQEAgLTg2OSw2ICs4NjksOSBAQCBzdGF0aWMgaW50IHFjb21faW9tbXVfZGV2aWNl
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gICAKPiAgIGVycl9zeXNmc19y
ZW1vdmU6Cj4gICAgICAgICAgaW9tbXVfZGV2aWNlX3N5c2ZzX3JlbW92ZSgmcWNvbV9pb21tdS0+
aW9tbXUpOwo+ICsKPiArZXJyX3BtX2Rpc2FibGU6Cj4gKyAgICAgICBwbV9ydW50aW1lX2Rpc2Fi
bGUoZGV2KTsKPiAgICAgICAgICByZXR1cm4gcmV0Owo+ICAgfQo+CkJlc3QgcmVnYXJkcwotLSAK
TWFyZWsgU3p5cHJvd3NraSwgUGhEClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
