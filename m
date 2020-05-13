Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA17C433DF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 22:16:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DA3205ED
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 22:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DA3205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F2034876FF;
	Wed, 13 May 2020 22:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eXA8T9ZMArdq; Wed, 13 May 2020 22:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D9A4876EF;
	Wed, 13 May 2020 22:16:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 295EAC088B;
	Wed, 13 May 2020 22:16:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 254DEC016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0BFD620410
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MLXaYMJTlKet for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 22:16:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by silver.osuosl.org (Postfix) with ESMTPS id 44369266BD
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:16:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: gtucker) with ESMTPSA id A221C2A285C
Subject: Re: next/master bisection: baseline.login on jetson-tk1
To: Joerg Roedel <jroedel@suse.de>
References: <5eb9fab4.1c69fb81.a1f1c.0e95@mx.google.com>
 <a868fa70-9039-f72a-39c6-5464a9d06db2@collabora.com>
 <20200512151600.GD8135@suse.de>
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <c9745450-a6d0-1944-a9af-ef9ce18fed12@collabora.com>
Date: Wed, 13 May 2020 23:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512151600.GD8135@suse.de>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-next@vger.kernel.org
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

On 12/05/2020 16:16, Joerg Roedel wrote:
> Hi Guillaume,
> 
> thanks for the report!
> 
> On Tue, May 12, 2020 at 07:05:13AM +0100, Guillaume Tucker wrote:
>>> Summary:
>>>   Start:      4b20e7462caa6 Add linux-next specific files for 20200511
>>>   Plain log:  https://storage.kernelci.org/next/master/next-20200511/arm/tegra_defconfig/gcc-8/lab-collabora/baseline-tegra124-jetson-tk1.txt
>>>   HTML log:   https://storage.kernelci.org/next/master/next-20200511/arm/tegra_defconfig/gcc-8/lab-collabora/baseline-tegra124-jetson-tk1.html
>>>   Result:     3eeeb45c6d044 iommu: Remove add_device()/remove_device() code-paths
> 
> Okay, so it faults at
> 
> 	PC is at __iommu_probe_device+0x20/0x1b8
> 
> Can you translate that for me into a code-line, please? That would help
> finding the issue.

Sure, sorry for the delay.  I've built my own image as vmlinux is
not stored by kernelci and reproduced the problem:

  https://lava.collabora.co.uk/scheduler/job/2403076#L544

which this time gave me:

<4>[    2.540558] PC is at iommu_probe_device+0x1c/0x15c
<4>[    2.545606] LR is at of_iommu_configure+0x15c/0x1c4
<4>[    2.550736] pc : [<c092e0e4>]    lr : [<c0932c0c>]    psr: a0000013

which in turn brings us to:

(gdb) l *0xc092e0e4
0xc092e0e4 is in iommu_probe_device (drivers/iommu/iommu.c:232).
227		int ret;
228	
229		if (!dev_iommu_get(dev))
230			return -ENOMEM;
231	
232		if (!try_module_get(ops->owner)) {
233			ret = -EINVAL;
234			goto err_out;
235		}
236	


Hope this helps.

Guillaume
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
