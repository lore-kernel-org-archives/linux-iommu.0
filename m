Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB1C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 16:43:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D5B60F70
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 16:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26D5B60F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA8F340439;
	Mon, 25 Oct 2021 16:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGf-USDxZKDX; Mon, 25 Oct 2021 16:43:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7983640390;
	Mon, 25 Oct 2021 16:43:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ECEEC0019;
	Mon, 25 Oct 2021 16:43:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7145C000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E894607F5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWMfpXI4bDTT for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 16:43:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08726607F2
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaWEQ/uKgx3crsxlfy9K8YOfi1JSMNiqfXL++Y0uuStdDMUbNs2zWCXaO78/s5OHGyoILkPa8DXwplA2ptwapC6682U6lgNv+d1zDCvgK/m2Gg8eOeKOwiGXP1cFJtgBjDIo+Psm7J7uY2inkzLkQ70kml/K4uJX+NsPDTxylt/fAJVZxzD0fJ89uV5rb9jPVavCbFSci1Yq1SCu78rsTXXiXqBKsVtRO/nn6zzMNJP4/P7XA4L5iTjLl1ypmFkPmzWxeI+o/IQg478Kt7uq80NuQHrsLLK53/bo1GaMRMGtqjVWE0QPRIvk8MgVZwpXAzEyOR/i0SnjEQT5967Vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5rDtUZqimZVyV0toZguW7txROBrh1ytXNVEfl8RWMw=;
 b=PgLKcUYEpZ3ullBjkhr6o5PGJ11DzoOQUPlWhm9YBT8ygE359XPKBjLTZJMhC2GEyuX5wQlqZXLim7oH1IXF8eUXhZq2haXtRakgT5v5gcMIQyM35unNhxNNPptOBal6tmJM/tjiYBatHeB6kbn2Nq8UbxlXLjN9p8AU84vvfEfuE76bNIFhaPZBWofVh3WS5ADn9ljXl22gmShX0HRodB3aLI2T3E0h6PjUTmrtJ+nFWiyHdXrEJyG8hEYKANLaY9mFd2VDp2tp1XkjKSgTLhkYIHB61r5hgsdOLvDAJbzYQR/EPwfFwyLw2FjDGN9dNJO1PNSULaC1uMcFLqfwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5rDtUZqimZVyV0toZguW7txROBrh1ytXNVEfl8RWMw=;
 b=Aiq5qz9xH4nP+GIyctwCuyLUtAk0LwdcVY1VfriiMQwdiQbbQqsS0gauEzYyTZwrX/YapbYmcXP9PPcJ2bZmu27oqmF+ZkdXHUc6zGavMYa2wE1DFN81f3FeFo7CRHH56Vtq4butSyJDJoRbL4zrwdefHSce0sgQpKHKaDtHFdI=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1408.namprd12.prod.outlook.com
 (2603:10b6:300:12::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 16:43:09 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4628.018; Mon, 25 Oct
 2021 16:43:09 +0000
Subject: Re: I got an IOMMU IO page fault. What to do now?
To: Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
 <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
Message-ID: <2e315f82-1bbb-5570-8ece-a3aec42f45f0@amd.com>
Date: Mon, 25 Oct 2021 18:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
Content-Language: en-US
X-ClientProxiedBy: AM5PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::36) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:8129:53e5:4c:630b]
 (2a02:908:1252:fb60:8129:53e5:4c:630b) by
 AM5PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 16:43:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba565e1-673e-4965-ee2f-08d997d6868c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1408:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14087A2D46BAAFF1938A283483839@MWHPR12MB1408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTUniRrYheWCcLArxhMd6549KKtCvoLGasxVvGUW3PPiWcO8R4gh8L4BSpw+KS46oIbRuuntZbkG6KS/V0e+Wk+Vx4Oe5cuPImlMGnn5v4Cp/uotCO/nwI4TSvRp4YV5n4S/zKmXEsOMjoKBuV42/BeC7gYRrQ0/D/cRTPtstO7oLWJkNY01+aLFA906auh7twbJlDdlYDFKTQAoIjaFE23FbhnWCSH3f90NVx3tizElVUjPrBucH4piMdbmd40wAJ2t95MQVunoyFVeEbRIj87Kf4fjQGNqnfrZ8OBzOdM8lCaTqKwb3Z6t0ek+dmJ+FxHMCWiK6a2tKGEro1z3w3FCUnyOTg6+vYqVcgzrZab1f2TFoCpcImJr278hPQ/rwgMohWwtrkPE82ZWmnBQbsqF+RVa8wBjKJ+r0knzrJ3nBsgZRN/utwh6j6dn3rPIAY/PWA19RnXbrRPHr2GdLezeFV715gYnLhBgF7T0/w+RnrEQ8Lgf9UtD2BBxd9BcoHTpiu3LoLI62JrEGY5M/rodp/QeNl6aLk8uiT6uPhesojsIkDipV3WhoAQrcO1eR0I8Tkh9c5SrMlP3vNTTKoadVZ34+S1mfO7ZtV6TqL9VxUMD9g+qn+jFHXwrPVf0Rmh34BbpuSmGuusAoxYnRP5ai4SAK5sAwIAZUtQ8hhu9gd00Mvykw9dKZqAj8QPrD1wqYvTu9lK890z9M/ol3pifUCLoXQRXax5WGKO99RWgXkITqrlMxKLrUoYhVNqy3eJlCqN/YM7ujCHltoR6RNZDyOpQwwBnIixsreP69Sn8u+DsqlNviqzYxFYCsYpV++9We8IyLLtoV/o1IWLzFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(6666004)(508600001)(54906003)(4001150100001)(7416002)(83380400001)(2616005)(110136005)(86362001)(316002)(31686004)(31696002)(186003)(45080400002)(38100700002)(66556008)(8936002)(66946007)(66476007)(6486002)(8676002)(4326008)(2906002)(53546011)(36756003)(6636002)(5660300002)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1c3YmxMWG5oQUk1OXFtcjRITU1hV3JQakY1YkZLOXJ4aDV0ajExKzRiV1or?=
 =?utf-8?B?NGtRaC9BOXA3ZjBySDV2MklVMTdZQk4za3lrbzMvOENJS3BpVzhlbW5uVFVj?=
 =?utf-8?B?bGNjVmlKVm9hMmVRZjBsZ3JXa1N3M3pWOU45SjMwc1Q2OEUzVUFydWZMTzVt?=
 =?utf-8?B?cjVUOFJBZGVXNE54Titrb1ZpVXh6aDl1T1FxZ00zZW1BUnMraXdzRDRJMzFy?=
 =?utf-8?B?eWp3UWdrQzMrTzYyZ1UrWkdyLzNkOVpSbmxXN3kxVmdiQTVtTDZYMi9LWmNi?=
 =?utf-8?B?UHVCRDhIUUpFbDFmSjN0ZkZSNk1pVEo5NGpRUlpNak5QS3lEYkxRbnNHYVEv?=
 =?utf-8?B?czNuUFpsSU1SMEc4SHdXT1RQUFVRdUlQWFdiRXBUZStJNWlObmVaNUVXZXU0?=
 =?utf-8?B?WGIrUjNSNU9vSllOMEo3M0R6UHpWdjF0YU1MeWdmSTVMQkxaeHdZUUpLbWhj?=
 =?utf-8?B?OEtvY3NDSVhZTk1NenF3SWl2bFc1S0tOZEZpRmZ5T2I4T0dwUXp5SzREY3Fj?=
 =?utf-8?B?d2t1YytZWE9GYytYRWRjYWJFZnNyZjNPdHZ3MUZ0bllqUUNGUlRobnJYRGJ3?=
 =?utf-8?B?bFdFYno1c0hFUC8wMFBrQ0ZUcHArdm9uNW1PLzVieUVTeFNGeWFkbk8wYlpV?=
 =?utf-8?B?Ui9RK0QyVWtBSFkvem1sTTVvNFhXQS9rWWpMVGNmQ0lhYVNpUzhId1NIckhy?=
 =?utf-8?B?U2grYUk3andNSVFabXlvd1RLWFF5NXc2ZkxWRFdoSXFaVW5CMllkRHUweFhP?=
 =?utf-8?B?M29JV0hSTkF0OW5DUnBXN2xBU2J6ZXVtTjRwQ2dEckMxaU50QmpPME5wektU?=
 =?utf-8?B?ckdNQjVzQ3hJL0F2VmpSdDRwV011RWQ1T0R2L1lDMXpRMkk1d0ZKOEg3czZC?=
 =?utf-8?B?d1NZTnk4dzRBbDFSd0IybkF6cXo5aXFVeE1CenArTzIxYklJVGh5cGJpT2tq?=
 =?utf-8?B?c2ZtdlR0YnpPbjJtSWRvZlhmZ3B5YUNSdk1BVkRZTFMrV0J1VlE0OWlibC9H?=
 =?utf-8?B?cVg3QWlnWVZSTWV3MnRyRkp1K0hJRkpDVlN4Q1RsWkVZK3pRd3VuVmpOQkpY?=
 =?utf-8?B?Y3UvUU9MQXRwQTgxLzdVaU1hU2ZuUFRHYmxkaSs1U00wdjNxYVNXWmFjVmUw?=
 =?utf-8?B?b051OEp6VmRmL1RWaG12Rk01MDVWYWNYOUhrc2diVFhOeFRGMy9VSE9sL2Vq?=
 =?utf-8?B?Skd6KzduZ0xOaTI3VDdUM2VxMzNiRFJpTGJCK25YWEUxMFFza2o0Mm5uRlFJ?=
 =?utf-8?B?bStQUFczRml0SHBSeGIxQWJoM0VPTExLdGRjdTg5eWtuTmorcDVkYzBZSWpx?=
 =?utf-8?B?cWYxZURRcnJ6MkUxWUVsR3dGenhHRGt5MVZEVEt6NDhBNk1JUzlmc2lXMDRP?=
 =?utf-8?B?RVVud09KUUJGTUI0ZjdYUEZGek5HL1JURTV5dS9pdktSQllPZURWVDNxd3ZP?=
 =?utf-8?B?VWlEcHpnbU5SQnNwOXlIZHhBemJ1SVJKR2hCT3FYMXF6SGlxd0ZCOXBTTjF5?=
 =?utf-8?B?SHd1N2xyRVlkYy9CblBqdzliWXFWSFZFUGtXc0t2OXdxUWg3MzlsU3l4aTh5?=
 =?utf-8?B?MXBubHg4WjBHdjdtK2gybEkvYmxLbW02RlFOVGNGeE1pOERWZXJ0MTQ1ZC9F?=
 =?utf-8?B?Z1ZhZEZLTDRQa1RoOUpJUkN5eXZqM2hneStCMmRDaVcxbFd6R0lsRVMyckpx?=
 =?utf-8?B?WjhyNWZ4TWFKZlZzMDRjWFhrMTJKQXIybEtpb1U1bFlYcTFQMWR5dVNXbFBr?=
 =?utf-8?B?bzh3NFRvM0xacGpxNkJPd1ViczdlWnFhZjNVNkpkWnhDbC84Vm5NdWwxWGtH?=
 =?utf-8?B?aS8rN3g5TDhBbUU2T0EvT3VvdHJScmFYZnFJMDNzVGJqNldsQ1Z0cVFENlJW?=
 =?utf-8?B?S2tuUFdRbEJCSG1oUFJqZDRiNE1JTHRQWGZOdFgycUdTUm15WHBUa2Z3Kzdl?=
 =?utf-8?B?VkcvYmw4OU9iVjhnNnFQbnlHdkFsMmp0OEU0bVBlNGlIT1NxcnIzN2N0SU5t?=
 =?utf-8?B?VThTT1NNUVlLam42VzM5TnM4WlBMYTJzSWlFVGRsWi9QVlNOKzFrWHNnM1gz?=
 =?utf-8?B?NVByN292MUVaMll1MDZMR3NBeTZlRWpHUGlad3pMbUFGUUV1ci80cUI4Q0RL?=
 =?utf-8?B?VGFjQnhlUXdtYVpmeDhoU1VFLzUzQXRLRSsvd1BVRFJyc1NVOFpFamFhSytK?=
 =?utf-8?Q?ZTQIpbUAwjrBxnu8RDcrTLk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba565e1-673e-4965-ee2f-08d997d6868c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:43:08.8962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WaXeVW1XylOVAuQoYVwsGE36lyt6ehG2ARLyKRiBVw+dY7gRGzDwmJsHszK+nG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1408
Cc: x86@kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alex Deucher <alexander.deucher@amd.com>,
 it+linux-iommu@molgen.mpg.de, Thomas Gleixner <tglx@linutronix.de>
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= via iommu
 <iommu@lists.linux-foundation.org>
Reply-To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgUm9iaW4sCgpBbSAyNS4xMC4yMSB1bSAxODowMSBzY2hyaWViIFJvYmluIE11cnBoeToKPiBP
biAyMDIxLTEwLTI1IDEyOjIzLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBIaSBQYXVsLAo+
Pgo+PiBub3Qgc3VyZSBob3cgdGhlIElPTU1VIGdpdmVzIG91dCBhZGRyZXNzZXMsIGJ1dCB0aGUg
cHJpbnRlZCBvbmVzIGxvb2sgCj4+IHN1c3BpY2lvdXMgdG8gbWUuIFNvbWV0aGluZyBsaWtlIHdl
IGFyZSB1c2luZyBhbiBpbnZhbGlkIGFkZHJlc3MgbGlrZSAKPj4gLTEgb3Igc2ltaWxhci4KPgo+
IEZXSVcgdGhvc2UgbG9vayBsaWtlIGJlbGlldmFibGUgRE1BIGFkZHJlc3NlcyB0byBtZSwgYXNz
dW1pbmcgdGhhdCB0aGUgCj4gRE1BIG1hcHBpbmcgQVBJcyBhcmUgYmVpbmcgYmFja2VkIGlvbW11
X2RtYV9vcHMgYW5kIHRoZSBkZXZpY2UgaGFzIGEgCj4gNDAtYml0IERNQSBtYXNrLCBzaW5jZSB0
aGUgSU9WQSBhbGxvY2F0b3Igd29ya3MgdG9wLWRvd24uCgpUaGFua3MgZm9yIHRoYXQgaW5mb3Jt
YXRpb24uIEluIHRoYXQgY2FzZSB0aGUgYWRkcmVzc2VzIGxvb2sgdmFsaWQgdG8gbWUuCgo+IExp
a2VseSBjYXVzZXMgYXJlIGVpdGhlciBhIHJhY2Ugd2hlcmUgdGhlIGRtYV91bm1hcF8qKCkgY2Fs
bCBoYXBwZW5zIAo+IGJlZm9yZSB0aGUgaGFyZHdhcmUgaGFzIHJlYWxseSBzdG9wcGVkIGFjY2Vz
c2luZyB0aGUgcmVsZXZhbnQgCj4gYWRkcmVzc2VzLCBvciB0aGUgZGV2aWNlJ3MgRE1BIG1hc2sg
aGFzIGJlZW4gc2V0IGxhcmdlciB0aGFuIGl0IHNob3VsZCAKPiBiZSwgYW5kIHRodXMgdGhlIHVw
cGVyIGJpdHMgaGF2ZSBiZWVuIHRydW5jYXRlZCBpbiB0aGUgcm91bmQtdHJpcCAKPiB0aHJvdWdo
IHRoZSBoYXJkd2FyZS4KClRoYXQgYWN0dWFsbHkgbG9va3MgY29ycmVjdCB0byBtZS4gVGhlIGRl
dmljZSBpbmRlZWQgaGFzIGEgNDAtYml0IERNQSBtYXNrLgoKVGhlcmUgaXMgYSB0aGlyZCBwb3Nz
aWJpbGl0eSB3aGljaCBpcyBhY3R1YWxseSBxdWl0ZSBsaWtlbHkgYW5kIHRoYXQgYXJlIApzdGFs
ZSByZWFkcyBpbiB0aGUgcGlwZWxpbmUuCgpTZWUgZm9yIHNvbWUgdXNlIGNhc2VzIHRoZSBkZXZp
Y2UgY2FuIHF1ZXVlIHJlYWRzIGludG8gYW4gaW50ZXJuYWwgCnBpcGVsaW5lLCBidXQgd2hlbiBp
dCBsYXRlciBmaW5kcyB0aGF0IHRoZSByZWFkIGlzbid0IG5lZWRlZCBkb2Vzbid0IApmbHVzaCB0
aGUgcGlwZWxpbmUuCgpUaGUgbmV4dCBvcGVyYXRpb24gcHVzaGVzIG1vcmUgcmVhZCByZXF1ZXN0
cyBpbnRvIHRoZSBwaXBlbGluZSBhbmQgCmV2ZW50dWFsbHkgdGhlIHN0YWxlIHJlYWQgcmVxdWVz
dHMgYXJlIGV4ZWN1dGVkIGFzIHdlbGwuCgpXaXRob3V0IElPTU1VIHRoZSByZXN1bHQgb2YgdGhv
c2UgcmVhZHMgYXJlIHNpbXBseSBkaXNjYXJkZWQsIHNvIG5vIGhhcm0gCmRvbmUuIEJ1dCB3aXRo
IElPTU1VIGVuYWJsZWQgaXQgaXMgcGVyZmVjdGx5IHBvc3NpYmxlIHRoYXQgdGhlIHN0YWxlIApy
ZWFkIGlzIG5vdyBhY2Nlc3NpbmcgdW5tYXBwZWQgbWVtb3J5IC0+IEJBTS4KClRoYXQncyBvbmUg
b2YgdGhlIHJlYXNvbnMgd2h5IHdlIGFsbW9zdCBhbHdheXMgaGF2ZSBHUFVzIGluIHBhc3N0aHJv
dWdoIAptb2RlIG9uIHg4NiBhbmQgZm9yIGV4YW1wbGUgZG9uJ3QgdXNlIHN5c3RlbSBtZW1vcnkg
Zm9yIEdQVSBwYWdlIHRhYmxlcyAKb24gQVBVcy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBH
aXZlbiB0aGUgYWRkcmVzc2VzIGludm9sdmVkLCBteSBzdXNwaWNpb25zIHdvdWxkIGluaXRpYWxs
eSBsZWFuIAo+IHRvd2FyZHMgdGhlIGxhdHRlciBjYXNlIC0gdGhlIGZhdWx0cyBhcmUgaW4gdGhl
IHZlcnkgdG9wbW9zdCBwYWdlcyAKPiB3aGljaCBpbXBseSB0aGV5J3JlIHRoZSBmaXJzdCB0aGlu
Z3MgbWFwcGVkIGluIHRoYXQgcmFuZ2UuIFRoZSBvdGhlciAKPiBjb250cmlidXRpbmcgZmFjdG9y
IGJlaW5nIHRoZSB0cmljayB0aGF0IHRoZSBJT1ZBIGFsbG9jYXRvciBwbGF5cyBmb3IgCj4gUENJ
IGRldmljZXMsIHdoZXJlIGl0IHRyaWVzIHRvIHByZWZlciAzMi1iaXQgYWRkcmVzc2VzLiBUaHVz
IHlvdSdyZSAKPiBvbmx5IGxpa2VseSB0byBzZWUgdGhpcyBoYXBwZW4gb25jZSB5b3UgYWxyZWFk
eSBoYXZlIH4zLjUtNEdCIG9mIGxpdmUgCj4gRE1BLW1hcHBlZCBtZW1vcnkgdG8gZXhoYXVzdCB0
aGUgMzItYml0IElPVkEgc3BhY2UgKG1pbnVzIHNvbWUgCj4gcmVzZXJ2ZWQgYXJlYXMpIGFuZCBz
dGFydCBhbGxvY2F0aW5nIGZyb20gdGhlIGZ1bGwgRE1BIG1hc2suIFlvdSAKPiBzaG91bGQgYmUg
YWJsZSB0byBjaGVjayB0aGF0IHdpdGggYSA1LjEzIG9yIG5ld2VyIGtlcm5lbCBieSBib290aW5n
IAo+IHdpdGggImlvbW11LmZvcmNlZGFjPTEiIGFuZCBzZWVpbmcgaWYgaXQgYnJlYWtzIGltbWVk
aWF0ZWx5IAo+ICh1bmZvcnR1bmF0ZWx5IHdpdGggYW4gb2xkZXIga2VybmVsIHlvdSdkIGhhdmUg
dG8gbWFudWFsbHkgaGFjayAKPiBpb21tdV9kbWFfYWxsb2NfaW92YSgpIHRvIHRoZSBzYW1lIGVm
ZmVjdCkuCj4KPiBSb2Jpbi4KPgo+PiBDYW4geW91IHRyeSB0aGF0IG9uIGFuIHVwIHRvIGRhdGUg
a2VybmVsIGFzIHdlbGw/IEUuZy4gaWRlYWxseSAKPj4gYmxlZWRpbmcgZWRnZSBhbWQtc3RhZ2lu
Zy1kcm0tbmV4dCBmcm9tIEFsZXggcmVwb3NpdG9yeS4KPj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0
aWFuLgo+Pgo+PiBBbSAyNS4xMC4yMSB1bSAxMjoyNSBzY2hyaWViIFBhdWwgTWVuemVsOgo+Pj4g
RGVhciBMaW51eCBmb2xrcywKPj4+Cj4+Pgo+Pj4gT24gYSBEZWxsIE9wdGlQbGV4IDUwNTUsIExp
bnV4IDUuMTAuMjQgbG9nZ2VkIHRoZSBJT01NVSBtZXNzYWdlcyAKPj4+IGJlbG93LiAoR1BVIGhh
bmcgaW4gYW1kZ3B1IGlzc3VlICMxNzYyIFsxXSBtaWdodCBiZSByZWxhdGVkLikKPj4+Cj4+PiDC
oMKgwqAgJCBsc3BjaSAtbm4gLXMgMDU6MDAuMAo+Pj4gwqDCoMKgIDA1OjAwLjAgVkdBIGNvbXBh
dGlibGUgY29udHJvbGxlciBbMDMwMF06IEFkdmFuY2VkIE1pY3JvIAo+Pj4gRGV2aWNlcywgSW5j
LiBbQU1EL0FUSV0gT2xhbmQgW1JhZGVvbiBIRCA4NTcwIC8gUjcgMjQwLzM0MCBPRU1dIAo+Pj4g
WzEwMDI6NjYxMV0gKHJldiA4NykKPj4+IMKgwqDCoCAkIGRtZXNnCj4+PiDCoMKgwqAgW+KApl0K
Pj4+IMKgwqDCoCBbNjMxODM5OS43NDUyNDJdIGFtZGdwdSAwMDAwOjA1OjAwLjA6IEFNRC1WaTog
RXZlbnQgbG9nZ2VkIAo+Pj4gW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4
ZmZmZmZmZjBjMCBmbGFncz0weDAwMjBdCj4+PiDCoMKgwqAgWzYzMTgzOTkuNzU3MjgzXSBhbWRn
cHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPj4+IFtJT19QQUdFX0ZBVUxU
IGRvbWFpbj0weDAwMGMgYWRkcmVzcz0weGZmZmZmZmY3YzAgZmxhZ3M9MHgwMDIwXQo+Pj4gwqDC
oMKgIFs2MzE4Mzk5Ljc2OTE1NF0gYW1kZ3B1IDAwMDA6MDU6MDAuMDogQU1ELVZpOiBFdmVudCBs
b2dnZWQgCj4+PiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZl
MGMwIGZsYWdzPTB4MDAyMF0KPj4+IMKgwqDCoCBbNjMxODM5OS43ODA5MTNdIGFtZGdwdSAwMDAw
OjA1OjAwLjA6IEFNRC1WaTogRXZlbnQgbG9nZ2VkIAo+Pj4gW0lPX1BBR0VfRkFVTFQgZG9tYWlu
PTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZmVjMCBmbGFncz0weDAwMjBdCj4+PiDCoMKgwqAgWzYz
MTgzOTkuNzkyNzM0XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAK
Pj4+IFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMGMgYWRkcmVzcz0weGZmZmZmZmU1YzAgZmxh
Z3M9MHgwMDIwXQo+Pj4gwqDCoMKgIFs2MzE4Mzk5LjgwNDMwOV0gYW1kZ3B1IDAwMDA6MDU6MDAu
MDogQU1ELVZpOiBFdmVudCBsb2dnZWQgCj4+PiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBj
IGFkZHJlc3M9MHhmZmZmZmZkMGMwIGZsYWdzPTB4MDAyMF0KPj4+IMKgwqDCoCBbNjMxODM5OS44
MTYwOTFdIGFtZGdwdSAwMDAwOjA1OjAwLjA6IEFNRC1WaTogRXZlbnQgbG9nZ2VkIAo+Pj4gW0lP
X1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZWNjMCBmbGFncz0weDAw
MjBdCj4+PiDCoMKgwqAgWzYzMTgzOTkuODI3NDA3XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQt
Vmk6IEV2ZW50IGxvZ2dlZCAKPj4+IFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMGMgYWRkcmVz
cz0weGZmZmZmZmQzYzAgZmxhZ3M9MHgwMDIwXQo+Pj4gwqDCoMKgIFs2MzE4Mzk5LjgzODcwOF0g
YW1kZ3B1IDAwMDA6MDU6MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgCj4+PiBbSU9fUEFHRV9G
QVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZjMGMwIGZsYWdzPTB4MDAyMF0KPj4+
IMKgwqDCoCBbNjMxODM5OS44NTAwMjldIGFtZGdwdSAwMDAwOjA1OjAwLjA6IEFNRC1WaTogRXZl
bnQgbG9nZ2VkIAo+Pj4gW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZm
ZmZmZGFjMCBmbGFncz0weDAwMjBdCj4+PiDCoMKgwqAgWzYzMTgzOTkuODYxMzExXSBBTUQtVmk6
IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPj4+IGRldmljZT0wNTowMC4wIGRvbWFpbj0w
eDAwMGMgYWRkcmVzcz0weGZmZmZmZmMxYzAgZmxhZ3M9MHgwMDIwXQo+Pj4gwqDCoMKgIFs2MzE4
Mzk5Ljg3MjA0NF0gQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgCj4+PiBkZXZp
Y2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZjOGMwIGZsYWdzPTB4MDAy
MF0KPj4+IMKgwqDCoCBbNjMxODM5OS44ODI3OTddIEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19Q
QUdFX0ZBVUxUIAo+Pj4gZGV2aWNlPTA1OjAwLjAgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZm
ZmZmYjBjMCBmbGFncz0weDAwMjBdCj4+PiDCoMKgwqAgWzYzMTgzOTkuODkzNjU1XSBBTUQtVmk6
IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPj4+IGRldmljZT0wNTowMC4wIGRvbWFpbj0w
eDAwMGMgYWRkcmVzcz0weGZmZmZmZmNmYzAgZmxhZ3M9MHgwMDIwXQo+Pj4gwqDCoMKgIFs2MzE4
Mzk5LjkwNDQ0NV0gQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgCj4+PiBkZXZp
Y2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZiNmMwIGZsYWdzPTB4MDAy
MF0KPj4+IMKgwqDCoCBbNjMxODM5OS45MTUyMjJdIEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19Q
QUdFX0ZBVUxUIAo+Pj4gZGV2aWNlPTA1OjAwLjAgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZm
ZmZmYTBjMCBmbGFncz0weDAwMjBdCj4+PiDCoMKgwqAgWzYzMTgzOTkuOTI1OTMxXSBBTUQtVmk6
IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPj4+IGRldmljZT0wNTowMC4wIGRvbWFpbj0w
eDAwMGMgYWRkcmVzcz0weGZmZmZmZmJkYzAgZmxhZ3M9MHgwMDIwXQo+Pj4gwqDCoMKgIFs2MzE4
Mzk5LjkzNjY5MV0gQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgCj4+PiBkZXZp
Y2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZhNGMwIGZsYWdzPTB4MDAy
MF0KPj4+IMKgwqDCoCBbNjMxODM5OS45NDc0NzldIEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19Q
QUdFX0ZBVUxUIAo+Pj4gZGV2aWNlPTA1OjAwLjAgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZm
ZmZmOTBjMCBmbGFncz0weDAwMjBdCj4+PiDCoMKgwqAgWzYzMTgzOTkuOTU4MjcwXSBBTUQtVmk6
IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPj4+IGRldmljZT0wNTowMC4wIGRvbWFpbj0w
eDAwMGMgYWRkcmVzcz0weGZmZmZmZmFiYzAgZmxhZ3M9MHgwMDIwXQo+Pj4KPj4+IEFzIHRoaXMg
aXMgbm90IHJlcHJvZHVjaWJsZSwgaG93IHdvdWxkIGRlYnVnZ2luZyBnbz8gKFRoZSBzeXN0ZW0g
d2FzIAo+Pj4gcmVib290ZWQgaW4gdGhlIG1lYW50aW1lLikgV2hhdCBvcHRpb25zIHNob3VsZCBi
ZSBlbmFibGVkLCB0aGF0IG5leHQgCj4+PiB0aW1lIHRoZSByZXF1aXJlZCBpbmZvcm1hdGlvbiBp
cyBsb2dnZWQsIG9yIHdoYXQgY29tbWFuZHMgc2hvdWxkIEkgCj4+PiBleGVjdXRlIHdoZW4gdGhl
IHN5c3RlbSBpcyBzdGlsbCBpbiB0aGF0IHN0YXRlLCBzbyB0aGUgYnVnIChkcml2ZXIsIAo+Pj4g
dXNlcnNwYWNlLCDigKYpIGNhbiBiZSBwaW5wb2ludGVkIGFuZCBmaXhlZD8KPj4+Cj4+Pgo+Pj4g
S2luZCByZWdhcmRzLAo+Pj4KPj4+IFBhdWwKPj4+Cj4+Pgo+Pj4gWzFdOiAKPj4+IGh0dHBzOi8v
bmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
RmdpdGxhYi5mcmVlZGVza3RvcC5vcmclMkZkcm0lMkZhbWQlMkYtJTJGaXNzdWVzJTJGMTc2MiZh
bXA7ZGF0YT0wNCU3QzAxJTdDY2hyaXN0aWFuLmtvZW5pZyU0MGFtZC5jb20lN0MxM2VhZDEwYTRh
NTg0NTM3ZDg3MjA4ZDk5N2QwYzY5MyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNk
JTdDMCU3QzAlN0M2Mzc3MDc3NDUyOTUzOTE0NjMlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
V0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2
TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9am4xSFMlMkZodG1mTE9RQkQlMkZJOXc0Wlhwc3BjNFg3
aWs2RzhOMVc1QWxxWGclM0QmYW1wO3Jlc2VydmVkPTAKPj4+IMKgwqDCoMKgICJPbGFuZCBbUmFk
ZW9uIEhEIDg1NzAgLyBSNyAyNDAvMzQwIE9FTV06IEdQVSBoYW5nIgo+Pgo+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBpb21tdSBtYWlsaW5nIGxp
c3QKPj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmlvbW11JmFtcDtkYXRh
PTA0JTdDMDElN0NjaHJpc3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3QzEzZWFkMTBhNGE1ODQ1Mzdk
ODcyMDhkOTk3ZDBjNjkzJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdD
MCU3QzYzNzcwNzc0NTI5NTM5MTQ2MyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1D
NHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0Ql
N0MxMDAwJmFtcDtzZGF0YT1XTnNzbGNDRlAyVUpYJTJGdHVQbXNGV3YlMkJwVzFpMDJxM0s3cEls
SWRhUWNmRSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
