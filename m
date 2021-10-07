Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58622C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 11:32:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E949261130
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 11:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E949261130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAD468413E;
	Thu,  7 Oct 2021 11:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sa-zaWPS8Uuy; Thu,  7 Oct 2021 11:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B574884199;
	Thu,  7 Oct 2021 11:32:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D73CC000F;
	Thu,  7 Oct 2021 11:32:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5705DC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38AC04097F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7R7wU7ktfkGA for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 11:32:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D40FB4097C
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV0hnp+6xyNkSxdmLhYMT4CrLQChdQvUZeDg2QdBpfpR5GSvk9j1Hcb28Ow+N69Q/03Aq8JR8DBX3JDHXQVq0SDPrL1+JgrLetw0XD54zNm9gvpF22T7p+CFRQ03rR5+xcvYnP4Wcae0auDc/KEAhGB+ok3fkyJZnzcGKEv0F9tPRVtqSCO+QbievXRVv0WRgPWFZ/R0oUf83O7/e+oQ80oHB82Gmclu6slKOTqR5F2tVW+GK3mtv0nLJysIFGR6bqSJFckNdv9tXSmx9m1OO/D0OfhFpBxHCNh4h6eBGnzq0r0YvkZBk3+EUPzXJ8jBf8S0z9YWbW/9jppzGshZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5QYofrs8w+sct4SoExgOk28iiOMNRwvq6rnbn8wlRs=;
 b=ABZ1PnrmL1pYuBXKbgngpdIU3aQP8ETn4rlA/0D6X1+YBHJt6EACpULHut2IIc9hEo/Z1skqqpv4262AxPtZUEeJtOZ7JlWlxsDfNZUuxm5OnPiKutLye7qY9aglabY62+nDaAI+xzPv81qAZvDSCB3HXujboAuXW6T20XaeBc1BG94MYQyfJrKBehn04ZNosPrfGQLudQ2ZHQLgjwKopHW2WXlXiq5Kzmzsz5Z+Lb9gadlzhVqnRmNA07XnYCRMwd0bxA3PA5ogjMi0xawap6LQg5E8GhuzjPRNmcKlhbb+XWTjOJ7X0IMfVmHVXleOfXVvDqfCXDaD/B+9Id2mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5QYofrs8w+sct4SoExgOk28iiOMNRwvq6rnbn8wlRs=;
 b=NsjBQhNVWzx7JjIY2CNoMoeCkPQB/GqrvQ5omOhhBympW6nwGri4dcsm1WW//nyFPP6x+KhbsgXJJvl5PPuexHh1l3eO2ptwd46IB6wvXFh7Zw6NCNgKz2RTwDEaDqHuf0qV1iTiSdNiRywsuG4TOc0g7xm1kLr1IxfSasAHHENnqefX0VrETx9XrtYle1TEiPC3xRjVvAt+7jUsqBcsWXuSDaalsbyWbeaH/yYec5zR9B7KOOaDPc7b2h+31mtL8Bpy1OBzNIJFIBzKXprfgobrTwRdSr7ZpHNQW7cfAknd0E7rXTBExdp/U4394MRg6UUpH6wbsFcVre78U3gmFQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 11:32:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 11:32:22 +0000
Date: Thu, 7 Oct 2021 08:32:21 -0300
To: Barry Song <21cnbao@gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211007113221.GF2744544@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder>
 <20211004182142.GM964074@nvidia.com>
 <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0076.namprd02.prod.outlook.com
 (2603:10b6:208:51::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR02CA0076.namprd02.prod.outlook.com (2603:10b6:208:51::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Thu, 7 Oct 2021 11:32:22 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mYRdN-00Bqys-Ah; Thu, 07 Oct 2021 08:32:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a03220f-67e6-4d4a-1baa-08d989862107
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5288505E49332160121FF81BC2B19@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i93H1yzMCl9kkTIHnU0uOb5j7x7fXojRfeGiJI468CLT9akOQtQa45nXoB7orJT9EasWDzxMsWdNYcrZP8Pz2jt5nG06ilBDHYiVB6odwR048oMZ/cUD0eXh1VQpRUH/vyAxkfa5BW0lKxu8oVzJDx3o91Y7lif6IdSo6Wyzvwwq+MAXXZD4juSJviZr/8eE1uVeiAznIv8/Cyu9eO2ElnSLLdN0SG86ad1ARNJKIVZ0OBX6nfd6L8MTj5s2AmAwPhw0yLL1M0i7HWbcbV/6CG/TWx+xVNcAC53Psy0xIh3X42k1iMj31H5v+k0vhwzDmLXJrOiqvUnwfYdBk14QLskf02OVMszRK7+SaXp9sfC+ygSjjPCr/EMftLtIts2Vv8NncyqTeYXz5IkBHcy2wbGkzcB1inJ5M2MiLu5KIpRNbh9GAXFVgu5ELGIMqdVaKyW3osaKXldDk9k2AwnSCzTM3sgGzJmv+gU5QB+8yIa0Q1hB9N4dTRg80evaVzgX9cNdC10oXCHM1+GeIzPabn+7m43IMtcJxe1f7llzUIp0mRvUPaeo0zfljGygtcm5nrBX0hYVeKYYPBOYMDfcRbYsrm2R+P/Z2eM4gBKMrjzc0BTvf9qy9z8O0wKCe7UJrwKRzRr1JQ0jTBJBXmX48w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(86362001)(33656002)(26005)(4326008)(54906003)(66946007)(8936002)(7416002)(426003)(36756003)(2906002)(1076003)(66476007)(66556008)(9786002)(8676002)(83380400001)(186003)(2616005)(9746002)(6916009)(316002)(508600001)(38100700002)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lAKFxgDvTGmGlG1tkj/6Bhjonb2+FvnEfqzM+YbUDtBuz/kkMIr0vUrbyQ79?=
 =?us-ascii?Q?Gq6xWbcJaIl3y6PYrzd+AJW1ZBQi1AQfq5W+8AQIuY/zw1A8ySqGZrzj9qzt?=
 =?us-ascii?Q?8af4xntNVEXsd3wAp+0Grz6DQjlJxB/d+FF/fecWDxpHmuL3X3uu5gHh3juX?=
 =?us-ascii?Q?dKqbcEQqij3QgCK7jva9p+XUczDRTecS3k2UnvI+xPLRoQJwN7gfX8+0svKp?=
 =?us-ascii?Q?0ZMJVDRcOGhmjU408XWUJZ9THGv5SV+vUoSdI7YfKbyhzb9yMHvX46v5viwX?=
 =?us-ascii?Q?kKJCd2qhwkPr0Gft/pzH/QvkvjJyyi89MOdj2gCRHytwhRz4G5eGyIL3Vm5b?=
 =?us-ascii?Q?lNfiXBCZkRJDkTmmALNuazvWcPcw5XSQJBMgwi7KAmIeft8cplkF9EREoIGH?=
 =?us-ascii?Q?oWI5c85klcu1nmUJNTovCh3d21w5GbhySQ0L0QVrljSvI3QoyTuVuugNE5J4?=
 =?us-ascii?Q?xM67HzmyafT70odUbd8UDVdHYtqU03zAhRKAJKp3/DnJVGZXRxbSodTcS8E/?=
 =?us-ascii?Q?HywJKB6Anhc+IragBhrYiMX7laXbErNi0Czv0xd2ow1My6rZ0mQEZd+u1ayl?=
 =?us-ascii?Q?HU91BZlui1kCnq2WD41KhojKS/ehf08MhG7Tc4JkhmtJZnzcxTN8C3zIr7pB?=
 =?us-ascii?Q?VeNhg0wpD47Jom67b6/crFVYstOz/CsbKU3luoLhQ0cOgbae2+uLnoEDiWXN?=
 =?us-ascii?Q?d/rkByV48sUPhiSHCFyUDcWZfKVWgIcIOHcppskCwOlhxTj/vZKNwkCtKbyy?=
 =?us-ascii?Q?AIYh29lIIw4jyHNnalRlnkWcDRvQJB0WQ3a+GzizUvoYbyLmySD/i8S0O2e6?=
 =?us-ascii?Q?AMGskdf3ACUj6RZGNqJgmhfSLjp6ec0PpjpmRAxnWjCgAURpupG4e5y8fGVH?=
 =?us-ascii?Q?cWsJ2RKgGKyRNCPhiNyLUHSm5thk7/a793HdU3w2+GbOlu7Wan6sW8UEhY0+?=
 =?us-ascii?Q?zmRKIWukVnbAL5IZJLNyIkdwc9vvsPKT4UZrHDlwXMZT7ZgdqZ8AWtxxP5tl?=
 =?us-ascii?Q?LIhc8hwRG1vkIwAg2Ot5uaV3BueR6SYxfTDB+B+A17VeM6KwMDPOziXz+3iF?=
 =?us-ascii?Q?7A/iNFXdeFu3C1pqkuqBvBQ6lg1U4Ncbo2HGsSrS8OkeBHUGO5P0kbdkVgz8?=
 =?us-ascii?Q?ocBTk9D+kI1RqE37G9d5YXHglk9z02099DSr2APQHehxygiMqL+NfRJF4e2U?=
 =?us-ascii?Q?Na3UI7byYJhyZ1AfjFBmuaBDI79J8p0eBuzT7M0Fro6bEVT3X4R7PoLE1PyW?=
 =?us-ascii?Q?VsZHJBVQha2LE1IcHLjDCiEps3EGSB2O9aCMoQMgkvOe420c0xzGqJuMkKcy?=
 =?us-ascii?Q?dLRLSK25rL/KbeQ4E0bElAa0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a03220f-67e6-4d4a-1baa-08d989862107
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 11:32:22.4204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb9QBRdgOP9RxpuYab4kgp/H5n3Fmu2zFIp8eURY6MDkOKNmAAZ1JCIcZN+AIHuX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 mike.campin@intel.com
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

On Thu, Oct 07, 2021 at 06:43:33PM +1300, Barry Song wrote:

> So do we have a case where devices can directly access the kernel's data
> structure such as a list/graph/tree with pointers to a kernel virtual address?
> then devices don't need to translate the address of pointers in a structure.
> I assume this is one of the most useful features userspace SVA can provide.

AFIACT that is the only good case for KVA, but it is also completely
against the endianess, word size and DMA portability design of the
kernel.

Going there requires some new set of portable APIs for gobally
coherent KVA dma.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
