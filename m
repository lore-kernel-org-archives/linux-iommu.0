Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793278263;
	b=pA1cwN3smc3He0AoextAH37rhsH2sOg+UvhKnsXbmxGwQC7KyI0POStlltI4U8tarhJC
	 QUkW6w+IWKGUu/pPeJ3Jp6kwdOrlvkahcuhCn8wGwdMYw1iOBfkTdPO527wGacbYa3JRG
	 Z63U9mNiz1s2OM8uWGNkpExvqcmXJcTgdNKub2g4HW0vzTFeHcy+G3KaDRMJyxjpMo3qv
	 cYkVKL/y9vRkLIzmdElhBO/xcxJZsfeGJn0gi8hHvsMu+OoyD1tkRGYJbNQKTQ0nNGLV2
	 XvGlpO7A/xE9UNRJitjV0A4ffbs69VotrpzDBmTAIKjbmJBK8JHgzVU6gvu+cl3BboA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278263;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xJw01UFo4m9G5e/G5/+UZVXqQ8vUEhBi25GcP9A3jQ0=;
	b=Y/Z2ePUwvYEdvc+uMVgNyXvCNPF2eGZIgzaLUMljZ8fpzilE+ETKCHNliSJqn7pEaBcq
	 BynNLgN0OZV34dG/uDPe0AEooX4s8W6GqDQvkhg9DEESJ9YidWBq9gPLtdHxy/FmclL5k
	 ftJ8gMBQomGkfDE6lgLfDENcNH/oDMqmSTByP4RDMSuyzLcUqCK56uAImJ3ywwqV2GnrP
	 OWXjmYkzg1uwbGzJwm0pcsei35zfk93Xyd0DBq6Vbe2FnRTJd5Vf1uHGO2yoJ0nJNtqGF
	 b4Y+J6e5hsK6U63trIlncr2Dvp2ThyKqj7d42GDB3xsbMCqmqhZfoYrX97QBqntaqbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CdrcKsT4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.28
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317C606A31A;
	Thu, 29 Oct 2026 12:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F317C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CdrcKsT4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xlp7aDVDy/RL+BUUCxfY5oDEfaNEMuv88pcvLDTty0m3e6wTAGZbim8n/9lehdMDN1q0/UiE3mUjINTgofD6OghoQ9hbTbCOiWzNvVJ9wvJpfd59L0MYooSlDCUNKJ+KUKvl+4Xw0kIRMIxqHo+x3lRmT0GcEEUgWgNEdUzTJKUZKR+MMAe7+9M3hew/AocT13Yx4ZSim+/652NBG/LjaqEOsD2P/EXuo15PTo2gyUepRcKC62Q+4flxH6bSNvB7+XBN4oEfdUDDEhwmlqO7OMJem6CiyLJLmoVZC0sa6BtNRxz/cCuPUO5jSaNtmeQEvRX+2gBWIzrLuEcjpR0FIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJw01UFo4m9G5e/G5/+UZVXqQ8vUEhBi25GcP9A3jQ0=;
 b=MwyPEHa7sH5mr4U0ZSnpScB3y6mAihcWDxu4ikOK1s96MjkrMSOytkp/EapspcO4kkow/EI146CQiwF3lfwzR6RUxRHmw798rQ6ig89xN5DqNg9hUATIm+b7al6mCJXlOKOtVsZhUXkwdHj8fjrH56MtWJzvV71Tj/blfVqs7B4s4nhcaZ40lMI2+EARcwNxhwpto01ljpExYcS7B9F2NTEK/aOjWM61tYuJKvmA+rRhHpDp5B7GA+xt4yjEXsxtBu0EjW39ZwXfIqJ+5Bgp4WaG9WpppPjOKSiI0iJ8/elXY/SmrFf5CBTASVtAcSJuvVHqXXcrOJAUQtb6e8pPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJw01UFo4m9G5e/G5/+UZVXqQ8vUEhBi25GcP9A3jQ0=;
 b=CdrcKsT4wLUCXOVt+m9gOKre3sEQfL1W2vtV1fg3H7yHseSY/iAb2w7kHEzuMK+6Q8w+sRqHMAiS6yv7Meatl4gqFyEDzenHo6VuILsnwJ48OSuiJFjGAHYhrq60cc5BXMXq9918IIzeyUgPm9Qq1LQFblMpifyb++5GIaNM1aSTMte26GMRsDW2N40p6NIWj8o8Bu7qU/VylYZm8xqrP2CaXOHln8pUaXLyzypMZBM9osymGso13yOWMZyn03qcTYNoed8Xgp+/PIK++wSb6KBOXbJt0yupMZYTRlvnIFydFmlam3/p8gtfLZeu7Oge7mIx21AMq3Ks9AhUx0RljQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB6650.namprd12.prod.outlook.com
 (2603:10b6:208:3a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 12:50:56 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 12:50:56 +0000
Date: Thu, 29 Oct 2026 09:50:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
Message-ID: <20261029125054.GG3040767@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-17-aneesh.kumar@kernel.org>
 <sashiko-outbox-163687@kernel.org>
 <yq5atsmr44r6.fsf@kernel.org>
 <20261012130739.GM13920@nvidia.com>
 <yq5aecduq6i1.fsf@kernel.org>
 <20261013115953.GP13920@nvidia.com>
 <yq5a4ie4c1lw.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a4ie4c1lw.fsf@kernel.org>
X-ClientProxiedBy: BN9PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:408:112::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dd5ac2-55a7-4f36-5d79-08df35bb460a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|261028144727099003|261022075727099003|261026140227099003|11063799006|56012099006|261022105027099003|261021121427099003|10067099003|18002099003|261026121527099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wh0SNQjQ4DL23X2vxA7+7BJ+ZE1F6xF9gawTyMrgpoj1ROIruT7CWmKgXXpx/Krw3umlL4qt0852cJajSxA4hbcS/HQkbOi7RJnvvqYHfossHJMPDYcjA6dmAqr1fb+holkgVxON8wBhyiZn14D5Y3XHrCvTZs+kqschcZTBlDvdUMQRESPmAW3X0GNSgfk6mcWUaE9cVSu7Fvcu7Ndt8EwZTMp1qmqjjWYx5LfNBYO7B9eeOPEY9oJTAttgIPcX3EutLEdGqXqiiQ1u3ujv1q3noEjN2EsWUmI94xHiO2j8VXpp2qKdZxXDn0TS8DBG2pFbmW2vc1Wx6PcmZ88fFWVUeQA9rpZ2Fy1dT++Ztb5Q/APFnjkYJ6GBfMXqir4o1QQSWYxZtKo92wLZ5vPJeZKWN5vVH/pTvblO9tSU49Qi7y+zt1hU6GVGoE/knn7lZe3uS1cFclGWl8oD1syRceXU/LNPoxTt/RfIH9yQ75VfLOlMUgGF1owdbaxOJIpZCIbKdwzIL1JBcXACHu+7uFRiFnRybIEq92ByDZT8q6bJ5va3rsDHEEvrL/Oem0JCmKI/7OKnMHpJyhGAE7hP2q39AImWgDn2BbUx0saf5LRjJzfUkJl8O6xC4YRQpSpYJcoILYNVxlpslA1El1UkzQvbV5Zm6kcGkgDWXJQ8D4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(261028144727099003)(261022075727099003)(261026140227099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(261026121527099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iia2fooSiDOR/iJEOIAHXZODhMwdePpvoQfnkmg14mDLkilMrTbQ1Y3Ktuqz?=
 =?us-ascii?Q?KdN9GVveE3nQmGAZy8BpzaV3hebNC8O9iDZJqhue7wX+g9c+QGsZzv+J8QCY?=
 =?us-ascii?Q?TG5otcOCxWQcAWNpZscO7mur+7Cql3FyBI/Ms5TmidddxYWmT9xSi/IIDiLr?=
 =?us-ascii?Q?/I6HzDCYSVzF34o9nFOAWG64OAOxb2wji6MIlCO/xT5dnsnr0h7EPozEsrn9?=
 =?us-ascii?Q?vAEuw0f1noIpwuNe/yKtZWsQI67XC5COTGbRNo2ho0vQCitB4ENC8QFqdZjn?=
 =?us-ascii?Q?u0RlWO38p9Ll7q7D2mt+oQayuScuhC+73gfaiCYp9kPb+Z8VhGPd5FoVFY2F?=
 =?us-ascii?Q?7U7ZxihYLVBg3WUZoxWkT1mtifsLF2ZQAL4WqW4DGdn8BsS6d2UohUydrNdr?=
 =?us-ascii?Q?+nVoKNW9M6DsY1InplB7tgDN3pMcY8Zd7l7POMqnVSUaR2R8KItOcGmYiqvi?=
 =?us-ascii?Q?j8RGAZm7GZ5KQkp0hYTRYaqbNqZp1mLKzUs0B4EHgmTvDBmuQ9nU0vWzEW12?=
 =?us-ascii?Q?xEFfCMUhJgEFsRnesFlENxk13UGMTogFxBupYnhoNgorvOB1+kFcW0ozfA2Z?=
 =?us-ascii?Q?1ARs/hvJUvsRh1D5sYIFOlKq95qb48sfuvVKMexp+zqDEq3LKZ1Y8vDo82z0?=
 =?us-ascii?Q?SBN6w+xlgN/4Luqu3MsjRF8eGhcmsGSdmn4SJAha7TSyY11UJHHS1qzxPRkY?=
 =?us-ascii?Q?ytkHJOqT6uFxL68/hTsOtjR17I+1RoFoOIlenN8T/ds1k7DIIpXOy/YGH16/?=
 =?us-ascii?Q?HG+SzTnOUsNZouRQYD3RiTRpehQyGdMiIQYoKB0hHxPS1cs0dcZldTNJ4me4?=
 =?us-ascii?Q?QmQbqOHk5LwYxbaH/mqt4jAwQ18H6RLmqvNH4lm+7sf/MvhwX8h3FMm7DA0/?=
 =?us-ascii?Q?k8uKUp/lYvANzL3icQSJ2k+tuG0Limgp77NBpD3byDOj5++H4Jx0urzWh7xj?=
 =?us-ascii?Q?47hpneHrUOGtKnSS6Vnvb04wLJ6YBbCJRoO3CSWVFX7S+EvohpN90uEqjeAD?=
 =?us-ascii?Q?hfZS2JRxIcPgyBqCK3TmcMQ56ZVq2VgN+986bkhx1M3IbG7RorHIo5+IlNoy?=
 =?us-ascii?Q?KPjS7A8i2gwmRYlLB8WUOLqOcbaGpCz3uCFtW6UPGSUNmQKpn6BH5aYH3DwN?=
 =?us-ascii?Q?5w9vWo6GJZ0KBzdfRoxHwrXRi0g41qlmPe6rFeYBI3ztZpq8wgU7xI3k5359?=
 =?us-ascii?Q?fVBwZl2a6kIeWaa9+6jMrTvjbCpOpS6X/QHRy0gBhoZCGUKEiY+oQDjvQuil?=
 =?us-ascii?Q?52E0Z6rt5ABhoLZhZwdkTvrpsXypBeN3s60s3PgeGNYMpFYucWktxulrWBaM?=
 =?us-ascii?Q?pKaNzf2V9Bsyq9/g1eJd9+EU9wwYnANTJCQ3ZvvwRfacezVqJLXdmdw+7CHE?=
 =?us-ascii?Q?r+XdJL1Kzz4gnKB00uDRz8XKcBp80HKAOx2ruf+Tj0I9Ok5omq+PUAXcC2Ix?=
 =?us-ascii?Q?CU0rvRUOfbMw9EA+tkqOkA1lUGWTl0BWEl6Br3D5K/r9Tz2dhl1I+VHM+oZx?=
 =?us-ascii?Q?+fZvjBs0Zi/1Ii+ksJylb5ddwGKL067gTyuHFazRp6UokcN4hD+Q9SqJeZbp?=
 =?us-ascii?Q?5a/oyUZ/6c2nOnRs3IipH3BO2Lt2l1BPcD99nWdMR8HsQkAHuKSYDD+5aC38?=
 =?us-ascii?Q?zhs8Fkw3KRhv6SmFLveGoJ7o83mswXgpifaV7J1ge7keq7xMNWQtS0cTDdoi?=
 =?us-ascii?Q?sB0zn/IRB9Is6FF8STBeuOkmeN8bFYMhfmgtIP0vtniYWq3i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dd5ac2-55a7-4f36-5d79-08df35bb460a
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 12:50:56.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUpABz9H3Fu80YRbFrPQLAzcks5Yy8rPS1zinAXEXBDGLPif4wqBfiTghk9olrO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

On Thu, Oct 29, 2026 at 02:41:55PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Tue, Oct 13, 2026 at 03:14:54PM +0530, Aneesh Kumar K.V wrote:
> >> Jason Gunthorpe <jgg@nvidia.com> writes:
> >> 
> >> > On Mon, Oct 12, 2026 at 03:31:17PM +0530, Aneesh Kumar K.V wrote:
> >> >
> >> >> With this series, vdevices hold a reference to their parent vIOMMU,
> >> >> which pins arm-cca-host. sysfs unbind is disabled, and the SMCCC
> >> >> provider device has no hot-unplug path.
> >> >
> >> > It probably needs some logic like vfio has to prevent unregister from
> >> > completing if there are active users. The module pin should prevent it
> >> > from ever triggering, but as a safety precaution.
> >> >
> >> 
> >> Are you suggesting that tsm_unregister() should return an error or wait,
> >> as device removal does? Returning an error would be much easier to
> >> implement by adding an unregistering flag to tsm_dev, set under
> >> pci_tsm_rwsem after checking all pf0->context_users counters.
> >
> > I didn't check it closely but the usual flow is for 'unregister' to
> > wait until everything is done using it, possibly with a shootdown
> > mechanism.
> >
> > I'm not sure we can implement a sane shootdown for iommufd's
> > consumption of the tsm, but we can at least do the wait.
> >
> 
> This will require.
> 
> @@ -116,6 +119,13 @@ struct tsm_dev {
>  	struct device dev;
>  	int id;
>  	const struct pci_tsm_ops *pci_ops;
> +	/* Serializes user acquisition against unregister */
> +	struct mutex users_lock;
> +	/* Written under users_lock, read with READ_ONCE() by bus code. */
> +	bool unregistering;
> +	/* Registration reference plus users that must finish before teardown. */
> +	refcount_t users;
> +	struct completion users_drained;
>  };
>  
> 
> When a vIOMMU pins the tsm_dev, it must also increment users. This
> requires a new users_lock, since all existing locking is in pci_tsm.

I usually call this 'registration lock' and make it a rwsem.

Holding the read side of the 'regitration lock' means the driver
cannot be unbound during the critical region.

Then ontop of that you use a refcount and completion.

refcount can only be incr'd while holding the registration lock.

Teardown decrs the refcount, holds the write side of the registration
lock and waits for the completion. Read side is always try so it bails
once the write side is taken, preventing new refcount incrs.

Most things use the registration lock, but long lived things would
transition to the refcount.

> I can add this as a separate patch, and then we can decide whether to
> keep it. I wonder whether we can avoid this complexity, since the vIOMMU
> already pins the TSM backend module and we expect unregister to be
> called only from module_exit().

It is probably good practice to have a proper lifecycle scheme that
does not only involve module refcounting. It will be easier to
understand and use properly.

Jason
