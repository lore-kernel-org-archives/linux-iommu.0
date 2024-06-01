Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458114E2EF
	for <iommu@lists.linux.dev>; Sat,  1 Jun 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717271892; cv=fail; b=nJw3mKYRnzpSH2qs0sCaz36V0q8ATxhxVK55YvSoddGcKstQyqsTv/NfPPqtOWElq4sJpZ+RU48scXVVIGqW4dMJeoI2MfhY+BGxAJn4eub+6iKRjg/lyo61cK3tDfDwft/kvYieqeontLfu96chySmsTJxNEjlBmxUw7B2i0NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717271892; c=relaxed/simple;
	bh=Aal+N3gJxX/TeMEAZMH/qVXiKL4I1aJoSsmbA83j5VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WCT6PB2uUjEizUuV7qpW0hjyJL231rfDCgu4MMMiEgCHpKkHl8yDZZeOatFIr2KceLiSW6+Wcd7Qs/QRH7Va3OC31m91bhwoBEQuabzWTLN3n6496/2NisoCFYSe3o8KXuAx/jql78ow588nA7akU9MVr3qcMS0x7deGa4Po6Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T/BosUQ5; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T/BosUQ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTVkRMMPrBN9UpXOV9jOnOAD8uY2NeJKB/+QOYh2086iycbbzUHGLsLp2WCuNTZcjWAgc4VJM1PigywpZTZ+XyomTg6YDqPzCsc0/MqSUhV+kiwwaK4PS+p/uy/ecmJKO9btdJiFcThytRzHixBMlQ+5NT/LrhHeASb9nIJPlcRer5ujK+wdnqdxgxl3T9cxooGxvuNW/Xa2qOvQPYnF6kEYu2MfsVAAxh7REymf0eE6/PyVH5z1g1TYya8PdDdlrHdZvpc/SfIpoMaV6GKFFKRSnhHMMkcRcFUWuXvGcrdNE3CtOKvbD0XMLrFTOzJlOGhE6v9juEYCyiTQW5lHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aal+N3gJxX/TeMEAZMH/qVXiKL4I1aJoSsmbA83j5VU=;
 b=iG1DC/tjbZWlxFVAPVZFw7t06LgJu4dyfsHXGZXl8N31ssi8cPdsWUa8jNemMyu//XqqxfIfYU5FR13bpnGiyOpkoS1DiNsqer1OjSqvfZiOYDcjwV/I4V0jWUgvk/Y8vNGiuTxupwwn1D+U2V/+hb+SmZz052mto5ZEXAX211hNAkimObSO92/sUVUUHjLhkUsZzaJhGJLX4bmOffrpsbUeo+l4Tp1o2I6LBEc7brS1GcnJkLcnlZfDfkWE6AulG7gM+TGyt+N22Ht6DgWBUqenj2J0V6y/lKWt7uPlFLHEgEaGQ/ywy44NgvtMzJ8NW9oMx2I6Pdsg947HwOQGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aal+N3gJxX/TeMEAZMH/qVXiKL4I1aJoSsmbA83j5VU=;
 b=T/BosUQ5t9xeqcxrfKQSOCnt12UsTS5s2bbz3OuxPNZWtMWUSszjVBrztKJ4E9wk0tpgQD9YpHusamwzhXDsTGXOLFABIISYNcuyoLE2Kb0BhCsLD/lmuprEJXP0PcY50cG3g9Yj9Y+9CKV14Q6VGwYFXUuXGS+hnO/+VwUosieXLfngBKB1dAcLvXuu5EKbl5vyaNJ0MR8Jta1APwtXdBXQwk2JLK0XCmu039F8DFKHHuDKyHHHN2i9qlhCpohXINAuvXepX1qhBHf3cxXLMZEVcvPY+iglPPllW9z2jySPVCTU1MsJP8eZelK3mUk95XdvG+OA/v1uBRv+etJjPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Sat, 1 Jun
 2024 19:58:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 19:58:07 +0000
Date: Sat, 1 Jun 2024 15:55:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Message-ID: <Zltus2S3qf0I4iaA@nvidia.com>
References: <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
 <20240522175053.GF20229@nvidia.com>
 <BN9PR11MB527660CCD250C176DF86F9EB8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2d949dfb-ea40-418b-81f2-f2711b796d4a@oracle.com>
 <20240524140754.GZ20229@nvidia.com>
 <BN9PR11MB52761D4122B818A05B508BB28CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761D4122B818A05B508BB28CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::48) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdcee89-3c3a-4c85-9a3c-08dc8275283c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m9PLjNmER8S802da+bLx9b8UaQTYEsdZefWvlgUnh/vxQr8/Z8nsq6LZMxP6?=
 =?us-ascii?Q?JjtGddI3revruQIJh3WTV3tLq108JJQ2L5305MIECHXZ65XQCKzTrQhP6YtT?=
 =?us-ascii?Q?rGpZoJVg59eLULlUugqgQoV8jMQX/kpOll/DcFfSJvSn33BNxs3DvXn7xMeP?=
 =?us-ascii?Q?GNk29g/7byhBurLW7uYz5+BHyCh6rbPziw1Qi7DkcfB4fcm+O0Z3wNeL1rJG?=
 =?us-ascii?Q?NZsnoQYApGKwqzjkNH6BGstxW3LJjmiKLZA9456PpqfEjNvh/upCJ4sUZuTK?=
 =?us-ascii?Q?T276yYAHDKQp5Es55hnxXK+mvJVRhmxUvo5J7GkjafqovM+KU2r10KvJh0fE?=
 =?us-ascii?Q?x65eF5a0cOmLw+cgX+ZNzhJoe0AP8HCBiajHJnoKECHbO1K0e040N+F/Nzjr?=
 =?us-ascii?Q?8BkBmSebksXjJF/uNddcf/OB+4fVuEbY7qNK2IfIGeqoMVFXKFWyBGfqwwnS?=
 =?us-ascii?Q?zhWPtfStY9lP+dIQNYWJEl7tZ60IS/vl5GVpo9o2E8FpgSBsa9H5+j9bQyku?=
 =?us-ascii?Q?s+tOSLbwTitSCPICMt8UCezQLOpCEVlEz7xjXTz+DHANczWLRbfz5uuSKY6L?=
 =?us-ascii?Q?ui1kPM3wnAvI3USKuNcI3vsDkXBsG/DuEEZ7EeKlgFoYauPpg2V4/ttUqnS4?=
 =?us-ascii?Q?uZnmZ8mI/nx02Vy0r1eMSdWP36ZvBL5rvrEhe5TfeC49z5Rk+hPOtisMCjgb?=
 =?us-ascii?Q?eQFk7FnrTyQdeRxjgHHHcdxFYduqbB1euplN/9Nv5jYAS9RS/ViBScd8FWdn?=
 =?us-ascii?Q?IS5rZAj188axzsYJgZ56me5eDO2O0FSo7qIvohnPiN38tYfIPh2T+SzqcMu4?=
 =?us-ascii?Q?WLTatyCPcor7hbDjdMVHEjrJ0DYkdH6xZCg8bqsanJSlA2s+rtNRoFMjFJGv?=
 =?us-ascii?Q?fGrxbxqu7G6Y9T8GxStIKtdW1FNWkGeGjST/93eAHzMwAC0pJDNjusFFTPje?=
 =?us-ascii?Q?wUF3VHIKVJBTXmvNf65JawWKPR27JVVOGcVrVb0znec6J+I/fFzPYE7qfwiM?=
 =?us-ascii?Q?UnsIaaKmZdnjdUmVKC3jjZGDo5ZMWgfmyv8WJ0yI/92L8HBz+UBuy1OqV5vC?=
 =?us-ascii?Q?vzVJihDLo0RdxjuY4Ifit1K0kCSkklyuR4iecNViscYriBV0JTY4JKlhsdRK?=
 =?us-ascii?Q?687pSMzrdH3H/j6D2kTfQem9ItQZ8uXOsefo7gn96uXZG8azckKXyEDPsSsW?=
 =?us-ascii?Q?GEpfy1bY+Cn7vGXo5R7LryE/MJ96MdrMuy297gwfPa+DOYGiTl7mhSNtutoV?=
 =?us-ascii?Q?7VPnQQ7E9yq5ghMHXegYZtdvajejvFbeMCzBq2YGTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oW+D8IKutIo/bC1hkml6VZJE+biSM/Bfx7sG6UvYubh1TSy5q1nDN7Rhf8sl?=
 =?us-ascii?Q?uwMV+/CjmgWDZRM2aShepWwIcpW2dAjB+HDSqLSguAp1nUafv2WDLpyy+bni?=
 =?us-ascii?Q?HHOlHIJ5wTCzeMVMo8g/7TFzXqeXKxHHt4zHSR1BWHx+mdEJJJbIa0zk2nVJ?=
 =?us-ascii?Q?Wb6uD9fORP4M3ZFrNk/QtvFwxfr2XpK+sNZL3ItA5ZbHah7FMaszO35Hgp00?=
 =?us-ascii?Q?Yil1L00PtmkKJuPz8OhhIEl0o7PH8ll/50u99l/Oz2I2Iu+lQqZkiudChHg8?=
 =?us-ascii?Q?+000KJ5zMTnj9xviIRddqLD2/uKYvueHeplfjV4KZK2E/nBq1tgnU6JAv4RJ?=
 =?us-ascii?Q?qNlOgClDRIeig8rjGBQg3NNJjdND/ppMj0ovCuMz/Cm2ELb+3/7i32z4qm4D?=
 =?us-ascii?Q?b+wF6N44Sdt5Rhs70JZjR07vLgdP0mMnZn0P27SoMb22rYOnOVpkD8/6Q9Yj?=
 =?us-ascii?Q?3b0luwQidClOsNcPRWwOf52V9VgP79qa5b3rjJlPsTtPw4XnyMf3iN6EnUnk?=
 =?us-ascii?Q?CQ0Jec7986LJWFQpqD4X4T5VutZHMOmLbaAiCsC1v8b8vJkOShchpUgDvPLz?=
 =?us-ascii?Q?wQxOKXCLxj7NOh0unzWccEF8wgov0R87PNwcPRhi85U+lVpLNXFj1egDTO8n?=
 =?us-ascii?Q?bQH8BH+OKOSNkH3OjM9kF8YrYlWOPcQIXrG8HVestW95EiUbch/egyn8xTLj?=
 =?us-ascii?Q?AZbqx0aw3v+PucmYa30x1oc76qZ5+RySubPH8Jm01qH3MZ2HQbcoUG27i+2d?=
 =?us-ascii?Q?a0REHBeVHkj2JqZzm1/q4JDLln4Tn39ivpoWcqk5QJtucc1oC0HiiROsjJJZ?=
 =?us-ascii?Q?izYtifvdvouAejo28OnBbfstrrJoqQ/D/PuhzhqXc9dFMAtw38LJ9pyHGPCb?=
 =?us-ascii?Q?GzpBP5QxztUbojHBFTk10uF7YTGzJhQVxDp/CrEhtLEcoavKCmO2IOUNVazt?=
 =?us-ascii?Q?FuS2SZWhUP1oWWq1LSZ8npUynSqSpKeW8z1k2GMmhX8WSh9LvPzyoTN1FXnp?=
 =?us-ascii?Q?t5xhEHujq37fcgeDpYEEVvXE8TNnME4egvYuXWqQWBFAZKQ4LdRnlqre2SEd?=
 =?us-ascii?Q?VV27CQSJz0vdirYpf5NNwUtgmkCrXeG2Q1zyMnbztrq+3SR6cU6xsFkXaRST?=
 =?us-ascii?Q?WO8lETB6/kgspp7n1pPduWXyHF1qJNd1DeVYwsRWRsRkjK/JP345ZVrJzfzt?=
 =?us-ascii?Q?7rKkR0vpXfy/OLxscp6tB//ljPbI7mp7pO1TEmsyOIpx6rxKcG77VoIAzHgH?=
 =?us-ascii?Q?n3aIHtTokRik6PMT0A0sQTG2rfDMobKUaJI0cx4mOXor18CddbR34Zi64oz4?=
 =?us-ascii?Q?2vS5YcdDQPUYxtCm1jLMWdennn1FxRIdPcbrKetvYRF/C8N+JR5A/w5cZWDo?=
 =?us-ascii?Q?Ck/8eCiawLRNJkPY6l1jMbiXX2ia18OtmIVtdjlJtY/ZNW32n2/4p7VS8rdP?=
 =?us-ascii?Q?0THmBEzJ/ZuOUMF5fpvGPmakieitOceSxJ4uqQ/1eIIzx514d0b5x/qmTdvX?=
 =?us-ascii?Q?zjCg/59obEQlp7mrJpbvnXPZY/6zZTC6HbU9n33HmLZEyOzcehXnVp+QSoFO?=
 =?us-ascii?Q?tWGSNAD3VZfegAFSbe65FzI+3kMQu7y3d6WrPear?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdcee89-3c3a-4c85-9a3c-08dc8275283c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 19:58:07.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlVr4TpDryWnoDEV14r2EACox/mz0ivbyv+Sc4bmdD+to6cte5SdmjAhQu9HobIv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

On Mon, May 27, 2024 at 01:21:14AM +0000, Tian, Kevin wrote:

> emmm there could be multiple domains under a iopt while the dirty
> tracking toggling must be done per domain.

For some reason I thought we had made this per ioas, so yeah it is not
right like I showed.

Jason
