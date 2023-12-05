Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A16928C
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZCPIy9uR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGNBoaRF5BpthO0oAuWRecZqwd8DFPCedxMvQcfViLLNX6covLMQBWwbh1oRNJ856XIM6y+JyLm8qx8lJsBpHMFsVyvBi/iY6zianLD5lUA63dZgY3am9EoIFL3BYkRPSyV3uX3YmbmX+ubeTRicPB2RXJole+Mv7YwJaUnZRBrKual7RrJWpPp4AGIGKImmBEl3Ia5FEFgkPwGywEnnEDvvc6xJ1uODzprPY01AHPlo6tOxGQL5mwbPJehvzOOIFBZwgHl3w4a+F1GwXGExvSVVMhb9oMKcfh9WbYoES95do551IUvhQGBB3oXOm4TUYRjBrhmnaPqhZKhtM9vNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NsqH25OOBWhuY10fHnZxyx5vLalu9Kp6rFDXC4DdgI=;
 b=hZMYD35vc24/lIRbYAeXsJ7K9hpBJ/L760WjDB+UAG6tr4HE+C4pbfAiWZVZ1UT8YloNWtFLw1mSaNm3a8FE7fBsb76Rk4dt9nZG7Gc75EKBiERrzyttMO9SyoN7coUNwmoD9/rusjPswQcxxNQXYoKKn9jwmM1oAq4NYR+wB5FF+UHojVQp9s5Km2qGgN0jj1xrNOs1EcXCN+/ev3nLbHD0zV85lD2oHMAF8K8s27+GEnMjLJRrSHjU+o8nKnLfL0HZoc42u1oVrNdFavH4OqUwRVvJP1b7q0yXcmWJIRrxNysEsIjPHcK5UKBeXonmJyJid370oCj5xaAvF5al6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NsqH25OOBWhuY10fHnZxyx5vLalu9Kp6rFDXC4DdgI=;
 b=ZCPIy9uRu43C9/8wxt7ONzbkUQYdFZfU5AdJtU8cFQOPT7iUGBZ3mZg+nH9+wPzFRRok3rLhAndts0q8Y6lSoPtn0D95Uby6urXNmTB9HZojN8jgwE4bdZeVdkn5xx7ayvHRcBYCPcGHBcXaM5uY2Zj0fkBVXm8HxFWeDE2p+/REoAb1AbN9+vDSk4NZ7Ntpt5QwpqMxO8SFlz4pvOpaSL0TdJiftmroCWCql18haYKnYgEKAm8mK3WUpPURBIqTMNxKlEOEUPqYV/7KXK/2FRI0Jj+3W6ISrrZg4tvqC3NCc9avur2ZZ82tyd655077HUC4EjofGPDcdwRWv3pICA==
Received: from MN2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:208:1b4::37)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:26:18 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::fc) by MN2PR15CA0024.outlook.office365.com
 (2603:10b6:208:1b4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21 via Frontend
 Transport; Tue, 5 Dec 2023 17:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 17:26:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 09:26:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 09:26:01 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 09:26:00 -0800
Date: Tue, 5 Dec 2023 09:25:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY
 domain
Message-ID: <ZW9dJ1yzsdCjpMGm@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <ZW6m54yS2rpk65kE@Asurada-Nvidia>
 <20231205143742.GB2787277@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231205143742.GB2787277@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 70af86b6-7552-4bf0-8634-08dbf5b74a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9sW16WfQGAjwgnizDtiizRkWdpkvYpJ4c47bkmH2vro8qC/QGjCWbXU3s+GfhVtiHCswNYG+BDBhhFcKitHYb0K4LKsfv5o5Oc9XMQ665zKOKaac+oYK4exx989W953riMPTtxIlLhQWd9Z5PlOPE4kHo+0Msh6e/G2HkqwiqwAJL8sZl6wfGFwd62EpAildqbxLidEEFrq02fdhlVZBhgIBTiyx2bIanfYGmCnfYiHy5FLRgLIv6fVLGsyEC0OhvP/vQYVvkp2xB/nZzmzHzr/7fRJnSGpxeE5mqK/0IWiio7+nsqtxhhogVCBDsWDN29OGMcJsxH3eH4HGrWC3QDukpVuDwLD7AHa+lbi0KoHLvRzD13tUTcEd/zm0z0yBYSyqskYDWtdTqSyVCFRIO6oRCcLl0L0r9mpwnfN0HhJv2AfiXG/hP5iz6ylmf92sIxuiVsNQSk65+c38ApGBKkah9acXM75RamnJ6dsPqZF2O3MowgyuNGwWokI7A/cUuTfTfsnXZvxkeRE0ACUGPeeNxbUNNyyC2h5Nphej4Y0aj8OhQn7GbuWYALjp6KX4BTDskJcB+1qXSPn4uZnISRhsNNmiYbrdlnEX8kOn/r0ZKuDertLw+PJPyQULSG5QMYcbpC+euClrCXIoL6j9Kc+/jwzJttdm2ayBXd6B3XLLvptJJdlxxTQKQ3AdgL21vGQ3shsAS3nXZr29inKDSFbC9vplC9VXx61TzIOgnrQB9sDA1W3Mdyc7Vg4lyZtZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(26005)(40480700001)(82740400003)(55016003)(7636003)(356005)(83380400001)(426003)(336012)(36860700001)(47076005)(41300700001)(9686003)(40460700003)(33716001)(2906002)(86362001)(70206006)(54906003)(70586007)(5660300002)(6636002)(316002)(8936002)(478600001)(8676002)(6862004)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:26:18.0159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70af86b6-7552-4bf0-8634-08dbf5b74a95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

On Tue, Dec 05, 2023 at 10:37:42AM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 04, 2023 at 08:28:23PM -0800, Nicolin Chen wrote:
> 
> > > +static int arm_smmu_attach_dev_ste(struct device *dev,
> > > +				   struct arm_smmu_ste *ste)
> > > +{
> > > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > +
> > > +	if (arm_smmu_master_sva_enabled(master))
> > > +		return -EBUSY;
> > > +
> > > +	/*
> > > +	 * Do not allow any ASID to be changed while are working on the STE,
> > > +	 * otherwise we could miss invalidations.
> > > +	 */
> > > +	mutex_lock(&arm_smmu_asid_lock);
> > > +
> > > +	/*
> > > +	 * The SMMU does not support enabling ATS with bypass/abort. When the
> > > +	 * STE is in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests
> > > +	 * and Translated transactions are denied as though ATS is disabled for
> > > +	 * the stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
> > > +	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> > > +	 */
> > > +	arm_smmu_detach_dev(master);
> > > +
> > > +	arm_smmu_install_ste_for_dev(master, ste);
> > > +	mutex_unlock(&arm_smmu_asid_lock);
> > > +
> > > +	/*
> > > +	 * This has to be done after removing the master from the
> > > +	 * arm_smmu_domain->devices to avoid races updating the same context
> > > +	 * descriptor from arm_smmu_share_asid().
> > > +	 */
> > > +	if (master->cd_table.cdtab)
> > > +		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
> >  
> > This arm_smmu_write_ctx_desc was previously within the asid lock
> > protection, yet now it's moved out of that?
> 
> Yes, arm_smmu_write_ctx_desc() updates a CD table entry and that does
> not need ASID lock protection. The ASID lock exists because of the BTM
> code rewriting STEs asyncronously.

I see. Thanks for elaborating. For this patch:

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
