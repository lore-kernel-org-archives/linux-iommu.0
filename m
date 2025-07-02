Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12C2741BC
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751460048; cv=fail; b=GAvDRzJfKjUZtdDgTM5k3bWBXGmi6x9FmBMT9GkovbzFMaja/5mSaLxuhorA3iZeDhkOlGAk7nzNKrkQVcYxKPsPC6rjQ9Wz7nPdNqSHbNYlRAbohqTKbyjnvwDaiHJOsGGibGSaCSOEvs32qkzcM9E+vyPq7ttWlsO8iJdM6oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751460048; c=relaxed/simple;
	bh=DZKFNtn1qy19Ye0tc/4gWS5tLaiAiR1j6xZiceYqc+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PY+ddG7pax6VCXZTqFuQy2rD24vtaTLgNyajbypmHQtHlRBDNwNLN31Suv1vEZd7iUm57LRg4lkRdEudGE+RDZ5s2/WT9DUXjEx4o7kO3dLM+/HeBjVkowHnIbrhWOAVViygoT0FHGuZfS1Bo5BrGC+TWfbsPN4hSle1Ac1NIxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMVyB6A8; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMVyB6A8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5RMZdp31IwFs8ducxrAY/nlqCFe0jQY4N4ZgNb8ROaxebF0xNkSJLHu+kMlDGVTF4+1H/3D2tCsul6NH1tfntLM531U+mH1bITJboAWJeLm6Kr7OvPW2OL1dZRhrfj5csP5S6qw0A6AIHsj6O3b7NRfLffacO8w1e3ajYoDSL/sgmiakOpTmc95ejq2gEBKMrGQHL0czbdrWrT3e+poYCZ3hGTiwh1oHXVlkZkyyPp/5ro67OX0M1qm3JiVnKo7ZJzb0a28+BAoaTJsD6/U/OZsTG9CCiP4veqBfiBWAc8oe+asiXxTto5gFe8tkmTJO/PxqLOsz90O1udRSdv1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gElzm7nDk/t67dOWcJKu7VP0IG0RrPS+hGnmzjXYeQo=;
 b=TeQK+cDqExNiJhR4HtK5oeQKGAAPyv3jY+NZhA0L+ROL30WFIWdxuMCrxLc7enD7cIedmT4IqQWS7rH110tZ5clgYQKiIwRdc4hyMW0XspJgApmjjG6eVacWbOzzo0JjkHnjSZ71OOurEG6gUsnzLnXwCXX2fX6KDss8ryLstS36kCFkBcr0MmcU1dHMS2Ctw5x1Mc4TknoX9l5SjxOQg0/ZrYQ1z+AZJla8tgwP4Mp16lIR3+ZjbRhSk2yMuGvaPSIyWEuaZ4Dzo4NoJMnPJg5v5lIUmXmDsve6B/gPNQOX05HQKQZuj5181LASzE707YKKGj+UQx2kqABM8Yvvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gElzm7nDk/t67dOWcJKu7VP0IG0RrPS+hGnmzjXYeQo=;
 b=dMVyB6A8PwClE6jRJxQrlD1ozgLIE2DzLHpmEJb2T1jjm6gsUIz021tzOS6TMBClRRWeggXwnAtPyXJfqbOod6w/ZzaLlmzehNb4F/mTlQPazHxkilBA9AP+8i9avM2rivdLJmRbilozNzHt0KmDwyLA+W7hrp3TAzrPxjZWonVmD3WgbKcjxJLw+zBxQtiwIiWel5yUeluekYPq/sF7IgzeSVRg4HIg5LxvxApLipJY/CN4dIRz7HnnTo/6ekTUgslESgOmcj84/kr1uFkkTKipbuwsntevEjSy0YycayHWn/4OcJKLk2oWMDrkxzKPsUh6NuZH+c23wa1JbJDEuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 2 Jul
 2025 12:40:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Wed, 2 Jul 2025
 12:40:44 +0000
Date: Wed, 2 Jul 2025 09:40:42 -0300
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
Message-ID: <20250702124042.GD1051729@nvidia.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
 <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
 <20250701121315.GD167785@nvidia.com>
 <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
 <BN9PR11MB52769790C63FFCDC711E80DB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769790C63FFCDC711E80DB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:208:236::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbb0754-d1f5-461b-f083-08ddb965a95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQcFGotwm6AKEHLxM5EaKOwrcDjdEJB3n/c/kQud+rFeVLOwarh2+Bd0X46K?=
 =?us-ascii?Q?rQtVqw8BQwPrRnufBlaHfUV0YdkQQc3CepE6ddCs9TdDapSC4PUhbKdREy37?=
 =?us-ascii?Q?+7Ac2nr5BKpzGLTBT99KjZGtwwRggyPpXYj51vdWzRhSnML4VAUy+U6sQscc?=
 =?us-ascii?Q?YKYu1p8Snq29vsSdM4/Ss+jgE2gwS/9ZPHJQ8cTbIHpfxhdDjN4zojT/GkVx?=
 =?us-ascii?Q?8H4m9Xw1xXQdDUgOmTiOtRxo40OJ10XpFWJ8IKs83/XT/DuQOt9pnMJI6AUz?=
 =?us-ascii?Q?SDHe3BrLI1Xlbov3ClQ77GlOmdFmAs8Te2xZtwWzK57NesIcXP2iCeWWf1lR?=
 =?us-ascii?Q?w5DFCdwzRV6i7XysIlZllJdgH1jot7XGL/oHz/6hhKG9JsoK6KiS0WY/qYyI?=
 =?us-ascii?Q?p3shVKPKycqJQ4BKE2QI1X+5ZT9/78wN7G9R4tabg95cAHAIncgkOtxVQ+z5?=
 =?us-ascii?Q?JVMd4Fad86rEiUXigPawfMjPwjSf5lEGo1hhr37fQ/VivFjiLHlIU+mhyAD9?=
 =?us-ascii?Q?gdfj3ieNFZ8XIAxdB0Ta1fNGVlAnD/RGWy9KLI6D4sZhXBhS4YVMYdvyHqfP?=
 =?us-ascii?Q?nlpTPBjjWGA1eCKZEts0yRm7XMSVfZ2uecQMHqI4WsOCqa19EDP8JA+XA8db?=
 =?us-ascii?Q?YQP3ZMCdrdqu1lL7uzcMA+UeZq+7fOrTtBzJearzIpJ5g3Adrxgo2fu4Tm54?=
 =?us-ascii?Q?MsgoGW4+5oMjmovwDrHImLM/FMrOOtT3a1YG0vSqKP10zrOSG5bCGMKlhnG8?=
 =?us-ascii?Q?A1aqFX8Gcf/Y8GEKpCnwacrOaXSMV4V8D2PYqwwdVaR7bVv9NgeCLEjB4GT8?=
 =?us-ascii?Q?Q8rfiOZQb5s98MIvYnE/2iHLsYfKa1rn35fFGF14OxrFtsEP2qFnD7pGcsVT?=
 =?us-ascii?Q?ExA7Ww9iwu6gG1uk3Fd6KxYp2MS/6KDpRZSiEM/nMbJo/yoLZMU1YcSr7aa2?=
 =?us-ascii?Q?kfQvSXZb2QKSjpoa21Ke1mzslX7JvHDYD2Vh3HqbyA26XgDJKjjQeiTTNr1Q?=
 =?us-ascii?Q?aiAD3rcNgdxiz/N9tO/9pasMQzuuRf6hylqSB1LW3BVi4yZ0crTUyDFSZepi?=
 =?us-ascii?Q?ZWbnVM9bFqikZfkwDx7i29nvWP6s40E8DQU+dHi5BOwCHHO00wtAnvNoIg+q?=
 =?us-ascii?Q?R4EqvvJAbFUbjFjaCz56anWGQxILCyD9qWEsiE7rqYxrO+Po9Ew7Ufo1Ub0m?=
 =?us-ascii?Q?Gn0ByEMpA3d6Z9jOxDoxK0/uiSjfmB0VFiWrJrRL97LksNe+RemIzzqc7CTN?=
 =?us-ascii?Q?nSUkcGwKDKEQHhHVipyR54FcTLav6Jefr76gb0PcyeXdlK7ctlbhmQp4gq7g?=
 =?us-ascii?Q?3uJTSAeZDhsS/VFyGJ/Q5jf19/flP9zznl9LwjOl6NRhhfnftyqA0NrNyixr?=
 =?us-ascii?Q?z9biWKS2DNnZmoTNSYHQt28ToO8ej0kGCfQm19BDXNWMcSP9KFMEOvwrCa6s?=
 =?us-ascii?Q?CWLlPGzm9mI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frn7JH8bGuA+4Rj8atmMJya6o8o5d5yt8ly7ne6wg6a4EJCvcIIgywbJek8E?=
 =?us-ascii?Q?yNGTgdpR8n+EizXaFWfJMUW0j4PXsBimOuReEwx9jaqMEiCL0h4XLzMh8+nm?=
 =?us-ascii?Q?lBqmt09sefHjRnnU0SVG3+U59/Zle8dZLzwVb6a8ONMrnkhhq7jUaXLwVR4P?=
 =?us-ascii?Q?fCnM9w1aqfhHfyoyK6mdA73Q+kGuvtgyWfuRevK+U6aiAxBVwcwwJCB5ecc8?=
 =?us-ascii?Q?42mMaOz0HhJfzCPZHWUKU/utfUu7R26tZPNPa9R0sYZA261/GDbqtalsrT7S?=
 =?us-ascii?Q?/F2XNsr2w7AA6Y5DnbwTrfadlVnKSrVfcdxxKrAt72AYA/d284Eze5aq90bM?=
 =?us-ascii?Q?HA+HOTr7nd4qUfbpW/wOTV5PUvjXiaJpRt1Yu9HyH72HYWFFOyLMmVv/w7WN?=
 =?us-ascii?Q?pc5bygXdTM2Tx+Z5veQAc8dhrR+ciMWbRFKIxG1pda2TbhDFEhfcl5f/DzuQ?=
 =?us-ascii?Q?PTgrb5llcDTxY3sMYxW8MGpGoB2KDY4OoaoxOt7Cbz8MlQOB54Q5xlXi3Ams?=
 =?us-ascii?Q?wFFBDBAn7BaBTMdUhwbdCH0izNAd4NVp+EcscZpPI3w0ywEN8lW9cIRLW0z2?=
 =?us-ascii?Q?buKuArqyakusgIsghlpofQ1ibgyWsSrT+jaeIQG+BrnaN7R7dHBOc2e3h0+L?=
 =?us-ascii?Q?rJ0fXGmJPTqZfoB0In85BlOMsG3EicJKdVpTlmKyfjK86pWRcLz1Bd9ZbIwC?=
 =?us-ascii?Q?fbVo9vN0BLO5nZ7Hryy9JRIm0iEtF9u8TIZXmDnKlYOgzWV/7TVP9vsOKIvr?=
 =?us-ascii?Q?q/PD3dUpCqK7Cc8THrs9o892v6vNNmP1suyBgDRydNPfVjPG9oPePoP7UbaQ?=
 =?us-ascii?Q?nH2rTgZvPjXlbKMFEtHUg40nsV/NqU/BNiYdEN7gfn0ICEmH3EZAaZst2zf6?=
 =?us-ascii?Q?h/6o5K5Bd6onbU/rbvxIKgYS6s2CYyJoj+nYZvbnYFXFSB3qmvMeIv+kuYw4?=
 =?us-ascii?Q?Va5QYKIFi6doDV3gG3GWF/EZTkrKZsfNePJe1Xdajbo7nhPeRbpqqWQrK04d?=
 =?us-ascii?Q?7s8lLCkbDqv2iPDUeixUzxkN07oRQakOZl7x9+BSWzAO1eb3x/aXvZQRZ0cm?=
 =?us-ascii?Q?mIOuzN5fnOU80iwlXq8cu4vplDS2QQhiwH7nO/iAWdFybgwq2cHFBjYGrsj0?=
 =?us-ascii?Q?CpnL77kkzAcJlXBZRYS/q4RT81Z9XBR6HPw3r2BuenldDqqf4zkkuFsrE7i0?=
 =?us-ascii?Q?rP1yPon4DhhuIb4Aw5khNMRpWCZ1UER2Q6cujch/fJ6RwxJlNnHK2/8c55oH?=
 =?us-ascii?Q?X43nmfgUZLIM5NlWA55tipowRlsf1/ZeqFVKkyG24Gjmzkvy2+SHh2oyUiwU?=
 =?us-ascii?Q?BecaUF5ho4yTkwUc221tPDdj77MhUiNXMfsg321MFtWNK85z3dyUoG/cQiJs?=
 =?us-ascii?Q?/FXNuAEkeRQVjSxSYraD237VqNuc+NzrfHpbbFdKcgJE/GFUkSwNJQFWjye2?=
 =?us-ascii?Q?7vDjg1fi6lUSoRvzu8jhTk5ik85jQYfYq5pcEFIWRKySBD0uMbKl+LDJ4QPb?=
 =?us-ascii?Q?nO/fTPj6P3sehGt94z/8NEKqJnvzZXR0yIbWiyekKxwuk3W241v1+Eh25xIb?=
 =?us-ascii?Q?uXv6gsXrc7HOwivAc94ZV1oGSr5KOVZXCjFI1JU8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbb0754-d1f5-461b-f083-08ddb965a95b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 12:40:44.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b44dujjssI8JINDj/E70k1aR0CcRPHTouosVTrIdA5TskSoJ21wa+3I+8BDr0w42
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

On Wed, Jul 02, 2025 at 09:13:50AM +0000, Tian, Kevin wrote:
> > > Yes, you can't touch idev inside the destroy function at all, under
> > > any version. idev is only valid if you have a refcount on vdev.
> > >
> > > But why are you touching this lock? Arrange things so abort doesn't
> > > touch the idev??
> > 
> > idev has a pointer idev->vdev to track the vdev's lifecycle.
> > idev->igroup->lock protects the pointer. At the end of
> > iommufd_vdevice_destroy() this pointer should be NULLed so that idev
> > knows vdev is really destroyed.

Well, that is destroy, not abort, but OK, there is an issue with
destroy.

> but comparing to that I'd prefer to the original wait approach...

Okay, but lets try to keep the wait hidden inside the refcounting..

The issue here is we don't hold a refcount on idev while working with
idev. Let's fix that and then things should work properly?

Maybe something like this:

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4e781aa9fc6329..9174fa7c972b80 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -178,12 +178,20 @@ static void iommufd_device_remove_vdev(struct iommufd_device *idev)
 	mutex_unlock(&idev->igroup->lock);
 }
 
+void iommufd_device_pre_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_device *idev =
+		container_of(obj, struct iommufd_device, obj);
+
+	/* Release the short term users on this */
+	iommufd_device_remove_vdev(idev);
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
-	iommufd_device_remove_vdev(idev);
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b2e8e106c16158..387c630fdabfbd 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -151,6 +151,9 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 	if (refcount_dec_and_test(&to_destroy->shortterm_users))
 		return 0;
 
+	if (iommufd_object_ops[to_destroy->type].pre_destroy)
+		iommufd_object_ops[to_destroy->type].pre_destroy(to_destroy);
+
 	if (wait_event_timeout(ictx->destroy_wait,
 			       refcount_read(&to_destroy->shortterm_users) == 0,
 			       msecs_to_jiffies(60000)))
@@ -567,6 +570,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_access_destroy_object,
 	},
 	[IOMMUFD_OBJ_DEVICE] = {
+		.pre_destroy = iommufd_device_pre_destroy,
 		.destroy = iommufd_device_destroy,
 	},
 	[IOMMUFD_OBJ_FAULT] = {
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 9451a311745f7b..cbf99daa7dc25d 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -135,6 +135,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 	mutex_lock(&vdev->idev->igroup->lock);
 	iommufd_vdevice_abort(obj);
 	mutex_unlock(&vdev->idev->igroup->lock);
+	iommufd_put_object(vdev->viommu->ictx, &vdev->idev->obj);
 }
 
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -180,13 +181,19 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	vdev->id = virt_id;
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
+
+	/*
+	 * A reference is held on the idev so long as we have a pointer.
+	 * iommufd_device_pre_destroy() will revoke it before the real
+	 * destruction.
+	 */
+	vdev->idev = idev;
+
 	/*
 	 * iommufd_device_destroy() waits until idev->vdev is NULL before
 	 * freeing the idev, which only happens once the vdev is finished
-	 * destruction. Thus we do not need refcounting on either idev->vdev or
-	 * vdev->idev.
+	 * destruction.
 	 */
-	vdev->idev = idev;
 	idev->vdev = vdev;
 
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
@@ -207,7 +214,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 out_unlock_igroup:
 	mutex_unlock(&idev->igroup->lock);
 out_put_idev:
-	iommufd_put_object(ucmd->ictx, &idev->obj);
+	if (rc)
+		iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
