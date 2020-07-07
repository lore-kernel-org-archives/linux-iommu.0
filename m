Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5FCC433E1
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 15:31:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE7D204EC
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 15:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE7D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80E6C88209;
	Tue,  7 Jul 2020 15:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OEY3qiE3hQOE; Tue,  7 Jul 2020 15:31:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C75F7881EB;
	Tue,  7 Jul 2020 15:31:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD42DC07FF;
	Tue,  7 Jul 2020 15:31:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E78E5C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CD724881F3
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NUsh2b6NxD67 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 15:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AA5FD881EB
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:31:31 +0000 (UTC)
IronPort-SDR: zfcClSfEeOcTsbkHYGhf7r73X8BmipHu/zJXVlW7AjkoACm1DCRf1HG2EqtcPEmHwcALSIpKXe
 DTl2x35kTqGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127212953"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="127212953"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 08:31:31 -0700
IronPort-SDR: eJJD6EfiVgzIOKmfSus1Tjy2l9fOS9NZutL4XyGgYBVX+/QYiTNGgoyLND0jlGDP+pvHoAcM+v
 CkS6K4Y7gxCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="283484062"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 07 Jul 2020 08:31:30 -0700
Date: Tue, 7 Jul 2020 08:38:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: IOASID set token
Message-ID: <20200707083808.27adc859@jacob-builder>
In-Reply-To: <20200707100718.GA151594@myrica>
References: <20200701232916.38fd7908@jacob-builder>
 <20200702064825.20f9d2b1@jacob-builder>
 <20200706103041.GA3214@myrica>
 <20200706135137.26979271@jacob-builder>
 <20200707100718.GA151594@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Lu,
 Baolu" <baolu.lu@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>
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

Hi Jean,

All other points agreed.

On Tue, 7 Jul 2020 12:07:18 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> > > For the moment, though, we could actually specialize the IOASID
> > > API to only take an mm_struct as token.  
> > That would be fine with VT-d. We can use init_mm for host PASID set,
> > process mm for VM set.  
> 
> I'm not fond of using init_mm for the host PASID set. Does it need a
> token at all?
No need to use init_mm at all, probably can do without a token as well.
Just need to allocate a set for the native usage. I will give it a try.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
