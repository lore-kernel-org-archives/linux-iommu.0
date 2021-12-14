Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B70C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 22:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2142814B6;
	Tue, 14 Dec 2021 22:23:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sk3KSK4HXu6o; Tue, 14 Dec 2021 22:23:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 828258186B;
	Tue, 14 Dec 2021 22:23:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 572E0C001E;
	Tue, 14 Dec 2021 22:23:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62C22C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 22:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 503DB60D62
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 22:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SVZBcKl68y3K for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 22:23:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D98360D5D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 22:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7ltI0b0JoVcZQlPxBpV/6VRd7/jkpvA8FH3gp/kiYj/+lAvDIhxul2RnpBCqmnhqs8FIaAl1lfx/3mSpHirINpI5qV8VWBg1qOLs0ySbKQIeRsU/QlDzdOOpKGk8mGTZu+5AugkC5AGkW4g4majVbX95YRP01BSPUiRPjQmyOURA8IUA49yylh2QPAbOYZ6ifl5lPb3/lV0NbllycZF8PC12hD8zIDeczBJ49mvh4ejEM8PmtRnSShGyS6f7gF9DlafKFwNNFtI7BgHSS+XZtG+bXJPWNZ/css7iEW5xv3r1q+MquoEdl9yoOCdRx/ngQmTSvMSoyoQ5mtSYQ3OLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN/ypNYWg4nvC5d/FKiTZuoHDirbOC6eHg1wc8QPtmE=;
 b=TUJDk+1LusvXcLwf9GU1WdpaJLyAViEQhYf0UA+rjjMbMTSJsDB/Umgp1bXdVXxAFK5GVU15nVW/eqB7HJat6Nr9uta7x0lpNS0Yrlgt6QhQv8EhxUQI0n3HuYq9A0CdpTDgEdWb+XswgTYYfqoYyR0jl5Ano2NhWSsKUwZnfwZUnJDjToTEbqLvhEuf/VpdmK0moGWVRwRWyPVx245FS3taBEX2V8f+HIRi9nColagMR61OntxsNpfbURrjLyjPlG5mkjoVt30meKMxlcKkgNtQCA8FoaLBUZ8r6TeYTuxt4Rh/qbhXtws65KBOILJl3DVWMqGHkeu2Bl7EO97/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN/ypNYWg4nvC5d/FKiTZuoHDirbOC6eHg1wc8QPtmE=;
 b=qOGY+Vo5e9Wym6op1aS6gF3Sc6YY1lKOsqCgxTtIZvs/bvqGydlSkgI9mM4+KEf8CKWXAk6vryiOKnh3cVV7z4oJL2ZTnwBNHWzDgHoPEJVNvWdSdpm0zvhkZKAogvVcjOnwqTqOgdMsYXhEz5rl/krnT5qo5r8BviXLJ8ATXko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 14 Dec
 2021 22:23:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Tue, 14 Dec 2021
 22:23:38 +0000
Subject: Re: [PATCH V7 1/5] swiotlb: Add swiotlb bounce buffer remap function
 for HV IVM
To: Dave Hansen <dave.hansen@intel.com>, Tianyu Lan <ltykernel@gmail.com>,
 kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 michael.h.kelley@microsoft.com
References: <20211213071407.314309-1-ltykernel@gmail.com>
 <20211213071407.314309-2-ltykernel@gmail.com>
 <198e9243-abca-b23e-0e8e-8581a7329ede@intel.com>
 <3243ff22-f6c8-b7cd-26b7-6e917e274a7c@gmail.com>
 <c25ff1e8-4d1e-cf1c-a9f6-c189307f92fd@intel.com>
Message-ID: <a1c8f26f-fbf2-29b6-e734-e6d6151c39f8@amd.com>
Date: Tue, 14 Dec 2021 16:23:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <c25ff1e8-4d1e-cf1c-a9f6-c189307f92fd@intel.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:208:237::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by
 MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 14 Dec 2021 22:23:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11af7221-fda9-4a28-deb5-08d9bf505fcb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5072:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5072C7592FF644D706972458EC759@DM4PR12MB5072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/mV53upqhm/I6Fy6wp82xN4BYDZ6QpFL/sxwj0CxD3MNDEH5AhMN63AQT8ixwXoJ0Kp8K9HK3zFEX0sx6F8IkcGfIhCkLz1J8j6fFCW78DXrCR1h7Vub9qxI2/6buaY2QdbTitZ2N5DsAfLPSKnpzJ3jwD04Rjlzf43I//soLNA7fert146FiYxF6WEoQiQNvQ5Hy/ZoIeUwbYlaE3Ycfc9wxub/0rDBkIpLhJHgYbQzCq8yYtoIUJyqo30TmRwzSNSioYLfPycHrJeSfWUjl5xVKyASFMML+YQ1s34AlFIupUvhDqgO+C4RMOVMB+EybPcuHe7RNrinEQB9ih+TFpCCDrigkuLaShiYq6tCgGFfdaybr8clwhedSAghC4nY08GRRDnwxS4oEPQce4bJwtIpicALtMti5wTmmFCv8wcC+FMWbUZTyw1GzAmatyj0S33x4PNiKhwLnHNPZpsOO9nzEGDN84Z3YU6Q06MARMaWN0xe50oQTCgg6SNw2fnUd3xiEeO53MsnqpKue1FMGIFSrSUr6aFni4bWJj21rtsbDgZIHINQOhsnUPqjfdNYRACt/JnDojqLY9fZPMSDXXE0xc7zRsPYiRobUM3nCyoCBtWR9wnlHnVo+D9AXwyLrmdXLao6F00ivLsvvN2wksB/ml/lSrAr+O/LZw/PpfydLlYOt92w20poMos4TqFllRExCkSpOZyTJV5XJKSN0BOtyPBolViNLvg/Ph81q3bh9zfPNG7wvEkD3CHHUsrhC524QvycKHWHRLHeNpfruriuod2v61/lVT6waVFJnpbG1EQoi2PRtL9VaE4pfY5+Jr6L6f9+4cfDjczIIxPFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(31686004)(6486002)(31696002)(921005)(16576012)(508600001)(26005)(36756003)(38100700002)(316002)(66556008)(2616005)(4326008)(2906002)(8936002)(5660300002)(8676002)(7416002)(7406005)(83380400001)(66946007)(86362001)(66476007)(956004)(186003)(966005)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JIV1EvTFkrL2w1Y2c1LzROVVJYWnMvQnRObXk3VUo2bkpTa0xldk43RVcz?=
 =?utf-8?B?TnJSalBZQTFkWmJrazVuSGUrUmljOVdMdDJyZE56RENNV1NSb3lRYkNWNE9S?=
 =?utf-8?B?bnl2cWNYZGZMTVlrZFgweVEwZzYyNkpvcVYrR0EyOXhXdFdEQytUbTVhZ0lG?=
 =?utf-8?B?eW9KVlVQdW5aUFNyMEw1NWZvVS80dGNRZHNwNGhOWEYzOTVUdmJleFVsTGNm?=
 =?utf-8?B?c3piNDRtL3J5WnFQY1ZBV1BubkNHTUl0SVhIMjExdlNSUXFKdWdTRytNM1dC?=
 =?utf-8?B?WG04bSsvZWRJaUZxa2s3NE5kc0RVcERYdXlXcEFVeEZJQzM1SW5ia25nelRC?=
 =?utf-8?B?TmpVdEV2Wm9tM0ZqM3owV3pIalZTM2htbjV2aWV3VmVLRDJLYy9TMGpzZGs2?=
 =?utf-8?B?QUpKaVV0S0p6NlZVdUJMSTdncXMxeDJUbDhoNFhEM2ZDSEhuNFdCd3FSa3pp?=
 =?utf-8?B?SDdLTGoxOWo5VGRRZllXcmpYeTJHZ2RrSFVDSVZIeWh3cGhoczB1NEpOK3kx?=
 =?utf-8?B?UVFZR3NydGlsVlB5ZklEZTBNcFBNSGIrWk5GanBPOVZLemlMM0cybEdFeE92?=
 =?utf-8?B?eHkrRkFMakxDQ2QzeThmS2FZcVR1OUY3dUlGNkxsekZVcTMrdVlwZE56NXhl?=
 =?utf-8?B?RXhSNzR2MEZqM00vU2RmT3k5d25PbDUrc3Z5alJFVFNFL0drbitURzRoa0ZF?=
 =?utf-8?B?ZVcwSkVyVXo4RG9LSE9QTmo4Qm5aTWRQdlkxczJFZjhrSHRYK3pRNGduQUdk?=
 =?utf-8?B?TEUrdGFTV2JjajhhVGhHZVN5RUg1NHNtblp4Nm5rN0t3NkhrdkhTbDByWGlv?=
 =?utf-8?B?TGZ6U2QrV2g3U3JSWTRXeEw4WnVZOTRwUzhlRTA5cmRKaHh2RXEybzlza2t3?=
 =?utf-8?B?THRoMHBRcGFRbDQ1cnhEc0JLSWs2dzVsbjJTUytxcEE4TUsyRm5ROWYzTjg1?=
 =?utf-8?B?Ni9SWVlsd2RzN2NFNktzbUt1ZnpwRGhTMVVmQWF6bVVkbVIvZ0hLeit4QVNE?=
 =?utf-8?B?djY3M3N0bnZUYjhmaEtZOE5Bc0hPYlJuRjh5V3JjRkZ4OFNSK3FRUFZIM3Q1?=
 =?utf-8?B?WVl6SEVBRTZVeURvMktaUFk1YzFiWlZwT1NlWUxiYTg5YTRwMWErM2NhTlhP?=
 =?utf-8?B?K1FRQlR4bEw3ZUhSYmVjVmpadlVaSitaY21oQy9TTFk1T3FURDVhbzYyRWF0?=
 =?utf-8?B?ZlI3MmRvdWRpUnJwNUs5cGZUSW1Idkc5TENKZkU0clVzNzl0U1g3cjRvUnZD?=
 =?utf-8?B?ZnhEdWF4dnJkWTVOZVdTY2FBaHdWN1hGcWhRM0k4eVhxNGpaWmlvZ0xaQThw?=
 =?utf-8?B?S3dPNFNVaFMwcWczUyswWVBRZjl0YURzaC9lTUJDT2JYNXNFNENkK1lCcS81?=
 =?utf-8?B?S3A3eFhlM1g1TjhqRzB3Z3Zpb2daM1JSR3FyNm55ZHdwVmw1MmFVSHB6dTZk?=
 =?utf-8?B?ZDJncFNmaWhYSWxUNkIwd1UxalUyNWovZnE5ZE93OUtLQ29RMnpUZUxEZW1M?=
 =?utf-8?B?eFYySExzWnhsTm10TWwvcmgzdWFVcXBLSW1OaWVDbmd3a1ZQRUloNHMrcFhP?=
 =?utf-8?B?eDQ1amlTbEZOSDN4bTJVdGl5RVZhRzZ4TTRpQzlYZGFzZHViTHAvUy9Odnhm?=
 =?utf-8?B?RVErdFVXaDMrb0IxdlVlb3orQ1JrNjREY3U4ZENKdWx3eUt4aGc0d0hsOWZy?=
 =?utf-8?B?N2VTMWx3eHV4RTNrMVlOaGpBSHlEc2pKdGRwNTRjZGtsWWd3YlVnZmM5MWxB?=
 =?utf-8?B?MWMzdmt6dkFkQjQrcVZJZ0dxSXJLNjAzL292b1RJYWwvOEN3OXFuVHpyRnRo?=
 =?utf-8?B?blJ6b0E2a1NTSnBTZCs5QjZwRlo4WWJnbCszUmI4eVUvL2hNeHRIaGJ6YS8r?=
 =?utf-8?B?OEdkSVkzT2VkeURncVJHMHE5MmhKZWdMVjNXOWo1emZOcXpzeG4wSDBBWG1m?=
 =?utf-8?B?SG8wZjJGV0tPN1ZJQXUxOXRBUWtoamVUaFZNUTQrREJKTXB3cmhXYVpmZThK?=
 =?utf-8?B?ZlRXNC84TlZhd3RodjBwSUMwUkE4OEFKeG9SaVBYVkdOa0NpNjFyWVVwaHdR?=
 =?utf-8?B?K01tczgvdFJlOElOa1Z4YTFpTWFyeTJrdlc3STlCd1BaSVdIaXU1bGFJditi?=
 =?utf-8?B?UVBMUGpXS3JIelZBaUk5NkNqVGVtWHZkVnJPbloySFovSyt0dG5mc05zK1N0?=
 =?utf-8?Q?j+vegUo3YzjtqluI8BKssHg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11af7221-fda9-4a28-deb5-08d9bf505fcb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 22:23:37.9402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trOwXHynVzJyIwVe5uejfFp/vUHp26bayatLp18EF4QxWNEGbel+3XJXuR+KNBwDrgUHz/siKO2IsBMNNs9n3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, hch@lst.de
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTIvMTQvMjEgMTI6NDAgUE0sIERhdmUgSGFuc2VuIHdyb3RlOgo+IE9uIDEyLzEzLzIxIDg6
MzYgUE0sIFRpYW55dSBMYW4gd3JvdGU6Cj4+IE9uIDEyLzE0LzIwMjEgMTI6NDUgQU0sIERhdmUg
SGFuc2VuIHdyb3RlOgo+Pj4gT24gMTIvMTIvMjEgMTE6MTQgUE0sIFRpYW55dSBMYW4gd3JvdGU6
Cj4+Pj4gSW4gSXNvbGF0aW9uIFZNIHdpdGggQU1EIFNFViwgYm91bmNlIGJ1ZmZlciBuZWVkcyB0
byBiZSBhY2Nlc3NlZCB2aWEKPj4+PiBleHRyYSBhZGRyZXNzIHNwYWNlIHdoaWNoIGlzIGFib3Zl
IHNoYXJlZF9ncGFfYm91bmRhcnkgKEUuRyAzOSBiaXQKPj4+PiBhZGRyZXNzIGxpbmUpIHJlcG9y
dGVkIGJ5IEh5cGVyLVYgQ1BVSUQgSVNPTEFUSU9OX0NPTkZJRy4gVGhlIGFjY2Vzcwo+Pj4+IHBo
eXNpY2FsIGFkZHJlc3Mgd2lsbCBiZSBvcmlnaW5hbCBwaHlzaWNhbCBhZGRyZXNzICsKPj4+PiBz
aGFyZWRfZ3BhX2JvdW5kYXJ5Lgo+Pj4+IFRoZSBzaGFyZWRfZ3BhX2JvdW5kYXJ5IGluIHRoZSBB
TUQgU0VWIFNOUCBzcGVjIGlzIGNhbGxlZCB2aXJ0dWFsIHRvcCBvZgo+Pj4+IG1lbW9yeSh2VE9N
KS4gTWVtb3J5IGFkZHJlc3NlcyBiZWxvdyB2VE9NIGFyZSBhdXRvbWF0aWNhbGx5IHRyZWF0ZWQg
YXMKPj4+PiBwcml2YXRlIHdoaWxlIG1lbW9yeSBhYm92ZSB2VE9NIGlzIHRyZWF0ZWQgYXMgc2hh
cmVkLgo+Pj4KPj4+IFRoaXMgc2VlbXMgdG8gYmUgaW5kZXBlbmRlbnRseSByZWludHJvZHVjaW5n
IHNvbWUgb2YgdGhlIFNFVgo+Pj4gaW5mcmFzdHJ1Y3R1cmUuwqAgSXMgaXQgcmVhbGx5IE9LIHRo
YXQgdGhpcyBkb2Vzbid0IGludGVyYWN0IGF0IGFsbCB3aXRoCj4+PiBhbnkgZXhpc3RpbmcgU0VW
IGNvZGU/Cj4+Pgo+Pj4gRm9yIGluc3RhbmNlLCBkbyB3ZSBuZWVkIGEgbmV3ICdzd2lvdGxiX3Vu
ZW5jcnlwdGVkX2Jhc2UnLCBvciBzaG91bGQKPj4+IHRoaXMganVzdCBiZSB1c2luZyBzbWVfbWVf
bWFzayBzb21laG93Pwo+Pgo+PiAgwqDCoMKgwqDCoMKgIFRoYW5rcyBmb3IgeW91ciByZXZpZXcu
IEh5cGVyLVYgcHJvdmlkZXMgYSBwYXJhLXZpcnR1YWxpemVkCj4+IGNvbmZpZGVudGlhbCBjb21w
dXRpbmcgc29sdXRpb24gYmFzZWQgb24gdGhlIEFNRCBTRVYgZnVuY3Rpb24gYW5kIG5vdAo+PiBl
eHBvc2Ugc2V2JnNtZSBjYXBhYmlsaXRpZXMgdG8gZ3Vlc3QuIFNvIHNtZV9tZV9tYXNrIGlzIHVu
c2V0IGluIHRoZQo+PiBIeXBlci1WIElzb2xhdGlvbiBWTS4gc3dpb3RsYl91bmVuY3J5cHRlZF9i
YXNlIGlzIG1vcmUgZ2VuZXJhbCBzb2x1dGlvbgo+PiB0byBoYW5kbGUgc3VjaCBjYXNlIG9mIGRp
ZmZlcmVudCBhZGRyZXNzIHNwYWNlIGZvciBlbmNyeXB0ZWQgYW5kCj4+IGRlY3J5cHRlZCBtZW1v
cnkgYW5kIG90aGVyIHBsYXRmb3JtIGFsc28gbWF5IHJldXNlIGl0Lgo+IAo+IEkgZG9uJ3QgcmVh
bGx5IHVuZGVyc3RhbmQgaG93IHRoaXMgY2FuIGJlIG1vcmUgZ2VuZXJhbCBhbnkgKm5vdCogZ2V0
Cj4gdXRpbGl6ZWQgYnkgdGhlIGV4aXN0aW5nIFNFViBzdXBwb3J0LgoKVGhlIFZpcnR1YWwgVG9w
LW9mLU1lbW9yeSAoVlRPTSkgc3VwcG9ydCBpcyBhbiBTRVYtU05QIGZlYXR1cmUgdGhhdCBpcyAK
bWVhbnQgdG8gYmUgdXNlZCB3aXRoIGEgKHJlbGF0aXZlbHkpIHVuLWVubGlnaHRlbmVkIGd1ZXN0
LiBUaGUgaWRlYSBpcyAKdGhhdCB0aGUgQy1iaXQgaW4gdGhlIGd1ZXN0IHBhZ2UgdGFibGVzIG11
c3QgYmUgMCBmb3IgYWxsIGFjY2Vzc2VzLiBJdCBpcyAKb25seSB0aGUgcGh5c2ljYWwgYWRkcmVz
cyByZWxhdGl2ZSB0byBWVE9NIHRoYXQgZGV0ZXJtaW5lcyBpZiB0aGUgYWNjZXNzIAppcyBlbmNy
eXB0ZWQgb3Igbm90LiBTbyBzZXR0aW5nIHNtZV9tZV9tYXNrIHdpbGwgYWN0dWFsbHkgY2F1c2Ug
aXNzdWVzIAp3aGVuIHJ1bm5pbmcgd2l0aCB0aGlzIGZlYXR1cmUuIFNpbmNlIGFsbCBETUEgZm9y
IGFuIFNFVi1TTlAgZ3Vlc3QgbXVzdCAKc3RpbGwgYmUgdG8gc2hhcmVkICh1bmVuY3J5cHRlZCkg
bWVtb3J5LCBzb21lIGVubGlnaHRlbm1lbnQgaXMgbmVlZGVkLiBJbiAKdGhpcyBjYXNlLCBtZW1v
cnkgbWFwcGVkIGFib3ZlIFZUT00gd2lsbCBwcm92aWRlIHRoYXQgdmlhIHRoZSBTV0lPVExCIAp1
cGRhdGUuIEZvciBTRVYtU05QIGd1ZXN0cyBydW5uaW5nIHdpdGggVlRPTSwgdGhleSBhcmUgbGlr
ZWx5IHRvIGFsc28gYmUgCnJ1bm5pbmcgd2l0aCB0aGUgUmVmbGVjdCAjVkMgZmVhdHVyZSwgYWxs
b3dpbmcgYSAicGFyYXZpc29yIiB0byBoYW5kbGUgYW55IAojVkNzIGdlbmVyYXRlZCBieSB0aGUg
Z3Vlc3QuCgpTZWUgc2VjdGlvbnMgMTUuMzYuOCAiVmlydHVhbCBUb3Atb2YtTWVtb3J5IiBhbmQg
MTUuMzYuOSAiUmVmbGVjdCAjVkMiIGluIAp2b2x1bWUgMiBvZiB0aGUgQU1EIEFQTSBbMV0uCgpJ
J20gbm90IHN1cmUgaWYgdGhhdCB3aWxsIGFuc3dlciB5b3VyIHF1ZXN0aW9uIG9yIGdlbmVyYXRl
IG1vcmUgOikKClRoYW5rcywKVG9tCgpbMV0gaHR0cHM6Ly93d3cuYW1kLmNvbS9zeXN0ZW0vZmls
ZXMvVGVjaERvY3MvMjQ1OTMucGRmCgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
