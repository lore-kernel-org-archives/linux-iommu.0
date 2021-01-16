Return-Path: <SRS0=uK2e=GT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3488C433E0
	for <iommu@archiver.kernel.org>; Sat, 16 Jan 2021 03:54:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B8B23A55
	for <iommu@archiver.kernel.org>; Sat, 16 Jan 2021 03:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B8B23A55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AACD586781;
	Sat, 16 Jan 2021 03:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W_CvMx_chnFK; Sat, 16 Jan 2021 03:54:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B91AB86B46;
	Sat, 16 Jan 2021 03:54:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B6B5C088B;
	Sat, 16 Jan 2021 03:54:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC88AC013A
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 03:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B15B92E19D
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 03:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGTPP1josdFe for <iommu@lists.linux-foundation.org>;
 Sat, 16 Jan 2021 03:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id AE7412E19C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 03:54:13 +0000 (UTC)
IronPort-SDR: IakWO3g6kiitnOaZDl8mkNmQ3U1EGCrnl1RlMfC0+k1MsM+8WR1UfyhsPHuCRrLTDgZmq1cHIR
 a8Mlu+EwYiSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="242711090"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; d="scan'208";a="242711090"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2021 19:54:09 -0800
IronPort-SDR: 7RhNQTovQFrnfgsrcED9MhwANujPxOXtWf4Cq1X9OVAbauLpkRRAXSUed/tegFsW9b4aiT9/qz
 us0wXXg3dWaA==
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; d="scan'208";a="382896643"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.175.94])
 ([10.249.175.94])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2021 19:54:03 -0800
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YAB0SHyUZbxprkL3@larix.localdomain>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Message-ID: <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
Date: Sat, 16 Jan 2021 11:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAB0SHyUZbxprkL3@larix.localdomain>
Content-Language: en-US
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Woodhouse <dwmw2@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

On 2021/1/15 0:41, Jean-Philippe Brucker wrote:
> I guess detailing what's needed for nested IOPF can help the discussion,
> although I haven't seen any concrete plan about implementing it, and it
> still seems a couple of years away. There are two important steps with
> nested IOPF:
> 
> (1) Figuring out whether a fault comes from L1 or L2. A SMMU stall event
>      comes with this information, but a PRI page request doesn't. The IOMMU
>      driver has to first translate the IOVA to a GPA, injecting the fault
>      into the guest if this translation fails by using the usual
>      iommu_report_device_fault().
> 
> (2) Translating the faulting GPA to a HVA that can be fed to
>      handle_mm_fault(). That requires help from KVM, so another interface -
>      either KVM registering GPA->HVA translation tables or IOMMU driver
>      querying each translation. Either way it should be reusable by device
>      drivers that implement IOPF themselves.
> 
> (1) could be enabled with iommu_dev_enable_feature(). (2) requires a more
> complex interface. (2) alone might also be desirable - demand-paging for
> level 2 only, no SVA for level 1.
> 
> Anyway, back to this patch. What I'm trying to convey is "can the IOMMU
> receive incoming I/O page faults for this device and, when SVA is enabled,
> feed them to the mm subsystem?  Enable that or return an error." I'm stuck
> on the name. IOPF alone is too vague. Not IOPF_L1 as Kevin noted, since L1
> is also used in virtualization. IOPF_BIND and IOPF_SVA could also mean (2)
> above. IOMMU_DEV_FEAT_IOPF_FLAT?
> 
> That leaves space for the nested extensions. (1) above could be
> IOMMU_FEAT_IOPF_NESTED, and (2) requires some new interfacing with KVM (or
> just an external fault handler) and could be used with either IOPF_FLAT or
> IOPF_NESTED. We can figure out the details later. What do you think?

I agree that we can define IOPF_ for current usage and leave space for
future extensions.

IOPF_FLAT represents IOPF on first-level translation, currently first
level translation could be used in below cases.

1) FL w/ internal Page Table: Kernel IOVA;
2) FL w/ external Page Table: VFIO passthrough;
3) FL w/ shared CPU page table: SVA

We don't need to support IOPF for case 1). Let's put it aside.

IOPF handling of 2) and 3) are different. Do we need to define different
names to distinguish these two cases?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
