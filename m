Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389193D2FEC;
	Tue, 13 Oct 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892799; cv=fail; b=nLKZviFvAneBHa2n5hUFihxd8wGa/2Z6ZPltPyTUaENn8yE/TI0PPFsqInu0yWwRyhHVhQi2Ws+P510LD1HrY+4R+yup9bv7aiRt816Tmn7lNoul3PUUOjVmEDob8qMXaeJPpIRwKTQWj7PMKsrrzjOTVvwUaTVq4YhhKF/E9po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892799; c=relaxed/simple;
	bh=EUZthlkzqVbM+WqBd5lZCiINVtDI3tcT/6Y/kadOokk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIkzx1mKdfXFn31CVcCbY3fihnqQKgoPxi11etFGxkVMPDCY3Lg54v7BsQBpBUiP2mGnKFUrsZKFvwPrKs9J0EjYGmJW0cb/tG/6PPMUlfkQxS/PMadp8N3invgIoYsmRBe1uZ46rR0RL3wVgbD210EiIPgExknvVZnXngvh1RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mun6b0zG; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mun6b0zG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aab9p5gJzp6L3EDPyyLJQ9OjDFXefz2OoLlFUii2wM81EdOUf9rPENJrCVxIh8iTKdQAy3gNz8jhxpgPfoa5nJEMhtgNCAzqXzNmwblnoDT8DB4tAZqRKVCZeicMQdxatY8NghRY5C86iIwHAGnODWLjC95LlXUPwilNhVyZRn2RoWJvaDDWO0TYWZAaMJhHLG6RDvLuJ53beilhsbR1mzSL8HrnZxqeH1I99PvQZPKviHqCkQSXlOSp2LqdpdJXEFm5bbHMzIwds0lNDgTE1BcXhnJNS9sF1DlReBVzKfiGp0x/cIQF70N/6ndAnM+F8K9cIzkt+wdwWGPQA0/iaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzJ8Bp+V2nX4aPQsVJG65DNXcLk8TsfMzZvmatgUCSY=;
 b=ftTDzibayX4QxhFrD/3uw0HMh7wnIayhL307mtUcrJfXZo+ornHcbBtpPgevlMkACozOT3BJn871VXO4gue2aVie+rYAmlCzNrwnNjTb8txU0k7u0DeUwQh4/7Vn2Nvodn3Ek+K8AhbqZ7T9M1ZxBxAF6yUZBBiy0pSwM7kpraGA+KAw8IwKPXeWFKGuPwca2OCeu2tfZjswEJ0B82VZLLbDx1IDFHByqEW0qZyTYPXX6pOIMFbPw5iv6afJeg6QkIHQ2qBiRlkcYqH5RmmXoY8ggdIrC6f/rFuNMJHzue3A97Lkt3ln0EGFZaiMdpasKlEfovChZp+9o2x+JRgS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzJ8Bp+V2nX4aPQsVJG65DNXcLk8TsfMzZvmatgUCSY=;
 b=mun6b0zGUxH+jq2MQfOd7WoK+UhXtd1eyTjcB8GQFljVuhR3JIa4m31qh9kye7UX6D424flwb+6XFK/UNhHcC2CDoSg82uVYyxkWotfXfQm3hJePvEMYQjbgE6P2YR+Nw+Hv+fCIJaJ1dWxYABLIPKRklT68VhRbaVBmWWdHcANkEAqJqrFRXVYG1oSCkkxXY+pf4XqaG0DmIXWbVB4wNq7HDHbj1F7u8dLspRPdhq+IE5Fmpx34RFYt8ywuz7I/mu1DPhW/1YTtP6tyDZkAXw+L1p0lINL5uaZD3Veatv35tGAB25Y7dmhtCZsURxc1DcrYiOxHbkfoytoCWcGUwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS4PR12MB9705.namprd12.prod.outlook.com
 (2603:10b6:8:277::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:59:54 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 11:59:54 +0000
Date: Tue, 13 Oct 2026 08:59:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
Message-ID: <20261013115953.GP13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-17-aneesh.kumar@kernel.org>
 <sashiko-outbox-163687@kernel.org>
 <yq5atsmr44r6.fsf@kernel.org>
 <20261012130739.GM13920@nvidia.com>
 <yq5aecduq6i1.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aecduq6i1.fsf@kernel.org>
X-ClientProxiedBy: YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::26) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS4PR12MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: 81673fce-b2b1-4cc8-f59f-08df29217ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XPlWggt1C4cQqDUmMN4fcRFTyomHsYF+xNYuiBXPXJfnbfe9vOl59wkP5X8jwKrJtzncgy0FORePy20utJUXJBHCoZiMJHiFIFgEnwza/X7agylRxtr2j/gubbdofOBkVLJHK+e+U790gcl5JPV0h8NZsDtNNLjwDimfXdCn53K3RprALjX4H3T6VqEr7c4w0sg0a5bTPy+34YciAt0ggt/eLWRTkffX9lyp05UEHCM6qRXUo1CyxWp79Em2AIId7C8ysSMX1Q+Jdp/3hUYtKJX0cZ5eFzB+iXrx5adO8h9CJF3q6s5iQk/SuURGY1W5tMVcfEmq4TYluHODzsBa8zUZBTjhbn1/DMiwtpA+fLdNzn0/jpm1EFk+kZ4ybgBoOhZAN20XtUM2HtYndDVGkNn+oM/0CmbtvQv0QZkouW/cbZsTh/Zm7/lfPvuxbuWWfpWKm4mAS/VBgUtBUg/MYzJE1P+oCvrjOHceP79VSI8Vw4iiApd82DfMmmY30As6JSJmDcQ4cOfolXnXlMH27sqVfIlsZcNu8B48ScGTGb+E27/Hbpy1fZ6y+1+zjtb3j+YlOQMQUIADNVGlfE+MEk/junjaD5F8pCOVo4GcMISS6YTdNYQQ7EWjdOatC4IHXxwv6Ab1v49+6qeBy53vQK6Ji2DwsSMpISjW38W1oUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u2nyL2mDrfEktMshJXzv2Sfzkl6HWghkgyWh/rk8APhlQ34Hor2kbRMI7dsH?=
 =?us-ascii?Q?LJYpqOiSOWqIiu8I5+Dya4dYeLZHZGJrEBgy/pmZyo41DcNk08N2r8V4LIjF?=
 =?us-ascii?Q?s/0piOJ56/et/YODC18Ki0lNRSaAtAorYDSrnpYQLKUSmm9K3zFfhaK7S5wp?=
 =?us-ascii?Q?esLAJqH52TwkJBJ/ay8gEBpyr093qUenpC6+OntYSZftB4NeM9ySMeEmniEF?=
 =?us-ascii?Q?q//NiuzZYnlLVi0Kasr4am8QmarBIy+s7tfii4ZiiH2OlrL0LUk00X4bx6Nb?=
 =?us-ascii?Q?tRupAk+05woSvdmNBEj3OYhRxiRXBfYuo3BIkzdrvhLbgBjY1vBCNzpoGDJY?=
 =?us-ascii?Q?z01PHLylNpIU8ljrBAGbqZt+dhoqhc7zVhyzkS6DANLQbKA29WHlPXgb8or+?=
 =?us-ascii?Q?EzX4VBx+q2nUhRr7AIylwCa4mznxLVHxq4MbK2U5QmFqW4ORntdb1dEqK9Yl?=
 =?us-ascii?Q?KQuEAmGD1owIbjucCVNr/zXdDO7GeUrIe2AJQmIDmFvwLhrh4DC9E3kJld3M?=
 =?us-ascii?Q?0vjgAm7LEhDW50HrDhzalX7eKFrrm2mWM0/CgNw9TlQISramdLyRmC6LBZbI?=
 =?us-ascii?Q?VsUCzLeOeTCxkfJGiZt63Jg1flayOImnGawA5Wl6aE0TH7oGcIoL0krzmJFU?=
 =?us-ascii?Q?lLXuQKUW7CxzXxlYlTKG0hdRiq01KL458O34JgyjnFxfXMUimUKfq3REAXOU?=
 =?us-ascii?Q?BH7AooU2yUpV2s9flm3aWuLCOU37shp/cEIbZpz/N30Hjkhcbq+rJxVYsVeA?=
 =?us-ascii?Q?6xZTHOw6jxv9nQQD5FjASpuk13Tv8B1pgCl3wbWo9BMjpoe66AKqL/FvLGs9?=
 =?us-ascii?Q?yC8b3Pnd8+YPRgwYvZqrg6glw5SKu0aTuVB1Do/Lh3nAtArKMbdTnT5NEwHD?=
 =?us-ascii?Q?Ff1gj+mCrU685PldTcsjpORrGCvrzr3RicY4lC/H9bFdD6Jh1Ky0F6K7Vi9a?=
 =?us-ascii?Q?fFGw8BO9XRPupmlARnj1y9pW/w4BZlGbHs1tdEI6z2U+28QW42t1xGS8y5sh?=
 =?us-ascii?Q?Ay4MFyjow6eyVIkWrGeS3lurkzYETbT5hUXnnhc1A+PxGRmHS+OrjSwxUGg8?=
 =?us-ascii?Q?zDYCBhSltXxxyqt6EJ2Y80PTTXRM/JwPcTT/zLrDqqNp0BOS6atub9Ox1W+N?=
 =?us-ascii?Q?s1dV9FtOK8/z8TjecUTOgfY0bi0yvwgz6PvL+c4fMCm9C7rCGAhIdu0uCsWR?=
 =?us-ascii?Q?Q91+V9n4xUlp8iBaclR/G1d9sgx6a1J01Yg5l6jjEE9AiG9P7/8mM22qyTFk?=
 =?us-ascii?Q?zPQ/Cq2+jfmRTCg87oZMwRHeDvl8nNAQ97cahTt8scUSaHEFQp6NtaMlWzjS?=
 =?us-ascii?Q?I3thlZoabyYGC2xXjXE7eVkUgrPRYYP4r3V89EULNpDB2N1tEf+dqRZ3igQl?=
 =?us-ascii?Q?CXCrXq5yeYmC3eNfrLm68QfxQvHa+xtYb8sOBQhfKwx8+GQpKU2IGioDBSd0?=
 =?us-ascii?Q?X14H9B7ZNOdwh/lg7pLIik4/N689LSiZ8jhLWvQoTnRrbiDpWAA5zDHt8Q9N?=
 =?us-ascii?Q?+HOtPTgwJOUC1I2B3IL/WvqhhKbg0OSVsgTYBT3WIK0aH/ItjsTzB8p77S/g?=
 =?us-ascii?Q?N69f1W1wGr4Vvlt6N1BNwwBIEgllOlGW9ww4HSOrm8QFR7kd8gKZyEo37ylv?=
 =?us-ascii?Q?0pak1KCYS30w9r8DYaoAvyJy6lnsHAjjwk9ZCBax70jPE3C/A6m0UnyJUijb?=
 =?us-ascii?Q?xNKmW96sTlPY4QxbQlCs2O4wvLy5Zm+c3TPECjBWLPPdMOLD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81673fce-b2b1-4cc8-f59f-08df29217ead
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:59:54.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2WfcX+C6ijNj60wg8GOPhLp+Da3DSEHWXbzqxINd3sAPVWbqUdAs0I46IOGCDed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9705

On Tue, Oct 13, 2026 at 03:14:54PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Mon, Oct 12, 2026 at 03:31:17PM +0530, Aneesh Kumar K.V wrote:
> >
> >> With this series, vdevices hold a reference to their parent vIOMMU,
> >> which pins arm-cca-host. sysfs unbind is disabled, and the SMCCC
> >> provider device has no hot-unplug path.
> >
> > It probably needs some logic like vfio has to prevent unregister from
> > completing if there are active users. The module pin should prevent it
> > from ever triggering, but as a safety precaution.
> >
> 
> Are you suggesting that tsm_unregister() should return an error or wait,
> as device removal does? Returning an error would be much easier to
> implement by adding an unregistering flag to tsm_dev, set under
> pci_tsm_rwsem after checking all pf0->context_users counters.

I didn't check it closely but the usual flow is for 'unregister' to
wait until everything is done using it, possibly with a shootdown
mechanism.

I'm not sure we can implement a sane shootdown for iommufd's
consumption of the tsm, but we can at least do the wait.

Jason
