Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68D25D917
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880381; cv=fail; b=ePZW9Xue/lhl07zTqjTTmk3dFuuJvsrI04A7zf2qfDNTErDlo/9tEIOOHiTQPKf/sJWCpAw5Ua3NlAD+AF3aTaRZXWPvypkrzAeju9jPfeLQP6aBZuZa+M9rYPL8QUcXorlqO60sEw8HsQRDVdu46nMx+QH1+TPN0rrNa5370gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880381; c=relaxed/simple;
	bh=PUalWuLxcLGBrhtHkdelTHWztV9Bo3KcQZ6Zf9D2G/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eidnTeZVrfr5rlndsCfeQaAq/DwkrOvxtLEtypwm1BiSjL/vn+TYdlCWRhONWbC4/7+ZPECfPxXl8yOao9u3GTSplkW+dHfr/pJ8xL4pcngNosYEABoTXMLB8WC2eDfp9jhwOpkXJcNROHcke3HybNDlAU0zt6+sUTORael02sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=At6WICTS; arc=fail smtp.client-ip=40.107.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="At6WICTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWGEXUNIVMrkih6YuKGqXsUj2mFvIZQn/6ea3CDjtQ5jV2FgMWzeqdoUEKHuViJypWTcookico4c3TZIf0EyZRToM45wcWpNiWPx4rQBNZ9JXwOPa5baRhJhAgC2x5lfenyJqvdVwfJR8a5lwatbpT+Zv0c5HFl86T6EM9u1mXIGnX49AKwhP8S4KmxxWSPBCTjZiOIBBVtOShr1k1PPeiixlV2KTMZYTKzEYG4wVoycrtK6nUDNuWkNmYXIdoXIHokqERdSJQZVDx3NebsRXE6Dg9JroCjQem1EFPvnmnUSvHwdylHQt1Gy+I46jgIxa6xDALWz1BM7/oKpOYz2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUalWuLxcLGBrhtHkdelTHWztV9Bo3KcQZ6Zf9D2G/I=;
 b=oUeYH6t2nM9Uh3yZY8BE5LYht2ionHk07Rcts9jpXG62c22P6xbP4p9Nc2Q8DG+obvbjZIEfnHHfKHw8rLgjPm8E7vGm7bZp7P66GBenMXsCn+0ymO9UMOsbX6N7/NNW/5ZG0yuy3yj53dhbuX17bLlS79U/NkjG+Ihj3a3vK+4kCykyw00/nZLT3drhdoR6dgK1fDj3UZ4kwrjxTlzao+ZvZbGh2EDGvFtITcNz1ct+5k8QeVcq0oqZ2FpOW4BAXUQQMEgGteEDywYjoomfm3S3Bf57SgiaN8176QvI88OH+nD4/aUettMs/W2T5phHkjW9FXYB81OUYeb9QhFpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUalWuLxcLGBrhtHkdelTHWztV9Bo3KcQZ6Zf9D2G/I=;
 b=At6WICTSjfzKz/LZgsvXQOiShS6uZPYxAZQ0Ieq9psnpg1mo15TtJixm8RohP5x8wq1d2YsL4j0opqAqSzcRESuVA6ich76I4xl1aZI2ivTVsi0iHcX/FZ24WquQt4JLNsq7+uMIXAtmAWAIBwh7ba01pYAaCyljSBloZuoqoVHAUtJz3LCTkmdfRQAfd6dPojb4bDRtbC1ZUM+WEmFvtPy7tH7NU7UXMRZN7NnDqLEDucl9ijnzJ3PoEvPy1r0v/piegfe8VrqH8CMkpZCXO1ydgIWBaRnqTUFDZ1ylFvSd6twBN5PhCee4RoG1dl0csZsnsZxmNjbG9j2s+2RJoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 23:39:36 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 23:39:34 +0000
Date: Tue, 7 Oct 2025 20:39:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 10/12] iommu/amd: Add support for nested domain
 allocation
Message-ID: <20251007233931.GD3474167@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
 <20251006144936.GS3360665@nvidia.com>
 <fd4341ea-869f-459c-a3be-a98cd1c8ba4b@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd4341ea-869f-459c-a3be-a98cd1c8ba4b@amd.com>
X-ClientProxiedBy: BYAPR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:a03:60::46) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9e5d5f-e41a-4ab7-3690-08de05fac558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gcDNkuz2+ru0aZfDSBdJ9X+MQ5SZglOiAVqIuxQ6/5N2N8d5pyQYBYQxBDlg?=
 =?us-ascii?Q?8qw52GLzpg9Mts6VlItMk7OZyMaA6xYjSzmmxvOtH6cpVZaMb4lXTiJP4hN3?=
 =?us-ascii?Q?NEKpH2w6eiV3FgLn8h70exX9U66bX29Zu3oSR6U3CwNBW1TZ+ltyDqpugMAY?=
 =?us-ascii?Q?+VULkMw4v7ttLXafQ3zlR+GrGSh5YWUmIHXP0d5vXwuJonaXQoqmBvko+Obt?=
 =?us-ascii?Q?8KkJQ50eQakYa3osJd5VhoSSKxBFKzcQrSSh5s2d1IR5kzcbOz0BQJR/l5Yj?=
 =?us-ascii?Q?Q8pqoohtCa9P0xBlFlDqBXCY569Q5pHaa8RqgcJUKEmjROSxeotezKOhH2tf?=
 =?us-ascii?Q?vz8jjzPGKMNr4vkbhxNkxR+osYbELplSZ72bVW8pdXQxTaCH8JMcVND+Wkpu?=
 =?us-ascii?Q?QFyybZwvzgYD5lkaDFxDZmX8tqIslEwZImqdi5WoaHYf+TTlkhjwfbjxi9M2?=
 =?us-ascii?Q?WntsJtBPWxA+l2o5MxjZd8AJPHXlV5+KtgrnInoA29xQjznTHnW5wvFFayn0?=
 =?us-ascii?Q?MAdzp2hc8mijvHGLLeZvAATYmvDFkqaZkuibwKEY/jNMsfZehqWdKx8MM6GR?=
 =?us-ascii?Q?KDBnM42hBlVpF2qeNZ2YstHOlHnr5GkyOGOlprFQMFSmDrlCSk7LUvYzn2ch?=
 =?us-ascii?Q?sO5AUyHKVTvZV6gdirYMjvET62NwXCHFOqlpbA8lGnsiaKTMSVmpxz3q9RLQ?=
 =?us-ascii?Q?s2oP0BMsyrPa/kCl4RQObX/fY1PRshaRPSF9GVayRmrAhMZunVtnFJmFW/ih?=
 =?us-ascii?Q?QLk64fURiCtL50Es+RvDEF5UfWfa5dsfxBFCDNoKu/ohOxe0R0yEb3r/vh+X?=
 =?us-ascii?Q?qbGXetIhGNoA3sWtYVFMj1RYpm38g5z9GfGc0Fi+AtkJIvS+qD0q9QJETusp?=
 =?us-ascii?Q?nUn9VRXhpWh2/Ozl8bmjYiGxnIq+EDqIv5m7JGkjcJ3yWK67gUjsOvQVpXZw?=
 =?us-ascii?Q?9dogihBcsBW3clJzgsU8n1fTHgdsrAOtoGRjKS6D68kygJL+IDc1qkGW1N2H?=
 =?us-ascii?Q?zXC53rjmZUT+rtzpxmQTR0BxD7q8f9wtvWcg7Etf9ps3iw06QwBaWc8328eR?=
 =?us-ascii?Q?LVsLdnmN9jsqED81eHF/yVvTWcdJIfNDkX5Kjm9CG2ggp2KvvnWxOJx8KT33?=
 =?us-ascii?Q?uCp9kNM7WlaRBpVqfi+pqGT1o4wwGkaHuH8qTcYbSpHucWZ0s69HZUbtdTeA?=
 =?us-ascii?Q?WR6zHe6/ez3js47AQgXHU6kU1shE/MVsgdu7fyN3KZENEI0sXk38T7D7vkmi?=
 =?us-ascii?Q?zwBEYt+UKfcVffoyjTndsug44jujch+Yw5E++2p4nyrU5PrODvqULjnFhur5?=
 =?us-ascii?Q?8xMpVjojELtCLWYGFf7NQtoJEOZ2G8ALoScF7tTwQH4Mf1NReJfWOwkZVuCJ?=
 =?us-ascii?Q?22RXx9nChIDN5bJXiEfu9V78et6ecStHd8DKmsheoNvLh+ZIv53sABRWWQbD?=
 =?us-ascii?Q?+zHMNRMPzIyFkEeg0quCIu/Jqf92p8zS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+jrrMVkX7cHcqUZzRjiNMnUFIvLEYUfKF2sLS5xKtlcrAhnyA350FLYrmTq?=
 =?us-ascii?Q?NH9CJ98Jr0AVu6vE8Uf36wAZUfWlBd8gNRIN39dQe+5se443YOEFj7By2wCL?=
 =?us-ascii?Q?kIcHsTFUSPMxUHUMVRWyfu9A7F1BR9IRDZugozM4tndR1Tq61bdnd5deBs/G?=
 =?us-ascii?Q?3Algv2yDW8cFGcZMiA6ZWj4Z4aNepY8tnCDMOsLYhqShhd3kafCXTYsk7TOO?=
 =?us-ascii?Q?olJnBmufgE9ZlU/tdpKH7+hjQovNHDq/pEioXjJSzbAajOxOGxKRQzad2DKo?=
 =?us-ascii?Q?1K7t6pFzHmX+8P7DmiBtLNFGxRdsuVV8wLLP2OcpSWsjp0lgtNNIAC0HRI+v?=
 =?us-ascii?Q?+/sXecZKUKFNNCL6LeJdrC08dboT+vp6mhDOR3g0uLSBbN4COZa6e3G6xV9d?=
 =?us-ascii?Q?YDCpEfuzC83o/F4eJDWjDHlaCr7GaH1/iNiEuuSUUKvfNbgtmAmk5bCeyfbf?=
 =?us-ascii?Q?D2oCGqZ0x0r7xFD6SHJQ4w3ILUOO/Jajge8wMu+cd85svW9AkzCAIwTRLi6M?=
 =?us-ascii?Q?D07RHGSJjB2rTaFXZRAeXWbYmYV+ZFuPR5pRUhOLJ8NLeGnxTIEH/v7rw9V1?=
 =?us-ascii?Q?bbfQ0oVrqQh+FaPUxoXo4l9S8e3TqjdFFcbwgFsd5LmDNsYSDWqg+7OsxWVM?=
 =?us-ascii?Q?F06150bPMVWOUXpMuzGPyktqGnPRtm7lz+fLG//KaV5UshH3eGUufDIzgr89?=
 =?us-ascii?Q?8TROopTs/0l/nRaTH6Kw9JdPESTV3NAb9fBeNG2rjM+X3PZYKJ8Y1RDn3vfj?=
 =?us-ascii?Q?6TMSeZI+1a1lQ6zUzvoDvkryjsGJEfijLbR6fEweFSxJPECHRDstDYuBobje?=
 =?us-ascii?Q?kgeMVD/LhicNn+5AoVVVOn2pTzmzfOmcOSmEtVzKsDgjoS8yV+BOXwORd/LI?=
 =?us-ascii?Q?xzG+oY44Wd1hBWIHwy/8wFanO5ev7Rw4UtXHJv+S8O14QRUOuhyM4TVwyJmb?=
 =?us-ascii?Q?DU1lKIHkB4eLIkxnSUoSzAWbZ6rvnOG48t1McHlgkF65Ro8YL3d+0UwbetE4?=
 =?us-ascii?Q?G8UpnzD5EM6XAWFWxSMgxwtzt5JnoM1t1XBYZRLkifZn/NbP0S8Mf7+jiNQT?=
 =?us-ascii?Q?rBX1+27Cv9q1xpOk22TGWkGBfKS7n9VljUYsOiHfY7GButG2rQ9EhL6Oxq2m?=
 =?us-ascii?Q?c4UT/mNRIcsPRonOJycr0HIHxZZQrFsAY4vaaqkME7cdiYMRNQR8qN6+4bvW?=
 =?us-ascii?Q?VwgoM5lcRxFfzteFtrB9HVs4a/B1aI1sVZVmmlcmcTx1usjtiuOCxlVtnQMn?=
 =?us-ascii?Q?5zcYaQTEn29tquPwJ0EbhI2U7jX3Gz0suOreOggkuEYPAK10c+Xu6/yA9y05?=
 =?us-ascii?Q?rzPclup0mbsGPI0X6AWITBQvfzzsA9nbsqhL4n5lvz/Tj4bUWFz1JCfFyQ9u?=
 =?us-ascii?Q?j/qXQRaQ+I/tUPiGQmd70TM7SqKHJaa/XuWwWugq8BxB7LmTpAJIkFqbzseI?=
 =?us-ascii?Q?WDUAdvhmdn4/KRrdGSywOEsTCw8KJuB4LKZ+zuiQmqbZ5L0+IRI4UzsWg/LT?=
 =?us-ascii?Q?tOB0CfUpCC1+OlMcm4y3pMEVBf+pleOr8tPtMZh4d8FAZeGkldnJJSP8mxKv?=
 =?us-ascii?Q?OMcYHkHFHuS/PTaoA2zoNMK8RKM2iSnOLXv/jy8v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9e5d5f-e41a-4ab7-3690-08de05fac558
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 23:39:34.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQVrCPUNls4L5EUHBUb7VdykEDbc+KkyRPmoxYtU1JZkwl4BESwzkxj3yGdbsLaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

On Tue, Oct 07, 2025 at 03:36:58PM -0500, Suthikulpanit, Suravee wrote:
> The gDTE[DomainID] field contains guest Domain ID (gDomID). The host IOMMU
> driver uses the gDomId and guest ID (gid) to index the Domain ID mapping
> table, and store the host Domain ID (hDomID) in the table entry. This data
> structure is required by hw to translation gDomID->hDomID to virtualize
> guest invalidation command. This will be part of the upcoming series to
> enable hw-vIOMMU.

Sure, this translation is part of viommu

> This ndom->id is the hDomID, which is currently allocated per-device to
> avoid TLB aliasing i.e. A guest w/ multiple pass-through devices w/ the same
> hDomID (same stage 2 table) and different stage-1 tables with same PASID.
> IOMMU would use the same TLB tag, which results in TLB aliasing issue.
> Therefore, we workaround the issue by allocating per-device hDomID for
> nested domain.

But this is what I mean here, the gDomId should be 1:1 with the hDomId
and here you are making it 1:N.

It has to be like this or you cannot manage invalidation.

Given this series is not really functional it is OK to leave a little
hack I guess, but it is worth noting how it is supposed to work.

It also probably means we should see the viommu series pretty quickly
with a goal to merge them all together in one cycle.

Jason
