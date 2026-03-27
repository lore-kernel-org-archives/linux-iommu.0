Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C43932E2
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645730; cv=fail; b=Tnw575k9PHLQIzkR0mn7vVNBWQEbmYbgpu3X96Ya2pbHZ0bTetDJcJ6YrMLMPGx+NVg+aPX3SUt6wn/okTWGUeJ485vmsJVcHWyEimwVaC3sF0Jo0iJ+zbF+y9G3XhzJGjkzZRfJ9Df8N6EbAdr9M05NguuxkRxdiLXGXaH4s10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645730; c=relaxed/simple;
	bh=rdv+SMTMScS9iIiEL1xqvqFAx9cgZO7RfnGDlDoJWPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh72v5jI3jHc9H7eo87WmD84fPrcWmmNdRxz8hzyD4n5mF6cdPavBsPxdSNpI7PgS76H+Mm+7KDqsMeDT04cbfKu1Sfkp51bUJCip0S7Giz9pzUqrVX8F/EIySxPEFXfiq+sGkAhHFwc3cWJnw6MzekTufgEUdcVU/htGHI4u4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QgDUvLsm; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QgDUvLsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+8r5COwLSmyzJD+cSHLcl/nc2Uf1lKdyxiMa3mx+60OoqPAaQBWvPMX/5CmwFvxooAC9Im+CwZ3dlkwbb7McNaFZ+UvdWHdB/iiPVIrXNcNJHDRlQm4V8z0hByCstEYrbfr3LM9ZztkRKxKEy8jztBXo0RJo/gvTrP5vyMpktc4QzCEre14/Mfq3btvzMIf+KQqCV/AACGqq+uUu8HwrYIhiPVxFyHRmSw5WS72R5kVGUqGYveY22ObvU4lbmua9DrRkmXDZi7yDM3fA/C4nx2PtCUFalhe5qLeUcg6+cdJnLt2UTzx9wAPf6szfYCQrr2517ShsSpO9GhJHQYziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzR3Eq953vPl7kYoYD3geieK0QE5uJHaybqOJkgHiD0=;
 b=d/hvWmUsMK6gacJBvb1kaipLiy4IN3tlDUbiYdkFJapPwEgAn5o6D+t7W9dXEMCulbsK0pGmvorGREdzhmGofsw6+MFXYe+g39fQ4CmFFXZFK+g4i8p3CUGxkFEPGajQ4ZlVbdH5f2LL6XBihQFd4wLcllIdlcUEIZF0Tkhu6TxZfqHfUCRzuYg3XacQLypKUAcVO/4lh7QwCmBC1xle6emYe5KYHyMwn5haWM3FpDb5Ppc3jUe+A9n+4we7fb2qiUvXecZuDRCVuEqegVzfJncKtyPSbiWRyLI594DKHgd7SD3F2reFgzSEOdURAGiwxdfYSB8ryWytpBNhF1X/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzR3Eq953vPl7kYoYD3geieK0QE5uJHaybqOJkgHiD0=;
 b=QgDUvLsmk33fAs9flhx0mt+YhLjwu9GbDNApz2n3wx2YqXtnBLdZcbwV369gBD7DuWESwFaWbn5nwvQiR/ofqOc6E2US/4iZNBVHBshUVhduywz3uE976Pvj1yMMDE6VwdnoLv136NWRcroABSNtG8kisc2VaysuF8p9BeHKa7bmZrT2rVUOmHuuO8x6eCpU2RpYfDmN7qJA9oqesIWAKAdfnnJ9Rqgh/dkWT/x0klKI1ikYwE9TEdUmAjsXKT5rEvBUGur4COeFkJk5wV+UB9gzdAHckkUy/PmN/aAjMupU2tnPAp5Fp8h/v2vNFjwzgoDJ2/unJz2oY2mcxOcU3w==
Received: from BL1PR13CA0162.namprd13.prod.outlook.com (2603:10b6:208:2bd::17)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 21:08:45 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::eb) by BL1PR13CA0162.outlook.office365.com
 (2603:10b6:208:2bd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 21:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 21:08:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Mar
 2026 14:08:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Mar
 2026 14:08:35 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Mar 2026 14:08:33 -0700
Date: Fri, 27 Mar 2026 14:08:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <acbx0NYGq6BOiSDl@nvidia.com>
References: <20260319043135.1153534-1-nicolinc@nvidia.com>
 <dd72f3be-16d9-4386-82ac-1b8e06186e3d@linux.alibaba.com>
 <abxr7XrsK1WSmr7T@Asurada-Nvidia>
 <BN9PR11MB5276A9067B8D8FE3CB899B2F8C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A9067B8D8FE3CB899B2F8C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 472041f8-9c1c-4b6d-144c-08de8c450825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nBYoVtOZ6hAjOA0d71rZBRpZSlwgIaiO6T8TKw5srvmNta8rF1Yh4I1tk9A3NKcSO2s1pxXN3feggxUZjW9XAj+oH2W1HqHT9r13eAUXT4sUgXXgSbhR7+9M09ELMNqmIqlkxJTjLnzSIt6/4KAo5/vDkAWCMaqByZ6n+x0RuC0mX+Qw5NKB80/2bn7SARXnNJtbRBoRjC3fGRWL3Git7j/bT73jVhxJi8Su6IyCvgsVPdIWWKWkIUvk+e6lSbhjnp+WRdPSiK76870ODxUBt8DKGMNRghxM1cbvSFzkzWYnPS+yYQcD9KqIkAqJPq/rurYhByPeEWUJcKTqUlPsSrF41J32tzpSmjcz0N1if3orwJL9GKJJHtWBXPBMfTOnV6xElzGPK8a6zLlcrsQLJvFIb391eYCJw2F6HaU3bwSceijUyKdeGohnuhCPX0A/F49CFZItnUSuFJlDA3KaU4XSvuzh4CB0B1W27jFlAO90BmNqdu0WKmFrvSzYxFpZBPbcn5VawdmuWMw5BY2RvFWLZuMzJ1kGMPMTMfRVsj5tvaIGiA46e0dvT//H7ISdWJ7j88DNBBaNsyUu+FoEyvA++LfhB68UTGoRRujtfs2Okrpd1ea4aIihO84kbU1errCg+6iEOnBU+l8bYeTH9t5XDHcCMv0aWZAK+X0cWISLfdaLgM19/V9reqdWwnOu8E7CFsz49FRqM7QAq6fZWCmaoK6mgecn/SO2zRkCnjFCPnity4So7e14Aw/jTdSKjQP61QAK0uiN2a5DsWsGYQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lc3KJmKKn2N+mZAV4+qp/PCgC3HsWqo+UBJUe+9nzSwArUil5BsSdI4I2RHZbfXYGPMaGEy4c/2/J5SYGQEj2MedNZlAm5R2jLenvlWXaNwHpU38DBy7E+M6Kgd0Cr8CBPNuelrflPBG6KmrRjbv7UB0F0p8uYKmhrANXnn6GUJBThjQo6/kADNSbFzHGtzigIOQNS+RNJdwzLf7tzj+KpupO1sWyAcjidY68/WfNiYpoy50FoSoMgO0N9xYd3kAC3Pa/tJYUEYIeQSLW++nAJ8tg4FiADWapD3ASqheo79GZwtjqlAJh1v7NCgzpKvUACwrI4/Vnr4QaBb4Au9+8HnFaZg0+nRxCrg14B8M+StTmt5MoTfyEcLz73EdWKzst397WBsnKNETyibOvJV5HOmmGCtsLgR3G8WmSW8p8HN5PtISppJEjCMaPEzF+uVS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 21:08:44.8575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472041f8-9c1c-4b6d-144c-08de8c450825
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

On Fri, Mar 27, 2026 at 08:27:12AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, March 20, 2026 5:35 AM
> > 
> > On Thu, Mar 19, 2026 at 07:14:21PM +0800, Shuai Xue wrote:
> > > On 3/19/26 12:31 PM, Nicolin Chen wrote:
> > > > @@ -3961,9 +3962,10 @@ int pci_dev_reset_iommu_prepare(struct
> > pci_dev *pdev)
> > > >   	guard(mutex)(&group->mutex);
> > > > -	/* Re-entry is not allowed */
> > > > -	if (WARN_ON(group->resetting_domain))
> > > > -		return -EBUSY;
> > > > +	if (group->resetting_domain) {
> > > > +		group->reset_cnt++;
> > > > +		return 0;
> > > > +	}
> > > >   	ret = __iommu_group_alloc_blocking_domain(group);
> > >
> > > pci_dev_reset_iommu_prepare/done() have NO singleton group check.
> > > They operate on the specific pdev passed in, but use group-wide
> > > state (resetting_domain, reset_cnt) to track the reset lifecycle.
> > >
> > > Interestingly, the broken_worker in patch 3 of the ATC timeout
> > > series DOES have an explicit singleton check:
> > >
> > >   if (list_is_singular(&group->devices)) {
> > >       /* Note: only support group with a single device */
> > >
> > > This reveals an implicit assumption: the entire prepare/done
> > > mechanism works correctly only for singleton groups. For
> > > multi-device groups:
> > >
> > >   - prepare() only detaches the specific pdev, leaving other
> > >     devices in the group still attached to the original domain
> 
> no, attach is per-group. all devices are changed together.

I think prepare() should use the per-device ops:
    ops->attach_dev (via __iommu_attach_device)
    ops->set_dev_pasid
right?

And it is intended to limit to the resetting device only. Other
devices in the group can still stay in the attached domain, but
they cannot do new attachment (-EBUSY) because that's per-group.

> > >   - The group-wide resetting_domain/reset_cnt state can be
> > >     corrupted by concurrent resets on different devices (as
> > >     discussed above)
> > 
> > That's a phenomenal catch!
> > 
> > I think we shall have a reset_ndevs in the group and a reset_depth
> > in the gdev.
> > 
> 
> I didn't get how the state might be corrupted.
> 
> If there are two devices in a group both being reset, you only
> want to switch back to the original domain after both devices
> have finished reset.
> 
> so a reset_cnt is sufficient to cover both scenarios:
> 
> - nested prepare/done in a single device resetting path
> - concurrent prepare/done in multiple devices resetting paths

Since prepare() is per-device, the per-group reset_cnt wouldn't
be sufficient if one device is resetting while the other isn't.

iommu_driver_get_domain_for_dev() for example would return the
blocking_domain for both devices, but physically only the first
device is attached to blocking_domain.

> v4 is way too complex. Probably it's required in the following
> ATS timeout series (which I haven't thought about carefully).
> but for the fix here seems a simple logic like v2 does is ok?

I think v4 is the way to go, unless we fundamentally limit this
API (and the followup ATS timeout series) to singleton groups.

FWIW, I have the ATS timeout series updated (waiting for some
finalization of this base patch):
https://github.com/nicolinc/iommufd/commits/smmuv3_atc_timeout-v3/
The new iommu_report_device_broken() is changed to per-gdev.

Thanks
Nicolin
