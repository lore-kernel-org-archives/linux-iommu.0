Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A574C433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 19:30:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF8223109
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 19:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF8223109
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7D45086EA3;
	Tue, 19 Jan 2021 19:30:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q+pciJwcsKaI; Tue, 19 Jan 2021 19:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5F9A086D63;
	Tue, 19 Jan 2021 19:30:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34AD7C088B;
	Tue, 19 Jan 2021 19:30:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 798EFC013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 19:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 644E386D63
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 19:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpUQanfqZs0j for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 19:30:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6D70A86D42
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 19:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5YdILU3fVnTUJLxrW1RaBKTGPR+dIGrLqVxJ/8VnHp9BdWdO8NLQqKaxUV1OVaMxCZQvly6eC2Blkq72sUnAdXzxWL9aITrtUG0OAIL38WrGsgp5O+9q1RO1gUo2pkAJzTWErmtAOFG3576vqC2xv3FoH1Q+WKjs8icFXxr120tQ5NVreFijM7ea1QbjsPDnoBQ8hR3I7UTM8oGHy5Vu1V1Tw5cEWMJ+89c3uhQiuRo7Jz6d2jrsR6MUNt7CI19tg1Be9r24lkiPeX3Rj5COWT0Ag4BX2PwCc0k+RfuEQCZBZCP9bD4UcxpovSFgKgNrQpkpU+O2cGXYMzhKeL08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHdpuoZtVPjGNmO1LuG9X80SJ6nzMJSl4GKZFpLxq4w=;
 b=j6OC3ueovTxUwne12YN00oyy/tKBZfAz1vVzocWPAsOERMKxzld15EHq0CpIN+ccw36oYkHPeSF7He2bvQN57qhl+U37/XJQCAJV63yJovfuyBrqDBWSQqNPpTvJP4JbrU/Zea7ABch5fCT5LMK4kkwyq949kwhg4mhD64xcwAccMnxaSTrX8flQayWOW/PCO2cSxyIn5AnrLMEAXBhY0qDSnIvXNpusB1bQbBmt+NGUVyRD9Nfl1WSaTBIPbBGGvZ93VAWHrbizx80jiHFgsSpvyz5irB+64ihlr34l5gnYIwnfIehJy7oV+4FQaj7cYhtZCYvkWdC1t9Epk8aEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHdpuoZtVPjGNmO1LuG9X80SJ6nzMJSl4GKZFpLxq4w=;
 b=AdlkJuKTbju27ki3XTgSZAD9cfyJ3skM1KQfkQaK8bXeajRnD+pbyJ7qN8lvw6EvPyhZGEE4Cxw1sDic+7T/2Z7Cpg0mC0TZrPvQW+7edzCKYv9k6b59s6EcaDPL6eymjz8w+AvEx1O/GMu+PJLOvRz68mHsBR2dtXNr6QZ90Jg=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Tue, 19 Jan 2021 19:30:43 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 19:30:43 +0000
Subject: Re: dma_mmap_coherent() breakage with mem_encrypt on AMD Ryzen
To: Takashi Iwai <tiwai@suse.de>, iommu@lists.linux-foundation.org
References: <s5ho8hmgi3k.wl-tiwai@suse.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f86f5fd3-c9d7-aa28-da78-f634b324f003@amd.com>
Date: Tue, 19 Jan 2021 13:30:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <s5ho8hmgi3k.wl-tiwai@suse.de>
Content-Language: en-US
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:806:25::26) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by
 SA9PR13CA0231.namprd13.prod.outlook.com (2603:10b6:806:25::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.4 via Frontend Transport; Tue, 19 Jan 2021 19:30:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a459b9d1-b53e-417c-7b53-08d8bcb0b67a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4075:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4075F2C8C7650BDA915729E2ECA30@DM6PR12MB4075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+ai1I9Q7jba9IKsazxuaJaxm/msqy+55mBT3PdR5PIwQcKMiAOcsFrEqhNC+EouQSzzo8F1VuDEKg5mZtGAk7+wLjPrX1ttz3iYdl+EocKlJv72S4VppuYYnE7WH1x9xAj4DYE8lPHbJSydQAyViHeIZQ378t7rH0mpv9YpZWcymPoeu+GS2OjiVd4tDVoSkAEZ7rwgoEzxMsR/Ncpe00dgHw1i79lLRV8Avnp4+B0YfOaIFFZn6qEbanlJNgbNaSuRivMAWyc6B6K+m4RCfipQhGbT0GIdQ2Cxdr913cubsSGs0IBt5/FKkTwRdH/JuAQpKCxcv8d6uA8pRLv6OtWUi4RU5aQg/zH4HcmhgwKC6MCpdkCD40m5WAbl45//xIzCvHOsj20/SfDwrcPLV8FUI80wl39YjdsrGJPOuNgrk0JQMo9TpYGGRieSICwrJYspqi3B1aT7dJvf1WDJu8N/cO4J3nU0+GDO4t7nkAafqDfnPsM5Ejdy5Frj0JIGUGRQRFjfKyVezHpkxpzp4fPUyx/gthIlbt23Z7Zgt6DqxQQhBlgHghuPdZHUSt5z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(966005)(8676002)(31696002)(956004)(36756003)(6512007)(53546011)(2616005)(316002)(52116002)(86362001)(26005)(66556008)(8936002)(66476007)(6506007)(6486002)(16526019)(186003)(478600001)(45080400002)(31686004)(2906002)(66946007)(83380400001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QnZOem85N3pkSVFUcjJyeGhuQXlHM3k1VTcvNi82eWx0bTFPWHZGMjBpUU9W?=
 =?utf-8?B?Q21RNWF4enNpaUM0RHlwMmc5L0tlMmlpWGljbXVlYkhSbGhqWnZtUUhXcnU2?=
 =?utf-8?B?WS80VisxMGgza0x4M2NOSVFTZmdrRUNFTUpjWGE0bWFkMDJuU0lnR1JERHlw?=
 =?utf-8?B?NFBSWHJxa08vM3hXN0dkcTl5cVh5OHkrSEVVdm5XQ29qYVJoRGU4UzFrL1Fk?=
 =?utf-8?B?WjFDczRKR0hFcVlLK1RUa0pHSnMxcmVvZzljU3RPV0E4WlVPeW1nVkx6ZTdy?=
 =?utf-8?B?QXpCQXZpdlU0MVBuRzAyZFZGOWZXVUgwbGRYQzJHQkNsMGdaSXNFcWVJVlVl?=
 =?utf-8?B?R3VYV25mNTd0aXRWTHJ3elZadXpGYlpGYlh5U285dmpxZEYxR2docGt2V2N3?=
 =?utf-8?B?VE5qVUNRREVtMlRIZ2lvTGVjYkJCaWttTmx6OEJnRUNUQ011NVQxV2tyc2px?=
 =?utf-8?B?QkxQK21NTzUvL3BhcGErOTJnbGpiNklBaTErcW9TdzZOR2VpTTEyVHpYQW45?=
 =?utf-8?B?WlhyR1VnanBvZ0dYNFhwMFJHeVFZeTBncTJVVFFBT1krYlFTY1VTaE42Ym4v?=
 =?utf-8?B?S204bU9KbjFINUx2Vk5WTGpKOVJZdUkzYW9Pd00waGg5d09WbklvNGlzNWZ2?=
 =?utf-8?B?TUs0NFdqKzFtL0pvVm8yc3FIRWlhUStVQUJ6TDc5NDUraUVkdjRkYStteWVZ?=
 =?utf-8?B?NjRRaXRSYkVIc2xUdEVOKy9VemMyMmltRmhpeVhOZVlFNzVnSDl5Um92ampX?=
 =?utf-8?B?ekdDcmFITEFGNmxvVDYwdEgyMitZSkd2TzhzSnpHSlZEMHIxZG9vSkhNcGMw?=
 =?utf-8?B?QTVscnFodHJpSHMzeXE5ZVRzRWlwU1BOQnI2QWZEMU83MWwySE1aRW9zWkwr?=
 =?utf-8?B?Vllld2NYdk00UUtCSjkyZDd3NHIvR1FSQ3VkekE3MkxSUU9HdXJGWHoxa2Vt?=
 =?utf-8?B?SVM3cWFrNTN2K2dMV1l1MzJkZDBOdlpaVkZEVUsyb2Z5N3VCcjVnSDd1QmtO?=
 =?utf-8?B?UjlKdHZCd2JzS3FlNkFJaDBwTEdYUnpnVXZqdkhaeVRSRG1rSFhHVDVYa1dv?=
 =?utf-8?B?SHpaN1hobm1TNXEzTXg3aWtEL1h6VksxRTFlNkdJeCt4K0RvQndraHc1Z2o3?=
 =?utf-8?B?ZHFDTGpsTHQzdmVPcGt1Um4zOUpMK2loZ2ZaeHp6cHJONGhFWDRVVG94b29n?=
 =?utf-8?B?c3hUMFlaNlcyLytFR1JTY2pubnh6OHpzRVpWYmFuMWpFYlFvckxXUVczYllQ?=
 =?utf-8?B?QVZ1QW5zWXhZQlJkWUVyN25pWVlFSmJBMk5vS2w2SGpXaDN0bnhnS0hkRGdM?=
 =?utf-8?Q?NXY21fffC+Ht472QgV5NZtrbT41gxkTxAz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a459b9d1-b53e-417c-7b53-08d8bcb0b67a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 19:30:43.6700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9HbkzwA9nDkAS+9hRrvggx9ZUD428AMFOW/ZnPk1pcc5cSLVpmHE28/ZIwhcHoPuOQxs3m0MDeo2fsQuGFQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

On 1/18/21 1:28 PM, Takashi Iwai wrote:
> Hi,
> 
> we've got a bug report recently about the garbage playback sound from
> a PCI sound device with mem_encrypt on AMD Ryzen:
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D211117&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C8f5024e991b747d3aada08d8bbe73df5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637465949142766079%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4i6%2BUkt%2BebHJPlAvkDxgJkIcKq0eF9E4ssZC9vNBLHY%3D&amp;reserved=0
> 
> The debug session showed that this happens only with the mmap using
> dma_mmap_coherent() and mem_encrypt.  The mmap with the legacy page
> fault (as done in ALSA PCM core) seems still working even with the
> mem_encrypt.

This sounds like a mismatch between the encryption bit in the kernel and 
the encryption bit in userspace. It looks like that should be taken care 
of by the dma_pgprot() call in dma_mmap_attrs() or in iommu_dma_mmap(). 
But maybe the force_dma_unencrypted() in arch/x86/mm/mem_encrypt.c needs 
to understand if the IOMMU is doing the mapping. Since, even if the device 
doesn't support 48-bit or higher DMA, it will still done encrypted because 
of the IOMMU. Is the IOMMU enabled? What happens if you do iommu=pt on the 
kernel command line?

I'll also add this comment to the bug.

Thanks,
Tom

> 
> Since the problem could be observed on two different PCI drivers, it
> looks like a generic problem of DMA-mmap implementation with AMD
> memory encryption.
> 
> According to the reporter, it's seen on both 5.4.x and 5.10.x
> kernels, hence it doesn't like a recent regression.
> 
> Can anyone take a look?
> 
> 
> Thanks!
> 
> Takashi
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
