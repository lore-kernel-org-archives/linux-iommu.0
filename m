Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF4363C61
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361845; cv=fail; b=Ji58mgXfLE71rld0m++1cM+4GYTnB2m5XS8AQzWS1ydN0vk5539kHgXc7WnhKBM3OcS8jTRq76qbzVtlExFnlTSgHccl37hZgrK+s9s8Q7IsX+Kza2TN4knawcIz/SY3vo4p9MlMVxotA/Uws29HhMCbvhHM42GaEk+fD2HvLeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361845; c=relaxed/simple;
	bh=1w9R/r3CifNiilL2BUMNYKLcj7zOSgDXCHaxIBvtINI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KHHsmpbgotk6dxg9bvCxNIz4PAD8B8WBMnrOTFbAc7Ix6Xg1dO+6CIhss0/3DQWXJB1WDv8NBNaGzVUfMQmEvXzdd0aCgd/zX97HPY72pgqNbkB3+p/m7r4IaTxGqKo28MojBKiLb5y7TlUzZfotGh7f2gLN0+4NaX61tZvK7gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKdz4ZgB; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKdz4ZgB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnAaNG/4sXpmB2zeqSpZR1l6jTf94SqBsKwU7x7iuBTvrM/X0DQKAy+r8qKUq2ZcOGzalda+l4u1/Ruj8NhcdZq1AOWXukxaYH8dr21cf/ObwpgJ55IV1iVkzS2TULEWF+1GqH6k2AHC5NvB45xg+uO6sTZehX5DD6i4AIql9aB0eDSAP6pYTWDrwCVc/+TDPAr2NY9PDRBNSFtfa2ODOfnrvaFIPPXsIVI0byBVl/alZ5sHERXhyFbNn4dYxLgz+U+PVS8LmY4qmKP1HMUX8kC6ucsOSXySaKePmNVZHp5CCTXvbGwJaVhORMqkQUi3TLiviUfBEYadoxKNO8g8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6uHryHjLPvqK8YR0I69HRvEyoHm4yz/byja5RgciSM=;
 b=ULDRYtp7wXoFVv0YNE9Ue2MLmJlSROX8BYmf6/icOExuVY3vItCLxKcnQVtjt9jA39CJrw7i3mZpX7b5LitkxNQ55bPEUbK7g2phf/iXhBOirtlwOw6vRAm9kTanZOK40uVlbPmVdWsIAuY0R423JDeoI8vWx/rLVT5IDcTHT8HwQFy6j48Gc/sBS/gkGs1mwAnK+vFpN8z0V7doDJ1PmThN1J4bC2QdqRmeCfabzNQo+fwzo79CWIZ+iuYLUTNXys+P3JcI4pe/8dJKa+PC+R991ubspg59Srn1GpzTgg/e2MWd4FjSICFMgD6Ruzt+n44Cs8CTtyqHqOPpG1/RSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6uHryHjLPvqK8YR0I69HRvEyoHm4yz/byja5RgciSM=;
 b=nKdz4ZgBCOEDXZ9dMmjxiTRnRbuTDrzAhXbz1ezghISJ90kPQ7nYdkqeVmuciLmNnuT4BzJ7XySXS0PjCXV8wMmBFy1ox96TpfwZcPeRXqBJK8Mx9Q8GPPZakUOrUc1ZP7EFoHTS3zFd9TCcvK6FPV0QD6u0le3zlxRGoSwnVqx5ssosaWGWCsxEffhZ9YR0u/b3Fo6gQdixmc70gK0OPPJ8rIQdfhj7z1TdwCoWzVrS46LyLiKWY5BahNGhQUUYkcrFpSP9EXofExUgRfMJmU35BpoVml6Bru7ckJA6c1NbkvWg2L2CLCzUzhFbvgOabCL7p8cHBr5WRtpnppKadQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:17:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 14:17:17 +0000
Date: Tue, 24 Mar 2026 11:17:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, praan@google.com, mmarrid@nvidia.com,
	kees@kernel.org, Alexander.Grest@microsoft.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, bbiber@nvidia.com,
	skaestle@nvidia.com
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Drain in-flight fault handlers
Message-ID: <20260324141716.GB7340@nvidia.com>
References: <20260307001723.964956-1-nicolinc@nvidia.com>
 <abLE3rdM9YAu81tq@willie-the-truck>
 <20260312142509.GA1586734@nvidia.com>
 <acKZ0wtfi5R_dHm0@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acKZ0wtfi5R_dHm0@willie-the-truck>
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fa5c44-752d-4c60-7af5-08de89b00db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hA3uM1C6+Q0vMuVS4G1lFDizUkJCRkT63ardsptadj1BJmvLUQvYfQMZYX9r/2VWbsUDnOd0CilUlGhaWHf+UcOBXGOxGu8ees3YFti+/Yn2fQsSBbnInS3s0/njkvAJjtihnWfsBGxaxeHt0CRkm4aFve0SVBXij/aA597perQgsp3Sc+DNbVYYPRoyWYHlansaLEzVBwSB/O9l4lJivR+f7rG+eeTLj9jlQ4di2OUMbD3wkXdSOuekM4qqlVIrksruAk8QcQ2Xv+cm6d/hVUgd6bh9T9tv6U5pLOEYOc0krI4Apf8vQDJvFMPxSA2qBJBV57IFlTMoJQQpSouP71PlCfWoj/DWPT7bAcEoQA15838yy9w8szA8d+NuDlyz696rTzMNnWQUcVgY2m1KJ6LBbstxdwznSZeR0JHy/xSW+QaH1OL3XO7X4r/DTQSy1Ok8GIOU7xw3oISCSFR3SYvdD0CpZIsPmhqBiCNUxZIzy1/WBWlkKFUNC77zmczxwVv9gS5qgMvicWN0wZdlehjkTN5bKt6Ea7bohoYejRQZ7RJFaVvzkds/TYq1rttsLox0h3cCaiZ/K/MO8oGnN+AwY6Rolr3NckDqkivR8yqLfm8z8TjXlpLeWjCf45sBlAGexI9U+r9FhT3h4XeEPC3H8RjMX49Kj88TnJ8LZIFk0Mg8v128oI6owfpPwwr1FDg67ZMH9KZQY7fgQNfevoJ0MFYBF4DjjHCVjVc3TG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R8lxXfhRuEPhEKChl9EfuZ+ehHSq8b7unSfexuhf5EtTJufKt44tWJ2zf5kC?=
 =?us-ascii?Q?4AZ71bBTGli4t0EQQPLxuJa1npp8sOZHnfChiAlYmICgH8JgVgcYeiNjiyi0?=
 =?us-ascii?Q?IngrVukFKrfpUGJGxVokwsqx05/IOBNxsSQeFho/3Cmbb2ft+NMCMQSvdmu4?=
 =?us-ascii?Q?aTqFhCJ1bo2Vqv4cqlHw5cy2vjAtd5MqSMd/F6vg+UmOPD3m2fGZOJtS0PaU?=
 =?us-ascii?Q?XEY7qwVePF4mpjronqd/+hi37MRsWDNwEviWY5qM/1kEA+5sFAUFhkmp/QYf?=
 =?us-ascii?Q?KPKuy3wudcVJMbUsXAhySTmKqrnyN2gdFfMs9MDRufkeEbSd7OvBK0iIqsaZ?=
 =?us-ascii?Q?yY0+xREyWuFQNqQz9jSI+K3POuSJLGUTHnmR3OekngoQWA/yQOxeU7xbSJ6x?=
 =?us-ascii?Q?wyq0NwD/NJ5WXezPlvBBjJT3SbinLqVy9pMX44HXBUWaWt9xDhI7+LK2Ybou?=
 =?us-ascii?Q?rtjUjoxc3xbTCorG9FQ7zudhy0LBZE24mdzkZXvTt8FYGuBEQwwpxAZSVU0b?=
 =?us-ascii?Q?8SitZu/LEl+dOt9pE0qccZnCngINIJbKD0dlwF2YNWdVe5y3eLuh2ShRJVmT?=
 =?us-ascii?Q?pEBG4b/bC75OZBtOExbzV97y4yfK9+d1xWUwn0lU1BPpKO/SeF5Ndh5N5zJ4?=
 =?us-ascii?Q?TN5OZ72tHKxI+0EzT2R5rq5gEF8W2NzW8pYtHBZa5WshBZ7hMiB1WS/Bv1pm?=
 =?us-ascii?Q?QgBRxJCh/VHGhmtyvOJtLyKSgTsuhYfg+qlhjDTYw3Qq/fFAGlv2YAUq3VwW?=
 =?us-ascii?Q?0WM4mtQXJS5RvWM2UNSzw9MFyQMI0sDhN7wFbh+WX0z9KpBUdejQ9tRfvcmQ?=
 =?us-ascii?Q?0MrXY3FPftbvC26E2yCTXUD57PTcUW4xgIssa6t6SzS5y5q9RXwyNPWYStWT?=
 =?us-ascii?Q?P0hXsU9yfZgc4LWIK3LsuUL5qt7xD/dfPK5FZ9GhqkNNeAmrpISWHoKbxzfV?=
 =?us-ascii?Q?kBx8NQlOD5WBd2hykxVAUnKPp5BmE3+coxOw9937F4S9vIN5JfpQgQ5WTFpa?=
 =?us-ascii?Q?PdLB0EhGI2GQxMyIzbmmeEm8dDxypxd93lD5CaeWjr8NNk8305Ej6W4HLgLK?=
 =?us-ascii?Q?pHpgg0IWTNdEGNNk30rNPYc45jXCd+WvWqHLfoPjAAPTBXe8Ci1nPE+AMhlM?=
 =?us-ascii?Q?L0YeRwTeyTwJBfTAofAs7IiEqaUY67YLNMTylAqPNOG0t5OOmIY1zEhjiLAZ?=
 =?us-ascii?Q?OF3+TwvGSPhsZEvQJi9y3rGK8GXLgXv42ho+QX7UAFICdIK+Jwk8Xj66A6Mm?=
 =?us-ascii?Q?SjlDuSLaJ0guD9DDrzNIoNshAZIsCzYALu0GNeXUncMjioNquGz5ABQ2TMI7?=
 =?us-ascii?Q?TiWhlLcn1Dw1fQYbXZ4FcvQi/Oq0oPGiaBXjBqnHt0UO+H4tXSAwfydgMpGC?=
 =?us-ascii?Q?8LN966XY3qbVTW1tActemJJ77dtUNytsEce7znYiIr55iPqT2QIcYeaIi0jL?=
 =?us-ascii?Q?IYraSm577FK1X4Iny1yfIcr5mEye1rKVQ+rf+ckHlatsljEg8G1UIogIxUVb?=
 =?us-ascii?Q?COKWF+9P9+oSL+FKmGMliOlhENFbaHry7A9xpgXYZgE0udsA3gbhVdCkd6XX?=
 =?us-ascii?Q?UrCugVdDkGxGSzJtmC/1DfRcmjqUlsuYTSmWLFYvMEcN2ruHI+l0OBiZacp0?=
 =?us-ascii?Q?ZtjKXyLShJdq3EWI8zbVxi1SgIQz81z3C0+x0W8VmxbICLJao6lXwj+kmGes?=
 =?us-ascii?Q?AEagaWX8T9JHaPx+v8CPys9kVjuQBgO4IcYcB6YD/3nO7mm8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fa5c44-752d-4c60-7af5-08de89b00db6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:17:17.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wUs0cBnzoFHLJ5KERWW2bgMRN2u0Ej8B4z/DkjLAEOR5xqVqSDx79Y38eKNUC5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

On Tue, Mar 24, 2026 at 02:04:03PM +0000, Will Deacon wrote:
> Sorry, that was sloppy terminology on my part. I'm trying to reason about
> faults that are generated by accesses that were translated with the
> page-tables of the old domain being reported once we think we are using
> the new domain.

It doesn't matter.

If a concurrent fault is resolving on the old domain and it completes
after the STE is in the new domain the device will restart and if the
IOVA is still non-present it will refault. This is normal and fine.

If it is resolving on the new domain and the new domain has a present
PTE so the PRI is spurious then the fault handler should NOP it and
restart the device.

> > The ordering is supposed to be
> >  1) IOMMU HW starts using the new domain
> >  2) iommu_attach_handle_get() returns the new domain
> >  3) IOMMU driver flushes its own IRQs/queues that may be concurrently
> >     calling iommu_attach_handle_get()
> 
> Does that mean we should kick the evtq thread? I'm not sure what this
> means for the priq.

The locking issue is around iommu_attach_handle_get(), so any
thread/irq concurrently calling that has to be fenced. That's it. We
don't have to expedite or synchronize with concurrent PRI at all.

> I don't think we can rely on the IRQ being taken, though, so presumably
> we have to kick the irq thread manually and see what's actually sitting
> in the event queue after the CMD_SYNC?

Er, I thought the iommu_attach_handle_get() was in a threaded irq? If
it is in a WQ then yeah more is needed.

Jason
