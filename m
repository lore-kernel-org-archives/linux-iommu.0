Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C901B6CE7
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729903; cv=fail; b=p0ev25VW03YwrloiNzWX5Q+IYPqUv1NjMS5FnYQR0eZn/CQfX0SJw3LHqIgMyVage+nscx7mTXYb7kpo93HqR3YAlzCM4aVYgHmdVxOtN/SX6F5aXDNJo+DnvJo0n9zLp9K+O0Y6fSfwC7365c6fjEc7U5PkNBsXdgUysxyK/aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729903; c=relaxed/simple;
	bh=1OrYRogO1vbO5+LMZ3uLEOrzdyJ1e1sb6pwFUi1NSdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DSPqsaPMsPQ17UQfDkA0skV9abpYw2a2AGO0GMAoNGCG1KkRJUfXwDycGs/PZUB0HMV6rnhqSMVjpbPFfQFS1DeuU7kfIJNjtrwVqKR5LVQnUdeKQNkZgyEafRmUUTSfZzZXC9R3EkYUGTnv/g/I/aTjlK2zdxGsiwFGSzR6bYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RNHeFfZY; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNHeFfZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcEp6/ugO1FqYO/yInzeJZieDrW+T3VrFZji4LE62+KYAYLGssBcHj3pP0QW/bO5VQceZ4P+yulb1Z4wt7daijlm+K8EuFW9Msb7imtOy53NdcZtiE9fBlnAgLtj/dz9T2oA6N6ZN3WZuxhM0pEiYCqVX3RK6p1AKF9h35g80T7JTF77+VkzhzcwRm3/T1NMSESEGyXRzWQRa8tanuFx3UryWy67mJ/aliUE4oZDIL36+zIueOJTBglpMZ2oSs7zycTekJrjc8EfWgGJgqFsyAuMxegyCTpoGWdMcjevCKGWLFNHvI8gnnDEjYjPmKqederNZKNCFd1hKihhV387vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oehKuUAvNigg8pVPXbgosvp2MLmA4FTukjp/ehLrAlc=;
 b=ZKq0GeM7Fs1lsyEtZaL4pnIuo/8jrwMeJ3Dsk/uOjEBEdUoYGfcYMcGgoCcKreiFjytz3MP80Q7uW3XoyqQ8srUnDQSsXETZMq4Fq4R7lIy0T/PvGPnmrC2av3VtVmzmv/kBdlcHFbuqiZ6wh+4v4ZqQjgRB55JyalECmxoQpWy4EH2T9/qd5HjHbDBr9bJ16A/tgmp8CZmIvWooM/vjp1ey1qehg3tfh9fZ/epSpOCckE6Z3YCrbsHZJnJMH0n7jUGIYZdxEeMxMDgfEr94yOGE1zK8NbGd2XhW4E73Xf65MzRfNDQ4atXo6ayhsg5Q7FzMVWZadoDtYvJXPI6hUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oehKuUAvNigg8pVPXbgosvp2MLmA4FTukjp/ehLrAlc=;
 b=RNHeFfZYNAXQCGI/f7iqoLvWjF6AkXG7FIZK8L91gnEGPGYPhLPY6FXYLKYLW/fvfaUsmhgHPPbbVEhgyAHdT1L8J7BEHjxwanvwUYbDVJ4ISC0XCeHeu55FCoxReDz3SpCYyVY3mZPT/bl9Y7mZFQp2p6wYiVTpD+raC6MGUSvOQw5AhEu51yQ/8aix39mACjdl1CGpGwnyTcA4J2S9qs4WIuwkoNvCMxULqBkP1L/rO1kIYWIa7rQamOWnEg4m2mnxhX/gqwwe/Q0YuwRd3qJSl934EsO4goUUVLSt07GDZbMPY/QsF96Jl+JlLJ0PgC0ujn4xFvR1xRxi1BXHSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 14:18:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8114.015; Mon, 4 Nov 2024
 14:18:18 +0000
Date: Mon, 4 Nov 2024 10:18:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V7 0/9] iommu_ioas_map_file
Message-ID: <20241104141817.GY10193@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <20241030001102.GA251312@nvidia.com>
 <1bde901c-980a-44e0-8f6f-8e1985683349@oracle.com>
 <b4fa2db8-192f-4cfd-880a-5e29bad58f52@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4fa2db8-192f-4cfd-880a-5e29bad58f52@oracle.com>
X-ClientProxiedBy: BN9PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:408:fd::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: a26814fc-4d9f-429b-0db2-08dcfcdb8765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3M3L2V6aUFlNWd6Q2hDZnRUaXg4VXI2UURscXMyQmNyRXhpWmlLdWVpMWgw?=
 =?utf-8?B?dllIUkpueWZzVm9hQmNhVnhROWRvdVZoQXpsR3Myek16ejl6MUJBNkZNL2Z5?=
 =?utf-8?B?M3lxTjZIMUhnVUhrK0VsMzc4MExuYTN4Ui84bkZxazRiZCt5WUNaZmhkeDZw?=
 =?utf-8?B?TWVzR1BINUJlVTFMcjJDMmZIM2tBMmpxbHcwbmtMWnhmdWVDRFNiMDFZckJF?=
 =?utf-8?B?MjNpaUlCL0RETkpOVS9aU0l6ZHlVbDJ0b0N3UEJEa2ZDUWdYVStqdmx0RjZE?=
 =?utf-8?B?WHViWlJXSG5oS3JEcUJjdVBmMWZ5WjZrampGc3ZsZER4enBYaDFrWHM4QnBw?=
 =?utf-8?B?ZWkxOXF4RzhtZVRIaWVtdjJKMmNYT09VeURiMWVrcEp6OGxWWTJrOTg5RzZu?=
 =?utf-8?B?VUhNTzdGTFdPdmtET2QwUU8rZXdlYXRWeWRXNERnYi90K0dLdVpBSFJ5VE1o?=
 =?utf-8?B?bGxiU2RZdUk5Z1JmaWlodm9lSkEwUnRsWlZ5NzVtMzNJMjM3K20rQytpNWp3?=
 =?utf-8?B?bWZMTzBqOHBhSTNEcGtmaGdDZzhRam92clMybmZiVlBCT0FjdWU3TU1BaUkx?=
 =?utf-8?B?T1Q3TjR3T2ZGb05SQi9ERTNoYWdIQTA1bnQ0a0FESG5yMms3Q3M3WVd2Q2FL?=
 =?utf-8?B?VlZEZjhyUTlYSytRMHZ0RS9ETUYvRUdxVHF4bmdMUHZxY3FFSlNjdW9kWVJa?=
 =?utf-8?B?d0ZPdjVMYzVEMVRPTkZZb0JZRnlZdTdJU21GdWNiM0g1LzdkWTBBK2hjOE1E?=
 =?utf-8?B?aGRLV3ZDY0ZpRElza3F2dVNSY3FHUzdGcmdiMW83b2lOeGZJZGpmOFhjaEgv?=
 =?utf-8?B?Z0EwVHRieWlNQnpaaFNQQlh5WVdzQ21qUWJqRWhxNGRwUGNHQk1rTlhHNmtP?=
 =?utf-8?B?V3l6c2lNeVRERGdmZmg5YmJ3dmVqdkZnQWlhZTNKQW4yYXQ4T1RrcGE0UnBy?=
 =?utf-8?B?bVQ1R3J0Ty9zdWVSTUY5c0lRR3ZZK1ZhakdMR0ZkKzRndERnUVN4ZUsxN2pP?=
 =?utf-8?B?NE91b21BaFBFKy9yUjZTejFPakFOYXF1bWM1dUhHa2NsT256emplTWNkdGpH?=
 =?utf-8?B?NGlZUXBoemRyRkxnSkhUUnZqNmsrM1pFdEt6Wjhzb1pFNWNOeUU5SUdFVUlQ?=
 =?utf-8?B?YmdWOWxmM05HVWlpeTZ1TCtqSkpXcUhISmZDM29xTlpIZWU5QmpwL05EbkdI?=
 =?utf-8?B?RnNZUFN6RU1iVXB0ZDBYckhzSDZSc0U2MnFoNDIrMXJQTDdZbExKR2QvTmxv?=
 =?utf-8?B?Z05IOHNoUHczM2RldGh1WHVQc2FvNmxRa252RlNPSGE4Skd5TUlrc2dkV0hV?=
 =?utf-8?B?blphZDhxazVMa1NnbE5FQ3p0WWtocG1GaHlndFVJS2VFWWxYbEhSMVE5Qk56?=
 =?utf-8?B?YUhvdnpYSmtVT0JLMjdzZStBK05xQWozd3A0M2pDS1RVV0FsRDd0UDhvM1hn?=
 =?utf-8?B?aFFXVVFXc0F1K29iY3pLYnJBdEgydm5sTkE1NU1Fd1E1TDd5c2lWWURORFpT?=
 =?utf-8?B?cU1CVjBsUVBtVWVqM21XMXB0NVRNdWdqOFpDQ3NGNDc0cUVqSUFSZ2xPM3Fl?=
 =?utf-8?B?QWFLb2lrMXhjUXNLMzB5WXg3ZGZYenk5amRsck54K2JLaFAyNnM3dW05WmZj?=
 =?utf-8?B?TWhja1ZMc3gzOW43clpoTE9IY2ZCY1FsMmZQNFZJd3hINi80eWZBKzdka2xa?=
 =?utf-8?B?Q3hQMDY5eFhCejJyTXBCYmNBbXcyVWdzSHVJK1QvYStaNzRRWjEwOGdycDJR?=
 =?utf-8?Q?7T5TyTkJQNqje9l3CGSsQbgaBMO0EDRCD60L50s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFFRRzBxRHdYeHM3MmhoMHBWMVkxYS9Pc2ZyOFJpMm5wSlRlQWJGcEp5QytP?=
 =?utf-8?B?RGR6OEdWQlFSeGlPbXY5VzNWQUVDMUJyTGpncExvS1V5UElFaGp0L1lGeVl3?=
 =?utf-8?B?NXVJNjN1Sm5IVGN0dWVBRm8vNmxaK2hTMVlDcnUxQ0hyNFc5OHFkUGl4QlpS?=
 =?utf-8?B?ZFFMZ3N1RnVWYVNPNDdZWnhCKzByRm5hcXlNU3dSVFYzc2FON3oxSzMzWWtp?=
 =?utf-8?B?ejRqbXhrZW5hcnpZM0cweWZ0eGloVEkyZ0VMQ2NxVnZpUmdpbTlmU0pZbnR5?=
 =?utf-8?B?TmpjK3Vjb293MnBMcitCaXVhQk1uc0w1Tk44QTJCd0RwbFVzWFNnT0lWZ3k5?=
 =?utf-8?B?QzNPUFFHclI2a2EyWjJDbnRLVm1Ca1NueEtyOVhaN2N4YlF4VkNZbzBZaHNw?=
 =?utf-8?B?dENOL2UvajFJcXpMN21rVy9tYldBOHdldGJyNEx6N0ZVRDd0OGpVRTRSam02?=
 =?utf-8?B?N1M3TGlUZy84L0VHcFZiNmNhWWV4eTFIMmYrcTE3bHZMNGo1UDZRdnZld3hX?=
 =?utf-8?B?bXNHUktaMGdSanZ1c1BQS3VqRTZZaDBGWVVzWStDRnpXQ1hpVG5aSDI4MVdY?=
 =?utf-8?B?bHRSaElhMkVzelRma1hQQmVWR2hIcU1IdlRXamFNUXBHdmUvdjhMeCtqZFNi?=
 =?utf-8?B?TDIra2VBbnRIQTlmNnlTRVdzR0UzTFprd0tvWEpFZzZtRDZ0Ni9icGRKSDN2?=
 =?utf-8?B?dXMyWWllOGM5S25VOU1RY1pkTGdiMzB5dUtVejBJcUJpMUZqSldKTEx2UFE2?=
 =?utf-8?B?RSt4UGpaZVVRaEtZRVlhNHNIclJxZXRNcXRybE1wV0VybGJwR1BPM09KUkFv?=
 =?utf-8?B?K3dBWjNOV2NLMkxqbVh4Unp1SHp0NmcrWXlVejI0WEIrVU1UaE1Oc29UV1Z1?=
 =?utf-8?B?Zzk0VE83Qm5DTmdYMHhVT1kvakhOZTYzZCtuTEZabFpVeG1sZWpjcE9HV3lX?=
 =?utf-8?B?YTZIOSs3VHBQampwcGpnb1F6RGFFZWdkc2xFNUNUTWVreCtuKzJGKzBIMlFZ?=
 =?utf-8?B?SmtSVndKUWpOU0dYWVZtRlRDdUpXWHRoN0RCeU5WWWxHSWdLTlVFM1dJYmRr?=
 =?utf-8?B?TFVnZm9DN1NleUV3UjducDA5L3hXUkNFSTc3SUZFTGUrYnJnaERudGh6MU0v?=
 =?utf-8?B?TVhCK3JEdGJudks5UW5uZXkrWVVFa0FUdXB1aGhHaks5a0NSdmRzZ2pSYzBP?=
 =?utf-8?B?VlJkYjNZOWJyRzZvREQ0NTFLNGswV0ZZQWFmS2ZsYXlQOVRvbnhpSUdWTWw2?=
 =?utf-8?B?RHBuQmJpM0NCWDRXRVd3bnZ5TWcwb1BpQUJhUUVjMnNZUGUwNlhMVzVlUys5?=
 =?utf-8?B?elJ1QTE5dU1Ga05kLzlMek1sMWpBRDgxcUpQU3pVb0V0MENmVXB6UEx1OEM0?=
 =?utf-8?B?bitLTzE1M255b1dyZm1aQlN3S2IySzZOTjdEc2lIOGg0U2E3NE5ZTXBrME5l?=
 =?utf-8?B?OTEwUkFwYVdzTm9TRnBWRmdiZStjVzFoRFJGSTZ1RG9YRDBjZWZoa3AyOEZt?=
 =?utf-8?B?Y0tuWGVuRXBDZHJ5S2JnT1QxNWJKTUpsN1hrcEY1c3ZZbmI1NncwbnBVMVRw?=
 =?utf-8?B?a2U3U1dOQ1VxcWMwRWRnaGUxUGlJdE5PMW1keHlTcExwMzU3aVZnakYvWmo4?=
 =?utf-8?B?QTA3VVZxOUFIMFd6bUEyWHo1Njh6R3NoRWFBSDR4RmVjU3pYTWRKby9CREI1?=
 =?utf-8?B?R2JUZXhxcHZFdzdFdHVkSFQrbEttMVlVMm43dGpQcG1CSE9yOGRaNUVzMWlZ?=
 =?utf-8?B?Qi82Q0VSNFFGekhNanMyek9EWXovSUREMXhpdFdtUCs1QitPdE16YjUxdEwy?=
 =?utf-8?B?REtsTFc4cERqMEZIZGtWcVhJQlV3WkpnN003TFcvaDJRMFlsVDNWUllVcDVN?=
 =?utf-8?B?ZlVwcnJRd1ZHTVRDbnZlck5XOXFhWEpjOXBUQWJnaFAzbmZrMUgyU0FuWlU3?=
 =?utf-8?B?UWdkWkRLUEQ5eFY3N1ZrSkxkQVFLVjlzVm10ZVpsY3ROOTBFTVNJaDArMExK?=
 =?utf-8?B?a2dkSUxqWFQxVHBtbk56UXlyNzFTR1Vrc3VSRnI5SWpwMVNjWFQwMXlGNWNK?=
 =?utf-8?B?ZGZnLy9QSDh0bEZ4Q1IxV1BoZmdSaEdLYlRyQ21jY2VrVHYyYU1iZ2FBVjJa?=
 =?utf-8?Q?tnhA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26814fc-4d9f-429b-0db2-08dcfcdb8765
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:18:18.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ochZmJQf/UEl75Px0HJyBVhNIvLiz7nmRn+h2wlEQ3ciM0DVMJBAgMsb7jsqeh7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

On Mon, Nov 04, 2024 at 08:58:29AM -0500, Steven Sistare wrote:

> > It's selftest patch no longer applies cleanly, but I'll fix that in V4
> > after you review the other patches.  Thanks!
> 
> Just checking -- are you waiting for me to post V4 before reviewing any
> further?

No, just busy with other patches :|

Jason
