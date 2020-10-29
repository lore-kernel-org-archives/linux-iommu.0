Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D9EC4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 13:51:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AA82076A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 13:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AA82076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E100875B8;
	Thu, 29 Oct 2020 13:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gubYBYrq-qCl; Thu, 29 Oct 2020 13:51:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0CD0D875B2;
	Thu, 29 Oct 2020 13:51:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2D1DC088B;
	Thu, 29 Oct 2020 13:51:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1BFAC0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 13:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BFD27875B7
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 13:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIvlf4dYgQMK for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 13:51:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9901F875B2
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 13:51:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED001139F;
 Thu, 29 Oct 2020 06:51:25 -0700 (PDT)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BDDC3F719;
 Thu, 29 Oct 2020 06:51:24 -0700 (PDT)
Subject: Re: [PATCH] iommu/rockchip: check return value of
 of_find_device_by_node() in rk_iommu_of_xlate()
To: "yukuai (C)" <yukuai3@huawei.com>, joro@8bytes.org, heiko@sntech.de,
 jeffy.chen@rock-chips.com
References: <20201029092202.900218-1-yukuai3@huawei.com>
 <98dec09e-08a1-6550-fa4e-85a8104b90e1@arm.com>
 <35ff5111-1270-fc88-788c-4fb9e38faa85@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d5442e6b-2a6b-a8f9-2056-2c0c81e88a01@arm.com>
Date: Thu, 29 Oct 2020 13:51:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <35ff5111-1270-fc88-788c-4fb9e38faa85@huawei.com>
Content-Language: en-GB
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 yi.zhang@huawei.com
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

On 2020-10-29 13:19, yukuai (C) wrote:
> 
> On 2020/10/29 18:08, Robin Murphy wrote:
>> On 2020-10-29 09:22, Yu Kuai wrote:
>>> If of_find_device_by_node() failed in rk_iommu_of_xlate(), null pointer
>>> dereference will be triggered. Thus return error code if
>>> of_find_device_by_node() failed.
>>
>> How can that happen? (Given that ".suppress_bind_attrs = true")
>>
>> Robin.
> 
> I'm not sure if that could happen...
> 
> My thought is that it's better to do such checking to aviod any possible
> problem.

->of_xlate() is only invoked on the specific set of ops returned by 
iommu_ops_from_fwnode(). In turn, iommu_ops_from_fwnode() will only 
return those ops if the driver has successfully probed and called 
iommu_register_device() with the relevant DT node. For the driver to 
have been able to probe at all, a platform device associated with that 
DT node must have been created, and therefore of_find_device_by_node() 
cannot fail.

If there ever were some problem serious enough to break that fundamental 
assumption, then I *want* these drivers to crash right here, with a nice 
clear stack trace to start debugging from. So no, I firmly disagree that 
adding redundant code, which will never do anything except attempt to 
paper over catastrophic memory corruption, is "better". Sorry :)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
