Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F9156C78
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079556; cv=fail; b=CBHfRYVy3KQhCCOoRvseNhyvv1Pc4eewAHHtFDAC1hL0E2QaYRVytjPQsmX9lSKOUCk8wXHFX+SzOgf3AkyzneqTY3RVZEOsiIi90EiF1YyWZTUqogUcZ5jfyvQ+q28TGik1EoRIyoewtV86D80Z9HLhscQEgbiSj4ViSm7pSJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079556; c=relaxed/simple;
	bh=m40fcPstNzwerDqD4Dq3Ksh5XDk2BBTeJQa35vOAhHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ji4QMexCg1u8FsUPT52j18pcb/w4aDyKbZSXHPY5s/DiKGdR0FeFQepTdEZ8mYDHFZnrdBivJSVUEwjAyaIVwEo2tNm0Q3IAuqn6qpKVYk8VPLAKPSh5OFhkGU4ruMbziNVwvmQOzuc7WbVTFhypETSJuJgWW+ulo7DnOXwBbwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usz/o3k2; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usz/o3k2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7cqzIlF3AzGhvqtaMhs/GP2rlqG8V+WvnFRO3gpY4dE+fud/45qw0dAKzPl9A593D8IkT586CtY4Dywy8BLzWwhKz+Ljtn7Q8esSwP1d4IdL0edf7uwg8vDBomTiktyxu7g2taDNExBMSWTGyZMvdJSJOmG+3Vo7QmXV+QIOoqj/4+XAtl679FYKmh7uQ1tr9Wly1pqnV/SKk427cpbMFhXHGuEf8EXRuhF+2klagZn/1v1gj2ktBmVPTwN2ilS7pSr5Z+J5E6V7pwxaaEzrOeSP4APqkm9r9Yz8RQ4V7Rj8Px75ZKxts8ybBA7Wi0OHlGL7yATl3+4ggFBpaXZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbutAkTX0RyfUE2eve0X0z6QqYmJy2GnX1lDPbw/ySI=;
 b=qA8fSLVPwlIX153Z4jzK1rRZWyf+PYKwW9g2p6+RsYBKSQoJzk7R5zyfaD0aRyTEvsDrW0O0UjsASk2n7CnsNKjOCK8eNjCmHZu3vsVOyodtvkY6TGH6TBZ4CgOTsoz5QYI2/QHsldWIoVNRUAP8KWtckcEhPLccN2imMsvbOtAUObys7QuymuPk38aQFJyPSGz01zQ6T2zmyromvEhzqqhCkazrlICnAh5m8GIpFUMgvuchXizG53cKnf4zfsTo+MdNnPsNug2su73g6lledKZIyxlkydZ87A89IaAChlfkw7etirkPqtYfJlWaQ9GLCC+kQXbLNyW0K2LTp77PNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbutAkTX0RyfUE2eve0X0z6QqYmJy2GnX1lDPbw/ySI=;
 b=usz/o3k2FbD5HIDA2lGOcN1S29QTJP8a/LdRJ/gp1eODKm8EGGX09RNFEn0uFthNrMWbEqvQyz4XCHDkGTyOz/ieDXPXyJu4W0hgLPMlh85eg0Ftq9b8vct6v3C5Oac0kYyp12GsIsrL7szV8GTBcfXSykq+Ljfoi2AR64LI+xQB0ZdDBWuPM5SnPQCzeUbqIIxhS/Xq/etwPxKQCqZgNkNR8IzSTzugG3G7TBawDO7O5AnyVetGgRbn/wrIl+BkE4ZF4+YzVl6xAjV1L+J1xrKKcAMkjwIfYhYauy2S7tiSNNrxYD3sq8MOBNMu0GN+WIpwGx2QUUOhV2H3wNjpTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:59:09 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:59:09 +0000
Date: Mon, 19 Aug 2024 11:59:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 0/4] iommufd live update
Message-ID: <20240819145908.GH2032816@nvidia.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240722155500.GI3371438@nvidia.com>
 <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
 <20240806125602.GJ478300@nvidia.com>
 <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
 <20240808195252.GE8378@nvidia.com>
 <53e7ab6b-9419-4808-b429-a88faeb3f6a7@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e7ab6b-9419-4808-b429-a88faeb3f6a7@oracle.com>
X-ClientProxiedBy: BN0PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:408:e7::21) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 09689613-b881-4137-2fad-08dcc05f7aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hms1pqreDN9PfryYFuro88eDV7Mq8usYDG4SO6l6icLWLap51LndWsabLBwN?=
 =?us-ascii?Q?celLHE4rPCkyh0dS7WTMy5UpPtzUh6YY6B7m9OTBEhcnMsDYB7IAJex77/6D?=
 =?us-ascii?Q?oS7mMFBGUhnzvyVWq7V7itI0fT8VPF4G6CfC+oj0bFOHFtW0S0dUsvAZ5cMT?=
 =?us-ascii?Q?rHkeOEqCtMIGpB36FBCLwLYS8Ke2JNt5TxFxVnecK7a1TiKD1dVYRSn04ZkC?=
 =?us-ascii?Q?09XlQ1PCUfqXIZ6yXhXbCmotLnHv9vnRbSVMCYNZPUXpfNO/iZt4spNOV7TG?=
 =?us-ascii?Q?b6Ar1vCifEztbO5zxbYHSdKvKV6scmlAblk02SNd64vwgIGP8Rmr7hmklTbZ?=
 =?us-ascii?Q?LQOSlBdeT8DMm6VahPSxEdAHXlyWebEK+qx0Gwykcm9Mn0fyugE/fwGFopIZ?=
 =?us-ascii?Q?pfT5p0RmpA03Z4Okvh0OJf+L0zIVKeLofxPWD6dsHUM5743Z5IPujxklk1Ra?=
 =?us-ascii?Q?SBLPhW31xBhkTzQfIYqHRwY8N8uLdd5idAA81dRTbaidBLcQXvHt5DPYuTBp?=
 =?us-ascii?Q?1Kyd4dNddiKryEWZ8DLaoCGFUYjQl46MvXuEE53VgEFCuPesIfgBEdORxXm1?=
 =?us-ascii?Q?/bnuOGnUJiX8Ec1OrHSs4RvWfA8PTm/WOsSr7TYwTjecKRtRyH1YJBGpJUn4?=
 =?us-ascii?Q?iUMiglQQHu0ClkOVvGWpjvw/OJJO3P6hBHfPZXTXKVWkjNdFzyxyX/KaRhj1?=
 =?us-ascii?Q?Nmr2hxDm2r9l/ce9hJ6UIjkFfKwbZJ1quxgGMm9/KExuZ+YTFASQri7fXdn5?=
 =?us-ascii?Q?etL3eGQTGh5yaySlNXYjkwIcAhzn5NMVbzaMxHXTBCAUYyR5YeP/rjU5t/Dm?=
 =?us-ascii?Q?PzV4/QmvFxSl6uNcBxt0KR6DT90ZpL21fDJc7w+MowGJcJJHHuuEg+N5Z+cS?=
 =?us-ascii?Q?3mU0Y8+onkgQGwKaLnHyRiLyY1KU0RxFlneVKx2dXdI+7G2ZOwNjSAlVpDNS?=
 =?us-ascii?Q?h6u7vVfHwqzvAJQi4z4VVSfdHEhmV1dvcmpZ9UKRnPXga8V23eEv+4iuG7Yz?=
 =?us-ascii?Q?lS4CDWsNYVQ3dcj/ZtXrIKrEl6Mb2BMZ4AmvqFu1BBAjXaDJtE9zgmqa0cSW?=
 =?us-ascii?Q?vtGFcZ5nus0JAkg+BgPsKlfLuG/SMbt701z/b/bC2CsnvvvC7FYA0KK+/qW5?=
 =?us-ascii?Q?Jb16TQEQ93jsl5llwOpWcuv/mqwu1an0oPlNGf5eokn2A/DiuvkSHvksoNtY?=
 =?us-ascii?Q?SKniOp+W40sH6LNAcSsmMaIH/uBHDN0CaT8rn7QaRNlYlg4q7tZh5MC5lWGs?=
 =?us-ascii?Q?Etm7DhjuWnFcL9hP2MePSdIRtt1RBpmPSYeufNZYFEKSHsbMZVlK5+ClXT20?=
 =?us-ascii?Q?aRZFDZOqH81jqWIAVSpxTLdWuMcD9PJGLdvE7VTi7OJ5ZpubsX7DBcerQUKx?=
 =?us-ascii?Q?b2eVYAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SbU0eSDzQTYvnEma8m0gBZSgMiWB0Ru6e26jLaR4kvunT/Jpj5Qani/xALAu?=
 =?us-ascii?Q?knhZPzofN5BuXhAfCrN1RxIDi8Mg1xTIZo3aIEmJiTOaY0YZZ4LqumpN+S1T?=
 =?us-ascii?Q?brZtvMI8u/zlmB8YbmKSQBLx7d0FekLvSzMLofLoRxpQEGNgkycS97pW3Izt?=
 =?us-ascii?Q?KF1nvidibrQWzpE+qJo/V5SXWMp2eGH7KThwkv2u168eGUhs8jqC9rZrxDzF?=
 =?us-ascii?Q?5MQ4LpLkPErBF0z7npAU9xFnxZ4Nl5VmSCEWs6dw4+zepWXCZ50R2+t3ufvl?=
 =?us-ascii?Q?8XBEiYosljyoJziIFkh8i8k9gGNLAx0aaBWDCx8uIicLdDfEETx8aFuq49Rp?=
 =?us-ascii?Q?p8JB7nFclI3Irxe8tVJrBjHvmDYxnozbg3f1B5LW2fbk5X2lxlogYYS2uhqf?=
 =?us-ascii?Q?2tnDrem9fNXjpRl+AuNPnVO4PGSui0KcDosq+rUcN7BxfaTeaDO1OcegsGSD?=
 =?us-ascii?Q?TtN1d/K8CGxz2GdfuIm/A12NAUPD0qGWdiph7XPzq6JWEJiilTr+QfYSa8a/?=
 =?us-ascii?Q?cX5c70QNiWyYQeJpLUhxkDG+4lMK2EosBR390hbWOuFfCG4Ey3Al97FsnwL+?=
 =?us-ascii?Q?7epOdOlIOta0rrHTDY+zXE0EgTcP9Cz8gn21j3IWdSYWJ2Jy3s4iZyJPyXSb?=
 =?us-ascii?Q?4VV88J5S/mnyMSy4ZBSxcUPguusoHWRblz46871mVNVomtiOtCeGKsZHWaOD?=
 =?us-ascii?Q?FtZGaBhOuWJN153WupJQz1TF3Tv9YZ9HE6T1omXZfMxuWhbeZJrfiErcjBOm?=
 =?us-ascii?Q?TViwQOr9mMNehN59TNx8gs3NBcEXXVJTkDqC9/J+XeFoezxdtexaJGNqvTyg?=
 =?us-ascii?Q?qznVQB9jEwSMGHsoW/uEQDFkAms3ndvfBFt4x1Q//MVve3vJqJU8hPNwvWg/?=
 =?us-ascii?Q?qMEymAgl293MbWYzSpyrR4byDG09+udP47cKPX2VNQqsKELB5ldyAV+1HCxr?=
 =?us-ascii?Q?ATIarsPjUuw3XT1E9iToX0rkkp8LM5wZFgYvjBsSEQ2Oy+q9/j/qprKPCzcn?=
 =?us-ascii?Q?aoV3rWurtzPhJVnhZj4K5jVWPJvSa1RpRGtvyrp6rYUpqaVY3zNRjxFwOGPN?=
 =?us-ascii?Q?lDeCKsdVjQ5QjKUMqUMWbncUSp6t0Bgwi8te1qdCVZgu0DDYeVLhbjjagiPO?=
 =?us-ascii?Q?IzwzIobiArYp57EccPqBgIM3pJkONkA8UZ4Q67yzSA3qum9QZHg9vuoRCfp7?=
 =?us-ascii?Q?v43tlbAz5V/IUb0wtROHJ244YmvqXRTS96hdx26ROqchFqtwZt4p/0SW2Si3?=
 =?us-ascii?Q?AvsSgbVJQS93fwPrxGarBV9cJqJfbzjd9d5WzuaU/yQvzM1YF16iiMVi0w8e?=
 =?us-ascii?Q?/Az7M2fdfhrc5tiJu3/yEuWkAEsAV7eYYvquz/NohHr3ydEwvUQ28ZbzPY3O?=
 =?us-ascii?Q?4Wbs1S+L53PaTfvX3Y8NhN3DrlP20YLNFySNnldN0fr/+XkzMfTspNKJlf7N?=
 =?us-ascii?Q?Cuie4KzaThqvVBYJ6wRFcay46atwCRWbwQ4AEt8mnigIJtOZii39dWJ084xR?=
 =?us-ascii?Q?/MnAKvw+BPWh1ATKLiemPYmkdNPVMJxCB0+Ic6lgEdkTzuVpCOmsNm/6XiiK?=
 =?us-ascii?Q?vsub4b7GeAuBi7gSQRA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09689613-b881-4137-2fad-08dcc05f7aaa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:59:09.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt7V70rVwPNecbP9eemQ6NDw3K6ibGGuo1xbgXFmAqTIrwf0cVtj8A8nqpSH9g9f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

On Mon, Aug 12, 2024 at 01:41:46PM -0400, Steven Sistare wrote:
> On 8/8/2024 3:52 PM, Jason Gunthorpe wrote:
> > On Thu, Aug 08, 2024 at 03:15:02PM -0400, Steven Sistare wrote:
> > > On 8/6/2024 8:56 AM, Jason Gunthorpe wrote:
> > > > On Mon, Aug 05, 2024 at 03:03:30PM -0400, Steven Sistare wrote:
> > > > > On 7/22/2024 11:55 AM, Jason Gunthorpe wrote:
> > > > > > On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
> > > > > > > Live update is a technique wherein an application saves its state, launches
> > > > > > > an updated version of itself, and restores its state.  Clients of the
> > > > > > > application experience a brief suspension of service, on the order of
> > > > > > > 100's of milliseconds, but are otherwise unaffected.
> > > > > > > 
> > > > > > > Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
> > > > > > > of an iommufd device to be transferred from one process to another.  The
> > > > > > > application is responsible for transferring the device descriptor to the new
> > > > > > > process, eg either by preservation across fork and exec or via SCM_RIGHTS.
> > > > > > 
> > > > > > It seems Ok to me, I'm glad it worked out for you
> > > > > > 
> > > > > > But have you considered using something like the new
> > > > > > memfd_pin_folios() system so that iommufd is bound to the FDs backing
> > > > > > the memory instead of VMAs?
> > > > > > 
> > > > > > https://lore.kernel.org/all/20240624063952.1572359-1-vivek.kasireddy@intel.com/
> > > > > > 
> > > > > > I've been expecting to add support for that, but does it help this scenario?
> > > > > 
> > > > > Thanks for the pointer, I had not seen it.
> > > > > AFAICT it does not affect live update.  The memfd is passed to new qemu, and
> > > > > the manner in which its pages were pinned does not matter, as long as the effect
> > > > > on the mm fields that we manipulate is the same.
> > > > 
> > > > I mean instead of using mmap's() and telling iommfd to take the pages
> > > > from a VMA you'd use a memfd and tell iommufd to take the pages from
> > > > the memfd directly.
> > > > 
> > > > Since the memfd is not part of a process or mm_struct it is not
> > > > effected by live update's exec() and none of these gyrations are
> > > > necessary.
> > > 
> > > The problem is that kernel clients (eg mdevs) use userland VA to identify
> > > memory when calling iommufd, so we must update the VA's after exec.
> > 
> > Technically no, they use IOVA too and iommufd translates IOVA into a
> > VMA and what not.
> > 
> > So if we teach iommufd how to do memfd it would also learn how to
> > adapt it to mdevs as well.
> > 
> > > vdpa does the same, if/when it converts to iommufd.  I cannot see us
> > > changing vaddr to (file, offset) everywhere in iommufd and its clients,
> > > up through the mdev code stack, can you?
> > 
> > That is exactly what I imagine, because it isn't vaddr already, it is
> > IOVA and IOVA always already translates to an area which gets you the
> > vaddr.
> > 
> > It is why this series can remap the vaddrs on the fly without reaching
> > outside the area struct.
> 
> OK, that looks tractable.  There are not too many instances of
> struct iopt_pages uptr to fiddle with, adding support for
> file+offset.  We must of course keep uptr to continue to support
> anonymous memory for iommufd, but such memory will not be supported
> for live update.
> 
> Do you envision a new userland interface variant of IOMMU_IOAS_MAP
> that takes fd and offset?

Yes

> Or have userland pass user_va as usual, but have the kernel check if it maps to a file,
> and save the file?  The latter is more work in the kernel but requires no change in
> applications.

Maybe this is possible too..

> Do you plan to work on this any time soon?  Do you want me to?

I wasn't at the point of this yet, if you are interested I suggest
taking a stab. Now that the the infrastructure is in the mm it should
mostly just be changing pin_user_pages() to the other one. It might be
quite shore

> We still need IOMMU_IOAS_CHANGE_PROCESS to handle
> IOMMU_OPTION_RLIMIT_MODE, and to handle a changed uid.

Yes that makes sense

Jason
