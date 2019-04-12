Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C445C10F14
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 12:24:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DE720675
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 12:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DE720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A9F77DCF;
	Fri, 12 Apr 2019 12:24:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 92806DCD
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 12:24:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 1D0137ED
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 12:24:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC349374;
	Fri, 12 Apr 2019 05:24:14 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C54E3F718;
	Fri, 12 Apr 2019 05:24:13 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
To: Joerg Roedel <joro@8bytes.org>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
	<20190410151516.47754-2-jean-philippe.brucker@arm.com>
	<20190411152803.GB29810@8bytes.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
Date: Fri, 12 Apr 2019 13:23:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190411152803.GB29810@8bytes.org>
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
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412122351.K7lg__SakBYFshGhEUCfRDJitCKKAXzZwBWJXk806Mg@z>

On 11/04/2019 16:28, Joerg Roedel wrote:
> On Wed, Apr 10, 2019 at 04:15:16PM +0100, Jean-Philippe Brucker wrote:
>>=A0 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
>>=A0 include/linux/iommu.h |=A0 70 ++++++++++++++++++++++++++++
>>=A0 2 files changed, 174 insertions(+)
> =

> Applied to the api-features branch for now, thanks Jean-Philippe!
> =

> 'for now' because I have a question below.
> =

>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ed6738c358ca..87fe1cddd817 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -51,10 +51,13 @@ struct device;
>>=A0 struct iommu_domain;
>>=A0 struct notifier_block;
>>=A0 struct iommu_fault_event;
>> +struct iommu_sva;
> =

> The iommu_fault_event doesn't yet exist in my tree, is this patch based
> on something else I need besided Lu Baolus work? I got quite some
> conflicts while applying the patch because of this.

Ugh, sorry about this, I forgot to rebase onto master. The only required
patch is Lu Baolu's "iommu: Add APIs for multiple domains per device".
The iommu_fault_event is introduced by Jacob's fault reporting work, but
is independent from this patch.

There also is a small conflict with the SMMUv3 ATS work, which I'm
hoping to get in v5.2 as well (but will probably require more work).
I'll send next version of ATS applied on top of this patch.

I pushed a cleaner version to git://linux-arm.org/linux-jpb.git sva/api
(with the below mistake fixed as well) and can resend if necessary.

Thanks,
Jean

> =

>> + * @sva_set_ops: Set ops for a SVA handle
> =

> I also removed this line.
> =

> Regards,
> =

> =A0=A0=A0=A0=A0=A0=A0 Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
