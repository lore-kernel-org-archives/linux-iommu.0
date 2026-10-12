Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D747CA74;
	Mon, 12 Oct 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807870; cv=fail; b=uCtL2x8XNvGVi0NcR7jEQAdFp/pzDHOg1ZrifV9cIhPYJhTmOh8Or86KdIxqHgt4nZZlMOh3OeoTPJBrvF8IZnhkZwg1tv9JU1yasyCXQsrSsLwiBo5ejufC+BPdLhzmbZdh/pa7Njwb5qLMMSLFPmtxRh/5F1wU50F8PB65zLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807870; c=relaxed/simple;
	bh=yIe8Mgqqs8B9w6Suh6H9IdYv4TVh+ck58Mf1n/CLMMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=arW9cbYq55tMh1UT2j7sDc4dCybC8NW/fQv/wRKhZb1xWmn7Cytvi8pEZW7ZaFxajuxPZ19fdMluGgREU4kiIYhJBgpfI7BbVU6OlWEw27/XPorPZcbC1l+dWOvq+Ij9JIdej2zQmEnruYKOzd1Pi+IaNNRgrLIIXq4p30OKe9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WLzMPtiF; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WLzMPtiF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9F/0XdBhBxVNJA3o5UX4st3DWmoMJpwsN/w+bFbjSCfGFf0rIY5pwz5+ukNjWs0aC9mmGk6TOtQOGdRdl2WHD2cWDMe8yKISguyZKK+x8P5ALeclVbbKAR7o3eCnL6RQwxjeS3bxbz6IyoxzwgtiBIo9NFE9jPMoKYKumEEwAUXzzTfunPwxtHzVew6/WFEAkt8mu2CHjzSDA8M7OG6js0if3w4S0El83pRf+S0C/1RH5R36ACWzNSUv52bKtSKFL5pfkg3Pv6Hv1PBf1BpQT3ktZFyKVy90KbnXh7q5S3KeTpi0Q07uYwT+Clri+ivgZA2V0Eui2vLb1XJoloNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgX5p04Oa0k65q1GIHMeiF7TVIfzlQImGLTPnOxcI8E=;
 b=UA7eRhaEP/fMPFjzxQVF5rYzb30L1/dMQbfmiZkBjbK2A47heoyUI9p/f9ZU+eUN8e63FQdSk11ZpuomwZLDfLYBln3JB9X4saKHaibiFFAvk75egFxwv0IL5EKanrHEKpjsH76lYTnf2aDvRECnzHTMuTKJEMG3VdyiyTYYCnOZxCRbmccNik34L4FhOa4kFLDxplEg+wby8bt8CXPINkbgQE1mpaydy2LB5YrXBGXkfvmow3mNlR/dfobZdkYKegxMeHEl9IiUs1vvS4SdB3FBjWTLS7k9av3NxHfSyj92hWap7mUXDuQE7JZsuctFtOrayFJurql2XvtTC35fSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgX5p04Oa0k65q1GIHMeiF7TVIfzlQImGLTPnOxcI8E=;
 b=WLzMPtiF8ORQ9s/dFndc3HHu1BIFWg1oIc9tXx7791fpqZA+BDjDLB16PLTkzlWNC0s+3zfCCPFXMTZOzvqxnbHGZAXlmPxcZW6Hlzc2p+5b9nz01yuICU+Yk2bZlpVvP77udmZkl9brODDiV9/wDYVbknNbDCrYW5+xHQhnII+MKoG3XB+aN2dBPTeJ/K4QkRA2epV6KqEj9MrWu5jF4tITB5tjFduBPzsvUD9LExhUBE0gc0Ey+HJDCx1AzmgBcUcM+4i3WTbne3rwezE47K9wy/HjQxBtwt48EJYFuoa3uHqnMgQ3o1nioBVitQ8NvPmWeOYw9l13aUIbLPuaNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM4PR12MB5939.namprd12.prod.outlook.com
 (2603:10b6:8:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 12:24:25 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 12:24:25 +0000
Date: Mon, 12 Oct 2026 09:24:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev
Subject: Re: [PATCH v7 07/16] iommufd/device: Associate KVM file pointer with
 iommufd_device
Message-ID: <20261012122424.GJ13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-8-aneesh.kumar@kernel.org>
 <sashiko-outbox-163681@kernel.org>
 <yq5a5wz75nee.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a5wz75nee.fsf@kernel.org>
X-ClientProxiedBy: YT4PR01CA0495.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::27) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2888ccaf-33e6-4916-f612-08df285bc0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DeCKV79moZ43MFkj0VwEJgYiKX8FNj/00yaj2F0zcUPOC0ZRSYEchTaOfd4UWnrLIAG6/Hq6Wn/HI7k6BtcSXN00IW2IO5C+j11o9TNlCLdBd31kcSOOQJERypUJi5uJJfrUVmWGoBzwf0Fdr/1L2YQUOUfo7+OHMCeYX220OXr8NsCG42x+XlHoz9mW5xfIBsh0DFpw8kRxtSZnppSg6+bpF3yYvfJdjIq8DSgr4QGLkXH/4KogJM9I/OPdWE7WwU3uEbGqU5p90Um0oPndeY3b6iJgFqSBVU0kAWZNaE4hi2NBk0YXjbBlsnkOidIYuE7UN0iRXeTLRVRmAMXZ4p2pxbXi/yWVxegIdAtRipKmJPKPKEbdDJ5uC6zzcY9EvoBRBs8Aqv1KHwI7Fs2zFBJIrsw4vcM4PxBYLqEiwim5fLvZwX6KfV5gUkPILNPKhbUhyqmUBGGDIBaBnTvFyYpfvoKoHXsmeEzTIyEA23tKRS+5psTzlEDr289WNP2nMWAkGSVX1VQMD5Hx9bvhXOSRGam40lXbt5icgpNGxSXQHCtRDJyIuny3EsJb/FMGgHpzeMHV5OlqyehuKXYzKE/ptD7RpQ841gskYoE/drsctzg0PBArAauWHZWJZjV175vISGmzRr65m99P/vuA7U5ajF0zQh7tK42u5vNS90M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N5XaCuvfa3x+Dx/jDt4AXKQQKmwcIkePNsEKgPWt0j2JdM/AuO6K8p8ClhWs?=
 =?us-ascii?Q?SUYhfM/3IucYebph0aLoyFI9l4wzLVzDYUIjwnPw3Yp1CAnDP5zYnu9CgJ8U?=
 =?us-ascii?Q?AxrrtvFHN/9ZoOCTuVoVzGnDnNMVg/KIZCysXVybgUSK0kaXU6iWWIPAeKUu?=
 =?us-ascii?Q?cwcbJ3jQ/7KYF2XNHgYqMqqrAyPRkJxKUKnUejDTVVfw4JnNIKTkO72ZNQAe?=
 =?us-ascii?Q?reWmDA5tIWkP1ZcVEskVhvQKbOqn2CEz9f7LP4Y0hUKwRmi+a08SLzA0RNhD?=
 =?us-ascii?Q?L1uLAuN8XvFtBK9PQWsKJpOAYfFE7L1Df1sQOGsIFVQitgPJpHKSwTGiWoI0?=
 =?us-ascii?Q?v0DBH1jghec8Jp2hb3WpLglB791n/JpZF0NcfoSExySrAWvrVHpV7R4uM4P5?=
 =?us-ascii?Q?qpSPYQHpO82fT3bU3+xfi7lKONUlnSlBxObLlmV6XRDRGQDgnn36jSTZlIE0?=
 =?us-ascii?Q?kIVgfw83SaonjBi2Ys/RyVKOYq6wC6QbPZkOYJwDQgu4IGixkJS+NtKF+3Vx?=
 =?us-ascii?Q?12siEefSS8fAe/HO3gVl1aoGxCHbcgyLPHHvqq7QVcfUnb8qrjO9eoZGrlx7?=
 =?us-ascii?Q?57dG2P8FcGdhH0LgM1la97WTcG0GIwvuDf1RPkdrp+3Yd3a3d1ZZ4c21KHRo?=
 =?us-ascii?Q?L+F3hz20/KatWKzH/mUy8qrb7QYa/Enugpnb5aPNd7g8ceYpb7MXacqSxn0K?=
 =?us-ascii?Q?e36KXKEwd3/TY9P2YdvTbJYtsczYIzwmJ1FjaZnKWiV4V/WFrthvzB1j4n6l?=
 =?us-ascii?Q?+qttCi1RbptpbwN/heJC+OYLeyJmQx+onxW3FHXCLlYwf1fCyQKQ2VmpBKBs?=
 =?us-ascii?Q?gmz0EksuxDujvwDGmRWUyz5vWXSLdcn2g2aNFEVmMU73251r64A4BEsTbRAk?=
 =?us-ascii?Q?yZBWJPWFOe7VTVwnGDqwAQzIUfK0iSpCt3brcYcPTC9BnaKG4Cjr5ZM2qoBB?=
 =?us-ascii?Q?LP1e1I/MEJ1ZpYP540NSX9meb1qEumZKHNI10UDTGx5AFE3LI1jDn9019QWH?=
 =?us-ascii?Q?HKq0QoaU/fsD9w8r3SHQwR1DiNXcFE0H4pf+lNTmPCc2VW0nj6sXV7LrGSPP?=
 =?us-ascii?Q?BQ33fr4FCEfSymbTPJCXAUK2pQGTe6MvRluMJD5N+hKLmP5TQaElL71EUDHv?=
 =?us-ascii?Q?2tJGOWmZyBim9br5Pe+Z82+9lwHPUXiYPj6EcIyfp6OcYkBBCm3ywElLZIQE?=
 =?us-ascii?Q?lPPEu2sfwAcbZgsFCqIDphWwxDK0sxqKPWx3bTCyhYAhyYT46y3l/GD1qxtY?=
 =?us-ascii?Q?KywQWuuEynZcDCw9rbVcuIHYMK0gmKQtJllCs62y1dXJwx4mRBgInjdqNjLN?=
 =?us-ascii?Q?jKR6RiQJMKO0E4ILei8O82pCvVao5PgTUbnb9lj+cPiu/Aw+0YW/aagSEdXU?=
 =?us-ascii?Q?Ss1sRMhw0MicWd8iXwK67Tlay+oGpIdtoYpdyuHBNFA2z+Ri6TZ2y+ECtA2k?=
 =?us-ascii?Q?8tc554OcRTqc+4Y/nGFtuabTr7EzRWS/0WO0JuwTUpPOKnNxvrUr2+Ngwzgh?=
 =?us-ascii?Q?dvEAt0XpH4gDCROghK7+6cHUCBX6C4ntsxAGzCDY9grqawnaepNfgiuG5pjr?=
 =?us-ascii?Q?+4ccKBhBsGsxMJA9COQg1UlnYtONjXT0EAgrzvPdSX3vj4O/tids2KogoKBf?=
 =?us-ascii?Q?23Eo5x73Xdrbu3ZfAKcswlBy+qmLgyGNoJ+0T92WewRjkohxag3gE4q37zK8?=
 =?us-ascii?Q?hn86OSWrDfOqNJw5nfR6J1VCWiBtHMmdCgiYW26OeQoSHFr1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2888ccaf-33e6-4916-f612-08df285bc0e8
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 12:24:25.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbNzLK871OkfhoNcq5xQiAXEpPWOItu+ryNSM0VWZdqSayIIxa58mGNN75WrJEHD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

On Mon, Oct 12, 2026 at 02:03:13PM +0530, Aneesh Kumar K.V wrote:
> sashiko-bot@kernel.org writes:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] iommufd: UAF of kvm_file due to iommufd_device outliving VFIO unbind
> > --
> >
> > commit ddde31c06624779bad69fb77ae7b9503b553dacc
> > Author: Shameer Kolothum <skolothumtho@nvidia.com>
> >
> > iommufd/device: Associate KVM file pointer with iommufd_device
> >
> > TSM vDevice support needs access to the KVM associated with a VFIO device
> > after the device has been bound to iommufd. Extend iommufd_device_bind() to
> > accept the device's KVM file and store it in the iommufd_device.
> >
> >> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> >> index a664c70a6fe73..f99f7bee2e774 100644
> >> --- a/drivers/iommu/iommufd/device.c
> >> +++ b/drivers/iommu/iommufd/device.c
> > [ ... ]
> >> @@ -308,7 +309,9 @@ static int iommufd_bind_noiommu(struct iommufd_device *idev)
> >>   * The caller must undo this with iommufd_device_unbind()
> >>   */
> >>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> >> -					   struct device *dev, u32 *id)
> >> +					   struct device *dev,
> >> +					   struct file *kvm_file,
> >> +					   u32 *id)
> >>  {
> >>  	struct iommufd_device *idev;
> >>  	int rc;
> >> @@ -319,6 +322,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> >>  
> >>  	idev->ictx = ictx;
> >>  	idev->dev = dev;
> >> +	/* VFIO holds the file reference while the device is open. */
> >> +	idev->kvm_file = kvm_file;
> >
> > [Severity: High]
> > Does this code introduce a use-after-free regression for kvm_file when a
> > concurrent ioctl is accessing the device?
> >
> > If an untrusted user thread executes an ioctl that calls iommufd_get_device(),
> > it will increment idev->obj.users to 2.
> >
> > If another thread concurrently closes the VFIO device fd, it calls
> > vfio_df_unbind_iommufd() which leads to iommufd_device_unbind() and then
> > iommufd_object_destroy_user().
> >
> > Because users is 2, iommufd_object_remove() will return -EBUSY:
> >
> > drivers/iommu/iommufd/main.c:iommufd_object_remove() {
> >         ...
> >         if (!refcount_dec_if_one(&obj->users)) {
> >                 ret = -EBUSY;
> >                 goto err_xa;
> >         }
> >         ...
> > }
> >
> > The unbind operation ignores this error, leaving the idev alive:
> >
> > drivers/iommu/iommufd/iommufd_private.h:iommufd_object_destroy_user() {
> >         ...
> >         ret = iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT);
> >         WARN_ON(ret);

REMOVE_WAIT is not supposed to fail, that is why there is a
WARN_ON. If we hit a bug which causes this you get a warn on and other
stuff like UAFs too.

Don't worry about it.

Jason
