Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B968B61
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T/qhur1d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTMRTY7hqrqEV7jWUtlMSVSI6E5YK37kL0T03S9UrwC3kD9RMxJ7VkMJXLEtcPvAYlJWgeAw1v1PHF+IQxCae9ageOE1TbCi8YU4vKyvPKGzvKKISyY3WZ/bU1OpxBc4I7qKrsn+QRiwHi7v7asW6leZbn+xF5gXoMDzRo2vd7/4RnUEBXZ+Z9WfSBbmnjkETgVkZZ2R0kz2OYyqzx9jq/2QmOYmHad2liV5E+ufpM7bRt28aX5hEAQiT5ghA9+w8TLmof/S4hAkj6tJ49sOtLOvSXsz/Brnqt+ThSHk7neENQaWyoVcR9ZxWO5ajIMdLwp5Sveeo0giDh02lN556w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrA5ep6ivqCn3oqZvTs92JxcH/sEdtJMQux7t6eR2hY=;
 b=nZ6gsiNF2kdbWZji88/8aSvudAOMPfrcHqwVvYyrmOeFZU/YnBBIeNVhHjcWEOFrR9rdJ4BEKdvuWwf3vkky3cNJD+K3rFAEWR0DbOQBE94arXDtLtcq4yIn9mCZZX9v5apb9dV0wgPa+wMrhN3V0kxueBW1GgbGvYdvOOs1k1dYCzEa6BAY3SfS9My9NVrh60fgl58bdwxR+qBtxHg7CSni8qDGX+k932RGLBNy865x/O2HHjC/HwHqKwbRs8jQuqI3+2wmrqD6m14c9+JgfKOP3h7HEBELVuqoHdANFC+yqEQNSYnonSNr1aDScl2iRhe/tb6rSl0f9FD07MvobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrA5ep6ivqCn3oqZvTs92JxcH/sEdtJMQux7t6eR2hY=;
 b=T/qhur1dBrsncv7BTB85fYuBSuLoO8uq8pqtia2irLqxTGcCfTd+hqPAV94HASEwRCSBgS8ybWAS0qRuK3sR9zJazmlLbT6HujPZturzSSxmJyCNeLiEtMzkSVMfMtkqHjGcqcXQskcuj4cWnu9yOnnr550lXNVAj2k3GLfcGmKOA5FJsU7EOa/DTr5yYGeaAURY3UPGR7Sb7+rnMcFjmNK7k0RltrwnkGQUyYbOLJg+BYJh5OfGWEn+n7w3oNtAsmxUBTgcpaOqAY7WSOirXx4s0S9cQPaeatE1oGYMca4fMiz1XuKM7IZjy0VmeTUer4zDmmmtHTdw/8mmLl+Ctg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:42:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 17:42:20 +0000
Date: Tue, 5 Dec 2023 13:42:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY
 domain
Message-ID: <20231205174219.GI2692119@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <ZW6m54yS2rpk65kE@Asurada-Nvidia>
 <20231205143742.GB2787277@nvidia.com>
 <ZW9dJ1yzsdCjpMGm@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9dJ1yzsdCjpMGm@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b740b9-3dec-420c-4f66-08dbf5b9881c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vOCjXpFWN1hdPjt4zH/L9oDy9BC7fxfQBq+XDhgDKVKYBE2EyEu4bOdPYM2v4gRC6uDwX7wXlwf4O5K4Xh9VN1o0DSKdvHYl5E0GihY4B+GbxVt+Br69iDqd5s0XC5S3KiYRUeeXSzZo0hsHSq0N+wcR8F31QVqaUgm4jCEj0MvPfG1kNCwre/fvmpzLJuO5iv7Y0EzC4XuolM6ObaoueOte1nF847/FbffcDIla9qyl3LkLqNGePxvYR8MH9BVNKmfmoWy79DGeweYgyWAo7B8gDySu8Pvj/9optF9+xeegkXbsLT5bJokrDPOvCLj7J1ek+MfT3i+4O8+ukd5HntsZUZ80Vh4dUl0JSTrAM5fdnaoDS1/FZJR/Y8SerEwIGe7Qvwb5KqpsDrGTueRN9hq8daLEKQkshGlmXi6ZE4V0Nea/ttMDUMwJLO5MTiHh7sCi0tnSJG+15XhoFX33a+A5COV3fQ/B7G3A25ICRFFHwsyOnSDf1F7z6eUVyl3lN1/MfqUw8ls73dZZ2PvTV6C6LQ4pxMFyjeKmug8rqsH6hpOUTpCgzisRPfd8AssM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6636002)(478600001)(6512007)(6506007)(8936002)(2616005)(6486002)(26005)(1076003)(54906003)(66476007)(37006003)(66556008)(66946007)(4326008)(6862004)(8676002)(316002)(83380400001)(38100700002)(33656002)(36756003)(2906002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrIZiHgWtRfPuUws3MCbas9txAH4OpPWXAT7T9P+OQ1Zxav8aaNaF/hepp7n?=
 =?us-ascii?Q?R2yW/hsYVY+uO0oAotx68ZYGG3P3LR6XPNQLI/XRXdi2SVRb9/5k9W1pqzFW?=
 =?us-ascii?Q?+x446kDSP225nZSgsS4iQacMVc/LzH96/ZImsfqIRBOqN8PAHWnK0mxYjV5B?=
 =?us-ascii?Q?QG67TwclLWTiV25Mh6ZnHc9jrw9zqMZ4hA7ME6Vjtgy5/kdEqTEKjQe/ghkL?=
 =?us-ascii?Q?4HN/2YbFSZtDC2dm0PFVkV4QkTNfSARRLYlyM3GwYb8gw24XGajEs7L1OBLi?=
 =?us-ascii?Q?0Rnw8/lEzzjFYFohObVKV/cNyRvyyaZs+g0SH8CXmcodvmbwE2rKaaL8PPY8?=
 =?us-ascii?Q?voA90Oluf2lXOaviKquA4f4lRnYhglaWU56KxMxr5J9v8Tmz1LF4iAMZx3Iv?=
 =?us-ascii?Q?zQ8THHhP9vmt8nFuRzrlvT46RrK1K/kwJKr6VxYghHtxYhBOATWBl2dxPj5m?=
 =?us-ascii?Q?tnrFGLu3kYVUfHy2cS7XCp4E0gFwQk1x1sbgq0iq93r0dqRKwzqW2W20ObxY?=
 =?us-ascii?Q?o5JAOY6Iqlv4lJwLzEDoC3wRrv8ZQZqS6dqEoz1BZ1dvaiFAB6YNNNMjIEPr?=
 =?us-ascii?Q?9c7oc/niI4nf7l4NkdVhln5ejYEFrWbVTljmq0Abuo2FPbwTlgdNvuuKYB5T?=
 =?us-ascii?Q?A4TcLcbGhTWfMRjcndIM6WHsbeigIcbD2wqtj9E3XFNOO13crBP2HC2LTkhB?=
 =?us-ascii?Q?neQfr7MF/CvIXwRzTzK0b1vuAaYJHMP2ADL/wmT7KsUU9qUGW7Bk5O5sId3S?=
 =?us-ascii?Q?wypWxlLOYQndlokDOXc91l853RRRPxpc7u1M9tpSIdX9pnumRrT0DxPkc8OQ?=
 =?us-ascii?Q?1iGCTSlD/z1Qot1HaGe2jw+7Mq9XHc41vFm+kzne82H0S4+dF4e+4wIIKABe?=
 =?us-ascii?Q?IrDVReis5KXfalKHSE0FBECWOVpV4YNthU3n8AxUCwvKuR9pSU5+KQxU7c/U?=
 =?us-ascii?Q?uzy8pUl2ICYc/JQ2bTUhnrxKx+z1oYN5TZrUj5RrvT71nhyo8Q7KWiyXE8p+?=
 =?us-ascii?Q?wrtz9n2uPpghmHjagCcBTUiLIhqv1uJceCRS3PzyJCWdOUjlD/iSLy4ZdCt7?=
 =?us-ascii?Q?845l1eBydgT0S+3qebM3zEiHTA2wvjxkaHJeWrklQmTBp32sp/cxsqkutdIo?=
 =?us-ascii?Q?R+3LVcdNE/KG0rq0+/CWmOT70FWG4uRCQ6uBaEP+FnCc+S3ZwY8suvwRvReX?=
 =?us-ascii?Q?MOfp341fEMt7C88D9o8wcHyXP7SogpMzunkRfUt0biGB7znn2cuzs9bebfSl?=
 =?us-ascii?Q?dz1otL2U9GuKFioetwk1+yZ54nTC++VxhXgNlHBMP8T9Eq0Ym6t1QNl2axa5?=
 =?us-ascii?Q?QxkvtwiZUyKK72rCMjXvvCnB/yWVSwsCot+2ZpFL71kIJk9TriEt8UHUU97Z?=
 =?us-ascii?Q?4CUh5la+GyRpoYfWpFbUjBLtWIkfR/InnZ5lsyBea1icxte6spDfuFOVEmZc?=
 =?us-ascii?Q?C9OxUvlYopCrN7FWbNYLUyxAn56ukhfmWR790h0NZA6hGQhCeQ2czvcA59i4?=
 =?us-ascii?Q?wtiKqPgaT/O8BR5zTh+1DYNdNqxrwr3DAvDdM7+unpgUuBuljd1jfUIKeyeb?=
 =?us-ascii?Q?1DBYh+DYOfGBTO/682cvKLdRwMEsUEbC9/6RiTeJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b740b9-3dec-420c-4f66-08dbf5b9881c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:42:20.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7TnkWnwItnvl4B/5nEwKxQrPqGuEcDgBW2472llOuCkcmuTvBftx/ixa9NQw3cq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

On Tue, Dec 05, 2023 at 09:25:59AM -0800, Nicolin Chen wrote:
> On Tue, Dec 05, 2023 at 10:37:42AM -0400, Jason Gunthorpe wrote:
> > On Mon, Dec 04, 2023 at 08:28:23PM -0800, Nicolin Chen wrote:
> > 
> > > > +static int arm_smmu_attach_dev_ste(struct device *dev,
> > > > +				   struct arm_smmu_ste *ste)
> > > > +{
> > > > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > > +
> > > > +	if (arm_smmu_master_sva_enabled(master))
> > > > +		return -EBUSY;
> > > > +
> > > > +	/*
> > > > +	 * Do not allow any ASID to be changed while are working on the STE,
> > > > +	 * otherwise we could miss invalidations.
> > > > +	 */
> > > > +	mutex_lock(&arm_smmu_asid_lock);
> > > > +
> > > > +	/*
> > > > +	 * The SMMU does not support enabling ATS with bypass/abort. When the
> > > > +	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
> > > > +	 * and Translated transactions are denied as though ATS is disabled for
> > > > +	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
> > > > +	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> > > > +	 */
> > > > +	arm_smmu_detach_dev(master);
> > > > +
> > > > +	arm_smmu_install_ste_for_dev(master, ste);
> > > > +	mutex_unlock(&arm_smmu_asid_lock);
> > > > +
> > > > +	/*
> > > > +	 * This has to be done after removing the master from the
> > > > +	 * arm_smmu_domain->devices to avoid races updating the same context
> > > > +	 * descriptor from arm_smmu_share_asid().
> > > > +	 */
> > > > +	if (master->cd_table.cdtab)
> > > > +		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
> > >  
> > > This arm_smmu_write_ctx_desc was previously within the asid lock
> > > protection, yet now it's moved out of that?
> > 
> > Yes, arm_smmu_write_ctx_desc() updates a CD table entry and that does
> > not need ASID lock protection. The ASID lock exists because of the BTM
> > code rewriting STEs asyncronously.
> 
> I see. Thanks for elaborating. For this patch

Actually wait, that explanation is not right..

The BTM code is changing the ASID which is done with a CD update

The ordering is OK here because the BTM code iterates over the
&smmu_domain->devices list.

The arm_smmu_detach_dev() has removed the master from the devices list
under a lock so the BTM code won't see this.

Thus there is no race between the arm_smmu_share_asid() flow and this
code, indeed we've already removed the cdtable from the STE at this
point.

Jason
