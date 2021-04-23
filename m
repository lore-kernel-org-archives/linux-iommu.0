Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D5C43460
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 18:20:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EC661458
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EC661458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4865400FE;
	Fri, 23 Apr 2021 18:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzbt2t95Ju5S; Fri, 23 Apr 2021 18:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87515400B5;
	Fri, 23 Apr 2021 18:20:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41996C000E;
	Fri, 23 Apr 2021 18:20:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5CE9C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 18:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67462414D9
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 18:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2y7VNNcuByVN for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 18:20:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::627])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECD1640F9E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 18:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj9mff3G82fkv+HxwZqig2/SQDTEP+YwYP2vo/c95OYN/Sis4ODHGnvjr13YiOHkTUcR2mSdYlriMEKp6KAf92bgakxlggEeiZn0/6L0kYDRmZzar7EwTr0V9eQczpNtD7B+vaYnFBCNpPdgXlLsXxUvhYtPsxo0RkWIH80fD72IAPdpWjcM0COqVQkvHFnQ2fKnaUHJPTCH6kMxxt55H+PJRBMy8RlvknoucAsyf0nBgpwK+Nij447p6EURZ/e+L31sDociCipGfGHKH/lnin0+wGOrOIskm8M7mEgoPgtuatRCEPoUSk5hfkW5XvWpiQ2FR+UrrnTjSOkoIH4ieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gapqk/8XKWL22oJQJG50Al6RLHuefx1vqDFPK/US01E=;
 b=Evot1KWRRGN/jwqHSGEyK/eYUfI+n9mp2zaZ3f2XfV1K4A4M+VbBEIf3QBwYtiaFM+X66p+VvtL+bL/ZOhW9xrkkNwM5QptC64TQTvLcugaA18CIN8WntHkctb9h9j2WMDkBrHF1vfcy/ExOUPrezpzqAv3qEXzTkU62RHWGtl8v8yv3acrGIbrP8fk6FHDtfbEaVamilrnCm0oS1jwHUrcYKP8UZgHwsBTqs5T81Y2eOXFDqJOCY5ErIkYRU4K718+asLcU9e6siKsklbTI/KVAjuHg3gAhUH7Sr9Vgz5lJHxktv0J2YMLT2B5MO71nvqqk51+dvDfSVqyD1RINow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gapqk/8XKWL22oJQJG50Al6RLHuefx1vqDFPK/US01E=;
 b=oIjhLevVwq0uY60B2XIcS2Hj93TQkWlc52f1UFa6FCle+oWUlWJm/hB1gGopPmTn1Kz949SE7KLqu7r0AkiFVqB6c2GySAQDgRkTnUKvnxWeI6cNo7YXxbP9e4Y1srD9W5iv90vIDnSUPVHHIvkxpfTLPid/YpB941EHh6B06hY+ETw01ZZoNz35UBJ9Qh+IvSeSW9bhX8eUYwU3bnFov0lDrlGB+MfyyaFlUAQm88KwcyqUuwLsqJADlQ4b4zlkZt/KgXrDQIafvUtLRNQ7nyAHadvsbMmy2g70QkJBt8mjZ/yENEBkiF2sDhUUJKmLGhSJ7uOGJNBzRi7zo9AgMw==
Received: from BN7PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:20::28)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:20:05 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::f1) by BN7PR02CA0015.outlook.office365.com
 (2603:10b6:408:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 18:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 18:20:05 +0000
Received: from [10.41.23.128] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 18:19:58 +0000
Subject: Re: [PATCH v14 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
To: Krishna Reddy <vdumpa@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
References: <f99d8af1-425b-f1d5-83db-20e32b856143@redhat.com>
 <1619103878-6664-1-git-send-email-sumitg@nvidia.com>
 <YILFAJ50aqvkQaT/@myrica> <5a8825bc-286e-b316-515f-3bd3c9c70a80@nvidia.com>
 <BY5PR12MB37642B9AC7E5D907F5A664F6B3459@BY5PR12MB3764.namprd12.prod.outlook.com>
From: Sumit Gupta <sumitg@nvidia.com>
Message-ID: <467c95cd-3ba5-519e-cdac-9f477da86ecb@nvidia.com>
Date: Fri, 23 Apr 2021 23:49:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB37642B9AC7E5D907F5A664F6B3459@BY5PR12MB3764.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b097732a-0214-45a3-b625-08d906846b48
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51961A3DB446833C4BF166C0B9459@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7clLpzt7EUCUrBWYbruNWLmcrUC57NihX8c0LjC34rXtHll6TifhtX6u5kjk2G+p4tGGREF194u5FUM8VKEDkvgcqSkUVkVQwnN1JE94t9u+WxAgWwgmHXy/rgAm8oGlic3CWyiEX/vrNmS7irLSHc8r8rKiz0IYSYqHj03sqwqcNwrEhdfXy8T3zYIpFku1zTNQe6okX0GzZ0weBue2NDq6pJ82lfDmt57WZSd76FJ3F+BOkM25jUYMiqzvx/ia7lujQmhKH24Jb6bAtZlBGlfMJsItxbYswwYKaUFIWcLTiKHBnUmxx0yH0G3GCla229BUb6sRzf4Ak9VPfl6+sxk5muF/5ohgDkFaUuG9aIEmWdzkQ1UBmYzvmJIH+YqXV8yUtHwnJyqNkGXm3WgvyUdUhtAbwRsU58FDxmThKiWdvRu9o6sTSmnYgNyCD0wOFrVRTy5KmgFfnWqgLLb+gPmAxkyHPcjtBAKzPg1ci/DdgXS68L9sq1ntj5wXpiH6bRUuY3v5cLhBrbg8+t3Korr6poJOauLnrxhdANpyDc4MRXCdx3nSrJcEwbEgaygk3XAaUrGzBnSs3sX0qWcn93as3rbkxkkwEAU+1/D93TqzmdUPHCXpq8xiJrnq/gHORLJEKhSXoYjVeWBRlPFDFfW4m4eABEVcYTpXpqE/wYN+b2icnc0/3UPyr86DX7R
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(70586007)(82310400003)(36756003)(5660300002)(31686004)(356005)(7636003)(54906003)(6666004)(107886003)(110136005)(82740400003)(70206006)(316002)(7416002)(26005)(31696002)(16526019)(16576012)(426003)(83380400001)(2906002)(2616005)(186003)(86362001)(478600001)(36906005)(36860700001)(336012)(4326008)(8676002)(8936002)(47076005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 18:20:05.3193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b097732a-0214-45a3-b625-08d906846b48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "wangxingang5@huawei.com" <wangxingang5@huawei.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 Vikram Sethi <vsethi@nvidia.com>, Bibek Basu <bbasu@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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



>>> Did that patch cause any issue, or is it just not needed on your system?
>>> It fixes an hypothetical problem with the way ATS is implemented.
>>> Maybe I actually observed it on an old software model, I don't
>>> remember. Either way it's unlikely to go upstream but I'd like to know
>>> if I should drop it from my tree.
> 
>> Had to revert same patch "mm: notify remote TLBs when dirtying a PTE" to
>> avoid below crash[1]. I am not sure about the cause yet.
> 
> I have noticed this issue earlier with patch pointed here and root caused the issue as below.
> It happens after vfio_mmap request from QEMU for the PCIe device and during the access of VA when
> PTE access flags are updated.
> 
> kvm_mmu_notifier_change_pte() --> kvm_set_spte_hve() --> kvm_set_spte_hva() --> clean_dcache_guest_page()
> 
> The validation model doesn't have FWB capability supported.
> __clean_dcache_guest_page() attempts to perform dcache flush on pcie bar address(not a valid_pfn()) through page_address(),
> which doesn't have page table mapping and leads to exception.
> 
> I have worked around the issue by filtering out the request if the pfn is not valid in  __clean_dcache_guest_page().
> As the patch wasn't posted in the community, reverted it as well.

Thank you Krishna for sharing the analysis.

Best Regards,
Sumit Gupta
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
