Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8D223336
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492108; cv=fail; b=fviSNl0vy2bFGET2mxJuRLV/Nu6nseVXIDwnspdqp1EA+OTL3snDo7ECS1HT1H+xbJc6iFsQOroIOb2BuRXMIt5O0Er/TJnMVSBcZCfHcjHnK9+a8yfRgSUOch+VWXyY/qqJQw/pPWp1aOD4gojXKkJJPcKcyJlXu76K1hTJZ80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492108; c=relaxed/simple;
	bh=VSoQ3IhojbxdJ6l/F2Dc3KzlkUtptXGMum0+4N+sO1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cMYOxF7QXcc7Is56+OPTrnJi3VO3aFzj+/5CJpwJ7E9EuZxCcPHC+e68egpoP/vGLHajNR/b7RWS3wq7IDD4etRwWkPxu4hLM7aotMgEI4lq5/WvduCV3egn2Pwp5CARNRj8YV6iEMnLvmJuMa35UBRVb2MQX38eQjqYzwwrAVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jT8INxml; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jT8INxml"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsqOJ78WSMfuowQONLIJawZNa/5GywTZeTq6tTviZRyMZmt4S4HDbqacQz8dqamQa5rJnuz4uQFVD7xIrz5LUDdhKzEYnpc5u5xELFrTN4UqfrT9zl3eWP9W0fm95q8OofCFTS8qRFao0sV4Xx9Wjh/OCyRds7LShY496jX7JHO9UJOW8PnUCj4Bwv9Q8GrIlpC1HakUfE6jME/6FNJTzFO3URijizU38Ew4P1jGCsHXrzmCPKdPDRwwH2LDNqQ9SUlVB0Yt1Yi0TIlS3wpZzyqxmwkxHYpyd/GaTctadvhs+yFFLjS39m/PVNJYgHi+2RdxBDw/oizB7DCSl6pWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4E/cB7qkOnSolkQJ+69FnHKxB5jAWMZnZDHRxT2/X2A=;
 b=T3sKYC/Di/JaNYTSYZQa2s67ENMBjbA8vDCYR4UHcnz9akEFeC626eSoNfKQDEi7ZdRBxfEgUQ3Cj+kI1O9vidOE62eRFd23atQReLvD2vD+Xcz4CqIUjWnKAw+eIEYWgJQVCtxoJysn1NQC7ftiGhtXOFzlrfm2NK4cLWIoch8Ulez2xa+2VP+X4NRENbWKnfKh0k7yv0GHO3uH3IFr+QKv07Ai+iW9ybPYs1JaurM2eCiM+Mwe5fc/nZCFeKKZzkOpcV5rkuCJ/ICrnA6+klooEJG2OSlf59SJsQnZaH41CTWz9fpcZaQe+VoCwQncR/Ffv5NXq170uretqI+Qww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E/cB7qkOnSolkQJ+69FnHKxB5jAWMZnZDHRxT2/X2A=;
 b=jT8INxmlpJHqHspKOFdbJDe673hAa+qmuTrGPS5OUx+gwrIsRtagc9qfVX0d60+J8xpWS+H3HnTUboZbr042DDtS7pUBaOfN4GoMlfZH3tdM7ylCZyWXmfIw0jZLqVncx3FuxQAcr0CH9e1r5/LZNW6Fq77W87A4yPbBfuYKyLoqgRzIRRxyPvPPXyiXN+rUHhKPgwpyVtRrEcPJue11jvMIso4Mn8OcTVd4kgh4Yw3EK+1gY8AutgJCNRuSV8oqsHGDwzBq4L0yIbhZgQWQpw/ic+fw2JO2ZppanVmbTYcLBirJ1FEovUKUNVRT7jdiBJ2gWt88DnuEyHQg4roxnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:35:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 17:35:04 +0000
Date: Thu, 20 Mar 2025 14:35:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v10 12/18] iommufd: Enforce PASID-compatible domain for
 RID
Message-ID: <20250320173502.GC206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-13-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-13-yi.l.liu@intel.com>
X-ClientProxiedBy: BL6PEPF0001640D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: c1752ab1-0c39-4a69-6da4-08dd67d58c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?seesuPUT/iauNAa+kECdoUVIKntwUITvfyC+ij5wmR35F6zeUSx8+8f7UbPX?=
 =?us-ascii?Q?fT+e3uRPTOJH9kauGvGgFkpUwJvZF7ZQKVzAe4+azUnRGSBrXHeMyalTD14Y?=
 =?us-ascii?Q?mz+8BboEBEPst0OOyDZTC4es19qtfAUgyhbeyq8NSyUiSXKdJ0yPXAsq71bU?=
 =?us-ascii?Q?62pBjv5DLH3opwJ1ynw0y3vF3ckP54fGY13v7Ce+YLVaomv2ceXChQXV8wSJ?=
 =?us-ascii?Q?gq6ZW4U77g7tyPDlEMOyR5WhgPmMty/6M+1vEFzH+byha7Ww6dBJhlhnzvPW?=
 =?us-ascii?Q?EEsKnpJG7uvXOz4DypNsI4yxB0M8pPZdpNB3EkZXelGRgjCDLijDoYlB+3eg?=
 =?us-ascii?Q?lz0zDNwXq7ejvyoVsFxd8sl7UpXYKhvORn8zLsU/Hq4PNKS3ssxxgnGiXzDt?=
 =?us-ascii?Q?/1Crnh+TgWnRY9t4egnRQavYz0dEsuq34QqrTKQ2JxSBZdpmkT/NMWmhZ2Tr?=
 =?us-ascii?Q?ADzlxu1hJY4k8qBttvn5SMwKkzNcdePHpXP17F5xaZShbz/wAmuXJLBwGzYp?=
 =?us-ascii?Q?IKGx+BPbwPbug7QM2PNkXGkVGdwL1T/KQfQ7eFJovTSoxEsxDbknZtetfZWY?=
 =?us-ascii?Q?CR/7ND/NcL20fPnHjdlG+7nbf86hxRLXkKInBvsvFarIs3qS3UL2yFAqTZUO?=
 =?us-ascii?Q?1k9V2Ulllfa5kXt8ufNsfdhQPnlAjC0z1ZLpAzm3GnVa8rkff8AgZPyPC2T2?=
 =?us-ascii?Q?FZn9qFzDOPOqMV9QBUX8vG6SlE1BDtwBww6YhtgGSYQwnvLGe6lumHL21d/d?=
 =?us-ascii?Q?pSz7DsaFZH6IBYinSFcMP2gkMVrjXgzbCx7Ch5L3IQgc1UUrFpgd6YE9jY/P?=
 =?us-ascii?Q?LDjHAIoVRPV5x7eGt/0JMJGSK+Vyercc02iaV7ZBs/PGR8XnYEJm4JdKaZrO?=
 =?us-ascii?Q?u++GH9CpLbTBG4fgsYTnf2CH9oc81U0uPVZbPBTZ/8TONBpnoPX0isctTZVs?=
 =?us-ascii?Q?w50t7XDi0OV/dQq+++Iw0vrt4hBphGd7M2xSk2a0PFVhyFj5yrGPV+at1fWV?=
 =?us-ascii?Q?KuA7y+Vdr0vAFZnamwdV2nPdPXQ25NicAS5iAwc05edxxpAXWeiIfu0fsdHM?=
 =?us-ascii?Q?hvDR9aTiLFdxw+trVtbdPM/zUD/5p6xSsRsUsL8pa0eZIP4xP9g81HLIIWjq?=
 =?us-ascii?Q?KYSD3Sv/nA6xKLrstCU/kFspE0VSHKGFJpapPixVqd28pkEnOiEsnuphqz2S?=
 =?us-ascii?Q?wT6FncWEQlgEm4hs5eRfVqeWpRa9QNrMory12u38kO4XEOypkt/2lAAZ+rgn?=
 =?us-ascii?Q?Az1a15157SVkiPI6RSzEXvnxFjCCVF/baMwzZyoBazqn37I3XWxmfq5xAuv/?=
 =?us-ascii?Q?pN+uoiNPvaDsaQpf4tzbq92+ovdSItQx2mZ2NwgNdHCSKOTTmhKI2VpD2Em9?=
 =?us-ascii?Q?s3eO+1sRWMmSt/0HO5t0m6ks7o8D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6L4Pgj8WMIYgxSaWkO25gbva1RqZoOz2HBPBVSqPSTtlDppNT9trxKey9RSw?=
 =?us-ascii?Q?QzZQ4DSPMA7ZfNXNbvZ9SzaAtz8FP3toqGov5OVTa4tYPmlJtwKuIiMfWQ3C?=
 =?us-ascii?Q?MVIIgaqz1YxK1N9KgO6Z08WBtwxLvuqKsJAb9XV+aVHpEa3OpFdvxoHrrmyz?=
 =?us-ascii?Q?nH/tmFeDeqwu76a4kbtd/2nCBXeQLHevdmS2Xy2W2pX6As4yA6PMYaYBPayc?=
 =?us-ascii?Q?vz2zaC6P7ZrvAh/mFi9TqijidDkXpoHYCDQXkq5iU/XMo/souJrv8jMZkGAf?=
 =?us-ascii?Q?gDAz9r8htsBOvO0UAFVScCVFu/myXlk+IL4cKQOmslrKzCrb2oNfxNtLC2KT?=
 =?us-ascii?Q?O/PsQLQ+3n9MKSNqMKi8h6rIACP5Gokv1hJxdegn65zsBaH+m5SozArBllQ5?=
 =?us-ascii?Q?4DAP191mFqQynA8G54q9ONLweJqPYnPpOsqDr3uYAGjhwIDEKbf+IbYzAGwp?=
 =?us-ascii?Q?2H18iDrh1ZTf7/CsDLj7tf83G/IfmBOwkO3WftfTIyOlfdP9vDQKNzRdu3Hk?=
 =?us-ascii?Q?HSCaGhAx70ahxi20cHQybkc4WBsF+SbRJEg0Aer8BaNEuUbuijVAARnWVToF?=
 =?us-ascii?Q?rOjRPsjumEF7L10saGiAq8CBWTf+xJDe9QaQNjuUuG+QpQFJY8IaKiuoeaM8?=
 =?us-ascii?Q?TkmWJGl+N90nLoLjmSGnIY5bLa/eGIlF8rXEfkZFeVy30dmKRaestdOqXjrR?=
 =?us-ascii?Q?X2zNUoWNw7iA1rbTiEuZsD283A+ZJpBDyBKusSHmb9sumBRaruqx1sGgf+2C?=
 =?us-ascii?Q?komK4YXzY8C07G25S3zb81hTBqPTf/rnyrNJ8KA5569O2ddqS+/dTyzCX70d?=
 =?us-ascii?Q?OHWJmYFIOnQCF8HAiE8RS2clF85bxYIx80BwecX8ES3OkZUNWpVd5xDv3rA2?=
 =?us-ascii?Q?G9N+MUKrMrlDoeZ0DxK9T3cZdMXfzVdlMk7BflfDbuuWI8KwQxVj5mQasdr2?=
 =?us-ascii?Q?k+4nSo1jYKrrfEXRLNSG4SzQ38VFuYp/aHMivPofDUUwF7etGTji3o2iJlfH?=
 =?us-ascii?Q?ToyTGaCSf+c0nKi3vF4zWhZ4HcaRdatVgbeooAIjzxw4NG4ZJeYExDHQfgKM?=
 =?us-ascii?Q?c+rMifKUCb6egvs3hezRKQBlO/bp6/zWkohXvQ1cNK61Yi3VQcJQ+rNiVH0R?=
 =?us-ascii?Q?bqV4VLDVZwbCClWj1xOXXHC7pZkXnwyp9saSefyp9Nb7xm4pUTscEAaHForw?=
 =?us-ascii?Q?UlV1so3qlsqQORHSKZWBBjzLzbEDHOfQgnXBtP/qQpA2U4QckBnPYhQAw7uV?=
 =?us-ascii?Q?WekjC4anoSPkJxelo0lIDMrBYAA7yLAgGDudDBEs2ACNKvduD9FCeTHMQDpC?=
 =?us-ascii?Q?4Zol3k0bhczJ09hUO6Pzyvyel63BJfxmxxZm5uGrfS1bc6XytCHsDz8N7W4l?=
 =?us-ascii?Q?8McANDQSWJjXJoHUK5oMJ/ng5XBh36NcvWfXrFghRhzp43dT4f+08es0eHpO?=
 =?us-ascii?Q?9MuvPBkmdrI3GvleoDYD1K12stKcKr9VvBN/vKNAH4PyNjSSpGmG1/pTnCto?=
 =?us-ascii?Q?zMMRuL+M8oVUppZyFeZvoo2knaJTqJ76olisfmmFgZg4s8VNKXjwTbInQiaS?=
 =?us-ascii?Q?Jbt04XhJ+khg/7S8slAsD3SwsfsiMokEbVypyhvc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1752ab1-0c39-4a69-6da4-08dd67d58c89
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:35:04.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2eK5RSp/P9eFQCY/ev2t+7N6w0LaVHiKwcU1LlW13q377FUYF0bK6vAnJGB5Wce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

On Thu, Mar 20, 2025 at 06:47:38AM -0700, Yi Liu wrote:
> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
> the RID to use PASID-compatible domain if PASID has been attached, and
> vice versa. The PASID path has already enforced it. This adds the
> enforcement in the RID path.
> 
> This enforcement requires a lock across the RID and PASID attach path,
> the idev->igroup->lock is used as both the RID and the PASID path holds
> it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> v9 -> v10: split the hwpt->pasid_compat check to a separate if in the
>            else statement.
> ---
>  drivers/iommu/iommufd/device.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
