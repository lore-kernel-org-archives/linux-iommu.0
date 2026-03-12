Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3866242D7B
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314549; cv=fail; b=lCxk868XwBiN7duJDzM9gFVO9jXyDdeLi9hJ4C+WrxzL8/IFBdCQj5P3vyB4xFqqTmQKCAKEJ3PkJkRHo5E053Rtj+SuroVffqdJppucYPWVVvz77+UehLqL4Eo25Zm35xbrN0x9ogGs00glkYQcQYr6TbVsVOF/1ASRMzNCTDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314549; c=relaxed/simple;
	bh=yZA8lfgAlxMC/oRjEp+XCKtbnO5khfIhOweAF1k+mIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AJhL54yV3Rr0EyD7qXLxZsx9O9EWAQsxkJ+mIMDCxy+jVNuW2borUCo//mgD3gm0OXsmZUhy5JP0+RmgrmH78uZlXhGd3Fq3Cxc4S60qd3sJvik+RnrAC7NLE06UdMZkT4ATJ089K8l7/pqPyPPcjdkd/AEIdLhK7KD08Q+Zjzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=chynONie; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="chynONie"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCI7X0JPoFgIrsIO3lp5t1xB6rDNUXsiofHftAcPkDnQre8By0yepfyHU42Z26SjgaKbnfbl1Yt9PZvvvpX0upt48GM98H09ydYYXW1D+VRBmPiC9KxSGF3ADzj9nmHgFGkrSIFW/IDkv5K6vNgkEXV3qxC7AGWI9lA2J/g4mbykg2nzRZT8bUiigkXf8yLhAWaZbIpJir2jsUgcbUNbuz/Nl2pvmPg/U4uVaVFXjwVY2Pge4d/XAC46SYMKdgogudkrmhG1Jn6ejSG00UgXr7ymtJ2pZQcVy7Ig/+jISOmjCoUCUUUdsGTtJqkFNL40x1VVzMS+pPAInVqQkvPvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntOLuPHYafGa0/hJxdqxfh8g32I3iNAhU1ByfG2vZrc=;
 b=Rkf3wulboJq3nUwHWs1lGfzyO6coh5j13jb4IDjDZ1wNmDrnu+fIxc4FV7ukK0x4JBVrmm2scUUyUBt694AL4mBsLMYH+m8YYObztbabRosn/ayYytFy/GkYz2W9IJwug6o+fjt2ynUBNGyIF12CFvzg8RwJeEo9BY6ivVtEr2AhFooHD+heviRrUpqayzgoCdIlxv/TELluS6EECQiYUnzSuQ6PLo+62syUZvOkRmwP8HYpBkIfbiMjAsHGB/wklOLLckwo3D/deTESx8vjNN1exQPaEtt7Hfi1/eqpYeoQYmlIS9JYIkbg6pKrbMzLGh+YSwvamhu3iNPhPQQaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntOLuPHYafGa0/hJxdqxfh8g32I3iNAhU1ByfG2vZrc=;
 b=chynONiezxM625IbZYpi71vcLIz3hhC4Nr1/PdvTUSpHshgjGA7oa5NP5f9OsMV9NfnuLRkDF3qLrY3xncVste9cumGVqAHj+IPCUZZKBLZjzgNDPT7hxtN369HDILNb2VWek8r3ZtZxZcRNeuQfDxi/Hnj/koN0TXBvitZ2zpBuxAGd45xsv1mtVHYweu8JRDlDxc4miVuDu5JRss3jAZZNmQb4dd9x7t/tmUPYTY/9P5sWlAaJmJVsW8H8y8E6pQoJItUMquVvDDXiU/FoX5NReV4nGvAnxaHwcy3JridB4+J3yxjO8gFk6MYgFRP+UdOd+TM+VRxQ029fhWgS6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 11:22:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 11:22:24 +0000
Date: Thu, 12 Mar 2026 08:22:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iommu/amd: Remove PT_FEAT_DYNAMIC_TOP from
 PT_FORCE_ENABLED_FEATURES
Message-ID: <20260312112223.GF1448102@nvidia.com>
References: <cover.1773058553.git.Ankit.Soni@amd.com>
 <0e71bed81bd7ce5e40a7fb24e6aab32dfb7de306.1773058553.git.Ankit.Soni@amd.com>
 <ed1715de-951e-4794-932e-577aee2c76f6@amd.com>
 <20260311164403.GC1448102@nvidia.com>
 <rkohijfap7j4kqbspdp67ygdjy2witildk54ar7ty6hogpqzxk@n6dzmnipzbxf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rkohijfap7j4kqbspdp67ygdjy2witildk54ar7ty6hogpqzxk@n6dzmnipzbxf>
X-ClientProxiedBy: MN2PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb6a6c4-17c1-47e6-e471-08de8029a2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iPWLFEMx8ifwyCl4RgT+1BTbVkMXrYfmv5G8aCeLNBORackc9fcZGqhxDYi5uW48fj4unJX3ZRCSqflHaZd3g0ryuBq8ubQHAUsnq3stb7wF9d6UyKrJQRB0SH2+awZfLtiJnp3IsmNTIWS80Bhh8tUbcb9H+mcG2VeM28qXQKMR8Ye9dPmWsvGQwewlDpxy62+FZNYB8e4Rxvukh++tCWJqyr+am7IYiObxkCfu2GaaRsnpTVXM0tdtPr7BeG+sQJA5dQuhlGby57dSx2yeJNQSp67yqnhwGUps5cmZMVjAFWd5Yr7HpJLC0rIIz3tr3757ijz0OwdjRTWmB9KeNLre3d7CjgHRvpmlCXCz5OdxGHDDhu8NerO/dJ2UCDWc4acWtBfVrvLBHDHQczx3FPkRF2ft5QAjCEzgnjozRl1N/QQVdUbFZg7PunxUbzaF7YIObkELssTqyD8S6qEvYwUkXx2KNV5byqvvLoJpm5qUe9NhvYPTAi8IMuJDyHdDEt/bQP2KazwrAAu1u5WWrLbLhGnwaHREoLMfwbjFZocdS+4XJ2DdndXclaShbuZB2UIOTSYF3cB96iHDQki8SJITVjFC7NeWbdA/j3wJhWiD5oOLnag16MWn1M6T1wgDHBLRQfHuvf8uqc+26OQT3ql/O00bMs/Aw0kM3cnJ311PIwma86FlCZc5/Qe7L3nAAQb94uZp6Z2f6Yxd7sPy/r3eSW3TREI4J4bRBwCV7dY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gro2N69z8TrICJsTiW+lbCGYeDGmh/bLPwO++rmqTd13Kxg3/25TKf84IUQ4?=
 =?us-ascii?Q?mm8VAd+zBNxOvZfW/o/4EoQ9k5IXcwPABLlmT5Spk9bTnh06jcmXaGGqlIEU?=
 =?us-ascii?Q?seYNOuqGJ9R9/1zCA6uwcwmYfj5qGMHsxa6EL5mrUR866cH3seNAMN/7Qla7?=
 =?us-ascii?Q?VA9ntF95dJNe/b7YHXI3RObXwkoOeZH8qgCvo+yAfSFXjSSjG1ZFmkUitW5F?=
 =?us-ascii?Q?TSmwe9TQ+RnUWnuRmJWnKVvuxhBobzUTTzb8CsmSoAUgQqtE7JYZgASj75bt?=
 =?us-ascii?Q?6keu9CF/aVUUJ26DiKbzHIwzzvYywGFGY/6PH29ZFz9oOT9cXCjiF4td2Pb1?=
 =?us-ascii?Q?Z72zKIRkhXUbyjYeAu8FN/5it1ULfLhgitRI6otnn+YylAgLefpTe2mcYmKa?=
 =?us-ascii?Q?iWUzT1dSMBzS0C9yJUkePnc3lOA7ScYun6fnhPk4uL7ZedotYcy/SzzO6Ern?=
 =?us-ascii?Q?tGmJM9l0WQOQ/CoM9eqPehbtJC0DLHUD5nhzHFIZtpv21wbTcxIKYLdFr2GV?=
 =?us-ascii?Q?uW6OuwER7I/Zigti0aPC6Eq/4l5bQBkZuuvkoATkav7GbPf7zc/5nJRC6cdQ?=
 =?us-ascii?Q?Tq8qLCkC1ja/DTf2uUK4220BdtrKFLxFQ2B0BUlbm4GcklJkpaOWdBajWVqr?=
 =?us-ascii?Q?6752ONSV2PEqkVHMPDLtzLsw5uOfQ1exh0qPpD+QyVjJUA1+zgJxKI3hqQEZ?=
 =?us-ascii?Q?eIHRXldVdV+sfkpbbd2dyFjgBMorUi8xdTvzMX1qTilY+8eo7vYjcf0O4TMX?=
 =?us-ascii?Q?eb7goVViywxAeUBmbQYwrxSqSAGB+c5wcFrKXiuImJWWnPV2xAb4Ecg1AklH?=
 =?us-ascii?Q?liMPmqcFDBqKY+ypZBPotEKwVNkjDmlyc1s7Gp4HJma5gWz9sRnTSy+5O4NO?=
 =?us-ascii?Q?TqjtCtXSF/b0OJNaV9PDSbYtDyItzRHH6eFNqsfhFH64ozBot7TMge7bXNcZ?=
 =?us-ascii?Q?f6I8GllzYQM4q+4gEFd3cUdDj+eeiLXPuaucNpt1466JkLeuBqSZFeUANtsz?=
 =?us-ascii?Q?+xgPhwKhX6Jxc5PwiXoZFlgYA31Q3C2lVWd5fU+bKMakBHPYUZHuy6Bplvd/?=
 =?us-ascii?Q?lAZ2CY46AW1uUmm9Gw8xR/LFIN7k22lbfvKnXN9OaxPl8ALGHdFsyCTlKsMK?=
 =?us-ascii?Q?eGj5Sn0RNXQEPcSY/2cfyNQTrYFmFHBDzoseR+7wpNKIhjY/ftwb103+XWXg?=
 =?us-ascii?Q?tLFiwXkKUErwu9mNj1Wh9MuX1ULJpkvbTF56UawFfaJ3cwFEGVJEZ3+sUmNo?=
 =?us-ascii?Q?kvADC7FsHg8Dixkh3YOPcy5BLsstzl8TKoqWIpssVfq24Iss7DeRtgaOhqsj?=
 =?us-ascii?Q?fK9I50IN+KY7ZKW7ThlHs0weO3hRyhhoB+YvrOEsIurW5hoQJ8yk8C6ZpCCB?=
 =?us-ascii?Q?MYrG7H732qy8FmiTW7QnH3/xbgEf7KiDQQfiQGNNlBmvHmfE0hBPTlcZI4S8?=
 =?us-ascii?Q?YhZ7q1p/cYIL3YVItAEVmt8bdkcyEuqbbG6I3thM42NIIdPHJxEt5YK2XoPQ?=
 =?us-ascii?Q?FTagtXKuDLW9mLQjYNy3u23XCPn4Mfu7MAhFXUQxWjzK/GjwUv/q6HgOxm/V?=
 =?us-ascii?Q?cuXWJSbjd/cAvdsSao9OeGc95y3DIUFhoTrXAfPSNF4x09oTs+QB1trotoBu?=
 =?us-ascii?Q?14tkMFk9k0i/s3zZ5031jgddQk1KJ/6dhZ3Mo+09GyrpFopYuvMCus8RTIPW?=
 =?us-ascii?Q?nTiRDJMq01kF00xHLn4okuZ6aaAdLO67JnJCe5xsjo53GcWY/hOxy8QFHZan?=
 =?us-ascii?Q?PIKtOeaAFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb6a6c4-17c1-47e6-e471-08de8029a2d2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:22:24.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x16YKG/VYx8FtsnlMPciIsRdRgE4He3CBeUddaiDLnUJmmPRvrV8BfzycEostLmR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148

On Thu, Mar 12, 2026 at 04:10:13AM +0000, Ankit Soni wrote:
> On Wed, Mar 11, 2026 at 01:44:03PM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 11, 2026 at 09:54:55PM +0530, Vasant Hegde wrote:
> > > 
> > > + Jason
> > > 
> > > On 3/9/2026 7:35 PM, Ankit Soni wrote:
> > > > Dynamic top is used to grow the page table levels. However, if the VA
> > > > size is small and the initial page table level already covers the entire
> > > > address space, table growth is not required. In that case, the generic
> > > > page table framework clears PT_FEAT_DYNAMIC_TOP, which in turn causes
> > > > error -EOPNOTSUPP and leads to domain initialization failure.
> > > > 
> > > > Remove PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES, since during
> > > > domain allocation AMD IOMMU driver explicitly sets PT_FEAT_DYNAMIC_TOP
> > > > via cfg.common.features, this keeps normal runtime behavior unchanged.
> > > > 
> > > 
> > > Fixes: 879ced2bab1 ("iommupt: Add the AMD IOMMU v1 page table format")
> > 
> > No.. There is no bug here.
> > 
> > I don't really understand why you'd want to do this, the driver still
> > sets PT_FEAT_DYNAMIC_TOP, so what is the issue?
> > 
> > It shouldn't be removed from PT_FORCE_ENABLED_FEATURES, something else
> > is wrong.
> > 
> > Jason
> 
> When hw_max_vasz_lg2 = 32 and starting_level = 2, top_range.max_vasz_lg2
> comes back as 32 (clamped by min(32, 39)), so it matches
> common->max_vasz_lg2. The 'pt_init_common()' clears dynamic top because 
> "the table can't grow beyond its current level." with next condition in
> this function, domain init will fail with "-EOPNOTSUPP".

Ok, that is much clearer, but this is not the way to fix it.

First it needs test coverage added

And probably we should remove that if but it should be checked closely.

Jason
