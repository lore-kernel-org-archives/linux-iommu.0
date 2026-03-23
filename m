Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7D370D6E
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270792; cv=fail; b=TNm2rBU9c3pTcZ8bfvFSoCulnQ4xj8S5nuoInFnMKh0AIoCJmSle3ZY+gnehVmAmSW7ZFqRpobuIVzgfnEUcsN7GOuXDu3un+f64pW5+5NaYK+pHEgu2CgUCUK2Z/Ev/Ufn5nKvxJgE/36mCC1nRJtpS0OHCKSzve0kISyQCg8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270792; c=relaxed/simple;
	bh=ne3WDw8bt0cAkYT6PIZMBilLtKF17L8CAKZjIYiIBBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AVYWAxvgLwFoS7H0hyt562jcahhBnzq5uUvdKQKKOoelIn2JREFJbTvFyV0fQYCeSMxcDw5Y6PPRVG1y5tgnqQid1/R2/TyiwGVMgqu1phT7rlJ48TtLJFHpBMd4Mn4iFsKBH0Rvq/SSWhZ11Tj3ix9CsRyjvQKZ2JPHZpuVfDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e+eOsKUj; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e+eOsKUj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNXeazsmilHE+tKf4eAyeeoKINOC39eQLufFhOCAkPVcsEVBNw3n9rvyqUQKKMbby1jp27QarSxWTGQkUusGfpZzyHSzq+ayS+kIioplFzW90KjEEX4hOxONeEgDOHdPzJ+t66lm9Yn3uz8lggSbKPmIe8rmOhJv2PPD69KPGsfwCF6/DP/wgPoOVLotY+oDZo1w+sNEp5TkYMCsddSwuuMLRZY6K80+WHkva+fO5hrgS+JEDm0OdzkbJt/uD0elXrzV3HAxkV/9HJUbIUfyualrk5GBuAmaU8paxVPpORsjcvHxC6aBfLaPcu8obSjZ7XbsC9FdZy8FFRf0WYb48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u9iU1rlZdew+yJviTDtzMhhIO6h3LiEhKa4l0hv1Uw=;
 b=OXFX4XArGg5fvl8Aa+70vGMwSf5UQK0IKZ7cWzA/ltL5UDvrGNBpiBHQLuOcucXqxLD5hIu7Ouotm/kuO8of2mICTdGkDl46hyoYAc9JdZTnRob5yS9cYghVePnZYHYdoZ/QmncCXzjlTK+nX8YX8i0SlvkHAgghi8jxMhoYjDz9A02fkCNbrOtjmgQ+PjlFDbWu5ve2BsPyS4Xu6oo/QXMBjzJP+FIbXYFnan+NcxEO4Y8v96sUZtYu2UR2OK8JG1S3MiRWDMx49D/pr4rJpcoCrFkkDLqvr3Qi5URiaZpvImQ5thD/pKkAkhZUesA0kvgGbKt4jqci4d/+NlqluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u9iU1rlZdew+yJviTDtzMhhIO6h3LiEhKa4l0hv1Uw=;
 b=e+eOsKUj8m1t75Ww+IbUvsfMc98QBVfSEydQ2f3KiO9VSPeOjXoU4YHLbh/noY3Op6n6qLujnZpshyextXT3fQT+aHyXkKy2OCb0owEiYTJLqeMUrd1OHnsfAmf92d1xFjj/yn5jNChNYaqA/ZJ4Ugn1Q8kZk2kdJqeGQsk33Fc+rkFin3W4Tb56atGM+ofOzmDcrZPDbuhYlkzYqQZE89+sk02IokH0x4D7X5Eu02jgJwJZsRu+xe1WRdZRp3vMxzXjQuBskj54oAWMDzlagDyOz7bmjSs8bsXH8p+NTPTlC0DwAA2lllu1081RZFIB2twoqbs+U22M6L7Nup7xIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 12:59:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 12:59:47 +0000
Date: Mon, 23 Mar 2026 09:59:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
Message-ID: <20260323125945.GD7340@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <abOjJf4HJ50vCIyg@Asurada-Nvidia>
 <02344098-c2da-4634-8f34-e03c88d030a2@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02344098-c2da-4634-8f34-e03c88d030a2@linux.intel.com>
X-ClientProxiedBy: IA1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efc2c89-534c-4e92-399a-08de88dc0f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O66ZSOqpmzRtXQaYiBVNzNZ0/lnVwpnWng+MHAYmzGaPaeLARS2N5f+zDeRwS4//YCJl4Du6T8LG3Uxq0oXuFLU+cnHs9qsuFRK3UgmTQDxBlu2XD2ZFmioqCD5NvWtDtDV9wK4Mo6+e0fiSrNe1kG/WMCKaXpkkFwf+lCMNH0sgc8EydqR4qtNIAMpTfwiwl5NMM8ivq2pZzdcjy9AsmZLs0K08YZH6idGSE/m5Ir2K3U3I5rukPs7DUOl4h7kS5uiDYwY1W93Pw5rz3sM58OVhx6oZMSjHUH8Bri4CnXXJJJ5DpCREMrWdEcKgzJ8v4w3l8pnnavoUmsLyWGwyq7e/EkxqPA217cwIjX5gWqmG9PdW6eReB/zA9NsA0KE/2UaXAHNdycSTAEEpn8odaG5erKz6pvHzJTfxPbnkpLY+SH9U+FTsPZIA6l3CvCBEfJ22WaiNTuEcFtmLK/U7mUxU2TIqDHgYUx5QyP/uWFFBVgRPT+/4wR8Ir2obXLGVDOsPCpkjtp+cDmKAcT/kLfyxiwaVXMhVksEL6t2b3h4AXAzwGHpewpEpwgxOa4N3D0bPZyPjqQQa9Hta3udelGyCDsgVA2SwJDO6N7hpe0g3vl2rP3MbwtO4NlXWLPV86OKLI7zCixvxG7TMyW+fgTbljjSS7vfUyGlCzpLw1xQOQRf2V6T4lJp3czvlOQmOrN17djj1GMvR6EXpX1d6zW7ocTOgcbHZFubHkMkDOZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/T10com1lRhtk3LQHIJa7lxokzal8QOTuG6sHrv6gudmOsvRO54bbD1Vjjd?=
 =?us-ascii?Q?kWXn5xF+Goc9RMgLX02VrJYNVFtnXIrVkqkSjDtUxNrhxPJ5zlX1ES+wzTgK?=
 =?us-ascii?Q?UbGn7hLe2xwK7bVtfPiwBekxTPQSB3aAA+JbOaTbpHF+nZ6FMwyiSZo7DIPc?=
 =?us-ascii?Q?WvPfT1LzUxi3iUSwhRGkiq6ioEqk56dLhI11KWeWHsgdbSpxcg+pE73wSDQ5?=
 =?us-ascii?Q?OhzPTjfqs4xMMit8FbtkcZ5un73mjBV5dCH3X34vxGnHAdPXfuskSehAg9HV?=
 =?us-ascii?Q?wl9jFzyjz9OVAPb9V1g1PcqlR3MBgM1JPv7h+ueaB7iv/xr90FGgRad2ucZ1?=
 =?us-ascii?Q?75OegDTvW9+wS2XMsSNMq3Ln/YWO4nczg7fzZ118rLt9V51VGqlcCbfAyzpu?=
 =?us-ascii?Q?szAB4VUkjxAFPmMAKjdhvmT7KgtcIddqvaRirG790awN5ow/BkvGGxxQApbs?=
 =?us-ascii?Q?1kqLpUYIDFMQPnsDqj8+EfM/oKelTCMDRVmAto0wgujmgU9uK7QUuexXyDk4?=
 =?us-ascii?Q?YnESGLIfqLcbP1loDVf7CdjDDathiLV70EEFhGLA+qEIAgFljpFBetadR4zf?=
 =?us-ascii?Q?f4AolPBf8gro+rS2kPmw5LwrLO5YpQYspNPz1NPN32UIBaVskdaRY4y/8tUA?=
 =?us-ascii?Q?nePf6U653h1m1v1OehMbk/OoctXqhAA4RJLpM4poM53DrLyo5c5foovLuCv8?=
 =?us-ascii?Q?FZz+N6YmqlumFL3yVmAyuPXzO+O7mJP92PVyJ6snYJxD+u4MnTjZOm+bMr6b?=
 =?us-ascii?Q?KG/ufSYjC2vgeCQFTIPzlYsliE0UXDB1gJGHU6tFG7PyW3zawEawfmUtQylv?=
 =?us-ascii?Q?ABfGTb6LiZvivuHzrOmoq90EMAGZ1MCgl4wzS9yfsXmRcWEDMTs9KGCQnxOD?=
 =?us-ascii?Q?IhYgHvbUU2XC3AI4+HjjrgQwmv4JL9L08y+XrNnSwRHPK8NfOuqJJgIYDp/i?=
 =?us-ascii?Q?a3Udy3Fh3V2wEN367DevfJvu2W7WppkmQPC/3ETVS6P/ZrCqyPeEz6oQJZpC?=
 =?us-ascii?Q?PjsNUwIkMtkMgR5DMLfTPpm7q3CaqC2fQ+Wv0pksQ9jfHq+D3yh5dXsi+Xsj?=
 =?us-ascii?Q?fE8JBslyVr3uG2UjXjaK0JVdxcFescvFiWk0PVb7eaLqGZ2zlHPUP5aGPmlo?=
 =?us-ascii?Q?vQ/hjeNJn+lCl5eJ5wH60D7cTbrxdTgmH3ibAef2QiQyTFP5MBMpXaPk8Ew8?=
 =?us-ascii?Q?zPSlfbdEQ2HnHwUOsBZt6eSpPu1bCFRQIhc8p218VbXltv81rQvyhNknUGoM?=
 =?us-ascii?Q?WzZOdsIAskQfG0buYPxC0LMIlMX4tKUlji7lGqHu6Y8+m20JgVADwMsZoSP5?=
 =?us-ascii?Q?xqluM3EVnde44fAnJEn560qi1Xr/N8Tp+N37eZw3Xo/erOJPo1Gf0Q8R2xwM?=
 =?us-ascii?Q?U0XPX26R9+PO7PL1/vdYeqNvEWHWvyx0QImHu56VLxnjHyiuqrOzP2EC845S?=
 =?us-ascii?Q?OZPtSNM50bcgWBJmSDWinBVsHsBGxa0n5VSob8CcGsxFMUe4T7ybiG/8pLwQ?=
 =?us-ascii?Q?nMJR9fTFrfY7gcVbuyqQDHs++C8R7pkRAYw+aFhN4OYZUhVW9JHvYEBueNI3?=
 =?us-ascii?Q?vf8yXQUkbadttLhy245iITg6XJayM8SVqi23rZ7kH1yn2NHmrazdCe9EL7lx?=
 =?us-ascii?Q?dgc+Xy+xIDHcKiS0qugro3BRb+J5U/ULzfCnmDUxMhBpj1EI6tAZFfTON2D9?=
 =?us-ascii?Q?fURD06f6CFEVp5Ax+ddAZmrvLBasXOsOWrwYyH5TdKKuSD8w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efc2c89-534c-4e92-399a-08de88dc0f66
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:59:46.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DP/ueghh06RJg6ee0Dh4JIJuD7/zVaA96myS+JNfn/L/4yaBn7APUMLjV9W/BqJo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254

On Mon, Mar 16, 2026 at 02:24:57PM +0800, Baolu Lu wrote:

> > > +	writer->ops->get_used(entry, cur_used);
> > > +	writer->ops->get_used(target, target_used);
> > 
> > SMMU has get_update_safe now. Can we take it together?
> 
> I will look into the SMMUv3 get_update_safe implementation. Or integrate
> that specially when we transition the ARM SMMUv3 driver to use this
> generic entry_sync library.

The intention was to copy the existing ARM code as is, the draft I
sent was before these changes from Nicolin, so it should get updated..

> > > +EXPORT_SYMBOL(NS(entry_sync_write));
> > 
> > There is also a KUNIT test coverage in arm-smmu-v3 for all of these
> > functions. Maybe we can make that generic as well?
> 
> Same here.

That will be a bit hard since it depends on driver functions.

> > But maybe we could just call them:
> >      entry_sync_writer_le64
> >      entry_sync_writer_u128
> > ?
> I'm fine with the new naming. It is more explicit. I will update the
> names unless there are further objections.

I was wondering if we should just be using void * here as the type
safety seems a bit harmful if the goal is to make the 128 bit option
fall back to 64 bits if not supported.

The maximum supported HW atomic quanta can be passed in through the
struct.

Jason
