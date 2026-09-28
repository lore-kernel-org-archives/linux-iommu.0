Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5C3A9D90;
	Mon, 28 Sep 2026 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621310; cv=fail; b=ND4WfmiIgH40pRYZ9zmlB9etIN82krEoPk+D7luI8doy1LiOCkGuU9K6KMYCdZ/4kN3e52cDY5p6S5tOPCkiSK243SMQef4Ndj1fBuZK+R0ZXneA6eb0ZF64dw6semNuiWNIKiMdIu0Yn3Y9LXBY7+K/7CCd7CEwXEi8Ls1Jw7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621310; c=relaxed/simple;
	bh=eTnU6L1E6UpfmMKGspuSVglLAKgc9Wf09FmItPFT854=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0MQHDk3rlfbs1MiegrvwMV1O7YKz5O1uWylbtbMh08IsY7dQa19M5fcNnZCZpxBlTIIX2lUKRtCkCChCx5Rd99Rj8vT00MlZDIpUZxvH9Z1AZ5iGtGGlJFdsP+Lc5mR9QoHaLVvReab4SyE5J6yJbFn9u1zGkEMn+RsZyZhhME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DahIoI5a; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DahIoI5a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uL5xNimCRYH380ik1lDTUao8uf8dSjMX3T2rLmBQSPU+VXyL0l1KxY29oZomM9At0Y0g89eOFhemJXzVn2xxFTD6xAPoYn40tzm9yoOjFw2mAk8/9ta0i34as61Iblq7NQWp1YRt4NyOQaB3BNPMnstV1kaX4BEyFNthbtnn1ElJQT+9KLfa0rS8HmUrcAFzoR83V26kloGqnFbbfGlcRjnHifdxmYLUkVkOjWti53tgP1XZGOH2iYjcMXKUBzjYiasLoGafmfMR+ZKvx1DF5ZQkWQ6RGuALYSP94TtM4IWhwg5s/v+0llSvC6edbYTaI/hU//SY1U7SwD6i2fcd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnbzCrBsTbXPqso5ihCwGtl7L7qiy/fAlDUSMTYgKX8=;
 b=jLWp0lgFgAM7R+pdOz+mFcIGgkwpRE/5b655wOQCIByy5jE9OHKA9uBdffadjVyUR+r+JFH4YGYqf4Ns0vCFvGrH7KEZFL5a/xlpqnwT0K9XVdJ1DySogZVEGeur5Jk3Pj4HRPViziydIPmLdgmGE3h9IhQW5rHAzPvTXal5moGDDIsiXA7TbKLwd06ueeLqsqMp/HTgTPG8CEDQrsTrIsEiftRkQAmxgbPx0k4GqRgsroDDHuR99XvOnw9v9FGZ7A77WSgUb9D5L5DqTm+09ryvcVcxsVzMWYF/24bAkr4Z32YNqcywMo2VmtiCtqrpIT4qYBHCPhJrsuejK6/zNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnbzCrBsTbXPqso5ihCwGtl7L7qiy/fAlDUSMTYgKX8=;
 b=DahIoI5ay4ZiM7a5ZIm7l3PFeDqVWVVHsWVAcyu4/9BXwJTFm6idyoI6n6aVny/OfKvUQx89C8c8wtoP262W6zgqZDUb/Sd/7cVktV2VvW5rFB8XdYTA0eLi+kx++smffwRWY4f1cfWGnX7Sk/RULEtkbWkTDRX0p0hzjrFVxKzlbjmHGTxQAXWs2vqV2EGdDf6/xFT54km1MbH+nO9XAYclLXvY04MGHrmQ/vwjwB/a1/m2IiWDDXwrtY+lMn865Z8fcZvAdOS+xnYQ5FICc36XEmQSjvoHcs2OCfJvmBWUGdUeGOWtkquJAGS4EWCXRb6n+3DSlZhDo4e1krafyg==
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Mon, 28 Sep
 2026 18:48:19 +0000
Received: from LV8PEPF0000006C.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::68) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 18:48:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000006C.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 18:48:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 11:47:44 -0700
Received: from sonangrm.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 11:47:43 -0700
Date: Tue, 29 Sep 2026 00:17:30 +0530
From: Sonang Patel <sonangp@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jonathan Cameron
	<jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Nicolin Chen
	<nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, "Will
 Deacon" <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, "Shameer
 Kolothum" <shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini
	<pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts for
 vdevice providers
Message-ID: <arq2Ql3-q9EApe3X@sonangrm.nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-12-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260917140159.1163281-12-aneesh.kumar@kernel.org>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006C:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e28e56e-57c8-4b5c-81d5-08df1d911091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	x2S2aLbtgJ1WEN8NLzW+wSNZz4CAy38VnWOtWcLsBlw08hu21zDhI6ZIt1EDdH6VaRgKyPFRtz1wSDG+jD4ufXMjnUtm4IXpGwQcKzZJM2ayQd2iZ1JPIC1DilmqUZeNXhv1xXirzw7HdJroF2mHkp1SkuEox7B1mrV51HA4qh3J544P7lVXD7s60QytlXn8CSZ4fGyiTuEjMqi1Pn0Rp23hKHStGEV3uAmLfEIkjLJges7T+Puokxs8GbTpW2TMBqX9umimgf1utiuqnBBMM7k+QMeFp/xVrU5QvrbeSHYxJUheZuSWKaUESG22W0Mv28QEGJNJPqVkTf1cfyDsqTJwLAz/cWodaU63gomG3QXS+ETp29O0+5FGBrauOSzrPihjZ7C0sKJylaQvzGjDMNrFYKrnkMc0FCAMy6f6LHNXaB01Q03/rx661NZXgBgTqoMRw1M70JfFlpMaN2+E/+YibI9BC1MyKDDxGGhSOdOCjkA/7PyzbHLeCwNFVPF1y2KswgSs6/ZB2A6hj2bKFxXYOSzj7d0RRciWGqqBA+foHVFbK66uCnQi6Gb7six5hpAPWhVh7BLquqaD/LDaMj/mGaO345L+fuviFCKdH6nloeRdMJnTT+Q6xOUWFdvlUBYmPPcuzevppR0xrTeXae8uaFg+89ME5tox1QhL5khmbW1ONkrmWX7bzNv3Rm2yxd/ktofl7QtP/IKdMp5ftA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FAQclJpiKjRvntL9hZKCNRc0ifwPLcpWctEk5kIGdp4Aks7j9rH3YLZSu5PRnOM8G7/iy/b7e6uUSHrXevVzySnICfcf25xbOP612RqudgpOxUSCowmQxc/NNnTKn6yN15zHieZ7NCxHboCH6ZLXM6bCAOgy0G2lTYY3AaaIBqWmDzSJKEy/eO/nlqntydeIQ6mv8WiUJlK3fzW9eyuv0rMzscXs71/ZNjPA1ncnLMG6N4dQRuk7eJaT1NtSWvU0Eb+OwhQTtFdWjlSo7trgCq64ppng0xs/D8tcn95urw3GeqZhM9MhSGaB423P8BlMchstdL1Qtp6/nqaF6rYToVuHZSHvOsbU9Fyw77pH9HxWFDFb3dNKXinBUcU4odZF/I5kdNXO4KjPMzEvE+GzEkbUDNYyShDrV4dv9UZN5er5EKaBLElSo7wXIhwsKB+F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:48:19.3460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e28e56e-57c8-4b5c-81d5-08df1d911091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929

On Thu, 17 Sep 2026 19:31:59 +0530, Aneesh Kumar K.V (Arm) wrote:
> +		if (is_pci_tsm_pf0(pdev)) {
> +			if (pci_tsm_disconnect(pdev))
> +				pci_warn(pdev, "TSM connection is still in use\n");
> +		} else {
> +			tsm_remove(pdev->tsm);
> +		}

What happens if the PCI device is removed (e.g. sysfs remove, surprise
hot-unplug) while the vDEVICE/TDI still exists?
Since removal cannot be refused, should the remove path still force
the unbind/unlock?

Thanks,
Sonang Patel
