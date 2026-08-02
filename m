Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E11CD1E4
	for <iommu@lists.linux.dev>; Sun,  2 Aug 2026 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692761; cv=fail; b=KKwDJgNDqFV5lnK9pvaTuO5msWrfwed2UAbnMDyw8e2aomkTzJtFQuvuSnrN4MVoxv7CXMyraGOYzA8oSDf4tzVs/uiNT+CJaVNVqIXOUypEBnMtHcbZti04fcHbXVwrTXY30ElR5trl081j5gAUFhn/BKw49O378PFvoTEQnsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692761; c=relaxed/simple;
	bh=IeIwJRbYiGZYdJof39UmgF4/JAaZchIYVDcvfMZgkk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhVI/keaMrC7gEtVGkI3ILB05vBDb2M+jnGy9i6+Yauvw8Gjl4oG+7JzUH6y/q92tl4cOIweAdLa+ZObHY+BhFzKHNjakcfH1lY2uKu14IHUsH9qEiZb1gvVtbZi6YmkYjGW0HJjZ3QX8cApkWJEjLl0SG4jlvMxUUrTHZ7V/zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B98KqNL+; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B98KqNL+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHk0bVhnA065w7pm220KiDei25/4fRTc9wg5A/QJC0rqGRENlXQ7EE+tnKFr1kvtwUq8OC0hgLroxCc5Ur3RfPbjTLU/goFn/Elo88rBxo461nBFJ2DCVSIUYGAC5BoQxijGSpq0uPEQLP9gxPJ9SAflZO30Rw1zQytj8+2YziUHe15rUT3EpPFRdjy+kdzqbahX8aTPbLqe2UX9ctyM46ijhj2q5RbZihymEggNXCXFVBCPjAPrsXfsS23kxBTapQxOX62sx+BH3uM1Oo4CoWbXQ9QwSLgvAdJ0mkqfI9PYtUAI8qB5BrFOJm+I44oKrNp+21c2UU/y4dgGbnm0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbFR2GU7XLS4De+9y2hmacp6mw5O2m0EXVjuaBjMMnc=;
 b=svlFgqxmlMcdPapWHRhtBJ0ZsIPGcA0zAIPsTtzEnMt2qOxTwfPGKyWe1QN3t8O8RJHSOaXbf5CCdA4D3bxBb9EMVClPDBOaTV38O+vFBH1dSNrYPqwDRhiEL6ohnO9rRBJyUls1oUhjj4sEA7rw/iepJPfGJwfzTjw0jlPx5dHZkZRlakY/t8k4upriRx5d7+jarGHNVyiACg7KQF6U9QpGURAtrz+8YjuN1aitKXiKUWKGdnzz5h3z9u+QCBWO1umabx0xBfzPkkY9ZsGwetquMooCo/erXIc1jOh4J0ImWZg0sJstfMTZkQWWkj8ydwHIQjJ8xaTck6oDt+jILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbFR2GU7XLS4De+9y2hmacp6mw5O2m0EXVjuaBjMMnc=;
 b=B98KqNL+dt5ndyHxZfoZBzcPh1lrQHaGXviWkS6CGETBg3IUE/T+qig3g8ENrvsoX87Jdx4K5BK0GOzBAb9fH2x8OntOLITSpSrK1QZGIVsJSBfjcfdxW9m6gT4jHEVzLVDq/ofsEW7IUVwC8huN9fUhqI080RSyVoDgHqcIGd547pf5evnJnVAIz5L93zKVuMH9RJk0kZiraHzkSoBMN1/zs2h4h8D+Qyd8zhf5TddcSsmyIbKBRpUn/fUItftC61usD1RLEmAENm0r+rWnvgambPgF+2Cde0Mv00ANKQynt0bAngLGJLIEkfOPScB4sWwcAGmDihgN9JjwKd134w==
Received: from MN0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::6)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 17:45:53 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::95) by MN0P221CA0003.outlook.office365.com
 (2603:10b6:208:52a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Sun, 2
 Aug 2026 17:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sun, 2 Aug 2026 17:45:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 2 Aug
 2026 10:45:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Aug
 2026 10:45:38 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 2 Aug 2026 10:45:36 -0700
Date: Sun, 2 Aug 2026 10:45:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Kuan-Wei Chiu <visitorckw@gmail.com>, <joro@8bytes.org>,
	<akpm@linux-foundation.org>, <robin.murphy@arm.com>, <cychu@google.com>,
	<hhchung@google.com>, <amitamishra@google.com>, <marscheng@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>,
	<eleanor15x@gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Replace sort_nonatomic() with
 sort()
Message-ID: <am+CPy4+gcGPtR3G@nvidia.com>
References: <20260730181216.2709088-1-visitorckw@gmail.com>
 <20260730181216.2709088-2-visitorckw@gmail.com>
 <am8MpGR14HAg58Gd@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <am8MpGR14HAg58Gd@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e629ba8-20ae-44f9-11e7-08def0bde65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WAuP2PNdcnx5mct8AqWmtki4hMdo0L8qog6a108D01nmJ2winqAGH4y07qbPE5jy38jJ6cRhTStRL38Vhw62Dky0Qhyh/ZaZMTDpvm/Bdd8JSqtkwPqZmfcEnpXYh5ZWbIdjp/swTrqnUWTe1rDWlkNupKFEuLSLMka8m3VTjq9DWauliQxggpjBSAMcb/6ZT420bOChsQ1HcHAlrZuQQ6EhqxMYsA93G8NW4I1qw+Fpda4HHTwADodC4i9i4R34kJ6MpIE1c3rHvLXtRd/YJK+Xc96xzQr11ZQjJ1rFg+E5XDoiCVeDXr6hL8qhG+4UKpWwUlsoY/TDDLfRSprV4W3Y9HlnfK10/M4434JQW/07ge0D2KX2sFE6008HRksAc1cX1v3iCB2fv41Jsg3miFEt/PFCmUTSj05NzoWVl7iU/wWkZnjlOLdepiz7KQ0ufUcmobjB50boX+Difi0eS0IWGelfALbhQZtxIMM2vzncueokg5ldUW5WBOtwLPh4ThyC5sisk0KeTzR0tYOKzJx50hZ8qR8aDMLRH57Y/ZyCypQvZMezJWPCRoUzkkHjvhsPT7ybhY4OkOnYf7rl0s46DavsrupKq9T/eDLnp9D4f85ma6VherWvrAFRKKBkRGQ+H5oKIS7ALfCb8eKk+dOsopOsQnAfsn769Z+4qlkRSRwQxCM/QRGalqG9emPbADK8VZi8r6UWY2tV9KfvHw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ll3ch/1+4mwr0kiLrZyhBDdSfZWAxBCszfQXKJRlqwKdGGsMZ3tcv1Ba31aXlEcrKf1tSBp2ELReNk7UxxYoMG9aHWecKtx8VJbclAMaY3yU6s3grDaUcUUJrMb/G4/Lpprjai1vRIyMd5VRqihIxCUJ1Bp9CBtk7f9UBgG3Fb55LhE/wsik050scEr74AjXzZVEpvrZDEaQ/vsESV2w/Hd+Sryw2KFpbU3mpy2YEKOUCNlULLpQb3gK878UZGUo+MTa9LwS0cdNoYig63QJBpf69fxG4UzrDW1C5EhDTZTjDYYm9zKPZOMzNUbktI3MOCXYx4RYr+RWaQgtijnk07j/s8eiRxDLaC97wlZnV7doDacihqrZO1ykkesi4pUOGqBIpTCDbSEUFcb387iYwXWt4Q6OU/05xByu1HtJGWJqBA47rWSDSYRCM/GdR5E4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 17:45:53.5589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e629ba8-20ae-44f9-11e7-08def0bde65d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519

On Sun, Aug 02, 2026 at 10:23:48AM +0100, Will Deacon wrote:
> On Thu, Jul 30, 2026 at 06:12:15PM +0000, Kuan-Wei Chiu wrote:
> > @@ -4047,9 +4047,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> >  	}
> >  
> >  	/* Put the ids into order for sorted to_merge/to_unref arrays */
> > -	sort_nonatomic(master->streams, master->num_streams,
> > -		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
> > -		       NULL);
> > +	sort(master->streams, master->num_streams,
> > +	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
> > +	     NULL);
> 
> Makes sense to me. Nicolin, did you choose the nonatomic version
> specifically?

It's probably rare to have a large multi-stream array, so I think
sort() would be fine.

Nicolin
