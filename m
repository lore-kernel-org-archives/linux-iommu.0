Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF917C433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 13:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 901DE408E8;
	Wed,  9 Feb 2022 13:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0XwuTESWJE1X; Wed,  9 Feb 2022 13:29:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 782FF408EA;
	Wed,  9 Feb 2022 13:29:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4191BC001A;
	Wed,  9 Feb 2022 13:29:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7738C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8723E827AA
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UnfjXKHiYYQL for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 13:29:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60FDC82779
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaaYSqJRdcECw9spGo9CIJ51TzKZ7Us8HjvJQH8tC3iXHdsw8JKGWzNGsphw4WNxIJs2jqWHQmx4efNITSukl5yxPZmJj5PwzU7r7E7DP2LlnsfT71NPaghs1D7CW5wHJmtOz0xa9k0qRSQZlOu8aYwWnLCTPj/7z/j3Pw3FD/2GFWopIyxCP7beHXi4lvCYWFvND28eCMQbJx1GihI1QCKKcIe72DoVgN//XlXcB6vuHr+26P1l7wAqJr+zukb3LKNrIOf+DdJSH6yXRCe+RUrPfp4aG5VRW1i+kiE4W4t0GrkuGyR2GQj5g6pJW90LFCxf5x4G+uBIODAXsvkfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRFhTcXUmuDazs+vRpCRMwOwcbhCuVUNpRabkVYd/kA=;
 b=hQcCZ7ePmGkVPyR2neoujd94DzgybV35YTxC/4wPisQ5nxHXINHmwJX/vOYy6WbNTTsyAW/DA4HN85bQb3vKVP88DIk9PlfFykwCZwZLka4EbRnZt7H4077+TQlIoGkBnFoDsUbCZVuFYzb3ZWBvpLDSfTyvmriNZMMtN3HHeRhVdBnQpQ3pXdAmrLtRiAkMb0fOFKCN6ZchxaYuWXorDRORKLo8Agct/uXE7pTTRv3Pz/VUIGS5NF0gfED7BMWXHIGI2mxYiP51WkwZbKyVJwCvoVhkeu0aSSx1OTm+fvxm7qY06Zg0ZzgF85S4LAeRk2oc/1lkZpzHR+KqePfAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRFhTcXUmuDazs+vRpCRMwOwcbhCuVUNpRabkVYd/kA=;
 b=EU+CX3CS1kk7lJb/oEkSTLbXGoChy7dD0rFxk+Sam3RHksgiz95tPAT0z9Asy0beHR86IrJt5MqMJV6b7xkTPq7QxPwC/rpIFQg60p06Z2p5XQRj2IQwxgPC1Z5KtWkEtPYLNqX1Cfl45+iQh8sjlTWSANX8sFKWY08BIBndEPphAQyhYX5bzGReuk49acNNHytOW+MuPDbwgtkZxHr0+nANV4Q94fAC8cEzJelqFRvnwctOfi/5dnTrVTEy5zdWTMPySsBOsLUckM867KoMthM0CLB6OIrnPo03Z8Nc6Q4ko8F95fZduWNJutSG+WdS51RlfZeKyRMLrGPc7cR0Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB4723.namprd12.prod.outlook.com (2603:10b6:208:8a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 13:29:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:29:11 +0000
Date: Wed, 9 Feb 2022 09:29:10 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 01/10] iommu/vt-d: Remove guest pasid related callbacks
Message-ID: <20220209132910.GS4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-2-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33e52a41-1ed3-4755-952f-08d9ebd02859
X-MS-TrafficTypeDiagnostic: BL0PR12MB4723:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB47236B877CB07551C48AE2D3C22E9@BL0PR12MB4723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KH1MfgisFZBBb+z+ZsFqDIw27dYavrt1PgH6uZas8ieWycn/vcv9jKY/WN5q8QzfRFB5HxBWk+UfUuu1otjioSkwwQKErdZ8IXzvbUVM06kuuOtsRVCIQFIhA0XKy7Ib35NFahQ1Tp7z30yPXMGADzEJwU0wlExwReU8Mb+INJuIE9IiOsdG66ead2WH0N8MUb+SsvU6ROXVZxiqqQCCUZVnQU8IvyZxASssdyUpKj4ZAjI9PtjsSgOnwmzcSoh/0/mBdTsbuhFP8aMeoPJJeuqXFwKvu6eBBZPyEI08iQopKChLnEtg5Cn5MN6DOxYVVlaekE39l8flFSVYnrzKTcoLcel3Swr/oH7i6QkpZrMvGzH+YGbLenkIaC9U/q0RTBOdgOqip167ZLVyvY/wegSgUU8iqyOZXI4L6iFgatKdJMMRrxcw4LQyDj4NtRjwI/u9wKsKPGVB/WIWZweItGDiQ59S6/3+iQ1rJvMW/+xTfvw/cflv1c06SoM1Hf5rxidxZ6WnIrE02viqsqaOVBn2gyCO9GmbAkzktXpiqcSmwnVMrIhTyUEz9hoAWkLNhR2ssXhjW+kmNsEN5tfPwZz5wZ/xF67/axkP89k5WrRt+2E7q8YbCwOxGwkiDcSKWDNdRKwnjFoyhj2msKuQ4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(6916009)(54906003)(86362001)(316002)(6486002)(33656002)(83380400001)(66946007)(38100700002)(4744005)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(66556008)(66476007)(2906002)(4326008)(8936002)(8676002)(36756003)(5660300002)(7416002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yyn4E5GgEP/Gv7cDZpgLZJlfovHcno4GvxXoGG04WuN1bLrIlw/TgNzoN1Zl?=
 =?us-ascii?Q?AqC/Tc6MFOpt4K/kY6y1q9o5vpt9l7LxCma43lOydID+F5ZcmPzmpTBkZkyn?=
 =?us-ascii?Q?oFAzxTdsIHizIfOJ1iSl4djwaOshKSqot3tdYUBl+1zmxJcpTZC6CKrAmdbm?=
 =?us-ascii?Q?dGs/o9rdlUF9SiEmFwP9YseRaop6NNEtLhizKNE1FpVOYY5WbI5lJgMnUDJh?=
 =?us-ascii?Q?zDCfdaBlBG+/loaOoN7JuE32POoGOodQbPlqCSXhkUM0zxCzu4xBoS0vo2Ld?=
 =?us-ascii?Q?pmHgmsWQbwZRCOoOzvc897SK84jYVzpfqOXop7cAYN/FZtmUfDl99NGqZTVE?=
 =?us-ascii?Q?aJdmVdlIUFTQQ0UUcJz2r1Jf8TMmL3hIaagwfnc5NLJHGIn4zG8oMmNCYfHh?=
 =?us-ascii?Q?qS/CpzKANrBqCwFjWTz5DF2hV6v4dXlWfpL4jVDsGY8/eCBphLqQ5aOPcBHR?=
 =?us-ascii?Q?zIW4r3jFXBr/JvD1QippxO0FN63GdA4sNhYSaBHik/YngGWZQrOG/Pa6jvco?=
 =?us-ascii?Q?GuEim5KOs4Co7J7zDa93qldv0fhhKl8HGMSDfQf4hDkFGUukhtzgqa0RjIh7?=
 =?us-ascii?Q?sDwk5Cdvo3EqrfHZ4c5IwcC9apiVdZew7sPDtNd2riCvlx5hLY0Qsfk2uqcl?=
 =?us-ascii?Q?OmTMi2MNYCXCv6adocxt6GFPtbsv8x64osQWSzGwCNmcF49A6IS78kBKanTM?=
 =?us-ascii?Q?/BWy/KxdwXDjna9YuvZdocLyOhQoWlgqeyllHL+L7Fu2l/VIt8a4R0w/Ozik?=
 =?us-ascii?Q?A+fprteIjeFzeVT51sFlAQ9vbAQaK5aqY3p48cPb6Eg4XtnaO1ZOxvwnuURZ?=
 =?us-ascii?Q?oCreF9z8sJezSsRuSkU9xvJuAOT6TJ/c0QN1WusuMF20u2UW1a2kUAESMLjr?=
 =?us-ascii?Q?+4B9vKhUjzLODYgtMeMCvxBNZE3CrLc2Fm6Bxes905sIcuWc9eufgA6rlYpG?=
 =?us-ascii?Q?dIL77TpNpP2SyRfwlIEKUOh4+Vtv0NjPrSP6Ryhf5vxNMBYXjmBSxOu8S+Eh?=
 =?us-ascii?Q?2I5ehWFCVX3pND3/q3qcOFe9v1NGyTD0D8T0UFkGjTPl4PHr2L5wwy3vZ98f?=
 =?us-ascii?Q?N6DcWGonynRYKKu4UAb5MTxTAUgUwKkJrPv8TUQT7JrYOHM88+Rg3y0zoBie?=
 =?us-ascii?Q?x9B2yN7T6//5uIs03SDWSyxr/kUsewEFaJD1J7usPab2RXkWhBFiAw7z96Zn?=
 =?us-ascii?Q?s55A3gBXuzWsN515wvuYMtT3fxYEjoa3Epj8lVJ1bBXRm0tntTOMfWh0bdT9?=
 =?us-ascii?Q?PX74cwRya9RVRUl9Oe+oP3NONCy3rCINr8ly/zZ/Y+OuaXfdLkA8YyeqSivY?=
 =?us-ascii?Q?th8yeeqyG54mWLKaVwN14Mf8Fjy3ow5LIQyyKlV32ehKkWPaCHKQforLFrI+?=
 =?us-ascii?Q?CRTtCqVoZTa5zjn+O587UMEUtRbUo0iK8hE1AvKx3TZvsfskaf67kqWnFeLE?=
 =?us-ascii?Q?kciSe0hy5a9uVmy6+792HBMlMh0qeOpdsiyvNSSpDLdnpf1W91e/CPTqldSX?=
 =?us-ascii?Q?fRVCpDuBuPpy8xiqziRKn1pSb6rY3H98cMPY0SfuByT51vARhyKzcUJ7B5JX?=
 =?us-ascii?Q?3Mf1SaOqVA/8+k/fWLo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e52a41-1ed3-4755-952f-08d9ebd02859
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:29:11.3570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bef0FXAlz5Kq4trXknUeqMNN/vqQnEVOiczhVt+xQNHcOGzvUHeCU/m8Vxr6ztwH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4723
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

On Tue, Feb 08, 2022 at 09:25:50AM +0800, Lu Baolu wrote:
> The guest pasid related callbacks are not called in the tree. Remove them
> to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/intel-iommu.h |  10 --
>  include/linux/intel-svm.h   |  12 ---
>  drivers/iommu/intel/pasid.h |   4 -
>  drivers/iommu/intel/iommu.c | 208 -----------------------------------
>  drivers/iommu/intel/pasid.c | 161 ---------------------------
>  drivers/iommu/intel/svm.c   | 209 ------------------------------------
>  6 files changed, 604 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
