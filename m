Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE43C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 20:20:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E667464F23
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 20:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E667464F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E3E9431B8;
	Tue,  2 Mar 2021 20:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EL87gJlGm3Ud; Tue,  2 Mar 2021 20:20:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 881E1431B3;
	Tue,  2 Mar 2021 20:20:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72910C000A;
	Tue,  2 Mar 2021 20:20:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7228DC0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 20:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 545F26F483
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 20:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="JURshcwl";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="nxt4kqWs"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IXSMvH0BrYMU for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 20:20:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BF6360733
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 20:20:20 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122KF4iM061553;
 Tue, 2 Mar 2021 20:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MySXm0Dugl+sP25rrPs2V0sxZ1PfMnqZsXjwK8peeOg=;
 b=JURshcwlAS1pVWjY2DLPHN1MQbBxulHVFZ3wT9zfKX9qOxRWjm/AEqx6sqBxhkDCn5KX
 /FtP0KguBt+wbkyrkmeDKix9y1XwD78QiM5lSOFui97u3yUghGfAdCI3tMFshYLZ7QwZ
 cd14wXIq/xs7Z6yq30YMNIuxnotyi7YxGfPT6KGXeobMZc5UkbQ0s8V/dnA7i7LIXCRx
 OQncyIZeFlRWf/nRs8RsHyt8wmvozbYXH3aSuHsSegT59D1e5ElEq6xMXhmvqQRxfnQR
 LFzpGO43y/90Rv85ezh5sDJUrDvpIkpsANwu2fKEajGu3q+jB0Hwb2cdYajCHkeoMxhS WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 36ybkb95e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Mar 2021 20:20:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122KF3a1009505;
 Tue, 2 Mar 2021 20:20:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by aserp3020.oracle.com with ESMTP id 370000cnrt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Mar 2021 20:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou3dN8J29r1YxdTHTSOu24yx9MS2ka//xg9qMqmMIBRUdaQEQazQd7chSE4A0I8mxUd9PRx0j1gX/9HGEAEh1pwCg5669iRQtoKIDGueLGz6ltHRGklnNdqs6bNBTHWpl+2onowb+fHlNviUN9CBz+K5pAaljf9gAzATHgD7HIBFJcSYP4xctR9DJtUp4ieZXPGmxcDJmkLuOMV9MUK2JaZwd1UGa42g+eii4lytNcG1ekVUe1eLpiQkihAKhsu/l9oP+Ziik/yxGph3nq3kABCxKOicO98N0Jts+Z8cnDB9t4zLfEb6kUfRgFL7qod8kd3Gmka6QqK3ZLbHYqeTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MySXm0Dugl+sP25rrPs2V0sxZ1PfMnqZsXjwK8peeOg=;
 b=aN0FrIq8HmlFaOmCrdNXxeoYltf/iiqqMiyzLnsc4PC+0G8vRBZXCdCGvOTRQOSK2Dm9wKrvqeTxjiKGEpJGRO+N3vp3VAwI16G/r4+pEifFEu4jOgHxMVPZcFc8be5w1wFL4cRf8FK9P20v6moleAe1EsuojGStt7w1fOFB4HIMsaoUJdPGVU1KDw8Bs296rtVxTf2pb26tihoeKJfYe21yjv0e/eRxeyuMtBIskmHYTjBlbAXwrLX89T999g+ruu2zbDrmWDXCV0GGhlMjLEBz0tygKW2d6zDCiGdgTQKgyJVGnEr3hqOa2idW2rBKXGHyiyVXgGm9cIoZUhVV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MySXm0Dugl+sP25rrPs2V0sxZ1PfMnqZsXjwK8peeOg=;
 b=nxt4kqWsnaewjduBnlFnLHCz4ecN+1fJo7Q1WRCcsFjIfyUew4S9zH59MjmzwyKW+cS9DUi0q+Ai61xjAgDMTpWfI1k06/r9K0SjmyoSZgd9hupK4BPirDFIsMNpc1FxxK8+uPfnTLY6fYmxgBxQ3Tlgc77odfA3YAW+z5DRScU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from SN6PR10MB3006.namprd10.prod.outlook.com (2603:10b6:805:cf::13)
 by SA2PR10MB4411.namprd10.prod.outlook.com (2603:10b6:806:116::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 2 Mar
 2021 20:20:12 +0000
Received: from SN6PR10MB3006.namprd10.prod.outlook.com
 ([fe80::607a:91ec:c8b0:af82]) by SN6PR10MB3006.namprd10.prod.outlook.com
 ([fe80::607a:91ec:c8b0:af82%3]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 20:20:12 +0000
Subject: Re: [PATCH] swiotlb: Fix type of max_slot
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Jianxiong Gao <jxgao@google.com>
References: <1614705688-10567-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <436bf276-5b16-62af-6a32-70f91fce7557@oracle.com>
Date: Tue, 2 Mar 2021 15:20:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <1614705688-10567-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Language: en-US
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To SN6PR10MB3006.namprd10.prod.outlook.com
 (2603:10b6:805:cf::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by
 SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 2 Mar 2021 20:20:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20748b9a-153a-45ee-40d7-08d8ddb89520
X-MS-TrafficTypeDiagnostic: SA2PR10MB4411:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4411BF8939CB123D11BFB07E89999@SA2PR10MB4411.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iu2vC3pTRQnDLq6AR38/9+crCZsLjkDXQLh7IgftT4KFiJqcDWIzCne8/twn9p0oKyUMoWAufWi++lmT8WQ6qk4Mr9Kq7FmWugSSn6Hjbx2O7xsywjbrJxBaXZi/dJwvPWeopgBin/q9CqV1fuhw4M1mEfJP1ZEC9FPdac45Z58aBsAV/YdaDJzs5+kgBm5JycXtS0lNYK69zQ9Ql9VVcdN8eJPEw8XyTjDO75UXu+Vt0FxYahyJvn8e+VyacsWpzi8kWXLjZtR7n3N7ZEc+SLa7OJ45OnhY/TZglL5tAIwa4v7cQXOlKppcF/3PMpkuJNAnXAzj17Ibi2Gx4VD40UiJ/hau0s4lWj8W82EZrfVP7tbAtLyGB8MaP7cL8LMa57VrxjOlJqunLEt4qbCXkuoe+lIoosksqlSxc0Q43TeIpKGZ7ea1bO8bf8cn86dJA/J02czXPClyqSlOxcCboEr3qty5j3fXwP7ENirjILYk7MbHrvFaziUjkb483YCXqPKet7nH4/PNmJMw0xNS8D2hq8I2mN1CzEdH8pWXiN8g0MVOAJBjmG/oZPhMPDEdYrngVWFbdijfFXRZvBZe2OMdNximzQp13Jwj7bwTGWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB3006.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(366004)(39860400002)(396003)(376002)(2906002)(31696002)(5660300002)(36756003)(186003)(6512007)(83380400001)(86362001)(31686004)(16526019)(8936002)(316002)(26005)(53546011)(2616005)(66556008)(66946007)(6486002)(4326008)(66476007)(478600001)(8676002)(956004)(6506007)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QVZDV1FDd2JzS1I2ZWVkVEh6U1ppUkhoWUVOTzNyVVhsam5RWDhyMm1FVk02?=
 =?utf-8?B?Q0NRVnFueWx6RnpuWHFGU0pkYjZneFFZaUowWFl6aWtKUFNBdmZEZHJKbEJr?=
 =?utf-8?B?a29zVUpJdDV1KzVFd3ExWTBoWEhWRHN0bFo1aW5FamRONnF0U0d3d3BsYlRC?=
 =?utf-8?B?VGczN1dWa0pKVHBRcWNPQ2hQK2R0WlJPaFdHY0J6NFJFbGQwenZzZThuZ2J0?=
 =?utf-8?B?d1J6VWtqdHJGN01EZThsaCtrTFUxd3NIQlZJam5KVytlUEhXeUVKVkNrYy9U?=
 =?utf-8?B?SFZBZDJ5OEllSnpvU0VjMFlzc08yNUdKbmNxejVyUnVIdEpqUWd6NThNQU9D?=
 =?utf-8?B?MUlDd2svRExTZnk1QktjNFhtVVpCNXNrN2trR1RkUnk2RGRVS1lHOUUwTURo?=
 =?utf-8?B?SldxQU9Hd1R6UGpMRmtabnFCZDR5ak40aHQ4TEZqOWY0ZkdEVGNHbW9XUkVX?=
 =?utf-8?B?M0duS0ZpUzdTV290WVJ2Wk0wcGtXakVqdFlSSXdmMFJRYmJ1Mnhxa0xtdmJF?=
 =?utf-8?B?V3hSSWNCZ0J6cisxbDNWTEp3Zk9hYjg2UUhEWHl5U1FOZU1SbU13ZGtiRFJo?=
 =?utf-8?B?QUJIQThlK2FsUG84RmhFOUJQSzFVU3FlZFpTV0d0dm1oZEJVazZFM1FPZEdm?=
 =?utf-8?B?TzdLR2xxVlJLVlN0WHZnYk1zbWNVY1JKKzZ1SFNFRnRZbE9Vd0R4T2lXSlNL?=
 =?utf-8?B?WXI0cVRHdHFpRW84MGJWQXc1MWY0eTY1b0VNa1pBaWhsZEhPWDRKU2cybGZ2?=
 =?utf-8?B?L2l2bmd5alRFL1M5dmN0eFJLSmhWdFJObS9MNlB0QkI2emVRaHFJbWFwOHZs?=
 =?utf-8?B?T1g4U1pSR0xmZDVaWXVqc3NHTWxYMVRZQzlzbVpLODRoZFpSejQwY1h4SlJz?=
 =?utf-8?B?czVnYjRKcVpBUjFUcThnWTJIa1NZTzlRTjBNenZTUEhXUlQ0dGZhU2g0SFRi?=
 =?utf-8?B?blBPeFdEYVltNWphZDRoQnBOQXE0c3ZvcWdFUVhuK2FRNHlhK0tMeTVPZncr?=
 =?utf-8?B?bmlHRU1tL2d1dkpMRUV0blF3d1NnbHBtL2tZOUtSRDhJSEFheFhHWnZWRHM2?=
 =?utf-8?B?NXczbjBLNThBREVQQklVUjhkSjYxOEV6RjgzZ3Q3OE1EOEZNeDZ3c25NVHdE?=
 =?utf-8?B?SUN4YlJ4VmpvamhIbHhaNnNoNU4vYmk0Y1NWZ21KYlMwUXU1NEthcmxHTy9B?=
 =?utf-8?B?NmhsSkJmMmtaeGdLQ1BHa0FzNjBQU3I3bkRkV3VWbVZGVW0xc2pQM2orTWZK?=
 =?utf-8?B?NVVscUpReithV0t5RVY2MXdZaDlmVzI5NzNNM0pFajJvUGhTVW5qSzNYMU5r?=
 =?utf-8?B?UklrQXhlbWt4aVViOXEzT0VoUnFEQ1NweVNkbUwrbEkyd29LblA4ZEIxdXJv?=
 =?utf-8?B?bjV5d1JuM1ZGTExvUENxd0taSkVWZGVBbzRwLzNJd1RzVURnWEltVXZPS0ZG?=
 =?utf-8?B?eEtZSGZVbkIxUmZqOEl3eVk2RlRNaTQyM0tYU3JPTW92M0h3blZTS3hwS05B?=
 =?utf-8?B?S0tDZXF4SDlTSCt6cUY4TTdRSmM5aWlsbXp0d2pldzdoOW1BdFBFQit5a2hM?=
 =?utf-8?B?em5aKzA2T2dENE5HWk1aU1JLV1ZGdHhUYU01YlRoOGZEQ0JydDFvTEl4L2FC?=
 =?utf-8?B?VmJLbkk2SEkvdFRVSFl4M2xGeHcxQm1ublhGeFh4eklrSTBhOVhEQzNkR0Rq?=
 =?utf-8?B?QW0wRlFTOVhqd3pQTHplQlY4c0REMDU4bnNrcHplbkczT05zam13S2x1K2Fu?=
 =?utf-8?Q?bB80lSorLzjn2bfH6l9vC96hu9U9qfGSZ1MPGeG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20748b9a-153a-45ee-40d7-08d8ddb89520
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3006.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 20:20:12.1013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9TMxRsNL6sYXQsgyScmQu6lvT1qkUrJjvYdy2g4ezeKnXRZk3cdo5TditgTx8BlNo33VoLY+lMqxwf2lqSWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4411
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020153
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020153
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 3/2/21 12:21 PM, Kunihiko Hayashi wrote:
> After the refactoring phase, the type of max_slot has changed from unsigned
> long to unsigned int. The return type of the function get_max_slots() and
> the 4th argument type of iommu_is_span_boundary() are different from the
> type of max_slot. Finally, asserts BUG_ON in iommu_is_span_boundary().
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

I think this is all good. Looking at Linus's master I see:


537         unsigned long max_slots = get_max_slots(boundary_mask);

?

> ---
>   kernel/dma/swiotlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 369e4c3..c10e855 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -534,7 +534,7 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
>   	unsigned long boundary_mask = dma_get_seg_boundary(dev);
>   	dma_addr_t tbl_dma_addr =
>   		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
> -	unsigned int max_slots = get_max_slots(boundary_mask);
> +	unsigned long max_slots = get_max_slots(boundary_mask);
>   	unsigned int iotlb_align_mask =
>   		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>   	unsigned int nslots = nr_slots(alloc_size), stride;
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
