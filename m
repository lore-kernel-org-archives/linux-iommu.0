Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5FFC54E4A
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:05:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C681B206A3
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m5uDa4RY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C681B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99B4121507;
	Tue, 12 May 2020 09:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dVt3YGQKQfMX; Tue, 12 May 2020 09:05:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C47DC2039C;
	Tue, 12 May 2020 09:05:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD65EC0178;
	Tue, 12 May 2020 09:05:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA2BC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3477E881F4
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FPULvsxgY0DA for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:05:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B8396881E1
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:05:07 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090505euoutp0151f61a0c2b7526c13035fd977316ba11~OPI_W5oc52636326363euoutp01V
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:05:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200512090505euoutp0151f61a0c2b7526c13035fd977316ba11~OPI_W5oc52636326363euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274305;
 bh=AhzmXRfuAXH1r/E+rpzhyc8oI1f4R3agyOC87Kh6/r8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=m5uDa4RYh7X+8F1CywD2nCIs18DDTSNbHC7TCjDRVYiFkZqu6IQe8zu9IQtf8wSeH
 VqlJa365kO+V+Y3ezrRzpOqNCxz1yjzJOvpak/61gANdlHy42GfggGbG2/SSq7iLi0
 u9W2xg3BEm5vtjEiNe01+W9nmaScMnzr2aXTLY10=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200512090505eucas1p20a660e61f27d8ae9889b1a1eeba5f897~OPI_BjmSS1504115041eucas1p23;
 Tue, 12 May 2020 09:05:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 20.2C.60698.1C66ABE5; Tue, 12
 May 2020 10:05:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090505eucas1p20fdb2ff84bf04f85ba28ae14e6bd5f8c~OPI9mQpuy1504515045eucas1p2R;
 Tue, 12 May 2020 09:05:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200512090505eusmtrp203ec1cd226791e437020f232645dd228~OPI9lhoHW0721407214eusmtrp22;
 Tue, 12 May 2020 09:05:05 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-5b-5eba66c1f51b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.F5.08375.0C66ABE5; Tue, 12
 May 2020 10:05:05 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090504eusmtip17a2387bb0530d831d1e6bcd0dc503194~OPI84EYTJ1442114421eusmtip1p;
 Tue, 12 May 2020 09:05:04 +0000 (GMT)
Subject: Re: [PATCH v3 02/25] drm: core: fix common struct sg_table related
 issues
To: Christoph Hellwig <hch@lst.de>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <df31517c-f3e2-8c57-b353-ff90745038f1@samsung.com>
Date: Tue, 12 May 2020 11:05:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508071609.GA31690@lst.de>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzu3JfX0ZXr1HawULg9oPKZEpeMKJK6EIhB9UeUtfTmJLfmrpoW
 lWQvl0Uapq5SK7Oymfiaj2rlqK1laZmYZqhLIzSlhzkparXtavnf9/t+33e+8x0OiUrHcH8y
 SZXKa1TyZIaQYAbzj47g1r0tcWG91QHs2XYrwtYUVePsH0MeynZNfibY23eeIGzZwyj2e5cN
 YWuHunH2dctlgr36tQFjT+ZU4Gzrl2GcrR/Lw9dSnL5ED7gH9jKMq63MIbhG+yDOlVg3cwNn
 LAhXV36U63MModyFnpuAu9ebRXDn6isBV9d2iJuoDYiltktWJ/DJSem8JnTNbomi4hShthIZ
 V2yDeBaowrXAk4R0JJw4fotwYSl9C8Bmh68WSJz4O4C/35hxcZgAsOzpgFNFuh1f8pUifxPA
 18YTqDh8BtB0owpxHeVDb4ENnRY39qUZ+GH0BXCJULobhYYRC+ZaEHQ41I5r3dkUvQbWWLrd
 PEYvhsc6y1EX9qN3wrbrdUDUeENr8bBb40kHwanGq24vSgfC7IZLqIhl8O1wKeIKg3QBCTvM
 FYRYNBpO5Y8AEfvAUUu9h4gXwD/NM4ZsAG3tVR7ikOssd6xo2hEF37X/dD8ASi+F1S2hIr0O
 OnLHpt/FC/aMe4uX8IL5hkJUpCl4+qRUVC+BOsvdf7GtLzvR84DRzaqmm1VHN6uO7n9uGcAq
 gYxPE5SJvBCh4g+ECHKlkKZKDInfr6wFzj/Y5rBMNgHjrz0mQJOAmUudXtEcJ8Xl6UKm0gQg
 iTK+1PEkJ0UlyDMP8pr9uzRpybxgAvNJjJFREddGdkrpRHkqv4/n1bxmZouQnv5ZoJwQ1mr3
 3R592Peyq6mhf5WtYEfMV/XzOHV4WP9K/fKBSZXD9Cn2xkUfRbAxOjInzvA+hevZVBpol2wt
 9tfPHS/8oVzvuSRyYUZ/RorC98i8edne92WMOTRig9IPibF9i/84fIVfdNg+Z4zaqK8gJh+F
 PJ+yG9lnOxDjNtnjoFcMJijk4ctQjSD/C/zubuh/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7oH03bFGXw9xmjRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLhx60sFm2dy1gtDn54wmqx
 5c1EVgdejzXz1jB67P22gMVj06pONo/t3x6wesw7Gehxv/s4k8fmJfUet/89ZvaYfGM5o8fu
 mw1sHn1bVjF6bD5d7fF5k1wAb5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
 kr6dTUpqTmZZapG+XYJexrJ2toKTbBVzHz5gbWBcy9rFyMEhIWAi8WFSbhcjF4eQwFJGiePH
 JzB2MXICxWUkTk5rYIWwhSX+XOtigyh6yyix6cd+sCJhgRCJrZeOM4HYIgJKEk9fnWUEKWIW
 uMEs8W1zLztEx0lmiecXToJ1sAkYSnS9BRnFycErYCex8fg1FhCbRUBVounSEmYQW1QgVmL1
 tVZGiBpBiZMzn4DVcAroSHzfvhCsl1nATGLe5ofMELa8RPPW2VC2uMStJ/OZJjAKzULSPgtJ
 yywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGPnbjv3cvIPx0sbgQ4wCHIxK
 PLwdRjvjhFgTy4orcw8xSnAwK4nwtmQChXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmJTy
 SuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwVuW5PkxnUZo/me+z
 4a8XNRIqwYUdcVfbKyPUinX2ThUP+jFXVuUyi1pNyOL3TuHd5w8vnRvXVHRC86Udp8120S+2
 HrOO7e+JmcngnGH5b6df1qJg97ii568F5vv2yF2XNTi77FddTsAblacKn1knb5sa/HZm4Z/5
 e5nyll7anlNQKmobf6JHiaU4I9FQi7moOBEAk0k3RhIDAAA=
X-CMS-MailID: 20200512090505eucas1p20fdb2ff84bf04f85ba28ae14e6bd5f8c
X-Msg-Generator: CA
X-RootMTR: 20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454@eucas1p1.samsung.com>
 <20200505084614.30424-2-m.szyprowski@samsung.com>
 <20200505101508.GA14860@lst.de>
 <5dd1cb55-accb-0dc6-4ca5-90c57cd19527@samsung.com>
 <20200505110950.GA19067@lst.de>
 <b887c355-14db-ad37-0e93-733ff2249967@samsung.com>
 <20200508071609.GA31690@lst.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

SGkgQ2hyaXN0b3BoLAoKT24gMDguMDUuMjAyMCAwOToxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3Jv
dGU6Cj4gT24gRnJpLCBNYXkgMDgsIDIwMjAgYXQgMDk6MTI6MTNBTSArMDIwMCwgTWFyZWsgU3p5
cHJvd3NraSB3cm90ZToKPj4gVGhlbiB3ZSB3b3VsZCBqdXN0IG5lZWQgb25lIG1vcmUgaGVscGVy
IHRvIGNvbnN0cnVjdCBzY2F0dGVybGlzdCwgYXMgdGhlCj4+IGFib3ZlIHR3byBhcmUgcmVhZC1v
bmx5IGRvbid0IGFsbG93IHRvIG1vZGlmeSBzY2F0dGVybGlzdDoKPj4KPj4gI2RlZmluZSBmb3Jf
ZWFjaF9zZ3RhYmxlX3NnKHNndCwgc2csIGkpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKPj4gICDCoMKgwqDCoMKgwqAgZm9yX2VhY2hfc2coc2d0LT5zZ2wsIHNnLCBzZ3QtPm9yaWdf
bmVudHMsIGkpCj4+Cj4+IFdpdGggdGhlIGFib3ZlIDMgaGVscGVycyB3ZSBjYW4gcHJvYmFibHkg
Z2V0IHJpZCBvZiBhbGwgaW5zdGFuY2VzIG9mCj4+IHNnX3RhYmxlLT57bmVudHMsb3JpZ19uZW50
c30gZnJvbSB0aGUgRFJNIGNvZGUuIEkgd2lsbCBwcmVwYXJlIHBhdGNoZXMgc29vbi4KPiBTb3Vu
ZHMgZ3JlYXQsIHRoYW5rcyEKCkl0IHR1cm5lZCBvdXQgdGhhdCB0aGUgNHRoIGhlbHBlciAoZm9y
X2VhY2hfc2d0YWJsZV9kbWFfc2cpIHdhcyBuZWVkZWQgCmFzIHNvbWUgZHJpdmVycyBtYWtlcyB1
c2Ugb2YgdGhlIGxhcmdlciB0aGFuIHRoZSBQQUdFX1NJWkUgdW5pdCBmb3IgRE1BIAptYXBwZWQg
cGFnZXMuCgpCZXN0IHJlZ2FyZHMKLS0gCk1hcmVrIFN6eXByb3dza2ksIFBoRApTYW1zdW5nIFIm
RCBJbnN0aXR1dGUgUG9sYW5kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
