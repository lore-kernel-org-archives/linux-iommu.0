Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30A220F54
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088102; cv=fail; b=rKXdzpXLyzUkC+oCJ7X3VcCiSwkZDVQmkWFt6fNk3hqOeHvemw3fQHikYNor6PhJq6ssVOX4slzUrICXDZAouUoq5StawpGAl0Q8f+WKnP0taOwkK6SFtPBj+ckyEpQ/liu++GQ10rOOQaXhQODej0OKAkSSafCWewcqWVwtHNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088102; c=relaxed/simple;
	bh=qSo1fRXGR7mChC0dkPOBNxg4ID908HlHPWNDYHWLpLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YT5jSp9vE3I18eKMeaLQv+wDWJblb2l11Kf18KdEsBsykLtS0A+ARTFoAf0LHKJIwy5DK07aSCW+4CA48wYyRW87mdASI5zmlSvHuknK8eMCLsxZA4U6fptXb7Ey+MdbKn0zEkp0fBSmEurI1+HrR9JeUPTR5k8yt0uXLzXJ9vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mo7L5JSP; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mo7L5JSP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p08S05+GoXMiwkrrUXuaHAD/FBYh8sDfX51Iy01T1gTLWJClGpMi6m8mBiFRsMdaqaDzlaZx6f1kRLEcb7Ua4jSlDxZndX1ASSD7J3Wv8GiumMMCPIjx1YGULUrG3R4yLDh7o6Ye/RuEwLjizNZUUehFQOekfXCreH0uTiH/ntPO6TkM9NgnIIRiogkcyj3WkS302JftlCiUGxyg1ZKg6lMK4fR6kBUrbyanzcfQmFYm2zVmqqKZupnqmLnO4Pm5wWsQfAsJbO4pQ7UO4QpOXFmZIWN695q4qysQkqfm1jUJrgN3l63yQ3aOYzZwI3yUQi/xmPC6K6A+GZtDbOCg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU6y5FqjvMxOjd7vl5oxHCFRlKQuK0cWh0UgpDYtwiY=;
 b=Njy0XF15LbH75NpkqJHcujmlHvqrBerIcXa198OrAlWJ0qwSSHpvE8fq5hy004u8wM2KDcy05k7Za6UUNLGL/f5oMjDADhPimpF3rG8bp4DoGaOrfpg81WGN70iuFCyVNGw8eO6eZw2sy5D7DlripAOJmf5aNwbmF2UFqKbQY/sBeXWZep9wRS6p9Wlq/zRg5Wt0Vojoi6w6f9x4jhsAd/y6xukgQtGgb6Dic9zzkD+vEw1J9uA4B8GxYMVzDwNQCibFQOFfwj4SXXztBumVvlGXXed3J71BBQSU8dyp7ZXku49KmKWfvol8LCVEX3meCGppAwrO9B7K3eu/8ckaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU6y5FqjvMxOjd7vl5oxHCFRlKQuK0cWh0UgpDYtwiY=;
 b=Mo7L5JSPVh92EY44qRhITzrA0NAoKS4Cq2YvMLOpbcgX3+Jtz5zgtsZFLbc+k7wccrye9CqnxqO29QWND9hGAGuw+N9x+x14mKlHQVLBwyyNhNcvFtmdYHdGaUiRVmWapNXLryyyEP1C6u0b/KsVSlqhSW7NMZ/1f43cfOEkdAjO8RAIEQ/Vt1czRUUC9H1j9nxVLmg7+/BN8tVLNNvwl0dcHd7GYbFVYM6B/ZWnbCILVOvHT79UtkLTrjw+c/jYS161zRZkTw5wYmLsxCRITS89E6QrXMkWo8Va2NHQ85k/ITibv1pfl4u6DD/S8coEjh0lzZf/ALwy5rcB1o+/fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Mon, 16 Jun
 2025 15:34:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 15:34:57 +0000
Date: Mon, 16 Jun 2025 12:34:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250616153455.GK1174925@nvidia.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
 <20250603152343.1104-2-jacob.pan@linux.microsoft.com>
 <20250613163103.3bca27cd.alex.williamson@redhat.com>
 <20250614001555.GR1174925@nvidia.com>
 <20250616084708.5a94ead7.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616084708.5a94ead7.alex.williamson@redhat.com>
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ba762e-f5a5-4cc2-6250-08ddaceb5913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YHD9YplAK5217RMq6314TawXMvEmaNpwCUCaHLj/HUN4Il1m0EKedVZmahQv?=
 =?us-ascii?Q?GyBL6vpfPfg13IzO0J3BnhqwkNYT6tPhAd57xYh8Xs13YW6Z0eC6cFkB/IVO?=
 =?us-ascii?Q?YRj/O5w5cTJxKaOtsZX39bOtnCdzU7uhKPkgeXuO/m3tMzcHQrUbYGa2Rofg?=
 =?us-ascii?Q?MeNHG86sPkT4W7z+XlZvxq876su49pmdme2C0ByliqYEPGAvwcKq8trkm0pv?=
 =?us-ascii?Q?rLj+LCuECSOwevAt+R2XCMm4bu9LTf7dYlpoFrcI4UeEhCQI9uyz7oXUtGSP?=
 =?us-ascii?Q?j4GWkgFdmcFxQW4+UVcNAqz/lhtzDxlK6fSQ413Xc+8kHRHhgBV9rNmbe7lU?=
 =?us-ascii?Q?dAZd9nQVBRTmV7dFGB91FA02ij98xYjhthn9RiYkc0QbdkS71g2fbUfjnJEQ?=
 =?us-ascii?Q?6YI0JIT+9tHOm8kkHPM15VinjQeWdRNomNYA7qmng1CJaiby51Wy0yE0Onbq?=
 =?us-ascii?Q?Bf2VeZx1n8Oi9RuGNsyKA/yWs2yJffv5s2lQ6YAMhnVAcznifS3a+ylZNu+M?=
 =?us-ascii?Q?yf66VizfMV8983kWXBrAJx30a3Rs9QB6l1JG+/F4jtsNG1DyMwnaUrK6U2zL?=
 =?us-ascii?Q?cg0mfJ2JH6HFTeNSKU4mYSsNK9P5bktNm6Ow/s3pqRKHhi9DHw0RNBKyQsfc?=
 =?us-ascii?Q?/bP50nGttdoFu50Xt/KClF3heOVwVKcfmNOoDJV1FPhgAg1kgwFfEzRckYjr?=
 =?us-ascii?Q?NHxs0QGz6jwCtTKDz4di8OFiTesJd2HUKkGPefzhzz1ZXXiExuH2aOLA1od0?=
 =?us-ascii?Q?r5g4XHxQ0rgAUnwSFIPIJeRGwPhgK/BFw01E/Py7mLUktw2FfwKRSLWoZa6N?=
 =?us-ascii?Q?jGlOVfF7n0xeFpnWqShBPzh1a1gl3w+W2TGTiPZyP+4bR2BgrjN0MpvhRo59?=
 =?us-ascii?Q?+T3hr4wGgt0Qy3PeAaWrud7gBBzRpl55ZRV8aqCPeH3Ast2IzeGocvuuN5Pn?=
 =?us-ascii?Q?Dr/1OxnxOuJ6JXY+NAJtgYqc05jNK0smetuH6y8xQun0tlk56/XRuGk/yX7W?=
 =?us-ascii?Q?usJniDklGe6bQ1TBZLIoITXOJ0SJgzEGyhTCHILY4qI9+oZ2ZGNcH3qd116f?=
 =?us-ascii?Q?4M2XwhAzWRCY7/yPJ1YabNXeRqNP/9W855ACH9flNY2tNVaQGbRyhi+yPLPd?=
 =?us-ascii?Q?rIQiU4zE+wCJBY3OFhLOfqF4wdwyHFccJNf38/3a7mvtoKLwNt+XXl9Fk+9/?=
 =?us-ascii?Q?K0LpoEghZlDE+ArdKB0x9Mc/i894es2bEaTHDx4pwCQU6kpNKFNrtdzoiaJ+?=
 =?us-ascii?Q?v8Ba3L4W357IidBkbxR44wCVT3vh7MA03/5AjkCdhLoO3noImRCbv7eJCwMl?=
 =?us-ascii?Q?9kpfiVkttUkXNV1M0T21FFD9hxWeXv/u3Ye+nHeD7OFMXjbko7Ba5mlsUsz1?=
 =?us-ascii?Q?ZR1wlBlezKiwJ8nzH11h+rO6ChEAkLvkJ7FKx4LMU4usnV7i4tcFQlodwbpR?=
 =?us-ascii?Q?tB45SxQAlUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vKSB3HFC/5crmGooDx5PwA3bogUIDVEw1/lwj4i+X9dB+m5xHl+Q+iCnR9b1?=
 =?us-ascii?Q?HP2EITK/EmlxXSAkCW4E7EbqqtjaLtqdzn+7IrPOfmRljWqUFDglDUFbjldg?=
 =?us-ascii?Q?/QwGe5a28M3Wu0AZYJ0aiTW6BEZcw6XJlpyvYWlq709HaqHVR4LQXXf9Ga1Q?=
 =?us-ascii?Q?vcEveCalKFiyni/Y7WZ0elfyWh2/TocsJ6OYPpMt+npKgcAwqKru2LbdbPu+?=
 =?us-ascii?Q?ARvFLOTtUy3A5eOgkp+RHx0CbyNEn49X+PgaUqiqpL9Va9g87gdd0OuNr+fN?=
 =?us-ascii?Q?jhAEj/e9SIKNl6LIdVAJVoCvSMw6a6mb7JkzIYG+Jh2DlwBl4Pss1aPPW8dW?=
 =?us-ascii?Q?SrHVno8I2iRu/nNmRii/26sYyeHxQRzILziyCi1m15aGoiOrt0+G2R+ZrF8Q?=
 =?us-ascii?Q?9qjbqtGUyDbu9D83kUqYlwCD+jOED/Hr5N3dDMVgRsbIUvypJNk9uaXgKXvB?=
 =?us-ascii?Q?yjN7jCmNv7ARIBxOvcMesbBwECygVCVo97peB5tcsHXVEGenxf+saD0Hxf8X?=
 =?us-ascii?Q?/f2qNvXL+CGs+dEi3/YLYfL4pB2EXNjTgCrxuwv3CZjpnnKg2me2k92inKoY?=
 =?us-ascii?Q?NWiTQ3fFcNM7+sHCPZs3NWIwdoYT5ZDgOHPrbbFYN8B9IQXnIrfq16MYSjc+?=
 =?us-ascii?Q?WPI06IZHVBd47Rp3+t/g2pK337L1+h5d4NeXJeIU6uJGnZqf1ma8oBU+nn1Y?=
 =?us-ascii?Q?mOILv+C1N8a27qDZRdd7w3A85WoxSgoprRkRAa0OszjnhY/V1UqIBe8zMc+A?=
 =?us-ascii?Q?OVKCLOu0ovodcvFEiAk6WYy6bJkFUmX2CYMDxxRDWs1b3ra9SNu69GeVaCFE?=
 =?us-ascii?Q?FnMEH3iekOdK+n3vPOsluvzd951MW5QN23m+gcLWox7cX5WtWd23OJHeQkvD?=
 =?us-ascii?Q?KgiFVEpmzjC/uG89wEQkQ+G7goxdMeHJq5gGYJ8oUYdrIRNAMEIl+UFc37k8?=
 =?us-ascii?Q?3RZFlKdAfEwYDegUrTMin+3DnvlKmJmn+lgT84SkrpGzMB171rcY9qk4/sZT?=
 =?us-ascii?Q?UUo1ofPpBXWH5JYBNAinVHlOIWe1iaUjb+7+Jj84r488ZepR3s7WdKRNAbBm?=
 =?us-ascii?Q?WfJpqRVapYaHpsXq7QZPGWADtgmeo9yLbhFE3EZV08+So2bXQDPIBWa1wd+u?=
 =?us-ascii?Q?8TCMHKnAkzCRY9Idq4JV1szqxpWalFm9mSstECAT/ZY8AFSMbpM75KlVsciq?=
 =?us-ascii?Q?7nmpeoIqquoYZ7D2096YBLSRbKhwsu+iHF6FrVd0z4GsnUDLeQGmRUGJGbrx?=
 =?us-ascii?Q?Wm60JVAQ8Fb7muyo4uXUDXMf0TlIwzTOCpGqUKwG9CS3I1exXMeIJotE0mNA?=
 =?us-ascii?Q?jYQmzdt/mlElrG0s3K2DKeGiOlDkKN6pPyFxeb/VttSN+tgSI9wjdjJnEFKP?=
 =?us-ascii?Q?laH5t1Pj9HlKrFyTRisBthg964WF6/unOQHWP3ZBpxsSHQyI5iHDfRsXlv4M?=
 =?us-ascii?Q?Zd7nD87VFnpH3R/WWkHAeOhHTQtnU3y0bmvbA82Sygu7EFqd6TEL99SyaF1s?=
 =?us-ascii?Q?lyqbwAxhAREEi3T+ajAoFpW81Jgp9Oknw/o8ftvMi5ESMUV+47lKbfModo3h?=
 =?us-ascii?Q?IurS6Sr/mBK5ihy/CEA5sJnQ6iP9JhPbl0+0D+oL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ba762e-f5a5-4cc2-6250-08ddaceb5913
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 15:34:57.1925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhd8Dl3NoaPyoEuINM9GKDrENcR1YxFrwq+w1O5sOYZAntXm/gkvczwzwfW4uKQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001

On Mon, Jun 16, 2025 at 08:47:08AM -0600, Alex Williamson wrote:
> On Fri, 13 Jun 2025 21:15:55 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Jun 13, 2025 at 04:31:03PM -0600, Alex Williamson wrote:
> > > On Tue,  3 Jun 2025 08:23:43 -0700
> > > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> > >   
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > 
> > > > For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the group
> > > > open path skips vfio_df_open(), leaving open_count at 0. This causes a
> > > > warning in vfio_assert_device_open(device) when vfio_df_close() is called
> > > > during group close.
> > > > 
> > > > The correct behavior is to skip only the IOMMUFD bind in the device open
> > > > path for no-iommu devices. Commit 6086efe73498 omitted vfio_df_open(),
> > > > which was too broad. This patch restores the previous behavior, ensuring
> > > > the vfio_df_open is called in the group open path.
> > > > 
> > > > Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Tested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > > > ---
> > > > v2: Use a fix from Jason
> > > > ---
> > > >  drivers/vfio/group.c     | 10 +++++-----
> > > >  drivers/vfio/iommufd.c   |  3 ---
> > > >  drivers/vfio/vfio_main.c | 26 ++++++++++++++++----------
> > > >  3 files changed, 21 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > > > index c321d442f0da..8f5fe8a392de 100644
> > > > --- a/drivers/vfio/group.c
> > > > +++ b/drivers/vfio/group.c
> > > > @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
> > > >  		 * implies they expected translation to exist
> > > >  		 */
> > > >  		if (!capable(CAP_SYS_RAWIO) ||
> > > > -		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
> > > > +		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
> > > >  			ret = -EPERM;
> > > > -		else
> > > > -			ret = 0;
> > > > -		goto out_put_kvm;
> > > > +			goto out_put_kvm;
> > > > +		}
> > > >  	}
> > > >  
> > > >  	ret = vfio_df_open(df);
> > > >  	if (ret)
> > > >  		goto out_put_kvm;
> > > >  
> > > > -	if (df->iommufd && device->open_count == 1) {
> > > > +	if (df->iommufd && device->open_count == 1 &&
> > > > +	    !vfio_device_is_noiommu(device)) {  
> > > 
> > > Why do we need this?  
> > 
> > What I was trying to do is put all the logic about noiommu into only
> > vfio_df..open/close functions instead of sprikling it into a bunch of
> > other functions. That seemed to be the right point to make this cut.
> 
> Alternatively we could be consistent about breaking out of the
> vfio/iommufd.c functions that aren't relevant to noiommu.  The
> container side handles noiommu internally, why should iommufd push
> handling up to the device file layer?  We're really just missing the
> bind path.

Broadly what I was going for was to just remove the iommufd stuff
entirely from the DF layer rather than to half pretend there is an
iommufd layer below it. This should ideally go as far as not having an
iommufd_ctx at all. So things start to look really weird calling
iommufd functions without an iommufd ctx.

> > With this patch we move toward the vfio_df..open/close functions being
> > symmetrical in their decision making.
> 
> But is it?  We special case all the iommufd paths to filter out noiommu
> but it's inconsistent with the legacy paths.  Thanks,

The container still exists in noiommu mode and internally does things,
eg it has a container->noiommu indicationm and the vfio-noiommu ops to
manage this.

The iommufd should not exist and should never be used. They are
different cases.

If Jacob eventually does what I suggested in another email then we
would have a noiommu special mode inside iommufd and it would look
more like the container.

Jason
