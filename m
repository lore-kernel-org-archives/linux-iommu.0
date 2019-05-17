Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA93C04E84
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 04:53:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF2820833
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 04:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF2820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 430EE86D;
	Fri, 17 May 2019 04:53:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F00DC5A8
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 04:53:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 93C1E710
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 04:53:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	16 May 2019 21:53:13 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 16 May 2019 21:53:11 -0700
Subject: Re: [PATCH v3 7/7] iommu/vt-d: Differentiate relaxable and non
	relaxable RMRRs
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	lorenzo.pieralisi@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
	hanjun.guo@linaro.org, sudeep.holla@arm.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
	<20190516100817.12076-8-eric.auger@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2ebc33ed-ded6-0eee-96ef-84e6f61f692e@linux.intel.com>
Date: Fri, 17 May 2019 12:46:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516100817.12076-8-eric.auger@redhat.com>
Content-Language: en-US
Cc: alex.williamson@redhat.com
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

Hi Eric,

On 5/16/19 6:08 PM, Eric Auger wrote:
> Now we have a new IOMMU_RESV_DIRECT_RELAXABLE reserved memory
> region type, let's report USB and GFX RMRRs as relaxable ones.
> 
> This allows to have a finer reporting at IOMMU API level of
> reserved memory regions. This will be exploitable by VFIO to
> define the usable IOVA range and detect potential conflicts
> between the guest physical address space and host reserved
> regions.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   drivers/iommu/intel-iommu.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a36604f4900f..af1d65fdedfc 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5493,7 +5493,9 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   	for_each_rmrr_units(rmrr) {
>   		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>   					  i, i_dev) {
> +			struct pci_dev *pdev = to_pci_dev(device);

Probably should be:

struct pci_dev *pdev = dev_is_pci(device) ? to_pci_dev(device) : NULL;

Best regards,
Lu Baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
