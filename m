Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42C3438B7
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234012; cv=fail; b=qOyfBb85g1/gdA0S4Yv9Mbw9gMu3NpeC96sTj4DRNgsuqjuKROgAT0C8wZzWKiTpangNpu5uiaYx0svzxp34VeXte4wbqWBm1eGjWLkQt7LP1mOdNNDsiEIadIeyp9K8FBgwVQMT0qXur9zcqZI3CKtkck2QJuxMQxxRMq+chFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234012; c=relaxed/simple;
	bh=ZsqIONot0eFL+HmWooSc/2S6BaX3NPrCAFWqYXE1x+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXg6yEtMPYPNqITJoMcCSBwjdbuQqllTlftgxEMZlPXOQU86RYoDZtyxp1cHgxIzxlMzRrTMaoVGYqJ/nV32ldd+jDU5/L0lpMap4idU0Ywihoin4yWq57ZQ9L+xyOkQ76nimB2t9Vs+rjitpD5mxHxHQZ0m9ks/pPckQezdAhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CswSnfJX; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CswSnfJX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COE+NhCmWkIRceV7PBPw6vNDY2pd1lTA15kMJEOTEAkyPwh3p/34xIAlYfhBeopU2XbSL1JZrA+2kjJvQ58XrjCAcTzCaYfgFv+8g86j/79y7abu4UYKnOnXHs7lunyQNodr3w4W00hjXHfSk+DiDsIuDplv+IoU90FZDU9BzyBM92VHwgK1sGkX8gLx+cewpirWZXaqVw6xKVibTAUddF4Fuwh/3i9i5YlIvBBZeWWckFOpPnjzxHRn/ySJa77YI+qvWfv7puHYb9wgjjJOKMKQ+AeD0fr1JtBJ8/VDGt0JyDtI4sbGgtNZ98uuSLJY7fNUMgVsDSBUKUwEBml0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FasI+fhSeuixumYprzf8i1y5eVKpbU2Cy1xfN19kbZ4=;
 b=cSTmRkm+hVA91FlayRPCDC5O/WFx+ui5V285FINKeoO/dJeWDLES1AHLZK2SJ0TYIraVg2bY1ZvDocdU0tFM2U0fOhQniw2KqDn196tJ2HmKSw4GgYrSwMCR/rhh4wR9TzCN8S/ANEIrvGaLO/xTCXU+Mhv6SsivXPL+m5oaGC/ay74TES+rDv0xWe7Brur3C+A9gGuPKT1J2+wWDGhGDzY0mhsp0eSyGUNwP1mUpp4KRHrE2pUcUgjq8m64xr2kA1YNBKGp7NxyaD0cHpS6qZPzxyW1wYpEm28mXX+ACiFVUqNauFcjCbOnDqzGP5LYSXAzfUbtEiSA2FiGNR6gtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FasI+fhSeuixumYprzf8i1y5eVKpbU2Cy1xfN19kbZ4=;
 b=CswSnfJXddaJfGzfxLvUO3MM0XgZH7PdnZQOZvO+vwZdU2shbmGe5qMeYjbtmexOK3hns3ikTmZHf47mIxfBXyZ1RkzsY33gt/m8jj63vxI1FyibdqJQ0UD94saJI7NViZqecuwitI+WbH2gs2DJAXakW0BlGbn2xuSZe0Viad+NpggODHl4NF1U1wpsMPpnFflpwVKnQ2vGxqxOjsUlPdBqRe1ZKCxz/diMnDONZytHR366HEgXAbyT2ebFR69Jf1VInNAchB/AhquOC6af9jKlxcCdMgNl0j80ZhwmLbbXoXBUv2u8+OzaiHT5puVXM3NXpaOlEO8x8nN/dP9dqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 23:40:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 23:40:07 +0000
Date: Tue, 19 May 2026 20:40:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 7/9] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260519234005.GO3602937@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: fd47ab0b-397d-46e9-58de-08deb5fff55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	VmDwLrZCURawgKrCqIR9ALQJ98kSdqwXBwGAcvqEwsnXomu/YnWGR44NN2eEPm+oefT59+rnW+fx1G2rkiMmjpdlsk/XyYhjR03N3wlEkQI4e+13+rMONb47UdiVhvaxu+aOKtGhh6QPDwUFNby8pq0eXd8454x/obO5ffvdkgmxAbtytpPIyIkHF8K7y6Ma9tAjLY+iiGew8zucoNigZvedMUjshHzHRv9QS4wzH8dFAAmsTyAKYkfg48CCFQsgBuOLKl43/TKlHwAxxzQ0ijYKRuHSpllio2y209nFqC6Tg78ZOkxv1SrV0JKGLn33YWp+kA1dVxmXOlRjsI5vUkLFBNqPpyZaBRy37PTZLyyFIqCC9+JfjvpJd0DdRPCfRcU5a+A2UysrW3hVV4DtQbn8w7SuKQP/08TF5elptyaB17lDbLB/mYLjqtvY0h90oGRRwq0vTMNX6+5r/TnzsxqGTuvhFRnqX8qOOzlcERatoJcRuLwax6HcqwgoqlTd60wEHSrDj//sdWbI29HfCtQ6bWP94Ur2eX4uWenJB2Kj0EAG/y11alJW2MjObaXDrtDotSkyXufE2uPdSPIi9OHBT19Ajuo0HUXq4FyHzs3eHdOYfYSHtuSZpODe5hEJShFhztM1UbfTJZ9y4RMS6Pnvw2HyIUKPAjHwie+5qXwweZrO7QML4wNIuZZY7xTW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dW5t45DfMLMEyn4q9q379UUxNh5gg1TuBOi4xQbxq0e0TxGkwmR7DQrkAqiv?=
 =?us-ascii?Q?n3Kujyk98LCRyke6jyN9VeZuqdouuFXhzB9AaKmRs6L+KJR25QXlIJm7/Mpl?=
 =?us-ascii?Q?JXFvleYU5Ve3g94mMNSankoRXvXUsU3MKvkIxPGy7GqegmQf7pmaMAlByOyZ?=
 =?us-ascii?Q?3npd6HUUvfxAuqnk4oAP6TYSY8yPvmDtHBwtPLxB1BP+ChR8KF0++R/YLtfG?=
 =?us-ascii?Q?U92YfNxjwv3dGkWgAnco4C6sSva/5FIaKjZ/FGZWe0R/ixY8NcyeIUDAstZI?=
 =?us-ascii?Q?AVKkY6Hv3ENpnoNyI/H+AhSxLoJ9kYbsadbGM1P/VEkvYGjU2t8+XgdBu/Y5?=
 =?us-ascii?Q?2wd0C41sGfSkiql0Ms8D6QITLth3Xh7EgQU0fJLq0xAkj5Uw8l+6Xz2/Et62?=
 =?us-ascii?Q?0c7JYLtL5MmAZzfC4z+NKFUki0lMcdLpKzRHBNdYBaGyKLnjdBfDYlT+QLPs?=
 =?us-ascii?Q?DvayBjF8ptPGGGbxCMJngcIwwNcJ9nOV4zYPbnlJUgWdGwRqgKmOedUEtkO7?=
 =?us-ascii?Q?dVWm1FIvkrKNbXAosriYWX+Jpi3mhaiF8STewmhFK/5QteogmNKUiyESJDM+?=
 =?us-ascii?Q?2UkGD9LSgdRVgwfJlPbpQSddWNwsB2z0XDcbiIydss504idrp7USIsn2c/t4?=
 =?us-ascii?Q?/Hk9wMfYUgq3A9vQVmR/4crcZHWV3YF+lMspKY0ZZa4qpOLuyTPleMl6nQDV?=
 =?us-ascii?Q?bp9xhcNTz7yYCajykV5P/SqOf30VZ89kcOdX+ESWSgrH9nxQO72QU6W5XNxs?=
 =?us-ascii?Q?2J1wt6YraSAMeTjFefa4dUf7NVaEvQ6PokU67zCySL9aZ8sSGx/9Qix0v+o3?=
 =?us-ascii?Q?SWOReq0nkmDrFAu3rALfX8g1FL0QUOIwSSC05GY3OYqF02bEWok8t461sEgz?=
 =?us-ascii?Q?aazMFjrnLrD+9hcOPsW430Y7qQL0eNZ6o5aJ3PupMjwKBupO3hpnSPMSYNq/?=
 =?us-ascii?Q?nep/rxQSc0ruZPqU6DjnH8S1KfhnTdH8AMv95vFUM4gKQpiubm2/GejEcdPY?=
 =?us-ascii?Q?GF9FZ3PY1R82wTFwZHEhrJoCJ8DxkHM5juw9d69zgK/PDG0xGWmzr+RchJHg?=
 =?us-ascii?Q?MQOroAhFSkulhEghvwif5tLA3BtRkTII8CuxpDvMF3GPKmupsbXQtpXnL3VT?=
 =?us-ascii?Q?OhsIdUKG8uyYeNv8EDjOqvMm3QeuyTQyqlKqEojaNetezJxfwhXspk2iXi+N?=
 =?us-ascii?Q?7kEs/YvL+8ijCDVT52IzDvuyycRY87CY7KS4aCAOo4n5ig7xV0YKgFvtjtzL?=
 =?us-ascii?Q?sdvrjVv0m7qlgyXX7M9AkpGCpDaIMSXxalDCAr5lqwiiX0ejmUvPD7E/OmSc?=
 =?us-ascii?Q?7NREoakJrSX7Jgc4cYIQUE3fOjjG5YO4esUfG0tIfGWLHSb4FJ18JyYneeuH?=
 =?us-ascii?Q?3lypGOx9o2NwgJ0jJuldHE77v4NeErIiD9iezQU1cWQdHOCj/R4Mkrqi+FGg?=
 =?us-ascii?Q?A0lkCdl8VGQF4AMAXKdNSdNKW3fok0B7FAA6qed8iyNkf1Nw52G8FyHj0EOW?=
 =?us-ascii?Q?Q1C0PNoQDrr5Y+heBwtU+f0yFo8Hjt0k0pXmAVpifSsR/ZwGmxkmhVIVXGaU?=
 =?us-ascii?Q?l9FbC5wrxBFKqdXj8BKVBEjDm1UhQlkJhjJT2C1esgrArzJGhWaD3uWAlCf0?=
 =?us-ascii?Q?Ga+JZucGC3J7d2ENV8kEV0NFh2RUpRV2cTUp9C+mMCtuTLvRpHmqKZ/apq/o?=
 =?us-ascii?Q?71ekgEJYTtVNrUGrh11+9Y2Fdx+4ldWGky0BnbKvMVK5GJDw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd47ab0b-397d-46e9-58de-08deb5fff55c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 23:40:07.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtvWFrApsTfcIbq1kFlOO63vgts4PUw9VE2UAsHCsDkSgad5isMXRGd80eIuXwTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461

On Mon, May 11, 2026 at 11:41:12AM -0700, Jacob Pan wrote:
> @@ -110,6 +113,13 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
>  	if (df->group)
>  		return -EINVAL;
>  
> +	/*
> +	 * CAP_SYS_RAWIO is already checked at cdev open, recheck here
> +	 * in case the fd was passed to a less privileged process.
> +	 */
> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
> +		return -EPERM;

I don't think we should do this, an open only check is sufficient. It
is entirely reasonable to design a userspace to drop SYS_RAWIO after
it opens the FD to minimize retained privileges.

Jason
