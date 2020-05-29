Return-Path: <SRS0=ta7q=7L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0272C433E0
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 13:49:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627D7207BC
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 13:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eFfjc9rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627D7207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 659A58769B;
	Fri, 29 May 2020 13:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bbMOJtcs3DC; Fri, 29 May 2020 13:49:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A24E380660;
	Fri, 29 May 2020 13:49:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88C30C07FF;
	Fri, 29 May 2020 13:49:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07C36C016F
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 13:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E3F9487409
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 13:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P34bw9T2aeao for <iommu@lists.linux-foundation.org>;
 Fri, 29 May 2020 13:49:11 +0000 (UTC)
X-Greylist: delayed 01:33:46 by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D4C4B86C1E
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 13:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpgFjynG2BdcntdW+7XVU6Yl4znlelYstO0kdOfRgE0N4u8A+whaNUIwxvikvDAjSfxKw7LjAor47DdJ8ASc+DFeWN1zpcvMWVBBz5EppZHbTukYv8eV3Np2nrJg4ibEsYGma1uDZQZMtRWdDOUI1gloBnqbvXJ4Gu9n3Ii01ER+HhN7l9uiNmZjX6OQiKUr/VA99pfY+8PG3dHulHQJLgcnt8fIpffroh91n5Q9Xuw+7VIJfxMMdMkqtwJVXabd6qO8nMq2RiaaiIwbr153JYmAZhOmTiwreopQurL46IMsFIt0oLWbNYgM2GCAyVymMAmUONpLn4WfEyhPuqWMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFoNYPXsz/lNFsw2fD4EpaAndzNf/R8P475YH9tQk4Y=;
 b=X8lzzEwazUUUF/uW+T1kFpbec2xUppM09L3WbJDYrxJt2Ca8/BosMnN+e+tinexjBsJn/n5ZtkF9ZTZtbPF7pkdbb3WrYXNGJRsfj+nrSS/eKoylZ8hoqC1yWRUaFX70ega8SOs0RH18vyMEs155QKFT/jX8SC0qkljS7C/lPeF6RJSr3SlQa8U7u1TMRW85MYwT8roQxRkImjh6BnztuoMZtc2PELFIAc4pQRWhksMy8AG+20S32KX9IYXOQlB65mvQCkvjr5SgvHb3geKAu+vMW5dPnaNG9mo2aDa9co0GURPIYHTScTyiUqCSq2rcyVtnCbpn0HGpbPoiLpyqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFoNYPXsz/lNFsw2fD4EpaAndzNf/R8P475YH9tQk4Y=;
 b=eFfjc9rKEuurEaObaVPRhYA7w+kXwxdURWkjtDH2NM6vnKlYYqmBweVgaXzPwuWSKldFx8YpBcIvazteES+C0d+d+2kB6Wb9R55QQTPPhFFBDV6npzRYZja6kavP8Db4ZGKENs5Uus99ryYygEpuB0APfvxsUu1flSxaoTlTyvE=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1305.namprd12.prod.outlook.com (2603:10b6:3:75::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Fri, 29 May 2020 12:15:23 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744%4]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 12:15:23 +0000
Subject: Re: [PATCH 00/10] iommu/amd: Updates and Cleanups
To: Joerg Roedel <joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <855af88c-66b2-29c1-a184-40d52592e38e@amd.com>
Date: Fri, 29 May 2020 19:15:13 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
Content-Language: en-US
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (124.121.4.249) by
 SG2PR01CA0145.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Fri, 29 May 2020 12:15:21 +0000
X-Originating-IP: [124.121.4.249]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 631211be-2b6c-445c-c80c-08d803c9f63e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1305:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1305AE2A42738EFDC918B84DF38F0@DM5PR12MB1305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3kunAOw4Q/vVOk8BTOeKMF9VHxJjrx1wbf7kh+QQdWl3OyVMnG5B4eXQXeON/dKwccmmJsocmtBGkaxgjVxvmPQYYQ341p2JKLwvH7mv+1oPeM5sPDfeH8jV6tlfWGEmPNutrvOy4cDZGEGVIcjG516TGQCJ5XMGOPbXJAmta19AsZr5NRHPH6xxSH60jiTuNRSvZWepb80hGpTIzm08WBPf46aGSYwsBsfYrw1Whph93IDSAWFgvy0M11F6VsIQquLglWylh42e9TksgrDIq01/QXBmv5c2ohmSkbn3e1o5U/1m2YjEyW8dUiwfVJBat7BbaXatrauo48zHrBstreb7W/L6hysEEmdJlmX5scvnRjL0eN6dozG0PVpdvZi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(53546011)(83380400001)(6916009)(36756003)(26005)(16526019)(186003)(5660300002)(478600001)(31686004)(316002)(16576012)(52116002)(6666004)(44832011)(8936002)(956004)(4326008)(2616005)(31696002)(86362001)(6486002)(66946007)(8676002)(66476007)(66556008)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hrxtGKOUO/Havwv2uJn+CMoeDoYU5bLfv9yvro6lvLlo40VcxDA/mSM+AJK9iaHZbLCs4aYPmFgEwfXOMxeuW2v7qmxhmtW3++vLH4btIvS3xEe/2jIjHaeHTqVx0u9wXCcTFJ6aYN54etAfzOZDBA3HJPae4DknBtdk00QMA3/SFU4SNPTcGMW/INRgtxWlXpWuQq8s44OJPpYvLf0BQtBzkZoALAnw/XoBy4x4a/oll73YNipi0pw7aCFhHkaQ63v/WV6Ac11NuLlNkm3brJZ6GvvrtcyJ1B2tqnjZBTg+9FlyZFlfgVWQzxTmt9P8R9R5tQoP0PjRCrdd6/fb8P12HL9pmqiNgRuzUPXa5px46ASPbhTDgza0MRrFToKXGuRetbirQ1ETNa67i2Jhd1UMndRt7xruyErRCRvO7JvZSYrc70ghjZHpoPmq3eJyFRJ3OtEPbczerv73NFtzgKsjcn6t2as6s2vc0Z5Clyg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631211be-2b6c-445c-c80c-08d803c9f63e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 12:15:23.0903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FjkbZe283OJ84+Njgw+ZLRgvE80Muls0RCOTAouJ4Z8RRfLNbW6onKvmnw0QwKQ66jSuYdcHdPaNeUeIr9dmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1305
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org
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

Joerg,

On 5/27/2020 6:53 PM, Joerg Roedel wrote:
> Hi,
> 
> here is a collection of patches that clean up a few things
> in the AMD IOMMU driver. Foremost, it moves all related
> files of the driver into a separate subdirectory.
> 
> But the patches also remove usage of dev->archdata.iommu and
> clean up dev_data handling and domain allocation.
> 
> Patches are runtime-tested, including device-assignment.
> 
> Please review.
> 
> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (10):
>    iommu/amd: Move AMD IOMMU driver to a subdirectory
>    iommu/amd: Unexport get_dev_data()
>    iommu/amd: Let free_pagetable() not rely on domain->pt_root
>    iommu/amd: Allocate page-table in protection_domain_init()
>    iommu/amd: Free page-table in protection_domain_free()
>    iommu/amd: Consolidate domain allocation/freeing
>    iommu/amd: Remove PD_DMA_OPS_MASK
>    iommu/amd: Merge private header files
>    iommu/amd: Store dev_data as device iommu private data
>    iommu/amd: Remove redundant devid checks
> 
>   MAINTAINERS                                   |   2 +-
>   drivers/iommu/Makefile                        |   6 +-
>   .../{amd_iommu_proto.h => amd/amd_iommu.h}    |  20 +-
>   drivers/iommu/{ => amd}/amd_iommu_types.h     |   0
>   .../{amd_iommu_debugfs.c => amd/debugfs.c}    |   5 +-
>   .../iommu/{amd_iommu_init.c => amd/init.c}    |   6 +-
>   drivers/iommu/{amd_iommu.c => amd/iommu.c}    | 265 ++++++------------
>   .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}  |  14 +-
>   .../{amd_iommu_quirks.c => amd/quirks.c}      |   0
>   drivers/iommu/amd_iommu.h                     |  14 -
>   10 files changed, 117 insertions(+), 215 deletions(-)
>   rename drivers/iommu/{amd_iommu_proto.h => amd/amd_iommu.h} (88%)
>   rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
>   rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (89%)
>   rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
>   rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (95%)
>   rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (98%)
>   rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
>   delete mode 100644 drivers/iommu/amd_iommu.h
> 

Thank you for cleaning up.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
