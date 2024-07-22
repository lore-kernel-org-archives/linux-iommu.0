Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703A134B6
	for <iommu@lists.linux.dev>; Mon, 22 Jul 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663708; cv=fail; b=D6y0FF77COKJvfd/HklRGRdEoPEWkZsiaZld+iVKAvoBnM9ctZ9lUwKVDqAS1tL7UL54+skR7okfhR6XKP1Meq+zFX+CrL77YDPwfV/RM/dCnPTRQ+cbzBh0WGxsvCa/znO6NfMGTuktxjq7AUdF5ZD6oPCCqO6V23VjCZHQfCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663708; c=relaxed/simple;
	bh=lrmqCng8L8nv+4+KZo82V/Z5pfZbNcIKG83W2yLVQ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sBeeOtT2r/GotWSjM51qwNEW9ihRYx+9fxDC1I7wR4ClKLRw729iyOFg7KlOZGENTUVaB156kVyoRZo9z/KpOJzXwjogppYa3OH2CylA3PLxvof51oJF0GT93ewn9Lx1Riw5HTzKESDY1+6aXspF1ht+kq5o266xPIo8jWn91B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MFP1fq8y; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MFP1fq8y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4NrD+u2YyfDJoV6JpaODKQ/MMNHOemEFS1hbB3yEqz/qDyfDNgbrK5RUR6r2SnXUhrJaiP8AfqpQswLLIZZ9ye1w786tZFSmv+BwvV1bf5KosQLdC4/FMIiuLIcrJz63k42E/Rc2SKPMmDDI1RrRODgp77g4IU8QWuA0iQ06XrGKqlAGjbDifD3S1Ut/1OU8ear4/Zn0u1R9/fZ87jYhIouGxTESVpRbisFjLZ+HyIJW0Gr9C4aQLCjpHsGiXDcEYgtKQsu1dAcOp96KwQApAZGtSTwwR91+4TE5sKysxPL8RKFBrGDBYdGABwI+VHYZshxoTtDxyYH+VwhOqtV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X0i/RE1Js0wkLI9ofLbk2NADeWmIWc2x4papTBsmPY=;
 b=xoqJeL3DwjzKO62eLI1NVamuPnEGNEzlEXd6fz4BA2bgSvSwM4/lKVnrrfy4mCVZXHPqXMqArIqc/NOz49m/ndEj5CbKVJZCPoVbY8Gef37hvnSuknrzVAnpsd5e8hkd07ZKY9JOo4rotAJk7m1p1Vw/7mykN8kSghjV/ya0w4iBCqnFd1hc8nbTpGkrvXLQZdyDxY0JDvJ4F1S61iDNirlil4X+U6gT0j4dg41KawouQKLDk44CGxBQ6dtRwR6Y7wJ6/uaseiA4egZR7sIjzltxIc/VaRPCAvUcWL/Uwqp3sBfZIHc3Y7+kaQ9/ldpf7ltacuuydJ0OrhiTI3jWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X0i/RE1Js0wkLI9ofLbk2NADeWmIWc2x4papTBsmPY=;
 b=MFP1fq8ynpbGAp3pXUt/5bdCnSBW3yeglwA5QOyf4AiNYbWL6aUkc7Ynnpu8eB5t4aZnZZyVz1qutGhpWU3o5id32ckGaBAovLM3lw6X28bOheWE0mk2GiSl1jcX05pfs5/j7UuvgqdGAwlP7BxegiKLYDuTlREORr0aL8eUydlYsRPabnaUbfuOwPGl4fOJs/NZZLL+wwBIhFBim/ccM7JDWp6bToQJr/tJ5tIp8TpoxyJllEjkvw217VvqJdJp6WCsMKskpL0JPzRFlp1qRa1xOu1k2k5zK12SjNddEQaqLBqYhAYeSsWUToYASI/h4vOwG/BYmjtwyqXu12vI9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 22 Jul
 2024 15:55:02 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 15:55:02 +0000
Date: Mon, 22 Jul 2024 12:55:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 0/4] iommufd live update
Message-ID: <20240722155500.GI3371438@nvidia.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BL1PR13CA0373.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 594f288d-2919-4a86-6ed4-08dcaa66a5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UVjC4TLAkYPe4G6JNqHJ5l+nPOGpQFVojWwGoaqk/jVO5Ai+/b2SMesUoxwh?=
 =?us-ascii?Q?PRRQZopUsmZtrUf9VQGC9S5ckayWXesjChYa6jP8nIC3r6drMoqxYSdObaF9?=
 =?us-ascii?Q?Q5skNtNF2vhx7Y/ZD7oDmzWulA99lu4H9363zqay1xWmJOZlURPN2uuDq+FM?=
 =?us-ascii?Q?zlV0WxHOkbuXNmrC5TmWIgl+o+WdFQo5ZQ1lqICUkDNnj7AOBqy5uNG9jn5n?=
 =?us-ascii?Q?05htXPh4SQfRHhg+iGBm5nwlDdsv7mLkug3e4PYDDNfAe8gltxWCCfif5VKd?=
 =?us-ascii?Q?2p0xA9eKu+RCkZkKo2ZLwRbyKKkwTN40FsKdlsaRXv8XSGuidvGs4hGaLZ5A?=
 =?us-ascii?Q?2WHctOURjndDI7ZEnBJ9HaR+15C51otazt2em+DaFBTIr0OaGgoXAK+TV1xi?=
 =?us-ascii?Q?+4XSXsLBft3VjkFPRiFbPDh2WdXRE7O8CNSh8UT7b4zMXSShnqLRH3ptPIUf?=
 =?us-ascii?Q?IwH7GZU/szMzZdGMmS5N3Nd2q66a97R5Teu840/XsQ4oyWDws/rVQGMyHH/x?=
 =?us-ascii?Q?/vKOZ/J9m4zDlmlb8NNTQfpHh9lEkk0NGZE9/CrGLO4YdlT8f3D1DbQAtikO?=
 =?us-ascii?Q?ED2y6SoquEDPBu1AltN3zVnskAlghY9LfRip41yV2Av7aw2JfwfsxKlLM2JZ?=
 =?us-ascii?Q?Tex1c5bObNUr17gA99IOfT3u6Jxe1rMr31JLT1ESEEONydWuwk+LBCdIhgbE?=
 =?us-ascii?Q?keOg7ut+VOY3R4gUF0BygmbFpvIbdLtCEHi5I/8p7Wklo8CKUyXLRKfCs4wk?=
 =?us-ascii?Q?iTLLlA7fOBlOzUy+dH1s5vAVHdyWVv/F3SsGZ81afvSHEXCd7xkiMLXy4xM9?=
 =?us-ascii?Q?xHQX3FL5H0/utjCC1FlRRZx1sfaS4EjccfyJ94U46EU3niHTRvEgI76tPD5c?=
 =?us-ascii?Q?PTTRNBKn9hN9H1cUbZf2z0bygfdmoKBUv3p7lsW9Rhnvqs1nr3VIYkt8u9VW?=
 =?us-ascii?Q?++lwybgVfod7DEbc2pEeJ1o1JLnNtrUE1rKBx+cmwOrDPGrVzUflzphKLiAF?=
 =?us-ascii?Q?3y59OlEcbUEvzXCeurbYeB6gmsxGmFhLTYvWgx9u0QI6ViQKtjfSwZPccWMA?=
 =?us-ascii?Q?bkVIqLecWlNsa9NwNyZhAwB5ob2pIyg3Kl65+9X7g6NWYTY8YpvpWbxxJz8k?=
 =?us-ascii?Q?RwM4oGTVEYacTu2QPAHfPUhsoWl4zy86M3km6vqPggut4vqpUzMAKx8H+asN?=
 =?us-ascii?Q?HSRYDxCTzZMFspRh2/6rvTegJG1x7hWMW450ujH0obVvyH7MFHhKwXl2wpOB?=
 =?us-ascii?Q?o1Ijj1mVVchRA3zPwh8udTv/gLu60htRllb96Cr1P4g5Yi8vTz62DarBDtJH?=
 =?us-ascii?Q?JtY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mazidbqRE7OmCWOrEet62PPli+6aCxkUXi9zyvv0zP+SUJLX3bmGdGyXjXR?=
 =?us-ascii?Q?kGePz/M2X87BSJw7XoJl418pSLvZIgrzyKxUiMBb3MNier78N/vBgcqorvE0?=
 =?us-ascii?Q?+oVRiGeaGbHfhd1BU7StrvdcD8xUbrDSZslL3OIOTTbzsQHoC3Lp9TpG+XJN?=
 =?us-ascii?Q?JXAo9BwMebIHr3iRUfdS0mZlJvi4WEmPkG0G72wKZ4wjhNirAS6L4nLCf0MG?=
 =?us-ascii?Q?htjGGpT5gFOtlSg6//N5z9GaH/Ugo8i7m+CHELqRrzPgQKXoQ3Bb6WyHeo6M?=
 =?us-ascii?Q?2hi6CZRAJ0H9ejM7qqMfTrm+r0AsQNu0ARJs79tbIdrIsDMVhv44tlAxNVsi?=
 =?us-ascii?Q?XhdRfh3YLIAbeEk2U7WlqbyVsfZr9/oGLP4p8lxxGFW2DXiXRkV+aSUhOZ6L?=
 =?us-ascii?Q?XiYaIIdbtotmxjww0If0JfaMfQz/1eG1+lVFO1+UKqrJ/9ok2Cb5e6WSxcug?=
 =?us-ascii?Q?ls5NJ20v9LPJIMDTLr7vPOpeEg2hythiKSV1yrLptnlPLXZwrDPu6PXAr+BF?=
 =?us-ascii?Q?PsaS3jy3m94pvrLE24uqB0s72aYHDrT6OGYySnCvxGYZ7WNrgZsJZdgx3ija?=
 =?us-ascii?Q?xgoIq9i/W0CO7Of5JynUkwGTnH6cAnr4lT2tOcXn95X7Pl29atKZvGQcuPm7?=
 =?us-ascii?Q?+43PABglcp58P3tfVEjd6xWU6ytcLgkwfKSQYaCzMU/nu9asGYBJ7okjHUwE?=
 =?us-ascii?Q?m52ajS4vrOiG3OJYekOEztIq5JLDACpSYvThRDXsjzH2Vw4tsIsGvCcMQFXR?=
 =?us-ascii?Q?52udkJxeVU2T6z5bR0BmisFGUfPv1ojmG8h3bneCs3iG0tkbko0LpaPP/eHB?=
 =?us-ascii?Q?AVQYtc38mkuE+QJ2RuI6o4IzwLi94Oj2kCNJ2mGwARs/hLBVYKrroRvHaH1w?=
 =?us-ascii?Q?v4x5LDllHrhkmSa+TrYPCJAzZOlzwnHwTChXHX41L+GG2Lrp+4c3QOP5ev9l?=
 =?us-ascii?Q?rrxUdt8wgXmINNr8ia/sOEIbRTi1zKlzibdo/+uosROWWI3CbHuLa94/WRX9?=
 =?us-ascii?Q?MXVd0HStR/YXl33zu+7g0nNobiW3It6RKATS3wCEbKRdCX4qoMnmXw3195EF?=
 =?us-ascii?Q?bU0FU2I3o6O8CmlYpS0vvAwo5t0dekiZ1r0qLWXzz9DR4JnSZgsK87IzaDGT?=
 =?us-ascii?Q?qyxbBsAtfR+UAE/JOS7sriEffsPUX0p9cGbE4bOu2k8kNiQFtJ5b67f0sqOD?=
 =?us-ascii?Q?1irk4meOUcG3Tomp8xSIJVtV0T7afKzfFQrNDGcj4ZWtOiop3qfVxIiI90ad?=
 =?us-ascii?Q?gdQG5E8iMfRgTqNSsxilR6e4Yj1AzHSaSNtCRy6TuQX3afjtTP764Yw5ykFJ?=
 =?us-ascii?Q?yw/teTYwUYYrca4mjqmJ0lenju6lkAOuOQrhNkJ1jA6n2GZW+Htsn41vnAvo?=
 =?us-ascii?Q?tM2sEmbhpUgtztOQUbR+47m5KwXkfmpe6q+R9th4OcPAtaDmTV4yKVaRoyVa?=
 =?us-ascii?Q?UMGvGznSG61qa3G877uvV/7HTj1tD6pMMDde6qsm7Ev+nrMVhUeKXyKfexKy?=
 =?us-ascii?Q?zhOgqNO1F3sR4UG5Ec4nwcy4UKHffLUaqrbHhsCeWdVLB0ftYQybKewes2dU?=
 =?us-ascii?Q?ytO+RwuhT8iR3N0pdwM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594f288d-2919-4a86-6ed4-08dcaa66a5ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:55:02.4093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReDIpQivKoi+NV5lpAxzAZg9sNGcK5mo3fHQxG6Mmg5TsgK/0Mb9DIlTatakN4JY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
> Live update is a technique wherein an application saves its state, launches
> an updated version of itself, and restores its state.  Clients of the
> application experience a brief suspension of service, on the order of
> 100's of milliseconds, but are otherwise unaffected.
> 
> Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
> of an iommufd device to be transferred from one process to another.  The
> application is responsible for transferring the device descriptor to the new
> process, eg either by preservation across fork and exec or via SCM_RIGHTS.

It seems Ok to me, I'm glad it worked out for you

But have you considered using something like the new
memfd_pin_folios() system so that iommufd is bound to the FDs backing
the memory instead of VMAs?

https://lore.kernel.org/all/20240624063952.1572359-1-vivek.kasireddy@intel.com/

I've been expecting to add support for that, but does it help this scenario?

Jason
