Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2F245008
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380410; cv=fail; b=F3eWj9r+ZkQAhc10ss/UsYxCY4gB8CVWLSVre9ZU1yqmbSjpzC3wxfzcbOrb6bBKEZZUmi3tjAmMDTHj0O9afIMXYlGToc8XDuoMegn0eqhfVbz5SWCr8hx3FX5Y7C8UCmXuq2ZJtxslk6un/IlGJZkVtH9uueFcwk3GuFWdi34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380410; c=relaxed/simple;
	bh=0/xHkmUVc1WzZwckvXDx3j8tpfsRpSpmPaY3QAzho7A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDzVXH8MzqLUCq0gexGnsNWU79HXhAVHfo4met2OXQnpaUPBbakrN6q9OJdgfLuVCSSf251+8+pJXEK/mJTyn0GQePjNY8agjcLNW/nPgLar42UbUa15/9RElrli6IDw/79TDEyL3sRIhGMvsDGzXOXz1paUsFmto3kL0I7JMdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ggCODipD; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ggCODipD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD2CuO3bUFxbl/kAar/AiJAhN7DoYaySns9VY3e8CKP4B4JeJDHciCKoRXAg29dvCUoP2ZgPfj/h8aFArU7dHzkeh7gEy/Lng//ukS8vmTAYy0BGfZlDuqjMQgRFjSIkDtKWreEd8F3b8hdGlZEnoxjVOgO2+9SU+FxZpQGvmbU0oaR8oatkT9/38pB5iI+nCDtDXA1TP44IegOuiYyAW43ekrFcK9ZAVmnU6cRPoDGLLbHTLnouNHl2tZWE/7J4uZyraRJ7uj9T6P3yTAegnjaxS/F6esicbW2LttQ3ZI+JMe6dKigdLdSvMpCmyUZsxIiEC8IowbXfW7C4KqkeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjTj995RmvRGZLOx/d51GNQ8RugNnfBTS0eqcyzH3A0=;
 b=ahMGN8MS2ME4po7bqgC+8VFSZHz8XFrQH9drQNvQbWnQFiVKm99hSobT6QmTraFlVabX6dEunUk/IPcwSZTqT+Lvv9/Zuyn2DyvjCiSLKLsC1YlQXaryprPqXPiybsVPEPeCRGzpjf1s59KOB2u0o3o54c1bQMYwuM8ld8CbGjerJibV11ikdNfWZhzYDvxk3Y6FHW0g8QS9+4ucaB4OSFZ9IPn3Co/xQUSrk3v3BOVHdLCedAPtf7oBUZaHqlY1C4KB2jXfA4DiY8UG+enIBIuv9aARoNfmhWpmzlrQGYtEcvix5fIJA9UYHnmrz2mV6eaqdnFhhvhx/Zl4YvA06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjTj995RmvRGZLOx/d51GNQ8RugNnfBTS0eqcyzH3A0=;
 b=ggCODipDY7K831Gs+uJHc0bPZ5MTVo5VycBBHD68kAgmVW7s7hw1nwtzR64iJ5OonBFguV/kOt2H13SWDVRWSyjVHacFYD+eI2FuOvdN6XPJ6BGZO096A+9T+DsNDFtuRM7L3IrjvAe1J3w3iNS1VRhrWTPp0r1qi0kZsW7DHBL9sCoeZZlh+uzOZNEheNKjbOGGyNa2mVC5SJYy6ve9LOm+i1OmJ8nVYmvuoqpNSG+6XajeDD1902Wnkc7khV9rxGQgQ6DA52yKJG1vkkDnfjiCqbFaexN4AHslMkNr1wc/fC2eewTC3gJEeEIgPRZKkq1Dq2fayjMg/GgN/4gIvw==
Received: from PH7P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::29)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 05:40:03 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::77) by PH7P221CA0012.outlook.office365.com
 (2603:10b6:510:32a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 05:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 05:40:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 22:39:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 12 Mar 2026 22:39:51 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 22:39:50 -0700
Date: Thu, 12 Mar 2026 22:39:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
Message-ID: <abOjJf4HJ50vCIyg@Asurada-Nvidia>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260309060648.276762-2-baolu.lu@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b765c68-95cc-486a-ffac-08de80c2f921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BIVulrJdWxEzpS4HEAbMUZd1Exdww1R1DDCadOV7ZTog5Kafpk6Va9UIko2P/yRoNMWTd476ckutN9TpToE+T6LbGznqOyK90ReraOJWK4cXRe5ZklzdqK7vuffu2C25SbrGlLO+xdUsE9E7W1+TpGx5v1gVtvHKAua9xWZSJwg+ILwdMXRgce4wJq1GKh+OUFmwBXnWuS4+CrmhDKr3SeNItm6G83WGOhqSuH//eXBVJKr4MM7+vyQKD19YO3EwT4MiTdXuKachYYSDwWoChW0xYwco4/JIrPS/Z8eH6OSLrFaSvjOWINfreEy3xgdIABbrexyFl8StbkcKdSMmTeIZFh/ncddYeVvl1CDNQ2vX7AmUpitvJ2RSwSDpOC0GSRB0EFrtqa+6qt18OyU/21d8EzvGAuPaHuKDdxu39/cSvzUqeyh5OwEbHkuk0KzgjAF1AnbCw9fT/IRxS6ogjduTk1FchCpcZpICL0kKBeZKnk8TdNz3Z3sqERmHrJ5dJ0tVxaKsXOKBC2sbI30GPIHkLEtH7eJeYClZyLrlWacHoNrBsvDaP2AfrDsrK1jqKpBk0Q0c36g12sA6t39a/Rup+S1eLq5i537Fyyk0bw3qDihj5jYoTmZUrv2HLHVwdGLYzrqzCKYUPauluGJ5Tni8jjDS2u2B1zG7/8G7italFBU0guWkf/OAMxwQ2cjIdqMMdEGOKbCWUpX+XA0NHaspiqIs/AjzYE6YsOU8AT66eOriBqs873NzAPKfdsvDZbqhqkmk3heN7OB0tEno9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GJNdWVCEvaNCHmJHOIt8pypcsYssFtrxT0B22bEy3ttfIjtPGXyeTK/C3YHBto/h10+XkKMoyHiGJdY7FB5mX/B9mREDXfEzZdVrtHsTN0z7CPXKd7VkTG30mmk+q3Q1NAz/uppW9IIqhPQvcmGQljdczoU88LjCLUJ63x2IRekQmVMefl74MTdajtaAiGPEJIFNUlvGPKLRhIPaqTPZGRy6YS7ScMBNX00meiZI1MCRz9hG+OZDYEGpZY8Zx/wVNI7mWo3GA87v18SObZOwCcAOkgc8SSrqaG/utrEcZkUwWhbQLDP48+2NHRlRe1n8fzo/Htoeb+BapXc8uVVuLIWwyKI/YN6v/1r83u9ZH9J3A9m8CLgMAKFUzBy7cgGKm85YOoj96wpCv1XbQ04gspVhwbTsql3/HIJF5685n4xjB2RL0MwdjIH2GBOZiBe2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:40:02.3405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b765c68-95cc-486a-ffac-08de80c2f921
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

Hi Baolu,

On Mon, Mar 09, 2026 at 02:06:41PM +0800, Lu Baolu wrote:
> +struct entry_sync_writer_ops64;
> +struct entry_sync_writer64 {
> +	const struct entry_sync_writer_ops64 *ops;
> +	size_t num_quantas;
> +	size_t vbit_quanta;
> +};

Though I could guess what the @num_quantas and @vbit_quanta likely
mean, it'd be nicer to have some notes elaborating them.

> +/*
> + * Figure out if we can do a hitless update of entry to become target. Returns a
> + * bit mask where 1 indicates that a quanta word needs to be set disruptively.
> + * unused_update is an intermediate value of entry that has unused bits set to
> + * their new values.
> + */
> +static u8 NS(entry_quanta_diff)(struct entry_sync_writer *writer,
> +				const quanta_t *entry, const quanta_t *target,
> +				quanta_t *unused_update, quanta_t *memory)
> +{
> +	quanta_t *target_used = memory + writer->num_quantas * 1;
> +	quanta_t *cur_used = memory + writer->num_quantas * 2;

Should we have a kdoc somewhere mentioning that the two arrays are
neighbors (IIUIC)?

> +	u8 used_qword_diff = 0;

It seems to me that we want use "quanta" v.s. "qword"? 128 bits can
be called "dqword" as well though.

> +	unsigned int i;
> +
> +	writer->ops->get_used(entry, cur_used);
> +	writer->ops->get_used(target, target_used);

SMMU has get_update_safe now. Can we take it together?

> +void NS(entry_sync_write)(struct entry_sync_writer *writer, quanta_t *entry,
> +			  const quanta_t *target, quanta_t *memory,
> +			  size_t memory_len)
> +{
> +	quanta_t *unused_update = memory + writer->num_quantas * 0;
> +	u8 used_qword_diff;
> +
> +	if (WARN_ON(memory_len !=
> +		    ENTRY_SYNC_MEMORY_LEN(writer) * sizeof(*memory)))
> +		return;
> +
> +	used_qword_diff = NS(entry_quanta_diff)(writer, entry, target,
> +						unused_update, memory);
> +	if (hweight8(used_qword_diff) == 1) {
> +		/*
> +		 * Only one quanta needs its used bits to be changed. This is a
> +		 * hitless update, update all bits the current entry is ignoring
> +		 * to their new values, then update a single "critical quanta"
> +		 * to change the entry and finally 0 out any bits that are now
> +		 * unused in the target configuration.
> +		 */
> +		unsigned int critical_qword_index = ffs(used_qword_diff) - 1;
> +
> +		/*
> +		 * Skip writing unused bits in the critical quanta since we'll
> +		 * be writing it in the next step anyways. This can save a sync
> +		 * when the only change is in that quanta.
> +		 */
> +		unused_update[critical_qword_index] =
> +			entry[critical_qword_index];
> +		NS(entry_set)(writer, entry, unused_update, 0,
> +			      writer->num_quantas);
> +		NS(entry_set)(writer, entry, target, critical_qword_index, 1);
> +		NS(entry_set)(writer, entry, target, 0, writer->num_quantas);
> +	} else if (used_qword_diff) {
> +		/*
> +		 * At least two quantas need their inuse bits to be changed.
> +		 * This requires a breaking update, zero the V bit, write all
> +		 * qwords but 0, then set qword 0
> +		 */

Still, it'd be nicer to unify the wording between "quanta" and
"qword".

[..]
> +EXPORT_SYMBOL(NS(entry_sync_write));

There is also a KUNIT test coverage in arm-smmu-v3 for all of these
functions. Maybe we can make that generic as well?

> +#define entry_sync_writer entry_sync_writer64
> +#define quanta_t __le64
[..]
> +#define entry_sync_writer entry_sync_writer128
> +#define quanta_t u128

u64 can be called 64 too, though we might not have use case for now.

But maybe we could just call them:
    entry_sync_writer_le64
    entry_sync_writer_u128
?

Nicolin
