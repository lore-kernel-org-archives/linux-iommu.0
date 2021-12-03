Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17EAC433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 20:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45D3360BC2;
	Fri,  3 Dec 2021 20:07:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Df5ie4293YSK; Fri,  3 Dec 2021 20:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 38B9460BC3;
	Fri,  3 Dec 2021 20:07:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10750C001E;
	Fri,  3 Dec 2021 20:07:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 555D3C0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 20:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B99F404CD
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 20:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wXFCG5FO_pwl for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 20:07:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6E0340017
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 20:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWdLt9Du38kEfy+ZifqRZ0BbExQJ0JqFhGZGtflLSZpRvaGEiVj3E6ui81fZtSU5NV8RJOqhD7oHWbPzNZ40QqjSJ3LRqcLz4CTSUZsgIPRk8319c8Tyu5w6p6MJEE9lytkmbym8LeNaJcU0O51Gk52cmzB1pPj+Cd8zsSrZyGDWSOGf/XK24DW6sKSTI1PAWrrYV58L6hbTA8VtzVcjBn7xC0eHJw2s/2xzOOJo2DZOOscAfrB5i2U/rCQeceb9pLC2C+O4R0C8h4NOM7R+gYfcjqtJUXNFn+79bqYl+EDYUC3jabySlcXPhG7Hvpi1iBJ4JE7mhZYTvwDitZWSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU7G+ZiaWrsg+p7MM9oMcVNwq3c0SZRE6z6LspM1vKA=;
 b=fhS71m0B1eSNcWNeVIym6bYyLZhYCd07WLuvrBOtFhFnsXoq6res7GochKz9dmCTXTg3M2Fi5EAt/9MxIcDeaIB0KVbtfLilmtq6PDml5v6sklTj2qwqHUaDVs1DRcvicYqRbbFa+UuwPBmDo1yJjNR5WYqHPinj+wPQxsNY7Qy1UZdU1uJl3rQg2I2kLurzDptnveN2yIIq7d/ZMT7otskoD05AXHoxVvwVujTWjGSW8mMVBZg7haBc53UsmYpzNGYopWFjMR7lDfC/fOVukiVE7JXKE2YRHu2VLKVGJilAHYm4u2GZ20+BrqQxTzC3HXLR9E2UBZ4NcEe1+8SWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU7G+ZiaWrsg+p7MM9oMcVNwq3c0SZRE6z6LspM1vKA=;
 b=D8lmOURMOLEy5n1O1VpgG7PBLINbz5CbTx9hrG1dABsPmaqaCjF7b0oDXHR6TolLODpB4miIleymZVg/bACcvPDHKvlWPBeXasuGZkOd5X2Piyh6n/TYdhF5kH13+zfDvnzsr16ZN3Q5zbJEbINHQZRQzVYp3cPjlmwAAxYq7M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 20:07:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 20:07:02 +0000
Subject: Re: [PATCH V3 1/5] Swiotlb: Add Swiotlb bounce buffer remap function
 for HV IVM
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jgross@suse.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-2-ltykernel@gmail.com>
 <41bb0a87-9fdb-4c67-a903-9e87d092993a@amd.com>
 <e78ba239-2dad-d48f-671e-f76a943052f1@gmail.com>
 <06faf04c-dc4a-69fd-0be9-04f57f779ffe@amd.com>
Message-ID: <1b7b8e20-a861-ab26-26a1-dad1eb80a461@amd.com>
Date: Fri, 3 Dec 2021 14:06:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <06faf04c-dc4a-69fd-0be9-04f57f779ffe@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SN6PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:805:ca::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by
 SN6PR16CA0051.namprd16.prod.outlook.com (2603:10b6:805:ca::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 20:06:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd0dd4e-1914-4c16-3f9c-08d9b698784c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5070F11FF25976AA7BF5A2A9EC6A9@DM4PR12MB5070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1WNw3gw4sfxpai0SCYeyLMCLThQbioDmSsgisuE3MtWeyEiUaoAAxqFmr/0PFnseMEaMaI8MxYD4Vh7wBVYBC8K72RXfAhwHunGXZpjvNF2dVRsfA+aBE9KbYqOvnDF1/UkF5qxik975l/HnWWxdxoxnQ7czlUdmdAGH8DwPb5Acf5CyHhiFSC0Plvx1mMkXA5CChp2++XnS1/ILz1zlEUqE1bsZz0uYvt3KIp63T2VtAbjmlQxNMK7J0FFVlRRWgsEJop205ZwxVjjx9jfQPuyVOF/Onv319UGWcDlk8jxcQnaMsynX7w+OnL+yV8GcJpGHd4QrHRLznSWbKux0BcDU64OF0tSKFCR0dGuhLv6I9VXTYyZwuwfr33owb+so4+o7osKduHkjgdI0vt7dLmXyx4rwYcFPxksnSGvWs+iSjj2Um73H6dl+49+f00NCOWiDcYluudYZ5bDmO/syt4LT2N2lWi1cZPdC1ctzgWTX8/ztpvBxQG0A5k0det4AMuCrOn41yR06f2QWThLvoXiaulYZobBByhb+VWfnAXYT1t3e0/unNchZ6VdS0KPR3H5IuV49cI6Pk+FhNQ64i4xaWhANAss0YNT6rGqLrTHlQLFyV+6GcK96vPmF15fGL7An5X5lfYVAEW7n9TZzmyu12WR+sHCgK7KbVBUrFVsTlWNzpdVV9mSgSllUr8O/Tvwc9S45RvSE8kZD/7pvxhcxQrASK2wDTIN/z9yFarWhHZOJ7XnJWZsJIt0JqI5WhTVtFx07mR1mvVNvg1oeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(4326008)(31696002)(921005)(38100700002)(6512007)(36756003)(86362001)(8676002)(186003)(2616005)(5660300002)(7406005)(7416002)(956004)(31686004)(66556008)(6506007)(53546011)(66476007)(66946007)(8936002)(2906002)(45080400002)(6486002)(26005)(508600001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anNOVERHVG5TTGR0emFJM203UWprTXVTM01zSVdUa00wWnJ4Um9UamEwSjZP?=
 =?utf-8?B?UHdwcWtJR0ZiMFVOTnp4TzhNWGxXNkU4YytSRVE0ZlR6Sml2Z0lBdVFQR1hx?=
 =?utf-8?B?SlRxV3NvdEl4SUttWmFnNGVGTGtnbVBiVTM5NlNWeFc3MnNXdzRCbHYwYXpB?=
 =?utf-8?B?UU1aZC8xNm1jYnJoOUtsa3FIeGJ5ZTNyclhnd01TbVlEQ2ROQU4wb1l2dERR?=
 =?utf-8?B?ZStVTnN5ejJxT2k3aGxVcjY2TXNNOEVjRzZHY3VveXpjZUVxQ0RPVTJrWTB6?=
 =?utf-8?B?TEVxS2pGWk5PK2R1a1VjditxT1NvMzVQazd4SXpUd092cVNIZ1MvaFJXYnNs?=
 =?utf-8?B?MnlVSnprT3VWSG52V0w1Z0w0R0ZOZG9nMmVFaDhnV2czSDljTWsyTkRXZm1z?=
 =?utf-8?B?dUFhSWRxSnhza2E1OTJZbW9OeHJxZ0gyUDhnWkIyZFpwbUR1VGdOdktBQ1RS?=
 =?utf-8?B?NGZiQlRnZ3hsdXdwY3NTeVRValZZd0ZZcjFYZ2RHNng4dUtHaU9saVlWY2NC?=
 =?utf-8?B?SWhUVjNENXJlYlNaWXcvaTVkSytFTGxDNnNnYzBmdUdaVGQxMFBRVmQ5VDY4?=
 =?utf-8?B?RmhDOWI5Q0F4RU5iUDc4bVRVN21UWFpYM2lBUmpQZzhLbmNIRmd4YzJnWk9M?=
 =?utf-8?B?Yk5UVXkzNCthVndJUkdzcWF1Lzh2S3J1MGN6ZFl2bEMwWXgrMkQ3dUd0VnB2?=
 =?utf-8?B?NFM0K2xyZjlkOWZhTWptczVjWDBMdjBBTVphSTVudDFrMDJqUS95MXI5SjBn?=
 =?utf-8?B?MS8vVkEzWVMxZ2FrdzdQSEpKNFRwQ1Q5TktOdG1GRUdkMCtwbUJKRHlUUmVW?=
 =?utf-8?B?MjJkLzlNWm9tRWZBZjVvSEZvZHdyNW9MUWo1VnpNU2llYlBGUk8zTTlHUWti?=
 =?utf-8?B?dUllYlk5WGpqQ0doK3FyYWFTdURMMTMrcUcvNUJqeEVDdGtpeFNVTU44SUdB?=
 =?utf-8?B?eVhONmNjd0wyNm1rR1hnUVNhUmVYZjQ1Uk1aRnF1aG5iZVU3WWUzQ0wzUjd0?=
 =?utf-8?B?ZExES2ZuUFk4ME9GT1lpa2p5OU1oWE50UklxSDBmenVGWW11eUhjcDNoZDdS?=
 =?utf-8?B?RzhCcVB6VENDSWRPeDQzZ2N2NnlKKzFzSTNkaW9sNGp6cEtQdnNjNWU4YnBU?=
 =?utf-8?B?UDhwbUxwNmFQb1pkTm0vaSs4R3pjZ0xyM25ZMXdtYTNsdFArQkJUazVjaGwx?=
 =?utf-8?B?WFNPc3ZEbFJIUzk5UDllZ0wyb0pEYUdHRmdFN2JLMGlwengxcmtMOEc5Z3Ja?=
 =?utf-8?B?K1E1RWtIK2JjTEE2ZEM4bjNvdDU2eU9KM3VHeUZ1U1lDL09BWHZEUFlQUEVm?=
 =?utf-8?B?UldzbmJEOGlrUFBFT2NFUWpFK1k3TFQwb1lhcnVWcWhDL0l5b1FEZ21TM2po?=
 =?utf-8?B?SnlTVk5nL2lPdVBDVm13YW1YZnJJZk5XOERadmJpM3M2YVMrY3NYK0IrdU9D?=
 =?utf-8?B?aTY3cDFMY2hLS1JWdkQ2S05CZzY0ak9XSmVtUDZURnh2Rm50d0VOS0FoYWVQ?=
 =?utf-8?B?MVUzbGg3Q0xnNjZKK0s4d2FCblNIaDhRS0t3YWt4QVZRN1BnMWYyWmEyUVFZ?=
 =?utf-8?B?eHU2cEpoUDRsTElnNkY4Ry9WY3lZc0kzWEJmNnRoMk1aUytxeStubG1DZlI3?=
 =?utf-8?B?VHAxeC9yZWdKZDVNc3Y4ZzV0UTVCUWhPMlgwcjlCclZxUlB2T0hLTVRWTWp6?=
 =?utf-8?B?UkQ3RkVnNnR5UXRIeHBBMktaczJNRjBZZkNrRmVBa3lDMGdqY25sNWg3MEFB?=
 =?utf-8?B?QXNtQ0s0b1FVbG8zSGNJNVJ0THNZUDZYT2xXTnZUY29lZUI0UWxGTHY0K3hS?=
 =?utf-8?B?T0tqUmEwTDBDV3N3RFR2azd1RHpzTks4SFBnOEx3cldPa0hPZTNCZ0NmbnJR?=
 =?utf-8?B?Z09mM0FMb3dkL2dXbE5VZDRGTTRoR3hwL2pWV1BCTmpDRjVWdFlaUmpJOGN1?=
 =?utf-8?B?bW0wSGVIc2JJc1lHYXdDM2pLUTgvdlZEbzh6ZWkwUG9zeW95UHhqSkY3aDk0?=
 =?utf-8?B?dm83ODl0YWYrcjF6SUJTWTJxUnBjMXZySkZmWGJVbXhleWl4dnJCT2ZPSDJN?=
 =?utf-8?B?RklRUjZuVnlxNE5XQjFRUjZmL21BK040dWpwQmIrNXpxY3hBcFZweUdqOW1F?=
 =?utf-8?B?aEltay92RzV4dUNhd2lMZDA2QlVHNG5QRnZVQ3U4dmZaM1JXbWhIL3Z3eEpQ?=
 =?utf-8?Q?iAy2VZ1220VEuoGkCOuhywE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd0dd4e-1914-4c16-3f9c-08d9b698784c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 20:07:02.1054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNFDqGR43QFLZPhB63ocWTL6UWhWK+2BmgzGd4pfDMYVnGmtlXQNiWgVo2GTMo0Lkzq5sI8C7GcF6s1/lkSayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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

T24gMTIvMy8yMSAxOjExIFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4gT24gMTIvMy8yMSA1OjIw
IEFNLCBUaWFueXUgTGFuIHdyb3RlOgo+PiBPbiAxMi8yLzIwMjEgMTA6NDIgUE0sIFRvbSBMZW5k
YWNreSB3cm90ZToKPj4+IE9uIDEyLzEvMjEgMTA6MDIgQU0sIFRpYW55dSBMYW4gd3JvdGU6Cj4+
Pj4gRnJvbTogVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBtaWNyb3NvZnQuY29tPgo+Pj4+Cj4+Pj4g
SW4gSXNvbGF0aW9uIFZNIHdpdGggQU1EIFNFViwgYm91bmNlIGJ1ZmZlciBuZWVkcyB0byBiZSBh
Y2Nlc3NlZCB2aWEKPj4+PiBleHRyYSBhZGRyZXNzIHNwYWNlIHdoaWNoIGlzIGFib3ZlIHNoYXJl
ZF9ncGFfYm91bmRhcnkgKEUuRyAzOSBiaXQKPj4+PiBhZGRyZXNzIGxpbmUpIHJlcG9ydGVkIGJ5
IEh5cGVyLVYgQ1BVSUQgSVNPTEFUSU9OX0NPTkZJRy4gVGhlIGFjY2Vzcwo+Pj4+IHBoeXNpY2Fs
IGFkZHJlc3Mgd2lsbCBiZSBvcmlnaW5hbCBwaHlzaWNhbCBhZGRyZXNzICsgc2hhcmVkX2dwYV9i
b3VuZGFyeS4KPj4+PiBUaGUgc2hhcmVkX2dwYV9ib3VuZGFyeSBpbiB0aGUgQU1EIFNFViBTTlAg
c3BlYyBpcyBjYWxsZWQgdmlydHVhbCB0b3Agb2YKPj4+PiBtZW1vcnkodlRPTSkuIE1lbW9yeSBh
ZGRyZXNzZXMgYmVsb3cgdlRPTSBhcmUgYXV0b21hdGljYWxseSB0cmVhdGVkIGFzCj4+Pj4gcHJp
dmF0ZSB3aGlsZSBtZW1vcnkgYWJvdmUgdlRPTSBpcyB0cmVhdGVkIGFzIHNoYXJlZC4KPj4+Pgo+
Pj4+IEV4cG9zZSBzd2lvdGxiX3VuZW5jcnlwdGVkX2Jhc2UgZm9yIHBsYXRmb3JtcyB0byBzZXQg
dW5lbmNyeXB0ZWQKPj4+PiBtZW1vcnkgYmFzZSBvZmZzZXQgYW5kIHBsYXRmb3JtIGNhbGxzIHN3
aW90bGJfdXBkYXRlX21lbV9hdHRyaWJ1dGVzKCkKPj4+PiB0byByZW1hcCBzd2lvdGxiIG1lbSB0
byB1bmVuY3J5cHRlZCBhZGRyZXNzIHNwYWNlLiBtZW1yZW1hcCgpIGNhbgo+Pj4+IG5vdCBiZSBj
YWxsZWQgaW4gdGhlIGVhcmx5IHN0YWdlIGFuZCBzbyBwdXQgcmVtYXBwaW5nIGNvZGUgaW50bwo+
Pj4+IHN3aW90bGJfdXBkYXRlX21lbV9hdHRyaWJ1dGVzKCkuIFN0b3JlIHJlbWFwIGFkZHJlc3Mg
YW5kIHVzZSBpdCB0byBjb3B5Cj4+Pj4gZGF0YSBmcm9tL3RvIHN3aW90bGIgYm91bmNlIGJ1ZmZl
ci4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFRpYW55dSBMYW4gPFRpYW55dS5MYW5AbWljcm9z
b2Z0LmNvbT4KPj4+Cj4+PiBUaGlzIHBhdGNoIHJlc3VsdHMgaW4gdGhlIGZvbGxvd2luZyBzdGFj
ayB0cmFjZSBkdXJpbmcgYSBiYXJlLW1ldGFsIGJvb3QKPj4+IG9uIG15IEVQWUMgc3lzdGVtIHdp
dGggU01FIGFjdGl2ZSAoZS5nLiBtZW1fZW5jcnlwdD1vbik6Cj4+Pgo+Pj4gW8KgwqDCoCAwLjEy
MzkzMl0gQlVHOiBCYWQgcGFnZSBzdGF0ZSBpbiBwcm9jZXNzIHN3YXBwZXLCoCBwZm46MTA4MDAx
Cj4+PiBbwqDCoMKgIDAuMTIzOTQyXSBwYWdlOihfX19fcHRydmFsX19fXykgcmVmY291bnQ6MCBt
YXBjb3VudDotMTI4IAo+Pj4gbWFwcGluZzowMDAwMDAwMDAwMDAwMDAwIGluZGV4OjB4MCBwZm46
MHgxMDgwMDEKPj4+IFvCoMKgwqAgMC4xMjM5NDZdIGZsYWdzOiAweDE3ZmZmZmMwMDAwMDAwKG5v
ZGU9MHx6b25lPTJ8bGFzdGNwdXBpZD0weDFmZmZmZikKPj4+IFvCoMKgwqAgMC4xMjM5NTJdIHJh
dzogMDAxN2ZmZmZjMDAwMDAwMCBmZmZmODg5MDRmMmQ1ZTgwIGZmZmY4ODkwNGYyZDVlODAgCj4+
PiAwMDAwMDAwMDAwMDAwMDAwCj4+PiBbwqDCoMKgIDAuMTIzOTU0XSByYXc6IDAwMDAwMDAwMDAw
MDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMGZmZmZmZjdmIAo+Pj4gMDAwMDAwMDAwMDAw
MDAwMAo+Pj4gW8KgwqDCoCAwLjEyMzk1NV0gcGFnZSBkdW1wZWQgYmVjYXVzZTogbm9uemVybyBt
YXBjb3VudAo+Pj4gW8KgwqDCoCAwLjEyMzk1N10gTW9kdWxlcyBsaW5rZWQgaW46Cj4+PiBbwqDC
oMKgIDAuMTIzOTYxXSBDUFU6IDAgUElEOiAwIENvbW06IHN3YXBwZXIgTm90IHRhaW50ZWQgCj4+
PiA1LjE2LjAtcmMzLXNvcy1jdXN0b20gIzIKPj4+IFvCoMKgwqAgMC4xMjM5NjRdIEhhcmR3YXJl
IG5hbWU6IEFNRCBDb3Jwb3JhdGlvbgo+Pj4gW8KgwqDCoCAwLjEyMzk2N10gQ2FsbCBUcmFjZToK
Pj4+IFvCoMKgwqAgMC4xMjM5NzFdwqAgPFRBU0s+Cj4+PiBbwqDCoMKgIDAuMTIzOTc1XcKgIGR1
bXBfc3RhY2tfbHZsKzB4NDgvMHg1ZQo+Pj4gW8KgwqDCoCAwLjEyMzk4NV3CoCBiYWRfcGFnZS5j
b2xkKzB4NjUvMHg5Ngo+Pj4gW8KgwqDCoCAwLjEyMzk5MF3CoCBfX2ZyZWVfcGFnZXNfb2srMHgz
YTgvMHg0MTAKPj4+IFvCoMKgwqAgMC4xMjM5OTZdwqAgbWVtYmxvY2tfZnJlZV9hbGwrMHgxNzEv
MHgxZGMKPj4+IFvCoMKgwqAgMC4xMjQwMDVdwqAgbWVtX2luaXQrMHgxZi8weDE0Ygo+Pj4gW8Kg
wqDCoCAwLjEyNDAxMV3CoCBzdGFydF9rZXJuZWwrMHgzYjUvMHg2YTEKPj4+IFvCoMKgwqAgMC4x
MjQwMTZdwqAgc2Vjb25kYXJ5X3N0YXJ0dXBfNjRfbm9fdmVyaWZ5KzB4YjAvMHhiYgo+Pj4gW8Kg
wqDCoCAwLjEyNDAyMl3CoCA8L1RBU0s+Cj4+Pgo+Pj4gSSBzZWUgfjQwIG9mIHRoZXNlIHRyYWNl
cywgZWFjaCBmb3IgZGlmZmVyZW50IHBmbnMuCj4+Pgo+Pj4gVGhhbmtzLAo+Pj4gVG9tCj4+Cj4+
IEhpIFRvbToKPj4gwqDCoMKgwqDCoMKgIFRoYW5rcyBmb3IgeW91ciB0ZXN0LiBDb3VsZCB5b3Ug
aGVscCB0byB0ZXN0IHRoZSBmb2xsb3dpbmcgcGF0Y2ggCj4+IGFuZCBjaGVjayB3aGV0aGVyIGl0
IGNhbiBmaXggdGhlIGlzc3VlLgo+IAo+IFRoZSBwYXRjaCBpcyBtYW5nbGVkLiBJcyB0aGUgb25s
eSBkaWZmZXJlbmNlIHdoZXJlIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgCj4gaXMgY2FsbGVkPwoK
SSBkZS1tYW5nbGVkIHRoZSBwYXRjaC4gTm8gbW9yZSBzdGFjayB0cmFjZXMgd2l0aCBTTUUgYWN0
aXZlLgoKVGhhbmtzLApUb20KCj4gCj4gVGhhbmtzLAo+IFRvbQo+IAo+Pgo+Pgo+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9zd2lvdGxiLmggYi9pbmNsdWRlL2xpbnV4L3N3aW90bGIuaAo+
PiBpbmRleCA1NjkyNzI4NzEzNzUuLmY2YzM2MzgyNTVkNSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9zd2lvdGxiLmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9zd2lvdGxiLmgKPj4gQEAg
LTczLDYgKzczLDkgQEAgZXh0ZXJuIGVudW0gc3dpb3RsYl9mb3JjZSBzd2lvdGxiX2ZvcmNlOwo+
PiDCoMKgICogQGVuZDrCoMKgwqDCoMKgwqAgVGhlIGVuZCBhZGRyZXNzIG9mIHRoZSBzd2lvdGxi
IG1lbW9yeSBwb29sLiBVc2VkIHRvIGRvIAo+PiBhIHF1aWNrCj4+IMKgwqAgKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByYW5nZSBjaGVjayB0byBzZWUgaWYgdGhlIG1lbW9yeSB3YXMgaW4gZmFj
dCBhbGxvY2F0ZWQgCj4+IGJ5IHRoaXMKPj4gwqDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEFQSS4KPj4gKyAqIEB2YWRkcjrCoMKgwqDCoCBUaGUgdmFkZHIgb2YgdGhlIHN3aW90bGIgbWVt
b3J5IHBvb2wuIFRoZSBzd2lvdGxiIG1lbW9yeSAKPj4gcG9vbAo+PiArICrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbWF5IGJlIHJlbWFwcGVkIGluIHRoZSBtZW1vcnkgZW5jcnlwdGVkIGNhc2Ug
YW5kIHN0b3JlIAo+PiB2aXJ0dWFsCj4+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRy
ZXNzIGZvciBib3VuY2UgYnVmZmVyIG9wZXJhdGlvbi4KPj4gwqDCoCAqIEBuc2xhYnM6wqDCoMKg
IFRoZSBudW1iZXIgb2YgSU8gVExCIGJsb2NrcyAoaW4gZ3JvdXBzIG9mIDY0KSBiZXR3ZWVuIAo+
PiBAc3RhcnQgYW5kCj4+IMKgwqAgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBAZW5kLiBGb3Ig
ZGVmYXVsdCBzd2lvdGxiLCB0aGlzIGlzIGNvbW1hbmQgbGluZSAKPj4gYWRqdXN0YWJsZSB2aWEK
Pj4gwqDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNldHVwX2lvX3RsYl9ucGFnZXMuCj4+
IEBAIC05Miw2ICs5NSw3IEBAIGV4dGVybiBlbnVtIHN3aW90bGJfZm9yY2Ugc3dpb3RsYl9mb3Jj
ZTsKPj4gwqDCoHN0cnVjdCBpb190bGJfbWVtIHsKPj4gwqDCoMKgwqDCoMKgwqDCoCBwaHlzX2Fk
ZHJfdCBzdGFydDsKPj4gwqDCoMKgwqDCoMKgwqDCoCBwaHlzX2FkZHJfdCBlbmQ7Cj4+ICvCoMKg
wqDCoMKgwqAgdm9pZCAqdmFkZHI7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBu
c2xhYnM7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyB1c2VkOwo+PiDCoMKgwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIGludCBpbmRleDsKPj4gQEAgLTE4Niw0ICsxOTAsNiBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgaXNfc3dpb3RsYl9mb3JfYWxsb2Moc3RydWN0IAo+PiBkZXZpY2UgKmRl
dikKPj4gwqDCoH0KPj4gwqDCoCNlbmRpZiAvKiBDT05GSUdfRE1BX1JFU1RSSUNURURfUE9PTCAq
Lwo+Pgo+PiArZXh0ZXJuIHBoeXNfYWRkcl90IHN3aW90bGJfdW5lbmNyeXB0ZWRfYmFzZTsKPj4g
Kwo+PiDCoMKgI2VuZGlmIC8qIF9fTElOVVhfU1dJT1RMQl9IICovCj4+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvZG1hL3N3aW90bGIuYyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5jCj4+IGluZGV4IDhlODQw
ZmJiZWQ3Yy4uMzRlNmFkZTRmNzNjIDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwvZG1hL3N3aW90bGIu
Ywo+PiArKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwo+PiBAQCAtNTAsNiArNTAsNyBAQAo+PiDC
oMKgI2luY2x1ZGUgPGFzbS9pby5oPgo+PiDCoMKgI2luY2x1ZGUgPGFzbS9kbWEuaD4KPj4KPj4g
KyNpbmNsdWRlIDxsaW51eC9pby5oPgo+PiDCoMKgI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KPj4g
wqDCoCNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPgo+PiDCoMKgI2luY2x1ZGUgPGxpbnV4L2lv
bW11LWhlbHBlci5oPgo+PiBAQCAtNzIsNiArNzMsOCBAQCBlbnVtIHN3aW90bGJfZm9yY2Ugc3dp
b3RsYl9mb3JjZTsKPj4KPj4gwqDCoHN0cnVjdCBpb190bGJfbWVtIGlvX3RsYl9kZWZhdWx0X21l
bTsKPj4KPj4gK3BoeXNfYWRkcl90IHN3aW90bGJfdW5lbmNyeXB0ZWRfYmFzZTsKPj4gKwo+PiDC
oMKgLyoKPj4gwqDCoCAqIE1heCBzZWdtZW50IHRoYXQgd2UgY2FuIHByb3ZpZGUgd2hpY2ggKGlm
IHBhZ2VzIGFyZSBjb250aW5nb3VzKSB3aWxsCj4+IMKgwqAgKiBub3QgYmUgYm91bmNlZCAodW5s
ZXNzIFNXSU9UTEJfRk9SQ0UgaXMgc2V0KS4KPj4gQEAgLTE1NSw2ICsxNTgsMjcgQEAgc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBsb25nIG5yX3Nsb3RzKHU2NCB2YWwpCj4+IMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIERJVl9ST1VORF9VUCh2YWwsIElPX1RMQl9TSVpFKTsKPj4gwqDCoH0KPj4KPj4g
Ky8qCj4+ICsgKiBSZW1hcCBzd2lvbHRiIG1lbW9yeSBpbiB0aGUgdW5lbmNyeXB0ZWQgcGh5c2lj
YWwgYWRkcmVzcyBzcGFjZQo+PiArICogd2hlbiBzd2lvdGxiX3VuZW5jcnlwdGVkX2Jhc2UgaXMg
c2V0LiAoZS5nLiBmb3IgSHlwZXItViBBTUQgU0VWLVNOUAo+PiArICogSXNvbGF0aW9uIFZNcyku
Cj4+ICsgKi8KPj4gK3ZvaWQgKnN3aW90bGJfbWVtX3JlbWFwKHN0cnVjdCBpb190bGJfbWVtICpt
ZW0sIHVuc2lnbmVkIGxvbmcgYnl0ZXMpCj4+ICt7Cj4+ICvCoMKgwqDCoMKgwqAgdm9pZCAqdmFk
ZHIgPSBOVUxMOwo+PiArCj4+ICvCoMKgwqDCoMKgwqAgaWYgKHN3aW90bGJfdW5lbmNyeXB0ZWRf
YmFzZSkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaHlzX2FkZHJfdCBwYWRk
ciA9IG1lbS0+c3RhcnQgKyBzd2lvdGxiX3VuZW5jcnlwdGVkX2Jhc2U7Cj4+ICsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFkZHIgPSBtZW1yZW1hcChwYWRkciwgYnl0ZXMsIE1F
TVJFTUFQX1dCKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCF2YWRkcikK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2Vycigi
RmFpbGVkIHRvIG1hcCB0aGUgdW5lbmNyeXB0ZWQgbWVtb3J5IAo+PiAlbGx4IHNpemUgJWx4Llxu
IiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcGFkZHIsIGJ5dGVzKTsKPj4gK8KgwqDCoMKgwqDCoCB9Cj4+ICsKPj4gK8KgwqDC
oMKgwqDCoCByZXR1cm4gdmFkZHI7Cj4+ICt9Cj4+ICsKPj4gwqDCoC8qCj4+IMKgwqAgKiBFYXJs
eSBTV0lPVExCIGFsbG9jYXRpb24gbWF5IGJlIHRvbyBlYXJseSB0byBhbGxvdyBhbiBhcmNoaXRl
Y3R1cmUgdG8KPj4gwqDCoCAqIHBlcmZvcm0gdGhlIGRlc2lyZWQgb3BlcmF0aW9ucy7CoCBUaGlz
IGZ1bmN0aW9uIGFsbG93cyB0aGUgCj4+IGFyY2hpdGVjdHVyZSB0bwo+PiBAQCAtMTcyLDcgKzE5
NiwxMiBAQCB2b2lkIF9faW5pdCBzd2lvdGxiX3VwZGF0ZV9tZW1fYXR0cmlidXRlcyh2b2lkKQo+
PiDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyID0gcGh5c190b192aXJ0KG1lbS0+c3RhcnQpOwo+PiDC
oMKgwqDCoMKgwqDCoMKgIGJ5dGVzID0gUEFHRV9BTElHTihtZW0tPm5zbGFicyA8PCBJT19UTEJf
U0hJRlQpOwo+PiDCoMKgwqDCoMKgwqDCoMKgIHNldF9tZW1vcnlfZGVjcnlwdGVkKCh1bnNpZ25l
ZCBsb25nKXZhZGRyLCBieXRlcyA+PiBQQUdFX1NISUZUKTsKPj4gLcKgwqDCoMKgwqDCoCBtZW1z
ZXQodmFkZHIsIDAsIGJ5dGVzKTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgIG1lbS0+dmFkZHIgPSBz
d2lvdGxiX21lbV9yZW1hcChtZW0sIGJ5dGVzKTsKPj4gK8KgwqDCoMKgwqDCoCBpZiAoIW1lbS0+
dmFkZHIpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbS0+dmFkZHIgPSB2YWRk
cjsKPj4gKwo+PiArwqDCoMKgwqDCoMKgIG1lbXNldChtZW0tPnZhZGRyLCAwLCBieXRlcyk7Cj4+
IMKgwqB9Cj4+Cj4+IMKgwqBzdGF0aWMgdm9pZCBzd2lvdGxiX2luaXRfaW9fdGxiX21lbShzdHJ1
Y3QgaW9fdGxiX21lbSAqbWVtLCAKPj4gcGh5c19hZGRyX3Qgc3RhcnQsCj4+IEBAIC0xOTYsNyAr
MjI1LDE3IEBAIHN0YXRpYyB2b2lkIHN3aW90bGJfaW5pdF9pb190bGJfbWVtKHN0cnVjdCAKPj4g
aW9fdGxiX21lbSAqbWVtLCBwaHlzX2FkZHJfdCBzdGFydCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbWVtLT5zbG90c1tpXS5vcmlnX2FkZHIgPSBJTlZBTElEX1BIWVNfQURE
UjsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtLT5zbG90c1tpXS5hbGxv
Y19zaXplID0gMDsKPj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCAv
Kgo+PiArwqDCoMKgwqDCoMKgwqAgKiBJZiBzd2lvdGxiX3VuZW5jcnlwdGVkX2Jhc2UgaXMgc2V0
LCB0aGUgYm91bmNlIGJ1ZmZlciBtZW1vcnkgCj4+IHdpbGwKPj4gK8KgwqDCoMKgwqDCoMKgICog
YmUgcmVtYXBwZWQgYW5kIGNsZWFyZWQgaW4gc3dpb3RsYl91cGRhdGVfbWVtX2F0dHJpYnV0ZXMu
Cj4+ICvCoMKgwqDCoMKgwqDCoCAqLwo+PiArwqDCoMKgwqDCoMKgIGlmIChzd2lvdGxiX3VuZW5j
cnlwdGVkX2Jhc2UpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4g
Kwo+PiDCoMKgwqDCoMKgwqDCoMKgIG1lbXNldCh2YWRkciwgMCwgYnl0ZXMpOwo+PiArwqDCoMKg
wqDCoMKgIG1lbS0+dmFkZHIgPSB2YWRkcjsKPj4gK8KgwqDCoMKgwqDCoCByZXR1cm47Cj4+IMKg
wqB9Cj4+Cj4+IMKgwqBpbnQgX19pbml0IHN3aW90bGJfaW5pdF93aXRoX3RibChjaGFyICp0bGIs
IHVuc2lnbmVkIGxvbmcgbnNsYWJzLCBpbnQgCj4+IHZlcmJvc2UpCj4+IEBAIC0zNzEsNyArNDEw
LDcgQEAgc3RhdGljIHZvaWQgc3dpb3RsYl9ib3VuY2Uoc3RydWN0IGRldmljZSAqZGV2LCAKPj4g
cGh5c19hZGRyX3QgdGxiX2FkZHIsIHNpemVfdCBzaXplCj4+IMKgwqDCoMKgwqDCoMKgwqAgcGh5
c19hZGRyX3Qgb3JpZ19hZGRyID0gbWVtLT5zbG90c1tpbmRleF0ub3JpZ19hZGRyOwo+PiDCoMKg
wqDCoMKgwqDCoMKgIHNpemVfdCBhbGxvY19zaXplID0gbWVtLT5zbG90c1tpbmRleF0uYWxsb2Nf
c2l6ZTsKPj4gwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBmbiA9IFBGTl9ET1dOKG9y
aWdfYWRkcik7Cj4+IC3CoMKgwqDCoMKgwqAgdW5zaWduZWQgY2hhciAqdmFkZHIgPSBwaHlzX3Rv
X3ZpcnQodGxiX2FkZHIpOwo+PiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGNoYXIgKnZhZGRyID0g
bWVtLT52YWRkciArIHRsYl9hZGRyIC0gbWVtLT5zdGFydDsKPj4gwqDCoMKgwqDCoMKgwqDCoCB1
bnNpZ25lZCBpbnQgdGxiX29mZnNldCwgb3JpZ19hZGRyX29mZnNldDsKPj4KPj4gwqDCoMKgwqDC
oMKgwqDCoCBpZiAob3JpZ19hZGRyID09IElOVkFMSURfUEhZU19BRERSKQo+Pgo+Pgo+PiBUaGFu
a3MuCj4+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
