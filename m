Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2EAC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 04:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93FFD41BDE;
	Thu, 23 Jun 2022 04:32:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93FFD41BDE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GRdlZ1t6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BRh1qmHXA0_i; Thu, 23 Jun 2022 04:32:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ECE4941B90;
	Thu, 23 Jun 2022 04:32:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECE4941B90
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB9A7C0032;
	Thu, 23 Jun 2022 04:32:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C60EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 04:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CFBE41BD6
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 04:32:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CFBE41BD6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RPJjhmcYneCu for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 04:32:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF2D041B90
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF2D041B90
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 04:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655958737; x=1687494737;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Xf1ZndHIWN0yF2ATkspzO18eIZTG7iZNontCpxDrQsk=;
 b=GRdlZ1t6W9NP/n28RwgSsYrj8bRhV8bh78bMxICF0QMXiPMosck8tZjT
 FccZZ+Lq0BuxPFUR77793oh9Lbg94/HDALXDM9B2SHFeEz+rbernlVjTy
 BsDFci92/hF0KE7WHrqtPGxPZ4oQcwiERRgEiaYUMm8BWjz/r01jtTiTd
 H9DmC1nsPMTtnQBo+m9TVtooAXbLb8zp1lBwQ4XNW6K5OaxlVyDsKtCSw
 AVbd6A533/BdY4RBnkiIr+tlkdFm9ebcHc5YFtrNBmp+iJ0EfbkHkZnId
 PNG0PdTHxJ601SoA+V7/l/hsGg9pSjOFtyzMojh1bdix1VcB+YniChqJb Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281698430"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="281698430"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 21:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="538746728"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 22 Jun 2022 21:32:14 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o4EVp-0000hJ-Pi;
 Thu, 23 Jun 2022 04:32:13 +0000
Date: Thu, 23 Jun 2022 12:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <202206231208.PGASmlUW-lkp@intel.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
Cc: kbuild-all@lists.01.org, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, jgg@nvidia.com
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

Hi Robin,

I love your patch! Yet something to improve:

[auto build test ERROR on v5.19-rc3]
[also build test ERROR on linus/master next-20220622]
[cannot apply to awilliam-vfio/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/vfio-type1-Simplify-bus_type-determination/20220622-200503
base:    a111daf0c53ae91e71fd2bfe7497862d14132e3e
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220623/202206231208.PGASmlUW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7a6e1ddc765bde40f879995137a2ff20cb0eda47
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Robin-Murphy/vfio-type1-Simplify-bus_type-determination/20220622-200503
        git checkout 7a6e1ddc765bde40f879995137a2ff20cb0eda47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vfio_device_get_from_iommu" [drivers/vfio/vfio_iommu_type1.ko] undefined!
>> ERROR: modpost: "vfio_device_put" [drivers/vfio/vfio_iommu_type1.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
