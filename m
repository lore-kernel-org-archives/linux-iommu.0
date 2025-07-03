Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F3253938
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541669; cv=fail; b=SMbRPCJmYWPB3ftNNDpJxY55DOTyvbbE2moszF2xu/IKqzWvK1Rs3KYhJxosZoVSKqox0danInXE4BfIdqD6GZMZ+VXDdt4G8DgoBF0l9ARuhYECOmZmLza9CKKYac4lQYfb1PFQb8mXUJIdrGn5K0VVKcZrVb3XcA6c3OZCrss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541669; c=relaxed/simple;
	bh=0tslnwaDDClGpQIDLO7dW3gdj8iCshPN2/biHkunpwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WlneUffAbfePFWSiWbtKcVZVBLta6cGkcKNIMm1TUJuHXmttAHC/Xq9FXv2wTKs+OcyPkU4gaQ+8/6IGRNf7Xu8fhPTVenjTk4ZWyx+ZLxgfm73GsXHM7JagqIAHoLlO1mLRD4iAgk3vrASHa3XKLaAbWDh8QEwj+Ux0ggAklWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B9EFIVYl; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B9EFIVYl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXim5ZfA4PhsOF1KZhuO3xh8uaVVWZERsbNYHN+CzNTt7xmwrtLwxvgQsUa79805v6+hyYLRHk+2BkiU4Hka+az/TH2YRbwZY/X32wKK7VeoMnit3UNMl0n3HRJbOOocBPWnhc6waO0BPA0aWUPukJYmMl5+dydnUwx4T3K9Xgcw8ZOu7TgVUGXD8OWZYtqEtxqBPKFCRyY5ZRTncDljHQG2Ruo7hPONh3Q7vBDhh9kS3cPr+ZkBRSuqefWUJSFJw5YdXhvtn7qQJ+s2946kwMdsuGJDBkeVA+XLqH2tfms5qoTRox7H0d0PoZu7EDlmgjkNmRhAm8nFIUeK1RutcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMuACQxla4hEBztPp2206iFuSuOocs95pfwgKsPDRBY=;
 b=uEaqzH8fVoV9m9mAvtYigTtL44J3W4ExsdlXbVyd1U9R8l1Iqnbs7NlMiA4mnmdEcuQj8hUH+pun9zpNO7jLUe2zubFkuuG0f05yVaDFZoEEsUkO8Pt7OiKBcvX/OJaghLM4ZR0SOZNwGT42wf5mSTR3zlQrqh42FeFvbssv0yaA2ZtMuC2Wx7L0EwNAxY7YeV5s/PzXXX1TC7aOCO/Js4e/DtIwTIY4RQHma7V3AYueWe7a/KR48zsLOXgrEjyMe0pg5t4c9nCnjp2YS1ckbDs9SQb4VdNtsL4KPl/nzmgGMDeOLfCdHTzHOlKL53CmkJVTagewFULunXWmGAvp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMuACQxla4hEBztPp2206iFuSuOocs95pfwgKsPDRBY=;
 b=B9EFIVYlLRumG3uZ24f/JuxrT2qGzXYx6X7Op7P1ZQcKkE33VSxesYHim1aXGe7bldonyUbOzl8yQ2ZJqejoCKRuSSJalt4RXMBOiK5MHPLtG35yhfZlVMw30iltAurzs5sN4bIJwyKqIUpWaL0almb/0nnsvOsbagrg0Mn6Pu0DkxKULOc2OKJnecU1hUWfnpOPPnkzFnNJEfkXNPbGKvF3PE2VNTZMnDY2mLEWGJgtjBaLM0VhsFGmamII+2sSPFrO8ux6fxgdp10feGciUzoQGuWRH1oDc895s+qZYX8ZtlI8bBN8CnsxwF6yqCAIzrkZYKUO1HVQFlCl0hZcVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:21:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Thu, 3 Jul 2025
 11:21:04 +0000
Date: Thu, 3 Jul 2025 08:21:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250703112102.GA1209783@nvidia.com>
References: <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
 <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
 <20250701121315.GD167785@nvidia.com>
 <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
 <BN9PR11MB52769790C63FFCDC711E80DB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250702124042.GD1051729@nvidia.com>
 <BN9PR11MB52765B056B71AA14943BE88F8C43A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765B056B71AA14943BE88F8C43A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 627e74b0-8a49-42a5-5072-08ddba23b2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wGPjZLgXLoqp4pj+Y4de6Te+xRDPcL3eBkjKxZptjawIunQtjYplVzCwvNU?=
 =?us-ascii?Q?++k0Iwjq3J6cdJIDx9wTZ5IJ630fQjpAKt4FlFGnirlIB/DrZKlV+iV8l6TB?=
 =?us-ascii?Q?f5Pj7f8tmTr4gYehgywnVgVzHroTGLRGddZjtyZ9LpAlegUVKZY49i9WQMBi?=
 =?us-ascii?Q?nt1I8fX4G8EV0PgNmMluL+ed/o4wRsef4NM+L57U+7OubMfHrkBM7FCoqL31?=
 =?us-ascii?Q?rka20NTOThOIIJS5xGUHcYTmh/jtJRyHxke00g5W+cMgDSh4ICxukmv1KbpZ?=
 =?us-ascii?Q?2JLJbrj5qm9HcL23rUejatSLGEYHqyP75oC/TdC9HDuWpVb2hrI4WAEGEA74?=
 =?us-ascii?Q?LaI7Nq1xEidVaUlXWlJB1XB2MWaOumN9Bavz4qg3hzef4zTfc9nw7su47Z4y?=
 =?us-ascii?Q?0YwbI8DOKQnlRBWuzJy769GllJXVJYQ2Pp6UjlZfSnwI4mU9sSNcrZ7Q/kTo?=
 =?us-ascii?Q?hbKhzTHQvW9lznV+pzNLnLcqiHsGIPI0qtzKKgqVtfeSVsFs++aqoiJnbSql?=
 =?us-ascii?Q?rQ615hGrI+9+8zAVqMeyUiwvIJamjdeU3MbNWyGNEuzLUPJI6YTSjQRnIDG0?=
 =?us-ascii?Q?5YZsuWhEESaZNigWXU+2o1Yag+/IOaq+oAcZePvjyK5KrsN/48GfrGGyytgV?=
 =?us-ascii?Q?ZbqjxfyZoLE2JSiF6/+x+cJn2/0ybaA9XqCHTks1pEvgdE+NTZFI44dK12Jj?=
 =?us-ascii?Q?phGyVa/fVbd2VOmj8YwLVLcHPtWHGBlIQyI1um8XiNjJlXCvo4KQlSBQpZft?=
 =?us-ascii?Q?EC94TlQtfq/8CiKpVlpISr7BuOLBC4KXLvItHEgQi4dPzwc/I2Xd2MbcIhP1?=
 =?us-ascii?Q?YpbRwtgBCx8wF3/WXevwfytHOIbzP6o0gS5WjEaZB4mN0zhU/D732fghQ1U5?=
 =?us-ascii?Q?Pecx25E5oByt80vPucx09UDODUUG9rezUNN9qNyZyV61fyzzcqzykPLUObiv?=
 =?us-ascii?Q?+Uq/H9ORynULOH063DdTy7wrpBhcxBZ60gwUvbFl98GrIAAGZJZ8BjFWyiUj?=
 =?us-ascii?Q?+IKu6VCxddZPYQRs6kt9TYT+toQ9lw874j+fN9Fok8o0j1jyKAUmvsT6qK4r?=
 =?us-ascii?Q?11fxOPoszxZXHkcZsWuHUKyURu1VHK8bNSJK6I8xdAt8k3s9hDM3/T71J6Kp?=
 =?us-ascii?Q?kJDdjgF919yBzWnaLTRo31oksksEu7DvJHq4F1/lhMddbMP4lgB2Fhvq4Hso?=
 =?us-ascii?Q?ooMk/UOV0eBSmdvcUnfAVIZ8SZb8GSfeFiuyep7hpUcZ4Mr/atS9gpsPG2U4?=
 =?us-ascii?Q?1yK3ktqP8/K5UVnKXCVL3sANt82nSTu/3IYSRVLfEoZQgwMGP7rC0bVRo/rp?=
 =?us-ascii?Q?OIku5QORLuX9gbvCZov9JcUpOGs7S5qPd6SOtRDa69tWnGjGNcANhaMa4GFe?=
 =?us-ascii?Q?sUnZe2qg3N546hAK18bgdKG8o6hISGPcUP1aBHJ6JkYtwDgYJwJdcoAzq0qN?=
 =?us-ascii?Q?5Q3LdEJEmeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CLmS7MSb/NfXLmCyrXd9Q3awEJZ+Dx//09HQ3Zz1sfleHtjqJ5rvBQ+R82DB?=
 =?us-ascii?Q?WrPM+Ym+VvbYPKv7g8DHHNS/dTTwoRIsIY38seQ9TXELQjX5ZmiFdrUDnBTc?=
 =?us-ascii?Q?mTghWImDKupjHAgiMHBvTQsUkt94PYm6IxOOLi2iIQNsphS3/Ghqbj9z8koD?=
 =?us-ascii?Q?ZOQg3e07BCVxhqDaznpSXqh7W8nX4DbNzriBvQ3w/rK5NaY8gxXQORVgCDeb?=
 =?us-ascii?Q?Zh+3GKrCNC1AEtvdzEQ3aiaa3gifdo4FQi7ZslHY/mzSnfKFq8ZjCnVwlePh?=
 =?us-ascii?Q?QSTdi6/nrQ08Jn3Hjr0cXeu4rnq0HmvBOEV8rZrJY2PQX1Io7BiMEiq00HSU?=
 =?us-ascii?Q?dGmxOkv0KbxYeT+AzSHJ99rQV9gzrubzmFH7itlMbu4cxRSlVWdnSeB4EWbP?=
 =?us-ascii?Q?H2eMKCZA2pPjnSR1wRXW3vfsvlXjyjuhb1wE63WMKKh388UwZvmhLYD9dqx+?=
 =?us-ascii?Q?gKQZgY7/LNGUotSmqaX2RwQq0yAf6facNnH0CMK8DSV/zU2kY98ZvgCn3lza?=
 =?us-ascii?Q?gHu61JD5jJP/CqCFUEW7IFSKVZVgA6Fs3XpEhPgbaQgFXLxgUjGlAtOZ9QWd?=
 =?us-ascii?Q?TAlMe6O3UQL2QG4kUkwiMq4j6EJwsZPZ8YgCwCHS5i4+tqFPkWbFBgMT2gR0?=
 =?us-ascii?Q?6i358hT84eW6L3YX2FyxQuZSs0mVyxDsw0PwdU1KsoLGng7LMUZu31IgX2lw?=
 =?us-ascii?Q?4UjcIGYji6u9olm/gJrcQL45heBKFncse+r7jwat4w/CGtz2S211KufzuuWQ?=
 =?us-ascii?Q?YsFCimMzVUoCIDwCeMPm3oBaE0Nu+v1vDBXts/MOjH0jAMrkG07z5MdClVvW?=
 =?us-ascii?Q?LXjfg1PPPg/TqcO/mFL2nD69XvdJDkm3v2ZaeY21wjn98a4c78anR4dCGpLr?=
 =?us-ascii?Q?Gd5BQqhPgM78J7ugu0mCdmDYiKalcyGhc4IqTtEGV3Pi6qewcT6H3i/Im6/T?=
 =?us-ascii?Q?RL2FkmGwXdg+07R75DV89EIq2XYPJwfLHdcOqzdJg4NeJ7at3i5q73EI/LBj?=
 =?us-ascii?Q?ekz4lNSQMdOmYJC7uT0PezNHStg84gkT734/7pYjAzYxLOE9PxCy6HP7ssS9?=
 =?us-ascii?Q?j+0mz4OFRTP/H+F4gJrH0QhXojPfqk2tCOTCxTx2YiHPUfy88S31FPlWZ5ds?=
 =?us-ascii?Q?M0tzgMAeFZBy6MCqKMEdT8J+RO2MGJW6Qsnw0SDa8POE3CQOtHB8dw5oNw/L?=
 =?us-ascii?Q?ieiy2Zbg5S/HjHZi9Ri9BHwoQUeUEddKLd1CLdnDxRgEUU7+tPeb82WtSlNO?=
 =?us-ascii?Q?pzGwJ4LDyc94x+Sp0qVUiX+3paF27/ozN53+11C/bZi1LKL3hADPwYV1jUba?=
 =?us-ascii?Q?jKUxNYMFZNBBh0soTyv38qDs9jhUHtVAIs4yFC2gQkFc5v3p316MbeKikP/W?=
 =?us-ascii?Q?I4CXnIw2S2ePoSbAc/XLmeLkDKL2pPqxMGESMn+QKumb3fjdBETH8heY5uPi?=
 =?us-ascii?Q?LIM08s9DlMvTfUWeOGbG0ygpv7MDL3FONcOQ8ezYjiBH1fJ3QOpi+3C+QMjH?=
 =?us-ascii?Q?TJmbwM3qjmgA6VZ+9gHxnLDw3zMFnM6rCY3I51/rlpqX0WGE8AJzVhfd2A4/?=
 =?us-ascii?Q?A6z+wZBfcxQM+oHrIVOk8Qlqy456/03kA3uVfhf1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627e74b0-8a49-42a5-5072-08ddba23b2b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:21:04.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSJA0SW2lcmMTgMlCvUl7S9tcv8Nb76ExEaOYfar8m7RYkMEqNsTMhNa2MOiuAh7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115

On Thu, Jul 03, 2025 at 04:32:26AM +0000, Tian, Kevin wrote:

> but this sounds like a misuse of shortterm_users which is not intended
> to be held long beyond ioctl...

With the addition of the pre_destroy it purpose gets changed to
'beyond the ioctl or past pre_destroy'

Jason 
