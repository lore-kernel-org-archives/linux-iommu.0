Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD61E4B2
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715525229; cv=fail; b=QFhkfoJqKkyVhNFcqStGuKg0MhkX81ZqfTTaNbSEe+WgDsfJDC7lKMIYE5TTI0XFffCvsxdsjYnug5v5MTT0DzVZNZadAUNYmYK1zwUBo2wVoAxasIuYjqvflDJD/TVk2fXvyplRDXLnTJy1uly1h/JG84g+YGIcYm/rbziBhx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715525229; c=relaxed/simple;
	bh=yIvkkR/kA57Rg2B2FIJPloyG06Sj6JCt4aHGQsKYMLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O5UaJpdAKJ8P6b0a+sAHDYpt+jhppZq9Jzxnh7gzPaQzggx3mx2Ai1hpXbFspFqhyWyuZHhG6DGQg6eDQPCHVzxNVlM6W/d73OZGtsbNmxdkQB6ydCUJDYpQiGhM1f4X408YuVXCTIEafJ6GgpcM4IYhcvScqjAyybiF6uyd4SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G6qtsV1p; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G6qtsV1p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5QrYCwTouiGMm2OE4gyBueRIaHZJ+BMGf/JvPcN4FufYkniU+zTihEtrk3AgrtDr6OzhfKtMYFb4n9L1GQwrYydF6ElOAF2ih8XGF5AgIWq76loU12xIT5gnvUDZV4NcoNu+DCX1Q07/HTlRahWjHx0uynVrpp9AwN7v972pXn3UT8+aU9PhVICT06Gid8mZ6TDhhxQCi8JOsO3hmKgeZ0+etTqwIb7qIUP7YSi6rMoXObgY7wnqn46qu2zusaxovH1nQ+eEu5jS8ah4i0kNzO0waxGHVWdGkshjaaOMP4lQwM78jBiIGWWAlLSFrFhv5ZLGPaSzFvwVaiZTLQqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoOuPDWVs9XAGzF2YjvsrDtP/fV2ta3YQMfgJgExx6Y=;
 b=JjPHaM99sJ++RA7Un4OkscQqG9IB/bDdzLbHGAGqLKXM1m3y7d7ahnC2ONhsuiKESKjYC85pA5wsUhY0/1DERGCmnZ52RtBAKn8GW+R1wG11G7/ZCWUe4Dq50A1z1Vq5HysgdU9Q23ernv/cgcEPsmCKM6xmqggsIh7TT5CG/tji168pW/514j3xC9yrD55bzBW6sIEOJSQTebvRsjK6pecMb/cDcnqOW9RCN4/sIJ/dCDKHWQirDrmtNMZ+gTdGkBncuCq1hDYiPnMRGkrt4hTGIiwc//zpjJotDXlV2VZzRFRBDMt83DKhkm06a7QRWjNtQwxG0sclo0F7oIWajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoOuPDWVs9XAGzF2YjvsrDtP/fV2ta3YQMfgJgExx6Y=;
 b=G6qtsV1pfl2RLUcOfnX69sDcXCsGyYTbCwkfO8o+xiXkY3A2tijiDJqldSq0CJgSPDyNOBaF6WlemnguOCT9ASWVUYjaQwNisvmb1R1aFsTQptDTgQ6FxZEcTcFd0qSzP4s/HuO/ma3HpwIYQO7k4536gqvGme4mdZ3M0lpmcnKaUm5sBs320dzJ1xB+Zvp35H/qvSImXfzCC7W8eGv3ocZKHXqSuBYN+3GfyXa6mGa65py9hu7GlfrUtYjA/pIuxFVH1X1OTbNlr5px2x/A2LYaP31MHyxzChynYIBDMmQfwMnXl9XtoM9mB+Q1B0xdBR5PXs0vSnswrfXGVq/wOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sun, 12 May
 2024 14:47:03 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:47:03 +0000
Date: Sun, 12 May 2024 11:46:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <ZkDWXnPW7CaX5TtA@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BY5PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:a03:167::45) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb26b04-7b5c-475e-e3b2-08dc729262fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TjaRmefPxM2HBgNxvar1gxEh6353RGbXxdTKSW7tTEj8aH2hVKOlV6+hmC2A?=
 =?us-ascii?Q?fQB1oCQLrX7NxFAqmYZZkgJwzrqX1ZdNhaSYWi7zO9TlwBFAKpL9Er5J8cP4?=
 =?us-ascii?Q?8+oyVmtAse2QoquRp5Olp/dyrO25pZeJiXVxnP/zBzH8TxVy2etLGCF1EJEe?=
 =?us-ascii?Q?84wb65DWhkLzTlT4nu/wV0nL9zYf+db/gecfZIGz4u4Fait41qzTsOKBQ1fv?=
 =?us-ascii?Q?GSU05idQ/rsHfu0tP0QAHY4f609jA0Tr3crRL3/LdQeZVYVWVLaGIolGU4Mi?=
 =?us-ascii?Q?Poh1xJRzoLyzQkAJfH39+S99JTihhvbRKZqeled6b+KoiH8ev+7K2cpVg5Cl?=
 =?us-ascii?Q?tDq/2v5QQ7xLI/XnML1PO8GBa6cbf0dkNlPgfdtDc3Eyb33cYLOsEZ79BkV8?=
 =?us-ascii?Q?4kcW7LQIQlHFwUJ6WUcvu0d0UeQnXZUMGCtzc2ANH5fn1ByLUTU7TQVIa8Bn?=
 =?us-ascii?Q?vBH9/t3OpXbb6bZR+ZOqB41Z/2tqEZh6z8F8yNzfHOega3nMVLG2V3fK01pC?=
 =?us-ascii?Q?GEoU3lOYcqrz7F9IJLBdss5XMfIWyG0J3EBLVsHL6sIkFhh9r94Iyhx4Avpn?=
 =?us-ascii?Q?72zekEPp5sd7Y99HkethjddMxczumrmfLzmHhuQfkPiIRkyKsxfTLW59MLrC?=
 =?us-ascii?Q?5pPhhL3m6C/SozLX4d1dEj3uXq946IRPrirPERa4tVUSBqPW3/7hqSfBi5bF?=
 =?us-ascii?Q?MQF6UdR+b04GvdCtVGQ/oBVbXSqtVJmvJ/ONCDR+kWCqs1lPbbbmTC1UaE6D?=
 =?us-ascii?Q?IHZ1hrRE20q8SAfghsOd9xkL7mX0/q1SnYBswx6gI6c/B3boGN7r+151jbHb?=
 =?us-ascii?Q?0D41yyYMnfMUmWAOS4CEvDyaF6B4xWAOu0iL5A4ulVFynQmC8VHZVBK7n1CC?=
 =?us-ascii?Q?IkbgNOLmXhTY8M3R7sXhGz3oIbelOYlWj+h+Lt2Ke19VpWdhtnz2mGZACjr5?=
 =?us-ascii?Q?JnemVryl64QGpCTDU40kv93C8lptQZFOhmbq8MPBsF3iIPlnn0PdhYrUVyLO?=
 =?us-ascii?Q?WNY5/d5VTnzNQY6fIDHI0w81XRs6Es1+E1Nw+MbeB42f6Yx1ulGZuPrtMlfN?=
 =?us-ascii?Q?xQnQoAiq3nwJ+X2o2gYox8h5q4Gjvt0b9P9EIJYYgFjbNeyX0sOjE9K7QlS7?=
 =?us-ascii?Q?x+eneMWVfOXxykNB+g/RW7UGHYJVYDnuvjHGtV9Z2Z3UaiFzmQdOrR/KY7Eb?=
 =?us-ascii?Q?wqgYbSviuAysHH7VuYH+A3oYCQjw4MfG8QzuDsNNLRdmP2fqERgMDIoRIYSr?=
 =?us-ascii?Q?8FE4OnP4OzoNe4AxZUQtCtN18pIVo6fIvjr5rmEibQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqKxwfkGHsfKjxjO56C10NlARL5Zxg9WbfMkkcuybX2JTwumDBpIMUoRlW6U?=
 =?us-ascii?Q?7MMYjPW+1PKOyaBtPm9w8KyiBdvdLLL03+SFbP/SjLA+QmR0lc/JM5IFR1gv?=
 =?us-ascii?Q?4aai3jX6Vi1V6bB7jrPRV29cwWm8Z24OdZkYXm3RGmZ+FdCfTqhHdVWpT/BQ?=
 =?us-ascii?Q?BURd/N/BACGhHqaZ/eU5/EaVvGXctnGWkdQg0TYZJDmp1K/MGPV+vYvyTWWj?=
 =?us-ascii?Q?wsHlGe8r4DHmlrls4O2tSMMCaFjLPhOXZ5S27SSZenfaL8ASN+7vlaamAjYe?=
 =?us-ascii?Q?r7xmZW7eC8osKIiFs/A2v+hsM63VzvVB2JQ1tNEr9aMklRjxYppsfQfVdD+3?=
 =?us-ascii?Q?jErzzmMJJR2aQIcJ4cZ1EdtndkNGv5WtoapnPS/Jhv9D/0w4/GhbooGqPEsj?=
 =?us-ascii?Q?h0W207EECWXyFVnHbIbqPZ4qPmsIW6okMXt1IEqzfcyXbjAUaJKuBr32n6U4?=
 =?us-ascii?Q?T29zeNlwXOHV7oB39S+NS7nEjz3jVrNJQaQQsgbtyxkOI2LQYsafpSXePgad?=
 =?us-ascii?Q?Lp0uU5Lb9f/u4WLFsshUcn7QaRbvTSS1G+QswntqDPeRnWAJuZstYuaONn5v?=
 =?us-ascii?Q?e/tA5jUJIt9cOTVOW3OYHNUX6dAEazw+menvkpND4RSP4Mky5GHF1VWTIZ64?=
 =?us-ascii?Q?SFvh7Qaw0DueljZ6HnHxXyB7cWqdZHTsVReIQmkvoej7hh74nPA73FSJ57kS?=
 =?us-ascii?Q?VrahozVgXy9fj+KiPHaKEcykkYrk/LOToiw5nvknOESmPtVQKe929nGRMKda?=
 =?us-ascii?Q?nDfpmETuCjdzwO0MenWLdri3qjkJQAhvh2StkrL0C3SBNRy5yptZYpOFSXzi?=
 =?us-ascii?Q?FdYNBWEQFGXPs79e53xGnhQYmmjcuGtTisQCpnkVDoQ+16Hfteh6r3A3PEOW?=
 =?us-ascii?Q?2vR1rvWq43oYbVOB9+4qgtbPOEr+oRnM9qtcEVpaeEZrjf+BYQ7Oh2bm+lkM?=
 =?us-ascii?Q?oRv7IXOmp7czvjGL/wZXtK3JKV6S0GmnqJkDAtdzAxzcOpmDogCVMdC9/zR5?=
 =?us-ascii?Q?+7SXVVehCK+lUfd855E/hSaGSltuFcuUovpsKhHJNuC2oBeNNf0XFlWsox3O?=
 =?us-ascii?Q?sCiGVkooKpCMW14ml2njW+XG9UVdEJeNjXLOI8n3owuE6KIBpFZ8n96phIcZ?=
 =?us-ascii?Q?CN0VuRYTfXEXbkXoafvlsmDLvrc3/76b1r+7U9VR5UVjqoaGXSlTUd0NYaxo?=
 =?us-ascii?Q?Qwda0DiXWCvYn16wJUFQQt5KYkTpr5qX2IS4gsz/SqfkdrtZWXfx+DcCUb5a?=
 =?us-ascii?Q?QtiQIQVjHZC7ISUvnSdFvR7onYJw7b/91fxY2NH/f0tcdUBVFMJelDgSXD5z?=
 =?us-ascii?Q?3nc5yjIYzlQfVVaS9lB83BJaTpFBdG0tvWLpOcSeN1mp2A9BlXVQ9633phEC?=
 =?us-ascii?Q?EdJ8xMqu3UdldOZCjRAZhmGbaNAi4lDG4LFfQI5rn9cjI9m9WxO4QpmcpSLn?=
 =?us-ascii?Q?mDCKFEhlqmmU+StDRibyZL9DRPM9W+/+DihNiDO2mkSsVRpOnZ7ScWU+h5As?=
 =?us-ascii?Q?AVqjsaBsPRNORry2UyV58+FpKyN4Q8t6gOdWejW/jX3CXqwdRgLsW+eYlIWi?=
 =?us-ascii?Q?yEKIsrnx9vbrnhvPNmV/8XGQcz5KONPbbOKz+MJ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb26b04-7b5c-475e-e3b2-08dc729262fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:47:03.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3dLHrxErSk2Wdleca0WDz/Fp0Q/ciXhn41VtZm2zm7EeYiLp2jwHa8CCOwVpnva
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

On Fri, Apr 12, 2024 at 08:47:04PM -0700, Nicolin Chen wrote:
> Add a pair of ops to set and unet device's virtual ID that belongs to
> a viommu object. They will be used, in the following patch, by iommufd
> to support some HW-acceleration feature from the host level.
> 
> For instance, every device behind an ARM SMMU has a Stream ID. The ID
> is used by ATC invalidation commands so SMMU HW can direct invalidation
> requests to the corresponding PCI device where the ID belongs to. In a
> virtualization use case, a passthroughed device in the VM will have a
> virtuail Stream ID, used by the ATC invalidation commands in the guest
> system. NVIDIA's CMDQV extension for SMMUv3 provides a v-interface to
> execute the guest-level ATC invalidation commands directly, yet needs
> the HW to be aware of its virtual Stream ID so it can replace with its
> physical Stream ID.

I imagine using this as well for the ATC invalidation commands. It
would be very easy and simplifying if the command fixup just extracted
the vSID from the ATC invalidation and used an xarray to turn it into
a pSID and then pushed the resulting command.

Seems fine as is

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
