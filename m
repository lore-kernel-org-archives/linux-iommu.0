Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93387C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 05:54:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BF664EB9
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 05:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BF664EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A1DB48543E;
	Tue,  2 Feb 2021 05:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o4TrN53zH0rC; Tue,  2 Feb 2021 05:54:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A6348464B;
	Tue,  2 Feb 2021 05:54:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F509C0174;
	Tue,  2 Feb 2021 05:54:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27141C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 05:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1B89D86C1D
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 05:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rpUovRkk6+dk for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 05:54:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0D64786AD4
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 05:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnc8jrpE6UFpss5adrF2QOsDaFpjnhD5iepW99gkbnZ9OmDRVmPlGsoTNIlq7xzdYJ28kHZwQy+JJ1uvYGFz9qOFDCy9S8x0ktm5yC80tUQsSx3k2XuKZsn44i2Jo0kOgyXlE93RkEgx/qHu6I/Q6MbiXrhlcJhTMDYtBM/EBRJOzSbSBwLr5FxC7s66o9qmsAvYHKXNFLBi58putHfMHL+pu5kqncEMNVjNd3txiFWUP2GZadmSPFzRRCbKhsCaLC0AN3XhlK1Tk7KmhJOtAffzflfq9WL7GptFQt5yFBeiCgMArrxwz0tRVBja63sdtRnFJYzPCmbdXsbx3s9ivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekIdZ+WJd5zRlo+nmSsj6g7OlmtiQFK7IZxkNjpBGaQ=;
 b=j5LRBQfE05pCqBtinIQu8kZF2x29YVD0ysV8E7cQWcDzRu0ln+JNyyJmVC0ewpMjBTlRz6t18nyOS/O8qGHUYfUCuj11Sd+QiBQNzsZ01/UwGRU+mG2K4AMA35coTTDToph65WBi48UBnLPRA/YJCAyw4wIEQAUiFh+Ivm7tIBSH+eQ4axIw8iWL/gFt9wq/ShREMXKlylTTGoCogKUUf/WYHS7YvmALEBEtTgSgg8tp2Zthqc0X9o3w8Cqf9sqdzdoTZyEow4qxZXk8nbeG3aqs7JmrL0cH3uGRcjxVN3pJdMB0Bc7V+dfDlU2U83bRW7UpKcsmIidvpW+kAtbJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekIdZ+WJd5zRlo+nmSsj6g7OlmtiQFK7IZxkNjpBGaQ=;
 b=ooCmT4rsd78/jUw18RbXnnVmz8rAXHF83KddWwgY5HqsBbfdXpNcr4MU3wdYgX49OW846XZrWP7Csb9YSmEK/48ySClXVDy4SQMhjWniUbtp0Eex6watb6517jZVZiDEDZcL+ACC9y39HV1QBx+R1L1/+ZwvzVdGgrgehTzNA0A=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 05:54:33 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 05:54:32 +0000
Subject: Re: AMD-Vi: Unable to read/write to IOMMU perf counter
To: "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
 iommu@lists.linux-foundation.org
References: <b44a9f38-adc2-f1f2-d544-c907920a7452@elloe.vision>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <9ebcadaa-301d-2b59-04ae-be9a243c7ac0@amd.com>
Date: Tue, 2 Feb 2021 12:54:22 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <b44a9f38-adc2-f1f2-d544-c907920a7452@elloe.vision>
Content-Type: multipart/mixed; boundary="------------B87208765103D852DA169860"
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KU1PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:802:19::32) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by
 KU1PR03CA0044.apcprd03.prod.outlook.com (2603:1096:802:19::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8 via Frontend Transport; Tue, 2 Feb 2021 05:54:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0363ab56-0d81-467b-0885-08d8c73f0341
X-MS-TrafficTypeDiagnostic: BYAPR12MB2984:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29843A09F9A3CC31933A90D0F3B59@BYAPR12MB2984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxOCPaEgRfxb6/iMcKzKAhUsjzgwZc6BM/hm0bA5TfpaOPd08Zuf6UM0uGIqBfgvjaof4y+k4sQP5liOEG9TZg9KS4JewLR68/OISwfJR6OUhRHxAzt8K+V0NhV9ijwDpHRfM0Ume6ZPCJ1Y8kbgwto41LbwBX2CEYEKCmZjLgwJGLBhF5XvKoGTMP4vK71TRLqSPxbA/T2FzD+0ECrnNI4es+7eI68AV3VUNRLOsfF2v15lNYu7BHndBm0RsKe27di2Uahrw4mqNVJ0W2zhQyvV4IVW9Ntvv7vd3CMfsKujII2+mb6fuMpuSdBcFfXfHI/eZAST8ScdKmA/ffKH1Psl3G5nEUwxapON/GSzaq4yohgIqDe4uyh4FpzO+onNVf9K8QbScBJP5DpVH05sRFZn57yt6V5zEzkq8PhST9N7T9bdT/t8CA4cuXDQ6TdBNhAt58xFXMpsF0Flcoh0sjv3x64GWiViyUBNCuzi04oCpbML1+M5PyDvln82JGrbnJEVNJ5T4hvXrP8VAPvzPAWWgH3ju+3OkJr6lfqflmIblQXyFyQaTcPtKvorsMNWlF4l2td4EzMC1Z2GMPyhEAuKotYlV1TERoQX50YvK3qjvvK3XragG5m5NBzwN59n3ic7SpaBasoT7MfE4QQQPedEvFVD7iIoh++gxYwj5aH0BSk8nbzOM4uz3RbYgwah
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(66616009)(66476007)(16526019)(2906002)(316002)(45080400002)(86362001)(66946007)(52116002)(33964004)(66556008)(8676002)(36756003)(31696002)(8936002)(186003)(31686004)(966005)(26005)(83380400001)(6506007)(53546011)(478600001)(956004)(2616005)(44832011)(6666004)(6512007)(5660300002)(6486002)(235185007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFYrZGZBcVJtQlpWMUFPR2NzYmd6dHoyTHIwdUY5YVVJOFZmd0RuWGxZTHBJ?=
 =?utf-8?B?NWdudXRwRzJPMUJNMU9yYTdGRENyblUvdHhpbVFxNFJPVE5PQzlLbndkdWhD?=
 =?utf-8?B?anFxRTFVTEV0azhiamtzTkN4RmtFK2tGWktVb0dLMXBTMmpxbWd2WFdsWnJz?=
 =?utf-8?B?SllIbUxaMkpDVWszVHRxSlJLQUxkRjk4R09Qd253VWNDRldKSk9TdzF5aWtF?=
 =?utf-8?B?WGhBVFR4WU1rSjNSczlDWTdLSFV4WXpDMjZHYXJvR0JjVCs2MnduQTZLajFh?=
 =?utf-8?B?ZzJ0OWdFcVVFMFFhVnd5MFFqd3VjWHJTSjV0WFloMkFCUVgrUkFIYWJxUjV1?=
 =?utf-8?B?ZHJ5ZDhZdHZ6alhMcHRma2dKaEhmYy9mWTdJcmQ5QWpoYUY2TlVHUDJmOFcx?=
 =?utf-8?B?bG1rVm5KVEVKTjlrNUtueHBrNWtiMTg2YnUvOUhFZmZLcWllenFVSmhlWGZL?=
 =?utf-8?B?NHQ2VHorZmt4d09FU3hDbzE0S2N3dHNFTzhIQ0syQjdDYlgwY3h5SVNrdU91?=
 =?utf-8?B?UjNwQlJrRWZYZEExY0cwWldWUlVpSTJEbnZaeXVIb0NFS3MveC80VlB3alF0?=
 =?utf-8?B?WWoraDdGMmR6bUZ3U3FXT2xZdVhKanBhZnhWYUdTMmk5YVhwY3V2Y2RoZDZY?=
 =?utf-8?B?eFdpcUFZMXdxdHBqbU83THZ3QmtrVmFXYUovVk5jaWRFalVEWHRhd0QxemZa?=
 =?utf-8?B?QWszVHl2RTJsMUU0STJLTmJtM2xOQm1pWnNiZytJQkNaS2tCUDVMNkVZQzk2?=
 =?utf-8?B?Nng2bzJKdXlUbFBMSkJKTEJaSDNnVlp0Q2dySVJacnJtODM2ZlhVQVhzbS9H?=
 =?utf-8?B?K2l6RnZVa2N6bHp4azJ5emIxVmZHSnd3cWV3Q2QzVDg2Y1lYbEtVWWxCTXB6?=
 =?utf-8?B?OUUybTJYTDZ3NEtqRnBhNDhUWnloSGttY1JybVd0WURGWEpIbVVwamtJNkFj?=
 =?utf-8?B?ZkJheSsyaFZRWDJVM1RTazh1cFRRd00yc2d3RUluR25RemR1RGhvWmFZNVRw?=
 =?utf-8?B?aEpxZUUyR0R4NmFoYzVoQW0reWsvK0thWWxKeUZZUGZvNmVPZHlyOUswQzR2?=
 =?utf-8?B?dVNKdHBoQ0xieElicjZIejlPMytYNGxrZXNnVFRYNlRoYlFIaCtBRm16c01x?=
 =?utf-8?B?am1hcnIrREhmYlFpTnRCNHljTWpwZlhLbm9IYWJjb1JxTk1VWE5paUZKMGVW?=
 =?utf-8?B?N2EzR2Y3N1FhSHRmeFI3OThEQ3p1RjZMN0xMVC84d1gvOGN3aGh6QnNvU2tW?=
 =?utf-8?B?UXpkMXBlT3Z1MzcvYUFWNEg0R1g3OTlkR3NHQTc2ZldHUlFjQVNJU203MVpS?=
 =?utf-8?B?YjJqdmFmNlk4S0ZNREVpODE5Smh2LytCdnhlaDVKd2p6bUZabTE2YjFnMmtn?=
 =?utf-8?B?WDZDWHF2N1pTbSsrcXNONmU5cFJwcndjK2RWWHp1dnJJUGsrOVVNNUNWNnpa?=
 =?utf-8?Q?7Icm+ST0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0363ab56-0d81-467b-0885-08d8c73f0341
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 05:54:32.9213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4H7Dhh+eYPZBeWjJugzXT215+kFMY0EZ7vbhZ0T0ZXaaS347Szo+v7DUURhvzcKULGRen6CkQoSNdUCnI0uGpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--------------B87208765103D852DA169860
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Could you please try the attached patch to see if the problem still persist.

Thanks,
Suravee

On 1/25/21 4:24 PM, Tj (Elloe Linux) wrote:
> Lenovo E495 reports:
> 
> pci 0000:00:00.2: AMD-Vi: Unable to read/write to IOMMU perf counter.
> pci 0000:00:00.2: can't derive routing for PCI INT A
> pci 0000:00:00.2: PCI INT A: not connected
> 
> I found an existing identical bug report that doesn't seem to have
> gained any attention:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D201753&amp;data=04%7C01%7Csuravee.suthikulpanit%40amd.com%7C7c56640fcf24465050f008d8c145eba4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637471853347946970%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uykr%2FZMpr%2BuLrw3k1bKVcwywfJB4CU0p2qJSZXgLNK8%3D&amp;reserved=0
> 
> Linux version 5.11.0-rc4+ (tj@elloe000) (gcc (Ubuntu
> 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #12
> SMP PREEMPT Sun Jan 24 11:28:01 GMT 2021
> Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc4+
> root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows 2016"
> systemd.unified_cgroup_hierarchy=1 nosplash
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
> pci 0000:00:01.2: Adding to iommu group 2
> pci 0000:00:01.3: Adding to iommu group 3
> pci 0000:00:01.6: Adding to iommu group 4
> pci 0000:00:08.0: Adding to iommu group 5
> pci 0000:00:08.1: Adding to iommu group 6
> pci 0000:00:14.0: Adding to iommu group 7
> pci 0000:00:14.3: Adding to iommu group 7
> pci 0000:00:18.0: Adding to iommu group 8
> pci 0000:00:18.1: Adding to iommu group 8
> pci 0000:00:18.2: Adding to iommu group 8
> pci 0000:00:18.3: Adding to iommu group 8
> pci 0000:00:18.4: Adding to iommu group 8
> pci 0000:00:18.5: Adding to iommu group 8
> pci 0000:00:18.6: Adding to iommu group 8
> pci 0000:00:18.7: Adding to iommu group 8
> pci 0000:01:00.0: Adding to iommu group 9
> pci 0000:02:00.0: Adding to iommu group 10
> pci 0000:03:00.0: Adding to iommu group 11
> pci 0000:04:00.0: Adding to iommu group 12
> pci 0000:05:00.0: Adding to iommu group 13
> pci 0000:05:00.1: Adding to iommu group 14
> pci 0000:05:00.2: Adding to iommu group 14
> pci 0000:05:00.3: Adding to iommu group 14
> pci 0000:05:00.4: Adding to iommu group 14
> pci 0000:05:00.5: Adding to iommu group 14
> pci 0000:05:00.6: Adding to iommu group 14
> pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
>   PPR NX GT IA GA PC GA_vAPIC
> AMD-Vi: Interrupt remapping enabled
> AMD-Vi: Virtual APIC enabled
> AMD-Vi: Lazy IO/TLB flushing enabled
> amd_uncore: 4  amd_df counters detected
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fmailman%2Flistinfo%2Fiommu&amp;data=04%7C01%7Csuravee.suthikulpanit%40amd.com%7C7c56640fcf24465050f008d8c145eba4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637471853347946970%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5w2IiD7Cjsvk9qyiYC9eLmFaBIJLXdLQx4kg27LWycg%3D&amp;reserved=0
> 

--------------B87208765103D852DA169860
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="0001-iommu-amd-Fix-performance-counter-initialization.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-iommu-amd-Fix-performance-counter-initialization.patch"

RnJvbSBjMTAzZDYzMTI4NWNmMzc2NDIwZTdmNzg2OTgzNzMwMmYyYWMzOGMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhdmVlIFN1dGhpa3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlr
dWxwYW5pdEBhbWQuY29tPgpEYXRlOiBNb24sIDEgRmViIDIwMjEgMTg6Mzg6MjYgLTA2MDAKU3Vi
amVjdDogW1JGQyBQQVRDSF0gaW9tbXUvYW1kOiBGaXggcGVyZm9ybWFuY2UgY291bnRlciBpbml0
aWFsaXphdGlvbgoKQ2VydGFpbiBBTUQgcGxhdGZvcm1zIGVuYWJsZSBwb3dlciBnYXRpbmcgZmVh
dHVyZSBmb3IgSU9NTVUgUE1DLAp3aGljaCBwcmV2ZW50cyB0aGUgSU9NTVUgZHJpdmVyIGZyb20g
dXBkYXRpbmcgdGhlIGNvdW50ZXIgd2hpbGUKdHJ5aW5nIHRvIHZhbGlkYXRlIHRoZSBQTUMgZnVu
Y3Rpb25hbGl0eSBpbiB0aGUgaW5pdF9pb21tdV9wZXJmX2N0cigpLgpUaGlzIHJlc3VsdHMgaW4g
ZGlzYWJsaW5nIFBNQyBzdXBwb3J0IGFuZCB0aGUgZm9sbG93aW5nIGVycm9yIG1lc3NhZ2U6Cgog
ICAgIkFNRC1WaTogVW5hYmxlIHRvIHdyaXRlIHRvIElPTU1VIHBlcmYgY291bnRlciIKClRvIHdv
cmthcm91bmQgdGhpcyBpc3N1ZSwgZGlzYWJsZSBwb3dlciBnYXRpbmcgdGVtcG9yYXJpbHkgYnkg
cHJvZ3JhbW1pbmcKdGhlIGNvdW50ZXIgc291cmNlIHRvIG5vbi16ZXJvIHZhbHVlIHdoaWxlIHZh
bGlkYXRpbmcgdGhlIGNvdW50ZXIsCmFuZCByZXN0b3JlIHRoZSBwcmlvciBzdGF0ZSBhZnRlcndh
cmQuCgpCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0yMDE3NTMKU2lnbmVkLW9mZi1ieTogU3VyYXZlZSBTdXRoaWt1bHBhbml0IDxzdXJhdmVlLnN1
dGhpa3VscGFuaXRAYW1kLmNvbT4KLS0tCk5PVEU6CkkgaGF2ZSB0ZXN0ZWQgdGhpcyBwYXRjaCBv
bmx5IG9uIGNlcnRhaW4gcGxhdGZvcm1zLiBJdCBtaWdodCBuZWVkIG1vcmUgdGVzdGluZwpjb3Zl
cmFnZSBvbiBvdGhlciBtb2JpbGUgYW5kIGRlc2t0b3AgcGxhdGZvcm1zLgoKVGhhbmsgeW91LApT
dXJhdmVlCgogZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jIHwgMzMgKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMgYi9kcml2ZXJz
L2lvbW11L2FtZC9pbml0LmMKaW5kZXggODNkOGFiMmFlZDlmLi5lZGI4ODU2MjVlNDcgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYworKysgYi9kcml2ZXJzL2lvbW11L2FtZC9p
bml0LmMKQEAgLTI1NCw2ICsyNTQsOCBAQCBzdGF0aWMgZW51bSBpb21tdV9pbml0X3N0YXRlIGlu
aXRfc3RhdGUgPSBJT01NVV9TVEFSVF9TVEFURTsKIHN0YXRpYyBpbnQgYW1kX2lvbW11X2VuYWJs
ZV9pbnRlcnJ1cHRzKHZvaWQpOwogc3RhdGljIGludCBfX2luaXQgaW9tbXVfZ29fdG9fc3RhdGUo
ZW51bSBpb21tdV9pbml0X3N0YXRlIHN0YXRlKTsKIHN0YXRpYyB2b2lkIGluaXRfZGV2aWNlX3Rh
YmxlX2RtYSh2b2lkKTsKK3N0YXRpYyBpbnQgaW9tbXVfcGNfZ2V0X3NldF9yZWcoc3RydWN0IGFt
ZF9pb21tdSAqaW9tbXUsIHU4IGJhbmssIHU4IGNudHIsCisJCQkJdTggZnhuLCB1NjQgKnZhbHVl
LCBib29sIGlzX3dyaXRlKTsKIAogc3RhdGljIGJvb2wgYW1kX2lvbW11X3ByZV9lbmFibGVkID0g
dHJ1ZTsKIApAQCAtMTcxMiwxMyArMTcxNCwxMCBAQCBzdGF0aWMgaW50IF9faW5pdCBpbml0X2lv
bW11X2FsbChzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIgKnRhYmxlKQogCXJldHVybiAwOwogfQog
Ci1zdGF0aWMgaW50IGlvbW11X3BjX2dldF9zZXRfcmVnKHN0cnVjdCBhbWRfaW9tbXUgKmlvbW11
LCB1OCBiYW5rLCB1OCBjbnRyLAotCQkJCXU4IGZ4biwgdTY0ICp2YWx1ZSwgYm9vbCBpc193cml0
ZSk7Ci0KLXN0YXRpYyB2b2lkIGluaXRfaW9tbXVfcGVyZl9jdHIoc3RydWN0IGFtZF9pb21tdSAq
aW9tbXUpCitzdGF0aWMgdm9pZCBfX2luaXQgaW5pdF9pb21tdV9wZXJmX2N0cihzdHJ1Y3QgYW1k
X2lvbW11ICppb21tdSkKIHsKIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IGlvbW11LT5kZXY7Ci0J
dTY0IHZhbCA9IDB4YWJjZCwgdmFsMiA9IDAsIHNhdmVfcmVnID0gMDsKKwl1NjQgdmFsLCB2YWwy
ID0gMCwgc2F2ZV9yZWcgPSAwLCBzYXZlX3NyYyA9IDA7CiAKIAlpZiAoIWlvbW11X2ZlYXR1cmUo
aW9tbXUsIEZFQVRVUkVfUEMpKQogCQlyZXR1cm47CkBAIC0xNzI2LDE3ICsxNzI1LDMzIEBAIHN0
YXRpYyB2b2lkIGluaXRfaW9tbXVfcGVyZl9jdHIoc3RydWN0IGFtZF9pb21tdSAqaW9tbXUpCiAJ
YW1kX2lvbW11X3BjX3ByZXNlbnQgPSB0cnVlOwogCiAJLyogc2F2ZSB0aGUgdmFsdWUgdG8gcmVz
dG9yZSwgaWYgd3JpdGFibGUgKi8KLQlpZiAoaW9tbXVfcGNfZ2V0X3NldF9yZWcoaW9tbXUsIDAs
IDAsIDAsICZzYXZlX3JlZywgZmFsc2UpKQorCWlmIChpb21tdV9wY19nZXRfc2V0X3JlZyhpb21t
dSwgMCwgMCwgMCwgJnNhdmVfcmVnLCBmYWxzZSkgfHwKKwkgICAgaW9tbXVfcGNfZ2V0X3NldF9y
ZWcoaW9tbXUsIDAsIDAsIDgsICZzYXZlX3NyYywgZmFsc2UpKQorCQlnb3RvIHBjX2ZhbHNlOwor
CisJLyoKKwkgKiBEaXNhYmxlIHBvd2VyIGdhdGluZyBieSBwcm9ncmFtaW5nIHRoZSBwZXJmb3Jt
YW5jZSBjb3VudGVyCisJICogc291cmNlIHRvIDIwIChpLmUuIGNvdW50cyB0aGUgcmVhZHMgYW5k
IHdyaXRlcyBmcm9tL3RvIElPTU1VCisJICogUmVzZXJ2ZWQgUmVnaXN0ZXIgW01NSU8gT2Zmc2V0
IDFGRjhoXSB0aGF0IGFyZSBpZ25vcmVkLiksCisJICogd2hpY2ggbmV2ZXIgZ2V0IGluY3JlbWVu
dGVkIGR1cmluZyB0aGlzIGluaXQgcGhhc2UuCisJICogKE5vdGU6IFRoZSBldmVudCBpcyBhbHNv
IGRlcHJlY2F0ZWQuKQorCSAqLworCXZhbCA9IDIwOworCWlmIChpb21tdV9wY19nZXRfc2V0X3Jl
Zyhpb21tdSwgMCwgMCwgOCwgJnZhbCwgdHJ1ZSkpCiAJCWdvdG8gcGNfZmFsc2U7CiAKIAkvKiBD
aGVjayBpZiB0aGUgcGVyZm9ybWFuY2UgY291bnRlcnMgY2FuIGJlIHdyaXR0ZW4gdG8gKi8KKwl2
YWwgPSAweGFiY2Q7CiAJaWYgKChpb21tdV9wY19nZXRfc2V0X3JlZyhpb21tdSwgMCwgMCwgMCwg
JnZhbCwgdHJ1ZSkpIHx8Ci0JICAgIChpb21tdV9wY19nZXRfc2V0X3JlZyhpb21tdSwgMCwgMCwg
MCwgJnZhbDIsIGZhbHNlKSkgfHwKLQkgICAgKHZhbCAhPSB2YWwyKSkKKwkgICAgKGlvbW11X3Bj
X2dldF9zZXRfcmVnKGlvbW11LCAwLCAwLCAwLCAmdmFsMiwgZmFsc2UpKSkKIAkJZ290byBwY19m
YWxzZTsKIAogCS8qIHJlc3RvcmUgKi8KLQlpZiAoaW9tbXVfcGNfZ2V0X3NldF9yZWcoaW9tbXUs
IDAsIDAsIDAsICZzYXZlX3JlZywgdHJ1ZSkpCisJaWYgKGlvbW11X3BjX2dldF9zZXRfcmVnKGlv
bW11LCAwLCAwLCAwLCAmc2F2ZV9yZWcsIHRydWUpIHx8CisJICAgIGlvbW11X3BjX2dldF9zZXRf
cmVnKGlvbW11LCAwLCAwLCA4LCAmc2F2ZV9zcmMsIHRydWUpKQorCQlnb3RvIHBjX2ZhbHNlOwor
CisJaWYgKHZhbCAhPSB2YWwyKQogCQlnb3RvIHBjX2ZhbHNlOwogCiAJcGNpX2luZm8ocGRldiwg
IklPTU1VIHBlcmZvcm1hbmNlIGNvdW50ZXJzIHN1cHBvcnRlZFxuIik7Ci0tIAoyLjE3LjEKCg==

--------------B87208765103D852DA169860
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------B87208765103D852DA169860--
