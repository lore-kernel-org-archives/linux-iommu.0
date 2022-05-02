Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B97C433EF
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 09:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 470B082BF4;
	Mon,  2 May 2022 09:14:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKinh9IAojdn; Mon,  2 May 2022 09:14:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F0BA182C3E;
	Mon,  2 May 2022 09:14:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6B77C0032;
	Mon,  2 May 2022 09:14:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86A3DC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 09:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D75E409BE
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 09:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVncWOevHIpz for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 09:14:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68DE5409B3
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 09:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651482874; x=1683018874;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mrdpF69sgCUgjY0iIsOoVsoDaXbqkIBauMYAKitutdM=;
 b=OM6UTQs52dUaUvYGy2sXe1YCDDUrFLztsI9NufDWccN7e2SqZHnjem8A
 7VhT+LEXrHN3OUw8lw4wuYsoFwUksSpniI9C+++j44e1ZWCJ4e+G/M98G
 Y+wYNe9K8J4kPG9BQrRWrlwqbxLau3/CkDF2MZi/zNU2+tViuL3u8RKDk
 OIKgg/BJ4cuQ7eXvgCFUBQJkXH0aEaUskG2iHwdz1JBrxbXBTpGyxqSbF
 4nXqXxsI5zpBb+m7+8WnYqVXShl88p/eWeZZKu4bxLEnQPdGnDr29kf0D
 eQRFAqgEJfA0IP7s07Uuxy8iGNsK4MYycWEpjXtOyy3otP7Z1oDhL/sjn A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="254612487"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; d="scan'208";a="254612487"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2022 02:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; d="scan'208";a="886465610"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 02 May 2022 02:14:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nlS8T-0009RP-5Y;
 Mon, 02 May 2022 09:14:29 +0000
Date: Mon, 2 May 2022 17:13:53 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaomeng Tong <xiam0nd.tong@gmail.com>, agross@kernel.org,
 bjorn.andersson@linaro.org, joro@8bytes.org, will@kernel.org,
 sricharan@codeaurora.org
Subject: Re: [PATCH v2] iommu: fix an incorrect NULL check on list iterator
Message-ID: <202205021754.GETHfNnS-lkp@intel.com>
References: <20220501131259.11529-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220501131259.11529-1-xiam0nd.tong@gmail.com>
Cc: kbuild-all@lists.01.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Xiaomeng Tong <xiam0nd.tong@gmail.com>
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

Hi Xiaomeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on v5.18-rc5 next-20220429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaomeng-Tong/iommu-fix-an-incorrect-NULL-check-on-list-iterator/20220501-211400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220502/202205021754.GETHfNnS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/99e334beef5d5be25ed19d3142d16000f0a1986d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiaomeng-Tong/iommu-fix-an-incorrect-NULL-check-on-list-iterator/20220501-211400
        git checkout 99e334beef5d5be25ed19d3142d16000f0a1986d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/msm_iommu.c: In function 'qcom_iommu_of_xlate':
>> drivers/iommu/msm_iommu.c:629:17: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     629 |                 ret = -ENODEV;
         |                 ^~~
         |                 net
   drivers/iommu/msm_iommu.c:629:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iommu/msm_iommu.c:638:1: error: control reaches end of non-void function [-Werror=return-type]
     638 | }
         | ^
   cc1: some warnings being treated as errors


vim +629 drivers/iommu/msm_iommu.c

f78ebca8ff3d61 Sricharan R   2016-06-13  614  
f78ebca8ff3d61 Sricharan R   2016-06-13  615  static int qcom_iommu_of_xlate(struct device *dev,
f78ebca8ff3d61 Sricharan R   2016-06-13  616  			       struct of_phandle_args *spec)
f78ebca8ff3d61 Sricharan R   2016-06-13  617  {
99e334beef5d5b Xiaomeng Tong 2022-05-01  618  	struct msm_iommu_dev *iommu = NULL, *iter;
f78ebca8ff3d61 Sricharan R   2016-06-13  619  	unsigned long flags;
f78ebca8ff3d61 Sricharan R   2016-06-13  620  
f78ebca8ff3d61 Sricharan R   2016-06-13  621  	spin_lock_irqsave(&msm_iommu_lock, flags);
99e334beef5d5b Xiaomeng Tong 2022-05-01  622  	list_for_each_entry(iter, &qcom_iommu_devices, dev_node)
99e334beef5d5b Xiaomeng Tong 2022-05-01  623  		if (iter->dev->of_node == spec->np) {
99e334beef5d5b Xiaomeng Tong 2022-05-01  624  			iommu = iter;
f78ebca8ff3d61 Sricharan R   2016-06-13  625  			break;
99e334beef5d5b Xiaomeng Tong 2022-05-01  626  		}
f78ebca8ff3d61 Sricharan R   2016-06-13  627  
99e334beef5d5b Xiaomeng Tong 2022-05-01  628  	if (!iommu) {
f78ebca8ff3d61 Sricharan R   2016-06-13 @629  		ret = -ENODEV;
f78ebca8ff3d61 Sricharan R   2016-06-13  630  		goto fail;
f78ebca8ff3d61 Sricharan R   2016-06-13  631  	}
f78ebca8ff3d61 Sricharan R   2016-06-13  632  
bb5bdc5ab7f133 Xiaoke Wang   2022-04-28  633  	ret = insert_iommu_master(dev, &iommu, spec);
f78ebca8ff3d61 Sricharan R   2016-06-13  634  fail:
f78ebca8ff3d61 Sricharan R   2016-06-13  635  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
f78ebca8ff3d61 Sricharan R   2016-06-13  636  
f78ebca8ff3d61 Sricharan R   2016-06-13  637  	return ret;
f78ebca8ff3d61 Sricharan R   2016-06-13  638  }
f78ebca8ff3d61 Sricharan R   2016-06-13  639  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
