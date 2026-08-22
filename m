Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623D37754C
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430433; cv=fail; b=sX9PLXtqkdwc693c1gnJ0An71u7FkeXHmHhjZ+fAoInOD2A8zxp9LwXcTBz77lfGnuvNqNNKFv8SjADt6RT96NDVXqk/tnDQR1hIBP9TRt+jQcdYNGe+rT/O7CLSQrziQxQpt8EXwG9s2t3WK6DkyLInbJ1IZWkxKC1m6yCsXFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430433; c=relaxed/simple;
	bh=UroosclFXJaip7b2xIiH1V6vsEb1cJ0ds4sZ2/Q17JY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjgqmEhZSZVUKfwVa/8dY+R2yqi3XITR5u0t+QQ0/rihfX4ZBcX0fyep25iBRTLgc+2eHY1UHYRYnVGh5vRcWECDUua1ij6pqY30+kZt0nSu3ddtwDzzPu+Oas0tYtu5/fTGfiILq9iX6q5FSUlaI7yXkA6XPgP6g/r+wbMDOes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q9BraXVg; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q9BraXVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7nlH4etPUHk0PlMKk0mKYlJuFalfH+AeSxHxkmdmD35jaDnTONbHI4bqaTM9u42jmNItXrRnT+PtW5ZnUvw+7GooNLc8IA9kXreuNm0BrkyFAS4SJmuHN7IXB/PzRn1ZzccC4GGvSCrtAoCP+kzl6jHWBZFOL+vqcuZmm1eepPQr9DwP4yUNxzVmPlhyKg496Tzw0UxNsajsBU6XyckMJGh3ZWSdPUtU9sWhwRYfpiIVn5laVNvayEuvGbclVJnbGp0u5tmVX27fXhXzbp2dzKy8lu9kSQTqHpaTj5jBtlF8cYpnZARn6e0J/SNU/8eZt2/q1jOhm64uNcmXy1b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWRENgTOsPYvmo7Z5UzYHRSiUSBfxxS3AoboGFqA/hA=;
 b=ljsQXGjjWQr767nDFYRHAFkyeOGHpyQrqCkt+F7qrFtimtI6592diS1A6yv30pe/gb8M11SKQDrijgvIhkspke0t7XtzGquW1j2uiI0nFF/k28ttbFTeCF3ocxvFRKMat8mHWwK1TgopryF9XCeoRVci9Ptkwk6rUe4y8XIvKmMySU0GgvtUuPTubMh6jApu1YDtG/H/8yBMyz7hvkPeNRdyX8nM5+YbL9nStsL/WpY1zJFAocbcr8TMWRdgbh6o/IkRxp86UAytCHPQQ00wL2Eh0rCYW9SYwSHNXBwXyyeftm3LlI8IGwEnFYyp9XTq4/fJAGwGUsxkS3Xkmc80Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWRENgTOsPYvmo7Z5UzYHRSiUSBfxxS3AoboGFqA/hA=;
 b=Q9BraXVgksh2FFvhMp9x/aoN2OzfIADL7vKvT2CEst0Wi5HdtTxiT7o4Z2YRpKItRY/mCB6gFcGYc1WS/1BWJenVF0xI5c70eaiiXG8guy5S/Orhyg26aZWNRzyDvKgbpiPLnxC4iCgPtVtuAMKpD8YiCoO2xqu7Rlbo2A9BR1462fU0rQkY4U86EKvChU0dkiIZcj2t4bhQ1IBvgAOnubqe9JsYdMWRe3YUwMHf5vcSv//whQgQNmItG8wvuWxMOeCWZ2pvUFyJvzbZ/s/bTky0C5HU5B5uJkYRRVOdCg5Ghnk2Lz1BxgkfqmRsIWdzEEDRQf3v/lHha0fUCd+njg==
Received: from CH0PR03CA0400.namprd03.prod.outlook.com (2603:10b6:610:11b::20)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 20:27:05 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::24) by CH0PR03CA0400.outlook.office365.com
 (2603:10b6:610:11b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 20:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 20:27:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 13:26:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 22 Aug
 2026 13:26:53 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Sat, 22 Aug 2026 13:26:51 -0700
Date: Sat, 22 Aug 2026 13:26:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3-kdump: Implement
 is_attach_deferred()
Message-ID: <aooGC51RH+ln4YFz@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <eb795edf2598c6df57122cd5951393ac1a860bcd.1784663184.git.nicolinc@nvidia.com>
 <178735412602.18212.5709943748630447883.b4-review@b4>
 <aonng6MDJ/s/MRuE@nvidia.com>
 <20260822200226.GO244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260822200226.GO244917@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 535ff67e-f138-417c-35ce-08df008bbb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	qeHDKyclv+bJYLm9cFawakjBUiMm2TiAh1TxZvW+FCwXZ5r2U6m7hG95MPT3kLodj1vNIuAa6QDC76z1Gdq5MdSQziY0MGlPnxcY/PoW54Wd0S6kASj0B+iIhTtKlSNn5EXw4mQjRZDfpchARF6VPplOz/DJU7sTd7LzOcJ6smsbucE3KRUMkbxD8C2lvSR0qL9CsppqQIwfjTUCoop0snAp0qi488nvYaeQiJqZ9VYpS5hR1Dziu10U83OiizZmSy7Ya7I90qoCGXnDGg/qGdBHg14gdD2IYLhx7gLjUywvtccVP5bpajbuUhcuqBZOyYeqhP11+bX4nWsyamyRuiIaNGUnUcd22pb0VWciThA2VaPFKmw93JVMkzCsS2UoFiKezmU7RBdiidoLxOXilxxKcJ4Ozd2ppo/FIQhmTw40iD9EEcIf+FvnAia8IKLeIprNga7G7QNNnC/Xrfyo3YvWi3bFKnOrmtl7BzUzc4me0sG5kBDpGsDrWEq1rGUUvCw6kqFs7FmsqG5OGn6DMOtYj98VXHOvCJTuK0XBeINP+t4uekSjlAaef6I63bAZ41hxLMxa1R0TGcYIO90ZureFdXw/aCGDZgoLBfd8fy7Yq52Ra/U6kzIt4fPZC0oqZn2yujATyvW6Ct8izvZzIiuuN+nuktVNMQH36lTp5JONdm2WkEuaHrfA/Q7WgMUaFSv3sPqnZ13vMu9adB1utg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2GDSPbZinjBsO4vxzpsFuPd1eLQqKPnYkqOP+Zhp6q+0Qz5StwGtoA1jJN+UL5BVwcngfkDrsZ/uzsQYBCbhlWSqwASjxaNMJISnSA9JKk148nNICpXZzII8K7Ot0IjTOS1uQ2BxoXemFsXqKODlDihp0O1oBSE3nRUDJqLt7CWjZzbkz7HrhKwsXsqJc7z3VegeMdF+CLP6fVcuPnrx9CDb9YRuWkQkXypnqI9//XMMX/+X4IF1wVjj0zCZBT58qCca8NJc+MU+Xd8DKPwfL0cfvaJBbm5Oe9XkFWvCViqf+VbWHVeLPOZR65WVUWwhZndWZPPT0tsGnJ+f0c+KQ+Bj2NZ44q4QRxGyuNK5KOvceNoOHi2tv9pfutAuKujFbofDQglmM4sQMy0oNQw4Ey5McDmlmLjnGOjNE8aJhk2vln1Ee0z+R8kgV5N+PCps
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 20:27:04.9231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535ff67e-f138-417c-35ce-08df008bbb2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

On Sat, Aug 22, 2026 at 05:02:26PM -0300, Jason Gunthorpe wrote:
> On Sat, Aug 22, 2026 at 11:16:35AM -0700, Nicolin Chen wrote:
> > On Fri, Aug 21, 2026 at 08:15:26PM -0300, Jason Gunthorpe wrote:
> > > > @@ -1276,6 +1292,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
> > > >  {
> > > >  	return -EOPNOTSUPP;
> > > >  }
> > > > +
> > > > +static inline bool
> > > > +arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
> > > > +{
> > > > +	return false;
> > > > +}
> > > 
> > > 
> > > ?
> > 
> > This is for !CONFIG_CRASH_DUMP case. I think we need it.
> 
> Hmm, I am testing b4 review.. I had written
> 
> #define arm_smmu_kdump_is_attach_deferred NULL

Hmm, I'm adding two-level is_attach_deferred functions:

arm_smmu_is_attached_deferred()
{
	if (OPT_KDUMP_ADOPT)
		arm_smmu_kdump_is_attach_deferred();
		// internally doesn't check OPT_KDUMP_ADOPT  	
}
[...]
	.is_attach_deferred = arm_smmu_is_attached_deferred,

So, arm_smmu_kdump_is_attach_deferred cannot be NULL.

Nicolin
