Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A91C10
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908367; cv=fail; b=qctnFS4+0LHW2mYMJwmL01Xq6Wh7jIaRdjq+66BLhSVo5CR2dBS76mbrrDu3+h1g9QPWdKflmmakMyJmkLzbYyv8Mu1eRuVyLtB4mu7chz2+Ik8rOuqTcq8S65feAESVMmMPus7HnmTqWfGaNNoQ8Z2pyJMyKQEIO27klKejsx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908367; c=relaxed/simple;
	bh=epp777TYM8JQS/PZ+v4W2DIvcjT2ofndtwX8J+rx2ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nr40LkLOTSzlkY+T7FDHq4CdKrU+vYv9LgO58qRCjSMb4zAnQ9mLTa24FiK2VZ6TLRYKQdQPk515qrhufqTUbZp+Iq15TELKUkUNJ+Coc2YkiczrV6ygOCocbie9uYU7fNBa8pNjyMZproFuY+J/t0e6Oz2VFn8hKjutTcqpagU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h17R2/fE; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h17R2/fE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq4seBIVSPxUwRMKr3F25sg/uM0F/KOJ6JFhmdsdamM+Ie5T4E4bZDAh1ElCblDrd43CTpHaXxmlKgTO2rxe2cwaq93UsNhD/Zl5qHIFIchmurhU3IUx6farFdVni8Df0C5WbcVRqErkoDhoBj8tJE62BkUEiI5HlYYcwAkpPWaJOGno5nZitofYxHgOExB2s8gYxPNAmGM3XtZIx9CS938cFcFxA2W15s6jvFqynyObYvr2Tw/7H1NZRZgtz6wkTVFSLZSVvTJ2f9ilW0XkQCQteXy1+kpZaSILyFjSFgShqIVtXjarCP6ijN2TXgYHMsSUBsIUIPZIZ0g6DLzqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EstSNjReG/5cft/N0aOOZxvEucfLKTQO+q9bGLOg2U4=;
 b=KwU3CBH4NDtsGzIKUtqtblHwI+vGuZPtd/U/5p9tniEhCHaD3OMfAEy6OssFApHQq4ca9D52Rt4GgDJqYZf4uOSVPOa4GTDmKP3QxPf1TZRrQRsrv2i+aYe5tzbZCGQNGIChHATV3iXHNGwwfXR6+7XkOE/ycSU3gpgckRd+rj4o/TfjT6S/a3woKouUxNlblm972In+pQk47c6UmiTXtp553eTq1CYyBt/LwNnTyBSZofNc62qMPaDkWHNEJqgUZlx8aVhOSDxXeJqSXwYayHs9rYnXdGaITnN01VWMVyjw8PBO0rNDJD3OHS+0/WJav/ehg9xKO1K40lOOTufLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EstSNjReG/5cft/N0aOOZxvEucfLKTQO+q9bGLOg2U4=;
 b=h17R2/fEOIiD5hqA26uKO9xBNB2FV/2P70CYOl5uXAHeNvYcYoZesxinpRl52eOuHYwx4TxfvQbCzCF2k+Xi1t4nZ16fzMfPj5wBf1hUCbo3GLXCkei49La0Dj1J3ESFIsgdAOsfaObwU0jkIZcACXurtJeyLLWSMLnF0n92uLeXLCXPPrShSwBfLRSoCRjLpO1R0Q5FefT5nkv77e+VxpNkOK2e8gH/2QkYiNdx1rEbJREZmkn+RePcI5C9bh/TJObXivi4kXrQAAdC4BHalSvl1iCJEnri2usbL8l/VjhyGRUsFqMOPKL0tXscQComrWFaQNo8Pm9oYdkerV2lqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 14:32:43 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 14:32:43 +0000
Date: Fri, 8 Mar 2024 10:32:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Message-ID: <20240308143240.GP9179@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: DS7PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::23) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a8ab31-1f3d-4583-6b8e-08dc3f7c9d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NmKyP/ImD8FcfWCFUYJG8oANyjOnOCnSUDNUiMcTd/PTYvGa0EVKpNdU84WO/DPugKCbibcd0jbo9jg5AdkKptbpQZD3t4sigM15toJpRZKrc5V5HYcDlm1+NZVeiIAhGSfjaaLcH9IWrOUBBWNVfksPWb8M0p4vNgBGLJ7EbaP69VfGc2QdC+Lq32lxP/8H2WBekhVB3SYW/gpgOcY10OgJV3gWaRxXT/W+uQC6I3V+WkevZbfpIqVYTJdITVxtDJpdoEJYP6KTsmBV2/qBAEVAsINlbz7cMWeReWqz2jM6l+JEQ0i7v7JuuTmlrtRrLQK+4Mp/hD7fxQatzW58Bvx5FCRllncl8KsRRjev2SFGyH4PVU2zUzZKNZj52HR8lkS6KX/AltjS7uQqGy86wrbMTF3U9esnERv0/YdnghxF6gSaaKttpOIa3pVmy3gWQaxx5Aslk7mvPCho57/thl/Zo2FtOlCvOxFweEZ+v7sB023zCAW2ixZaEWq2ZcBaXexx7APpFUdEUIenKm1fJATS8PgYvUyph49xhnB7xgFY3qN2ol3EeCvrGhK0f9QB7I0qc04sC55AHycjYfno1gWNDsu5gwNAUTZ9vBWofxB0svy1GWFy/BFDVtv8I3rDpXTy9Qq3Qlpp9q9+OM1p8rbt+I+ATQKcQNFvHvCOMW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm9QY0Z6SUxFUzk1RmdXYldKa254TDVtMHNJNzJSSUJydVNKaXhUUlJZL1Mw?=
 =?utf-8?B?T0RUTlNHTWZTMDBYWHFHSmdzQkE0S1VyRkZwcHRLazhLM2ltWUIzOXlTNDdB?=
 =?utf-8?B?TlVnMHN2NWh1TXJIZ1RvN0M5cys3ZUZtS3IwajZGa0liSm9TTmFzUEEycnpG?=
 =?utf-8?B?eDVQMyt5cWRwTzkxWjByTVhsSmdXTk42VndrYlVjNFBJL2dZVWplWTMwbVhh?=
 =?utf-8?B?ckVsVHFpM0RNLytWNkw2SGVaSGg3cVU3VjluRlVxWTdYbmcvVHQvYUdORTg0?=
 =?utf-8?B?cVZYMXkwWGpXekJSTjJxdUhyT3VjS0lta0dRMnVHRGQ3VlRXSXdsakl5WEtE?=
 =?utf-8?B?MEo0ZTRHK2xmYm5XYTBjc3NzbmNBRzJ1bUtVcGYzNEZ2bC8zeTYrb0V4RkR5?=
 =?utf-8?B?Q3dONzBPRVN5U1VsSzQ0bWxBOEoxK0hrRmtNNzY4VTc3cTdtcnBwQWg0cjZq?=
 =?utf-8?B?V3dCRDhVbVZ4Wmh2WUVJY29NTEQ0cHAwUllNMVdDUXNPQlFhb0cvditUQUhM?=
 =?utf-8?B?S0dzc1NUMHNFNGhmUXJpSldZNHh6THBxb3o2QjZ4eDNhU1pLc1R4L3VneUEv?=
 =?utf-8?B?eEN0NGxQNGtrb3FoU2Q0VVFGd2VLMEVCZ0VLY1djazVaTndibk1zU3MzcnFX?=
 =?utf-8?B?QThJdTlrYjVKNnlXSTFiUml2eC9PRHJyWlZ1cklaZSttcjhNUnpyOGRteEk1?=
 =?utf-8?B?SE1HNXFvK0dQNDBpcDR5WlJMZWxUL2FTOE9NaVM1ZUR1ZmthRXB0SFRVYmJH?=
 =?utf-8?B?MEFJaHlVUVF5Zng3K010djFZcThSWjROZEpZeTI2M01MY0FoNStHOW94Rnpr?=
 =?utf-8?B?b2VVUTF0UkRiaHBjZlNINWJzVmJKR3NXV0l3NEdaa0FhcEN4OS9qVUZic2Ra?=
 =?utf-8?B?cFB4NzVvb1ZpTDNGZHJaV2RjSHBXQ0tUeTFtQURXN2FJSDI4RmFiMUdBdTZ6?=
 =?utf-8?B?anNVQXMzU1hQRGhZZDhnbG4wL0gxcXBBclNZd082YUlUdVVqMEQzMG5IRnVO?=
 =?utf-8?B?SXh1MXNTSXkzZ3YyQzE4UlBiRElMK0JyTGxUQXhMSEVkbmc4WjJkTlpFWlYz?=
 =?utf-8?B?dFBaRXVFTk9KeGFiMktmbFRJYW9hU1BVVXQwN08vdnM5enU0MlFEcWhONk1w?=
 =?utf-8?B?cWZiVE1FelcwS0JoNDRYZFk0RWRCWkZvMXJiUWM0RExYSU9oU0RueVo1d0cz?=
 =?utf-8?B?bFNIUVJqeXpZTDAwbFVPVmp3Z3E2NG5LMGY3WEJrTjVlMDVFZXphd0d1cHpz?=
 =?utf-8?B?NGVjek13c0NLeFk1RDNiOElVWU4yekFCd21rZUg5eGFuZWtoU1grNDhjR3M0?=
 =?utf-8?B?THFRZHFDUWRmNkRVeks2ajhoMHh3TEFCUkhrNmx6N2tiRm5lZlFJWGtwNnFK?=
 =?utf-8?B?R2xKb0J5bHB3c1p5TEpOVTVORU03YkpPNWpxd1BFOThZVkloZitDbms3MnBL?=
 =?utf-8?B?VmFSRm5OKzc5MUwzWTlPUmlnRXlzUXJnZDVidlBCWndBdVhUeEVCQm9mcmhN?=
 =?utf-8?B?MjhmODNFdVRIWlFlakNYZDcyTWplakRONmg4WHdiNnJ4Z3N6UkxNNDhITExC?=
 =?utf-8?B?VHd3SGhreWZHN2JDWWhQUUVzVVVQbmhiNkRQeTk0WmtDWjdWdkFqZ3MxVjlJ?=
 =?utf-8?B?N05pZkxFN1R2dUdzemg2dDRtdWFNaGNDQ1ZVTW4rZjErYlBoRUEzSzYzVTRO?=
 =?utf-8?B?bWJabmpTQlJpdElQSm00T3VhVnl5Y29kWEl2Y2Z2UU1kRitwZEFOOXlncEdV?=
 =?utf-8?B?amVkeG5iSCtoa01kaUUvajdtbHJqMFJIZ3hpc3oydXBQcVNkTXdlMEptYnJz?=
 =?utf-8?B?UVIwWTFxUkFmSG1xcXREVGF5NWI2S1VaZUI0enY4bEVDVUJTY1ZLeHpXbHox?=
 =?utf-8?B?ci84K0Z5Mnh6NGFBeithZXRaK2xnWXVyM1d0TlQyOWo5VkkycEJqQ3NmYjdY?=
 =?utf-8?B?ZUpmTEo5UUxGM2hzWkJNcGpkbEY0VTNGdjVWZW91UXZmKzhUME5Rc0p6MW9Q?=
 =?utf-8?B?UlVRYVpaV1M0OEFWekJjVlorVkw2RnhPVThMbnRjc2lkUjd4cUR3V3FUMWxs?=
 =?utf-8?B?S2Q0OE5KUmZQbjVMNEFrdUpJS010QXJlS3lLbVp0Yk50MWo4OHRLd0ZoNmRk?=
 =?utf-8?Q?JpX0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a8ab31-1f3d-4583-6b8e-08dc3f7c9d78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:32:43.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLvY/f9LZ0F7DC9xlK8+pAqyhjMUsYE0hqX25M9ctQIIDvpSf6FGq5qdav9F5YQ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976

On Thu, Feb 22, 2024 at 09:49:23AM +0000, Shameer Kolothum wrote:
> From: Kunkun Jiang <jiangkunkun@huawei.com>
> 
> If io-pgtable quirk flag indicates support for hardware update of
> dirty state, enable HA/HD bits in the SMMU CD and also set the DBM
> bit in the page descriptor.
> 
> And now report the dirty page tracking capability of SMMUv3.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
>  drivers/iommu/io-pgtable-arm.c              |  5 ++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
