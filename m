Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71094C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 14:34:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1793164DDC
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 14:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1793164DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0BDE86F96;
	Tue,  2 Feb 2021 14:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ok4mp6wPe3pX; Tue,  2 Feb 2021 14:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC24A85EA5;
	Tue,  2 Feb 2021 14:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8C1AC0FA7;
	Tue,  2 Feb 2021 14:34:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60D9BC013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 14:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4F83E85EC1
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 14:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q67jsQ9WXQci for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:34:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5678585EA5
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 14:34:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90519ED1;
 Tue,  2 Feb 2021 06:34:37 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E69C83F718;
 Tue,  2 Feb 2021 06:34:35 -0800 (PST)
Subject: Re: [PATCH 2/2] iommu: add Unisoc iommu basic driver
To: Joerg Roedel <joro@8bytes.org>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20210202073258.559443-3-zhang.lyra@gmail.com>
 <20210202104257.736836-1-zhang.lyra@gmail.com>
 <20210202140101.GA32671@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <992fad43-c457-d809-3bd7-7fd5b6e8fa22@arm.com>
Date: Tue, 2 Feb 2021 14:34:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202140101.GA32671@8bytes.org>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
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

On 2021-02-02 14:01, Joerg Roedel wrote:
> On Tue, Feb 02, 2021 at 06:42:57PM +0800, Chunyan Zhang wrote:
>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>
>> This iommu module can be used by Unisoc's multimedia devices, such as
>> display, Image codec(jpeg) and a few signal processors, including
>> VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>> ---
>>   drivers/iommu/Kconfig      |  12 +
>>   drivers/iommu/Makefile     |   1 +
>>   drivers/iommu/sprd-iommu.c | 598 +++++++++++++++++++++++++++++++++++++
> 
> This looks like it actually belongs under drivers/iommu/arm/, no?

Nope, I believe if Arm Ltd. had any involvement in this I'd know about it :)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
