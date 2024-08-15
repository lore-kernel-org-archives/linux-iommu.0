Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEF46426
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743456; cv=fail; b=k+jeu4J2xfMZxm7/djHMfJGwFfLzOgqeCeT0UJDzQ2ASRW3MA1gdqZGLEqH4Wphygf6gTQYBVE8GBaJ0VQ9w7Sc90X/2fHjDo9cR43UoauUvL7C2+v73WB6cGq3A8hsQ7wkH7PowqAfjwR75gBRWGHSWYSxZditnVzPvfjxabP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743456; c=relaxed/simple;
	bh=MQ7T/OzzbLxVi0gAqKbRNGVgT566FhhCVLxHxLL6vvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hxh3f0DqK2a83ysCd07+PENcaNJQ5E2JviL8GyqZ+u56fDvV5DPRTQ8R2IidJoyvGSXRHN7fMWM2Ep4ZmskhW5DBEHoBv2JWWVAlneugnR/QrY7cdhD163LvbLHnnQwf0Rq/VlU4CUKWRjLaJfuV+zLvc+xB1yJCoaxJbuAl4/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dcs4z7iQ; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dcs4z7iQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlBGYCyloC5Uolc+f0HAZEs9/sSZajt5mnNEHOcDOZJnug9L/9M7Ev6o+osi3gC5CDsRzXf+B2KE0YKmmlGszFMH01HjZyPzLacrfaTweleQX3f22rn9CzIfcenqVvZZuILVNQP+62yFDO4M8MhieyxXC3GJZBfWdDvUi2n1N0DjzaOQhITPNJF61Fv3YFkLrllgueIVxeOFAMoFHutH1ndPa6kUFg3PsRSV6+2Y8vN8PYvtuKVyIB23tclhgqs9dcBkYhfP67wUaFq/GC2+bmGUAlWKahCkpUBs2jMZyhc3GGkza5GyC72YNmFlYHLLFSa0gI5aQGN1boUMtHKmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV0MF8lM7uuQdu/wT9oyhbVuCosK7Oo8Wi9mThD80m8=;
 b=vNgzR4lLtqPmNi5LQCUbH280bBNSKJlA3TAwBr/IBggRrjKMnKd6DvqEUsOxx54TVqePk6dDQSxB02Ahb4xlJ5u2JIlwVFBqxFImG8USLv94h5FbL9zdjNhi/arAYgoGQS5Wf9/i2prRF8acqteg85k3VTW2jTEinJTVIJmmB5vuAdtOKwIuGbsE1HYnudq6HuqFGVuEJmXXlnIJSb76OMzE5vNHdBn9CwHlRnzT4QfsJ4twgFPwZs4hpNfpKMnas2HOyd/Oz6AZn6M7pq+GxQDtLL+NznsPYqzLN8b2lZIT7cp7oHiS9Zu49G7wtaHhCLU/iosJ/vww5+6nrNVZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV0MF8lM7uuQdu/wT9oyhbVuCosK7Oo8Wi9mThD80m8=;
 b=dcs4z7iQyij8jGroGWQ8jg1h2r3CdKzgxVR+3j+VW27pvnxZbsAWcFob/cFa/DONUWTzhvmvnreLjOuUZvsvX//gOgRBVujk0HctVESOV83Ne/A6YprH4weVOyMUQQn1TAMc+bMpTrwwKaEq1I674Gfe+mle63QPk0vgo6VTM1RrSmKpDtJ576I1xDQTcr5Eq9/EyN0aaHyf1XPHnQNBC73/RRbpvg4pxICXnBmsE+RobALvpURYSpdtYYt294XFsxBTJUsokjjFKc2jKtU/6gSa4OuZbGN+NJDGDLK3ZemNZbs9I+trR7WIWJ30tS+37tAZUccYPaC5MOP4MLx+Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Thu, 15 Aug
 2024 17:37:30 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 17:37:29 +0000
Date: Thu, 15 Aug 2024 14:37:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Message-ID: <20240815173728.GL2032816@nvidia.com>
References: <20240807003446.3740368-1-nicolinc@nvidia.com>
 <BN9PR11MB52762AD4E68BC0FC10CACBE18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZrZ6sBbDK5gJtbB8@Asurada-Nvidia>
 <20240814223843.GA3972912@nvidia.com>
 <Zr0+RSaQk8e/8pl1@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr0+RSaQk8e/8pl1@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: ece9b9f0-da4e-4d1b-0e0c-08dcbd50efb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?noMlmFmV4iydm1D9Jf+Uh5B/9WDCyEIsJ/W/qD2dXBnViAjhsuCc0Le/38uo?=
 =?us-ascii?Q?bx0LNArZl4kswBxoFPSLXeF24Uly9RdkeWqUj/tkvw41W/S5xEHeVqo5CloD?=
 =?us-ascii?Q?AzGrMKRhrLSLMmvsk8b5VeINKhWOcpe2fqTsAyuLy8PFfM0/HAfhWPSK0V8w?=
 =?us-ascii?Q?fZiVStzI/SAE/080atWLNg5ypSH2CCKRUonjUvMeda7+1xIKBYRP5B7VpaKx?=
 =?us-ascii?Q?P8zAxR5oCfO8QcXdN5EK/zjepOCQS6MtDABfd5iQo7s3zDcmtWpp2+pbqzux?=
 =?us-ascii?Q?gqHB8sLJn5bkeSOjUe797D2l6gXkqKVg/8qmhZt30m7ikPrMbBntliGUmlpg?=
 =?us-ascii?Q?1qR8fcTNq55HiS5seykIsX4P3nO6UoKGTwiLTt/oJZsnb77Mcc+B5Kx1B5P1?=
 =?us-ascii?Q?vtLkgJ/O5y4bYDWvrGce0d25Lqb2SpKuJlvCBKQwtB3oDYi3Tis28JhWFoaN?=
 =?us-ascii?Q?bOZBGG1piDTeA6LqpEqSh+Dwqo31UMISqOuZpDTqRwlkWXieu/uybv1Mnzot?=
 =?us-ascii?Q?WBTd78PyepUuJPPjZkWhXCdMh2KyyJdbPqjjPNCwlu6/jdcvYsAwfWeSVORh?=
 =?us-ascii?Q?MQBvnfTohUFh894xdd9N6yfNbPIblVS2ii+KcJNWVtQhF5uew2Oyn3m+bc3g?=
 =?us-ascii?Q?9n3cDj0v/6ANrBvq40acY+3dctJL+sO7glwV8VJcz9+jFOXXIMuDyu6lAHHe?=
 =?us-ascii?Q?mZeq6SH9ODdqafwJ1VDV3W2cILIkeE16YpNN0Y6BSdd80ljgtSArKtDHbyV+?=
 =?us-ascii?Q?GnQjf79zbrslSLkEn4AF+hpBzpYnIk47bq/JRYACQOhTTfzjBiHpweEzvYoX?=
 =?us-ascii?Q?Xv4mX+xvmoVw/sdPX/OZSYfDykIwwINAaydryMKCerpvAmzc401FQkq3rvCC?=
 =?us-ascii?Q?zCACdhP8SFAZFqatYiHNWPimFi8kMs+7aKDa3hzkdojTzfVIx6gj1pAx889b?=
 =?us-ascii?Q?SQkX//KEjHXVFMBoUl1rT8fGQn6Z1qeDoeLNYII5e2WXDQPthnKh+RnmYfmG?=
 =?us-ascii?Q?Up8Pz0uxa7q5VWQPv+W/DVbF0aES0FPj2G4Ag+PgtNQ0MVYulWaN+9ZdWjQU?=
 =?us-ascii?Q?LjgyVUPdxgO0cIaDTKNFkcVS158GBj75X1picaNLNALpbVk+JWa0LejVY6Q9?=
 =?us-ascii?Q?SaZpw1BRD43uBXZP0Ym31N6zxk9q8MI0g+u0XXhJ9IGC/oxYeTJx6EBExQ6d?=
 =?us-ascii?Q?t76BBOto97JtS1RMYpnwtccwFFb/6jEC4l3BkXAUnZQd7y4rMnNfgxjI7U9r?=
 =?us-ascii?Q?vvYVDIkXiAn7gWW0RF33vPDOz/CPhKk7xsC5aJHtnTZ8eRI/6hRrt5f8+MXZ?=
 =?us-ascii?Q?Tw6A7qBfidK5MH4U+Kpndj7S16/n2FB9VxHEw+tIJnrxfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v3eq0ZpUpNWr6FeDIgj5bdrC22qR+jC+GawmrR5XnBzOTsOnwsQOITVi0SBz?=
 =?us-ascii?Q?e/V44EWyGKoSFyp73qr+DgdluNL3b/HU1ny9Ob4+TYWdnAo/4IWj7jOSKYWn?=
 =?us-ascii?Q?dn4qUJFtsF4tvnk0zGl6fA+W6JM4+XFQnhuMDpESR3xePCcPRzECpKCrgl8w?=
 =?us-ascii?Q?FvedlU99qiTuLVbAG+36qGs3cn1+a+qjIam/HDE7/vcATN9EMHcQFeua4JyH?=
 =?us-ascii?Q?BDrJBdXjXT47qU+gVAhWI0HVjmOh6GCZv1r5aabKwwmcL5rxQszk6GtBMzmz?=
 =?us-ascii?Q?hhuxl0IHoprqLV7FQztpDX+P7b35E8TUvJ7Ow7P+ovVtWO5FmjbTcL4nkL/2?=
 =?us-ascii?Q?LELegEaEzXIoJlPha/FI2yKFDeACgl6VpOj1l1pJtNGkEA5vuzrvSRY6SJub?=
 =?us-ascii?Q?pThi2lyqaSHmfae7HyBKZEDmEGzKbJfN3JzQjBxR+Kv6pTpYcueI4aONQfFe?=
 =?us-ascii?Q?RpDYI8w+3TMu/Qi+0Rt2s/KkwqSTlaccWz4szHhYraKfpSn8d+G40qje8DQO?=
 =?us-ascii?Q?EwldLrXFLoyuzvQZ0LEQe38YSOWdc+qyDFjnFDTwk0vPlJ1BSxURI+N2Z+eu?=
 =?us-ascii?Q?IjLZfjh8Iw1c3ZFi1yFxWYyxpkSQzGRkZZQAtflPZEpN5WDlKejhL0xa+98p?=
 =?us-ascii?Q?icgqWLNJRZ6F0kXJqTgGQnTuMqQ0JreQmdKkztG3uuO5r0m9//qLR763mSZ8?=
 =?us-ascii?Q?XagQRTZAk0EbgbQkZsN9qDe8y0SGlRCD5H5hqTYGXrA16BTJa5GXjOV6mUqP?=
 =?us-ascii?Q?cEtL3xdueeJSHHZ6m95w3gFzkgtbkAQgtp/MDaaNjEdUoJuzh0iAAViLwNB1?=
 =?us-ascii?Q?hGnEkW16WRHa6xXpooB5v6pFWxzXoOlWOmmFshFyEv10ZyEquQ9Xf8GxFXHd?=
 =?us-ascii?Q?fZrOG0wE1vL1QL0UE7baIs/IR6M8xdOudiC9SCywYIWWUKpBljMlKsooAI7R?=
 =?us-ascii?Q?7U3m7XQd2WLH+Ox7HZXP5jDmFyb110+u2Ilpe2pH+4PF8GJJkxNgB4HIbWq+?=
 =?us-ascii?Q?bGETfI8uVZ+/O2pMqixz9IO8gNMmdWc8u7OXSuqvVNv2R/DQZyvKHD1qHFZL?=
 =?us-ascii?Q?lskuaTHpUyQpo0xuv5/Lv22G/BQo4qyGCvmiNVjAJcUIth26qycqasiXzKRf?=
 =?us-ascii?Q?s2PVLcHAQofdSdyl2ogVU+gmg7vmBSOwHle/xOT0W/8FDEowa9vr8nnEHRFM?=
 =?us-ascii?Q?DJoKgSgoOnHutyoPjexKAh7JNU/Hk5z0+fScg85Eyq6e2CboUoRS15IChl/V?=
 =?us-ascii?Q?VzORRLw8YAasBXwMM5Fs+uvW6dpQn9Or70YoiqSXirTFbODkANfncH1mAeBB?=
 =?us-ascii?Q?G9Sk30g7itd8eUozUSTjFsue6wj3d0yFcCw+iMplCGTnJ7eeJQMbBMo8PJD6?=
 =?us-ascii?Q?WMfYacajEGapP6jT0mpZ80uBh74U9q9ljoxIlbp4M2YnE9Mb8rl2VL53jlci?=
 =?us-ascii?Q?RK3cq2j38K8DXf1uskDmCQ/59brIqKyu0zznaY4ffB1JR3nFZ1YogC41bS2Y?=
 =?us-ascii?Q?ZeWo5u8tQJXJr5pvVzvhEDGHZhkQ7cZQrF4kVvwdTfIsKorkBSh2asH7gbGj?=
 =?us-ascii?Q?k0NbvRo2QUYy3QFdSaM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece9b9f0-da4e-4d1b-0e0c-08dcbd50efb2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:37:29.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/T7zwbWm0Fb3m2YkRxEsMHtTBUzOOjQoJWww9zMlvqi9DKZ6zffob3kjqZQ08Di
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665

On Wed, Aug 14, 2024 at 04:31:17PM -0700, Nicolin Chen wrote:
> > Regardless this seems like a bug fix to me that we may as well
> > take. Unless we intend to retire the entire RESV_SW mechanism it
> > should work correctly.
> 
> I am hoping for that, yet can't guarantee of accomplishing it at
> the end of the day.

I think we can't retire it completely. It is necessary to allow DPDK
to work as-is, for instance.

We can only hope to provide an alternative for nesting..

Jason
