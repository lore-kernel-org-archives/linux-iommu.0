Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D07C35E1C
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 18:19:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF982469B
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 18:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF982469B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8D85C230A4;
	Thu, 27 Feb 2020 18:19:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jPIcD4nl-Zwk; Thu, 27 Feb 2020 18:19:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A73A2203D4;
	Thu, 27 Feb 2020 18:19:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D9C0C08A0;
	Thu, 27 Feb 2020 18:19:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A3FAC0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 34B7985BCA
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G2KBGLXZdeiq for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 18:19:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id E8FFB85B7C
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:19:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 469BC1FB;
 Thu, 27 Feb 2020 10:19:16 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CCB63F73B;
 Thu, 27 Feb 2020 10:19:13 -0800 (PST)
Subject: Re: [PATCH] iommu: silence iommu group prints
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <E1j7Hnc-0004Bm-Kn@rmk-PC.armlinux.org.uk>
 <2b86add2-03aa-21f1-c58a-120a8394e6eb@arm.com>
 <20200227134839.GL25745@shell.armlinux.org.uk>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a76d0425-c25c-60e9-3f5d-a33f49fd2989@arm.com>
Date: Thu, 27 Feb 2020 18:19:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200227134839.GL25745@shell.armlinux.org.uk>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org
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

On 27/02/2020 1:48 pm, Russell King - ARM Linux admin wrote:
> On Thu, Feb 27, 2020 at 01:44:56PM +0000, Robin Murphy wrote:
>> On 27/02/2020 11:57 am, Russell King wrote:
>>> On the LX2160A, there are lots (about 160) of IOMMU messages produced
>>> during boot; this is excessive.  Reduce the severity of these messages
>>> to debug level.
>>
>> That's... a lot. Does the system really have that many devices, or is some
>> driver being stupid and repeatedly populating and destroying an entire bus
>> in a probe-deferral dance?
> 
> It's all the devices created by for the mc-bus for the DPAA2
> networking support.  I don't know the technicalities, just that
> the boot is spammed with these messages.

Well, the "technicalities" are really just whether the thing before the 
colon on each message is unique or not. If you're seeing multiple add 
and remove calls pertaining to the same device (or frankly any remove 
calls at all during boot) then it smacks of something somewhere wasting 
time and resources with unnecessary busywork, which is indicative of 
either poor design or an actual bug, either of which would deserve fixing.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
