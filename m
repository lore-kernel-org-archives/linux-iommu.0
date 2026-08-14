Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFD4908C1
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726815; cv=fail; b=mZvDfUEehmx7KxxqcE5u3Ra6DGZJX7TP/S9kgM+OGMDGIxKgU6hBTa1LcSarVzXN85OvpKZVYhxH+aEY2qrhL7IB5dhHYJv+EZbYFOyvNkYGDQUc8AY2jz+56X6B3cWV/XiDfa3m5mrYPo47d0MA1TanOBoTwhlSJyp/2eVEFA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726815; c=relaxed/simple;
	bh=zSj9e3Vlsv9ZfrM/aDqpxAvY99BjB/oVJVeVhiI77TE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+rWmHjBkp1Llzcbma6+orV0PTRM6AUz9ScmeBLBlIw5XlToFV2ao4VRwxY62otXBoNU0HahcxLqKmijGUs1qRCGoLL1RJoYctophVRSvDndYxoDYibfpWlicEKU9jCVadUVwL5Nuv3UoOnUX1L1W1jRMS79zsh/JeYLfa9F1cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e6vAKO3l; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e6vAKO3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpTuDtxdFJatfhWnZoIjTB9iFEoWJPFJ1f2kDX6x7biTcAQHom314Bsy3qnA900QIYCfDghLxNRbbXpgME8WbP6rhDsCc3ZSvMpHRYaUH3mV+o0mCpWG4cq8sGFw0p0Wzp/RddJ3LEVEfaRZFg5otDV5jABha9rdnkGkwHe0edHIR4Iv2EKCuZBVTlPlZYyafXp0dpedjXa7zoz2cQNMspzaAZCSANkbi80co3kGK4qPZ0D0QC2tG3ULIm6YJQnqmQw57wP3efTtkBBCMjgkLG58IvprGJixZ+zzzH2VqLAYHUBWu9UguO+bBypsSc5ze43BISqdA79LKD2wI92q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE6qkKupRCH+U2n4Kzu4y1WXSbysfCuVXEjBgGVKX5g=;
 b=cXon5IqxKV7Gp90MJX78YuAH/8WIcPi5buGLjdzWy+XfBD5by2tWaG7ZLxAV2uJqvEsh7a2VsZel3i1frtaB9RMowAi4pzO3lFECxgsEchqRFviA2+n1wjRtoDS5XHCXFhU9mA6m3NIv427m08MbYjPT/fxrA08gs/d0qGDApLOf/vYTtI/IqwvKMooa41YGfi1gPF88COJ8iRPgutWfseNhnBCI5Yu4lSb9pyJ6XxW37zIZ8h58ntHJR7MgeVpL95hkyZ4kaF2fEG3617yF6xMukZFiW1tKEemouSHp/Gwzbg9NMyKn7jB9pefCmQpIX85GoT/d0MOhMy0lw9K2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE6qkKupRCH+U2n4Kzu4y1WXSbysfCuVXEjBgGVKX5g=;
 b=e6vAKO3ltT4qUxEG3CU04NY53cmUxIJ7dqiAc2xkr9oGW/6jrZxEjdfTECWhWpRf1BD6J6r5dDcXwjAlNwqVDDvJ0mhXLcsjZN5dMsd2iU+p930VTcN6zHMZ3UjBJfkTGnUvQxp0bfbfQJ7+LTe7CPYpJROfD7TFn8umFXzGRAw=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 17:00:08 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::67) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 17:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 17:00:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 12:00:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 12:00:03 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 11:59:58 -0500
Date: Fri, 14 Aug 2026 16:59:50 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "David
 Matlack" <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 11/18] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <xssagtjtc27kxprwyz7exeiotigcr3ksnvr53ap56ialuqlfe4@xql3pr5va6m5>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-12-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260808022723.3893618-12-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c6f29c-32bf-4da8-bd08-08defa257ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|23010399003|56012099006|10067099003|4143699003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ajZVYntJ9IUL7WH3P4/0gGbbR6IOJgC7agMzp1qc0dBj/oFpxEmDZtHjY1RS5im74cXSuqpEZh4gjxd/p47Yw4cqlUWgg/6XkMTLjiVpYr9zkROIgwtPU5w6MSJLMZGtdopQk9QapekqIXh7nfHne+/4luNmgRGG+eMo7a8THEJuN9zph/n3hV3nHSa/eTDAAeW2/ICMuVAAfnucEjuMsslJJASmvt5+vd9K0Bx0a+0MzvdI6ZVNXBwTXTsx0BS8hupE2/jTbwZEEnh7sq67Nu4Cqo530xM+WxnAuH/kHL2EUcn0+VRWbN52P71AnEECohHYv/BpMEFajvegoNWmfYWMgEMhgqcBSKn5X2crtrXwJTRafW/XCMOpw6dxbf1291LOPAnpdXe3Ci1C5YGUVIqliJLNPyH3rPRKA/A6mXnPkcV6ive4349Hp0fJKrPC4URXMGwb8+QdjI5RQQqNANO7ya/cliTNYPCE0STowE3uTJpbEKsNYrKFlcJPVBKyG+W9phKen+b7N2eKsuM2OnsVTIsL1ZRuZBIGbWdr2O7iNN5p7O+0bzZGu+Cbn21lZcX1CXcnUXJpqgv6gFaiC4m93cLGS22NE/Im+lFPBJFDQJ0rUCjaeNG6OTI3D/x4Pmgw+9UP6qFVUZYo7YtsTFsXUowvRoYEsGwfLLGweUNJ6zXBpCJR/A1LHNSIQtPXljm7B9uKrINF8cEOva5WVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IHHLYf+cDgSeMkzyLHkc4tRoxz/ToM6z2pr8cjeZnDyP/L9HxTE26m84Fy9RTfFWQc70Hb+gDySJbGtdix727u1nkGOpQztfVe7Po5wavmzLCS1Jc1MpcOc6h8qrhigloMsacXLO6ED3TESZ+iXGcUD53EHxrD9SRG/e+VQ4GvhK+VBTEKQh+h91AGKw9D3gKFD36Bws57wxZi6SsTSXLLnoGgquBIAjKC7ou89iu+vMq2NZ5FD6vVEfxDMyWnVzNH7BVxpR+EDMDce/b1goJkr1ZYpPFaWbVASzMqtVkOmVblanpSckweQMnEYShAFVjm8YOFDCiwgkomvuwkuvAcOytQIMDHFi2yU8ASFsbzgKvOFmx6Cj9jsskWdo50zNn0ZOySUrVdM4KW/YnIlL5WBmeYns53KjxlXpUXvYFpBRxQIwSLtVcVOJ00NYKT/T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:00:08.3254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c6f29c-32bf-4da8-bd08-08defa257ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645

On Sat, Aug 08, 2026 at 02:27:16AM +0000, Samiullah Khawaja wrote:
> During default domain setup, restore the preserved domains by restoring
> the page tables using restore() iommupt op. Associated the restored
> domain with the iommu group of the preserved device, and reattach the
> domain to the device.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/iommu.c            |  76 ++++++++++++++++++
>  drivers/iommu/liveupdate.c       | 130 +++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h |  69 ++++++++++++++++
>  3 files changed, 275 insertions(+)
> 

../..

> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 20acf123b47a..04c0212cd81b 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -708,3 +708,133 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>  	liveupdate_flb_put_outgoing(&iommu_flb);
>  }
>  EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
> +
> +static inline bool match_device_ser(struct iommu_device_ser *match,
> +				    struct pci_dev *pdev)
> +{
> +	return match->devid == pci_dev_id(pdev) && match->pci_domain_nr == pci_domain_nr(pdev->bus);
> +}
> +
> +/**
> + * iommu_init_device_preserved_data() - Initialize preserved state for device
> + * @dev: Target device
> + *
> + * Looks up incoming Live Update state for @dev and attaches it to the device if
> + * found.
> + */
> +void iommu_init_device_preserved_data(struct device *dev)
> +{
> +	struct iommu_device_ser *device_ser = NULL;
> +	struct iommu_device_array_ser *array;
> +	struct iommu_flb_obj *flb_obj;
> +	int ret, idx;
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
> +	if (ret)
> +		return;
> +
> +	mutex_lock(&flb_obj->lock);
> +	array = phys_to_virt(flb_obj->ser->device_array_phys);
> +	iommu_liveupdate_for_each_arr(array) {
> +		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
> +			if (match_device_ser(device_ser, to_pci_dev(dev))) {
> +				device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	device_ser = NULL;
> +out:
> +	WRITE_ONCE(dev->iommu->device_ser, device_ser);
> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +}
> +EXPORT_SYMBOL(iommu_init_device_preserved_data);
> +
> +/**
> + * iommu_release_restored_device() - Release a restored device
> + * @dev: Target device
> + */
> +void iommu_release_restored_device(struct device *dev)
> +{
> +	/*
> +	 * We do not support releasing the restored devices that are not
> +	 * reclaimed by the device drivers as they can fallback to the default
> +	 * domain.
> +	 */
> +	BUG_ON(dev_iommu_restored_state(dev));

Hi,
After a successful live update this is one sysfs write away, and nothing in
the series disarms it.

At PCI probe, iommu_init_device_preserved_data() matches the incoming FLB on
devid + pci_domain_nr and sets IOMMU_SER_FLAG_INCOMING.
Nothing clears the flag or device_ser afterwards. The group is meanwhile owned
on behalf of iommufd (iommu.c:3229-3231, "will be reclaimed later by the
entity (iommufd) that preserved them"), and iommufd_liveupdate_retrieve() is
-EOPNOTSUPP, so the reclaim that would end the restored state cannot happen
yet. The device is left with the state permanently set.

A remove then BUG_ONs, in pci_stop_and_remove_bus_device_locked(), with
pci_rescan_remove_lock held. Any device_del() gets there, so surprise unplug
too, not only sysfs;

Hit with my live-update work for AMD on top of this series, on a preserved
device with no driver bound:

  # echo 1 > /sys/bus/pci/devices/0000:43:00.0/remove

  kernel BUG at drivers/iommu/liveupdate.c:782!
  RIP: 0010:iommu_release_restored_device+0x24/0x30
  Call Trace:
   iommu_release_device+0x36/0x70
   iommu_bus_notifier+0x46/0x60
   ...
   device_del+0x267/0x3c0
   pci_stop_and_remove_bus_device_locked+0x22/0x40
   remove_store+0x8d/0xa0

Two suggestions:

  - Clear the flag and device_ser together when the restored state ends.
	The two helpers partition on that bit.
  - WARN_ON and fall back to the default domain rather than BUG_ON, and either
    way do not die holding pci_rescan_remove_lock.

The same missing clear should also fail a second preserve, since
iommu_preserve_device() returns -EBUSY when device_ser is set.
Reaching that needs a reclaim first, so it may not be live today; static reading, I have not run it.

Thanks,
Ankit

> +}
> +
