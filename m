Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45399C2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 23:08:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8D423A5A
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 23:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="esDNOvaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8D423A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 52FA2870CD;
	Mon, 28 Sep 2020 23:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 91Wu3NzNG1ae; Mon, 28 Sep 2020 23:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A5220870C7;
	Mon, 28 Sep 2020 23:08:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7627BC0891;
	Mon, 28 Sep 2020 23:08:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A97E1C016F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 23:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 90378870C9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 23:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QdQ+iRULIcK2 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 23:08:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E997B870C7
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 23:08:42 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4447D23A58;
 Mon, 28 Sep 2020 23:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601334522;
 bh=yx7Kl0l4LL/Tx5VWW4V3Yshm8iNUcgJJrDqsEi+/CI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=esDNOvaQBOKfLSsr97k+I5mnTJEnZaivBEIgHvM19pd79mkh8+Th6XPwP9Dg7Nu8F
 n1JK1azkKbq5XAjhQvWuh8gZeIXNRzYUR0SLDbng3W2pSqMX5+frAs9Kre/PSATOTQ
 1mB7qdIrAZLVKO/Jx9zpQxnEd4tPpiq3CWHfS3ps=
Date: Tue, 29 Sep 2020 00:08:35 +0100
From: Will Deacon <will@kernel.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommu/qcom: add missing put_device() call in
 qcom_iommu_of_xlate()
Message-ID: <20200928230835.GA12939@willie-the-truck>
References: <20200918011357.909335-1-yukuai3@huawei.com>
 <202009220340.bJfsaeQn%lkp@intel.com>
 <20200921204556.GB3811@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921204556.GB3811@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, yi.zhang@huawei.com, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com, Yu Kuai <yukuai3@huawei.com>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Sep 21, 2020 at 09:45:57PM +0100, Will Deacon wrote:
> On Tue, Sep 22, 2020 at 03:13:53AM +0800, kernel test robot wrote:
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on iommu/next]
> > [also build test WARNING on linus/master v5.9-rc6 next-20200921]
> > [cannot apply to robclark/msm-next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Yu-Kuai/iommu-qcom-add-missing-put_device-call-in-qcom_iommu_of_xlate/20200918-091341
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> > config: arm64-randconfig-r023-20200920 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 4e8c028158b56d9c2142a62464e8e0686bde3584)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/iommu/arm/arm-smmu/qcom_iommu.c:601:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
> >                            return -EINVAL;
> >                            ^
> >    drivers/iommu/arm/arm-smmu/qcom_iommu.c:599:3: note: previous statement is here
> >                    if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev)))
> 
> Oh, this looks like a nasty bug. Seems we're missing some braces.

Yu Kuai: please could you send a v2 of this?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
