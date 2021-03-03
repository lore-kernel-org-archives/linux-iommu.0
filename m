Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12262C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 20:15:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A9E64EE7
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 20:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A9E64EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E864C6F947;
	Wed,  3 Mar 2021 20:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cyFcbvkqfiTh; Wed,  3 Mar 2021 20:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8987B6F600;
	Wed,  3 Mar 2021 20:14:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF59C000E;
	Wed,  3 Mar 2021 20:14:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12E51C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE3EE40150
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIrO6XOX8nTB for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 20:14:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44D9740141
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amUqqIA8CF4AoC/g9eo9J9AqJ6B0LukDHfQ0FeZq9yq3DsegCjGrdHD53H7RUgYloHX9meHCj6GmJL0o3ePoY3RZThJW369qGxfXFg5OpjfFWQoPFEUtaD1t16Qq0s+u4vXUaOyywWPJF4YUI/Poc7rl3yunOejuuuq1AkHQ1czRTjrr+8DUGzRKIL2/EH+BOCc9mywc8pzm18ILlVduQvgv3+9977DGVv8zvy81DKxqOz8Q0yMm9z5nDCid4Fpjo+U94G0noIk6QoXeu625q8bv9JY9oA1fJWFx/mvu+C6DNep30NtmtFJGcH3u5eNtuS7vMvxI+98wWlEyunP8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1FsJgXlj5kUtWbMijNPCXJ2zjpSXHjnmrtSyRIcnrg=;
 b=kMw6hJJht3rXG8g3POLoV5Eosti6Dm+JrUcZbSjRJT7Cl9QwN/TijBwXM1czUKf3er2weDnqJCzVb+8Pllh0Ygj7DY1RdIGxkirpH8rHsTfkxYYYO6Aa2r8NWjwWwTX5n8ZAC38lZ1dfwF85ydIISIOn4vzdVhNAT1Q1Dt5xJXII+lq1hMq65IH5b9vKQr7K3kBAQzeCIY1993+ScMArVJnRB+ngF3b+CkBnXwSfYTyn3d76dWR7Lhv6M6G0MjsuoSwAxshSgSt/mbE/AbHLpR+oVqXf3mPfTIwziiqPzBvIn82MLdOqcFR1/Md4v8WwCbOVAV7E1a+/HgyhS4qAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1FsJgXlj5kUtWbMijNPCXJ2zjpSXHjnmrtSyRIcnrg=;
 b=PXP5wCmOqOczXsUkfUhnsLPB57oBh15agUwp7AcnhKw/ZOf8s77Brc50wENhLJpyvjnr0fu6knEhU96I3LrJhX+tAHnUZZhcgYsmkOm3HF+eq1Xb3q/jopZ2jRQfR9BGk6u9shSnIZv5L9qHGxcn246UxvjyuF3UYsoC5rfjzgg=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR04MB3310.eurprd04.prod.outlook.com (2603:10a6:802:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 3 Mar
 2021 16:40:43 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba%5]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 16:40:43 +0000
Subject: Re: CAAM: kernel BUG at drivers/crypto/caam/jr.c:230! (and
 dma-coherent query)
To: Sascha Hauer <sha@pengutronix.de>
References: <20210301152231.GC5549@pengutronix.de>
 <a52e0a0f-a784-2430-4b37-fb9fdcf3692b@nxp.com>
 <20210303145656.GL5549@pengutronix.de>
From: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <0103a43a-382d-0d71-a6ea-ead3d7ab7041@nxp.com>
Date: Wed, 3 Mar 2021 18:40:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210303145656.GL5549@pengutronix.de>
Content-Language: en-US
X-Originating-IP: [78.97.206.147]
X-ClientProxiedBy: AM0PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:208:be::49) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.213] (78.97.206.147) by
 AM0PR04CA0108.eurprd04.prod.outlook.com (2603:10a6:208:be::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 16:40:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e63b893-e9b9-47b9-afce-08d8de63161d
X-MS-TrafficTypeDiagnostic: VI1PR04MB3310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB331010DFE7BAD0EFF795440E98989@VI1PR04MB3310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Di5ACUMhBoHItB50B/LMR5nbwpZWT328HikzCeUA6/TyM7K0re+4dXMH3wzTTbGK2U9G5D4+VrTNPlkwqnf4+jxDT/JXSWcS0uD55N3vVVDS8Z8loZw0tkaJrlTtkxOc6eJwjcISQ96kFa30hxLPX3KgsL800F3ajpCOh/PjmtDHRJBH5PVtKT/6c4h2XzMkB7MBSedh04G2fPy1Otj268k1EUwcvWehaH5+x0Q8+0weoJPpZxgljXllOWSa+/FOZOko9MCEb6oIO+Bz5Lc5hSyiD6O7eLaqOQVKD9/MSJKVlpVeo3cnQeVjp+ACB64Zr3GRZW02fFEliijKrHUatbiXjvA1ZuSUBXbH+zIfkRDbiPvUHQPlx9gUHDVNpfbLKBl++SJfuAXAnf53/IxH2dd4973800/ckmJHSxu6/wwy4hcM47QffY7o4vmOtvKvvo7pCrSjxXMfz9HyFmbkp46d4RJPEEuzG6vNLKTesYT6mevDHy9AIhK/Td7laRfcx3hD0AcerBCm8S8BH7hmbRCIy/pCrZ6kQmkRa9VfpwIdj6glSxmiT0GceQvXxg7d6BjhguoyaZpoKgQffpbFqivE45rS8BR+21d6uqMBMvvrpLNAEQqYjp1I56AlS+HaAg+L4C1d+87Tz1e4+VAQjENuiEuFulxXb+wjBa5y3WtLg+gpojtL+XnQPsvIWGx/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(54906003)(52116002)(7416002)(66946007)(83380400001)(8936002)(86362001)(8676002)(66476007)(36756003)(66556008)(53546011)(26005)(16526019)(2906002)(31686004)(4326008)(316002)(6486002)(186003)(2616005)(45080400002)(16576012)(6916009)(478600001)(956004)(5660300002)(31696002)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L1d0WlhWN2pUc3hUTjRJL2cxQUhQcVRnWk13bnZDVGRrU2J2ekc4ejFBcnQx?=
 =?utf-8?B?WGFEanc4YzNpYmFTYkdMV250OWpaZW9SZkF5SmRrK2lvRGxGQVVzdmNYN2xR?=
 =?utf-8?B?ck5uUjRqRS9xZTNVVTNRWkhQcStlWEJnMjRhVWtiWFNxVGE3bDhJa25Bajl5?=
 =?utf-8?B?RHBVellVLzF6dnZFblF0enI4YnVPVDF0dWNCQXN2ZnVWWGI3R2dJemQ4ZTlR?=
 =?utf-8?B?bG9wRHl0S0s1NUdPQ3JLYjhRaGVkaFZ0cVRrVDd3NWNoTnpTYnVtc3ZreWxX?=
 =?utf-8?B?QmR2L2t1S0lDdVNSRHFMRk1wczI1UlhEYVR5ZmVHVk14UmYxYitwWXE4VmZP?=
 =?utf-8?B?cDNXMDBSc1Zjb3hUcjViUXIvVTlQVVVFTDdOQXN3a3JFekJMeGd1WTlLbWdE?=
 =?utf-8?B?YXh6TjZwcXhhREM0bHl1R2t2QUJuUUZxdTlDTStpVlR6alBWT0J1S0dIMXpl?=
 =?utf-8?B?aTNjTFBLbEJDc2o4TEJ0dnNTdStNejE5elg1Z0J3QmNLeVArNlhFRzhqWUUz?=
 =?utf-8?B?QkdyWnhybjR2VFBpVlREWXVCZVhkZ0FjejBncW1nOU5SV3JKVmV3RU9URFFM?=
 =?utf-8?B?MmFWVzZoMW9KOGFHN2tUeWxtcG1FNHpXTXF1YUVUeVZiVnNzUU02SjJsbkQr?=
 =?utf-8?B?RUlHQnVJTllkbnFNR0tsNk8xS1ZobTJlWUI5bTlBa0lTamduR29YUU5MMTRy?=
 =?utf-8?B?L3Z0QTYrd2xlUFY1UTVJNi9QbEZIK3RkQmh1WHJzNlhsYlUraC84dDIxRGpF?=
 =?utf-8?B?L0duRWlNYW5GZDBwbjV4bFh1QkdkMzVpV0VFdW44Q1podk9EdlQrT1FVOFBv?=
 =?utf-8?B?SFFrSUxiayszUFRJdm1IR0RmSG9iQ2lZTzBXUU50eGxIL1JEbndRUytGaC9W?=
 =?utf-8?B?WFZFa3ZuOHZFcG9FalJaQnFNMC96NXdoNEdTY09oRUZzM0h0a1ZhK29RNlk0?=
 =?utf-8?B?UDhXZEZQNkZHUWgvR0JlZHNOR2VyM3M5clhLWXNncnR6Tnk2eFVzTEg2M2Fh?=
 =?utf-8?B?NWdWRG0vbVhBM210aFZ1RUJ5SWkvbXhkTEcwcUcydzNKOUZERGc3QkRLbms5?=
 =?utf-8?B?N3N2UHovNktJR0hmelNVMVdHMXh6dGRSZUs4R2dsTS9iM01ycnFyRTNtYmdx?=
 =?utf-8?B?YTRtNzBKWmdIMFJuOUlacFQxTytjY3pJb0crbEpGQlFYWERzSnZ3VlRyYzFS?=
 =?utf-8?B?bkNNYkFWbFlaRE11aXFRRkErQTBzYlZKUVdaeWI0dkNhdlVjQXQrV1BaV2FM?=
 =?utf-8?B?RXJtSFFLT2hoWEhoUDVtMWd0eGQ0Q0g0UmpiTy8xRHZ2OWJTaWw4bG8vYnd3?=
 =?utf-8?B?blJsTTYvKy9qOGlNSTY2bmNEakh0U0lROFgwYURiRGFFNW9sRi9jbUc1ZWRZ?=
 =?utf-8?B?Y2dIN1VMaUhwY2NTQWkzVzdOQWx2MUpQK0FIcVovRjB1QXJoNU9NRURqQXZJ?=
 =?utf-8?B?b01YMUJFRVRUNzhIMmtWcUF4MzZLZ200TWVGZTBoU1B0TVNwWnBoYWpMeHly?=
 =?utf-8?B?NTFlUEZ1Sk5mNzZiYTRuV1l0YzZIZVljZzB0WUM5OEc4WHRDSnY1Zm9hR2tJ?=
 =?utf-8?B?eVVxYkdLdXBPOUtMKzNDdDZVcTJQWFRnR1pHdmVLMi9VRXpDZzdNMjFpZTZG?=
 =?utf-8?B?cDJ4c3V2aWVFREc4NnAwa0lUdjMvNk1WcHJjTC9ZY3JaZk55aXBLb0lwdGNl?=
 =?utf-8?B?QnNGNVlnemNHZWVKM2R4a1VaSWQ0cFZNbXJ0M2hkendyZlRWeDhNNWtpU2dF?=
 =?utf-8?Q?Gw0MdnKHDBGmhFwYgzj1kPvqBpfakuXPZYTPQQ2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e63b893-e9b9-47b9-afce-08d8de63161d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 16:40:42.9986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kVwhflvmKPo9Qey3Y9s6UQuMz9G5WHuyFjv6HCjc4auEpdLckIRRz+2uR+FPE01tqFXSdiMYP4BuodYTOtbqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3310
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Greg Ungerer <gerg@linux-m68k.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMy8zLzIwMjEgNDo1NyBQTSwgU2FzY2hhIEhhdWVyIHdyb3RlOgo+IE9uIFdlZCwgTWFyIDAz
LCAyMDIxIGF0IDEyOjI2OjMyUE0gKzAyMDAsIEhvcmlhIEdlYW50xIMgd3JvdGU6Cj4+IEFkZGlu
ZyBzb21lIHBlb3BsZSBpbiB0aGUgbG9vcCwgbWF5YmUgdGhleSBjb3VsZCBoZWxwIGluIHVuZGVy
c3RhbmRpbmcKPj4gd2h5IGxhY2sgb2YgImRtYS1jb2hlcmVudCIgcHJvcGVydHkgZm9yIGEgSFct
Y29oZXJlbnQgZGV2aWNlIGNvdWxkIGxlYWQgdG8KPj4gdW5leHBlY3RlZCAvIHN0cmFuZ2Ugc2lk
ZSBlZmZlY3RzLgo+Pgo+PiBPbiAzLzEvMjAyMSA1OjIyIFBNLCBTYXNjaGEgSGF1ZXIgd3JvdGU6
Cj4+PiBIaSBBbGwsCj4+Pgo+Pj4gSSBhbSBvbiBhIExheWVyc2NhcGUgTFMxMDQ2YSB1c2luZyBM
aW51eC01LjExLiBUaGUgQ0FBTSBkcml2ZXIgc29tZXRpbWVzCj4+PiBjcmFzaGVzIGR1cmluZyB0
aGUgcnVuLXRpbWUgc2VsZiB0ZXN0cyB3aXRoOgo+Pj4KPj4+PiBrZXJuZWwgQlVHIGF0IGRyaXZl
cnMvY3J5cHRvL2NhYW0vanIuYzoyNDchCj4+Pj4gSW50ZXJuYWwgZXJyb3I6IE9vcHMgLSBCVUc6
IDAgWyMxXSBQUkVFTVBUIFNNUAo+Pj4+IE1vZHVsZXMgbGlua2VkIGluOgo+Pj4+IENQVTogMCBQ
SUQ6IDAgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDUuMTEuMC0yMDIxMDIyNS0zLTAwMDM5
LWc0MzQyMTU5Njg4MTYtZGlydHkgIzEyCj4+Pj4gSGFyZHdhcmUgbmFtZTogVFEgVFFNTFMxMDQ2
QSBTb00gb24gQXJrb25hIEFUMTEzMCAoQzMwMCkgYm9hcmQgKERUKQo+Pj4+IHBzdGF0ZTogNjAw
MDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8gLVRDTyBCVFlQRT0tLSkKPj4+PiBwYyA6IGNhYW1f
anJfZGVxdWV1ZSsweDk4LzB4NTdjCj4+Pj4gbHIgOiBjYWFtX2pyX2RlcXVldWUrMHg5OC8weDU3
Ywo+Pj4+IHNwIDogZmZmZjgwMDAxMDAwM2Q1MAo+Pj4+IHgyOTogZmZmZjgwMDAxMDAwM2Q1MCB4
Mjg6IGZmZmY4MDAwMTE4ZDQwMDAKPj4+PiB4Mjc6IGZmZmY4MDAwMTE4ZDQzMjggeDI2OiAwMDAw
MDAwMDAwMDAwMWYwCj4+Pj4geDI1OiBmZmZmMDAwODAyMmJlNDgwIHgyNDogZmZmZjAwMDgwMjJj
NjQxMAo+Pj4+IHgyMzogMDAwMDAwMDAwMDAwMDFmMSB4MjI6IGZmZmY4MDAwMTE4ZDQzMjkKPj4+
PiB4MjE6IDAwMDAwMDAwMDAwMDRkODAgeDIwOiAwMDAwMDAwMDAwMDAwMWYxCj4+Pj4geDE5OiAw
MDAwMDAwMDAwMDAwMDAxIHgxODogMDAwMDAwMDAwMDAwMDAyMAo+Pj4+IHgxNzogMDAwMDAwMDAw
MDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMTUKPj4+PiB4MTU6IGZmZmY4MDAwMTE2OTAyMzAg
eDE0OiAyZTJlMmUyZTJlMmUyZTJlCj4+Pj4geDEzOiAyZTJlMmUyZTJlMmUyMDIwIHgxMjogMzAz
MDMwMzAzMDMwMzAzMAo+Pj4+IHgxMTogZmZmZjgwMDAxMTcwMGEzOCB4MTA6IDAwMDAwMDAwZmZm
ZmYwMDAKPj4+PiB4OSA6IGZmZmY4MDAwMTAwYWRhMzAgeDggOiBmZmZmODAwMDExNmE4YTM4Cj4+
Pj4geDcgOiAwMDAwMDAwMDAwMDAwMDAxIHg2IDogMDAwMDAwMDAwMDAwMDAwMAo+Pj4+IHg1IDog
MDAwMDAwMDAwMDAwMDAwMCB4NCA6IDAwMDAwMDAwMDAwMDAwMDAKPj4+PiB4MyA6IDAwMDAwMDAw
ZmZmZmZmZmYgeDIgOiAwMDAwMDAwMDAwMDAwMDAwCj4+Pj4geDEgOiAwMDAwMDAwMDAwMDAwMDAw
IHgwIDogMDAwMDAwMDAwMDAwMTgwMAo+Pj4+IENhbGwgdHJhY2U6Cj4+Pj4gIGNhYW1fanJfZGVx
dWV1ZSsweDk4LzB4NTdjCj4+Pj4gIHRhc2tsZXRfYWN0aW9uX2NvbW1vbi5jb25zdHByb3AuMCsw
eDE2NC8weDE4Ywo+Pj4+ICB0YXNrbGV0X2FjdGlvbisweDQ0LzB4NTQKPj4+PiAgX19kb19zb2Z0
aXJxKzB4MTYwLzB4NDU0Cj4+Pj4gIF9faXJxX2V4aXRfcmN1KzB4MTY0LzB4MTZjCj4+Pj4gIGly
cV9leGl0KzB4MWMvMHgzMAo+Pj4+ICBfX2hhbmRsZV9kb21haW5faXJxKzB4YzAvMHgxM2MKPj4+
PiAgZ2ljX2hhbmRsZV9pcnErMHg1Yy8weGYwCj4+Pj4gIGVsMV9pcnErMHhiNC8weDE4MAo+Pj4+
ICBhcmNoX2NwdV9pZGxlKzB4MTgvMHgzMAo+Pj4+ICBkZWZhdWx0X2lkbGVfY2FsbCsweDNjLzB4
MWMwCj4+Pj4gIGRvX2lkbGUrMHgyM2MvMHgyNzQKPj4+PiAgY3B1X3N0YXJ0dXBfZW50cnkrMHgz
NC8weDcwCj4+Pj4gIHJlc3RfaW5pdCsweGRjLzB4ZWMKPj4+PiAgYXJjaF9jYWxsX3Jlc3RfaW5p
dCsweDFjLzB4MjgKPj4+PiAgc3RhcnRfa2VybmVsKzB4NGFjLzB4NGU0Cj4+Pj4gQ29kZTogOTEz
OTIwMjEgOTEyYzIwMDAgZDM3N2Q4YzYgOTdmMjRkOTYgKGQ0MjEwMDAwKQo+Pj4KPj4+IFRoZSBk
cml2ZXIgaXRlcmF0ZXMgb3ZlciB0aGUgZGVzY3JpcHRvcnMgaW4gdGhlIG91dHB1dCByaW5nIGFu
ZCBtYXRjaGVzIHRoZW0KPj4+IHdpdGggdGhlIG9uZXMgaXQgaGFzIHByZXZpb3VzbHkgcXVldWVk
LiBJZiBpdCBkb2Vzbid0IGZpbmQgYSBtYXRjaGluZwo+Pj4gZGVzY3JpcHRvciBpdCBjb21wbGFp
bnMgd2l0aCB0aGUgQlVHX09OKCkgc2VlbiBhYm92ZS4gV2hhdCBJIHNlZSBzb21ldGltZXMgaXMK
Pj4+IHRoYXQgdGhlIGFkZHJlc3MgaW4gdGhlIG91dHB1dCByaW5nIGlzIDB4MCwgdGhlIGpvYiBz
dGF0dXMgaW4gdGhpcyBjYXNlIGlzCj4+PiAweDQwMDAwMDA2IChtZWFuaW5nIERFQ08gSW52YWxp
ZCBLRVkgY29tbWFuZCkuIEl0IHNlZW1zIHRoYXQgdGhlIENBQU0gZG9lc24ndAo+Pj4gd3JpdGUg
dGhlIGRlc2NyaXB0b3IgYWRkcmVzcyB0byB0aGUgb3V0cHV0IHJpbmcgYXQgbGVhc3QgaW4gc29t
ZSBlcnJvciBjYXNlcy4KPj4+IFdoZW4gd2UgZG9uJ3QgaGF2ZSB0aGUgZGVzY3JpcHRvciBhZGRy
ZXNzIG9mIHRoZSBmYWlsZWQgZGVzY3JpcHRvciB3ZSBoYXZlIG5vCj4+PiB3YXkgdG8gZmluZCBp
dCBpbiB0aGUgbGlzdCBvZiBxdWV1ZWQgZGVzY3JpcHRvcnMsIHRodXMgd2UgYWxzbyBjYW4ndCBm
aW5kIHRoZQo+Pj4gY2FsbGJhY2sgZm9yIHRoYXQgZGVzY3JpcHRvci4gVGhpcyBsb29rcyB2ZXJ5
IHVuZm9ydHVuYXRlLCBhbnlvbmUgZWxzZSBzZWVuCj4+PiB0aGlzIG9yIGhhcyBhbiBpZGVhIHdo
YXQgdG8gZG8gYWJvdXQgaXQ/Cj4+Pgo+Pj4gSSBoYXZlbid0IGludmVzdGlnYXRlZCB5ZXQgd2hp
Y2ggam9iIGFjdHVhbGx5IGZhaWxzIGFuZCB3aHkuIE9mIGNvdXJzZSB0aGF0IHdvdWxkCj4+PiBi
ZSBteSB1bHRpbWF0ZSBnb2FsIHRvIGZpbmQgdGhhdCBvdXQuCj4+Pgo+PiBUaGlzIGxvb2tzIHZl
cnkgc2ltaWxhciB0byBhbiBlYXJsaWVyIHJlcG9ydCBmcm9tIEdyZWcuCj4+IEhlIGNvbmZpcm1l
ZCB0aGF0IGFkZGluZyAiZG1hLWNvaGVyZW50IiBwcm9wZXJ0eSB0byB0aGUgImNyeXB0byIgRFQg
bm9kZQo+PiBmaXhlcyB0aGUgaXNzdWU6Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWNyeXB0by83NGY2NjRmNS01NDMzLWQzMjItNDc4OS0zYzc4YmRiODE0ZDhAa2VybmVsLm9yZwo+
PiBQYXRjaCByZWJhc2VkIG9uIHY1LjExIGlzIGF0IHRoZSBib3R0b20uIERvZXMgaXQgd29yayBm
b3IgeW91IHRvbz8KPiAKPiBJbmRlZWQgdGhpcyBzZWVtcyB0byBzb2x2ZSBpdCBmb3IgbWUgYXMg
d2VsbCwgeW91IGNhbiBhZGQgbXkKPiAKPiBUZXN0ZWQtYnk6IFNhc2NoYSBIYXVlciA8cy5oYXVl
ckBwZW5ndXRyb25peC5kZT4KPiAKVGhhbmtzIQpJJ2xsIGFwcGVuZCB0aGUgdGFnIHRvIHRoZSBm
b3JtYWxseSBzdWJtaXR0ZWQgcGF0Y2guCgo+IEhvd2V2ZXIsIHRoZXJlIHNlZW0gdG8gYmUgdHdv
IHByb2JsZW1zOiBGaXJzdCB0aGF0ICJERUNPIEludmFsaWQgS0VZCj4gY29tbWFuZCIgYWN0dWFs
bHkgb2NjdXJzIGFuZCBzZWNvbmQgdGhhdCB0aGUgZGVxZXVldWUgY29kZSBjdXJyZW50bHkKPiBj
YW4ndCBoYW5kbGUgYSBOVUxMIHBvaW50ZXIgaW4gdGhlIG91dHB1dCByaW5nLgpDdXJyZW50bHkg
dGhlIGRlcXVldWUgY29kZSBCVUdzIG5vdCBvbmx5IGZvciAiTlVMTCBwb2ludGVyIiwgYnV0IGZv
ciBhbnkKSU9WQSBpbiB0aGUgb3V0cHV0IHJpbmcgdGhhdCBpcyBub3QgbWF0Y2hlZCB3aXRoIGFu
IGVudHJ5IGluIHRoZSAic2hhZG93IgooU1cpIHJpbmcuCkhlcmUgdGhlIEJVR19PTigpIHNob3Vs
ZCBiZSByZXBsYWNlZCB3aXRoIFdBUk5fT04gc2luY2Ugbm90IGZpbmRpbmcgYSBtYXRjaAptZWFu
cyBkcml2ZXIgY2FuJ3QgZ28gdG8gdGhlICJTVyBjb250ZXh0IiBhbmQgZXZlbnR1YWxseSBjYWxs
IGNvbXBsZXRlKCkKdG8gd2FrZSB1cCB0aGUgY3J5cHRvIEFQSSB1c2VyLiBJbiBtYW55IGNhc2Vz
IHRoZSB1c2VyIHJlbGllcyBvbgpjcnlwdG9fd2FpdF9yZXEoKSwgd2hpY2ggZG9lcyBub3QgdGlt
ZSBvdXQgYW5kIGlzIG5vdCBraWxsYWJsZS4KCj4gRG8geW91IHRoaW5rIHRoYXQgdGhlIG9jY3Vy
ZW5jZSBvZiBhIE5VTEwgcG9pbnRlciBpcyBhbHNvIGEgY29oZXJlbmN5Cj4gaXNzdWU/Cj4gCkkg
c3Ryb25nbHkgYmVsaWV2ZSB0aGVyZSdzIGEgc2luZ2xlIHByb2JsZW0gYmVjYXVzZSB0aGUgaXNz
dWUgZ29lcyBhd2F5CndoZW4gdGhlIHBhdGNoIGlzIGFwcGxpZWQsIGV2ZW4gdGhvdWdoIEkgaGF2
ZW4ndCBmaWd1cmVkIG91dCB3aGF0IGlzCnRoZSBleGFjdCBwbGFjZSAvIGRhdGEgc3RydWN0dXJl
IHRoYXQgZ2V0cyBjb3JydXB0ZWQuCgpPbmUgdGhlb3J5IGlzIHRoYXQgY29ycnVwdGlvbiBvY2N1
cnMgaW4gdGhlIGlucHV0IHJpbmc6Ci1DUFUgc2V0cyB1cCBjb3JyZWN0bHkgdGhlIGlucHV0IHJp
bmcgZW50cnkKLWRldmljZSBkb2Vzbid0IHNlZSB0aGUgImZyZXNoIiBkYXRhLCByZWFkaW5nIDB4
MCBmb3IgdGhlIGRlc2NyaXB0b3IgYWRkcmVzcwotZGV2aWNlIHJlYWRzIHRoZSBkZXNjcmlwdG9y
IGNvbW1hbmRzIGZyb20gYWRkcmVzcyAweDAgYW5kIGlzc3VlcwoiREVDTyBpbnZhbGlkIEtFWSBj
b21tYW5kIiAobm90ZSB0aGF0IEtFWSBjb21tYW5kIG9wY29kZSBpcyBiJzAwMDAwLCBzbyByZWFk
aW5nCmFsbCB6ZXJvcyBmcm9tIGFkZHJlc3MgMHgwIHdvdWxkIGxlYWQgdG8gdGhpcyBlcnJvcikK
CkJ1dCB0aGVuIHRoZSBpbnB1dCAmIG91dHB1dCByaW5ncyBhcmUgYWxsb2NhdGVkIHVzaW5nIGRt
YV9hbGxvY19jb2hlcmVudCgpLApzbyBJJ2xsIG5lZWQgdG8gY2hlY2sgaWYgbGFjayBvZiAiZG1h
LWNvaGVyZW50IiBEVCBwcm9wZXJ0eSBoYXMgdGhlIHNhbWUKZWZmZWN0IG9uIGNvbnNpc3RlbnQg
RE1BIG1hcHBpbmdzIGFzIG9uIHN0cmVhbWluZyBETUEgbWFwcGluZ3MuCgpIb3JpYQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
