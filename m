Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DA6A350
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cSeLTpT2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHeoSZv711DjzxqBEOFgl0O3iHg9IfAfUZ/fa9TfNKsmB72WBCRPotzLQZHwqgHBHZx2v3v8nw3KuuEv3enbeOKNhEoax86nzS8w4mhAvROZ6Wfdd+sFwVN9mGG/NKUTCjF5EeTkb73vkcrNt3bv/8nMN+WuXTC++oA91v2r7VCK4VFQonEyQHrct/D8fn/1FC6sGYvmRthz9Gi2O51KLUbfK73vwFM+6lDLqywgtu2wLmPAI0/Eq1pAGUIdqqrYWoIPoHlpCYyuvZzdHq3mPWa9hP4bU4lv7ddFYW9bE8nJMfR6cTPJAVbUR/oP6xyAiBIhIHCZZpesU+w4xG3MAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL47X0zT1vWmU0nJ8o/+NSY4Lkp9xK2Z1yti5rS5qm0=;
 b=ZOuBkN5lNWJbRtKiLqcOacn0MlLcDhyUmz8LFZrvobpwKe1SSvX39S0IClUEy1Sm+QXRw2NRmzrcyPb7coDhgB0FP2+CJy7qOCXTrSGT8JTTsk2GDLw8D2Zjm3wMNqdMgm2zUFkTuO9J359bc8oV+JTbkOwoOfi/CZdItb+V3Ex8H45Q6uCe3Ks8siOwQ5hOKaNuppfjvTHd08S09LSLQI5iGKcl/nmyf/nLw208TZ7ENAvqY2pdkPCyJEBhSg184Z8fZm21Ohi9qCTLG4/5fhjtheaZrVZfymGIeG3t/dLW6jLwPPPPpAAEhVxmZcU8UbH5+SG/1EKd4ZN2H0g41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL47X0zT1vWmU0nJ8o/+NSY4Lkp9xK2Z1yti5rS5qm0=;
 b=cSeLTpT287oCUhGwRIiDGjizPt11TWqJTlaS1uGsJLJymHlQoG6sp9tj4WKL7pHCFs14yLy//p2ZHpCE/ET5NlaJWr5jUwNwaCgXgTyCpSuN0sLsgDvyp7Fvl1/RY5Fwy6B8h67/A4FBiph1Jgtlccy0qvhSns1rS4CRcgmuDKUDd7jhwBhCQoMM4zkhgB00og03sPcGZSJ0W8Z9InPEeJBSeHhbxQBiHupjN1fyL8kj/cngFMJC1y8c6gGWV+Ib35expNXYNSnufQ2VaQXZyqSVE9Y8fDs9llYUEpm/khb3Tx6xxsWxyD/TVdZrLyYB1OnmzTvJ9Qc0+rG9pVLh6A==
Received: from SA0PR11CA0153.namprd11.prod.outlook.com (2603:10b6:806:1bb::8)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:21:43 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::fc) by SA0PR11CA0153.outlook.office365.com
 (2603:10b6:806:1bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 18:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 18:21:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 10:21:20 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 10:21:20 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 10:21:19 -0800
Date: Tue, 5 Dec 2023 10:21:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY
 domain
Message-ID: <ZW9qHsORHC5obMLS@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <ZW6m54yS2rpk65kE@Asurada-Nvidia>
 <20231205143742.GB2787277@nvidia.com>
 <ZW9dJ1yzsdCjpMGm@Asurada-Nvidia>
 <20231205174219.GI2692119@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231205174219.GI2692119@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca42df6-1d00-4ebe-8c6b-08dbf5bf084b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lnZax5VTgfprQeP9Pp5Fdvzg9n6fNGBTmSd2OAb3YnbEzEekx/pPzJYL+Ctt45e9CGGjfpX/2jSXIDsSKNAzzU5LUTkdplhWgjyCDmJV515C48f3MY1eL8AFseXtab3F22irwGGaJyAq4OXjTn7e3gasrL31pmJ4x2kAX41aYYJj+3OVs3oFIJ5debDztiAWfsO4pZ34o4YnvgP/bjm88ol3zsZgXR2Uw8cL37Kl+0UQNkUezW/gPHvwdSf1vPRESRSubD7dA0B31qklKvgqFAVEwvZ6f71QFGCU4Klee92OBjUKA1/io/NoKmOW8Wx9IY632RlelJHg87s1gZtubLBXG+vUCfkbmuqPipbioBQ4VuNHwr5icXa2N7E8DSoGL6A3N2ABKpu1v0m6D4XQQcZ01pYhhdaBc0hyCdxCs+08dRsbtTm54iGnSrLARIHlS9oYpUng7hLzz17sZM3yIStbEGkQjpJi04OZRzzyyzIE5Wye22kOyEIi0REP92nrwjHKYsDpDYttmL/9uGxX2mSmPHi5zChOjn67bxmJTPfvcHKY4238gO7oAU+N/ylSROoKiOEcnlL7T4MeSnj72w5Z6ZuUDFNirI6eHKRqi1tG5VJhErhU5o4Xr4Ap7xdsmT/BA6Wsdo6dWOaeu1WmqZGb31U5gj0mdJyTNzEcMqiv9opAJ5vx6tisTbO1gee7hSgWlxzemrREtpSl2Rji5t431EYw3+euVeGNTslRhTctn4KNIquopdZEZlQh++7h
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(36860700001)(55016003)(40480700001)(9686003)(478600001)(54906003)(6636002)(356005)(70206006)(7636003)(70586007)(316002)(26005)(47076005)(83380400001)(6862004)(4326008)(8676002)(8936002)(336012)(426003)(82740400003)(5660300002)(2906002)(40460700003)(41300700001)(86362001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:21:42.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca42df6-1d00-4ebe-8c6b-08dbf5bf084b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589

On Tue, Dec 05, 2023 at 01:42:19PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 09:25:59AM -0800, Nicolin Chen wrote:
> > On Tue, Dec 05, 2023 at 10:37:42AM -0400, Jason Gunthorpe wrote:
> > > On Mon, Dec 04, 2023 at 08:28:23PM -0800, Nicolin Chen wrote:
> > > 
> > > > > +static int arm_smmu_attach_dev_ste(struct device *dev,
> > > > > +				   struct arm_smmu_ste *ste)
> > > > > +{
> > > > > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > > > +
> > > > > +	if (arm_smmu_master_sva_enabled(master))
> > > > > +		return -EBUSY;
> > > > > +
> > > > > +	/*
> > > > > +	 * Do not allow any ASID to be changed while are working on the STE,
> > > > > +	 * otherwise we could miss invalidations.
> > > > > +	 */
> > > > > +	mutex_lock(&arm_smmu_asid_lock);
> > > > > +
> > > > > +	/*
> > > > > +	 * The SMMU does not support enabling ATS with bypass/abort. When the
> > > > > +	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
> > > > > +	 * and Translated transactions are denied as though ATS is disabled for
> > > > > +	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
> > > > > +	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> > > > > +	 */
> > > > > +	arm_smmu_detach_dev(master);
> > > > > +
> > > > > +	arm_smmu_install_ste_for_dev(master, ste);
> > > > > +	mutex_unlock(&arm_smmu_asid_lock);
> > > > > +
> > > > > +	/*
> > > > > +	 * This has to be done after removing the master from the
> > > > > +	 * arm_smmu_domain->devices to avoid races updating the same context
> > > > > +	 * descriptor from arm_smmu_share_asid().
> > > > > +	 */
> > > > > +	if (master->cd_table.cdtab)
> > > > > +		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
> > > >  
> > > > This arm_smmu_write_ctx_desc was previously within the asid lock
> > > > protection, yet now it's moved out of that?
> > > 
> > > Yes, arm_smmu_write_ctx_desc() updates a CD table entry and that does
> > > not need ASID lock protection. The ASID lock exists because of the BTM
> > > code rewriting STEs asyncronously.
> > 
> > I see. Thanks for elaborating. For this patch
> 
> Actually wait, that explanation is not right..
> 
> The BTM code is changing the ASID which is done with a CD update
> 
> The ordering is OK here because the BTM code iterates over the
> &smmu_domain->devices list.
> 
> The arm_smmu_detach_dev() has removed the master from the devices list
> under a lock so the BTM code won't see this.
> 
> Thus there is no race between the arm_smmu_share_asid() flow and this
> code, indeed we've already removed the cdtable from the STE at this
> point.

I see. Maybe worth mentioning this in the comments above or commit
message?

Also, the arm_smmu_attach_dev_ste seems to be used by IDENTITY and
BLOCK domains only. This turns its nature to be a cleanup function
against a translate domain, while the naming sounds very generic.
I cannot think of any better name than this one, yet maybe we can
highlight this with a line of comments above the function?

Nicolin
