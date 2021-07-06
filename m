Return-Path: <SRS0=cNfX=L6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF697C07E96
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 06:40:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E1B6196A
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 06:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E1B6196A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D9B540139;
	Tue,  6 Jul 2021 06:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VATQvAs1W3x; Tue,  6 Jul 2021 06:40:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7FC140104;
	Tue,  6 Jul 2021 06:40:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBB71C001A;
	Tue,  6 Jul 2021 06:40:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6757CC000E
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 06:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53A5B6068C
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 06:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QheE7vL4n0Fb for <iommu@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 06:40:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BAC06006A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 06:40:38 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210706064035euoutp02d48dd3a1b64106990826605330c52395~PIGs_SqO43202532025euoutp02f
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 06:40:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210706064035euoutp02d48dd3a1b64106990826605330c52395~PIGs_SqO43202532025euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1625553635;
 bh=/FABSd7h+/aNCApA9rE7hWI30dZ59mhJinjTD6hB7CA=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=mw/uNbJ7p1edrGnszgtpngkES8iSYpe1MsV4USxGvyC5iyXC3oyl8gwSVs5jj7COh
 beM8bTl9NU4Dg2FOKjeXFpA6f+gHXk10MHAMzrApgofRf2wdeZRc+BBFZWYSOCHJ/O
 bUtVT3kd//PBjmZhP/sFWAwRdVd2kdS1L1OBS1qU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210706064035eucas1p24281895a290f144da55d106c266d640d~PIGssoy6J0361803618eucas1p2m;
 Tue,  6 Jul 2021 06:40:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id F3.DA.56448.3EAF3E06; Tue,  6
 Jul 2021 07:40:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210706064034eucas1p1e4bd9281a5badb012c1a65f0dbf8169a~PIGsOCGgD1739017390eucas1p1d;
 Tue,  6 Jul 2021 06:40:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210706064034eusmtrp1afc12f722a94dcc8e36e702650db4e17~PIGsNL00w1015410154eusmtrp1t;
 Tue,  6 Jul 2021 06:40:34 +0000 (GMT)
X-AuditID: cbfec7f5-d3bff7000002dc80-ee-60e3fae37e8d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.B6.20981.2EAF3E06; Tue,  6
 Jul 2021 07:40:34 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210706064034eusmtip28242c78fef63937cdba889b3821b449b~PIGrnZo003174931749eusmtip2H;
 Tue,  6 Jul 2021 06:40:33 +0000 (GMT)
Subject: Re: [PATCH] iommu: qcom: Revert
 "iommu/arm: Cleanup resources in case of probe error path"
To: Amey Narkhede <ameynarkhede03@gmail.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <71106cbb-ff6d-02cb-7743-dfbd27bdaddf@samsung.com>
Date: Tue, 6 Jul 2021 08:40:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705143054.nxy4ii6t6npj22ov@archlinux>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7qPfz1OMJiyjs3i0vZlrBYL9ltb
 dM7ewG6x6fE1VouJ+8+yWzxf+IPZ4uCHJ6wWfXuDLFrumDpwejw5OI/JY828NYweO2fdZffY
 tKqTzWPzknqPyTeWM3r0Nr9j8/i8SS6AI4rLJiU1J7MstUjfLoErY/PZY+wFW9kq7s5Yw9jA
 2M/axcjJISFgIrH6fRtTFyMXh5DACkaJXxcvMUM4Xxgl7q2bBuV8ZpRY0rGCBaZl98JrUInl
 jBI/pp1mBkkICXxklGhbJgliCwukSjSsngS2Q0RAR+LRxoVsIA3MAtOZJA4/XQ2WYBMwlOh6
 2wWU4ODgFbCTWPvXGsRkEVCR+PS5HqRCVCBZ4v28GWDVvAKCEidnPgG7gVPAQuLltonsIDaz
 gLzE9rdzmCFscYlbT+aDvSMh8J9D4sqHZVB/ukjsWvmeCcIWlnh1fAs7hC0jcXpyDwtEQzOj
 xMNza9khnB5GictNMxghqqwl7pz7BXYos4CmxPpd+hBhR4lXf3eChSUE+CRuvBWEOIJPYtK2
 6cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS4tz01GLj
 vNRyveLE3OLSvHS95PzcTYzAZHX63/GvOxhXvPqod4iRiYPxEKMEB7OSCK/IlEcJQrwpiZVV
 qUX58UWlOanFhxilOViUxHl3bV0TLySQnliSmp2aWpBaBJNl4uCUamAKN9fc01Vq+Y4j6J9p
 /TeFqE//hHK+rcmWc1R/Ip/x9ENA3Z1vcRGzM/ZLLkmssnz6pun9gjhWXlmluW0zP3xwsk43
 DvO9MsHuqvDaPvefH2/6rZJ+89Jp3pmSXM3b9+8WNP3cYsWs2755qefsLWXCvhNWljt53r2q
 m/6m8gb35OUvIi4d03E3vFKczv0gzzqqnNEtb/q06s8mM08d6jo7w7TwQNPHb78zL760ERBi
 KQ3/0XBsEi8rp3F16vGPWY5HmsXfTP+Xo2BXcrV5m4TbxK/Tlhlf3G/ANa/7eseEnFcLLyxs
 F1ryU+TSk2MT5u3WFF0rOSNMtOBgd81eF+nFDDXvpjc+bX/TPTfQNmWDEktxRqKhFnNRcSIA
 OZINCcUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7qPfj1OMLj6Vcni0vZlrBYL9ltb
 dM7ewG6x6fE1VouJ+8+yWzxf+IPZ4uCHJ6wWfXuDLFrumDpwejw5OI/JY828NYweO2fdZffY
 tKqTzWPzknqPyTeWM3r0Nr9j8/i8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q
 2DzWyshUSd/OJiU1J7MstUjfLkEvY/PZY+wFW9kq7s5Yw9jA2M/axcjJISFgIrF74TXmLkYu
 DiGBpYwSX1/NYIFIyEicnNYAVSQs8edaFxtE0XtGiZ5F65lBEsICqRJHn54EaxAR0JF4tHEh
 WBGzwHQmieuvP7JAdOxnlDg8+zQTSBWbgKFE11uQURwcvAJ2Emv/WoOYLAIqEp8+14NUiAok
 S/xc384GYvMKCEqcnPkEbD6ngIXEy20T2UFsZgEziXmbHzJD2PIS29/OgbLFJW49mc80gVFo
 FpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA+Nx27OeWHYwrX33U
 O8TIxMF4iFGCg1lJhFdkyqMEId6UxMqq1KL8+KLSnNTiQ4ymQO9MZJYSTc4HJoi8knhDMwNT
 QxMzSwNTSzNjJXFekyNr4oUE0hNLUrNTUwtSi2D6mDg4pRqYOjf23PuwY9+sRKEJ3mtrBORC
 mfU7jqn0Tf0qynes/Icxd/iEI51u90ySlR4yf/9v4C0S5TixP+LaOouie8uS7u5Z+P6pksYi
 6z6uQ1sd/0REXDddEHOiRO5+ap5g2jHT344P3YN/FyxP5T3nqT1F0el4cObCtNP3JCbpvZfX
 +dyYLtAstezDZRb+IHcr9yuCUzqXeG854HL+5UnnM/GhbMuWx7ZKzDvwT4dVy9Fx8aldl4S7
 jjPVVNck313pdPy1mUYHzxUGrTOiHzK/xiTsZ9fom7nsXmTw2SviS6sd+O/mLt14wfWfgN3h
 Vbf8OyVUZrSm8U/86XL9//Gdb87UloZPuv7LxPirq7Oei8opJZbijERDLeai4kQAt9mzc1gD
 AAA=
X-CMS-MailID: 20210706064034eucas1p1e4bd9281a5badb012c1a65f0dbf8169a
X-Msg-Generator: CA
X-RootMTR: 20210705065703eucas1p2e89258a2fc286896b755047e06f514cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210705065703eucas1p2e89258a2fc286896b755047e06f514cb
References: <CGME20210705065703eucas1p2e89258a2fc286896b755047e06f514cb@eucas1p2.samsung.com>
 <20210705065657.30356-1-m.szyprowski@samsung.com>
 <20210705143054.nxy4ii6t6npj22ov@archlinux>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 05.07.2021 16:30, Amey Narkhede wrote:
> On 21/07/05 08:56AM, Marek Szyprowski wrote:
>> QCOM IOMMU driver calls bus_set_iommu() for every IOMMU device controller,
>> what fails for the second and latter IOMMU devices. This is intended and
>> must be not fatal to the driver registration process. Also the cleanup
>> path should take care of the runtime PM state, what is missing in the
>> current patch. Revert relevant changes to the QCOM IOMMU driver until
>> a proper fix is prepared.
>>
> Apologies for the broken patch I don't have any arm machine to test the
> patches. Is this bug unique to qcom iommu?

Frankly, I have no idea. Just grep for bus_set_iommu() and check if the 
caller might be executed more than once.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
