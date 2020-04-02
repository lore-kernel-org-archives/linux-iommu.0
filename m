Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7648EC43331
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 13:21:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4195F206F5
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 13:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4195F206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 05C4D87EAC;
	Thu,  2 Apr 2020 13:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VceNrobSVZ-a; Thu,  2 Apr 2020 13:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2CA587EE0;
	Thu,  2 Apr 2020 13:20:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DB16C1AE2;
	Thu,  2 Apr 2020 13:20:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EF60C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 13:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 88D0586208
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 13:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BeTAzV1aLCTn for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 13:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8F78C859F4
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 13:20:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3B2630E;
 Thu,  2 Apr 2020 06:20:09 -0700 (PDT)
Received: from [10.57.59.199] (unknown [10.57.59.199])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33B83F52E;
 Thu,  2 Apr 2020 06:20:08 -0700 (PDT)
Subject: Re: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "john.stultz@linaro.org" <john.stultz@linaro.org>
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0dea497-b272-e74a-ac9c-3a3cd653a9f9@arm.com>
Date: Thu, 2 Apr 2020 14:20:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Content-Language: en-GB
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>
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

On 2020-04-02 11:16 am, Yoshihiro Shimoda wrote:
> Hi John,
> 
> I found an issue after applied the following patches:
> ---
> 64c775f driver core: Rename deferred_probe_timeout and make it global
> 0e9f8d0 driver core: Remove driver_deferred_probe_check_state_continue()
> bec6c0e pinctrl: Remove use of driver_deferred_probe_check_state_continue()
> e2cec7d driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
> c8c43ce driver core: Fix driver_deferred_probe_check_state() logic
> ---
> 
> Before these patches, on my environment [1], some device drivers
> which has iommus property output the following message when probing:
> 
> [    3.222205] ravb e6800000.ethernet: ignoring dependency for device, assuming no driver
> [    3.257174] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
> 
> So, since ravb driver is probed within 4 seconds, we can use NFS rootfs correctly.
> 
> However, after these patches are applied, since the patches are always waiting for 30 seconds
> for of_iommu_configure() when IOMMU hardware is disabled, drivers/base/dd.c output WARN.
> Also, since ravb cannot be probed for 30 seconds, we cannot use NFS rootfs anymore.
> JFYI, I copied the kernel log to the end of this email.
> 
> I guess the patches will be merged into v5.7-rc1 because the patches are contained from
> next-20200316, I'd like to fix the issue in v5.7-rcN cycle somehow.

This already came up in a different context, and there's a proposal from 
John here:

https://lore.kernel.org/lkml/20200330202715.86609-1-john.stultz@linaro.org/

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
