Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705954DE727
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402306; cv=fail; b=XJHWNX7yaKWZ+YJ4jnJRaFGRAElE2knkiLFI5pu85z8XQKtiLY7VXL63/UJ749uHHGGuv8VgCvIf32KAfYLHLHIBw6oucXu7UpMtSYsOx5YfnsPY6OvSo63WIeA2Wlb1DnzhducOvjckmioebQNGtCBxVMT9blqn+KWzqe5noKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402306; c=relaxed/simple;
	bh=bEiCMPfXrmZ+UJ2TjpgHrg06T1IqeD4i4XVhiCcZReg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG1Cf5WU85NELqX+Zm1w5oU9VvN9qvUvmdPrMKxlphWUlITjP2YL7yAyK4RrcngBPw4UBj0DZhLp041TWfOTZ7GZLbalMWBg53xqNUQaJYxPLt/Ovg46sXLSPsgSrQLIfH/kUUSGVlFuqEF2SIo1hs6Mioj/i/uCeVVNXqih8/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B+qFssXA; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B+qFssXA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onjJVMNA+YF1JwyxTe7kO1390v47iicUoRKOf8aM8+iVxSSBeY8JJw4OwhHiDgZklkmcjZPkoyoYZ3soMPXjqwAoHTjOaXDCtTtXJS+zC5DYkIb3/fEYCYPzq1dvwZqpoFnRnLQBt7a6UqDIpoFdRZZQD1tDHQaPBCVSM9HPmirmJd3U8g+yMu6vfUEgototbLAIb5CKpSNTCHUFoxkHuCb1HqVxPbii+thpc9evi5J2DXB6uH/gJLnMf5X7Uo5J4PGxb4EcpC3XvermJ0wiC+ayGOlaqUx9xfzjI/4QkQbDrINaIsOjAIFsVQMXw/DhtEdUhO87ALWdkNCxaLq9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0t0/2x45Uwu3oL0pEL0/crmRnJUcXSjt8g0SKNyXmw=;
 b=Ima8HY1+MfO3TtjvTs3jX1f+KuKmmG13VWbQSbPIifAlItVyiemt39aeOWM2zwod0XElEG6M7KfkParq4aaImYlDQOwJRKAu0+qFvUmWDZH+FFoTcsavwkM/bMqld5BCAldepGzWFZtfXgfP8PCwhWD6mfjFo+sWypn8MuJ2eznc2XWCApwxZu6tCTMEa08aBhrdEj60paBQSozF9Lw+cDqXl1OO4qAIUmNEk6DgJ/C2nEXQY+86ycBE1Hr7jgHE++kWyqzrVGo55Dr5l1aAKJeI7LVQ4JGgJBie5EWzZ0dhE7hyfOnLyhXN/yGpWuA88P5I8xApsiHh6f/AdRfLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0t0/2x45Uwu3oL0pEL0/crmRnJUcXSjt8g0SKNyXmw=;
 b=B+qFssXAWQIoPjuiAdxddA8j/uZtX0Vy/3xXoClo5LlphLjCAJiyApNoAhjgqbxIWqTVBJqzOBYVXkc3zjR8xgT1o8UPVUZZfwH47FelXcUII3OFvM7xa48IQq+UqvLZAsGAWUglxfNGzWoYQ3GG+Bml9SCLsoQjW0+A4XC8yB/fX32rfO3sGQnjnlEZ9wmIuEgLym39QiRZQ9YaH0Oqmv7PEA4N6KUf2YQ0OjtTmvRee5UmKDDUKR89TGDzRs+X4+qKVeDZQgWq4l9+FgHK9Im4TA3+3dODbNoJcvlcJeJpV4GOpeyFGEoBGHe1x9cJt02e/8xyYnzuDOu3hyGaLQ==
Received: from MN0P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::26)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 19:44:57 +0000
Received: from BL2PEPF000352CD.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::4d) by MN0P222CA0024.outlook.office365.com
 (2603:10b6:208:531::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Wed, 7
 Oct 2026 19:44:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL2PEPF000352CD.mail.protection.outlook.com (10.167.249.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 19:44:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:44:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:44:34 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:44:33 -0700
Date: Wed, 7 Oct 2026 12:44:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
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
Subject: Re: [PATCH v5 11/18] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <asahH/NfWZGdvIsE@nvidia.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-12-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921004834.2601285-12-skhawaja@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CD:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: df3adf60-13db-4c8a-dbed-08df24ab777d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|7416014|36860700016|1800799024|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	UckYY5OS6FDB2hal9Hp1XuN3cWHPWf5FSaZSzJiMMnns7Vhzyh0EPxDGoV1XrF33gvUCQnc9Vq3YM39Em1ldrgMGamdCNyNoZtKxlgk0XS+u2ExpHaYHmSpLrO5fjxGSmsspKSGlwR3oLO52eXDqUi2OQqbvOjn8HbpW8rrMIRufOsD127tiBUmkjm04fEDonMNQwTqDnXOaZTRCcy7KV3zveQeQujsIO7Uki9mlVHwITk7rACj4nxx6bA7kIchfOGtDAQTK4j6qUCJ2VHwGnW7vvRyPQG6YHZq5TIRMaEX+M/cBQklqnRLcb/yEKruAmA3o1HNX4niHRSeBJ6xrCM3G/WN21CpMniw7tLLHQ2JPfQ//gBdfIO9hkWhJPas80v/4L8fKARn41YseEqyXUNMdjuYkIsT+ZuIRIm7pg9zM4B32dh0Qw0zVEyW/2uEVCJQN/kD+x8//gXwBElgccqc1g4/fAvI+Nnc6J7vbNcwG16Y8OwckqEhCawKdrbxL2x1TYgGXOr1xh+G1p2SHUhaoPN9mQF5FxdDtRdUyQgLnMgTYWLcarIyFVB33FAVICNm1ECxCH+cEit/JUrKX+V0N6k7xRR0SJszQHxqm4vNAKXHPz+hjKTli7Xn2jki05DYQaWWldR0onxQDkeuvsq+8VIniuwlDwP8UDlUmeUdzhNKeMYjoh6qSDu6RBLmVRWIQjgbwcWQhX1L88lb12g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(7416014)(36860700016)(1800799024)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uVB4KE0tqBUj9+97BBGfQ/mtvnbvXad0Fbb0qJ50l0bgkSHmmd36hLMjONYzwf4auzAPZ/gje9m8MaSguvtTBiQYYtwO6Z75kt3f22/jyA+lKEyiwd9rRKEid8hUadeBvEBx1FFIUoG8o9Oq+5gNEKk67WZ7OwDuzLggcp5S4WpPwaWQESwKXQ0VwMBBmE20YGI/yWtPqw746ma/O4xxOn6OUK1jeriH/jjqYDvig4iOsV76bu3lMYyBm8Ad3oFtYH1KcGVdH8hVjr1djJD3zup9dUnXoj24Jwj2HaJ/SHOIIpROCzifPkmBjHvzsG0dcne1TDCnVQgNF7jSqWGR0ly/rxZtIWm0QLdGu+4qhLLqCjQ4q+CI05OktYzxCrubr2miHF18OLhtqLpR8KraHeYKbT3hoGaOSyTylnRx40whwi4H577oM8kGf341cbyE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:44:56.9695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df3adf60-13db-4c8a-dbed-08df24ab777d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313

On Mon, Sep 21, 2026 at 12:48:27AM +0000, Samiullah Khawaja wrote:
> @@ -694,7 +700,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  	}
>  
>  	for_each_group_device(group, gdev2) {
> -		if (dev_iommu_preserved_state(gdev2->dev)) {
> +		if (dev_iommu_preserved_state(gdev2->dev) ||
> +		    dev_iommu_restored_state(gdev2->dev)) {
>  			ret = -EBUSY;
>  			goto err_free_gdev;

Maybe it should -EBUSY on a group that already has a device so it
wouldn't end up with a multi-device group.

> @@ -2211,6 +2242,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>  	ret = domain->ops->attach_dev(domain, dev, old);
>  	if (ret)
>  		return ret;
> +
>  	dev->iommu->attach_deferred = 0;
>  	trace_attach_device_to_domain(dev);
>  	return 0;

Unnecessary change.

> @@ -3175,6 +3207,62 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
>  }
>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>  
> +static struct device *__iommu_group_restored_device(struct iommu_group *group)
> +{
> +	struct group_device *gdev;
> +
> +	lockdep_assert_held(&group->mutex);
> +	for_each_group_device(group, gdev) {
> +		if (!dev_is_pci(gdev->dev))
> +			continue;
> +
> +		if (dev_iommu_restored_state(gdev->dev))
> +			return gdev->dev;

list_first_entry instead of for_each_group_device since there's a
singleton enforcement.

> +	}
> +
> +	return NULL;
> +}
> +
> +static int __iommu_group_restore_domain(struct iommu_group *group)
> +{
> +	struct iommu_device_ser *device_ser;
> +	struct iommu_domain *domain;
> +	struct device *dev;
> +	void *owner;
> +	int ret;
> +
> +	lockdep_assert_held(&group->mutex);
> +	if (group->domain)
> +		return -EBUSY;
> +
> +	dev = __iommu_group_restored_device(group);
> +	device_ser = dev_iommu_restored_state(dev);
> +	if (!device_ser)
> +		return -ENOENT;
> +
> +	ret = __iommu_group_alloc_blocking_domain(group);
> +	if (ret)
> +		return ret;
> +
> +	domain = iommu_restore_domain(dev, device_ser, &owner);
> +	if (WARN_ON(IS_ERR(domain)))
> +		return PTR_ERR(domain);
> +
> +	/* The restored domain is attached with the restored device. */
> +	ret = __iommu_group_set_domain(group, domain);
> +	if (ret)
> +		return ret;

If (ret), how about the restored domain by iommu_restore_domain()?

> +	/*
> +	 * Ownership of groups with preserved devices is set during boot. These
> +	 * will be reclaimed later by the entity (iommufd) that preserved them.
> +	 */
> +	WARN_ON(group->owner);
> +	group->owner = owner;
> +	group->owner_cnt = 1;
> +	return ret;
> +}
> +
>  /**
>   * iommu_setup_default_domain - Set the default_domain for the group
>   * @group: Group to change
> @@ -3233,6 +3321,16 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  
>  	/* We must set default_domain early for __iommu_device_set_domain */
>  	group->default_domain = dom;
> +
> +	/* Preserved devices need to be attached to the restore domain */
> +	if (__iommu_group_restored_device(group)) {
> +		ret = __iommu_group_restore_domain(group);

__iommu_group_restored_device is called twice: here (outside) and
inside __iommu_group_restore_domain.

Perhaps change to:
	dev = __iommu_group_restored_device(group);
	if (dev)  {
		ret = __iommu_device_restore_domain(dev);
	...
?

> +void iommu_init_device_preserved_data(struct device *dev)
> +{
> +	struct iommu_device_ser *device_ser = NULL;

"= NULL" doesn't seem necessary.

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

dev->iommu->device_ser is NULL after kzalloc.

So, maybe drop "device_ser = NULL" and move WRITE_ONCE() into the
loop (under match_device_ser)?

> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_incoming(&iommu_flb);

Hmm, you might want to check the lifecycle of this flb thing.

dev->iommu->device_ser points to something inside the flb, which
might be freed somewhere?

> +struct iommu_domain *iommu_restore_domain(struct device *dev,
[...]
> +	domain_ser = phys_to_virt(ser->domain_iommu_ser.domain_phys);
> +	if (domain_ser->restored_domain) {
> +		*owner = ser;
> +		domain = domain_ser->restored_domain;
> +		goto out;
> +	}
> +
> +	domain_ser->hdr.flags |=  IOMMU_SER_FLAG_INCOMING;

Drop the extra space before "IOMMU".

> +/**
> + * dev_iommu_restore_did() - Get restored domain ID for a device
> + * @dev: Target device
> + * @domain: Target domain
> + *
> + * Fetches the domain ID preserved for @dev and @domain across Live Update.
> + *
> + * Return: Domain ID or -1 on error.
> + */
> +static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)

"did" is an intel thing..

> +{
> +	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
> +
> +	if (ser && iommu_domain_restored_state(domain))
> +		return ser->domain_iommu_ser.attachment_id;

... so, it could be just dev_iommu_restored_attachment_id()?

Nicolin
