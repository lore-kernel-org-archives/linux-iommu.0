Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C3324B2E
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069407; cv=fail; b=ez2hJ0Y6q29yOl3Ovw2D/03NoV9r9mkEJkYYcgzYSCDPa6xTq7hOwLvhjDgrKvgRGsm2iYqofGNEzUMVEc7czaW5/QDnO5Plr53d3Cg+6f522dbuNeckt0vBwY3LjMA+lcsO1PskEdBUD0DZS6/cxmI5+sI5gbq+CDquikPoZ/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069407; c=relaxed/simple;
	bh=bUFX8D4rhfaNLgt+WjfM91K6tD/nGwNlY6RcwlVuOpM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z53EP1DfkgI2aJNgTCtUyIzXvLLlShfQLCJi1ojJLL6qjJeePJEAQD6dn00dCgXxXD3oc25W79XnsGA5yZ+jwG041Hyt2cTn1DfEUFRvrRPN08fudryXITA9QKbTaitVjXoPqJXt0KTbaauugz5HzJ2GrJZMlF661e6SoP+YsBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=knVj5HTi; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="knVj5HTi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT1b7kL3rmMFz3w0P2mZ3xQWwtQbNYv09TJlr02UDMD9On1Dwcoxy/RExjIr1fdF19tSMbOKMrCT9r8oL1TFc5gm4hlgzBKd0/1p8e9np4A/0EEtMNruZZYaB+SOhQqFLv37fqVb7FALipmteYfd7GI92GaS7Ufv1p8aLtWp1rBDvLIgCtk4XeDtiGTr4k9gGcAkf9yyit+fm2iv1ljTSoMYWkAe4kifLyCSZj1MvfMvHYgQP7IHvtgdALbF+z0HpyWPKZz4rcqUDBsSdK1y87vR2PEq96swIEZxxoxjnjKlJxiZRxGweby7VLdo2CPTlbr7nzpMD7iCrXNfUIuW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zPtDh7PpRJe7dWTQzPi6sW9zQKb/8IXAwIzJt0OOHk=;
 b=Wwq5kRoIdo3z5lO9y5AKt6Q/lIKp0a9NbCIoYRD35RKOHuybIGwehBx5Zymj4JXKAuA8D3kKK3mjL/wUT1TUjgyufdV3D/VCfXnTpkW/91zHtCV6wBsGuxXKde+JpuOqsnUxIjf89wndvto6CVMhG6/0s+wwXvdMFKmDKpyVUJGy0wPoijspOB0NrNbrdWepbnCiqoiKjftHHmwCplP0SPL0ApElNtxJQn8EkMbe3a4zXuonw/32hYUdN3eL/MwIXqcfz21WzfgB3kjqxOEOznYkqn3qHs4jRJeEvOHPJoDWJVbZ/cy1a/mrYAS99srMTcH+yhlxJa0KPIyAafpgtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zPtDh7PpRJe7dWTQzPi6sW9zQKb/8IXAwIzJt0OOHk=;
 b=knVj5HTizqidb42K0satwKmXhX+8vOMZZI89DsfaNIWz4E3g1ZB7vlksz8uA6x10ZG7rxij4uIK8/vd57NSO0N+KmzqO5cMvEzdA39WApHud1SWBeqrFfuZxD+OjC+U1SxgrJX+o8YhDvYa/vtg+NSf2Gt55obyOtxue0YLgsZmhlEhP28al8zkUjNXS68Xv4A/cvg5KzvpqOFjp65on3T/htu5zsh49MHE9CUc91+8naMU34jK3IxcFQ/AJs8Wc5DYpE3Cmu3qhv869pfHOMijl4F5cqI+O6rx943F0ct+HBhN4l61/QhVkEg1QECLMTgHSxm/u2G2y0KfV2QFj9Q==
Received: from BN9P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::29)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 21:30:02 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::d0) by BN9P223CA0024.outlook.office365.com
 (2603:10b6:408:10b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Thu,
 13 Nov 2025 21:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 21:30:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 13:29:43 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 13:29:42 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 13:29:41 -0800
Date: Thu, 13 Nov 2025 13:29:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 13/14] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <aRZNw3OFePohDLTI@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
 <aRZLUc1hvFXEC/iG@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRZLUc1hvFXEC/iG@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a2cf57-4514-4f82-9e34-08de22fbce6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5UK0y4YC0NxSnEQTx/sAu1qrHyFTEU/R4xAGV69QnbLFiJ8T2xNCZrrD+L00?=
 =?us-ascii?Q?8hmi8RxCRG/rf8wz4piHRmCs9QCIXsfweRgOE8ooWXl1LLciY7xkMSJgPTGg?=
 =?us-ascii?Q?px4a8V/i63LJKcmasm/+iFZjdRV9ozhcKBeRfVuUWdEoE2P9AwiSKQ5MSb6g?=
 =?us-ascii?Q?50hrZtYFxe6RJ5SbUDdUlsA8C+JKLFnYik04jAS9ALsDxvoCwKbVutMwk82r?=
 =?us-ascii?Q?xeHZ44Ns9ydHO9SYqR9qsnNehDSASDETo5DvAlOwS6tDa89AERn2bZgmuiXr?=
 =?us-ascii?Q?RrLgNDYVSY3RMC2Xht8E4JHlydG6oaJcx6Q827RiJW3dRNrOnnHyJYxQ6alR?=
 =?us-ascii?Q?LC7iqzPNPsz7JO3Uo/eVKSIY0tlJF9C6YFhH1oXicVl2CuiSuWPa5DXaJwlF?=
 =?us-ascii?Q?0xk5TrRGbEzsTKaRPdNFnrkyLTDuPzQ9fGodogKRoA/qTnH1vXBZUli3pMYN?=
 =?us-ascii?Q?N31Jc/xwaNZixgZM87N15M0aCz6kGMSBtKiZmB5BlIYply2T6w1sOfVDTPnn?=
 =?us-ascii?Q?4k15AsWORDPuZMq1Id34RMuyz2O64E3OTHdG72rWlzPw1w4/5cf1CFrIZqlq?=
 =?us-ascii?Q?5bmWqBWpbUI0AAqnSjUkOzU02RMF5ZxlBQxjCeJ1fTsaWAJp0IO2bIi6orgN?=
 =?us-ascii?Q?zxQ5MaxWywTLGxG2NMXWiRZi3+s1KoAcsuXfP1Uh/Ib57rFi7cZkeOhU2suY?=
 =?us-ascii?Q?RUfDJi/vCj4MsKISCqYiVhE9WT5GmLTENaUUrpbpe4soFqi/aQAHTvyCOBKh?=
 =?us-ascii?Q?5V8fsgqN1LvnGW6AMXO0ICOJJ4bYGjP3Rm1PNLQ6qDw5XlgxFrdYGgYw92bG?=
 =?us-ascii?Q?NWSZMe36KPl687Ru9ARuhY1UAeNRDYqCx5nrH5igma8Baq5Mdt3sP7+GXxgr?=
 =?us-ascii?Q?/kpftjTWDWBtgyml1mO3J1qzU/5g9pXKA8epZmhGr/m0ZrYB3sqThMywNNlF?=
 =?us-ascii?Q?J0Aaf9Ny56Rx2wXGbMdeqIAsF/VTuTbyhEYNKr+QBspC6lflUECymeBhqgES?=
 =?us-ascii?Q?0IiF6xBt7iiA1tH5AbiI8nkNC5i3uOB1lvOOpwcXXO5RlQaMF0dCW6tA2NNS?=
 =?us-ascii?Q?MF9Rn10Y1CeHLAQcFRd3ov8jKSdGa54nqYDl/MLHkCjo7Hum9fKrUvJJHfP+?=
 =?us-ascii?Q?SE/y5V6AVqglPqM0zht1L3zbSt2AsikaowdR7ObzowNEHHC4FyjabXa0rDh9?=
 =?us-ascii?Q?hmndmNXsi2vmsUrRUcRA4bff0e6tuo6OSte1QSg8omio+JRxKqmCFN1UoXaL?=
 =?us-ascii?Q?WCtpgL5jaR6K1U4GSvo+qpuj+U4WAfvkqyDLY+6Kp8+3eET9Mq0G3Jq+Gff5?=
 =?us-ascii?Q?NAWHwjTpHhdy7JaTOgJ520HCABUJ1aHacMghyLIZFWKKhIdUPlEawn5Ctdcl?=
 =?us-ascii?Q?q4bRUB7oVWoDmOY50JDuroXTHi5Pt3AybOOLwZpFTI7lm+hle+tLXBCwTWyU?=
 =?us-ascii?Q?0Dcy5wTMtCHkQ5ca/NfrAYi7FRSuWN9mg4Q8t/KG7TPVPGOlmsabNzT/FOI9?=
 =?us-ascii?Q?IWmBe5tfyC2PEbF9RBoh5uhwwzxwQ/0BumdFBIGfJB8O9R2qYy0MsOa4vqlc?=
 =?us-ascii?Q?XKt2oXW+SoSIr7MVaLA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 21:30:02.6971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a2cf57-4514-4f82-9e34-08de22fbce6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

On Thu, Nov 13, 2025 at 01:19:16PM -0800, Nicolin Chen wrote:
> On Wed, Nov 12, 2025 at 06:25:05PM +0000, Suravee Suthikulpanit wrote:
> >  	else {
> > @@ -2097,35 +2115,29 @@ static void set_dte_entry(struct amd_iommu *iommu,
> >  						       &pt_info);
> >  			}
> >  
> > -			new.data[0] |= __sme_set(pt_info.host_pt_root) |
> > -				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
> > -					       << DEV_ENTRY_MODE_SHIFT;
> > +			pt_info.host_pt_root = __sme_set(pt_info.host_pt_root);
> >  		}
> >  	}
> 
> And this __IOMMU_DOMAIN_PAGING path seems to be used by v1 only.
> So, it could be squashed into amd_iommu_set_dte_v1(). This could
> tidy set_dte_entry() further.

Having looked at PATCH-14, I realized that amd_iommu_set_dte_v1()
is shared with the nesting pathway.

So perhaps:
	else if (domain->domain.type & __IOMMU_DOMAIN_PAGING &&
		 domain->pd_mode == PD_MODE_V1) {
		struct pt_iommu_amdv1_hw_info pt_info;

		....; // <--move here
		amd_iommu_set_dte_v1(dev_data, domain, domid, &pt_info, &new)
	} else

Nicolin
