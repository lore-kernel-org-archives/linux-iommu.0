Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237B78F45
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384895; cv=fail; b=tPY2iBxvRhGmSXmIDOwwZLvSY4iNm+lhlZtq2EssbFiDMKpU84DkiPCJtNF2XkTLoBE3NoeIRMQWdPFKBCrSq7zOcCY8Z1zvmJ7FEyX/7R6ELn88dwRE+Kuxyzq+h+iM1F5ohMwpCZl6ATQLb62X/lNxRWDNSB82dR1cHAEfl3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384895; c=relaxed/simple;
	bh=su6jZivjXTPW5//+OnDDz1JYVqIBgTHfdt+xj/TH+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cEp7bYCw2uUtweLAkO4aT8kAFgtfUWTZ5lb0XtDuEzbZjLQ5vqGgYTcwcdMRKkn1V0xQOVGia48o/xS1jkbMtf5YG/p121B4ybkN3Idt0R8KttuzxMPfJmN4bCIlaNMJff51qnarhzSnW9jaRjDi2XBwsChtcPaCXFIWXcw176M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBAkhHdV; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBAkhHdV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCEtSmSC6veXnMm49YKqEwqJGtm5Ap8p7kz6N0m7GoovtrvZVGu4q2En8oTmSLXqB8dPB2QdWV76v6BfzLxPeyKPWohtASMKXe+YECZsy0XnMAMU9S/IxedKQO+Fc7xOtVmb10nSmW8O9UtaxdKo9xbFFmbP6xOF69WdWQoIu4Gc8RZ4WfI6UY3h+uOVmltazSDc2mqTHDM1CfdrJU/oRDR7xhplQ04XkC9YWcT0/bUCEPRWvctmqd3MXpH5W+cVPENQBfEG94hKGWW6EE/0yEcF5i1ZHUWZjqOqijXKOT63x0fHSY5uBTSGOwznhKW/ZzfCBdLyC4ilrz4dhLqmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgEBXzNnudqYWf4FcpqgcrjW/yQLlJGmeyr4kjCjazU=;
 b=dVEGz6A8fmp/2AhRyWULWq/EU406j1qU+uZdGiPP7ZmX3TML1k74DQtksnWd6V6Hemjo3O2d6EDQzgq/CxWwnL8yqeIdXSVlS6ItsDSrd/cLI3NVn8AWUWosQ6ShUOj86DrG+ZEP6QweCoM8AeXlXAFUkDtT4AT1SWxkIJymROH9I5cFGIeyFvkTVULJb606Oui0udQPzx4DG3aMIkKfY+jb3PJnnraMwAMr7L+03MWMqHLboWp8aGx8qsi2yrAy4Xbk3VmWM/rZH1Z/KL9MzwTpMmGCB+yI8X3uwrbAAnhw0RD3VDaw4m6cWQk+VbRYo9LYYaMkhE8aVt+2alYQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgEBXzNnudqYWf4FcpqgcrjW/yQLlJGmeyr4kjCjazU=;
 b=VBAkhHdVuCl9hxBoRRmJ1pY9Lh2DOsrkKtVtGnKsTQe7nKOFf968v8IxzYO5tFXfemUs2rL1+q4b3KQQR9QTpKCQNpUe13lLlKfIzgD8ma9iMvhaX+2H7CDplTjUMWUg1FKHmNMYN3RlaB95ApIH2SQ9+caHT4omUPsaXkX6Qkh+e0UrI/DgjMhQvo5GMwXikvc4XhxduTeXZZqTgzxVbEuqHMHUCGE7jejG1nrUINl8N4jLxjshK/CNqR+9RVJ4skUHmOXEh6KWj6TPVA3av7pOn4hLe09xJ7G8rx1BE3eEFDcP2rR6NcoegMnVwdlmeVzrfkQ9R+RbF6uxVeFkCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 15:21:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 15:21:23 +0000
Date: Fri, 11 Apr 2025 12:21:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, nicolinc@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fail aliasing StreamIDs more
 gracefully
Message-ID: <20250411152122.GF8423@nvidia.com>
References: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
X-ClientProxiedBy: BN9PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:408:ff::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b87e0f-61c7-408a-5cbe-08dd790c8518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?miqBahTeib8hHG+AihA/mZS+wLQ1/od48XfqFHUvGQg0yxRpeOtIMz0jfaks?=
 =?us-ascii?Q?wA2n2aGQCBeqyb7J2GsSpkqNWxIjwTic3FDS0sLlg7afhANqU2FQlOC4SLqE?=
 =?us-ascii?Q?+CszoikLzt+HrKQ9MCKAYfEdVcLWBQ1jk0txAzp9tOOteRNNg33QvumPnbeg?=
 =?us-ascii?Q?MJD9c6WypwEwVGMNRjvNZyLDmYJC/MDE/zI0f8poIPWDGseJR9AIe1KtlTw0?=
 =?us-ascii?Q?Sw2ZO6tfHLFCfrtx9CKj4lWEGDgt5qwq7SM1kOfhJrE8oWnTKtW/rT5MspBi?=
 =?us-ascii?Q?OVCR064C8MgYIkp538PCLyaClKYqmCakyOBM2eIKQ/pwbUxShHsShzudoStb?=
 =?us-ascii?Q?o9OX49qpCSUiQ2bZydG3Otv4rIFc1rJQ6AI/HaIE+vqFYRF/WVflQHdyONkZ?=
 =?us-ascii?Q?638B4oBu5Lf2nPYOACZSQHK2ogqHKn2lueNf5n4sYycSKWCQujHf6LWWDCv9?=
 =?us-ascii?Q?35RaFzDNUXcQEbewPBephKk89iGSSxBYsOv2ZZQhaJcF0Es5CSfACBnalXBZ?=
 =?us-ascii?Q?xBVvGwE3rWDvvarGCR7YmeNW9cLZLfwIow3n33fNBx2ECJEqXeHjHnvh9G5/?=
 =?us-ascii?Q?wwOKZDF7fpBLtG48m52d6N7h9WUVA+1QvpU6giLdvjG67G0iKrYsy2gCKT+8?=
 =?us-ascii?Q?BBrhONG35uB9opjBdIysiZCubWFD5DBGfXoPySK7WYP9nIFikZEfcyGkjuTV?=
 =?us-ascii?Q?QvEhOj6pRtk5onA2i0gcwr+PnWuEd/inUgyLVUS0HEmob68LlNxA/ZB6MAg+?=
 =?us-ascii?Q?T2L0I4Xr6HK1PsVeHYEuMqfGM3811bjBoqWTz+6CRjyxOncXfEtdT2wY87kf?=
 =?us-ascii?Q?7hQiPsHaPX+1vx1HnhiEEoqnGKkBvEECRC/X6KI3Yf8gd6D8onxyKeH9Nhqn?=
 =?us-ascii?Q?Ayr/7L0oaQCAx6hNeXUMZJaL2nar8U8KaEfeNYTRp/ubR7SWftihUPBNCKa4?=
 =?us-ascii?Q?7HwZwB9FZDI4C/JyJaygf4EoNvTu8wUlf7usTkH2p5U6vOEb5L4tFTsVP47E?=
 =?us-ascii?Q?LP5e2Vbc7giQmAAcdHtZ0EuhLJHDMGsqtuLZycFjljs0/vTg+Wyjb/38xK6w?=
 =?us-ascii?Q?spwd+JyuPK2zcxO3vYUnCz9wRuOVaAtWcCbuu24DAn+OrDWndMzqgfFE92oq?=
 =?us-ascii?Q?RYTZ+J9YQQefeiPWl+qqQ/C3uMGjH8MGhoMTcvXg0cP0YGLqnP4TsmCvj+Cy?=
 =?us-ascii?Q?aaal88LzlxVH3z0WJhQjZdq6FPOUcgpp323M9lIAFJjw4B2a9AMkIYvPjdwc?=
 =?us-ascii?Q?0UmKpyLZOtLiAj3VCLtlIWB/0arHEoGIZ4+B70u4kABeRUnEvCC9pehkXk/k?=
 =?us-ascii?Q?fuAyIfcMwy6QmxEpguoRSZCa5PKQZKiu8meSIajk2tHYzMmS9F6BZQ5UsuNY?=
 =?us-ascii?Q?cAalOobf/poaJY5be0D2Qfj6Xw6qbBQbNRAfXz4llyenmiRk0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?183JMTsOeETA1JWHhzcynvLNTjUEdy3L7RyqUmoAle85kT3+rV3bW71Sjj+e?=
 =?us-ascii?Q?zF2QJD5fTwbqkVZMGQR1WYxSjpabmtmfjKJWo+VSUgsHGL+lGWHknEoHzuRC?=
 =?us-ascii?Q?Gsbqdrw4w3FP63L0LIFDrJ1py1RBe2p4ZJSRrVeq/6YGSu8vezaHZMKxNxqA?=
 =?us-ascii?Q?ApAPst95QpnOGnbmkgNFqaKM96GY6t2Q3binxzrPPe9nTxVUp/qRHZWFYEmQ?=
 =?us-ascii?Q?PcGiAY0JL/72yvnLPLjLV0tiCZ+kG8KVT4cc+JfaOtrmnDxpoA9JNPvo7dJ1?=
 =?us-ascii?Q?VOY5yqUsAN5TteClK23zQVopy4cVqIaurlD8lhUuJtsdfqsHm1HykcoT6hm3?=
 =?us-ascii?Q?eYIUTO893VD2pKsgS17jAo1EcqRxPdOhGGvOhP655mfljAxRpotFr1nNQd+U?=
 =?us-ascii?Q?on36gO4fzXT0AmQU2ie3pFmGk+pj5gYNRXaFRVldpdgzEPnofdVmP0fnC+gz?=
 =?us-ascii?Q?IPb2iS3ziP36uRvrAvysJnFTPMU1+R+S07vxLWnS4+rC/T1a9iYBG1E8jMF1?=
 =?us-ascii?Q?vTpEwnELI8GdsBsPYvfSg8/cg/hYqqBivO6WQ0K/1EBMviFHDl0XnjTLQPsb?=
 =?us-ascii?Q?7RK9PpqCyhx0n4JXr7OkuY3f4kFIRi+V0ZO261EFcYCalneE5X1SC4ZLWN1o?=
 =?us-ascii?Q?hvvqQw1L8URyhsislOir8cx9bgHO8tUN0iXCOTEuWvlcTuXazDDdLmkCPSAV?=
 =?us-ascii?Q?8+lEH9F5N28crSahOuELTetHJIzkLayaWTABvD7LKnHkSBQUXXUvjII68Nbo?=
 =?us-ascii?Q?bAWK1YJJRH6BH8is9llSDjO4A73FchmLRRGIlJ2NmMmxUX3zO9kTfhGo0qHf?=
 =?us-ascii?Q?uzkOS+f/c++NcjDPrmv1tePaLljSunE2Fbg5ItY8MYLzT4UsVMoq0fjWsGYD?=
 =?us-ascii?Q?X88NSaDq07TqXIu2yiY2AmT3n5TqJEyRh9okkWxCD97l3LvRinrBwy5LleRz?=
 =?us-ascii?Q?9WhOp8rNYYesMwXjBCShVirGmtWzvJ118+/qOTcKPdVS2wTpiMS3O6X7d7LI?=
 =?us-ascii?Q?ijfF/XX4cT2azQADj7hfU+WWlbO9FqyETfdt8txdpwIAc8iMPWXfIp9IfFwU?=
 =?us-ascii?Q?HBM5ZQDn9j0GbxS2Fymzginpg527nL31N8X0ee/D4v/m0n+qmoBg9zcutBaP?=
 =?us-ascii?Q?YIXst+wwrolPB1n1m65DLKT9OyKMspMCtwieKWCfYlF8NM/lATtEhZzkj2dW?=
 =?us-ascii?Q?jOwvol1aixqvp/CiKXjAnx28aVNPQuLmEYXCy8cQW5/haX4KlCTfN95yHzEp?=
 =?us-ascii?Q?HAvDlA4f1He+LV02NAAq/T6e5quwiX1aAhlRD8odVY3vIZCWRd9O4WEKinPV?=
 =?us-ascii?Q?oXsgviXoUwBT0Rdke7RkvG7Up7xmdmgvL2WFC87HQIyZsWyYNA3zcnJBylqV?=
 =?us-ascii?Q?G6hszYMaN5+0tepKeV2pX/BFwSuT7UAqCIEshLLdfNjST25ugWxiHVemrRZp?=
 =?us-ascii?Q?mdDQtpFlyhruyG2cYsSXQdC0rxEPh0VOOPx7UQsxoCtCHXJAuPEFpQpFsS1o?=
 =?us-ascii?Q?x8pMLI6hhnsd1v0wooDGpOBEAUXy9bjwuC/ou9E3OxeXQrNPwJoqKHLtGgWU?=
 =?us-ascii?Q?APDe69/b1NmIZPgGyvbEngtPKb15aWRc+sruVH5K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b87e0f-61c7-408a-5cbe-08dd790c8518
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:21:23.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcbE684faXndAeGRfx6i1rZEUZGHNoueBznZM0xYBjpwvb9R3LreA96Jldrwn5JD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901

On Fri, Apr 11, 2025 at 03:09:14PM +0100, Robin Murphy wrote:
> We've never supported StreamID aliasing between devices, and as such
> they will never have had functioning DMA, but this is not fatal to the
> SMMU itself. Although aliasing between hard-wired platform device
> StreamIDs would tend to raise questions about the whole system, in
> practice it's far more likely to occur relatively innocently due to
> legacy PCI bridges, where the underlying StreamID mappings are still
> perfectly reasonable.
> 
> As such, return a more benign -ENODEV when failing probe for such an
> unsupported device (and log a more obvious error message), so that it
> doesn't break the entire SMMU probe now that bus_iommu_probe() runs in
> the right order and can propagate that error back. The end result is
> still that the device doesn't get an IOMMU group and probably won't
> work, same as before.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b4c21aaed126..c06459f7077b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3400,9 +3400,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  		/* Insert into SID tree */
>  		if (rb_find_add(&new_stream->node, &smmu->streams,
>  				arm_smmu_streams_cmp_node)) {
> -			dev_warn(master->dev, "stream %u already in tree\n",
> +			dev_warn(master->dev, "Aliasing StreamID 0x%x unsupported, expect DMA to be broken\n",
>  				 sid);
> -			ret = -EINVAL;
> +			ret = -ENODEV;
>  			break;

I don't think we should dillute the meaning of ENODEV here. It is
supposed to mean that the driver does not recognize the device and
this IOMMU instance doesn't translate for it.

That is different from the iommu instance owning the device but being
unable to probe it for some reason. The failure recovery in the core
code should be different.

IMHO it makes more sense to change this and related:

static int bus_iommu_probe(const struct bus_type *bus)
{
	struct iommu_group *group, *next;
	LIST_HEAD(group_list);
	int ret;

	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
	if (ret)
		return ret;

So that recognized, but failed, devices are contained to only effect
that device and do not fail the entire iommu or bus registration,
which is more like how things used to work when the probe path would
ignore the per-driver failure codes.

I can't think of a reason why we'd want any per-device failure to also
abort the whole iommu registration??

It would be nice if the dev->iommu would record that the struct device
is inoperable and then we can fail
iommu_device_use_default_domain()/etc in a contained way.

Jason
