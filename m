Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC35026B
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715553672; cv=fail; b=Z1nvj1tOcdWA0c2/O1TMlYD0IPAuLU+FsydwBlg08hqZrSxHSra4ElyGGmHaEcJqXpuLD0UHC5+5kTBYfctnQufZUiTuFt3Oj+byZXreg8SfbTKY/XrUeliYPaLJHfDcKy9nRAMJrsgCm9EtYoAL142hQaJDU9xizI7edkwG+4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715553672; c=relaxed/simple;
	bh=0wvglfsCisHETur/IIJHcbVPfOMUeAn9WKIPoxFOsT8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEN/FVz2Hy4OTfh52JAFfhZ52Om1dEWT+TI3UIAslXWis/s0pypERlaJjyHed3cwq8H2NpuqUKtCy4AwvUM0wWUH9Kv00SukI7l42gPgd4TI1k/pOsMFF7SaoG9welMjvCpo4jsN+oTHwzaiB37ic0uFqEdr6hZ+S+yR/+qL48o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NId2LPL0; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NId2LPL0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVhXO9UcKY3V3XFrfegWCqd0rnTi4iB1AWIdsMxVDHKdsJH0i5RrrxGe2si9dNC/IXT3f6RBwODNhBbT4OspFZMArObxeCZ1AxjHOZGtG6l3jeT/KkReatTDuzPTZQJNnvIteiOWOejCwvIxHwlTec+GcgIRgysU0wKaauNEfduGUVN2/xvr+CLf+jhg9dJPQDHIjO5aT7vxQhLiKPfsHciR0g+NsQY+0HxYW2meIwnDb5OtM7NDTJ73KnALHAb6T8JMbmTKuheRceU9ptVWscR3DqxBfnHmPB/rUMK7sIX9n6pFfEyAoIkA+GKdBoqmP2nAOsZNPRats+0/uLh8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdCVOJJD2SkDez0i69w3vIIU2HgbrzrVAPibWIyJDHc=;
 b=cr21i8Uz1zphmOOT4Tt5QA1aaLWBYh+eYnYoXMBw8Hkl4+9tTZvdD2P3gHVzO56iEM4aaN2NLwv9IsEJj2P1UKc2M3agdRCRiN2dHVcBTWe7Vel1W53qWPk1qO/fSrKuTeAwrlyHe8oGoBGSSBZbn3aL/gjjhKnyInw2y7yziFH9MUkNk4ust8t5QizefPCGKA++bpoiBjFZn+TFpneBgTF7ber9U/x55IeZJhqXATtnzYuaL44XQz2g9595A2BSuQuDLDngpbG0qJvg+YY0ni2HAch+DFNAJEtct06NREw9FqN0q4nEty4ZuOz48BgjigQuaC5iG0NqmwU8cmEMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdCVOJJD2SkDez0i69w3vIIU2HgbrzrVAPibWIyJDHc=;
 b=NId2LPL0u4q0nkY9qE+5HETOWiXUfZxK1pMGE2+OdCO2AYXHE95qot+6VGuYlCEHzvZ8f827TpQjXZjAXw9eSa4c6XKieAKrpJsjYWmTuclxVpVGo1cSrUkoHjMHPyHLFW6QCepI7bhKMohfIEWvrS5+R3FW8CCSHgfbpbX/l1HgeP0mDaA/X6mueXXMwvyb5Sd6RhtgstPAcTIvGMzdvjuwNRkZauduLcvUqkoiFqfJE0DSx0tNU9KkBZdPq37rk3VU3c8mV6Nahi7ZBEc5K5D2MZYHDFMQboaepc4VgvwYEgXwl2ZxTXZ5uyl4/6noD7PwHpSF8t/uXelauq4jWA==
Received: from CY8PR22CA0006.namprd22.prod.outlook.com (2603:10b6:930:45::10)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 22:41:03 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::6a) by CY8PR22CA0006.outlook.office365.com
 (2603:10b6:930:45::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Sun, 12 May 2024 22:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 22:41:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 15:40:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 15:40:51 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 15:40:46 -0700
Date: Sun, 12 May 2024 15:40:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 01/14] iommufd: Move iommufd_object to public
 iommufd header
Message-ID: <ZkFFbIiXBEQH+2Fd@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <09e84c7c9099aba07b24b113c70d57d4574aee08.1712978212.git.nicolinc@nvidia.com>
 <ZkDCbWv1DFH25mnh@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkDCbWv1DFH25mnh@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: f26ec14d-3205-44a2-4e69-08dc72d49ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nktuc0lQSjdPNko2YjFhbXZPL21sSUhFK1VnWllzZUx3MC85T1hUWXN6RGdm?=
 =?utf-8?B?VGZUaTViNnhsaTFsb3g0WWtMWU1mb1hkN0x1S29Ia1ZIWElPampUQUVOZGVW?=
 =?utf-8?B?TElpYVN0NVNhNFkxMC9CNm9HZzZQMlp1Ukx0Y1pJUmlnbEpYNkc5aE80Zjgz?=
 =?utf-8?B?RDZ3ejJoaGVQMUR2RnBVYUFIdnJ3N2VsbWhzOEF5Uk9ZZ3REbzg4YWZUY01Z?=
 =?utf-8?B?dk1Fa25LNkgxNDdlWW5FRjZWWTY4NlliVFpYZUdIYVZ6bThhSElVTHBaQW5V?=
 =?utf-8?B?c1hUakVqaFlYUllSeXpyOXhjOU1ITVZldUNJK2VvZzZzV0NrcFRDcitmQUlx?=
 =?utf-8?B?NUVqd0VQdDEwZFN4cktXbFFzT1JHRldERURJYlBHZEZtWUxwMlVmNDBjOUcr?=
 =?utf-8?B?NEp5cHZSOW9jN3V1d0p6R1JUdUM1K3l5alZwTVdaZmFtVk1PdVNOT20xTHpT?=
 =?utf-8?B?VkJ4ZGNibEliUzdWZ09rWjJveDlNSmtCSm9PaUtUV1E0STFIdVM5YjFJZFRR?=
 =?utf-8?B?blZQaU05MS9jSG83OTZJYjNXbWsrMXNFMS9qbDlrVmxyNnVjMzhZWGRUekhr?=
 =?utf-8?B?UGF2YzNPZ2VhakUybGVqelIyUTZrU094S2RpWUhTMTROOXdZdm1CdzVsdFpU?=
 =?utf-8?B?dTRxTkJNTXArcW1pUVJkLzgxbXdMenRBbmNjaXhqRGtmZFZuenlMNTdqMzBN?=
 =?utf-8?B?NGVIYUlvV1d0amttSVQ5UTVua1NyNnRiS3AyVVJic1BOM1pobnpVOHBHMGFu?=
 =?utf-8?B?UjRjNVNYUlBIdkRVclFvL1NnRG9OR0Yvd3RGMDh6TjJUdXBWSktWNXE0Zy9T?=
 =?utf-8?B?cGVPamdUVUlQTmpkRVpJREgydGtjU0NLZFAyNDZ0d2lsTEx6cTZRVktVRWZY?=
 =?utf-8?B?aE8ySGc0VWlvdUdlSWdTTDVxUVo4UW1uWU9tVnV0VzIrWE8xZ01WNlhhRFZt?=
 =?utf-8?B?ZzRvOGVFTVJGcmdqWmd1UVJUQ1FZeUEzUVZoeGlzV3JOMjlvcU8rWWtQRlVa?=
 =?utf-8?B?Sk91Vjk1YXBPWUw1NHUvbS9jRlpIQ2EyTVc5TXNaSGJjRXZLY0R5L0p3Z2U1?=
 =?utf-8?B?cGFEclh2SElRK1piSVFhRGhBVHc5bkcxTjNmZXdndUxPektzZmNtZFYwa25X?=
 =?utf-8?B?VXJmSmtUTTMrdi9VN3hSangyNkVGaklSbEV2eTlUbW13MHZrbU9TeEpXNjgz?=
 =?utf-8?B?Z0xXSkVmeEVGZ2FkRGxoM0czWldlU1F5RVFlbEQyZFU4Zk9HTFpJeDcxUHUx?=
 =?utf-8?B?UDVxTGNYM1hRcUd6eFlGUjdNZnRQYWJWaURuK0VESDhwcDVrTVlkT2wybFUz?=
 =?utf-8?B?dEZJS1crRlVMUDd3L0UwU0NmUko2NG1OTGFOWWRTc0FkM2VGQUZ4cVc4bHdK?=
 =?utf-8?B?N3FVbDFBWGY3MlR0dWMxNVg5ZUl0OXQwRFoxTHduWlZzcnZqbU42Tys0M2tY?=
 =?utf-8?B?M1BzcFBZMVMrOERYZG9mTklnRXlxcldFbUx1TFcyRDN3WW5ncC9kQUNZK0d3?=
 =?utf-8?B?c1ZpK1hOYkJLajFqbW11RFZCeXlRQ2NzZG1yMzZjZWtUcFBYU1RzRW1RL04z?=
 =?utf-8?B?aU1YNDljWGl3L2tYazZ5TUFQcXpwR21DeHhIR1VYMzErZmlhUVRQSXZNenQ4?=
 =?utf-8?B?MWV4SlBpTmRlUmJPSExKbVRwVlRQVVpoYVN5eUFTR3c0MDFXbkpzMllIM0Vt?=
 =?utf-8?B?VDZlcHBlZEo1RVFuSk1XZ2FFQlc1U3cxNEMzdkhoYWdVaC91emRqbEM4aW1N?=
 =?utf-8?B?c1dHMmxnZlhyenQzNDliRVByUGYvRDVVSlFNbzhGejdLbjYvbXVSVlJZZkpU?=
 =?utf-8?B?Qll2Z1Rtb2tVUjE0akp6THNMcHIrK3dVemxBT3AxTnh4U2x4d1ZIelZ3SlJl?=
 =?utf-8?Q?Y4SKpAJHVdj6S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 22:41:03.5018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26ec14d-3205-44a2-4e69-08dc72d49ad8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

On Sun, May 12, 2024 at 10:21:49AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:46:58PM -0700, Nicolin Chen wrote:
> > diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h 
> > +enum iommufd_object_type {
> > +	IOMMUFD_OBJ_NONE,
> > +	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
> > +	IOMMUFD_OBJ_DEVICE,
> > +	IOMMUFD_OBJ_HWPT_PAGING,
> > +	IOMMUFD_OBJ_HWPT_NESTED,
> > +	IOMMUFD_OBJ_IOAS,
> > +	IOMMUFD_OBJ_ACCESS,
> > +#ifdef CONFIG_IOMMUFD_TEST
> > +	IOMMUFD_OBJ_SELFTEST,
> > +#endif
> > +	IOMMUFD_OBJ_MAX,
> > +};
> 
> Can we just forward declare the enum? It would be nice to keep it in
> the private header

It doesn't seem to support that:
./include/linux/iommufd.h:31:34: error: field ‘type’ has incomplete type
   31 |         enum iommufd_object_type type;

By testing the following change on top of the series:
===================================
-enum iommufd_object_type {
-       IOMMUFD_OBJ_NONE,
-       IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
-       IOMMUFD_OBJ_DEVICE,
-       IOMMUFD_OBJ_HWPT_PAGING,
-       IOMMUFD_OBJ_HWPT_NESTED,
-       IOMMUFD_OBJ_IOAS,
-       IOMMUFD_OBJ_ACCESS,
-       IOMMUFD_OBJ_VIOMMU,
-       IOMMUFD_OBJ_VQUEUE,
-#ifdef CONFIG_IOMMUFD_TEST
-       IOMMUFD_OBJ_SELFTEST,
-#endif
-       IOMMUFD_OBJ_MAX,
-};
+enum iommufd_object_type;

 /* Base struct for all objects with a userspace ID handle. */
 struct iommufd_object {
        refcount_t shortterm_users;
        refcount_t users;
        enum iommufd_object_type type;
        unsigned int id;
 };
===================================

We could change the "enum iommufd_object_type type" in struct
iommufd_object to "unsigned int type" though...

Thanks
Nicolin
