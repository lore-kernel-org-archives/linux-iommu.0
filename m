Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B886338
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750815396; cv=fail; b=VcOXpMOvex+bA3y7en8dECf6higpGa+oOrqA0xl79qE6vhtlVj3ko8ZR+OFiF6BLGUrrV+1QKTH4pFNDofDkRWpuuSYqboTppiZj/hEqb3vL4WES0bgKNIgxXOX7EdeqDuykeBrQsHaN6XNIAcZVg3HvEKux6WeO5g+kIDv0GWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750815396; c=relaxed/simple;
	bh=FeBWGmpzVEiRz98yGRKeJGvIxqrikEwbsqE5Lbh+LPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M2VBLn+qV8S5uiCJjktDUA81YBnoMYpTtWOfJHCdtNU2yXpUhVxNKT85CgsuuvCq0zk65cowuwbzlV0xPcGNIg7FSpfNSWHUBr+C1qqIixKSTMrKfGH5cTR6qaOWArcmTldZ2/DXv9JfjDMC9dm+EHKrFwiLTQ84ef6gb0Nl41o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lnJTEamP; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lnJTEamP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm5slFSW16ZoOHZqridrWqgMhjkgXX8USCyGdq2qYiP5IWKZ0C9p+TFG2Qs7wIq4IUXSQKNjy1W09I83nkAPviRfEo9AeWDgIj01OgBbB9aYhDhAFacOJ4y12Fa9IPV3jW1h+RuBEbYSl+m0xE4DTUvd3EOXBe5wdwR8cfmLnHo5mZM9K0dUNRk5WCBmkY4TtJr0eX9KLvlsIDqhtEfp7cSx+Tf3YKqF3VxfK+d+RopueWLQxDjwm7wciunh3mDYSegI1SCtLsC+kQ5DQwHNDOeVkFgx64NqmfUxT1aXN0mTQrbdq+5DnNP6fQCs4r5wxdEHIXdsUtsnHd2ruSYdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzGmFNIF/GXqwWeWVCt0F8+q8b9otuXbOfAxbXPkCc0=;
 b=j2tvTkSfG1Z6g7sj6boovO/HzE5JOARuGIAlDN0Hwx0vDcoqxL3iAT+Uth7gbSqjcBx8wXunDHRzZVP2zL/njmrpEFnTMVXpAdaHWeajaq17XQpm4TTfiGkpXTklVNCRAImfwz3ngzPfxnCfMrOFngozYp2Nmh+IKLI8qM6xnER7KmmxVxGpVgXexzAZuvn5SSd6UQbHJ1beA4BVLRhOzdlO9RA6sx4ygkuT3C1QAu9G5FbQQW7pxAIvafbe4MPxeeg/9FWLtbrMG6xs30+gIGWQbgK1KMT3PE7CVrhJ28qsDxcWX/zKQuva6IRLeSJiy5mVAxrsFO3GaoHEp+Cjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzGmFNIF/GXqwWeWVCt0F8+q8b9otuXbOfAxbXPkCc0=;
 b=lnJTEamPjPfefsYUzv7lDxaNRBZsOfjbNJl15u0btrkMS7UQnini6TD7o3gFjXlxHC00FWDLqVSYChXuN2WLo5V/VJk2LhKF8hUkfmz9gCcK0pTIA6T5y1FiJJqG5SNpdHKWT/OlTtgHT45Ol8rlIPim4NtxM8H/js8XKG9ner/OsUQINIFA9UbatUuDL96101VZvuW7E0uzpQaLiaM/LanaXdAyJrZ27zINgmOj9OTSmfvKCZjKs5yViROM5cFNSfuoZXb3ToSBVuJCMa2e7tKHdrv3aFKwvNIEi2zz9IToVhXAGoRlCwoDh72UbVhgGMVDJuiuSFsDrH7KOD+Ymw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 01:36:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 01:36:30 +0000
Date: Tue, 24 Jun 2025 22:36:29 -0300
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
Message-ID: <20250625013629.GD167785@nvidia.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <20250624145346.GC150753@nvidia.com>
 <BN9PR11MB52762BD911A3CE2F1A062B158C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762BD911A3CE2F1A062B158C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR22CA0030.namprd22.prod.outlook.com
 (2603:10b6:208:238::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b46160c-715b-44c2-93ba-08ddb388b5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hdQM5z7zqUI0PvL2CfjXNxZZYn+oHBrxGl64MFrUrGo3qxlZRh8dvJg82aSE?=
 =?us-ascii?Q?W37IpUt4RThbD67vSaTkDVgZBJ/SBTc6JrUfAi8s7DzdIC8YF7THQf7se4f1?=
 =?us-ascii?Q?03k11sfeCKdEySf/Xz+mg3i3S88S/z48nsfLTdqAMHG2/KjtHWo3LOOG75xR?=
 =?us-ascii?Q?LQVl7SDfV2jf3QWoBNQ+fgyEtHiSlND2f79Mi+q+H9aM3xGW2Xg8P53HS7X7?=
 =?us-ascii?Q?B1i861bYlL2t6jRIdEXVzggUw9WRvb8+0u20QdGiv91ItTSaUU5ZodNSmt/i?=
 =?us-ascii?Q?cxzWTBW1Lu9KsyWK0tdHwLIwfhHkjAi3tMqJGm5J0RMHeLurDa341TQ01PQ3?=
 =?us-ascii?Q?zbaY2qxFtopj7QyJr6IExRGpYzkJqKUdOlVBUNbhO927txkNWpBrbE02FvXf?=
 =?us-ascii?Q?z31h5YLYMKm51kipKvOO58YZqlnrBNDIZEKI0VvFDx6JJPqiWQtTNLqhYVHV?=
 =?us-ascii?Q?nzoLEpSiC4xFQnVApq2FiXizqPyZqJMJy3NSITCeHX51TiVg1b4A7InQwPf9?=
 =?us-ascii?Q?YqGCoj8nlN+hqMYf9zqDmLkt1BG0LX7wLPPVXHBtIryRanWdvmkXxyOV9sfE?=
 =?us-ascii?Q?+V+M81XcYLJP3duwZwFBmdeKKLL9Dnvhn0sQW+oyXOkfz5BnFH8SJO31Y6er?=
 =?us-ascii?Q?GVE+CfrmRSQBoUyH8TOTOE/w92KEn6SVZyONZj+QBBCqqBqdO6ywALL2v8rI?=
 =?us-ascii?Q?Vd1dyVVJJXa2W15PgNYId0dqe41LxmXMxK/ArSUEQFmnqLc8fBNGz7LvrHmN?=
 =?us-ascii?Q?GzjNju86/lBdyXEw5HtlkAH/UuJdWNkyr9XRI4vTCN0lmr274gTR0vq+JAry?=
 =?us-ascii?Q?UYxM1Zs8ARC24Y0Z4mpdUXerVm2OrjpUshiZdn0Kbjb6HjiyBzrur2qz5D9H?=
 =?us-ascii?Q?QqrQ56VEFcfE84cay88M7HUDvgrec36iq9vm/aZdTySLD5PQCWfwjjyH1yQR?=
 =?us-ascii?Q?cpuYy0U+RLqPO5cKAeDtviPW+1z3GgahTWeySSZLtVJAZSes2tFEKjAXsmYS?=
 =?us-ascii?Q?CAlyJnCBsMlFeLG9Mp95WXjAjCKXgbzyPvmElf7R81kSArr5nEjsaQ/BFr9k?=
 =?us-ascii?Q?C0IZ6O4eOCcIyv9nQ8g2RSZMrMdgPvZ/mtLvH+YI3l1mPekvIN3z8QKswGVr?=
 =?us-ascii?Q?5w/BOkLnKOwPmbOYy/ixyGSlZ/2QXHCq8T0UVlSPfHf/Q5p36cE2KmhlBC+P?=
 =?us-ascii?Q?yQ7UO3JVf1IMVnvvR6s47mesflz9sFGE4JcsvwKrXfNJsR8u6CD9T37UvBLH?=
 =?us-ascii?Q?Ddbf4OvnL9vdLdCrcDJ7A2aTVcck/ER9GVKhnC+PSDFg1ipV+e8sU7prNIVm?=
 =?us-ascii?Q?ce1EWeHBWPgKjBVFWWvxZ+FJ22LEywsYfzA5mV4WuSe0rw8cS4w2w2xfAlZJ?=
 =?us-ascii?Q?qPZNIgC5o5EXeXFa7WgiEK1sBcGlBMO2L+fCFfbS5fTmZYqxwosyn/sqvj1i?=
 =?us-ascii?Q?5BxcrSUvurE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IYvY6UMSADKTzIdG0anFNbRuhFQq1tUxFCltp5ChHM0HLGJbLfRFRBcDUeNA?=
 =?us-ascii?Q?uLOzfxXwgvgscclrx1oglGS+QLAZP3XIOKGrACn1luiRjqvB3cfTY7c0jfxP?=
 =?us-ascii?Q?XuKVtBZy/CMKijqPQ9LV8ap5UiKFU//mdLcP8uO8atpsb3US+FLgD9/26CDs?=
 =?us-ascii?Q?AJzJNRlQINM0u+uZFPBRa9/GxfMsg3rTaW1K8amTru3ykZI2c1oB5S/LZ37B?=
 =?us-ascii?Q?SVgraHDg3ZiR63yIdPcqbu+oHR/HaWkESxHemfJTwf1mtH1dCanBcjfOoIqO?=
 =?us-ascii?Q?iMMOJv03ahtBGSXQ59CljUB9Dnq04iH02bUN9sJn+QuJ3p+VmzCwETyMWCtZ?=
 =?us-ascii?Q?ANtv6vXGarE5v5AiBBPHLDyBUul7PPtv5WUcL2BW76QoIA7CDJENzevLsRFq?=
 =?us-ascii?Q?ky8v/gbuQihUqSuYVQAVvUhNDs4Uke0zybAVJUP1JddWkGqjQjw2NhDEtOfI?=
 =?us-ascii?Q?nlWhv1664HCCmymjL0sxbbS6q3c6zDAPsxXLxwP1chtKMJdOdpXhkrhwZwV4?=
 =?us-ascii?Q?w+aR1bEGF+LXgnrUtTGI0EQ4CApI5enrac7PVeay9bRMnStxVerGF18/fucw?=
 =?us-ascii?Q?cWX/53TkCg6hphHpPRhbKThnakGf2vtfI+iaZtVhnEfu40pS10Msqx3V07XM?=
 =?us-ascii?Q?yaYyzKD1xAMpjGHN0w25JApxS9JI5sddzUcGcn0iPo+nt85kR73+apDEl6Ys?=
 =?us-ascii?Q?WKotd3ApvCRABRYq2N27BujerkYPN1ZcqJOfRe7OY+rta3dZrqvEE0lAHBKm?=
 =?us-ascii?Q?ruAqAuJ8pc3dScAO6klC6hhkpSQ9IKR+QRO6g5U+0ymDiV48JRkbx/NCqoqX?=
 =?us-ascii?Q?s4e0qYCKn3VetTK+/+0h/p6BUFsTdzUNpi+RHUnv6r8HYFaIfeokg+TalezF?=
 =?us-ascii?Q?SzsgKeGre0fcxTI2XrsogKfpCyNyQv4poMCjD0aBL1wW67bB4/wcPge21obC?=
 =?us-ascii?Q?jTjIGfVGKktUKFsUc8YDK4e56I0+PyXlGPOSzaEuJGQqmjp0mxWqD4LwCO+S?=
 =?us-ascii?Q?235AYlN7JC0v00ih/33N1sTUSnWf20ZI+YCIvDuyN8lUvMPhIdX0ebIfHjkP?=
 =?us-ascii?Q?UugsWGS9lAB6V+PyfBOgt6DM44k6z+rlGWvOAq06853UBbv7PmR307rw9Gf+?=
 =?us-ascii?Q?UOGDNJZyI6MJNuyAseYbDlmeBJxL5cxcJDIdSlGngm+pYRw1o/xgOd3vn+AG?=
 =?us-ascii?Q?pW7THR/r8Pd+sB/Guq+Kn2xkeLJj2lCOhfJEqIneKVy7Z3fO2Kfqe+rB2BW9?=
 =?us-ascii?Q?f2mmsRJ06atOISS3d2tJpHNG3lTZWfNXlfeP85rVOkSuE7Hjf9iYJQ6L4ZRF?=
 =?us-ascii?Q?2Oe4aAFkIspePzADufh4aSzQzjpqlCFDm+SYTYAUy0GdVUuTwddeEMcfvfVD?=
 =?us-ascii?Q?ZAMewXj2qz8g4jtaabWGvUaBSlIEUrgdYeg8iQhQeJeDMmBAPG6sy+uyfKBh?=
 =?us-ascii?Q?enqUdJggSS1yrqTrdu2HVBcth8KMNfzcAs01ig6S1nWEUjymCPyRVobxBhe6?=
 =?us-ascii?Q?7MGMtf1ltDl/n5QbD4VTva11hiF+VwvT1oxyHgiJKEOP/VZp0faVqudo/b0S?=
 =?us-ascii?Q?GD6o7F3gUeA6WmNnYBYD/iE6Iw2VfKYCse7EeZ67?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b46160c-715b-44c2-93ba-08ddb388b5ba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 01:36:30.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ADTbt8Y+9QKVk2Z75uZlk5kUwRCdinAWoIYhuYQKnnRIXYJhQNYFVW38CyVj6LE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846

On Tue, Jun 24, 2025 at 11:57:31PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, June 24, 2025 10:54 PM
> > 
> > On Mon, Jun 23, 2025 at 05:49:45PM +0800, Xu Yilun wrote:
> > > +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> > > +{
> > > +	bool vdev_removing = false;
> > > +
> > > +	mutex_lock(&idev->igroup->lock);
> > > +	if (idev->vdev) {
> > > +		struct iommufd_vdevice *vdev;
> > > +
> > > +		vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> > > +		if (IS_ERR(vdev)) {
> > 
> > This incrs obj.users which will cause a concurrent
> > iommufd_object_remove() to fail with -EBUSY, which we are trying to
> > avoid.
> 
> concurrent remove means a user-initiated IOMMU_DESTROY, for which 
> failing with -EBUSY is expected as it doesn't wait for shortterm?

Yes a user IOMMU_DESTROY of the vdevice should not have a transient
EBUSY failure. Avoiding that is the purpose of the shorterm_users
mechanism.

> > Also you can hit a race where the tombstone has NULL'd the entry but
> > the racing destroy will then load the NULL with xas_load() and hit this:
> > 
> > 		if (WARN_ON(obj != to_destroy)) {
> 
> IOMMU_DESTROY doesn't provide to_destroy.

Right, but IOMMU_DESTROY thread could have already gone past the
xa_store(NULL) and then the kernel destroy thread could reach the
above WARN as it does use to_destroy.

Jason
