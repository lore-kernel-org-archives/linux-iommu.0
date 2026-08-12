Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D659396590
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516184; cv=fail; b=FrYwiA1Zq+TN+mKYwFhmPiowc2GQ0uVsXgKyP/Wp+qetE7cXp7f4nbfzolez25UAEJpWl1ckLFoXZPsyTwkRIFsS5UZNGDOkfcycmIFTFGCT8ldSPyfuu2byiKCWtk+mXSDkXC+iOh4LYsoUHIZ8GlQUM5v5XNtfgWUlvTx5Paw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516184; c=relaxed/simple;
	bh=WdjFpgaYHHYuiLQAMO+DijP6kweePEs8yeiTXJL7w6E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnyUTaZOB4QGN2cftNznJhDhArVxVyRhpnugdvwrka7YyAukbgMye7IyEPQyMAA47a/zu5OgzdJq93X7BdtfsIIrb2whyTC9o5UWIKhgemk/MB9t+nvWZK1ra6s7EirO2F6MBfmNfaGzbrK9MOgbhJrHJajedZIXNEn9SBJmFfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QHlpcyy5; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QHlpcyy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJYz9JoZKomyo+UlRi8nB8+iHk5LWAb0uZGP9tOGKYHLFPuai7oIQ/QbaC8cIaqXEo3YfSVxHdtmg/5tRWIR/UlwcAuIdHRw0YFlS5en5J+ZZy7o2VsnmWJ1j/XZ7VmDKrWXt73LWvge+xLeQzSvtF5gDmnNv7YK4Q2egaDbTSj7WEWELKaJCooaBPeP0/PFGkNGioWakn49Kcu8mtMmBSBCQ6hlKJvPkd6PuXwzqatx4gYNT/q73o1lI6JJCwboAk4DTW2Xu2JC8/eX37cGqmX7JbhltWaN3h8A/xywMlX9lN1Lbuu7a/jwpq8/LWXjz+73kLa4pgZ2v9h+wcsspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT7hyokwjYTEB/Srqhl3IYymrScqmoHb3flAi9lx8YQ=;
 b=fonRp2OpGfPbSva1a/ZIFs3XBaWD/0U4zoAcH0FhgsE+jak0xecwMIkKud6IVWxD5JXgS7HwegYrB3iQHdvdWJ+4db3j5/Fh8K/FSP8RVntkJ33gCkGaqRO+ys5U7S0u2Wfygm1/Y73UEmnbOzviqnd3HoOX4JdczmXpc26A1QirGiPjpjLM8Jj7dpi7nzUVh+C4bwTd4nYAfW4kpTyMRvUt8qIV2FmkVvOL8R2TSHfkzU0DTi257XwDdyvSmjzoFhes1B/SEVN2s6ikWFS9BEWBuqU4Bzv1SiUvGj4okxPfDgi7h6m9F/eEJ4z+PU+/N3FHC4dsB2JVm9Gp3QuAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT7hyokwjYTEB/Srqhl3IYymrScqmoHb3flAi9lx8YQ=;
 b=QHlpcyy5GtXFS1YHq6nBOxnCK6Wi8Bb/bsMeR06Y74f+KxlVx2WmESv99+WjfQ1G51iaU6HGCLsutVUxqEC1fUYHEVTr65K9b7JaYgPm5PzBIyPQUgdioV8Q8fhvwm32iGoAttlai/sWhp6d6ZxwMjn/qd4ziSiWdVi4C/yXgFU=
Received: from DS0PR17CA0017.namprd17.prod.outlook.com (2603:10b6:8:191::28)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 06:29:33 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::57) by DS0PR17CA0017.outlook.office365.com
 (2603:10b6:8:191::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 06:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 06:29:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 01:29:31 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 01:29:26 -0500
Date: Wed, 12 Aug 2026 06:29:18 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 09/18] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <wjt4qqbzwsiaxz7bxog6prag5qvverji5o7dvdsek6frakuptd@urudi4rsvmbk>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-10-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260808022723.3893618-10-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: c1241db8-9615-47d9-b56d-08def83b1229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|23010399003|36860700016|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	roKfxXFouquw4T2SpuPdDIFyLP9FV8qj+Di/TzltdsWcbVUFCvVMvLVq/XSps9si9PJdhB0b2ink1OXblOY06tF1iFhAHTg6mf4ULyGRaRRrYjsY0rpO0+dW4Dfn/a8HoJ5GDaQdI317f3hBgSBwOK5Nd481ANDRGe+UK2GGmApAIIfElrC9BA12xTZKLs9eXFucqayYGpjTtqFa2Gt7Mw0qB6DDLFQEb1FAzG0mlFm64oI330+aehhEzMkKYoHHS8OVUxGziPyqmIpOLnnS3FQk2O4LvrTafDtmxCH1CG8Y9tuK/zQwYu/wke8+UuvpKgRHVyv+t+RZpgEGYZEmXlTP7bwZ4AgfFb5DrIt/GDgPBFufCJmbg3joSrmpvVqmX1wbaNZH3WhbumweFITAWuX8KfJrXRGGAdVDnSb3iYnbkjDMBTAZsd2n4Xf45wHh2aj/I/qj69cNTMLNEecVV6ajl4yhdMQuGhgVlah5IhctimyUodMQGEn9ErlTkGi26s5X/5m16mJP+xXIeIODgsWwDQxKC+pIkx4Tj7LaeDUgV2T+kRThoEryqWfs1I5eKCpEjMXIchVhxgEtI8Ujio7oJBJq/w3BD2cRcV8rLPoaTRIvXB1wI/HIaGDl6w0KvpsJ9UjEENVRk23rE+DvXPoBs8Sf0UBzzKjQIpcMJNOC7VyOaydqZ7yyS1abbmmdsUYfS37wX/6KJpEeeK/wFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RkhhEoQUfnSYvwZvYg/GwNJdXB2KGh89hbIGxb+L3GpV6CP8OvlHHDq2L3anMmDIxSWEfSxcuO+j2GexxPqezWeJPe6a6is1lXXtCM9Ms79GvlwJ1fsPC4xJbMnhJmlYCuvlQHHklD5vizKyVURJEVS1nmweSKFF5JU1KXRysnL7AyP8jscQBFYIbMcfIA/YOytbuWEYWec/yTzJfyrPInivkXZULVGzesQ9gjqDeswf7T3CASx7IOe9/cT7ZloEF0qdLSLxhU4hhuLuRoc9XgAMuTFT4FAaTYBdQomTFwv/cKnuLH5VgiyipYJfeJiJ/hltmK+HurqzSnnY5QRYvMHqnIkru0BKiZJivZM61BMxcqOI8Ypl/luJtYpoxG92NZ4FIIJ5JlbxoENVSgIAng2NeaXg0Fcb8yHP84bQhEh9SjsIwRoRIiREREdTaAVX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 06:29:32.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1241db8-9615-47d9-b56d-08def83b1229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231

On Sat, Aug 08, 2026 at 02:27:14AM +0000, Samiullah Khawaja wrote:
> The preserved state of the device and IOMMU needs to be fetched during
> shutdown and boot in the next kernel. Add APIs that can be used to fetch
> the preserved state of a device and IOMMU. The APIs will only be used
> during shutdown and after liveupdate so no locking needed.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/liveupdate.c       | 122 +++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h |  45 ++++++++++++
>  2 files changed, 167 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 7f349ae5a124..20acf123b47a 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c

../..

> @@ -262,6 +273,117 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>  }
>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>  
> +/*
> + * iommu_liveupdate_flb_get_incoming() - Helper function to get FLB state
> + * @flb_objp: Pointer to get the restored FLB object
> + *
> + * Return: 0 if FLB state found and restored, error if no data found
> + */
> +static int iommu_liveupdate_flb_get_incoming(struct iommu_flb_obj **flb_objp)
> +{
> +	struct iommu_flb_obj *flb_obj;
> +	int ret;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)flb_objp);
> +	if (ret)
> +		return ret;
> +
> +	flb_obj = *flb_objp;
> +	mutex_lock(&flb_obj->lock);
> +
> +	/*
> +	 * FLB version mismatch is considered fatal for security reasons for
> +	 * now.
> +	 */
> +	if (flb_obj->ser->version != IOMMU_LUO_FLB_VERSION)
> +		goto err_fatal;
> +
> +	/*
> +	 * Array Phys of each type should be valid if the FLB was created for
> +	 * preservation. This is true even if no devices, iommus or domains were
> +	 * preserved.
> +	 */
> +	if (!flb_obj->ser->iommu_array_phys ||
> +	    !flb_obj->ser->device_array_phys ||
> +	    !flb_obj->ser->iommu_domain_array_phys)
> +		goto err_fatal;
> +
> +	mutex_unlock(&flb_obj->lock);
> +	return 0;
> +
> +err_fatal:
> +	panic("Failed to restore IOMMU Live Update FLB\n");
> +}

../..

> +/**
> + * iommu_get_preserved_data() - Get preserved data for an IOMMU HW
> + * @token: Token used to preserve this IOMMU HW
> + * @type: IOMMU type in preserved state
> + *
> + * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
> + *
> + * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
> + */
> +struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
> +{
> +	struct iommu_hw_ser *iommu_ser = NULL;
> +	struct iommu_hw_array_ser *array;
> +	struct iommu_flb_obj *flb_obj;
> +	int ret, idx;
> +
> +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
> +	if (ret)
> +		return NULL;

Hi,

Returning NULL for every failure loses a distinction the caller needs.
"Nothing was handed over" and "something was handed over and the lookup
failed" are different states, and this helper is the only place that can
tell them apart.

Of the errors reachable here, three mean nothing was handed over:

        -EOPNOTSUPP     live update disabled or not built
        -ENODATA        no incoming handover data
        -ENOENT         the handover carried no IOMMU FLB

An -ENOMEM out of a .retrieve() callback means the opposite, and returns
the same NULL.

The distinction matters because callers read NULL as a cold boot and act
on it. Both VT-d call sites in 10/18 do. init_dmars():

        if (!iommu_ser)
                init_translation_status(iommu);

        if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
                iommu_disable_translation(iommu);
                clear_translation_pre_enabled(iommu);
                pr_warn("Translation was enabled for %s but we are not in kdump mode\n",
                        iommu->name);
        }

and intel_iommu_add():

        if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
                iommu_disable_translation(iommu);

On an -ENOMEM both disable an IOMMU that the previous kernel left
translating, underneath devices still doing DMA through it. The warning
attributes it to a stale enable outside kdump, so the log points away from
the actual cause.

The helper already treats this class of failure as fatal a few lines
lower. A version mismatch and a missing array pointer both reach err_fatal
and panic(), because data was handed over and cannot be trusted. A failed
fetch is the same class -- something was handed over and could not be read
back -- but it returns an error that becomes NULL, and callers read that
as a cold boot.

A single failure also spreads. luo_flb_retrieve_one() caches a failed
.retrieve() in incoming.retrieve_status and returns it directly on every
later call, so one -ENOMEM makes the lookup return NULL for every IOMMU in
the system, not just the one that hit it.

Is returning NULL for all of them intentional? If callers are meant to
treat every failure as "nothing was handed over", that is worth saying in
a comment here.

If not, the smallest fix is to return NULL for the absent cases only and
an ERR_PTR for everything else:

        ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
        if (ret)
                return iommu_incoming_absent(ret) ? NULL : ERR_PTR(ret);

where iommu_incoming_absent() tests the three codes above.
intel_iommu_add() can then return PTR_ERR() directly, and init_dmars() can
goto free_iommu. Nothing else about the helper needs to change.

The whole point is that a caller can tell a cold boot from a failed lookup.

Thanks,
Ankit

> +
> +	array = phys_to_virt(flb_obj->ser->iommu_array_phys);
> +	iommu_liveupdate_for_each_arr(array) {
> +		iommu_liveupdate_for_each_obj(array, iommu_ser, idx) {
> +			if (iommu_ser->token == token && iommu_ser->type == type)
> +				goto out;
> +		}
> +	}
> +
> +	iommu_ser = NULL;
> +out:
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return iommu_ser;
> +}
> +EXPORT_SYMBOL(iommu_get_preserved_data);
> -- 
> 2.55.0.679.g6767b8d81c-goog
> 
