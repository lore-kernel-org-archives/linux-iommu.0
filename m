Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9A15EA2
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 11:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC5um+Udlmde+0FuZKSDyMDZDlWdYxzDW5fG4JSNEALfcsSrmBBV+x4xWs4Krbz3PFm0eqOepVKHGAplYcG3Q8G/F23ckQpbTUuHDPDn9K870vYgSKleV4Asji7ECNAfxqPRvNgUMBS1w/x48Vh0GcsNtPzhzoeMAkqxVNU75flMkJ0tZRxMDvZlaLm2Dc9DXCapyoABwsh+erOcNI0azXONG/JcwTeqgSHNzRzdGBA0Go4W9XlFMl91vwI4CgP1Gb0stwWcHY2/w7z+PtpDzHbdlXPKPmF/XGZdu06jecQleG2rf+Z+Z9+ec1ChAtKuCbWjUIoeeO7AjGc3offXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+Zx3X44Lh8TC/2hHYbq4+QT8/UddAxJ9BQN540uF0M=;
 b=TiIO+ITXYzE/oHzbtIEqTgmka9foK4SxcfDtpr1m1Ijr55bZ31XeLKitwpRg7eH86YtYm0U582CyoRwN8wyi0jew1kzP5ZMXpZbBzF2rGa+iGoHpC03d5ZGRrRbAPYVROiK6+RN6aB+RRz59ru5T+fGU1y12i7EIzUOQ17Krzq/ifwuO7Cum+7qarWHc6s2HSte+BJoksQmee5WmkkjI6mPX0k7RZIOTusYsuVBq+pdbICHyAee8HcwT61P/gScvkEeQ9hK16uemr3735WXlxAM6MElfCoA3GpRFqx2yFhDqKjG6aSEXw0HnDUVfBEHwHLce1C+okuxhtoSUWpgb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+Zx3X44Lh8TC/2hHYbq4+QT8/UddAxJ9BQN540uF0M=;
 b=zzXzDaaVVlU2BovYF5e77xJUkhl1W9ygrqzau3WqyuJ0cKHzmRSlj13iKOTRVtAMBdw04Akp504YjP3nB2U3BD0PfNoyUd3lHCgTImhW/u/ijAshHP8nQtN39w2lgaAxr1WuOGydzDWX6F2/2L0LOICseanzEMLwj8+QZV3nM/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 11:02:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 11:02:52 +0000
Message-ID: <34d1724f-8ea9-8ad6-986e-618f0380313e@amd.com>
Date: Mon, 25 Sep 2023 16:32:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 00/14] iommu/amd: SVA Support (Part 1) -
 cleanup/refactoring
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
 <04e44120-61fb-3aa1-50b7-8a9ac01cea7f@amd.com>
 <20230921172147.GX13795@ziepe.ca> <ZRFjnaztAmplwIBW@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZRFjnaztAmplwIBW@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b071d71-68fd-42fd-051a-08dbbdb6f640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UFpaadSoPaGGO1ozSplPStp6BPGk2eTI9cojYRvp9IU1oiRjAIJc1oKY3ZzY2C4mxTK3tOLnyi3YqcsB62Kbf5xwxYdBxSxUeal4fvaRbOjOuOJbQbZItfiq8NQst+w/5EXoxm5d8Dja/SHrtV645QCjv/0UbyJwjfCzskTI7xAp/y9RoqJx4Jga3834DtU4yAHMabR5I0LMdUW72BZfIeRNRaByvCU27c3Q9dWj+n9COpX+TrgTak2PyNmPsGetxiyL2YqUNlzN4sFT56O3aYpGwTozPG/Cx58OqW9piYz7eByOmghCDCm2xlywV8TJrS/ALc5xwu7EpNIcPaSYoVS30TsTRAwYSC30eSNPV8a/wy0Be8496YS/LJ8Of0/FflbzkdX0YOK/wqQOWoQaEKN86Eg1qIIcsr4eH0GQkE9ngYoMJarxinNbGcgAaLoTnmS0HsuyiWc0XuqxbkZ9BQls5lD+W4iUcKIsqX4WBrBjp6KkvH3vpUi4xpQ9aMBZb90zp/5vimZmfhMLmeEic2Opr/qlJdLS0t+HsAw0OASt+sJlTyAXGDL9mM1TnQFdbv8IRtjW2MoVioGbopmrcUFcSs2ZYdbIfmx/b6FP5EB6RNkRgHvsrovbixi4ghBh+54/2YQ5ISacV4GwYX2WMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(31686004)(53546011)(6486002)(6506007)(6666004)(83380400001)(26005)(36756003)(966005)(38100700002)(86362001)(31696002)(6512007)(44832011)(66556008)(2906002)(66476007)(66946007)(478600001)(8936002)(6636002)(5660300002)(8676002)(110136005)(41300700001)(316002)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVR1V0tVZGFLUDJSOU9DTUtqZUcrc281SVV4UEVQN0dySUgwUkFrVk5zTURn?=
 =?utf-8?B?bnIvSFZ3WTFocXJ6bWlxZzM2Wlc3Snh3cnYxRC9rSW1TckpxVHozOHFxaUNR?=
 =?utf-8?B?UVpSempDSWxTbW5BRUR0MTJPNmVXNW8rcklNYTY2M0Z6YUdpMzN1ZWtTR3dj?=
 =?utf-8?B?Zy8zOU1ISTkxS0sxWjZYSUhocFZsZjMraGhaeHdPRzd1WU1va3hUTFVtbVgw?=
 =?utf-8?B?ajNESFNBNncyclExYjFTQTk4NmpKQ050Sk9RdkdvT01zT2tTNENMQWNTZ21Y?=
 =?utf-8?B?a0M5Y1VDeHIyUG44eUEyOHdja3ZtaGVvVDdZcnNMbXhzNFlYZXFqZFdETDAv?=
 =?utf-8?B?Qmwvai9oMmdGYThXQWVUQS83UTZ1ZDhxVnBjZWpEZDVLbkN1SnlqLzE1aVls?=
 =?utf-8?B?U2tVM1NqQ1paMzhHcFNqdlllM1VvMlZoM2VabVFseVo0NHdxTGhJcmc0YlFh?=
 =?utf-8?B?MWpIQjIxWUN3N0NLbUc5OHFwU0MyVERRNzkyc0FFbG5yRG84MWVveG9BUnlQ?=
 =?utf-8?B?V1RtdkdIdXdXVjVveDFsNDFSeFlxSHBiWXhNdGxyNGVrRVgxQy85QUxUaS90?=
 =?utf-8?B?eUlPbVprL0pmR2xPOVhianVNRVg4dWpRVXZXUUFhQk9hU09BanRQdVBRblBa?=
 =?utf-8?B?MC9xcURseWpNRXFINEFPRUpmUjN0UVpJQWtPdmVNb1pLeDNSRzBRVUh1ZzhM?=
 =?utf-8?B?RWF2dXRwOVU0R0h3bTYxWUNpaUVuT2tkNG1VRHlWOWxXTndEQWZyak9FYjl5?=
 =?utf-8?B?Y3FuSFdDQU1ubXQ1QjFOdWZ6RmwzODJjRVpXMFgwYlYwa2JGY1ZWdmNxUDN6?=
 =?utf-8?B?NGRuSWZSeU0zQ2l5UVphYXNVTVZubStIUTQrbHEvV2srK1V6aE0rN0dKSC9G?=
 =?utf-8?B?bjZHelg2dzNSNTk5ZkN4SXZ4S1lsTm5VVVpmYTNTTWlOVG1qZUZWd2NJTkw3?=
 =?utf-8?B?STJ5c0VnSDFzaGNzb01ZK3REU1Z5UFJNaTNILys3OG5rR2lCOHhDZGlpSWxu?=
 =?utf-8?B?dHRmWHpBZjA0NGJiMnFBSEIzODByUERFR1Z3aUkyMXVpU3Fta0ZPMzVtUmxp?=
 =?utf-8?B?SnFqZ1g4TitjdDV4dCt1ZCtENGl0WkdERjFEdHpCZEVNaS9peDEzbEN1REw0?=
 =?utf-8?B?bjAxMk1JaHJodWI4UjE5UldQSUlra3d1NE1TQ1BDcDR4SmhmZDZPTXhQdTFG?=
 =?utf-8?B?dTlUbHhVUWZrSHhFRjkzbFI1aXJ1bUFjMG9QNU5heFNCR1lrM09wQ3ZHSkZU?=
 =?utf-8?B?SXU5U25Eb1BTSGZKbTZDVUp3SjRVdnQrWDN1cnlCV0Q4TzdqZE0vNk5EcVFH?=
 =?utf-8?B?NG1wSHR6cERZcnJ2WDZCRGhJcnZpMDdTeFBxMWoyQjhkb2xHVkJObDBBajRm?=
 =?utf-8?B?YU04UExOS1hsa1BWZm9iR2pXb3JFTUp6V0tna0ZsMHc4SVZwblpwUGVvTWd0?=
 =?utf-8?B?QWkyVkxVS29RdTBoejI5TG84Y002aFlSMWNlRmlEU2xHODhHbWJiTFJraUZX?=
 =?utf-8?B?a2pXRmh1bUF1MTVjY3pPcStLNXZMWDZjcm9uT0dsaUc2Zk5xd1BGQlNBY2Jy?=
 =?utf-8?B?aXdVTHdOQXBiSzNKdUE3ZGp3dGdxZnNNb0drczhReHFIY0dFbVJHampwK3dY?=
 =?utf-8?B?b0d6VnNjUmx6TnBqMzcydUplT3J1Q2VQdTVEL3MyWFBGYjJRZGNJaW1GaEJo?=
 =?utf-8?B?QUx2dnJvOUg1R3ZYd0xSQVNpREhNV25xb1h3dzJqZFlyUVFzU1BLZ0Rac1dS?=
 =?utf-8?B?YnIzVWt0MFFrMFo0cXVPTnpnVHQrelNGQitIc0lrdVNQUGlDNGZ2Z25UWi80?=
 =?utf-8?B?SUUxbHkvVisvTHZOSzFQSXQwb0ErT1poY251YmliWndFRmtuSmoyRnJTTmZp?=
 =?utf-8?B?UXRGcHFNSks2U3EvbzhDaGxlSDJ2RG83Sm5zdGFkUkEyQUg2R1lXWFpJOTR3?=
 =?utf-8?B?aHRxWDR5cEkxWlVxTVdUZmw5V1VqWVh5VkpaUk85REk1WlU1TGxLTWFWMHRj?=
 =?utf-8?B?SXFrL2hwMDg1eWt2YWdBTXlIYzBxRnV5cTJFRFM1NnA2MWMxTXdwOGZRL3Fn?=
 =?utf-8?B?bmxkeExnR1FMUE8zNlhoMGxvb25MQkQyWjRCeG1sb1VrR2N5ZVp4bjRkdHVx?=
 =?utf-8?Q?xRyHva3+eqsFHYhCbyT620ZPV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b071d71-68fd-42fd-051a-08dbbdb6f640
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 11:02:51.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUyUEUba6ChtClYD0Oy3G6OVP0/0nMB3fQr8m28fdfK4/i+Rl0D73/Xhsqojq5/aqlFu4C1PDMGeiJ5GuZvZ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928

Joerg,

+ Alex

On 9/25/2023 4:10 PM, Joerg Roedel wrote:
> On Thu, Sep 21, 2023 at 02:21:47PM -0300, Jason Gunthorpe wrote:
>> On Thu, Sep 21, 2023 at 03:19:37PM +0530, Vasant Hegde wrote:
>>> On 9/21/2023 2:51 PM, Vasant Hegde wrote:
>>> This is an independent part of bigger SVA series. This particular series is
>>> tested independently and it works fine. Can you consider picking this series
>>> while we work on sorting out Part3/4?
>>
>> +1 
> 
> Applied this, thanks.

Thanks!

> 
>> Also the v2 API removal:
>>
>> https://lore.kernel.org/linux-iommu/20230921093140.6162-1-vasant.hegde@amd.com/
> 
> For that I need more validation that it will not cause regressions on
> older hardware.

AMD GPU driver which was the only in kernel user of iommu_v2 module has removed
iommu_v2 dependency in v6.6. (commit 461f35f014466 - Merge tag
'drm-next-2023-08-30' of git://anongit.freedesktop.org/drm/drm).

Summarizing Alex concern:
  AMD IOMMU driver forces passthrough domain for PASID/PRI capable devices. Alex
mentioned if we change this then it may break older GPU hardware.

Part2 of SVA series only removes iommu_v2 related code. It does not touch the
default domain allocation code. Hence it shouldn't cause any regression for GPU
hardware. IMO part2 is good to go.

We will do the default domain allocation cleanup later (after SVA series).
During that time we will account Alex's concern and make sure not to break
existing hardware.

-Vasant
