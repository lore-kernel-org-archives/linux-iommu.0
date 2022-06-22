Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A8CC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 09:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3306660B6F;
	Wed, 22 Jun 2022 09:57:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3306660B6F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=REqZkvf8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RVlUTCn5hXLx; Wed, 22 Jun 2022 09:57:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 73B49607F7;
	Wed, 22 Jun 2022 09:57:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73B49607F7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D2E3C0032;
	Wed, 22 Jun 2022 09:57:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 111D1C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED9538145F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:57:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED9538145F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.a=rsa-sha256 header.s=mail20170921 header.b=REqZkvf8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XaecCcGKLxh5 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 09:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A1D481418
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A1D481418
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:57:31 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220622095729euoutp02c8a9b9596cfe3ce7c3941ced2ddf6d61~66N0lCVT22647426474euoutp02b
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:57:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220622095729euoutp02c8a9b9596cfe3ce7c3941ced2ddf6d61~66N0lCVT22647426474euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1655891849;
 bh=FePwQ4O/YSznXBsN/aF7A8HVK6oQ8MRUR2C9E7B9jF0=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=REqZkvf8HPtfSU5+DJhc92y0fTQuFxqAZ0qWLtjvF21/hcygzdo512Vd8O/U4ks9r
 KNGXogiDoYPegniZzZcyUzcKM4eXypp0FeKcP8EDfa0nZSD2wHpbi4kDJdFj3ziJT4
 74fhe9P2Idk1p5EN+uiQGgX7qSA4y6sOXiEYVpDA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220622095728eucas1p27c8e332c655bf827abd03dedb6dbb6f5~66NzxoGr91480814808eucas1p2p;
 Wed, 22 Jun 2022 09:57:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id C0.F5.09664.887E2B26; Wed, 22
 Jun 2022 10:57:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220622095728eucas1p11a4d7c17808256e599f1888ce9ab4cb3~66NzMRAay0805008050eucas1p1G;
 Wed, 22 Jun 2022 09:57:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220622095727eusmtrp2395019a94bb083f5f58a9ad7b31fa1d7~66NzKazqG1462214622eusmtrp2r;
 Wed, 22 Jun 2022 09:57:27 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-fb-62b2e788686b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id AE.C3.09038.787E2B26; Wed, 22
 Jun 2022 10:57:27 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220622095724eusmtip14e377a1805eb0bfea932599c4b108040~66NwTpPHE1778117781eusmtip1j;
 Wed, 22 Jun 2022 09:57:24 +0000 (GMT)
Message-ID: <ec775e98-1164-1016-13c7-9247e751782a@samsung.com>
Date: Wed, 22 Jun 2022 11:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC 2/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Sam Protsenko
 <semen.protsenko@linaro.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <47a0abcc-b3d6-a9a3-8d3a-5689bbf8767a@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRzved/t3RgOXwYdzwHZtdI7sqCdejwF7dS6WlQXHZnFdcXANyDH
 oM3Z8Ew3fgnLIWoQDQSsTG8uXBtyyaS1MUGhY8DG4Lqh3jnCm7cStm4FArm9Wvz3eT4/nu/n
 +9zDxnnHiWR2qXQfJZOKJXyCw+gd/Gf02fo5U+FzK2o+GravEmjE+gcD/fn9UYBCv0ywUFN9
 LYZ8jm9Y6J7fw0DLDWNM1GXNQuZ2OerTD7DQklfLRA1tRhb6MfA3hky3PEzk6msnUKvzZwyt
 aG0A1fY7WMh218dEZ9S9BJprvC/c7klCwzNBFjpfpweoxrsN6RdWwfYUkc/WgYkMHQYg0qm0
 hKjLpBCZ9A2EyOu5TIjM3x0WnZw+C0SNPXogCpo25HLyOdl7KEnpfkqWISzglCwPWvGKY3zl
 704PoQKzKRoQw4bkVnjV3UVoAIfNI88BeHWuGacPIQCPm0+CiItHBgE0X698mKgOLTFo/iyA
 t2ry6MA8gNNnWqIClxRC540hTAPYbAa5EaotT9J0PLz2tS9qeZQshJ29tcwITiBfhTPnnVgE
 42QS/M3XGcWJ5C6o628Ckftx0sqC+ptqPCIQpABqAhoigmPILHhhfOBB+HFYfbEtugEkGznQ
 O6XC6NYvw/C5QYLGCdA/1MOicSpcvdQZLQrJcrjcuoWmldBzx4DTOAt6RxeJiAUn0+CFvgya
 3gEbx0M4nYyD04F4ukEcPNH71QOaC+vreLR7E9QNdf830zY2gTcBvm7No+jWLK9bs4vu/7ld
 gKEHSZRCXlZMyQVS6rN0ubhMrpAWpxeVl5nA/V87sjK08BM45Z9PtwOMDewAsnF+Ijc71ljI
 4+4RVx6gZOUfyRQSSm4HKWwGP4lbVGoU88hi8T5qL0VVULKHKsaOSVZhCRbhoaDzEcNTW9+a
 LUgZOWRZvxRYf+fUbUQ8sTm44XRooW6+KRnLY7V/2LFO4LdMtVQ43uFXrcsN74rNvZu9//Vn
 3ANk3WM5VmF//V+tmdrt3ePiXwvM+YbX+j52+Y+8/V4Fa/jepivyLw++IvzihxOX9bufr+p5
 0b1RkGHc8fm39uSJzlntsPcSJ+90Vkhy7GB43rVT9lLL1HVjbJs+fy6+6v3m7rTdkxcdeZ8Q
 ypK4BGXzijucPeY4cE36gS8xblRWXfnm4huTRfGF3S9Mqm3hT1VeV6pJZ9lcZHEV4DbvFaZR
 cnMbf/HGziOZe2sOu81pR92ZAUXOuzEzkpzU0S3KWT5DXiIWPI3L5OJ/AZbtBbEkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xu7rtzzclGSxoMLc4deg/m8Xp/e9Y
 LN4v62G0+HLgErvFhI5WJosnRxaxW/x5dY3F4m/nBVaLBfutLTbPKbbYteowu8XvO72sFp2z
 N7BbbHz7g8li0+NrrBaXd81hs5hxfh+Txb/eg4wWrXuPsFsc/PCE1WJp4zY2i+d9QIkXW8Qt
 Tt39zG6xum0Vo0XLHVOLVZ/+MzpIezw5OI/JY828NYwesxp62TwWbCr12LSqk83jzrU9bB6b
 l9R7TL6xnNGjb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxM
 lfTtbFJSczLLUov07RL0Mv4e289c0K9U8ez8NbYGxqfSXYycHBICJhLNX36zdDFycQgJLGWU
 uP34GBtEQkbi5LQGVghbWOLPtS42iKL3jBI/mqexgCR4Bewkzt8/ztTFyMHBIqAq0bhbGSIs
 KHFy5hOwElGBJIl5e1czgtjCAu4Sd1efZwKxmQXEJW49mQ9miwiESrx/eYURZD6zwGF2iSkd
 M6GWfWKWmD1jNjtIFZuAoUTX2y6w6zgFrCXWXzwMNclMomtrFyOELS/RvHU28wRGoVlIDpmF
 ZOEsJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZhkth37uWUH48pXH/UOMTJx
 MB5ilOBgVhLhteHekCTEm5JYWZValB9fVJqTWnyI0RQYGBOZpUST84FpLq8k3tDMwNTQxMzS
 wNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgcmLr6M6tbb/an87z5ctwSs5S9fKL/RT
 PH537+L/j95b/U+M+5L2dMrpv7vU153U3pQpcvqjJFtZz/WgifWOcUGP3wVcl5nhPrWQr+KZ
 N0eeVVx2r0msaeiayCeTFK8rLao9kPpprvlxi9u/duy7qXN5/W6TU4UT9k62dDUX7jhtlNZ7
 +/PRM/k8IYLbd/rm+a7MXs4zi+np/u2cy3w36DLUnvsu5i0423r+zZr7eukzHO6pHfXi4F/T
 pslo33B0h4e7RHHKviSNJ73BGw59ePjM7vbn4NT42HsN14xSHn9+dv51fbVpHPPBo0cv5qxb
 VSzxY+2O3l3dT4Ku9/A+VI3WurhpjfA2twTRUKUNucVKLMUZiYZazEXFiQCG6INquwMAAA==
X-CMS-MailID: 20220622095728eucas1p11a4d7c17808256e599f1888ce9ab4cb3
X-Msg-Generator: CA
X-RootMTR: 20220121110911eucas1p28d11e1b04773e8174b9d65f011dc1977
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220121110911eucas1p28d11e1b04773e8174b9d65f011dc1977
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
 <20220120201958.2649-3-semen.protsenko@linaro.org>
 <a111932a-6685-2a9d-abce-87af26b121a4@canonical.com>
 <CGME20220121110911eucas1p28d11e1b04773e8174b9d65f011dc1977@eucas1p2.samsung.com>
 <CAPLW+4kKR+7hM-eZc8-v6Dzeaj+TPBRmCLDSVNEnfx2WmN2TJA@mail.gmail.com>
 <54b76143-dff3-8a19-7ab9-57fb80d59743@samsung.com>
 <CAPLW+4nxSDeGL-1hFzdDr3vYx+9ct8_YrXfVNgzwm1Gq2=Vh7A@mail.gmail.com>
 <47a0abcc-b3d6-a9a3-8d3a-5689bbf8767a@arm.com>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Will Deacon <will@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-samsung-soc@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Mark Salyzyn <salyzyn@google.com>, Jinkyu Yang <jinkyu1.yang@samsung.com>,
 Thierry Strudel <tstrudel@google.com>, Will McVicker <willmcvicker@google.com>,
 Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Jonglin Lee <jonglin@google.com>, "J . Avila" <elavila@google.com>,
 Alex <acnwigwe@google.com>, linux-kernel@vger.kernel.org,
 Hyesoo Yu <hyesoo.yu@samsung.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
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

Ck9uIDIyLjA2LjIwMjIgMTE6MTQsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIyLTA2LTIx
IDIwOjU3LCBTYW0gUHJvdHNlbmtvIHdyb3RlOgo+PiBIaSBNYXJlaywKPj4KPj4gT24gRnJpLCAy
MSBKYW4gMjAyMiBhdCAxNDozMSwgTWFyZWsgU3p5cHJvd3NraSAKPj4gPG0uc3p5cHJvd3NraUBz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4+Cj4+IFtzbmlwXQo+Pgo+Pj4KPj4+IFdlbGwsIGZvciBzdGFy
dGluZyBwb2ludCB0aGUgZXhpc3RpbmcgZXh5bm9zLWlvbW11IGRyaXZlciBpcyByZWFsbHkKPj4+
IGVub3VnaC4gSSd2ZSBwbGF5ZWQgYSBiaXQgd2l0aCBuZXdlciBFeHlvcyBTb0NzIHNvbWUgdGlt
ZSBhZ28uIElmIEkKPj4+IHJlbWVtYmVyIHJpZ2h0LCBpZiB5b3UgbGltaXQgdGhlIGlvbW11IGZ1
bmN0aW9uYWxpdHkgdG8gdGhlIGVzc2VudGlhbAo+Pj4gdGhpbmdzIGxpa2UgbWFwcGluZyBwYWdl
cyB0byBJTy12aXJ0dWFsIHNwYWNlLCB0aGUgaGFyZHdhcmUgZGlmZmVyZW5jZXMKPj4+IGJldHdl
ZW4gU1lTTU1VIHY1IChhbHJlYWR5IHN1cHBvcnRlZCBieSB0aGUgZXh5bm9zLWlvbW11IGRyaXZl
cikgYW5kIHY3Cj4+PiBhcmUganVzdCBhIG1hdHRlciBvZiBjaGFuZ2luZyBhIG9uZSByZWdpc3Rl
ciBkdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uCj4+PiBhbmQgZGlmZmVyZW50IGJpdHMgdGhlIHBh
Z2UgZmF1bHQgcmVhc29uIGRlY29kaW5nLiBZb3UgbXVzdCBvZiBjb3Vyc2UKPj4+IHJlbHkgb24g
dGhlIERNQS1tYXBwaW5nIGZyYW1ld29yayBhbmQgaXRzIGltcGxlbWVudGF0aW9uIGJhc2VkIG9u
Cj4+PiBtYWlubGluZSBETUEtSU9NTVUgaGVscGVycy4gQWxsIHRoZSBjb2RlIGZvciBjdXN0b20g
aW9tbXUgZ3JvdXAocykKPj4+IGhhbmRsaW5nIG9yIGV4dGVuZGVkIGZhdWx0IG1hbmFnZW1lbnQg
YXJlIG5vdCBuZWVkZWQgZm9yIHRoZSBpbml0aWFsCj4+PiB2ZXJzaW9uLgo+Pj4KPj4KPj4gVGhh
bmtzIGZvciB0aGUgYWR2aWNlISBKdXN0IGltcGxlbWVudGVkIHNvbWUgdGVzdGluZyBkcml2ZXIs
IHdoaWNoCj4+IHVzZXMgIkVtdWxhdGVkIFRyYW5zbGF0aW9uIiByZWdpc3RlcnMgYXZhaWxhYmxl
IG9uIFN5c01NVSB2Ny4gVGhhdCdzCj4+IG9uZSB3YXkgdG8gdmVyaWZ5IHRoZSBJT01NVSBkcml2
ZXIgd2l0aCBubyBhY3R1YWwgdXNlcnMgb2YgaXQuIEl0Cj4+IHdvcmtzIGZpbmUgd2l0aCB2ZW5k
b3IgU3lzTU1VIGRyaXZlciBJIHBvcnRlZCB0byBtYWlubGluZSBlYXJsaWVyLCBhbmQKPj4gbm93
IEknbSB0cnlpbmcgdG8gdXNlIGl0IHdpdGggZXh5bm9zLXN5c21tdSBkcml2ZXIgKGV4aXN0aW5n
Cj4+IHVwc3RyZWFtKS4gSWYgeW91J3JlIGN1cmlvdXMgLS0gSSBjYW4gc2hhcmUgdGhlIHRlc3Rp
bmcgZHJpdmVyCj4+IHNvbWV3aGVyZSBvbiBHaXRIdWIuCj4+Cj4+IEkgYmVsaWV2ZSB0aGUgcmVn
aXN0ZXIgeW91IG1lbnRpb25lZCBpcyBQVF9CQVNFIG9uZSwgc28gSSB1c2VkCj4+IFJFR19WN19G
TFBUX0JBU0VfVk0gPSAweDgwMEMgaW5zdGVhZCBvZiBSRUdfVjVfUFRfQkFTRV9QRk4uIEJ1dCBJ
Cj4+IGRpZG4ndCBtYW5hZ2UgdG8gZ2V0IHRoYXQgZmFyLCB1bmZvcnR1bmF0ZWx5LCBhcwo+PiBl
eHlub3NfaW9tbXVfZG9tYWluX2FsbG9jKCkgZnVuY3Rpb24gZmFpbHMgaW4gbXkgY2FzZSwgd2l0
aCBCVUdfT04oKQo+PiBhdCB0aGlzIGxpbmU6Cj4+Cj4+IMKgwqDCoMKgIC8qIEZvciBtYXBwaW5n
IHBhZ2UgdGFibGUgZW50cmllcyB3ZSByZWx5IG9uIGRtYSA9PSBwaHlzICovCj4+IMKgwqDCoMKg
IEJVR19PTihoYW5kbGUgIT0gdmlydF90b19waHlzKGRvbWFpbi0+cGd0YWJsZSkpOwo+Pgo+PiBP
bmUgcG9zc2libGUgZXhwbGFuYXRpb24gZm9yIHRoaXMgQlVHIGlzIHRoYXQgImRtYS1yYW5nZXMi
IHByb3BlcnR5IGlzCj4+IG5vdCBwcm92aWRlZCBpbiBEVFMgKHdoaWNoIHNlZW1zIHRvIGJlIHRo
ZSBjYXNlIHJpZ2h0IG5vdyBmb3IgYWxsCj4+IHVzZXJzIG9mICJzYW1zdW5nLGV4eW5vcy1zeXNt
bXUiIGRyaXZlcikuIEJlY2F1c2Ugb2YgdGhhdCB0aGUgU1dJT1RMQgo+PiBpcyB1c2VkIGZvciBk
bWFfbWFwX3NpbmdsZSgpIGNhbGwgKGluIGV4eW5vc19pb21tdV9kb21haW5fYWxsb2MoKQo+PiBm
dW5jdGlvbiksIHdoaWNoIGluIHR1cm4gbGVhZHMgdG8gdGhhdCBCVUcuIEF0IGxlYXN0IHRoYXQn
cyB3aGF0Cj4+IGhhcHBlbnMgaW4gbXkgY2FzZS4gVGhlIGNhbGwgY2hhaW4gbG9va3MgbGlrZSB0
aGlzOgo+Pgo+PiDCoMKgwqDCoCBleHlub3NfaW9tbXVfZG9tYWluX2FsbG9jKCkKPj4gwqDCoMKg
wqDCoMKgwqDCoCB2Cj4+IMKgwqDCoMKgIGRtYV9tYXBfc2luZ2xlKCkKPj4gwqDCoMKgwqDCoMKg
wqDCoCB2Cj4+IMKgwqDCoMKgIGRtYV9tYXBfc2luZ2xlX2F0dHJzKCkKPj4gwqDCoMKgwqDCoMKg
wqDCoCB2Cj4+IMKgwqDCoMKgIGRtYV9tYXBfcGFnZV9hdHRycygpCj4+IMKgwqDCoMKgwqDCoMKg
wqAgdgo+PiDCoMKgwqDCoCBkbWFfZGlyZWN0X21hcF9wYWdlKCnCoCAvLyBkbWFfY2FwYWJsZSgp
ID09IGZhbHNlCj4+IMKgwqDCoMKgwqDCoMKgwqAgdgo+PiDCoMKgwqDCoCBzd2lvdGxiX21hcCgp
Cj4+IMKgwqDCoMKgwqDCoMKgwqAgdgo+PiDCoMKgwqDCoCBzd2lvdGxiX3RibF9tYXBfc2luZ2xl
KCkKPj4KPj4gQW5kIHRoZSBsYXN0IGNhbGwgb2YgY291cnNlIGFsd2F5cyByZXR1cm5zIHRoZSBh
ZGRyZXNzIGRpZmZlcmVudCB0aGFuCj4+IHRoZSBhZGRyZXNzIGZvciBhbGxvY2F0ZWQgcGd0YWJs
ZS4gRS5nLiBpbiBteSBjYXNlIEkgc2VlIHRoaXM6Cj4+Cj4+IMKgwqDCoMKgIGhhbmRsZSA9IDB4
MDAwMDAwMDBmYmZmZjAwMAo+PiDCoMKgwqDCoCB2aXJ0X3RvX3BoeXMoZG9tYWluLT5wZ3RhYmxl
KSA9IDB4MDAwMDAwMDg4MGQwYzAwMAo+Pgo+PiBEbyB5b3Uga25vdyB3aGF0IG1pZ2h0IGJlIHRo
ZSByZWFzb24gZm9yIHRoYXQ/IEkganVzdCB3b25kZXIgaG93IHRoZQo+PiBTeXNNTVUgZHJpdmVy
IHdvcmsgZm9yIGFsbCBleGlzdGluZyBFeHlub3MgcGxhdGZvcm1zIHJpZ2h0IG5vdy4gSSBmZWVs
Cj4+IEkgbWlnaHQgYmUgbWlzc2luZyBzb21ldGhpbmcsIGxpa2Ugc29tZSBETUEgb3B0aW9uIHNo
b3VsZCBiZSBlbmFibGVkCj4+IHNvIHRoYXQgU1dJT1RMQiBpcyBub3QgdXNlZCwgb3Igc29tZXRo
aW5nIGxpa2UgdGhhdC4gUGxlYXNlIGxldCBtZQo+PiBrbm93IGlmIHlvdSBoYXZlIGFueSBpZGVh
IG9uIHBvc3NpYmxlIGNhdXNlLiBUaGUgdmVuZG9yJ3MgU3lzTU1VCj4+IGRyaXZlciBpcyBraW5k
YSBkaWZmZXJlbnQgaW4gdGhhdCByZWdhcmQsIGFzIGl0IGRvZXNuJ3QgdXNlCj4+IGRtYV9tYXBf
c2luZ2xlKCksIHNvIEkgZG9uJ3Qgc2VlIHN1Y2ggaXNzdWUgdGhlcmUuCj4KPiBJZiB0aGlzIFN5
c01NVSB2ZXJzaW9uIGlzIGNhcGFibGUgb2YgYWRkcmVzc2luZyBtb3JlIHRoYW4gMzIgYml0cywg
Cj4gdGhlbiBleHlub3NfaW9tbXVfcHJvYmVfZGV2aWNlKCkgc2hvdWxkIHNldCBpdHMgRE1BIG1h
c2tzIGFwcHJvcHJpYXRlbHkuCgpXZWxsLCBTYW0ncyBxdWVzdGlvbiB3YXMgYWJvdXQgdGhlIEV4
eW5vcyBTWVNNTVUgb3duIHBsYXRmb3JtIGRldmljZSwgCm5vdCB0aGUgZGV2aWNlIGZvciB3aGlj
aCBFeHlub3MgU1lTTU1VIG1hbmFnZXMgdGhlIElPIHZpcnR1YWwgYWRkcmVzcyAKc3BhY2UuCgpT
aW1wbHkgYWRkIHNvbWV0aGluZyBsaWtlCgpkbWFfc2V0X21hc2soZGV2LCBETUFfQklUX01BU0so
MzYpKTsKCnRvIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGV4eW5vc19zeXNtbXVfcHJvYmUoKS4gVGhp
cyB3aWxsIGRpc2FibGUgU1dJT1RMQiAKYW5kIHN3aXRjaCB0byBETUEtZGlyZWN0IGZvciB0aGUg
RXh5bm9zIFNZU01NVSBwbGF0Zm9ybSBkZXZpY2UuCgoKPiAoYXMgYSBzaWRlIG5vdGUgc2luY2Ug
SSBsb29rZWQsIHRoZSB1c2Ugb2YgUEFHRV9TSVpFL1BBR0VfU0hJRlQgaW4gdGhlIAo+IGRyaXZl
ciBsb29rcyB3cm9uZywgc2luY2UgSSBjYW4ndCBpbWFnaW5lIHRoYXQgdGhlIGhhcmR3YXJlIGtu
b3dzIAo+IHdoZXRoZXIgTGludXggaXMgdXNpbmcgNEtCLCAxNktCIG9yIDY0S0IgYW5kIGFkanVz
dHMgaXRzZWxmIAo+IGFjY29yZGluZ2x5Li4uKQoKUmlnaHQsIHRoaXMgaGFzIHRvIGJlIGNsZWFu
ZWQgdXAuIFRoaXMgZHJpdmVyIHdhcyBuZXZlciB1c2VkIG9uIHN5c3RlbXMgCndpdGgga2VybmVs
IGNvbmZpZ3VyYXRpb24gZm9yIG5vbi00S0IgcGFnZXMuCgpCZXN0IHJlZ2FyZHMKLS0gCk1hcmVr
IFN6eXByb3dza2ksIFBoRApTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9sYW5kCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
