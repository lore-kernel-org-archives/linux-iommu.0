Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4E248F6F
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031439; cv=fail; b=HEv2l/CH/ttn5czJEVMK0AMOB3+PeQbR05OjjJrnEVFjZue2PgMXs7vj8CihhYvMGhp1PKKEH6tTXCgBLlS7jqUbRfvLh5QIHLJeGdpeTYeo5P1U8K8A0fDFfTKxhmMifsf9k457GII4YgpThO/Ccga59xvGvibQ3G3RFgxv3OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031439; c=relaxed/simple;
	bh=X88cDkzDlm5gNLPw3Wtu57yoBmTARGQmhamv7RyjLWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2eHSNx5UtjlBabbhilGN2SA5Ajv2M5cW9DNbtdo8Ln6WxSxzpmOqbmtoZw/ffJpXVP63lwjPnyg3GBZE0SMGeA/aituYrlvfuVI/RIBXJ5oZ0PMLE2g5PQLkh6c6Fn0iiYRGMonHKu4r0TS4/4w/TKd4z07SQpdi7E8ckrWJOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nVS7vTuz; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nVS7vTuz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+9HcixwaoBlasJHanYC63gNKqphLHCmwhXlbwt5cP5+Tqnj63Dp1mSDKd43nAaaWvmKHFCqow+VojLa/mcs65wEQL0bu6lsnreAxNbS4u+16CO23i7q1iykNUkqn5cocvcdeFRWTGhwEzwd6pNwi8Unae4lI+I3kw8oY/RwEMRGlsTmUVAl5BUSlY5JxOY60S8JOU37l1WU0MkpV4kfee46uj0IXbg4bStR9t2gbBhcNa8POrvPEZwuX0Ob2w0pxqCzERxE6Mrx4bkRjtnYwU+50bgbSiF6RDzYVal/W/gYTPf1sp/vNYigOsc3VN7d9Wy9czCQANYTG+bHNW7HRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckfLZj3Lo5i4pQ0gzc/EG0AQhzECzWqOjZwhnrW3Lho=;
 b=uxQddKuppZyezWjQ6DoNuPIXfQh6d6rY2xyoOYaJcbgJcKn80gmT2Mxagpx4FcPgm8tSdh/OHMAOqjhE2ZsewthHkEapUoqxOjCEFr/GpEz4eoMp8vOsdCQVlCFZXk2jspAsdmQzehewT9ueV2OnogrjPT6mnJGOSpY91Jw3daCeSaF1jayrnKl4tnYahvf+5EznYRpqPvECIPQy7woJj0tfOA81N6bWJBNoP2nxVcemxHYdiM8VfHwIIdcSbzNcBAo+WnzXZ/MFefbH4ZMouRLF+cqiOIVWHBeSkktNuDPDj6xfCZhr8MbB1cZNGJuyce1aoO4k9iNdOrE2T+jzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckfLZj3Lo5i4pQ0gzc/EG0AQhzECzWqOjZwhnrW3Lho=;
 b=nVS7vTuzJE+U+QAmwOwcqdDlvx/yK7+83/aKLEzh4TcYu02faVVbl4vNoBH0kE7eke6HZK/OGEhKnuezfdhWyYNjNHyhI+tJjGr921dgtkysYBmc14Q+Iy4E+WO4fXu1RatsHgqahsuDkd7eT2Bkch/6zjf1ked5zD/S1OYPCwY=
Received: from MN2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:208:120::35)
 by DS5PPF266051432.namprd12.prod.outlook.com (2603:10b6:f:fc00::648) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 12 May
 2025 06:30:33 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:120:cafe::b7) by MN2PR10CA0022.outlook.office365.com
 (2603:10b6:208:120::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 06:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.1 via Frontend Transport; Mon, 12 May 2025 06:30:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:30:32 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 01:30:29 -0500
Date: Mon, 12 May 2025 06:30:16 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Joao Martins <joao.m.martins@oracle.com>
CC: <iommu@lists.linux.dev>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, David Woodhouse <dwmw2@infradead.org>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
Message-ID: <m5ageqedj5otmfo4yuld4es72esfmlc7vb5htolj5pcffurjl5@mi5xemcd4fgi>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
 <g3xrnjfs6zekogfohud2s7kdvphx43e6mdh3vfpllynrwokxwf@vvetz2j2nrai>
 <4f04d596-685e-4e48-9038-8aee6c927ebc@oracle.com>
 <lpbeiyyzoxuankxzgcms2iwkoydvj2vcpv5jftiy26nkslliwr@juykyxhdwwzv>
 <deb1603a-96df-46d8-9cb5-86121f334a88@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <deb1603a-96df-46d8-9cb5-86121f334a88@oracle.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS5PPF266051432:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b5d76a-d451-4a05-c139-08dd911e7fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YJ/Ru3GB6HDWIfxuyeY4fUp3o8ZCUUFPlFMpw7Rc+VuLZowUjm2hikxNdqpu?=
 =?us-ascii?Q?uo61LL6HjcxogZmyZbz+AS1XiLtDzB4BnV4e/x72sKYdtoT+riAEld3S9tdh?=
 =?us-ascii?Q?HKrILTCDydpbkkXnGTnRDlJeMODLqn3WxpEILzZexCv1zHjkMsHGZF+S5nvd?=
 =?us-ascii?Q?JiS7e7FNIV2/smkoZPViJfzEzkVEm4xFcT/cu9LNVF/vJqQ7BZNW7OZ9vWXp?=
 =?us-ascii?Q?19vicbh15CPQdA4AsF3RWUs62XGhklhv8ZGvaB1LXS8RA7DUFComYtyxqGWm?=
 =?us-ascii?Q?C6HU2Qj75aAIpMyYCDK465h8bxGRmb4XcxPQSXtL8gbAUF0DCoqKQ3EHDnfH?=
 =?us-ascii?Q?M4spNt5LIoTftvx927Rdqf/mNqaCiVyGP4oF1XYJHWKxwmU1Zg06gJv2wmmq?=
 =?us-ascii?Q?6UgKYZ3KBKnu22/w64MyzGSmS9TzfVDpT9UZjOJDKw6jBzFMS6w2tdKUPc71?=
 =?us-ascii?Q?zAMiVjGt4bWcyDEmQMUZrtNSUKwL76ph07kGXpVaK3kYVUIwJBqodm71GQZf?=
 =?us-ascii?Q?S/SuxmHsCV5tjtKEy+KV1pQQg0Y/Blk25wniyvrg94lNRssEyfkN+dZsTNff?=
 =?us-ascii?Q?9EfMbks9KSN6k1RjtOcap8T6kmCN5vwVE4NNso5XXsbu7eI66A4YcfflWC4h?=
 =?us-ascii?Q?D/cX4eOaA8iNkjdaF3913LuqwvNjfeLKAEkOisxPo2KrKtBs3Qwz5G/UlI8s?=
 =?us-ascii?Q?gXVvVtEDM9dCub7EHR5u3HMoa3JqJ8hewWUzGi6Zi9q3bSFsr3OseYFjLj65?=
 =?us-ascii?Q?zwjeHENDcvbAXPHX06K9hBf6KHXhnkGfy9f8ZkqVvq0aaww7MDjIwoWke58f?=
 =?us-ascii?Q?DSTLhA1BKgJRaEme8zMIvuDyeZwPtAFKyjI7EQ/72aJoKoGoYx+wD+N5jIxq?=
 =?us-ascii?Q?FJWFEz1bzMMCaE6SEz7+6JUN+sstP8UJpPbxQSKDNfVoNJQVrYnhi3mpiyBS?=
 =?us-ascii?Q?smhiszwKN4snABtKj5HDxQtz5hlXpOsp0oqxQqNxLDF1iNV9ZuOj1xXR//Kw?=
 =?us-ascii?Q?1ke95r2SqMRcafXWQ9gIJ5O6l9YRWKg2RuxYt9k68RmrRN9enN1C04cA7kJ2?=
 =?us-ascii?Q?iBy+91EtQCW1pgSqL44UWGUkIAcXOEijKmL0vZoFgju13N1i7tbvLG1ej1jU?=
 =?us-ascii?Q?b5WqEmTuEDyuqHWAzZ9TDcsm4raAbzb4FWBklEsnUzs0wp8h+g4UYA3AwwJI?=
 =?us-ascii?Q?9ssTjOZGZXA8QGcDKQizXOz5z6Ui/dPC2HIqHO1eJACbvu4R9lE4+ekt4aAt?=
 =?us-ascii?Q?1CslEuWftmPS/b262iH2Ttv+s6rBXr3JWdLAgHB/HmlKZDH3PCG8SmBm/ekz?=
 =?us-ascii?Q?uOtX25zwxubgnQ/Z3CV2lxXyjREiRUtczbW8zkG0mxJvn+jRuRAsu3C4hUkp?=
 =?us-ascii?Q?t/+PT6v/f/RMb2PrtHibU9atJz9EkLnCwlJYnuEa06aPcs/POl/XNxrDsTBZ?=
 =?us-ascii?Q?l3pI7UaapvEUrowngS+Jn3DeH4GjhAbWcapqV3vUiaUh+5PfkkJBojYas2wD?=
 =?us-ascii?Q?4JdzdbW87vMRf94=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:30:33.5232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b5d76a-d451-4a05-c139-08dd911e7fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF266051432

Hi,

On Thu, May 08, 2025 at 06:03:44PM +0100, Joao Martins wrote:
> On 06/05/2025 06:12, Ankit Soni wrote:
> > On Wed, Apr 30, 2025 at 12:41:04PM +0100, Joao Martins wrote:
> >>> With intel patch you mentioned above, it seems that it is mostly handling 
> >>> "second stage translation support" disable, which will eventually disable dma 
> >>> translation. And in AMD case, HATDis bit indicates host(v1) translation is not
> >>> available, then attempt to use guest(v2) translation, and if both page
> >>> table modes are not available then disable dma tranlation.
> >>
> >> OK, I guess it makes sense if HATDis is v1 only.
> >>
> >> My other call out was that when we disable dma-translation all together (aka
> >> both modes), then we shouldn't advertise the IOMMU groups (internally and to
> >> userspace) by not calling iommu_device_register()/iommu_device_sysfs_add().
> >>
> > 
> > Sorry for the late reply. I had cross-checked it; if the probe fails,
> > then IOMMU groups will not be populated, and eventually, it will not
> > have significance for calling iommu_device_register()/iommu_device_sysfs_add().
> > 
> 
> It would nonetheless populate a ivhd entry in sysfs needlessly but with an empty
> devices list (qemu diff at the tail end for how I checked it; it's only missing
> the ILLEGAL_DEVICE_TABLE_ENTRY event being generated, but enough to check the
> first patch with sw iommu) e.g. as far as I checked:
> 
> $ find /sys | grep ivhd
> /sys/class/iommu/ivhd0
> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0
> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/uevent
> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu
> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu/cap
> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu/features
> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/devices
> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/device
> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/subsystem
> 

I was assuming, since iommu is still active for interrupt remapping,
user may need info for cap and feature using /sys fs.
@vasant: can you please suggest on this?

> -->8--
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 59593582be23..78801672ee3d 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2326,7 +2326,11 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker,
> const char *oem_id,
>      /* IOMMU info */
>      build_append_int_noprefix(table_data, 0, 2);
>      /* IOMMU Attributes */
> -    build_append_int_noprefix(table_data, 0, 4);
> +    if (!s->dma_translation) {
> +        build_append_int_noprefix(table_data, (1UL << 0) /* HATDis */, 4);
> +    } else {
> +        build_append_int_noprefix(table_data, 0, 4);
> +    }
>      /* EFR Register Image */
>      build_append_int_noprefix(table_data,
>                                amdvi_extended_feature_register(s),
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 34abb61e092e..d033d309a210 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -83,6 +83,9 @@ uint64_t amdvi_extended_feature_register(AMDVIState *s)
>      if (s->xtsup) {
>          feature |= AMDVI_FEATURE_XT;
>      }
> +    if (!s->dma_translation) {
> +        feature |= AMDVI_HATS_MODE_RESERVED;
> +    }
> 
>      return feature;
>  }
> @@ -1665,6 +1668,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error
> **errp)
>  }
> 
>  static Property amdvi_properties[] = {
> +    DEFINE_PROP_BOOL("dma-translation", AMDVIState, dma_translation, true),
>      DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index e0dac4d9a96c..b5358dc30533 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -169,6 +169,7 @@
>  /* AMDVI paging mode */
>  #define AMDVI_GATS_MODE                 (2ULL <<  12)
>  #define AMDVI_HATS_MODE                 (2ULL <<  10)
> +#define AMDVI_HATS_MODE_RESERVED        (2ULL <<  11)
> 
>  /* IOTLB */
>  #define AMDVI_IOTLB_MAX_SIZE 1024
> @@ -371,6 +372,7 @@ struct AMDVIState {
>      /* Interrupt remapping */
>      bool ga_enabled;
>      bool xtsup;
> +    bool dma_translation;
>  };
> 
>  uint64_t amdvi_extended_feature_register(AMDVIState *s);

Thank you for QEMU patch, i also had similar patch ready, i was waiting
for kernel patch to be submitted.

- Ankit
