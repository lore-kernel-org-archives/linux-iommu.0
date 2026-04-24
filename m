Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCD3E7169
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058951; cv=fail; b=cwoAgBG4Ro84vxtq7i/WdAEYLcz09j8y2238BTlzMPT1StLuMnWTPRYL77okZLY9FAFiZZcNbMupP6rbTptCuc5g+woA22066EBH79iubqoKuCf1e5j7Iaj57ZOmMfKnARrRiIt+P302zBExVl5BeFeEdtEX1uA3wVjqw7Rhp4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058951; c=relaxed/simple;
	bh=npXc6h4M3V+Jra0PFvWvY1KI8j6/ZgG37wdhwZI7DWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUze+F7zDP2TfiNmF0+DiMG+WEEAbJKrWYtfuJQRtTvILPA3UBN/qpFEB5dRDLikYlThbJIZgU56dmXMs8V1nHY6CU3o4T6dUziWwtVkdc/2gSzKfrxhjzAsCXvV7vu73sy8slsNusKGIvMXmB2gochbypTFJFAyAidRZpNmROs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PjhUn39S; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PjhUn39S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdRtYuOTBpbeN3oK7JB063AoMC+fpwXRk3uhBeNiy6eu6IaH8e1sNeCgsZNgiPvUv2NukpFWOA6cgcP/flQywEFZYNtO65E2E3ieriYgRyJaavUgBUAt4UGRWUUkvP9DG8+Y1fwG9DYk9hlYbKMXTUmq2WRMFF0VJdoQl7uuTq7JSgX0p45Jz7lWuHBgcnfbIcT/XOO9wm0CypKs9QkaiV1hueEpXjxdtY/qD3cyKFk2xpq+HfFO25KY+yyV953ozpQmd2MTqVBA+EtTEArne1QKrGAogGfnMfEQn0RfpZoop+DaDk0rPArzGPRvKhTW7vu0lsHnOHexP/9lEM86kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsV66KQMR5dB/L0P/yGMLKe0N9P5jNcKCHuuDoN3Uf0=;
 b=SlUO/QoFIC7foo/F2Oq/324svZl1BqrAsZN9hN9nnvawaFsWRi5IQaukTIgTrlb8WDqwITQ4jGvlt7k2XA0VF+h6Qvd3vaS1ya4BqeyDw4o73AC/zRy7KfZX3cN9Qa+EQaRbpgrg87IaTim20IXZ6hfiJpFcC9T4oYTX9ku6oYMsljIffbHlaxefF5oHyS24eC+aK9JKbv/JBCJV3PeqFIH3/tamxi09zdHor8VxEoceTy4PSOXkpn3ScTiLOsjj+40R2DmTfuDJqqRywIgcOjPSimMr/Ue1uTUNhfjPjLCWdSMy8ueE8MKmHgLFixOJNeMFEdl9mc1wZkwjUGYFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsV66KQMR5dB/L0P/yGMLKe0N9P5jNcKCHuuDoN3Uf0=;
 b=PjhUn39SRX3wxTqwgpkita1FBXvNk4jwrrMhdxAxNJgYlMSTZ5FFVZUNrHW4ybl3KTyOnd6tEmEHk8cH0IxsgJ8eLYXrSloCmYDZe4TTM3OsMXZEorMXOPsCp/7afuMxyJ4b+od5VXJyrboWbHYyoRTb+itwTFfFJtask7wvdvyuCsKFjKL3j5tSZ4JipGzOBsaEj/qQPsvRPjlrel2FGJ7LrmBuTRb76Je+z5lGoSci1Bsb4qGj0MIplHVW4okfCivhdlibkSr433GH0GFDz3zO6IH6pKCVhGJyVITT7JB3UeDOvxkzE1dcGKtqqUH04r7h2Fhk40pT4hCfMOTf0g==
Received: from SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35)
 by DS5PPF4A654669B.namprd12.prod.outlook.com (2603:10b6:f:fc00::64b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 24 Apr
 2026 19:29:02 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::17) by SJ0PR13CA0060.outlook.office365.com
 (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 24 Apr 2026 19:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 19:29:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 12:28:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 12:28:54 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 12:28:53 -0700
Date: Fri, 24 Apr 2026 12:28:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v7 3/6] iommu: Fix pasid attach in
 pci_dev_reset_iommu_prepare/done()
Message-ID: <aevEdBqqsoS+yLnq@Asurada-Nvidia>
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <3f1b73fa5162e55ffbe497508aeea1fc7cee6e2c.1776551790.git.nicolinc@nvidia.com>
 <9752ce24-a5f2-491d-b6fb-9e6d81f0cb67@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9752ce24-a5f2-491d-b6fb-9e6d81f0cb67@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|DS5PPF4A654669B:EE_
X-MS-Office365-Filtering-Correlation-Id: 09499015-5e9b-4cd8-cc9d-08dea237bd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6d1DsbbfBM5UY75n+Qvk+Rkxz7ouhzI7yoZGQJy0MkVzBJhYcxSb5mbGX5nM+zoFRYOVLIyTG7CWcqdWeHT/GUM1C0TwCqA1obByUVS+O5MH5cmuA+I+W7r9rW0WLArioHQ9C/BBhoKL0Df9FP6GPJl+TsPcW4sa0XX9Vwk7X6xon0rNJIbjWQ+bgVXJGBrfZUqypFrb4sM47NfwSvkD3iLL9NiNPCo9TNUtdSEjyW7ZhOD1g3W8pg84IGXHO+nLUHIjep2+DWUz0bBtL5crCLGrEFqk5yC/8MtrlS3mbKZtaWiWy+eTma5LhwHuVkxi4gT/2S3MCnOmNfJMIq3J5kQ6zb2GkjCBotn67yemCM4h6D7k4y9S6p56R1oOVOWWggsCZfCdpXMlc3lS0Tf5queNlIqHzAr6QMOSvEXjEnFHpBZJUVF/r1FF2paabL3vWmws1MpQyZ9sR/Nx4thgDijvvsv5WxPvvqlT+5LzsvB5jlVGaLmSkBCOhNCyoGIoN4JUh/w9kA3Tok4UgVwQYA6c/9HWs2cCiPNkccbG8K8kXUm3mZiNt2toadRO94kbQQvhogersKzlmmvmO2GhFi1MFcKrrwwrs29J4gho5c4iM8lqkxBG8gI+Y3xNUrpx1re0H0nAq+HyRC8i1SMXZvtlkDPUDnQ+GgcbMFoUd97RgMRnfLD63L3YXL3ECH0CJU9/xFk6pWTF3X/4Y7vKvYY78JndUw67Ed60wWpM7a55XS84+mz6Wjn2nHK7fhAtnVdsgzZfbv241eJDTgKjCQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0zarR9dYBZy6ikjwFUxdwyjMz/lEFOinVWy2vUfVn4CZc3+WyNsnkLr8l2IgLy+orU/U3j2QX3ihbKAM9Hht2EwpE8wS+5543lgk+CmD/uh/wOmiMTeHaG6MumG5Xh2zVB6E2F6ELmTchsDlEvi9KHlcJOoTvVpMR6kcHtnAFPeHHVPlaKTMhtdk94yYa1jWU29UXaPaOu1/QobAGQLFM4NbraafFVndt/KZ5je9EHPpxcyTUTrKU7V9DGnxTk5HesLaBJEoiCmVA5G9DtXcsYcREuzFEi/sWUb+TZix6zaCI0sA4EyIw9ltvWmIfCjWTfkyiYlNB2t0BBBV3zdeuxyFkQIaPzORVoYblWIB0RkHA8stJkApCX6PkZ21cJheslGqrb8watoQZrqjV4mXSfUJ+nwQsLBmcfd7xl21cTn+3jg7o7EL06vukJLJis2F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 19:29:01.7452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09499015-5e9b-4cd8-cc9d-08dea237bd66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4A654669B

On Fri, Apr 24, 2026 at 01:49:52PM +0800, Baolu Lu wrote:
> On 4/19/26 07:41, Nicolin Chen wrote:
> > -	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
> > -		WARN_ON(__iommu_set_group_pasid(
> > -			pasid_array_entry_to_domain(entry), group, pasid,
> > -			group->blocking_domain));
> > +	if (pdev->dev.iommu->max_pasids > 0) {
> > +		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
> > +			struct iommu_domain *pasid_dom =
> > +				pasid_array_entry_to_domain(entry);
> > +
> > +			WARN_ON(pasid_dom->ops->set_dev_pasid(
> > +				pasid_dom, &pdev->dev, pasid,
> > +				group->blocking_domain));
> > +		}
> > +	}
> >   	if (!WARN_ON(group->recovery_cnt == 0))
> >   		group->recovery_cnt--;
> 
> I don’t think this patch fixes a real-world issue though it has the
> "Fixes:" tag. Logically, if pdev->dev.iommu->max_pasids == 0, there
> should be no domains attached to any pasid. Consequently,
> group->pasid_array should be empty, and the xa_for_each loop is just a
> no-op.
> 
> I understand this was a result of Sashko's review comments, but I don't
> think it worth a formal fix. I admit I might be overlooking something,
> so please correct me if I am wrong.

The max_pasids check is a small thing, to match other callers.

The fix is replacing __iommu_set_group_pasid() with set_dev_pasid(),
because this path shouldn't change the group-level pasid domains.

Thanks
Nicolin
