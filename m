Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DF7C433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 14:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D316408ED;
	Fri, 29 Apr 2022 14:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DuvECXYOX5lf; Fri, 29 Apr 2022 14:35:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5662B4000B;
	Fri, 29 Apr 2022 14:35:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30C80C0039;
	Fri, 29 Apr 2022 14:35:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF263C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEB374040D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BU96O8oJwL6X for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 14:35:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::614])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CF4B4000B
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzjzUHXZqAasu2nMWAb+P3MdNF1+4t7TT/5ivbZ8TpSGgUTC3TQGoo6ipZItbRe7fuBwCH6HPbmTS6DrJmQszgUgOiFjQjvIpD8pDFINqvCrL173/jFV6lCByGLf8RQ4OhRCbr/ZrGmC1W2dvfmMS9yQvh9OEJBEh3rrAXeQnyUSUhm4ugsWxZNVZlAjuOynCoa1BnfsItjcgfkvULcoUb/J6zgUQX4pRecAOPB/0B9kzn+njj766sL0AXw+BDuRF84ZPXCPlaZLcZVxhrcxDyp5ZQ8dGoFgJ8bPpk8FEXjMLEkpiKS8G2El3NZGt6FekrF02l7wAuBTHDQovK3MwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0jiNM7rehQlyK2fMfyKbbGAkrI4gCNoEHrCMNnUS/Y=;
 b=I+D5HT3A8VDETBTcAVT0/tyOZlMrqpWkYbxqtE7x4HUV44RwF0CuNBo6UpeYyESQn81fhTG8pJO3uwrpHNrU3Ty5nON+ZFjd/MpsXvMhx1Ye49TDRNV5brt6U92FGuCpjOZp+XK8WiwevmGC0oarqxKScVx7i5fHAfQPJvRYvunhOLOQtPDiRTf/6pht9YNT+QIbl27nsWR57079EJIXXgoOWthKbr2sTonkBXke1VGmKVyHqIizC5SAGdTrmwHWGa63i5KBu0etwVPoRuTTt6U86/ApmMgrPOVQ+7yLcykyCG88/UXVwJ6bI1/1qJQNkAjKHfHXE4b6BJSyVTxCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0jiNM7rehQlyK2fMfyKbbGAkrI4gCNoEHrCMNnUS/Y=;
 b=BlcmIZbaX/EZOmeqRG/sz9A9uK9Br5yE2F19C50QX47xBnQf5Bc3vGYS7BVSWf7UHsWnxXfKCHxAmEyT4CHFAJD266ZllXwWYMRfoho+0PSAn0Div//mPSX50hHQQXyDpEZvz/qIHx6WLEK9B7nLm9VqLTkm4WaIBMcOsVna4rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BN8PR12MB2849.namprd12.prod.outlook.com (2603:10b6:408:6e::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 14:35:02 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1%4]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 14:35:02 +0000
Message-ID: <cd5e7070-9478-579d-7629-337ed047d67b@amd.com>
Date: Fri, 29 Apr 2022 20:04:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 01/37] iommu/amd: Update struct iommu_dev_data
 defination
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-2-vasant.hegde@amd.com> <YmpkoYbwu0g4+BAA@8bytes.org>
In-Reply-To: <YmpkoYbwu0g4+BAA@8bytes.org>
X-ClientProxiedBy: PN2PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 867c13d6-8a28-422e-7fe0-08da29ed71a2
X-MS-TrafficTypeDiagnostic: BN8PR12MB2849:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2849C4A663C609FA2B475CA687FC9@BN8PR12MB2849.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWGMCL9YeyyGwcSZgisRX38EG4clOTCUDSTU6S+04vETomg95rcC7OdOUYgCFgHrfiLarSCIhnr6dCvSBKyvOAoPoMz2mSlHMiv3NbcogsEGDQLBKxFByvIlLj046yR7iyiC3mNLehd2EQdv1JGK0wOmzdOH4kPxZljmGuhaft0RLRMGFv6Y6tTYxTp6R7T2JfTcvg17sb0RoUUGonPS/gsBGofpdhpSwet4nhsmZqmWUgQxVUsU6Nfn6jecRMazLIfmsbKy3HPctoQ6TLjlFOQJNpyhk95I5CV32VWYPpIt1/SJC0T1h5QyNWfHhoMbGqnkcQkzf1b/1PD8cYDNt/as3sQQyYmJ50UJqgxt/wWDH88i7AxP0HV/XdPfar+FWnaOjY3TuXlHQVs4dWvu4JxiARCdY2ZZJmtwxJeg2JFwwZWdG7sHwHvaJKFNt/cwUgTJNUAQJwzOvbd9NHuMO5GtvCYdV0PaHjIw/YEOqE1zhiLFJ7dx0s7fCZUI2fyFmojzvfhPEHwOy8JOC2topwpC+cWOwfjB2G8tYR+j0AEvbPW01R/C3H5ljDcTP+8Vt+jqo2H4OFyGIO6LmZOViiTNNz44dHIF4TiJ9xDKrrAM5GvV/qQ/2z9vnyqlIyWoxu4W8cDWj/BRehH0kYTRc/+v2TCe6RENc0rG8KFhqLNVyVqVoPYa04SwEwQ40pMY4YGjeCzIF4s7XYXBBEqRCvc6dP3DX9Edwr/KXFPRee8ME4+1MZyMLlPe+V4/kQCA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(508600001)(86362001)(31696002)(2616005)(53546011)(26005)(6506007)(6512007)(38100700002)(6666004)(2906002)(66946007)(44832011)(66476007)(316002)(66556008)(186003)(36756003)(5660300002)(8936002)(558084003)(31686004)(4326008)(6916009)(83380400001)(15650500001)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NicWZCVnZwanErYWZ2Z3VDUTBrYUd5a0hUcFFYbVF5RUxybVlEckt5c3JJ?=
 =?utf-8?B?dnRQaFNEWHlFTDhRZjVpMTZWeFpGMWxIL2J2aCtveGd3cy9acGZRTHd0Tkgy?=
 =?utf-8?B?Z3Y0SnJmQ3NaWUgzTGpEZi92OFZvVFJxdllIVkF4ajhxN0ZPN1dUdm1saVR5?=
 =?utf-8?B?T3EwZmZ0Y3J2cm9GbmNRM1Vjc3pxZDZiZGJJZVFkMWQwVTROL0g3YmlxTnpj?=
 =?utf-8?B?eWlKMm8vbTllVHlCL0krOEFXRWxYQU5pMWNocWtHaUd5VG1hK2hOUnZrUnh2?=
 =?utf-8?B?WmlaSXp6Vkd3YUFRbG13TVA1ZndqQ2k2RXVYQ1RRR0c0bGpheTVVTFJuNHFl?=
 =?utf-8?B?M0VRMDBIejJrcDV5OXRWZ0ZHUkRWWktCd0F1NGRNNGdYaTVwb01oS0wzeXlI?=
 =?utf-8?B?YkhBVHZaTzNGMS9uV2RQMWluQXE2NytBS09tQm9Oc0NyVTNmY1BSU1JjVXk1?=
 =?utf-8?B?THFZSGhrV0RqWTFWQzBQYkNNNVJubU84WmVkbEFZQitZQXh6cEZHNUNsM0lT?=
 =?utf-8?B?R0pqV3g2UG5Sb3Q0MjBKd0V5Tm1xVnFxaXVyTEFHYm16RG9aNDJIKzJGVXdJ?=
 =?utf-8?B?SXJBaDB0NTE0QTliZzRCZkFKWjdSQ2pGYWRSYkpVWmYzYVRPZzVCZHI0VlVI?=
 =?utf-8?B?UHNPL29kbDl6bFZUNjBEL1ZDYmxLanVOd2hLZnBOMmlTNnMzNk54UC9ZR3dX?=
 =?utf-8?B?akV1Ykg0Vks4Y2t6em5OQ29IYy9vRldNb1RHUkJiWnhnSE1odjFNOWRzeTAx?=
 =?utf-8?B?cmduVDhMRDA2VHE5VnQ1cXZqMXdrRDJCOVRwNmRiWXIrQzNuT3lEMWZRNkhQ?=
 =?utf-8?B?cERXVE1XbzBHZCszYUw3cjM5aGcxRWtKUVhlR283QWVVL091S2N3WHBBSTh3?=
 =?utf-8?B?TE56L0dCcFRqdXlvVDZ4ZllrOHdaTUNUTkdxdEVkRWtycnNIdlBldVFaN2R0?=
 =?utf-8?B?YlFVTzBRTnR4NUtEclg1WnJvU0IyaGVINEZIZTRMNDlzRnlPUllpcVR4dys1?=
 =?utf-8?B?b09GQ2F5M0Z6c0tic2JsU094TlRHcGNzT2wrWkZtNWxXSUhsZFlDRjF0MlRC?=
 =?utf-8?B?TldVVWxrN202YUtWbGY5YUVGZW9OSEhhOTVqcGQvWDd1OTh3UXlNVVg0WEE0?=
 =?utf-8?B?dXRkQWNMTnB0NVBrbGpvMXptTzFOUFhnWXdpN2RSeXdiT2l6VUVid3dzRUMr?=
 =?utf-8?B?Y1pSdkE2UlpIUmVSek9RMnpHTEVQVHpqQWM5cCtNV2F2RVE1Uzg4NHQrekVJ?=
 =?utf-8?B?OHprQkdraXByMXowa0lLa0pYNlRWM3dMK0pPakZtb3hNR2dic0paY2ZrU0dZ?=
 =?utf-8?B?OHhFb1N5REtNeW8xQWRQY2dGWkhiWDdDVEtkcWxGLzNqYTh0VGFCbFdRMTRX?=
 =?utf-8?B?UE9aZDRBVFJ4a3BDSCtRU2Y1b2VlVE53UUs5UjZzTFJsZmcyLzRUL3FSbEFW?=
 =?utf-8?B?c2RBME9US2xXN1FMSDA1VGkyQUJoRG5lNGNzcWo2QlVYUEFrVU9jMVJCYzNZ?=
 =?utf-8?B?RFU1b0FJRTdOOUdQZTFhNW1YclcxSUh6RUw0elY0Q25lVGR5WXdOZ05nTmEv?=
 =?utf-8?B?RmRWRWV1RGZpdlNSTVdWMzRDNmVZZ0VwOU5LQ3U3RFlabUhZRmVtSWh4S2ZB?=
 =?utf-8?B?UDJBWVN0dkR0ZWZKaUNQclluRVVrNGFXSHFiNVNMMFRNOG50NHBrR0U3M1pv?=
 =?utf-8?B?VElKVktTZDIrYURxVTc0dHo1SzhyK3pWQkdFdUh4WUZZTmprT2dqd3ZwVkNq?=
 =?utf-8?B?Rlpob3M1ZlJPdmg5ZDUvZHI2ZHQ4SzNjcmQyUGhLek43ZTVSZFJ0TnV3TG1i?=
 =?utf-8?B?ZjRRQUMxZUxhYVduWjFwVnBLc1c0QWpTa0VEbGxUQnUwdnhrQXFGci8zclpn?=
 =?utf-8?B?aU9oQWgvSUVPbEYwY0I4RUI3NStoNU12SW5PeVd0a0s1RXRTN0l5aGZ2VzRz?=
 =?utf-8?B?c01UOThuTkNyMVZPM05Hbm42ZFVHS2pDQzZqNHZiWGFITHFKSTE1TWQ1MmJx?=
 =?utf-8?B?ZzRXNXQ5ZE84bWJBZ0VRTGxDRmN5dlIwT1MzWUtDMStITmlhNUlNWkcxV3RZ?=
 =?utf-8?B?U2lTSXpGV0xRbExjTjIzZHIwc3BYNGl0b0YxcjIvQmlMMko5UkJUNjhZTFps?=
 =?utf-8?B?TEZWQVFodmFRS1dJUE5hZUxOVnNiUTk5MHI5VzBMNWQ4Q0pxWGVhQ21BQjBU?=
 =?utf-8?B?RlNubVNxMTdKbjdaZkhuTTFQUWVPTndIVFlFVkV2ZndxWVFXdWUyS1hpSU93?=
 =?utf-8?B?cys2YWFHWVZnOUE2S0NNR2xLd1k1cm9EMzJiSWYxQkY4RzFIa09ydmdVUHFi?=
 =?utf-8?B?UlI4T2U4Ni81eEZ0NE9UclBsaHV0Y3FRazVIV0ZvcEt5ZjQ3NnRTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867c13d6-8a28-422e-7fe0-08da29ed71a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:35:02.0402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRHFGGtvSiN4ek/XlkDWFsUucu5FxY2+7kvhBqXgXUiOu1PdiDSykOBhB4trT/MpntO3HIsvI6AwpJBLknwT6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2849
Cc: iommu@lists.linux-foundation.org
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

Joerg,


On 4/28/2022 3:25 PM, Joerg Roedel wrote:
> On Mon, Apr 25, 2022 at 05:03:39PM +0530, Vasant Hegde wrote:
> 
> Subject: iommu/amd: Update struct iommu_dev_data defination
>                                                  ^^^^^^^^^^ Typo
> 

Thanks for the review. Will fix it in v3.

-Vasant
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
