Return-Path: <SRS0=acbz=LZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF7C11F64
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 08:29:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9482861490
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 08:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9482861490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B379400BF;
	Thu,  1 Jul 2021 08:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhXMTuJ1E9qQ; Thu,  1 Jul 2021 08:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8217E400CD;
	Thu,  1 Jul 2021 08:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BE6FC0010;
	Thu,  1 Jul 2021 08:29:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FBD1C000E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 08:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86FCD83C4E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 08:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WGp-Xvow4Lr for <iommu@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 08:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C9D083B7B
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 08:29:33 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210701082931euoutp019107570aca3cff19da5d2c12531e04bd~NnXYjqvK_3102931029euoutp01x
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 08:29:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210701082931euoutp019107570aca3cff19da5d2c12531e04bd~NnXYjqvK_3102931029euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1625128171;
 bh=Ot0MIWXbZbOHC3NOB3xttOMBVPOErGYNsWoNItxp+i4=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=DWaa94YP+lSTTgP8gzr8QPGCSpd6tTfjDKvE2mBuNaosQMI6L2RaqKqF4+79esJPc
 NCkwHlDusx06FNUqY5Y+N8R7M0Q9uKLbYfHiMMDdJQV4LGO7qLPd43UuHKq1tyIWnR
 gN+hfJ30OGCe7jc7w1aWTUqHFeZRRTtiDx14A8Wc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210701082930eucas1p2d9fe0e671a2c8dc1a503a5ce7d4fd168~NnXYNItde1092810928eucas1p2m;
 Thu,  1 Jul 2021 08:29:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id A7.35.45756.AEC7DD06; Thu,  1
 Jul 2021 09:29:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210701082930eucas1p10f9a8f82118f7ffc382f64ef2ad24992~NnXXugvq70677006770eucas1p1Q;
 Thu,  1 Jul 2021 08:29:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210701082930eusmtrp2de8c4edb9226c8039efadebb91a37f4f~NnXXtuvKe2939929399eusmtrp2r;
 Thu,  1 Jul 2021 08:29:30 +0000 (GMT)
X-AuditID: cbfec7f2-7d5ff7000002b2bc-70-60dd7cea291f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 99.98.20981.AEC7DD06; Thu,  1
 Jul 2021 09:29:30 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210701082929eusmtip1d7d9093bd66728eb0e71d576c4827499~NnXXIngwW2436324363eusmtip1Y;
 Thu,  1 Jul 2021 08:29:29 +0000 (GMT)
Subject: Re: [PATCH] iommu/arm: Cleanup resources in case of probe error path
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d3fee5f3-a435-7aa8-62ae-060e9b2aa532@samsung.com>
Date: Thu, 1 Jul 2021 10:29:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bc07bd52-ed2e-0a44-80a7-36b581018b40@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87qvau4mGEy6YGxxafsyVosF+60t
 GlZfYLVombWIxWLT42usFhP3n2W3uLxrDpvFwQ9PgBJ3TB04PdbMW8PosXPWXXaPTas62Tzu
 XNvD5rF5Sb3H5BvLGT16m9+xeXzeJBfAEcVlk5Kak1mWWqRvl8CV0fbpGFvBYcWKr/eusjQw
 vpPuYuTkkBAwkTjx5hdzFyMXh5DACkaJmY9WsEA4Xxglzk3Yww7hfGaUmPr2G2sXIwdYy8rF
 hhDx5YwS0+9dYYVwPjJKrHl2lBFkrrCAv0Tnt99gtoiAm8T5g5PBxjIL9DBJPGs6xgKSYBMw
 lOh628UGYvMK2El82f6ZHcRmEVCReLHrNCuILSqQLPF+3gxWiBpBiZMzn4D1cgpYS2xbOw/M
 ZhaQl2jeOpsZwhaXuPVkPhPIMgmBZk6J5ecOsEF86iKxeMIJJghbWOLV8S3sELaMxP+dcA2M
 Eg/PrWWHcHoYJS43zWCEqLKWuHPuFxsoAJgFNCXW79KHCDtKLOmfywwJFz6JG28FIY7gk5i0
 bTpUmFeio00IolpNYtbxdXBrD164xDyBUWkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgw
 L7Vcrzgxt7g0L10vOT93EyMwZZ3+d/zTDsa5rz7qHWJk4mA8xCjBwawkwhu183aCEG9KYmVV
 alF+fFFpTmrxIUZpDhYlcd5Vs9fECwmkJ5akZqemFqQWwWSZODilGpiqwrcwVBvv/S/cdcdc
 K4DjxQZH4Z7HgfPeZuz56WerHnb9fMafPYmsVWu6yqLNIrRO/WPg8vjD0bHQekL8NfmQ//KP
 91TInvpmp89c/ezGypfNVxw+HX3X4XXTYJqNbWA341rn17LMq76/1wq4eV+0ymCK1f0lxey+
 iyw/HOiukttr80TKaMaiFa0N8ia9N7P0bVI5j3jncwepTL7UlBzBmFllEXzji0b6m8mx4b+Z
 e24u9ep5u8Pm3421VxdEcK7dK2Qle6r4acnpyWkbHIV8jzQcmXtH88ezI1IpId+lDd7vOHdd
 72RxzZNEVc/FsRM1+k22f0o2CmacOn3yEr2sz2uav3KJ3etXsv34aKkSS3FGoqEWc1FxIgAF
 ZkiqyAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7qvau4mGNxsFLS4tH0Zq8WC/dYW
 DasvsFq0zFrEYrHp8TVWi4n7z7JbXN41h83i4IcnQIk7pg6cHmvmrWH02DnrLrvHplWdbB53
 ru1h89i8pN5j8o3ljB69ze/YPD5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
 No+1MjJV0rezSUnNySxLLdK3S9DLaPt0jK3gsGLF13tXWRoY30l3MXJwSAiYSKxcbNjFyMUh
 JLCUUWLbsZ2MXYycQHEZiZPTGlghbGGJP9e62CCK3jNK3J80kxkkISzgK7HwyD6wBhEBN4nz
 ByezgBQxC/QwSZyd9ZcZouMGk8SVKX3sIFVsAoYSXW9BRnFy8ArYSXzZ/hksziKgIvFi12mw
 daICyRI/17dD1QhKnJz5hAXE5hSwlti2dh6YzSxgJjFv80NmCFteonnrbChbXOLWk/lMExiF
 ZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNFtx35u2cG48tVH
 vUOMTByMhxglOJiVRHijdt5OEOJNSaysSi3Kjy8qzUktPsRoCvTPRGYp0eR8YJLIK4k3NDMw
 NTQxszQwtTQzVhLnNTmyJl5IID2xJDU7NbUgtQimj4mDU6qBqdN35fUJPMafWQLnJIfF1cqd
 31X2I+rw5FO/nsRF5K8782Vrr/O3O1G5i24fclW+qC8XtuVuw4tLD3ctl+lLkZfIms2jnn7m
 87qD6z+8uPNNbrJaoo9JyO57iicu6SjlePm4rlHkzF+ppBVe13FJfqcEv/kXhRu/tv/dY33+
 yryO7GWt/6QM7j8pWn7n+NoHx1X3aIsd3fLdwE+uf1L+brMQhsL9SfP28S5+FdMjnlK+lWtq
 VHWAQ7RS7ye57okKAjrFl74+nP6uY0Lwr1ClJqW1Ue/2tiznUlsRcI/XynmXZNPWLQG7io7a
 3ZohKe36tmTi02UWkc+YCzYsLy6u0M3yOnIi9sYGn1ezy5iPLlRiKc5INNRiLipOBADoZ6Hf
 WgMAAA==
X-CMS-MailID: 20210701082930eucas1p10f9a8f82118f7ffc382f64ef2ad24992
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

SGkgUm9iaW4sCgpPbiAzMC4wNi4yMDIxIDE2OjAxLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MjAyMS0wNi0zMCAxNDo0OCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPj4gT24gMzAuMDYuMjAy
MSAxNDo1OSwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+PiBPbiBXZWQsIEp1biAzMCwgMjAyMSBhdCAw
Mjo0ODoxNVBNICswMjAwLCBNYXJlayBTenlwcm93c2tpIHdyb3RlOgo+Pj4+IE9uIDA4LjA2LjIw
MjEgMTg6NDUsIEFtZXkgTmFya2hlZGUgd3JvdGU6Cj4+Pj4+IElmIGRldmljZSByZWdpc3RyYXRp
b24gZmFpbHMsIHJlbW92ZSBzeXNmcyBhdHRyaWJ1dGUKPj4+Pj4gYW5kIGlmIHNldHRpbmcgYnVz
IGNhbGxiYWNrcyBmYWlscywgdW5yZWdpc3RlciB0aGUgZGV2aWNlCj4+Pj4+IGFuZCBjbGVhbnVw
IHRoZSBzeXNmcyBhdHRyaWJ1dGUuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFtZXkgTmFy
a2hlZGUgPGFtZXluYXJraGVkZTAzQGdtYWlsLmNvbT4KPj4+PiBUaGlzIHBhdGNoIGxhbmRlZCBp
biBsaW51eC1uZXh0IHNvbWUgdGltZSBhZ28gYXMgY29tbWl0IDI0OWM5ZGM2YWEwZAo+Pj4+ICgi
aW9tbXUvYXJtOiBDbGVhbnVwIHJlc291cmNlcyBpbiBjYXNlIG9mIHByb2JlIGVycm9yIHBhdGgi
KS4gQWZ0ZXIKPj4+PiBiaXNlY3RpbmcgYW5kIHNvbWUgbWFudWFsIHNlYXJjaGluZyBJIGZpbmFs
bHkgZm91bmQgdGhhdCBpdCBpcwo+Pj4+IHJlc3BvbnNpYmxlIGZvciBicmVha2luZyBzMmlkbGUg
b24gRHJhZ29uQm9hcmQgNDEwYy4gSGVyZSBpcyB0aGUgbG9nCj4+Pj4gKGNhcHR1cmVkIHdpdGgg
bm9fY29uc29sZV9zdXNwZW5kKToKPj4+Pgo+Pj4+ICMgdGltZSBydGN3YWtlIC1zMTAgLW1tZW0K
Pj4+PiBydGN3YWtlOiB3YWtldXAgZnJvbSAibWVtIiB1c2luZyAvZGV2L3J0YzAgYXQgVGh1IEph
bsKgIDEgMDA6MDI6MTMgMTk3MAo+Pj4+IFBNOiBzdXNwZW5kIGVudHJ5IChzMmlkbGUpCj4+Pj4g
RmlsZXN5c3RlbXMgc3luYzogMC4wMDIgc2Vjb25kcwo+Pj4+IEZyZWV6aW5nIHVzZXIgc3BhY2Ug
cHJvY2Vzc2VzIC4uLiAoZWxhcHNlZCAwLjAwNiBzZWNvbmRzKSBkb25lLgo+Pj4+IE9PTSBraWxs
ZXIgZGlzYWJsZWQuCj4+Pj4gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyAuLi4g
KGVsYXBzZWQgMC4wMDQgc2Vjb25kcykgZG9uZS4KPj4+PiBVbmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzCj4+Pj4gMDAwMDAw
MDAwMDAwMDA3MAo+Pj4+IE1lbSBhYm9ydCBpbmZvOgo+Pj4+IMKgwqAgwqAgRVNSID0gMHg5NjAw
MDAwNgo+Pj4+IMKgwqAgwqAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBi
aXRzCj4+Pj4gwqDCoCDCoCBTRVQgPSAwLCBGblYgPSAwCj4+Pj4gwqDCoCDCoCBFQSA9IDAsIFMx
UFRXID0gMAo+Pj4+IMKgwqAgwqAgRlNDID0gMHgwNjogbGV2ZWwgMiB0cmFuc2xhdGlvbiBmYXVs
dAo+Pj4+IERhdGEgYWJvcnQgaW5mbzoKPj4+PiDCoMKgIMKgIElTViA9IDAsIElTUyA9IDB4MDAw
MDAwMDYKPj4+PiDCoMKgIMKgIENNID0gMCwgV25SID0gMAo+Pj4+IHVzZXIgcGd0YWJsZTogNGsg
cGFnZXMsIDQ4LWJpdCBWQXMsIHBnZHA9MDAwMDAwMDA4YWQwODAwMAo+Pj4+IFswMDAwMDAwMDAw
MDAwMDcwXSBwZ2Q9MDgwMDAwMDA4NWMzYzAwMywgcDRkPTA4MDAwMDAwODVjM2MwMDMsCj4+Pj4g
cHVkPTA4MDAwMDAwODhkY2YwMDMsIHBtZD0wMDAwMDAwMDAwMDAwMDAwCj4+Pj4gSW50ZXJuYWwg
ZXJyb3I6IE9vcHM6IDk2MDAwMDA2IFsjMV0gUFJFRU1QVCBTTVAKPj4+PiBNb2R1bGVzIGxpbmtl
ZCBpbjogYmx1ZXRvb3RoIGVjZGhfZ2VuZXJpYyBlY2MgcmZraWxsIGlwdjYgYXg4ODc5NmIKPj4+
PiB2ZW51c19lbmMgdmVudXNfZGVjIHZpZGVvYnVmMl9kbWFfY29udGlnIGFzaXggY3JjdDEwZGlm
X2NlIGFkdjc1MTEKPj4+PiBzbmRfc29jX21zbTg5MTZfYW5hbG9nIHFjb21fc3BtaV90ZW1wX2Fs
YXJtIHJ0Y19wbTh4eHggcWNvbV9wb24KPj4+PiBxY29tX2NhbXNzIHFjb21fc3BtaV92YWRjIHZp
ZGVvYnVmMl9kbWFfc2cgcWNvbV92YWRjX2NvbW1vbiBtc20KPj4+PiB2ZW51c19jb3JlIHY0bDJf
Zndub2RlIHY0bDJfYXN5bmMgc25kX3NvY19tc204OTE2X2RpZ2l0YWwKPj4+PiB2aWRlb2J1ZjJf
bWVtb3BzIHNuZF9zb2NfbHBhc3NfYXBxODAxNiBzbmRfc29jX2xwYXNzX2NwdSB2NGwyX21lbTJt
ZW0KPj4+PiBzbmRfc29jX2xwYXNzX3BsYXRmb3JtIHNuZF9zb2NfYXBxODAxNl9zYmMgdmlkZW9i
dWYyX3Y0bDIKPj4+PiBzbmRfc29jX3Fjb21fY29tbW9uIHFjb21fcm5nIHZpZGVvYnVmMl9jb21t
b24gaTJjX3Fjb21fY2NpIAo+Pj4+IHFub2NfbXNtODkxNgo+Pj4+IHZpZGVvZGV2IG1jIGljY19z
bWRfcnBtIG1kdF9sb2FkZXIgc29jaW5mbyBkaXNwbGF5X2Nvbm5lY3RvciBybXRmc19tZW0KPj4+
PiBDUFU6IDEgUElEOiAxNTIyIENvbW06IHJ0Y3dha2UgTm90IHRhaW50ZWQgNS4xMy4wLW5leHQt
MjAyMTA2MjkgIzM1OTIKPj4+PiBIYXJkd2FyZSBuYW1lOiBRdWFsY29tbSBUZWNobm9sb2dpZXMs
IEluYy4gQVBRIDgwMTYgU0JDIChEVCkKPj4+PiBwc3RhdGU6IDgwMDAwMDA1IChOemN2IGRhaWYg
LVBBTiAtVUFPIC1UQ08gQlRZUEU9LS0pCj4+Pj4gcGMgOiBtc21fcnVudGltZV9zdXNwZW5kKzB4
MWMvMHg2MCBbbXNtXQo+Pj4+IGxyIDogbXNtX3BtX3N1c3BlbmQrMHgxOC8weDM4IFttc21dCj4+
Pj4gLi4uCj4+Pj4gQ2FsbCB0cmFjZToKPj4+PiDCoMKgIMKgbXNtX3J1bnRpbWVfc3VzcGVuZCsw
eDFjLzB4NjAgW21zbV0KPj4+PiDCoMKgIMKgbXNtX3BtX3N1c3BlbmQrMHgxOC8weDM4IFttc21d
Cj4+Pj4gwqDCoCDCoGRwbV9ydW5fY2FsbGJhY2srMHg4NC8weDM3OAo+Pj4gSSB3b25kZXIgaWYg
d2UncmUgbWlzc2luZyBhIHBtX3J1bnRpbWVfZGlzYWJsZSgpIGNhbGwgb24gdGhlIGZhaWx1cmUg
Cj4+PiBwYXRoPwo+Pj4gaS5lLiBzb21ldGhpbmcgbGlrZSB0aGUgZGlmZiBiZWxvdy4uLgo+Pgo+
PiBJJ3ZlIGNoZWNrZWQgYW5kIGl0IGRvZXNuJ3QgZml4IGFueXRoaW5nLgo+Cj4gV2hhdCdzIGhh
cHBlbmVkIHByZXZpb3VzbHk/IEhhcyBhbiBJT01NVSBhY3R1YWxseSBmYWlsZWQgdG8gcHJvYmUs
IG9yIAo+IGlzIHRoaXMgYSBmaWRkbHkgImNvZGUgbW92ZW1lbnQgdW52ZWlscyBsYXRlbnQgYnVn
IGVsc2V3aGVyZSIga2luZCBvZiAKPiB0aGluZz8gVGhlcmUgZG9lc24ndCBsb29rIHRvIGJlIG11
Y2ggY2FwYWJsZSBvZiBnb2luZyB3cm9uZyBpbiAKPiBtc21fcnVudGltZV9zdXNwZW5kKCkgaXRz
ZWxmLCBzbyBpcyB0aGUgRFJNIGRyaXZlciBhbHNvIGluIGEgYnJva2VuIAo+IGhhbGYtcHJvYmVk
IHN0YXRlIHdoZXJlIGl0J3MgbGVmdCBpdHMgcG1fcnVudGltZV9vcHMgYmVoaW5kIHdpdGhvdXQg
Cj4gaXRzIGRydmRhdGEgYmVpbmcgdmFsaWQ/Cj4KSSBmaW5hbGx5IGhhZCBzb21lIHRpbWUgdG8g
YW5hbHl6ZSB0aGlzIGlzc3VlLiBJdCB0dXJuZWQgb3V0IHRoYXQgd2l0aCAKdGhpcyBwYXRjaCwg
aW9tbXUgZmFpbHMgdG8gcHJvYmUgZm9yIHNvYzppb21tdUAxZjA4MDAwIGRldmljZSwgd2hpbGUg
aXQgCndvcmtlZCBmaW5lIGJlZm9yZS4gVGhpcyBoYXBwZW5zIGJlY2F1c2UgdGhpcyBwYXRjaCBh
ZGRzIGEgY2hlY2sgZm9yIHRoZSAKcmV0dXJuIHZhbHVlIG9mIHRoZSBidXNfc2V0X2lvbW11KCkg
aW4gCmRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L3Fjb21faW9tbXUuYy4gV2hlbiBJIHJlbW92
ZWQgdGhhdCBjaGVjaywgaXQgCnByb2JlcyBzdWNjZXNzZnVsbHkgYWdhaW4uIEl0IGxvb2tzIHRo
YXQgdGhlcmUgYXJlIGFscmVhZHkgaW9tbXUgb3BzIApyZWdpc3RlcmVkIGZvciBwbGF0Zm9ybSBi
dXMsIGJlZm9yZSBxY29tX2lvbW11IHByb2Jlcy4gT24gdGhlIG90aGVyIApoYW5kLCBpZiBJIHJl
bWVtYmVyIGNvcnJlY3RseSB0aGV5IGFyZSBub3QgdXNlZCBkdXJpbmcgdGhlIGRldmljZSAKcmVn
aXN0cmF0aW9uLCBidXQgdGhleSBhcmUgbmVlZGVkIGZvciBzb21lIGxlZ2FjeSBzdHVmZi4gSSBj
YW4gc2VuZCBhIApwYXRjaCByZXN0b3Jpbmcgb2xkIGNvZGUgZmxvdyBpZiB5b3UgdGhpbmsgdGhh
dCB0aGlzIGlzIGEgcmlnaHQgc29sdXRpb24uCgpCZXN0IHJlZ2FyZHMKLS0gCk1hcmVrIFN6eXBy
b3dza2ksIFBoRApTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9sYW5kCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
