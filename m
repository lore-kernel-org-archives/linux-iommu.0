Return-Path: <SRS0=mSd7=HI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADFEC433E0
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 04:03:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AD764F06
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 04:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AD764F06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99CBF203D8;
	Sat,  6 Feb 2021 04:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGyYvnryC9lP; Sat,  6 Feb 2021 04:03:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0D64D203D4;
	Sat,  6 Feb 2021 04:03:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C04D4C1825;
	Sat,  6 Feb 2021 04:03:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B113C08A1
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 04:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1218686C11
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 04:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZoDcd3-x13vB for <iommu@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 04:03:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 233B686C1E
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 04:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2/rA14hLhK8dhLb49wV/B4n9YMQ0trO0l6oSFqZE7r8VvZEbFIg5SGEZyk2u7hiWj2sHJd5r9t3K0qi1O4jzzPepYkxRA0cIqXK4Bz126IxWWErw5xbJcyxLVlkFxp6pesxpa8BjJNboHclU/HgbVvRkF7ytGTT/KqN4NZQACxg3tzIXh5xYcFxd6TUGS1nVAOSO0Impi+JpaXbY6yYerVvGsv5gAPFQyenyzR+/bZvJFUvTNxNPXNkySCLFDX5XwogaNslQb+Fj9tcOdn6pRgcp6Vgk0HCGfRpappl3iYEv/7to/Zdidw5SAB8Of06WIKJFcyQsUuckNwozxjvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/GzbG1VtPfhxyDvIcmhQYiq13KQFTKXCRrbdwoVZb4=;
 b=EkQvR8OFhZPOQojWSSFk7PF8HdzWLjyEHFlmZPdHlcq5Eqkxz7H2VcR7slOac0zZMgIUYEleNRI0B0p8isCTIuYi43PjYUwXKhjJlcGBx8NTHcocrOu3bVXSRMAF9ga0KBu0OYv2PdHuU2Kkf1We+f8uIoZp9TM3m5UZzmnb5Hmud3xA9qcJVwB/fs9r2TuEpOABP1wU984k2YmYdVXKJCXCxhozVTPyYJMRt8vuvPIh5DjAf8gvMH9U8nXMs/tnalBHp2AUP2HX2YBkOlFiNcPUR88cZfSwFCu6QKantoUc8cl35zPza2ml71Mp2mp1eFlRCYG/P2Pid5rCqbOgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/GzbG1VtPfhxyDvIcmhQYiq13KQFTKXCRrbdwoVZb4=;
 b=E13tZ93QXd/bsYUu7FP0F+Wf2s0xhPoaqjtiQwR4DQubAX87GKwCoxHSFunKqWbAz8rNbGFJYqcY2wZd8yKM4kRckJfA4nxjQ1yiLphgeOZtfBlX9+q2uu/ysDPvj2xxYCCC8DQdByLKYWSoPtranvIBiNHkGBswFz6nO7aaYo8=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Sat, 6 Feb
 2021 04:03:00 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3805.026; Sat, 6 Feb 2021
 04:03:00 +0000
Subject: Re: AMD-Vi: Unable to read/write to IOMMU perf counter
To: "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
 iommu@lists.linux-foundation.org
References: <b44a9f38-adc2-f1f2-d544-c907920a7452@elloe.vision>
 <9ebcadaa-301d-2b59-04ae-be9a243c7ac0@amd.com>
 <00a54bdc-6495-d43f-744c-0df269e5d3d6@elloe.vision>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <e868f04e-7754-310d-aafe-b8ad926359d7@amd.com>
Date: Sat, 6 Feb 2021 11:02:50 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <00a54bdc-6495-d43f-744c-0df269e5d3d6@elloe.vision>
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KU1PR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:802:19::22) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by
 KU1PR03CA0034.apcprd03.prod.outlook.com (2603:1096:802:19::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.11 via Frontend Transport; Sat, 6 Feb 2021 04:02:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f776e66-040b-48d9-2d09-08d8ca5417d8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3192:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3192870A0B88FA39AFC1F28DF3B19@BYAPR12MB3192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZYJUA4jQ38qbVgbU1fat97dhhzgu0oXb1TxXie3c6nGLoaDjhFWsBdq/cwXfmv80zhT4WuIlGP5QBvSsvRQxPWFOwsgoXetNCr6n6BRMYprnM014Q8UtMZn9hBlIzaZqZeknVVIeFyng79P0kxeLU9otUsq31nOC0sBFwcFHfCsTZGg0XFfBW6CV7FqDYGb794SHOBwZI2cD03WgPSjoGKcevKNlHlYJyZdj6HgX8puEwzWpj8qlg5GvPe4BCACFaX/rmymW6WGaGhE5STZ8szR2BHX81hkm5FovWFZMgLXrM6IqCuDG5f0JX1JeENAnDnlg4tEJ6YktEavNZbWxeF7PMCXDVa8Qb1/d/vB/wlODOf4RlrYAneGsJO4j+KHAGSPhK0hwbavZFa+zOhc2XWl8gSnFQmgPXJBuLPfYuOaVvS2kVo2AKxQBWbYyFJ4FHtKwqmX8BAENzTdqaswsd9w9nrO2xCx8UiNiBhMJEtjsoWMd6FGO8VLKyyHCRxldZ8en/m0+YCvWHLO55dEJTF+YZqm6TO53FZNoj77PGj0r2hcAQB8FW25gYAvc9rl1xjS27GSoxubjeXV8VI8Pif2+T5C4bTssGbikIgf741i9hQi5Aest9qrcBhnhq8u1IxXnTAHyww/n+QRtZR/u5JGRidLwVoZrBImwkfCqrczqo3mgYVhVByDwPLKeDIO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(36756003)(8936002)(5660300002)(66556008)(2616005)(44832011)(66946007)(478600001)(66476007)(956004)(31686004)(6486002)(26005)(83380400001)(966005)(53546011)(6506007)(52116002)(316002)(86362001)(2906002)(31696002)(6666004)(8676002)(6512007)(16526019)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aDd1aWxNTlhMWGk2cVpvT2xSdmJhT0QraDZVdFJzK2FDamZ2SE5sWUd0czJW?=
 =?utf-8?B?Y3kzM2xVWjVoT2lGbE1hS1poTHl1QlRwTUExVjcrYlBYa3RQbDMyblFLZFRa?=
 =?utf-8?B?alQyY09MNFpPeWNPVm9xSTFwbmc0eFlnNWQwMmdVa0h2L3BpYjZyMFYwRGtt?=
 =?utf-8?B?dXpTcXRwdytaemVoQWxscjR0RDhLQ0tOM29MRElJbWd2d21MbGNzYmhtL285?=
 =?utf-8?B?UFZGb1ZUSVVmeEdEVlE5SUxwVFd5Q1p2NThPd000TlBFdHRXUDU4SkU2eEpW?=
 =?utf-8?B?SGN1ZHo4YVZiOE9YSzJvaEV4WncxaGY4M3lhVlpyNEV1V0FGYXdxbXdCOWda?=
 =?utf-8?B?THBHZHRVM3R1QU5GVzNKOEwvT01yOWo0aGZlVC9oSmt6R2pQWWYvdEgwWEFs?=
 =?utf-8?B?dHBWM1FtR3d2ZFJabnROZmx5dWNpU2NFakpzd1dsZjVyeXJEWVhHSzNHODUr?=
 =?utf-8?B?eVdZd0huV3hib0tqVTB6UWtzMVBTbVlnbzdNWFlZK0lZQ3FMUWtoU3JPZVJ2?=
 =?utf-8?B?eGFKeWp6RnFJbVNYMWRkaHRWc0M0Z1Ara0dyL3p2d0xVOW1Gak9mT01mK3BX?=
 =?utf-8?B?eS9GQVFyYXk0YnFSWDBNYjZkN0pUVmluc2lMbXUxQzE3L3llcjJieDZKa3NV?=
 =?utf-8?B?NWk4d0NuSUtNUnFkeFdJS3FEeVhuMytORzJ3Ty9BTFVSVTY0K2ZvNHJuYmJW?=
 =?utf-8?B?bkxBV3VBcmVYQ01FbGVrUkZMUXBGdU5haGdNZGMremlpUG9xdm9KMWszODBp?=
 =?utf-8?B?cE9RUlUxS3h6UjNna2FDeU5QNGJQMHY4cENPM2ErNlJ6OHZDWUh4VEFneFBp?=
 =?utf-8?B?OGxFRDFWdTVmem9LcDNxcjFFVDdPcVNtbGNyZ3FLMFZvZkZzdlJvcEtnUWJk?=
 =?utf-8?B?enVoVkhCWStkdWV4a1ZycUlqOUpxaEpQWENnY2k3dHptQ3VnTnhFWVRWRGRB?=
 =?utf-8?B?dzlQbEVpWGlrYmpEUUtUcDV4RG10a083c0xwM0JQRC9EUTlHMlNJWDRpL0tt?=
 =?utf-8?B?cEZwYUQ3WmlRYm5zZE9NWTZnaU5kYnJ5cVBPN0NMWCtBeG1nYlVoSHlnbENa?=
 =?utf-8?B?N3ZZMUdJZ2JyQXFCMFgxWFRxU2RjVEsvQ0RlRCtaMFp5QmJ5aWdpNld4ZmNH?=
 =?utf-8?B?aXh1YkgvQTJUdGR0M09XaXFPYzR2SEFtZGJ3U1BJalNFRlJ6aVNSUTBObkVW?=
 =?utf-8?B?OGNOSVAyU2luMUFwejZ5ZVFLRGJwaWNkUWFMMk1taDFNc1pqUi9IYTJ1YXhy?=
 =?utf-8?B?UzRFWHFHa0pOSGpVQWZLSzZpM2RQT2FGODVSSmg4OHdQSWRkd2dmVGlrcStQ?=
 =?utf-8?B?a29ERXlDWmxDN1BLcnlLZEg0dExrK3RvdE1wZWwvNE83NlRXUjRUbjRKbzND?=
 =?utf-8?B?TkFtQXhraEc3ZDVxcmwwZEsyMzcrQ3pZSDNIU2tITFUzcGkzRkNGaEpjRmx2?=
 =?utf-8?B?d1ZqQ1NjVXBVM00vNzUxT3lsTEIrNzJUTVVZdDRFRE02c1ZscVVPVFI2b3VI?=
 =?utf-8?B?clhnaWFXY2NBOHFVZXRweGNpMzFkVnlrVGFVeGxKa0tTYjFoOS9KM1BSOWw4?=
 =?utf-8?B?NDFyanczdCtGWit1ZTE2YmJwUzk1YlZqVmxxU01pSWMwZzNCeEk0UXNYRVhw?=
 =?utf-8?B?RGY1b21PSm02ellUU0NJTGpvSFJXTk14N01tWUk1WDBNTkNXdG0za0I4eDBG?=
 =?utf-8?B?elpWQ2J3TUZNK2xROGtwcFhNRW9xa0w2UmNaRVp3REpYVWM4OVhHMitNTEdT?=
 =?utf-8?Q?l7aFDEWqmkD+RMn6hSi8rOqD9F2yIt3QohLFzwV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f776e66-040b-48d9-2d09-08d8ca5417d8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2021 04:03:00.2779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYW2/xB+POujN70NowW7J+gBu1IEEOOy0MXIuZ6gDeS8zZF3SKjGItPDylCdjFddbEIng+jYZercAAmiMfmtOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
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

Tj,

I have posted RFCv3 in the BZ https://bugzilla.kernel.org/show_bug.cgi?id=201753.

RFCv3 patch adds the logic to retry checking after 20msec wait for each retry loop since I have founded that certain 
platform takes about 10msec for the power gating to disable.

Please give this a try to see if this works better on your platform.

Thanks,
Suravee

On 2/4/21 1:25 PM, Tj (Elloe Linux) wrote:
> On 02/02/2021 05:54, Suravee Suthikulpanit wrote:
>> Could you please try the attached patch to see if the problem still
>> persist.
> 
> Tested on top of commit 61556703b610 doesn't appear to have solved the
> issue.
> 
> 
> 
> Linux version 5.11.0-rc6+ (tj@elloe000) (gcc (Ubuntu
> 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubunt>
> Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc6+
> root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows 20>
> ...
> DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 ) 12/23/2019
> ...
> AMD-Vi: ivrs, add hid:PNPD0040, uid:, rdevid:152
> ...
> smpboot: CPU0: AMD Ryzen 7 3700U with Radeon Vega Mobile Gfx (family:
> 0x17, model: 0x18, stepping: 0x1)
> ...
> pci 0000:00:00.2: AMD-Vi: Unable to read/write to IOMMU perf counter.
> pci 0000:00:00.2: can't derive routing for PCI INT A
> pci 0000:00:00.2: PCI INT A: not connected
> pci 0000:00:01.0: Adding to iommu group 0
> pci 0000:00:01.1: Adding to iommu group 1
> ...
> pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
> PPR NX GT IA GA PC GA_vAPIC
> AMD-Vi: Interrupt remapping enabled
> AMD-Vi: Virtual APIC enabled
> AMD-Vi: Lazy IO/TLB flushing enabled
> amd_uncore: 4  amd_df counters detected
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
