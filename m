Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA71CCEEB
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361049; cv=fail; b=O5QQ8jwYFXiKRZ7Sahn++y+1fEGlkv19N0jOd3ois09m8B7Ld7P6WK3xQkG/JC3zOI9WiMX8FG4mGQK3DmfYLiqfmOCeu2FOOdZntFAUhecPfPupWcC4fNwM9YNwjYK7vvWOq34UJUvBTdAfsO/n3MA9+FMuL5JStuAsMDo6W/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361049; c=relaxed/simple;
	bh=FOIm5DZm63llGx5E1Tz19XwXGoDp5M3qgFLsBevcSjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MFnwEzBZBxDAxpGO594OofjdAyWYnRQlLlrElmpdE9c/0XaSqdBC7OYAm8M7NNbfDiMuej15jXD8A9BpACdumAH/ntlD9P75H0CVzluUZ7arbKw+poiRY4PzflYKSsV9WMAJkgFqapTsBDkAqDi91FbAguUrq7WMQgW4m+0b3mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9w2KHHZ; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9w2KHHZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYJELx8769sd3tYypbDbtwee0v3EqDsz+wC0qNV+7CzbaKRRtnirSnKF8Rebp7h8QawEOPifEWU7DZnNMbVyY1TbqLxGiBlmGPUx0cb5P7It/HSKtKxwskHBtABYrEFC3dSOAu3KI1evY1eYcNj3AZn2QsIdAqPohgaIBRem1gPbE373KhszuXejJTHX+eWDxwt8Jg2L5IjTpLeLw3UPnUJVfmKibpPTHl9L2EciP/ees5xk/x+8CS1ZUErDTz2I3FcMq3G0R/d+cWlItkcb7tSewD7BFhiGAzK7PZp4+2K+mzeZn+3MxocBCexIMa4WDiQ5Jl9NY141aTOgFUBXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMGQAFSK+SO19zzrUicmmf7/rStfm9Mxg+bYl0/DYq4=;
 b=ui1TuD9mwmxKSgnIiVbHtt5lfCVPzbKu4rovRSOyJhP4y+KiOG38267tZxmSeH0/h93TmBelKFFvCiJzVwbuYqGPDUmZ0R+urZyO5nte21xjMaCESe5dIrquaj35UrlxZtsi2aAP5Li6Od9s/PftquULMAL/KXko8YYRgMSZD8yFK3BLAnYUSak+Wad4VMqHwuMu5Ec+Q2uwexTzk773z+OORrDBGmIT6OuNtZc0lpQKVmmIiRAR4hp53blt9oLn4hBXJ3BqQn/mpQRDHEak3j+4eY6nsys/juVYPn9C7KUCTcq+0LQADPy/ChhN9FZH0zPQMuY3ARoRswQQF3F91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMGQAFSK+SO19zzrUicmmf7/rStfm9Mxg+bYl0/DYq4=;
 b=Y9w2KHHZbB+xUpy7R9LbOqfKEEKHTOW/Udal6wVHDglgoLtYWqW16dYhzuJ7WvHq9zlPV5gl7nbUSudtqiFiOsWLJTZX9yC9K33QzCUhbrcdYzs5YSr8/xbU8UA7iAqeDqRVDgZasyPpqNz8nsJP0fXf3sHdTdG0PZB9pjyR+CrB5u+paWRiHEieTB5eaDGht2RuEuKgYJ0OaleyVg9MTUtXCn/PkY2K4gTL95xJ4MedOk33P86fq+jl8eoqfxJy3yA3ViXnuMyC4hQszLmzHGMkyKkanBILnUdFDZMviOZOZ+OKoEWfagdKU3XzTm8+SGppJR+rFIon573qQBkV8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 21:10:41 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 21:10:40 +0000
Date: Thu, 22 Aug 2024 18:10:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 0/4] iommufd live update
Message-ID: <20240822211039.GY3773488@nvidia.com>
References: <20240722155500.GI3371438@nvidia.com>
 <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
 <20240806125602.GJ478300@nvidia.com>
 <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
 <20240808195252.GE8378@nvidia.com>
 <53e7ab6b-9419-4808-b429-a88faeb3f6a7@oracle.com>
 <20240819145908.GH2032816@nvidia.com>
 <ffa07fb2-6554-40cc-8af6-e6b3a2cfacdc@oracle.com>
 <20240821180400.GM3773488@nvidia.com>
 <1fd5610b-998b-438a-8959-2dc7f3ed8afa@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd5610b-998b-438a-8959-2dc7f3ed8afa@oracle.com>
X-ClientProxiedBy: MN0PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:208:530::30) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2cdd7b-4ec6-4dcf-0b84-08dcc2eee08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GNY1BL+z1xZ8XEjObJaYPXsUTy1uBdEt6kmbcF4ddbQeWdAa97T73PQ/xDlI?=
 =?us-ascii?Q?dqQzELeUzl5kWPVp1b8ljM8dw/GvHAW+2z2+efX8+x6i2V1O85Z8Zorqd70C?=
 =?us-ascii?Q?CGIqjnhoV7KqwwveN2dcZrAd6AHZlJB00SCclr2KmNwNbAtnjGDDWNFcBXPk?=
 =?us-ascii?Q?+P3e8SsOLm0ncGheP6NWe0ZhagUcvS8C/mZ1iw4VMgp6jHaKzpGrdOXRIUeP?=
 =?us-ascii?Q?ieKzllhWb5WNCmk3AX0tgO+f/4/Jm21JsvNslEB8GClUSWKKD8uk4czF2Hjx?=
 =?us-ascii?Q?Kmzs1lCKCvx6OhBEJWNGEi9VyvXafBJ3gmvCYxkhfUcGlx0/dk4Mq/PyeQWG?=
 =?us-ascii?Q?HiypMuluuKl+2qIhd/5VtkPh4lWxpwYOw18JtdwYse7WDJsmIvcQiKGi/cLC?=
 =?us-ascii?Q?gCZhuKf7RSWb4k4Z7PfYKsTdhI0Qd0N2YtdwHZP6fQICVArsYBSGdfHhCyRo?=
 =?us-ascii?Q?lJizbZEydy6V7VWXm79wO7CyVdK0XuLxmJCYdNXz+zPCh9UC/E6jzSWQTlCd?=
 =?us-ascii?Q?sIgKMvvembdFxLN+dPI59AwBtraYNU/A8fgbm/XC/FxMuDeiDobsjvNRsjBr?=
 =?us-ascii?Q?Ypo57O8eswNj2hvoMG7qR6b3JqDIW6JcyvKBmHHYinPI5KAopqu5yZ3++zIA?=
 =?us-ascii?Q?y7RZoL2BqfvfYGs3oQqQZXtD+6tD+IU+Lrd3vxt2tBQ8wKr23lix3ci6/2YP?=
 =?us-ascii?Q?2MgC9xMqCVcrLX65nw2UvL6huSuyMwNR5LVBQ8IfPTVuFzRoQBB5gGdyr4Xz?=
 =?us-ascii?Q?SX2LUnkkxWlfetJlJw1yaN8eIu+BX/w4b4590puKJr66g7htAY4jCIAgOAr9?=
 =?us-ascii?Q?bbVg0FBFZErBi01Ni8rojN0KYPd9Sv1tf0JwX/RO3jwAgj19+6XnohYtJoM9?=
 =?us-ascii?Q?KMKmrSY2L/jPfpedFS7wp0iw66BtRUKh41RJ9S02mjD+cbYlXkIcScNiQFyA?=
 =?us-ascii?Q?BO+9I0MT09KHE/mfHWo+Ce7rDT84MeziFlXlPswK5S5W0Qk0VHftAsW+hy/1?=
 =?us-ascii?Q?AA+ghs6P3Gr9dn6TBodsd60V4uMIMev6NUffoFFHCOAlK8Sc8cNxnvy9p7Ut?=
 =?us-ascii?Q?bEtkMzauJ952e0ktYJEoYpYF5v6U9ZSX9t14xxDmPp6mnhd1PrKqEqYf2aeE?=
 =?us-ascii?Q?8hbUdJdBi6AeLaJiGfyCsc3/Hjcb4ZRbPuNmXT7nMBXsvYKupYuwqo+FH0W7?=
 =?us-ascii?Q?1tYkjUTZKcGaDKHf5noHfml81ZF6f2L3gzSkrEcYY7mA6rIyjOpr4XW8Y3/0?=
 =?us-ascii?Q?IKz+yjMMJbOtSPpdlCYK3MVVfn5ENHa5aPocsvL8V6Wg9lLIe6mmPgdCqbXm?=
 =?us-ascii?Q?FIuGyhQeyqgmgvmSWE7V+HoJk3GaedWhLxnEV8k9S/cK6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/dbBpgnAdINSyHn5Z5zOhcgqJLBpdrR6zmr2MDzlMeObDn1H/k4889URvUOi?=
 =?us-ascii?Q?Nqb95dPig/0wyOvUQj1C0rvhX8GXfgNSVRrUR/Fmk1VSoGqSD/bUQiMCdatc?=
 =?us-ascii?Q?fu56JZSzxNSlm/Ri2o6lfiM9CFq8XaFWhgkGNNCpC+KZw05qOm6XtDmid5bf?=
 =?us-ascii?Q?glw6dZnbSvZBjQS3iQOAhT5TQILsrZWnX4hjWJB8G05R8CIAwZDvAU+9XcNp?=
 =?us-ascii?Q?Re4ZqBmqo94ZThBW9tl/yAEPaCSgAXknexUnVNOY7QdWWjtUj6w2PJo5Oj5p?=
 =?us-ascii?Q?iPcChGLQ1rMltninaISAfBL4U2ijev09p/KuglEJX2fo6O0HgxPb8UA3ZlZj?=
 =?us-ascii?Q?Xa2myzok0satFQp8YXQAxzByQVUcln5SE+Z2DIQO8lCBuUeuVB8ALAgFTUvD?=
 =?us-ascii?Q?PSN5dhdFiBokZEES4rWT0e09ho0FrDgVCS744wRaVXfE7XfcNaceNwvRNDDY?=
 =?us-ascii?Q?865NkxD52gWaThVV7pAr16dRnfoOUMDVAwDtliXVh9EzZ4TtbSyzM/gSTtdk?=
 =?us-ascii?Q?zTsGjgDyEIkf9MyHTZ75Fqm61sTx+h2R99a+NR+jzAQ8AzOVZhYrIYSmfuHo?=
 =?us-ascii?Q?KWn4opNKQrC/fvcGUZCISBXUkrU9wZBvwXR/qoG0H1G2JMFDl8fdzZCpdX9d?=
 =?us-ascii?Q?Y0csrRRyLYmsmP7MZJnJveHPakPlmTArDG3z7e0QOnuouuVdybgkM8krbD+n?=
 =?us-ascii?Q?nLJZKin5sKp/cYnG33PAjmysenWBlXEn0c4H3jKGu6uAe9AbLoMxPBf70zYL?=
 =?us-ascii?Q?r5W+PLhqXKoOFpTlBuxtxGr8ZDTO7ExUy2mhmhQgeeA6lKeh3tjlv7NiGfwC?=
 =?us-ascii?Q?Pqwu1wasYzH8c2x7/fSZj/t19JYKr067efdBghABDe9RyqJvZ32RgQfWQA0m?=
 =?us-ascii?Q?6HcxluxfpEo9bJgcZoKBfGj4a5GdsPiXiNmL273rEj9/GGE/N1GG8O03FayW?=
 =?us-ascii?Q?Q1fRJKMDRlGlaNQndM0vy6V3a+ZETUd+k84ivSbJMXDaEFjhCN7t0oltpYrr?=
 =?us-ascii?Q?GlaiBwJekCNXRJN9tt7mdF3LhscDbRVLy31GBw44MpjjaWdxwcq3dTxG0cK5?=
 =?us-ascii?Q?l15uo2+6VEdzPdL79e+IqrBxQ4qMNL3qJvxVNUWS9BX3F1KuvgB7LbVacJKe?=
 =?us-ascii?Q?S1dP9ZkGu1c6e3xgfo3pCpa+UPfI4eNYUQi3OFQYL6ysVpal/2oydsT/pn+I?=
 =?us-ascii?Q?1RbGdK8s3jMaYgtTckch/Q0ygwphKlHmVUUK/J5vsZFUhOaCf2eAUIQsbN87?=
 =?us-ascii?Q?Mj/QD5KYpaHzQPo8rXi6eoLHm4DbiFpMSr0XM0gRD9z/UlYdP7mDas96DWMZ?=
 =?us-ascii?Q?aU2WeL2ddYpPrM/3a22v6BqI7f3mJYQncOFzk+Tm75mD7wuz+YC1RgiDdT+h?=
 =?us-ascii?Q?TT2pNHITfD5JHIaIV0FEvU9OoGN078cAjaV5VXJJ4bJdLxMVeEJF+dRYcdpA?=
 =?us-ascii?Q?ORgEZo9zlOdgy90yBlTZQ5FSkaydaQ9gCC5wTXH92/Dq4IQXMlWlStjIQ/4x?=
 =?us-ascii?Q?38mXqfShjx1G7Dqh33NnhvgKhzmARDWojo8IlwqRYZwsXqFonkXfyJe6Ywcl?=
 =?us-ascii?Q?doV4pSdVUiPRhhgelKQUhs0STd2g7Qr7/xIr2a4r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2cdd7b-4ec6-4dcf-0b84-08dcc2eee08d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 21:10:40.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9vGLz8eUj0LhpZm7t1fE2Vny3a841wH8xgFR5ry/ovypb33xS5Wq6/Qqvda3sRR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968

On Thu, Aug 22, 2024 at 05:05:19PM -0400, Steven Sistare wrote:

> When iommufd supports mapping them (I assume someone is working on that?),
> mdev access to those mappings must work after live update.  We must be
> able to translate iova to PFN without using va, by recognizing the mapping
> is special and calling something special to generate the PFN, such as
> the extracted guts of vfio_pci_mmap_fault.

I intend to support MMIO via dmabuf, the current VMA approach cannot
ever be correctly locked.

So it will work the same as this in that vision, there are patches in
progress for the parts, it is unexpectedly big :(

Jason
