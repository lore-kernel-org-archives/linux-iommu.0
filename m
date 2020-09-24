Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFA1C2D0E2
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:50:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78E8206B8
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bWBa5D73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78E8206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5EEB9874F6;
	Thu, 24 Sep 2020 10:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jgdDVnhGhjE; Thu, 24 Sep 2020 10:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 89CC6874EA;
	Thu, 24 Sep 2020 10:50:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C068C0889;
	Thu, 24 Sep 2020 10:50:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9D89C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BC6972E0FE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2hSgPM3a7FKp for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:50:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by silver.osuosl.org (Postfix) with ESMTPS id 565622040B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsVya4BujNekHyvNyNDGLEAvUtuKnDiZiuVIh6L3QSD8r7vctsrefMlKbj9X4CzUNdFoCeyemuN7VtjEUUaQHwLzVZI68gPmJ7ZAsauVorKLvAHYbPRK6zVKy9Wk5eYh4N9bf60a0/nKjbbv4Pupdi4S3iv4vqQgijlWFnSdBctKQ7ZPeHKmFbEWbMCcqwskqEyOBfEF5fImJ8UjA1Vz/I8wtb6t6NEg5QuI4xq0Z7C7s+NmJdHS+6IYnrtEEQ4bATprCEEeMVGMq4+52avCaJOPmvKBGL2mS3OWjF91QrK9GL7fse7nhyp0ik+f1gOmj8ocEX82Oyru4XyHV6NipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcCKoh9lnBfCzTA7Ims08zMzDRdcIc8kFN2fp8yqDZY=;
 b=Vv5V+iNW/244ZfVlyfHzPcgeQw7xF02D8Mzx3DZyUisoS/xQm/x1CGz8y6GooL5IcNWBllemyRSPZH+SrZzhSIfLQf8qtY+dtOnL+B6PDcKT82afOEjiU6sNbVHNAvIF1/b2yvV0VW3vgyHt6JuuEnnORMSDWc5emYl6KgapiRLITdIieiTFYhVFKiN9p3i+L9ktLYlHLqMU8XabbwY99Fz9352mI53o88Bsky4Hcq4R0bgmXiAPgHhzJh+Fm1F0tdYBBzFTP3LM0Igt/htvijoWHcoyfC8u2CJYy18lDAGrGhKxXoxDrByyPw2YwP9Th4tdEHKJpgoJ02gyn7Ojzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcCKoh9lnBfCzTA7Ims08zMzDRdcIc8kFN2fp8yqDZY=;
 b=bWBa5D73ofxfWWbERkKPzpe7PF6GoU7Lgk2PcO/zlpm2/x1T+YU9qRJLJHlr+Z5zY8DCkznB4eLbcCmC09S5xmzC95nMTZkEZwTlG0UEpKkNN+AYAD8jDAe2/eClSt0HQACWVbW4GohTODyPVpT5OlboxFVQzhstRkPuGSJbl8A=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.17; Thu, 24 Sep 2020 10:50:46 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 10:50:46 +0000
Subject: Re: [PATCH 00/13] iommu: amd: Add Generic IO Page Table Framework
 Support
To: Joerg Roedel <joro@8bytes.org>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
 <20200924103448.GO27174@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <c4b95103-8c66-6a9b-af18-a7c40d9dd943@amd.com>
Date: Thu, 24 Sep 2020 17:50:37 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200924103448.GO27174@8bytes.org>
Content-Language: en-US
X-Originating-IP: [183.89.247.160]
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (183.89.247.160) by
 SG2PR03CA0112.apcprd03.prod.outlook.com (2603:1096:4:91::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.9 via Frontend Transport; Thu, 24 Sep 2020 10:50:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aed2f12f-9ed7-4860-ebbf-08d86077b121
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3081102CE1AF44124A3665C0F3390@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/fiEcp7RWozyMJD17lwFTaHitGml4KOR5Gf3rcHpAtqc2x+LooFElDzbIOqfaUonyud3qrd3l9pPVROF6ffn16RhCT2Fs+ifobZJcf9UgbMw0TLdXn76k5y0sEI8KtDtfyfPh4RKBDSKfstAPAzWxv/7ko44HzXQ5FNEdLpkIZUYR9GuP9ZBFnS75kXxc2hbHdRK2Ua3Yzu6l3stKzFmnrBAkVjxCDlxSc2a4rgs+WYu3AC9bAbRow+LX9npSlkkcN6614nJiQcDOR9RJWBQGZ7H79RAFElEKiSJiHkUUBwVBypVCHLSNoTjrpDlOOsKxR9MTBEJqJIxGZFvIK6YsEmWSPb9MwxnMPi6nNrWZIGBjLxyMUPwqGKSPGISn39T6nq0laPXjwE735YoVuXRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(316002)(8676002)(4326008)(5660300002)(36756003)(66556008)(66476007)(4744005)(44832011)(2616005)(956004)(478600001)(16526019)(186003)(8936002)(66946007)(6666004)(26005)(2906002)(6512007)(31686004)(31696002)(6916009)(53546011)(6506007)(6486002)(86362001)(52116002)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IgL9nesptcl5jCURFcD4n3cLVzzjUgSEEwpYjvVoHOG3DEm5i+WZNNs8nPelJeeGc9FjOhUX+DwHq4LZ9R56Ykc+e6ob8c5Lyhuq2NGTMcNPF6OAMGg9XTFVirU0gGDscanFtOIJPUFjx24lVtep6+YJtUsuxcnBUDTWylEt9QJ0vuIhXp46tn6BoozNgm3S5TQXzBJVVuk00myuoOayyNhFQoe00SvQMCywtjf0L1DSn18cGA8u8MACXgZqR6UkKWVCWLeOF9oMut/kFOOVlh5+VVx2vuRb4CuvtWKUkCsRybM7KfDJg80RHiqsQ++XLKrm9f9s0x4xu+4lbQlAYNDKni1CiT0D5JR8y3r6hHLIBzODxJVBsiTZACeJqh8PvsCR4Tnh897ZhL3NRqCrYyUnBQYEA9A3jIuowZee3g4n3CvnJ0eBdZ6+B5TuP/qysHhyFPiURWNPWDOlGu3ETcDqxlTbMYa1SjWjQLJlMSf2UzxPkNU7mVdislGC5KOdNi975e0NzXs2/ftNj0bBHhbSVj72z1xIyMh6GgOjNmD8yT1a6Ml9plfqKdhRKCdOkW7gC9d2oLrhGCgOExIjlxavhtp8JzT/EqJYfSsxztOqHRy0Oiq0Bv6Rj0mAg+/4JZYuPV/iqFAAV8Y553O9Lg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed2f12f-9ed7-4860-ebbf-08d86077b121
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 10:50:46.4289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcKHRUYIn7yezpG+zsoU1/7A6aHxh+JmXvTFPIkVvxp9HQ6ZHLDRq5F24libAB4B2EFLZh6gBV1W8RgqYRxgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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



On 9/24/20 5:34 PM, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Wed, Sep 23, 2020 at 10:14:29AM +0000, Suravee Suthikulpanit wrote:
>> The framework allows callable implementation of IO page table.
>> This allows AMD IOMMU driver to switch between different types
>> of AMD IOMMU page tables (e.g. v1 vs. v2).
> 
> Is there a reason you created your own framework, there is already an
> io-pgtable framework for ARM, maybe that can be reused?
> 

Actually, this is the same framework used by ARM codes.
Sorry if the description is not clear.

Suravee

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
