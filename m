Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A9C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D95D1408CA;
	Mon,  4 Apr 2022 10:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1VceammZBXI1; Mon,  4 Apr 2022 10:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D349410E5;
	Mon,  4 Apr 2022 10:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45AA2C001D;
	Mon,  4 Apr 2022 10:14:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07114C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA85282423
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6hqGpfBa8sPH for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:14:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E64F681DB2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3BLx3Osdgi1j3pxoT+S4TxtdM0gWsJdM0ZUpn8xLkzkchmJl1CsCMVaj4U90p53P3n0XaIqckYtcg5xjjsCS3z8Dr9nwCH5WZ/Ctxs4MUebYiTZGMFfc66ffljp46+0dv0OuP/jdY/U4tVASrri3nvjq+a+9D3QM5H69rl88G8pBUcgocNzAPY/6tzbEfa0L0ZufVQny/oQsCTJlcl9xtXygatt5Rr8Ep3jj3wSoRFWCFyHx5Z3uX/CF9BSgbiH/JUGf0F8eD9WiaPDzzzzMlkRiaU2vyvH3FOelUXApQ2GPp0xHXinZPYYIwkkrDXELtS6A0QLxnmUrx0Rw/R3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1arhxwVQujesD0xH1lAcQ2w46D6jt2mlPAFimNEX6Ok=;
 b=PxnkekSEioRRhW2tZjqzD5O7VbbyA/gsYwtAe2SgMLFLROYT5OeDh/bYBdlehw3O/yw7EerHnWLZ94FvpWSNFeyEA6Hlm/UF2klVw94zZdcifKtgH1Ihp/a2M/B27+ha3izJyHtVupvFAUE1C5XBOWEi8dt8nesdJu3+Gif53Vodg3uqibjCXRLYxlvrof+grWouItNnN4vUINX86b+oHkYyKjVeE4RrGwl2/kKhmy7t4I+H3EYJlanHXRQyqjAGGusXNtf/294luawO4EpSnY9daBqqk2r1rEZTiqnfzE97ivgIjhVY4D/AuxuZJzDotQPNmbBYYQQZAbazEU6dVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1arhxwVQujesD0xH1lAcQ2w46D6jt2mlPAFimNEX6Ok=;
 b=mJOBdpT+tv+Xb30Bo04ziKfJLoXQ5G6Qt7ZAo0x8jROEgjTYkdysPyDYUFxEhn47zjogEu6PPdqqVmINPe5sTr8ZPkLCWOzE8V9ukdJUMF/qfv8pB7V/J5osjsxGC63UvnSWfj9XpQFfjxyBCmpTdR8H5dd8R/UfP/3H4mJSwlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:14:14 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::5447:15e4:13e2:4608]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::5447:15e4:13e2:4608%4]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 10:14:14 +0000
Message-ID: <43c0ad97-f7f0-39f4-7606-f147f00b29e6@amd.com>
Date: Mon, 4 Apr 2022 15:44:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 00/37] iommu/amd: Add multiple PCI segments support
Content-Language: en-US
To: iommu@lists.linux-foundation.org, joro@8bytes.org
References: <20220404094129.323642-1-vasant.hegde@amd.com>
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
X-ClientProxiedBy: BMXPR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::19) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e2eb02-edab-4bd6-d8f0-08da1623de83
X-MS-TrafficTypeDiagnostic: CH2PR12MB4310:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4310FA1E03D7998415CCD0AA87E59@CH2PR12MB4310.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8KGUEjlt0hZoHrZuBh/7lBXVCzhgYC0NbRtBeDd8o8Mg35ym0JTHtC93CWzvN+TXVcCDPSUoHv68XI1Ngd76/DWMewGpHGS2em+LAc4xVcmCTTt5+Pw7q1h3u9u0a1vLAns0alxbZKNIcLqDOVyQIJ+RQgn2CNo87U2u9BH89PHYf34Oyf2JIeo6HJOX9Pk8Oknba6jU7NOEdDPTA2SD7n2EMAU9umQrQYgQqDAIJB+321mrqQxe9ehFjE1KAuppbq56xQwY+HLbt8HE/nJTeRGO7ubMS+Q35uzA7w6syX1PluVc2j/jDlUXKlTG61zC3+aGrfpyk0NCQWEO914PzefvxBr+670S2QRvnsSbk6Zr7VMTxDYRPYxGREUbkdjpB4BuYKvZ3PfDZsdCJ3PXP2hls0Bb0DNaXh6c3/cO9RXvxm2YkFbSAmAa2/4Nje0Q3Bswuc6+sbzxmSbZ1MBBbpPd8O6TIcJ/3aN18Bbt27fLEiwIe57TwE10GN39GE/fX44dBhZ/6H6sc0b6D1/W/y/JTL1SQHoRV84ljBjPGo3XWdCLed2Ig0B8+Paf9QAHbwj5BFyNpYXXkF+7peiQ0xfu6HWBBZG1/J6eOMDfOhgItGSC8MhWRLZ8eY1f6sLB0IeFOwLnoBXZP+o5r6Rb40XExYfvxppdLK/H4GWNuf5EZhTbvv6CYf8qEfz9IrLI6WgHJLv8Jvj6MR/3pJtIfcjN6dS/LVZL3C/hTV7Mx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2906.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(2616005)(26005)(8676002)(66476007)(66556008)(66946007)(508600001)(186003)(316002)(53546011)(86362001)(38100700002)(5660300002)(31696002)(44832011)(31686004)(2906002)(6486002)(8936002)(4744005)(6512007)(6666004)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UyswSHEyVFN6RzM1dURGM3dlK3lRZUZEcHo5L2c0RFZ5SXJybUlBSEpKb0Fy?=
 =?utf-8?B?SjZueVh6MnVRb0VIY1pTM01pQzhMRWN1L3RMdWEvTTZkc1h1NjM1bjVkZ3Z0?=
 =?utf-8?B?VjRMSlpIU2ZqWjIxK3VIb2REcExMa1dJeGp3YXBWemUvbGd3SUh2VVRud3dn?=
 =?utf-8?B?a2ViRHptNm92QXhFVGJxSjJJSGN4dWdCMUgwcERhejNlZWRNS0VudXUvbGth?=
 =?utf-8?B?ckNXWW5SSGpLcHlvS2xodjJPRnVXYmVRZU1JZkFzNThZeWp3T0c3ODBtU29D?=
 =?utf-8?B?NUpZUy90VENUVGh4Wkl0LzA0VS9JWEwxYjI4OUgzQ0s1Mk9WTGRWOGgyMkZP?=
 =?utf-8?B?NWZCaFlUOFp1R2tzNXEvY1pNaFdCc01NUGh5NkV6M1NST0hYSW1aby82cnow?=
 =?utf-8?B?WExwZFhWRVJpdkFlNzJqdEpiTUh0VjBxZEtIem9sSnFNT09NS1NhUFZ4Q3NK?=
 =?utf-8?B?YTU5VGlPTnBIeEpoUHZxV1BOTHBjTEdMZmZtV1pWSGh4VmJqY0hqRlJxcVda?=
 =?utf-8?B?UVZyL3NtWHRYUGthWFloNy9QdWd4R3Zld3pIVjVueWdOKzdYbVhSYjJra1hD?=
 =?utf-8?B?L1dOaUVQNTROR01McElqTjdrZ2ZsQVNLL09Pb3VHbzZ1TnZORUpnV3U2dkpR?=
 =?utf-8?B?VGdvZXVZWFdBeHZtS3Fyby9tdXByaU9ORk1TZytpdlBVRFNTbTZIN3BpY05O?=
 =?utf-8?B?SDZxK1RRdFBHamdCdVc0NEtOK0xBMnY3R2Q0WlBHb0MvTkVzQlFscCtuL3d3?=
 =?utf-8?B?OG9YZTA0bDlaZXdmUll1MjZIa2VnYWNJaTRPQXFiWXI2bzdzaG9LaGR2QlJ4?=
 =?utf-8?B?eFZmU29TbmhxeXJFT2pZOTZMUERkVnl1cy9VQU82MElTUm9JY1JQY3FmdCt1?=
 =?utf-8?B?dThlcFV3b2kzajZZK2VJcXNHVUR0bis1OWFpbDhKTm5KVHh2M0NISHdBYUJz?=
 =?utf-8?B?c3oyZVdJeE1pRDBTSmJZL1FjbjFhclVaMXkwVkdkZ2pNbDRDM29naWFuZ2VJ?=
 =?utf-8?B?OXFwWGpldlEweUw4eXljZitvTkxUZ1ExRFpIbjJnUnh4WDRaRGoyaVRNKzNY?=
 =?utf-8?B?MWI2ajczTTB4cnZ4R3VLenkwZWFNSmxPb0dSVWtTNElWNlUvdlFYcjFFdThq?=
 =?utf-8?B?Vlc3QXJGUThIcmo1b3ZEblZzc0szTzB1WEsvdzNITkNuNUEvMzF0WHVRM2hL?=
 =?utf-8?B?RnFSY3IyYzN3QWdJWkRCZzZJYUFjZ0Q3T0M3dEVJT2gyWGlNbnlDZVcrRVJ1?=
 =?utf-8?B?UmNVUXYxZDBTOUgzcVJtemFXWHZPREVOc0F3SFFPaG9RdktBM0FJN1ROalR0?=
 =?utf-8?B?VmlId2psMTRCMlBUb0h5Y2JrR0x4bXhtYnB6NHNXc0piK3V6QWhCYVk2VFZX?=
 =?utf-8?B?N2tLY3M3K3gwemhXT2pDclZyV294SEc1d0x6M2QrNFdlem1ObzRoUW9RdUdM?=
 =?utf-8?B?WnRlSUdjZTBWVVZIeXJoL2U0dy8yc0hISVYrbzhiWUFYVjdoOU5NSTNBaEFX?=
 =?utf-8?B?U215QTRjK3lUNnBFa2lTU1hHMldDQ1I1NHpnY3JTSzZQUEN0SloxVlBQRk9N?=
 =?utf-8?B?aEg2Nm9HM0FVQmhKdnNlaXdHOC9aV1IvM01KRlJNVG9GMDAwNUNlay9teDdI?=
 =?utf-8?B?aFp6cjBCekxLV041ay9lNTV6dGhNMFlwOW1YOEpjbldMQXVMU2ZRbStsbGp5?=
 =?utf-8?B?VmRYYmJVcWJvSGNIYTFKaXQ3K1lsaFRwMGpqRnIwV2g1OC9Ca1FrZjVzYnFu?=
 =?utf-8?B?YlU0TnJVSHlOdkNiRGlEMm1LRVZsT0U5eFhyT1YwY2FCNE8yZGtOMnpKZWdT?=
 =?utf-8?B?d0lSSXRJWG5jM0MwNkdtN3RKMTU5Y21ibkxBa1RjRmtXWHdSQ2VwN2NLc242?=
 =?utf-8?B?RU5zZFJuRFErbHE1VEFrYUFueWpoZmNxRnkyNkxLWHJRd1JmVnVTODVlMEQx?=
 =?utf-8?B?dXNRMzBvR3RmY3dPbmxCa0FyQnNGa0NVMExDWEhpUkRXTENmMktsb2lPeERs?=
 =?utf-8?B?RTNFVWxXOExwdEU5czRtZkdPajc1S1ZzWGtkVTNqakxmclVTTUtXSmtFcWRW?=
 =?utf-8?B?TG96WGovSFI0ZVFYcWFhSVd0bWZRM3NqbGNoYktZQUhZQUQ3SithbjlSZ3Ft?=
 =?utf-8?B?L3NZZGNMSjM2TUJ2TmVBSlZvVEJRMkpnb3hvT0VBYkJITHkydi9zMWFqZTZ6?=
 =?utf-8?B?OEl5eDVNUjJOMU5YWmVkS1p5dUZZVXgyanFudHp6RUp1djZ6Kzd5d2NLODBR?=
 =?utf-8?B?d1NEbnR5clVPSk9VbVhlbGJvajZJekVLUlJmKzhUSEtMaWsyVnBuZ1ZjOGsx?=
 =?utf-8?B?K0J0VDZPaTloRng3bE1mOE5DdTdhaTd0amZseEo1R1RKbDBBelY5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e2eb02-edab-4bd6-d8f0-08da1623de83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:14:14.3257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moq+8+MDzUaM0f5naLHJByxha9vOmz1ultBwIh2JUt+qARRuJlB9WJW5aS7Ix8LvMqls5N3FdT9fCJJZoAeB4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/4/2022 3:10 PM, Vasant Hegde via iommu wrote:
> Newer AMD systems can support multiple PCI segments, where each segment
> contains one or more IOMMU instances. However, an IOMMU instance can only
> support a single PCI segment.
> 

Hi,

Please ignore this series. Looks like I had network glitch and git didn't send entire series.
I have resent series.

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
