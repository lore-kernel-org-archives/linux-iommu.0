Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBAAC433E1
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 09:36:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7975E2074D
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pUykOiAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7975E2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42E12886C4;
	Tue, 16 Jun 2020 09:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sOjLvPMD0NgW; Tue, 16 Jun 2020 09:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 687FE886A3;
	Tue, 16 Jun 2020 09:36:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58FB9C0888;
	Tue, 16 Jun 2020 09:36:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0493C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 09:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AC02D89458
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 09:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0jyBriv7ZeA for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 09:36:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 825708943F
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 09:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G97VSFmKu2KiCPI4XOk1oBmO6T+xqBLF123gL7562/ycrGvCsjoNOw5L3Jkwj8stPmTXRSwyxUS9JBOvxwNruFdDUHcTInGthGvrxSJd70NbqgmoqfrpAAQNK4Ll/sb8UsBO5z3yNiTppebpTMBGU6mzQriv18lhPtHkGCwnMt5jlohcsIvWaQl06Ezm9MNVyGET580EVFueNhnUHFgrHNK6brlnvjAF/OrUU/dtN7SX+SkgM6mOHQ5HDs91K3KwKrMtJNIZeNZZE0UfoOnl7cZg/91Jw2RQ4fcCjtAPAXWyjql8REm2DdIf59VGLqf2g+V0Yecw0GvSNP4wdp2C9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cU+sgOXakDtGYijQ64gZND2Wf5aBlSsbn5bzbIMzBY=;
 b=fsK0aCdXENpCROcRsmGHlExqHcH32wMvjWqNOWMh/QSlupb2eNN/VIL18WLMMcCPCiUc4Dmc1b7/GAru/Ku3KLzPeXs4uaec/GjTvHia6nwDh3+GsujayazvqoXnWesejw77vZP0FPkm5XgdKiXJf4NTR/La4xl61h+zYQn1Zzq7BxqditR4T89aWBglxUMPQ2FnVGNI9ZmNhrAgACrt68ZfRXJgGS9lo+DRr0TbPya6PK1ZVbMtdLaOlSgKm2LFdIcau8ii6krezfrP5jvkyIMU9swn8LcuIVZc3kJ7gNuAy8xR76IW6+2RBkD8gJ0oXmPIxXjHPzpi3JJe6PEVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cU+sgOXakDtGYijQ64gZND2Wf5aBlSsbn5bzbIMzBY=;
 b=pUykOiAurO4DwJ1WqM/h1AmTzap6LxPFPW6fRDPJFDKjsSsovwNWB526hxi33qU+xRHcElG9NaFzzTVP8V4iUKbpG4ovPATldKVvm+O+G3bsDtUMZAw2QbHnjKS3Qtd6PttUZrMkMXo5XqgQ+hPAZLi4CK08Gyof1H5FOYC5WW8=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Tue, 16 Jun 2020 09:36:00 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf%10]) with mapi id 15.20.3088.029; Tue, 16 Jun
 2020 09:35:59 +0000
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To: Alexander Monakov <amonakov@ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
 <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
 <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
 <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
Date: Tue, 16 Jun 2020 16:35:48 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
Content-Language: en-US
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (159.192.253.167) by
 SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 09:35:56 +0000
X-Originating-IP: [159.192.253.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0bd570d1-b7ef-4733-43fb-08d811d8ad52
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449A962748243910033A3EDF39D0@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Trh1rX62RVI2kI2bPDanGQGpAPGz6n5wOMChvBlciEQlM4z4JC7f3/aNuMccFzqvqb6y8KvUKKKAtSZ4Jja8bySJfPHMfzOCc59nsdwIvewmMC2y85irHEgktyCay02i41Mv7SzFYdUcybP2QiG4hbwDv/UWh49VM2OEXQ/hU6Sc+JUApzho6F5F7a6gEon9KfAn7kEMcSz1tvaflvjv0hQV/zyjn3EaT49JMhpu0he6gYXHh3bQ1rUVX77KK9kG3sR0DKBLqvjwL7RAIUcfw4poiUuiD/jVkPLKOfVpdKOi8A3EPFvd3IRk1G1/BU0h483+gqFB/SoqIUjFIfy0yNqvGjMcKQ8lVYQoD4DSZsv3vFx0rA3YdB07agVCTvU8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(44832011)(66476007)(6666004)(66946007)(5660300002)(31696002)(31686004)(66556008)(956004)(86362001)(8676002)(2616005)(52116002)(6916009)(6512007)(36756003)(186003)(16526019)(2906002)(6486002)(4326008)(53546011)(6506007)(26005)(83380400001)(8936002)(316002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ppfQxRbr/KpTBZoyrg3b4f2CFXg+awkDVmvJK/uyp+4rvpKl+anfLsVvZpgrlGckGDUlPbJPEukHeLCGri9E3DCVxBzC7yCakqWYNYEyYKKEvZXClsHzGdPBg5bRRKgrcc6Ne98WR7ggkPyfMceNTqOaRo4VgwAR9NmrtGl5A1vf89H+218R5DSE/dEUXia9S/SqKD6XWhdn9T+kHKMXLfHQSso34oiOcba/Bx2zMAi+mA8nmLAalGDkUFzq4/Qd6D4ZE1XYAA066NiUQ2NgfQbu5seMs1mEQnQxylhvdPseiiZocNLzFjkq7JwPGEN+J/hiGt5Cf0NjUpiy5OG2xvVyIjJXpcTK2FWkF0v5RapHJ40idoJ5S/2YYgegEOxavAQWF/ka/NL+o4TtKYD0PqJ3qo/iZvDJE3VtBlm9Nd5k3mkq5Z5dz+dXIL5/koVLIMj1+23VUNI0B5kFrhebcrxEnYUzsRb2u5AMhfYOqjlXGZrM6uxnl4RmlfR8oy+i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd570d1-b7ef-4733-43fb-08d811d8ad52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 09:35:59.8220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3sU3NJiEFAbPsKW0gjJt8ub6sGc5f0qbNnv1G9GJUumX8axlBWPzk7VJ4z6I/V0HCTpov4IbHB4QhtzN0WDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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



On 6/16/20 3:48 AM, Alexander Monakov wrote:
>> Alexander
>>
>> On 6/1/20 4:01 PM, Alexander Monakov wrote:
>>> On Mon, 1 Jun 2020, Suravee Suthikulpanit wrote:
>>>
>>>>> Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
>>>>> the issue. This is the earliest point in amd_iommu_init_pci where the
>>>>> call succeeds on my laptop.
>>>> According to your description, it should just need to be anywhere after
>>>> the
>>>> pci_enable_device() is called for the IOMMU device, isn't it? So, on your
>>>> system, what if we just move the init_iommu_perf_ctr() here:
>>> No, this doesn't work, as I already said in the paragraph you are responding
>>> to. See my last sentence in the quoted part.
>>>
>>> So the implication is init_device_table_dma together with subsequent cache
>>> flush is also setting up something that is necessary for counters to be
>>> writable.
>>>
>>> Alexander
>>>
>> Instead of blindly moving the code around to a spot that would just work,
>> I am trying to understand what might be required here. In this case,
>> the init_device_table_dma()should not be needed. I suspect it's the IOMMU
>> invalidate all command that's also needed here.
>>
>> I'm also checking with the HW and BIOS team. Meanwhile, could you please give
>> the following change a try:
> Hello. Can you give any update please?
> 
> Alexander
> 

Sorry for late reply. I have a reproducer and working with the HW team to understand the issue.
I should be able to provide update with solution by the end of this week.

Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
