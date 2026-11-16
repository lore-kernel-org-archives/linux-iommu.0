Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794872501;
	b=lSwe2gQKlSbT3vWV2vh8MWNdOHOGVhEgF8TPUBt2SVNu2mG2xwFVB8FNkFNUVggj6MhU
	 X8zpoyNWMpJj/gtH9qj0lTxNfCTXh9+He/pApnrC0onGCpP289jbD5xUlMoLWujObnl3i
	 NnaXzzquACbDvlfwQAegeD4uI2i418ylIgwDT37wiwLkM1Lffy5XP/yyXdq8qcbhEmXOu
	 W+r5NQ6AvfG7kvYj7t4k1INIIJeSJw8UzYP545AIL5ltdFjnD5oHvJphRITGjnuhpbxvZ
	 p9p1OB5jd2CtJ8djrtznNCNa+1JXYSKIjIh9r7rCPJWJ7cOyNwLkp/sTkSl/RswVBUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872501;
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
	bh=GyvRqTVRkvHTL9nbC8hZSGtKZILYefYx38wsBwCtD0I=;
	b=tTQjkwmto+NOCzIqtPnysnIWFODKUlzZKe3VL+T9biih7jPyLt7UKr1TKuQQbJVyJbht
	 4aWFSCW4OHWrVP1NBlDu7Z9eDsnEgqWT7UgR9IpQnkf+7Xjk/g8Y6JHAwJ237yJzNDG6J
	 mZNXISzNEztchpSWt5PRHs06MyuDuxzbRavZc08NQZWtEcre2WS14y7kq0hnrp5/XFX7c
	 k6+x7fJfvlaUepaaZE4pVf9uN4XqPR5IT7P5PQJA4K24lEQ61qip8nrR3WEmmE4KI4c1j
	 yDnrr0Bo+CErvA9x7nLtl5wqKEdqo5ETIoVSFUWlmaCI2hnFtrjasevinRt99dRjJDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pR7B5evR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.40
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF2606A31C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 23:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88DF2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pR7B5evR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c70k4/ghpOAZ1eR89IMs2T/w5ZsKLsNEo+oYnsefxZ2D1xgBEu1/v1+HdMI4vq4IgSYdBixBfkN7uA1D2NSKk/WZe7VWm4qAs4ROHo2qYYvsJxHYtM8o94MkN63hcdUXnqoE4u7ydSvLKF8sZ3SYGpIhU/txuPSdV6DNIv7eSt3fYQYR8K0T6b4A2qqKUOq0JPwf4oFuPfO9KEZ40IavlNWHZfwn8utXgrHkM8R8LwTfFXxsNNfgPLSHEnU1haArWJddLu7NP6QRdX7QvEqrzMLNCKoCUZSEB/C88DM2ZuHHqV3En+YLQaZAt7xtAkNLyu+XekdKl9wJDwi0ACmkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyvRqTVRkvHTL9nbC8hZSGtKZILYefYx38wsBwCtD0I=;
 b=KDnmxpFWCceMENp703+szPxMHSSNVfatVhJagDJv+h5nTcHsghEhWc+huUEZVPPZw8kcPO82PGTi9INUU3HLgaT6zzCNajSHgaXKPCTZVNg8tnLB4Ti5eC005nYM5XDhefEV/KSJjYt70HTcgSindnTMqLHH/K7a8pjDJl2zpUKz5Vqwsl0m6yJvPmw58Yp0ES9+khTkMiYxEJcgEhJ6L/peIS68tqeUWg4LlGZ9bMni9JLbgPOtrbby3zg7YsvlIbJIyf67gVvlUGpDcy78tCD7SX6UwsNOgm3j2VsW5xY7RIlu9jXY9Lrm4X32uNzJBJbHtvpcimpggmZ2hHXCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyvRqTVRkvHTL9nbC8hZSGtKZILYefYx38wsBwCtD0I=;
 b=pR7B5evRM43TPQZHmvPSmP56VRG7e+ORNJGXjSQIM7vX4guq8XBBia96gGdq3QspSq02XtuPuU1VLygf9fek8ZkCTdv528GquKOzdneQwr3y/fYYrCIsG6xAaxexJRKpfnh1qW4tZf5BhApZVeta9HmFapoeADmAd6svUDZ54SRRuufmj5snKDqNimgkgS32j3z4vFEbWq/Q30S+w1cO5YHDFsvomhGzHxu4gSLoSBjc2b1SLN6iB4OemKcoMoVSetgF27GKOf5LGpMWILcpGARs0F9216ivLKswByIOFSAaLbyAO02cWbfU+9P2MQ3Jg/EhTayzOENn7DOdFiap7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB8850.namprd12.prod.outlook.com
 (2603:10b6:610:167::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 23:41:32 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 23:41:32 +0000
Date: Mon, 16 Nov 2026 19:41:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <20261116234131.GF2245175@nvidia.com>
References: <20261112151039.2083705-1-praan@google.com>
 <avdO5cBwc/2ysstZ@nvidia.com>
 <avromFJ6opeGEcT_@google.com>
 <20261116130832.GC1850935@nvidia.com>
 <avtltxy9sp6cYiEP@google.com>
 <20261116202354.GE2245175@nvidia.com>
 <avtoJ88ELacDrquz@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avtoJ88ELacDrquz@google.com>
X-ClientProxiedBy: BN9PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:408:fb::8) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: e3cadefa-9c47-41ea-e952-08df443b24fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	90ktzLlDQ7JaRvKSwDNrKkOLletC2gVnWhwGf8T/95Rj43lHm3kCET3/05mGrZDc9/4yweuDVnDkmsOsUu7QSVlU+2r8EYXeAk/GPFt8J4oqds0jj7PRYY8kcYpGkBZZe0CU+AFGVy1+NkdDygPID2dH2BMrHFiKoaScdI5QsUTVNPPy4yuDK7eHqc+ItlSoJf7yUduGSYaZb1hs/RniAHRexvI1L7vQFU3vyZzTNPLWnwrZ4mzE5yOmBBhlySSyVr/wlGKGKX9xCu32hk0Fzpxr5ZEXJNKlVbA0LDahv0r0R1rtQOTjDyCbBohtSEpiBo+NswMO4xfYqr9lmf2PZn86eI1Q8lD7B73CvMQSv/iLYEL2y/cBCC9j3r1UtTqiJORJTAXZKtZIjO+ciq2bBzaUkrp46QWWyAx4JbB+IPPhxyuWh7ppd5F7CFnVEePmeDUCeX7JDgla5NIBh5RTTQmSS6C+w3g/6Syzt8oSAW4hq3CARXhcEZf+89XzDyk4rAESqWa8ntOyTaUqexEzQz4BHXkRio9ebAW3maJDutzqJoyYZGQojSFl+uAraXhF/+FY51yqV72kNFEvjzSM+KRmiprVAY1jcLn7IaexEgWafbqrgY8/L+eNbIlm0FR91fQDkGdEqr0kEPsaCvPqLoV4poOF0DBkJziKQGKLtFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqlMgrt5ziGWsTL5qpMewycCcpvryANraQdIOWRARst6R0GBTNXXiWvxI5Si?=
 =?us-ascii?Q?fZdGlNaZxDekqiQW5y2K9mZCxDKPRRs5FZhWEEuFCI8tO/uJ7zv2pPYLTuW+?=
 =?us-ascii?Q?tmYv/3w0HCV0eO+OAIy9tZQkksUW4SPhZUH8c/TzOHoxp51QP0oGCagIEPXM?=
 =?us-ascii?Q?nMZYsfm1Q4BrsJOAqXuLm9lq0ZswmoJisCuhJSoouP22XJROZvIw5rJsZ+uY?=
 =?us-ascii?Q?Sb4qeDbqjfJhRNSy0hXrcOIQ+XlhW0ZaLiB+INqcWa6N91Ze6Zi6JanFcekg?=
 =?us-ascii?Q?wEsESRGP8F+/dE0hxwfCQYfvwPXPL2jq0SFSboYqrfMmrM+ctICxjeFmpv5A?=
 =?us-ascii?Q?54N55qdXHuWYQpddmouF3w3wZo52XS6WjjfrB6Iy46sg5k17GBTff0xswEob?=
 =?us-ascii?Q?MaOIKPr/7GEA5dF1fB7+2Ldt4AlFGo9ydsnPY8RlopbL5HXBGU+vdfsFsHD7?=
 =?us-ascii?Q?5xjbthazQWsPWn0jnyLsrjOZTJ9A6vkT0xcCRUPODWtIuRW22UoEcRaix6LT?=
 =?us-ascii?Q?kjaEGnHlduB05X2PE04W2HmhFSoMZDoNIbiuRnD46ClEdPkn0CezpN2H/N1c?=
 =?us-ascii?Q?m487acfDBtsKv0PwVqCgjxyvaRY6oBxt4E32Dq2gcX+bF21flkncmIEEzGsA?=
 =?us-ascii?Q?uBRSU3l71e2TUIflp2HMIY9iUleunXZ+P4hC+bXVyY+V0sRqgHyzquvo0QPF?=
 =?us-ascii?Q?Qq4QVbkfzz9714iVjYAckUuwHRruAmBbVDV4+OUEPus47LfX3ZXuGTftvjg5?=
 =?us-ascii?Q?eXQmWO/enrj0sBp2f7WDjIxag9qlN3O/HNDFvWW29cerhEo5BDizafbxAoJl?=
 =?us-ascii?Q?SlBx1IN7G+WZ0Bf0gPtyRmVzzhy/b66YfpIycA77iFAk0ZImOzBC0/wW2Ao3?=
 =?us-ascii?Q?a43rmB+pZlBYwHKBsg28B/PbrI1y+f2iqEBja5FpthTvqafj6coKIFb1Ivhc?=
 =?us-ascii?Q?uttTBb+V7Qh1du5EorKdVjIeywoIoek16ec1bqHb8bXEcsrBq26Ni2HWNJdg?=
 =?us-ascii?Q?KxCPbXkMHcQLWQlnP2cwQd+qkklkAvNH3MZbTtnTIq6YXspmrcyOz8EOjFPc?=
 =?us-ascii?Q?s5VMU1ys0bffu/iIBijalX8e9m12/emTwCi3MLt4kr8V2qBIMc/jKOeAeg7y?=
 =?us-ascii?Q?LYyh1RcrKlB2yO5T2n5AcJsJSq+PwGf1bqRkpaGkaOAbo2r8GuydAW5+RAIT?=
 =?us-ascii?Q?bSPGG/rk1yaFq3PJobG9K85HTqYPzRETIiVvJafsvpkBqOe4AczAz5w6qBkI?=
 =?us-ascii?Q?XNJh0sn6n0uBwsWUCLLc9/eaaEdIgz2h6Q+K+TY+tL3miKhFNwk8hrtyBO1O?=
 =?us-ascii?Q?WLiv4dnKLUZd6VQYoNqtG7B6qkOd0D+8xGETph2Sg0nkpJCRYF5LzCC++d8I?=
 =?us-ascii?Q?OjR6acdGwG+5SYH3Cb3sBfmQFOlbmsJeRY8HTtY/b5Gt4SSPByviyavbG/iU?=
 =?us-ascii?Q?n/BfK3ARRzE44Q5mnJnhY/7YB+c3XszGHxKWGXlDkXvUYnpssKWWH+koCWWH?=
 =?us-ascii?Q?o4hcrS/O7YZ6rff98OFb1dmyrtMO1gHPYUJZaUORHS4qJIgTdk28LFWI+w0V?=
 =?us-ascii?Q?JewtzD1cxA1MfoloySFs351+gsjRvUqFWrby8TQMFyaIyT2Ns81sWgbXw0nT?=
 =?us-ascii?Q?wEnO2iWXOGgDKrrFpNEfto9k+Pn6vNuILWHpXoCTKRl5lZ7bZeyzAyff81aA?=
 =?us-ascii?Q?tH5WHXP2n8+iuoK2cJcvQJlPKfNdW97Z6TNBg8RJlb8Yfm62YVYvtne4gaK7?=
 =?us-ascii?Q?H+zoLEzD1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cadefa-9c47-41ea-e952-08df443b24fc
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 23:41:32.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Gp0TF3yvZuvnlUrtijt+uGnQI8GtDVZzbi60WirvIqxc4U1vjFibBJ1cJfYrFvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On Mon, Nov 16, 2026 at 08:31:35PM +0000, Pranjal Shrivastava wrote:
> > > Also, the selftests check exactly that [2]. An unsupported data_type gets
> > > -EINVAL from the drivers today, not -EOPNOTSUPP (happy to switch if you
> > > prefer).
> > 
> > EINVAL should only mean that the data inside the struct is
> > invalid, but everything else is understood. If the enum itself is not
> > known that has to be EOPNOTSUPP
> > 
> 
> I see! I'll respin the patch to return -EOPNOTSUPP for an unknown
> data_type (copy helpers, intel/selftest invalidation ops and the
> selftests) and fix the uAPI comment to say the probe should look for
> -EOPNOTSUPP. Does that sound fine?

Yes

Jason
