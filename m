Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5B1EA77
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5g1ACEI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwqwKm/BhuUh0aKlxXYI618xJuOH1OkB7yIB2fk1LH9bXx06oALmmEBmLZHAVlSInPKMsREEbYYK2AL9XqOuHUG/6a9XoteM+fhAh9FTdvsH/KN6zi5JJ9ty46PJ3YYQ6qNepX0n0qX42snp3HM/9uBxyWPP4yzFqDzi4D2wMCL45Dw4CGtTlT+8WZo1BQueZ3fVgxk4onur/oJpPN+TEESLQ37LbYImBPmOoFL9MRwdDXzVBSr7HK+TuXjGMRKrLbtN3Li6lBsksk2TIzAo3+oWHzRD5lr76TuLNaLpZhpOfQssVSf4VUufhdB3Kdqv5afERADejRmiAFg+7xBylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zapg6dMHcfIChdyX3CrLp5DDb1omTh8LNiF/iSgDaT8=;
 b=ljeURBYAz13/yY50uMtOXWOFGtw8S2RYbsRowJlFCKHte42BpaVRoJpsx9sBl32K0YplTcTSvGfhEbqabPdFuftJOa70yKYso6+xgMhkR+hNwpQzK8ZOHxPzPUBN0JxgfhZltzv/0Oqwa0Nz79vwfQVd+VJmg+CrOFzqV7APRx+GH0Hvp05Q1qp4Vu553I1mU4V1EbxpF5JNNg/qHa3saFcibUNSkLBMfiuy0EhHxjZlykVqy9Ql3QZkxVtcHN/77W965I3A8mciztsPZub0aJ/eWJfuCZL05vR33NGNq1LrLNtMwbD2Z+SHoT9Cqeo0qZRipaZ4/8Lax8Sh9OyrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zapg6dMHcfIChdyX3CrLp5DDb1omTh8LNiF/iSgDaT8=;
 b=N5g1ACEI/EedplJbCkpp49b5I45atGgKaF6WsNY5IMGvjWG2Ic4cnxzElJn+tWFU5xRW42giTPBBaINRT69wxnfM/phtVqs06bs1ReGOXVSmMGEwItgebB5YQtH2XJGtwCoc2u6xQEpQozczN9wMyQRyqXxE4xwdIbv0irBM5geNY2odD5RlZMCI9I0Nywzd3pSEJTIZEue7hLEhpX4EU8bmoqdxiaPh5FAoH1O5cr6VJUKC3DxwRIQp+AFwknGz/YD4eVUxyxGTbFDQQftU9Qor1VT55+fGFQ6Xx2vRKNhk5pYJU8xewW9JIdVwnBp7w0miqp+35Apz6+DDrqRVLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 13:35:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 13:35:37 +0000
Date: Wed, 15 Nov 2023 09:35:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: Moritz Fischer <mdf@kernel.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
Message-ID: <ZVTJKHeP+cNN5wJU@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <ZVONEV2wtAMQp3-Q@archbook>
 <CAKHBV27XX4QM1PiV5FxKBeeiKxUN1GrDFr2y4uRN=ijp9cnxRg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV27XX4QM1PiV5FxKBeeiKxUN1GrDFr2y4uRN=ijp9cnxRg@mail.gmail.com>
X-ClientProxiedBy: BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: c446ec72-82ac-404a-8e75-08dbe5dfc063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mApozVIUIp8gT7EnyvBizaEvQThbiCp0jEMvpZIh131hrEgNjK1Bz+wKt4OVqF4huwWJFcGlg2kquZoyRyvu78WmXDtJ5qEv9k4vZCZoxi1X6b9sxO8fknBIexLSizW20xyr8fZTKGqFpr1XjIxyglKaOsqwZweiAVTgj8qYa4zu9Zya4Bb2epFhUGaDm/lksw4MCrMv7J5Sgo8RRi19XkaUM9EE98e2vCHPFw4QR6OQtVPWGmi6mmC3w3NEbXOXxpGlNNpu3QmxDY2AMpW2R2p3x0ZNciydf5EUn6Voo5ON5GG9fpoi7BSBSq2mvPDh/v1plTpYMf0bTMBkhH/2f33G90cLjxZ1J9dF90VlHRmvC2jbfrmB4IGcFyX1NkbJmrA8WWaGkT+6C5mRFmK6h0Z1vnzWsg5JTovxOfzfbhruwIS5dv6eU+nV/cdltaZj9HBvVC6HOVo7xkfr/MwJ3aZCbt3kgrUvUeQd+Z8UCmrijfgKh+atpgFfQEIzRdsvNtY0EiM9DHE9oD5gXSNUhbJzzPMrrMgO2phS8tL1cT28t5NWzgPByzIDC4FAzqszLn7n6lZKBVQOJZBYg5qE+EknNvYDO9UojGFu5rM4PLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6916009)(66556008)(54906003)(8676002)(66476007)(4326008)(66946007)(316002)(8936002)(478600001)(36756003)(6486002)(41300700001)(86362001)(5660300002)(4744005)(2906002)(38100700002)(2616005)(26005)(6512007)(83380400001)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlKjYjv31PLxJL7iv7EAoyapF6k6Xwsp1Lf6LnhjdT5yuCfgCc73TmU2yHKu?=
 =?us-ascii?Q?yAGCc4W0wvzkltgg3Gih/La7oyUPLp88PI2ydX5dSG5JH4+5CgvB+RdxQspI?=
 =?us-ascii?Q?N/PL0kxGzf+zWfeEzTiRJbWgUDXxoXkVDVm75+PWFgKIhRCyj+oqWMv+Sclg?=
 =?us-ascii?Q?S79zOSmX6TXc2V/gqyW/Pxh6PJyCQe0KWK0qb1C0+Pr4J6ccU1TlhEHh38Fw?=
 =?us-ascii?Q?MKpJLzsmK4+Qz1LicRo453kubE3/HF+t5tGGxenoDztiAPPMTMZSlWMrYE+8?=
 =?us-ascii?Q?dvQfwnCaMq5DhrvOVOqfrWwyF5EMM2n0ySXmjA/gqWM3HZB6mV2BU9+9+H6n?=
 =?us-ascii?Q?fkn++uHdSMKUDQgCfwNPK7gFoGKYYOfUYcn/PTNEwOHmXZ6JIpCOjkZVhkjY?=
 =?us-ascii?Q?1MOX6RLV+qJEqeqzTnceobqUZ7HUMo9Vab4mOqrFBNeg8dZ8qdOHgt1AdEZ8?=
 =?us-ascii?Q?3t7EGZvTdQYgxhdi1+E9mvAu/+oNcyz1jOTrArPXusTBnd5ptcAd+Dq6eeXn?=
 =?us-ascii?Q?Fk0tnHanxcStggjaAtJW88U/thFpCcjZP8lyYdVyeiXqkdxnn72MYKO4/J3K?=
 =?us-ascii?Q?tuZ8FFpyL934qR1QbiD45fCAfz7gvDn+fza21j0K/su5Ij8MEM+HpMJM3K/X?=
 =?us-ascii?Q?G5sSsfZDBNe01UYzYtNA8JVQmgVJAOtpYd25OJOITFLEaQKzkdJ2589XK0Hc?=
 =?us-ascii?Q?Hg//CjlDalO3Q6Rks3eqmUL5IMdWwqZcWZGDACvSO9Fd3gVFgtjqdW44ML0F?=
 =?us-ascii?Q?8/rMK4IQglleVOVJypquWJ9wpvtd1dt4rfQ0dgN8r6LFgInxsVS/4KgmfxKF?=
 =?us-ascii?Q?jRuLFuExmX/O45RVAaksZuy1P/Z11ExRSeNg+zSr4ppfHEoLRfZWuUUPTwxv?=
 =?us-ascii?Q?lO4Ql9amGRPBWrOvPbGG23f+3oGmgwQBfRK6C7dC9JYF9spf8c1NFw81KQpf?=
 =?us-ascii?Q?VGT9Q9GScyB9N+nDzvv7vFsKmVjvnqig2GcvSetUyBaqBkm1WUrpnnqmIji7?=
 =?us-ascii?Q?4BHWFCQ+kk1XJrEIqpE/anOh+RBm9WNpzvzWkPitzUKQM/lTfvJiq0m2YUCj?=
 =?us-ascii?Q?IxQgAsGscbE/3h1snkCFrTREcAXuRC54V/uX72Qx2P4pH9lQiHB2iHyRqgF1?=
 =?us-ascii?Q?j1yOGdLHTP7b4umhIIWCGPOA3ejEO1GV21kv4bY5O5p2HyXDso2XOUO+kCuS?=
 =?us-ascii?Q?Uss7/NjXx6i7Pt38Yib9UBb5EU17bAzMa+qJOar3w0sucOus0D6k64koroCU?=
 =?us-ascii?Q?nWFNBm82AsFJbm/OhuAAJr9U7HCBjcuR6qvFibTjFYK8skpQAFGJFiXhkqPt?=
 =?us-ascii?Q?s/3cWLGKo6zWv1JPtAsTZFfzWrxXwyYyoncwdPmXvVvXTW+baSf25GU9qs2v?=
 =?us-ascii?Q?X+n/rT9utiXwEdh+O1pHMwBm3MXKXy42UCoQr7gxLgrU5LiP40PiKZX6JNoj?=
 =?us-ascii?Q?IffMdJW9al9SPmOhUk2rD9vWoVqIejYCKFcHiDgz1qakv7r74PFScTQKCy6b?=
 =?us-ascii?Q?3VUKiy1a5Tj7wcp1UPrjKpOR7z1MFJlNbDMt0s+cY+jyg87qEB6bikcFl6sd?=
 =?us-ascii?Q?qc1li5jBux0qUpyWPso=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c446ec72-82ac-404a-8e75-08dbe5dfc063
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 13:35:37.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zc51ElI9GntBSToT1+DgRrF0OtWhSMS3it6oWE0SBDEh7ppdoLrJCsQnqRA2K1J8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674

On Wed, Nov 15, 2023 at 07:52:17PM +0800, Michael Shavit wrote:

> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > index 961205ba86d25d..03f9e526cbd92f 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > @@ -206,6 +206,11 @@
> > >  #define STRTAB_L1_DESC_L2PTR_MASK    GENMASK_ULL(51, 6)
> > >
> > >  #define STRTAB_STE_DWORDS            8
> > > +
> > > +struct arm_smmu_ste {
> > > +     __le64 data[STRTAB_STE_DWORDS];
> > > +};
> > > +
> 
> nit: This looks out of place at this location compared to the rest of
> the file. All of the other structs are defined after this large block
> of #defines.

The struct follows the defines that specify how to parse its content,
which is pretty normal

Thanks,
Jason
