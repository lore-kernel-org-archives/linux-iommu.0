Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FEACA41
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 12:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK3h9uQQUwd2DV/MLoqZyh+DspSVHDMuoE77KGpVuCimcTh2JRTV5J+0HQZ5Xlg2JRqP6977ApsnK23PkwcuCz03waDBFBWiUHEYbb4Wqt0a/aCuXQ+LZFj3VczMdt4yjUqAu35+Dv6WOpAWBVAks9AgVxlv9Ml6WF7Is4Rh7XUmvudhdoEJWaPaI9+Iy+b8LBSEShgdYKNqsoT/Kvsp4MMpO41GpS4WnP2Apl0AKDDXYr450SAx5MUqoCkGnSkigs+hq0LPxXa8ce11hyMFJWflCaXYsXBPK2mSkIKBWZPJNIl1N5tArjA50v/1uyZtl4dphzZh/iX7xZHnwnMAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnE0kQtQJSE05iJBk9tALQoM5hEhAIJLYjOB9ZW2HoI=;
 b=UR9n//5tm+QqHAVHhkjgbNuLuvAvMHeATLUOJikQp98d8JATpbPR74b2nJwLor9dMVCho6ij1UaaxNCOgnuzbbVu+3z0rBb4cLlz6fNMgTN30GLUmLDnHilCVcfTSnQjLaYmhrp8kZG/PTzcXtotS3hyZDoroVileItem6knokOBzfRpDkwRAOjhlVMXSN+t0TEGP3GOc1g7h/qcE3KXBR3C3qNoDi+eozjA4d55clNUISxHRDwWSmG72UMy6JeEejlMJ4uy2BPiVAUsCP/uQij5fQ+aGt+/1nLKWE84Y87Y5lHk6yq3wuuEBMCKYOeTYPKwJaBvPFkwpBkd2rliVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnE0kQtQJSE05iJBk9tALQoM5hEhAIJLYjOB9ZW2HoI=;
 b=W0TZG4BsH2nIqZOy27IVykbZ76I4z/gYlfkciSwfreclgTfdYXlltZeZ2slGPThPZHQZedKZLfr15edGvvIPT1QFS05S6akw/x9H97HGNmv3hPD7sNb9dyiAyfqbNaTuBS2mm/Q7ZliiLIEX9o8YLZE0ipeiPASptuK/cfOpIOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AM7PR04MB7176.eurprd04.prod.outlook.com (2603:10a6:20b:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 12:29:50 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:29:50 +0000
Message-ID: <c1c1f3d2-61c1-c1da-36d8-900f1982db63@nxp.com>
Date: Wed, 26 Jul 2023 15:29:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH] iommu: map reserved memory as cacheable if device is
 coherent
Content-Language: en-CA
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20230725140055.12823-1-laurentiu.tudor@nxp.com>
 <ZMEP8pqztmPw3UmP@ziepe.ca>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <ZMEP8pqztmPw3UmP@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::11) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AM7PR04MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d570668-09d1-45a1-e465-08db8dd401c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EWaPTtkdwEvhnF46XFH8PjwkY7e8/Lz+zBcKBczR6s9FRuBLgLi/WXEfRE8EMn5cmM5UuD/ftD7dH+iljBBpUbbL/jlbIiPkCE+njOxibREDqAEMy9ucjua86d3+2g0n+19fQCa1u+zS9n082R49/BYY+qh8P4RtogSwh7e5B4zLmlFRbRFC05UUYe1xJT2Ig5QILSy/v//xYdzCL6FGyvsY0yloKBSifUuieIIVPcAtLEyBiMQ1r25qmom47fX/1ii1wlc+FFKEUjSAZ8vv9/AXPSG3zHzAnWjchpEYLVnev+Tl/f0Pf6ME8xMcanEYHkScTVHuTQbh7h2OL/2ZP23l832Fjyfh+YFT1fdZ+DeWTcwnTsy+1T7ypiIV3IRpwdpg2+Uv1QgZzH1C0KIPMJ5LuIc928hzjlTL43/1Y2BloroRiXlnJtSGMbYLpkNoaKAxdVNWYsA9t93xdaIJBfYv87XunAibaNGo4kUas8r36pvMOJtd1AlKZ8rcJK2q8kNFrCkqiA9nOeTfyM8mjJtyzmJp6K9jB84ZUbXyDYOZS6hCeiYUGAs/umUsFsgvYoMY0K51PyeQspJD2Vg7g/5On6zOkg+uuNXaEO0x0U4S1FtO5zYRxgjDy+RAIX5Dhc7DMK/nEjdElU+7EKIukCCsjSCTH+vXjJBRVUm2wYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(5660300002)(44832011)(4326008)(66556008)(66476007)(66946007)(2906002)(6916009)(316002)(4744005)(8676002)(31686004)(8936002)(41300700001)(478600001)(52116002)(6486002)(6666004)(6512007)(966005)(6506007)(26005)(53546011)(83380400001)(186003)(38350700002)(38100700002)(2616005)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0JqanhITUg5S0pCeXBRTlEvZktwQ1dKY2NpRTVxZ050dUVpdmcwbTJ5NzZO?=
 =?utf-8?B?eWV0QXUwS2NDQXhhUmRKZlAwNWY4cHNxNDdrcU1HTWw5ZGtyTDFnbUVCQ0J1?=
 =?utf-8?B?WmhYaWF2aklSbG94UjZzeEFaZU00blNudnMvdTRZSkR5U0d5VVNXeFBwTDMr?=
 =?utf-8?B?ZElVSFpHMHFCYjdEdHhYVFNwMEw4N0JzMzN1MnBxcFF3ZzdtbjBzU0lUSGhR?=
 =?utf-8?B?YStWSjltRVkvZDRqbWJUQlFhK1hVcXFzWVhpSWY5UDkweTgvMVBGTG9rbEh2?=
 =?utf-8?B?QVNCZG81eTRCbTVacytHNEZmbVVKRkZtdisweFRsODNUWkgrSFV5NnlCbmxR?=
 =?utf-8?B?ODgvc3pZazB0U0NZOVhTcHh5MkhIVndRaDR6a0RPOXM4cGFGalV6WGtYZkhB?=
 =?utf-8?B?Y2V2MGlXZlJaU2RJMmxDSGE1NlBXOWFCM0pDa3owQUlZb1JBS1pneWhYSkor?=
 =?utf-8?B?RUJkcTRyM1Q5MnloakpBaGRyMGNVSjNTZXFtUUlsenZ4UjlYbU1xL0JOaG1R?=
 =?utf-8?B?TndzWnVvMG5rZ0UrM3ZNNUhEUGdpQWNCQ2w1UTNzMlBlZDZ0YXNrRkFBTXlz?=
 =?utf-8?B?dTR4ZkE4R2ZLL0FMWUV0Z045WHZ1OENGTmZ0enV2NHdjZWNFeEdjS3VxVEZK?=
 =?utf-8?B?SmlianpQazVtQUtrd3plOGtZNEdlWjZhVVJXdWhhQzR3NTdONFRqYWdPYjBW?=
 =?utf-8?B?WDVkYXZBdG80Mi9Pd0lQcFNPNVpSd2NoZGtRbHRWck9TQkNWRnR4LzU1VUcx?=
 =?utf-8?B?a2tYaE9XQkhUZDhYZFNqbjI3OWQrT0JhVGEyNDlXTGs2WmdZeTFNMDdjNEFh?=
 =?utf-8?B?bmJBV2RjZ2dSYUpYZGN6eE5rV0JzOGFheGRnajhuM1BtTzVEZFBQaFpFVlZh?=
 =?utf-8?B?aUxLamlRVUVpcjAvZnZwZ0RjWU9rbURuQUMxS1Nyb1plNlJVK0FkeHBTZ2ZH?=
 =?utf-8?B?OTNXeGxJallYL3R2VmRlODllV09XS3JtQWRsQ2pIZDZkVm4yYlhhTFFEb1Zu?=
 =?utf-8?B?WFZXaW41RndvdzlzZVljY3Fqb0ZlU3dtbldHTFU0dE0vMnVFQlFRZHpsK1c0?=
 =?utf-8?B?Q3BXcTByN1JZVStoaGRXaUpDRnp6RndEWWQySHRqRUxUMTNiMnNTT3l6L3hB?=
 =?utf-8?B?UnRmR085YlI2K0VlZEVWOFJkb3dIWForNG9PekNNRWZFTExHVk9aaUY5S1Yr?=
 =?utf-8?B?dUJhczZVbmlEZHcrU2loSnRxeFhsaWRhVlBUckJCcjFMbzA3dzU3cEZoL3pw?=
 =?utf-8?B?YzRpVS9PbUUwTWZJbURRVlduNGFWODlNUjRWRkhyMzk5b3loWGNrRUR1VUc0?=
 =?utf-8?B?Sjd1bGJxUlhyYk1IN2dVdmFXb2lrNlh5Yzd3SXFQb3ZwYWlDOWp1SEM3UFJE?=
 =?utf-8?B?SFJERmFrQlNiS3ZYVVcybXJIRUNkdTlqR2JPQkMyZC9GNFRkNjRPSGNhRHQ2?=
 =?utf-8?B?a3lHRmhucXdTN3Z5YURST2ZsQnBOU3QrczZLS2E5UVBDQTJSMWx5N3BkZmJK?=
 =?utf-8?B?N1JMcmFDVTkxSTNFRkh2dm5pWmFCR1JIaFovOE0xM1hqQ1JTV09nTnhoYTdE?=
 =?utf-8?B?NW5ZYTl5b1V6WXJwMktBYzdiYUl2Mkd3bjFKQVZpbGtoUkdXaDBzZnBOQW5D?=
 =?utf-8?B?dFBBTXN1MVF4Y1ptbVo2dDkzem9DdnVjckxpRGE3UU9hYUtBYkZJdjhqY2N6?=
 =?utf-8?B?UFNRWkVSQzB2Z21NRkMzelh5SHNYQmthRE1FZGJVQlFZdnlwYzZuZ0NoS1N3?=
 =?utf-8?B?OTR4ZHM1WVYxNUpCYmI3L0F3NXluYkRieWdUQWp6azBZYmQ5MVVTcGl3cXZH?=
 =?utf-8?B?aUFLR0RlVUVNWE5yK2pja3F3VExTN3FIY25JQUc5d0FsaGdzSzNoVkMyc2RO?=
 =?utf-8?B?VGVLMkcrTkN6bEMxejIwc3VwRjQxUW1pMDg1SW9xSk92SzJXb3M2L1pqdDFa?=
 =?utf-8?B?dEVweVlaUU8wQjhuREFYTUZtK2VHeDlOS0tFMFlvU056bXNSOXJMWWxmQVls?=
 =?utf-8?B?VHZSR0xKQ1VDSFh1VVNYS3hsR3VtSkhQZTVKWVZKeEF3Rk1nQURrRWxRcURi?=
 =?utf-8?B?MW94eGNZekRvZWdOeXUrajBQTWd5TDVpeDZzcTErYUMrOUpnaUJMODlPbFhU?=
 =?utf-8?B?SU1KcExyKzI5TWVkYmhwTzNHamRQZ0VNbmMybmcyTG9INCtQS1V0Y0VUWWx3?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d570668-09d1-45a1-e465-08db8dd401c1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:29:50.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wZsTpze4uojE0YFYlqkFzr+QrV6liJWVHADrupi9VXl/oFqkPV753fSpGRHhlZHOO3tJ0RD2VjVNBmDLHBKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7176



On 7/26/2023 3:22 PM, Jason Gunthorpe wrote:
> On Tue, Jul 25, 2023 at 05:00:55PM +0300, laurentiu.tudor@nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Check if the device is marked as DMA coherent in the DT and if so,
>> map its reserved memory as cacheable in the IOMMU.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>   drivers/iommu/of_iommu.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> This only makes sense for IOMMU_RESV_DIRECT - is that your use case?
> Maybe mention that in the commit message

Yep. Will respin with an improved commit message.

> And add a fixes for the commit that introduces IOMMU_RESV_DIRECT into
> of_iommu.c

Would it make more sense to mention the commit [1] that actually added 
this support for mapping reserved memory in IOMMU?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5bf3cfce8cb77d9d24613ab52d520896f83dd48

---
Thanks & Best Regards, Laurentiu
