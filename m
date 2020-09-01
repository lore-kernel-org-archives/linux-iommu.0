Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7035EC433E7
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 02:07:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C2A208DB
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 02:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2A208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10ABC86882;
	Tue,  1 Sep 2020 02:07:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkluwNvMXJdK; Tue,  1 Sep 2020 02:07:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 72A1A86886;
	Tue,  1 Sep 2020 02:07:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B5F6C0052;
	Tue,  1 Sep 2020 02:07:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 607AFC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 02:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 44735850E6
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 02:07:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wlv0a9Z0y3cI for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 02:07:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5EA82845D7
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 02:07:54 +0000 (UTC)
IronPort-SDR: 3mHs5YjMQ1wNTWJlCai0Aion/79T/ZKpc8ndvwhmDyH8ZrFBvbG+kXjUqg4mQSQLST6sOvrD6p
 OWDyViv5JouQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144836767"
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; d="scan'208";a="144836767"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 19:07:52 -0700
IronPort-SDR: hxS9IMOFjtGq6/GaatetSwyE2Z8r4iWVafiEH/XBLCpIOZTnTa/ZOyk+dZYqgD13+JQ9RZqyBj
 Q1/9mwwdW7Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; d="scan'208";a="325155986"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 19:07:51 -0700
Subject: Re: [Regression] [PATCH] iommu: Avoid crash in
 init_no_remapping_devices if iommu is NULL
To: Torsten Hilbrich <torsten.hilbrich@secunet.com>,
 Joerg Roedel <jroedel@suse.de>
References: <e27cd096-a721-db9d-e4ce-7a432ed6cd4c@secunet.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <12935d0b-61ff-d274-b1ee-3b1fba36bdc7@linux.intel.com>
Date: Tue, 1 Sep 2020 10:02:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e27cd096-a721-db9d-e4ce-7a432ed6cd4c@secunet.com>
Content-Language: en-US
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

Hi Torsten,

Thank you for reporting this.

On 8/31/20 7:03 PM, Torsten Hilbrich wrote:
> I noticed a kernel crash when trying to boot a v5.9-rc2 based kernel.
> 
> The crash reads as:
> 
> <1>[    7.410192] BUG: kernel NULL pointer dereference, address: 0000000000000038
> <1>[    7.410196] #PF: supervisor write access in kernel mode
> <1>[    7.410199] #PF: error_code(0x0002) - not-present page
> <6>[    7.410202] PGD 0 P4D 0
> <4>[    7.410207] Oops: 0002 [#1] SMP PTI
> <4>[    7.410212] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.9.0-devel+ #1
> <4>[    7.410215] Hardware name: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N1WET46S (1.25s ) 03/30/2018
> <4>[    7.410224] RIP: 0010:intel_iommu_init+0xed0/0x1136
> <4>[    7.410229] Code: fe e9 61 02 00 00 bb f4 ff ff ff e9 57 02 00 00 48 63 d1 48 c1 e2 04 48 03 50 20 48 8b 12 48 85 d2 74 0b 48 8b 92 d0 02 00 00 <48> 89 7a 38 ff c1 e9 15 f5 ff ff 48 c7 c7 00 a5 ac a1 49 c7 c7 20
> <4>[    7.410236] RSP: 0000:ffffb14e40073dd0 EFLAGS: 00010282
> <4>[    7.410240] RAX: ffff8d0643731720 RBX: 0000000000000000 RCX: 0000000000000000
> <4>[    7.410244] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffffffffff
> <4>[    7.410247] RBP: ffffb14e40073e90 R08: 0000000000000001 R09: ffff8d0643803700
> <4>[    7.410250] R10: ffff8d0642620000 R11: 0000000000000016 R12: 000000000000000b
> <4>[    7.410254] R13: ffff8d064361e650 R14: ffffffffa2455d80 R15: 0000000000000000
> <4>[    7.410258] FS:  0000000000000000(0000) GS:ffff8d0647480000(0000) knlGS:0000000000000000
> <4>[    7.410262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[    7.410266] CR2: 0000000000000038 CR3: 000000056760a001 CR4: 00000000003706e0
> <4>[    7.410269] Call Trace:
> <4>[    7.410280]  ? call_rcu+0x10e/0x320
> <4>[    7.410286]  ? trace_hardirqs_on+0x2c/0xd0
> <4>[    7.410291]  ? rdinit_setup+0x2c/0x2c
> <4>[    7.410297]  ? e820__memblock_setup+0x8b/0x8b
> <4>[    7.410302]  pci_iommu_init+0x16/0x3f
> <4>[    7.410307]  do_one_initcall+0x46/0x1e4
> <4>[    7.410313]  kernel_init_freeable+0x169/0x1b2
> <4>[    7.410320]  ? rest_init+0x9f/0x9f
> <4>[    7.410325]  kernel_init+0xa/0x101
> <4>[    7.410329]  ret_from_fork+0x22/0x30
> <4>[    7.410333] Modules linked in:
> <4>[    7.410338] CR2: 0000000000000038
> <4>[    7.410344] ---[ end trace 16bcdb1e11668fcd ]---
> 
> Full kernel message is attached in kernel.log.
> 
> I tracked the problem down to the dev_iommu_priv_set call in init_no_remapping_devices. It seems that for one device the dev->iommu member is NULL.
> 
> An dev_err outputs the device as "pci 0000:00:02.0: DMAR" which is the intel HD 620 graphic adapter in a Lenovo T470s device.
> 
> The following patch (also attached as intel-iommu.patch) avoids this crash by checking the pointer.
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f8177c59d229..2d285a42db3f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4053,7 +4053,8 @@ static void __init init_no_remapping_devices(void)
>                          drhd->ignored = 1;
>                          for_each_active_dev_scope(drhd->devices,
>                                                    drhd->devices_cnt, i, dev)
> -                               dev_iommu_priv_set(dev, DUMMY_DEVICE_DOMAIN_INFO);
> +                               if (dev->iommu)
> +                                       dev_iommu_priv_set(dev, DUMMY_DEVICE_DOMAIN_INFO);

This looks more like a generic issue, used-before-allocated, and should
be fixed in iommu.c instead of VT-d driver. How about

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8fd93a5b8764..a599da87eb60 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -190,6 +190,28 @@ static void dev_iommu_free(struct device *dev)
         dev->iommu = NULL;
  }

+void *dev_iommu_priv_get(struct device *dev)
+{
+       struct dev_iommu *param = dev_iommu_get(dev);
+
+       if (WARN_ON(!param))
+               return ERR_PTR(-ENOMEM);
+
+        return param->priv;
+}
+EXPORT_SYMBOL_GPL(dev_iommu_priv_get);
+
+void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+       struct dev_iommu *param = dev_iommu_get(dev);
+
+       if (WARN_ON(!param))
+               return;
+
+        param->priv = priv;
+}
+EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
+

Best regards,
baolu

>                  }
>          }
>   }
> 
> I assume the problem might be related to the following commit introduced in v5.9-rc1:
> 
> commit 01b9d4e21148c89fdbab3d6b3705f9791314b631
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Thu Jun 25 15:08:25 2020 +0200
> 
>      iommu/vt-d: Use dev_iommu_priv_get/set()
>      
>      Remove the use of dev->archdata.iommu and use the private per-device
>      pointer provided by IOMMU core code instead.
> 
> With regards,
> 
> 	Torsten Hilbrich
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
