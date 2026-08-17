Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA93298991
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980766; cv=fail; b=nwrxWSWy1oSIHRToIS/oZGzWcaBjzT3fwXHR0z9HM5j0Q9JZxWZFqLCKEYo99X4IrwBmh76W5AsBewiB76WLtyIeV3t1/jA0pKzfyFCMOQ6pYh0MgJFakrWOHCSKlUgDXNIR1XMKgcpCKMMpgjM0YhRhJ7xz/JAo74PUVXmXeOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980766; c=relaxed/simple;
	bh=3/Pg/SuzVkREX0hAnqKAhCMNwAWyu5zFvaHy7abrhGE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+1MWB3JRESDDVkJ97xoSTw+oXFzGniJ+eKWEFkY7HmDiZ0smYKjIqoNj0XyLreFhdl0tC4Y03640C6AgflkR1EisskK2XkqCFB7D0ywP2Kv3srlGhYAXxjn4JQiOIeNKHSRjsCD5eQda4GTFcVgTka1nRm8XkUJctUvA798Xps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ztENKgJ1; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ztENKgJ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJEXSYmeamhKhsmBXaSBmy71wJCvJC/heJ3qzXoupJGKU0eCIJhxjfWHiUVmdsxL/7MtL3pP6ltef+Dt7sjZ4vlR63wpIN5S/vY5y/IEchkadfpQ8C+8oO+VVXSaosZEaqbbVP9sAXwxXmlqk51Kxwi2WS5oOC2BESzW/0WqiAdnEYWIjyx13eRn2EOwNOzfW38COJiXCqs8l5ZcEcCJkeoCKouGTGbq7HRShxAXz+b+TzAQi6C5q1n0STnzdzs/dfyWE0t8WAzycADOwWZW9cWb3V/m6y4S0ryCeHLKQbU5JGSAoI1GMakZMNYsBw21luFrHsyjO/a2bqRiUlqqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkwPX6hf0y/Di6qap4b3rzvaRHjHMdm/bVSQz/qaVDc=;
 b=JlMDn04uw8PHgUljIPB8kPG9bStBSFAsklqx/HcharvztXK44fjWnG3rstn+UuznUGX4q3faQdGXSPNa68cBL+/WJTWMs82sDxnVVKmQEpFGXjTcUJ/QJNHhMj2dhQpJP0ZyzkPkjkdK/Nn+xmC7JJp0YOIGKa9eaIvMIG5ZiLXw1UCp7yU01FAEVSBakyAutNuM0CcwSn6sf7dZz5rQmFlJZ9WtVGsKYd+1gQLE0SpUz4YHxV4Vxrd3cDqevA747v9kup9kUq2uRX2QzMxqjaCToicETxUFJ+30q3uXKF6jcda3+g113e97H1rz9sthFF2uBlFXMkInqiGC2hsCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkwPX6hf0y/Di6qap4b3rzvaRHjHMdm/bVSQz/qaVDc=;
 b=ztENKgJ1kM6fzicLek1xsqfj9fpqF3F0VYLQEn4AwVRZZ25Fv6zNkhMrgF8OH2TRXvh3gd5hpc5WEC3ChWboK+fzTHRjXFNKyXpI/Vow6BfjQmiw2ilroJFzHJ2L1LCKSE4/pBlgHoDvK3qbZTX4+0Muv0pHWunhwCG6sEtNVDQ=
Received: from BN9PR03CA0163.namprd03.prod.outlook.com (2603:10b6:408:f4::18)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:32:34 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::5c) by BN9PR03CA0163.outlook.office365.com
 (2603:10b6:408:f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 15:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 15:32:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 10:32:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 10:32:33 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 10:32:28 -0500
Date: Mon, 17 Aug 2026 15:32:25 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "David
 Matlack" <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 11/18] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <b36wgcuhm2wpnpqlbnglo74nu6k4uw3pecfbvzli3fmmtlae66@kh5qvvhb2qjx>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-12-skhawaja@google.com>
 <xssagtjtc27kxprwyz7exeiotigcr3ksnvr53ap56ialuqlfe4@xql3pr5va6m5>
 <an9mwcflLcLtwDrn@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <an9mwcflLcLtwDrn@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ca96c3-133a-49e2-dbfe-08defc74c2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|7416014|376014|6133799003|4143699003|10067099003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wEmZCJEW5070tbktz+jyT5kL9jtHsjAhLDHy/c8tkNCYR5xYVuXcMznka/yNyKOlwum1Vm+JVqQjlvepOzUW+1OWBr23xWx4j2BnkmFeFiBEJL4u3j/0QNR/TmWbmXushnrZ+D/9g3b1lUO+Y2ZpXE7Kpvmz4oqP3fScCbeYIyKAHVXPcvaX2TExIyqEKXW5ca8f1FAmOUyTpT2GlpvXGDY9F4UyRaabY6zJp7wv3MqWfpeYtEbZj6S2AbbKKshZeFfFb8PxuHfCJwuek9+h2SHKwnLa6GNc72cTREE2ayC3iKhTEW0RQOyIgqa13CS8SkHYlBHRQ9QwS1m5Ua7jnbP9GR8XRWYx2TR2uq3o3NskIWq5yWvVIQyhBMbPUQ+ZLAhwVFYF5zly4kkw4DfBekDBP++x8EjhX7xPb7ZtwSLqdl1m7lISDvdlECmFQ5FyHeS7F7QLXUo7R91G74gefi4oKN37/eO3EzdI5yyjCFvCgwHjVCrpAWFOsM05lNNf0M9JM2s5NZ/VEk9QmrlJg3jzYfUIr/4bjs9NSX+F11YOu+SFXnKbvcDIerCQKgD3dZICw8rA1abLxmFZ5lUO6UdDhzj4TfeWVphJ5/xgqbznFARFhB4VbedWZiBHPqR3/0g7Kp87u5t4ds9vQVb21zmQZb1Edo5PfrvoTstHQhQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H1UJaUdzjttGaOIT0W8Hu45E36R5PtXBwb3mz1O53Ao0MmrbEOkLSxT2SWPMtJmsn81H87PO6yBtoD/3LWDLm3HHUxmNV5mBl+2fPupNv77kmUmBhue8AGqqY2o3hqrGQS90LSYdOVUH/KErZoXwp0VrrWyLX5YFg1UVaoZUUjZ+vmegivhUtQTk1CIm+TiUTvIaJTcVzYJ78bp1ZaMsIpJp1K0Ru4cv+vO07hVeb4CqdeAOXb9UsjCPtRR0vt+ZT1GAXgt4fsiscl+RH7FHqJrJgvfclISaZDNNwLjdrmi2oF+e53L12xbBNQ9Fo0G8WOR6irgtrCIEz5oCIb7R89/tJA7fmCbj8TyBpSduf/7guJAwQXmMPuKjRcZEsB5QIiyMJvVjAEGcp2dS2W/xu56joXHURMbEmazxh1Mh7VztGnJF5Gzt6MgOQSO1kBkp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:32:34.6190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ca96c3-133a-49e2-dbfe-08defc74c2ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267

On Fri, Aug 14, 2026 at 07:46:01PM +0000, Samiullah Khawaja wrote:
> On Fri, Aug 14, 2026 at 04:59:50PM +0000, Ankit Soni wrote:
> > On Sat, Aug 08, 2026 at 02:27:16AM +0000, Samiullah Khawaja wrote:
> > > During default domain setup, restore the preserved domains by restoring
> > > the page tables using restore() iommupt op. Associated the restored
> > > domain with the iommu group of the preserved device, and reattach the
> > > domain to the device.
> > > 
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > ---
> > >  drivers/iommu/iommu.c            |  76 ++++++++++++++++++
> > >  drivers/iommu/liveupdate.c       | 130 +++++++++++++++++++++++++++++++
> > >  include/linux/iommu-liveupdate.h |  69 ++++++++++++++++
> > >  3 files changed, 275 insertions(+)
> > > 
> > 
> > ../..
> > 
> > > diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> > > index 20acf123b47a..04c0212cd81b 100644
> > > --- a/drivers/iommu/liveupdate.c
> > > +++ b/drivers/iommu/liveupdate.c
> > > @@ -708,3 +708,133 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
> > >  	liveupdate_flb_put_outgoing(&iommu_flb);
> > >  }
> > >  EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
> > > +
> > > +static inline bool match_device_ser(struct iommu_device_ser *match,
> > > +				    struct pci_dev *pdev)
> > > +{
> > > +	return match->devid == pci_dev_id(pdev) && match->pci_domain_nr == pci_domain_nr(pdev->bus);
> > > +}
> > > +
> > > +/**
> > > + * iommu_init_device_preserved_data() - Initialize preserved state for device
> > > + * @dev: Target device
> > > + *
> > > + * Looks up incoming Live Update state for @dev and attaches it to the device if
> > > + * found.
> > > + */
> > > +void iommu_init_device_preserved_data(struct device *dev)
> > > +{
> > > +	struct iommu_device_ser *device_ser = NULL;
> > > +	struct iommu_device_array_ser *array;
> > > +	struct iommu_flb_obj *flb_obj;
> > > +	int ret, idx;
> > > +
> > > +	if (!dev_is_pci(dev))
> > > +		return;
> > > +
> > > +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
> > > +	if (ret)
> > > +		return;
> > > +
> > > +	mutex_lock(&flb_obj->lock);
> > > +	array = phys_to_virt(flb_obj->ser->device_array_phys);
> > > +	iommu_liveupdate_for_each_arr(array) {
> > > +		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
> > > +			if (match_device_ser(device_ser, to_pci_dev(dev))) {
> > > +				device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
> > > +				goto out;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	device_ser = NULL;
> > > +out:
> > > +	WRITE_ONCE(dev->iommu->device_ser, device_ser);
> > > +	mutex_unlock(&flb_obj->lock);
> > > +	liveupdate_flb_put_incoming(&iommu_flb);
> > > +}
> > > +EXPORT_SYMBOL(iommu_init_device_preserved_data);
> > > +
> > > +/**
> > > + * iommu_release_restored_device() - Release a restored device
> > > + * @dev: Target device
> > > + */
> > > +void iommu_release_restored_device(struct device *dev)
> > > +{
> > > +	/*
> > > +	 * We do not support releasing the restored devices that are not
> > > +	 * reclaimed by the device drivers as they can fallback to the default
> > > +	 * domain.
> > > +	 */
> > > +	BUG_ON(dev_iommu_restored_state(dev));
> > 
> > Hi,
> 
> Hi,
> 
> Thanks for looking at this.
> 
> > After a successful live update this is one sysfs write away, and nothing in
> > the series disarms it.
> > 
> > At PCI probe, iommu_init_device_preserved_data() matches the incoming FLB on
> > devid + pci_domain_nr and sets IOMMU_SER_FLAG_INCOMING.
> > Nothing clears the flag or device_ser afterwards. The group is meanwhile owned
> > on behalf of iommufd (iommu.c:3229-3231, "will be reclaimed later by the
> > entity (iommufd) that preserved them"), and iommufd_liveupdate_retrieve() is
> > -EOPNOTSUPP, so the reclaim that would end the restored state cannot happen
> > yet. The device is left with the state permanently set.
> 
> Yes, these points are valid and this is intentional. The IOMMU
> persistence support is split into two phases as mentioned in the cover
> letter. The reclaim logic in iommufd will come later as a phase 2. The
> preserved devices go to normal state when these are reclaimed through
> iommufd.
> 
> https://lore.kernel.org/all/20260128195943.GY1641016@ziepe.ca/

This is pretty much clear, and I wasn't asking for reclaim here -- I described
the parked state because it is where the BUG_ON is reached. It looks
independent of the reclaim design: phase-1 code enforces the phase-1 boundary 
with an unguarded BUG_ON, on a path a plain sysfs remove reaches.

> 
> Regarding the handling of sysfs, my concern is about it coming back and
> going to default domain as mentioned in the comment. But I will evaluate
> if we can allow device tear down here and reattach it to the preserved
> domain.

Agree, that teardown is the right direction. The removal can't be refused there
in any case: it arrives on a void notifier under device_del(), so the BUG_ON is
the whole of "we do not support this" -- taken with pci_rescan_remove_lock held.

It also can't distinguish the unreclaimed case the inline comment describes: the
only caller already gates on dev_iommu_restored_state(dev), so it panics every
time it is reached. Happy to leave the exact shape of the teardown to you.


> 
> Also please see the patchset breakdown here:
> https://docs.google.com/document/d/1enDn-uPE9U77U-xHEnzn6HHGKiePSAtMIP8EDU3NO0M
> 
> Btw since this phase 1 is relatively stable and I don't expect many
> changes in it. I have started reviving the Phase 2 patches and will be
> sending them out as RFC soon if you want to experiment with it.
> 
> Sami
> 

Please do send it, and Cc me. Reclaim is the part I most want to see.

-Ankit
