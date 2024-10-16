Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8075208D63
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082514; cv=fail; b=AQhbu45IOgK8P6axY+Lqt10uSZ665f3NeDuCddIJOSHf9hqcwxZPCqlYbm+gVRBDM6djjaX/elmEtMRniazEPjAJU+lO0n0dhOLhBuBfTxVO87UIjH/0jBHnpCGaf/D8Z+A4QPCpC/0/zka+F47v7c7tJ2yW9aouwHtxs796gTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082514; c=relaxed/simple;
	bh=dX6961Wt7mN+0RR+Ys2/lLJ3S28MkYGdHcKpLyFRmL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rlkKUI4EtPWNTWQz6dsXAVyNJ+ng0wI/Xw2vXfjYk7gwYP/BQ7jqsZR/nYoHFdkThmHllMNAoeEyILT/RXwxv1IxUyGzSJOfQQCGCjbBKMa/8hZ9D6rJFUN+ztO4dd3SuYeKrHVO7UebTXakXAAAPf6CBfUy03xQzumG6p5BETI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Csf8fydf; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Csf8fydf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4RqxzKAzlO2xcPOc0ct9ube9gf5JnkWJ1vhjF9tAVIzV1zu5jPXT/BYn0+t8Tf9i9RptJYkFIzoshkC2Lf9z41iPIStGF0gY7w8XJEDTmV2lpkL58NJbDBSW1Pacu2CGj6eX89MMfE1ISr5RLfEWXkXjTLI6mQeheRde4LNk34HuajpyVcwNHyfcv3189f1OhkIgEeE2vbpbv3r++KGiOiOk7HXya5xvNK8iQcXGIpOQPSlRbUhSDbO6kHyKgRMTNDWJm+D0RjB/LhTonOoy33rQ/Vp2H8ib66GNmOuq2OFdUoQ1JvC/Aw7y67W4GCdlh/i7tqybreDiHAMPjWkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt1Bs2eM4fQIwH0GxueA8UYR4PQNXPJPdVCZOB8xCvw=;
 b=qGqegXMtxkpHNCil+ebHF6AJV6D1FHBfOfuQj1oJUGx46YJdvSWmgexv5krlcikjb3RUoNggH3HbL059ZiMKa7nOa5yc5HFzBJb7bue34Pttq1qdWwRt1O3svK+WAOOxBcfarur06lUh4TcwIqPfAOmgVrItY/uG5NZXk9ihhIdSPpLIADGVlGzYYxP1Vg/BHpUTvLQBaITD1nu5s8OJULCtUVcqcinUb7aaXDtk2iRUeIqAO7q1fTs92bH/1Cmb2SmprScJ1PnzwRoui7kHc+4xhOLu9z53nyKO2EX1GQIT4IChu8NBNNX3KdEl6IZvV0Jpk5G+xvCxz9R63L1Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt1Bs2eM4fQIwH0GxueA8UYR4PQNXPJPdVCZOB8xCvw=;
 b=Csf8fydfpqhpKHsYZQIII89fXXiFOUXtMxd+EkLbhHLYH9F7R0QeUjyiXJl3tyscrbip54Dun6QFnXQHYHo8f9mpAXED7n08q3JsnWF7lKupi9Oex/m0WRPrkRu8iVQso4Td8b2OPsnQ/rebZ5q4BxDn9bCnUgGxzUftLaufUZFX6cdNZjNTfgNN/BRhgbyP9JPfkNHlcVlkVbi3NTnPftWDAdBjS9l8EO25S22WvkjC1iUlHfN28EeXp1ojLLkeCtIxgWf7wWP8ioTL031ZBRZddcV21k9KmIHjUorRzA3FAWFY/CDz/2dt9+082aVmim6rFKMGuqlE49LSBpBlmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 12:41:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 12:41:48 +0000
Date: Wed, 16 Oct 2024 09:41:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 5/9] iommufd: IOMMU_IOAS_MAP_FILE
Message-ID: <20241016124147.GG3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728067700-32092-6-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be6e9f4-e0ca-4cfd-10d9-08dceddfe6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTFlDhHjeyboLpGfibwJAQksIsv1G341tzahJ51YFhitgZCj8YAuzMYLQe4A?=
 =?us-ascii?Q?kc8OuZx2uOTnbW2zZbAs+5LUf4HqVW/80pDinKRldz0VDP9nzl5uezSwH7HV?=
 =?us-ascii?Q?cTZiriUyF0t6tyy0xvit/NtaqtqdBwvEREFSg7QL/arURn4fgYCc5FP6i4w7?=
 =?us-ascii?Q?+F7TbuUm2D2LPpppHMjaCrPyj+aRkOt88eWC1mFn++csAcdnLYDZKvoD6qjq?=
 =?us-ascii?Q?/voHrD8G4sWohxYUwkLzgCYYrfX/BwvdY4SETTbhHRzCE9iKaOtzJC3SSSEx?=
 =?us-ascii?Q?RmA+OCkMHSuG9GZaF/pD2nGHJVpJRJ4HCWO1QjSu+5sOiXQAPuLTrfGjsG0C?=
 =?us-ascii?Q?etfwEhzDpF4d1fvYrqVYhabRukUoXmXp1HjA4me+4CW12NHwkZmo5mE5wj3s?=
 =?us-ascii?Q?FE7MDWQ3SSY9wppmvfAuipsBsCEanw8hof8ymXj5QspvkwEOkmzjlVunW22x?=
 =?us-ascii?Q?t8AxNk8rFh0y7sNi9v7MC2EHZk9Sgl6/ylK+gaAw1MM3Q//uGPqGt0xT0G/d?=
 =?us-ascii?Q?gcO5+kPcm/zNznGZECMJn31xhJHnZE4U9BctoJIJnzLMjoTup5Yxo/kUd32g?=
 =?us-ascii?Q?iyMPfXCrcE5eSVk8/pRTeUqHK4HZlCDniZjvRLq9lRmy9y0/zAGu+l0Ikcwm?=
 =?us-ascii?Q?S9FPyrrDYCgBijfMLOTp6NxXDQcUN0eNgfpCt3Eu4YwYKczg4SgxaGhXga5j?=
 =?us-ascii?Q?HGtSbWsX+tree4/X4Yj/RMBv1GFds9VJOBhtlIidWsIlj++Uk9VYyu47f7i3?=
 =?us-ascii?Q?IxZKiOp/W+6FGV7LgAYS+tt7VZaqrIwMLR1Q1aWE4mejvjxM0D946ITNEsAv?=
 =?us-ascii?Q?OkVJneeo/PEfaSVW8+jzwJOVNvbT4e4suS7J53guEpmE8S2BpS+T9MFK+4+E?=
 =?us-ascii?Q?11esvQRAH8nLJ38XEbeP3ZPx6aj5TC8DLYMsbdn/hvi/jcjvl5STU7z1qS4v?=
 =?us-ascii?Q?R9VYpUdZxc6ePT3TyjF8dcjH1sEadfnToY70fWPB7yKVGKpRAWTN7TEW2a6A?=
 =?us-ascii?Q?FFzRfn1UIcyPfcGOtP/GeYwxNeIPxC0IWffif7Gc5AgzNIYkhh8cdTwivL8x?=
 =?us-ascii?Q?g2Z2sU7Q9dcvpuhwdfZs2ALMwpqmL7LyP2ljnuWMIRk+lZo+8N/OacRlm2Tl?=
 =?us-ascii?Q?/eq5q7mmnDSPnysf4ii2/84eCXgw5uKsmSssekdE8e5TdvGMrkRSA7y5x8wk?=
 =?us-ascii?Q?NdmknbQF4uQpghajCfMVvBSurZBm2TUZ2QnYG7oQaXiV7mLjjp2L8Gz9lx6a?=
 =?us-ascii?Q?o04NkSJ28xfitlMnXSbgaYnKwFVx7rqKNFPJEnICsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79SOcknEW0Ku9MvMgS6pzPZhFkfYJYrhKIqFxpmLXMOdKWYv8iEKdf/dwqf1?=
 =?us-ascii?Q?j7ZHZGiWyoc5laBNxw4mRRCKNJ+G/k/pEMbx4qws75QkAp8pKk8HA2rPRZ3o?=
 =?us-ascii?Q?RLmHmUgKhU+iFGAHUuRHBPUhXMDEMgWZ90n4Co0sbSa3FSPxf4/DJP8HqQZz?=
 =?us-ascii?Q?KN9GeauukeR/wVPMIDPnwUqNFOCDRBFG/BZB6pdkDFbAu37IWXXDQO3xrmtp?=
 =?us-ascii?Q?/JRZDy+sgquC5WAbpakVagkPqxf6syLQ6EcsNZ1NHaPuf3LNn23IclkPWVAw?=
 =?us-ascii?Q?FnNilyQZWl2Qo6cexyoRGPyeQfw69NVCHCvnIj8NO757XtGoHkCgryJsMdnl?=
 =?us-ascii?Q?q1fGFVpSrv7ITeiUPqMyGUj97K3HuhUrgV2wMQkU8nv9WwPhlNebXq9a25ca?=
 =?us-ascii?Q?udKiZiWiBsKhuc6S8m6iVb4TfWy8QRKqaNSgyiJOA1tKTC4r/Ti5Nj59trqB?=
 =?us-ascii?Q?dYtgYwMLR0N5HVwDMkBV77jT8ido7MFHeWdnoAA3AAMbXsqItmPPgXE2Cu8e?=
 =?us-ascii?Q?2XqKGrl01m0eRCRNke5fRm7WiLxSDRX/7j73exqL9mcHceq+/WYdrF0Mt4Yx?=
 =?us-ascii?Q?FpfTMvASmyEUiKL62akve128crZ6EL8EIK00q6Wm/l/tHKPaQD5+tyu6PZo4?=
 =?us-ascii?Q?PWnkXIc6i6fjPRQOCzapsCvGIZPWy2QH9ZM8XGUpP9otQTFHiociM5nScavs?=
 =?us-ascii?Q?aUBhDYKwLrMXbbmaMiaWZdbqOEa4FTecNLV8QZ59n293IV+qp9AlVC9ObH2Y?=
 =?us-ascii?Q?Dv1nm0jq8fkLkGQoiU2elv54J160LDLF3Gh2+RDd9dWf4J6Gz+zd2ZloaJOf?=
 =?us-ascii?Q?Eo0GH8cxprBABvnv3ogdDPjldAqj40DWy8YYH0KkLnPP2rn/BMZUr2ErwinJ?=
 =?us-ascii?Q?hX9PA4+K7NSMm23KE1E5b1FyDMmWOxnbP3EzynzNK+yzsg/M+djiDzy+ZbdC?=
 =?us-ascii?Q?zj/X8TDDQuyFuRQ/LWdVbU8kzJeDNrtmw80gn1xseFcEyRRfWZ8hYMtrjlTI?=
 =?us-ascii?Q?uUciWvBb7NdeZ79znwJJciOANHJF1VmOO7wMIhQA+wJ998Jow0L/3DWtiLN3?=
 =?us-ascii?Q?OTbunbXOFXroMHNMu5SHHrJuJhvBWSJEckCswljjsKt1HYsvtRY2+I60GnRr?=
 =?us-ascii?Q?yjMeYzB6WhjOd0lr65/4g7VSStWyFtBh+kJKzAn2Aj6NL3b2JE8MRNwrl4g5?=
 =?us-ascii?Q?/vAwGRN2QtpLikh/uIshmHM90OYdpMnqpCoiTk/rb53Czo2A1RrAMNOdkt11?=
 =?us-ascii?Q?d/+zOFLwsbrLAa0wr3N6drnjzziHOEaBIaV4eveZmapUNW17qUWaJjFLgqDL?=
 =?us-ascii?Q?I3+pB7tw5RDmcTDrCoqHt878SWZ2gwUAD2tEsnaVlmaLjv0zlWnBCXMsC6HY?=
 =?us-ascii?Q?us3yyLXW21f+yZsLTuaGbqiOuWU86t5znHa26978r5RRb62+NPQNISxYAgT8?=
 =?us-ascii?Q?Ad9PrUUFio5c1oT7mRE4aEwkurdULdzGi8N3AfIU6/chpCkf6cTFqpOLAbpl?=
 =?us-ascii?Q?azBPdTaVFAo3hkmE5e7fMnoIQ0dxbXjFBpADgXaIxVNc2xf0GOCZAJPuydjL?=
 =?us-ascii?Q?iQdhJMrHa9vSsyiLN88=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be6e9f4-e0ca-4cfd-10d9-08dceddfe6c4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 12:41:48.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iGJ4EJS9c8Qy5jMHHXyiNMxTp//ZNLzc+aUfzSaDZJRayLVgwkMQseAAYEBpkVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682

On Fri, Oct 04, 2024 at 11:48:16AM -0700, Steve Sistare wrote:
>  
> +int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_map_file *cmd = ucmd->cmd;
> +	unsigned long iova = cmd->iova;
> +	struct iommufd_ioas *ioas;
> +	unsigned int flags = 0;
> +	int rc;
> +	struct file *file;
> +	unsigned long end;
> +
> +	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
> +		return -EOVERFLOW;
> +
> +	if (cmd->length > 0 &&
> +	    check_add_overflow(cmd->start, cmd->length - 1, &end))
> +		return -EOVERFLOW;

Why is this here? iopt_alloc_pages() does this validation and I don't
see math on these values between here and there?

Jason
