Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA963E
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 06:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfrQKFDf/uPht/7nZvvl2+IQDATYdfsg4XEvxNwmX0vjOWDZ5T+EuiDT+scwh4yDfYSyPTR81N6UFzT8D3vnh2aIERMj8fUEt0yoUKs4dcuuBih60y2mTtHyIckDOc/vHzO9lbQTD7wzpFtEA8aJpCbAZVo7kLBcZ+02MjWnpVpyUH2va+3OQtro4qxMvFOOpA/XHT+cu1XcKGdcdBlDUDsHOheX1yw4zcCNPsPP9tB0Z3HoQGnalj5g0JlphLmsyiQTcKrygCtT5ztbmHTLc3RJAousYbj2U2GqNJR45jA4Hk8IwAPfUOlOy2m6qHGGfR6SLyP4ptQ2O5gKRBUswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XsbLuluBcqwh19LenjpHEou9ggsG4YGHPoGWyqTvzg=;
 b=Y76+S7eC0xf37v4oYrf73UOCJ6MwpBMKZdDxs0rT3TsdDUY4NyECmvzUEm+h5tdX+NJJRQzld2iaxM0R6spJvTne8tpWJXU/lpCQpynE08S2ZYPyzggGsnw/iM5XEZ2hnZvsvafspS/FV31n9U8ntc3xF3eITda0bpGD1bAtY/8WDnPoqh7uOqAqQtaF0kCvjsHyR0kGblbpiRNr0xPZ299dIkiAIOIy8yu7+6TCWJCUNvLqcEMQprvEHrktvGijzUt28P4tLielwbvs6WF2IDKKoTztZ6BivI1d6PrEJGbdcs1I1sZEz38nu/X1Mx637wGEYTRB6URbYqOS32GIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XsbLuluBcqwh19LenjpHEou9ggsG4YGHPoGWyqTvzg=;
 b=X1NtXR4gCduloJPQtNBg/ZKMl32nET4ckleJOtIlEIKMTrsvH38vnBkoXrWZ9Ezjd4xeeuUQHCwXM82b2qFZyHKYEmv/u/1l8DSVG6UOd+HjLo0AnMJY1/n2nOi7VYzz4YrDE46+p0wvVPbsvS6N2FXMBcues/Go/EGwsnQN1O4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 05:59:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 05:59:59 +0000
Message-ID: <6ba4dfcf-4e9a-d49e-254d-2c36167c3a0a@amd.com>
Date: Fri, 17 Feb 2023 11:29:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Do not identity map v2 capable device when snp
 is enabled
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
References: <20230207091752.7656-1-vasant.hegde@amd.com>
 <Y+37or/jktnlKUsp@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Y+37or/jktnlKUsp@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e81a7c-4b43-4c18-e8bc-08db10ac33c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CDefl1lPDA7mjlf7i8r9vbIge1GQrFNLNeDs6AW7/IoYifydSEJwhzTQ4rzdlR0MSbK8J5F1TX7n1jiuffP1NpjZtjvaZKsePgzlsN74NjEPKuk/n5ic9XswHYJ1Ka7SIiQt+aqjMIb8HSuEdR4vBycSyhTgz4AlcEoDrS3p4J/vyzOl1grmTmUqxTfX2PnCW6die6jf1/UwMGvizhjvamLYsxBEFBQyn89vN3wDRUjAV9Dne5Ye0hwCYJ6gFjvVNax2xaCCaEqA+1eW4hxAuK0JmAY5CFd7Sl4Q0WtGumCIw4rdMS25qFlQtuqQ2RZDn2Dvv//IeG4tqqktpuRS1yKTPO7S9OHsIidXwI8Q5T28dBX7uE6RPpJe85HOg0FdXMd/e77Cf4nsE+lOuTNyq+rrG0CHZSYITjLQ/6v1qALbSGWRtVP81aTnSlvMmDSrOs1bsOBzubZXtN7Z3+ug3YzGbpyvB02sCGdw1xOlxHFatgLWhVKj1kH3T4Y6W+otmiCCYJeUT6yTKMk1AJo5v80066iPq71fAdpIXKBxZw7yCCTKdjF8LHu4kdgENze4M5widySlaNIe5Xcka/SMRLYlpcGu8NkblIN3vHJO3VP8TopVCdGC2GBT+jcsbwxDUZ0LUtE6xGBWxSBXt4XhgVmvjvZDjD73PotZjUOjaY3ISG5rD4tjh9uzcekSDs4ylVaxFj79TJmKqaY/lxSoN09JCQNhpw5Iq8O6MmrFt5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199018)(2906002)(44832011)(31686004)(8676002)(66476007)(66556008)(6916009)(66946007)(4326008)(478600001)(4744005)(5660300002)(6506007)(8936002)(2616005)(36756003)(26005)(6666004)(86362001)(6486002)(53546011)(41300700001)(6512007)(186003)(31696002)(316002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDFOLzFXQWNMdTc4M2tqYmRLblp5ci9PV0RJWFpHeFZDTmY2UVBxeVFpd05B?=
 =?utf-8?B?U3dWSUtaK1JjaFAxd3Z0Tzlrbjh5V0JtbkhQSTFUUlp5N2x3RStWWEFQNmQ3?=
 =?utf-8?B?K2lGUHZGbnhJa094S1lqdDRrNi92cHdIN2tBdmFhWkVqZ3dEb2d1R2p0TEU5?=
 =?utf-8?B?a0FWZERKendGRHdWU0hFTmo4MnYrcE5rMVo5ME8vNUhTUGprNEk0RHBtMnYr?=
 =?utf-8?B?VjVKQWZoQW8xOUlycFlGT2txUDErZmNqY3dOM3VuWVNtVGYrUlpiaDFORlB4?=
 =?utf-8?B?RStHRWpWdjMvOU5abHRzQnNML2R0V2w0V1NkclBrRlRwT0UwV1IrTHNrL1NO?=
 =?utf-8?B?VElQRXZ1SVpDSG5DWGdpYlBlSWxpaWZWZSswV200UTlrNy8yNXhGRGVONysx?=
 =?utf-8?B?RzBsUnd0SFluTm1pNHVsaGNTNXdheURWY1dQZXZGaExFUzZzTlQ3V0ZRUEl5?=
 =?utf-8?B?UXRPdmdJUnFZYUl2RGZwRTQ5S01vL3J2ZFFsZkNUamxkSHdqTnh0N255Ukt0?=
 =?utf-8?B?ZXZuc3EvdFhDWFlKbEM4R2U1ZkdiamxpNGN6QjErWDBrMjhsQVIvd0o0SWQ4?=
 =?utf-8?B?U05iU1BJK3hWTWsvNDhYYlJKOFFwaGswbWtYLzlVK2VIQXV2UU85YzFtdjNs?=
 =?utf-8?B?K3RVcGNUeWdyZGRvTUxJTFhSOGpLODlEb2pkeE5jZHk0dlBjelAyNkQ5UHhN?=
 =?utf-8?B?VmRXeWdwR0RjNXQ2TXNMUVdDNGZzN2ZwMkVobVJUMUJYakk0djJsc1RmcU9K?=
 =?utf-8?B?dUFyNXhLNVBQc0F3c2kzQUtCM2JaY2xpUnpsZi8zSE9RVjh2aXpGcGNLS283?=
 =?utf-8?B?QjdUVTU3RXVTWER6Y2dsY0NieEFSUTRBRHczbGdIVXZkejR2SStKem80NXJv?=
 =?utf-8?B?TVhtN1FuY2x2VHFvSitib0F5N0diT3lsSXZHRDFmQk9oS2ZlZXlJUmdtYlg0?=
 =?utf-8?B?K0RRbmZReWtRcm05dE9UOE1wSitMY25rL3k0alhISnRQektacHdOdDVpaVp6?=
 =?utf-8?B?V1M3ZXRFai9KNFJhZjdCMmZkNld4cmJOemVPV2x5WEQvcGttY0ZYUnJrdXIw?=
 =?utf-8?B?dHF1dFNBN3NyUWZ4Q25saHRCYVhZT3M3VXExY3B0L2t0VXBVVFB3dDRidmM0?=
 =?utf-8?B?aUZKN2pzV3Z2SitrYitrN2dGZ2JHc1lkSFB3T0djekFPV2t3czBINW9zS3p6?=
 =?utf-8?B?ZjNOaU1hK2QvTEZoMkZHQzR2enFRSzRWcUJVUlNNVU9zeWNMWTlkT0I4eUJs?=
 =?utf-8?B?US9KTDRyWkF1ckZsQlgwRGZHSjhZOGwycHB2S3FRQ1dNQUFUemZMcmt1MnhV?=
 =?utf-8?B?cG5nTEF3MDBSRkxaZDRpTG0xdW5OOEJDU3dHVGJINGYyOWdoNDlyTmdPTytC?=
 =?utf-8?B?RVVPem1mMlFrR05HeDBIUmFFZWNIcGp2L21Cangza241Nkg2STg3dU81b2dV?=
 =?utf-8?B?YVNEYnQ3WmxHWjN2NjlhSFh5QXdvUlJpNDlWQTRFNmJIMW44cE1VcGVCVDVh?=
 =?utf-8?B?ellHQ1JpZnZSSUF4R09HRnVsMkFFNThKNDFXZnJjTytKdktDdVZhaGtQQ0Rt?=
 =?utf-8?B?aWNFMGthdEF2ODVsZFhZQkVxc0lQZVhNa2lDZHMrRHVPT0VGQzE4WVpHc3Rj?=
 =?utf-8?B?dnFsNkhoSXhGTmxMVFMrRDhWN1ZvY3NDMjNsQ0pCMlllNUNxeWhBZjVrd0Fl?=
 =?utf-8?B?L0RDQXFzV2I5NTlnUGp4ZGppVS9EdTFaQ3NUeFFvcEdmTGVuTlFGUEJGOERp?=
 =?utf-8?B?blBWemRDMkJtOXpEK2swQTV4K3BSOGZDWW9ZMHc1d29ZbWVpOEYzZHdTb1J6?=
 =?utf-8?B?eFVVd2J4U0RDNjlBRmFNNVJKTE91TTBMQVRlTkIvSlhkL01QZ2FZWWtLWkMw?=
 =?utf-8?B?KzIzWnBEazNiNUNiN2ltKzBuRzJxa3VZQnZwQTUrcGRJME10R1JuTmIvOU5q?=
 =?utf-8?B?VGw2QnM0b1h6b1N2MWg1Nzh1ekJ3eTZMUjRhYThldnRkQmExK2hHZFdEaVRB?=
 =?utf-8?B?ZkRCVllwdWM3VlpnNm5MWjRGT1p2S1k2OGV3RGpxQWpCSDBxOVlzenZRdnlR?=
 =?utf-8?B?SEhGUGJ5YlE2MVJsK1BRNmxZU3NXc21oZlpqZ2lGbldWN3Q3ZHV6UzMvdmRz?=
 =?utf-8?Q?WMXlRgG5ogA+ICYGqstiYM5dk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e81a7c-4b43-4c18-e8bc-08db10ac33c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 05:59:59.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSQHbYuyIQh/Vnj9NWZl1sjHabv/Gh13McmvU6zh2KmolMO2YUoZO9owi72CTrQRrr+Y0wu3W2fqbMd2aJpj7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518

Joerg,

On 2/16/2023 3:17 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Tue, Feb 07, 2023 at 09:17:52AM +0000, Vasant Hegde wrote:
>>  drivers/iommu/amd/iommu.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> Applied and fixed a checkpatch warning. Please use check-patch in the
> future before submitting.

Sure. Thank you.

-Vasant

