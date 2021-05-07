Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6785FC433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 11:56:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB0461431
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 11:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB0461431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83F2740637;
	Fri,  7 May 2021 11:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDs3nhsBFDvq; Fri,  7 May 2021 11:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DDED40F96;
	Fri,  7 May 2021 11:56:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 174B3C000E;
	Fri,  7 May 2021 11:56:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25A93C0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 11:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0630E4038D
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 11:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5KlLZ74CA-xm for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 11:56:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A16A40165
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 11:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRJ7/itJvtDUFf66BOfsidWpxrZKlkJCjnMKJxIQb8Avqrv2w0GzXUvHCL3TuJB5Uzll9PU/to121WLEuXk1iuIhNqY1RvUfxMcx/c/b54OdyW3TnPye35Z/keQQrygy2rvS57Ngm4yWyzeq7XwZW7ty1vbIdl/OJBMDFYA8hTHaJ8jn6DHq4aNfuz8T80uMhbiq/EL3Y6zGXMgWzgzcv2LsRKfWtPiJOAGjXErMu5u5eewH5askvlTCrtuycZxlVc1ILFcBP8thlHezKkRIiM/7E7g1xbMRo/UbdlevPSLOd5zCy8SMA6z/Rv+tv9Q8wp2mxKRZ/ma/TbpjKgsY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x91ShF55DsdK1AQkgu8r0q9DqTW3y3LHvdTS6vEtdHk=;
 b=HsRKi6Jo5FQgWiFR71Z0hChS3SmJxlKYX11kl4JyfgTLck7Ehypo9sOlHkHReTk9nLBRepXoT6kCKM+9O9kKEY26o9ENddjlxhfXqW21m2pYLeBIKpydnMSjIQhHtXAUxaCEX058BPaVWeaMVcg6hk/Lkd+IXKBoGN9yCjPy/Ji9B+7+gUB18AYLnlgbDbMRiJpKw57wcJ7AYc1eEh+rPn1r4liTTofl0VZhcl3jAXEA0xTE+zyyFu9vooAFE432HxPhFbRp/nPebQrSmdrnOMNM+gGqGtWosCSBdby3GXew+tJZJl+ow1lTG3EICZZwELnWydX3QHR487uIZqgEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x91ShF55DsdK1AQkgu8r0q9DqTW3y3LHvdTS6vEtdHk=;
 b=gZxIii//zTVu02wO53I0Iyk12vZGYGqf8Yk97sXqdbzMG4AstQvk0w5eOPMBsNhJzN7l+kviggOuOceMpRLlKn+DjWHj8HxbeOwcFH9KUPCwaw9fJo64LggyEgJDVWXe1oB9ECoCLaACeyzLhPwXAhQDKS0oYUJvDHFGGDhB00obnYUUxND8cfnTlSpPauegbwIIjJWnviYfIPpCsekKJVj0Mi8fCBou6HRQJZFBivOciSKTClpVlkeRY8YnxISZjktG0V29hH4alLJKRy3dhX5mEKx0Nm3ddHof4rY7kt+Ut77Cb1l7HMXwpJTLBvjN4Zegmn5u8GLf/1M7xB9b6A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 11:56:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.030; Fri, 7 May 2021
 11:56:44 +0000
Date: Fri, 7 May 2021 08:56:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507115643.GU1370958@nvidia.com>
References: <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428090625.5a05dae8@redhat.com>
 <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:208:236::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR05CA0055.namprd05.prod.outlook.com (2603:10b6:208:236::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend
 Transport; Fri, 7 May 2021 11:56:44 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lez63-002kCu-3Q; Fri, 07 May 2021 08:56:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2b3b70f-96a9-4a5a-2c1d-08d9114f2f2f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02031615228582A48E85373EC2579@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxQoQnBlixazE4T2P+YtkjTqzFM6VfRaGUdAD1FtDX/VwnYNxfwqQTr+/kjVHWeblQhavuBD4CGIHrW0z6IzfoDoXb9aXtqpsgGtaNyxK/G7uP1TdnhD4h90zya8ng9yYxmLTRVPMCTk653Qzx/XwRNgrSc3JE3zA5/rurbHuZlFfn7M3p1741Vv8ldY1rk9Ne4zOEa4GAoRK1GeTcSwa1NxetvBS/oZSERVJOCz7ulpwZTw/0S3/CFrGzrOj2tdM+W65AsIgzK+ZCNvsyB89yE1Bv6o2LL5vUAwQkZkkKlGh1XoCFyFY9ZeULiYqw/Hw1+abn4/mY3TNinPtdO/TssXGaU51sP4bmIi0lBSaSUHC2c4vYkUGEiPnoobSa0SCLFKOgD2ZFxsKWH0kq4OeTAyX8/bTyUzww3ivZFbtoRS5QfLtRowXYTfAh3GYdashyMsANh5NjEVyvJzTKWRTbkJlU6HT17TWp+nCPlF5k3j1r0kfR9rguhs9JegVCGgaRXX47P254jgQLhrixxK+hNO2C1SXdevm/GhWjN2Kmzao9R24b1k+/Z9sWY+LaDNtqn0K1I/IfXnntzpAFuJEtSo33SWN25/fGQ/pfBMNQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(66476007)(8936002)(7416002)(8676002)(36756003)(316002)(9786002)(38100700002)(9746002)(33656002)(26005)(186003)(54906003)(426003)(66946007)(83380400001)(2616005)(5660300002)(66556008)(4744005)(2906002)(478600001)(4326008)(86362001)(1076003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+DitjvQSCUIYmT/gOw/LJSMU+QHAg+5IJBasGLRWWHfOWnTLxjA/JBnbK++G?=
 =?us-ascii?Q?xDJBoRfGAu0Uh9HJqc1vJ4XDQZhIouod/4Gltz29l+IlKyqISiQC5s/ZC09I?=
 =?us-ascii?Q?nie9qTHVHeBlCxeoVxJffpEv3gd0uQ5PgyGLsB/vEu9pqY7maxeNnU6xb3pD?=
 =?us-ascii?Q?kPHmcEtWyOnd3g81NcJCg0E8KMdB2DUetMra1Nlb3LS6xhJ0wBU9qRvf4SjF?=
 =?us-ascii?Q?fVdmZWnGwbwLWhosgeuPSfJhugnZrAvNJNMU5v5tMyCJ5/kBm+d821vZFK5f?=
 =?us-ascii?Q?bZBCgvcsnTn/GihdF2apCo6igSrCPJjBtE5LfFJLamx0vMbF4I3Q98h9deJT?=
 =?us-ascii?Q?o7X6CXSBEAyT8uWt90suAsD9IKSP8+ucrqrNshLEcJgcgCvNVSdn53QcdZ2W?=
 =?us-ascii?Q?7eZmnvJYUmPpdWgzwK6l9Qz7u5062e1gjkg7T3QwnqQc/pYOcylXba1Ra6R+?=
 =?us-ascii?Q?cVz3jAoCO8kf+6FCnhTDWtI9wFDnRa1+gEHH9X68DN1MhISpXFW3WUpmqc9f?=
 =?us-ascii?Q?JsYrK5egSRavAsPmxwBWGfXKEabp3yYWyYmUbYqt3aDImPuQIT+UgdmyLqxV?=
 =?us-ascii?Q?+veKsdxQu+xJWDe9XCYgZpp2pYu2PLO5mzCscIqV30gyAvlHfRvFQFAxMTHu?=
 =?us-ascii?Q?4rC65B8HaV7pCK9F9Vwc8kObi20OK1HeOO3tgYPAZo8j/rWcU/NwQJkjx5gl?=
 =?us-ascii?Q?7Hh4og7ZV7iaww7Kne7iEBiEIgH6BxhumxO94WrfAHNbboyyC/aWpIE5aWGr?=
 =?us-ascii?Q?1tFUe1NIM1aYghOyqRLVjeSaMwUBcCCaHYfYNqCojB/YCrVZZAqNOlm3J9W4?=
 =?us-ascii?Q?jhNOuQBNOl6BI/0dgiEY6+tqnbmODOLxx6N+qRmtlDS0INh9uEemiJ3GI+N0?=
 =?us-ascii?Q?VOD3vIvhYDMUVClTxHJlasmfM4gmfnXez2Pag3Sx21DQymKLxmAMJVwBrWPS?=
 =?us-ascii?Q?suI7DvWddFLT91RtFIUzcdGJrlUBRvU1nF6xyQCzaovFjukrN1xcxzP9KWfc?=
 =?us-ascii?Q?RqN73aqSacMUHRAntde5dL7ypljkTrfZnG/nohIgygi+jDbNz/ulhC0FpF5E?=
 =?us-ascii?Q?Qo1cXDztc5bm6c1mxwbMuTX6QzgMwpydiqZrXJ+b+ZsHZgcznTwpsurelSJ1?=
 =?us-ascii?Q?mULBK3obNbCgRlI5iX7tVD6mO+X3AMFZ9rJH3CI3fQpgT18SlUQJ+UWb/5ah?=
 =?us-ascii?Q?GvUVxeGbspp+VgBMMoENS+8ogC+glWaKy4UpIBeOycwVoCn0ZwpMLO6FyfSl?=
 =?us-ascii?Q?McsK+1+1H20PgKVvmzkYuUbcVLkLRAPKCn2kJd++JwH3hNjtx7ZsRQOKtfv9?=
 =?us-ascii?Q?kxUwXq4qUfQiXsokXOX6kwht?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b3b70f-96a9-4a5a-2c1d-08d9114f2f2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 11:56:44.5132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEitO0pbGoSc+vPviUXjF4JsOBP3cdi0cc/Jrj06Xt+zPq0E7lnQ81tSs0Ako9PG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 07, 2021 at 07:36:49AM +0000, Tian, Kevin wrote:

> for /dev/ioasid there is still an open whether an process is allowed to
> open /dev/ioasid once or multiple times. If there is only one ioasid_fd
> per process, the accounting can be made accurately. otherwise the
> same problem still exists as each ioasid_fd is akin to the container, then
> we need find a better solution.

You can't really do tricks like 'FD once per process' in linux.

The locked page accounting problem is much bigger than vfio and I
don't really know of any solution..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
