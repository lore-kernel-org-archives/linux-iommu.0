Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D844C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 12:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAE74605B7;
	Mon, 28 Mar 2022 12:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f_9KWWYvoGpQ; Mon, 28 Mar 2022 12:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AADB1605BA;
	Mon, 28 Mar 2022 12:22:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BAB2C002C;
	Mon, 28 Mar 2022 12:22:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C62BDC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 12:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F2ED415B5
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 12:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjgMUMS-bDuT for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 12:22:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 498DB408AC
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 12:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo3pQuAjw5G9FXmBQSVOTL+rXHlR2d0hOjeEp8JZ4WkYNPEtHMZIQPwQ3F4w12nugOpUMjoHVfDFCr/TclQ20inrjCjMBpBLcY9Fl8prvZlVDTTeIzDLknkj2ErCdFSOiT9YG9OQDPUkC/lImDPDH3kSHZ2sfyGgNA5iItUZxWc3S+NCyX0ZkyuOtEe+YtzxkacXFUrvsFJVlHrgQ7iMnmDox6KaPP2yR33Hd3VG6IYv+tDhVsshKn4AfiAPLsWq/D/tdfkI/l5utVPLXw/LpoGqYgHnUM7kt22np4wpZ256sDK4rfo9Epk6z7ljagRwJQ9wSej55gbEX9g4UaKFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leRXqSISEjf+QsN6uXjqGo+pNy63RFr1/INsmU/04c4=;
 b=RBskU51kJb2iLuf7SgzLkKG2lNSGD/jZjgglBspKEeqd3jvS3pK5So8smiVzfVpvn8wKL6IkQBiBMNJsrLkFEkfDbemQsBqM8DIo6PSTre1KqFfZKDbzawU6LeUwrHTJfRjBC0yjnnvfvCoSis69Iq7kBBnxOjPjz1KhlDAhe5jKwLTZ7lj9CwMARKU8w1kI2aLII+8iJzR5F6B7J8K4AyxMIK9igRkHybA0npDY+gzRNe21edj9PnHDcLQoIanZVAb8La+MD/Ic6wzBLRK3nklrWBfgQGAMVJLEWYX/NsaYOI5zUsQnDcwgcyA9TOtZ6iEeqGmCPdPxAiIx0zLmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leRXqSISEjf+QsN6uXjqGo+pNy63RFr1/INsmU/04c4=;
 b=HE6xKx8PaLWUg0myNj0MZlBcmgD9mMtmkDJBSmLGaw9RIjUzsjDD3HK9VsxfkCyCIi7YjonSMbHpumeD7lULW1ujGZPpIEVVjdM6ykWVa2VE+yhKdAVkPErdlqQU5kAFn9uMxWjIRMfYlX8Mr3T9bJ3Pvcki19KFuGup19KwWGsyySrc+5yzJoftIln6wDvtztmu1P/Z0SH0FMPMX27oI+BK6U5YGaF8heuHmkZ2rjF7pwmxdkYvICFkq0OPv0HgsG/t5CFCNdiRroQpWOCp+p4VzPQMgrz0QBFWXQinXagpqogJr9hcmGAccExmH49TWkYXxMKN4nPFeEXQjJX0xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR1201MB0012.namprd12.prod.outlook.com (2603:10b6:3:e7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 12:22:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 12:22:41 +0000
Date: Mon, 28 Mar 2022 09:22:39 -0300
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
Message-ID: <20220328122239.GL1342626@nvidia.com>
References: <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
 <BN9PR11MB5276BED72D82280C0A4C6F0C8C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
 <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEvTmCFqAsc4z=2OXOdr7X--0BSDpH06kCiAP5MHBjaZtg@mail.gmail.com>
 <BN9PR11MB5276ECF1F1C7D0A80DA086D18C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEtpWemw6tj=suxNjvSHuixyzhMJBYmqdbhQkinuWNADCQ@mail.gmail.com>
 <20220324114605.GX11336@nvidia.com>
 <CACGkMEtTVMuc-JebEbTrb3vRUVaNJ28FV_VyFRdRquVQN9VeQA@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CACGkMEtTVMuc-JebEbTrb3vRUVaNJ28FV_VyFRdRquVQN9VeQA@mail.gmail.com>
X-ClientProxiedBy: BL1P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c18c30c6-ba1a-433c-c2de-08da10b5a759
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0012:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0012466D7A0DF0D61CEA30B6C21D9@DM5PR1201MB0012.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StwqwO0Ns9Xo/rfrjF7fAe5c1zVYhyiS2Ysn5Y9YbvHsr+1OAkVSpw3txwgMwAqVhyBTA39dzIbUa/daf8RDJcmYgbvC8sP8pGzncIyd0ZgxeX0RQvr5yUc2VfdalDsRXQ7jo5mOxr12rQP0H+oNz14XDlUCE24muGHHKL/g+S59evHd2bfunuWTPGhpAPAyXZPKJ+j7XeerMrXNeYmdUQASftN9sQIwCBLQyaqDANiECY/gb0iHt7oChfurWWZgwVRcsUSM7ZEPoPDZ1goT9JZSm/z712AVaM7LV1jJqxnCfcn/KS2jLwU05sycxMVpDE5vvimK4SiUotJtTQ5tzgLljKsilxhccPgLdUBwMdE8MHOFqDmvLVEvcMxbzDCVFHkWXC1owGwLSlCYv7Me5lWSreTCOvyRtvx6DKMyyqgtbc5SBEbfMgP/UnxmlSA/K2O79wiPYBc2KHUOZ+dPZaMNDvNO4onx2mATCNHOIsheHiViIcI5jKGJuHRL+3KxcrUB2hs1yrb3d7hUEDJQxRKJzfRJWuz9H80/oNEhuBD8maaq8XZYDyuyIWX9iqxuHQ1DN9P7Eug0gDoJ30KgbdEONXhHC2IACoC5DTzBJQu9KjWDZ5BrR7AzRROVkapR3QqjddWDKbb+3pBrduqdQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(36756003)(7416002)(6486002)(6916009)(316002)(54906003)(2616005)(66556008)(66476007)(8676002)(4744005)(66946007)(4326008)(508600001)(86362001)(8936002)(38100700002)(2906002)(6506007)(6512007)(1076003)(33656002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9Yef1VZbu0Lv4NsKquELRfI4MzieG/0YnriZ3wq8Aa5wC60WZE/NSWN/Fk1?=
 =?us-ascii?Q?4BrkPrO8jLtS3WLquVRvV3kq+15oDbvkWKUwmlGvVzhd41sU3VB4B+m7tPwh?=
 =?us-ascii?Q?OEEaUIc21qaTT0NNgj8sueC88HDq2zVBLIZWgP7WIA7Sr24dE9o2OpZdj6Hp?=
 =?us-ascii?Q?Usiddm9p9BD9aOCSc98s2btNcvr9Gw/ry4zCe6YrYdrQ3AQbywnZhzvgsNu/?=
 =?us-ascii?Q?W0v/5jPGV5V6MSViZj/7ot68lz1kkymCdOptpVSi5gCr/N+s6n6t8YlcwtL6?=
 =?us-ascii?Q?NqKHG7UaKQWZyeBZyQfBIsjPyUyencFjMlspr62r8vFKgFk3sU6aQLN0qUlE?=
 =?us-ascii?Q?M4yAetAEPmFIhOGrwdZTuQvztBh1ZdJ5ukQ/xGrb5YIgFO6RME131JnFS9Zy?=
 =?us-ascii?Q?R0ua/ID7u5905OuxzEajw5H23848qowk0/UQ54K7NydvVGjwQkIyJa7yu+/v?=
 =?us-ascii?Q?vHNSPUlOdd4KWajTWA18gAxB2w/uNCOk4VgKV4+5E+kgouAwiq+LJ4hzri47?=
 =?us-ascii?Q?2KVZgnwmLeUXm5bD0IPM5JfnoRNb/wQjIibt8TutQdVvZzUI7IkoBQpNdCi0?=
 =?us-ascii?Q?WdqHZp1q3CeQoOEG1emDAkoH/S3nOJMF+Aa58Qk8U6KARdCVg6Hp2TjyU616?=
 =?us-ascii?Q?4YlfM2EflebLH3yistGG6H6CWezzpVQKFWAqfKAt3Y31b6l6QPSwVaRi0O/a?=
 =?us-ascii?Q?HunqhV07xcIB6RVQNqyTpU1YD1vkSV1ivaFGfKSqcE8P1SQHCaA7GX5zKD3E?=
 =?us-ascii?Q?5WIlXwGUKpKebF1C7rN//+0081vG51gkRzxjRZ3CrxwitLBFSU5jU2jMPxcn?=
 =?us-ascii?Q?6vm8UsGUVlhqEan0S7nJvvqVea/lF+zX2lUER3fVoqefD6yFbBjI4EuBzIvr?=
 =?us-ascii?Q?oUOAypnIkhD2wtjOgPz+hoqhkQkQUCH62p6HpDd1nKDsxuvfpCxFx9MPoC4N?=
 =?us-ascii?Q?MfRr8u9F4jwsCsac2zJxgWaJEUgPEoFip15gtHS+ghAaKtLsf8nhgYX+NyS0?=
 =?us-ascii?Q?0Bo9DOP9RnG2CtzDpyNtO9UoA9xW2nHM88jeKaSRGjsu00e/r9NBqHmJ8BBG?=
 =?us-ascii?Q?HheUo30RzLOA1vONUwqDy92PLfNgrUmUKazYEOj8p2YQyOzxyYMPHynUb2Jl?=
 =?us-ascii?Q?8575TUfz/OBpCO53wROvFuVI1tIzRq6gUiJo09dCXiP93XrVMI8+Gun2FagW?=
 =?us-ascii?Q?WidP4B1+q1BTAhiv+DUm3MT5c37o81TYSW9VWVPrDMp65ehAQG/7Lm19UsyG?=
 =?us-ascii?Q?jbUBG0zCpGJBTwgRNXFEUsgzhvC9T8QYm88ilvtxXUU9/gBCMu+j6eEl2yF6?=
 =?us-ascii?Q?z3N9ruMIR6GcDxK3zHvY+ZW4+0UoCtOLUKN7mzzNe4KTeSC0TLYUfW5dSS2X?=
 =?us-ascii?Q?K8d6h+M+XdjhhwyfxNLcO9iHf5vj8l4J0TJGjZVO1S3hq460zOc+JqBTgOKK?=
 =?us-ascii?Q?OPkBBNve5aEGTYst+gXSppQdn2lftQxwHaeRf0esITFN7RGM1ehFHD+c9ER3?=
 =?us-ascii?Q?J1oy3OBp3arIfz5klAZo6mpC2Pvz+mnewGFaYsQ7RN5n8FLVqygbfaiScLWp?=
 =?us-ascii?Q?o8NDEPrFBRqathSQDFYSyAUoYemEnQvUFMbVwSkoR8gKwpKlXh+P+VBozDhL?=
 =?us-ascii?Q?mTMwJgTjl9g0J9Ifmka/1r7clZygCI1fUfy4ADV6qQIepdlsVyw5SPf+kYU1?=
 =?us-ascii?Q?J10efGTP6Vqv84S2/+2lJFaNRDOcJlwCO0WdwA9llJ8l6pGJXST4CJY7kvrm?=
 =?us-ascii?Q?PksVikuuFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18c30c6-ba1a-433c-c2de-08da10b5a759
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 12:22:41.2117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBCWE12KV/5WZKOdR5QZgP1EGQdU+XZTMNGHhLzWp2X7UuBIcdyiGoMD75zVPIMG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0012
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, David Gibson <david@gibson.dropbear.id.au>,
 Sean Mooney <smooney@redhat.com>
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

On Mon, Mar 28, 2022 at 09:53:27AM +0800, Jason Wang wrote:
> To me, it looks more easier to not answer this question by letting
> userspace know about the change,

That is not backwards compatbile, so I don't think it helps unless we
say if you open /dev/vfio/vfio you get old behavior and if you open
/dev/iommu you get new...

Nor does it answer if I can fix RDMA or not :\

So we really do need to know what exactly is the situation here.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
