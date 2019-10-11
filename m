Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F354CC47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 09:25:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5C02196E
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 09:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5C02196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 70BB113EC;
	Fri, 11 Oct 2019 09:25:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CF90513E1
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 09:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B39245D3
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 09:16:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2597A337;
	Fri, 11 Oct 2019 02:16:44 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6239F3F703;
	Fri, 11 Oct 2019 02:16:42 -0700 (PDT)
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Add an optional "input-address-size"
	property
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
	robh+dt@kernel.org, mark.rutland@arm.com, will@kernel.org
References: <20191011034609.13319-1-nicoleotsuka@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e99e07c2-88c6-e4d8-af80-c46d36bc6cd0@arm.com>
Date: Fri, 11 Oct 2019 10:16:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
	Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011034609.13319-1-nicoleotsuka@gmail.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 2019-10-11 4:46 am, Nicolin Chen wrote:
> This series of patches add an optional DT property to allow an SoC to
> specify how many bits being physically connected to its SMMU instance,
> depending on the SoC design.

This has come up before, and it doesn't work in general because a single 
SMMU instance can have many master interfaces, with potentially 
different sizes of address bus wired up to each. It's also a 
conceptually-wrong approach anyway, since this isn't a property of the 
SMMU; it's a property of the interconnect(s) upstream of the SMMU.

IIRC you were working on Tegra - if so, Thierry already has a plan, see 
this thread: 
https://lore.kernel.org/linux-arm-kernel/20190930133510.GA1904140@ulmo/

Robin.

> 
> Nicolin Chen (2):
>    dt-bindings: arm-smmu: Add an optional "input-address-size" property
>    iommu/arm-smmu: Read optional "input-address-size" property
> 
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt |  7 +++++++
>   drivers/iommu/arm-smmu.c                             | 10 ++++++++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
