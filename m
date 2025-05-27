Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC411CD15
	for <iommu@lists.linux.dev>; Tue, 27 May 2025 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748304317; cv=fail; b=AvX1wfOk+Of1MUr5VmEGW9H3IBIvpnz3kcTVTmV6hvujKNEfEMStIayOyciK/XyWRxtpl1E1+WiKmA+3GfoO5CKz1h3wwHBrIu+GiITkwU2HF8bmJahQsh4iiTN76jp+Taz1DwGTPl5gnDFqrgUCPMkTYXdJwos2M7pYapGmOhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748304317; c=relaxed/simple;
	bh=qv52By25CVCjgr3sCFVyD9fTWOowD1KY+RocKk1hgJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sWgBrrn6MUC5Iv5cpxEaYzMFl4PVgbIFk5EoTAskIzYJWl+DJY90mCovEUdhpPO9fGnCLDmMLppM8p25NM0kYdp1UxwxTBJ4sNO85GpDdeG/x34YVwVimvZXl+YPBy6ycpCmpH/JlOd4Loei1LUAMvygul/L6nSyoseOgo4jAIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PKtjNeEN; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PKtjNeEN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii2tizbHHJZ9LeU+/Y/y4Ye/3j0nFSyB4e4u0a5CFQ+ta7tmeU2kENdhJXq4mjkrTSQQJGR6pnVtftBz98McRNtaXto23UZ25KMUaaOqz4pObc0lQUWxrcXHGiMP0zjocdRZc0UEr6KbqVfoOvGDbYzUxy6oN8kTg26sz9lnWY+VeUVh5dRqwXwKb91iEMBxwdtUMlgdgf8ck7EonKgWhR58e56krsK8Mx/ZU+V62ENgYbBQ8+XZgY7YdmiDZkIsT4WgdDbTN/P8WvbLTfeA8MXMatH8LeuEhGOS94eANwD2yknfArGLtYMekfRIDscVvWJYmdK6NaRnytDEgSSXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r45xNP/pBQVxaLRCXI2f6Mtugo2nCyvpaxLGLpsXxSQ=;
 b=hV67aCeHuPeTW5uKPE6Y9YHvkFFyojti7tYiJNA4a1/8FidtygLQk6SnlM0AIOUBP64s0WOs97PC/OEf+gzKxW/apXHSLcsBkQbaHbtVqp9UY4QB41HiA6Aj3YSYnYYELGDwxXqTTgqNb2f27YeSlADAh+aiE1sK8wIAqiwFGFYDehkvCIXoCP98YrU4G0RlhzIwR78Yd6HD82RDvgkJ3xQlqRwqYQCY5TRZvkTVPM0qhAkc0Kztl4sgadhOL96hOV6d9FzJKZd60oY/SaLrK2oG593ZuDRhCNvAXPZwy5Lv+a8prqe4BVrlLhFQRUaImmzQBrq9qT9JXaZ2nF4PeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r45xNP/pBQVxaLRCXI2f6Mtugo2nCyvpaxLGLpsXxSQ=;
 b=PKtjNeEN0K+3peNpr7yKOlJ7avhpZYDaQS+F6We101PbpAq+aWf1EMmg1Z3rqkgD5j6LPhlcRlkGrxKi3924HfFtj0ZCXTvpBRrtWdgIwdeTitinvP125kOVQO+MBUfjEch/hNMv4B6GTsWh+FfEaKEOM1g8t5+WojqeaKOcvWeA294K6mNpWdxnn+HqXMXStKLYLg9Yd/a4jOIRJZLqh4Q1W+WTA4WYHyYJ45peaG/Tk939PaN4OYuN6UfGRFGI63jVJvbDRDQNh27q6rIQzfx4w1Ea6OqwLNgM46FgXHTlhgenNgFys0wdMN4yqFspq15Yryi2y5YbIx235n7EPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 00:05:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 00:05:12 +0000
Date: Mon, 26 May 2025 21:05:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
Message-ID: <20250527000511.GK61950@nvidia.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c7ac75-7fa5-46ff-6448-08dd9cb22692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OY+trXE1F/kBZKfCY6hPqEkGFZtmcMt0SS/1asYpFisj3JPc00pJKb6NhW2s?=
 =?us-ascii?Q?wd87HzBPHcH9RRZSTHydCFvOGIos2yK+AYFuTPzcLBRJno/bdkWyJcZjymAT?=
 =?us-ascii?Q?z22wLG5bO2wpzzC5deXlcWQ8rtvhT4ADq+nE6YrOVyZOxvya2PT9yRw2drLs?=
 =?us-ascii?Q?0PPtkq9QNRAk5yZQ3myukdVA8oEctRDVeNxaOK/U0Bg7peRkLby4fcdcM//o?=
 =?us-ascii?Q?Tcj9Am0XZf9QOIIljGqyxSijSb9aTAC/7wNnxQyikf9/qznRZy7KRp0EF3nI?=
 =?us-ascii?Q?UBajOIBuRJNJ1wrHwWS6vOVRnnkEjscTcDcFAViY0yzay9Oz69KYPbFVXOrY?=
 =?us-ascii?Q?E82jbBsiMi5CBfW7zU/oaOz60L9gIw5Pa+xHYDPNf6D3I+G/sxDGPqHd379a?=
 =?us-ascii?Q?tOATISsgft03/OJNerGelOAOZ4pxHY6n3aaTpX+CA0oHMmj/VYsuD0Rgb1mc?=
 =?us-ascii?Q?Wr5wC17Q3voUS4obwhc8ZIpUNLDIX2lLr/SNVj4OTyInjrOzt8npOJRFKGZQ?=
 =?us-ascii?Q?/vZGC13I+oGHm3Jt9PFuliIn3IhtBORPKeIcfPUbTyMS7JqBmo96Biqfo6tB?=
 =?us-ascii?Q?teBa1FeWjGStPkaRjC3VKcPoO3ZIOkIMBBGsWz9KaV6h9/KAoFeMK6tnaN9U?=
 =?us-ascii?Q?/Og6xdY075iDlYzFH1OCGZ3he2UHKDME12FLJU3UsqHPnAGepxdSo/Qvfud1?=
 =?us-ascii?Q?x1VZwvcHsv7DUIAUOD2fLcZsrcsIuTqUJKl5lDDBW3+9NKQDvBZydozR3hdV?=
 =?us-ascii?Q?Dja63TyASaB2FCv+Lohz272vCT7Z7C03y1fW5GOgVqMhvE/y0BvDGIIZLpi2?=
 =?us-ascii?Q?ijgZY6gUo71Ae7qwu5ZVj4k5RCKfDFgNncGXyR5YCHnBxl4Hynw11no65p63?=
 =?us-ascii?Q?talwl8JfvZOE9XN4RaoNnVX69KV8JfQOv9fDp8pypKkVMsUfLuMOdWN6QRIg?=
 =?us-ascii?Q?JQwgOsZ1WBQpo45ase2FhkoojXkq2oDhQItnVFwraCUWg3s0MHipS3TiEo9e?=
 =?us-ascii?Q?1RTPKpqr5qaEJ8eMt8TaO5rLDooTtVQFXupYZCkEASXg38nCPUaDTxCxGXJS?=
 =?us-ascii?Q?KW5DQOsnxVRONfnpDgWXJ8nAq6iAHQQef7X+aT5oaltewbcMhS2rs7lWLRfD?=
 =?us-ascii?Q?VlXwWF4yDbZp4iv/KHwrD0HqrY7u4EEZieLUt7y3fGYs0bdDZTGFQqxSL5Xe?=
 =?us-ascii?Q?Mm+Sy2hsUQsH/LNisWvjmB6AAV04vQD/33LRf1UZsceX2xm/b9wg2xqTMje5?=
 =?us-ascii?Q?BAea5VJyxhZGM4Wvu2qNMrKi0jtqecsLHdQRx2QYSfW5jy8kttLFMAHHHnTI?=
 =?us-ascii?Q?El86U2wgNMYk3VyUHIdOR2vKlUYuZIUKRgpfBFSRT42yq/2AF9Ny+j96oB/P?=
 =?us-ascii?Q?iCWoNcfic91XP0QNu7sDYJhONK/hf7Nqs3SGqUW87cDRSsuP7tPEiMtvsgi2?=
 =?us-ascii?Q?P+5sRXYqlqE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w7epKvlmc5BK9yCy5iQQCLo1qQfwlPgJo7P9gzYtn7T8BKtNzUKeCkxfKmON?=
 =?us-ascii?Q?3/g/CnprBZ1uurSz1t5Eg5M0NyJq0cAjIwaFLX/yxUmVnfn3YpRuHN2w75d7?=
 =?us-ascii?Q?+Q3c+gC0uQe0odR5jfDehOSJ5B6tO3IDf4uBGz8gRijReHIoWxPb+tLDEAXY?=
 =?us-ascii?Q?LCw8YEST89N0fTA5HMwPUM19kSYeNm3b13KcznxgC3f+utJzgHZaQgejnlcl?=
 =?us-ascii?Q?mV7cQrNBps7xTHwYsRP644ed2hVqDdQbIfWnNkc2INwL+B4nrBtA7hwHbOPJ?=
 =?us-ascii?Q?dFD5goUmXXjTkItDRFc/miYrFNOZVdEYBP/hj5+uEQK1XpHaFGAisZatli2I?=
 =?us-ascii?Q?hDNnKIOubLAiUibsanI00IqNuyTzV3Xq8t6gfCRLONfJ1c8oOTHHDfJA5wUd?=
 =?us-ascii?Q?yd/TJLDC5xXg6SVBBQR5Aqc143yMIb6h5tKGDeipG2ElGUqJQe0SHM8h1bgr?=
 =?us-ascii?Q?hI8GacFzRPXPCimMAm9pnJYGwIXm/QV96sCSNVEtnfeJg5WzeZyTnYMyuHBm?=
 =?us-ascii?Q?GvKm5yzG/Z+6XAzDmnaucRqi+TuNLRCmNpuMEyByI/LyZTa5+F4fvpkJaktK?=
 =?us-ascii?Q?a9QotsQ3O1FK00uxi3FIHDVhm0y+LqADZWp82mPT+xxvcADDePdYnPy4ihkc?=
 =?us-ascii?Q?sELLodqTfDF2nMLuFBp5P1iSj44Pd9xmAW7tox16p7XV6tdr4+jrKDTQbqZW?=
 =?us-ascii?Q?feH385+8HbIHXoWXe/Ztx6OzfWtIQIVYUEK1xDZLwalZCzB0pXgZxH9184fN?=
 =?us-ascii?Q?CNy22jSAhEeAJYeYWGxry3ezbzOKaqxoxja568pBtHroIwwKdTPtylEFL4iv?=
 =?us-ascii?Q?p4t1VrLARRYlc0Vsh54XLqxSSF0hr54FgM5AUoxJF2GZ4IdT4uOIn67EoQme?=
 =?us-ascii?Q?fwD6m4ag3LX02xQRUG7xELWb2XaBB5nTEaW10RiFS81cPr+Lme3MnDwHK4Fq?=
 =?us-ascii?Q?/4AhpjmxQ/fzWSDPdsgBofVKm3etWjicLUqLZW8FUzLIhufMtn1Mz07iR0zx?=
 =?us-ascii?Q?N7wb1QCeXXsUPXgF5CSl2ljpWSCIonDQF6MNn/ydou300gV8G96DegwhmVtO?=
 =?us-ascii?Q?i0puq319Ki/HJ/YJWbYP2KIYzDEEiVYhUaXr4roTHwnCAIzEZJtTVICIYRyF?=
 =?us-ascii?Q?DYf5MPOD4Za8/YWO73qOeTbz/qW/DGun3T7gzlo8XLeISDOZ+9x63x0RHovU?=
 =?us-ascii?Q?fPBF6OOskoBYvmPLF6Q0iZVktsfE0jNewKCgCuI6glOZBbTwthdj/j+1JHJs?=
 =?us-ascii?Q?GVkXnuXV19kjHxHwKtCPmb6Vt25FN7n9jA+Y7i8H2Rp3/ZCyiVwD+lXl1W1p?=
 =?us-ascii?Q?LUGxdr9K57RtBTF2mg31rfxpzQqTGUsOtqrcWZieNYoQt7+3Ob3AFPo+n4dV?=
 =?us-ascii?Q?AKwCmLIYF0qMKTLb5yjskG/GCjxzrFEqbUloBM4InQOuQ6pcGgRPDHL7TDwF?=
 =?us-ascii?Q?SQYn+oQzACWgK70Y4tmjXV+gML/qVTVaZ+SfIRS7SBDPfIW76pM83gWBb8Sp?=
 =?us-ascii?Q?VcgQ/j+tsJ+V15eOw/7MFi7xb2OsApEO8Jm/HexSG2YG7dIxlyieuY90HKfy?=
 =?us-ascii?Q?SYjyO1F01HHebBoG8abU47o7a3QWcKi8z2Xox1/6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c7ac75-7fa5-46ff-6448-08dd9cb22692
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 00:05:12.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A9XmvXNXovJH44ikrCYmKs8OibEPGsl4G1PZhPHCzi9DyvgcZjA5ooj39YkooGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406

On Fri, May 16, 2025 at 09:45:21AM -0700, Jacob Pan wrote:
> For no-iommu enabled devices working under IOMMUFD VFIO compat mode, the
> group open path does not call vfio_df_open() and the open_count is 0. So
> calling vfio_df_close() in the group close path will trigger warning in
> vfio_assert_device_open(device);
> 
> E.g. The following warning can be seen by running VFIO test.
> https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
> CONFIG_VFIO_CONTAINER = n
> [   29.094781] vfio-pci 0000:02:01.0: vfio-noiommu device opened by user (vfio-noiommu-pc:164)
> Failed to get device info
> [   29.096540] ------------[ cut here ]------------
> [   29.096616] WARNING: CPU: 1 PID: 164 at drivers/vfio/vfio_main.c:487 vfio_df_close+0xac/0xb4
> 
> This patch adds checks for no-iommu mode and open_count to skip calling vfio_df_close.
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/vfio/group.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Sorry, this should have a fixes line:

I think it is probably

Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")

By the look of it, since that is what started skipping the vfio_df_open()

But after looking at that patch I'm now doubting that this is the
right fix.

Previously we'd still do vfio_df_device_first_open(), just the
vfio_df_iommufd_bind() was skipped.

Now we skip all of vfio_df_device_first_open() which also means we skip:

	if (!try_module_get(device->dev->driver->owner))
		return -ENODEV;

and
	if (device->ops->open_device) {
		ret = device->ops->open_device(device);

Which seems wrong to me?? We only want to skip the bind, we should
still do open_device! At least that is how it was before 6086e

So.. This may not be the right fix.

Maybe more like:

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c321d442f0da09..1b6a0e30544401 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 		 * implies they expected translation to exist
 		 */
 		if (!capable(CAP_SYS_RAWIO) ||
-		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
+		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
 			ret = -EPERM;
-		else
-			ret = 0;
-		goto out_put_kvm;
+			goto out_put_kvm;
+		    }
 	}
 
 	ret = vfio_df_open(df);
 	if (ret)
 		goto out_put_kvm;
 
-	if (df->iommufd && device->open_count == 1) {
+	if (df->iommufd && device->open_count == 1 &&
+	    !vfio_device_is_noiommu(device)) {
 		ret = vfio_iommufd_compat_attach_ioas(device, df->iommufd);
 		if (ret)
 			goto out_close_device;
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index c8c3a2d53f86e1..26c9c3068c77da 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -54,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	if (vfio_device_is_noiommu(vdev))
-		return;
-
 	if (vdev->ops->unbind_iommufd)
 		vdev->ops->unbind_iommufd(vdev);
 }
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 1fd261efc582d0..ff19ea05442e7d 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -506,17 +506,19 @@ static int vfio_df_device_first_open(struct vfio_device_file *df)
 {
 	struct vfio_device *device = df->device;
 	struct iommufd_ctx *iommufd = df->iommufd;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (!try_module_get(device->dev->driver->owner))
 		return -ENODEV;
 
-	if (iommufd)
-		ret = vfio_df_iommufd_bind(df);
-	else
+	if (iommufd) {
+		if (!vfio_device_is_noiommu(device))
+			ret = vfio_df_iommufd_bind(df);
+	} else {
 		ret = vfio_device_group_use_iommu(device);
+	}
 	if (ret)
 		goto err_module_put;
 
@@ -528,10 +530,12 @@ static int vfio_df_device_first_open(struct vfio_device_file *df)
 	return 0;
 
 err_unuse_iommu:
-	if (iommufd)
-		vfio_df_iommufd_unbind(df);
-	else
+	if (iommufd) {
+		if (!vfio_device_is_noiommu(device))
+			vfio_df_iommufd_unbind(df);
+	} else {
 		vfio_device_group_unuse_iommu(device);
+	}
 err_module_put:
 	module_put(device->dev->driver->owner);
 	return ret;
@@ -546,10 +550,12 @@ static void vfio_df_device_last_close(struct vfio_device_file *df)
 
 	if (device->ops->close_device)
 		device->ops->close_device(device);
-	if (iommufd)
-		vfio_df_iommufd_unbind(df);
-	else
+	if (iommufd) {
+		if (!vfio_device_is_noiommu(device))
+			vfio_df_iommufd_unbind(df);
+	} else {
 		vfio_device_group_unuse_iommu(device);
+	}
 	module_put(device->dev->driver->owner);
 }
 

Jason
