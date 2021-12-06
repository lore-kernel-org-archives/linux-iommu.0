Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CDAC433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 15:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB60482BFD;
	Mon,  6 Dec 2021 15:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jMGYZL3MJxy; Mon,  6 Dec 2021 15:06:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EB8B0826E7;
	Mon,  6 Dec 2021 15:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6A37C001E;
	Mon,  6 Dec 2021 15:06:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0F50C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF16740943
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ebrN-UCTo2ps for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 15:06:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2088.outbound.protection.outlook.com [40.107.95.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D309C4038E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+1BFR+YMvuuYZPmZmZUvFvQGajWllsOJipmLsNjdTMem6/W+DmJQmYfPru1LcXWjBEfP/9GaaqPGSdIzzFd90uCpu4ZwES4mlOoWGvA7430UKBjVkfx/dDRzIzcUYAxXd2bxizbT7BqEoyKRa+/8YMpUpsIcsKArTL45nWT1CFgp1uC0T9djU9EwtjV3PN0KCGc14S3TmiXBAb1rb/i0ECltes3R5VmYAf41z9fSS4AkLn0dfMYIPOvAwPnxTInWHBddgqywuZq+EoJX9WnoI48epbhHGKxAibCTybbJz+z/DzN2atVIK8xyvBc4rSjtKWkS8EnZsoCBsNDKx+ckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBo+prTEmOeUe+HBHFkHZadQUGrNMtQgjg7nuOv+dZU=;
 b=NkPa0aGrrqC7zGQCT+OK0eot6/RFkTGkwqDx6dkSkel08NVPC0XwCKSYxXsTMf2wq66UEfjTyh0Ibbe9U0Leu9dNTCDle7PTf2RKOmh6zpFp+gi2CDJVCWNrr3vueNefKOzaHU8W+Ib4N7WwBwAghlo0xZpbttiQ/ev9SVK1vpHSzkvznKDMuGDjsb//gHaWRBC9xg6Al9Aij2H+rSjKXgZUx0jw3NKn8LbulgvchUKNWOXyklkw5ahMe8IWBQpgVUOK+AFE551vPxaCh6aVRIXpDXXTH7GGqk9Ro5j6FNDze4s2aRBwEski9Pv20RqqZeX+78TA1XXFHahm1IrAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBo+prTEmOeUe+HBHFkHZadQUGrNMtQgjg7nuOv+dZU=;
 b=OLLyeUxDXVWANamxsyHvdRrv5iCZwT5crD+e+FwNKO8UYGxlMNbSIOPvtIs6UcHA5z/iWBrAFoKGs/Lu6dCxf8ck359GnyQIhza6f7oMJBedKNXQiauN2gFC0ZqyN3HZ00MU9z4hSZwLzNqJfqvNE3ub5k3RUjKkUNal5AYCx5opr+sNHitT/miGqo/O5N6C2d52EeA4FW/QaVIS+rB/iL6M2+LODLwLvciWweUjbLtdQeInJyTnBZb0MbNU68xPRIn+wYCPA19WaG8Xgsvmlmo5Ym3bCuuqlcK9LirYwRtlm3FqTysiom/tVQZzBlqixVqA9B8C6HP/wIN1wQ4A8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 15:06:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:06:49 +0000
Date: Mon, 6 Dec 2021 11:06:47 -0400
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 04/18] driver core: platform: Add driver dma ownership
 management
Message-ID: <20211206150647.GE4670@nvidia.com>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-5-baolu.lu@linux.intel.com>
 <Ya4f662Af+8kE2F/@infradead.org>
Content-Disposition: inline
In-Reply-To: <Ya4f662Af+8kE2F/@infradead.org>
X-ClientProxiedBy: BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21 via Frontend Transport; Mon, 6 Dec 2021 15:06:48 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1muFZn-008x7J-OV; Mon, 06 Dec 2021 11:06:47 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfba5c46-e1ad-454c-a5ad-08d9b8ca06c0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5237:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5237776EF367EE6F72BC7E04C26D9@BL1PR12MB5237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DsQw1CgA0Cgiko0WaqUfRcJIm9kklXhFa8vMHNHZluTMFQC4OKIkNigyWKg24jf6dSx6YC/YNnb6DNX0meaZBOXedTn/vny1StllM1Jdntt5LcvEyb8LbZw45yaE+8EAxHNW9Oh3y/3TUQp4ZqNBFamwH+sWkJL+PifdoQviwtR73GKc/+/UpmLPaixjNJ0iEsT5+LZseB4okIhl7InRxFz13iNFg/j2HiSksHhq+qVD7DMCQ45zYaEediv8tBcacqUZ4e6GeIMFAjBYac+hKwI0/JegRDe9ue2BlE98C3hPZiPOHXpm9BJU6g42Lsca4pWa7CfESAHWl1CK9XHR0k+ms4zCzDVKvkfu0cU4/cV472k0XdJEpCvvubCZw7mMF1bSYnWeVUm9TLkfToWl6H3Dmn15OdDQqNl1qlJitRJyOFl9WJcQKOwTr9pLLPfRDySBPOyjEfH/BL0WGFjskQzwB6d9TgKYQ91xvUQWZFEA21CZJzqD0jhSshXKph+aGuP0OF2aIbmxmqVPUHY3Rh1n14BWPjKgOQnEiyCZVcD5zIUxbcBLNLO/R/Q6a6ZObNdWaf8tH29/8qH1H3QBHhCPJrgoIixNyZDRDwl7hfUOn1pKiNsbYIrIJV2XlQHcKV8qK/uzVRFFlni1IDDfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(8936002)(426003)(66946007)(66556008)(1076003)(4744005)(2906002)(38100700002)(36756003)(66476007)(6916009)(186003)(86362001)(9746002)(7416002)(26005)(8676002)(9786002)(316002)(5660300002)(33656002)(2616005)(508600001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rFBCOmDC9Xk7KxqnGPh0ccDa7pLqkktG2NSwSRn/Fz8GHYeSus91M/2TvS96?=
 =?us-ascii?Q?OJ+dEotJgFgM5S9ub2YsudhQGQDlLBDLDJ8Gt4blAW/Ur3A2IBdyWO2DknRt?=
 =?us-ascii?Q?CA56U2lsK/jOE4jmcGVT0/1qD2iuY/WoXw3yUrZN0/slbbzlgZFmd9Itw/am?=
 =?us-ascii?Q?DFo6fW37aPCFmE8xt7BUYxxllXeJN7fQvYFE7ULg/cDBQUF8Xa43N+haLeSv?=
 =?us-ascii?Q?D9m5f5wBggv8QQofhHCLz5Cf8Xrug8u6syFPBPEYCZBYbLtQVvuQbMCzyYle?=
 =?us-ascii?Q?2Uc8U9KhygS2HgXP7DZc+6UjmEPvJdYSji+QPbpW01B3oACPeW0L4eXRTm57?=
 =?us-ascii?Q?KA7/M8Y1oTYtcpiMdY/yShHX9pUisXLCBllXjty/HdTaqn0bPDtDzBlwwdXb?=
 =?us-ascii?Q?U1wUgusFSrWFgKyKoSd6YmhkyavvGKx50mCXyvRiSlgkRWYvCCtagX7YywRl?=
 =?us-ascii?Q?JdLQdhu5HFSdwA3IJea9vO1F2Kb798xCyjLaXxkLPMA+n2GLEJmNDx045/7v?=
 =?us-ascii?Q?kRNp1B31jfkV1bhNcvF6d/KSgU9xW2Ep63nNbPgLMys3MBH86FDNcZARgl3F?=
 =?us-ascii?Q?orZwOqS88P4MLQPXN0n8iaq3madBd5kDBum3eoVJXANpP90Jq757t59GgJ2H?=
 =?us-ascii?Q?+bHoOy9fUrciNRk/z17MCkHIO/IVRv2KyoOSvlYR2dEmjbdAPXZ3cSOlqeza?=
 =?us-ascii?Q?SZaqgCPDavwNcr7YjsGwXANSmU2LOEoBOGA/Rr+itBj+DFFbszC1kN/1QBMY?=
 =?us-ascii?Q?YnaEj4nMz1t1zI1MES/VlfMRC6gRjJvlERL4ZldeQOvoABZKQaCMFyUb4efG?=
 =?us-ascii?Q?PACHnpOY6MhvpC23ALadS9x7GOu9qzR/xIasDMIf4J1MazMiCYTCuu4J0adK?=
 =?us-ascii?Q?4ngSJwiRTnK4n/ub/htflPR1tRw0MUVhA+5KHMRF3vnYuoj/RgGqxAEqmvSU?=
 =?us-ascii?Q?4UwPT2iq/gSSE05B6bTp+Q0wY6PQBSMu2hMLIJmVFVdAyzXbE4nwIBLxUa2W?=
 =?us-ascii?Q?eCKriAaUluL/ldzPAs6/I5ix6nH8+NC2cuVK9uTgACdtTK/FUj7wocTtr23Z?=
 =?us-ascii?Q?3eG6NIqgYXh8fRltGEikuEouWCyX395GhSTBYaegUhvCcaFtvg7hVaudzobl?=
 =?us-ascii?Q?GKm2mXl73uKZZMF2SpZlmuzBLeOliE7z7TLP78YSsG7hYJl9jK+OAMW+lOuH?=
 =?us-ascii?Q?vwXn4xwBUfgx5iwxQUHCyMGGkY3j7tsWq7Jw+CHBLrUiaUdUGtUMetu29suq?=
 =?us-ascii?Q?ILz5VY14eAWN12XSCV+uXMU5uz9x++DgXfDOmWQ5I6KlWhub9AxzbN6NJZqz?=
 =?us-ascii?Q?AzhqUhBC7KRUB3evyGbx1+904Py96t03cuDkWbVAYcMvplzmnUGPXLh6Nw3y?=
 =?us-ascii?Q?gpCnlMZVbEe047+ijwefVe55Y88hd+NPrUiHoXT8ScTOSyV119+0n5+lwjlY?=
 =?us-ascii?Q?C4darY2nsMkGPeaIfpr3z8BRTCHoQdO7HeV0oUXNivgc/3FQ1GRgSyu00rPt?=
 =?us-ascii?Q?RsKtGR/OIKlUgEDYCdVniiOpzBU6NoasExY8YmGOMSo0NQfK0xI3XtdacbLh?=
 =?us-ascii?Q?rcbr84zHXhxlz60psuk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfba5c46-e1ad-454c-a5ad-08d9b8ca06c0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 15:06:48.8341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g85Z5i4QYonz2nVRKPWrBPZbgVzIJARtEwySs4vhM9OPX6Om2do66c7bHwGqBJp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Mon, Dec 06, 2021 at 06:36:27AM -0800, Christoph Hellwig wrote:
> I really hate the amount of boilerplate code that having this in each
> bus type causes.

+1 

I liked the first version of this series better with the code near
really_probe().

Can we go back to that with some device_configure_dma() wrapper
condtionally called by really_probe as we discussed?

> Between that and the suggestion from Joerg I wonder if we could do the
> following again:
> 
>  - add new no_kernel_dma flag to struct device_driver
>  - set this flag for the various vfio drivers
>  - skip claiming the kernel dma ownership for those (or rather release
>    it if the suggestion from Joerg works out)

v1 did exactly this.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
