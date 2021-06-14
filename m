Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39126C4743C
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 13:29:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FF96128C
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 13:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FF96128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94B0B40131;
	Mon, 14 Jun 2021 13:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9emyuEJlxIXi; Mon, 14 Jun 2021 13:29:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94E384037F;
	Mon, 14 Jun 2021 13:29:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51BD6C000F;
	Mon, 14 Jun 2021 13:29:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EEBAC000D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2932460809
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ck1hR_ein1x for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 13:29:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF2AD6080D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:29:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 259ED6D;
 Mon, 14 Jun 2021 06:29:15 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A18ED3F719;
 Mon, 14 Jun 2021 06:29:13 -0700 (PDT)
Subject: Re: Regression in at least 5.10.y and mainline: Firewire audio
 interface fails to work properly (when booted under Xen)
To: Salvatore Bonaccorso <carnil@debian.org>, =?UTF-8?B?5bCP5aSq?=
 <nospam@kota.moe>, Jianxiong Gao <jxgao@google.com>,
 Christoph Hellwig <hch@lst.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>, xen-devel@lists.xenproject.org
References: <162352833546.2353.230557992597997974.reportbug@home.kota.moe>
 <YMWl4UnFBAVRDnys@eldamar.lan>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f7c7d36-b6f4-f8ab-756e-a563fa03b9e4@arm.com>
Date: Mon, 14 Jun 2021 14:29:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMWl4UnFBAVRDnys@eldamar.lan>
Content-Language: en-GB
Cc: 989778-maintonly@bugs.debian.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-06-13 07:29, Salvatore Bonaccorso wrote:
> A user in Debian reported the above issue, which was reproducible with
> 5.13-rc5 and 5.10.y as packaged in Debian and found that 85a5a6875ca9
> ("swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single") that
> introduced the issue.

Sounds like it's probably the same thing as being discussed over here:

https://lore.kernel.org/linux-iommu/2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com/

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
