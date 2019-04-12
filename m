Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9C3C10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 01:43:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF2D21850
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 01:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF2D21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 763072AF4;
	Fri, 12 Apr 2019 01:43:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 579D928D8
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 01:42:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 447FB25A
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 01:42:49 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Apr 2019 18:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,339,1549958400"; d="scan'208";a="130677578"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga007.jf.intel.com with ESMTP; 11 Apr 2019 18:42:45 -0700
Subject: Re: [PATCH v8 0/9] vfio/mdev: IOMMU aware mediated device
To: Joerg Roedel <joro@8bytes.org>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
	<20190411151917.GA29810@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0beedc65-fc26-5f17-6f0f-6e0c0aa022a3@linux.intel.com>
Date: Fri, 12 Apr 2019 09:36:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190411151917.GA29810@8bytes.org>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	sanjay.k.kumar@intel.com, Kirti Wankhede <kwankhede@nvidia.com>,
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	kvm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	yi.y.sun@intel.com
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412013649.vW6uhqbgOJoLogFBtxN7EZmrMijQiTzvf3U8P0vMIz8@z>

Hi Joerg,

On 4/11/19 11:19 PM, Joerg Roedel wrote:
> Hi Lu Baolu,
> 
> thanks for these patches!
> 
> On Mon, Mar 25, 2019 at 09:30:27AM +0800, Lu Baolu wrote:
>> Lu Baolu (9):
>>    iommu: Add APIs for multiple domains per device
>>    iommu/vt-d: Make intel_iommu_enable_pasid() more generic
>>    iommu/vt-d: Add per-device IOMMU feature ops entries
>>    iommu/vt-d: Move common code out of iommu_attch_device()
>>    iommu/vt-d: Aux-domain specific domain attach/detach
>>    iommu/vt-d: Return ID associated with an auxiliary domain
> 
> I applied the patches above to my tree. The first patch is in a new
> branch called 'api-features' and the other are in the x86/vt-d branch.

Thank you!

> 
>>    vfio/mdev: Add iommu related member in mdev_device
>>    vfio/type1: Add domain at(de)taching group helpers
>>    vfio/type1: Handle different mdev isolation type
> 
> Can you please address the minor concern on these patches, add all
> review and acks and re-send?

Sure. I will resend these soon.

> 
> Thanks,
> 
> 	Joerg

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
