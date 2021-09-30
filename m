Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76196C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 04:57:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8C26138F
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 04:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC8C26138F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78B4942544;
	Thu, 30 Sep 2021 04:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZXO_BdGUdjx; Thu, 30 Sep 2021 04:57:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0779442524;
	Thu, 30 Sep 2021 04:57:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC43AC000F;
	Thu, 30 Sep 2021 04:57:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9FEEC000D;
 Thu, 30 Sep 2021 04:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B59206076A;
 Thu, 30 Sep 2021 04:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="NT5SwQ+f"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="NT5SwQ+f"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yvioi_3eOVSq; Thu, 30 Sep 2021 04:57:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A4856075E;
 Thu, 30 Sep 2021 04:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRw1j3ERvooeG0UCuv/UqZGm6kIInQkq+pCDBldhueg=;
 b=NT5SwQ+fCaMpVhAZtNY/FAzpgMMhsX3oyjFKRdlO8vAHIyjQhQu2lksKY4OW0W9M/UX02ENy5s78FdLg5k7sFe8vtLWigTPNrLUA4tDaKBJu8QGo0jZ8ERDWwBojJ+gVC56UQVApNj7SK9ohu3qKrUlDNjEgfmm5piXdkBuR0hI=
Received: from AM5PR0101CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::31) by AM0PR08MB4530.eurprd08.prod.outlook.com
 (2603:10a6:208:13c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Thu, 30 Sep
 2021 04:56:57 +0000
Received: from AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:16:cafe::a0) by AM5PR0101CA0018.outlook.office365.com
 (2603:10a6:206:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Thu, 30 Sep 2021 04:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.33.187.114)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.33.187.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.33.187.114; helo=64aa7808-outbound-2.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-2.mta.getcheckrecipient.com (63.33.187.114)
 by AM5EUR03FT005.mail.protection.outlook.com (10.152.16.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 04:56:57 +0000
Received: ("Tessian outbound 1fd2edb24cb2:v103");
 Thu, 30 Sep 2021 04:56:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b270f002fc72ad22
X-CR-MTA-TID: 64aa7808
Received: from 0b87cee5886f.3
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 659A67F0-4AE1-4CF1-9703-1F827243564D.1; 
 Thu, 30 Sep 2021 04:56:47 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0b87cee5886f.3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Thu, 30 Sep 2021 04:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dococ41s35gaEMZ0Sqtm9sZruKvbXdlHB3MyPGdOCYMG81DlpOrROedvrA94QfAC+1vF2Pzg2K844+X4W1Jz6fhSkYZ7usDXKxKmRmVnLnDlQPm/5gFgFaEc7LKTizd2XVDbEOJrFn7r/OC9Lebjp0k+g4auLY0iOvLJBAMP6livgZmMThYtFkOpxxKvuV2SLTYuPYSA0/cHWGeXIEIJ9rn7NPbkZFJd648cB22LL5cjD7x0Iq2Kp6IN+QNT+nFo0ZCpRlUHEQ28OqYxNQKVb6lwtqYE8eA1RoZVBzc//hYrOIuNA32/t+3ArTY3Lpbv+IY/6ShPxZj00h24NcpKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NRw1j3ERvooeG0UCuv/UqZGm6kIInQkq+pCDBldhueg=;
 b=Y3dZQQOO60g6XEys0kBTmW07jo4jED0yA4S2T36MgSunRVNALLbKkUd6sxlsbsI60J4+AN2FvKLs42cQzAYKNjKxLQjXANAv6RQ1qJfaUTXnVVDGwJ6RP3WNd+CUXYBTawXmIjqt67SjIHUSL8lAbHwecIjRbgT1TfhshxGrksqnL1qxqb4Kbn0MsB6DCYjpVC31ujuG8R/mZpl+2PmeGw7P5oaddQh2JlSdEz9JAMYHD51hvo+OgxxAHmndmButQ1P/uDA1Srrr1vqYqVehQk8sv2fgJ4EvFmKQD/44WzmI7xxdP/butHpmHOd7Gz8GNK7BWlhpLFchDg3/vc7dYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRw1j3ERvooeG0UCuv/UqZGm6kIInQkq+pCDBldhueg=;
 b=NT5SwQ+fCaMpVhAZtNY/FAzpgMMhsX3oyjFKRdlO8vAHIyjQhQu2lksKY4OW0W9M/UX02ENy5s78FdLg5k7sFe8vtLWigTPNrLUA4tDaKBJu8QGo0jZ8ERDWwBojJ+gVC56UQVApNj7SK9ohu3qKrUlDNjEgfmm5piXdkBuR0hI=
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB9PR08MB6713.eurprd08.prod.outlook.com (2603:10a6:10:2aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Thu, 30 Sep 2021 04:56:43 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501%6]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 04:56:43 +0000
Subject: Re: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id
 and flags information
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-2-vivek.gautam@arm.com> <YUoBHA6NZaz8wlkA@myrica>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <3b490967-58b5-7c4a-2275-250e26d24aeb@arm.com>
Date: Thu, 30 Sep 2021 10:26:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YUoBHA6NZaz8wlkA@myrica>
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
Received: from [10.162.16.71] (217.140.105.56) by
 BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Thu, 30 Sep 2021 04:56:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e4792f0-f89b-45c1-5a6a-08d983cebb1f
X-MS-TrafficTypeDiagnostic: DB9PR08MB6713:|AM0PR08MB4530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4530A81963CDB7E0F1864BF989AA9@AM0PR08MB4530.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zlXLqQUvHW93KDy8cguEACuygQNipzBzXUCOg/UOd/cbAksUKcrxgqDvkLFU2Hxx+umuISe7GjKVkApBlZHgwAO4g109VllQGtN2x6pa3kAPHBrR0URxQxsqvri10eTrRQzWV2fXaHk4GMLk47O/S48SC+ZzF6XsWFMZ2MNrz6T/oEOqNoAPaROIjjPywBzE7Im3ipf6/zK33huefwbkAr6PJmI72cVb11ZCKT5gVKswPhz+vA7oq0ACygFmgpPEs9DkONWqCBaBtAAYVQ9kCk9WX31sJTz9tECWnNuIcCv2//lsTpUUURl+ZqjY4DIGyKQXmz4eRNNDDXaSBPf0ujaV6vH/1p/ajHfnqCjdg3AGSk7PTwc5DHB1j+FayZHxr5gtByFZ6OdrmpxSx6194ceFjgTuPf/WwcdUKI1fygLbT4zeb5RuJnppZzcYAN6j3lHyiocBMEH+HDcUQ50veGzSOv7/x6rnSgtAvnGEUUm+qEjWPV9L7v4bIaD+i5d3t0F8to66T3eg6fb4ahqfUYAvt6gCbPOz8/2OmtJm8jECvHgwtr6AFfWdzQoUaCH/4tQgHYhNWbL0nDznjhW66kml7cB+ASrvM2Q5hDN3vN4R7EJUif/nZd6n/Cc7dAhvaiM2xTWbBC3rVgnbAQ2QOIWzAF/ymEJkzv0TOl2w8B97WPvXSkAhyc9SC/U2k0OLuYuogLLErrRBWi4Hhi9Gqjdtik9xyrPqPXmYCip7b6e9qkKm6jTYlpcrnel6K0kfSdaHcnlIInHvuKN0OG3d7A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR08MB2645.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66556008)(86362001)(2616005)(66476007)(6486002)(8936002)(66946007)(7416002)(36756003)(38100700002)(38350700002)(16576012)(316002)(2906002)(4326008)(8676002)(26005)(6916009)(508600001)(31686004)(52116002)(956004)(83380400001)(186003)(31696002)(6666004)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6713
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d9d180e4-8b68-4f7d-7882-08d983ceb282
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ElAIKRgmyBBq30cjqimFue7zSUaY5F49lNR9H6siyXB/D4HnqTvSai8wTxUMY8/K2sco6eucWrzjFj21ncDtuWBRjegQhVkgZnZiYTCS8ckS550O6RQNrBNhqEWUrOf9nNsaCuh9/kIgyZd/CXl1fV8LcfQFXyfkY9l2+i5eUSW6aHBJQit9XupY42e0zesl7S2GhGPF2p1SvhEwK8B0xNKQr/0BoEh/m6BWmMYzwevZRvh1o5zMhy+PMkcHXbeMQ2RTvetwU+fIb8dFv5agZ+DLInkLgLKRW4yfMV1EwEJ3MM+sk/iukBQ9DgNE1t75/OLHEv724U4Fn6ts4RAxkhiqZmMp7fxllVGudy3Cbil/d2+PXVjxks/f9UDYlEEEN8yS1HbboZpG4gIalGvYYNg1R1Hj0kiO8K+j+ohLshRUyBI5tFeReznkqwFCTJRFjZiUD+dVychJRbH45oW2Wd0UApWc1gNnY68ii26wVsQF9fRhnKTCB0UzoHS3+pja+O/f5xSBCgZphbEq0RmnmfvuFzkSaFbRt/AKrM+9CmRAG9Nq9lkiHY29g7B1Z2eylDf6K8iXRDepwcMwSr/VRJMuxPSy8flE+ZKD8YSr6AqvqV2t//QjOhHLlkI9DWUKDWKO/QDv7aNffqrJ4+qtxQv8NgiB5tv8DPz1ntLWL4pYXcT0WT0DRo8Lv1hONMEEIDhjrVgWSioTlPEFSdtX9hqn1f9TRJ1dGVS7bgT1Xc=
X-Forefront-Antispam-Report: CIP:63.33.187.114; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-2.mta.getcheckrecipient.com;
 PTR:ec2-63-33-187-114.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(31686004)(186003)(4326008)(47076005)(86362001)(31696002)(6862004)(8936002)(53546011)(82310400003)(450100002)(336012)(83380400001)(36756003)(356005)(36860700001)(70206006)(508600001)(70586007)(6666004)(2616005)(8676002)(26005)(6486002)(81166007)(16576012)(316002)(5660300002)(956004)(107886003)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 04:56:57.4562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4792f0-f89b-45c1-5a6a-08d983cebb1f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.33.187.114];
 Helo=[64aa7808-outbound-2.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4530
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

Hi Jean,


On 9/21/21 9:28 PM, Jean-Philippe Brucker wrote:
> Hi Vivek,
> 
> Thanks a lot for your work on this

Thanks a lot for taking a look at it. I hope that most of the changes in 
this series and the nested page table series [1] are independent of the 
presently on-going /dev/iommu proposal, and can be separately reviewed.

Please find my comments inline below.

> 
> On Fri, Apr 23, 2021 at 03:21:37PM +0530, Vivek Gautam wrote:
>> Add fault information for group-id and necessary flags for page
>> request faults that can be handled by page fault handler in
>> virtio-iommu driver.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   include/uapi/linux/virtio_iommu.h | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
>> index f8bf927a0689..accc3318ce46 100644
>> --- a/include/uapi/linux/virtio_iommu.h
>> +++ b/include/uapi/linux/virtio_iommu.h
>> @@ -307,14 +307,27 @@ struct virtio_iommu_req_invalidate {
>>   #define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
>>   #define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2
>>   
>> +#define VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID		(1 << 0)
>> +#define VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE		(1 << 1)
>> +#define VIRTIO_IOMMU_FAULT_PRQ_F_PRIV_DATA		(1 << 2)
>> +#define VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID		(1 << 3)
> 
> I don't think this one is necessary here. The NEEDS_PASID flags added by
> commit 970471914c67 ("iommu: Allow page responses without PASID") mainly
> helps Linux keep track of things internally. It does tell the fault
> handler whether to reply with PASID or not, but we don't need that here.
> The virtio-iommu driver knows whether a PASID is required by looking at
> the "PRG Response PASID Required" bit in the PCIe capability. For non-PCIe
> faults (e.g. SMMU stall), I'm guessing we'll need a PROBE property to
> declare that the endpoint supports recoverable faults anyway, so "PASID
> required in response" can go through there as well.

Sure, I will remove this flag, and rather read the PCIe cap to find out 
if PASID is required or not. After this series, I will follow up with 
the non-PCIe fault handling.

> 
>> +
>> +#define VIRTIO_IOMMU_FAULT_UNREC_F_PASID_VALID		(1 << 0)
>> +#define VIRTIO_IOMMU_FAULT_UNREC_F_ADDR_VALID		(1 << 1)
>> +#define VIRTIO_IOMMU_FAULT_UNREC_F_FETCH_ADDR_VALID	(1 << 2)
>> +
>>   struct virtio_iommu_fault {
>>   	__u8					reason;
>>   	__u8					reserved[3];
>>   	__le16					flt_type;
>>   	__u8					reserved2[2];
>> +	/* flags is actually permission flags */
> 
> It's also used for declaring validity of fields.
> VIRTIO_IOMMU_FAULT_F_ADDRESS already tells whether the address field is
> valid, so all the other flags introduced by this patch can go in here.

Sure, will remove pr_evt_flags field, and move all the flags to 'flags'.

> 
>>   	__le32					flags;
>> +	/* flags for PASID and Page request handling info */
>> +	__le32					pr_evt_flags;
>>   	__le32					endpoint;
>>   	__le32					pasid;
>> +	__le32					grpid;
> 
> I'm not sure why we made it 32-bit in Linux UAPI, it's a little wasteful.
> PCIe PRGI is 9-bits and SMMU STAG is 16-bits. Since the scope of the grpid
> is the endpoint, 16-bit means 64k in-flight faults per endpoint, which
> seems more than enough.

Right, I will update this to 16-bits field. It won't be okay to update 
the iommu uAPI now, right?

> 
> New fields must be appended at the end of the struct, because old drivers
> will expect to find the 'endpoint' field at this offset. You could remove
> 'reserved3' while adding 'grpid', to keep the struct layout.

Sure, will update this.

> 
>>   	__u8					reserved3[4];
>>   	__le64					address;
>>   	__u8					reserved4[8];
> 
> 
> So the base structure, currently in the spec, looks like this:
> 
> 	struct virtio_iommu_fault {
> 		u8   reason;
> 		u8   reserved[3];
> 		le32 flags;
> 		le32 endpoint;
> 		le32 reserved1;
> 		le64 address;
> 	};
> 
> 	#define VIRTIO_IOMMU_FAULT_F_READ	(1 << 0)
> 	#define VIRTIO_IOMMU_FAULT_F_WRITE	(1 << 1)
> 	#define VIRTIO_IOMMU_FAULT_F_ADDRESS	(1 << 8)
> 
> The extended struct could be:
> 
> 	struct virtio_iommu_fault {
> 		u8   reason;
> 		u8   reserved[3];
> 		le32 flags;
> 		le32 endpoint;
> 		le32 pasid;
> 		le64 address;
> 		/* Page request group ID */
> 		le16 group_id;
> 		u8   reserved1[6];
> 		/* For VT-d private data */
> 		le64 private_data[2];
> 	};
> 
> 	#define VIRTIO_IOMMU_FAULT_F_READ	(1 << 0)
> 	#define VIRTIO_IOMMU_FAULT_F_WRITE	(1 << 1)
> 	#define VIRTIO_IOMMU_FAULT_F_EXEC	(1 << 2)
> 	#define VIRTIO_IOMMU_FAULT_F_PRIVILEGED	(1 << 3)
> 	/* Last fault in group */
> 	#define VIRTIO_IOMMU_FAULT_F_LAST	(1 << 4)
> 	/* Fault is a recoverable page request and requires a response */
> 	#define VIRTIO_IOMMU_FAULT_F_PAGE_REQ	(1 << 5)
> 
> 	/* address field is valid */
> 	#define VIRTIO_IOMMU_FAULT_F_ADDRESS	(1 << 8)
> 	/* pasid field is valid */
> 	#define VIRTIO_IOMMU_FAULT_F_PASID	(1 << 9)
> 	/* group_id field is valid */
> 	#define VIRTIO_IOMMU_FAULT_F_GROUP_ID	(1 << 10)
> 	/* private data field is valid */
> 	#define VIRTIO_IOMMU_FAULT_F_PRIV_DATA	(1 << 11)

Thanks Jean for summarizing it here. I will update the patch.

Best regards
Vivek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
