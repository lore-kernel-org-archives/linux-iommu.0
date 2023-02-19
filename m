Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21544A29
	for <iommu@lists.linux.dev>; Sun, 19 Feb 2023 10:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNfteiuUosaMms6trTG8Xa01MEUkLMyIYJCr3JO7XknIgdCRUV2OsYxtcxpJcImsJ2t+ka9Ec1qNpWWp8XF/OnrJrxZyUFPr9uXxNjAA4LK60NzAaGP5/Hco4TGKwwKcPLgh6hBFJ/Xs92fgdFXdHVnVC4c29Ep3A+6VZ3ED0NwRzWV/SOPhdwJ/YoJ00yYGTxME+YE1lTMbL1h8BH5jNvN89fuTEdKUpONDZqeNvmTKq+1ToSnK0DgncXQf3wzVUPOTgYOCpZjISLfDomphv4N5UKdJ+8iGgc/BAzlF6FabaHw7qHDzSrP0dqy2/7mTpzc1RcVF5yqcdrhIRGcpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1pVSIHFxmbyiBrZ1Lrp07oq5vQorWvtxYP17yBKLpA=;
 b=l2pcAn9HQt9GmolryMB7+MxoSWuWvCFgbNvAWHuWVd3L4vspF9pwp1UgMQ8bzA0yM5PQwE4G8X3UyFh+R9sxn23vQlUSc2SGKJ9weqpS2qiazvI7cBMl23GGZTQczjIr0aWxtANo15+qR72BtN6OLaaiY/cBICtIelN60IJC3XV7ZOIMJ2I16KQLoVPChob1DOD9fdlCNV849yc5o31mMG6Pp38mi/ozZ3VqapJKonrmlkQ7EYc4dmzsHuk6/yxhAq05bOnMkFLvsMPks0ydndPiGpV3eeiuwZWGDFqn+7jG2NYre4snSGS+4aqudwSGEpyuWY6RjtVRMbTQPm35Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1pVSIHFxmbyiBrZ1Lrp07oq5vQorWvtxYP17yBKLpA=;
 b=xezG9o75w2b+FXNnEB4Nze+QN+CSaewkqrz6K5QLQ8bd+DLiNFpwyOtoprTA5CrnoTb158j3BQFpHEg4rTyTo19KMGOEVwdhNis0/hGxsnODJPiTXX8zeM9D4ZFNv1UASpfa0wBgcfTGai2IRn8f4pUBY4Lt/jNhcRqsLgh9NSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.15; Sun, 19 Feb 2023 10:17:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd%4]) with mapi id 15.20.6111.018; Sun, 19 Feb 2023
 10:17:47 +0000
Message-ID: <c76bd797-a0b8-b9c1-d3d6-74e42ffa903a@amd.com>
Date: Sun, 19 Feb 2023 15:47:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, baolu.lu@linux.intel.com,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Matt Fagnani <matt.fagnani@bell.net>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
 <0f6e2838-9d7f-dc2c-6e5b-0d02e239f032@amd.com> <Y/DilsJ9ItuWXhGU@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Y/DilsJ9ItuWXhGU@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: 888c9a62-36cc-499f-06c4-08db12628bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zQx8lWvI1AHC5TF/vAG2OFKWBinSbCEkzzouj5tbklMuGLQLLLl5lGF0JvRYaPRadKCn+CGNGs7kpeg//abtihNYAZzg7Iu/ipqQOG9jId5N0y6n73vl46wTZo9TIvU3Qa75Un75NH+A/vMqaEi8cjNBcB69sI5Sxc1rRJYlmqiJwk52lrFQHjb2jbFdaXhM8uFg0JZa1E7iNxGH6Uup6YaHXEChBDBSgytxDmrSefOy+JhNcOKqmnhNWvuobsrJvrF/TlN61k2/YfZ0UYoQRKJ2XIPumT6SU1/eMJZlIs+mQdfasQ+S/4/g5aW3UGUrRsvIg3VQQi2r+Hz9zYjkM0vuLGjrRrqm5e4y1y7LFXCDsfDqMJACHgLVsF0tsjaSusvLRDCa2ngZ7aVeNIYZ5/XQo8FCLyp/OZNfM9Tu3sH59GcIxjvSmbo93moLxEX1zRtd6yTtRIo4CyC+ZBm/7q5d1KTJuaJRhrWWxCUVJ/tjfMgOQtVSpMDO+VSHn8e5cTJYqNce0HgwCuGklWb/qvW2zIAzKZKeRRPKqtxDNBmOstXejNWbxDTC9FSJ5F0YGWI4FhPbIc9CXYPEGfVmJM4Pz36JQgKRoVQBR/46acHy7+7NbznecfZ+yUxEmPzmsmYjC8axjKClf6QxrwzkPoDzCqGtvtLdD/8UqlQJmFCBeoOZ/hfofsOlMzj0LdQ7+fMdAmiT5jU6mIAG2pUJIYYeaUxBhdYrldXJ4yaHB+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199018)(5660300002)(8676002)(2616005)(41300700001)(6486002)(36756003)(44832011)(66556008)(4326008)(66946007)(6916009)(54906003)(86362001)(558084003)(316002)(66476007)(31696002)(478600001)(8936002)(31686004)(2906002)(26005)(53546011)(186003)(6666004)(6512007)(6506007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGEzY1UwbnhOMzhxb3orekg3RnlFMlZaT0h0SS9ySlZ4Rmtaa3FhKy9SY0dT?=
 =?utf-8?B?ZGE2UmlLVnVaYUZUQ2g5Yjd3b3hTNnNYK2dMM2Z6THd0U01HS1FNSG9XMktQ?=
 =?utf-8?B?M24wOFB6TDBBZzZtejVqTS9aVXo4dzBBb3ZaazNpdmQ2STlWSjJ3WGE4WldW?=
 =?utf-8?B?RHRHT0RBOTl3V3ZEUTgwR3B1Y1MyQ3BtSHVDcFNzZnF4U3lwcGJ6a3REVnB0?=
 =?utf-8?B?M0xkZlJQaDZQTXpGT3BxSGd0UE1sczFsZTFNUlQ1d1ZaU0I1SFpabS8rSWRr?=
 =?utf-8?B?bWllbjU0ZEUvZVhGUjJaMC9lY1lLY3IvZWJic1FPWDJ6WW1SU0FLLzdHbE5q?=
 =?utf-8?B?eUZDNUpQdG8rODZBcVBpSmQzR083clFRUVB4MzU1VGlUZWhrdS9MU25KZkJP?=
 =?utf-8?B?UFNmVVpqS3g1MHo5TU1vZUxDcG1qNUdmSzBSdXUyUjVacVp0b25TQWIreWJa?=
 =?utf-8?B?RmpDZFBmRFErUGtBUnZDcXF1KzNyQVFXN1JwRElWNm1EaU9iZnhucHVtTjdw?=
 =?utf-8?B?bExvYVl2YnBobzlDaldKZWtNek5tTEZydHAyVklUVlJLbnYvVlpFVUg3VVlG?=
 =?utf-8?B?bGZteVBITFBGVzJNOHkwK2hmeGpCekM1MGhUMFh6SGdKd2g2cXJpRDBHTmZp?=
 =?utf-8?B?N2gwODBMMHd3enV4L3JMVFJlZlRpYU1Xek1PQnFTeU40NEk4dWhvVlBIZGlw?=
 =?utf-8?B?RG5zKzhtVGx0VnMwR2FuY0YzbmRHYWJHZEtEZm5TSjBSdW9HcVhyaFp2blJl?=
 =?utf-8?B?QW1RRWNXeHBZLyswYWl1RXpKRVNuT2VyWlRrclJMWnRtWTNBaGZHYVZTMk9Y?=
 =?utf-8?B?SHRkNzI0MkEzYWs4bWFzdHhGM2hxRTErV21zaUV3QmdIeVNLNFFOQlU2S2NX?=
 =?utf-8?B?d2paUlRRc0JvNDdIL0EwQWRoT3hvVVp1UEJoTnhoNUpETHo4M01nYU5sZFNC?=
 =?utf-8?B?OXJrZGRVNmNYTnZUMUNKL2dqeFhaK1hsUzNRTFpQc0JQNlZ3WSsxMVgxMEdT?=
 =?utf-8?B?VmVHeVB2Sk9wY3dWSkxlYXBieEpzVVcyVVNvY1VSTVB4cVl5aHg2MTV6NXln?=
 =?utf-8?B?YWM1WTZFN1ZOamYzTm9STHFnd1dodmRlZlN6WkNCZzcrQ0xrekNKcTdaNE5N?=
 =?utf-8?B?eVRWN2FVaFBwcmUrSU12V3ZKZlB0WmN1bHl6Q2VBMkJMK2NiZlVZYndpR3li?=
 =?utf-8?B?OTRlY3d2ODdyL2d5MXh2Q0QyeUhwSU41aEdWeWZKeXZKbmE1em9NeHQ5ck0z?=
 =?utf-8?B?YXhaQTA0YitsN01WVm1oR3AyejVNUVFEZ1NxYzNuOWQxNGF0RkhlMnhQaUtO?=
 =?utf-8?B?UWtaQVZRRlpoNlNVVlc5ekxyOVl0U3hoaUxzSzEzTDZGTEhVejdUcVR1VFBP?=
 =?utf-8?B?L2hJaFZUaHdzNlk4Y0lWT2VyUVlkTlFtNjdiRm1GdmZyaG43S0dQSFZjcHAv?=
 =?utf-8?B?M0pocW9PWmFTeGcyRUJhaDdSdzkxSkZ1RDA1RUdtd20vamozZnI3cjAzTXpY?=
 =?utf-8?B?QUF6YUE0SHYrZ01ZbXdaZlMxNFZjOTFrNXBEQlJVd3NJcmlmT1hkZGs5SlA3?=
 =?utf-8?B?WWZGbWhLRnJlU0s0eTRRTEJFdHpWSE1GbjJOQmJQSTd5RG1aQXFIWkJQcWtB?=
 =?utf-8?B?TzlPOEFaTy9xdzlUdmhaRXQrMlNycy96TkIxM25Sd1QrY09PMlc3KytnSnUz?=
 =?utf-8?B?dFZxSytsNmpuTFRvOTBTOW14TExFenZJRGFRS1RxYkNuL1lRWmxBUEZJazJK?=
 =?utf-8?B?SmxNWTZhYnVQdVIwZ0laNkhzVDJvdnd6Yys0UEs0dy9UV0xTZlRaakVOMldP?=
 =?utf-8?B?YTA1YXE2dGdVclpJM0JicVppbDBVS0lJK2lpcWhFTjd1UVlsREdRdEJvZkZi?=
 =?utf-8?B?Q0lBTFhKOHlTS3VqNTV3UjhvaGRtbVhxTXkvVWFqLzhMVldsbnA3SWxUNUd0?=
 =?utf-8?B?OHNaR0Q4MDRCNlorNTQwVFhzelRhQkZHSjYzVTIxMlFkTUJKckowT0draTh4?=
 =?utf-8?B?MXUwTFhzbld3b3Zvc1VGSU9IK1pMbjVMb2tnaVhiTnRXUHRvNEdvUS8zNkdF?=
 =?utf-8?B?dXo1K0hKZ1ZSa2N4UVArcGJWa0daOWRqWUk2R3dNWVNlNUJRMjFHdGo0ZDM0?=
 =?utf-8?Q?b6DjjBxrUkrwGubr3sPBhcAo0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888c9a62-36cc-499f-06c4-08db12628bc8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2023 10:17:46.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9M96NNjLsak9sCfzkWm4tMUU/8IOOuwcUOdwgahaM68MbEKjmNa1Cvx7HTOgxD4GjpSxonQcQPSTLXYQZd7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433



On 2/18/2023 8:12 PM, Joerg Roedel wrote:
> On Fri, Feb 17, 2023 at 11:23:36AM +0530, Vasant Hegde wrote:
>> Can you consider this patch for 6.2?
> 
> Queued to core branch for 6.2.

Thanks Joerg.

-Vasant
