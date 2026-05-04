Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0703D31B114
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926225; cv=fail; b=SmChnO0dC/mylQm/EoqMCPJmAWjH7zhRfNtB7v7VA4edYeNw1a9zqNsU/dT60pW2o8r830p8hNlFhLoqjtijlKiWjXXHcPTbj4+jXYPeyf1D51VTPGQ6d4/TPKTv/rDgOrDh3iNwZjVP/V5I3DwwhOfiK+NSuYzEEsr3ye6nEtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926225; c=relaxed/simple;
	bh=8+0NyGQz04hiBu83GzlC5sC9Qr0hGabDcUdTrbqZjVw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/q3ZnqIsHhEi/q77e67CIDOdfr2/NfqYCVFnp5PRzi7y/VtpCyq7T+l2Y1UP8pnJShxB6NpNTIpzfoLRXogT8xT6un5Quimt+QMBKfjLPHYFcBv2/t6LhL6AnniPRGPsl8/PKwgrUK5800fiHGbtHXAX4QCzrSij1wrPGzPHt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Huyyzbez; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Huyyzbez"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W896mpg3Sn6SZFSWBIbXslOiGOCL5W2S9u343qJy7jBKukMMsZ0WqP706imJu8rRQ6o6Ue2Yxx4EYKEmjj+OugxRk+q5aAQQY2QU+STXAtUkIxmpVz/CP76cVCVjK7yiyZco+ud1gPcimZYgRYrSOCrs237MhCp0rCjxSqNfgYpPUDhhc6QLSo7VsIL9Ii0s1DCTaE5USZAeT/mhI6eGN10XnJxHd6vfuWHdaVrHyVvP15TzdDHHg9PvokAhRqsPgyMN1qoOSZH+pXY9kV8UJa9o+beGyZL92giDGHip0V+J082yEhqErzOFwE4gJpH6rx/9SmAIWDO7WHR9W6ItFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzTELHimw+kKuDvJl29lFC72UsngU7AO6ZcvI485rIg=;
 b=hofVrdQSZ+V/dKqCb0MOZs10bzDT5B+QnCjQ5XcYr+dZUJiDLPD3Rr7A4FOKruME5eBkle8jqwe4MjBTouee6q8JOmYYx8f6l9POAabBVET6sYJ/vsB6jqOb+kxPsA/T/rMrNz9vf0sXlfI9Ky7S/SBAd0woOx9o7NHnZMz1brP6GNcPDe7SuP4E06UEX93UlrZmrKWR6NJTFzILf/pGwY32QDk9d+sx/MXn5cA29tVLSEMR2y1nfyvvxDBvbqanWSXMXVdXwyC+AMbvbTTRDIXbhunDJomOqr2IbvtzbN2ciiMSvSVLkubvUGBTNrmVrC3wCv09BaRyUWhw/7UYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzTELHimw+kKuDvJl29lFC72UsngU7AO6ZcvI485rIg=;
 b=HuyyzbezoYECGuRkkw+NAuqqkqCgxPv0KLb9+jr2jeDU4AMgzjjtuBhTWsFDueORjpKBUH3GmHfRsPAXQeJMAE5qZ6BcZV2cWqub5urK3waX86AH5TWL1VUmah50l37Qy+DuQN0BT4rYnJ2Vek4sxRDAiWCzyjHjgvpeZCTcetlu13kSAhEcHefj7ZRlfhF0cCkyklgX8NAF9jsmGzcaIpZA59V06MPh+iAUg0trAFSleuCVZQawFZjZi63luENiogDNaAQ0LaflGlHQLDetFVtvG355bBDRSKnGVCK18JUKUxUv9pZX3EuMP/O4AeWeP9eUdudX4Uqhcz3VuubnSg==
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 20:23:34 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::40) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.12 via Frontend Transport; Mon,
 4 May 2026 20:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 20:23:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 13:23:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 13:23:11 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 13:23:09 -0700
Date: Mon, 4 May 2026 13:23:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Samiullah Khawaja
	<skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afkAKlu4nllduGCE@nvidia.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afj0cyBZwkVLyIwK@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 47403dc1-486c-434f-38f1-08deaa1b040b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ku5wIIkkDYLrK1+FOu5hzQG9Ho7fvY7V1tRpeOx8ujTfCl7hFrTD0FGZv82PF9xa45yfeKOTztIu/UuEtoMU4iqN/JOENjnZfstsAMtyhx8D+VPYdBlMrm7ROD5sI2O+U53sROqOc+4x5B0va9aac9VEscj2qnpdQQjvLAMAJAmid0rJOdpyFZxmWVLO6eAedLKC5jECLKj1fDXp4TFCnvurKuM+wUtzgsiGU9jFE/JUn0IQkiNWqNibIsyeLWhof0Af/e7X9MYjdBfsqkFXc6tJwfeWJh/JDxc/jUbPLqarHiavV/AlBL1dPpQ2DcaQ5TFg2KUGDEORsLrwZKum2UYKc8ED2ouiyn/JufYjPo1pcBTT1qRFRqDRAHENXv1gfxtME+gxIui2u49seL5nvRgTVVbX5so20BnYuQorKrcwsy7xSasQIhuEPbRBqaOeKApOo+bSfg8Z2npKFFY+2LL7kxyUAtn5MnJ/0Df3Sj1AkIH/EweXSz8ReR1vhWpLXACe+DOtc/OH4WTEOG0dWfH6lwBb23OhdNdyURrQKuXMRjM3ElP3grDe6CG1FeI3R8bc2B81huodEAbMjpAaytsBlovED3cjvxVBuQaPqyOlJ9oL+t2jz2Q2jr/RKGyvfd79YAVhYbXCpWkuExpiMB4+O2H23dvmH9LOVM0rPkXo2RvQujl9JvZLDu133l6twbFfbsquaoz22wVUr+CrvuAVWu1GzTwO26biU91G1B4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Femqzo7TzOslc2p4eszEiJo/zCo/yOKMuVQ1RTGU5Ft98RWuTBfXdAEg2zxNhhxftAWzGaFBO5cL1GGt8vBkQTE+LGigNgAiMmU6s9BRHKYJ6NG3kqNHPKzFrpfVjyc7isQH6qSG0WEpZcWQZ2ibDAJWH1SGe75/NGocTm8ubtLqVb3cMOkLiUfukQPCMUi4OD3e9MYPwYyzoFbfIR/MQT/RfTaJMjJQKg65xtLg5zQjytoaADpJ893mhdosaDGgtLCo/1DItIRaHvcJM2cd2ef+yUzh0WjZFfd3pMBMmBk8etdMCIvn4+Pdaf8oJel1Opepn9Ck6Jr1WImMZzkUo/xqBpDv9FItjq9YJodn7tL+or7WhkImHki4ZZ0ybKj4WitOUpPjX6+UYOEMykDifOWTgGDsyN28pGw/S0qgyrlSwl2C4B6g/tggzMjkRmW4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 20:23:34.1220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47403dc1-486c-434f-38f1-08deaa1b040b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> On Mon, May 04, 2026 at 11:01:42AM -0700, Nicolin Chen wrote:
> > On Mon, May 04, 2026 at 04:38:42PM +0000, Pranjal Shrivastava wrote:
> > I am thinking, maybe the call sites of pci_enable/disable_ats() can
> > check to_pci_dev(dev)->ats_enabled instead of master->ats_enabled?
> > 
> > Then, we keep master->ats_enabled as-is, so detach() can revert the
> > nr_ats_masters and ATS invalidation entry in domain->invs.
> 
> My suggestion in that case would be to update arm_smmu_ats_supported to
> check if the client is a VF and check if it's PF enables ATS:
> 
> static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
> {
>     struct device *dev = master->dev;
>     struct pci_dev *pdev;
> 
>     if (!dev_is_pci(dev))
>         return false;
> 
>     pdev = to_pci_dev(dev);
>     if (!pci_ats_supported(pdev))
>         return false;
> 
>     /*
>      * If this is a VF, ATS only works if the PF has already enabled it
>      * with a valid STU.
>      */
>     if (pdev->is_virtfn && !pci_physfn(pdev)->ats_enabled)
>         return false;
> 
>     return true;
> }

I think that's okay to address the issue for now. But it assumes
that pci_enable_ats() will never change so it won't fail for any
other reason.

> and then in attach_prepare we can add the ats check for safety:
> 
>         if (!state->ats_enabled && master->ats_enabled) {
>                 pci_disable_ats(to_pci_dev(master->dev));
> 
> +               if (pdev->ats_enabled)
> +                       pci_disable_ats(to_pci_dev(master->dev));

master->ats_enabled is redundant if we check pdev->ats_enabled.

If we add a gate here, should add to pci_enable_ats() too?

Nicolin
