Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B73C04AB6
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 02:22:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D133B206E0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 02:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D133B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8BB2423D4;
	Wed, 29 May 2019 02:22:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6DD3B2270
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 02:18:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F04466C5
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 02:18:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 May 2019 19:18:42 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 28 May 2019 19:18:40 -0700
Subject: Re: [PATCH v5 3/7] iommu/vt-d: Introduce is_downstream_to_pci_bridge
	helper
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org, robin.murphy@arm.com
References: <20190528115025.17194-1-eric.auger@redhat.com>
	<20190528115025.17194-4-eric.auger@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <560dde25-6cac-a721-baf1-110e03723eda@linux.intel.com>
Date: Wed, 29 May 2019 10:11:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528115025.17194-4-eric.auger@redhat.com>
Content-Language: en-US
Cc: jean-philippe.brucker@arm.com, alex.williamson@redhat.com
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

On 5/28/19 7:50 PM, Eric Auger wrote:
> Several call sites are about to check whether a device belongs
> to the PCI sub-hierarchy of a candidate PCI-PCI bridge.
> Introduce an helper to perform that check.
> 

This looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
Baolu


> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++--------
>   1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 5ec8b5bd308f..879f11c82b05 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -736,12 +736,39 @@ static int iommu_dummy(struct device *dev)
>   	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
>   }
>   
> +/* is_downstream_to_pci_bridge - test if a device belongs to the
> + * PCI sub-hierarchy of a candidate PCI-PCI bridge
> + *
> + * @dev: candidate PCI device belonging to @bridge PCI sub-hierarchy
> + * @bridge: the candidate PCI-PCI bridge
> + *
> + * Return: true if @dev belongs to @bridge PCI sub-hierarchy
> + */
> +static bool
> +is_downstream_to_pci_bridge(struct device *dev, struct device *bridge)
> +{
> +	struct pci_dev *pdev, *pbridge;
> +
> +	if (!dev_is_pci(dev) || !dev_is_pci(bridge))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	pbridge = to_pci_dev(bridge);
> +
> +	if (pbridge->subordinate &&
> +	    pbridge->subordinate->number <= pdev->bus->number &&
> +	    pbridge->subordinate->busn_res.end >= pdev->bus->number)
> +		return true;
> +
> +	return false;
> +}
> +
>   static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
>   {
>   	struct dmar_drhd_unit *drhd = NULL;
>   	struct intel_iommu *iommu;
>   	struct device *tmp;
> -	struct pci_dev *ptmp, *pdev = NULL;
> +	struct pci_dev *pdev = NULL;
>   	u16 segment = 0;
>   	int i;
>   
> @@ -787,13 +814,7 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>   				goto out;
>   			}
>   
> -			if (!pdev || !dev_is_pci(tmp))
> -				continue;
> -
> -			ptmp = to_pci_dev(tmp);
> -			if (ptmp->subordinate &&
> -			    ptmp->subordinate->number <= pdev->bus->number &&
> -			    ptmp->subordinate->busn_res.end >= pdev->bus->number)
> +			if (is_downstream_to_pci_bridge(dev, tmp))
>   				goto got_pdev;
>   		}
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
