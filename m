Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2289C10F14
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 14:59:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6C02186A
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 14:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6C02186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6AAFBDCF;
	Fri, 12 Apr 2019 14:59:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8CEDDAC7
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 14:59:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C528C855
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 14:59:56 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id A3DEF2DE; Fri, 12 Apr 2019 16:59:54 +0200 (CEST)
Date: Fri, 12 Apr 2019 16:59:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190412145954.GD29810@8bytes.org>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
	<20190410151516.47754-2-jean-philippe.brucker@arm.com>
	<20190411152803.GB29810@8bytes.org>
	<aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"ashok.raj@intel.com" <ashok.raj@intel.com>,
	"zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412145954.xvHs2_-xZxrbl7uO85VodoWEhzLfrP6kc1h64ATPDCo@z>

Hey Jean-Philippe,

On Fri, Apr 12, 2019 at 01:23:51PM +0100, Jean-Philippe Brucker wrote:
> I pushed a cleaner version to git://linux-arm.org/linux-jpb.git sva/api
> (with the below mistake fixed as well) and can resend if necessary.

No need to do that, I solved the conflicts I've seen and compile-testing
looked good so far, so I've pushed it out already. Maybe you can
double-check my tree if everything is as it should be?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
