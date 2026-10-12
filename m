Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F93B4EB2
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849321; cv=fail; b=YN/8LoaLQxplmt27bbJavE9dnT1BdktuSIbUuo6eRqxgjRoY9QhpggskSyZRjEzsgDNlAieSCzXY5mZe+RFGC5PgLe5xtMmqqiqkIu9ePm6Z8H5iOcruMT9eQuVrqMxYmRwA2KKFyvZa/nXM2cAGnY4Z9uLrAhlUzmLJnfqBO7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849321; c=relaxed/simple;
	bh=Hx3xASshJJj2GaIyc48ze0EUjuGk809iaWEJwbkOvXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4QscbCfLSpZ1H224bcY/wrZg2FE6Y/IscQm5H5uz31XdYlmfVL87zy4lrnPnzZKzy1qTbuJgmLmYq8lCqLBegWzOq6dF0yl3vjG1G/jzbQRoaTKPfgkVIs9/MS0khYNH8+c1tpmji5yEdiWWgtJACWEAkptg/dYtoIbSSb3mDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lzm9WyOE; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lzm9WyOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2rmNqc/uFkdh9rkv+ex9C9vyu9z2k3eimObv5qsziIn0PZsuhHDjdbCflt3oGTPdf5Da/LRl++Mt/NTfr583vnrCvQylMRhkkF7ybCpcvMUNE+CcJ677quHU76Qpb5sNz5lrQkIBe/gRTGFIpegKJ+t7KMe8Fpu18TgVIkAeaP3vslK3mAbucmDN4/V65Ia+fLhmAOqwpKLHVzgIcUYfGw2XxP8QRKCWVVPBygzrPpeqyQUFzP9aCaUWLUkQcH175LI7eol1uwjEL116BEV+iWbRPWlbLd4+GPim3GcApFS8KE4n9cQZKq6Y/YM2QCAaCp0PJ27r6FEJ2LBn1oQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+y2Pap08gETfDY6MDNtv39eJphi7NgwKnhQgjqRVRI=;
 b=vvpI8PphmF29epsenOiZfrZJkq3a6jSF3wUGzeeNih2Cl0A0G9X4k3FAa87KVNXHNyIeM7od+OVRMkJB2c39NSstAK1H3jnooKmC52vqE7LdohYt0IsESWztez5U+WpFOfDxbdnca0TkQrAKSEBGiSQeg4X7c82lHe6hkX7K5TDGWvlItGNPhqg+sa7xH//6xURevPKDh4I338HMW4CULprSShjtEk0ENirVGgd+ogmAwqGnEIn6PUbQMFOK+njH2ElgCSEbjbRrP4kc9J9oUb7KN/tmfbKQz2OQnCvlchxYzseNP95RR0Ukl8Kgyl9Rx/xFps8pa+QqvHCWoGsaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+y2Pap08gETfDY6MDNtv39eJphi7NgwKnhQgjqRVRI=;
 b=Lzm9WyOExxOCW5A4m+4g9RsJx486Hvi2HZYFccxgi8niM2w+iWNj30B3Ybl3Ucjjk1+pif8A6YEb8m8MsvdThi0F2E279uXEm1gvgkykgX4HA16jlt2yuTV238exPR7S2sbAginS4ysypgmIezpjswOoSRGCReqGShw596EWSzMhTY1YcXk2Xp4Bbuy9iNwUP9X7JiyeEF/b6FCbWTVpQ7G55pj+FmGmZMSV9O7Shpv1S3IRJey5e9upgTVUmvz0aGsaWnkThvDaNY15Enp6yNORgtKO1blmiu4vrQQRy6Hybb2EabqrSqXWVivaySZtb8fMrapje7kzpcorKor/lg==
Received: from DS1P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:44e::18) by
 SAVPR12MB999168.namprd12.prod.outlook.com (2603:10b6:806:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 23:55:14 +0000
Received: from CY8PEPF0000005C.namprd21.prod.outlook.com
 (2603:10b6:8:44e:cafe::2c) by DS1P223CA0027.outlook.office365.com
 (2603:10b6:8:44e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 23:55:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY8PEPF0000005C.mail.protection.outlook.com (10.167.247.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Mon, 12 Oct 2026 23:55:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 16:54:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 16:54:50 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 16:54:49 -0700
Date: Mon, 12 Oct 2026 16:54:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <as1zR1wc7ERxvR1F@nvidia.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aszfVNP6DGzWYdK0@shlinux89>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005C:EE_|SAVPR12MB999168:EE_
X-MS-Office365-Filtering-Correlation-Id: a2252448-b9f4-4edd-1558-08df28bc425d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|261009223027099003|3023799007|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	uDRjO7NlcnBIb59Bq3adGFa+CDgUuOVAOLh3KjVz0EU/JnbdXyY8Ec07kVWCWWy6g8oCkGHmEp+A9obbOegd5LK+ih1o3bMX40YJItTcVMssBhsWlTC0Wz7Dxa2/uaAKKbq8+aQK4AHvmSzZNlcFUroOBuHlJ/BBiz6Q+k5RwDdtfAmoVaf/v/m8lWPnS8RWmZV5xhPtj3wawBBZJHkPgUM1CHqeyRHMtdSA4k4SQF1xlBKuTDZ/4PLVkkv9UdeDHRdQ1Wkpgig5ukPO6QT7gYfvnV9genVjABiWw5kcfLAGo9V2PIR8NEIpi0UtD2k2S+bE2PTy94flqxKHEhCCn3E3gqpYVzwdmDY3aG0qUvucx13TWl40NcawaQiMw38STdFzbJK5wfKXH9Z2J8PE09rmointGPSPbDWjYH7/ycXJo3zd/TwFItHVRnEuUQQKZbEwO2DzRo1Oqj0ZlVVR+ipkDJAjPQbOFydL6Uw/cDtTOj9R2OjpNNfQiV8Sokk3L9JPLMhIA8Fg/rVeGOYA/j2XDACZ7dHnoCykb1zbBK3D9hQQSSRn5w4X9OOzI3Wq1Qk151xgHhIrglYNkpWZ03Yqus6+5ZZbwER4XD+5IQ1ZD2He3+lFFWoEfQv474954WpUlQDWbhlKEXktemiFog5dO+uGa/c6jnyH+5hRDEywiPw2QIQYxMOrK6SWdxZz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003)(3023799007)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aJxvZMyc0ZVpsjW8x8rei2p9DZbs4uowDHUGbIERETT74ZyRMOzDSalauUZF9GJgg+zmCKEDdhFx255J5u34jq1vVa7Giw1OuEyWPARaz6RP8hhjm5OZr62+rcw3b9UtcuHLohsR4eCNsdIQPGw7xw3kESTXbMrO+Cv14e/EjnrNUyIA+MDNmxPhswhCfdvHAciNLiaCHsPQrfou1t6q0nU5CVgZI8slrUbE8Pk72KWCKuc/+ntdpcTAwNOLcGdTTuK7vk24zygY1fdDJyXLzG5vHm7jj9F9IrMXoLLIRW67sFUBTxfLVQyMajZZXl8XftmY/RqTWedNs8N7/LLM6a90NsKZCrwfkrFxKzoeX/LC0fQxIfdPiHQQTUiJpwlZuRH/0UBcczYYFghgShOzOgy/CkgIwmuJFp0wyi4i7I4MPMfLvvDsHs5Xzx9wPe6T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 23:55:14.0607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2252448-b9f4-4edd-1558-08df28bc425d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000005C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999168

On Mon, Oct 12, 2026 at 09:23:32PM +0800, Peng Fan wrote:
> >+static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
> >+				     u32 sid, bool is_abort)
> >+{
> >+	struct arm_smmu_stream *stream;
> >+
> >+	lockdep_assert_held(&smmu->streams_mutex);
> >+
> >+	stream = arm_smmu_find_stream(smmu, sid);
> >+	if (!stream || list_empty(&stream->shared_masters))
> >+		return false;
> >+
> >+	if (is_abort) {
> >+		stream->ste_installed = false;
> >+		return true;
> >+	}
> >+	if (stream->ste_installed)
> >+		return true;
> >+	stream->ste_installed = true;
> >+	return false;
> 
> sashiko has comments: https://sashiko.dev/#/patchset/20261011-smmu-shared-sid-v6-0-cb76b89dc612%40nxp.com
> 
> We just need to support a simple case that platform devices(single SID) which
> could share there SIDs, such as MMC-0 and MMC-1 share one SID.
> 
> Shared-SID masters are restricted to platform devices sharing a single SID.
> SVA, IOPF, and vSMMU nesting are all rejected for shared-SID masters (patch 5),
> so VFIO passthrough and direct domain replacement scenarios do not apply.
> The only domain transitions are the default DMA domain attach at probe time
> and ABORT on unbind. Or I may miss something.
 
Domain can be switched between DMA and IDENTITY via sysfs.

I think there should be a way to support that. But, without a concrete
use case, it might be easier to add this into the attach_dev callbacks
(except arm_smmu_attach_dev_blocked):

	if (arm_smmu_master_shares_sid(master) &&
	    old_domain && old_domain != domain &&
	    old_domain != &arm_smmu_blocked_domain)
		return -EBUSY;

And Sashiko's second remark does reveal a real bug:
"Additionally, when devices are detached from a domain, is_abort is true.
 arm_smmu_skip_shared_ste() clears ste_installed but unconditionally returns
 true for all masters. Will this cause the ABORT STE to never be written to
 hardware?"

Given that your use case always group SID-sharing masters in the same
iommu_group and attach/replace a domain on those masters together, I
think a simpler solution can be to always let stream->master install
the shared STE.

One pitfall would be the release domain's attach_dev, which would go
through arm_smmu_attach_dev_blocked() just like a blocked domain. So,
it has to skip correctly if the shared stream->master == master. This
means we might have to add a separate arm_smmu_attach_dev_release().

And I realized that there is another problem in your design: the CD
table is still allocated per master; see arm_smmu_alloc_cd_ptr(). If
STE is shared, its CD table must be shared too.

You'd need to redirect all the master->cd_table with something like:

static struct arm_smmu_master *arm_smmu_cd_owner(struct arm_smmu_master *master)
{
	if (arm_smmu_master_shares_sid(master)) {
		int i;

		for (i = 0; i < master->num_streams; i++) {
			struct arm_smmu_stream *stream = master->streams[i];

			if (!list_empty(&stream->shared_masters))
				return stream->master;
		}
	}

	return master;
}

> >@@ -4360,9 +4391,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> I am thinking to simplify reject if stall_enabled is true:
>  			if (list_empty(&stream->shared_masters)) {
> +				if (stream->master->stall_enabled) {
> +					dev_warn(master->dev,
> +						 "Shared StreamID 0x%x rejected: existing master has stall enabled\n",
> +						 sid);
> +					ret = -EBUSY;
> +					break;
> +				}
 
I'd move it upwards: next to the existing "num_streams != 1" guard.

Nicolin
