Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889BAC433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 20:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1884C418EB;
	Mon, 20 Jun 2022 20:19:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1884C418EB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L2uW6kf7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qVOL1vGDqgH8; Mon, 20 Jun 2022 20:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 83F26418EC;
	Mon, 20 Jun 2022 20:19:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83F26418EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4C5C0032;
	Mon, 20 Jun 2022 20:19:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD03FC002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 20:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6714418EB
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 20:19:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6714418EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FVC0nmx_qenS for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 20:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FE87418EC
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FE87418EC
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655756341; x=1687292341;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QUGWdwtiY/barQJg8YWgoUlcx2pD9S6eocsUfc3YoZs=;
 b=L2uW6kf7X2J6a5y0W+D3VqiL2MSoOEvTxuMPHvS9nBg2pIaPo+MOoY2m
 0nxIIkdY5EUaOpGT+ZQ3IPgt0deUGbFrbuJqeFT2CCtF7WK5YD9cM3RUD
 0i9ylt+By6RazwCeNUih/my3tAUBduPK1426gLzRq7ZWhAApzBHRZQ3DO
 cEbNoju2v9VMk+BN7SI5ZOlwjDEbUUYX1tSxv9lXKoiCYSQxsAhNLAadh
 HC1ImpmW6+zDz3eH6RMNH/WQ188QT/4VTY+redMcTBJneTcWV75IusPHY
 qS5iFxOqvTNyNFFmdq7AiA5Y9j1ZyO2sTeTq2xZuOng7jwiZn68dtZUCr Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280699304"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; d="scan'208";a="280699304"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 13:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; d="scan'208";a="714728052"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2022 13:18:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o3NrN-000Vwx-2R;
 Mon, 20 Jun 2022 20:18:57 +0000
Date: Tue, 21 Jun 2022 04:18:19 +0800
From: kernel test robot <lkp@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] uacce: Tidy up locking
Message-ID: <202206210432.WVkOxVu5-lkp@intel.com>
References: <YrB1D9rv9G4h/BYU@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YrB1D9rv9G4h/BYU@myrica>
Cc: Yang Shen <shenyang39@huawei.com>, kbuild-all@lists.01.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org
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

Hi Jean-Philippe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on soc/for-next linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Philippe-Brucker/uacce-Tidy-up-locking/20220620-220634
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220621/202206210432.WVkOxVu5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/intel-lab-lkp/linux/commit/3589b5391f54bea3dc85ed65fe0f036757a4f21c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jean-Philippe-Brucker/uacce-Tidy-up-locking/20220620-220634
        git checkout 3589b5391f54bea3dc85ed65fe0f036757a4f21c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/uacce/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/uacce/uacce.c:291:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted __poll_t @@
   drivers/misc/uacce/uacce.c:291:21: sparse:     expected int ret
   drivers/misc/uacce/uacce.c:291:21: sparse:     got restricted __poll_t
>> drivers/misc/uacce/uacce.c:295:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int ret @@
   drivers/misc/uacce/uacce.c:295:16: sparse:     expected restricted __poll_t
   drivers/misc/uacce/uacce.c:295:16: sparse:     got int ret

vim +291 drivers/misc/uacce/uacce.c

   277	
   278	static __poll_t uacce_fops_poll(struct file *file, poll_table *wait)
   279	{
   280		struct uacce_queue *q = file->private_data;
   281		struct uacce_device *uacce = q->uacce;
   282		int ret = 0;
   283	
   284		poll_wait(file, &q->wait, wait);
   285	
   286		mutex_lock(&q->mutex);
   287		if (!uacce_queue_is_valid(q))
   288			goto out_unlock;
   289	
   290		if (uacce->ops->is_q_updated && uacce->ops->is_q_updated(q))
 > 291			ret = EPOLLIN | EPOLLRDNORM;
   292	
   293	out_unlock:
   294		mutex_unlock(&q->mutex);
 > 295		return ret;
   296	}
   297	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
