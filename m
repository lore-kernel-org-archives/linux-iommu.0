Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A09457
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 19:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TURmxyjs4ecx1R2aNsWHscwZ0qOw/p4toaAF1TjUxvZ/TdY+jBoYJj9193kWXjkWrZlj0DE17BBG4XPzch1bDJ9T9DptE42k/JO+JQ82kBHStBtqdrCLuDM/ZCaqU5cvbbaJ0Joh38v+w6vbH3H6ElqHt0FH+ycxRYTKNZfYczRnddG4/Dye1Dqh1SiO1Yk1fYdJcLwgD7jtxa1L41MKC1zG7W89L2pjbSMAoioBHJrkAt/FB0+VFiu6cMhWWMb7rXV1D8LWYinVGQ/+4JQzuXBIgH+rW558RD7kmWOdd1dIuP8/y2zEeBXQpGhp3Y/tQf7bHWmeFU69mSLGZQ5Gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcKoUZfQPC04b+bci1i17/gjEcIYPhd6hU0l6NJCpDY=;
 b=deLNLp2CKP6GCYk4Tzvb50nUbdX+qQbKiFO+hwBijnqvDSCc3WwIwDFTda6Ixoo534y/I+ssEXlikql01mr19naJX3kF9vpd3tXv5XkrR5q14l1F2qTLQ494HOxKc6mTXGNd0r5MsGA5GUkQs1QgP2eW+eopSoA6p1Mjg2m2KXaPC2oR7r8GywdhAYn99GY+q/t9NZ44CwB3bHq0qLrUjwcMGy0V+NA+CgGr3feC0uV2+rWuiAWNMQRrur1w6/ZBD4R1U9cEWqbWwGUnp5+1loCD8J32PMKfJg8mEAIZTi+x8bucxPIgpxcq5kyD1mcyWz2fo17BeoicBZJJYDqSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcKoUZfQPC04b+bci1i17/gjEcIYPhd6hU0l6NJCpDY=;
 b=G59oLwXYBOoQF6+FbuLvDgFqRH40xoqPuHXnk0W0YPkPe5Tu6Rt2KiV+1WlYCSHUoABQSLdMe3MbGdMi4wc1GDXIZcUJtRIx9x6xOwIlhkEh19u5WVYY2ZfJgRrlegYlOe4KGpCOTKrC0/6vL/POqRDhkGrr1apdbga9dpjh6O/5ftYBPgIlxEJuuZenjkQRhRLfbf7GH8wRXwNXbPraxd42dqt+v8sw58D4TAQX9P84ksJ9CwLww9zfhpZ7Xqjor/co1c5vqqm2sXkYiFepyTHjKH4YQ7Mo5TN+c1yI6Qj95k8wI5DPC7ECPwFmeBXttAaCHfcKnBYujpmkcb6eVg==
Received: from DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) by
 MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 19:03:08 +0000
Received: from BN8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:ac::39)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 19:03:07 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::99) by BN8PR07CA0026.outlook.office365.com
 (2603:10b6:408:ac::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 19:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.29 via Frontend Transport; Tue, 11 Apr 2023 19:03:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 12:03:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 11 Apr 2023 12:03:01 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 12:03:00 -0700
Date: Tue, 11 Apr 2023 12:02:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Shameerali Kolothum Thodi
	<shameerali.kolothum.thodi@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
	<yi.l.liu@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, qianweili
	<qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZDWu4wTKvFpnaliY@Asurada-Nvidia>
References: <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com>
 <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
 <20230411090740.GC2040385@myrica>
 <ZDVLL6qcTxfIMT5g@nvidia.com>
 <ZDWpXqR9tpSzq/t/@Asurada-Nvidia>
 <ZDWpw894UhnTBm1k@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDWpw894UhnTBm1k@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	BN8NAM11FT017:EE_|DM4PR12MB7647:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deb4389-af27-4a9d-5437-08db3abf62ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uX1VUL4GO6humDWfovpAm1qqTQc0tZdi/pejnUaS8ZFjoRV4xuErHgKlPJgZkT9Ojki+uSFpgTyLiJCUTqrkkkfe7Yy8JuWBkR9qbwa7QyxxmczRN9q0+UPjH6JJ29Lc/GpjvFOu8SSQEaieXD+lRRmd8A+iIjvfH/y+HbvJBz3oCHgqvpwxu5KG4u0GBqcIFTXmy88Refg/hhFiBHHf2oC549ESrRxCCDD2CV04eWo3P2djLjBkVoSUWSh/q2NTVw1GYEYp9GvXtr5iWzd87RIMarxoyKmuEEOQun+mDsNrY0bLYNU5bzo9n/zAM0/y8ho6IoEgIVLc/kkf+cvU/n4zTT6I2ILmgLezKnTCXPZuPe/AqKZk2oNHngLo/0A5JI6P01AoZMqlj5QoGnN7cwab/xWDV7EkEWw1yoUKd/gopCbDH0R4X2et9A8i34YNz9Kc+zRVzwLKsAxahjq7NDQ4626QZCwdV6OWuK/bJcsilXn3CTcWt4WnMc7zwQJ2j8Ukmy1pSkVVa0/OE0VPSxPudZOClG8T66gzheklC7zJhIWzlgmB1zdc6NLtilsvPJQosknRfwo7quYV0AlrFXa6SCUI7pjd0up1oxb2UA3IZi0XgoeelhHmrVenyaUtbitxkcMlpnmxhkm2kYtbvAIyMrbhFx69Hcf9n5fbh5wFWF3AWHwbHjqm+LqQCYEoVVuna19Zji6gGxedCZPbskdxqdXCmuTHVCVcC+leWbOtOcZgIGsMdsERh7Za9egcpFLUblG/E2fV3xWk3/QO+WMC/MRaNkQTVrZfrlOhpZo=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(7416002)(36860700001)(40480700001)(86362001)(356005)(7636003)(55016003)(5660300002)(426003)(336012)(47076005)(83380400001)(2906002)(6636002)(54906003)(186003)(478600001)(34070700002)(40460700003)(9686003)(26005)(82310400005)(4326008)(70586007)(70206006)(8936002)(8676002)(6862004)(33716001)(41300700001)(316002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:03:06.9938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deb4389-af27-4a9d-5437-08db3abf62ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

On Tue, Apr 11, 2023 at 03:41:07PM -0300, Jason Gunthorpe wrote:

> > > > > > > We are using ioctl method now.
> > > > > > > From the testing, the TLB miss impacts performance a lot, so we use
> > > > > > > huge page method.
> > > > > > > After using huge page method, guest can achieve comparable performance
> > > > > > > with host.
> > > > > > 
> > > > > > Looks like these tests are not stressing the MM, just measuring pure
> > > > > > BW of the DMA, so they don't get into the invalidation regime..
> > > > > > 
> > > > > > You need to measure a more real application that is actually using the
> > > > > > MM (eg alloc/free memory, fork, etc) while it operates and turn on SVA.

> > > I'm not talking about kernel dma_map/unmap, I'm talking about MM
> > > activities like mmap and munmap that become slower once SVA is enabled
> > 
> > Is it about mmap/munmap() calls or accessing mmap'd memory?
> 
> I mean literally userspace mmap() calls to change the mm_struct.

Hmm, it sounds like a different perf factor? Otherwise, I still
don't understand how it impacts our decision of choosing between
mmap'd queue page and doing copy_from_user().

Thanks
Nicolin
