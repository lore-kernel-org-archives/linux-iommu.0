Return-Path: <SRS0=jB4a=WS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E35C3A5A2
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 14:30:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A77233FE
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 14:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A77233FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DC80DCDF;
	Thu, 22 Aug 2019 14:30:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1BB62CB7
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 14:30:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B346E8AC
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 14:30:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F453337;
	Thu, 22 Aug 2019 07:30:29 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5672B3F706;
	Thu, 22 Aug 2019 07:30:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu: Introduce wrapper for writeq/readq
To: Will Deacon <will@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
References: <20190711150242.25290-1-gregory.clement@bootlin.com>
	<20190711150242.25290-2-gregory.clement@bootlin.com>
	<20190820120848.2m6gytilrpil4stu@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4ef6512d-701f-4fe8-8173-5f659dab0d32@arm.com>
Date: Thu, 22 Aug 2019 15:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190820120848.2m6gytilrpil4stu@willie-the-truck>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Hanna Hawa <hannah@marvell.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nadav Haklai <nadavh@marvell.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

On 20/08/2019 13:08, Will Deacon wrote:
> Hi Gregory, Hanna,
> 
> On Thu, Jul 11, 2019 at 05:02:39PM +0200, Gregory CLEMENT wrote:
>> From: Hanna Hawa <hannah@marvell.com>
>>
>> This patch introduces the smmu_writeq_relaxed/smmu_readq_relaxed
>> helpers, as preparation to add specific Marvell work-around for
>> accessing 64 bits width registers of ARM SMMU.
>>
>> Signed-off-by: Hanna Hawa <hannah@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 36 +++++++++++++++++++++++++++---------
>>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> Sorry for the delay in replying to this -- Robin's been reworking the driver
> so that implementation quirks can be specified more cleanly. Please can you
> take a look at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/refactoring
> 
> and try to respin your patches on top of that?

Right, the arm_smmu_impl design was specifically anticipating this quirk 
as well - it should just be a case of a cfg_probe hook to hide the 
features which can't work, plus {read,write}_reg64 hooks to override any 
remaining 64-bit accesses with the explicit hi_lo_* variants, munged 
together (either statically or dynamically) with the standard MMU-500 hooks.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
