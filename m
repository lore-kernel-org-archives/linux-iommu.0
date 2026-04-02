Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191883D6CBA
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131869; cv=fail; b=cSzd/v6YT/9kwrrHScOzpdB+m98LTeW8gb67y62sVoZ4jBj/Mh4V3TX/eV0LCjqbusoKtXLzgT8hXByIzKNzE40FrAW1oYPTLqnh6PXFHVPfO8kRZIzxDhoeZK6YySMSQpZAqFCxjTG6oQvhdsYafAh2NOIIhSsZMqg9lZ+2Bhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131869; c=relaxed/simple;
	bh=oj9xNsn68faSd4s3tk+b4Ql14gsetukKKTK0+oJKNZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=curKJ4BEqm9LzK5R0ATmiDSkcXAhtvpkQZ0lZEpqAziSp257uFKLcaS95nkMoSkiuQkcGeBQ2RFdD8zioEM82bGygH6Uk5ad2NrVMN9EDJONojeRM5JmaGDepbYxmqKrtywZqkmTrXoRUnkljMg4AurPLLr4epcpdRwwSgo03B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=roBlU7CE; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="roBlU7CE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuPgwULsq/3+tKVq74yu7OxqeYRTL2b89cndXOEBEhYyG4Np5wQmYhnj5ZM5/TSuSFxDSeOLhFJAnV2ezMZCEzbndh3Pmgp0VaoVsET5m8cChUr2nSDQKSAX39gOgHnPdNtIOv1DMcKnlLrZYeQ3qPClop0KVWaY6d33esy7pSWmsMtkqIBxOw/8z7aSJRCcinxXmYl+jZc74rl5ozhymlEJ3h+uW/Q85m2eep0m+MgkxnIm2Ktp3S/6vtJp3G9L6CvY8yon5/gTmBf1I8fyUte10b2IpKYwZnzAQ+wUiJxobrgXd4KJWiJAUT4Yrrt+8TwHy0ZgWqBfL0ngTE0swQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+IPEOjUuvrRdLIBd/Ypgl249QIjemoVl9glykOyyB8=;
 b=U4vHyWm9KeMSL3qiSRlbXf7Q+pwYbYjSrYo0vnBK3KPXTDAeVlXQMDYdRn5f4G7jCgO0+QIpcOCSCO8GzzYHleLGBNCMbOquXtqSSMfvb8mvgBt3HEixtfYM3NHbGEkoRhyE7w6CDmXAQg6xF4mn8aVX/G5wX2GG9GFSeJEj+df+TvurVQSTTyuRcvpm3GAtVvxKU3nSdFXakjSQDzjZgNSNjDs8y3xLgKC4UIpc/itfaLcfJ8jn1v/ZpLiOiVUDBDugRT+vomZ+zyTLV5xbth1oM1eFGCiuUCnUc3mZW3dr3EUlQf6v6a5ufftRZfYu1ozKYjRWSFW8vj2oU1vM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+IPEOjUuvrRdLIBd/Ypgl249QIjemoVl9glykOyyB8=;
 b=roBlU7CE1VNZZwA9D1ImdxpajdEN/33uqEu2OJlAptWsg41XRC4fPEZj6ZiF0fIXk4XMDyKlVtiHnWgSmOEqXmruChP/qRbZ0hKW23WlPSsActJt3QhjXcwYVRViTvoQNQUARvYuaIPSGr/4iHA8EdfpyCTgHSbwQcG4aJA8xnPeNKync0vOmOpnXpq5+IlkcO60wm3wZLPtW77lnqRx8hKmEycKpShZlroLkl8zYo13n8x3z39yQrkHQiVIJNioi2RZ1nAh4mWl7cfB27HQoOEP1aTTTbsY9DHFpKyETIEVIkdUXRUariDiOZoPHQ+ty9QG4WTEExIpHUnfLy0Zzg==
Received: from PH8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:2cd::10)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 12:11:02 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::a1) by PH8PR07CA0021.outlook.office365.com
 (2603:10b6:510:2cd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 12:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Thu, 2 Apr 2026 12:11:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 05:10:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Apr 2026 05:10:48 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 05:10:46 -0700
Date: Thu, 2 Apr 2026 05:10:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v4] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <ac5cxDW6qLudN+X/@nvidia.com>
References: <20260324014056.36103-1-nicolinc@nvidia.com>
 <BN9PR11MB5276EBE613B081DEFFF6456D8C51A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EBE613B081DEFFF6456D8C51A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a61c1d-de3c-4468-614c-08de90b0e8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4uvhOCrb3Ph/gCPRqPYQBfzamdBDY0w5IJ1KCPWR6Gxs4gFXwEETZRFnrC67QvgEWJVWVcEypYh1Y0TsORaj16mUihsPjdiTbG0CO/h6KThMBZAYCOdZMPYCL832pxazcr+D2LLrijfdFKQdGIdthU0ED8syc0ss15QJ+brOQEnNo6xcfZ3ZOY1W+hJoynwQLFGjSVg/i/8Ze9xg9UOhnlrg91WBWv5ql04TQOws5q24oPEL8fWZzaDtI+MooHvmc7dkOkjqOfplWvJy+IdJwcAe9Bojsnca+l+I+lmeAOD/k6yKzBmzwFylQdyOpZpwniPgH7WkxZX/3UCq6A+rjb+zT6lsmm2AKSiN6s7eXCY+K5Vl/3XN+txzRed1DCTXUX7EMnM1xA3DEzurvbMhx/1Aux1rizvR9Dg7T1J1UDf2yweC2eGzNm/3lrPMQzRJA97W37Fe6gD6/GeVU/dtSrSImX4fDZtLHf7oFDQceJ6XEZemelJixCp8YxGTAaoZdz75NaASJCoh/lLxwEWsevjJWJX+f4zU7F/sPbMS255dAq+l5W7tAbXkXDYLe/gW3SehA/nHL+LLGr/X1C6dLEFId7JxDWscxg/Jts5Ja+7AflfJG06BNIbvtJQPgwArV6/9ttuuE9klep5O20OccJvTgm1+j2HuWMGvYJUHJ8Cft4OGA3xQTW1DuPnyHn6Uuc0M9NThOG919JXmF4mP2j59zdNEIVJJcg/QD2/dqVjZklcdrpAHyc8FQjaisqk16VIX2eVmp8kupRQK3m5NdQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u5+wM0iyE5jJMJy3R55jYPQAaoRqYI8/V1d4MUVnFOkjBOKR9vJ4JcdU1bknWWnTtSZfDDrN9a0JXmL/FtgVQRYOwp2q3uscBHAir1dU2QBrDckZHEG0DC9IKhCF+AJhxLOuagIkE+rq7CZKuDA5Hhw9EXTNJvCgs52jd2xcypB0f6weyhPf+IqzjtUkGoXFFEWiWaNiEVaAsADy5hNs9pXDuYSuIcR6p+2HIFyqPDsD9fZXQTFeuW3hXllzrdugeSBuwKYxYQvjvn/6+0QnQf9nIaH4Op6PF+t/0vpgcmNqxXc3SWiEdXohoNcgdwTyms5FibfFHKh+T79KMQzJ71MgZ7/74dwDWxmqMftAyEQ+W8eiCzj8/6IFbe8glf1zDKjDAWQFd8DmKqEmZb49DS/Fl1BRb2+Uz8uhHXx4q7mD8QQHAENXwewUrvyArdHw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 12:11:02.4755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a61c1d-de3c-4468-614c-08de90b0e8a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

On Thu, Apr 02, 2026 at 07:34:24AM +0000, Tian, Kevin wrote:
> But with it there might be corner cases to pay attention in case iommu
> driver calls it in other places. e.g. Sashiko [1] pointed out one potential issue:
> 
> "
> Incrementing gdev->reset_depth at the beginning of the function prematurely
> exposes the blocking_domain to the driver. When __iommu_attach_device() is
> called above, if the driver's attach_dev callback uses
> iommu_driver_get_domain_for_dev() to query its current domain, it will observe
> reset_depth == 1 and receive the blocking_domain even though it is not yet
> attached to it.
> Could reset_depth be set to 1 only after a successful attachment, while nested
> calls still check for gdev->reset_depth > 0 at the beginning?
> "

Ah, that seems a good catch.

I noticed the same problem in done() but overlooked prepare().

Yea, it should do something likewise:

	if (gdev->reset_depth) {
		gdev->reset_depth++);
		return 0;
	}
	...
	attach(blocking_domain);
	set_pasid(blocking_domain);
	gdev->reset_depth = 1;

Nicolin
