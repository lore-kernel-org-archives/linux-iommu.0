Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81BCC433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 12:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B4A160F6B;
	Tue, 31 May 2022 12:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GtXlEv0iq62r; Tue, 31 May 2022 12:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE1BC60FEF;
	Tue, 31 May 2022 12:40:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF663C0081;
	Tue, 31 May 2022 12:40:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25410C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12DAE405F6
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDWBU6pwc2Yn for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:40:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 734B640AFD
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDFiZzf7BzxAn2w7r7rJ+LcbAwm6f3fSPRjNbuMcbbCqtPh3G/RcYgmV49gVNh0fJgNqnQKI2SkFhaYIqGqncejslPkt9+3mis2w3C9YU2VYHFaCGDBwh/15LUp06P9fca/ZdfNb6zDXd3/1UZNM8emVVzexONLGKVfisAs136AEO1KUjpIFvNvxE1g0o8yYvOqU7tZBh/Sk9Qu59sQlxhDAA+nU68nhtuexSRlPJxEgIHY3xR1bfacG1hUdgNwaGCTaEZfn6xX77EihH4ZTOMJWOQlH/BU/IrH9A1NCAS5barz4dZGp47J1OaIlJ7cuRgM558a/JI9u6m+4NGbooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUVYPgD0rnNZI04jtAtBbccDPQScUX4efyuguz0rcG0=;
 b=hgSORNcfHyYliZ+eyq5DjPlZ/c3pEakw0hAXJdjaRpnTkjc1XNWGfoU4w8dkTJBOLUYRG56blo4t+v2LxfIJrhpOO0jhmpZTnENlWGl9kcaF4Vf66d1lHggW2wnZXMj4d5enbOa0oudVnQm0mdfiMFKhVH2UvI2Qu9QXt7tG0StsorFV9gDpF99aSF/zmy3hf9Zz7E9TQkKzFrPPORUa6l+PEY87yj7MZ+gPZI/cCNlkzstcpQzDtE/e88Ri7lDQ+Ho1XYYext1nUfDHxNI0grStxXfxVTa7pA4GmRLoFqnriNdCaJvmJyglHfmu4dpPLKJiTrPqpAAHwFOGuzs+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUVYPgD0rnNZI04jtAtBbccDPQScUX4efyuguz0rcG0=;
 b=fmXuMH1bVh/U8Sj7kieX18/UbiLy+poEEKwzF7oNTRB+zH3rEYVYbfZ2ZAgGa8CBQOB+bV6lslT8AevUzcU7Wm7h+EPg7b5iM7cUAeoYQ/C2lkpRQQduPui0nUh/u3FNSyNXKlx91EUwWurV2T2eGXmAA8IFLHEgkvNnKxZsRDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.15; Tue, 31 May 2022 12:40:10 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::8c27:b470:84f9:82b8]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::8c27:b470:84f9:82b8%7]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 12:40:10 +0000
Message-ID: <3c1186fe-0fa8-7329-c7a1-64ec0bd644c4@amd.com>
Date: Tue, 31 May 2022 19:39:58 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH RFC 10/19] iommu/amd: Add unmap_read_dirty() support
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-11-joao.m.martins@oracle.com>
In-Reply-To: <20220428210933.3583-11-joao.m.martins@oracle.com>
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ed6c92c-b0ab-4ab1-e476-08da4302b340
X-MS-TrafficTypeDiagnostic: CY4PR12MB1494:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1494F6F2DBED83ADEF6FED5FF3DC9@CY4PR12MB1494.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEhA5e5npOUXdr5XSlaPNYovx/JOGATpBVZnwabMd8hHaMjzKdfDrlDZfuZ1Gdf+mGXm2Jc5p2NywjOA/i3iWHB+vjd7qxT3itZVtvtRmydtJuLvlvuDFIRnHyv4IsahpPYWFy1kCKHbI7ev3lVGs9N2cfum8wwflbmDR3Uv46NLOSdBob7qsAhJNe/w++xIFejXPm8yfKUvlAqHxhexaNRPCAEjrXXmMbYHTtAIM5KUDQLeEJsmXoH3cHo0kl991w9bwGkK/K3kumLaRX4J2qvhhe4tePSJCXZ4YmQ3ubrNkoJy/6zemIZtAqUU4hPPh0gDc24oY13CRR9UibYJBolw+6gNLe9qIIMvaatbeNyopyewMPNP6WNyVCw/MWpTEy66YAZQAnJeewjsECpxKpbabGL4KQCSKEP+hY/BbwNOUARZ4sAvF9JLAu2/Mhc2ZoyZYIEBA09k5k7AQGXHjTVE2ZG8XKK7+sraGfWSBF+qS8whw32yZRj7J4wdtsuo+8nsc5EFbh3N6UobsdTc+YJgv4ELXsHOsgIcadfIgh0jxPLFKjD4JfAc5wO9i7PJrw7ADNWQJ3pWxv80A8slz+4HPpMl5V5nHZxNQeP5dN19eTJjVoMOx/O2JXqcKHrOqxeDCrcs69oc1ZY4QaNT4fp8I8AiFNFYTNW5S6Tl7JYop2VaMT84g6TP0nc15PLP/aOmbkwzUtwHsufT7zx4QSUfIPtUfxD0gV/wXraMjq34nCSLChwR9r4335BBJ23XzSf3mWkIFB+Zf30bb3FKUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(83380400001)(508600001)(54906003)(6666004)(8936002)(6506007)(38100700002)(5660300002)(6486002)(7416002)(86362001)(53546011)(66476007)(186003)(66946007)(66556008)(6512007)(36756003)(31686004)(2616005)(8676002)(4326008)(31696002)(2906002)(316002)(14143004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU5YKysyS2pzYzVRTUNDVGZuQ09xRWNEMUovZ2RQczlWcEVpWk11K21LWm8y?=
 =?utf-8?B?WlBZV1NQSmVtU2p5dExFcVZyMkJpb2NNVkpzY25vTUJ6NW41TDhzNjljR21k?=
 =?utf-8?B?ZGxUN0RHWDVoQVFKL3FEblV4dXRtdDBWU0h1YWhtTzh2azBEL3BpdnNVN0po?=
 =?utf-8?B?a3BTd2dKbWp2YVprYnAzazkzUFZuNi85VGpEczVpM1Btc1Y5d0tKOGdIMnhU?=
 =?utf-8?B?clI4UDVrYmZKMFdIdmpORTlIaWF2bUNtR1JIQ3FhdkJ3WFYzeXN1WVJOL0h0?=
 =?utf-8?B?aGs4VmtZWnNtT2VOOTdaUWtza2RVL1M0ZUt5dHF2WGY1UGFiZ1R1cnZrdUE5?=
 =?utf-8?B?MzVZSUtOSUtzOWpYeURZMTN2QTArVDVLUUpvbHE5eG80bnFVdVZXaXNRSHBt?=
 =?utf-8?B?bFJiT0RWNUx1MCs2VnFuSkZjSFlvSnA3K3R5eWFwN1cxUFVmOXNpNlovTHVh?=
 =?utf-8?B?Skw3OUlKcVNqaVZEbzJqRDR0R3hyQkdFVlJzSmZXWFBYd1pkdzNmUHV5WC9G?=
 =?utf-8?B?SExvSnI0U1pKYXh3MFRCcHplaDJqYzJuYWtTeEVKTnZWNGF0RG5MbXMyRk9I?=
 =?utf-8?B?YjNRYVRQMitSL1QxUXZkcGQrT2pMcEU4RThpOXNJY1doNzBCckdZL0EwbkZW?=
 =?utf-8?B?S0d5dHJrVmE4cjVmSmdWMkx4NXNOZ0Z4RUpDRVRBaHdVZTVLL09tbmVxT29i?=
 =?utf-8?B?bW9oZ3Q4UzBRaTZ5c1lMZzhNTC9aRXJWQmNaVU9nRmk5SytLeEZONnR6aVUy?=
 =?utf-8?B?TllaUmpSN1lGNHJlQkkyMyswOFJqR0RJVE9sN2dtMTR3c09ZYzVqRVAwVldB?=
 =?utf-8?B?bDZOTVlnY3pOdjQ0Yzd5cjZ5M1ZLMndUUitvMzJ1Yjh3MDEyZmp6Z3VEM3FB?=
 =?utf-8?B?UFhqWUtDSWZXYjUrMmkwNk4wZzMrMWxiSXNLMVZyTHdKV3BlQTlUOGZCWEE0?=
 =?utf-8?B?ZWRJaDlVMGUwRDNnYldGalR0eTBJVGRFSXdWR1RoMTEyV05IOGNWZzZyVzVO?=
 =?utf-8?B?YzNkeldmdUlUWlRjK2wyV0pZOXJOVDNFampISWZDbFdqTkNxekE5clkwWGhC?=
 =?utf-8?B?OU5yQ0tJQXdLUmlacUhPV0swSVcyakdzSlNXOU9WSUNWWXk1ak9HcHZML3Yw?=
 =?utf-8?B?d2hZa2FjcHRiTllEaGROQ2hZMTBjb040Zk1yZ0dxUExDRjNDV0grSm5PNW5N?=
 =?utf-8?B?Q1pvVTd6LzJaMjQvRGpMaFY2V2VNNkxVb0FDd3FsaTl5NzlXWkFjcFFRb1FP?=
 =?utf-8?B?SGw4SjU2ZFVBVlZKZEEwUERkS05rR2FxS01YV1p0V0JFZ2p0Y2FzVWh3ajdQ?=
 =?utf-8?B?OVFpOXlOQlFpSWoxNkJJd05yZXNNMWNaY1NEbzZOUjh3SWNGNmRIbExWNW1l?=
 =?utf-8?B?U3QrbGpCcm9sQ3RvLzFISVQvYUNJSUVvT21xeThaa0dIS01QWnhVTk9QZDZL?=
 =?utf-8?B?Zy9vY3c5TG1ObTRXc3I2VTI0VXQ4cFdVcUk4L1g3NHVCRUwvQURMMUY5Vy96?=
 =?utf-8?B?eUNvVFZyREIvdk0rVTVoRTlscXNnKzRQK1phTE5WUnByY1M2MCtBb0pCQU9v?=
 =?utf-8?B?bnNGaENCY29lQVBsSlVZQ0ovTzNUYjh5aU41S1l5R0s2S2owUklaelh6S20y?=
 =?utf-8?B?Yy9oYXJDQlhibmJ2QzFMS2lhb1JYSm16Zkl3NTVNOUUvMVJtOGUxeXJSaE1W?=
 =?utf-8?B?Z0tKcVdzQ3RNMEZ4TjZwVnNQUFUvZ1pVUkl6SFRYWlFHVlFBMVhLSlIvTEhM?=
 =?utf-8?B?WVB0UjUrZllOMXgwNFRYd0ZjVEtBRWZTck4zemJZSnlJTGdkT1pSTXlzS2R4?=
 =?utf-8?B?MkQ2MUx0YkNXb09sdlo4ZHR6QXdZNThWenExODZCcFZ5M3Q0c2JtYnQzSEhX?=
 =?utf-8?B?eDJKNHRPTmlkeTljQkFFYVgxK0RBR1ZvL3RjMUdtMUtsT2dBMTNFbWIrN0Z6?=
 =?utf-8?B?MVBYNjdPL0FWTG9SaEFyUzZIWWl2RXFESHFKaFlMUVFCQmhDbkFDYmlOWjdm?=
 =?utf-8?B?T29UVDRQTWd3NVBUcVZkZE84R3cyY0lDSVBJVlFNaURRbmFOSG95SXdyWlVs?=
 =?utf-8?B?bHZON1FmaWVJY3krUzdvR2JoWDEyWVR6RXFRUHk3dGRkdG02YTc4eWNTL2s5?=
 =?utf-8?B?bEhUY0hySVUxbW0zaTF1V09NWmt2MjBjRWFleGEwczhwWTVzaGpsbCt3aFdk?=
 =?utf-8?B?eUtWSjJ6Wlo1ajhBdGZRZy9odUxrWXhJbGtyYXdzVTU0TXUrWUUybG90d3pl?=
 =?utf-8?B?THYvRDdSVzNMN0szaWFpNTlnV1FYVWxNNFJISkY4R3dycloxZW1IdjdHRmlj?=
 =?utf-8?B?WnZGa3NGTXpsM1Y0NTE2akYxUVk5UjB1TDZVSWFMOC9WUWhsZ055ZnFuNnli?=
 =?utf-8?Q?vzVKqK+Zz2FtglWbb2Q3WH99kB79IT719Qhl7cwqlwT77?=
X-MS-Exchange-AntiSpam-MessageData-1: 1mlDEJxfPcABpQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed6c92c-b0ab-4ab1-e476-08da4302b340
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 12:40:10.5997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJsU2yDmAFhtw/KyrFkjZZvCwTmhvhV6jC3DcfC3UeQxo/ilvIr/871HvvTuf64fFcwhjKzm1F/pIQlWXfkcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1494
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 4/29/22 4:09 AM, Joao Martins wrote:
> AMD implementation of unmap_read_dirty() is pretty simple as
> mostly reuses unmap code with the extra addition of marshalling
> the dirty bit into the bitmap as it walks the to-be-unmapped
> IOPTE.
> 
> Extra care is taken though, to switch over to cmpxchg as opposed
> to a non-serialized store to the PTE and testing the dirty bit
> only set until cmpxchg succeeds to set to 0.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   drivers/iommu/amd/io_pgtable.c | 44 +++++++++++++++++++++++++++++-----
>   drivers/iommu/amd/iommu.c      | 22 +++++++++++++++++
>   2 files changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index 8325ef193093..1868c3b58e6d 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -355,6 +355,16 @@ static void free_clear_pte(u64 *pte, u64 pteval, struct list_head *freelist)
>   	free_sub_pt(pt, mode, freelist);
>   }
>   
> +static bool free_pte_dirty(u64 *pte, u64 pteval)

Nitpick: Since we free and clearing the dirty bit, should we change
the function name to free_clear_pte_dirty()?

> +{
> +	bool dirty = false;
> +
> +	while (IOMMU_PTE_DIRTY(cmpxchg64(pte, pteval, 0)))

We should use 0ULL instead of 0.

> +		dirty = true;
> +
> +	return dirty;
> +}
> +

Actually, what do you think if we enhance the current free_clear_pte()
to also handle the check dirty as well?

>   /*
>    * Generic mapping functions. It maps a physical address into a DMA
>    * address space. It allocates the page table pages if necessary.
> @@ -428,10 +438,11 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
>   	return ret;
>   }
>   
> -static unsigned long iommu_v1_unmap_page(struct io_pgtable_ops *ops,
> -				      unsigned long iova,
> -				      size_t size,
> -				      struct iommu_iotlb_gather *gather)
> +static unsigned long __iommu_v1_unmap_page(struct io_pgtable_ops *ops,
> +					   unsigned long iova,
> +					   size_t size,
> +					   struct iommu_iotlb_gather *gather,
> +					   struct iommu_dirty_bitmap *dirty)
>   {
>   	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
>   	unsigned long long unmapped;
> @@ -445,11 +456,15 @@ static unsigned long iommu_v1_unmap_page(struct io_pgtable_ops *ops,
>   	while (unmapped < size) {
>   		pte = fetch_pte(pgtable, iova, &unmap_size);
>   		if (pte) {
> -			int i, count;
> +			unsigned long i, count;
> +			bool pte_dirty = false;
>   
>   			count = PAGE_SIZE_PTE_COUNT(unmap_size);
>   			for (i = 0; i < count; i++)
> -				pte[i] = 0ULL;
> +				pte_dirty |= free_pte_dirty(&pte[i], pte[i]);
> +

Actually, what if we change the existing free_clear_pte() to free_and_clear_dirty_pte(),
and incorporate the logic for

> ...
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 0a86392b2367..a8fcb6e9a684 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2144,6 +2144,27 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
>   	return r;
>   }
>   
> +static size_t amd_iommu_unmap_read_dirty(struct iommu_domain *dom,
> +					 unsigned long iova, size_t page_size,
> +					 struct iommu_iotlb_gather *gather,
> +					 struct iommu_dirty_bitmap *dirty)
> +{
> +	struct protection_domain *domain = to_pdomain(dom);
> +	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
> +	size_t r;
> +
> +	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
> +	    (domain->iop.mode == PAGE_MODE_NONE))
> +		return 0;
> +
> +	r = (ops->unmap_read_dirty) ?
> +		ops->unmap_read_dirty(ops, iova, page_size, gather, dirty) : 0;
> +
> +	amd_iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
> +
> +	return r;
> +}
> +

Instead of creating a new function, what if we enhance the current amd_iommu_unmap()
to also handle read dirty part as well (e.g. __amd_iommu_unmap_read_dirty()), and
then both amd_iommu_unmap() and amd_iommu_unmap_read_dirty() can call
the __amd_iommu_unmap_read_dirty()?

Best Regards,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
