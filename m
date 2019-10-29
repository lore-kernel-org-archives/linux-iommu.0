Return-Path: <SRS0=m6Z5=YW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8479CA9EC1
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 02:36:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CDA20862
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 02:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CDA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6D2E1EDC;
	Tue, 29 Oct 2019 02:36:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9075BE1E
	for <iommu@lists.linux-foundation.org>;
	Tue, 29 Oct 2019 02:36:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 068D18A
	for <iommu@lists.linux-foundation.org>;
	Tue, 29 Oct 2019 02:36:34 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Oct 2019 19:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,242,1569308400"; d="scan'208";a="224828056"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 19:36:31 -0700
Subject: Re: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
To: "Tian, Kevin" <kevin.tian@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-10-git-send-email-jacob.jun.pan@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDDA6@SHSMSX104.ccr.corp.intel.com>
	<20191025103337.1e51c0c9@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7B8@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <75d15d99-d8f8-c09f-e9a7-64c17d037e0e@linux.intel.com>
Date: Tue, 29 Oct 2019 10:33:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7B8@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 10/28/19 2:03 PM, Tian, Kevin wrote:
>>>>   	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>>>>   	.is_attach_deferred	=
>>>> intel_iommu_is_attach_deferred, .pgsize_bitmap		=
>>>> INTEL_IOMMU_PGSIZES, +#ifdef CONFIG_INTEL_IOMMU_SVM
>>>> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>>>> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
>>>> +#endif
>>> again, pure PASID management logic should be separated from SVM.
>>>
>> I am not following, these two functions are SVM functionality, not
>> pure PASID management which is already separated in ioasid.c
> I should say pure "scalable mode" logic. Above callbacks are not
> related to host SVM per se. They are serving gpasid requests from
> guest side, thus part of generic scalable mode capability.
> 

Currently these two callbacks are for sva only and the patch has been
queued by Joerg for the next rc1. It could be extended to be generic.
But it deserves a separated patch.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
