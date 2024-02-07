Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658D81ABA
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324750; cv=fail; b=n8g8qm8VrVziMY4D/iKYL9l0NTxqkELY7Yu2ypyYLs0PU4oKRGsuOm0bjN2r4HgESJ6rFpqYSgty7QOHt7YSOd6vTZFxOcqtviML+MCTxnX7JV1qx5OnBMSZUEENuKT4UudXbPjfKr3yZA+ZoWXC0kL21RLeQGjt1hq565zXbcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324750; c=relaxed/simple;
	bh=mXRtyx/E3CVxLSmZMQMX2FygwE1h1HNUu5yMRzCrFuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K+o3+I1FDvk6L0sxdhYVikQJilMhqEgC6m9+98BzPKJk5Pgf+5QaUOfP+A9/Dn10noEqD6SMUQkZnOvX6vjYf28Mx8PwcsQDzlTodiyMPGVzxt6krsX01p8A2f1m6N9CxbAcMZCDq2OxC10sbQODzUrP0jWxby6phnAt++pCai8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YRpe3HLr; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YRpe3HLr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8bfk5CtUw2dlr1nMMuenvVm7n/IAuWrV07M2b1Hmf3tuDTTnpE6YdYN71A9WNVQHmgprjpiDjVZfARHjUEJkxDVFYcZSR113YJHOupaYDuQJueTeIkOwJd1sM/nLa+y5S1DzQMzoybpfsWgN0cVVxS4XGkOdhPm2ZxWRBw1f0WYrHwMKQJdPLUkPob0ceTUQTBfwjT/QodRYItpnO80821f7jBbv1QwF2+F0rHYX7te+XtKsIf3PrmZisy34GCmWsR1K0A3cNkLJ8Ge1xZxnC2hFtu004g89a/XPpFuRggTl2bksre7pw1uAjUTS/MhhQ1amWKrD+CzczzhvngW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXRtyx/E3CVxLSmZMQMX2FygwE1h1HNUu5yMRzCrFuM=;
 b=ZzHF5kyS0dadrq/fb53kzJ11i7D8BmdoWHP8z3vwzNzUq2gP71sYd3+f8qHK/2LSAJ1sgL6MWBM4d9TalJqLmxOrkfsvijhas0QgoLaR4SmSQM9xh4NCXETEilkQYiNeXB6SX/LWmhrQWdfcb5fe7zT2M9OIMz2/hJXaF8/S+pY4HL5yReYeTNdtnV0V9rtvAQj0vuH+t7a3gCGWqDukb602c7NmaUVkNYd7xzm7NqevjlyD8culEQ6ijmgkYvm8hQOEpjEGJpSyigpUlDwmN5zbdtQxfhM/ZSHFXW/Yy6FlRw1FmYsEHamuPvzQ35joV/65+xqlNjTdNl7skR+y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXRtyx/E3CVxLSmZMQMX2FygwE1h1HNUu5yMRzCrFuM=;
 b=YRpe3HLrKTDaknsqIBqqSqjQShILR5v8cSeIdqZE4rYzaTMYhNFqysM8AQ66Jr64vOmXymwNeThfVflVc+YyU/9ShfGKyLpnqDmJVZv0rztyQD6wE4uXTo9znrfz4QS616dynHpcTiFbGTLImuIi5RatR9UHXqfVUr+8mH/4klrZlq+XhRUcFYJTfSvE6Oc5x7fvcJXBKRLR+GJXgQgfuMNd5ISVozsDZGd2MPXK2d9p3w6ljA8n0IDKfWKkpb6rBv7g8Vt/HTC0EEXjTZUu+8DUp1gfMyxPvy2NgehCkuvy6uGR0G2P+YELwvTFBRc51hgQ4CtfCrO7rj7RPkgDpQ==
Received: from IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 16:52:24 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Wed, 7 Feb
 2024 16:52:22 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 16:52:22 +0000
Message-ID: <256ad499-ae45-4b0e-a61d-2cd97fdc82a0@nvidia.com>
Date: Wed, 7 Feb 2024 18:52:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] iommufd/iova_bitmap: Consider page offset for the
 pages to be pinned
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240202133415.23819-10-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240202133415.23819-10-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR12MB5549:EE_|IA1PR12MB8405:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 17eaf4bc-fb0a-4542-55b2-08dc27fd27a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vlRadj9fgbUPOYzQvu/PHv38uiTxX6JYs1r8c/NddaJK71UXsWuCE4I+N5sCTIwJ3eU7kPEAqa8hd7ZzBE1zNxrWKjwhTGLALlygKtUNRrnNv72J4fHVwErHyJxJeOcixMm5wZyZ27mzRW65Z616dPiCymoMM/jiZjvkDu1QtOmQRieU7MwEfi3HMjzyY0QqPAF4/RGwQm6Je4t3Gig1BLPatiqimNK7zCqm19wQxL+vHWQA8KUJp2VI/AH/J3gpNbrdQTv5VSteTWdVCx5wahpeRJKgXITEBKgjpTCldJBKdU6Yc5r06V2WzEfThhfgYPcb1RlSi5++OCo3MiRxBWFUOhTSMt8KRmernupJyOjUUD0fXZ093/ik0AoICoHkJx+vQysN3Uag8ruk+ckUtgy4valhAsUnajLjl0TL8PpP3v6g41oTb8bwt6jtdPkekxQvG7ht0aHRuy06lxD47/VYMpS3gMnHFSeAi6F5YflKLh37RUTISF12CwqAsC6zkVG3dQjjcPSgj3N8L2SMkDtm2INlajTsvblWaeYlqQUnA+TgMRxO5KVvhKOVYi7HarGyyDiKlChabW75OshzXS24iP8Hobcy0DBSDpwSIEf+4xWLjWdlWP59vyveKDklxAOZP/llvWEy+H0g83L67g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(54906003)(41300700001)(2906002)(316002)(36756003)(8936002)(6486002)(4326008)(8676002)(66476007)(66946007)(66556008)(53546011)(5660300002)(31696002)(86362001)(2616005)(478600001)(38100700002)(4744005)(6506007)(6512007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnhzdGtoSGowamx1TFdpVDE1UHg0T2hMb0dOcDNabFZOUGpZRUh3V2lNZWFW?=
 =?utf-8?B?WHdVRytRcGhQUmgvNTUxbnF6eWhmZmZ1Umd0Q24xTmdDbk9PT1lEL1F0VE5P?=
 =?utf-8?B?ZGoyMTlzWkZCVm5laW0xNHFNWmgxVit2UzErQ0dJSVQxaVVadkplRC9pYVJy?=
 =?utf-8?B?eWxMdWVrNjhTQmV4bThNZ0ZxcCtxUkVnM3pKZ0JuRzZxT0paWlp1U2kwWTQv?=
 =?utf-8?B?OW1DZ2VPMzQ2YXl1dzgrRWdMaEV0WUJGYTJuQk1MbTlEazIrMnEwZ2g1RS8r?=
 =?utf-8?B?azdxaE1hbVJNOXNoQmw2UDI5eVpJQ0FJa1lTQmR5QjhyUjdBNlV2Q3NnRnNl?=
 =?utf-8?B?U2trQ1Q5cHVOVStHbm5MYUNWclROMnlCWXIxaU5mUXBhZDNxdjB5UEtld0Yw?=
 =?utf-8?B?LzYzQ2t5OFJ1bjUxeFBhR0VKLy9Rc0FydWZvMmdwWkRvdEZ1Q0pyckpEdC9V?=
 =?utf-8?B?R2Y3Sk5uaE9RTzAvWmpLWVFlOHd4ZituanhKQkNjb0hXbU5TWmlQM0M5TzhT?=
 =?utf-8?B?eVFXYlZtTFE1NksrVVhGQWp4cHpRU09lYUdPdWVPOWw5OWpEUHJCemVmUkNu?=
 =?utf-8?B?ektLN3lsOEpueTFpT0ZoM2FlYXhDYmlLVFZpMnNwWnB1VTJ2WGp5R2todVJk?=
 =?utf-8?B?eTNxSWF2Z3Q3eVpSeUgxZ2hleFFkU2tkWTRJWXMxMUpONEx6NnVDR2RGbW9m?=
 =?utf-8?B?VzhUN3k3VWtadVBoa0RrODVTTEw1MGlUWWFCRC9qeHdoWTZ5ZnFjWWJ5YlJz?=
 =?utf-8?B?aDg2MVlRdGlGazNIRWtCTHJpMy9WZUhnLzh6ZHBLWGhBd0lSdHFSVzUxam1l?=
 =?utf-8?B?b2RJYkZyVTVvK2V0VWhMdmM0blZTM1V2L3JIZTA3VzBNeEZLOEE1Ny9YUXo4?=
 =?utf-8?B?OVRCb0FCbFJWb1o1NWs2eG1EYXhEcmdWamtwSHhRODZib0QxSXJoSUljaWQ5?=
 =?utf-8?B?RVpFUXljZDhRVDdkOHY3YUd6UGhTak1DTmVPbXVaSlV6cnlJbHE4YnlKNUdF?=
 =?utf-8?B?bkpWM2I3Q2JFVjNqSU5PR1M0WFBmbnRKakxoejg3YTN6ZS81Nk5IWi9kdlVm?=
 =?utf-8?B?RDV6cGlIOVJDMnVscFExcUpvU1RvK1kybUovUjFaMkp4RVhzTnNETkJtbWxL?=
 =?utf-8?B?bjhwdk8ybEFOV1F6NFAvcHE2VklNcXM0TWJ1VnB3c2o3MkZnVWJRYlNHd1FE?=
 =?utf-8?B?eFJLK2VtNFdDQ2J5OEplWWVRWFUvczRoYkJyWHMrVWxlMGQ0eU52MFB5Q2kw?=
 =?utf-8?B?YzRISWtlc3NmZXRGUk16MHgxc0cxeTNaVmJwamxuRmlTclZJd2VrWTJuc0o4?=
 =?utf-8?B?SDJNVnZRLzRFTFVSZGRLRmVIMjJNUy9sWFNneFhaa2E2U2VVeHowY1l0R0F5?=
 =?utf-8?B?YUd2cFg1K1d5Y24wbFB4RzhnM2xTNURsdDBLQTliRHpwdUpSK3hubGxncXFT?=
 =?utf-8?B?SDJ3VG9yY1dXbXlNdkRjdng5SFp0QnJpYnZoZUZ4akFBUUhEVW1XcUJZRXFI?=
 =?utf-8?B?TTYwTmJoL1FHUlk4cUtkNjNVdkdLTmFPcndrZnNCNkF1SmIxUHdEaC8yZXlp?=
 =?utf-8?B?Ly9Wd2RXVE1Fc25GeGFXNzk1R2I1MW40NnFEVkhhelVpRldQTGlMZmo4RjRV?=
 =?utf-8?B?R1AycThrZUx0R2YvcVAzY0NhRHBGMGhFVzZMZnBUZzM4azF4QngvUGJCcGhm?=
 =?utf-8?B?Sk9YTEhhOHhDZFZVRkcvNkFaY05mZTJtVGJMRE1IbXRsdlRIY1BvMXlJR0tq?=
 =?utf-8?B?NjUrN2RJMDRZSUhqZG9mOTdYVGFVZVVnMkxWMUl6S2g3R2o4dFZaa1k1b21M?=
 =?utf-8?B?TUV1VnFuYWFOQzc3SCtsT20vRzhmQ0h2eThFc2ZTL0hxKzR6cHE0QUtxMzJD?=
 =?utf-8?B?ZzZLYjZZN1FKT0pzVmJCQ1doVWJtQUFWS285Z2xaZlVUYnI1NzgxcWc3b05B?=
 =?utf-8?B?VXYrd3dmalRjN3ZSNnl0SUQxUHYwUXNVbnNQemxWMFdqWktrMHZIWVVJM1lq?=
 =?utf-8?B?UXVJb2ZZeU5HYlJLLzY1eG1IYkl0aHpwVEY0bUthenpSVmZybjRqWWt5aGxE?=
 =?utf-8?B?Q2o1eG9vS2ZkNTlsa2ltdmdzbFV3bVdvVDBQM2RCK3Z5NnljaFRLRlF4Wkc5?=
 =?utf-8?Q?yFbRqshwRO6OTvOFsNiqXdiRw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17eaf4bc-fb0a-4542-55b2-08dc27fd27a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 16:52:22.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNvCVY4GYSU8YIFB4LRXy6Tedn9RrEetMbuAES/dvsMulO4l5Qz0/TEnKfMLg6f8TeJJ6sZHU94SGArcfGeSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138


On 02/02/2024 15:34, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> For small bitmaps that aren't PAGE_SIZE aligned *and* that are less than
> 512 pages in bitmap length, use an extra page to be able to cover the
> entire range e.g. [1M..3G] would be iterated more efficiently in a
> single iteration, rather than two.
>
> Fixes: b058ea3ab5af ("vfio/iova_bitmap: refactor iova_bitmap_set() to better handle page boundaries")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Tested-by: Avihai Horon <avihaih@nvidia.com>

