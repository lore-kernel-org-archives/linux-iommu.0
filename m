Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8C8C433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 14:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9456C40AFE;
	Tue, 10 May 2022 14:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cJnhv5rjzqYj; Tue, 10 May 2022 14:34:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 52D7640AFB;
	Tue, 10 May 2022 14:34:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C712C0032;
	Tue, 10 May 2022 14:34:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D767BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 14:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3EA882AAA
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 14:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KSjsdaGmby_F for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 14:34:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 077CC82AA7
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 14:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiqukb+FWJdGRcDPg1axDbVLDxpKDEybp7XdAOj9G45ALAfqU3zmyPAF+g18ZHlQZ4M+bv+x41L1scDvnQPqGKvOIwwuQ/aKiJCBwhVBdgq/9TwJDL2vVJkKwlSBIjTeG4ULQfYER06Yki9LvVAAtITz4JI/9p0mAMjEYNb9Gqw1mgyqjSozCDdaDCFPxn6nkB2v5tJ5O0W5rI/6XgV2OeZa/toXcfzNA3saXnwyOiA/Xw7jyp2BrzTlpxs2hfjTJw54j1GqGeACUlNZOicZ7yS/ARb/1qModSZS/mbFKx1qqFD53woNk9Zk+qOY/x73kF0M2H0Uda2oHBKIU7TlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4DtRP/5PtYFWpBG3TlhiYI79WN7SEw3HCiGre2SxUM=;
 b=RGJYX3NbGQk+x5/ym1YfT0tx/Dplwx6I0jrczN2Onvc9CmemTTry5aF4hZYNfwkXdEDlRNjVFO4dALw5CICSUyArArn4R3e94d+Z52SI+xZXWt5dcRLwhCm4kwBetYCXpQL0gZOxaMkfBnJM9CfpLvku6h/maL4KV1DT68Kb6S8nZMHSao+5kUtTQCqyJxWXoajVrO2syC/Yh7AU3lU4ZX5y6xz3QQAIFnL3njhD7fWVKYd8j9NtaKfAnV5cLz3PVHw5CHC6mJaEZRxeOKzjzIsrIqHwmAEtIrIGSZpMDR4+vMQnSuSlmNA5quQ6vJSv0UBzST/0XhtImdLK9bQ1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4DtRP/5PtYFWpBG3TlhiYI79WN7SEw3HCiGre2SxUM=;
 b=ZxvIeH3U8QiLwbIzsPpJnDVTIh5EKN7oRv+e6t+EeSxBaaEfwK5jE5k0i7xneBXAfTbPrKhZZUhmWyJAWdgqHjhwb+AsZ7rdBFovOLDhpsTZaH+iLVrb/1cz01uzZkjWZDZXCAHIsM3IKZnO4cBPdUv8+2yfTFHq17y/jj8yVEIJ9n3EOzRHA8ZevbNA5EsTASwtLdlmT6gyfYGT52QLRI2dZXRZ9P56WaT6QnodtCnSE1ZyCEP0uIdJNfjMxrqSo5AG0CmsMuZaf/Pun4xv3dtqzQ1GMmTp5u46hXqRKGwk3nz5MhFWEZCjlcfwJwYF2Kh5nPYwz6Mqwb4OTvuFNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 14:34:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:34:06 +0000
Date: Tue, 10 May 2022 11:34:05 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 02/12] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <20220510143405.GE49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-3-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220510061738.2761430-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e3e3cc3-f725-4f76-9505-08da32922329
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB373768412D943D917C7E9820C2C99@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZs4cab8ske7OC+S37VNsxIQpfDEliYbrd/4LGQcKKhiib6IjigSoAzdYjV21CHwx9j12WoTXH/mX5JkC+MzxEBG+T2W9BNb7JSHzpDBIRHAw/5W2TvQUrge2Ay9NCGlv37VexqTBKPTd3KxwjBaFBcaMPSToV1FvoSmlX2JnYXTFjiZ/GewJ/ICX2sgTgR0d2ueDPnN9IegyhiWgFgyf+uLer/hDhsaOcQkSOo9UPQewAl2wLp1EU317IzvmFicXjc+laP5ztspX8IY3h4r6cOUD88iuBANFu2DxBXCX+aZqaEcR9ZvktJMu5z1pkYoPxu8rGLhN1KJrMzfIOAV0oYTnsSGbou1XMix8imMSl4wMXglsPq1hkZ97et6QZ7l0wGAAFpJjPT0GxfvZ7Uyzqz5cOdwpvMq9BRpvBXzEzykuK2BQXNSAAiQMEpwupD7Dce8V5fZlOb2652q3FgJ0RxvPdedmKDnkTPGDA1SKwuIml1wJqqGK7M/oUL/WiW699lcbtD51pSnAko8qfiUJj0WoLKTvflidZ1dkRcoMFfFfSAu232XSZSkI1BHkMrczGEAlh/3W6Br7nPSsNPHRyhHw94YJhJDMSuqSucFVON/Ns7ucpTj49OVrKdhqZP6ET529pzTatSONHdPRUi25A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(26005)(83380400001)(8936002)(2616005)(4326008)(66476007)(6916009)(66946007)(66556008)(54906003)(8676002)(38100700002)(6512007)(316002)(6486002)(508600001)(33656002)(2906002)(5660300002)(7416002)(186003)(1076003)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+pzLiI6cpSyYGykE3fMna2Aom5U+6mT8ds8raaZE9HRjXfOHwsopHPZ4zJK?=
 =?us-ascii?Q?ihkS/BCM/xLnjejXWyk4z2dKHbFrf3MlMOtD6EdBnzr52eLD+ECybqbHhTkL?=
 =?us-ascii?Q?+PT/j8ySWOo1Fa88M3FtFI1BZKJG50Z2VDXNd6qvB8T7STcHW8C0w1euaUG1?=
 =?us-ascii?Q?GmjxqSBaU1t8F3K9b1TUEAvh3L7RloqlNLUyRf7F+1cslzZS5rZDSAePYhmp?=
 =?us-ascii?Q?sBuEuMmx1tBqecxWPX1F8nLlVkKNhvgYftO7SSZgUSffUNzH+FJ+4rPVeH6J?=
 =?us-ascii?Q?yQnG3r0UHH6ttp649ucN1lYZZYHmVAXFBHiA0uC190v5M1z2IM7lMY/fXmGV?=
 =?us-ascii?Q?WBH/8CXkXXBmvh3VH1VmXsmYLOgY4Yivni2wNQgt/fgQX98+3Lm5DYenNaX8?=
 =?us-ascii?Q?/0gdxTDx9ROHq7MoGwI32N4PAbPiP9579G7aCJDyhUEc9y4fv3tWuzZYMS6m?=
 =?us-ascii?Q?ucQTKqfheMXF428K8X/0FNdjeXYW34oNmLRfxI5BoKrJVXnL8uPpBKg1nT53?=
 =?us-ascii?Q?VRSNPf+1efiLvCnusyHkhQEU45kNLw0xYzRJ1oWj8cit/AK7pmjzXJSX101H?=
 =?us-ascii?Q?hjXlmZMUS7CfC4mcXPtjSKmCFoUdC11EqtgJPg+aV4UXC2EDfy0B1XqSDOGB?=
 =?us-ascii?Q?4r50+ME3z2YLk44T4odaeHgax9mDpbTOItwcT9QBWZ88sLc5RDe/NTHVnQGt?=
 =?us-ascii?Q?aN8KBEK1A+blfLeauid9v0/YxjIXTlD+7bVup4Y1IM0IcjSRDPAe5d9vDb8y?=
 =?us-ascii?Q?MnHgSgJHXdtfMB3CVuGL26AQF6PkWTXIylNsrKkerWirPzx58QUXYTvNM1Jg?=
 =?us-ascii?Q?sFyu8FvJwhZXmG/p8wNTyZDGFIEovn3jatSMmBY48bQlJgriC5liQMK8s8Q/?=
 =?us-ascii?Q?l9ylJD7eYtgGDwjGjkLt2QVSO8W0BzIKiCOjcsXsGYuAlgWVbhwPaFHIct5Q?=
 =?us-ascii?Q?4/TnQZiTRqJQXEwi8EzvhmJRsDzVXKH8uweA7yo7+TOVoexyko7tn2EPFLNM?=
 =?us-ascii?Q?0IioLEWPxe03yRxq83KAP73UVLWj/V3qDnC/6QUn3VOwJ+yYSlv0GhTN4ayB?=
 =?us-ascii?Q?EpVLdgc6leR/5WD3TsALrkYOkMwj4O3wm4XxIqLHxZgHDsugXJ8uxNOQBqHo?=
 =?us-ascii?Q?T7eNnHd8WbFUe4RVgLWFSbe+844WmR/1bfaBej8UcJLVcOFA4jcefvK4EVw4?=
 =?us-ascii?Q?tUMHMWCGOplv7i+S43E5wPyo68Urpb/AzxF+O8nmGDj7B0dWGmLnlRV5AwzO?=
 =?us-ascii?Q?5fKgE5lQxNJVh3ltVo7mD4fIpyLVDUwto/s0+ulkRa/LCMFGtqFTAAWvUXHf?=
 =?us-ascii?Q?Hn9qLXPXA4whW6VJy+H083MChyPQFZYNFIOInUt4z8k95VXQmqsdjlktDQqt?=
 =?us-ascii?Q?2aaa5rZJ20HyM46CisJJy7cJY+u7/5Ddt3QCTLqCO7112GvcqNZqs8kcF4CW?=
 =?us-ascii?Q?hEhy2aCBUvQ8ME+92NCQA/GRl4Oo+cturOrMNO5YzWctaR4SmFOClg2iycOy?=
 =?us-ascii?Q?ZP2VfhmWasV7rqGM2i9VMj1g2JFIW0NaDcjt0iEdJRVObNsvekQCpRvLvjhj?=
 =?us-ascii?Q?vDTH3qya6mFp22Yl0mKnOqaPK/I6UhIDGQJ2DPlf01AH3TKV2BMyoph5fBxQ?=
 =?us-ascii?Q?eF3DJnTkgMWkAhYpyWCuwNAbfNnma88D2eMCT8bwsc18ZeYqZu2VXQFcPWp3?=
 =?us-ascii?Q?/nQvyXtJKFnoWtKqU5OAgdSGQVwaFeDg/t2qrd6Rxx5Lw4D9q9yTMDxy1QbC?=
 =?us-ascii?Q?+ksdnGhoZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3e3cc3-f725-4f76-9505-08da32922329
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:34:06.4449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LixuMJZjbvb3Uyxz2g8mJJ1fRpCPOI5aMhBrsVTHwFFmYl7GWdkzHsZsoUPgPK1S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, May 10, 2022 at 02:17:28PM +0800, Lu Baolu wrote:

>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..afc63fce6107 100644
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>  		master->stall_enabled = true;
>  
> +	dev->iommu->pasid_bits = master->ssid_bits;
>  	return &smmu->iommu;
>  
>  err_free_master:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2990f80c5e08..99643f897f26 100644
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4624,8 +4624,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>  			if (pasid_supported(iommu)) {
>  				int features = pci_pasid_features(pdev);
>  
> -				if (features >= 0)
> +				if (features >= 0) {
>  					info->pasid_supported = features | 1;
> +					dev->iommu->pasid_bits =
> +						fls(pci_max_pasids(pdev)) - 1;
> +				}

It is not very nice that both the iommu drivers have to duplicate the
code to read the pasid capability out of the PCI device.

IMHO it would make more sense for the iommu layer to report the
capability of its own HW block only, and for the core code to figure
out the master's limitation using a bus-specific approach.

It is also unfortunate that the enable/disable pasid is inside the
iommu driver as well - ideally the PCI driver itself would do this
when it knows it wants to use PASIDs.

The ordering interaction with ATS makes this look quite annoying
though. :(

I'm also not convinced individual IOMMU drivers should be forcing ATS
on, there are performance and functional implications here. Using ATS
or not is possibly best left as an administrator policy controlled by
the core code. Again we seem to have some mess.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
