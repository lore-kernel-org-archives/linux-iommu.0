Return-Path: <SRS0=J567=KB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC4C433B4
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 12:27:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1F4613DA
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 12:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1F4613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD55A401E3;
	Thu,  6 May 2021 12:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6uWjV_wlnGOI; Thu,  6 May 2021 12:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51295402A4;
	Thu,  6 May 2021 12:27:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C07EC0027;
	Thu,  6 May 2021 12:27:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86FBBC0023
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 12:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AC7840646
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 12:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t5y8ZxBcO4ju for <iommu@lists.linux-foundation.org>;
 Thu,  6 May 2021 12:27:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::628])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76F4A40289
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 12:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy0NV+Q/s+IEiL18ZumpmPBsMuDN7YySkLT6BQitkyUFAPMcrpwsd3fW9CBV1fMl4S3+S50lC6nvrFFYrZ2xv06+Y+xWLScWH+FCa+Lt0Q2QY9hMm7O+RIGjaluITITxMlQKXyQk0CPdLqM4JMnu3zBpF44/Cb15ohuMEEzhnF7evqG5l4oq9PsZfVzjmDSkyzpK03u4Tx8IGQA0GT8oRGzauzi5nYTeKP5yj9iSdB2Pz4wEIS3phXArU8kHov/tZowRSJ/YP6qx8f8YSe/bmvg6GpIZDcszJYhuVAnbeAYwcB5sXkG6ffZixhxCfeg++zIDO8Dz4jXMNKbnaWX+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUnM+SoblgyZbKXGB2OAUHX8JozGAwl5FN3Tsj9wolY=;
 b=GxfSJxGC9tEbJK3RCtCkHbgg49CxsgV8oiVmg6l7i8y2jQGlBFD4e+92/uh7J1wpSgAGcqx0nDvWIjFlVR4eJr0ulYPeNSkX4CFassuhiIBt5vV0/SUF21Hbt3OtuFI2a7zzQPhtjJ/U97YRCtGR3hv0AYd4gj8siIhbbioyTAAzIGqBAjVYJiBMouzbqmfNA3q1+F0dPQiukZo5Fz9g/eGTaDfX78fxi9jl9qzfLrNPGpqj46WaM+bj9LwDGqEYgLYZhCxlmT5ADELNHLkFdJVYVJX2EGmzYGDOgRYNIyypt/7zujkWx/jLDCD+xxdvAm1ftBl5P/0TCQ+tTUbEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUnM+SoblgyZbKXGB2OAUHX8JozGAwl5FN3Tsj9wolY=;
 b=N6RKjJGv7FOBoEEGq39G6c/AJnzsTqSVxNB9XLw640NwdpxZUw+hnDX8icQlJq2n4USKfx9g1qwoDbdErQajsSMOQZ9iwEjMiWyaFRIzBlUGLiSh+PtJe9XpqaE67tI7Kuhp3IvT77mrMXyFxnkw4GYVbdW69fuP2B5r7YfVP/9pixhAYHoQYV9vT2s++U4DRPws08jKjhEkuDtZi3g1Hp2nYK57Ez4L0fSy7FXcsKBmh81WUINGBiOgNyQebVt5f0C2X+jsV1vzJi1YPS5hdHtfRgCgoouGq6nyoSV8Y/ij2g0skryCB7b3+mI2d/05ig/9b1GniDe/i6MU6BW8BQ==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Thu, 6 May
 2021 12:27:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 12:27:32 +0000
Date: Thu, 6 May 2021 09:27:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210506122730.GQ1370958@nvidia.com>
References: <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
Content-Disposition: inline
In-Reply-To: <YJOZhPGheTSlHtQc@myrica>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0260.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend
 Transport; Thu, 6 May 2021 12:27:31 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1led6I-001oSB-7V; Thu, 06 May 2021 09:27:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bbdd94a-b633-4ba2-54e2-08d9108a51dc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3307E71E9AE06AE691177DE2C2589@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnBBb2nsiKgTEgK+YUkXeeiUi0wld+rgtalc7Tm7+xlzheY72ZQvZKEGbqYahSHfmkTp6FW0FJqLhhgWO93V1YJ2ENPpgCsyg1o9j+EgfGaw+9RVdsoj8/OAMccBh7zYAsMeDjHtyTARzyl82NoxQUU4tBhh2pTAVWeUnUl7XuRGTpJiO0g3k1kTKqIvb92ADzmc5zNWAb7jIOg3CMtwAtBW/VNfEEzplH6cAs3i4h0ZoVRY5ni0uc5qQzfaR20jePaSDxetJ04vw65Afb+W+d6EU8PiUAedANGx3idAm55SIOz5Si6lO4ZHwsAmLr57vvgWV/Ofv2vDNeKzKknT8wUkRWPm/DLvuRfATYXZCytODRBR0EtiKbsQqdSata6Ht60pRsybsTtHVC0MA7Mcs9268wlxI+KNbGkVjyXD/wlzDtmoi4GjZAm2SCCoQncgR4/XrUjCdSRr/dB78S1OrsSyZe/X1pd1UmK8m+z7w8n3q7n44XDFdgXXVFa0W5cvdCw5kzFrnqXFGZpXu8WhZZhpObc+8myJUx51zSblWm9LQ93TNkDTpTYAGMlDVUGsA/RvztWypINXQqd97oG38MWydDPy0aVz7kBxhnpLA4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(2906002)(9746002)(5660300002)(9786002)(8676002)(4326008)(1076003)(316002)(33656002)(186003)(36756003)(86362001)(2616005)(66946007)(426003)(66476007)(7416002)(66556008)(54906003)(6916009)(83380400001)(26005)(8936002)(38100700002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V3Y1P8DOWoETHnqjE5FbAx7v7CEP4AvFc52pTQcA0TiBSkueJAK4DQZucT0X?=
 =?us-ascii?Q?7NFPBCwicGbF74CnHSNsiJsnbi7JXLJeGxRUUPufySIKSRlC7kNoFupCamaT?=
 =?us-ascii?Q?1j8uKLcxsasgjFw8q5yn1LTArDwpL2rG5rdN+8k9PHFtGaDNB6Kds6n3Imws?=
 =?us-ascii?Q?SClITWdfSB1/GVRdoigt8LO+RcBbZA3WJEmeNaY7MO/Qkea7ei1lVi+703kv?=
 =?us-ascii?Q?KhH5PV5lQX9Xn14bf6ieul6i1AM6NC7OGps9xmiFu6spE487rQFG6Ts/qcBa?=
 =?us-ascii?Q?ImbJ9QKUVLFpqrpNi/104WrB3T1SZfnpth+YfjgfrCkvxWwtV006lGLeXxOs?=
 =?us-ascii?Q?3Q4j3RTkcTzBOGDJqeMTHQayscnPW56PnUZ0yf41oeEOopeb/4zVduUk6R3W?=
 =?us-ascii?Q?23VNCwjjpEotT88CD59P/zgo/m5UJjCM4eq1zP3IVoUhAYnVBlj6lv6lhYr/?=
 =?us-ascii?Q?XCWBrblmzsHlPsR8C8Y98g7bJPpYf0INhbZeO9sJcK32xbO4G3YDfzAlNx/Z?=
 =?us-ascii?Q?QTQB7C7ny8t0bMBdjsa/QQgmett/TmNsy8+CapMnHfYikvZdrEiDYYVKU35t?=
 =?us-ascii?Q?xCnU4BPrnqa84tsQbh44cVl22NZUFjtgJR10RDYMCqRqXQw5r5wPSeN0327H?=
 =?us-ascii?Q?nsZJ2elvBd8PcFr21WRxJ+eCPtb9t7MkXD7e/CDWL8g0Wd6VHfMNZvdg8Q4m?=
 =?us-ascii?Q?C/XsXuACeo8zCRKjnOOVcbdVyybNvXdFz4jqlF0LmjhHk9frwMJGlAc11Lkd?=
 =?us-ascii?Q?zLyecYHylxfc8vFAoKg4B3JEgosLbdApdl7Fsol5MLSTjgzGCMct+QXVRGae?=
 =?us-ascii?Q?JOgMot25csK2U/OinYdUpYAITL1qXXNPsIcGaNu22Bg8QgV+fLV84Vkii/T+?=
 =?us-ascii?Q?wx4JBJd3jClRI0lXJ9IOlfHGWSZA+FvfrqUvXwYbLSwq2OFXPDz9FDvlYZcB?=
 =?us-ascii?Q?cBjXDyrHNFa9b1pbyur6720NNqH5tqs800XSSARzX4G9wD41nagdyDOKk5XX?=
 =?us-ascii?Q?Bo8n74RzcwqdaQpLnaPrPyZ2BzYi+ZA0SHgUrd4gb0pbATjAa8MXSPctA2k2?=
 =?us-ascii?Q?pBQRGesrFNDiuxpDZYTrpBVOr/Qg0wmfjGKlVfs9eJjBUoSBXdVWmd36vTWC?=
 =?us-ascii?Q?yrT/P8tXb7FXAON8iW76GqFsGb9/XBwIvFThyM/1AEbN9BmkYZOZKw1NWnib?=
 =?us-ascii?Q?4exxzE57YAOOhKuUNQBirBAHWQ+4ZSj5A98YwnLxFYAXm4HUVsp3LgqGLTBl?=
 =?us-ascii?Q?HsjOsbCZhJEMEdYzC2g8B0ht26khvs6gDV9nsGeuLHjPc7qDBQ9qTxXEoPv+?=
 =?us-ascii?Q?Mj0hAh6j1xAqfPsN9JljQL3H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbdd94a-b633-4ba2-54e2-08d9108a51dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 12:27:32.0397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blOGTiootY2BbcK7lAHX0g5O9HMMJ8ScnASRnBIV6108uLQtbtXBx1hqDWtfb/Zk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
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

On Thu, May 06, 2021 at 09:23:48AM +0200, Jean-Philippe Brucker wrote:
> On Wed, May 05, 2021 at 01:04:46PM -0700, Jacob Pan wrote:
> > > > For ARM, since the guest owns the per device PASID table. There is no
> > > > need to allocate PASIDs from the host nor the hypervisor. Without SWQ,
> > > > there is no need for global PASID/SSID either. So PASID being global
> > > > for ARM is for simplicity in case of host PASID/SSID.  
> > > 
> > > It isn't clear how ARM can support PASID and mdev but that is an
> > > unrelated issue..
> > > 
> > AFAIK, the current SMMU device assignment is per RID, since only one stage2
> > page tables per RID, not per PASID. This is equivalent to the older VT-d
> > spec. prior to scalable mode.
> 
> Yes that's right. Since SMMUv3 has a single level-2 page table per RID, it
> doesn't support assigning level-1 page tables to guests for mdevs (sub-VF
> devices). So no PASIDs for mdevs, which also means each guest has its own
> PASID space and the host doesn't track guest PASIDs.

Basically it means when the guest's top level IOASID is created for
nesting that IOASID claims all PASID's on the RID and excludes any
PASID IOASIDs from existing on the RID now or in future.

Which would be a different behavior than something like Intel's top
level IOASID that doesn't claim all the PASIDs.

Lots of little special flags in here :|

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
