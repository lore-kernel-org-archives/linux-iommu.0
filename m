Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3E3C43334
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 02:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D394640541;
	Tue,  5 Jul 2022 02:58:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D394640541
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kjTas8jb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LROSWNuQ0eLu; Tue,  5 Jul 2022 02:58:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B53C40131;
	Tue,  5 Jul 2022 02:58:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B53C40131
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34D76C0032;
	Tue,  5 Jul 2022 02:58:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2BD9C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 02:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC15360A8C
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 02:58:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC15360A8C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kjTas8jb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5Ok7lVwJFys for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:58:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48522606C0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48522606C0
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 02:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656989929; x=1688525929;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IDbhF7wCQCWGlR+mgr4YPKJMsld6Uv/Sy7LrfLbGeWc=;
 b=kjTas8jbtlzDJBMJNfzaYBsd35JeHSVGJ2O4ISIG0XsOAV1ZpifU02U8
 gfBkktU78vA70uPNj5B8YZXC04rUmGIhnTs8xblkFsoC3bUT2HFBquN1h
 FjTk/HES374Mumzah0oXBxed+C1apwKTwUxoWiFdK7QYEWvtE1Q0Qm2nj
 0ocyAY+YOL6LkFR5N0oqdh82xBwrigKqrUXgtp+uafpddfERgZ/a5ywIa
 OB+30RKLVs7LOuIdUdwjxcIZwCdzhcLmydK0HzJirefhXC1f2A8AUNNAd
 xhA5OMrtaRYavH+jZS09F5/suHDK048X0Dv589md8lmXG+nqybR2ZwEgy w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="347214635"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; d="scan'208";a="347214635"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2022 19:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; d="scan'208";a="597146062"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 04 Jul 2022 19:58:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o8Ylv-000Idm-Jw;
 Tue, 05 Jul 2022 02:58:43 +0000
Date: Tue, 5 Jul 2022 10:57:57 +0800
From: kernel test robot <lkp@intel.com>
To: Mikko Perttunen <cyndis@kapsi.fi>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Subject: Re: [PATCH v6 04/10] gpu: host1x: Add context device management code
Message-ID: <202207051045.JWeVR4tW-lkp@intel.com>
References: <20220621151022.1416300-5-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220621151022.1416300-5-cyndis@kapsi.fi>
Cc: devicetree@vger.kernel.org, kbuild-all@lists.01.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Hi Mikko,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on tegra/for-next linus/master v5.19-rc5]
[cannot apply to tegra-drm/drm/tegra/for-next next-20220704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikko-Perttunen/Host1x-context-isolation-support/20220621-231339
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: arm-randconfig-r005-20220703 (https://download.01.org/0day-ci/archive/20220705/202207051045.JWeVR4tW-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2501beeae7469b805f9f624049fd56643cf6e18e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mikko-Perttunen/Host1x-context-isolation-support/20220621-231339
        git checkout 2501beeae7469b805f9f624049fd56643cf6e18e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/host1x/context.c: In function 'host1x_memory_context_list_init':
>> drivers/gpu/host1x/context.c:80:40: error: 'struct iommu_fwspec' has no member named 'ids'
      80 |                 ctx->stream_id = fwspec->ids[0] & 0xffff;
         |                                        ^~


vim +80 drivers/gpu/host1x/context.c

    15	
    16	int host1x_memory_context_list_init(struct host1x *host1x)
    17	{
    18		struct host1x_memory_context_list *cdl = &host1x->context_list;
    19		struct device_node *node = host1x->dev->of_node;
    20		struct host1x_memory_context *ctx;
    21		unsigned int i;
    22		int err;
    23	
    24		cdl->devs = NULL;
    25		cdl->len = 0;
    26		mutex_init(&cdl->lock);
    27	
    28		err = of_property_count_u32_elems(node, "iommu-map");
    29		if (err < 0)
    30			return 0;
    31	
    32		cdl->devs = kcalloc(err, sizeof(*cdl->devs), GFP_KERNEL);
    33		if (!cdl->devs)
    34			return -ENOMEM;
    35		cdl->len = err / 4;
    36	
    37		for (i = 0; i < cdl->len; i++) {
    38			struct iommu_fwspec *fwspec;
    39	
    40			ctx = &cdl->devs[i];
    41	
    42			ctx->host = host1x;
    43	
    44			device_initialize(&ctx->dev);
    45	
    46			/*
    47			 * Due to an issue with T194 NVENC, only 38 bits can be used.
    48			 * Anyway, 256GiB of IOVA ought to be enough for anyone.
    49			 */
    50			ctx->dma_mask = DMA_BIT_MASK(38);
    51			ctx->dev.dma_mask = &ctx->dma_mask;
    52			ctx->dev.coherent_dma_mask = ctx->dma_mask;
    53			dev_set_name(&ctx->dev, "host1x-ctx.%d", i);
    54			ctx->dev.bus = &host1x_context_device_bus_type;
    55			ctx->dev.parent = host1x->dev;
    56	
    57			dma_set_max_seg_size(&ctx->dev, UINT_MAX);
    58	
    59			err = device_add(&ctx->dev);
    60			if (err) {
    61				dev_err(host1x->dev, "could not add context device %d: %d\n", i, err);
    62				goto del_devices;
    63			}
    64	
    65			err = of_dma_configure_id(&ctx->dev, node, true, &i);
    66			if (err) {
    67				dev_err(host1x->dev, "IOMMU configuration failed for context device %d: %d\n",
    68					i, err);
    69				device_del(&ctx->dev);
    70				goto del_devices;
    71			}
    72	
    73			fwspec = dev_iommu_fwspec_get(&ctx->dev);
    74			if (!fwspec) {
    75				dev_err(host1x->dev, "Context device %d has no IOMMU!\n", i);
    76				device_del(&ctx->dev);
    77				goto del_devices;
    78			}
    79	
  > 80			ctx->stream_id = fwspec->ids[0] & 0xffff;
    81		}
    82	
    83		return 0;
    84	
    85	del_devices:
    86		while (i--)
    87			device_del(&cdl->devs[i].dev);
    88	
    89		kfree(cdl->devs);
    90		cdl->len = 0;
    91	
    92		return err;
    93	}
    94	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
