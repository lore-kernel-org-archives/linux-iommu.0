Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDFAC6377D
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 15:55:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A632D6127C
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 15:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A632D6127C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72371606B3;
	Thu, 22 Jul 2021 15:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SoG1CZ6je6Zi; Thu, 22 Jul 2021 15:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C97E605C9;
	Thu, 22 Jul 2021 15:55:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31266C0010;
	Thu, 22 Jul 2021 15:55:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EFF3C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 15:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4E3183139
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 15:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qIypcFEHw7SA for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 15:55:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8709B83022
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 15:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROqyBEb+Rm7t4cWcrTX2XWcXc2qfu4hsMKsDGs/+uBQnyuKv6/1huAyR/jO7BwwUdEdUmzfOtjNf9Idt+id/V5JICYs8NPXdGl5JYLze6C6yucCl/e8IkhwVyFaWMg7KYQCzI2PUtcNj7m9QUaOxO9jPo9qq2g+O8uM97ALdLek4MIKIT+cj+NPoKmXjf0qURByrrXkL2S7/pOGe0WIHLUFOfHfIVmXHqHBaOIM9jIEx16oR7mdxz5B5db6oT5bBYBPPw9OUehKs4Kb25zlPZU4TlqsSDAtibJTlr89U9qj659hXMcrEE5viaEZvqncPDioYlisksPXjT2FG7RtWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NGOQT/oil+JcHQsSewhUy2Qe8139m27kMTBzJCasj0=;
 b=kThwRFPAF6683EeHaJQqdskMJu+sFl0iwkYm20uEV9ZF2h+s9SXET5jXYJbLgrNiWpCHLnFpKDiMKUWeqibC+eQg2QqVLpOAG1xWWBXrMSThRFYk5+TYTWkfIK2BUpfMJauZoCvDSkmh+fMnwm/oaD3FqzRTGF/QDndu/WK/lY4hGQE3owu3bhajT7iTIdYVMhccKtKOdkHEL+M04klqtSOoRD7beiRFFq+V8afrsoYcOSfBVmfGNJGAMHNNo7rzCDXsexHcHleFSfZkN8IdWuyN9XbzFYBQre0EwfiAvUUM4vSXtRC8lXyw5NyQXQqyFgCLHf/S11VK/6ErTzU2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NGOQT/oil+JcHQsSewhUy2Qe8139m27kMTBzJCasj0=;
 b=IZF6j6oOWEpFZMBr1WRp4qMeGiY7imZRNrL4qttfytRLtTJ7DksgSAKRBlP0VobeTbSHugMQy4z0NjDrUKqtSH5xJCM+Kc2OOzagHsa5OZs8HknY5q3rQeH7ktcPRgTDC+yf8EKGJ2kMRHGioClxqjfhVkx2WX6T2lDy49aLUWo=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:388::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25; Thu, 22 Jul 2021 15:55:48 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461%5]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 15:55:48 +0000
Subject: Re: [PATCH] iommu/amd: Fix printing of IOMMU events when rate
 limiting kicks in
To: Lennert Buytenhek <buytenh@wantstofly.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <YPgk1dD1gPMhJXgY@wantstofly.org>
Message-ID: <82d11674-cabb-6129-11a8-23ca3c989bae@amd.com>
Date: Thu, 22 Jul 2021 10:55:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YPgk1dD1gPMhJXgY@wantstofly.org>
Content-Language: en-US
X-ClientProxiedBy: SN7PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:806:f3::24) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.117] (165.204.77.1) by
 SN7PR18CA0005.namprd18.prod.outlook.com (2603:10b6:806:f3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26 via Frontend Transport; Thu, 22 Jul 2021 15:55:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca896c9-fc97-4c5f-754e-08d94d292c67
X-MS-TrafficTypeDiagnostic: DM4PR12MB5037:
X-Microsoft-Antispam-PRVS: <DM4PR12MB50375CD7FAF1CAD2CE0EAE07F3E49@DM4PR12MB5037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12AeHsAS5Ug2fl2ogH7YRnrk62JnJutpGzQHBhuTy7zCgrFlF4KYD12IT7sZvvugW95QZ6Xn6CLsvayEmBtk7wtufYvhVheGzXS7Aq1LJNWMiAlIRiiTOPuRguBgezQLnHSiWPgPffqkFZ+zAGoX305adDHU8tU2LQYFUVYVe0iaEkfr+KSneDbbDeVDniZrH8JTWjLl/iGpQ9YIQvwf67QKfzk9VKrmUQR45tBTB/YwKrQRnSYe6g25lkWIBLzy4xOUC7D6Pz5uJZSQ1HzavEuWfqO0w3xTHsH7YigzpAUPm+9/mcBvoi9DbYTCb9bkIatc98qaEvKEfMe+V5V8Lhv3RbEUBEcdenDPE0QAiJKCe6K9BgHEBKsjetECYsrzHZOsK2ndE3wLlBm1Mtbi3mswdJNBEZicP0dzXlKn7IVusxwP8fVyfLQ7yQeA8t/qWwOCHBLED6Jvnu90XSFXXSFSQFZa+Ozw6rat/GPq0U3pQURbXY0nnlbvWsD66IwOfsIJC+0ogdn+vqvjTa+mlKH0ouYz/rEfu1U3CLrVOOTYOzpDMEQZcWe3LSE5GISe9jqsmQOI087+Uyy7k/WdBSB3Ukgh8kgglNYyTZw6L3GrGlMCmZIQVW0mKWZyeHj5Vc5Gkt4A3WKvge7Fz5B8vjZYQ09+y3TXkpnWHicEz8WgSWcB1DdwBzNJuziSEni9jrdDHpekVe6I3GWlmObat/wT/FfxgDdf0W9gDy6qPjeoTrQB3YYEXzSSdjKFBj1eVBIfs/YzxHWOsrNCIMvxzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(956004)(66946007)(4744005)(5660300002)(86362001)(53546011)(66556008)(66476007)(2616005)(8936002)(36756003)(316002)(8676002)(6486002)(83380400001)(26005)(16576012)(110136005)(38100700002)(38350700002)(52116002)(478600001)(31686004)(186003)(31696002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXphNDN0VW43Rnc0anJWOEpiNERRL1UzcndlWkNPVjBlWnJHSTRVZ2FHOFNM?=
 =?utf-8?B?bEdiRVVXTlhDVVFqUFdiUldVM0Q4bU5uRkp1UnFFbXpPZkwvM3NOMkluUVh5?=
 =?utf-8?B?R2FIeFdhZ1hhQzJETmUzd3d0dHNzZHl5QTBIeEN2TlI2SUQ2RWhza2xXQW96?=
 =?utf-8?B?NnBwQ3JaQ3B4b3drbGw0bTJjeDgxVWE2OWlicjlTMFI5TDlmTmIycG5LcSs4?=
 =?utf-8?B?SXZ1YzdpMTVPQW9heUw2TVNIZUc3aTQrUEgvL2tRNTgrTzVCY0VZZlNSTGhu?=
 =?utf-8?B?VjY1b2tTQnpIM083OE9ueE45VTJUbTlCQ2llaUhGVDRFQlZtUk90K2RaK1Zl?=
 =?utf-8?B?eXNycXVybk5ua05IeFZ1anc5MldrdXMzVzdUZXVvYmswTGo4dWc1dEgwYW5W?=
 =?utf-8?B?MjU3RVYvN00wQkdjc3Y5bzBDWEs0YnZGcHlEWFo2T0xuelVqM05ORFVWdTFu?=
 =?utf-8?B?U3hLUVZOZkU3bVJHYWxiRmFYM0FOKytyNVZ6VzVIT0VRSFFCemI4eCtXVjJm?=
 =?utf-8?B?TFV4NUxLdDJEcURhb2l3ZGRpcW1RMVVVZFdVd0lhbjRQMVBoS1BTZE0zVFpG?=
 =?utf-8?B?Ti9uekpaTzJRKzhjRldLU2k0WHF0endiZWMvSVZPYWQ0eFpuS1JzWnlIMk14?=
 =?utf-8?B?dmU0d1ZyWkx5Zzdnd1dCbDNCL1Q3dnZvRnNtK1NLWkMwbzVNVXdab0JOODQz?=
 =?utf-8?B?WGFYbzNDdzc0WW9NUHNXTlFhNDlad0RoM1JPTi9sS1Qyd0RIa3kveVU1OEw0?=
 =?utf-8?B?Q2VLMW54L2RldWN5b0YrUHBCTTE3Y3RJNWJXS2haZVNZQnEydUQ3TDdqejBo?=
 =?utf-8?B?cWlWVmZoODZtbHpPbG9nSlB6amlnMDI2R0x6eXMrYkV5N0lwZDhKc1QxMUNr?=
 =?utf-8?B?TzV3UkNLREcrYnRLejhIVlpQS3pvTkFMVXpCa1NPczgxM1JjVGM4eHhKK08x?=
 =?utf-8?B?ejUwamdhMnVJa1d4UjhMWmxjU2RLemM4NEMwUXpnMldpV2lncHRrS3c3OFdO?=
 =?utf-8?B?dlZaaEJlc3JFWnhHR0wzUEd3UzRicFNZLzJuMlhudkdwMWRXSTRxOFNUNTUy?=
 =?utf-8?B?bmpIazFDdVJJekplY2ZYQXNscU8veEMyMmtVaW13QTVkbC9RUUhBZVVqemQw?=
 =?utf-8?B?b0lhc0t2T0lJclVOcjkvVEdQNDAwdnBGNENJVElVVHZMM1lHQmlrVWl6YjRQ?=
 =?utf-8?B?QUMwWlZVRDJabWRqUmc1enlKbm02NkgrUmV5bG9IU1JjRUZ3VjVyMWd4WjVW?=
 =?utf-8?B?eHFGdmQwamFkN1QvTlc5ZHgyQnpPRGo0bGVXeXVDWXkvRUwwYUlYZXNoZ1JE?=
 =?utf-8?B?cnFldGFSb2x2OFdRUHZkKzNkbjJrZEExTlpPdDF6ejVYcVJWRWUxbXlhWGQr?=
 =?utf-8?B?eDZkb3p3Wk1JOUduYWxXY0tVUndQR1RMYXl6UHlIdEJGRGMyZ2IyandOeng2?=
 =?utf-8?B?YzRlR2lHVkxhWmtTTHE1YXgycCtxNU5DeEVIUkUxRnMrNmpTMnZMTGZmR3Ri?=
 =?utf-8?B?K2RDUGRwZEVhV1FXRFB2aEU5NHRsNjJSRkhuaXFocDhobUMwa1VNMVU2M2I4?=
 =?utf-8?B?YktDTHhCeTJXVk9OeG0xUXBQRU5pMnk4UDJ4WS9hS1NoR3FBazVHMW9XSmlh?=
 =?utf-8?B?QXZMajcxRThncDV0NTBhK0swajJ5eTBwQTFkWFhrWXc4RFJCaFNZV2dMdFZD?=
 =?utf-8?B?NHFhSS9PUDE1SVJ0UmQrQ3JpSTB4Q2Q2bTVCOUplSkYvdlMwQ0F2UlVReDd3?=
 =?utf-8?Q?+rhiyhFkmoEZtFKDkSnz7675XlTprjN+6MTeOC0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca896c9-fc97-4c5f-754e-08d94d292c67
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 15:55:48.5533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvuZ5sF32+VWiHZmWHhUb8MNLp3mDp4xMQQEcp1tInUXUVGUttFUfyWisPpGkUf/NybkxzsBrbp+IYJLM8BBDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
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
From: "Suthikulpanit, Suravee via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 7/21/2021 8:44 AM, Lennert Buytenhek wrote:
> For the printing of RMP_HW_ERROR / RMP_PAGE_FAULT / IO_PAGE_FAULT
> events, the AMD IOMMU code uses such logic:
> 
> 	if (pdev)
> 		dev_data = dev_iommu_priv_get(&pdev->dev);
> 
> 	if (dev_data && __ratelimit(&dev_data->rs)) {
> 		pci_err(pdev, ...
> 	} else {
> 		printk_ratelimit() / pr_err{,_ratelimited}(...
> 	}
> 
> This means that if we receive an event for a PCI devid which actually
> does have a struct pci_dev and an attached struct iommu_dev_data, but
> rate limiting kicks in, we'll fall back to the non-PCI branch of the
> test, and print the event in a different format.
> 
> Fix this by changing the logic to:
> 
> 	if (dev_data) {
> 		if (__ratelimit(&dev_data->rs)) {
> 			pci_err(pdev, ...
> 		}
> 	} else {
> 		pr_err_ratelimited(...
> 	}
> 
> Suggested-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
> Signed-off-by: Lennert Buytenhek<buytenh@wantstofly.org>

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
