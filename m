Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39008C433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 03:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0E56424E1;
	Thu, 26 May 2022 03:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qzgaiURtJVRa; Thu, 26 May 2022 03:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6452C424E3;
	Thu, 26 May 2022 03:29:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 246C8C0032;
	Thu, 26 May 2022 03:29:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 879F7C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 03:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5354184526
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 03:29:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5FmWT59_j6ux for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 03:29:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D53C84499
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 03:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOFqJF1BjIsl5b4sx/CRUa+gxWtpfkeU7ayemB5fMN1vu7uU/JODD9/jAmFEZllbNlJy+Ts8a+Bumus5fQLz2Cxe+xBFXq6MmtEXAkNVmCkqHj7qs3B8I+iSbG40R1Iz2WhA9TYOadehFUZJ0LcovYqWvn9xllW40BmBy6RIJAkfDosGTs6VAsr13hXrtOwrTD+W3vkS3CfgKyZpzCghHr5EUiQ5nSqzo/wcCNyHyHGYfZOjlqAlbgOJ86zd7lkMPBXQxRwd5pybwdb9MJ07cc/TUpVVC/A93w3EAd9nlTLczVjfzwzqKtucqOn2FL8LVd0f724YVU/3zZtPniJIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb1K9Aj5sVdO/YgAqWin4RPpJeDfOdGMLdnSV2hxBhA=;
 b=hZ6dIunJCm+tDBYXL1gvU0IMSaJq+LmxGHh05OQFB28NNa46H0QPFgrNX5q9yIlXPDZKtLlsIT7ZqwNLPLsxeAGMJREn0ebMb1SDsu6pTQhL7mUw/dbvMxTYKXv4aFNz4zuRbfhpfCFEUn5qd5TWfwVosE0NEsw3nczYHg8NHEYl7/GO2Gmb1wMXk72Y18/xQyc6w76Pf6dBCbT4EH/sPx/IfeoEPJPk3fDGhL/vhadyE7Z23zeP5gz+ESvar5VJHQfNpEI+qjRgh2Q95gmQLrY24pNBJ+ODXG0ZqZddGiQiMuPsuJ7SwWC7jBtP7hWmJqVIWoKlHzvCTcyHYuYahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb1K9Aj5sVdO/YgAqWin4RPpJeDfOdGMLdnSV2hxBhA=;
 b=c7jlGXY7MhYsrEl4+32vbX48cKyTNFznt+oTSvEdRG5V1a70V7xMCAsx9NsNQtmhzCD1LX0bjd8nsyxuiyY7hu8VlaxxNBn0Y0mw3rtJ/gIJTDd7mqldc1K9+w3jot2EUCXwuIZ8OOcvzjqQ58LUm07yGjbH7kFXtNEW2zmvFjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 26 May 2022 03:29:17 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::8c27:b470:84f9:82b8]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::8c27:b470:84f9:82b8%7]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 03:29:17 +0000
Message-ID: <dac2c654-cb9c-6554-0afd-9e8db012374a@amd.com>
Date: Thu, 26 May 2022 10:29:09 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO page
 tables are in used
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org> <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
 <YodMvV/8eii4KCLg@8bytes.org>
In-Reply-To: <YodMvV/8eii4KCLg@8bytes.org>
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fb3c4ce-9bd1-4675-1c08-08da3ec7e9c1
X-MS-TrafficTypeDiagnostic: DM8PR12MB5461:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5461EBC51F2B8B1799E13FBFF3D99@DM8PR12MB5461.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppu3l/lHBk0d8iJ8FDqKXADfhDmeDqNJSpm8T5keQFFpqhz3T0KXteT6gfZAFclrQDn37j64upuoQygW2SBZLO0E52CAgHO41KyCbnNaCIRglxxAHXyh/ToamfikEnPXgobdxnrF1ibFg82rMqrmakGLXLPTywsyKSXWNxlHkr03WarUnkIWmUtIvbx3nTZToIgPDMR36bAk3jPt2QUFWwtEt4TiIZirMb0KnwwUJhR+iHNCcmEUyO5raos9uJd5DuNTPtqFFD03iGuAHzXTyraZCk/KFnhgcCXL/4VSe//ICqBRs6gs2xRWw1n9N8TsdP328NjIwrjpX4g625MG6MTGAiVQcbu6cpRsJP9Z+hV3rACTESenHTfc2pJ1KGxLYgzfYPWHB6LV8MFRUzhedw9c0SV0766bcu6H+PM3KfkSt7vxuFUV7yDl9ZVcceuB3Lc5a6hANyIFHBD2R0vSRAXYDve8xq/TsL2uQGL6RyI5otSoVtNsVRDkvysty9oJMavSAbVN1p8VmnyMoK/orLuU8ZA+nTNKjQJ/lxlbH70eq2Vk2BydhRybLhIwTyg4IK+bmyep/TW5A7dRSit2wnLZfIvfzF+BCwJ6TjGkblDFWytOdr5EdAv6zr9fuKG47P6W6mGL5Stn/tFWIFVTdplL7GCAGXixux6k3j7lIDP2lf5bq4mYHoKsnANQebzm5I8Dmm71oVPiEB4amZwzfYPfWs/lT4PLfJnTF4ghfbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66556008)(2616005)(6506007)(6666004)(53546011)(316002)(26005)(6916009)(31696002)(6512007)(508600001)(66476007)(8676002)(4326008)(6486002)(86362001)(38100700002)(186003)(5660300002)(2906002)(31686004)(4744005)(44832011)(36756003)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFIWnNDZnBuL3AreWhOMFpBN3IrRWNWQ29XL3F5QWxIdHovd05UbGtDQXlT?=
 =?utf-8?B?b3ByMXQ1THFjaml0dTBNWWhIQlFYRGVxOVVyR25EaW1oZEo1NWtvZXdnR3Az?=
 =?utf-8?B?ZHdBSDN6azJZOVhmcTM3Zjl1dm1XdklBWHRTZmtKcXZhZU1ydEM5aUQrMkhV?=
 =?utf-8?B?TDB4QmJxckhEQ0ZRS0pqTC9zYnVubUQybk5qZ0hhSlllZm9acEhPWGltd1Iy?=
 =?utf-8?B?QnJTQVNDZElncHIrbkFsVEh4eitsVEYxeS9SV1RMZXBuVDdFVit1OUlNV3pV?=
 =?utf-8?B?d2UrTk1Qam1tclFQdDYxdTFxRG5SbUJlc21tcHhGU0RSbzk5SFJlZy8rcmJS?=
 =?utf-8?B?YzF2YmVFL0xmRVNIZWJKT3RJTDJiTGNiVkFmOXRxUzlOeGxweC8rQjJLZ3hR?=
 =?utf-8?B?WjB3Mnk4NjFZeXdBbXorMEhzVDZpS0ovb1ZKOVFySWlEKzNiU3ZhMDRteXJE?=
 =?utf-8?B?ais4OThyMjNyOEhndmVCVXkzTmczM1VqRjNxT3U0eU83TURuRTd6R3had2Zo?=
 =?utf-8?B?dnRxSGVyKzB2WmJNcU0zTXd4eDJ0NDIyRFBHZlhJOHFPRGJtRDlDVTlFV1J4?=
 =?utf-8?B?SEo2RVFYdGhjbUM1UHdBT2lQRU5zR1ZiWjNwS3I5TUVxL1l2bGZQNHN4VEJm?=
 =?utf-8?B?c2tEUmhYZnlEWGRQUUF4OFlSZisxK0RIMWcyT2ZEVVR6eHl5TE5LZGRSUVZQ?=
 =?utf-8?B?cEY2WUI3V0xEcEsvUVJEeTE2WldvR28rRUtHeVl4RmswY2xadVNtTm1kT0V1?=
 =?utf-8?B?SSt5WThsY1NwYklyZUJwaUhvMHZWMVRJVHBrWUdZTEN2UE53dk5HQ1hvZ1Na?=
 =?utf-8?B?UTdsdG9TVlM2TmU5QW5WZVo2blg4bkZab1NvRllaekF5TzBXLzZBUE1hV21l?=
 =?utf-8?B?R2hDRDFvU0h4RUErY1hJVkpPUkJSUzJoT2FJT0RBTjgxa3dnTFhRUVhTclhG?=
 =?utf-8?B?THJRZVdxZE9QK0VrS2FwbzVCV0RmNFJIRE1uRUVsWkpMRmZ4R3F0NE1rR2hQ?=
 =?utf-8?B?dG9CNUhaMVBUZHM2Q28yVjYvVTdqUFk2WlNiRi9wV0l4MmRDODlBMnhvUm5L?=
 =?utf-8?B?eTJRN2pVdktma0JRQWxuVG41SVRxNExTVEppMGl2TmV2cmd2MHA5T3R1Y0E3?=
 =?utf-8?B?WjZSRXdGT1ZhMEZ2UXlZeG8xYXJnK2FxTEVvWEJ3R2dMVnhBWGJhaytBZ0NV?=
 =?utf-8?B?ZlpEa1RqQWIwMnc2RittZ0huUURnK0pPNXNuMWxmaXBkc0dZRSs1MGw4U1A4?=
 =?utf-8?B?WngwOTdRdUZYbWZYTWVRNVJSN2tJU3dyZUtSR0tMZEI3Vmk4TlpJWWg2Q1Z6?=
 =?utf-8?B?aVdhTW5aMGdicjg4eXZmNWN4aHVaVGhyZXZEZWNWT2ZuQ0Fvd0lJZWZVZ2xM?=
 =?utf-8?B?THZIUUhSVDQ2Y0o5WllqNTJHTVA2cWJqNWRHdEZDUnMvTHN6YWhBVzZ1Wkx4?=
 =?utf-8?B?NFlpYi9GekxmUURLYklUWkJ4YmlmNUFwNFFZa1hMNlZ2cjZjMzIrMUxOTlV1?=
 =?utf-8?B?d1QrTnlaOVVwVytBa053VXBXWmd1amRMS2c2cDZkWjZhRjhOaDFmRVg4Z1ZQ?=
 =?utf-8?B?ZFV4cEExSnEvY2FoUUNkUzdrVVd1UkY1QnVHYWRmT0RSZkhJQmhBZmdGT2pN?=
 =?utf-8?B?cTMvMGhKbkwvMytYWTJwSENZUHdZdXRvaEJTRDRXWmpLWFQ0eGFDV0kycUNB?=
 =?utf-8?B?WGxwRnFnRm9qNGpzYldWSnc3R2xrVXVLNGU0YTdxTUtlemtUeGJxcnVsaDZB?=
 =?utf-8?B?WmZHczdHN1VDKzRObXdTckduN3lMc28yeUVYQzlRRERGa21EMEhlazZBV3Vl?=
 =?utf-8?B?OWNSaHRCSklXL3dMWG14Y1ZyMnZjZzNLcExDNWdETnorZ3FuZDJzMnQvcFZq?=
 =?utf-8?B?Q0ROdFl0MWl3bnRSRlhyU2RNWHNXWVZUR0tVbzMvcS83T2J5eGxhdXh3V2I1?=
 =?utf-8?B?aW83SERtSFd6Nkh6cW1lYkN6MXRPelZpdUg3aE40SWV0dkJKWHpLOE1QajN3?=
 =?utf-8?B?VHFOYzAyaWY5M25wcmE2Nld3a2IvdkdQaHVsQnYrcXdncXlzVTZKdjMvd0Zo?=
 =?utf-8?B?VjNBWEMxY1lRbVFHQ21vQjVPRU9NZEUzSVd5cEEwV0FuTksyekk3VVFTM2J5?=
 =?utf-8?B?alNadUlYa1hTZG8rbzNJMWhUVUdCZkR1eVIyWVNBczNBZkpMaDdIT0dsVCtn?=
 =?utf-8?B?SjNjcGJ2cXZ4MFpXRWIxc3czdElnRTJXcWwycTVWWHlkSE5zUHJBeURRZ25N?=
 =?utf-8?B?cUZoZWtObGVVT01KcXQ0dHpQc0pPdUNsbTY0TGM2OGdRMFdPMFJMbEJaWU5O?=
 =?utf-8?B?T0doOUppOEl1Tm0wUUNQdjV6cnRKS01INmd4eGtmVndIWFVqYWM1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb3c4ce-9bd1-4675-1c08-08da3ec7e9c1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:29:17.0766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8LbmZ3uNSL8LJwc6dd3e2Pp+zM5RBHriiGMchIph+Jqa1petpDOP2Vosub/WiY8Z4jz9zkR9hvChXWeOvNpBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
Cc: iommu@lists.linux-foundation.org, jon.grimm@amd.com,
 linux-kernel@vger.kernel.org, vasant.hegde@amd.com
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

Joerg,

On 5/20/22 3:09 PM, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Mon, May 16, 2022 at 07:27:51PM +0700, Suravee Suthikulpanit wrote:
> 
>> - Also, it seems that the current iommu v2 page table use case, where GVA->GPA=SPA
>> will no longer be supported on system w/ SNPSup=1. Any thoughts?
> 
> Support for that is not upstream yet, it should be easy to disallow this
> configuration and just use the v1 page-tables when SNP is active. This
> can be handled entirely inside the AMD IOMMU driver.
> 

Actually, I am referring to when user uses the IOMMU v2 table for shared virtual address
in current iommu_v2 driver (e.g. amd_iommu_init_device(), amd_iommu_bind_pasid).

Best Regards,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
