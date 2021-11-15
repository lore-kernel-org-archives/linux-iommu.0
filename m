Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0767BC433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 13:38:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922D461B27
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 13:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 922D461B27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C3D80DE7;
	Mon, 15 Nov 2021 13:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0j1XoRdJhzm; Mon, 15 Nov 2021 13:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2FB8B80DE3;
	Mon, 15 Nov 2021 13:38:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16E16C002E;
	Mon, 15 Nov 2021 13:38:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED3F0C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA7BD40177
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQMrrzE3RbBA for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 13:38:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB54A400E8
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNvjD6z8Ev3MLHAvGvh1SN6tvJEa4FOP+VV3GkDxRx9KV2s9LK89MD51tbBGWeyBe2zB+s1STpn+QDYfhwL7QQZ6WW+aHbTcgpvR8JetMdIgnOoRdqxMilHrEFe/fJ8MN2omJ3ZDOOyYclih/r/ySLlTuOBOiyEpkwJcbPjx6LYn9bYodhuW+VZSo7oJjDHK7eows7/AlatnY4qKV4muMX+dOAS5FqDpGcKpysbWstL1Pc1yRl/2dfFMxQIX6VdHv7+yL5+yvOmMPuSRbdyE5cO3BKg/gkI2O+76kebIu8i101ZmBldJkS2mb74t5paNKp1IG2vY93QVXUEh80x6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej0YBITiTz6MlpEdgBhnrqTxOocCUOAONS8G0UL/onw=;
 b=Jy84QSsRgbZktpEflEaSL0JxU3urb1jONKJjzdeXHZUdY+4wmhPpQnmOUa0ni4ZLMjllxglIPs/kEgGizyoEI2oqIfktA4eDPhjxwndMmoom9sFqKuFze2b+TFt/FbaL33w2ri6ymCx+itxgXGA+IOxciv/x+yacjDllS9VZknXZpYtv0KKydq1Y0ECVtvqO88cIUi9OKoGkCnAsnZewJbZgO6Dmf9oX49BlsE20Q6UkaAv7LHKFPzF2ZzaoTtJ92f40u/SZm1rGr7cYZCaZv7SEjr5Dq8D5EP3bs4V7LxhKCboxR9Sc1f/AioS9dJo1Es8F6O+5WgCfmLwNpbD7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej0YBITiTz6MlpEdgBhnrqTxOocCUOAONS8G0UL/onw=;
 b=ksV76H+aZ2JaQDdTorYE73iESgiLFWwOP9zRCs1l72exSwuY0V6zxKv/uPUTvgKOhxF0OjRasrH9H1rhw5S82xxjqkxflIbJ4k5ZmYeofc+HZfa0Q1wbgiG+9CAuyg/bVgRKYA3jQTBkJiIRJPZJAi0dDNbiNhyIN1LDn2J2+RcQLf++JtdCIib7VifEhHzHt/uByGAMX/aRUwq+tFjkpT66w3GU3bh1h6DHLH7AEZWF1Fxcav5j4kOJMVW0/zknhk5R447d6L3et5Z2GDz57zxf3OitEShCp/1DDKJgiF33l3MSR1cGsH27h/pz7z2IiAb8SCapZNlisMmSwIThMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 13:38:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 13:38:16 +0000
Date: Mon, 15 Nov 2021 09:38:15 -0400
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <20211115133815.GN2105516@nvidia.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
 <YZIFPv7BpsTibxE/@kroah.com>
Content-Disposition: inline
In-Reply-To: <YZIFPv7BpsTibxE/@kroah.com>
X-ClientProxiedBy: CH0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:610:119::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by
 CH0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:610:119::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Mon, 15 Nov 2021 13:38:16 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mmcBb-009zP2-16; Mon, 15 Nov 2021 09:38:15 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48dab027-fdce-4cab-219d-08d9a83d2dc9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52382CC182A5F244563A8194C2989@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpX6uR58ISmpLRy5LuZRXkVSfn/0yhHVOZZmzIvstEOcO4uVmvd/odtSpkJMVIznR423qRBBcCiI/8fGjt1sfZmf8k7TDO48HeptezDlKSrhOmgFN0vZ1cEejJtSQYytHglGpC0/BMXTf2CZHc4wQar8nMTW4P5+8aubY1pDd1ics05nZP29tv8aj8Wyay1JPKcTEWScb0DraiV78tbdL4NQVf2H60ocatNqWJisy9hiOOSPqHWO7FG3Idkw9IedeeKcPDzm0yZ6z+XEXZB+UIftl/RG+Y17cDarxLFLy/Uac2OqB9+h1f2fuIUewwXmO7ygZ07+fGyOvZB5t2NKF+eHwviUqSaY06TGhsVK5zsKKptgkg+CMq8htpONEvlBoLQQ/qnDNuOqzXWL4/ia5dziF6daGTSGu/TZIqvbTNYP9HfJV41Fb4/0hOq0YoYFK+xAQ8coPfXArm4iN7c+Ywpi4YroU2DCrXbyM178rEa/mT0HOXDVqfjTTVgk2K5bXXT/X5pQjRS/kk7jS97UrWMVpI7DSTD4homJkoicY/PlXb6NB8neVxAfosNaAH00/YWYxqgz64RvBbC1UR15J2vOPVNrRyDGvWYKhMQGHpM9leVAx321+SUCImCXf9s7XdlpganPOAHc28qbtdN0dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(9746002)(1076003)(186003)(9786002)(8676002)(66946007)(8936002)(6916009)(36756003)(54906003)(83380400001)(508600001)(66476007)(426003)(66556008)(4326008)(7416002)(38100700002)(2906002)(316002)(86362001)(26005)(2616005)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QY9mj9+RSPzNeUWOqREWgrunhuMfe0aQKa/2E96LRClO9RT0kGgZRSkTwOvM?=
 =?us-ascii?Q?p+qWyI0y83TSaV7SJKhqf57cxFDh68OIaXsF74V6yZ0W5j4OK5SEDq8c5mPX?=
 =?us-ascii?Q?O0r9xro1UcCnyfQs5fp9J8dXuyrf+9HM5U0lUDo37gf6LCE3vG/Ocv0u+rZP?=
 =?us-ascii?Q?MzJbPW1iQSDWYEKk1OTm0IMawYJA8QhsurVHojH3d4Mdc6PwkkG9AE5sP0LQ?=
 =?us-ascii?Q?WyBJiNjNAGvZ0JYTWShpuD3JAONIx6HXBWu25Xny+8MGE7vYqUqU+hdFqzzk?=
 =?us-ascii?Q?AAmP/rqnS2pR9r+J4HMbVaQ30t6snqX68g7wM/V/MBpWpr+D4AKxzkOVSF9C?=
 =?us-ascii?Q?XRse8pv0dHLtYw4HTPKncWVSE75lKt2QIh/PSKYSGNf97oNX2nraZHbBNro8?=
 =?us-ascii?Q?DLlqvZ4POsmV/7uyrEchXZSc1VDJbtj2Z+eciwfMhsv1XCLmHCxRZ7s7DRdr?=
 =?us-ascii?Q?9I207kMMghwr0I6l4TJgvAMKGNBDDbE0hB3lBzpAb9KBvDl13wpOn6hgm8DV?=
 =?us-ascii?Q?NTUeUSIsNPcMQvk50bTXqElEtnXnJFJ3ewzxVbeREy9Xtf3OJ/HXIbz+FXpC?=
 =?us-ascii?Q?kM2nTx9ORmh/F+LFbQll5zRqx7x/tnSbD7RIwS3kIJRpWXU0bxHHMAgWedM1?=
 =?us-ascii?Q?MvCu73EJL0jrtkA8Yu3Nvv/4tFLoVOB83JBLB5cQC+xs8rXJtSVp5oX4b771?=
 =?us-ascii?Q?92TBPtWtvfB5f1fW9AkPm0C2dOncgIyOkxQshAQanf4GRMzq1I7IhlZU1Lmf?=
 =?us-ascii?Q?m1Qw7GIaR8yiBIm8IfCSlGsJn4KswI/C19j0bmDGc8T/Nwyf1eHvh/zDJJkV?=
 =?us-ascii?Q?51+ZAIZ9CP0uaGrYmC8MBCRvoLeibPsfHkSWhlIiEj+fnVkpvUc95NywhnD3?=
 =?us-ascii?Q?oM9hfcfN6bVPsEi0OtScFVArqa/xfJCiiBRYlUPBLShZyhOmi0VZxnT/E5rB?=
 =?us-ascii?Q?R3K2Bg9Ug8sdIsDdxo8oGLe//s8zFTLnQp+HeA79vxOKYXkDoXaCFsLPcYqH?=
 =?us-ascii?Q?9I1J3OcVbzh7cfTmxsdSs9yyo6KdJeq6Ex3+GUbw+aw6qj9W10EQOEMewRKQ?=
 =?us-ascii?Q?nnDgagXFqGO1woEnNKBBFOoqvGZVQxqqv2humSs+/nheSTJtMAN61SKKCUbC?=
 =?us-ascii?Q?VM+OadKhk4yeZjNFf9lrsShxnkGyDd/DGK37PxWF2Nn3q0wrLziOcUCmwUEs?=
 =?us-ascii?Q?e8qpQGfZ79itCPiFwPZQYOMwZExfwWFNBHmXOd9dNvqvugrFfhaxLm0JPDjL?=
 =?us-ascii?Q?IxzmSZYaDO0zHXUp+LPuNcVCAyDHuBP06TRTm5b4Zv9Omqt0zJUV6AVXbYXg?=
 =?us-ascii?Q?Z5EVJpxITscnsKpbRhZfk3gAzufeFN8gwldXYhU1GwEp0Plk0fkfjt+LH0YK?=
 =?us-ascii?Q?gOhWcLNkud/flQywhFcivQVcRzddDKYMQtuDvAntSAYDt1ivJCL/YAsIBEU+?=
 =?us-ascii?Q?v23dCzzDDA5HCi6tPgTBdtjvXW5yecueeeMfDC0PjMYVmHR7aslygEnGw/4r?=
 =?us-ascii?Q?gJp8HqvCivabqxOEXYEApU/mXdIL8e02Ir1Uph6U0Zkwg4GzCCSvMg6k9wkf?=
 =?us-ascii?Q?9RWlZiWwPefBtTt16g0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dab027-fdce-4cab-219d-08d9a83d2dc9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 13:38:16.5886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsRe3FSFfll5c1c1eSvw/8H05+osdo5bFabGwjjdOGUnQYMZqM43Gs2Hkhe5XBGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 linux-pci@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

On Mon, Nov 15, 2021 at 07:59:10AM +0100, Greg Kroah-Hartman wrote:
> > @@ -566,6 +567,12 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >  		goto done;
> >  	}
> >  
> > +	if (!drv->suppress_auto_claim_dma_owner) {
> > +		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL, NULL);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> 
> This feels wrong to be doing it in the driver core, why doesn't the bus
> that cares about this handle it instead?

As Christoph said, it is not related to the bus. To elaborate any
bus_type that has iommu_ops != NULL needs this check, and it must be
done on an individual struct device as the result is sensitive to the
iommu_group member of each struct device.

> You just caused all drivers in the kernel today to set and release this
> ownership, as none set this flag.  Shouldn't it be the other way around?

No - the whole point is to cause every driver to do this test.

iommu_device_set_dma_owner() can fail for any device, if it does then
a kernel driver must not be probed. Probing a kernel driver when
iommu_device_set_dma_owner() fails will break kernel integrity due to
HW limitations.

The drv->suppress_auto_claim_dma_owner disables this restriction
because three drivers will deal with DMA ownership on their own.

> You only have problems with 1 driver out of thousands, this feels wrong
> to abuse the driver core this way for just that one.

I think you have it backwards. Few drivers out of thousands can take
an action that impacts the security of a thousand other drivers.

The key thing is that device A can have a driver with
suppress_auto_claim_dma_owner=1 and call
iommu_device_set_dma_owner(DMA_OWNER_USER) which will then cause
another device B to be unsable in the kernel.

Device B, with a normal driver, must be prevented from having a kernel
driver because of what the special driver on device A did.

This behavior is a IOMMU HW limitation that cannot be avoided. The
restrictions have always been in the kernel, they were just enforced
with a BUG_ON at probe via a bus_notifier instead of a clean failure.

So, I don't know how to block probing of the thousands of drivers
without adding a test during probing, do you have an different idea?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
