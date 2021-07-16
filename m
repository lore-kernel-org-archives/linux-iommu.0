Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053CAC636CA
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 18:30:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920B4613F1
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 18:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920B4613F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59113423FF;
	Fri, 16 Jul 2021 18:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dw6A49AXG7t0; Fri, 16 Jul 2021 18:30:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E895240513;
	Fri, 16 Jul 2021 18:30:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC048C001A;
	Fri, 16 Jul 2021 18:30:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1743C000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 18:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9333E40513
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 18:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGfPTraJO5QO for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 18:30:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5389542540
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 18:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCusrRZ0WrOsGdu8pDzUC+Fl6pH387dOq8KFZOu9RSjTvuv+9J8/CFcLFIJgwCR/NLNVuNPEQNKHEbfINbb3WUamheTtayu1qJW8G+so10mKfFqBH3rM55U7N9NGz2inh5CYEJ0syy4VS6HTMk8s4RVoJzDZ9yJhq+tZ1PyYfMITBhrPyItOiI3Su+4tZETDD5Lc8xhvhsh9CCLEPMsFBhbh6Dh6z/SNpfxz5WX58280nhfEe00DT84ZP9H8yqZnIzesdKsPsM85O8YNe7c4zYKyOSgT/M7CNVO8O3HEwpt0fGecuNXiSxfnVFIOJ8LCnjEdcoYfBFOlFiGoHok6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiyzeOwo0DGZ+B8oqz/baeTBEkFIR6Vv1cX6l0F9hmQ=;
 b=GFmN606pnUUQh3hHHQOpZ0mfq7HYgiJcP9bKFVvjS6r9DEY+IRlFilO8PbKyRjfL7y5CgyrsxGPrEJMvhozKp3Sni8q0vsGrkjQVqzzwsZrba2JghPPDeEEh4EnSuV4XxyDwS+Lew1jGiWyxB2JrnGqvDtTFqMHF71++uUM/b/LHBixKMeftwQ40KZJ0wF7SI/UCtGtkSCWETVaRk72uqdKC7dDandDZ7dcSFu9/3mHmtdKzAg7EwRupYuNWN4g6pYU2zcrp1q4um91HuC7n7+cNmGIFnWAqF0Foi0RaKlJWNNiUPzwPW7z01utidM6+R41E8xx/sKCT6bFUK3L7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiyzeOwo0DGZ+B8oqz/baeTBEkFIR6Vv1cX6l0F9hmQ=;
 b=PpJHg6t9CSKWmvqaDZgn3tNvrtXZC4+4QX9xfuoGU2MR/qmDjD3uF96CnOIBfu9lunCkb7S5oY5I00QOktUn8lhELI0si2+JG4Bheo6xHKg0FRW4vAy5Q9yaYxU/pPSOdHEdlO2vKAi+WHhjE099aiAPI+gttZanAvlQEAv5jbu+iqevrQYURGxmtVMHd/5Bi8CGOyUvqHdDu2pxpKdK42ra+yA0XW/isZPcNK2kFB7YOBMUoBjiFfp4kxnKoYjV9YEw3KeGMSoRLjTkj0bwXk4YEUyr96AaInHZGQYCU50glT8UCuen2A4BrNeeJiTe/jwvQfUvOj6jWbVgmetitg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 18:30:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 18:30:15 +0000
Date: Fri, 16 Jul 2021 15:30:14 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210716183014.GN543781@nvidia.com>
References: <20210715124813.GC543781@nvidia.com>
 <20210715135757.GC590891@otc-nc-03>
 <20210715152325.GF543781@nvidia.com>
 <20210715162141.GA593686@otc-nc-03>
 <20210715171826.GG543781@nvidia.com>
 <20210715174836.GB593686@otc-nc-03>
 <20210715175336.GH543781@nvidia.com>
 <20210715180545.GD593686@otc-nc-03>
 <20210715181327.GI543781@nvidia.com>
 <BN9PR11MB543337BAEA86708470AC1E0C8C119@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB543337BAEA86708470AC1E0C8C119@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:208:32e::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by
 BLAPR03CA0122.namprd03.prod.outlook.com (2603:10b6:208:32e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 18:30:14 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1m4SbG-003P2Y-4b; Fri, 16 Jul 2021 15:30:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca31cc23-673a-4cc9-bda8-08d94887c130
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5205351173405A0D1F83289FC2119@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qnPCn1FzdV0DtZLJ0tCkfylCwtlOirKcScq9iEhGB7EoMPQeoK12qNZJyA+c4eeODP3sdwh3sLha0XHvNEmAjRHnmRLFDE5kO3P2pUhWXkqfKdxD6ZB9n0ZqL6OquavHDGS8piEyqEXR+R36S9MHBOR44XARNwq0JxI7C8XEHi1h3gRnxUt9XvEs94zoR+spJd7kdY6eA0ulYQB9LCCDb+VpFR/AlA9mT1BSUqs9Q+DD2Y3AQer2asp5QoiTU9Mr5XrCg/gWb6GxR/QoioHCZohjzvtpYvNXci5s/bJQBuVEZ52ZxeuQx3YbNthDCM80XOBxvSS58MnGYmYq/u2wJDQlpyNI8KOitaNrVsmcVRAP5q6lw3mkDir6QPpGagvt7LwDaocXhFx3BdKu0RYk9Zv1YCd+KG7q+/tGHKmdaSMnBrXoM4uR5Fuy0weD6jECqooOSILr4st2HiyE2MlQJRXEX1ZNL5Hf5BefyTpKWLVLnfqjuWXnlJi2ptXVqasbD1Zi0j7NjsorZ3WOykMFAxs+pcLM8OPG2v/SQ+cGC0pjgrQ/ls5Pmh+ZizDGP3emDI5sA6lP/jJq0kULUdV1E83U3osgZieJZpm9Py9EnQtHwJBS7JEHCuNKphoEa0pEyJ8CFiXS/CVuwPJqCydP6HY2WBmPJyyAXQT+cHO34lMsZZrPpHOIZw2chjtvQoar4qQ1WoCfiLE/DLIHtB5lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(2616005)(33656002)(186003)(4744005)(26005)(86362001)(83380400001)(9786002)(7416002)(316002)(54906003)(38100700002)(9746002)(36756003)(4326008)(478600001)(6916009)(8676002)(426003)(66946007)(66556008)(5660300002)(66476007)(2906002)(1076003)(8936002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q06N46xGm84mq8NcoxKCZz3nL4RMzEb0PqPyghE6r7YAZYD7u7//jR/2U/Y8?=
 =?us-ascii?Q?Bom7tnDLJyNJlld/9F7onbXHQWigjQdQahopfSfAn43M0TbTo7pYIZo1Ec81?=
 =?us-ascii?Q?vOlivydCP7BxT9Nd+HONNJJWgsNt77wyyctISK9oTRSBpPi9m2KvlE5Z9cqq?=
 =?us-ascii?Q?L5gqSBVJFQ0SagK/gRIumMgOyXSeaPm3tnloTJk2ZtXfgP4pnGpsm/utOwPU?=
 =?us-ascii?Q?tCivBK2UBzPYJo4ebTRtjgiVoYrO1+wxUFuowCBRzlRA3M80/mGx1G3q8u91?=
 =?us-ascii?Q?9kp/Jx5d9MynKpXR0nvGPiIOHhfIpNcKHZJ/oLk+imWvkf8POcf1ReJpecz/?=
 =?us-ascii?Q?vsFhVJKajkbGiq+IIDBh6fUj5QWw5bAmWWF33zMLEQqHunlUgKrCsYqOv0DJ?=
 =?us-ascii?Q?cfY4A1h02kMe1vR6vvGl8o2jyIGuEIQ/X4jKVR8VKwKE71j3QWr+pUY+MdzB?=
 =?us-ascii?Q?LkeNta5PAKgYQ7VpR/yVr+OCuMIpQP2AjnsYo8Ta0p3g4MgYOzmRcb16YRVw?=
 =?us-ascii?Q?HKe6Lr6lJZxAs9nLazXaHY0RCKANXNI4iftpaHtMz3ChBtE4hLFg74Hrdr0b?=
 =?us-ascii?Q?NWWlTU/+vlBZJu7zz1/a9nSelOMxu5gKNincQeUhdJlRbpGTfjH3KKshf8L6?=
 =?us-ascii?Q?qcNiYcbX2Tciur00D3Cn0sKcHw3JPaFVCJvek7W8uIMnj3RHQJf4pg6luF6z?=
 =?us-ascii?Q?6j3xTbvd0HGAVtu7Yw0hEHIzTB4qK0f0tKqKF7cDDDU6rMJSOkhkMKwAfUB5?=
 =?us-ascii?Q?2S0bM36/EqrSGkP9TsWdLidGw+bZ4G6LiIU4w89QCDhp1ZrcZimsCUertAuc?=
 =?us-ascii?Q?s7y1aVNyfoxs3Vdr4eoLJbdSVGpAR5sQ+A/71EG4aYJGDK1+MnDB/6opTIHu?=
 =?us-ascii?Q?api8uxW3bB29Clhtt/3ULUINfgvAc7Zc2OJ9p6V2zCYprP8nQd+lq91lzuY4?=
 =?us-ascii?Q?0nak3MynfhoqkPAeXlB8fzIZKX1wbpL85SO19z/EoxKEgz1Ihcw2cMkP6NU6?=
 =?us-ascii?Q?8UIVmBWk5webG9lIbRoqhzID9nNo81qrp0ylfXKBhC8XHNEZ5h1+tG4GTOND?=
 =?us-ascii?Q?rCD/tbb+MYDngra9Epoh+gV3nhu4t7SA7lqsl/3rm6DA7Vf1OhFLJ6HNiM6i?=
 =?us-ascii?Q?lop9yikssNr20KuNRDcaC7UojR/2U245F1rOnKzuRb1s/8/PisQpmSDi/XM0?=
 =?us-ascii?Q?jPMhnCL0wuxScDANiVd3s7csodtKBegGgQ9Q7YOHUx5Y78cOKyU3ZC6ihi9g?=
 =?us-ascii?Q?gBtc0X7auF8w81qcgjOU0+1PQd3M6vN2P0+gBzLgerlR/7WOyAkNq+DQ4WZ3?=
 =?us-ascii?Q?Jy2chyEAq9FN129JYNi4WYij?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca31cc23-673a-4cc9-bda8-08d94887c130
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 18:30:15.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WZx+n3ZeKi6uw3OMp93TaPJbo4CHqKHjTFGwYyPsADPWXa1IiNavdfnbyKpi2ar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Fri, Jul 16, 2021 at 01:20:15AM +0000, Tian, Kevin wrote:

> One thought is to have vfio device driver deal with it. In this proposal
> it is the vfio device driver to define the PASID virtualization policy and
> report it to userspace via VFIO_DEVICE_GET_INFO. The driver understands
> the restriction thus could just hide the vPASID capability when the user 
> calls GET_INFO on the 2nd mdev in above scenario. In this way the 
> user even doesn't need to know such restriction at all and both mdevs
> can be assigned to a single VM w/o any problem.

I think it makes more sense to expose some kind of "pasid group" to
qemu that identifies that each PASID must be unique across the
group. For vIOMMUs that are doing funky things with the RID This means
a single PASID group must not be exposed as two RIDs to the guest.

If the kernel blocks it then it can never be fixed by updating the
vIOMMU design.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
