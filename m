Return-Path: <SRS0=ipMx=7T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA4EC433DF
	for <iommu@archiver.kernel.org>; Sat,  6 Jun 2020 03:47:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E741D20656
	for <iommu@archiver.kernel.org>; Sat,  6 Jun 2020 03:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E741D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B2D6A87215;
	Sat,  6 Jun 2020 03:47:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jr05kCTn37T0; Sat,  6 Jun 2020 03:47:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A2CB87201;
	Sat,  6 Jun 2020 03:47:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DC3BC0888;
	Sat,  6 Jun 2020 03:47:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35AEAC016E
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 03:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2A55887215
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 03:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5nNno1r62BIJ for <iommu@lists.linux-foundation.org>;
 Sat,  6 Jun 2020 03:47:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1A22387201
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 03:47:46 +0000 (UTC)
IronPort-SDR: /+rwhPBFYeJSFYZlkSvLRhOX0NvUzInoxfDQ6wr/4ntyrxOSKa1e/ole0rmSYt6pTC0mkJrxrZ
 Ln+sfRY+6pfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 20:47:45 -0700
IronPort-SDR: doFUxYktMjT+9Frop2VWFJ+ZWLisjHACPXrUod+jj8Xgaxgn+uxK0KBDx7WxpnM44pJGmFiBTX
 CUa8FImuX1pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; d="scan'208";a="287935558"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
 by orsmga002.jf.intel.com with ESMTP; 05 Jun 2020 20:47:41 -0700
Date: Sat, 6 Jun 2020 11:46:55 +0800
From: Philip Li <philip.li@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [kbuild-all] Re: [PATCH 1/3] dma-direct: provide the ability to
 reserve per-numa CMA
Message-ID: <20200606034655.GH2459@intel.com>
References: <20200603024231.61748-2-song.bao.hua@hisilicon.com>
 <20200604113631.GP30374@kadam>
 <B926444035E5E2439431908E3842AFD24E0011@DGGEMI525-MBS.china.huawei.com>
 <20200605085751.GQ30374@kadam>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200605085751.GQ30374@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Dan Carpenter <error27@gmail.com>, "lkp@intel.com" <lkp@intel.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "kbuild@lists.01.org" <kbuild@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Fri, Jun 05, 2020 at 11:57:51AM +0300, Dan Carpenter wrote:
> On Fri, Jun 05, 2020 at 06:04:31AM +0000, Song Bao Hua (Barry Song) wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > > Sent: Thursday, June 4, 2020 11:37 PM
> > > To: kbuild@lists.01.org; Song Bao Hua (Barry Song)
> > > <song.bao.hua@hisilicon.com>; hch@lst.de; m.szyprowski@samsung.com;
> > > robin.murphy@arm.com; catalin.marinas@arm.com
> > > Cc: lkp@intel.com; Dan Carpenter <error27@gmail.com>;
> > > kbuild-all@lists.01.org; iommu@lists.linux-foundation.org;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linuxarm
> > > <linuxarm@huawei.com>; Jonathan Cameron
> > > <jonathan.cameron@huawei.com>; John Garry <john.garry@huawei.com>
> > > Subject: Re: [PATCH 1/3] dma-direct: provide the ability to reserve per-numa
> > > CMA
> > > 
> > > Hi Barry,
> > > 
> > > url:
> > > https://github.com/0day-ci/linux/commits/Barry-Song/support-per-numa-CM
> > > A-for-ARM-server/20200603-104821
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> > > for-next/core
> > > config: x86_64-randconfig-m001-20200603 (attached as .config)
> > > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > Dan, thanks! Good catch!
> > as this patch has not been in mainline yet, is it correct to add these "reported-by" in patch v2?
Hi Barry, we provides the suggestion here, but you may decide
to add or not as appropriate for your situation. For the
patch still under development, it is not that necessary to add i think.

> 
> These are just an automated email from the zero day bot.  I look over
> the Smatch warnings and then forward them on.
> 
> regards,
> dan carpenter
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
