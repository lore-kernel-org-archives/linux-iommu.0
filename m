Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA56CC04AB5
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 19:53:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF0F26B14
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 19:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mVkn8qHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF0F26B14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 319B4CDE;
	Mon,  3 Jun 2019 19:53:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 47FA6CCB
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 19:53:08 +0000 (UTC)
X-Greylist: delayed 00:05:04 by SQLgrey-1.7.6
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E0EBFA3
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 19:53:07 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5cf579710000>; Mon, 03 Jun 2019 12:48:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate101.nvidia.com (PGP Universal service);
	Mon, 03 Jun 2019 12:48:02 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Mon, 03 Jun 2019 12:48:02 -0700
Received: from [10.26.11.157] (10.124.1.5) by HQMAIL107.nvidia.com
	(172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Mon, 3 Jun 2019 19:47:59 +0000
Subject: Re: [PATCH 07/26] iommu/dma: move the arm64 wrappers to common code
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-8-hch@lst.de>
	<06b331f0-7df7-a6cd-954c-789f89a0836d@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <acb46c7f-0855-de30-485f-a6242968f947@nvidia.com>
Date: Mon, 3 Jun 2019 20:47:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <06b331f0-7df7-a6cd-954c-789f89a0836d@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
	HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1559591281; bh=RMxapgyeEuOTQ8bInOu5Fbjyth09Qz8mwr+ogzgFnH8=;
	h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
	User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
	X-ClientProxiedBy:Content-Type:Content-Language:
	Content-Transfer-Encoding;
	b=mVkn8qHn4oghIo8cKZJkJcmq0wsglM5sp4kJ+xEF9zxvkcO3EetQgf2WDxh88dKjl
	WU1kgDYR/RidtsSNfnah+urlkR+Aos1fbomRJh6Mppj0JQQvyIivYS5V6fRQJohR0L
	3BANrGnTtJhH+HsC14T2ZHd6w6ZJtQMfzzOPCu3UOfCCJvUHBxlBeVRcxyTcmiFwqk
	JUR6R9NsmkaIo7NwILxJWuVb0kwVn28ZNBRL28dX8Tmsmorji8+p9XEtvX/entSiKW
	QlKhjgG5mx2vvbBDIHNrTzsMbbV5vRMD3GixETL4yf3Ev9Z+ZL6g8+QFpf4nVKcf9X
	S9Y166LHlYo4Q==
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	linux-tegra <linux-tegra@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Ck9uIDI5LzA0LzIwMTkgMTM6NTYsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMi8wNC8yMDE5
IDE4OjU5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gVGhlcmUgaXMgbm90aGluZyByZWFs
bHkgYXJtNjQgc3BlY2lmaWMgaW4gdGhlIGlvbW11X2RtYV9vcHMKPj4gaW1wbGVtZW50YXRpb24s
IHNvIG1vdmUgaXQgdG8gZG1hLWlvbW11LmMgYW5kIGtlZXAgYSBsb3Qgb2Ygc3ltYm9scwo+PiBz
ZWxmLWNvbnRhaW5lZC7CoCBOb3RlIHRoZSBpbXBsZW1lbnRhdGlvbiBkb2VzIGRlcGVuZCBvbiB0
aGUKPj4gRE1BX0RJUkVDVF9SRU1BUCBpbmZyYXN0cnVjdHVyZSBmb3Igbm93LCBzbyB3ZSdsbCBo
YXZlIHRvIG1ha2UgdGhlCj4+IERNQV9JT01NVSBzdXBwb3J0IGRlcGVuZCBvbiBpdCwgYnV0IHRo
aXMgd2lsbCBiZSByZWxheGVkIHNvb24uCj4gCj4gTm90aGluZyBsb29rcyBvYmplY3Rpb25hYmxl
LCBhbmQgYm9vdCB0ZXN0aW5nIHdpdGggdGhpcyBtdWNoIG9mIHRoZQo+IHNlcmllcyBtZXJnZWQg
aGFzIG15IGNvaGVyZW50IGFuZCBub24tY29oZXJlbnQgSU9NTVUtYmFja2VkIGRldmljZXMKPiBh
cHBlYXJpbmcgdG8gc3RpbGwgd29yayBPSywgc286Cj4gCj4gQWNrZWQtYnk6IFJvYmluIE11cnBo
eSA8cm9iaW4ubXVycGh5QGFybS5jb20+CgpTaW5jZSBuZXh0LTIwMTkwNTI5IG9uZSBvZiBvdXIg
dGVzdHMgZm9yIE1NQyBoYXMgc3RhcnRlZCBmYWlsaW5nLCB3aGVyZQp0aGUgc3ltcHRvbSBpcyB0
aGF0IHRoZSBkYXRhIHdyaXR0ZW4gdG8gdGhlIE1NQyBkb2VzIG5vdCBtYXRjaCB0aGUKc291cmNl
LiBCaXNlY3RpbmcgdGhpcyBpcyBwb2ludGluZyB0byB0aGlzIGNvbW1pdC4gVW5mb3J0dW5hdGVs
eSwgSSBhbQpub3QgYWJsZSB0byBjbGVhbmx5IHJldmVydCB0aGlzIG9uIHRvcCBvZiAtbmV4dCwg
YnV0IHdhbnRlZCB0byByZXBvcnQKdGhpcyBpZiBjYXNlIHlvdSBoYXZlIGFueSBpZGVhcy4KCkNo
ZWVycwpKb24KCi0tIApudnB1YmxpYwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
