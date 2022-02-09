Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DDDC433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 13:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B042860FCE;
	Wed,  9 Feb 2022 13:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psemHIhPT7gu; Wed,  9 Feb 2022 13:30:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD1A760F0B;
	Wed,  9 Feb 2022 13:30:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 892B3C001A;
	Wed,  9 Feb 2022 13:30:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D8AEC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3395441511
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H6NF3mSziHmt for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 13:29:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BDC3410A5
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN3Th46U5Z4WlJWVj/cYKqtM3mrIstXHsgVT5RxRdXOJZoYyt5N4uVUhrCwpJ/vaLJ3E2Cbpmm/ygDhgjDlWJH5sJmSHh2Fl1mx/Ml/C6Gl4QT0HQmcQ41J7ouq194V7N7Aw2KvDA/VW+jGbsq47zfRHLJoEpgEawlZqwmMhuqL3qocXC5R36dNBFUlSBwhSeilU9jGcU4Nvnx+D79w/ACZ62dYzAvlrr5zh21PLRCwm6FcjW770OULnnIgQz68z5Eb7+fCcxiVt7LTYifF1FSvwJP8CQUGqR9hbUK3hG0ePnHZR3Yp/3kO2SgutMAWI7bx5G8lUrEdwnL/6V/Zq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMP87sBpnalH6/lDUijGxwqrDCv+ntLjhgoEJjXC0Xw=;
 b=Vbdw5dl/2RHjSOWpNWp9y8fP5GxfN/IHW1F9e7pmsyfr+F6J5F9f+MQSbuwuUSyJbfpOSG4dUHnIRroDStMjB2IQqbn7DPOJYPCZdFHTh9eIFMTzSKeyoN21m4w/pO2gpqVGQ0JmOQM9BytdPbxXO1V8hf6kD2HUvKKzeMtDtizStAkn1Li/wNHUB8PlYme2JHBhEjBba1++EINC71fVyu30KnYmczYeqAIOOAXwYefXEe9EkzTnBkPpwuZYcO+myrDE/ipywUMLnmqugZ1+k/QwQfqXWekumQhY/+B/s+kcRvffSyWAo2ZW9CDzF4UqTjIr6fGx437fuz6WL4YuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMP87sBpnalH6/lDUijGxwqrDCv+ntLjhgoEJjXC0Xw=;
 b=o51p0hlGHby6LCXoKWAa1lJrPBUhGiQn4jsVqv5wNICnhL8M3B485UuTSs7azL5N5tshMkwbCrmNKUuTT2Uunjiw4qtwvjToBghg0psO8JoRLhTJdueWYr840Iq8fcbjsdTp3s/Te5yWFZcCjjJZ58MmKC7mtrGkePB3i+V3VAjAQ65ntNDhtJNorY4HachqtWJsysP51cvxr7RwHCjN1K4wAhxjcCQjdafsrLqpLconLG9OBqNlxrNBKP7rt7udiQ54n843NQCabeD5QJUF7C+6Is37NzHH3tzSfl+3pDTHjK0tixyZVLLL6jfDaJ5ZfpjwwPx6gMzL+7RhmIc9/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB2533.namprd12.prod.outlook.com (2603:10b6:903:d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 13:29:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:29:56 +0000
Date: Wed, 9 Feb 2022 09:29:54 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Remove guest pasid related interfaces
 and definitions
Message-ID: <20220209132954.GT4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-3-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0363.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::8) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ac0bda5-0fa3-4aee-9c4e-08d9ebd042f7
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2533:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB253313946C5B935A8ECC41FFC22E9@CY4PR1201MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UExVSkojuMRV6V3N2FRFTP7lU4bp7pK5uki2EMPpbbh2PxSI+7RqnmVd8pqriQ/NWrLsfSOyw6YYm7Ad+ruTpmVG48f1o0wLXQY9cQBLMOCzkut6+BNTeG4vS3SbBJtrG1o/ZEHNz4W82PtnL14wnpFEUx8hCZa7gRthcFM5vhu3NdTRRxpyEKdTU0ogD4p/c/1LljS/UXQLV89OfQxWTc+RRw4kjH9UIK2e0hIPe9XlO8vqxUvnWxbOaiMPbTmQLOUhULwOm+8g4nFPERHTxsGycyhcJAzgfCCuqAJmW4yJxzRCFUOXI38gwJjaC8T7f21BWbWmvEd+pVUoEsQI7PQhxGmkFQzh2de07dzk35ukI4EYCqAuI5glhSKoEFCDXsUuX0ifK5NIviGNUcvjWtzleNxBN8G/+zHNf0oFU4uAbZ+wk1DW9mpoBENa7CzxaS8xrd2+Z1gMs0ixrwKQcy9O9cwdL2oalijX5gOfnCccpaIsOiiKeq8+pabhWoAEia2UVpW6yp5CKLOV8FK0lPTZOUSy2LQRpKcD/zHZpGbEm/dIxQxDjoXlQbz8zrj4Lk7IjUt6uJyWabfKC0WwAOI5qSXaZ9XqouSy/Er+rx24VhQ++rjVQuLQaETa+aKDolOdmSLaQg+gUgFs2gtyyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(6486002)(66946007)(66476007)(36756003)(83380400001)(7416002)(508600001)(8936002)(4326008)(8676002)(33656002)(38100700002)(86362001)(316002)(4744005)(2616005)(6506007)(26005)(186003)(1076003)(6916009)(54906003)(6512007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0acblMOXBXrMW6AbP02h+Ch356prQuBoJUlYZpeqgXAx2VqrvbZJ58TvcJun?=
 =?us-ascii?Q?Lsbf1YfWUj+7WBlVt2z63f1m/o3xF5BtiAGNAAp4mOHD+EvC6i50nRBq5O4y?=
 =?us-ascii?Q?l35n5GhCVWr6PStc52IYh1lKafn9lNUoUEnvvuzYptxqG4I0ccrL1RrYM1yW?=
 =?us-ascii?Q?fDU263T2/vo3LnuYTLwjKuLkXF4WUGH2TCFuQSMYv9JtQm9IGNXBP8nu6yXX?=
 =?us-ascii?Q?mXgjitStGGOcNqfeadd2OXa1uC9LLhaok6lNHCDf5b0SEJbSzaG783XMnFa5?=
 =?us-ascii?Q?1hQH9myD7yOqU+4S9eNF/+V3sNBvVk5ndyfdIIiFuCN6qLL1UXSg//7130o0?=
 =?us-ascii?Q?HFiSpD3t5qeifMfHc86Ej0hejWRqb3NzqwxeBPxJRMLjoViinQRtdBP+PNfu?=
 =?us-ascii?Q?i8N2wDY6RIHFvqNhQhW/LiOJRBzWohKP+nM9gyGJcFfNj7CjFeQHIrgIFvOw?=
 =?us-ascii?Q?NyMkMWeokSQ4W4SzyT84jGYb5fv5XMOCDNSNnKcOa8kRCzdyqmL07CIJm1rO?=
 =?us-ascii?Q?h9WH9pWfvCzj4aVqAP7m6hzctFBUtLjTdpO+DHSUmvcWyurKJ+OsDxLamieT?=
 =?us-ascii?Q?tD2NqDQcnQSAv/zU4rRhRNrWyAe1YRXkcCZNfamrjaChuYKi6YSdJh9Iljbm?=
 =?us-ascii?Q?ax+zJCgdlJ35oFWbp3NQt+NAXcGSM/1LNMOil4B37rk0OPcfq16mrG2B0W8m?=
 =?us-ascii?Q?SSJsJfSe7XOEgnlrSDLl1oP1hw0fToI7mnCaK4Xw9hhf91LpsOhk7Xp96yWU?=
 =?us-ascii?Q?RPCybvYm2HG15KxKx5qgU4XLMyZYiwqviiePhGs+FIh9Et/EUl3Mv+AmIL4L?=
 =?us-ascii?Q?OzqpstdbLTdU/C76BuIe3Nfhla5t16AKOxyna/sL+KWNZbAbsJ1/uOCB7L8K?=
 =?us-ascii?Q?dh0vtHGDhKBYOUZLWkeglok1XGMNqzAF+uJIEPUAej38lwzM8lL5m1mjbQ6m?=
 =?us-ascii?Q?6LMAgwmUTOgKxlSHBu+LAnQEYJS1hAba3dlg//e1ppS3J2FXl2ngXO8+aXAt?=
 =?us-ascii?Q?xKQcEcwz9Ktd12w+2SBjNWelt/SjdlSyVmAL3pBL54667byzOOIVlGDCgVz7?=
 =?us-ascii?Q?8kCZBDdTfazAmP/7dd/8DwNG8BsvJNYNpnp7Nd2daO2+TAoPiS5UbOJpoq5Z?=
 =?us-ascii?Q?sCiNwUOeXHH197+LmtY4PmnWydZTY/evZThyDqR5CBLrWSkoxPm2oy37gsbn?=
 =?us-ascii?Q?Xpk/D8mp7KOkm8KjlAJA+Slw/GP4EtqWBWEhVRYKAg6bPigN90Tr215E55iO?=
 =?us-ascii?Q?/nUztZraF7sVsOEKpuC6fHt1oG8TtVJUCgROkBcrAi3p+aevnlNUJuruqoJ1?=
 =?us-ascii?Q?sUMqT6Qjs30/g9CJyKlPevBo5r7otpXgADelFnXo7sMWuLoPShqwZv5kXVAK?=
 =?us-ascii?Q?apjpsbgyquChAMjYMqR663HcnSubDbMlfxl1pM5toAleSNXlP8Yiy+9PBaHR?=
 =?us-ascii?Q?T6x2PZ9MRj4oNe+dzv5JWxGcH+TvXlD9tsXU83wdaicCHImdTCDwTwR9JT6+?=
 =?us-ascii?Q?g6XSeYiAaB5sNFlfkhNDtR0qa28AxWT+Htwdcbi8HKEJRAv+OntuGrpCmh6T?=
 =?us-ascii?Q?6iXSWVxIVqFsfnhvPDA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac0bda5-0fa3-4aee-9c4e-08d9ebd042f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:29:56.0146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJdwJVnEAz9JP7B/mFrJGqPFzlZujLJuBCoT7qkOoQK5mGxErC1ZRc2FYMgFt77O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2533
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Feb 08, 2022 at 09:25:51AM +0800, Lu Baolu wrote:
> The guest pasid related uapi interfaces and definitions are not referenced
> anywhere in the tree. We've also reached a consensus to replace them with
> a new iommufd design. Remove them to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/iommu.h      |  44 --------
>  include/uapi/linux/iommu.h | 181 --------------------------------
>  drivers/iommu/iommu.c      | 210 -------------------------------------
>  3 files changed, 435 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 59178fc229ca..65d8b0234f69 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -158,185 +158,4 @@ struct iommu_page_response {
>  	__u32	code;
>  };

What is the plan for the rest of the dead code in this file?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
