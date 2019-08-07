Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B4DC31E40
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 03:07:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FE82070C
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 03:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FE82070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F3CD6D89;
	Wed,  7 Aug 2019 03:07:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7CEE87F6
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 03:07:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E6C4982F
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 03:07:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Aug 2019 20:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,356,1559545200"; d="scan'208";a="185855550"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga002.jf.intel.com with ESMTP; 06 Aug 2019 20:07:34 -0700
Subject: Re: [PATCH 2/3] iommu/vt-d: Apply per-device dma_ops
To: Christoph Hellwig <hch@lst.de>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com>
	<20190801060156.8564-3-baolu.lu@linux.intel.com>
	<20190806064347.GA14906@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f532a2c3-f73a-85d2-d2ad-37cde02547ce@linux.intel.com>
Date: Wed, 7 Aug 2019 11:06:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190806064347.GA14906@lst.de>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
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

Hi Christoph,

On 8/6/19 2:43 PM, Christoph Hellwig wrote:
> Hi Lu,
> 
> I really do like the switch to the per-device dma_map_ops, but:
> 
> On Thu, Aug 01, 2019 at 02:01:55PM +0800, Lu Baolu wrote:
>> Current Intel IOMMU driver sets the system level dma_ops. This
>> implementation has at least the following drawbacks: 1) each
>> dma API will go through the IOMMU driver even the devices are
>> using identity mapped domains; 2) if user requests to use an
>> identity mapped domain (a.k.a. bypass iommu translation), the
>> driver might fall back to dma domain blindly if the device is
>> not able to address all system memory.
> 
> This is very clearly a behavioral regression.  The intel-iommu driver
> has always used the iommu mapping to provide decent support for
> devices that do not have the full 64-bit addressing capability, and
> changing this will make a lot of existing setups go slower.
>

I agree with you that we should keep the capability and avoid possible
performance regression on some setups. But, instead of hard-coding this
in the iommu driver, I prefer a more scalable way.

For example, the concept of per group default domain type [1] seems to
be a good choice. The kernel could be statically compiled as by-default
"pass through" or "translate everything". The per group default domain
type API could then be used by the privileged user to tweak some of the
groups for better performance, either by 1) bypassing iommu translation
for the trusted super-speed devices, or 2) applying iommu translation to
access the system memory which is beyond the device's address capability
(without the necessary of using bounce buffer).

[1] https://www.spinics.net/lists/iommu/msg37113.html

> I don't think having to use swiotlb for these devices helps anyone.
> 

Best regards,
Baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
