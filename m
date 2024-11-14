Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFD262A3
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606152; cv=fail; b=lhQZG4IgnjM/werrkZ+twruz8kU/ANU5sssPtJluEZXmIxTiU+AP1GkB+/5ThiR3y7yGjKC+jf2xU9N1mVpMtF/e4HAFjKFswqH7is2XpKn89tKsMBAsULe+DIaHYRv9KwJtRMqJB/0x7t2WDDq5D1O8bwtaw+14QuiEYhzbHRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606152; c=relaxed/simple;
	bh=vz4+Agfj5YDHTVf5mhhNNYkaRR5KQxPlfMibijBm4Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ypkg8Qj7AxpX4UquqUsAZRmQUO1/DyCWv6YG9aqUQoZ4obsgDfOcwEei/ETKPc+2sVvMiuPEUwS07e1ddGpdRit3IpcBsMVI2OzrVzvLRN/7OoGQ79R8DJJ2xRiRbWhg2L2AKBP5ISWKQkPxa2BJB3q5wHeTKPYCfdN9Z+bnia0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n3EdrTDf; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n3EdrTDf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncjygaaf4642TZKFDw+ZxM6BgVVHi73zZv4YYJ75IuZyIc8BemZPBmkfwHlBmr2o2ibaAAOaw9Vg88+9qFMYUknZeWhRTKEn40joNqqeRjZIl9CdwCQu74otV1arl0A177acLkrOZW0O9Nt0Wkq5x2WHl+v3zvp+KYOa9qIunZJysMW4g0Ul58gZJaniDFkhCnodriqAYxDuRtOD4qQkcZB6A852tpOSRofX0tWMiUly5UzJRoBkI0FaeJm1yi+XsglkylVarImcsCXmhS9YaGRjV5ru54ogsGJTjL+GdpSDkKUVqs1KQPu/MM6t7n7yINHQzBTluhOI1OMG6DatDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcgYXNLhrq0jSGdq4BjSkQ+kQMz1hZ20pfEnmv3IJtg=;
 b=Dy8XuuzfwpWv5hY/cPjb+BiPUWMzdx1j5o3VPcL86Ne9fsLfwvo5r3kIL0eq6Da1FMAMySR0XdxLdkxZAr+FbpYYVuYjTo0Se+gErEKekRBUewRsBiNyN2aACHTfg5eSH5D9tqJrZn5b/ls/ZvYFgfD+tiCGLGQh85DLCOAo/ZXq0y8ce3Pu39ZORurdLuXw4gM3Yo56U6HqJlCr2/CEXjkNIsteb/01djmUv3mJa29g7pkbCCcy95n9MTBGd5S7KsWPx3mzyIrGcY4eWdCAHESCjPITm1j+C1hQU5UnFilITWbLadnmufY+YCFu+eJ5AopOu3BcmUx8QE84bpGt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcgYXNLhrq0jSGdq4BjSkQ+kQMz1hZ20pfEnmv3IJtg=;
 b=n3EdrTDfoj7flB0r6BqGxwHNIHG4MKbrV8n/CCTdTvSz4I9VIyrf7R44qze0AIRVRWvbPC4HlvHf8tLC30dVExMQ//1GN7HI0xy7JkraAM0vJc62pihm+iKWySPL+7GFjE/d1m5AArVIuQQSNqujSA3gEEpqcRSYPKywSFeO6HC/4Bbhy3b8fZlUg+BCQYTYBAcrETY30WvX7vT02JXgUgWTTbhvnSnW+uy7Ir4DB2WVxPad300S4LGYH2NPN7EHbCVVeLoBWZuZwWuZN+Pbksifht5Gkcoc2iVamP96uRWS0z9h3mo7XLenLSC56agUZmQlnJB44OjxPGeMP7YpLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 17:42:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:42:24 +0000
Date: Thu, 14 Nov 2024 13:42:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V5 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
Message-ID: <20241114174223.GT35230@nvidia.com>
References: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
 <1731527497-16091-5-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1731527497-16091-5-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:236::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 4973b9bb-269d-4294-3362-08dd04d3b30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jrCSQmn0856gU//7O+U/JYlHZZNEy7DBPM5h9HrKZI/+7AcRcswtZy8TgZj4?=
 =?us-ascii?Q?EvZx5ladooNI2Ag+kimwGC3LhRPBx4w+qoToO/vjbN+DCT1tAocmkm4usqGh?=
 =?us-ascii?Q?jQzycByIdrXGcUs+XUp8/Lr0F24znf3TkQkOWY4kka7ATDoC4/3DBpHxgou+?=
 =?us-ascii?Q?KD3e0KZ4q1H8S03zvyc4Om0oW+9DKC26lrjv3CT+wSG9xjxp3jaUX3THFoN0?=
 =?us-ascii?Q?anz+JpgqegpnpAmQeEyfEuRjGIRyrsZ6XZkro/9XV2/Ou+TiUfbtHyh6DoYw?=
 =?us-ascii?Q?Ll0vYgcl1RS6CfIyR8oxu7/u3A8b1kiNPukwKQmcPRuq35MwU7N6pyHRh21R?=
 =?us-ascii?Q?7HSJk1gyAsk4KTqBBOJzUPwkmem8Yi8i/jr+UJhEypAqYYZUWBbcnE2JjADb?=
 =?us-ascii?Q?SlL4kzsJRsrPsQNL6Gnmi6llxTkMrvIo6gZmPQpmlws3X0N6rR3/DL3zVO4J?=
 =?us-ascii?Q?ngP4hf8mzmTamODc501IZwVfTbjqdj0vBTEHBXLeh0VFWBZwotXY6FipzHAQ?=
 =?us-ascii?Q?gqwpaA+A6PI9/5bZW/NiLagE05G0cqcXgW/87rxgBRRCdOD5yVR5tpohl/fO?=
 =?us-ascii?Q?3BclWUdt2FDr9Zz13wUEQ0wGMTrZOWk03nHA0okWuSX0R70Zy1PGUyKYBjXg?=
 =?us-ascii?Q?G2pTIatXpDq3zMiuXKEKs8q6PpEwDYfCGOETNtKDsvZtb60Wj7jWmAv5p1uX?=
 =?us-ascii?Q?xD9HFHy5y5eQA8Scg4skGd+rUHxh9pc+Zley5klfs16G4UNyebYiBS1O+ckg?=
 =?us-ascii?Q?v1484FLUi0pPJUrj9+ETGBbk1do3cEGxv9J34BlarLgto1YstHKHpva97Yl6?=
 =?us-ascii?Q?TOAYN9yP6UB3/agSHHYKvt6AdEBJIrgN3dVwtGGed/eHZWEToYJroD9KnM6d?=
 =?us-ascii?Q?if4zoUGSEezZxFyXgpb0/6d9OOn6MPBAp8Oe3hOqO4F809Y3C3S3SeNoTBoS?=
 =?us-ascii?Q?qDeJIV8dG/e1DXNeuIvK2ykOm26E871VqgQUp//YAT3HN6kgYWoOpZS8JFkd?=
 =?us-ascii?Q?uxSSvsReF03zavJOuVrdtyB3r+LrXxNuddPNBE+B3NJ7ilvne4RrRFWvKfQS?=
 =?us-ascii?Q?VPFyMqR7P6Z/1mp47BcKWG8icPlxlFEscLpzSY/IoJUEDpzw30aru4p5hLAk?=
 =?us-ascii?Q?R75EZZcZ1RLfqM+ceIfmZ8TvaO/OZjhei6fn4cDIRsrxuOudNTlhihkvvtR8?=
 =?us-ascii?Q?bO0pHTGNRzX7EeW9q2XGLbnUnSMaZ5mXAy+UhcET36seQNBCp6FCwSvt4nLe?=
 =?us-ascii?Q?+1CMGNRMPGRFZegsAF9ZXP9XdD0dBHdy7MN3uRbb5WJqhBNOIMwhPUaVspeo?=
 =?us-ascii?Q?C7KlXCQWj2T8xfY5Q3aJXDPf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NgjABXxjEtDfFtiwARV4zgM9GP3t7N6vh9Nmq4A0Rs5YurbXJeIPLEXZe/Hq?=
 =?us-ascii?Q?dEb24ixN7FHmQnRmlomZlYbbWM1Lw2yb5eg2o2YYS+4ZKOQnm3vPUOCUBXby?=
 =?us-ascii?Q?Q8zkV/V+M31KCfIJN6vesBCNpw/oybSmlOT0E+0RWSu6bVMIMc6vlsAu3/j3?=
 =?us-ascii?Q?SQIRWoaVg1HLAiX+Bc0gvjEsFkQT8t08z7WFcHFNR8wjtyj/lfAO9puVOATr?=
 =?us-ascii?Q?KduHsVhtSC0vMZTxsdmluX3r8lR1oBG212FFus/6ASyr49DNM01WkMFgnmpN?=
 =?us-ascii?Q?513YQ8zmryx1gio45ywsIFF1HTFdLZ6G0g00nzAMoTivxPMeP0vuJSjL9GPh?=
 =?us-ascii?Q?/h9LiVjrIeSvS6uuijBg5ji9EJhUEUTiAYMUfW6SA2P2jfwuvKprJyv2ZV56?=
 =?us-ascii?Q?EWK7cSSNOcz7ONwVNg7Witny8gzEih0E1liaofunWe/mHbKbjgiFUGldNX5H?=
 =?us-ascii?Q?2/iOxyCloCxPPc75UdWrIK1sbNryZIPkRm8CfC9VA1StkaneI5BRw5c1RXzs?=
 =?us-ascii?Q?Ik6dqyAnfXV3zUFpFWc7c9e1OofQ8LuRcALs07aOiXbzso/0D2LD2edMDoqR?=
 =?us-ascii?Q?+mfVfvOy8BLqbAikfMx3Oz89D7PcJagkrsCohfqVHHCsrUc6GMQtjueu9QJU?=
 =?us-ascii?Q?0H8G6+wjCJE9BwxeaDAbOo6ifcy+jv7xy/ly9qGhy0fByKG4hR4MeabhBvpS?=
 =?us-ascii?Q?4AqSvFc/FIQ8Ma09Xz+v+NFc4t++c7Rg1sbZRsZUnOGDRPMOgnr7teRpq3fk?=
 =?us-ascii?Q?wXri/rDHIpLhkDytbT8xw69lXDwppDCrfIZOrWfv3mMMp93suDuKLvN4+8cg?=
 =?us-ascii?Q?PIrIZFwFEnKa+ZxDmOUl7f6iWjHgKnAIAGTFIOV/B7Te9KX4PsAINqTXx9BJ?=
 =?us-ascii?Q?wFgdBIK0W8E0KsowhVXG997Bdq7AR0+XjDkIjUdlKV/cyDKd+e579H0QcfUj?=
 =?us-ascii?Q?Ho6Z7SVU7PT1QjRjqe6N5PkbNtJTM/OAGxWKjHY5i4JXY4cqHFaIsERwuEvH?=
 =?us-ascii?Q?HgBz8DKknDU5ChOeO0cKa57uXgTTZrckVc/ifNgGoEEQmYl+aqel8xja4vYq?=
 =?us-ascii?Q?arSQW6gLJqDFOsdEzKpJsEZWcUf/LQhT7E6FZhMFclVcNu9ZhetgM8L7NlQP?=
 =?us-ascii?Q?WvDmZOGSvfFsi1gNELiLESpjxCvFDTisQK3fTS8w0tlO1lPy0MvQcMGdUQr4?=
 =?us-ascii?Q?1Oc+IvxPnqQzo5ACZMGW7nQM0Gp8Zk+vtl4ZEsGHMOqc+k5eW7umnv93yhqL?=
 =?us-ascii?Q?hWQc8ffWitAeg0oKGAqWavsmt7HAMR6J1GJ/7CsJ5x60VFmvwm4/o1UUPey3?=
 =?us-ascii?Q?hvrtZ+ebJ0qG9S5zXQ9DZK2nENrxQlIaQnxw4t/W432OEkeknkj5nNZ5ZWKL?=
 =?us-ascii?Q?1u37wovLFHWSaZ+cJ/OUSwIPEs05O1KseLFeprP2dpT4yPU3ZGzLjNBsl9Au?=
 =?us-ascii?Q?f9NRc5mwbJNwYFoq7RLTaaK7frCgZLrlBhSOtpoCdbeQ2KvM7rYxVtanN0B3?=
 =?us-ascii?Q?0zO61o3P0PQXJ38HxT/1ROHiiPJX8sQrEzaNn74Adwqt4Uc4TlBNazhUri8B?=
 =?us-ascii?Q?i6bNqBwthsf+a0eyBiY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4973b9bb-269d-4294-3362-08dd04d3b30a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:42:24.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLVQDjE0NHU1bJAL9TS+STIPZkdVoXZ9OIuqjnA9dxsOnUrVnDHaqmjvmCCC/ctn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

On Wed, Nov 13, 2024 at 11:51:37AM -0800, Steve Sistare wrote:
> Add selftest cases for IOMMU_IOAS_CHANGE_PROCESS.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  tools/testing/selftests/iommu/Makefile        |   1 +
>  tools/testing/selftests/iommu/iommufd.c       | 141 ++++++++++++++++++++++++++
>  tools/testing/selftests/iommu/iommufd_utils.h |   6 ++
>  3 files changed, 148 insertions(+)
> 
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index fd64779..bd23ac9 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -Wall -O2 -Wno-unused-function
>  CFLAGS += $(KHDR_INCLUDES)
> +CFLAGS += -lcap

This should be

LDLIBS += -lcap

Otherwise it doesn't compile:

iommufd.c:(.text+0xe54a): undefined reference to `cap_get_proc'
/usr/bin/ld: iommufd.c:(.text+0xe57a): undefined reference to `cap_set_flag'
/usr/bin/ld: iommufd.c:(.text+0xe596): undefined reference to `cap_set_proc'
/usr/bin/ld: iommufd.c:(.text+0xe5b5): undefined reference to `cap_free'

Because the -l option is in the wrong order

Jason
