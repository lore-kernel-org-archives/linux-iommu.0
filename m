Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE719DF62
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093925; cv=fail; b=svibtwz7bJYvsx49ZMutwVUzVA8bxs7bAI5KyFla5Vwf8DO1qRUBO9DB9NRpIEJAlxIh2+hOsgILuAHRNTvdVkcTn6Ftx3LAMoOop4wVCth0iMsYxPdAtJbuOPfPc07Xl0ZPWbrDUoC46emW74e1eodjlV5SAE7xeHXjlOchOwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093925; c=relaxed/simple;
	bh=qoqqmeJKLYbU4ZzWn+VVEElbHtFvNWhMya8lS6XAdgU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxmA3RbXIl1rIq+4dPSxVo2teJSHWHbM31Ggn7x6/5bdI5jxyCUkq6ywjsD9mAIHvsF81FgspdBOp3jiJdeYc2CaU0rxwA4R+mrA0ThjAAN7LDh6ivFni+RFtzlwZrhPlhME08FFVazGj73bQfNLX8Oqt5ellDkaWnyC1CcpLkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=peaNShgd; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="peaNShgd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7PrZW/jkQ3yueafGe5kKcw86yKgPfBKEyvvRkFjN3ERAbewytVy1BTpgUnMnEnDw2l53Yiu92hqD1hhA7AaDQI8cxJ33jS740Ht8gkANmVD1pu7aLsKEC550cyGuDHmxb5vrOINf6KKrrLBLMJlM7pQQgFDON0HiQ1VXc2ZcfXAuu7M5N8MqRsd1wpXtOdFKBSiQGGDwhLvVMplj1ZxOPUtgpELSsTyWC8YCOSDeCMQlJYoOFBjonaMeRVVZRvi3a92uS1/2CUWLLrB1K3LB3Tkhxh9KPtybBLvmw0OnFr8ZCg3ZwNBIDRQb/5/bzNGUiKD2EJjw7Ilw1gyvLFOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGf4sBQCDOniHWBZJ+6LZ0pt+MAyBNBD+iLIotP4uas=;
 b=jdNPglfbCNAALQussjX7T8+VDMkXgsH948JnCHn29eOFdI6VtZvPBvCx/1dTsBtcGeRVVvjsNgY1qdGX5k6VrVjdb7jn5nWJC8P59fMAMQ5noSujlNvoTudArtjaBGQWOMJUzWpxZl8+71tibBA+NMbaiXN/j4kzUnrglLz+vL9syjOtfVGhmDeQBRnCl71/HhMayI3DU2GsjI1+1NnJukZATaTh6FdQXYPiBjsTSubzq24Jf1AWye54pd8WyCJMGtaj0OlbyhySLefYS+TyaX+KnjQ+IkVu8zRAseHyM1lOlEEjt+VGdXA+v+m+aNpblec6TqDD1MOXbhANI5e5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGf4sBQCDOniHWBZJ+6LZ0pt+MAyBNBD+iLIotP4uas=;
 b=peaNShgd+Y9HwYw3tEWdkal/hFNAjlQL9FTaM7iY5ytbSPXfVm7hWmvQ+lNYjWFGIXQBi0YnuLszNFgi4DinIb8Y9a7EeCZfaBKtogCRZxuYztJl0t9Kn3+YURCWGpznREhuoHlMm3a43xyb5THLHMknZFuPphrHZTeTFSdDSGmzOuiboSpeuWIopXneqbvJX7jpNRYED7XyBd7cb9lnrDrPYdloPGA2rtGWH9uLZUXWUZzxgwzXtAgonvurz39nX3juZkVQTB8tXtqfDzP5Qtwj64sWsEyeUoj/b66nB7QCHvZHepv463O13hOQUW7UjUSmRdW0rtMiJ+Ykdwu/Sg==
Received: from BN9PR03CA0468.namprd03.prod.outlook.com (2603:10b6:408:139::23)
 by IA3PR12MB570242.namprd12.prod.outlook.com (2603:10b6:208:715::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 19:52:00 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::9a) by BN9PR03CA0468.outlook.office365.com
 (2603:10b6:408:139::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 19:52:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 19:52:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 15 Oct
 2026 12:51:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 12:51:37 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 15 Oct 2026 12:51:35 -0700
Date: Thu, 15 Oct 2026 12:51:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andrew Jones <andrew.jones@oss.qualcomm.com>,
	<linux-riscv@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <tomasz.jeznach@linux.dev>,
	<tjeznach@rivosinc.com>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <anup@brainfault.org>, <tglx@kernel.org>,
	<kevin.tian@intel.com>, <fangyu.yu@linux.alibaba.com>
Subject: Re: [PATCH v6 09/16] iommu/riscv: Reserve an MSI IOVA window for
 iommufd
Message-ID: <atEuxafCLCdZrdR7@nvidia.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-10-andrew.jones@oss.qualcomm.com>
 <179209292716.4133959.2758345963634439485.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179209292716.4133959.2758345963634439485.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|IA3PR12MB570242:EE_
X-MS-Office365-Filtering-Correlation-Id: c32e24a8-5632-450c-768e-08df2af5c712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|7416014|22082099003|10067099003|18002099003|11063799006|260925021911599003|260925022911599003|260925021311599003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hbQHRwk8/PLSQ6KDPKvQqPb6RiS74dLFCrodGyox7DTLaJRoqW0VZ+hG9YdEEMGKOURnp0apmyecXvg0c+qFC//7JOQqIcOzM1ABlPpn/zHpCf4TJEVXMCJA4dZt2TO+qcWby4JOfRvs4IOUgVwEH5o5RuF5trqYbzY2u5Rir+gMstwDkYeWLvdMS0nfRveV9CyzQcsVUcHqBnQQx2ek5fjzqEbpX2mqMfig5QzYeuYPIeiXgKQUDuaMuQCEx2rZEpvwDzdw7F7f3nLu4DYMyQKXblOd5g3rtcTbeUHpwcDEfGmVNeia/PuQvMQG1em4kiLbMX2oqC19sKwsMRaJvldivfchWyhAWLwPc7+bsN6buWvt9X8W/1ryEBk/h/UZb8xYYXPDniJ76+GZfhQwX55sHsGWgQjtwDb4Z9k8yPzHfbuYoHRY8K8cyy3Aj1cJ7rUtlixAA1feI77eXUQAsOS8dpe9kAYgVs6AXzDrzwAOr+V1uuGrYRt/bywu3T7Ef1XgJJd+Mvnb+9nzaij/C30qhsrCH3qMAbnD9qvMRVj4a3avh5T1oQHqw7h8WpdWIS2AqYHhAAtyQMgSsWruvJ79fKb/XDRV+b8OollOjOAYIkEH9fdidw1nECdTHOKVQ44QBCbX8yr6GCFRAkZd5z/x/6fHGVRhFcVbuIx33DMZjrkHGZztc3UTXhi6dBnFtUwo7+RDGzkRnPwfLPjFwg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(7416014)(22082099003)(10067099003)(18002099003)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZwXJgfz8qoWHJlNnCCHR6w9D1V92jYNHlSen9HQryYkeNm412nbKRDjgVoZ6DDgIUT5nCnxfLUnyXCOwQUAeSLZfXaxzOjlEfgU339N/b+zgThprxN4xy2bRO4JTEc8bqx3b5ECGro91XbwaEVv71tQYlRNA2/bEiq0hKrUMIa1/n2IyGaEneYWbLZH70zGKZKHJKqw60CCOMKIDh8EMHIDu/5jGfof3H0fHPNla2E7nlu0bMVy1qSlxN/Hkl9vYQ+/HX8cBKtARO5y2HqZZM/VdigmZUV9eO2Dx7X0WeqsmpQCMgRIlNjNPDcMlvva8ZI0Ns3W8vHppkiGYv2a2AYkWWBSoVepvAfGobrTSrbVu6ZifaZLje6U816dDRsczS1/mW6ktjTZWV2MBieng5WbCAIFOoYq990AmzpOLJTbG/meb3PSorx0XbIkFR7bd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 19:52:00.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32e24a8-5632-450c-768e-08df2af5c712
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB570242

On Thu, Oct 15, 2026 at 04:35:27PM -0300, Jason Gunthorpe wrote:
> > Reserve one page per possible CPU, sufficient for each supervisor IMSIC
> > page. Use a 16 MiB base instead of the 128 MiB convention used by ARM
> > SMMU. kvmtool places its guest IMSIC at 128 MiB, so with IRQ bypass the
> > domain-wide guest MSI address match can also capture host-delivered
> > MSI writes to the SW MSI window and misdeliver them to the guest.
> > 
> > 16 MiB falls in a hole in the current kvmtool and QEMU virt memory maps,
> > away from their guest IMSIC windows and RAM. Keep the window below
> > 4 GiB so devices with 32-bit MSI address registers can use it.
> 
> And this is a good reason you should not follow ARM down this mad
> road. Nicolin had some patches to allow userspace to select the SW_MSI
> range instead of using a kernel hard coded value, which becomes a
> sneaky ABI. It would be much better if riscv starts off on the right
> foot instead of continuing this mistake.

It was paused due to lack of an immediate interest:
https://lore.kernel.org/linux-iommu/cover.1760487869.git.nicolinc@nvidia.com/

If riscv wants it, maybe we can give a push.

Nicolin
