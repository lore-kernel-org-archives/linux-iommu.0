Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231D5696
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyrvHFIrWZ32p7BBZC0Lp7+hu2RSmPeUIlqGRMjpBHIbFt8Dx1e7r1RKon2X8DBs3qXl9VMBhS/vpsufUW7FTi4CLP8oQt+HX3HUzeHA782DxF73VHTXnmjVaO4vs7K2wt3WfS1WZhnM+62s/lWEKwzlLGZk1JCYtn0QDBseQ6ZE/3hPxYez/Em57J6W7vGYm0GgxMOVLpZ/YNWuG9agcfdYSFn/nKr/2NKN67KGEJKTBuQqyIHGMrXLqyYGNH/nGUovw7N8XOj3RcIfAVnBZFvu1BwWRSrU3ttGT/DE+JUK7MeYccySoKiebvm6MhinC1ZCFPUtJO/edvakBv/zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDwRxExKanuodGpO4gbjr20VyFmjm8TSd/X9awpou0o=;
 b=IMMcf9juYe64vXdITsivUGT+fr0M5AidPeNIiMAf2yGph5qDYRltLol/zQqSnURjBBWgj49PFLY5s7O9kCRbhwklsW5XJRyrarHemSfSa4w0sj6PEcrW4oBTczj+Eg5kGxBzCmh+H+/bak3D1RkURGYSMl2zXrhkcFx9/s9ODp0AuiUbSbw0aw7rTKwzK5XA2wL7G2XgKDZ9dIhNgqY6sfhp2vo4SIOiU/j0B6CXwyBmO6yqWmBoCIUX+jVoWsFDRUzKicIz5RDzftSyelgZybStWRgtHRL1Serj6bv+Z8btoFmYFtUvybsUzur82uSDZCvEwShFpaCSrG6lCyMQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDwRxExKanuodGpO4gbjr20VyFmjm8TSd/X9awpou0o=;
 b=i704vyg7uBl7UKYa9XT72IqjayB2JrbGSpBIIX3363RgYqVebjdDjHuA5E1oEhaWtiZnsKdHRoInqlJXZdbOQo6hSzUUxwBJkY4xpl0270WtvA/3xkpIeiHMNNA9ERgFA3RAmQKX1WWSRaFKVpYZr3KOjgkotX7KufM/JhQWIlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:43:45 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 05:43:45 +0000
Message-ID: <41a24259-7c23-a53e-0718-9a331ee3ef5f@amd.com>
Date: Fri, 28 Jul 2023 11:13:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 11/21] iommu/amd: Clean up and enhance protection domain
 flags
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>,
 "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org
References: <20230712141516.154144-1-vasant.hegde@amd.com>
 <20230712141516.154144-12-vasant.hegde@amd.com> <ZLGFH6qERiRbD6cd@ziepe.ca>
 <db7fe0f7-77d9-f898-0503-d6da58cf25c6@amd.com> <ZLUyzrmRKhz4wwQ0@ziepe.ca>
 <1b5b9a47-0e4c-927c-c19a-9ee05ef66918@amd.com> <ZLaHS5bWAu1yjqoW@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZLaHS5bWAu1yjqoW@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 43313bab-d9f1-4904-398a-08db8f2d9b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/VKteAYaoW8HYMnt/Rhv0A9WUXk6MLT7hQub4TSF6agwrfdUmv6pR0dKvXeH84jj4SV7j7L5YApWJgVOEzmg3vKPKPJ3xfyrAimnLQcaTmz8topIl/6vPeXNupU/7ZO3UlD+uEZePg/V0GBKBDew3roAmLBg6mZ/s1e+l0ZHrZgBKpSw2Qc9ooz4IJaMSt5o9Oirqwe66UzRPrOvKBf/MYTF/bE/FnhVQ28M2EWftx2nJXLn5H9SF6AD6pBSbNlQA0cFXy14/9klesWmvuA7rxeioVKHcwkLbdhdSEfp7ijR1CNb416WFSQ2hqaVu4/CKQPfYWdrQGeehJNNPBFpaRcwwc4MgciF9bUvX9IhbP1ZL2xeXBOxNzb3j6A8XrbBiTxpwEWIMExqBkvRj/HO/RXHI400yTHVYUx7OnseAUa5fp+970D8yQm4gYm+5xUomj/64Y07E+BLciM0FONlXwKwxzeszl6+90Pxu2W6ERGGe2Yy3VvpRu8/LuWqp8gF5JFInpxk9PdGObDUKm6zjzXBqlOYyQvISF3gpzzWVqZvDvbRVH1JfiKka5Iqtq5+7i86nsu8ObOCbMmbnpw0/8yyXSWjtqAGlYlOiTVFXQBups0O3+yaabQTf6X7qRVq6FK9UXlwtg0gUdmNnmlnxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(66556008)(6486002)(66476007)(6512007)(6666004)(66946007)(44832011)(4326008)(110136005)(38100700002)(41300700001)(478600001)(36756003)(2906002)(6636002)(83380400001)(5660300002)(2616005)(8676002)(8936002)(31686004)(31696002)(26005)(6506007)(53546011)(316002)(86362001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9FNUZIYU9ES1BxZnV0U0Y5cGF4SGlmWFBlR2cya01zQ0pZOE4vdzh1cGY1?=
 =?utf-8?B?cmVuQ21rSHloblo3c1QyOVdSbm1ybm5iUnBrdGg0ZkVjZmFMdEtJcnhFMVFT?=
 =?utf-8?B?U3FkbGV6R3N5NlFTNXFHTEZ3cmVYNGVRTGp4bHBDVWo3YktGajJvRWphalcw?=
 =?utf-8?B?WGdqMk1EYzR0ZFNDRjdldVdEOGFkdk9TMzhFRW1laFR5ZkN6THJXWU5GMTlQ?=
 =?utf-8?B?R3Z0MFVEa3d0eFdKNlRrSWJXcEltUTNCem9idG8vSWVZRmZrRVhPYjhUVGw0?=
 =?utf-8?B?OTFQOEZjLzMwdjFYUEhCNGsvR3FGMjFPalJTcWQ5bzBoYllnYm5BOWFnNmR0?=
 =?utf-8?B?MUZzMURnZlg2cm5OaHFWb25GVGRhVUlCQTdoenluWU1xTklEUkdpYXdzRjV5?=
 =?utf-8?B?V1VQMnNlVXpPaTl1OHp1ZXRiMmlmQi9kR21rMjlJU1F1NW03d0hBaTVYcVpJ?=
 =?utf-8?B?TmVWd0VoTnVsb2NaZFcyL0MwRnlMRzE4cjRYVmtaYlJWK0hPTEtPVkhnWFBJ?=
 =?utf-8?B?bnZQUWM3MjZZeHFGczNzclgvc05vWHB3SERnbHBPcGFJamREdzdFNXhTWlc0?=
 =?utf-8?B?cnZQTHBlT1lzRkR2OWEzYU1QMXE5UCt2RWYzRkFNQmtaTnlFZWViQml4amZD?=
 =?utf-8?B?VU42SUNNOG1zVm50TnJaK3ZwNnhBQnRuUk81VENNM0dNbVRBZ3ZOckVvcXRG?=
 =?utf-8?B?QXhOanZvNnJLbWNsZFhQNGxQeUhGQnZ0Zi9DS2ZIYXEzTlpxSlc0SmRWTWU2?=
 =?utf-8?B?bGFFK0QrbDAzODhkMytlV3pTd3NJMTM5UHdjVWJnQitTZHl6M2ttR2NMYTlI?=
 =?utf-8?B?WFRxS1hVRXlib1FhOVlJN1c2UFBXa0xvTFUvOSttQWRiM1cyMzlkUGJXcTVZ?=
 =?utf-8?B?NWJjK2J4NUtZcDgzeG1mSHFvb25EeUQzMnJrUHFsVFBzVzcrRmZ3bjE0Ykdl?=
 =?utf-8?B?ZmlERENxZmY4cVQ3Zit0UFhHTG9yV0N2djZEdnR3dURjcTh6bjhQRTdNMnRT?=
 =?utf-8?B?U2lQZWt4djFWTnZGOEJPOFZjZVlBYW96WVRSNmp5SWlIYjdaaWlJK3BXVnFq?=
 =?utf-8?B?Tk11K3RXSGJNOGFEZVZXMUVSNnh4Tkl6bDlOUHdBcGpsWitFUEtSbGNleHFE?=
 =?utf-8?B?SlFiVTR5V2dlTHZrM1ltVVdDaDBxQjI5SmltVTExMzExTGFaM1VBT0hkRVhP?=
 =?utf-8?B?eENMQUlLTFYxTVU2RUNhZWxVU2gzNnpUamMyck9BNGdrSXN2d1lmeEJjTUdn?=
 =?utf-8?B?TDdtbTk5TkdZbjNxK3B0R05vcUxGMlVZQVNPLzl2STlBMzZGWkNEOTV5MXhQ?=
 =?utf-8?B?ZENCa2VSTTU1eHpoNk5GMWlQYWs5TGx6ZlNwSHlDOGtDWjFkYmowMU04cWhM?=
 =?utf-8?B?VEsvZGJGeFNCQ2FDRWw4dUNJWDhiNkpOeUpGdGJmM0hINHlzdzhVeTNqdEhC?=
 =?utf-8?B?bzQrSlRtUXh4aEE5UWVENW5IUnhvNDJzUXhaR29uV2tqQlhBNXN3UlRoQ2hC?=
 =?utf-8?B?TEgzV251WEhLdkxWOC8vdmZFL2IrcWViNU1adTFQUCt3clhxMTN1RUs4Y2VI?=
 =?utf-8?B?VDZidXlkcWJWM3dKRElmQ1l0eWN2aVpZZE9sZXpIWTd5UTlPNmxneHBja2I0?=
 =?utf-8?B?cUEzbm5SOHBXWTJDbmhTMytjKzlTODZTenFGbzN5eXdTMUt2SlBiUzJUbE9j?=
 =?utf-8?B?RTZmOS9xWHlSUzdFMDJwMi85VnA3cE1SenZkeTZxWnZkMVhWRUpCR0V5VHVD?=
 =?utf-8?B?eWFlcXZHT1FBcGwxaEUvNVFEVVJFYkcwK3dZSWJkazFwM05UU0JLUXhYUGdj?=
 =?utf-8?B?Y2kyNHd3SWpnelExZjBFenptU3ZhQUErYStxMTZhbE1WSjRMcmIzTDdOYjI2?=
 =?utf-8?B?RzNiMEdOWDgyd2JaNjBIQ1dDdVhWRmdINm9mREVjWjA1ayt4bTA3ekFVWEZC?=
 =?utf-8?B?UXZXTUQxc09pVFlzRFZtdlNRRXlkMDhFOXNKVVBZYi9aZTJtU1NVTVJnY1ZP?=
 =?utf-8?B?bk1Za0djeGl2cktrQWVPTVRBdEhpOWR0RUhpSjFWS0wwbGszdGJpS0hLazJX?=
 =?utf-8?B?bitHaTJNTG52YVRuc29SUVFGZ1UxcW41ek5JT21HSHdlSEZ0OVBJTU1nTVBr?=
 =?utf-8?Q?8nSkG/ywsl71vIpX9R2KqmdU2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43313bab-d9f1-4904-398a-08db8f2d9b84
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:43:45.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUk0qRF9WpoxkLS540aij22kr0K7Uf7XwXcRK5lkNsa/uedzvH71+FxVzVf9xngU87EzJCFoM18TadOPJX9Crw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223

Hi Jason,


On 7/18/2023 6:06 PM, Jason Gunthorpe wrote:
> On Mon, Jul 17, 2023 at 11:38:44PM -0700, Suthikulpanit, Suravee wrote:
> 
>> Then we need a way to distinguish whether the v2 table is:
>>  * Managed by IOMMU driver for DMA-API, which supports only PASID=0.
> 
> There is not even such a thing.
> 
> The driver should have an iommu domain. It should have and indication
> if it is PAGING or BLOCKING/IDENTITY. For PAGING domains you have an
> indication of the IOPTE format.
> 
> "DMA-API" is a PAGING domain with v1 or v2 IOPTEs
> UNMANAGED is the same, a PAGING domain with v1 or v2 IOPTEs
> SVA is a "PAGING" domain with v2 IOPTEs
> "AMD IOMMUv2 API" is PAGING domain with v2 IOPTEs
> 
> The core code provides two actions for the driver, attach domain to
> RID, attach domain to PASID.
> 
> If you attach a V1 PAGING domain to a RID then you have to put it in
> the DTE
> 
> If you attach a V2 PAGING domain to a RID then you have to put it in
> PASID 0 within a shared GCR3 table. The GCR3 table is NOT part of the
> struct protection_domain.
> 
> The descision how to configure the DTE/GCR3 is based only on *how and
> what domains are attached*.
> 
> Doing this wrong is why the driver that that weird mess with trying to
> have two different versions of the identity domain.
> 

Thanks for the detailed explanation. We are working on moving GCR3 table from
protection domain structure to per device structure. We will post the patches soon.

-Vasant

