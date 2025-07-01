Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2C26FA4C
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372002; cv=fail; b=G+r2NHe7iqxbRUftsmRS9uXeVpG13csOubR8Eo/fgBxJzzLpTa+1Fc6cQc0qxdgWVJSFxJLgUiC7xan0i/2xX7ElN42QkzHVnjBhXqzCeb28A3KfzLbzthRSXSrKfVMBFWTvaQpAztpeq042tiENFv22tRwF0AtORycJ3le5wy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372002; c=relaxed/simple;
	bh=R5gQAPKGTmdOyEMx2d0T6IPl7iQC9BIu8D3cqDDoE0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U6I01+6eaYx+KMcJTbc5d68IZlSXWDAFxYXYIg51IV0LsMM6wAYO0AOLCFzx8DEvIr0O5xRyLFX4+rf6wtbZFEHM5pQGp47fqzwHjDYbAGzlyneTtFEoadJ51rrAODJ40RRqx2RNf6CuVsXWdvWKENIOyzgDDlL/d16EKt1omGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3rYvK2y; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3rYvK2y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHtZdg+fSW9TpkWlRmCPAI/v+n66DHWJhXvx1CQldMNbMBcbaHJTxxK/XV2ide88EjP7Snz6JEIG1v6ketYyNbenDcoc9+ZOHMMW7vC3Ns7BuJNYt3cq+m5c4R4s0l6uLVwPSPCIwPXlZuGbnhMJpMKijdEtLUDDd+7Hj6reyPiSRnFPCM4GlQUBQ1ntbxJqhN3eH2Ij+Xta91sD3zwo3SEK4/Rr3tEMyA3kcMbQIAougHrMZWACQtoe1SWgsp7XjtXPPM1iFIX/HLnUxSJe74b3ov+FS7Uz0LW+wLVXZ2S+iJ593yS9Wh64fCjb06jQ5tJZtyb14mAccl1Adp5gyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj8X0zqMiyuLuoC4/UJVSJS32f7pcYh8Tm1kSWRYSYQ=;
 b=CEkFSSNkT1UXSB4DKoWMDHB2ewgIyNrOT68/bPYEM2dsrUA30baaNTKsfAB91wi/ZZuXub2irRmZWDql37p4nHx7hXJYothHt/aJrmp2oBPMFpTjAxsAyqyKAWY4cMtjhRokaExiOp6qqxShnlpxN5iIgG9/qdKzACy+er4uIoTF9l0XB4yVCNJVgnylpvC828tP61rpP+R0G20jROTdLLPG/7F4qRSPCSn0upDZtzbD3v8GCOey+h/cmlNBZAIOwuC4lTHZRYK2ytZVGFj7hHmUHR3fnRvWXmvPswr3n+ZhV3JxJP/9euZQMk1ENQ1p03vEiZQQXsYZYd1ZPYdLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj8X0zqMiyuLuoC4/UJVSJS32f7pcYh8Tm1kSWRYSYQ=;
 b=Q3rYvK2yDyjGEgUITif5cS37rzO9ajh5Y62OoKixrbRAc6pD5RdQZugyHBZ+VisLxQiU93mQXeI8/zhUBw3u16/IyZh2SpbyodvZbZ3N28G62E+tLFEWxhpDwaz/QMrebUTBCbz6L8wv/TXh3rtPA5tOBtUFhxffybSYqgjDZNMh2VFtLVxoiA/YY1A0RupxLf9paciX8a4krxTk/mGGsEVsnKrFzFDwOD2zmYK4qJDakfLycNsvta6+3ta6cjc2eFh0kn5fBMNan5XKzgStbdhoqO6/wMEH59cHE6Gll2L1YWrL/+eFO7ogCB8qmXx0cHO8K8qiy25O44k/WwPC3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 1 Jul
 2025 12:13:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 12:13:17 +0000
Date: Tue, 1 Jul 2025 09:13:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <20250701121315.GD167785@nvidia.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
 <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SN7PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:806:127::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: aba9a2ca-fb24-4fca-f169-08ddb898a94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iVS6K+2mm129kD/kkBHs2fEi9Sxr4jktfEgRiAYUIJ3FVwwPaSIs+BG0IBF1?=
 =?us-ascii?Q?4bv0/1rGgUePQe73XHhVpfPYT1uTvIOXFpwt7HZC9bAXjvTQDy2z7udRzzFa?=
 =?us-ascii?Q?by2896XYu6QyHv6AUXwcwHC0wuw4cQh2w4lbDLSiloLxZhgHgV14Davw4MiM?=
 =?us-ascii?Q?WqDhUUIUf3kOyXtjcratdzV5E1U/pz8qDMtFavpM8fil9jfruyWiyKBO3rPN?=
 =?us-ascii?Q?jMHhWmgaMt8dQleKPayKGI1S/ydAWbkU+hLAK/hZ7F0MhCv7h6L1pVwyfouP?=
 =?us-ascii?Q?O0IGaAqdcJ9rngGud99gV3kiAkFWcimDRsjANcLGCwwQI4vAdQ++AOvKc5oB?=
 =?us-ascii?Q?B9lkrrLXbHoKX2qiNxD/Rb7c+sisWYTtiippHrrNKeKG84MB+rNL9ZHe5VQs?=
 =?us-ascii?Q?LRJygrz3no2i/HpVZFlGLGGL/KVyw+iZseHPfJFPIsb1dDlDGl/vi5s22Bx/?=
 =?us-ascii?Q?ssydzk2Z5IdMgtPFAqKEbk6XmHPKvh4/wvTUVH3pt276x2X9w6DIzJn4cSsr?=
 =?us-ascii?Q?UW9mfjzdn0BkdJkAIk4BPEJiTzSb4jxkgpQq7U0mzIOLIxRbSiNfdA+xT7jb?=
 =?us-ascii?Q?wU76XLrWISdzonv41UeEu2+LQz/xregUAseRWQ1yUe3i221zyNfwHcGuIkh8?=
 =?us-ascii?Q?XQn1VaIG1j6n5rSH6TmT51c5/RDsFMENFaYz4TBOTVvr0t7pvIlcvIJAVFB/?=
 =?us-ascii?Q?ZU7XCsAWGzmtJZxM7zs7KGPWQaXkRAW3yyAM/p+JR3WWMPuQpviIwPSlCJsT?=
 =?us-ascii?Q?PP2nkFieIXt8cBhtg3z5+1UWqkuov/7Ml/A/5IdKb+At+KGDlx6fhRhS2C3A?=
 =?us-ascii?Q?p3KEfBB7zRmymfzqaHzDeWgM57AbtRiPSNO+yYmZeyihnisNk3HjrLNlyt43?=
 =?us-ascii?Q?Eih5kZMUyT62EMQr70k3YvwPiBS2R7V82bMvMIGB09ivShFZcjE/LllSUlSX?=
 =?us-ascii?Q?kNPakUr7UVbjfUZZw3wX1Llv/jdt1HaLztYMQ84LIcxoWnVGZZ2zzOfkMUMf?=
 =?us-ascii?Q?KhQBHAGdiOhnvlgqSeI19QU3dwUtaMYZ90HY2VD9HeZTS+Nr88Cf2kgU1Ifn?=
 =?us-ascii?Q?SoQCHGXNkngPWCboTs6+AHiotkLgMb8auVUUs2MVS3YvDVJwXsCmSuZJkFrs?=
 =?us-ascii?Q?GjMqyLd1JJn4KMJ75wFX88vmOq3ML0hrg9YiW9CDYZZxlMrNsUyHECJIj7Gt?=
 =?us-ascii?Q?3beFuUDXw/xSi5juhdOX74bFcJ9a7ySLbMdvcZscxAC2VJf66uppM+k7bBG3?=
 =?us-ascii?Q?2Bs+jKkKlmxz2oe3YOdKbbrtaJsskinhQSBsssnYa5UjvkxKsOaOMv+xWc2Y?=
 =?us-ascii?Q?7KbJpCIYwhxq3qTT4Yfdrh1p9VXAuRRT+1SWaXK0uazaFXvLVjSeKXHmN/pM?=
 =?us-ascii?Q?qUxPRcWGoCNDT/TT79+TruNqIr/QNxvN/zgCYDIDrgmEEmSKZrg5D4G1Va1C?=
 =?us-ascii?Q?MwLYUupv//k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zook820jnTYxzlqw4kLCACzhJwJavyn25Hvbou6RdsG+AS5EoeEYHPnyEgVs?=
 =?us-ascii?Q?VN8ljZ0QRuKtEIp0mP1X65K2Jws/sLlGzP8s6TXVuVNC1JoNCWiIhpYcrtcX?=
 =?us-ascii?Q?YJOafLQWCSwvcFJBphhN9ZisNynPb6x5q1vNhZK+8b3vL4J3nTcoDscMW/Pc?=
 =?us-ascii?Q?3ggYRsunqMMgSujHzCzH0EJ9ey8kQCwdOPinGZPk7/EtfYkoDgYmznuiTCc9?=
 =?us-ascii?Q?wbYqE5RUBh0anzlsLiGDCivCtHFZC7EZeaRhLzQhe/+d0kiNF6NtipBywhpe?=
 =?us-ascii?Q?mxKUHo1n1TDD8kd2eGEeef0uN78ZWCWUnRe1tTYBc5m7lQujiAxDPVcZiCaC?=
 =?us-ascii?Q?qdXxAcxintfkPPz2c3BizahQjqLAGTGli7jPJu7typl4wlxo4RcmD4YZ4FxU?=
 =?us-ascii?Q?Wo591DlQ/vzqSSwiJ1fmoNc+u+3OO4+TakiTt7y26VV/kn2IBzI42+5aVw0/?=
 =?us-ascii?Q?8Gs+QyMqVDLeonk4/4sJlEaqdWZYTH4XWonVeJ87PttMAP62pgSOgqlO1LZv?=
 =?us-ascii?Q?KIEnGsgW5pccTviKmbc2l47tbGZwWJoEKdPxWgOl068aTfqw+n4n2G1OYtXS?=
 =?us-ascii?Q?hAUNiCcx/L5inO+xdCtWrck8Dhteh/o3AXgG04iQ9taJ+L9It5xDZ48jGyQJ?=
 =?us-ascii?Q?XDsYNh46zfwHGcStJ+X+BS89zgtjh8w89SSSJjk8ztxb8KxiOUHML/aDtniH?=
 =?us-ascii?Q?gxt87/hWULE2Aw1k51dVoulh5/rXzfd42nIC5QHiAaYCOYZ59DWz3DCU92cm?=
 =?us-ascii?Q?p9ZvwFKIvpvEsc0GU2H/wiBa8usNxCCAQORHLRMvJyR2q9IxlZv72MLxJoz7?=
 =?us-ascii?Q?ycbyor5D8B6VfxZvdbhnsPARpKspGfn00NrdHA45xR5lnDgLlRqDzyKXrdil?=
 =?us-ascii?Q?+YCUrtVcEHEeJmGIsaXzLX11B1cveOfOTvBnfe5PM7cPIspFN6SSB3ZizibF?=
 =?us-ascii?Q?XrcrbDRwEMSfbmgH6m83RIGPCwW/a1I0fc1VLda7MLCMl6H8A2c7j4WrKYtB?=
 =?us-ascii?Q?Boe+mCaO7KYTBNiihJuh1BGg1ZI9dG8K4OfxaNUc3ILscidYGrdqSFar5Kkf?=
 =?us-ascii?Q?8+XZ8BRMbU15zvvMPab5n4TIe0JEKigk6cOq3WUM/z8bnPr6PK0oIzJbN6jL?=
 =?us-ascii?Q?HZLW254wtCIw1B353ehz5RIU6Z8BvoPlpJYE4RJCprMWkbpIFC5+T1PBCl0V?=
 =?us-ascii?Q?/24Lm1Aa+CRa/5EjG3cTyHajbz3ZoT7f5cScrRMXOjL67D24izEdcv2T8cSW?=
 =?us-ascii?Q?l0RZAOM0oCAPBn+EoXmjNWSPdV0gFQB9BVbIl6sRxOlMwOOc540vozB2iixc?=
 =?us-ascii?Q?w50XMWnirHKqcogqhYusKEnRu9aXrOPXx2mgLhADAQuzGcYdBIPPwfMiikgt?=
 =?us-ascii?Q?p4wbWG3esBOMtTEZ3zV+nGTzn6JSpFStOG8ixH5IQ5iCvhCkDzEDOOFQQq+h?=
 =?us-ascii?Q?BqpSoQgSnj3YudHm5kc4xDU+L+5ZK1Ta6eIPhSyX19IQmx012t3IcVILh82O?=
 =?us-ascii?Q?ZuZ9H8lICFyEqQxT5SdfJ1kKlhDOLPnxKY+ySTZhlcCvtcsLiOw4U2iwDyXZ?=
 =?us-ascii?Q?X0p5jLLibfTg5UpFFmN7Aq+OYPrnF0dqxIrBxP0D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba9a2ca-fb24-4fca-f169-08ddb898a94b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 12:13:17.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWpuX7B1StJsTn4pnZqYYJJqUugNyZwdcdvYmA00/C8ELZbNNRmVwD+AbYj3EOAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

On Tue, Jul 01, 2025 at 05:19:05PM +0800, Xu Yilun wrote:
> On Mon, Jun 30, 2025 at 11:50:51AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 30, 2025 at 06:18:50PM +0800, Xu Yilun wrote:
> > 
> > > I need to reconsider this, seems we need a dedicated vdev lock to
> > > synchronize concurrent vdev abort/destroy.
> > 
> > It is not possible to be concurrent
> > 
> > destroy is only called once after it is no longer possible to call
> > abort.
> 
> I'm almost about to drop the "abort twice" idea. [1]
> 
> [1]: https://lore.kernel.org/linux-iommu/20250625123832.GF167785@nvidia.com/
> 
> See from the flow below,
> 
>   T1. iommufd_device_unbind(idev)
> 	iommufd_device_destroy(obj)
> 		mutex_lock(&idev->igroup->lock)
>  		iommufd_vdevice_abort(idev->vdev.obj)
> 		mutex_unlock(&idev->igroup->lock)
> 	kfree(obj)
> 
>   T2. iommufd_destroy(vdev_id)
> 	iommufd_vdevice_destroy(obj)
> 		mutex_lock(&vdev->idev->igroup->lock)
> 		iommufd_vdevice_abort(obj);
> 		mutex_unlock(&vdev->idev->igroup->lock)
> 	kfree(obj)
> 
> iommufd_vdevice_destroy() will access idev->igroup->lock, but it is
> possible the idev is already freed at that time:
> 
>                                             iommufd_destroy(vdev_id)
>                                             iommufd_vdevice_destroy(obj)
>   iommufd_device_unbind(idev)
>   iommufd_device_destroy(obj)
>   mutex_lock(&idev->igroup->lock)
>                                             mutex_lock(&vdev->idev->igroup->lock) (wait)
>   iommufd_vdevice_abort(idev->vdev.obj)
>   mutex_unlock(&idev->igroup->lock)
>   kfree(obj)
>                                             mutex_lock(&vdev->idev->igroup->lock) (PANIC)
>                                             iommufd_vdevice_abort(obj)
>                                             ...

Yes, you can't touch idev inside the destroy function at all, under
any version. idev is only valid if you have a refcount on vdev.

But why are you touching this lock? Arrange things so abort doesn't
touch the idev??

Jason
