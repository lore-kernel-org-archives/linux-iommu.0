Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794860643;
	b=mbGmvMR/FyllGywnlyzAgPanZFIExpB0o22MbtPacXS3lODsB783YmBdpFduak6QutYx
	 hr4rNE7pdiuSptf1nUwhanL4bdoe95qmzuF7WIwewwc+TOuE9N893WYsWN+h5IUVYNZEq
	 HhlzgTC0EA13Few1WEDcYmXGoouzuobA3vbIZGyC2eeMVgUXaQlp7Sva3RTAXla8bMnVL
	 7/zJzs5QsyAunhWQQzIqCgv/xEzuC5TjPcrYMfV/1n0izQgikd8kI0BdoHaFGlsHPq1EP
	 i7FL/zlVJQ8iO+VtN7fb4+uiVnDxC2cgA80r3Ar3GtZrTQBkuu0bifrt0ku47LDuwPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860643;
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
	bh=M1Us/T6clc4BBWeqYFF3j9U2hi7peh3xmc065siTSoU=;
	b=G/p0bNToG0D5T3zj9plMzUO0zsbVa2U58XByIs+Eu7W3U92rV0lF/cZ1VOmwh5edPINE
	 emUuiwLn5yHEha4TM3VOZI/EOBbMGPQaT3OedRK18utb9TbHcm8TsZbdCLeieFVRL8cMX
	 fbFmsqNT95h4avDvscTar2bW3J7dApFkgRB8yRXTaeWEQSBzO7GKbIzOKIB86ZLxEV7PB
	 f231Jx+OlwHfZgB8fOmytTIK7hG0AUyFhr8vTVh45tKApBq8dHIMRtK3Xv0oCnLqUYqG5
	 FAhj0txb/4MaVwJynUZmurk6zgTiEixgQNO2S5x7qy0vYz3IK9pyYBnXtrrUuJsRVzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TOiRvElT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.53
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619EC606A31C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 619EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TOiRvElT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2rwIEcUJd6qOBJ+lqOMQlimXj6Gq2ti6I4Zy2bQZevemilUx7fMQdz3gJhlU+H3Tpa05yBlDlqsiLtDUpCy2auvi07gJZekKO/48+Ah7tierSSE/VXkl+EAjnZvKBFqoJ8TT8sNsnXvfr6Pr184a1BlVCmA1t/nPZdITxJ0AJR3ynOkFJ3Zog1iRmhYm2ljHAkpTUwrpR5owDlKGrp4MYv6kcuhNsXonJbR6uKwuAfTZxfBCImyDCRx+/lnNBRLL3L6+zJX2OvF2DC0+eQA9HoOJmZ3CYZtgHiMsGaE2pnftpAz4cp45xlzRKL/BA29J9Zq9xoNPEQFka6wFNV4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1Us/T6clc4BBWeqYFF3j9U2hi7peh3xmc065siTSoU=;
 b=ao6ONYVdJZrvMcimyU42vOe53DLEDXR7Yv9gwbTUpSKEARy4vGXe0Aau1bwJX8sCLLhw5u2JTZ2N+w/vLVaSw3ZfgtSJ4RWBoiz8THzMJEZKJNUI85QyvCPTX0zn7lA45+kC8+uenvwG0U3VwxZbLGP91lVrmdSlg6PWYLDdWsOnL8JENmN4yNeMCP7hNPZjgvYNCGrMUzNYlrsN+5/M9/Tvif6ASJr+slDfIt84sHQDP810FTxYQSY/ibMup3fZB+JT/+k2wANVDP6Jl+RlLSGHFu8J0ttj5MQ5bd3ypSKsego+YidhSTO6XdioryfHbj+rJwrEYi1zw89yfsO1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1Us/T6clc4BBWeqYFF3j9U2hi7peh3xmc065siTSoU=;
 b=TOiRvElT4qVZco4hRI3UqtXU+ziWRxw++upQoytStLEF5wOM2VJbFRy2P236n1x4OWfLPyQ++9+UkEvVqrUKKxQI2IuZrMs640KU3I7edx8+xljImDjaOcqB8sYa6RjUE80jO9B8Y03NzPcgfChBYT/g9OuAv1dyADnM2iLZ+w8BnaVz7IYN3FDJr2kkzfaUHRHMvjGh9Hx6A0VuBnqEqODer0AnrX+Y8Am9Nw6UJ7q8OZn3F7euvUp5iLPGurJLTk6/7sPGuYlBMrkQvWbEo3l9LrLdBjvzvP/Eli2iUKkReNVhMgAaJqQtkY7ULZdNLDhCdmbB2ck3hOhnUWiRDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by BL3PR12MB6594.namprd12.prod.outlook.com
 (2603:10b6:208:38d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:23:56 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:23:56 +0000
Date: Mon, 16 Nov 2026 16:23:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <20261116202354.GE2245175@nvidia.com>
References: <20261112151039.2083705-1-praan@google.com>
 <avdO5cBwc/2ysstZ@nvidia.com>
 <avromFJ6opeGEcT_@google.com>
 <20261116130832.GC1850935@nvidia.com>
 <avtltxy9sp6cYiEP@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avtltxy9sp6cYiEP@google.com>
X-ClientProxiedBy: BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::28) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: c210ac0b-2731-4c06-4cdd-08df441f8a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|5023799004|4143699003|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	56e1Yv4/VoStNnk2LwNePpPww0PsPacb3BduPbpgeXQpnUEwuA6BFWuimqGdN8fYeztcpFp7DnuqQh/pEy0GLq9iOYePcXANycJBt5xc5X7X3gh8yU49moqwSCzuau6f0pMhglznpjQCQQXKFLbx5flx1sGani25uUCFPOBqVfgQ76+iXv25KWBO8uTvDc1OOsvCJ2l4EhXplYboXpwPgvxqlqndAXgFHEnYdcCgeQFky1TfHMlMdXpwa81YPLRgOtbFZgXNSaVLlQJ4gH0tx2a/OTgU9RrKlQXh1FV4kXyZwk0UPAnY+RfOalivto+fx36S3rzuieNgUTTaaes9mxiU53lN3CE8wOSSG+e8gCSqjloSdmrpWcCUrC4qenCOYvnX+IWaGQ/wts6nm+XbbNyx7gcKs6exumLeP2EpyCBtXkrsfdTpv4da70wU9/8G2w7j7d/m+YW6YnEA57cxAWKO3LAh4jp8n03MyXjOAetOl4Ives5EBCiLNI8kELypKbOs2Q7h4jxInx+B5MZa4faNm1bh5bnmZiGynox1II4Jc2QKwlkUXpFQa8q5UvJ86I6NyQWAAE1/pPnKS7nn7558rg1d93veEGPTlpAjsJ3rLDpJGUXs5Wy765qKipZrNCyFx1Br2bLZ9Y0wzIri1aJLecGI42Why2LhCVCyeHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+ioJ7HDOIVBGSHeUs9Zxu4Lg5mxMXOuanA+eOvc3A3GJfB5b2jJBwCoG9pv?=
 =?us-ascii?Q?lKxqTti70ejaTLpUEVfKibL+N6xoUHBT2o7OyHzxJK9hNkfDjOFNdjhts7jX?=
 =?us-ascii?Q?agQnvD5twug2IGZOtCTt1n/EYPUIwp7x+qpdLbI+MRSpFQ3yeA8E4D9P97W5?=
 =?us-ascii?Q?WH8J/tzj1BWvJQScA3WFry8bzr2DJBJx9tRqL0JwfoMnTIke9G8mGyyRaeGk?=
 =?us-ascii?Q?rv50EG0UN1wE/VQU1KuBzeUI8koxajyppf5mRMpuZcXmY3G+AItbyQcIo4fL?=
 =?us-ascii?Q?HNukG2Ec1tew/FpedwIrzqt4BUFrZcItMKDwRsubYERE5rnvgiSFPfP1Cskx?=
 =?us-ascii?Q?gd2Q6bkO7aVa2+Fjjqe3RVRLSVqAT/BhXwGmzNuhmV9/xjtMdRhU6j7s2iyt?=
 =?us-ascii?Q?cslmL5ma2nhnjsRDKwXa6xca0JylMga/7aM0S/xE2Dp7qB0TrDXlv0MBEUye?=
 =?us-ascii?Q?4Gzu01bkawNMzQskpfLujIW0up8bKzEx9CzyBqhyw766qS/Ri1yp8lye6rJO?=
 =?us-ascii?Q?tzMUfq4U5HZZVpvi67eJgTh1FVCLDMBRGz42GrDSl6c922PFEwJzWQ89QN/q?=
 =?us-ascii?Q?Q8sV3abSZ4sJZ0860urWFFVS4OIT5iIm2Ct06e2DHhCZZNE8Uufq78Pa+FlA?=
 =?us-ascii?Q?EnA9Xx5hPtkIz5U7cjY3s2QNa2T36o8IE+gnxTPHmK4ydTCdEcyF1wBwHT1X?=
 =?us-ascii?Q?sOJ+LXI1V43Tc4HERgJ2jTOxt6E0Dm961i0OrLrKFLvVHpw0tQf6goTVtORn?=
 =?us-ascii?Q?8kxdYqMm7caAV9YREW+ba9VXjqqw6UmFsMMVd8sWSyTGe/ZogKVftDL/Z9hZ?=
 =?us-ascii?Q?e9o/JZp7DIytPspfJ2go+7pcJERUxjmHK72AOa/gA1j1EX0iphuVhgMMJyP/?=
 =?us-ascii?Q?Ayc+kT1ymOsO0lw4WRwY5NJV2gCiO2Z1uPtFVSzUgpOekWiPWMmv2OsLaqHT?=
 =?us-ascii?Q?4xUCTJbTIKxXKFjzF/egXUiXxY8ye/X/SYZpDfq6JbeekxjeyPnzx5nSDkN0?=
 =?us-ascii?Q?3kmYIGFAiGmFOlj2GVyXRcV9Ospr0858+sJNZfhTp23w6lmZIfgebvoy/Ita?=
 =?us-ascii?Q?+BEPuEIT+qQTCOBACEJ4FIaKnZ3M2o1Qm6SpO5ESBCMOyrhuP1PQ+A5PjwV7?=
 =?us-ascii?Q?ctKkq0r7W6dxWYsAsFt0taCszGJV2fNQOSyjkF5UmChkKFb9mypDrhmvEmIN?=
 =?us-ascii?Q?wOOqvl+sv1FmTNs6T1oc5IamdKoKLCUQPuFkkIlXNoPkncqPuXIgmDFwL9d+?=
 =?us-ascii?Q?DjKQXEkgHcOAiv3vQpVweSEUiAyM/FN7EMsvM38YLJd5iAQbOjXuVW6kq/up?=
 =?us-ascii?Q?XRaTA89ywWHHG8bdDBo6k8BM0e4kT4N01+GL35OUxUyjvnOx1xVDEtrOW6yk?=
 =?us-ascii?Q?kuKeEiZrmTGc2NFVysWCUgeDPpFwberzIZXOC4UOuQ0lCq0484V3DVIgr22Q?=
 =?us-ascii?Q?6yJ9xCh+1AfeYCfV5VIcYVJNNSCNf91Qe2EdXhCLo8PFLwf1b8dkhU5Y76Y7?=
 =?us-ascii?Q?DnpuuTkGPtD0Gyc3fs5HQz0H8r26e8/ZnUoUNj70r9G07mkUsq8oK8gVEnrN?=
 =?us-ascii?Q?gEM8djL7G1vVjnbmSUeVJESiz9c9B6BhlIJAcNcU4WZ0laE7BhpZN0GSPV6X?=
 =?us-ascii?Q?AQ3GSm6s3bS+dtNBM3FbknGx+xdL7HryiJSoQtjHRLMln7rMDKHuIWw5akcT?=
 =?us-ascii?Q?Ugl5b8eatpt1zWSCOo3sYRyAj70RMktIWXKeY9PeMUBYTYcBF9PO9f92pt8b?=
 =?us-ascii?Q?Y6CGEXj5Tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c210ac0b-2731-4c06-4cdd-08df441f8a0f
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:23:56.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFXCHG2AT7zcE1JYJJa00IH/weWNxi8z6vE4/MbBGPXygqG5Uuwg4zsJYg2nJzbK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

On Mon, Nov 16, 2026 at 08:21:11PM +0000, Pranjal Shrivastava wrote:
> On Mon, Nov 16, 2026 at 09:08:32AM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 16, 2026 at 11:27:20AM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Nov 13, 2026 at 09:54:45AM -0800, Nicolin Chen wrote:
> > > > On Thu, Nov 12, 2026 at 03:10:39PM +0000, Pranjal Shrivastava wrote:
> > > > > @@ -556,7 +556,8 @@ static inline int __iommu_copy_struct_from_user_array(
> > > > >   * @data_type: The data type of the @kdst. Must match with @user_array->type
> > > > >   *
> > > > >   * Copy the entire user array. kdst must have room for kdst_entry_size *
> > > > > - * user_array->entry_num bytes. Return 0 for success, otherwise -error.
> > > > > + * user_array->entry_num bytes. An empty array copies nothing, though its
> > > > > + * @data_type is still validated. Return 0 for success, otherwise -error.
> > > > >   */
> > > > >  static inline int
> > > > >  iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > > > > @@ -569,7 +570,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > > > >  	if (user_array->type != data_type)
> > > > >  		return -EINVAL;
> > > > >  	if (!user_array->entry_num)
> > > > > -		return -EINVAL;
> > > > > +		return 0;
> > > > 
> > > > TBH, this doesn't seem very necessary..
> > > > 
> > > > Though I don't have a problem so long as Jason is okay with it..
> > > > 
> > > 
> > > I know it looks unnecessary in-tree, but zero-length is the documented
> > > way to check if a @data_type is supported.
> > 
> > Is it? I though it was put in 0 length and look for EOPNOTSUPP,
> > success is not expected.
> > 
> 
> Reading the uAPI comment [1] gives me that understanding:
> 
>  /*
>   * An empty invalidation request array by setting @entry_num==0 is
>   * allowed, and @entry_len and @data_uptr would be ignored in this case.
>   * This can be used to check if the given @data_type is supported or
>   * not by kernel.
>   */
> 
> Hence, for a supported data_type I expect success..

No, you can't create most of these viommu types without giving actual
data.

The comment is unclear, it should be looking for -EOPNOTSUPP.

> Also, the selftests check exactly that [2]. An unsupported data_type gets
> -EINVAL from the drivers today, not -EOPNOTSUPP (happy to switch if you
> prefer).

EINVAL should only mean that the data inside the struct is
invalid, but everything else is understood. If the enum itself is not
known that has to be EOPNOTSUPP

Thanks,
Jason
