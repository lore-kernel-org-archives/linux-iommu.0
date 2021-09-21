Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59491C433F5
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 16:19:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C64D60F70
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 16:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C64D60F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B512403FA;
	Tue, 21 Sep 2021 16:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BcPHWHNMeR8b; Tue, 21 Sep 2021 16:19:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2C8C9403EB;
	Tue, 21 Sep 2021 16:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13C3BC0011;
	Tue, 21 Sep 2021 16:19:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8A1BC000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D808B60C0B
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-HyO6qos9lR for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 16:19:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2044.outbound.protection.outlook.com [40.107.102.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA4606058D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 16:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVKWLF4zqoFOeqGV+njIhiqVFprr0GysWFBlFdVUeXvZBNkcbl+OxJ7g+Ex0SwL7bZaaSg2/yENlVFgmBSCGzRqLgL18FsrrnySfedqNAhxZ6RQHsIfJSO+SmUHDmPwn7olMKnvJKOoMBwbgPNfHaRr1Oap03Qv7Xdy+eN9i83JrMVD68S5y08kjCYF/YoUy1r038VLPuGy7Ia12fXmgdlcYv6xc4QwJ3MJTLOI4Eq2He7ss8O9chj/5e4/cOeF8AU+W1CMaqC4Az9af2OWVysZ3sfNE6npYGp1FSpz3sc2oGwe4waUEAPWTwj+6TvEwIbDZt9kLJn2oJNz9Jpi0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1UyvvG3HE1baY/RG0eoERi852EQ8zcQLNGoxT6aTZ0o=;
 b=HclmPbFVIsVILSSoFtnBOVf8vl1ULcMZnXZeblsujjPPYwgS8qPneB3po6RUttPEgP6vUekPwIOpZZvonoQifLibUvgqNTdu9ioOp6uhTrIlqGNSrT7FqnAxZ/NaObJ7wwj695LRxCoOZP672La9m9oQLV3zT1Fl0zhCkSB7ahpgtUjauZEYP+yWVZDsRaoLqcm0NSVGfEEdQNFpR+TXOqU/kQBDo8wcstTIYokhMxhFoDq2bQ314ifG7cDPbZUYFYklbomXEAGgPMF7HKJhN1l0QcIroItmd8LhEp3tCsmZu3gvKPkWdzOKtehjpFYFj4rDiBA9YHkYe/JYnUyKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UyvvG3HE1baY/RG0eoERi852EQ8zcQLNGoxT6aTZ0o=;
 b=lrQwqAT/ZyciNgdusjlLsxXs1cx7FjTYUZVQos9Az7g8ogwbFHc8vMyIVwVwQbtNh1Khczt6UCbpCssb/u0cR4j0VM9awCfVjEvhRrXSIfXkxgECBqjX8IABjr1DKTx4KaRc4wQqx+pze8XbREkRSJCp71YUM+16m35Z5Sr1JjWfQDBvUt9wlpV+/BdOqVjgKpQgYir1SmAJnej0LCIeLrhf/XOoz9Pr5eNqh5mYhJxJJ/oRoy4BtWErYF5qiMz8KpVlrUqM5WqtvEJLeCkWrN+PL+M54yUSulsP7t4bWapw3ltnNGJmosylThe1qnlCYQ7Tk+2c0yGyO7gaQ/q41A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 16:19:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 16:19:32 +0000
Date: Tue, 21 Sep 2021 13:19:30 -0300
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 04/20] iommu: Add iommu_device_get_info interface
Message-ID: <20210921161930.GP327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-5-yi.l.liu@intel.com>
Content-Disposition: inline
In-Reply-To: <20210919063848.1476776-5-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0065.namprd13.prod.outlook.com (2603:10b6:208:2b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5 via Frontend
 Transport; Tue, 21 Sep 2021 16:19:31 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mSiUU-003VgT-6J; Tue, 21 Sep 2021 13:19:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4172759a-ce21-490a-1646-08d97d1b979e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5079045933382F47237775D0C2A19@BL1PR12MB5079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jedjudD8rvIt+5fVLTQ1ilCH6b5vEL1wqOeJ2IMhiTSesHMaRmwEAcuSkc0jiUnb2+XodGFAKlhWOVOyWVDAOMNubW77vut4AAxoXPGDqGUcgyu2h6clKNE3naOFndDY4ANSCFpf8Nfdh6TeCpoNLlItd5IC8cvvMrUeEBZiyzAYGv9k1gRYIM45NbjlpmaWteZvC6/6kkJl651W/kvUw7xDxliZDlKX8zOdoWn2ciKuFblyZL5CD1jra/JX4+bhPCQ1idTsUgd+M3Tzsz2xw85kTW3bvUM646Rt1F6QQdtWvG1s4iOYRQqWGMfZdX1DqiYoUENp1FNwn+PiBBDkLLD4hJMEgjA3SgwpvETUCEO8XbFRu2qJ8NXxNjtoaeTVHqFM1/TBmRBqPh+KL2cwULfxPSHYOiZSlrsFqVZspkrp2yURxbO8EawUqIddjs2aU4Di0eh7I3uC+8Kf8yq3J5W1jtr8VMd2pzsOT24ElhprVNl0RNUzyDUYp9xsbOeJRqB5YdiaCRUesNTGXgUrSn57QCCz1qU19ikwzj0ATAVSNGGIpJnjH5XUwshBvAvDs8twRnPuR8BdLYyDAHrtO6qVuMSkrB0mAQ8fpRhyaPgfCXMR1+d4q30ulL7IoMX2zXOR7ssE3OxeVRqqqz9mqh2i8blaLgkXOiIaLXCPGdo0bIppvxnwemEjAqaJsaIj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(36756003)(2616005)(508600001)(86362001)(4326008)(1076003)(26005)(426003)(8676002)(2906002)(9786002)(66556008)(5660300002)(66476007)(7416002)(4744005)(9746002)(66946007)(33656002)(107886003)(8936002)(38100700002)(316002)(186003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9wKQzrp40rlATFuWDaDrGXshXv/qszkoaxvgZDoiO2LggEkazx4nuVD+4c7j?=
 =?us-ascii?Q?kFYvkr7VS5jOFoU1ZYtTIYiWPNC46vr+WgDmseRAgrOwFntSG7+ycYyWg3xJ?=
 =?us-ascii?Q?EzooT1rzifSkDjQcqkzuHUrtJXx9iDiwY1aZjVJ/X6KS6PxUZ9B+uZRmqR1x?=
 =?us-ascii?Q?dRIrNSXtTXtbQ2KPVWAHBSJlDhYqgJ6ckCZiwLFPI4QtDujnVwchG0sno8R/?=
 =?us-ascii?Q?a9wpQlIQmLbxz/ybQREAp4ac0skhpCKKdxi52G79UTlJcD8zfOmfKHcPBolK?=
 =?us-ascii?Q?xq50h9RefpKPkoxVM+yiPP5QaJ+bDzwNRswQRzEMFlXqUJqL/L2JEZEjWmSa?=
 =?us-ascii?Q?t22m8ipjkbxEoggy+48vv2/wbrHpD2lezIrNwkWOQEORzL2RWDLlK4SAxI05?=
 =?us-ascii?Q?+3l+1oS4QHWPJik6Zb3qtj60J03bmYwGYi6zdTTCzWQAng1Jqvn9R41l6h9L?=
 =?us-ascii?Q?2HCrd8OBucVjNtWdWznq2Y4JO3Ypzbqz/xdSza5kYTGhVg//Ca/dQj9Dykra?=
 =?us-ascii?Q?wFQQe4cxjbLRAt+llSHn/VpyRUr/RrvWMCdPq8u7hzbHg6H8ZCbqfSmA54aY?=
 =?us-ascii?Q?rywgapUPz7PBZDJ8/up07G4gXw3s6zGiEzJlpT7DfMTEEZZOsGM/mxllNgpz?=
 =?us-ascii?Q?eKdZpHi7fWBucIOR/UDhm9cU67BxTkHyDSzKwdRKTISDc7eZEOnvyfuj6nnV?=
 =?us-ascii?Q?3Afb27UWt6wUVCqdREYpDYn2tFBUXy9vj96c28iQ87jCLgqmqlBbDQAj4AsP?=
 =?us-ascii?Q?CwDab3tQJHZzVbhg/WEyBbYZdZKpUPeGb7DcneTAbyeYaNwgKzA5P1DiRKy1?=
 =?us-ascii?Q?mgrzfvhq2piH7Qew3sOQsdZZVscoG3QbZFBzgrvSeZ0Nz4Mt/UMkGBwFeZLI?=
 =?us-ascii?Q?gHEhwXbLlV+FWoLn3KGxKsLoEOjuLpL/M9Dfgfv6k1lUbFP6aOy6SYLt8Q0k?=
 =?us-ascii?Q?YIj917Cr+X0ajGlBxzWBzfldxEmhJW+0BMrdAybL7tjxeGxPcZrP+I4yvvJk?=
 =?us-ascii?Q?clDw0+gRAdjBqMTJuntlOD8icB3ZH9a/UzQH+tpAk+7XtOj0wSNYcU+fFH5F?=
 =?us-ascii?Q?UTBkhO9YjDFFFL1fNCrUhbGFypou8HfIJOlCHwyNAIhhjTOQ6Je+EAcU/uNJ?=
 =?us-ascii?Q?N9aDReuk3uuWG0kmp7ScLbcY/hPkKJp3OI8nwl2YYeJHdhXey5Zx8a0t8uyR?=
 =?us-ascii?Q?5tPkGr3GznsoNCyZdk21w9PIVZgMrN0eaOXUgjWn7hTsX7m8ltkdkNxr2bBE?=
 =?us-ascii?Q?NvLLhFKEU+BmHgouGtV3ktHV47xTGbjj1LDa9rvvZZ+G6DPBZXJReaAVEjlP?=
 =?us-ascii?Q?ElqU/ekRJ0beTEwqRdKUq+O7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4172759a-ce21-490a-1646-08d97d1b979e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 16:19:31.8810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liOa0nqBUwWM4Gwd7xtG1zchMC866WfDSzFj38nrEy9QdISwmopY/PjRjMAcEisd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, david@gibson.dropbear.id.au,
 dwmw2@infradead.org, jun.j.tian@intel.com, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org, pbonzini@redhat.com,
 robin.murphy@arm.com
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

On Sun, Sep 19, 2021 at 02:38:32PM +0800, Liu Yi L wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> This provides an interface for upper layers to get the per-device iommu
> attributes.
> 
>     int iommu_device_get_info(struct device *dev,
>                               enum iommu_devattr attr, void *data);

Can't we use properly typed ops and functions here instead of a void
*data?

get_snoop()
get_page_size()
get_addr_width()

?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
