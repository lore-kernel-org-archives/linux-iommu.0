Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F918C3815B
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 16:16:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D2020B1F
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 16:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D2020B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 59FBE848C2;
	Mon, 20 Apr 2020 16:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vdrg5AZGZzRy; Mon, 20 Apr 2020 16:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44A5D847D1;
	Mon, 20 Apr 2020 16:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FDCAC1D74;
	Mon, 20 Apr 2020 16:16:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF7C2C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CC90287E8B
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLgNUWFPPjvx for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 16:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id E1E7787E4C
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 16:16:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6440C31B;
 Mon, 20 Apr 2020 09:16:38 -0700 (PDT)
Received: from [10.57.33.63] (unknown [10.57.33.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C420E3F73D;
 Mon, 20 Apr 2020 09:16:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] iommu: Add Allwinner H6 IOMMU driver
To: Maxime Ripard <maxime@cerno.tech>, Joerg Roedel <joro@8bytes.org>
References: <cover.a31c229a83f1d92e6928ae2adb70887da0fd44b3.1582222496.git-series.maxime@cerno.tech>
 <6864f0f28825bb7a2ec1c0d811a4aacdecf5f945.1582222496.git-series.maxime@cerno.tech>
 <20200302153606.GB6540@8bytes.org>
 <20200401114710.doioefzmjhte7jwu@gilmour.lan>
 <20200408140649.GI3103@8bytes.org>
 <20200420143958.rdn3j27tu3umtkrh@gilmour.lan>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <af745738-9e0f-40b6-9a20-19c233a7e52a@arm.com>
Date: Mon, 20 Apr 2020 17:16:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420143958.rdn3j27tu3umtkrh@gilmour.lan>
Content-Language: en-GB
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-04-20 3:39 pm, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Apr 08, 2020 at 04:06:49PM +0200, Joerg Roedel wrote:
>> On Wed, Apr 01, 2020 at 01:47:10PM +0200, Maxime Ripard wrote:
>>> As far as I understand it, the page table can be accessed concurrently
>>> since the framework doesn't seem to provide any serialization /
>>> locking, shouldn't we have some locks to prevent concurrent access?
>>
>> The dma-iommu code makes sure that there are no concurrent accesses to
>> the same address-range of the page-table, but there can (and will) be
>> concurrent accesses to the same page-table, just for different parts of
>> the address space.
>>
>> Making this lock-less usually involves updating non-leaf page-table
>> entries using atomic compare-exchange instructions.
> 
> That makes sense, thanks!
> 
> I'm not sure what I should compare with though, do you want to compare with 0 to
> check if there's already a page table assigned to that DTE? If so, then we
> should also allocate the possible page table before the fact so that we have
> something to swap with, and deallocate it if we already had one?

Indeed, for an example see arm_v7s_install_table() and how 
__arm_v7s_map() calls it. The LPAE version in io-pgtable-arm.c does the 
same too, but with some extra software-bit handshaking to track the 
cache maintenance state as an optimisation, which you can probably do 
without trying to make sense of ;)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
