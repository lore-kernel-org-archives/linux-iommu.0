Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50859C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 13:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9FD24028D;
	Wed,  4 May 2022 13:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9EfOsDai0Ax; Wed,  4 May 2022 13:57:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08DD140286;
	Wed,  4 May 2022 13:57:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB2C2C0039;
	Wed,  4 May 2022 13:57:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E562C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6837E830C1
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TFCA2KtmLvWS for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:57:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::602])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BF3F82EE1
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7fVr8aVCrU5rSKYbv6WKYSm10tN28BSF81xf3jdpGEf7IO2jiJw8XFn28mO/9w9oHWhRPps908iro93/kpfrugOoWHf6myMOJn7ysvPSrK2r+diPCvanjyvX6pxmaY3+Z3xLHq9/zw/HMbpuZJ5btyY4AwbQxuuNk9U9rtY7fEnOZr695Xiw9XJyO9nODMAd4friGtimqR4zXCYaQYZttClNpV7LTv8ZyEnuuHyhK9yjHd1SVZq6I0o/AtLj4PJQUFAlGaMQgZmCpIdnT3/KvVj8na5FX8GYo81DNE9M3q2b4hFcUWX06sMfXM91jSTQNTAPk0nJtV7tm1vzhQwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EEn74IEMs3n1Tdkvz1Ot5J851Ilkur8LLomQCZk93I=;
 b=lEBd6z69BukMmJh4ItZfVuBT2D8RgYSIFTWtRLiq/6T9A492zAacnptBsgG+0PQB4si/tSq5332zK3oyyVaejghYXT9EoDGBvjw21AY3wdRRwRsrt3AXFXPD3w6e9yAU6g9g4AlNTrkXxg92FtZpN51/Q3+NQo/+eRD8PYtJp/THT2yIpoUUeW5LISs0Dp+fzS2BmiJGzYZCRv0rWxy8Y7ybC7aZPhlvRE1SNpewgrzpvpSR82JBgoxA9W8NKcLmi+mtH3JxSVdg8cJd9CMF4Z92/4N7DHdJ50cVaK+vWIxRbdoDkkku7hSuU/R/1vxjq7lOFIwZWk+INQbDDywwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EEn74IEMs3n1Tdkvz1Ot5J851Ilkur8LLomQCZk93I=;
 b=oNLDL1rW50igCzorRt2m1iArqmSSGA6hjgVka18i1Mo0J4AcO0JTn+g/hfmTmrWOMfF6SEkzwxg9yvK2Qg2s1ZtIIrl+wxyGhaP0FF7vach6/4vqqOrvB9HgebcTp29J/kWxvPJEy1S7QWt4GYQ9QtcdVskWrndVuGbICW8ukIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by HE1PR04MB3100.eurprd04.prod.outlook.com (2603:10a6:7:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 13:57:14 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::8ce8:25aa:6242:b565]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::8ce8:25aa:6242:b565%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 13:57:13 +0000
Message-ID: <b6bd7101-f5b9-4676-d515-ed4d1ee14e75@nxp.com>
Date: Wed, 4 May 2022 16:56:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-CA
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: AM0PR02CA0176.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::13) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28e883b6-be80-4aa9-3be6-08da2dd5fdd4
X-MS-TrafficTypeDiagnostic: HE1PR04MB3100:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB31008D0DEE781C79F5A8B540ECC39@HE1PR04MB3100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmG90a9Vr59tFLh2eXerG8Sdhp3hmOzbfRPB1hgkZOauMMoS8VuCwPbewKYANJWd1rGG7WwRMdhKqt5bypupM41YM4LGB3u+xf/nJhZeLVdplfZzWp4UUGsrMvtZgKBxnHeJmrXw6UBIS1iXx6pIllqQ2MzkovOVsRyQT6SMllkT7gGIjkwGWoYLvH/FT3pSUz6S0kElN2QB030jTM/SLk3qNqqXsJyDSZcUz2Sogz/8Y/ZbqXwAZnfYIJOq+/RmuGN7+1T0dkRBPu2NOq01Kag8dAJ+HVl8frZUvcmG7FCvu8qWW+kLGn7mCDp/ngPOg2b8mf7hj5Ai1UzqRGh+0aFHazUqiMFXpFAQxB5CP1oH8qxq3k2euQgb1Mi6Q754A4R8FcOsiRqsyu1oRBKZgKqPSZYsTfp4o31cxXcm5npu/lUE4hAQsO3hXFpKGoh+tkQtwUTqDqwzGVQsQ342o4JKDj/NxQO1nAEsQTgwAwLVhyQbaw00VNziNFF7djg4MedQfmqla5jgqxWYgPb/5n+oQ8xqO59X9dRowlTCXySQ0kcsSIIGP5w2Fcfd1nFyqT/jCf4YuuW+qBCKEAgD0+6nx13V37YUJYGXLzqsVm4M3dBhKCXeQeTeHUBW+9xendocFnZJk2mL42Ibz7GSnjnGIcM0KThjcL0YjTFfe+EUhA0hjEUtkjwf5rIo8JynS23WpGIs8Q8/Jdk72iOgWbcLrLomtsiwBIDsDE1rFR857nBB6sSh5ABYnXjaxbsYX1hXDSqbiuDxi2vhHzNAGaECu6OZyeXKGVAHEivb0Wk58HI3kfHWgPzDz5aBYtSUd5LES6Umsn0AZAQUicL7lrZqXwkue5pyAQ01kh5JLov68apku/OUGdaqt9Jkn482ojn06zeBfpV7t8JmxqaMTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0402MB3405.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(66946007)(4326008)(66476007)(2616005)(66556008)(8676002)(2906002)(8936002)(186003)(7416002)(45080400002)(966005)(31696002)(31686004)(316002)(83380400001)(36756003)(26005)(6506007)(86362001)(6512007)(6666004)(44832011)(38100700002)(38350700002)(55236004)(6486002)(52116002)(53546011)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1JjM0p4eE9uY1QvaDRnRWx6VmNNYWJRbmtWOVMrQm14bCtmcWJSSWN5Lzdx?=
 =?utf-8?B?Q3hZOFlBWUlQRWUwL2FRQTZaRzNOdE5RWjBzYlp3Yk1PdGtac2wrbmQvOTJw?=
 =?utf-8?B?VVY3YXV5aGdwMDdZK0gxamgzd1d4L1VPL3diN1dla1lhQmIvRzlWd3Y4M1Bo?=
 =?utf-8?B?QlNTTFF4VzlKTWJXbkNTMERibjlyZUdveklsTVgrVHR5R2ZKVzhwMHVhdjEy?=
 =?utf-8?B?eG1QcUc1cm8xTmpDWllCS3RBWVRCc20vSnhuMzFLdG95K2xncHhJTklqZzdr?=
 =?utf-8?B?dHBpanhQclJYV3dseG5yY29tQzdLTUpEcXhLeEphNzd5RFFMd1M3MnhjSzBp?=
 =?utf-8?B?NlZwLzcwOTBoakIxQWdDU01jVTlGclVURHJWQnVFS0NVUUszZk1ObkVSb1pG?=
 =?utf-8?B?SGd6YkV2aDdReG5meXBRSW04U2o3OVJnZ2NOcUxlTUwrZVY5aTI2Y3RUZVFU?=
 =?utf-8?B?ZmZxMmk3WjR3SXZXaCtqKzFXWWoxRHNsNHcxWWJLSUtxa0dmWGpiTnl4QUlu?=
 =?utf-8?B?VHpDbGsxVE5BRFhyZnJkT2hKMEo4N0tsUEpVbFZRc2J4TXZzVWRmYndTVndE?=
 =?utf-8?B?SEkwREJGZ0FVM2FYSENXaUZITDBkTklrRWx5UDk3dHlGelQzRkV2dUE3eWEx?=
 =?utf-8?B?Rmh5VUFET2trU09wWkhnQWx6Q2RFOFA0QXNNazBwalBYU29KRVFPRTNIblZH?=
 =?utf-8?B?dUFzVzkyUHZGdHpJNkJqMytPNXYwN2RjMWMzUXg2dndPaU9XaU1ZdnBXVHVM?=
 =?utf-8?B?WjB2dkNnVG9DZGczbTdQSXp0SzZXZmpnSWdscWRrNE5mZUp6Wit3aHAzWWNk?=
 =?utf-8?B?V3krM01OSnExOVpEbUxzVUd5aGtLc0lMV1RUWGttaW1pRi90WHJsQVV0T2Jv?=
 =?utf-8?B?R2IrZ1R3Yk5leEtNc1ZVdUdKc1NZYnF1VFlvV05qOVlnVDYrTmFncXZRTmI5?=
 =?utf-8?B?blNWZ0FHNE8zcGdXTkJ2MjdXRXdVL3RtWktEeldsc2pUODJjM2FSai9JL1Mr?=
 =?utf-8?B?WXFXSXV4S0w1SnRpc080a3V5SDVNVUlETmc0THh0NUwzUGREVnRGRkhRbGVZ?=
 =?utf-8?B?cmw2eGkyWTdWT25TbTFKNkpwNDRpRGQ3dnNvQWFKdlMrN3Y5MW1raFBuajhz?=
 =?utf-8?B?RHpGT3d5YldaenVEbXZlcVpPL0h6N0ZiTmJ4R3AvT2JBWUdFSktZVmxvOVpY?=
 =?utf-8?B?MHQ5bVFsV2dEYjRjOXJzZ0dTTUxUakFNdHBoOVJyS3pON3lXSHhxNXFPUTE4?=
 =?utf-8?B?MjFVT294VW5DeTRyMU1xWUNyZnoxUks0S3I2V2RzSnJaeHBvSmRzd242eFcy?=
 =?utf-8?B?cXNqdFFIVHJQRFNlaEZQeFYxd1A3ckdjL3o0b0NQYXFNYWUyZFBzRExnYXc5?=
 =?utf-8?B?czAzRFBRVkkyVm1RNUd2Y1NWblRrTE5nUGpSRElGeHk4VWM2bW9Cbjg2Zndo?=
 =?utf-8?B?WWd0djRacE8wOEt4QzQwUFVsRGttMjFydTNOdXh1OFhpQ3dVRkErcHRJR0Nq?=
 =?utf-8?B?REFXOUIxNGhGcVdpR1pBaTJhc0NJMmhReDdrSWxreUE1ajhOZ0hLR1E3RE1r?=
 =?utf-8?B?Uk5sR0daQTlRMTNMZjZDbEUwUHRwOWhlUG82bDVTcStNMGFuOHlGYm5HeTJX?=
 =?utf-8?B?bnMrdHBhTm1Fc1FFOUxtSitERVZjRXcyN2k3a1NhaGdCNHlDUEl2NHR4allX?=
 =?utf-8?B?V1FPWnNnc3JBOXlZaWptZS9kaURteW5VT243cFIvK1Fhc2IyczZCSUhHK1lz?=
 =?utf-8?B?OHE3Q1NDbDl5ejNLSngrckFjaXB0KzNnNExaVVpOK0pJSjg5Z2pvZ2lCd2dF?=
 =?utf-8?B?K1MweitMNVc4WHlQUDlKK3habkZtUS9tOUJuTTNEOXJ1bU04TDBUWk1CbDlr?=
 =?utf-8?B?SlJHVmJjdkswMlMvMGRwczF2cHpVcDNRa0I0VVF2WVlDbTNFYVRnVkc2MmVS?=
 =?utf-8?B?ZjUvZkFxTGdsRlkxeTgvOGNrR21ZczdLM0wwSys1dXk2eGJYazlWSW02cysy?=
 =?utf-8?B?UHB3UURJdWcvRFBMQkt3dDdZRnczMk9pNkx2aXg3d0wvNmEwMzUxYWp1V1BG?=
 =?utf-8?B?RTNrRTZUS2FCNjVMdGlnTFBZWDR0Q0cwMmtuSTNLbXY3cmpQY1o0cUdDY0M5?=
 =?utf-8?B?aGtUeWd6Q0tMVndjWm15TGJDeE1YcUJweDBxNUxtcGhxS0IwNkpQaC9xNE1v?=
 =?utf-8?B?Wlc5OWovSy9JR3c2cGhhV3NWbXpVZFN6Sk9FY2wwMTJIdkpkeXV2ZzJEbUNR?=
 =?utf-8?B?ZDZFME0xTzI4b3FEZVlYWE5JMDVxZitSaEJFU2hnU0diQ24vZ095VHc5bHlz?=
 =?utf-8?B?SXc0cTF1ajRsYTF5L21YMHVURDYxMGNCYkdnM2ZieVVEcDlQYVJXMXBLV2wr?=
 =?utf-8?Q?xgcn0rRQjmVvm8OQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e883b6-be80-4aa9-3be6-08da2dd5fdd4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:57:13.8518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs0jPXh4Nb+wjt+IXQouBCDK7c8zixa6PKaYMKVi5ciT/W2Frbp5Ib3vjBI2KvQIXS34hQ802PlWC/EIVeFK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3100
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA1LzMvMjAyMiA3OjMzIFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOgo+IEhpCj4gCj4g
djExIC0tPiB2MTIKPiAgICAtTWlub3IgZml4IGluIHBhdGNoICM0IHRvIGFkZHJlc3MgdGhlIGlz
c3VlIHJlcG9ydGVkIGJ5IHRoZSBrZXJuZWwgdGVzdCByb2JvdC4KPiAgICAtQWRkZWQgUi1ieSB0
YWdzIGJ5IENocmlzdG9waChwYXRjaCAjMSkgYW5kIExvcmVuem8ocGF0Y2ggIzQpLgo+ICAgIC1B
ZGRlZCBULWJ5IGZyb20gU3RldmUgdG8gYWxsIHJlbGV2YW50IHBhdGNoZXMuIE1hbnkgdGhhbmtz
IS4KClRlc3RlZCBvbiBhIE5YUCBMWDIxNjBBIHdpdGggU01NVXYyLCBzbzoKClRlc3RlZC1ieTog
TGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4KCi0tLQpUaGFua3MgJiBC
ZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQoKPiBQbGVhc2Ugbm90ZSwgdGhpcyBzZXJpZXMgaGFzIGEg
ZGVwZW5kZW5jeSBvbiB0aGUgQUNQSUNBIGhlYWRlciBwYXRjaAo+IGhlcmVbMV0uCj4gCj4gUGxl
YXNlIHRha2UgYSBsb29rIGFuZCBsZXQgbWUga25vdy4KPiAKPiBUaGFua3MsCj4gU2hhbWVlcgo+
IFsxXSBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZhbGwlMkY0NDYxMDM2MS5mTURRaWRjQzZH
JTQwa3JlYWNoZXIlMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q2xhdXJlbnRpdS50dWRvciU0MG54cC5j
b20lN0M4MTU3ZDMyOTI1NzI0YWM5YmY3OTA4ZGEyZDIyYzFhYiU3QzY4NmVhMWQzYmMyYjRjNmZh
OTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc4NzE5MjQ1NDMzMTYxNTclN0NVbmtub3duJTdD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9RGRZQ3BnJTJC
N05XJTJGYjhGQllPRXNtbFlWODhrd04wSzc1QUY5WTclMkZnMkJFbyUzRCZhbXA7cmVzZXJ2ZWQ9
MAo+IAo+ICBGcm9tIG9sZDoKPiBXZSBoYXZlIGZhY2VkIGlzc3VlcyB3aXRoIDM0MDhpTVIgUkFJ
RCBjb250cm9sbGVyIGNhcmRzIHdoaWNoCj4gZmFpbCB0byBib290IHdoZW4gU01NVSBpcyBlbmFi
bGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlc2UKPiBjb250cm9sbGVycyBtYWtlIHVzZSBvZiBob3N0
IG1lbW9yeSBmb3IgdmFyaW91cyBjYWNoaW5nIHJlbGF0ZWQKPiBwdXJwb3NlcyBhbmQgd2hlbiBT
TU1VIGlzIGVuYWJsZWQgdGhlIGlNUiBmaXJtd2FyZSBmYWlscyB0bwo+IGFjY2VzcyB0aGVzZSBt
ZW1vcnkgcmVnaW9ucyBhcyB0aGVyZSBpcyBubyBtYXBwaW5nIGZvciB0aGVtLgo+IElPUlQgUk1S
IHByb3ZpZGVzIGEgd2F5IGZvciBVRUZJIHRvIGRlc2NyaWJlIGFuZCByZXBvcnQgdGhlc2UKPiBt
ZW1vcnkgcmVnaW9ucyBzbyB0aGF0IHRoZSBrZXJuZWwgY2FuIG1ha2UgYSB1bml0eSBtYXBwaW5n
IGZvcgo+IHRoZXNlIGluIFNNTVUuCj4gCj4gQ2hhbmdlIEhpc3Rvcnk6Cj4gCj4gdjEwIC0tPiB2
MTEKPiAgwqAtQWRkcmVzc2VkIENocmlzdG9waCdzIGNvbW1lbnRzLiBXZSBub3cgaGF2ZSBhIMKg
Y2FsbGJhY2sgdG8KPiAgICBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gdG8gZnJlZSBhbGwgcmVs
YXRlZCBtZW1vcnkgYW5kIGFsc2/CoGRyb3BwZWQKPiAgICB0aGUgRlcgc3BlY2lmaWMgdW5pb24g
YW5kIG5vdyBoYXMgYSBjb250YWluZXIgc3RydWN0IGlvbW11X2lvcnRfcm1yX2RhdGEuCj4gICAg
U2VlIHBhdGNoZXMgIzEgJiAjNAo+ICAgLUFkZGVkIFItYnkgZnJvbSBDaHJpc3RvcGguCj4gICAt
RHJvcHBlZCBSLWJ5IGZyb20gTG9yZW56byBmb3IgcGF0Y2hlcyAjNCAmICM1IGR1ZSB0byB0aGUg
YWJvdmUgY2hhbmdlcy4KPiAgIC1BbHNvIGRyb3BwZWQgVC1ieSBmcm9tIFN0ZXZlIGFuZCBMYXVy
ZW50aXUuIE1hbnkgdGhhbmtzwqBmb3IgeW91ciB0ZXN0Cj4gICAgZWZmb3J0cy4gSSBoYXZlwqBk
b25lIGJhc2ljIHNhbml0eSB0ZXN0aW5nIG9uIG15IHBsYXRmb3JtIGJ1dCBwbGVhc2UKPiAgICBk
byBpdCBhZ2FpbiBhdCB5b3VyIGVuZC4KPiAKPiB2OSAtLT4gdjEwCj4gICAtIERyb3BwZWQgcGF0
Y2ggIzEgKCJBZGQgdGVtcG9yYXJ5IFJNUiBub2RlIGZsYWcgZGVmaW5pdGlvbnMiKSBzaW5jZQo+
ICAgICB0aGUgQUNQSUNBIGhlYWRlciB1cGRhdGVzIHBhdGNoIGlzIG5vdyBpbiB0aGUgbWFpbGlu
ZyBsaXN0Cj4gICAtIEJhc2VkIG9uIHRoZSBzdWdnZXN0aW9uIGZyb20gQ2hyaXN0b3BoLCBpbnRy
b2R1Y2VkIGEKPiAgICAgcmVzdl9yZWdpb25fZnJlZV9md19kYXRhKCkgY2FsbGJhY2sgaW4gc3Ry
dWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGFuZAo+ICAgICB1c2VkIHRoYXQgdG8gZnJlZSBSTVIgc3Bl
Y2lmaWMgbWVtb3J5IGFsbG9jYXRpb25zLgo+IAo+IHY4IC0tPiB2OQo+ICDCoC0gQWRyZXNzZWQg
Y29tbWVudHMgZnJvbSBSb2JpbiBvbiBpbnRlcmZhY2VzLgo+ICDCoC0gQWRkcmVzc2VkIGNvbW1l
bnRzIGZyb20gTG9yZW56by4KPiAKPiB2NyAtLT4gdjgKPiAgwqAgLSBQYXRjaCAjMSBoYXMgdGVt
cCBkZWZpbml0aW9ucyBmb3IgUk1SIHJlbGF0ZWQgY2hhbmdlcyB0aWxsCj4gIMKgIMKgIHRoZSBB
Q1BJQ0EgaGVhZGVyIGNoYW5nZXMgYXJlIHBhcnQgb2Yga2VybmVsLgo+ICDCoCAtIE5vIGVhcmx5
IHBhcnNpbmcgb2YgUk1SIG5vZGUgaW5mbyBhbmQgaXMgb25seSBwYXJzZWQgYXQgdGhlCj4gIMKg
IMKgIHRpbWUgb2YgdXNlLgo+ICDCoCAtIENoYW5nZXMgdG8gdGhlIFJNUiBnZXQvcHV0IEFQSSBm
b3JtYXQgY29tcGFyZWQgdG8gdGhlCj4gIMKgIMKgIHByZXZpb3VzIHZlcnNpb24uCj4gIMKgIC0g
U3VwcG9ydCBmb3IgUk1SIGRlc2NyaXB0b3Igc2hhcmVkIGJ5IG11bHRpcGxlIHN0cmVhbSBJRHMu
Cj4gCj4gdjYgLS0+IHY3Cj4gIMKgLWZpeCBwb2ludGVkIG91dCBieSBTdGV2ZSB0byB0aGUgU01N
VXYyIFNNUiBieXBhc3MgaW5zdGFsbCBpbiBwYXRjaCAjOC4KPiAKPiB2NSAtLT4gdjYKPiAtIEFk
ZHJlc3NlZCBjb21tZW50cyBmcm9tIFJvYmluICYgTG9yZW56by4KPiAgwqAgOiBNb3ZlZCBpb3J0
X3BhcnNlX3JtcigpIHRvIGFjcGlfaW9ydF9pbml0KCkgZnJvbQo+ICDCoCDCoCBpb3J0X2luaXRf
cGxhdGZvcm1fZGV2aWNlcygpLgo+ICDCoCA6IFJlbW92ZWQgdXNlIG9mIHN0cnVjdCBpb3J0X3Jt
cl9lbnRyeSBkdXJpbmcgdGhlIGluaXRpYWwKPiAgwqAgwqAgcGFyc2UuIFVzaW5nIHN0cnVjdCBp
b21tdV9yZXN2X3JlZ2lvbiBpbnN0ZWFkLgo+ICDCoCA6IFJlcG9ydCBSTVIgYWRkcmVzcyBhbGln
bm1lbnQgYW5kIG92ZXJsYXAgZXJyb3JzLCBidXQgY29udGludWUuCj4gIMKgIDogUmV3b3JrZWQg
YXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIChwYXRjaCAjIDYpLgo+IC0gVXBkYXRlZCBTTU1V
djIgYnlwYXNzIFNNUiBjb2RlLiBUaGFua3MgdG8gSm9uIE4gKHBhdGNoICM4KS4KPiAtIFNldCBJ
T01NVSBwcm90ZWN0aW9uIGZsYWdzKElPTU1VX0NBQ0hFLCBJT01NVV9NTUlPKSBiYXNlZAo+ICDC
oCBvbiBUeXBlIG9mIFJNUiByZWdpb24uIFN1Z2dlc3RlZCBieSBKb24gTi4KPiAKPiB2NCAtLT4g
djUKPiAgwqAtQWRkZWQgYSBmd19kYXRhIHVuaW9uIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lv
biBhbmQgcmVtb3ZlZAo+ICDCoCBzdHJ1Y3QgaW9tbXVfcm1yIChCYXNlZCBvbiBjb21tZW50cyBm
cm9tIEpvZXJnL1JvYmluKS4KPiAgwqAtQWRkZWQgaW9tbXVfcHV0X3JtcnMoKSB0byByZWxlYXNl
IG1lbS4KPiAgwqAtVGhhbmtzIHRvIFN0ZXZlIGZvciB2ZXJpZnlpbmcgb24gU01NVXYyLCBidXQg
bm90IGFkZGVkIHRoZSBUZXN0ZWQtYnkKPiAgwqAgeWV0IGJlY2F1c2Ugb2YgdGhlIGFib3ZlIGNo
YW5nZXMuCj4gCj4gdjMgLS0+djQKPiAtSW5jbHVkZWQgdGhlIFNNTVV2MiBTTVIgYnlwYXNzIGlu
c3RhbGwgY2hhbmdlcyBzdWdnZXN0ZWQgYnkKPiAgwqBTdGV2ZShwYXRjaCAjNykKPiAtQXMgcGVy
IFJvYmluJ3MgY29tbWVudHMsIFJNUiByZXNlcnZlIGltcGxlbWVudGF0aW9uIGlzIG5vdwo+ICDC
oG1vcmUgZ2VuZXJpYyDCoChwYXRjaCAjOCkgYW5kIGRyb3BwZWQgdjMgcGF0Y2hlcyA4IGFuZCAx
MC4KPiAtUmViYXNlIHRvIDUuMTMtcmMxCj4gCj4gUkZDIHYyIC0tPiB2Mwo+ICDCoC1Ecm9wcGVk
IFJGQyB0YWcgYXMgdGhlIEFDUElDQSBoZWFkZXIgY2hhbmdlcyBhcmUgbm93IHJlYWR5IHRvIGJl
Cj4gIMKgIHBhcnQgb2YgNS4xM1swXS4gQnV0IHRoaXMgc2VyaWVzIHN0aWxsIGhhcyBhIGRlcGVu
ZGVuY3kgb24gdGhhdCBwYXRjaC4KPiAgwqAtQWRkZWQgSU9SVCBFLmIgcmVsYXRlZCBjaGFuZ2Vz
KG5vZGUgZmxhZ3MsIF9EU00gZnVuY3Rpb24gNSBjaGVja3MgZm9yCj4gIMKgIFBDSWUpLgo+ICDC
oC1DaGFuZ2VkIFJNUiB0byBzdHJlYW0gaWQgbWFwcGluZyBmcm9tIE06TiB0byBNOjEgYXMgcGVy
IHRoZSBzcGVjIGFuZAo+ICDCoCBkaXNjdXNzaW9uIGhlcmVbMV0uCj4gIMKgLUxhc3QgdHdvIHBh
dGNoZXMgYWRkIHN1cHBvcnQgZm9yIFNNTVV2MihUaGFua3MgdG8gSm9uIE5ldHRsZXRvbiEpCj4g
Cj4gSm9uIE5ldHRsZXRvbiAoMSk6Cj4gICAgaW9tbXUvYXJtLXNtbXU6IEdldCBhc3NvY2lhdGVk
IFJNUiBpbmZvIGFuZCBpbnN0YWxsIGJ5cGFzcyBTTVIKPiAKPiBTaGFtZWVyIEtvbG90aHVtICg4
KToKPiAgICBpb21tdTogSW50cm9kdWNlIGEgY2FsbGJhY2sgdG8gc3RydWN0IGlvbW11X3Jlc3Zf
cmVnaW9uCj4gICAgQUNQSS9JT1JUOiBNYWtlIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lv
bnMoKSByZXR1cm4gdm9pZAo+ICAgIEFDUEkvSU9SVDogUHJvdmlkZSBhIGdlbmVyaWMgaGVscGVy
IHRvIHJldHJpZXZlIHJlc2VydmUgcmVnaW9ucwo+ICAgIEFDUEkvSU9SVDogQWRkIHN1cHBvcnQg
dG8gcmV0cmlldmUgSU9SVCBSTVIgcmVzZXJ2ZWQgcmVnaW9ucwo+ICAgIEFDUEkvSU9SVDogQWRk
IGEgaGVscGVyIHRvIHJldHJpZXZlIFJNUiBpbmZvIGRpcmVjdGx5Cj4gICAgaW9tbXUvYXJtLXNt
bXUtdjM6IEludHJvZHVjZSBzdHJ0YWIgaW5pdCBoZWxwZXIKPiAgICBpb21tdS9hcm0tc21tdS12
MzogUmVmYWN0b3IgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIHRvIGZvcmNlCj4gICAgICBi
eXBhc3MKPiAgICBpb21tdS9hcm0tc21tdS12MzogR2V0IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5k
IGluc3RhbGwgYnlwYXNzIFNURQo+IAo+ICAgZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyAgICAg
ICAgICAgICAgICAgICB8IDM2MCArKysrKysrKysrKysrKysrKystLQo+ICAgZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8ICA3OCArKysrLQo+ICAgZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYyAgICAgICB8ICA1MiArKysKPiAgIGRyaXZlcnMv
aW9tbXUvZG1hLWlvbW11LmMgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiAgIGRyaXZlcnMv
aW9tbXUvaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTYgKy0KPiAgIGluY2x1ZGUv
bGludXgvYWNwaV9pb3J0LmggICAgICAgICAgICAgICAgICAgfCAgMTQgKy0KPiAgIGluY2x1ZGUv
bGludXgvaW9tbXUuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKwo+ICAgNyBmaWxlcyBj
aGFuZ2VkLCA0ODYgaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0pCj4gCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
