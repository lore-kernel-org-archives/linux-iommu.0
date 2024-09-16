Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A817BD3
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503152; cv=fail; b=nU0maXftUnuEoQ0qeL3uwnPs/0GhcpF/u8mVH9wNQddGOYmW32z5dgN8MuWyLW1jcxritEPyZK6yT1ACpBXDpYZAPO4f7LuWvIQ/Gr47E0uj92YpCFb7AnN6D9Opc1iAFnROBrHSXbHgQHAsH7IOqA+nnMSFGLIGqPon1xJlHzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503152; c=relaxed/simple;
	bh=MoX4mcwjElD0IWe2BSiYc8f1CPxGwHGKuR43anNaMWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEwOSz6A8Wa6g1KEmIt/BkbR6f5xBy2hE+Xz/h0emQ/4RCcVvqumIeuWqJmofuAYDjEK1c2kZHxeY0sZYgbPFVqNQYVAxDOGpWycS8dIXECcuBeo5/hcM+PheaJzHJJWdjRvECDO1G7NsgS+5g0dHQNwn8YDZwBW4PkOoZx8wSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lQ7a2x7L; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lQ7a2x7L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHO4brmRs+wRbQqpKvQc8w9opV/QV5PSCkFAPQJe8jCYWxCOwvvYqRQIrkkCcXQFGlOPdJ7IV9n0nhuNGDCsuReVPok5VeEj4wg7SwMYvsZ7QrWtLUNpseAbulecfprD5gxqUpeXJDBRhNOF5aUcFB5P+g3sxijEN8CePicINpdbgXr+Aej9OtODkotGCVvEVcFxeW8oEATvYdh+l4eE70DzxnqjrBChzazKjE+NYETla4AsKxBu1+He+J0q07eeneTyFTzh893ZridZEmD/GHO5F/I8sg9DHeu4M+3TsifHr1gd8saZikC/nHWeme7kLk/MT2iiSf/jpXRiDfM5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWal0vw5LlBRrOLOkN/TvuEOmUT2LkWPCpQkGgMU1pA=;
 b=WUwEjc3KfeG0FFjYNjea7oUVqEBAWHQNVx0/F4Ll60+dIVyH9p4DtjZteXepw2/ceaNQetF0meT79hj9VNgOn3mEq2sLYGhCRoXmLR7n/mwKs3NGPx+7teZQfYdNTKslW7ObQuy22/iVL/zbCnTpuqHBAhYGJONkiO2PCRBjj3yt8lrMzx3fy+pBLCplvF0vDA1Sa8aVBs3P44M0jmfmQudYFxbGTEEq+IsfeZBomPtTlZvS0P6AXUEsCQ+JL3gd1TaR96f+rXB3nhWHppvkzG0AriwTXX9Bh48MyJ9b6OBx8wgwnRb+OvlabdQJOm0KNHk4gZafoXMTxis6QWODzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWal0vw5LlBRrOLOkN/TvuEOmUT2LkWPCpQkGgMU1pA=;
 b=lQ7a2x7LrvPoB0aHp5OyFUw2ZZhJnAzJhf47iBPwFT80hYM8z+6c33v7WvWnEmFpxyCHf3UWsz8kRdYCvsgPP/BtavaqVbqwplgFycS0m1N8HIOTTwhuYOBVXbcZDLa08xUNKIVNUGd/RpAVslUqcRbWjfa+1qWSZdd168PF5yY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Mon, 16 Sep 2024 16:12:28 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 16:12:28 +0000
Message-ID: <e25c8360-41f6-4105-877f-dc5b6051541b@amd.com>
Date: Mon, 16 Sep 2024 23:12:23 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-3-suravee.suthikulpanit@amd.com>
 <20240906170034.GL1358970@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240906170034.GL1358970@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2be06a-da69-486c-efd9-08dcd66a5bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REZCMzh3cWJwWGhmSkp2ZFRPaFlCUFFSemNlbHA0UzdwRE55aGZXL3pUQ0E2?=
 =?utf-8?B?azAwendVL0d1NmI4OTJqb0VvMTJPVG55MlRUOVlnakU0RzVLTmF1MFVubDlK?=
 =?utf-8?B?TTd0ZC9ReEZYOGNySjRmdE9wVUFJcnorZjhwZzZzaCtwbnZKb3g3b3NMaXZS?=
 =?utf-8?B?RVNVTGhYKzBnd2Q2dlRwalg5WE9HejBCTXR6YU5vYjd0MGZ6S3lYbnJTUWVQ?=
 =?utf-8?B?SFBjZVcrS1VoNVBneSs2QU15c2xiSkwycmFwL0FQKytMM0hEbzZUM3A2VjF4?=
 =?utf-8?B?dTI3VFRRMStsZzFENWJxdFdUNUxpc1NXU0trTUErWGNDYlZaNlNXK2R0Q0c4?=
 =?utf-8?B?MUdRL1J4TUtLVHVLVzdnL1JJTDFZVHgxcnVPTmp4bzBLZWxBblN3WUxYM2NZ?=
 =?utf-8?B?YlIyaFFObWI0UW5pUmsxUjRKOFVSb0p5MC9kamw3K0tMbENwS1dYUFpYU1Ns?=
 =?utf-8?B?cktURTZQemVzYnV5WVZ5b2ZSdExraFRGdlp6U2VqZVFFeTdVSnRpTnord1pF?=
 =?utf-8?B?aitNdkM5N0dZYnZ1Wmc3Mlp2K1h4aVFRRXNPTXExeEgyZU8weXVIWFl5WEtv?=
 =?utf-8?B?UEJSL3IwTE9uQWx6VTlHZTdJbXRJVWpTM0VBaC8xaFkyWXRrbHlibnRZcGdR?=
 =?utf-8?B?eVhtczdLM3ZLZXd4Y01VNlFLbjhVWWR2ejFDYmhTdjZZZURCa1NKTzF2QWJX?=
 =?utf-8?B?ZXZKMC9OcjRCQzdpQnIxeStLVm1QVkdESlZLakY2WkdKM0MrZzFEVjBtOXN6?=
 =?utf-8?B?bExCSlN4MFJWUmVKRTBxWVZMQVV2eG1tOWpWOXFxdklsUng5SlBLWTZFN0s3?=
 =?utf-8?B?TFNjenNYOEZ2eHFIRThSR2JybEowVytCdzhpbnZKdm4yeWx5ckkvQVdqQUtQ?=
 =?utf-8?B?Q2Fmb1NCM1RoVG44MW9jQjdXRTAwa1pWWVlGdDhCRTVZU0JrVDdieVZSTVNn?=
 =?utf-8?B?TjlMb280dmJlSStVYUpBdk5oNFJRd0ZVZDlqOWdpcGJXS0t4KzJubGpBRjlX?=
 =?utf-8?B?cVc1dTV3S1BlSHQwUmtKcTdiWTJnMVZkbG1BazU2MkY3QVRKanA2eGxRdkJs?=
 =?utf-8?B?UjR2QjNWWHBuczB6eDgyNlNxREVMSS9rV0NDdm5NRC9waU1nQWphZUFlUCtO?=
 =?utf-8?B?VitKSE9GWkNUOENWK1lWRUVyZ1lkS2U5a3lrRUtzQ2k4YkxLSFhEOFYyRTBw?=
 =?utf-8?B?M0taTDkvblcxOHIwQWhXeElBL1hWNERXNk9OWXhydzIwWk9mT2ttYm51bEV4?=
 =?utf-8?B?TFhrZ0szbFhEOUdEUEE4QnpEOE5PbGpPMUVFeGliLzN6QVVHZlFTQ2w3cmNo?=
 =?utf-8?B?aXV4RlUyYXB2Yy8ySjFpai9VTlYyc2dYdTFRM0ZHOWZWNE10RmVLd1BLVjR4?=
 =?utf-8?B?Z3ZmQXgxMG40WEZtS05yYXdmS1JDTWlaRGFXUUloS3JrNWJTRXBscHNxM3M2?=
 =?utf-8?B?UUxicHExd21yYVlNSElCTHRxeGMzSW1hKzQrT2s0Q1ZBWGpVdmZYVUZpSUQ5?=
 =?utf-8?B?MDRtbEVMTzZ5T2loT1BuSDMvK2ZkZC9hTzZHT1R3K2pleUIxRzVTRENoV21W?=
 =?utf-8?B?MG01ci9maTM3clB2SjZPek95d1FrZFZXUENhZnlLZzA2M1R3ek1vSWpha2Nt?=
 =?utf-8?B?eGg3c1hNMWZkZ1M4UWtSWmo4cjA2K0JGd0szWm9KNFRLUEZ4YTlKUk44R2xN?=
 =?utf-8?B?d1hPamQ0akZMaTR5eVY1SVpLTkpkY1FUd0hPdnlLOVRXZVJhc0RUT0ZjMTds?=
 =?utf-8?B?TDN0eDgyUXF2NjNmc210SkJpZHo1eG94V0txSWVNZXdLdldWNUlPeGpGcUxO?=
 =?utf-8?B?c0crMjJnL3QrTUdrUFhiUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c21ub3k3a3JHK0NwLzVvdWJISndvYWc3V2FWOE91TnlMbm0zMXpkb2xuTGk4?=
 =?utf-8?B?YjlkRXRTZFhmbXcwSE43TmxPL3Ivblo0cDZOYzcrWllaeXlmbjJLbmhhT1Qy?=
 =?utf-8?B?Mmo2ci9vYXFRTGh1b2FSbzdaZTkyYUxWcnovcjhFams2djZySDE0UzNJV3I2?=
 =?utf-8?B?b2F1MzBXWTVDeXp5ZFdwYXRqbzlMbHA4VFFFNTM0Y0M5Q0hROG41aGRKZGQ3?=
 =?utf-8?B?c2FmYjlRRFZoWk4xRW9NYXQxUFM4U214d2VFUGJ4d2FTZDl4c00yMzVKOUtP?=
 =?utf-8?B?SWF3Nm5zb0pOR0VtbXZveVNyS0VoeHo1eTUwMnl6d0svR0c3elNyRzEzYmlH?=
 =?utf-8?B?UkpmN1F4V3gwQTVkMG1RdUZPR1psYk0zOHpuY2IxYWM4SHIzRzJ2L2dPbnlz?=
 =?utf-8?B?eWtjTUlPRE5EVTRFRitYbzZwNlp0eE5WY2U5bDRVdkRTM0NPV1dmWGhhd0RP?=
 =?utf-8?B?QzNiU282YjVaV0VaMDhpeTdYTGtQN3g2bnpITEY0ZkNnZVB2VldnUjF0cEdq?=
 =?utf-8?B?emdjRFR3aXlISkFtWUhWdVd1MnYzeEhveUxsM09nbTZLajNtbGJoNFhnZnJN?=
 =?utf-8?B?UWxqNUZFQTNMOVhIN3BPSTBtS0ZWZW9GYjFURHYvaXRzdTZ2ZHQ4dkdOU0R3?=
 =?utf-8?B?Tm1ya1dIaVFIUm1lS3ZQM3N5eDNMaUQrVGtCU20yUDlhaXRTM3lwQXlXeXoy?=
 =?utf-8?B?M0ViZ2hVNVo3UGh1WnNxN0xob3J4VUw4eHI3c1BGOW95Sk56MTVtWXdYVnB0?=
 =?utf-8?B?aXR6UHNxOVhwNE1ndHJaWGFrMTByRUtHZ25uNHF0WEE0dldMWmF4bVlPSGo0?=
 =?utf-8?B?TnJZYkZNZzMwVEwxemFIb0ZJZDZxUkY3ZktTQnZnbnd0aGxtL3NkYldHSlh6?=
 =?utf-8?B?N3RhRm8vem0vakRvWCtqeVZkNitKeXdzTkk2ZVA5dklXWHVMNjU2N0lvQkFI?=
 =?utf-8?B?TloyM1Rla3lwSTFxZHo0UE9kaGlPemI1K3F1WXc1czVoSEhyWWtzbTQ5eUtP?=
 =?utf-8?B?aEdya2RteHlnRUt3d3lpMmgrNzkzUCtkR1lIdDRkT0VEcnoybk94RHhueHBG?=
 =?utf-8?B?b25VenlnMC8rSmc2NDF6VVFyc05RTityWjNRYnZ2bStWRmVOMitESzgveno5?=
 =?utf-8?B?NkdKT3ZhUzF0dmtSSzNDTkdqV0dacmJ1ZE52TUZNdG5ubjlSRnRlWmd0YmhV?=
 =?utf-8?B?L2lYNjhvd3JWMmI2eU4zTXhLUjNib2NHODNKRm9hNU03K0h1eGlZL2gwSHZs?=
 =?utf-8?B?S2hqTktBTVVJUGtFZmgveU93dEZuMGR6cllPWWNzVGJGRGtVVjNFRzY0a1dr?=
 =?utf-8?B?VWNIMHN5bkVxa0cwbGdVZWMxOHJhNW9SSG5WUzRXdEh0NEMySUQvQU55cG5G?=
 =?utf-8?B?WStzRmRpWCtKMUcxOGVGMnAvNmx2Zmo4US8wanZXdmpud3VWTzIxQyt2UW0r?=
 =?utf-8?B?eG1yR3YvcDFiWXR4T3pBdk5TWFFXeVlJbmw5MjFqYmZvZ0NoK21nSm9KQ2Q2?=
 =?utf-8?B?OXg0TU9mbTVCNHBST0ZtUTdjY1R0eVdVZVZuelZqOXRpSklXL3hvNHpzbDZR?=
 =?utf-8?B?VFJ5WjJhL1c3RWRVTVZkaWVHb1hDTDJMcmxlQXdPKzhtMmxFTEZDYXM3aHhT?=
 =?utf-8?B?Mll6Y29Bb24wVUxxcTRTSUptNmVxNVZMV1B3d2RPU0NJbyt5amtEdjZVRExC?=
 =?utf-8?B?V1Vaa2RrRXFIbWxkdm5oMnFKbWpQdVE3eWVjTWpjdmJzVmFWcGwyKzhYeVUy?=
 =?utf-8?B?eEl4eUxjUjkwRVdocDU3eVFMN1hGakZVVXlOY2ZMc0N6VHNQd0VlMzM0T3d6?=
 =?utf-8?B?TnphSzErN1dPNi9SVUxMcUpWZWpUbVRCbDlYcnA3WUtodS9QR28vTVROS0Fp?=
 =?utf-8?B?MnE5eFdwRzh4Ny84QVBZYXhQQnpTRXRYZXYrV2NkOGVZQmZQWTBzNnQyRjMr?=
 =?utf-8?B?WE9WU1V4WVAzTHA1MVFBT1ErbUpTbUVFaGJSKzYxMDdBNEhvVWJMUy81Rlo2?=
 =?utf-8?B?TXV4OC9uNTBSdDhJZ1V5dENQNHd0Wk5JQWZnSGhSSWZzMCtCQjVhd3hPL0Za?=
 =?utf-8?B?eVBZWkVWeldYWnNsRUl6QnE1YzFSYXJCTHZKd09LdEo4bXpScFdVUjZScTRB?=
 =?utf-8?Q?xB/DposPG98oJV5zFWRtqNQmL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2be06a-da69-486c-efd9-08dcd66a5bf0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:12:28.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46necocofTRyWn2PW/0wWa/XB9tucuua9GFsSBHa9T4zDrvsbGEcK3/fqbnvT1LJerjxOFypLP6RKaR5/61ALQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582



On 9/7/2024 12:00 AM, Jason Gunthorpe wrote:
> On Fri, Sep 06, 2024 at 12:13:05PM +0000, Suravee Suthikulpanit wrote:
> 
>> +static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
>> +			  struct dev_table_entry *new)
>> +{
>> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
>> +	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
>> +	struct dev_table_entry old;
>> +	u128 tmp;
>> +
>> +	lockdep_assert_held(&dev_data->dte_lock);
>> +
>> +	old.data128[0] = ptr->data128[0];
>> +	old.data128[1] = ptr->data128[1];
>> +
>> +	tmp = cmpxchg128(&ptr->data128[1], old.data128[1], new->data128[1]);
>> +	if (tmp == old.data128[1]) {
>> +		if (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0])) {
>> +			/* Restore hi 128-bit */
>> +			cmpxchg128(&ptr->data128[1], new->data128[1], tmp);
> 
> Like I said before, you can't fix this. Just go fowards. Keeping an
> old DTE will UAF things, that is much worse than just forcing a new
> DTE and loosing some interrupt settings.
> 
>> @@ -243,13 +285,28 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
>>   	if (!iommu)
>>   		return 0;
>>   
>> -	amd_iommu_set_rlookup_table(iommu, alias);
>> -	dev_table = get_dev_table(iommu);
>> -	memcpy(dev_table[alias].data,
>> -	       dev_table[devid].data,
>> -	       sizeof(dev_table[alias].data));
>> +	/* Get DTE for pdev */
>> +	dev_data = dev_iommu_priv_get(&pdev->dev);
>> +	if (!dev_data)
>> +		return -EINVAL;
>>   
>> -	return 0;
>> +	spin_lock(&dev_data->dte_lock);
>> +	get_dte256(iommu, dev_data, &dte);
>> +	spin_unlock(&dev_data->dte_lock);
> 
> You can't unlock after reading the DTE and the relock it to program
> it. The interrupt data can have changed while unlocked.
> 
> Put the lock inside update_dte256() and force the interrupt bits
> under the lock.
> 
> Something like this is what I'm expecting:
> 
> static void write_upper(struct dev_table_entry *ptr, struct dev_table_entry *new)
> {
> 	struct dev_table_entry old;
> 
> 	lockdep_assert_held(&dev_data->dte_lock);
> 
> 	do {
> 		old->data128[1] = ptr->data128[1];
> 		new->data64[2] &= ~INTR_MASK;
> 		new->data64[2] |= old->data64[2] & INTR_MASK;
> 	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1],
> 				 new->data128[1]));
> }
> 
> static void write_lower(struct dev_table_entry *ptr, struct dev_table_entry *new)
> {
> 	struct dev_table_entry old;
> 
> 	do {
> 		old->data128[0] = ptr->data128[0];
> 	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0],
> 				 new->data128[0]));
> }
> 
> static void update_dte256(struct amd_iommu *iommu,
> 			  struct iommu_dev_data *dev_data,
> 			  struct dev_table_entry *new)
> {
> 
> 	spin_lock(&dev_data->dte_lock);
> 	if (!(ptr->data64[0] & V)) {
> 		write_upper(ptr, new);
> 		/* NO FLUSH assume V=0 never cached */
> 		write_lower(ptr, new);
> 		/* FLUSH */
> 	} else if (!(new->data64[0] & V) {
> 		write_lower(ptr, new);
> 		/* FLUSH */
> 		write_upper(ptr, new);
> 		/* NO FLUSH assume V=0 never cached */
> 	} else {
> 		/* both are valid */
> 		if (FIELD_GET(ptr->data[2], GUEST_PAGING_MODE) ==
> 		    FIELD_GET(new->data[2], GUEST_PAGING_MODE)) {
> 			/* Upper doesn't change */
> 			write_upper(ptr, new);
> 			write_lower(ptr, new);
> 			/* FLUSH */
> 		else if (old has no guest page table) {
> 			write_upper(ptr, new);
> 			/* FLUSH */
> 			write_lower(ptr, new);
> 			/* FLUSH */
> 		else if (new has no guest page table) {
> 			write_lower(ptr, new);
> 			/* FLUSH */
> 			write_upper(ptr, new);
> 			/* FLUSH */
> 		} else {
> 			struct dev_table_entry clear = {};
> 
> 			write_lower(ptr, &clear);
> 			/* FLUSH to set V=0 */
> 			write_upper(ptr, new);
> 			/* NO FLUSH assume V=0 never cached */
> 			write_lower(ptr, new);
> 			/* FLUSH */
> 		}
> 	}
> 
> 	spin_unlock(&dev_data->dte_lock);
> }

Got your point. I will update based on your suggestion here.

> And it probably needs more logic to accomodate the VIOMMU valid bits
> in the 2nd 128.

I'll take care of this when enable the HW-vIOMMU stuff.

Thanks,
Suravee
