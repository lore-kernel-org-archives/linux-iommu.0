Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BD0C433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 01:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C97D841A0E;
	Wed, 25 May 2022 01:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vhZ_zgcM9RNj; Wed, 25 May 2022 01:40:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 36B6141825;
	Wed, 25 May 2022 01:40:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E6B0C0039;
	Wed, 25 May 2022 01:40:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDFFCC002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 01:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C78E541891
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 01:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QPf-d4_nmYxh for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 01:40:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8184C41825
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 01:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653442832; x=1684978832;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LPMOPnYEgjdhEDNOqttDlYIQit/14dPGn99F51fR4Dk=;
 b=lg1Bik0Tzd42v6t6Q5k19wxvsswkeVPEmbuDLQJrYJ9iWuMhGxNW7pDk
 U7pmvePpeonsMGmcDyXLaBv5pnEQzr7vXKV0Azj8TEs7dyKfRF8Y3yp65
 x76DIVyLzqzt/8EcaKj+Gicw+7IXfVi55c6Upr9QP5aGmu5vOmwg7u8NR
 PELoSmIRmgnbcip7TpzwUbHivpuDs+igYg9uhu5dJVoKLp9KFQvBriGuD
 W8yi72MJudRBDn/R9KjRJmyaVc8Ezdd+kwUWK/aYDQQkvxZNR/tzKFU2L
 3EM1NXFPHF1BJeF4j+FzdoNDEvIRDIDtXhgyMA5BLcXkSjV1Qa0jxsAlh g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273687473"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="273687473"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 18:40:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601594170"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 18:40:29 -0700
Message-ID: <7149e5dd-c72e-538b-b98f-0fbc89580a95@linux.intel.com>
Date: Wed, 25 May 2022 09:40:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
Content-Language: en-US
To: Yian Chen <yian.chen@intel.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Sohil Mehta
 <sohil.mehta@intel.com>, Ravi Shankar <ravi.v.shankar@intel.com>
References: <20220521002115.1624069-1-yian.chen@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220521002115.1624069-1-yian.chen@intel.com>
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

Hi Joerg,

On 2022/5/21 08:21, Yian Chen wrote:
> Notifier calling chain uses priority to determine the execution
> order of the notifiers or listeners registered to the chain.
> PCI bus device hot add utilizes the notification mechanism.
> 
> The current code sets low priority (INT_MIN) to Intel
> dmar_pci_bus_notifier and postpones DMAR decoding after adding
> new device into IOMMU. The result is that struct device pointer
> cannot be found in DRHD search for the new device's DMAR/IOMMU.
> Subsequently, the device is put under the "catch-all" IOMMU
> instead of the correct one. This could cause system hang when
> device TLB invalidation is sent to the wrong IOMMU. Invalidation
> timeout error and hard lockup have been observed and data
> inconsistency/crush may occur as well.
> 
> This patch fixes the issue by setting a positive priority(1) for
> dmar_pci_bus_notifier while the priority of IOMMU bus notifier
> uses the default value(0), therefore DMAR decoding will be in
> advance of DRHD search for a new device to find the correct IOMMU.
> 
> Following is a 2-step example that triggers the bug by simulating
> PCI device hot add behavior in Intel Sapphire Rapids server.
> 
> echo 1 > /sys/bus/pci/devices/0000:6a:01.0/remove
> echo 1 > /sys/bus/pci/rescan
> 
> Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
> Cc: stable@vger.kernel.org # v3.15+
> Reported-by: Zhang, Bernice <bernice.zhang@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> ---
> This is a quick fix for the bug reported. Intel internally evaluated
> another redesigned solution that eliminates dmar pci bus notifier to
> simplify the workflow of pci hotplug and improve its runtime efficiency.
> 
> While considering the fix could apply to downstream and the complexity
> of pci hotplug workflow change may significantly increase the
> engineering effort to downstream the patch, the choice is to submit this
> simple patch to help the deployment of this bug fix.

Yian has been worked on using IOMMU bus notifier to solve this problem.
It turns out that due to the following facts, we need to refactor the 
IOMMU core and Intel DMAR Code:

- Interrupt remapping also requires Intel DMAR code. Therefore, when
   IOMMU is not enabled, the PCI bus notifier in DMAR is still required.
- The IOMMU PCI bus notifier calls .probe_device() which lacks of the
   information about hot-add or static boot.

Considering that the problem described here is a serious problem,
because users can easily damage the system by writing sysfs files on
some platforms, we need a quick fix for both upstream and stable
kernels. The refactoring code will be discussed in a separate series.

How do you like it? If you agree, I can queue it in my next pull request
for fixes.

Best regards,
baolu

> ---
> 
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 4de960834a1b..497c5bd95caf 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -383,7 +383,7 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
>   
>   static struct notifier_block dmar_pci_bus_nb = {
>   	.notifier_call = dmar_pci_bus_notifier,
> -	.priority = INT_MIN,
> +	.priority = 1,
>   };
>   
>   static struct dmar_drhd_unit *

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
