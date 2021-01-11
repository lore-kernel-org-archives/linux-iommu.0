Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5843C433DB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 07:53:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE8F22A83
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 07:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE8F22A83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C4FE86678;
	Mon, 11 Jan 2021 07:52:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TqakqdoSfzOz; Mon, 11 Jan 2021 07:52:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10D5286660;
	Mon, 11 Jan 2021 07:52:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA81EC0893;
	Mon, 11 Jan 2021 07:52:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51A45C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 07:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3875A86660
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 07:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UkKB6XErTkX3 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 07:52:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 88F328665D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 07:52:54 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610351575; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=huO5ikyPhqdZL6A8Erp87tkWU1chk9SNZgP+iThKQjk=;
 b=LJcucpvK4hpMhDPawlZaM049kd1oYxpAt9fMoLyEWPO0bGRRneFevqO2cV915J1dqC0mTJVl
 QBM4pOEExgYk5UWyD4+HiMNno0wtICmFh7xGfNirRc7sUh9xmqo94Kcgyn+Ck1JUangGhAF9
 pi/eX9LCKQKIhVwvPlknVCj5vZk=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ffc03c7c88af061070c68e9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 07:52:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C6D0EC43464; Mon, 11 Jan 2021 07:52:38 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C1B3BC433CA;
 Mon, 11 Jan 2021 07:52:37 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 11 Jan 2021 13:22:37 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: isaacm@codeaurora.org
Subject: Re: [PATCH 0/5] Optimize iommu_map_sg() performance
In-Reply-To: <20210111062300.28541-1-saiprakash.ranjan@codeaurora.org>
References: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
 <20210111062300.28541-1-saiprakash.ranjan@codeaurora.org>
Message-ID: <5a29b6e339c66e9c7cd9a608baa3f9e1@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: will@kernel.org, pdaly@codeaurora.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org
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

On 2021-01-11 11:52, Sai Prakash Ranjan wrote:
> Hi Isaac,
> 
> I gave this series a go on chromebook and saw these warnings
> and several device probe failures, logs attached below:
> 
> WARN corresponds to this code in arm_lpae_map_by_pgsize()
> 
> 	if (WARN_ON(iaext || (paddr + size) >> cfg->oas))
> 		return -ERANGE;
> 
> Logs:
> 
> [    2.411391] ------------[ cut here ]------------
> [    2.416149] WARNING: CPU: 6 PID: 56 at
> drivers/iommu/io-pgtable-arm.c:492 arm_lpae_map_sg+0x234/0x248
> [    2.425606] Modules linked in:
> [    2.428749] CPU: 6 PID: 56 Comm: kworker/6:1 Not tainted 5.10.5 #970
> [    2.440287] Workqueue: events deferred_probe_work_func
> [    2.445563] pstate: 20c00009 (nzCv daif +PAN +UAO -TCO BTYPE=--)
> [    2.451726] pc : arm_lpae_map_sg+0x234/0x248
> [    2.456112] lr : arm_lpae_map_sg+0xe0/0x248
> [    2.460410] sp : ffffffc010513750
> [    2.463820] x29: ffffffc010513790 x28: ffffffb943332000
> [    2.469281] x27: 0000000ffffff000 x26: ffffffb943d14900
> [    2.474738] x25: 0000000000001000 x24: 0000000103465000
> [    2.480196] x23: 0000000000000001 x22: 0000000103466000
> [    2.485645] x21: 0000000000000003 x20: 0000000000000a20
> [    2.491103] x19: ffffffc010513850 x18: 0000000000000001
> [    2.496562] x17: 0000000000000002 x16: 00000000ffffffff
> [    2.502021] x15: 0000000000000000 x14: 0000000000000000
> [    2.507479] x13: 0000000000000001 x12: 0000000000000000
> [    2.512928] x11: 0000001000000000 x10: 0000000000000000
> [    2.518385] x9 : 0000000000000001 x8 : 0000000040201000
> [    2.523844] x7 : 0000000000000a20 x6 : ffffffb943463000
> [    2.529302] x5 : 0000000000000003 x4 : 0000000000001000
> [    2.534760] x3 : 0000000000000001 x2 : ffffffb941f605a0
> [    2.540219] x1 : 0000000000000003 x0 : 0000000000000e40
> [    2.545679] Call trace:
> [    2.548196]  arm_lpae_map_sg+0x234/0x248
> [    2.552225]  arm_smmu_map_sg+0x80/0xc4
> [    2.556078]  __iommu_map_sg+0x6c/0x188
> [    2.559931]  iommu_map_sg_atomic+0x18/0x20
> [    2.564144]  iommu_dma_alloc_remap+0x26c/0x34c
> [    2.568703]  iommu_dma_alloc+0x9c/0x268
> [    2.572647]  dma_alloc_attrs+0x88/0xfc
> [    2.576503]  gsi_ring_alloc+0x50/0x144
> [    2.580356]  gsi_init+0x2c4/0x5c4
> [    2.583766]  ipa_probe+0x14c/0x2b4
> [    2.587263]  platform_drv_probe+0x94/0xb4
> [    2.591377]  really_probe+0x138/0x348
> [    2.595145]  driver_probe_device+0x80/0xb8
> [    2.599358]  __device_attach_driver+0x90/0xa8
> [    2.603829]  bus_for_each_drv+0x84/0xcc
> [    2.607772]  __device_attach+0xc0/0x148
> [    2.611713]  device_initial_probe+0x18/0x20
> [    2.616012]  bus_probe_device+0x38/0x94
> [    2.619953]  deferred_probe_work_func+0x78/0xb0
> [    2.624611]  process_one_work+0x210/0x3dc
> [    2.628726]  worker_thread+0x284/0x3e0
> [    2.632578]  kthread+0x148/0x1a8
> [    2.635891]  ret_from_fork+0x10/0x18
> [    2.639562] ---[ end trace 9bac18cad6a9862e ]---
> [    2.644414] ipa 1e40000.ipa: error -12 allocating channel 0 event 
> ring
> [    2.651656] ipa: probe of 1e40000.ipa failed with error -12
> [    2.660072] dwc3 a600000.dwc3: Adding to iommu group 8
> [    2.668632] xhci-hcd xhci-hcd.13.auto: xHCI Host Controller
> [    2.674680] xhci-hcd xhci-hcd.13.auto: new USB bus registered,
> assigned bus number 1
> 

<snip>...

Isaac provided a fix which he will post as v2 and no warnings were 
observed
with that fix.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
