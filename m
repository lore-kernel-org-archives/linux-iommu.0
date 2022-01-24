Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FDCC433FE
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 17:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E582660A79;
	Mon, 24 Jan 2022 17:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 82nLhxuKbXXw; Mon, 24 Jan 2022 17:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C8FC460812;
	Mon, 24 Jan 2022 17:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8309DC0031;
	Mon, 24 Jan 2022 17:18:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE24C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 17:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE81F40250
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 17:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nJpnBpdOJnmx for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 17:18:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44A2C4020E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 17:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dqbkg9Ey/PmuiFjD6/WUGQ5v4mq3VwVGWp1TCvVeKyuh92wCTg7IBb/kudmhxikJIYX71nc8/ej4axyWxjxloUpOhyvbgGoEfa7S3lAWM1s6dGsLCyvu5EE8VX4HCpr1Z865RN0MVbSUHE8uYwVHR4ATmLPCUg5TKLR39FdUylW6sPfCXuf5lVgcU9yjrIQ/29PDDIhZONxkcDQ/q14mAmY7RmCpweQ0CsHaJM4qkJhJGNP5C51cp92L/g4Fw1XXhKdf/PYRbzlixiEWvvmsP2w1WADSH2FKtzHpG6QyEc7djD/RnOOfnzDkqNdGVHnigxbQEyNjvHR5FYtLAZGanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYEBFzAm+76aFeLIl/mwxSlqinNryGozNFn7PHvX0D0=;
 b=YtLvwM8xMNAZgy4OXzT7Q+rNpSWnsnjtml/2I7I8t5ah+yQ/2wZ1Galbc1vOa9thLzv3IHBTJ43k6qEIZXeaSn9KS70/fSaY/D3mXE8iCDL0AQG4p5vejXRzOAsAoJNDo0NeWNRWwC7f2RX86RXyhxSgQNdDDC63TL62GxzgGwuNF3e3zakWzLF1+Q3h3zxVY8EURxUlNt6d+3wCut69FbXxo/eZ5aD+I9S+ZGCfBY+P/JURwngDojIcXwcdUWUHAEG53WV7V+O2i5kIhNUgnkPlXNqX3dQQtFINFB3n3MWL6ulq+qhRJIEaUdxMIdcHXkHs+T5RTclOrrmW0g0W7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYEBFzAm+76aFeLIl/mwxSlqinNryGozNFn7PHvX0D0=;
 b=IY6c3yetaYq76TELopEahv/dm6D67fxXwYIzpO5H+3WhuE3P4M9/P+Nr88i/oi7i0q932Gq5kZ5AZQ9zqS4pDIYAfpDSE1kxGYN1Z/YWuE45Jxem5yf+CvHVJMELLEo3iROjLtOJkncuXphEva4lBmUHK4J6xYOaHOV6wwp9u6t1fB4+WFZICeped6kdfveeI9yrTyrCZbkwQ5c6zBzgd0g9roUQyV5TSSkj69UoFntz1a+c2RfgMvp9AqvdKYQAWTeFi/8W/RKJEF0d+F2YdKg8wp6vC+/oCljKLOQQsS6RPvyPEBNXx+Vxwrx5Jzz9jyIzqLjbfF0NzrTb/nqPHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 17:18:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:18:00 +0000
Date: Mon, 24 Jan 2022 13:17:59 -0400
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <20220124171759.GD966497@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:91::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9fd6ade-63bf-4343-345c-08d9df5d78e5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5114:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51147CFC88869911DF57E435C25E9@BN9PR12MB5114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SGTk7ceCMglg8vutWBgN25pOTlo7aVHZt5kfd3HKEAl0seNGVlLwS34nt5njxsfel/6AEDKmV0kvhLML4lwJyD1CzdLjSlZhXJEQKDafiju7QJWSwiMQAtwp8rbUUwsisbnp0gZ9tIJ6f7afq0Bf9zVhFsgWuhN3UE/OFMyDZ6noVMiEtU39aFl8FnUSe+rtdqQ4u9/rvK3fcJy2svsPwjlRBn3iRpFtiDB5/tuI06j2gZm8BkJV2w25mEnk3OjJA3RJ8Em6UlNQRpGjWA2TtcSkNqkJKnGccNYY7YOwmWkWXlBctns8oxEMxT2jPLCKM6aJ7GoBSW08+eWPkS79nReYLNUlis3Lu7uney4l9S9d0OweYOTpbzqowqjDPtbZQTM5vEOWD3wSYcc73C2b8PoUHzQKGSRBUK8AjOZNY/k3El40ef5pf2x2K601OqXiBAvhLYK5hQcPPMsul2DndBi2/HWJdYyUOVv4MlM0iQGWNjthOeD95JpJi26XjT9Pnw5RttFMpZ7aCS8VsCHBE67J9HioycgQ1XvQVSNoTFI4tB7usBDzvPkBiqYMhII+6WwTtzsb8/zo8gTKoo+G4qiI3FCP6oTmSTETJhqavAm12kBblaO4WfZn1ZJk2vUNO6HeEUbOLrm0WGYJ1DzQaUFia/7KRi/ZS9jLLb8/avoWEWZIoBgGcHM707vbM48Akmt287iC+/MKJGMmGSlCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(6486002)(33656002)(83380400001)(2906002)(6506007)(5660300002)(6512007)(2616005)(66556008)(6916009)(66946007)(4326008)(7416002)(508600001)(8936002)(8676002)(86362001)(38100700002)(316002)(1076003)(186003)(54906003)(26005)(36756003)(4744005)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8E6U9U03D03tFvJDwT9kXSRXHfDMNDYSEgo3+R4rPjs+Wzd0/jkEJpbJxjf3?=
 =?us-ascii?Q?JoJuK+enTGyZUrtfDbSTaW5hGtF/xYezeDBEpwSA3IVRULFajNBQdQQ/oajh?=
 =?us-ascii?Q?yOnPIcEOkMYFhldLrpnZAa1tFYpDACeABDUf//6a5EWF4RuOW/3ivg46O7Nd?=
 =?us-ascii?Q?oVHHlSlUMt0hl4if9cVwOgstfLuowDkL8uvTuFS5DiyvDHeSadXaT7fNMYLo?=
 =?us-ascii?Q?qPRtiBbCruV5v/3EkB/0K3O/uJp+z9z9QW8eaAe31pLz6y5khAwD6EX3YiXu?=
 =?us-ascii?Q?7P1eVPIsqsk/WqBHOmHjdnp3OKxpUIElHVSasF9T2XnxhUB6oEI4m2mfliLR?=
 =?us-ascii?Q?2MnUbM2wNtxif5YJsjIoOfh3UAqj/7fzPHVFKQf3ydDuSeG8JuimTlLCptov?=
 =?us-ascii?Q?4EXmBQbYBQVVYu8uDnxLsXmbnbr7HnuJUXi9lg0Q4kX2xv+t/z81f0GPxVC1?=
 =?us-ascii?Q?tNpYr6SktuRRCa5y++rb/tGq7pGbIGmvKW6+uqnUsQTe+pOL4Wq10cdk5Mep?=
 =?us-ascii?Q?jdVM77/4AKb5hh852TkT1lLcJ1PV98s5uFD9uVVLRkiDJeAoLEsxuaxLhfFk?=
 =?us-ascii?Q?XU1hYTCEQl46Dhk2RYztPy2lZ7gh/WYIhAc+Z1KSMhLmhJ/pJk92DU4nKpqt?=
 =?us-ascii?Q?r3DYJgLvEA4oWRlRMbUV7cklBR02Vs3H0L2E4VJm9LEpDnqc8COgnSJfO/Du?=
 =?us-ascii?Q?Zoy1E0V1/Rq7QEUcx1wf4mTKehPfzgmrUfbAepY2kcmhEiadI+Yx0HXfxzug?=
 =?us-ascii?Q?nwIH6/JmVsdBoc2FAAxqTIoCKopDuerBb4Ap9hmqbDcc0YtDZ5iMVuPI6bNr?=
 =?us-ascii?Q?FU3Y5gmgRgzcVS2wH4s5JZrXboxJZTNIuoC8CihZHJ6uD17w8gxjAnMfgnz1?=
 =?us-ascii?Q?qqRqneQ/QJJqI4RpMFCWSNq+GRZ9E8KNwE49P8ytkB6z8kxR7dEFKezt+Zg5?=
 =?us-ascii?Q?lvDgEQe8V2TPp+Fh/mpiB42z6eYAeUtgty9YgI3Asg/gVjkGVRpvR3sX2+7x?=
 =?us-ascii?Q?+PiF+WkcePXXLBB9jhdocd2scc8Bx5YfXyQ0lxSnWuXBHGOEqoFoxKsWaP7b?=
 =?us-ascii?Q?MftSe6eyHhruxohFelQ5sDN2aR2RMSbbTbaxHAp9iv6178SGqhNiS40iSCBW?=
 =?us-ascii?Q?xuqWdW3TdPswjd8iGEt7IPBhOuOn/Rj5vC45fCGuhho+aqPrWRnf3OBAAU8X?=
 =?us-ascii?Q?GqT3tOwXk2yDwXmJ5QBJknrhKdYTFojcXAZp+I6JIoPbd/S2gnBo1Idb976z?=
 =?us-ascii?Q?NEHbeUIQCwaIrugj9uppuxzWp1EInQUhCZjHdpcF/AV1ySN47JvaiE3k1cH8?=
 =?us-ascii?Q?qm/oZDyEzyillMEpzzWiYpk+Sdl48l/tmYiRtYoa8CTVEZbgz3xWaoA+5s1H?=
 =?us-ascii?Q?+9L6z7PUozubFOzRE3lIZhrSYoA/941bMcr87cdZQDZLCB5EakcWdsw2229G?=
 =?us-ascii?Q?gU098shx6g69ER5nZc+dXdsao1eXZhciBR4uSItZ5zuzbRStU93aqeMZA2Xi?=
 =?us-ascii?Q?JDwuxEEeb3lLKzupH9O7uVax9QWllKbgqiUjsUNBdfvfhN0npEjoxxjqYVcO?=
 =?us-ascii?Q?xkLKtKAZeW/lwqx3pHA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fd6ade-63bf-4343-345c-08d9df5d78e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:18:00.7717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzwA3CA6Dd0rMR966bWievsR1EGzhXoW4gzPQUNViGFeILRajI6kKjy/UOpjC0Yf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
Cc: "Raj, Ashok" <ashok.raj@intel.com>, David Airlie <airlied@linux.ie>,
 Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Jan 24, 2022 at 09:58:18AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, January 24, 2022 3:11 PM
> > +/**
> > + * struct domain_ops - per-domain ops
> > + * @attach_dev: attach an iommu domain to a device
> > + * @detach_dev: detach an iommu domain from a device
> 
> What is the criteria about whether an op should be iommu_ops or domain_ops
> when it requires both domain and device pointers like above two (and future
> PASID-based attach)?
> 
> Other examples include:
> 	@apply_resv_region

For apply_resv_region the 'dev' argument is really selecting a device
that is already attached to the domain, so it should be in the domain
ops.

> 	@is_attach_deferred

Only two drivers implement this and neither use the domain
argument. Remove the domain argument and keep it in the iommu_ops

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
