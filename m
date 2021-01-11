Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC4EC433DB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 06:23:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B536C22581
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 06:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B536C22581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 53DE386456;
	Mon, 11 Jan 2021 06:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQPf1wVhYHkG; Mon, 11 Jan 2021 06:23:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 08B1A84E10;
	Mon, 11 Jan 2021 06:23:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD8CAC088B;
	Mon, 11 Jan 2021 06:23:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D058C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 06:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7F0F920334
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 06:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NQDxfsZEOH0a for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 06:23:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 3356820014
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 06:23:20 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610346201; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qP12+/itRUcyXevm25tTKN/chs7KqhP61X3N5GeI15s=;
 b=JlVZFaOcgkuh9k844WzN6ab5S3Nd8UWE+fM1JMH2B1ITTc+d+WqPLbY+8WdVw1FFg0dbLNB/
 pZTbRjNtfgD5TjWEyzKMXPl86c9lPfJ9OUzeQO3bSXuu1WmusB65hISdhvL4AdmIzvnKt9KZ
 rz6SxPTADkQZKynHuhDJd7B13U4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ffbeed4e53eb5da8cb73712 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 06:23:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id A8430C43463; Mon, 11 Jan 2021 06:23:16 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AC57C433CA;
 Mon, 11 Jan 2021 06:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AC57C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: isaacm@codeaurora.org
Subject: Re: [PATCH 0/5] Optimize iommu_map_sg() performance
Date: Mon, 11 Jan 2021 11:52:59 +0530
Message-Id: <20210111062300.28541-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
References: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Isaac,

On 2021-01-09 07:20, Isaac J. Manjarres wrote:
> The iommu_map_sg() code currently iterates through the given
> scatter-gather list, and in the worst case, invokes iommu_map()
> for each element in the scatter-gather list, which calls into
> the IOMMU driver through an indirect call. For an IOMMU driver
> that uses a format supported by the io-pgtable code, the IOMMU
> driver will then call into the io-pgtable code to map the chunk.
> 
> Jumping between the IOMMU core code, the IOMMU driver, and the
> io-pgtable code and back for each element in a scatter-gather list
> is not efficient.
> 
> Instead, add a map_sg() hook in both the IOMMU driver ops and the
> io-pgtable ops. iommu_map_sg() can then call into the IOMMU driver's
> map_sg() hook with the entire scatter-gather list, which can call
> into the io-pgtable map_sg() hook, which can process the entire
> scatter-gather list, signficantly reducing the number of indirect
> calls, and jumps between these layers, boosting performance.
> 
> On a system that uses the ARM SMMU driver, and the ARM LPAE format,
> the current implementation of iommu_map_sg() yields the following
> latencies for mapping scatter-gather lists of various sizes. These
> latencies are calculated by repeating the mapping operation 10 times:
> 
>     size        iommu_map_sg latency
>       4K            0.624 us
>      64K            9.468 us
>       1M          122.557 us
>       2M          239.807 us
>      12M         1435.979 us
>      24M         2884.968 us
>      32M         3832.979 us
> 
> On the same system, the proposed modifications yield the following
> results:
> 
>     size        iommu_map_sg latency
>       4K            3.645 us
>      64K            4.198 us
>       1M           11.010 us
>       2M           17.125 us
>      12M           82.416 us
>      24M          158.677 us
>      32M          210.468 us
> 
> The procedure for collecting the iommu_map_sg latencies is
> the same in both experiments. Clearly, reducing the jumps
> between the different layers in the IOMMU code offers a
> signficant performance boost in iommu_map_sg() latency.
> 

I gave this series a go on chromebook and saw these warnings
and several device probe failures, logs attached below:

WARN corresponds to this code in arm_lpae_map_by_pgsize()

	if (WARN_ON(iaext || (paddr + size) >> cfg->oas))
		return -ERANGE;

Logs:

[    2.411391] ------------[ cut here ]------------
[    2.416149] WARNING: CPU: 6 PID: 56 at drivers/iommu/io-pgtable-arm.c:492 arm_lpae_map_sg+0x234/0x248
[    2.425606] Modules linked in:
[    2.428749] CPU: 6 PID: 56 Comm: kworker/6:1 Not tainted 5.10.5 #970
[    2.440287] Workqueue: events deferred_probe_work_func
[    2.445563] pstate: 20c00009 (nzCv daif +PAN +UAO -TCO BTYPE=--)
[    2.451726] pc : arm_lpae_map_sg+0x234/0x248
[    2.456112] lr : arm_lpae_map_sg+0xe0/0x248
[    2.460410] sp : ffffffc010513750
[    2.463820] x29: ffffffc010513790 x28: ffffffb943332000 
[    2.469281] x27: 0000000ffffff000 x26: ffffffb943d14900 
[    2.474738] x25: 0000000000001000 x24: 0000000103465000 
[    2.480196] x23: 0000000000000001 x22: 0000000103466000 
[    2.485645] x21: 0000000000000003 x20: 0000000000000a20 
[    2.491103] x19: ffffffc010513850 x18: 0000000000000001 
[    2.496562] x17: 0000000000000002 x16: 00000000ffffffff 
[    2.502021] x15: 0000000000000000 x14: 0000000000000000 
[    2.507479] x13: 0000000000000001 x12: 0000000000000000 
[    2.512928] x11: 0000001000000000 x10: 0000000000000000 
[    2.518385] x9 : 0000000000000001 x8 : 0000000040201000 
[    2.523844] x7 : 0000000000000a20 x6 : ffffffb943463000 
[    2.529302] x5 : 0000000000000003 x4 : 0000000000001000 
[    2.534760] x3 : 0000000000000001 x2 : ffffffb941f605a0 
[    2.540219] x1 : 0000000000000003 x0 : 0000000000000e40 
[    2.545679] Call trace:
[    2.548196]  arm_lpae_map_sg+0x234/0x248
[    2.552225]  arm_smmu_map_sg+0x80/0xc4
[    2.556078]  __iommu_map_sg+0x6c/0x188
[    2.559931]  iommu_map_sg_atomic+0x18/0x20
[    2.564144]  iommu_dma_alloc_remap+0x26c/0x34c
[    2.568703]  iommu_dma_alloc+0x9c/0x268
[    2.572647]  dma_alloc_attrs+0x88/0xfc
[    2.576503]  gsi_ring_alloc+0x50/0x144
[    2.580356]  gsi_init+0x2c4/0x5c4
[    2.583766]  ipa_probe+0x14c/0x2b4
[    2.587263]  platform_drv_probe+0x94/0xb4
[    2.591377]  really_probe+0x138/0x348
[    2.595145]  driver_probe_device+0x80/0xb8
[    2.599358]  __device_attach_driver+0x90/0xa8
[    2.603829]  bus_for_each_drv+0x84/0xcc
[    2.607772]  __device_attach+0xc0/0x148
[    2.611713]  device_initial_probe+0x18/0x20
[    2.616012]  bus_probe_device+0x38/0x94
[    2.619953]  deferred_probe_work_func+0x78/0xb0
[    2.624611]  process_one_work+0x210/0x3dc
[    2.628726]  worker_thread+0x284/0x3e0
[    2.632578]  kthread+0x148/0x1a8
[    2.635891]  ret_from_fork+0x10/0x18
[    2.639562] ---[ end trace 9bac18cad6a9862e ]---
[    2.644414] ipa 1e40000.ipa: error -12 allocating channel 0 event ring
[    2.651656] ipa: probe of 1e40000.ipa failed with error -12
[    2.660072] dwc3 a600000.dwc3: Adding to iommu group 8
[    2.668632] xhci-hcd xhci-hcd.13.auto: xHCI Host Controller
[    2.674680] xhci-hcd xhci-hcd.13.auto: new USB bus registered, assigned bus number 1
[    2.683638] ------------[ cut here ]------------
[    2.688391] WARNING: CPU: 6 PID: 56 at drivers/iommu/io-pgtable-arm.c:492 arm_lpae_map_sg+0x234/0x248
[    2.697846] Modules linked in:
[    2.700988] CPU: 6 PID: 56 Comm: kworker/6:1 Tainted: G        W         5.10.5 #970
[    2.713954] Workqueue: events deferred_probe_work_func
[    2.719228] pstate: 20c00009 (nzCv daif +PAN +UAO -TCO BTYPE=--)
[    2.725390] pc : arm_lpae_map_sg+0x234/0x248
[    2.729775] lr : arm_lpae_map_sg+0xe0/0x248
[    2.734073] sp : ffffffc010512e20
[    2.737483] x29: ffffffc010512e60 x28: ffffffb94345e000 
[    2.742942] x27: 0000000ffffff000 x26: ffffffb941fa1500 
[    2.748400] x25: 0000000000001000 x24: 0000000103468000 
[    2.753858] x23: 0000000000000001 x22: 0000000103469000 
[    2.759318] x21: 0000000000000003 x20: 0000000000000a20 
[    2.764777] x19: ffffffc010512f20 x18: 0000000000000001 
[    2.770235] x17: 0000000000000001 x16: 00000000ffffffff 
[    2.775694] x15: 0000000000000000 x14: 0000000000000001 
[    2.781154] x13: 0000000000000001 x12: 0000000000000000 
[    2.786613] x11: 0000001000000000 x10: 0000000000000000 
[    2.792071] x9 : 0000000000000001 x8 : 0000000040201000 
[    2.797529] x7 : 0000000000000000 x6 : ffffffc010512f20 
[    2.802988] x5 : 0000000000000a20 x4 : 0000000000001000 
[    2.808438] x3 : 0000000000000001 x2 : ffffffb9457d6100 
[    2.813896] x1 : 0000000000000003 x0 : 0000000000000e40 
[    2.819356] Call trace:
[    2.821878]  arm_lpae_map_sg+0x234/0x248
[    2.825907]  arm_smmu_map_sg+0x80/0xc4
[    2.829761]  __iommu_map_sg+0x6c/0x188
[    2.833615]  iommu_map_sg_atomic+0x18/0x20
[    2.837827]  iommu_dma_alloc_remap+0x26c/0x34c
[    2.842386]  iommu_dma_alloc+0x9c/0x268
[    2.846329]  dma_alloc_attrs+0x88/0xfc
[    2.850184]  xhci_mem_init+0x200/0x930
[    2.854037]  xhci_init+0xc0/0xec
[    2.857350]  xhci_gen_setup+0x270/0x348
[    2.861292]  xhci_plat_setup+0x4c/0x58
[    2.865146]  usb_add_hcd+0x288/0x430
[    2.868815]  xhci_plat_probe+0x3f8/0x568
[    2.872844]  platform_drv_probe+0x94/0xb4
[    2.876957]  really_probe+0x138/0x348
[    2.880725]  driver_probe_device+0x80/0xb8
[    2.884936]  __device_attach_driver+0x90/0xa8
[    2.889407]  bus_for_each_drv+0x84/0xcc
[    2.893348]  __device_attach+0xc0/0x148
[    2.897289]  device_initial_probe+0x18/0x20
[    2.901587]  bus_probe_device+0x38/0x94
[    2.905529]  device_add+0x214/0x3c4
[    2.909112]  platform_device_add+0x198/0x208
[    2.913497]  dwc3_host_init+0x228/0x2bc
[    2.917437]  dwc3_core_init_mode+0xfc/0x18c
[    2.921735]  dwc3_probe+0x978/0xac8
[    2.925318]  platform_drv_probe+0x94/0xb4
[    2.929432]  really_probe+0x138/0x348
[    2.933200]  driver_probe_device+0x80/0xb8
[    2.937411]  __device_attach_driver+0x90/0xa8
[    2.941881]  bus_for_each_drv+0x84/0xcc
[    2.945823]  __device_attach+0xc0/0x148
[    2.949765]  device_initial_probe+0x18/0x20
[    2.954064]  bus_probe_device+0x38/0x94
[    2.958005]  device_add+0x214/0x3c4
[    2.961590]  of_device_add+0x3c/0x48
[    2.965260]  of_platform_device_create_pdata+0xac/0xec
[    2.970535]  of_platform_bus_create+0x1cc/0x348
[    2.975191]  of_platform_populate+0x78/0xc8
[    2.979490]  dwc3_qcom_probe+0x4e0/0xa88
[    2.983518]  platform_drv_probe+0x94/0xb4
[    2.987632]  really_probe+0x138/0x348
[    2.991400]  driver_probe_device+0x80/0xb8
[    2.995612]  __device_attach_driver+0x90/0xa8
[    3.000084]  bus_for_each_drv+0x84/0xcc
[    3.004025]  __device_attach+0xc0/0x148
[    3.007966]  device_initial_probe+0x18/0x20
[    3.012264]  bus_probe_device+0x38/0x94
[    3.016206]  deferred_probe_work_func+0x78/0xb0
[    3.020864]  process_one_work+0x210/0x3dc
[    3.024979]  worker_thread+0x284/0x3e0
[    3.028833]  kthread+0x148/0x1a8
[    3.032147]  ret_from_fork+0x10/0x18
[    3.035817] ---[ end trace 9bac18cad6a9862f ]---
[    3.041583] xhci-hcd xhci-hcd.13.auto: can't setup: -12
[    3.046950] xhci-hcd xhci-hcd.13.auto: USB bus 1 deregistered
[    3.053107] xhci-hcd: probe of xhci-hcd.13.auto failed with error -12
[    3.062208] coresight etm0: CPU0: ETM v4.2 initialized
[    3.063345] sdhci_msm 7c4000.sdhci: TCXO clk not present (-2)
[    3.067862] coresight etm1: CPU1: ETM v4.2 initialized
[    3.078829] ------------[ cut here ]------------
[    3.079076] coresight etm2: CPU2: ETM v4.2 initialized
[    3.083587] WARNING: CPU: 5 PID: 7 at drivers/iommu/io-pgtable-arm.c:492 arm_lpae_map_sg+0x234/0x248
[    3.083589] Modules linked in:
[    3.089200] coresight etm3: CPU3: ETM v4.2 initialized
[    3.098235] 
[    3.098241] CPU: 5 PID: 7 Comm: kworker/u16:0 Tainted: G        W         5.10.5 #970
[    3.101722] coresight etm4: CPU4: ETM v4.2 initialized
[    3.106672] Workqueue: events_unbound async_run_entry_fn
[    3.131984] pstate: 20c00009 (nzCv daif +PAN +UAO -TCO BTYPE=--)
[    3.138161] pc : arm_lpae_map_sg+0x234/0x248
[    3.142557] lr : arm_lpae_map_sg+0xe0/0x248
[    3.146864] sp : ffffffc0100c3800
[    3.150272] x29: ffffffc0100c3840 x28: ffffffb942394000 
[    3.155736] x27: 0000000ffffff000 x26: ffffffb944010100 
[    3.161198] x25: 0000000000001000 x24: 0000000102326000 
[    3.166660] x23: 0000000000000001 x22: 0000000102327000 
[    3.172122] x21: 0000000000000003 x20: 0000000000000a20 
[    3.177586] x19: ffffffc0100c3900 x18: 0000000000000001 
[    3.183048] x17: 0000000000000001 x16: 00000000ffffffff 
[    3.188512] x15: 0000000000000000 x14: 0000000000000001 
[    3.193973] x13: 0000000000000001 x12: 0000000000000000 
[    3.199434] x11: 0000001000000000 x10: 0000000000000000 
[    3.204895] x9 : 0000000000000001 x8 : 0000000040201000 
[    3.210356] x7 : 0000000000000000 x6 : ffffffc0100c3900 
[    3.215818] x5 : 0000000000000a20 x4 : 0000000000001000 
[    3.221279] x3 : 0000000000000001 x2 : ffffffb94581a100 
[    3.226741] x1 : 0000000000000003 x0 : 0000000000000e40 
[    3.232203] Call trace:
[    3.234722]  arm_lpae_map_sg+0x234/0x248
[    3.238761]  arm_smmu_map_sg+0x80/0xc4
[    3.242615]  __iommu_map_sg+0x6c/0x188
[    3.246468]  iommu_map_sg_atomic+0x18/0x20
[    3.250680]  iommu_dma_alloc_remap+0x26c/0x34c
[    3.255250]  iommu_dma_alloc+0x9c/0x268
[    3.259204]  dma_alloc_attrs+0x88/0xfc
[    3.263058]  sdhci_setup_host+0x250/0xc8c
[    3.267185]  sdhci_msm_cqe_add_host+0x38/0x188
[    3.271756]  sdhci_msm_probe+0x540/0x628
[    3.275795]  platform_drv_probe+0x94/0xb4
[    3.279921]  really_probe+0x138/0x348
[    3.283687]  driver_probe_device+0x80/0xb8
[    3.287899]  __device_attach_driver+0x90/0xa8
[    3.292381]  bus_for_each_drv+0x84/0xcc
[    3.296332]  __device_attach_async_helper+0x80/0xd4
[    3.301347]  async_run_entry_fn+0x4c/0x100
[    3.305559]  process_one_work+0x210/0x3dc
[    3.309684]  worker_thread+0x234/0x3e0
[    3.313537]  kthread+0x148/0x1a8
[    3.316861]  ret_from_fork+0x10/0x18
[    3.320541] ---[ end trace 9bac18cad6a98630 ]---
[    3.325372] mmc1: Unable to allocate ADMA buffers - falling back to standard DMA
<snip>...
[    3.587535] mmc1: running CQE recovery
[    3.591419] mmc1: Got command interrupt 0x00010001 even though no command operation was in progress.
[    3.600796] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[    3.607417] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00007202
[    3.614038] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000108

Thanks,
Sai

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
