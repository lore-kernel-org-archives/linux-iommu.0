Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6519EC433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 13:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0628D40AD3;
	Tue, 10 May 2022 13:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLKlJaVLO7Xy; Tue, 10 May 2022 13:46:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DA64940AD0;
	Tue, 10 May 2022 13:46:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C071DC0039;
	Tue, 10 May 2022 13:46:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB779C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 13:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C91F560FAF
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 13:46:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B0ZQkpNfBVzA for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 13:46:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C273E60A8C
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 13:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+dO6s9kGlfa+M6BEOtwqUy4vV2tAMZHNn4t3Dgz6R66/L0AxIhZQgS8gtZPeAB62lAwNBPbrEXX3J3R6dPEMaH6ZM7l/ZApY7dsVDiAsliYL4Zj3UMLXC8kGBAaColqBMhzijkW704Wyslol/0AlsLAk2qF6Obw8Iih61jiAjYYksaxQdXRYxCqux3lthqDG5iNojSaFjLmoLS5JaqIbDl1/lKP/DGviIYcbF1GY3szNnfUB4vG+ZpowjI35ZqdKM7teZBAHZtO9RIpgzTcHtgcb0/BXNPWw2DhVGAdZ7vqWh+t/Ie0l0hxmKPcK+5JW38pKqr3jMYz6wTsc7hdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LsbqkdHoc9tXEBuffQPakAtvMZLvm05SzaVMsp/bx4=;
 b=eHdiH+IhHN3ziuFC5X37qGYgJ0HP4qhI82J+MqfNC5b00mLthi8lYxuCHDASyTS5fxExFHx/0Ouy26J5kqOX3dSY3ryS5w560to0Xf3+8fB/VoPDPYyXfM+amA/5mvZq018VJKuF8zwAP0O8+Evpmalyg5F280yCQt7jTNNPc++5Jn2qPoiP0mAcIvl5kAYsHBw1+C+ZFKyfMO03JPoqTcozcdhlK4Lp+JslAYpvX7PCtXdYAKxCCmyKajRjRCAOIesFsgCZYIQa793syr+Clzjai4HlX/HQ85zOQA6R26ULXFZcHtg0tbo0P+YvmO9I4eiYuC64mrePhZ7dC9E77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LsbqkdHoc9tXEBuffQPakAtvMZLvm05SzaVMsp/bx4=;
 b=jBioxRupdV68V5YxitcJa7D53tmovkPqaS2VLZAJChPfEUZRFDxMw9d5Xb6RZxrvRaG6jecpowo+0Urm4rDALW6fDzR4mIkxHRDgOJzFcb13lDCtoFPbs/lMhiFrBFJI3gsVz7HIemFZuF4YvXOYgWjPU8eJ8gzfgocGXUDHt4gL6u0lA5UjX/rcRqq5Gxv+scsDOXXuxoN4b9CiytQDK+rei7GO+ZaW3Z5I4Xh5+Yo8ZhQl2kOtgfSNPhGEzEiNawkbT0N+7mJdlrxLXIlrOaVJod+9/Jm3ggDSrATogXa1yPigBraqQjcWUE0r2UAkj1XBqFkdiNKvyBo8F9ys8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 13:46:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:46:53 +0000
Date: Tue, 10 May 2022 10:46:50 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Message-ID: <20220510134650.GB49344@nvidia.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f5d1a20c-df6e-36b9-c336-dc0d06af67f3@oracle.com>
 <20220429123841.GV8364@nvidia.com>
 <BN9PR11MB5276DFBF612789265199200C8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505140736.GQ49344@nvidia.com>
 <BN9PR11MB5276EACB65E108ECD4E206A38CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220506114608.GZ49344@nvidia.com>
 <BN9PR11MB5276AE3C44453F889B100D448CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276AE3C44453F889B100D448CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7886d3a-9478-4bca-03bf-08da328b8aa9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5379DDE03847E166F1E9F0FFC2C99@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pikp+Ta/Q4kfLligW996aF0aeKvxgeHLvGHsoWAO+TBgG4zZpc6zxJq2OteIdZ1W/5wzp2A5b0xFaM/vm9JZCmBuJjXWHU8yal0QPRkvRPqsN5+axalJJ05gVPAbPa/gUA0dvgB9GRVxVgeYMztEuEH3CVj0N3RN59Ga4P7mu2AonZ1QogHFeDRWqewNHGJwTAxHQAOnW46EeFLvFEjAuf9WjL7M9x4VhKZhoyrUOUvhPMFjlcUjX+WuM2bWn1MxIOPZ/FB6JvnzpKCHGkFro+/nmwW5W+DEK4rCznv/WoIlI2pUA7/ljRXu71Fp3PWCbJEu+jY24zeQZ3sZnmxv6i9j9V18Hn8mmpjxBeBymDNciMTJGIkJoTgjMlQdLU5vV2TQuYfbBkON+m4lo1Kz25dk18vJan9Y1cN+x/YbCTfJUvAt8ixMa6wD3QpB56ewX6GOjl3Lwk4NPtQQG7cAIQCrP8xBdCHQ6zDouDdiEYqQ8tEYOVeKPZUtgWSLtrAr8HMd8oQwKaNkt+/UMAInbWrO12diinj+mKfkZ2DHZT+pWlYo4iH6CpIxUILSleskp55zAKrfK/psc1B+/YJivoVf4BUXy4Pl3SWSfBQgACNCtG6UNEgL0wDoBVGcFiKxTwLAoZ4m6s3oUvC+uvLVGa8aIYv8VZULhixSYM5+H8nelMkzqkyMlf77fINEPcmlzoXmvo2ZnxpkIw7tJx9BfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(2906002)(508600001)(38100700002)(33656002)(5660300002)(36756003)(186003)(4744005)(7416002)(83380400001)(8676002)(8936002)(2616005)(66556008)(4326008)(66946007)(66476007)(54906003)(316002)(1076003)(6916009)(86362001)(26005)(6506007)(6512007)(14143004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D9D1vueo43kY68l7m0EjbPlUnh8hJQlfxEWKsNQ88lJgFxTkmNbzj4Gq2BpY?=
 =?us-ascii?Q?WLa2coIZ64ZVewWR4869OrExWuzu/xHUZhL4Hywe9ynUv8RLzpG1l3VhaPP+?=
 =?us-ascii?Q?4ezW03b6uMJrrPVMBYJb+1yshR4tWZHKTI+pNtQtU4reVVBL4PO00ZLJdJ35?=
 =?us-ascii?Q?pcG7yBHsFOoYHJWHVF1LNUhM/dKeFFECTGrm6gIdRBTByO4JmAzJk7rouhxN?=
 =?us-ascii?Q?o0QycB2KWRpzgkhqw54ZHd7VCODIqvY67imO3mcSdkJr8zOlsb2ehzSWDH4l?=
 =?us-ascii?Q?B0wuve6bafLXiKeXKJCtnx19DtYf3x/TkbDJ4ugrE4MORa9gp3GoZOvOun5J?=
 =?us-ascii?Q?dtUliajv83QPOfoxbkArXFinze2ydT/eHeXZVukyRi6+yTw/ahhn6gNV3BGb?=
 =?us-ascii?Q?AXPn7xtCUSzwVxfo18FdGEXbqzOIcU6Q90uG9u6MmpzB2jykfQmlHoO+N8MD?=
 =?us-ascii?Q?eYvUjklW0zORuuLZNY7TAPUOR4B+oo1H0RcSgjobt+c783+HyQOBt8KFQGyL?=
 =?us-ascii?Q?BYDkX5vZE70++QrVr37c+a2czpKCeNY1jvQ+EWhpRQG7vJj0Z5NtXACOyhwb?=
 =?us-ascii?Q?3lFdVzpIXDpB1xJet17ld0fIRbnfnVDHl1X8IrxGDqv5TnS9GCz6xnEiYjud?=
 =?us-ascii?Q?m1fVo29qbhYc4X30TXwYnfV4Gakj+Qk+ZcvH3o89asqdHF7xonhguzIEsx5l?=
 =?us-ascii?Q?3fy90mNteAgWqu8yIKhiQjm40We4eSMJNZeuAU1KyFIyZSNuWQjN43wezqG3?=
 =?us-ascii?Q?GJ+bzhQwdMtXi9rK9uE5RpOhfELKV3H0HJrtZepg+fVTimjPP75R/PmJtfI3?=
 =?us-ascii?Q?yZjL7bucPI7dms3o/WDUtyXjXovIDitvOvZ/WLZtmBSbBCHuujK1MkU9b9be?=
 =?us-ascii?Q?nq4K/mpaw1MK9AFQfDnlWqNIWYvzv46QIG8rxtKqsSmP7rBoNdf9AXKrJnHC?=
 =?us-ascii?Q?mffwW9pm8dZhTbtwV8cFujIwTQvBlk6tgFbNwH+dtUyJ1G3RNAKsD9QOCXb5?=
 =?us-ascii?Q?Fei4cTiR0QZTJREwdSUpX9d74xOIrs/Ba+1Elwxzhe2mfgGtqJwmIeCTPmUp?=
 =?us-ascii?Q?xTD9RxcocoYK+SEchqviCD8G0NB82LtYepCGqeiH3NLeZZXnEqgUkIBAxi0V?=
 =?us-ascii?Q?ki9Zgszt4GWh6d0p9JnUJjjRfLP4EsMEru6KFKD8hlWVtI7GGvyCtEpR+b5M?=
 =?us-ascii?Q?bio/v6p2xGi1m3fC31ODznSEspAb8k2gJGZf85xMC+gysTC6JjI7GxP/ITu7?=
 =?us-ascii?Q?7Md26GbAFXQxoccqSZDyVAHpblTYX37QNU2Cg8QT7NJREGxIDwipKTimRdKO?=
 =?us-ascii?Q?iZJBPsRvQlK+sUKFfXGrSew0+0UYlAlfPfVcetntLJecIEMRMEpeNsJX4G2x?=
 =?us-ascii?Q?3DpWY9J8aWAwFGgXVfOVHmeRygGwJre7lq+ciQXS9SErg60t87bMV9iNFN2q?=
 =?us-ascii?Q?R4VUa3cj8AvNCby+NbmppCptqVR6Bfn1sBLFDbcda/fTLVGj1vOf14IeiO6S?=
 =?us-ascii?Q?XZE1wYj3ukjvUvBYUkVnq9/TITtkztA0QXFmNxpAHxeVSE1xQH8SyKp9CY/k?=
 =?us-ascii?Q?wwZ5EGb05UjbsugLDi/HwVx1pW3HGSu8cz0uIqEf/iqzeAArHTwjBGkGrePe?=
 =?us-ascii?Q?y6+d2psxlDD8JXKIN8B4vH1BeIpE/xl6hkE3T/AuqMD/Y/gt8amesk3rEuqh?=
 =?us-ascii?Q?re3LIjTWt5Br5nrbp3jmdPrpgpJmihi9xlAbHE8Z4BiNsUR+2ARf+OLiHsk7?=
 =?us-ascii?Q?Yd68ZqdvMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7886d3a-9478-4bca-03bf-08da328b8aa9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:46:53.6253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmZrtLRXVejjEUfm7T8L/dD34ZABW4xDm6ZCI5/vN8JZsaT27UO2KUXE+2p8NHau
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, David Woodhouse <dwmw2@infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, May 10, 2022 at 01:38:26AM +0000, Tian, Kevin wrote:

> > However, tt costs nothing to have dirty tracking as long as all iommus
> > support it in the system - which seems to be the normal case today.
> > 
> > We should just always turn it on at this point.
> 
> Then still need a way to report " all iommus support it in the system"
> to userspace since many old systems don't support it at all. 

Userspace can query the iommu_domain directly, or 'try and fail' to
turn on tracking.

A device capability flag is useless without a control knob to request
a domain is created with tracking, and we don't have that, or a reason
to add that.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
