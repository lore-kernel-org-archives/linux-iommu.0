Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F61C28E
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854827; cv=fail; b=QsHH+SgUZJh5pXMcwrr2mij6Ax5epoOSCOaItlozpB6vf2gsHWKUx+daES982JKLw6sljSOoCkJ0F7hCkU8UGAcVhpNEq6qG8nuhQ5lmckrXt/Sq/68SQy2Ht5ezJ1Hykn181gv6m2d/U2kKfttOfAV6dL7GjLoMkyyrvL0f1Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854827; c=relaxed/simple;
	bh=FSWTWd9Y2HQZMbxTiVPHqSgOtnOeVHDgSTn1Nx7PBUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kREzXWiyO2xpci2mfyBYr0zyS7RWGnnGv6i8Zky5/nAO46H+ac70o7neEbjExYhYvPUWeXP//HtRd6vkM6YAah+1/Q3DxPM9e0BICZkd+9JbIBjoZ2WYjqOQF0/Mqa3/X7nnJJ/2y/TkjC6kdqnXjgUXJWB9xUvtPbuQUodt2ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lBEWLzUc; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lBEWLzUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNvK7N4Ai2kJDg82vgufDaCtg6p+P4zvrnBb22hwJzUlGrJ6TSqjBFVt48zoIp4w1pW179H9XqSypSX/mKJ0ZbhZKrtwABoAkONsrVrM6og1VAqImDbEsN2BJXb5w/KQLSeKua7tLop1IECQVMczmVpwy+Ssqn9T+1Ef+EC3TbhEBnVhwtecfkkD0gzS2IRDkwELJAW7k96c3OPUol/5s20eSWEFAfK1GN5+ZRFiBU0RzlPvt7KDHecCe80YR4NIzx1f1Pxh/PB99X9b6DRZgIBpriykBBrzzDCklh0DW8GZi5UslPzQBqVzj3WnYWYLv3mpZ32u3EFbJD1Des3wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvmZGAP74Ha0pKWRMYe8JQiC0h1UPlKSic55VB4tC3s=;
 b=ATzTEHrR5FGLeorgNj6u9oLLfwO2XThCrOB1N+gesyqZ8YTphQYvA13XD6fg/Envw44JQ6mROixVQ64Jn5Do7TgXC2DiSb//91d+vNwH+0ZmHjTjPYaLcqphQ3hDyg4bm6oQBabNKPAB7D35y0LcWG5DD/jvzYO9OP04uOZRggdBok/O+W7Etpxb5TGUJvSApBnTcmopmhcl5utSspCyk2LeapTLcl6gouSU983teI4xlatj+ROuSNfnd2q6IVbIQxJ8Ywi+zvt7lLeyYVbyuF4prvr6hOcQNZFkt6kiK5+mPVHxtBoLYYsNnTy8z2ndDNo9l9hhSp+LIeHE3L2KRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvmZGAP74Ha0pKWRMYe8JQiC0h1UPlKSic55VB4tC3s=;
 b=lBEWLzUcl9rfPFNH5hfvHMRlLNqNr6JTYbELjC8Fd99JH5v/R9mncqPvnafIDqGUH5rNYKd3fyTy1c1wY2WRKW123T8xyHuvB/lzQkNU4LZPGY9D6RG759hUVqwRsUYr1NNSjKGjH7x0sJ4mfYLtaJZVG/ms+BWp17bUh6n21hvcF2i6cHrFQaV8q4+WwbWI5PGzmFWeYG4KFsC/5xiMr8ELiBly96dBSFTrKeOOatH6ipXiqYS89tisuhyAQ3Yh54x0zW09uVfSWVeL9/GbMZd1rWskJ/Wez4+f3kvNJBIG0Y0V+d9R3sMO/pyOKSZE4CSM5P3Pw33jBU+YHc+eGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Wed, 25 Jun
 2025 12:33:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 12:33:42 +0000
Date: Wed, 25 Jun 2025 09:33:35 -0300
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
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250625123335.GE167785@nvidia.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <20250624145346.GC150753@nvidia.com>
 <BN9PR11MB52762BD911A3CE2F1A062B158C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250625013629.GD167785@nvidia.com>
 <BN9PR11MB5276A6F54C0391F72F3CFD7D8C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A6F54C0391F72F3CFD7D8C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0340.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: bc259ecd-744c-4967-c5ac-08ddb3e484cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XE9h9zm2SOvH7dbC6DpP5Ibdzg98ythkOidthjBddriteOTwptca7ztK4uaC?=
 =?us-ascii?Q?CFP5H5hPpWiB8Yp+MctxCwbY9JHUWsUsFoJigcnWFezA1i5iYUmGsygarLtA?=
 =?us-ascii?Q?n0W2AGBeR86p5a+JJMIiFX6U59P6xVtNatAMB2MgE/V9PQwFQ9fVCOW9l3Pl?=
 =?us-ascii?Q?Fu2AXR+P8fvQF8uFriDjUwFVrcIBMyx63Apwcf72Un7ktUckxrUSYI8edUYm?=
 =?us-ascii?Q?5lK4clCax21BgsEXglNwR113lcMguui0JQuQeXNA6spAKuNndasOuJQtlnRA?=
 =?us-ascii?Q?bNDhvWxy8+nUOfCBnZ0a26Olr6ZHsDW757/1ExxqTKUw50akBP0lPkMfsVt5?=
 =?us-ascii?Q?q9IYv8vaUTZBqykiiJSKGx30lomyjGOpjD5UaXUl4M5F3/JOY3BDtTcumWwh?=
 =?us-ascii?Q?/tHzKQaPv8I76DXR0Mycn8ioVzpVXo2L9RqkOs9Pq27V5WrNJfC7aTzCJ4Bu?=
 =?us-ascii?Q?ce6TLEVOd4QjSjeZndiCoOMy3fLAuEaY6oyQs1OMrhiG2iz6D/VA1KROBvjh?=
 =?us-ascii?Q?WQXL+1jhEMpQAsvuQsDDgaIfWSy7VmP+DjA/tRdjwOXPYH82yNLWM/aK6rXD?=
 =?us-ascii?Q?IvZ5G3/8obKaE4rFPq3EKfs6pAVjIlg7k8MaadlGyq86IpVik9JUUHmkuFSG?=
 =?us-ascii?Q?Y01Gz2CAXLNV+sbgVwuLE7JybBh7yza9OaMN/V1TPH0n8gHOGuIiDJOe0KUT?=
 =?us-ascii?Q?4Ry+0sy/kqay1EaiKxLip3AHr2oFt5Q8Q0m03Nn8/ttq7hNwA7chK2VuARuq?=
 =?us-ascii?Q?hIB+LCmprN9yOzPvg7d70wNKYlfpdwQor2mrps30XMk9PvSzp1T4HQT1BNTP?=
 =?us-ascii?Q?CvwkwRy3OMc6iYQyGF3EKOO4iOBMycMx08b/dxQw0NGcNdrHhaq0rqchYhid?=
 =?us-ascii?Q?7aw3+FzBO16XxGzuq21pApgsSESd4e2hiWs/8cCmDC3qTrXBhzV6X9sZAhfm?=
 =?us-ascii?Q?jMcQ3S3rl6RD3KZrypItEZL4ryAFT7VmKUPxtYl6QhtN1iZJR+BJJnJAmkg9?=
 =?us-ascii?Q?u2ya0EEt7kFcIQ8BRBH/pBBHkX8WwteZ8jJfmRnUSdPH0ucZwrLibF2fsakt?=
 =?us-ascii?Q?jXrFgteqcTQ6CKM0qw9UdYVPcIGEPsWzqR4o5yUpz51hKDn/5NiukP2V5Y6E?=
 =?us-ascii?Q?cazJAvlEVA3eAybWqKDCSaHySLIrZm1kBr0lE/BiVHQm9ED60ak23cmhlH5P?=
 =?us-ascii?Q?r6mxBkNPjhFE5k5IyD9vnWrgAoYw5csSf/3cEMvbLHO18+m3GxjNfUc10Br6?=
 =?us-ascii?Q?e15Gpo7HlYbBSctVXLri6rMvO9vYfkdyG7VBarotwEhB6qaHE1R27UWY6mDR?=
 =?us-ascii?Q?lm6I9AEYxFMIKV11Z3Pwwpw0Pe5aMP965n5gPiOLXcMKN2BXypv2Ntf8Rvgo?=
 =?us-ascii?Q?+D+dGPWZ6HvrPkC6GVYi66l6Y65dKTmt3d6KlLdCnWKrZqeZ3lFXGi3Tn+E/?=
 =?us-ascii?Q?fBtCP2Y9gHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZL5uOldluyUWxAoyiDmDAKldrvIQF3YA0vGh7TOZcqjNHcsQegQm5GTElr+y?=
 =?us-ascii?Q?A2vfStn/zHof2ODvL44mwr9pzUCg3RA+2T7a+JeKIz9wjAcTtCLzsVYiA42K?=
 =?us-ascii?Q?9pEI5NAhJTkzlcreLKDPXKvtHe+ux2Xlr8+EtooepYACXpCvIOX5GXZrWFpY?=
 =?us-ascii?Q?Yvqz3Rf8Hx2eRaUYKzh17AguqIm+7TTO09HL7W2OxjmN/i1Rc4DPIlx3mFi6?=
 =?us-ascii?Q?8sl3/UbB3VyhfZxrUCrP2VVUjjPx/OYPubWrtC28VFY0zlyzuJyOlcwUrnJ8?=
 =?us-ascii?Q?FE6noys2DiYidATod+mmGwsvwDZmwSzl/KQlZy5DyrXimK3XX3+hpwPqCJjd?=
 =?us-ascii?Q?KtOaKRGAUhx2jAGl3DKUh5VTPQfQeP2TkrEvRkmpw7yxKtFJMeXgZOU5NtXR?=
 =?us-ascii?Q?xDp5QBOqRwMr7Sp9o5YzAis8zCH1K9Njidjfoy2MttLht2bJZrXX7Npf6Cdw?=
 =?us-ascii?Q?rcTLmHB0VzhE8KZK3iKMSKUXEMSNc1j4JNv4wA8iZBnOj9ZHPjvsNHgX2R5P?=
 =?us-ascii?Q?SxMDv/HY21E+R82+BAyTpMLlxvX2PARr2yucsgwgIDAVk+R/RTy4IBXd0EUa?=
 =?us-ascii?Q?j569tgKbdGOi8qO9ZNcZ1u7EAnvbIqAAy9Ov0YyXFX2WJr/OzmgSVnm14Tn0?=
 =?us-ascii?Q?ws2R+D4FN9uGquhN8l1zVFaqz68sSBMUy7sdsbgAH3eRe54isn3BgEsDezQk?=
 =?us-ascii?Q?XiDweQlxTEu/Ndrj1y6u77RBEOpOnwrpcFZKaBezH/OpDu+YMCvny6R4hq09?=
 =?us-ascii?Q?yzvGNuxqaKmYEhj6bZ4aGBVkrQl6nsvnE6U9Tia4LemkSXA0HCwgpEvW/vyc?=
 =?us-ascii?Q?hPK7GjCLFb/yDSfXUmwrLD38WTeGzAnLci5M8JEV7dv2hpQGZGfyQWpUJ4pJ?=
 =?us-ascii?Q?RlZ5HOi94JFWoe1dMWfqzLG3az6sQWxgvUCphOoBWf2ScZMuv03WPuBM0ZaT?=
 =?us-ascii?Q?J8s8DJ/YatWDN701rhcSzReJC/Df4O+shgO/6Q016eRMouVW0j1ReVCOWMGb?=
 =?us-ascii?Q?CTe5WigtSiOeORHTUp0URx3n4JDWSsIhm+4v2FdoZ5/FBoNL1RHVTjFOb7p5?=
 =?us-ascii?Q?VI86gMYxKSqi4yvAmQEsaEImvPB0N8n3ODwR5onUA/LahrmVnjffwiTfVdy+?=
 =?us-ascii?Q?eXUW5gYZ3skU6uWHyz5taL6xQfh7HV/12140EyEuXByAxe47M0LiyLfBiUHb?=
 =?us-ascii?Q?cBzZd1qUbab7v4Z5+Mkg0Td1kw8edfxT5dEkGVM4+6hX28ZtIbm4+mfgUsRH?=
 =?us-ascii?Q?LNBKyM3SLfvyNWHSZGxZQaSGEBLpSM0WqPdkcxBLGnrdtEyR73nN4d+HR7g4?=
 =?us-ascii?Q?+Cra47k6vpGHbvPjJIgyq+fG2mdJIEasj7BBaLj4r6dJAJiE6B/KwHGOrscR?=
 =?us-ascii?Q?+ceq/51zq0ZchGCJlR9wgsgrhSZAa3pZi1YSHW+m+kFyJ6EXdhrdgbrCpdNo?=
 =?us-ascii?Q?70LTcOdoWVSsF0tP0spGgFCowcbilrEJ41tcxiySHytt8pGPOnsSwcxJl3jn?=
 =?us-ascii?Q?6sdLO0aVCXWPxtNfzWsAF2wWUH/JPO66cUMlIdiVBwd445eVclcd92qC6Z5A?=
 =?us-ascii?Q?BJtU+Ai0w8vkOExG525Xv76mJRG0lJHbUd5gCdwT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc259ecd-744c-4967-c5ac-08ddb3e484cf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:33:42.3728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElnBZPWdu9kGddqIPvK8S3CDMm6VvFrbnwE1M19FJFQ4ug2kd6eBAhm/lS7q1anZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131

On Wed, Jun 25, 2025 at 02:11:40AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, June 25, 2025 9:36 AM
> > 
> > On Tue, Jun 24, 2025 at 11:57:31PM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Tuesday, June 24, 2025 10:54 PM
> > > >
> > > > On Mon, Jun 23, 2025 at 05:49:45PM +0800, Xu Yilun wrote:
> > > > > +static void iommufd_device_remove_vdev(struct iommufd_device
> > *idev)
> > > > > +{
> > > > > +	bool vdev_removing = false;
> > > > > +
> > > > > +	mutex_lock(&idev->igroup->lock);
> > > > > +	if (idev->vdev) {
> > > > > +		struct iommufd_vdevice *vdev;
> > > > > +
> > > > > +		vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> > > > > +		if (IS_ERR(vdev)) {
> > > >
> > > > This incrs obj.users which will cause a concurrent
> > > > iommufd_object_remove() to fail with -EBUSY, which we are trying to
> > > > avoid.
> > >
> > > concurrent remove means a user-initiated IOMMU_DESTROY, for which
> > > failing with -EBUSY is expected as it doesn't wait for shortterm?
> > 
> > Yes a user IOMMU_DESTROY of the vdevice should not have a transient
> > EBUSY failure. Avoiding that is the purpose of the shorterm_users
> > mechanism.
> 
> hmm my understanding is the opposite.
> 
> currently iommufd_destroy() doesn't set REMOVE_WAIT_SHORTTERM:

Oh yes I got them mixed up.

> waiting shorterm_users is more for kernel destroy.

Yes, it is to make kernel destroy not fail

> Then iommufd_device_remove_vdev() will wait on idev->vdev to
> be NULL instead of calling iommufd_object_tombstone_user().

Ah, because the original version incrs users, not just
shortterm_users.

Jason
