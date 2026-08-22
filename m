Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58D13FEE
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787422364; cv=fail; b=Dh1co5+IbdSDeaVCHjgr3PUuDzzLQvU9sZ6d+dsvVwxzGlPysheXqBnOY+UC89cjLQrxq13Y3a7bGOKyYnwX7HBQR9mfT3fgZ15vnSMcOFt0wictWC7SNSctd48yY6dIqwznUwGpnMFV+CK5gYcPhyvFw/mlHj8O+n0AqFGbsQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787422364; c=relaxed/simple;
	bh=yOAlotUX7FBbYRP69fylNEBQWFhEA3ZnZb0M3fUmSgM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPEGERGoY0zNsh+1ICwiv7O652pDbIzyhGyFHQteVh4EruQBZ58lXccRktV4RXepHzekyS1gkLC7bFVjua8+E1OqElBoBgvzIWDbTlaUoiz4W/cKeIUI5ij/J0UEX5InlRxYrB1Fh3NoyRujwRhZpAk6qMsst2S6uL7pdbgc6kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HKXKmnPt; arc=fail smtp.client-ip=40.107.208.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HKXKmnPt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ1m/KzG7xoEghfLfNZ4wUwbs5lnDIF8nCi/zzPh0iQdQgptwCGGyRgAOtIggeIerpldTfqVcEY2TVlDcQNH13lg4/F5Mcc0vXm//MTktxTgzOGpQiu2SuWcwNFz4uyLR7mOgHIcuEUGGR0lTFZHa7DEtgyRHSix9LafVllcPG1HZ33rfdVir+ypviBPaz4s7rYNGiWOYYS6oxGfZ7RIGc2Ikfy/xbtiL8WBhHRA9sQUJcm4IFw+4O29UtCEKlJEFtr3NWPHpnWZOwJxX7jN4Wtyf1Z7zASSLmuTFw4BgxX3YzCum1YnhPyRlHdd4yQpB6oGEia8qQvZ3eENiExvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x0V8y7AtTqO+N9yrnBcjanzCtGg0yM/mYBEKDfCal0=;
 b=u8cuOIUsw8uVWctKkmKzRVWgYv+5T+9dzGmeG756j456qGauoSwljRnW1a7TC6Tuf5w3FiEh4y3unIxQFJWEB0v5nNMQRvIUYWsP+MWWQOO/v5IxfGAVPp5Az1mRmHMqxky/bBYbTlA1NimScT1R5QPCv2hqe1V/is0GN652kS3Wnp3WfsJPY3K937ooYuXNw7F57Tt/Cj5ny0xktkKwp5rkqXSldU86LtFpq6GNjng+oE90wbZL7DxFiXG4TwK3N77F4/McUA488WyU99GJflu7A7zIbZqmJQcv0aiaf8iMIqJ5PgomQtgFUi79M/Xi0RuzsplciCV3GlpJH2DF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x0V8y7AtTqO+N9yrnBcjanzCtGg0yM/mYBEKDfCal0=;
 b=HKXKmnPtOdK7QFZv6lj2olftA9Gw1e5l1nvL/sF0U+5ZHWJN0Q8p8n8IdLX6OPu3C9zRqO6d6V70HPTy08PGRhUTfhJGoiOmhuVE9lo2WP/aBBWUVPsf+x6oT/9mFtP2doRDlz+c4ZnMOsAXWIFEHgGxQZcTq1mevN+mCCJtBBPWMRRz9KlxdGhnQd7oYm3lqAG6PtcnLvfAz9Beu4ymSWMsqjGHYq+DsF8iFo8klw39yabA8gumzW1wnWo9sBGNB1uoDdOGtrBMzLDMKkf1eoz/CVsA1GCQLQ2RidQrcryGV7oHThAxdg7ojQ5+ivUl2Ddty2h+7JY4ru6KI+SOEw==
Received: from DS1PR04CA0021.namprd04.prod.outlook.com (2603:10b6:8:243::16)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 18:12:36 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:8:243:cafe::86) by DS1PR04CA0021.outlook.office365.com
 (2603:10b6:8:243::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 18:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 18:12:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 11:12:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 22 Aug 2026 11:12:19 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Sat, 22 Aug 2026 11:12:17 -0700
Date: Sat, 22 Aug 2026 11:12:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v9 01/12] iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ
 interrupts in kdump kernel
Message-ID: <aonmf/mKFhBDca5D@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <35000f29472b5e12114073d614168c251551ff0a.1784663184.git.nicolinc@nvidia.com>
 <178735412597.18212.9285735691655908532.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178735412597.18212.9285735691655908532.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f7a0a5-5512-47f6-b7ff-08df0078f1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QGf3cK83eg5oUXslpX6NkJDGUv5JTTMKJ+nFD4nazqFEF0Y4A1HIOe8f0+fSS3w/LfuDISiIy4ZTNfdf+sqLOGrvJnRfj2CO9MOvDLOxMWBIYIvtGu9c05L3Oqs3FTQEdkg6F+T7NA/F1KJDwvSkD5WdVx5oWNAmmCYndPRIa53voHZ3FjumxiPHJkiZKMMPurLmy1iDAr9q6goyLm9FrxfZo/nbF40RqtcwoqiHlSw4K24UKNaA39c75rXFrfxJE3lUdXEi8LNkuYF6QuU4fmGHzmg9cyVe8rJXX4KmpMFKgmzl6Bw+jjXZvjTxuO59w5WOF5PfeJYo1msJhhTuL+sNEnZGWnTlg0RheZC/7q50UfM9DFqT3Vr3ONLm444nc4ul3yxNZYsJAHJJ3TIton8PRkrSR+WpBREG1412+NFfhG6GVJKSOp7GKynHQuK1EPBn4iJhUVXRLIoqx1DeaFPNWFAH4fbtkle+7jXTquohpzXBvAf+6fNaB7xuCNqd6VlgBUXn4eliPhgfkZj1oVck/ZCeFT+RFrdH1rSzIegniT7sAWKb+pJzABfsnor4n6Zs8i5CcxtCEZTN0L9dydit1EB0x0/+7D8SklGVzLNGpJiDP6cCxvk3lv/6od+AY9Hvxe94q9j8Pxr1/iVnTgpH9Yn20kLGvlRxnChP7LqtBIhTlhejbjaxhL6c7aLPaBOOzlefn4/Ry49oNHYPzw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s64udPM9QJlGpmRh7OEVc0X9GFYoGQkneRrhBgUNQoaUV10wU7eVulAXwr1su7xOMdqiKqI+B3unKi/Dyz3lBOxOwAj0Rzspzs3Y6fbwzmLkO5Xlw9EM4hr/cKwBxWtuz0x0LLT0AE+ZyIZkrCHUyXMEDDRKjZ+MilzbTQXY2pERjJBdKAfNdcq0qNs0tWXu5k5ZLlYUf7ZKaYxYCa8D4JzGnob9C6pVhoiTnQPm+W3H8JWJPqRqQRx6aHKXWD9PnU+NyjivMitrMnjq8cN5p/VKG/HwM/p48rsjS6rUZ/5Nb0UJQl3Gf9+d4UOERXsQFbGIAw7ENBO2VFV6jMPGULnNBz8qp0v02FTh9K/stk8cjrwrA4cVbnXFKjYyG+slye+AIZYV03DawZS3vKSfByaXG01sKF9HH+RVmp8DVh4JGkqfqh08timz3mGU+J4v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 18:12:35.9636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f7a0a5-5512-47f6-b7ff-08df0078f1aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642

On Fri, Aug 21, 2026 at 08:15:25PM -0300, Jason Gunthorpe wrote:
> >  static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
> >  {
> > -	arm_smmu_gerror_handler(irq, dev);
> > +	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
> > +
> > +	/* In kdump, EVTQ/PRIQ are disabled and there is no thread to wake */
> > +	if (is_kdump_kernel())
> > +		return ret;
> >  	return IRQ_WAKE_THREAD;
> 
> To Robin's earlier point, how about some ARM_SMMU_FEAT_EVTQ ? We already have
> ARM_SMMU_FEAT_PRI. Unset these by kdump instead of sprinkling kdump things
> everywhere?
> 
> I'm not especially kean on these kdump annotations as a long term
> maintainability, but having a FEAT to protect a well defined area of
> functionality seems more understandable long term.

I've added a new patch adding ARM_SMMU_FEAT_EVTQ.

> > +> @@ -4682,19 +4691,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> >  		/*
> >  		 * Cavium ThunderX2 implementation doesn't support unique irq
> >  		 * lines. Use a single irq line for all the SMMUv3 interrupts.
> > +		 *
> > +		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
> >  		 */
> 
> Why? I mean I get we might not need a threaded IRQ handler without PRI, but is
> there a reason kdump would not want to create one anyhow?

In kdump case, only GERROR is left. So, I thought it could match
the non-combined case.

But it's probably okay to remain to be threaded. Also, since we
gate interrupts with the FEAT_PRIQ and FEAT_EVTQ in the combined
handler, it makes things here cleaner.

Thanks
Nicolin
