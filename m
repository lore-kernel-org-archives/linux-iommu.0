Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC22BE7C6
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286956; cv=fail; b=Ap+XT+JlTnLTzLT9yvCq0qEEAd/oJteVkHqzDCxQ0HcfNVRkfYbfKjhB/VaHKDHhQn9Lv0hmwpZWLdVCLKbXMghSlzi2I3fNhILgJ0tul/8/aqq4mdbiSEsV1TjGpmd5039fH0L7Vz469jcJYuLU3SVUqEoaENrUMZmkFzAe0s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286956; c=relaxed/simple;
	bh=4lQj/BcXl99hZloZn2aKbWSj97Jo9gvtxnEHg71N2Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aWIF8Uzr/vw9piR0Dqhc1W/IfCcidm/VTpNu33iZVYItr+k1sCbe1xENHc9BACT4TMoMK79QLsxjmdoOpvEG9B+nbQqNGp4Swk8+YCnbCXogoIGzEAOaH6FwahW2GrXmqETpPOuimWrJc5163k8c3uODKJKRYpbb2Ec2BXwt58M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UkHaIfsW; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UkHaIfsW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEIKYf0uI+P3MMJfsOCdz+FdsL/HJ5/F5XI7Dt34LVObyKbCg2Nl6aS3fLqTqsSijbt42X33yViGq1S1N970QUWLAoynd3ubn3Mc82hscK/lvmb/9D3MS37JyhprACo/ivii2yYCpU+9QGERMccWCnbgxO8puYXS18BWdZTGtnEQDXGp2FHsEe31xg5f9tRsIs8gH9G4s5WjG5OP2ryvRi9Y1IWJyhkgzl2Q3fAY5qk3O90IM/DHDgq/j+NDg0wh1LPKmB1voVEyECnLB0KXrN4gaUF1hdg+M42rTpMUBYJTn6q3q6Zlbx1Oy2blFeJFW0inDjy1CornEEWrVwTiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lQj/BcXl99hZloZn2aKbWSj97Jo9gvtxnEHg71N2Kc=;
 b=BMwg1ChqCaKxcUaJDEFVp7j04tx3VpH1ZdK/7yZtrDb9/Pii5NzRndJjx7HRddOnteisVwzRHmaPNPbykQjfAOlOUEEzj/3B67cWUtkAaw54qSxdRtIvDpE7AmqnnyIglHcxYKZOz27Umc7LEiSuO3YRJOUBXX3+GtxbTC1kVyv8Tfrym3UsbrSUG325qRZIbRTTcCCwmGMeuRdMDIFimicWtagiwDeaB8/vQV7SDmX6y7KVfeVrvPJFqDgxgFdezci+M1lPkHNkdtWyuOqPGAP2YtqRa1dXK60yLl9UGpV8eUlLQ6QIUIRa4aFR9viUDi9WxGb2QgO+ykF7DWbnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lQj/BcXl99hZloZn2aKbWSj97Jo9gvtxnEHg71N2Kc=;
 b=UkHaIfsW6o37LyW3YYMCzDIvuz/Cr9Q5/9WciASQturhrUqU1cry2h0GwLTW1vIEf7Hcf+woK5eD30wmDKH6vqU9sG8qRLxKB3UFduC2U2bqvRHqynq2pXhZ+YPMd49JI0YwLGqzMyVmJxIDNqBmqA6/ssGj5J2o6zFvavMN+b59DHVGjj/dWiBulXU1AvcE2QEWDEUgOo/GQNRl0JBlaQF3NacYj801zDq3baI5R7ackLPO/S03WJnXKvTCIAHYE082tuPgA428EOW86gnSmTGNTfjMOHWa4VujHokH+lQSTaDHAigANucIztMF02+BnyZmZId9HvrvzlLOeYHSJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 14:22:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:22:26 +0000
Date: Wed, 20 May 2026 11:22:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Message-ID: <20260520142225.GU3602937@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
 <a0e88436-3bcd-4808-8aa8-86b3ec0c197a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0e88436-3bcd-4808-8aa8-86b3ec0c197a@intel.com>
X-ClientProxiedBy: BN9PR03CA0906.namprd03.prod.outlook.com
 (2603:10b6:408:107::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb6d8af-ec69-43ee-34a3-08deb67b377b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SM7X4GwEg5UJy2VZqIFIwUVR8n9pkpwIrpGLqmAjkvjElhhMN9NhqLxOhiBIydgqHPZ3OZqRQUcUGm9RRwFfA0wzw508+o5/USPVjcK1YDcXJBIh2yrUEsSgYhdAgLlviE47yZ4Z7uGu//X1O5F0pQ8guMUly1xuge5XCtqbu2OP4QCb9LLEBQNZcH8MyrzhMwGMzNZHNkDI7sL8J457io1byzvoRDvF3PA17il8Pwcu8lFAM05rGow12gpJZVGFFCPL5l+qlwDT9qIgT/utGxb/zVDMwI4u1p4Wl/C0g5/F59v6iaDcGfcxHxHrFRDwLYFYfVcE1glidn6WfQqHsptaBrEt/6MP9rXEXBvpxgmPkUUQBcFk3E5dOok0fducfoSIfNbSvP3Mw+MURcbrxoQsipVRIKt4nLWMA2VZRSv1Dx69x9mBV7kQENUMr29qRZWpdCSWHWaZ1AUBBcKl2SK0/4U7f5cH9GMWX4QVAZuIxyzDojFUKf/j22dDs6uZp5QM63fwfK4Qrg/Ld+WxBCo+Ozv6j8P7+S3IsXaGnoOmF3AJ8CRsw28XD1Rg4rsJNPYeJfqJhWRGfdhAsD/s+GJ2fZ/FMhberjMZbZxTkRhqSvRHikTrWP8Ay/F+AL7LeLgkatPKfbKwLgR2Fy19xYMu1SqGyXIzGh+8hZoZqk1dektuA+xmSyw5yUUOTEQX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V3AAbHdWgnjsiOxOKTvmHjYf1W/fPQb2r+xWkZNUONQ0kuxxOPRSs2MWDod8?=
 =?us-ascii?Q?p8NzNIAqwjggbSojwYNv83nzTCf5tWaJhdIiPefrZMsOQVp32RLuN+XWKPOx?=
 =?us-ascii?Q?I10LUA41++vyWvteaK7TLq3ZRD5T7foGnU59jy5m4P62oOEW8Dw7E9SBXTlx?=
 =?us-ascii?Q?C7dmVte9YibkUx7mhtAdHFsvvAKBdpx1Bnm4ck5os+kHBAdaIJqg7v66qwZG?=
 =?us-ascii?Q?fsd1UzcNsgtq/asZyYisHwCPE47c3K3nFujBXRVOiusxBWNJwDNikgM3wJPK?=
 =?us-ascii?Q?V/G3PbBxxUaAnWulymmC+2tpcp0sQFdkvfAYkeZDP7o5RTyggTB4Vm8ijuub?=
 =?us-ascii?Q?kAq8Ik8qG3Dr6rI0gYcPP1N661aBxhcETVW/tZjPdlbf7VCZQTeXIBxBf3/2?=
 =?us-ascii?Q?JO0zWrr+3jjIQtDIpgIljZEkmRqz69/oorXyTEBztgnkiKpBdMsrn14brwV0?=
 =?us-ascii?Q?hPKGhclZgs298E2nGMEholKYjQLSTLhQn0Bv3ITuMGerUyCAMVitMvgtCfiF?=
 =?us-ascii?Q?prnAPwRvd6ZQZaR9Ma8wMPwWSSQ5P9bCz9d3ofQPUeBUJ/GRX9PMUQrGvWrO?=
 =?us-ascii?Q?08fBRk/bGoQnRU9T/iczcVOHHoL4DTNSqzB9tA97i+fohyacrCx6kEXiHS/9?=
 =?us-ascii?Q?KcFCJOA4sU2ktKJi7+sYm3vNClTdDEBsq0iDPog5lNj9qAJ3sK5S0rVC0BPS?=
 =?us-ascii?Q?7bdEk3uOZCMWO5X1yDv3pO3UQin6Pf1eCa4ZYc7l+6Kl7P9iT4RMveInMbkg?=
 =?us-ascii?Q?uQRWrPdBsC0RIRv1+YVaLjZaZx5Q1XvGEJL+TM6dWPQbZmaRLRSNaTGpfnNP?=
 =?us-ascii?Q?GTN4nw5mDH0qrNZufOzLigm6wuaW27Im2brc0JOcXLKk3Sancgv66+7RB+ln?=
 =?us-ascii?Q?YNO4llzWm4BKvqgTsoaRMtqwKIufPT1ocY1ktivjSvvLC91M4YXdT4siXVgo?=
 =?us-ascii?Q?m5eMXhfh1bTMbeUgWTAq103jtQlK6qUdPMhYRgf0V6AhzXF5D4VPKtntHbx2?=
 =?us-ascii?Q?Spky0hkLTrRuKpzgYvkFhpQxigVCsaiznTJ3a83C0KOaydcm/zujSKz5t/7d?=
 =?us-ascii?Q?MlnWsbZz8OwYYMkkunC10QtH/4KeWNbFoq5PC4T8e1aJuY8LwEws/iu+1dYB?=
 =?us-ascii?Q?IrFglyMSa/rr8O/shGihvkDQ6KyGrqe+ebYxeDp+gHfyPH2oHIIczFnIWPZN?=
 =?us-ascii?Q?SXlo3+7JP9HRhJK3qbRf7SwoinCGH654k2sGH8Sry1oqrswr52cjY49fLxA8?=
 =?us-ascii?Q?QmNbby2FUYXGL/37SzBWGiVxVsd02bC4UlqIoVMgHJmJ5A+IFc6fOg9ThMhM?=
 =?us-ascii?Q?UtTudYzCF1MdLo55Gsy4CSMKVQclTgXKjdQ/FDpn749zF5C1A8U22oCHq4Qt?=
 =?us-ascii?Q?2CIds17VGSCexJp9uXPm4EB9qAF5b8Py6ygp2ERy3zV68n1cCHRLjuio4Fcf?=
 =?us-ascii?Q?9g0qIfURB+YmO5Q3JWJwH3fvM55l7eKfzxsQn+IYmvMFwmjT3PPlpBMzbbVV?=
 =?us-ascii?Q?xmi8iRxZ/lpX9gq8TpIo74tcmM5OQPW4sVQ2zrq8GJL0ZsA0DH4UkZLp8eAG?=
 =?us-ascii?Q?4zi/OVU8n62y9dec8nQins3sqcFmR+f0LNHRI1sop1FPIcQiLqx5Qny1065o?=
 =?us-ascii?Q?/fMgK247ZfCq9uncr/suEhY9pYJByBnKXBNYA93bQV6sWIEpGvLFtdhwnfv/?=
 =?us-ascii?Q?OO45Ru4/Mxd8fWQ8CLwqFOJZBzzpwMpz+Z6q5Sl0loXa80IX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb6d8af-ec69-43ee-34a3-08deb67b377b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:22:26.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAIY3malCOtjPpqAqp0cn2QemZSLBcRvLGUES1eaXM/mUTCQm31+VZEE2LMn4wMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0

On Wed, May 20, 2026 at 03:20:15PM +0800, Yi Liu wrote:

> can this work for normal vfio usage as well? e.g. vfio usages that open
> devices that have iommu procetction.

No, it must be blocked we cannot leak physical addresses to userspace.

> My concern is kernel does not prevent normal vfio usage from invoking
> this ioctl. If it works for normal vfio usage as well, may just remove
> the noiommu term from thie name. If not, may be

This is a bug

Jason
