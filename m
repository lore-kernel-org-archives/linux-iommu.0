Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63097C43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 00:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7D6384798;
	Fri, 24 Jun 2022 00:55:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7D6384798
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=faI+eiHJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ha9MUjndLekc; Fri, 24 Jun 2022 00:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C35CD84795;
	Fri, 24 Jun 2022 00:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C35CD84795
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FDBDC0032;
	Fri, 24 Jun 2022 00:55:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CEA1C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 00:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5311E60BE1
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 00:55:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5311E60BE1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=faI+eiHJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6Wbv1v6qPRg for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 00:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF7DD60BB1
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF7DD60BB1
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 00:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656032112; x=1687568112;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PA8xe1s8KSwd8s5ArY8C3K1kz59dLQKimlFAN3yCtl4=;
 b=faI+eiHJhHXKZ28aSM1jFSbn1k3AIgK7s4/JNIIYE418/ubNT7TIWvO+
 QFfAZ+0MhbUGYWWP3gDqj9f010dlDhnOaXwpNrW0e7WIUeDYIuBSZQqm9
 yys8LwUWT66+3MzOMxKelu5IzycSidcuuE0fRlNgrOON7Gitru4IXqK6n
 DQIsOCmNEDlrPI8rJ4ws4GB62G0PEeB4TI+f0sAub1j5rmjVvS2kNm15j
 m78GVtNQ49MLi/MLeTAgOs//YsDDWOw1P8Dbylxg5rUHNIwk/DCZ51mA7
 csbqVWUS8glzJCGfe7yMQ9rTemp37e855OZmVij5/tEh0709wEB8FIQ4t w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="281966976"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; d="scan'208";a="281966976"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 17:55:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; d="scan'208";a="645023733"
Received: from wenli3x-mobl.ccr.corp.intel.com (HELO [10.249.168.117])
 ([10.249.168.117])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 17:55:09 -0700
Message-ID: <6639b21c-1544-a025-4da5-219a1608f06e@linux.intel.com>
Date: Fri, 24 Jun 2022 08:55:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: iommu_sva_bind_device question
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org, 
 Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
References: <20220623170232.6whonfjuh3m5vcoy@cantor>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220623170232.6whonfjuh3m5vcoy@cantor>
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

On 2022/6/24 01:02, Jerry Snitselaar wrote:
> Hi Baolu & Dave,
> 
> I noticed last night that on a Sapphire Rapids system if you boot without
> intel_iommu=on, the idxd driver will crash during probe in iommu_sva_bind_device().
> Should there be a sanity check before calling dev_iommu_ops(), or is the expectation
> that the caller would verify it is safe to call? This seemed to be uncovered by
> the combination of 3f6634d997db ("iommu: Use right way to retrieve iommu_ops"), and
> 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling").
> 
> [   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038
> [   21.445108] #PF: supervisor read access in kernel mode
> [   21.450912] #PF: error_code(0x0000) - not-present page
> [   21.456706] PGD 0
> [   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
> [   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
> [   21.464015] Workqueue: events work_for_cpu_fn
> [   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0
> [   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00
> [   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296
> [   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000
> [   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0
> [   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4
> [   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000
> [   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000
> [   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000
> [   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0
> [   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [   21.464078] PKRU: 55555554
> [   21.464079] Call Trace:
> [   21.464083]  <TASK>
> [   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd]
> [   21.464121]  local_pci_probe+0x3e/0x80
> [   21.464132]  work_for_cpu_fn+0x13/0x20
> [   21.464136]  process_one_work+0x1c4/0x380
> [   21.464143]  worker_thread+0x1ab/0x380
> [   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50
> [   21.464158]  ? process_one_work+0x380/0x380
> [   21.464161]  kthread+0xe6/0x110
> [   21.464168]  ? kthread_complete_and_exit+0x20/0x20
> [   21.464172]  ret_from_fork+0x1f/0x30
> 
> I figure either there needs to be a check in iommu_sva_bind_device, or
> idxd needs to check in idxd_enable_system_pasid that that
> idxd->pdev->dev.iommu is not null before it tries calling iommu_sva_bind_device.

As documented around the iommu_sva_bind_device() interface:

  * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called 
first, to
  * initialize the required SVA features.

idxd->pdev->dev.iommu should be checked in there.

Dave, any thoughts?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
