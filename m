Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D31AB515
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981658; cv=fail; b=eyCjHj6C79yM+7amnqTOXLM/S4caeZF46Zwk9pOC0kgY6AT8SndvS7beN54O+8w45xaP1AHAoln0i5nlvve/Z10xIKV0xcCNI/wn7J2bkyZxseulL0uiEa/QuqLgwXk6hK/WPCLHMIE/8wCt22tpWduMGE2DL7tA7U6aaWyZW8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981658; c=relaxed/simple;
	bh=B2X3EdEhJlTO5aRzWKvD9Qh0NfN8qkqNguZLG6wnoC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WhMEmJsNWwF5xhepS1hPy5fCt+tJWd5IFI4x05HbiCEj3DeW7hfSRhS4s//hS7UXeYr8mEM4NegoWZgQxqwDqvGnwLgPFBODeu7deClEh/S9OqN3XuN5Wtm1IcHGwGW3quVK4oSjTFFLpXxP5Tdz626Suy3kqDgEdRPI18SqTk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDihJetR; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDihJetR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsnEFFdb+n/lR8cJtONiyOpjXs5TPRGi2tKLzzaO5kqg0AXsZSa5neqFioMvF5kwqIOP9iF1sbceUhpwsKmD2njd1qAV79tEWmSvZUElepudGh72/nNg83qpYOM+qlPCj57e2SPeyvjHvVhb27RumpRODeleDSjfVtLEzRqjRvB/F55MZshNW/YVaOVfSMVtJILdSqkuydg7Jnz8ztrqMEEx924HNlHleliwebOx6ySfrWR7rjZhSR7kFw43SKVEJXOAyyVvnjvFnFc7BO7dJY1hKtPbj5jkyMOFZqF+DHZufGi8R7zXoeS+E5rpvE1FGW1agvRgNXhqN5mOJHvqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQJJ7Fi8BK6kdsRmrq72bMUVCWalScwuoZNstL6w940=;
 b=dRcV0QDHzHILSFY/I4YeQNuxN2g9XHI4sNh5bMx7EEPiOYGF5PjO8g9szQDBkzLEWNYOYw7FE4da2KzCcLOVaP77Qzf2XvAsmOagH1uVbuRUGGE+JyMpB+cQNh3LPDRPL3lxLhS3LtrQ3Ff+PtSuI62+VoJUNilooexEptzIQGWAgnmDLHSE1nbzqhCMBkyWPi9OESa4koW3gS9TJb5LfivtDky3Yw2M4213bDLnh03KwWJtz8SuGLVzvHHl22MaYZbh816IMqWRdBkGLaNWybxsiqjC0Py2tzjakI+zszTQF7njZsNqD1PYjiBcYG15dkXTcKiCUMtlIJYZYA9C/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQJJ7Fi8BK6kdsRmrq72bMUVCWalScwuoZNstL6w940=;
 b=VDihJetRsZ/pCUuNuc7hzXwduL8wi+YqLiSiKB/Ds8+aufBoz+SfANCAen0Snt+ipAecvy/7dTO/zDBPxo0bFDkn6g54OOmP6EeLZcQCBXJxNrPi07vI0sCEMZTv1qjpZ/AbViPha9TYOGoSDUIOxuuZ/oTVZPc8/+3vTyRRHgcsrtZ1FsZS0Wu2IpYTw8eLqIwO614zBKsISDQSoewYlpSIvRXZwAo6AYIKJ9qQTSxXzWOsJHhOsj4plOg+xirCAsehd7ED3gL/egqXBJLqXuZ0IreRxwaZsacjoSRufbq4TxOtncMcc4SJFz7Qa4BAMqq+WJ4JtUHjseAbbsJF9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 18:54:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:54:13 +0000
Date: Thu, 3 Oct 2024 15:54:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v4 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
Message-ID: <20241003185412.GD1365916@nvidia.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-3-suravee.suthikulpanit@amd.com>
 <20240926194607.GP9417@nvidia.com>
 <fc5b7217-49b5-4ca0-b4f7-0eab5000a2e4@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5b7217-49b5-4ca0-b4f7-0eab5000a2e4@amd.com>
X-ClientProxiedBy: BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d42167-528c-40a5-f250-08dce3dcc5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CzUqKQ1ik0usYXeSbvRtpwDeNX1eiLUDgNcmqcih3s+nXEx3S4Tw2y8kDIkl?=
 =?us-ascii?Q?lEJThAneKP2hgbE0eZFCJ6fBEQMCcsr/KxHIKu7ZliFY/ycm2N5v9lFtFufL?=
 =?us-ascii?Q?uE1QDUWJruF4J2J9Fxe2+Qs6XxiWPqxqWKdMi/QrOZFEMB5wPirYy5KDzciQ?=
 =?us-ascii?Q?xiKMTLWBu3vrMcn3yUnKXF1OApczAZ5kmLe9fjsNQ38eb3M2jQzxwp2p8lPb?=
 =?us-ascii?Q?oNMUen7h5m4cieGkYq+7qYV/4Mx2EzN+8yMdvUVI6ZDbzYU+h0sNARHTVjDv?=
 =?us-ascii?Q?vDqeFgHoAh9+QysVSLTajrTLeBuWBr7PRrT5J9iWICBtKMMMVO3LdBRJl0lc?=
 =?us-ascii?Q?rLebTHHv19/sYGSVpKKB1/Zxo1PeRR+m68kVv24IpzIR3pCaT848J+PGJAeO?=
 =?us-ascii?Q?5089UFaF87Yn76NFiuAH1sCoGqwaRbsEn/j/G/0HZouWCf6CjLdKbYymWKh6?=
 =?us-ascii?Q?7STcJN6Uksu5SqgR91gxmH0zU9CDpjr/GOZW1SGdZ6qLMTGXi5coBUhNtEuG?=
 =?us-ascii?Q?dsmNIDE7DB9ohZnBEBilDAggw2/g9kEnAi0nEf208iJ9fPz4QpTqZJVKqyVg?=
 =?us-ascii?Q?sZ/1AxQLFlCJFTEZ7xf5dVx96x4xj/G6RULTNTKI31F/H//+kzH8eSMmSWSR?=
 =?us-ascii?Q?mCUnQBALaPyYlz/f6yVOHOkjN3Pjjj7f2CJKQQJJFlpxHDUs+UZFqCr/CIZY?=
 =?us-ascii?Q?RheWqzQ+Pf0+oOBOXuBX/sXyof6pe1hSyt/JlaH1MpM6gALm2lvF/S8o4htd?=
 =?us-ascii?Q?+9NVAp4Hzs8wrefiW64ewu+GTztQsFg9RAaYxMFQ5x0vtBb4Aliulj/Qn/GT?=
 =?us-ascii?Q?AZEqUvIvhDPEmZVRwsjmh22cFfnT5BTsNxaxSGahRgz8Klszr5dquRpxWBvI?=
 =?us-ascii?Q?HAhff6P66FONFEZ1rfXdKcIeHwfUVZ0yPJNBGBMlBgxk3/7HIizlrB+Is+LS?=
 =?us-ascii?Q?PROhFCe4sC0hjK1WcF66KPtlMWXlSfLYwuuoERstfP9XLI4bXCrxIwCkJB4n?=
 =?us-ascii?Q?ENu3ZYj3vatzvoMlCZH18LBaFL3u6UHeH9zUvlBk9rDyHRaTNaZS4RgutZAy?=
 =?us-ascii?Q?zZI6UGHxv0nE5zj3uohO6J2stSMGhEI2hJhe7+uMrWKmJqW9BZFpxCyKuNzV?=
 =?us-ascii?Q?7xvjE+mEcCl25dODwf3qrDejqem51CoNLdk5GajuBvZ05fN43qVilRxUsuHp?=
 =?us-ascii?Q?FCuDDOrQYzSE2psWb9cvNxwW69lClSzu5dzo23M+wRzqbdCjHHLwjioUZZEJ?=
 =?us-ascii?Q?QkFqFVMDtm/ndxCUmx7Eu/oNrYuI6qMZJI7EYiqbag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5/fTUm8ber7PIMyQY+BYdXRA4w93wyA2eUrQMOCZuYXfQuDFTWj7Y1ZKlsqX?=
 =?us-ascii?Q?F4+UGyU20ygd8AOUb0FHuJaXbIkjSclKRa0wT0K1D9TIiBeCvTVByEI+zuO1?=
 =?us-ascii?Q?uYy2qFQIDer3EmZR1xJnySALHslmxyKJCILbcBMgvcXFbXemHmpyEaoWiE5e?=
 =?us-ascii?Q?Y5zDGLeglXy2lu3aapOLAui51BoiWLxCoaVjZQ5tzJBBVEBmu02PCPq8WzGp?=
 =?us-ascii?Q?pCXYlT3lcMV/LZAerzLUSk9joas1UbsIgZaXB5COpc361IxKE4A5mzYkixg1?=
 =?us-ascii?Q?rDrd1HMHFGXMlAHlRvEtkWb03LYUT4n44xBzHpsf2b3zbxYtF0ELO2GvIStj?=
 =?us-ascii?Q?iD2a93SrQnZe3NnZbF4GrXFXfm5vXVSdRPvnBgovU/Gws4QjIQwxdA3XloK1?=
 =?us-ascii?Q?8uGZeDIoFKivOUFwJj8dqNa+2/8BmZhWtIPdxPkcR2Len8fRTA+ncOfdNaDr?=
 =?us-ascii?Q?1ZcHEkU72+MR7r7UeF8l01LqS3izIaq1vORusmqJn0yiNBlRWxekwAuLAEOO?=
 =?us-ascii?Q?SQJq4PvYrBMwT24WiL+wP9wtJyz0cDi+mAmRjJbbXK7qs40+FYnfq30CPQIC?=
 =?us-ascii?Q?LIlLcoMpajM7pM3FNvtURG/9W7nj4igawgzBmMT20QYl1cccu/gZvUas1UF1?=
 =?us-ascii?Q?CeiPLXSeiQrs3vlOrkmIj6ghSHBzdmQ/o9gdxneYfJfDDaoT5Nc0tU341nmg?=
 =?us-ascii?Q?+lxvfiGIssjVAq3bjn813tp1XLmnzHbj5UDz6/pjQQ9nmf8iTEWW35szoyVX?=
 =?us-ascii?Q?dSEidMhU7zjkNyV6lUopHSjZ9l2sWZSydguLWmC/yXCWKaEOQDxDSWfvX1GP?=
 =?us-ascii?Q?X9Gm7qThgsx7zLj9uEqShVCxfxft5WFyTmaWAF9eo+h/mNGjDW3xD2Gbl5ZA?=
 =?us-ascii?Q?e4ocTKg0mOTP7VkgVEAugq4UlO9EGKE9AacDlpqI74+hOk8r8I+WswLpFvYz?=
 =?us-ascii?Q?MOh2jV8jiZ7X11tbuU8n05rqvob6AHIxB+RB1Lrj5bYlgrLOpQOdCVbOwxrF?=
 =?us-ascii?Q?FUSkRZO1tr3/jpxBjaxGDTpg31LOACa/EdmcXDJXuYZXzOoAVg4PcYB0Dhp4?=
 =?us-ascii?Q?IU7M/WbthRglkcj5jVkRdT+qHsPKI31USf53BQ/VMu28n3+u+I+6D3FhbMUi?=
 =?us-ascii?Q?QmVotwPicgowbGeXtz7SX+CKzKNaRhyE+2InWpMUtQeadkP+r9z4IduFiHUW?=
 =?us-ascii?Q?nGBMyiq1fW68+FVIC2FXDrBBdwmNWvgXkxYh816ZDEiUb2VqwZBsMXTBvKeH?=
 =?us-ascii?Q?EXhW7VHFS9LA9wu7Lqi6yzJ2V8UhPd5wMSXz76VWFSxv05jsgQR/hbaTqywy?=
 =?us-ascii?Q?13qCWKB/Pdym9OzkQrOItJrLevUKbTzncxgS0BSmwM96VskkFK54VmoxijYn?=
 =?us-ascii?Q?DfEnxea4OYchNJdI+rI6Ma0ovayrDWF3bA3MZO/WqA8Y97PFmMC+447/rM/c?=
 =?us-ascii?Q?JKXCAXEt8p0I9/t/MRpd2vPCKjqPnSzUFpfQ0CvE+RiKUtFGMtXIrW4oLhry?=
 =?us-ascii?Q?TiK0VDA6R3Qz0hBr1WSHQbGyq/UQtueCLHCL2bn8YdaGiHSlQdCIr7ZpuxsF?=
 =?us-ascii?Q?xQp9nnM9HtfnvVGuV2Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d42167-528c-40a5-f250-08dce3dcc5e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:54:13.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25cO4aa51M1xfKKHlNQOFHMWacUfpi1SPn0jEqX0j5YOY/Vwhzqbmb9JlUBVWXmp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502

On Thu, Oct 03, 2024 at 11:15:53PM +0700, Suthikulpanit, Suravee wrote:
> On 9/27/2024 2:46 AM, Jason Gunthorpe wrote:
> > On Mon, Sep 16, 2024 at 05:18:01PM +0000, Suravee Suthikulpanit wrote:
> > 
> > ....
> > 
> > > +	if (!(ptr->data[0] & DTE_FLAG_V)) {
> > > +		/* Existing DTE is not valid. */
> > > +		write_upper(ptr, new);
> > > +		write_lower(ptr, new);
> > > +		iommu_flush_sync_dte(iommu, dev_data->devid);
> > > +	} else if (!(new->data[0] & DTE_FLAG_V)) {
> > > +		/* Existing DTE is valid. New DTE is not valid.  */
> > > +		write_lower(ptr, new);
> > > +		write_upper(ptr, new);
> > > +		iommu_flush_sync_dte(iommu, dev_data->devid);
> > > +	} else {
> > > +		/* Existing & new DTEs are valid. */
> > > +		if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
> > > +			/* Existing DTE has no guest page table. */
> > > +			write_upper(ptr, new);
> > > +			write_lower(ptr, new);
> > > +			iommu_flush_sync_dte(iommu, dev_data->devid);
> > > +		} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
> > > +			/*
> > > +			 * Existing DTE has guest page table,
> > > +			 * new DTE has no guest page table,
> > > +			 */
> > > +			write_lower(ptr, new);
> > > +			write_upper(ptr, new);
> > > +			iommu_flush_sync_dte(iommu, dev_data->devid);
> > > +		} else {
> > > +			/*
> > > +			 * Existing DTE has guest page table,
> > > +			 * new DTE has guest page table.
> > > +			 */
> > > +			struct dev_table_entry clear = {};
> > > +
> > > +			/* First disable DTE */
> > > +			write_lower(ptr, &clear);
> > > +			iommu_flush_sync_dte(iommu, dev_data->devid);
> > > +
> > > +			/* Then update DTE */
> > > +			write_upper(ptr, new);
> > > +			write_lower(ptr, new);
> > > +			iommu_flush_sync_dte(iommu, dev_data->devid);
> > > +		}
> > 
> > There is one branch missing where GV is valid in both and the [1]
> > doesn't change. Ie atomic replace of a GCR3 table.
> 
> Not sure if I follow this.

Something like:

if (FIELD_GET(DTE_FLAG_GV, ptr->data[0]) &&
    FIELD_GET(DTE_FLAG_GV, new->data[0]) &&
    (ptr->data[2] & DTE_INTR_MASK) == (new->data[2] & DTE_INTR_MASK)) {
    	/* GCR3 table has changed, but the same number of levels, no need to disable DTE */
	write_lower(ptr, new);
	iommu_flush_sync_dte(iommu, dev_data->devid);
}

Jason
