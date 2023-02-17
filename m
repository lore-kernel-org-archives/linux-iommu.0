Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E263E;
	Fri, 17 Feb 2023 05:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O25hEH5tKB9Jb7Q01+6czLHkDJpUCYnIfxAZ36gmESnvMIUCRXEqa0dNnaqKIJPAJSD+oOnBW3wJfkMauFjxMrJGXzdrQ3CcgEBp/RJ1IMp+a9utl7MAn5navWGOf2cn14gHcNafqKmmVDv1MHS5GLiFuBRtsaLL7PNbkmxkk7HErHTi+tuWTXp1jqYs17OlR5K3a2t/80D6TkrZNxLElzM8Lu80iw7QeeTdXk/2W486uVE7+Wz9QL2xw0tGWprHY36IZ533OfobiS3VkHhv+SJ2J27ucNkfVubE/CTJpC5hUjP1t+osbcryJNnGk95tW2Q0Y0rhehBXO/kSemUcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fplpK5LFh0c9ffNDbzBGoSUD24Hd7QUprUrBrCFpnmQ=;
 b=aDH/h6oGRP0FCVZAVDPHR8ByLCyGilXiVoYbcnfICXZDFhe5XVBSuCSb3x6AU+D4JHh4VfpiJZ0igL224iks5tFKz2ow0WE95bEYfVjob4AKPufMc6I2AcF+0V10WGVnh+D43Nm6SbxC4pPwGlmzOoxv1nNuHT/ofL53UKNLP8mqMccALN7BEblh5TWEXXzpjMMS/qrlO2IMZpsO3+oZNYk1oJJQNIIKfINyEVoxsjLSpEJYTwdpE/ba6TdRZr0luG0LFvHHpKl6RTbIVysVrlnbXBpzBkSBUtdf3CDYI3hA6SAf/UpzIDA6gtcRkZNZ6fAxUMDwboneVdTyUK3OQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fplpK5LFh0c9ffNDbzBGoSUD24Hd7QUprUrBrCFpnmQ=;
 b=uoCtbG2a18Ne08xXuQN42KV7iccltA6mgN2PeTROVZ5IbJ8CWzqxnJaU8fFd8QuRzfIylV4a1RCe62AOLy2hpOZXd46hpqpkpIX+CUT6hCERk0S1FD1JaDlxB/ItKQrqXuahEtc3Nvk32TB6C8yIlZWRH8YCBeC4lIGvGnwh17U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 05:57:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 05:57:03 +0000
Message-ID: <d3d6aff3-b10e-4d02-65f6-b714ad57bd78@amd.com>
Date: Fri, 17 Feb 2023 11:26:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 3/3] iommu/amd: Improve page fault error reporting
Content-Language: en-US
To: Thorsten Leemhuis <regressions@leemhuis.info>, iommu@lists.linux.dev,
 joro@8bytes.org, baolu.lu@linux.intel.com
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org,
 Matt Fagnani <matt.fagnani@bell.net>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
 <20230215052642.6016-3-vasant.hegde@amd.com>
 <7c8a2356-4964-20a7-2f8b-4836c1f6a9ff@leemhuis.info>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <7c8a2356-4964-20a7-2f8b-4836c1f6a9ff@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e26d710-e70c-4fc4-1c88-08db10abcaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TTKCMkF1mTuiElcGlwBf41waJ1VfZ4EPmGT8Q1fePBU9LkME5AGPcMzk3H5LcHa7BSBoCLj0L1vFxGcODhrY9BTjWunfHFsAlx5iJoEq+N4ZWbMdUDGF0VdgT/m+qchYfp5XKSQUqgm4a3c6CTVLhj1W0/hYH2cqXmDowEcEr3oaOtG5fIypVvCQCMs6QaT0x0PLWiryEuG8Z6WlYkzt+mih5f5YvxT+OU5hsLJTWVoaFi7lbpCG0pQy28EcoK8QgG38DM24PqCgZShgISnAmrbIDfLBXvrd2JtXPQQgi6E8q/NKdXRgUIcdwozx6A3jM1IVt6wo8LfdvrX8Jkzfne3hP6LC3ZNrNei2qRogWfF3KJn1SHYu8L2OtDxrkhABUNHSd5XeEyaGHnR/boX7WQAHvPVA2AhpFoKSS1+IODdwPGTpuircM0p7gPqoJPS45EJlW4apOscRsPsKnLJebKq5rqOPhG5TVbcuAo2tbbpp3klSWfvDDu4i3Sr4sEA0xExXypE4ueHxsfOW4cQebMWdJZ8S2xsq6m04lpxq9uFLpouy3fZaW1wbj/ghp3pstmPTc48kHzTxujlnXO5hQ84zFESbK58/AnqW04VOyisNChCcWgIKIY8NKs/x8oVR/wdLIUJr6zpVSTBsN8TRtH3E4sNQrNvfYoSFAC6pxHlJwKibbPNGF4wzSLrlW67w7Pjy7jXh2UPCrzCSFyMRRP3YLeYG3ICbidpPRVZzoNrnUb+VG7h4CsmssaH/smV832SbgrviWgmKH32fvqfHCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199018)(2906002)(44832011)(31686004)(8676002)(66476007)(66556008)(66946007)(4326008)(478600001)(5660300002)(6506007)(8936002)(2616005)(36756003)(26005)(6666004)(86362001)(966005)(6486002)(53546011)(41300700001)(6512007)(186003)(31696002)(316002)(83380400001)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0lqSGxkME81TjJGajNqSURvT3UyWEVCb2t3ZG1qR3FZRDJqeVB6V2pObm1S?=
 =?utf-8?B?VnZGUHBrdE55d0loN0k0QW1TbDZ6Qmp4NjgrZFZyK1RzSzJ4TXpuSkJGQWg4?=
 =?utf-8?B?WjRCUFJXZ0hPTXcxV29FUXcvVTI5OFo5cDRDQ2E3NUJHczBGdldYMVlHcEJ6?=
 =?utf-8?B?eW4zVTlObVlhL2xPdklKZnVBRkVWOEVzcXNYaS9ERzdQOHNGdEN0VzZJUHlt?=
 =?utf-8?B?bTc2OVB2V3lteGlBOWd1QTRuL0x6U2tiRWxVQW5ZUkFNc29YWUZiRVc3eEkx?=
 =?utf-8?B?eUhBYTViaUhlbnBYTTJqWDc5aUJVa0ZzT3BGTkV3eFZnSmR0TnFGNXFCMlg2?=
 =?utf-8?B?UWRJMUNUWmszdm9PRHphbmdvNWZSRERpUytBYXdFenlPKzNJQnpRM2hDSE5Z?=
 =?utf-8?B?cERiL1FOdzN1d09vb1NtRHRqR0twaUF2MzlyRmhjRnRyczFBc1hWbGlVZXQy?=
 =?utf-8?B?amxtK0dVY0xEbTNIUWptSElmTWhnN1FaZmRTWXdzZS83ZkE4Q3RNcUc5TGF5?=
 =?utf-8?B?cXFQVzlsd05vbHNRUTBjdHFwdU1sN1dpQVR5NkFISFMzaUxqK011TCtoYmFo?=
 =?utf-8?B?QjBlZ0RxRklROGdBRGFZMVhUYUhCdWQ4MXhLTFFmU1lOdjJrUnFvMGh1d20r?=
 =?utf-8?B?WlRJSk9uODJQdkxBNEVtaFNvYlh4ZEpaS0xwdGxsZTdOZG9MZjNlUGo0VmJk?=
 =?utf-8?B?empMdWZrN21QZ2I5T0t0Sy9kODF6STVjVW5vRWZCblpFS3EzNmcwbm1ESksr?=
 =?utf-8?B?aG5NeThXWlcrUkRteEdLWWY1bmpJSEw2SkRYUTREY3pPVnM2Zmd5UTVnWkJs?=
 =?utf-8?B?d1huc2hQUmlYV1N4N054UzNWeUQ2Ny9wVEFieFdHd0hJOCtTbVkySVRTRHR5?=
 =?utf-8?B?RzBKaFk3TE01ZjhzaG9DbmQwN0srdzk1N0wvTWxGcmxJWnlXL0xNMnFDdHpR?=
 =?utf-8?B?WlhuOHlYOUwyWkZ1NE1uVFRGVHU4dTVEaDZheWNlbHR0OGkrZWw0UG1ockw1?=
 =?utf-8?B?bExFd2hRM21meXRWK1k1Q3FLMndMV2orR3RLZXZXN1NvUERMMXZlSzI4Y0hO?=
 =?utf-8?B?RWovaVpWbVc0VllWUFl1Ynl4NjNHQ0hPNW9PeVV2d0J2a010R2lZMjdCZFJM?=
 =?utf-8?B?MUVDNFJUaGRHRVQxZ1IzbFYzbEhoeTV3K2JhYm5yN3BzMTVpM2JtOFp0OVpF?=
 =?utf-8?B?c1hRTWtBQTN2RkNFWGpKYkswTjk0Tm5lRGR2eFhLbG1CQ0tVbFg0YU5JdHk3?=
 =?utf-8?B?ZlVuMm1rdlFQejFweHpNcTFXQVkvMWxkenNYeFBiaENKWWtUV1lNeUhsaUlp?=
 =?utf-8?B?aXZmRmp5TmwxOEFaWUI5Y0pib254K2VEN0cxSlUzTXA5SitjMDVHdDBiLzYx?=
 =?utf-8?B?TUhLSWphQkt0dHJBTUIyQlV1aFlVbDNDL0lvcWM1MitsVWYvbjcwMEdrM3JQ?=
 =?utf-8?B?VUp0aysxQ3paOVgzQVdTekR2cTFGUGxGRk1MN2hYZ3dqN1ZQdTU5NXVRVGhi?=
 =?utf-8?B?aWVockd5NEFKZkpWYmNYV2JXcjQxSmgzS0ZtQWhqbklwNUF2UWtib3AzUEdF?=
 =?utf-8?B?VEtOMzNyd0d0ZEk4YjB2Z29MZEM2MWUxdkFlMytRK0xOcmgzNlQ3VURiQzVo?=
 =?utf-8?B?ZzZ0Si8rKzNUdjdVYWhOSkxCRG5teGpkYitvY0krT3pSZDVBM2xLcmk5QmQx?=
 =?utf-8?B?ZkdDRlBobmZQN1lWbW10WkxmNEdPRWphMllCVjFFQjZHMjl1SVlGeDVwVURW?=
 =?utf-8?B?aG1Icmk3aXdYVUlVaVRqYnhvVnFwRFY3c0tKdWlGN2FxVEZPQXJxUXZIYWRQ?=
 =?utf-8?B?WGF0Q3JqUFZQREFoeHQ3NEIxbGpwTWFTd3JWNzVCZFlEN0cvOFRIN0FqU1dM?=
 =?utf-8?B?WTQ3VFpScFJYS00wQmEwTXJyQnE5TVlVQjk3a2pTcXA1NHNHeGRUYUx4N0Vs?=
 =?utf-8?B?cEFhZGs0Z2pkT1JPd0dyckdjUlNyUFdxNmdRNTlLa053WmM5V3dzNGxoNXl0?=
 =?utf-8?B?U0xtZ1MxdWtndHZ2WjVzQW9CanVzazVSN085RzNBOGVXd29uczN0WWxmZUJ2?=
 =?utf-8?B?ZWpMRTA0RlJvbTZSVFg2VjR0eHZ5YVFsVkFUOVFMYXN0OVNVLzl1TzFRZ1Vu?=
 =?utf-8?Q?k8RnMvID99SXyGQPyuY0zDGIJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e26d710-e70c-4fc4-1c88-08db10abcaaf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 05:57:03.0389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvDTK9wt7vIUBFmjb7MnQ5pYOHn+xyF++Znssor8r59JUWfmX6za5WFzhIxRdVo0LQh8Z28Tf2w/mzUrjvKd8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518

Hi Thorsten,


On 2/16/2023 3:11 PM, Thorsten Leemhuis wrote:
> On 15.02.23 06:26, Vasant Hegde wrote:
>> If IOMMU domain for device group is not setup properly then we may hit
>> IOMMU page fault. Current page fault handler assumes that domain is
>> always setup and it will hit NULL pointer derefence (see below sample log).
>>
>> Lets check whether domain is setup or not and log appropriate message.
>>
>> [...]
> 
> Many thx for taking care of this. Is this something that is still
> suitable for merging before 6.2 is released? If not it would be good to
> directly add a "CC: <stable.." tag to ensure it's backported to 6.2
> later, as maybe there are more people affected by this.

I think patch 1/3 is candidate for 6.2. I have request Joerg to look into it.


> 
>> Reported-by: Matt Fagnani <matt.fagnani@bell.net>
> 
> There is one small thing to improve, please add the following tags here
> to make things easier for future code archaeologists:
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
> Link:
> https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
> 

I am sorry. I should have added above two links. I will keep a note so that I
don't miss things next time.

Joerg did added these link before applying. Thanks Joerg.

-Vasant


