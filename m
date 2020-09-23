Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B34C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 11:04:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC452145D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 11:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hy5UVEv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC452145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7047822E96;
	Wed, 23 Sep 2020 11:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AmfAfwsVfrg6; Wed, 23 Sep 2020 11:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B01AD22E8C;
	Wed, 23 Sep 2020 11:04:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9876EC0859;
	Wed, 23 Sep 2020 11:04:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46FA7C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 11:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2562622E96
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 11:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ai38467o2sg3 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 11:04:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by silver.osuosl.org (Postfix) with ESMTPS id 2AAE022E8C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 11:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNShelGkxtNjAolvfEtv6nAyzspOMQtKRViRsVAw2OddttXqSKVTY1OMSaLtOuhA6pwq1bEwj+jU2+RWgtTwJTv25QVKVG/zJQumKOVSMz3Jkk1sWmcuRkyNsY3tLNzQPHBCXr99/Njk2IhlYoQOYd9PshIpA1P7PjfRjgGvNiydNrc9dRfzxZdQkLMoAgYmdV9BosUCgx2JsoYqfzUUvCWgfX/7vgEk/5IDbKikPHvcKR+Bjwdc6A7rxZlxu2FI+CnHLfvh++C6pvW/5MxGK4EOXVdGzKDmy+z6O1b+HRU/pmefb0l2OBW/P6rzCNiI+6H5TewmHjNl7x2W0gpneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hblxid5BQCezAaZc71o/wIE+KdOFw8mHfk40JcdCFNk=;
 b=m8nfEiwsRqXOexRtnq3e7vD4f1S5IED4s1ITqV+ULs0/bD87I/75m74WrzFTs5dioA4l5/z9NFPCtbk+J6iLUqaqK0Ck5F7YHw/chBt9U71AL2imCIfnpr61KF3E+HG3kihnOctLAvXKuPvSZwf49LD1DxOvX/c53OMNS3zW19vx5IHhKIsG6vZXF5dbVc3JUE0e0UuWky0FqXPeHm+K0KZa63DpjuctHVn2mHYliz++HWXbzvzwcIZ1IiRaOJaXzpRQCOaVx2UgC7hVqlJtz3rElOcjfaT99ShENAIEUIsoFgaiXMeg+NOBS2k9bWvh06KwcG/mbRYlHBfHceVMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hblxid5BQCezAaZc71o/wIE+KdOFw8mHfk40JcdCFNk=;
 b=hy5UVEv2T3b4MCWeq9uxtokyIbln76KgdSPch8aix0OekQ3REOg1e8ANDlGJ8F3iKcwPImSEDVZroEhGFdv/mswhda54LHnyzL6v/MeuH3QBWoJhkxt92GQXpx5GIb1ZRx0Kc5bhivq8hU5PNtAC4U2bSeX+DLTmvcjehs1ESGg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Wed, 23 Sep 2020 11:04:17 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 11:04:17 +0000
Subject: Re: [PATCH 2/3] iommu: amd: Add support for RMP_PAGE_FAULT and
 RMP_HW_ERR
To: Joerg Roedel <joro@8bytes.org>
References: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
 <20200916135549.146468-3-suravee.suthikulpanit@amd.com>
 <20200918093117.GO31590@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <64ffa498-990d-2086-eff3-bac70f674e88@amd.com>
Date: Wed, 23 Sep 2020 18:04:07 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200918093117.GO31590@8bytes.org>
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:820:f::11) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by
 KL1PR0401CA0006.apcprd04.prod.outlook.com (2603:1096:820:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Wed, 23 Sep 2020 11:04:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 106a152d-32d1-4de6-b59e-08d85fb069f7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB002573FA0F3EFBCD934D31A9F3380@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xcxO/6b2bZGGn6xQgUz7JiJE6Lnm9MWh0etNgStgnOuR3kL5aKmMLQz0o+0n8sW4inl75g+KazKzhsTqdpNq/7XRO6PYKCr59rPB+7pF7dy7ANcGYKXZKM3V1rNMzcRqw0rFUeLnaXLRGdUGOliPfqCLicu7gE/dZ2oAXnPJUO/Ywtr+osEoTJxq+j+zu824y8OHeh4KalAm56Fn50H62H5CqlNOdk9UKuCnX+RSGSnvTHTmx1QjY9PVmvDpd+eVQzGDndeJzaINFIZMmN4b43ORwXR9RGabUTxue0luUM2yDWR7GE2US1AS7LxXkbirT/iEHlYega8vW67NFQ4BsLM/qMABlMu8ALIjDZ4F3WEi6EGAaHbmiSna93KO9jq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(2906002)(6916009)(8936002)(4326008)(6486002)(66476007)(6512007)(66556008)(5660300002)(36756003)(66946007)(8676002)(31686004)(31696002)(44832011)(53546011)(478600001)(86362001)(2616005)(26005)(186003)(16526019)(6506007)(956004)(83380400001)(52116002)(6666004)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ELstsUj8W5EgZ3uv29vBGfn7J+1CN247BfpWqMLS+wTedNbRf+309qCLtVvgM+Y77YTICeNki/yuwB6XG+dQ78hE7u7O4WWj9ne1scxtplaoIn/ruv43IkCmCLZxVIVjIUBYzdSrtHlfEA9DCo8TIgPbRdRlUJ606RFDGSrgoMsRdEYdUgm3az4NwvuhqXBszxrihd5DEsnOy1ozEDfU6cyH4WKfD5u5lJiCtupLI6QLhnwvy1lJbj9Kgh2ZrjVaUV5Y17p97HA3EVWs//7yHJC0VP6KrOJqltWyGjesrWz9pBy7g4VxVMcTqDLYRHY5yab/MaQmtVYOlj2s7bT4FN+aF5PU60INXgnAs/VSA9Xh+lUqh9d768NrSdX0ZZgVG8p6bxQ89Soc//gSkJUvL3cGRDbYlHFI9us6rvmRAqZlNL3pmiGvKd9mLgn9Y0QfHEf7K0yIbkhYA4do041E9HwXp3S+ah456OgFR5ddZFeIIeuNENsafu46FXl0iJfWmAW6PklBFvzcHca1BdO129JSGFNGl9aKrXYcPn7PuihmJnlCi3kd20r5GIg/fOPmfWphBKhTjL0JBlKo8jMuWeubh3AuB8CjzoD5kAznrzAxXmn4A02LTBwId86nvqVKXOUvQncx/7mtPZOU9YhGSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106a152d-32d1-4de6-b59e-08d85fb069f7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 11:04:17.2858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXCN5ip1mKdWklphf80jW7UmKq1ICU2Ygwv+WOChWXPnpHVhV/Gj8+CxG6Vny51haxpIHjshDHUfy4KZ49PNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
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



On 9/18/20 4:31 PM, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Wed, Sep 16, 2020 at 01:55:48PM +0000, Suravee Suthikulpanit wrote:
>> +static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct iommu_dev_data *dev_data = NULL;
>> +	int devid     = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
>> +	int vmg_tag   = (event[1]) & 0xFFFF;
>> +	int flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
>> +	u64 spa       = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
> 
> Please write this as:
> 
> 	struct iommu_dev_data *dev_data = NULL;
> 	int devid, vmg_tag, flags;
> 	struct pci_dev *pdev;
> 	u64 spa;
> 
> 	devid   = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
> 	vmg_tag = (event[1]) & 0xFFFF;
> 	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
> 	spa     = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
> 
> Same applied the the next function.
> 
>> +
>> +	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
>> +					   devid & 0xff);
>> +	if (pdev)
>> +		dev_data = dev_iommu_priv_get(&pdev->dev);
>> +
>> +	if (dev_data && __ratelimit(&dev_data->rs)) {
>> +		pci_err(pdev, "Event logged [RMP_HW_ERROR devid=0x%04x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
>> +			devid, vmg_tag, spa, flags);
> 
> Printing the devid is not really needed here, no? Same issue in the next
> function.

I'll update the patch and will send out V2.

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
