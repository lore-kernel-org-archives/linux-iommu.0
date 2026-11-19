Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106989;
	b=JECYgbTzG9dROzz2GZ7JoQXBWIx+YNeKGpCPGQbrC9Z2rqK+PVcCFXGHU8cT1sbHrhdi
	 uZcRUWrdj+DQjrRENvP9AeY+QKFKBPnh9sn7F0ac1mh4ujTwnQOtYoLskZpYHwQiLeQYH
	 h625O7BpyLCgQ7JS5QSL8XVBb4MhXVuvKXVW+vSia/8FmjPnNjN65OQHeHk+8B3nknLe9
	 f0VTMfLwB79HQmtpyT6sMn35zTOYXbJZSgwe2SUGZkm7STrOstQrTj8+d1BT7jH7GKG4R
	 s/WfLjR5dqp8WSTBIzjY2cyVfUlRIw4SJ0atYnRap4xZwTVMzfvgO1VCv/f9wbVAEtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106989;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3gH8lWYAbIT7C0oUIgzKB85xh81Eg43bzCf4uslGnD4=;
	b=To79MdAKxEl7oQJ5bw5iPllmXMXAlp2nZ2MSDdxB2aO6vsjdDZgRiSmQQnelUrnuGRcH
	 2/T+BH9KANh5kxx09kNvSiwcbC3eoYlzkzts61HWRA90QP22ETiYLizPxd2BDAYEC5849
	 FeZ1OhXrTftguOAtYatPPQpfOH8jDs4DugqYZE8wwLO1d/R9qigXl8PxLUSRa1c7xdnws
	 kzigASAzglHbEufVsARFZEHiAP1kWlLf/wT1hmSoJlx13MtnfjzIptY5fKUFXDUXbuQoe
	 CRisMAk/pEh+PYPy279d7dXznR8fo6S8PWl8R8vojRXtlMMIgPKyRmEjkvpPg+WX26Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UAt8QJlS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.6
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D28606A33A
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D28606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UAt8QJlS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpsYCx9R/nRvvcXSLyRSs0jVsiHKIgiFpVJiRk0K4xzRyjtZbHdq86/xJvJA0DTvqWWknGH0QJJFUex3tijzVfDuwVLCLeUTw5I4E8IIjGyTtF42y83ue3CtDHi4YdZ5iAhN60eiM2Aw/gVSvv5KyYCEbSnHMQa8mMxymQD+E8u6vcC0iNgoOV26OA+PiqNuTBhvZoTnbDIpHwcQVQDvLCscdbptsktLUnkHKD6G3cjZ7YOKEEaL5GbCWBJ5Tc6lG2/m1GJUOfEOu9cwrMvKX8md5TC+k3sBr3roZYjXw57ci+pSzjF+zf/wYefEl9/Rme53/MXgPUJtlN22Rh3MKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gH8lWYAbIT7C0oUIgzKB85xh81Eg43bzCf4uslGnD4=;
 b=SdgaverfRBRTpARsrlVGxIZcy8vPyIaPYUlA3bIuT2PyKVK2azfh7EUR+PkgfRJ+RZYTsjkakz6PRjddODkCQpGSobzJ7s3Hf7cMI7klNOWuLtfFiJUiS6AA6VMhJ/0Lr/KP6zo3Dgvqy5T4FosfLQQLPUD1qsG2k1JpX6HGin9HCjMmWAma5fCIjqozsk9EbAClIIkWwf4PL/rqqzRLm9nlA+M1SI3wycwTPy8H8RxAGq0vjUEkjpD4jLjh/rcKodZNLQ2iEiN4LaHHlCgw47TO/CQwu15QYecn1sfIBEP44xgzeSpyfFOxdIuuLcfnWmsnOaU+jAczuq6EllUoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gH8lWYAbIT7C0oUIgzKB85xh81Eg43bzCf4uslGnD4=;
 b=UAt8QJlSkdPpHLzNTvTC/SN1sLFRVKrtmUCWBc3kHK9rOl9IGjwiAr3/nlif3Ct2r6y72WeLZbG2Puu7M66GctAMPkhABCZPtpr5Cc4hLgpn0EQkaK5++fnzQwVV7iPp7q1QNQaxwgVY8deMwXA+TfN78SJhrzWpL+Ka43hwoMprsZ4P8F40iz94r4v3Sc8qLpIvcCXxtO/dk7ZUBgd6B7ezsALLWqVur61Kp3Z+PQUVrFxZ1fVLbM0dX7CjxCYt16YO883aSz96a+0B1EQprhRGqmAgiSR8guiLukXTHMIK9r/ofUx3QLKjUT/mSDBPrTdqGHaQ0VnYWOQbmhV0ng==
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by PH8PR12MB999273.namprd12.prod.outlook.com (2603:10b6:510:425::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:49:31 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::3d) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 19
 Nov 2026 16:49:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 16:49:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:49:06 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 08:49:06 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:49:04 -0800
Date: Thu, 19 Nov 2026 08:49:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v13 07/12] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <av8ofzh/uhpBjmxC@nvidia.com>
References: <cover.1794942324.git.nicolinc@nvidia.com>
 <d9b9d642e61c0b41bf0edb2165d2d37dc6b0c20d.1794942324.git.nicolinc@nvidia.com>
 <bbe0db50-acd2-4fb2-a0a4-8fb80e85fb29@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bbe0db50-acd2-4fb2-a0a4-8fb80e85fb29@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH8PR12MB999273:EE_
X-MS-Office365-Filtering-Correlation-Id: a732c50f-83c9-4312-62d5-08df465d1528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|261021135927099003|261022075727099003|10067099003|5023799004|56012099006|11063799006|4143699003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MzHyy3jwTiaYpkASxH7vOr2WCJzeejMGAvJcOQVf5FzFi0LYGEx5AEjGVDVBa75fW+QM/sAaYcsYwZfhZgqV78z7kD/Z+qkfof/PnAZzFfUsP7DqortmGloyN7uFjfI5GZl3bOBzea2BpGDaDvRf+uiowUSwewfBX8YbFM3KwN7FVwCNvMDBeY/hp+L/ezTYvnnZ5UTWe0bqn5bh41nBZiX0h3GQRXn3JKzdKU1pxSLC7ME4I/fS3WeP4gzFK0pHVJp8Ctgd3b+Yvm4TXVCjPrPETCtNJqPLi39BiB3Vzy7jNkDOJZZ2fFgPcUVnI2fgswaxoUstVgsOT1vcycVXw8VxoiEP2+AP6rS6cVvAZYxijmGWKT9v2o642omBVv0buoXmluIvhej6dXXyULTwumin4fReTrwzBwBI8atAKlSzHzAey/cmxFisrYk5U68rAbWFPP/0PKI5HKBGhST5guXyWJ07TQjKcxvaxp3pm9NHocjj37obL9A9GcVeGICv++5qzbZFttERwrwU4x/pWVtyIBy0SOCWR6CNsvet7Z6zChX1wApIcb7iLm2+HEY4mt9Mp7TZOshtZutN2SjzxKnRbQrgOvcMf8tr5g+TgZ/7DmOV3qP4EPdLDqdWzNP2KChxVrmGW9bBRShgVpDD5c96I+wJMEn/H/yUP6LYjd5C3yOdaL02oYI/9pHK1zsfZkrNfBSyYomg7RuTIWFp2A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(261021135927099003)(261022075727099003)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2HCPJgo2Zg4KKxGIlOLqsdAYrrPcGokAcWw/UNkb8YdWx+CbBXd30jpBGcfSAGUQH7L16umVFM5IKthJb6sEN7vC8W7avrVxaRs4qJ+YttBKO5R+BmEpwFqRIez1ragICe+WgnkY3DT88Q+cSHDvv8VosxOdBQC4E/8sA5pQdRVc0ehSd1BLGVyhbCPqq1JZ2DYgUfukjMU66pFIkX4xzioNy9yjoeYv3XQzmwVMPbmJDwHOKPfbid92z184Ui+T6WD1ScQSF69sNc5T5XfU7rjdT8j5GMyJo5M1MkzRQ9Tpl7hLZx506HJEUGwgpyEchgWoa2Xv9uXawOzFqAwt6UUfxSjfZgxk2K1sQ0xLPi4L2iDwMXQi0LHzhBzFRyvVRzZGUXRq4ZBcBKCBhOy/EU0VOSAe/BqUFD1457WH7aXQ9+mVhlclTjMhhzH3dw5d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:49:31.0560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a732c50f-83c9-4312-62d5-08df465d1528
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999273

On Thu, Nov 19, 2026 at 10:55:59AM +0000, John Garry wrote:
> On 11/17/26 19:21, Nicolin Chen wrote:
> > +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> > +		/*
> > +		 * Both kernels run on the same hardware, so it's impossible for
> > +		 * kdump kernel to see the support for linear stream table only.
> > +		 */
> > +		if (WARN_ON(FIELD_GET(IDR0_ST_LVL, idr0) != IDR0_ST_LVL_2LVL)) {
> > +			ret = -EINVAL;
> > +		} else {
> > +			smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
> > +			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
> > +							       base);
> > +		}
> > +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> > +		/*
> > +		 * The kdump kernel need not match the crashed kernel. An older
> > +		 * crashed kernel that predates two-level stream table support
> > +		 * may have used a linear table on 2-level-capable hardware, so
> > +		 * enforce the same format here to match the adopted table.
> > +		 */
> 
> The mainline kernel has always supported and favoured a 2-level table, no?

Yes. But here are just a few extra lines to support the kdump from
a modified kernel to a mainline code. I believe we can afford it.

Nicolin
