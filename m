Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE52CC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:25:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B059613BD
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B059613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6533B402B1;
	Tue,  1 Jun 2021 17:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yrtz5IExfif0; Tue,  1 Jun 2021 17:25:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50D05400F4;
	Tue,  1 Jun 2021 17:25:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28C9CC000E;
	Tue,  1 Jun 2021 17:25:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88240C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75F10605D2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XzIFJBkJZQ5p for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 17:25:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AF8D605AE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4P0X0tLdgT/+mpSJK6niXwlerCletI7zk7sVvweZXnk1RgqXtVwAY+zG4p5yjy/1T6sZLm3yRz/KGpnVvUAnzCiLj7R5hRwZ+yH+vU66Q3Logn2ccjxVX84U2pZgy2DeA0QVU+ZbbdlA9yc7xuobMl1xbSwqyFHF8KYG6o6Y2YSYEc+7Zn/o3kvqslUwggYmYnsx6eEwAbyKHkb5HezxdXzYlK8ehhCkVbOguOJe42rjIisurwh+MsRjSwovsxvPDjyjxnqYZ25cIkfbW4dujaNIqx5VPeAROryLRGsdkGRiIA4UpIDIz2nq0wabsUkw2475V+pw8FNDkl25ywShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9Lgx7rdgZqul76FlIkn6rynKdbLSTMHJhIxTaIP5rU=;
 b=R6Tx+NYVmP0DpzWl0xdFvnopBrxQ9fh0hHXou7oNqMTJarIPbWMd9x9APdFTU+2Ldf7WrhXE7jC8PjOCDp+zPAlhM7553c3HwmVly/goaFR7HH7Fsd3cDWfSr2+9k1jmhf+7janj/CWSF5qD20eyG8fyui3nPlqL6VM3MWC9q2vI88QybnqrQ++CzTF3SGNp7DDqGVVSkk13sTGB6jSSGd+q1OO97vHi40269GR0t/kxwvMCfqQrRM0PNizkuslEZufwtkwGe4OlRG+zl1Jt540cV04viSCKb7aJ+/CY8yjxpkhOeZBZgLgswzPhFijI2252DAqxwiqtL/6yk51/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9Lgx7rdgZqul76FlIkn6rynKdbLSTMHJhIxTaIP5rU=;
 b=CghzaCf+Gx7BP/5FRQPfe47z9nxRlO4wbLjaPuUA4jkwYG00q0uTqQZ5oT2rLN6Jlz3ajZY6XHcPsdYiKTNk6aztJD1LPsgYRV/5HIuU9YzmagqyAfgQUd19coK+HQP0+/qMlLRNF5pepO/EwHAYJ3+a/Fc/BmfPyU3ysqt5NI3/gwujSv+cCIzz6w1KuF2eQ3Pwms8a/2pNWxKtGkCDb0Wk7sGxoDpGfLvIUjQ97t0goYPuqKWSMZH53V9LgRms2DtddsFE2oZRALh08kgj3FEaHVwr6/Y3xLlsroNOK/KZx846jx9bmpQa4AQlitKwEGZ05/xpOu3wUEhk9ZAjmA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 17:25:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:25:01 +0000
Date: Tue, 1 Jun 2021 14:24:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210601172459.GJ1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <20210531193157.5494e6c6@yiliu-dev>
 <20210531180911.GX1002214@nvidia.com>
 <6ca65628-1c0e-4ae3-6357-1493f993349e@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <6ca65628-1c0e-4ae3-6357-1493f993349e@linux.intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:208:134::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:208:134::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 17:25:01 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lo88R-00HXVB-T4; Tue, 01 Jun 2021 14:24:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01330da6-9441-4853-837b-08d925222fc3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125584A8009BD38D3A8E4F4C23E9@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjOxx6ubbEK3vXi8/S+Ac0TL0miNTKQ9axCf/TmGG11tMGCnLe7X+IKlvnfS0Hl2mCeAkQXJmp5hzvBem/fRozuf6jCjrTIXaXHEBneIJj3Vkmf4CoP2/yiGDBE3oTPL8eF8XrRXbc5Gh2THpwY5Wai6CCL6OWd+siGWh9wuelA6A3ty4/x3X1mCppnrSkwQYUv9vAJ0jcc1/zauttt1hLoImnY0ppXHO8ovDHQ/wlkGUoLJqRSnBzlGI0QLNXyI61Qr9befdJaKnkpAnniZI9TNb0V46vXisLTAHKD0zY0BdwVmlFyG6O08qm+/zp9jvy+phTLVsnNW1c2diCY3t1CtUd2oJmx8284QHDOksXrnB12J1CZImK+oihYtnhl6hhSZtYBblfICqDFfNDvBQCkcI6kmfjrJU8rU0fuTp3jOalt4dZtqODiaS+13MbWIdaj3JL0YMstHS8Fh4NVOl6tweuujsAoYiP8uhEsM11SdH3j0mhqm23QpH8rmDqHCPcP3eGSRCh8B8H1Iopa62lhc2ptb/abADhp02gMNX+ROpDtYyqqMIb8cmScv0jZsipe0CnFfhOHZ32uT2yB43ewkRqvkBvqHRZGAIlDbeXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(8936002)(66476007)(66946007)(86362001)(4744005)(8676002)(36756003)(7416002)(2616005)(5660300002)(9746002)(26005)(6916009)(83380400001)(1076003)(2906002)(426003)(53546011)(4326008)(54906003)(478600001)(66556008)(9786002)(33656002)(38100700002)(186003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XaexVpdrElJId4XqzjDiqpWaoshDx8HcxjB+TKSAUn0GrTSjfMdYSV53nVWB?=
 =?us-ascii?Q?gFUE+Zt74TxeWsqyT5JpThKt0UfAa+Hzvs1SD8e5Lt6UEhcHvSXnPvCN03kH?=
 =?us-ascii?Q?7UEclIDuUSBQZPJcbZGRHSJphFnBtqeJ9kmyxyRXCEAXf0ccb9BSV3prvvwa?=
 =?us-ascii?Q?OliY8810aCA2aQKJIkUQym6yltMy8qUFlAeLiuVwRb1PqCw03euRfs78HYGK?=
 =?us-ascii?Q?z78XZyE5dEd9rRHwmZV4GfzydRPjejVyo4fav6+4yqD3KBvIpXYq956hePkj?=
 =?us-ascii?Q?e4UYP3V4lgZ3OQS62BFevXhMaStiUFWBhdKjEqmFyBco2qo4c+MlRmoeikji?=
 =?us-ascii?Q?8h9SOPIBlygg+N9OlIX0+FAy4pEDKl0VSEtWbLpVA5P65LgFHgTm62hcBHmh?=
 =?us-ascii?Q?16ByXRpLEfVwhduJ3wcNoSBVUdCdS0GZvvWE1iPSy9M7SjWTq5TWQ3P4Bzwp?=
 =?us-ascii?Q?vQgUIZ7F539pgyMM4R9LDdQGquXrHT0jy+Jk4kb6/BwzqI/2mTFO8evYJfgf?=
 =?us-ascii?Q?8zXlMYD9JWcgEoCVrChxBOV4fp+WLZZ49BBemZqRMTy1om6uYRqFG3JtHuLZ?=
 =?us-ascii?Q?snFBOqMpR9KQpt8RIM0AJixZ1aGGNnwFFt8QcKkatsSHdczowqxP4wQQXfrm?=
 =?us-ascii?Q?om8qOFyFPpWBAO5YHcA6ippYLXc0s40V7IeCvLUzPHc16DPH2lEA8h/oIbiS?=
 =?us-ascii?Q?2rRg5mYQ2KkiUAYEq0qwzyJpn5BZofqjDNrIiI78jwvs5u6MrWogRyehSLrH?=
 =?us-ascii?Q?iaa9AyYTQpPj+Z1HIckgLYgP4RX2a15aqiEGoH1TWTvmhVE0Aj2YKPQmlOhh?=
 =?us-ascii?Q?SqMqFw3M1QgblsQy5udwMuMsJR3/KHYQbLX6dKxquL09VKNC4p1QGrcIRbk9?=
 =?us-ascii?Q?vgIdHtXYpErVz2mk0LT9mcOV1n8DmIe+XMN7Z8G5siopJbQdUMsXt5YjJVWJ?=
 =?us-ascii?Q?PXtNOrpAnNp/3ip9ilttpOrlAFxGc2Ir2L+nU1oRPXTwvFCyReUuCCRDVIt/?=
 =?us-ascii?Q?WV89gDQIXhlJeRHxyIzrS4DmTliMeHQMOq09LsUVU5GnZ1lzy9fZ2UqcbtUf?=
 =?us-ascii?Q?lcFqHmHJ7Bgau6zaF/q5TKtTjaD05zXf4pz4YV60niI5vrIROKp4l2XmbMEe?=
 =?us-ascii?Q?b+HpXXyoG7yGqpGKvOTUEJepwqXvJ10rwpU/bSKSyYy++2++vfZZulKC2pEW?=
 =?us-ascii?Q?sp44Svw5+cZLjDTLaJnqvbtDhYF+WEH9Fm+++d8a3RNmu7aq896dG8Q1Y0bb?=
 =?us-ascii?Q?5UEzn1brWtTPdKdo/DPZSJBcXYf1Z7RAFwLOa1XM2t1596Ign/xm3VA7Vdk0?=
 =?us-ascii?Q?yfvbSSU5LlkOOtoRu7m3gIrj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01330da6-9441-4853-837b-08d925222fc3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 17:25:01.1965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XujNGRw2qQWv5IQWZ9TaMBFPsy5qDP8hmMWP3SnSVckM7qKjRz1c6JPBaF/tyiSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Wang <jasowang@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Tue, Jun 01, 2021 at 11:08:53AM +0800, Lu Baolu wrote:
> On 6/1/21 2:09 AM, Jason Gunthorpe wrote:
> > > > device bind should fail if the device somehow isn't compatible with
> > > > the scheme the user is tring to use.
> > > yeah, I guess you mean to fail the device attach when the IOASID is a
> > > nesting IOASID but the device is behind an iommu without nesting support.
> > > right?
> > Right..
> 
> Just want to confirm...
> 
> Does this mean that we only support hardware nesting and don't want to
> have soft nesting (shadowed page table in kernel) in IOASID?

No, the uAPI presents a contract, if the kernel can fulfill the
contract then it should be supported.

If you want SW nesting then the kernel has to have the SW support for
it or fail.

At least for the purposes of document I wouldn't devle too much deeper
into that question.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
