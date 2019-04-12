Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D4C10F14
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DCD2073F
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DCD2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 31210CCA;
	Fri, 12 Apr 2019 16:05:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6887ACB8
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 16:05:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 20FF2875
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 16:05:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D64E415AB;
	Fri, 12 Apr 2019 09:05:27 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D3653F557;
	Fri, 12 Apr 2019 09:05:26 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
To: Joerg Roedel <joro@8bytes.org>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
	<20190410151516.47754-2-jean-philippe.brucker@arm.com>
	<20190411152803.GB29810@8bytes.org>
	<aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
	<20190412145954.GD29810@8bytes.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <52decdcd-765a-4c1a-bb4c-99490629b310@arm.com>
Date: Fri, 12 Apr 2019 17:05:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190412145954.GD29810@8bytes.org>
Content-Language: en-US
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
Message-ID: <20190412160505.nYeGqACWyAamjZ9bldltmMnD391NMZTJSteAACsxnRE@z>

On 12/04/2019 15:59, Joerg Roedel wrote:
> Hey Jean-Philippe,
> 
> On Fri, Apr 12, 2019 at 01:23:51PM +0100, Jean-Philippe Brucker wrote:
>> I pushed a cleaner version to git://linux-arm.org/linux-jpb.git sva/api
>> (with the below mistake fixed as well) and can resend if necessary.
> 
> No need to do that, I solved the conflicts I've seen and compile-testing
> looked good so far, so I've pushed it out already. Maybe you can
> double-check my tree if everything is as it should be?

It looks fine, thanks!

Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
