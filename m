Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E24C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 14:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42A4983E6A;
	Tue, 12 Apr 2022 14:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xpQWuF85ngq7; Tue, 12 Apr 2022 14:57:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E48CC83E4D;
	Tue, 12 Apr 2022 14:57:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7776C0033;
	Tue, 12 Apr 2022 14:57:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A932BC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88EF0416E7
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ze6olqhGchcC for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 14:57:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD4EF40353
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMW5XAix052TY9lNluzl3JjeQH5ZThR8Qhw5xAzWsqGSVGTIO7h10Y9vWa4DTWmbPCGoO6oa9eOhd5A0FAftfoVjlOZwg2rpBzguxYWeQAYcxZzB2JbWODRCykCfCEiYOkkvLQ+Yrtaoztj82QOb/iL8cUM4rJs8US6yzb8H1MoO677+ZKe3HtEMcOOdMhqwFCBJDjXI+bZm5uHEvLdm8hd0i0lboFcLKkZlmfTXXAW/4FBFacbFoHBnKg9SQ1v6SyMKTF4dS1BrLUp5O8U5LX5paqjVBoE2UyeeYaRUBvZfCK6T2352A/HaH9xDXVAA485uNAjH982Jq60pfKnH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apHweCYvjul8dqQ4ds8F0Dfa3IjjtWLxL/Gy28Ap+Og=;
 b=nEa4GqNLeN1h7wU6WRWMhm6JRFYANTfjOrSdWCc/xnXVeJ+a8qrM0Mpb5w/sQLHs3+Dw2XWByZstCwUDTLeFl+OOPU6shB2E1LqF2pTwip7CTjGXlH0OtUuPd2ywRBEVtKYtyE+xG+k9mM1CYyhyQ+7wckuDbKVZWHw8ue3tTix5uoAukzMHSy1FW8mEu4+95cbBkTK68rHJd1H7P6uzIrg/GuvbgRzcyaKLCPVpxrr1eaju8Z/7qh2vA1L+7KXwnz30I25kAGn9dG9PRy+u67YCqWHX4B8RRmpVomXLCxW26m+r2+tFHucgrNWwcXSaz/stZejGEbu/UeZnSBIlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apHweCYvjul8dqQ4ds8F0Dfa3IjjtWLxL/Gy28Ap+Og=;
 b=ouExFzTDek0aCOVgEtCaXXynO7aQ90ZakpIDrL5E7yW6ijZzw0YcXd41kHHY54/yadlV95DlNxPlvZa/HRCDoyuSWV4Cz+hbBkJPdypVpCPc9C+HQaf6Um4cT44y1nBlL6REaMFTWt7LDz1M07qUFitBCaeRF2JEnNWdQatw0f8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 14:57:25 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::58e1:c61a:5541:7668]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::58e1:c61a:5541:7668%7]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 14:57:25 +0000
Message-ID: <a17ce6a4-4378-7dc1-0c97-1f9bf6900461@amd.com>
Date: Tue, 12 Apr 2022 20:27:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RESEND PATCH v1 00/37] iommu/amd: Add multiple PCI segments
 support
Content-Language: en-US
To: iommu@lists.linux-foundation.org, joro@8bytes.org
References: <20220404100023.324645-1-vasant.hegde@amd.com>
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cac126e-f4c9-4aab-c51d-08da1c94c176
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38957ECD36E98D91FA4F44C687ED9@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6USQJSxjZaryFnEI7l+UxnB23qr/XFPAdVIbc4uAzvTyBVIn7lhqzPLl7vX/0T6oF13sMTV2xFx/QZkYequ4jonD77K1XqUOF/iMYDt5x5H3euko1GkL+ez2Fc3Aq1l4sXQ2S4Uw/J+COUq2jNf/U3UWPnY7XGobs4kNC9yaqe53FGK11i5dqbckDpkVhOfirjMTgxoXYYN0Sw2QpRtsqkFS+PjpUNguBmFpW8hgPLjkuls4xHTIf3bZPAuqflH+CZKRapkr72glHwYuNxdVcPA5FzIf08461/QT89S7iAy399cqgCSW6m3E+NtDILZhU9vyKuLhuDe3govXqj6tL5BNhmcEXr96Rmk7owne+TIpWHJ+/KY/Bjk/wvWY5HPCEmFgAl4f8KGfAga0PJ8cttCsjGMw3ySLz0n1Ps2zNhPoeyWPKgtU9pAE02DJGphSU5st/7O6JntbkJ/1hZrrorJ/1Hkm9jYOIS/sShDLEhRQpX3YKV4K5q7tOTV22YQvNPnG5mFWxW43rEma92T4MvJYGNP+35AzcllDIhWQWxc2aOJCa9hmp86fAJtlHzWgpaIH1J+gcfZJC8pTVX4pHF7PHwev/lbXUEYvS+omJa586xKSPRNLnCMiCw9i+1vBtBd/5RScsufDjZLNzrNAncGN20ePakJ5xfVXlpVv7aXOmjN88+SLmO+SWmV8AxpBDRhNgPttI0o6ZeCRoXmhoKJ2PJf/mERA1se7zF52g3efulfeDKCy8Thc1WLBJkeMD7Q09dyi2Vt1H1YOotywUZm+1q8HMX5UMdr1iKw19q7p+UOqnwrgOjDNRVJFD0plPvKn80vS6B9z5H7zMy/7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2906.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(36756003)(83380400001)(5660300002)(31686004)(53546011)(86362001)(966005)(508600001)(6486002)(6666004)(31696002)(38100700002)(316002)(6512007)(6506007)(44832011)(2616005)(26005)(186003)(66476007)(66946007)(66556008)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRFR1ZUdVZsTFc5djFES1h6Z092U3lMNTcrNmV3TFdwaTV6cWlEazFoS3pp?=
 =?utf-8?B?THRpV0JtRVhsWG5zNlJlWVpEUlAyQ0VtcWJDcGpGY1VyYlNzZlRHTFVIb1ZM?=
 =?utf-8?B?RU1TQnpBbjNzOGlJS0JLR2dwMElWbm5oS3BkWllpU1l6VW9WOTI2MFFuYXlq?=
 =?utf-8?B?dXN2TElIaWlzYXAxSCtqT0FncHdXNUJTcnRjY2NWS0ZpVWdJdmtYSlJvbDFw?=
 =?utf-8?B?K1NTbCtTR1BxOXpmQnBVN1hFMVJ5cUsvYkVYdEQxZERKS21JWmo0bXpUZU1i?=
 =?utf-8?B?VnRaR3NsZVVlbFQ3NGhud0Nwek5VK1YrekZWUitBUTZBalE4V0R1bzNDSG04?=
 =?utf-8?B?ZUF2N3kwZG5Bdm04dEp2cTMyUUlZOVpRd2lxeHhITWdWWHdVUXhWaDdPYisv?=
 =?utf-8?B?ZjZXSmhSalBSa0lmVzdaSkY1SUFQbkpHcUY5Z0xqTE52OVgzb2tVQ0tGRkxv?=
 =?utf-8?B?WEl1RHorUHA4Z1NaTjAwRGgyWkFCOWk1c2k1dUdUSHpJL3RWT0ZybEo0ZzRF?=
 =?utf-8?B?VE5Jdnlud1pXZS9Ha1dXMW1zeG1JNy9JRHRvcTFUSFl2RGd1bDd5SS9LQ3k4?=
 =?utf-8?B?SmNoaExGeUtNbnVPMmR4UU45UUw5YldYREt4SDI2UndDRmlSK1hQM3dzcFJP?=
 =?utf-8?B?STBwazN6bUg3WXl4OWtRTmhCejFXcEpRaWlNb2ZSNTlZeGFqbkJTQ0ZwSjRh?=
 =?utf-8?B?NXZuVVpQbWtEQzFnbVVnT0ZvenFXQjJhbDZtRWNyVWh5YzFKSytpUythYk5S?=
 =?utf-8?B?OXJsVU9LOE4rc0t0UCtrSFZKbDBSSTQrRnFIUHY3U3FkWnVDekdvcGVadEtq?=
 =?utf-8?B?RFg3Q21iV3VmQnVBbnE4WTBoNlhtbzg2T2l3NEx0S1JndmFJK2duU2IrVHM2?=
 =?utf-8?B?L1BmQlZmNFA3b1d6MVFoQ0d3cVdOSmpJSi9sU0JmT05hdjh4U0lzZFBoL1Z1?=
 =?utf-8?B?dFd2UWdWSHBGUFRucU1DSmgyZTJCVjFpMXZZeFJMVnZDVFlaZ05zM0pCSXFw?=
 =?utf-8?B?SHUyQjdrNCtIK2NOWHdIeFlRazU2citqRmRxVStNb0JNTytZbGlvU1hZODF6?=
 =?utf-8?B?L2U3NExiT1Zkb1E3MG16S2pTa3ZvWFlGTGdTVi9FdU9wb2tIUUlENlRDZFZs?=
 =?utf-8?B?TkNXbE9nUzc0Y1JZM2xFTTJOazlTV1Q1Ny85SEdBaTJkOUM0UXJZUTBqSWp3?=
 =?utf-8?B?Z0VILy9EUkdzNzV6eVNuVFNKcVFlUUJBMFhrYVczeFlBaUpMclFUYlhJWVY1?=
 =?utf-8?B?TGFPaGZibXpFSTI3K0xadHUxRjdrNUlIWXFhMEhWR3ZKVVlVV2o3ZDdOekd2?=
 =?utf-8?B?VERCWlFtTk9hKzU2Vlo0TUhLd2pkUUE3TUNCRmRnaUxSTVJ3WVFJZmFmbjl3?=
 =?utf-8?B?R05qRmJvdXZLMm56ZVNuRWZpZllWZ1RXY3c4azE0bmpRWCtaS0MrWUwrSlQ1?=
 =?utf-8?B?MWtpdkVDNUJiNmJ3cVc5RDYwMzhNWHQ5dlBpUWN6M0F4aHRsT2Nib0ZUUERC?=
 =?utf-8?B?S3VTVnpTTGVYTG9pUFJ3dEFsZkMyRkdZZWVZRUFlZmZEdXc0OHRlK241cVRM?=
 =?utf-8?B?QzZqUk03TGNmT25VRjhoT0pUMEk1bXN0WVdXVnMyNThtNEt4T3JuaW9WdUlO?=
 =?utf-8?B?UUdSNlQ2ZnoyMzVVZUc5NUkxZnpnMndiTmo3YThUN2xHY1NSSEVsbmRGRERC?=
 =?utf-8?B?R2J1aGdpZGZqM0xXMDNqYnRNOWx6cUxDTzdxa3drS3d4WjRLbGpWTnd6djZV?=
 =?utf-8?B?Y052cXFHd1YvUENhT1VTS3hqU1kvUDU0VVpURU9ONDAwRVhYUmIxTTlIR1pC?=
 =?utf-8?B?aVJSSHBqSnF4Mk90bDdwaXNCTXdaazBscGNZMFU3Mkd4cjJmWkwvT1BsYzYv?=
 =?utf-8?B?Tis0ZC9WK05mYUFYOEZQWU5yVWtWS2FlUnJUTkZnQ3c2Rm1pNDlrSEhRc05o?=
 =?utf-8?B?eFovVHJUb1VjbFRJZWRINVppdHR5Umw0bDZiR0F0a0cyNkR5eWhzSlB1WVVL?=
 =?utf-8?B?dXVKSUwyd01GaTJsTXFNVHRTRnRZaUpLQkN3NjdFVThpREFKa2pyME9zSTY5?=
 =?utf-8?B?WGxSMEszK2J6dnVzZDJKZGxaaldsUGtZaElQcFBWcUdlMEpKSEgyV1dNREVE?=
 =?utf-8?B?VzU5TWJLVzZuTGp4NmZJdjVROXRoWCtjTzhpMWRpUFc0K1RTVDJsNzJMM1pm?=
 =?utf-8?B?L280VWI3L2JxUVlwSTh5TVBmT0dOYTd1UWNBNTcvc1RhcWJrb09BSzRmdzdw?=
 =?utf-8?B?VEFJbVloQjEwZjl5dGNFa3VIdktyVlk2M045Q05ObGZUMy8wWWoxK3FwYU8v?=
 =?utf-8?B?Rnl4bG1sc2p2Y0Z1UUl0clhJR2JGTmNBeEFpTGc1VWNIYjlwTm1SQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cac126e-f4c9-4aab-c51d-08da1c94c176
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 14:57:25.6307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXfPsVvzHCd0Tbeiak5+fgFGdecliE+xj+01645Chkpam2chI9Gv5tZuAOQGn6P2qu92AvQMEI8YeW+CBg3sMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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

Hi Joerg,

On 4/4/2022 3:29 PM, Vasant Hegde via iommu wrote:
> Newer AMD systems can support multiple PCI segments, where each segment
> contains one or more IOMMU instances. However, an IOMMU instance can only
> support a single PCI segment.
> 

Did you get a chance to look into this series?

Thanks
-Vasant

> Current code assumes a system contains only one PCI segment (segment 0)
> and creates global data structures such as device table, rlookup table,
> etc.
> 
> This series introduces per-PCI-segment data structure, which contains
> device table, alias table, etc. For each PCI segment, all IOMMUs
> share the same data structure. The series also makes necessary code
> adjustment and logging enhancements. Finally it removes global data
> structures like device table, alias table, etc.
> 
> In case of system w/ single PCI segment (e.g. PCI segment ID is zero),
> IOMMU driver allocates one PCI segment data structure, which will
> be shared by all IOMMUs.
> 
> Patch 1 Updates struct iommu_dev_data defination.
> 
> Patch 2 - 13 introduce  new PCI segment structure and allocate per
> data structures, and introduce the amd_iommu.pci_seg pointer to point
> to the corresponded pci_segment structure. Also, we have introduced
> a helper function rlookup_amd_iommu() to reverse-lookup each iommu
> for a particular device.
> 
> Patch 14 - 29 adopt to per PCI segment data structure and removes
> global data structure.
> 
> Patch 30 fixes flushing logic to flush upto last_bdf.
> 
> Patch 31 - 37 convert usages of 16-bit PCI device ID to include
> 16-bit segment ID.
> 
> 
> RFC patchset : https://lore.kernel.org/linux-iommu/20220311094854.31595-1-vasant.hegde@amd.com/T/#t
> 
> Changes in RFC -> v1:
>   - Rebased patches on top of iommu/next tree.
>   - Update struct iommu_dev_data defination
>   - Updated few log message to print segment ID
>   - Fix smatch warnings
> 
> 
> Regards,
> Vasant
> 
> 
> Suravee Suthikulpanit (21):
>   iommu/amd: Introduce per PCI segment device table
>   iommu/amd: Introduce per PCI segment rlookup table
>   iommu/amd: Introduce per PCI segment old_dev_tbl_cpy
>   iommu/amd: Introduce per PCI segment alias_table
>   iommu/amd: Convert to use rlookup_amd_iommu helper function
>   iommu/amd: Update irq_remapping_alloc to use IOMMU lookup helper function
>   iommu/amd: Introduce struct amd_ir_data.iommu
>   iommu/amd: Update amd_irte_ops functions
>   iommu/amd: Update alloc_irq_table and alloc_irq_index
>   iommu/amd: Update set_dte_entry and clear_dte_entry
>   iommu/amd: Update iommu_ignore_device
>   iommu/amd: Update dump_dte_entry
>   iommu/amd: Update set_dte_irq_entry
>   iommu/amd: Update (un)init_device_table_dma()
>   iommu/amd: Update set_dev_entry_bit() and get_dev_entry_bit()
>   iommu/amd: Remove global amd_iommu_dev_table
>   iommu/amd: Remove global amd_iommu_alias_table
>   iommu/amd: Introduce get_device_sbdf_id() helper function
>   iommu/amd: Include PCI segment ID when initialize IOMMU
>   iommu/amd: Specify PCI segment ID when getting pci device
>   iommu/amd: Add PCI segment support for ivrs_ioapic, ivrs_hpet, ivrs_acpihid commands
> 
> Vasant Hegde (16):
>   iommu/amd: Update struct iommu_dev_data defination
>   iommu/amd: Introduce pci segment structure
>   iommu/amd: Introduce per PCI segment irq_lookup_table
>   iommu/amd: Introduce per PCI segment dev_data_list
>   iommu/amd: Introduce per PCI segment unity map list
>   iommu/amd: Introduce per PCI segment last_bdf
>   iommu/amd: Introduce per PCI segment device table size
>   iommu/amd: Introduce per PCI segment alias table size
>   iommu/amd: Introduce per PCI segment rlookup table size
>   iommu/amd: Convert to use per PCI segment irq_lookup_table
>   iommu/amd: Convert to use per PCI segment rlookup_table
>   iommu/amd: Remove global amd_iommu_last_bdf
>   iommu/amd: Flush upto last_bdf only
>   iommu/amd: Print PCI segment ID in error log messages
>   iommu/amd: Update device_state structure to include PCI seg ID
>   iommu/amd: Update amd_iommu_fault structure to include PCI seg ID
> 
>  .../admin-guide/kernel-parameters.txt         |  34 +-
>  drivers/iommu/amd/amd_iommu.h                 |  13 +-
>  drivers/iommu/amd/amd_iommu_types.h           | 127 +++-
>  drivers/iommu/amd/init.c                      | 683 +++++++++++-------
>  drivers/iommu/amd/iommu.c                     | 540 ++++++++------
>  drivers/iommu/amd/iommu_v2.c                  |  67 +-
>  drivers/iommu/amd/quirks.c                    |   4 +-
>  7 files changed, 884 insertions(+), 584 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
