Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9F8C433FE
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 18:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE1ED610DF;
	Tue, 15 Mar 2022 18:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNSszeizA8ll; Tue, 15 Mar 2022 18:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 51FB4610B5;
	Tue, 15 Mar 2022 18:36:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33B26C001D;
	Tue, 15 Mar 2022 18:36:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A2A1C0012
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 18:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53984610D7
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 18:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bZqNZ2UcLC9v for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 18:36:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::609])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABBC860AAE
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 18:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFmzCo1CH65fD6dJ2gSFb/Ztzl15b8GDv75AvIfDQFlkemkwMhXeR6ASwJwEgHr9fqbtsaNrD0UUTioO2xGC+LLnhKPWtROgKJmTo6Y7lsrFqGNiedaLKrd0G58GJtOM4HjjWESCBzB3sGGhnlItzve6gN+btOhhs2Q8JDwyls5+q1rEkFsWwNjCeQgQvKXUAyjX5ecmVzIPoEvEJgoWXEvoGPMDsDJ1omnwuaeoR2QE0gAW2mj9CCiwMv+LRhHRVfw6oDR5UPP8jNh7jVSzDRbk5yYivTbyHEa2uNUJ5oEi+4XjnjEKnhEjUoI7MABAJVs0nxGQjOAN7rSVYjc0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7u932eFtFTu8Ax5NhJ5Jyslo5hbYj5zmxEjVk4EA8Q=;
 b=TcC/sSEq8tq9MtGPR/sKdd11sKTIdzB5tjgEUbZoga5wgN8GTcHeGjY0jmAO5nm5434b10G5xbb1CaLrxPHE8lRMfxldWYWsUEoVw52ejS/zV1J+dYiuNxrZqkwnUGNx+0KTp+PikEvXtl+OeITmQAW7yB+Wczx7ZzJM+tvVcjAWB09iQGLUOigNeiIVQF4M7xb8biwqFz+O1cbi+48LdU6wCbiLm+MWx1tDBbTfpMU2L7Kc00qU7bmc9GUgbCDQOXqYTUnnpookLOVXqoNOhOPH7rQrsZo0L9e/JoKDnK3jfnEPNI0BQ8SuOzV8Pt9qCrN0wlg+8FyMmhqOUSljpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7u932eFtFTu8Ax5NhJ5Jyslo5hbYj5zmxEjVk4EA8Q=;
 b=OKq1bBDmsVORI8Ds8zWmilQV7ofXZ0/UhpNXiW+hdi3por8GZyZ4Ipe5Nl6tLO6nQMKivVFg2cpFHEi/YE7e6/WpJ3EmBD4ciwszycKX06wnQxaxlpdjOJfMn/M4rqX6EkV2mxJVuFevPb3vk0B7ZVJA8jmwigSCTvdTOgibsi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 18:36:14 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 18:36:14 +0000
Message-ID: <7d588dfa-aa57-7be1-9cbb-61897f81bf99@amd.com>
Date: Tue, 15 Mar 2022 13:36:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig
 <hch@infradead.org>, christian@kellner.me,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
 <20220315162455.5190-2-mario.limonciello@amd.com>
 <YjDDUUeZ/dvUZoDN@infradead.org>
 <BL1PR12MB5157D7B7734122684D47923AE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
 <21d33a75-8c0e-7734-b3d1-dbe33cfe0ab0@arm.com>
In-Reply-To: <21d33a75-8c0e-7734-b3d1-dbe33cfe0ab0@arm.com>
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8c21d68-1c8b-4110-46c7-08da06b2af19
X-MS-TrafficTypeDiagnostic: CH0PR12MB5332:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5332C0A6F20463B7813C726CE2109@CH0PR12MB5332.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJ3cWx5ZyN6WCny6GrEe84HutucFTsXcVRbS9s60RsotRjbrbcODZDJ1JlKJFqImmI+7ZOSB1Vo/M4JT3ovWm3bjpCyr1SUfYrgxHjNEMjKhqAc3LMPhrN2NVbjh0FfeM52A9FxdOTS/lKnSeonuCxwP+lvj48cwZdIUGZDABDlzmsar8Mm6yElH+IW0cQDnafBjjrXzy1ZCeK5cbCxE31msKUH9zthLw4u72AtCVZZvUTh7C7pvSn2iOIpLigC+y+1e6lmVVbW9kJOar7331aRuX4uINKih0/5p6Q+EaaW5s3SH/toiNB/vIOJFluiN/4rzqgDSjrJJ9h+NOwz05BH2KMoj8ac5rvU0RtGxja+UfyCHMb3Hof+pFq5u5oAaq00NQCjnO9KWWpCE0h0vXBx9jEWuB0nn6uo3se/CilkdNe1IuXnWT5IrFnvBRDmuAL+lEItnHMs7LXp9LHuj0hzCpsK89J7NiJFKSV4N8zLY+42mBGiFs5sNKEWobx4ojoERGcIVwuWCyR3wnubxg2zloMtPQiL8uj5L/jgvaBUad7iEZYf4C6APTm3ZwXVu5QJvwfVDWNkwJDvGutkJrw/TKxTJpwuEdrUNDwzz8Uuucmx16Wqq/m01LWGfxSvEPTSk9zMB8oPbrzBYvE/fnEPpc68SZh0avOIjs80PreKT8Xo/f5qCpV62Gd9lxYCyQT4orkr4eqIhyXT061bhG2fgvsNeoJKD4wtKOpZl8MTUeKLz3sTNdqnPP7xYIHwSzBktPwKY+voMJIdWUiZQsSqO3TlJULUTbhwKM0++GT5jsxKUX6kA4ySmu6ypUIzqrcgDYegwiEUQMrklvFULmqNCEZPyoDEm+PzQ0D/Kn8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(45080400002)(966005)(6486002)(26005)(186003)(5660300002)(8936002)(36756003)(31686004)(6666004)(7416002)(508600001)(2616005)(31696002)(4326008)(53546011)(86362001)(6506007)(54906003)(110136005)(316002)(6512007)(66946007)(66476007)(66556008)(8676002)(83380400001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNSamM5SEE3a3hoTW5mWmZQaFB0dnB0YlBhdlFsTGNGSHFmaFBrc0J6cy96?=
 =?utf-8?B?T1JDWmlHZFpCVkZGODNtanFMNVlrTFJZQytFK2NMME1iZm1LREFiSEdGMjRx?=
 =?utf-8?B?WnJZazIvMlRERWdNZEtVV1k5NDdzbkFESDIrOTBPMEFWVUt1bXlKYTUzZ1Fs?=
 =?utf-8?B?Zm9MMUxsVWl2M2M1UzZmKzlEYUc2TDFGeG91dE1Wci9zaUxQS092bWRzMkds?=
 =?utf-8?B?NC9rWkFJaXZhOWVQMnpzdjVycmtyOVVCUElSckdBV0hUSGEwanJnS2g0YWZH?=
 =?utf-8?B?K3hVaVNYakh0N2tTZ054VlNUUHp3RkJUN25wQ2cyQTZzWGpYVDRXQUZlSDIw?=
 =?utf-8?B?ZGFPdDlYWlhMK1JQZHhaL3VJcW1NUUhtMStVc0ZtRklvTEczZFFFNHBVMTQ3?=
 =?utf-8?B?dHVrbjNsaFdKWVAxWWFyK09TZklnSVhoK2NnZWNqMVgrdnJ1MktKL0hhODNz?=
 =?utf-8?B?VDNBSjZ0eGY3NUdXMVRYVWhvTXE4ZmpRRUtqQlZFMUNNMnlySDVEdGVwbFNh?=
 =?utf-8?B?YWJDSXFRbzFwTEx6RFF1RUxRQURodVZpMXprUU1kaS9qVXlsSm9jdjI3TnVO?=
 =?utf-8?B?cUE5bWhkQjNrdXArVUsrT1V1cU5QMmFUTnhmbzNRQzRjUVE5UGR4VWFRMmpD?=
 =?utf-8?B?VDVVbGlTaWYwczNFakYyRWM0YlVIRVhMSExGSzMram8rWUtwZDYvK2lDdHk1?=
 =?utf-8?B?VUFkYWl5MC9uRkJyakRjK005UmVVY3BLMVRRM0xqb1pZb3lTTVNnSk9aTXZT?=
 =?utf-8?B?UndFWEc0ZE91TnBIZVpUT1lTRHFMdG52aTZMOFR3c1hHSzg4OERHTzVKVndj?=
 =?utf-8?B?V0xRQkhqODV0RlNJRHUvL3p3OWVoUVhqNncwQzlOQXFhdCtleElmZkdlUzNk?=
 =?utf-8?B?V2xqb0didFB3TU1NTlVxQ1dzWmhMY2x3cXQxakZweThSa05pSnRFWTk4dTd3?=
 =?utf-8?B?T3k0Z093THVZandrVFIvcFJKMkhkOUtFL2VLeFlpUy9mWGNzc1R5U2dWVksy?=
 =?utf-8?B?UytGcWRoNytwUGZZbE5Dc1orSjUzSXZVdjRDclZ4TXNacm5vcC91am9EeVBU?=
 =?utf-8?B?MkN6eWx6T09jNkpjcUZUSG5wblJaMUxBdUFuVlVKK0o5OE8rYTNkMjBJSTFN?=
 =?utf-8?B?QTJ0amZFbXhQb25MUFJkNjdnYTlBNlpqWlllZkF3OE5qQXRVS0E5ZWEydEdn?=
 =?utf-8?B?NWFla0tETWR0K0JCYmdpWVNNQU5mWUhxcW9URllaNmlRMng3SGc3bXVIVWEr?=
 =?utf-8?B?K2NRdW9YYmcycHlkZkFMMU5wMmNhYkJSWXYvSFl3cmpDcHB3QWZEZjZ5cUdY?=
 =?utf-8?B?S29HNllhWCtHRkdSOGpnOFhDOXQ2WGVsZ3pzT3pHc2Nrd25abEpWSjF3YTdB?=
 =?utf-8?B?NXFQYzQvMmlBTmR3dEt1djNkeG45QmxHL2xOM3MzVW5QUzE3VWxETHNJei9v?=
 =?utf-8?B?c3VIZ3pUVXhmYWUrZnJFcUl2N1N5dEduMTBWUFJqR1pHVEU1TDFTcGNTUmYz?=
 =?utf-8?B?MjJlWVI0TlhibjgrbWdEWXNJNEJyN3NqWVQ0Rlp4WjNZZ05XVWVGRDkxckh6?=
 =?utf-8?B?MllXczkwbUt4R2ZKWjd6Nlg3Z0xOMFJZOCtFM0xxd3lKL3IwWWg5NGl2a3p4?=
 =?utf-8?B?dUZ2SUVhczBiRGdEK1NOdnpoTndjT3BTZ0hNbEdqS3M0YWxqbVY2Sk92MndQ?=
 =?utf-8?B?bkY0aUJOMkprdWg5YUlNL1V3Y3Z5OHNrZVJ6SW5iam5vQjFMWUE0SzhacWRF?=
 =?utf-8?B?TC9oUmpLNHRpRXBZTS9zcE1CU1N6bmJZUmFwaUZjZjJVT1ppYVRIVjVsYU02?=
 =?utf-8?B?MEg4cGxjWkloWjFPR0haQlgvOTlkNnpYWGRMTE1TeUpwVnZvTUFsblI5STVU?=
 =?utf-8?B?TzFWMERzNEpRNmVtMzloNWF1R1BhZXVBVkdaZ20wYVdmYmRCekFUa01uNDZq?=
 =?utf-8?Q?wNiKm3PyebLKutQt9VIEgbqbxcdSsE2p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c21d68-1c8b-4110-46c7-08da06b2af19
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:36:14.0460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPx5wPzMGfn56y5uEaZXtrzdrGfmmOBbIjtviesH6iiUHrtlKpYRfN2AKpyyu3jTrm+9Mev4IUOO3hK63RIRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
Cc: Michael Jamet <michael.jamet@intel.com>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, Will Deacon <will@kernel.org>
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
From: "Limonciello, Mario via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

KyBDaHJpc3RpYW4gS2VsbG5lciAoQm9sdCB1c2Vyc3BhY2UgbWFpbnRhaW5lcikKCk9uIDMvMTUv
MjAyMiAxMzowNywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDMtMTUgMTY6NTQsIExp
bW9uY2llbGxvLCBNYXJpbyB2aWEgaW9tbXUgd3JvdGU6Cj4+IFtQdWJsaWNdCj4+Cj4+Cj4+PiBP
biBUdWUsIE1hciAxNSwgMjAyMiBhdCAxMToyNDo1NUFNIC0wNTAwLCBNYXJpbyBMaW1vbmNpZWxs
byB3cm90ZToKPj4+PiAtwqDCoMKgwqAgKiBoYW5kbGVkIG5hdGl2ZWx5IHVzaW5nIElPTU1VLiBJ
dCBpcyBlbmFibGVkIHdoZW4gSU9NTVUgaXMKPj4+PiAtwqDCoMKgwqAgKiBlbmFibGVkIGFuZCBB
Q1BJIERNQVIgdGFibGUgaGFzIERNQVJfUExBVEZPUk1fT1BUX0lOIHNldC4KPj4+PiArwqDCoMKg
wqAgKiBoYW5kbGVkIG5hdGl2ZWx5IHVzaW5nIElPTU1VLiBJdCBpcyBlbmFibGVkIHdoZW4gdGhl
IElPTU1VIGlzCj4+Pj4gK8KgwqDCoMKgICogZW5hYmxlZCBhbmQgZWl0aGVyOgo+Pj4+ICvCoMKg
wqDCoCAqIEFDUEkgRE1BUiB0YWJsZSBoYXMgRE1BUl9QTEFURk9STV9PUFRfSU4gc2V0Cj4+Pj4g
K8KgwqDCoMKgICogb3IKPj4+PiArwqDCoMKgwqAgKiBBQ1BJIElWUlMgdGFibGUgaGFzIERNQV9S
RU1BUCBiaXRzZXQKPj4+PiDCoMKgwqDCoMKgwqAgKi8KPj4+PiDCoMKgwqDCoMKgIHJldHVybiBz
cHJpbnRmKGJ1ZiwgIiVkXG4iLAo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlv
bW11X3ByZXNlbnQoJnBjaV9idXNfdHlwZSkgJiYKPj4+IGRtYXJfcGxhdGZvcm1fb3B0aW4oKSk7
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfcHJlc2VudCgmcGNpX2J1
c190eXBlKSAmJgo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChkbWFyX3BsYXRm
b3JtX29wdGluKCkgfHwgYW1kX2l2cnNfcmVtYXBfc3VwcG9ydCgpKSk7Cj4+Pgo+Pj4gWWlrZXMu
wqAgTm8sIHRoZSB0aHVuZGVyYm90IGNvZGUgZG9lcyBub3QgaGF2ZSBhbnkgYnVzaW5lc3MgcG9r
aW5nIGludG8KPj4+IGVpdGhlciBkbWFyX3BsYXRmb3JtX29wdGluIG9yIGFtZF9pdnJzX3JlbWFw
X3N1cHBvcnQuwqAgVGhpcyBuZWVkcwo+Pj4gYSBwcm9wZXIgYWJzdHJhdGlvbiBmcm9tIHRoZSBJ
T01NVSBjb2RlLgo+Pgo+PiBUbyBtYWtlIHN1cmUgSSBmb2xsb3cgeW91ciBhc2sgLSBpdCdzIHRv
IG1ha2UgYSBuZXcgZ2VuZXJpYyBpb21tdSAKPj4gZnVuY3Rpb24KPj4gVGhhdCB3b3VsZCBjaGVj
ayBkbWFyL2l2cnMsIGFuZCBzd2l0Y2ggb3V0IHRodW5kZXJib2x0IGRvbWFpbi5jIHRvIHVzZSAK
Pj4gdGhlCj4+IHN5bWJvbD8KPj4KPj4gSSdtIGhhcHB5IHRvIHJld29yayB0aGF0IGlmIHRoYXQg
aXMgd2hhdCB5b3Ugd2FudC4KPj4gRG8geW91IGhhdmUgYSBwcmVmZXJyZWQgcHJvcG9zZWQgZnVu
Y3Rpb24gbmFtZSBmb3IgdGhhdD8KPiAKPiBCdXQgd2h5PyBFaXRoZXIgSU9NTVUgdHJhbnNsYXRp
b24gaXMgZW5hYmxlZCBvciBpdCBpc24ndCwgYW5kIGlmIGl0IGlzLCAKPiB3aGF0J3MgdG8gZ2Fp
biBmcm9tIGd1ZXNzaW5nIGF0ICp3aHkqIGl0IG1pZ2h0IGhhdmUgYmVlbj8gQW5kIGV2ZW4gaWYg
Cj4gdGhlIElPTU1VJ3MgZmlybXdhcmUgdGFibGUgZGlkIHRlbGwgdGhlIElPTU1VIGRyaXZlciB0
byBlbmFibGUgdGhlIAo+IElPTU1VLCB3aHkgc2hvdWxkIHRoYXQgYmUgVGh1bmRlcmJvbHQncyBi
dXNpbmVzcz8KQSBsb3Qgb2YgdGhpcyBjb21lcyBmcm9tIGJhZ2dhZ2UgZnJvbSBlYXJseSBUaHVu
ZGVyYm9sdCAzIGltcGxlbWVudGF0aW9uIApvbiBzeXN0ZW1zIHdpdGggSUNNIChJbnRlbCdzIEZX
IENNKS4gT24gdGhvc2Ugc3lzdGVtcyB0aGVyZSB3YXMgYSAKY29uY2VwdCBvZiAiU2VjdXJpdHkg
TGV2ZWxzIi4gIFRoaXMgbWVhbnQgdGhhdCBkb3duc3RyZWFtIFBDSWUgZGV2aWNlcyAKd2VyZSBu
b3QgYXV0b21hdGljYWxseSBhdXRob3JpemVkIHdoZW4gYSBUQlQzIGRldmljZSB3YXMgcGx1Z2dl
ZCBpbi4gIEluIAp0aG9zZSBjYXNlcyB0aGVyZSB3YXMgbm8gZ3VhcmFudGVlIHRoYXQgdGhlIElP
TU1VIHdhcyBpbiB1c2UgYW5kIHNvIHRoZSAKc2VjdXJpdHkgd2FzIHBhc3NlZCBvbiB0byB0aGUg
dXNlciB0byBtYWtlIGEgZGVjaXNpb24uCgpJbiBMaW51eCB0aGlzIHdhcyBhY2NvbXBsaXNoZWQg
dXNpbmcgdGhlICdhdXRob3JpemVkJyBhdHRyaWJ1dGUgaW4gCi9zeXMvYnVzL3RodW5kZXJib2x0
L2RldmljZXMvJE5VTS9hdXRob3JpemVkLiAgV2hlbiB0aGlzIHdhcyBzZXQgdG8gMSAKdGhlbiB0
aGUgVEJUMyBkZXZpY2UgYW5kIFBDSWUgdG9wb2xvZ3kgYmVoaW5kIGl0IHdvdWxkIGJlIGVudW1l
cmF0ZWQuCgpGdXJ0aGVyIGRvY3VtZW50YXRpb24gZXhwbGFpbmluZyBob3cgdGhpcyB3b3JrcyBp
cyBhdmFpbGFibGUgaGVyZToKaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3Qv
YWRtaW4tZ3VpZGUvdGh1bmRlcmJvbHQuaHRtbCNzZWN1cml0eS1sZXZlbHMtYW5kLWhvdy10by11
c2UtdGhlbQoKKEludGVsIGJhc2VkKSBQbGF0Zm9ybXMgZnJvbSAyMDE4KyB3LyBUQlQzIHN0YXJ0
ZWQgdG8gdXNlIHRoZSBJT01NVSAKY29uc2lzdGVudGx5IGF0IHJ1bnRpbWUgYnV0IGhhZCB0aGlz
IGV4aXN0aW5nIGltcGxlbWVudGF0aW9uIG9mIHNlY3VyaXR5IApsZXZlbHMgdG8gd29ycnkgYWJv
dXQuICBGdXJ0aGVybW9yZSB0dW5uZWxzIGNvdWxkIGJlIGNyZWF0ZWQgcHJlLWJvb3QsIAphbmQg
c28gdGhlIHRodW5kZXJib2x0IGRyaXZlciBtYXkgb3IgbWF5IG5vdCByZS1jcmVhdGUgdGhlbSBi
YXNlZCBvbiBwb2xpY3kuCgpTbyBhIG5ldyBhdHRyaWJ1dGUgd2FzIGNyZWF0ZWQgImlvbW11X2Rt
YV9wcm90ZWN0aW9uIiB0aGF0IHVzZXJzcGFjZSAKY291bGQgdXNlIGFzIHBhcnQgb2YgYSBwb2xp
Y3kgZGVjaXNpb24gdG8gYXV0b21hdGljYWxseSBhdXRob3JpemUgCmRldmljZXMuICBFeHBvcnRp
bmcgdGhpcyBhdHRyaWJ1dGUgaXMgdmVyeSBzaW1pbGFyIHRvIHdoYXQgTWljcm9zb2Z0IApkb2Vz
IHRvIGxldCB0aGUgdXNlciBzZWUgdGhlIHNlY3VyaXR5IG9mIHRoZSBzeXN0ZW0uCgpodHRwczov
L2RvY3MubWljcm9zb2Z0LmNvbS9lbi11cy93aW5kb3dzLWhhcmR3YXJlL2Rlc2lnbi9kZXZpY2Ut
ZXhwZXJpZW5jZXMvb2VtLWtlcm5lbC1kbWEtcHJvdGVjdGlvbgoKSW4gTGludXggdG9kYXkgc29t
ZSB1c2Vyc3BhY2Ugc29mdHdhcmUgImJvbHQiIGhhcyBhIHBvbGljeSBpbmNsdWRlZCBieQpkZWZh
dWx0IHRoYXQgd2lsbCBhdXRvbWF0aWNhbGx5IGF1dGhvcml6ZSBUQlQzIGFuZCBVU0I0ICh3LyBQ
Q0llKSAKZGV2aWNlcyB3aGVuIGlvbW11X2RtYV9wcm90ZWN0aW9uIGlzIHNldCB0byAxLgoKPiAK
PiBGdXJ0aGVybW9yZSwgbG9va2luZyBhdCBwYXRjaCAjMSBJIGNhbiBvbmx5IGNvbmNsdWRlIHRo
YXQgdGhpcyBpcyAKPiBlbnRpcmVseSBtZWFuaW5nbGVzcyBhbnl3YXkuIEFGQUlDUyBpdCdzIGxp
dGVyYWxseSByZXBvcnRpbmcgd2hldGhlciB0aGUgCj4gZmlybXdhcmUgZmxhZyB3YXMgc2V0IG9y
IG5vdC4gTm90IHdoZXRoZXIgaXQncyBhY3R1YWxseSBiZWVuIGhvbm91cmVkIAo+IGFuZCB0aGUg
SU9NTVUgaXMgZW5mb3JjaW5nIGFueSBraW5kIG9mIERNQSBwcm90ZWN0aW9uIGF0IGFsbC4gRXZl
biBvbiAKPiBJbnRlbCB3aGVyZSB0aGUgZmxhZyBkb2VzIGF0IGxlYXN0IGhhdmUgc29tZSBlZmZl
Y3Qgb24gdGhlIElPTU1VIGRyaXZlciwgCj4gdGhhdCBjYW4gc3RpbGwgYmUgb3ZlcnJpZGRlbi4K
ClRha2UgYSBsb29rIGF0IHRoZSBNaWNyb3NvZnQgbGluayBJIHNoYXJlZCBhYm92ZS4gIFRoZXkg
YWxzbyBtYWtlIHBvbGljeQpkZWNpc2lvbnMgYmFzZWQgb24gdGhlIGluZm9ybWF0aW9uIGluIHRo
ZXNlIHRhYmxlcy4KCj4gCj4gSSBhbHJlYWR5IGhhdmUgYSBwYXRjaCByZWZhY3RvcmluZyB0aGlz
IHRvIGdldCByaWQgb2YgaW9tbXVfcHJlc2VudCgpLCAKPiBidXQgYXQgdGhlIHRpbWUgSSB3YXNu
J3QgbG9va2luZyB0byBjbG9zZWx5IGF0IHdoYXQgaXQncyB0cnlpbmcgdG8gKmRvKiAKPiB3aXRo
IHRoZSBpbmZvcm1hdGlvbi4gSWYgaXQncyBzdXBwb3NlZCB0byBhY2N1cmF0ZWx5IHJlZmxlY3Qg
d2hldGhlciB0aGUgCj4gVGh1bmRlcmJvbHQgZGV2aWNlIGlzIHN1YmplY3QgdG8gSU9NTVUgdHJh
bnNsYXRpb24gYW5kIG5vdCBieXBhc3NlZCwgSSAKPiBjYW4gZml4IHRoYXQgdG9vIChhbmQgdW5l
eHBvcnQgZG1hcl9wbGF0Zm9ybV9vcHRpbigpIGluIHRoZSBwcm9jZXNzLi4uKQo+IAo+IFJvYmlu
LgoKVGhpcyBwYXRjaCBzZXJpZXMgc3RlbXMgZnJvbSB0aGF0IGhpc3RvcnkuICBUbyBnaXZlIHRo
ZSBiZXN0IGV4cGVyaWVuY2UgCnRvIGVuZCB1c2VycyB5b3Ugd2FudCBob3RwbHVnZ2VkIGRldmlj
ZXMgdG8gYmUgYXV0b21hdGljYWxseSBhdXRob3JpemVkIAp3aGVuIHNvZnR3YXJlIHNheXMgaXQn
cyBzYWZlIHRvIGRvIHNvLgoKVG8gc3VtbWFyaXplIHRoZSBmbG93OgoqIFVzZXIgcGx1Z3MgaW4g
ZGV2aWNlCiogVVNCNCBDTSB3aWxsIHF1ZXJ5IHN1cHBvcnRlZCB0dW5uZWxzCiogVVNCNCBDTSB3
aWxsIGNyZWF0ZSBkZXZpY2VzIGluIC9zeXMvYnVzL3RodW5kZXJib2x0L2RldmljZXMgZm9yIG5l
dyAKcGx1Z2dlZCBpbiBUQlQzL1VTQjQgZGV2aWNlCiogImF1dGhvcml6ZWQiIGF0dHJpYnV0ZSB3
aWxsIGRlZmF1bHQgdG8gIjAiIGFuZCBQQ0llIHR1bm5lbHMgYXJlIG5vdCAKY3JlYXRlZAoqIFVz
ZXJzcGFjZSBnZXRzIGEgdWV2ZW50IHRoYXQgdGhlIGRldmljZSB3YXMgYWRkZWQKKiBVc2Vyc3Bh
Y2UgKGJvbHQpIHJlYWN0cyBieSByZWFkaW5nIAovc3lzL2J1cy90aHVuZGVyYm9sdC9kZXZpY2Vz
L2RvbWFpblgvaW9tbXVfZG1hX3Byb3RlY3Rpb24KKiBJZiB0aGF0IGlzIHNldCB0byAiMSIsIGJv
bHQgd2lsbCB3cml0ZSAiMSIgdG8gImF1dGhvcml6ZWQiICBhbmQgVVNCNCAKQ00gd2lsbCBjcmVh
dGUgUENJZSB0dW5uZWxzCiogSWYgdGhhdCBpcyBzZXQgdG8gIjAiLCBib2x0IHdpbGwgc2VuZCBh
biBldmVudCB0byBHVUkgdG8gc2hvdyBhIHBvcHVwIAphc2tpbmcgdG8gYXV0aG9yaXplIHRoZSBk
ZXZpY2UKKiBBZnRlciB1c2VyIGFja3MgdGhlIGF1dGhvcml6YXRpb24gdGhlbiBpdCB3aWxsIHdy
aXRlICIxIiB0byAKImF1dGhvcml6ZWQiIGFuZCBVU0I0IENNIHdpbGwgY3JlYXRlIFBDSWUgdHVu
bmVscwoKCk1pa2EsCgpJIHdvbmRlciBpZiBtYXliZSB3aGF0IHdlIHJlYWxseSB3YW50IGlzIHRv
IG9ubHkgdXNlIHRoYXQgZmxvdyBmb3IgdGhlIAphdXRob3JpemVkIGF0dHJpYnV0ZSB3aGVuIHVz
aW5nIFRCVDMgKyBJQ00gKG9yIElPTU1VIGRpc2FibGVkIGF0IApydW50aW1lKS4gIElmIHdlJ3Jl
IHVzaW5nIGEgVVNCNCBob3N0LCBjaGVjayBJT01NVSB0cmFuc2xhdGlvbiBsYXllciAKYWN0aXZl
IGxpa2UgUm9iaW4gc3VnZ2VzdGVkIGFuZCB0aGVuIGF1dG9tYXRpY2FsbHkgYXV0aG9yaXplIGZy
b20gdGhlIENNLgoKVGhvdWdodHM/CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
