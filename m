Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C715E5B8
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124742; cv=fail; b=ZV9zjelmSsoGAaMU4QR5dJ7tHt8nGI5IVfCmiMn9E+4i0dnm3hM7GB2SGUrjJ7g4Hej5s7PSAqNq0zK1HraVNxNNd+ahR3vX/Jfsi58C0BoACZGDg3JOgk8LBlZPEGw1y7TnGg1eqRXxybdfP9y8P3TYeOyiDODE6o47UI+tgaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124742; c=relaxed/simple;
	bh=fokIpho5t97dYHk7bN46qKJkIDGc4dH7OOWHXA+O6U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mdNQP2xOjbGMxP+RdioAoarhfeBBu/WiuG2y0lnDZCDXcKfBRw48h+S1Peu4rhobQo0jBrjK7i6mVxPy7T42rBIkwebUWF73igcQDPROatrq20yGL2w54X7ruI5aSFwPQe0HJ9VDApgovUyPORD9USWans5XHOJr1ZEOCwBxULg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXCv/Axm; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXCv/Axm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paCs64mhtJFnO6BOqvC7EPD86Tw1TRUkPrOSs3C8ayAFKfWjxm4yd8nJp3/LS5ShQWbUyTjGOv58hDN0QQIVqv8mQykrvU0tXa9TgW49VjWd4RdBftwpP1x8xsLudspAa2iTS0GZREZ/5SZiPBpE73rLBiFL8sphuiwalj7lQr0rT8iijzWGT3zPqqX3kBWGeL5MMKItKojFg2v2UxIHKjBR9SpnRKEOAZXVT4VNjbdu4rl3sspvKkvY6xLKFpIZ6CJkczn8/D7nGYgcZuKoHAjSnBWe87HsnYKYcv/PGY4CkJaZDS6+OLzqK/X8k9kysQjdT2fvOnHaZy9br4epGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxMVa5BlTMR+zmQ1CBbjjulFHeyvAfMV4sfozlOPNio=;
 b=wJczcnDhHOH68ve/fWhPdYbBP9N/D8dHONaBp/kZEH++haeiUTNoRFmxX+Vicix9o6Pa6njOqd86mHX/aUS3s/ddutFxGaFMH82cPG0RuH4jlA0rDPsBsYujV9KyTOzq/ws3rlZk5daaq8XOgAkVOZYrwQ5LEExMiJHjSXKqBmsBDf3yvoLbdVGSxcIiaNAQf0jF+w8pkRxOp7u1FftgaBWWogpEY2PeM696TF1AEs40fwXdUyJ+Te5xXc0ZHUVFSb3OPVpETi+mYy1z0JTgosGuPlv8k7cVZsmJ6cbg/ldViO/d2fEtrs+b/Dj0Zb7e1mEB/tKHEQmWZfWLt7H9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxMVa5BlTMR+zmQ1CBbjjulFHeyvAfMV4sfozlOPNio=;
 b=YXCv/AxmDp0JDP9T7PzXC837IHmvi3mnlZIN37une621WpFs7Hf14ViMeYKSAesqIUOWOXzZ8xK1wHkv9nq6CJfkE4E9duQ8MK6y7Q0mkQobXq1yQE2wmjaJfx5ylKjp4oGIQSk2TBMKRBK9WYyQAVdtDANOIFLqFfq8AOYljacG+GCLHiMgBF/fohWMAPKkMg9NyFq4QsDSdEr47oNbgG9hwcGB8HHH6NQmA5O7X5G7tU925PHOgqpclPxRVhkvhl4deKncI2vsyq3kyx3G/X6zxOqb2qSJdz8J4IPc3s8MseclZCCVDgXwAr3WISekPRMCoekCo+qAWrt/2Lb9Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 14:38:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 14:38:57 +0000
Date: Fri, 17 Jan 2025 10:38:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v3] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Message-ID: <20250117143856.GD5556@nvidia.com>
References: <20250117020449.40598-1-nicolinc@nvidia.com>
 <BN9PR11MB52763118C04E83C14683CBC98C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763118C04E83C14683CBC98C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0406.namprd03.prod.outlook.com
 (2603:10b6:408:111::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8f607f-27e9-4fad-c3cd-08dd3704acb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLNT5sf07zdB2Q1SuUk+GlceaTLltrf5rh1gOfihsiHDiVZ+oPFG4fB7vwjA?=
 =?us-ascii?Q?W60InbkkzjdJ9d3IkWjF8M4FMGClCUwIFPs2S2Q8zbxBq8TnWE53Wnk/F09M?=
 =?us-ascii?Q?PWRUWb9idOCmpoS1aBHQ+oPVhFv/vifp7ur0t3OmRxKRDEJZeFK4e655UjGK?=
 =?us-ascii?Q?MiXsXd60Tv5Jk2nUZw9pQqrUUwe1EBVPlL7AJG6OaaVItNlHgNr7y8tRVEkQ?=
 =?us-ascii?Q?6uNCbIhHjF/CZbdkKF5ZqnY/qED1JruOuu7sDFcJbyZDFQQf2gSJ7V4LRhuq?=
 =?us-ascii?Q?dbRDKFdh7srfeLkAEFE5Dt333qeMb1SJ/pc9XAAnRCA80LPV6eRG9y9yvp0D?=
 =?us-ascii?Q?ts1NsfShNbYeXX/s/QBqt8bx8kgP2u2tXjf2vZJ8H/zqD5PFO28Qk5T/JHCs?=
 =?us-ascii?Q?rv/9c7q+teaCFEeCHQtcIAOAHwZnvw7Np/jpZJneN60d8OrrfNTSt9PCFXgW?=
 =?us-ascii?Q?kbLel5U69KexvgSK+IUJbws3Lv7yiE8w79g0H+wcp6D69Ncj1J29gyiWz4Vb?=
 =?us-ascii?Q?/8sWJTMgmPqEzUWAaWdaT7kecYUzQyUAu1rF51Z6YUzOA5S9zZvwFS+sw5eM?=
 =?us-ascii?Q?ae7FC6N4zbEnnSh7tGeLn+M/q/TJJ9yvVSwIQu2T/5/EskiRPDHRXuU2zNRt?=
 =?us-ascii?Q?grlJ23tFTlqdGV5lyDZar2KK3713HseaN1oUYVtqDyn8CxQjbujire2Yim13?=
 =?us-ascii?Q?MapqSk2Qzt3F+e511adJjWyx8ym8FRRU+Sf72Uqq8Ktlt5SvEChldGla4DsT?=
 =?us-ascii?Q?eFYuGbiw2H967tuaEMo+Y9cP/CpfwGvOG7hEX30t2hRpEsjOTGm99HyNkKjY?=
 =?us-ascii?Q?1W6lYndo7aj/jbZ2c7ENqqCJXEWzBWrIO/XNcQTZTCCET2kLWsoCmOxJ5Wm/?=
 =?us-ascii?Q?pg0GStzptlIIW8EZxedD58cKZq27Y5PAJC/9QijG7RhxzYp+jWQCvLrj6cNc?=
 =?us-ascii?Q?++9jZMkGcS9uQsHQH9RTvcnPD2ZFmB9eRRXcIm1kPB/xwSrI2424+AYvegHW?=
 =?us-ascii?Q?o1K449Bb6sLEiQTGpb305qHB6ejBNJpcuCJ8+nDKDjLOUxj7uBkTC6Zx80sn?=
 =?us-ascii?Q?zggtrs4QL9ix8Dp9CIBgFGjHYiRRQOfUUUY8xjnipO0gdRGombqDm1212P64?=
 =?us-ascii?Q?UFAYtAlUFyDmpkb36S0KUcvpORPW7JYIdo7geOHm24sIdILt4ZtCzDwGQ32Z?=
 =?us-ascii?Q?lMh0zTYHYvkrwz2DGqSatvuKg3jV939ZlYYNkdYJ6myQK4RMb4bCeu79xuJD?=
 =?us-ascii?Q?tQ5ETwMit6hgzHy0Vl1swyLAjY1P+PPVpMeYZYiLPgfX9CPkRVqrn8veokps?=
 =?us-ascii?Q?9iK9l1s1apwPCnU/ARNCqWtvojBRe7gSOEnEUnUNh3RWE1ObFp1v7scRix/Y?=
 =?us-ascii?Q?SPwfeDUV+0jVMjW4LkWZofKPlSPi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slKWFUiKNfXByrwt1CmJ64V55pn8DO6aHNlxYViZtGJVCl+5uCSXEXCJRrTh?=
 =?us-ascii?Q?W+5d7q3aiJjgEL2tz7js/1SklFyHiOI+2ZLigS0mtpvASBrnrheNtMZpXVGm?=
 =?us-ascii?Q?cwf7ffNc70cf3GVgeLJfIQdboLlsDduj2G7U9gOIm7ZzBqDmXBKuGi0H5gp9?=
 =?us-ascii?Q?V3XSZpgCf8df8Oc1t3NsIfYo2nd/E//NgMkm0UQFf9auv2+jLuUiWf1H/shv?=
 =?us-ascii?Q?qQvPk6AbkFViFSHra2sD9NMvf/ZHqq5CnD6cufbsP2gfzQhtVI0Hx2oSKX8a?=
 =?us-ascii?Q?diPregmv9kibLeJXefZHm2xEwFIJO50avj+Y1wF4tLQaxvmxZ7h5uTHv09m1?=
 =?us-ascii?Q?uCCknWNtCBXkbJKpTKPftba1sWh5n0mD4sESjLkRoAoA0loOFFrFeajToeQ0?=
 =?us-ascii?Q?LeMNiPJ/lpRo9SaTmUNQoFXEScpVZytoVaYaRXiKOMVfzVFC67NMBcznduBo?=
 =?us-ascii?Q?yiqa1synJSjuVAH59vWl+WHZYHrDUeCtkqD/taUBFDUUE4m7tAAxp3QDsdQv?=
 =?us-ascii?Q?Qt/p421FqnsK6r55IHGcbgXQJJrqx3M5fmfb4bG1lc1dPPItuyRZwR4tHO0O?=
 =?us-ascii?Q?OkrZ5tuB7QCkwl1T7JRnqjmKASj38yZY525jcVHjXCceIUrXXwno4zgvA08c?=
 =?us-ascii?Q?OUh9bRclFooFbHf/LY7OL5wPG0MoC5KXUPQ3SlhydLtqw5pvpejT0BtnyIAK?=
 =?us-ascii?Q?/mfA6iolBOjcC1dC5Dnp8Y2fV0OSIxbD8il3I/l1NBnCG+PHPlF8I5m1jH4U?=
 =?us-ascii?Q?lGbn2QW5XIXrxW5HEdp5LXjUoAAESWrFtQeqW7CYp0Eu25ACajAgzJChoHyR?=
 =?us-ascii?Q?n43GBnklOKnlHvUFuhOLAQhPYYZaq9M3pLUCefzTZGeNcrs03jhu1v/aeT70?=
 =?us-ascii?Q?bn5yomYpVJDLwRg+Vvf3sZnd2+/EVn4AcIbDSUIUmPSab/XmvuWgsaShSN5+?=
 =?us-ascii?Q?B1tbwjSO2lP7jH7lXYO2SO2B7bWHgsC+k+4kLY9z+ytaltGtiX5xMxV88YIl?=
 =?us-ascii?Q?/zgVPdJtomG84Ran9LSNr8s0a6Kyd3NYaKX3jQg3sodX6efmUBLG8Ko2JscP?=
 =?us-ascii?Q?Hwe7sAhUIi4CaWONXv10k9wfwW2wDd6cwyQbP3ojgqlsWTtNXY69QwKIZcwe?=
 =?us-ascii?Q?99J0UIFU+DwMzm9Vpt+ajTSKf10Zgy+YNIrUFR0v6yhMi8LkjIpO/f/pW/AS?=
 =?us-ascii?Q?wmZ62OZ6xsLTHpHhi6iIeJMDLBQSK50XYd2p2HEK4mnUF0Xbk1N9MWduBss4?=
 =?us-ascii?Q?QokEOjOnKMF/OOOyPF9TjZnsMYr4grcQNM2NXBbq0ZqqFjvn1bGCCNahNWMS?=
 =?us-ascii?Q?W9BIjxpWiTU/GQpsoEkBCfVgHGkoctnLX7dtb+Bj59o0Z0+1wYy0GYlynQeT?=
 =?us-ascii?Q?lMnvr7htDf7XWm15X6mzm50vLArJ3rLI3SgqIX6Zagmw5Rw7RMlPWlAZU+xx?=
 =?us-ascii?Q?3DkP/kFy7GEm9isPosybUU+oXscoq1ygDImjzUCEb0qCCRlc2tS5x/7ePhqd?=
 =?us-ascii?Q?iWV6Vp3xZZ8x0DhOzQTglgqHC4f27j6Haa2pHZZImpgbe5FKaqwOH7mFao1s?=
 =?us-ascii?Q?6bTD08dF1lxX258+VXKgquaqqtQHNOkjiuBrxMNr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8f607f-27e9-4fad-c3cd-08dd3704acb9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:38:57.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v20Nw/xQV7GHuuC8eOege1GMLRG9p5wx4hwGJnxLlpHqSi6NBNVTut0zKCG+faGO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

On Fri, Jan 17, 2025 at 06:20:15AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, January 17, 2025 10:05 AM
> > 
> >  	mutex_lock(&fault->mutex);
> 
> Nit. The scope of above can be reduced too, by guarding only the
> lines for fault->response.

Hmm, I think you have found a flaw unfortunately..

iommufd_auto_response_faults() is called async to all of this if a
device is removed. It should clean out that device from all the fault
machinery.

With the new locking we don't hold the mutex across the list
manipulation in read so there is a window where a fault can be on the
stack in iommufd_fault_fops_read() but not in the fault->response or
the deliver list.

Thus it will be missed during cleanup.

I think because of the cleanup we have to continue to hold the mutex
across all of fops_read and this patch is just adding an additional
spinlock around the deliver list to isolate it from the
copy_to_user().

Is that right Nicolin?

Jason
