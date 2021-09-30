Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193F2C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 10:57:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F216619E2
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 10:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F216619E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45DE342587;
	Thu, 30 Sep 2021 10:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phZ_9GrGpt7l; Thu, 30 Sep 2021 10:57:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03B1042582;
	Thu, 30 Sep 2021 10:57:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA851C0011;
	Thu, 30 Sep 2021 10:57:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08F6EC000D;
 Thu, 30 Sep 2021 10:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8E2C84044;
 Thu, 30 Sep 2021 10:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="hZT0AaFs"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="hZT0AaFs"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ZCW9BE-6TfA; Thu, 30 Sep 2021 10:57:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30077.outbound.protection.outlook.com [40.107.3.77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45CBB84042;
 Thu, 30 Sep 2021 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkAKYa1gMIIUByASee1s56jAoSvExuXSp/OZ6nCs8ag=;
 b=hZT0AaFsgzFQ3M6c5tb8Xz3t4CkbK6sQWzU/ZD2U5iHukkW9QZh76jKPBV5Iv3OoAvOVSMvc35rIaBl0/dFgQ66L1CeXUQEF/4y15EgyLl4KnPC0dkPg/Ueh9CGCkckZiYyXUAs5EgCZOQHA17earjIVYf3g6vIlgpsGkjQ8v80=
Received: from DU2PR04CA0216.eurprd04.prod.outlook.com (2603:10a6:10:2b1::11)
 by AM0PR08MB5058.eurprd08.prod.outlook.com (2603:10a6:208:160::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 10:57:35 +0000
Received: from DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::3) by DU2PR04CA0216.outlook.office365.com
 (2603:10a6:10:2b1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 10:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.33.187.114)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.33.187.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.33.187.114; helo=64aa7808-outbound-2.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-2.mta.getcheckrecipient.com (63.33.187.114)
 by DB5EUR03FT058.mail.protection.outlook.com (10.152.20.255) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 10:57:34 +0000
Received: ("Tessian outbound ac52c8afb262:v103");
 Thu, 30 Sep 2021 10:57:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 423bb737f23d2a90
X-CR-MTA-TID: 64aa7808
Received: from 27dc911c7288.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 74E55384-9329-493D-AE39-A57911A5A7DA.1; 
 Thu, 30 Sep 2021 10:57:24 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 27dc911c7288.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Thu, 30 Sep 2021 10:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDsBGhxFUBLQ+VgXLIScMxPYTYBfz9yeQsQF7nKN6a07W1xKafSLB60rxeNWRmjs8Up4l1Dm5SPdr24APQYP536MHZBTlLAwx2nXfQ0jl76Xsqgu7la9aQE49Ah/mOWsHqFcyKqCoSLsJAcCCyRzB14tt/3RC33EwcjwfQyNRyMlCXmgTQqLBT2dJ1Xx0sPJOzD1IeIL6Nf94bvFJIRb4D0tuceqpotigZGC0bvtcQ23gzNK16iXEHiOgSQDtLg+JOXdbGD5wCsatj182wjdzXh1oDkVQkLV+DQFF3r/7oLz3VTasK7glC3npBiw7Rpx1OCcIm8HJkp37XdM7Jujvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=DkAKYa1gMIIUByASee1s56jAoSvExuXSp/OZ6nCs8ag=;
 b=L6yzE9aypYjZTyYnfli/o3nD+iiryp7jopL6Ov83MAvPaMNtFY3aqe06wgaq4nnRjYro/j1s3ABJMeFrRdilvxA0ZKV7wbWwkBzzovy9/5Wnbl6oPCpYVpulgdRSjG69q7a8csDFfLYh8MdiLf3NDSHsfXKuqpywyS/1vKWDHAll/8eiZKyp6kh9slAvVGOMkTCjVtoZ7w3PZ93z9pFbAc10usKV9aDD7NfzAjxtgJn3u6U2jQxFPwlpyZMwlCNR/FgPP1wB2e242sJg3ocR7a85lfCdZLRn6meH/S2ZVFMdoq2hkaHr4YHEQ+pItmmwKbIk648Xx94SeBMm2BLOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkAKYa1gMIIUByASee1s56jAoSvExuXSp/OZ6nCs8ag=;
 b=hZT0AaFsgzFQ3M6c5tb8Xz3t4CkbK6sQWzU/ZD2U5iHukkW9QZh76jKPBV5Iv3OoAvOVSMvc35rIaBl0/dFgQ66L1CeXUQEF/4y15EgyLl4KnPC0dkPg/Ueh9CGCkckZiYyXUAs5EgCZOQHA17earjIVYf3g6vIlgpsGkjQ8v80=
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB9PR08MB6444.eurprd08.prod.outlook.com (2603:10a6:10:23c::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Thu, 30 Sep 2021 10:57:22 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501%6]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 10:57:22 +0000
Subject: Re: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id
 and flags information
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-2-vivek.gautam@arm.com> <YUoBHA6NZaz8wlkA@myrica>
 <3b490967-58b5-7c4a-2275-250e26d24aeb@arm.com> <YVV6DD7zmy1MKva0@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <03a3d20c-732c-b9c7-c090-7b476a277a12@arm.com>
Date: Thu, 30 Sep 2021 16:27:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YVV6DD7zmy1MKva0@myrica>
Content-Language: en-US
X-ClientProxiedBy: BM1PR0101CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::25) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
Received: from [10.162.16.71] (217.140.105.56) by
 BM1PR0101CA0063.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 10:57:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7443bc5-f2bc-4fef-312a-08d984011bd2
X-MS-TrafficTypeDiagnostic: DB9PR08MB6444:|AM0PR08MB5058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB50586C23289EBB030C54C5C089AA9@AM0PR08MB5058.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MKCU0JCIbc432IEKyjDtK8RvJ3Yt4Zf0hG/R798iXuw3qXiEg3C8GUGguetcmaaM8g1/qWsXnEejDmZsXbALHkJywIwxgPfSrSoCArnmN8jf2yXSr4rp1WHWtdbcVxKRycxH2P8kvp1k0Ipvz6uJOeRRtgTxH1W9Jeg6wWXjKEfXAyU5ANAivbrnAXRFyayD8qXBipMBzBWDQO1J6AS4Kx/oCSOIiiRqR2PvRNPTwjVGWEeEou6eO1mSbAqZVxPKr9FFpTcZfctSvO/x2XiSuH+gvwjhFalLbszYOfsS7fUECYTRPGAOLa5h3gohb4JStW/KRFvvK6FXXZLZ1kYWpHvJjWJAHwmSodD3t49eJLWPGJREEV68znXsfpDUDqJHmILQlnOICaxhavnRqojiFdlfvOV8HRYV6IV+w/RLVBzLatwn4WZwYVLElhuhaBT99c4ukTtO8dV16MDZmoYsbI/mSxOsuXFfO/xBaGxkRIo3XzV3MS65IU1KjaN5i5uHYiIwuZR6pSGbvrBxIFijp3h7k7YvvZHq/9ybqWjbv6V7cJZNJUiwE2oCQB7jpYIBzzQFQPncbP9cmtFXu6vGI7besmv7QPjWRAi6rHm0qBKBR+fpn9fxCu3RKlC8Tkju0iToDiMpXYcUrcdraiADTOVKBlpQSGEkOmOiqmXFD1FvfBFUtj58k11y7HRHs24KD1f1mzfXZOBOfv9JjxsK4NqEqU+2F+KuQqGPRfAcCLHv5qPXssq2CmVoLUNdiL86sSAf5Qhk3wLIFkX5/AOFfg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR08MB2645.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(316002)(508600001)(16576012)(6486002)(8676002)(7416002)(4744005)(26005)(5660300002)(66476007)(66556008)(66946007)(956004)(36756003)(6916009)(2616005)(53546011)(86362001)(38350700002)(38100700002)(2906002)(31696002)(186003)(52116002)(6666004)(8936002)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6444
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: fbbc3f2b-bd25-4c4e-a9cb-08d984011437
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSFnDRKVbEJJAVI60MxKwLeeNDbTvLrSjgLCC/c0N8cwt6AYXTtO2rddg2nUIrNy8ihxdahp5lnni2K9pyFgRsQkTkAfwDgzll6g+eE3JqOw5DRwwqRpaeqzFBwJ0U0IvUQgNqk94r/gGeY+GAatY71jP9+o8XA6/DZhtxQZInGAlKJMGTjLOP/P70Imj+xi61oi5LZ9ykKYFcnkzEoErvXfK2GwN0E7eUWbhClanwZqqZ3spfGUOORQEQ5dOf6xmAAJdLOUcEJIfdLJg4B5nbNA2iWZGzuLue+fVmJNdQClSdCMAX8LDdju7OMUsBS9yQLgiW0MaSeFg5Vsxls+wXRvztKjtzoyWlCcXfn53lMpl6tni5Ta8rLagL9mVtfGO9yb9ZB8lt10raVfJTmeC2bhcuSpGVtrBA6gH8hhSrKIC4AYDVlzcbSQCF8NfHNvcTJneTNYiFWwLDLzGVIqh4NDc736jcUyoXwX2cFNkCinXc96ba1oWld1Zpj5nVdNhhj9FuQm397jH7eOJQBLMAVFVsdSqRFKktTqnsz1UAA/reB963IfLhjajG7/xT85tgUwYOZ2TOx1VlpylLiVlr1NdRV6v29GfoALQ7l+BjJ1o40bLHAkfk0tDoS0teLg/tBBj/Mwff2uImWFk+uJbk1NWqsY9rI+ZllzSdelWbj01clWnv9P5A7fY4+XpGKNrqw5lOBNi4MV47Gx4IMfs7efXiFrmgFTVO59njN4ovI=
X-Forefront-Antispam-Report: CIP:63.33.187.114; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-2.mta.getcheckrecipient.com;
 PTR:ec2-63-33-187-114.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(356005)(16576012)(316002)(336012)(26005)(6666004)(31696002)(186003)(956004)(8676002)(2616005)(8936002)(5660300002)(508600001)(36756003)(82310400003)(53546011)(70206006)(2906002)(36860700001)(107886003)(4326008)(4744005)(86362001)(83380400001)(31686004)(47076005)(70586007)(450100002)(6862004)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 10:57:34.6119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7443bc5-f2bc-4fef-312a-08d984011bd2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.33.187.114];
 Helo=[64aa7808-outbound-2.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5058
Cc: kevin.tian@intel.com, Alex Williamson <alex.williamson@redhat.com>,
 mst@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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



On 9/30/21 2:19 PM, Jean-Philippe Brucker wrote:
> On Thu, Sep 30, 2021 at 10:26:35AM +0530, Vivek Kumar Gautam wrote:
>>> I'm not sure why we made it 32-bit in Linux UAPI, it's a little wasteful.
>>> PCIe PRGI is 9-bits and SMMU STAG is 16-bits. Since the scope of the grpid
>>> is the endpoint, 16-bit means 64k in-flight faults per endpoint, which
>>> seems more than enough.
>>
>> Right, I will update this to 16-bits field. It won't be okay to update the
>> iommu uAPI now, right?
> 
> Since there is no UAPI transport for the fault request/response at the
> moment, it should be possible to update it.

Righty! I will add a patch for that too then.



Thanks & regards

Vivek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
