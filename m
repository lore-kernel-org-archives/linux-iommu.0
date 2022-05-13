Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615BBC433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 03:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF305410CF;
	Fri, 13 May 2022 03:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IzlsI1-6vk5S; Fri, 13 May 2022 03:32:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 85C45410C8;
	Fri, 13 May 2022 03:32:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B243C0039;
	Fri, 13 May 2022 03:32:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 944D9C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 03:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A93A60B4D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 03:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z1bQ-FLtvBe0 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:32:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3D2060AEE
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 03:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652412738; x=1683948738;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1JaSwFo6yze7m9vGoeyzvVSuA0dchXzgqHD9DVXRPM4=;
 b=GBcZafuZijes2gRJ9uofq74tQiK+0g3I//LM6EAAtCRtt83bQjy8V/nD
 j6NsXXjJ0RjLkZNaGfl59QOgrVJejpPOzM0h2PfW20zYJfpEtRGDSx8uW
 KgV7JKIR1+WVnynXC4mlc5SmM4PpY8XYSF0SKoaMhaJj0qODVAWslFolZ
 1xwKoecbp8KUqstIn6sdFCfQXiNBrdf5gBfEY/GIAHsJGvRelsAsprHzQ
 f3UjexNZa8aWDccPzYyQT5sQfWKPpJjCgL/abppazshcXgdLHAgqegem6
 aYBe8j/xlq0ON91C32RAxotPgP6TIWRLCA+ioB/yvGpmisyphtkmqf9cx g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295461377"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="295461377"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 20:32:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="739986975"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.249.175.174])
 ([10.249.175.174])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 20:32:13 -0700
Message-ID: <6da2adf4-6717-b562-5ee3-7e28447aa65b@linux.intel.com>
Date: Fri, 13 May 2022 11:32:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/vt-d: Try info->iommu in device_to_iommu()
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, dwmw2@infradead.org, joro@8bytes.org, 
 will@kernel.org
References: <20220513003233.4442-1-nicolinc@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220513003233.4442-1-nicolinc@nvidia.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 jgg@nvidia.com
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

On 2022/5/13 08:32, Nicolin Chen wrote:
> Local boot test and VFIO sanity test show that info->iommu can be
> used in device_to_iommu() as a fast path. So this patch adds it.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/intel/iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2990f80c5e08..412fca5ab9cd 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -777,6 +777,7 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
>   struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
>   {
>   	struct dmar_drhd_unit *drhd = NULL;
> +	struct device_domain_info *info;
>   	struct pci_dev *pdev = NULL;
>   	struct intel_iommu *iommu;
>   	struct device *tmp;
> @@ -786,6 +787,10 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
>   	if (!dev)
>   		return NULL;
>   
> +	info = dev_iommu_priv_get(dev);
> +	if (info)
> +		return info->iommu;

device_to_iommu() also returns device source id (@bus, @devfn).

Perhaps, we can make device_to_iommu() only for probe_device() where the
per-device info data is not initialized yet. After probe_device(), iommu
and sid are retrieved through other helpers by looking up the device
info directly?

Best regards,
baolu

> +
>   	if (dev_is_pci(dev)) {
>   		struct pci_dev *pf_pdev;
>   

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
