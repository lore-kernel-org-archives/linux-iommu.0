Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F84C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 15:28:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B32A2077C
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 15:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B32A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6290A29A8;
	Thu, 11 Apr 2019 15:28:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4F34429A5
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 15:28:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E6AD386F
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 15:28:04 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 4FA40451; Thu, 11 Apr 2019 17:28:03 +0200 (CEST)
Date: Thu, 11 Apr 2019 17:28:03 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190411152803.GB29810@8bytes.org>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
	<20190410151516.47754-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190410151516.47754-2-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, zhangfei.gao@foxmail.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	christian.koenig@amd.com
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
Message-ID: <20190411152803.Sa2yZvLkkgnrqwgTA6LVKYJjZyJsYvAq-ggUt2WhZac@z>

On Wed, Apr 10, 2019 at 04:15:16PM +0100, Jean-Philippe Brucker wrote:
>  drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h |  70 ++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)

Applied to the api-features branch for now, thanks Jean-Philippe!

'for now' because I have a question below.

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ed6738c358ca..87fe1cddd817 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -51,10 +51,13 @@ struct device;
>  struct iommu_domain;
>  struct notifier_block;
>  struct iommu_fault_event;
> +struct iommu_sva;

The iommu_fault_event doesn't yet exist in my tree, is this patch based
on something else I need besided Lu Baolus work? I got quite some
conflicts while applying the patch because of this.

> + * @sva_set_ops: Set ops for a SVA handle

I also removed this line.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
