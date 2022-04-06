Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FA9C433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 21:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DC6961165;
	Wed,  6 Apr 2022 21:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L7mRHEMuBlaD; Wed,  6 Apr 2022 21:39:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC1336074C;
	Wed,  6 Apr 2022 21:39:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF076C001D;
	Wed,  6 Apr 2022 21:39:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E18C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 21:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17E4C41879
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 21:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Lb4UE8DnCAh for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 21:39:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A58D4158B
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 21:39:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C0212FC;
 Wed,  6 Apr 2022 14:39:54 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50ABB3F718;
 Wed,  6 Apr 2022 14:39:53 -0700 (PDT)
Message-ID: <87075d61-c51c-8d94-9263-17aa40f7d70e@arm.com>
Date: Wed, 6 Apr 2022 22:39:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] RDMA/usnic: Refactor usnic_uiom_alloc_pd()
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, benve@cisco.com, neescoba@cisco.com,
 jgg@ziepe.ca
References: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
 <202204070316.vOzwORw5-lkp@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <202204070316.vOzwORw5-lkp@intel.com>
Cc: linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
 kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
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

On 2022-04-06 20:54, kernel test robot wrote:
> Hi Robin,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on rdma/for-next]
> [also build test ERROR on v5.18-rc1 next-20220406]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

Oops, I failed to notice that this does actually depend on the other 
patch I sent cleaning up iommu_present()[1] - I should have sent them 
together as a series, sorry about that.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/f707b4248e1d33b6d2c7f1d7c94febb802cf9890.1649161199.git.robin.murphy@arm.com/
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/RDMA-usnic-Refactor-usnic_uiom_alloc_pd/20220406-133657
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220407/202204070316.vOzwORw5-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
> reproduce (this is a W=1 build):
>          # https://github.com/intel-lab-lkp/linux/commit/0aa6215010a083081b26ccb23d0aa2b4089bbbfd
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Robin-Murphy/RDMA-usnic-Refactor-usnic_uiom_alloc_pd/20220406-133657
>          git checkout 0aa6215010a083081b26ccb23d0aa2b4089bbbfd
>          # save the config file to linux build tree
>          mkdir build_dir
>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/infiniband/hw/usnic/usnic_uiom.c: In function 'usnic_uiom_init':
>>> drivers/infiniband/hw/usnic/usnic_uiom.c:561:29: error: 'pci_bus_type' undeclared (first use in this function); did you mean 'bus_type'?
>       561 |         if (!iommu_present(&pci_bus_type)) {
>           |                             ^~~~~~~~~~~~
>           |                             bus_type
>     drivers/infiniband/hw/usnic/usnic_uiom.c:561:29: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> vim +561 drivers/infiniband/hw/usnic/usnic_uiom.c
> 
> e3cf00d0a87f02 Upinder Malhi 2013-09-10  558
> e3cf00d0a87f02 Upinder Malhi 2013-09-10  559  int usnic_uiom_init(char *drv_name)
> e3cf00d0a87f02 Upinder Malhi 2013-09-10  560  {
> e3cf00d0a87f02 Upinder Malhi 2013-09-10 @561  	if (!iommu_present(&pci_bus_type)) {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
