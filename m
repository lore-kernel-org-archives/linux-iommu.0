Return-Path: <SRS0=ZTHc=VC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6851C46498
	for <iommu@archiver.kernel.org>; Fri,  5 Jul 2019 02:29:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A863021850
	for <iommu@archiver.kernel.org>; Fri,  5 Jul 2019 02:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A863021850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6FE97C3F;
	Fri,  5 Jul 2019 02:29:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 04B64AAE
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Jul 2019 02:29:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 94C9A70D
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Jul 2019 02:29:08 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Jul 2019 19:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,453,1557212400"; d="scan'208";a="248066440"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga001.jf.intel.com with ESMTP; 04 Jul 2019 19:29:05 -0700
Subject: Re: [PATCH v4 20/22] iommu/vt-d: Add bind guest PASID support
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1560087862-57608-21-git-send-email-jacob.jun.pan@linux.intel.com>
	<f183139b-b5a8-f6b5-58e6-f93e01f7be6a@linux.intel.com>
	<20190627132244.351c7426@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <840a6943-87ab-938f-5f8d-3a2c21e08549@linux.intel.com>
Date: Fri, 5 Jul 2019 10:21:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627132244.351c7426@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

On 6/28/19 4:22 AM, Jacob Pan wrote:
>>> +		}
>>> +		refcount_set(&svm->refs, 0);
>>> +		ioasid_set_data(data->hpasid, svm);
>>> +		INIT_LIST_HEAD_RCU(&svm->devs);
>>> +		INIT_LIST_HEAD(&svm->list);
>>> +
>>> +		mmput(svm->mm);
>>> +	}
>>> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
>>> +	if (!sdev) {
>>> +		ret = -ENOMEM;
>>> +		goto out;
>> I think you need to clean up svm if its device list is empty here, as
>> you said above:
>>
> No, we come here only if the device list is not empty and the new
> device to bind is different than any existing device in the list. If we
> cannot allocate memory for the new device, should not free the existing
> SVM, right?
> 

I'm sorry, but the code doesn't show this. We come here even an svm data
structure was newly created with an empty device list. I post the code
below to ensure that we are reading a same piece of code.

         mutex_lock(&pasid_mutex);
         svm = ioasid_find(NULL, data->hpasid, NULL);
         if (IS_ERR(svm)) {
                 ret = PTR_ERR(svm);
                 goto out;
         }
         if (svm) {
                 /*
                  * If we found svm for the PASID, there must be at
                  * least one device bond, otherwise svm should be freed.
                  */
                 BUG_ON(list_empty(&svm->devs));

                 for_each_svm_dev() {
                         /* In case of multiple sub-devices of the same 
pdev assigned, we should
                          * allow multiple bind calls with the same 
PASID and pdev.
                          */
                         sdev->users++;
                         goto out;
                 }
         } else {
                 /* We come here when PASID has never been bond to a 
device. */
                 svm = kzalloc(sizeof(*svm), GFP_KERNEL);
                 if (!svm) {
                         ret = -ENOMEM;
                         goto out;
                 }
                 /* REVISIT: upper layer/VFIO can track host process 
that bind the PASID.
                  * ioasid_set = mm might be sufficient for vfio to 
check pasid VMM
                  * ownership.
                  */
                 svm->mm = get_task_mm(current);
                 svm->pasid = data->hpasid;
                 if (data->flags & IOMMU_SVA_GPASID_VAL) {
                         svm->gpasid = data->gpasid;
                         svm->flags &= SVM_FLAG_GUEST_PASID;
                 }
                 refcount_set(&svm->refs, 0);
                 ioasid_set_data(data->hpasid, svm);
                 INIT_LIST_HEAD_RCU(&svm->devs);
                 INIT_LIST_HEAD(&svm->list);

                 mmput(svm->mm);
         }
         sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
         if (!sdev) {
                 ret = -ENOMEM;
                 goto out;
         }
         sdev->dev = dev;
         sdev->users = 1;

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
