Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711DEED3
	for <iommu@lists.linux.dev>; Wed, 15 May 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715738380; cv=fail; b=B4fyCdwtexrVReEluTZ46rW74BjsjTr5uxJW73LncNEkdeXwjXbhLoXeKzEJaJFLJ2oLUML80XMvQ2lACXbknvslsmZiDmlKyM2hKxrn0druAl9ttUpQelccRyNU4FAeNEvJL2p/r51sIS3d4ms3dpRZst6b00ZGlhMDsCzHDPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715738380; c=relaxed/simple;
	bh=WOtOdT5lQjlDdzTp1alvzVrLjE2VYbLDxJ0y/ILj+04=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHBevG3Cc5GmUaXnMkMmzpVYCFup2Op30yJHWPOeOSMSG9o5UKYxrf5BfiAcKq+ctZwh+nWlQmAzP22uwkGCeL+PnmfcRY8Nfc3roihdAZC5owu9rlzEOEHTWcdE0kUzTWj0G7xLBMapgtbf255DVIIHp/Qt+zA/pgpqK+G20oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lXl1QgRk; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lXl1QgRk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juWVHN1jorI6eFg+xJQOBYBD2weXLFjGQ2fJL9rdUdl0iAiCn+9A7ISVkqjSQPKlkfzgB4IqZWB3qTaeXB5OdVoVZVLr+PTvtrzyd9WabHpxaLSHP825zSErDwp7WoJ3w/eE8xuV8id8ZFgNpukd/1K3WGugtB9Ec+ImK10k9dUt9AMUGhZpcPx3z9LKqQJ78oi6lU1VT2iyjD1GkDHNbaYf/DnAxQcf9fW3ku6YEulXMDPweHsnmeWBrKI1v9hBz5an2lf3jo+4IwoTD3GV432iJXT78RVNH4T6u9+8PvkU3Xbl4xT3nCWyirOgkyU6Uz+TdDUEyK7BZA61nPhv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxQnuTX1r6FZ4hWZNU0BfYJxdHJ4BMvqoYZE+y2hMOI=;
 b=cCTqdFFgKBlP0btaUpPfoyQCt522wRUnj6uVbDy7rQjfcLHN/AyAEBqiZ7DLBrTwomqkgeVFHjOX39ie0gU0Z0UwzVJdHRgUiiKKmOEQMgQmPh490cYR7C3pfteD45E6qTW6VVsAmDhHiJa90xAsKQ+srniTCEKrXb3Q94r+rgpghiOSkibFDZzB9qEV1XO0199kMnrxc54W8C7Y8WvtgOHsRvyYWdXKD6U8HzGsgJ9N75nv9frucddFUkayylJyWVAh7fY4fyrjYhKd4s2hNKR4w92xJLmgs018SzlhW5ZuRJEklm5XHRoA604KvvD6TsDtBfYVTuuC5aGAPmlixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxQnuTX1r6FZ4hWZNU0BfYJxdHJ4BMvqoYZE+y2hMOI=;
 b=lXl1QgRkiYPF/sgZxOKhxHV7JvW3iAKuzFk8vU8so19+I6PqGQjsAFeY/85ZPCl+zw7h0YBeS6sXkVTGcQnh0v+sLoMExz4LSK57clevA4Qsf2GDBD0bbMQbZok0XgfksoCVq4EG8zNeumMOC0TjdDdHECYnI0nxjvosqRGWQwd7VjLlQ1SexcLTk6IniWmsEXZiED74W+LxaNR+u5KyfDyLCGE5Rx7kLUxlMnKvKzgNO6MgM/+TSCGDQNef2uDU84CUXL/YQ8z7f898jkhm1cp2lhs+kozXAbwKhq/fO84bFpjapePrzsX1Fg8+0JeziHLY7CvxR82k8ytMuKlx4w==
Received: from CH0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:610:e7::26)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 01:59:32 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::4d) by CH0PR03CA0231.outlook.office365.com
 (2603:10b6:610:e7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Wed, 15 May 2024 01:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.0 via Frontend Transport; Wed, 15 May 2024 01:59:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 May
 2024 18:59:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 May 2024 18:59:12 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 14 May 2024 18:59:08 -0700
Date: Tue, 14 May 2024 18:59:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <ZkQW6/OAQ8MzN6Go@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkOI8ztR1mUMJ8oe@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 77849d73-cabe-43f1-8288-08dc7482aa0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G801vzGU2UDpwazA3AScfNJ/2kIbiqGAIYiAyoOFEv/N/J7Ck8R1Me0/UJCu?=
 =?us-ascii?Q?OrwhXslVjBW3WUKOojPo2BNiysbQDb2t5oZhTfg43M5uRhPLTbnGFgg5lonh?=
 =?us-ascii?Q?WEuw1I4YZG4eb5VCmkhtpOSdPfqB7LKfjp1SzRqjjoHyhWAaT3cLALxJYt3Q?=
 =?us-ascii?Q?5B6ZigE3mQlD6CJxUt0XTrOTIy/L1O+uqe43MaeIDAHwpvyYzbS/ekTmMmJC?=
 =?us-ascii?Q?OqqmZOBuQpvFXAyA3BHrkabxZJrakLlsH3WfMu4EouiLSfPDzAhneiwzBZyb?=
 =?us-ascii?Q?kcnHGPJIPwlNBZAY2p7E6YWnqpxxFtDmJhgyTQlHK+AdG6bPOn+WhqlUiNSF?=
 =?us-ascii?Q?p97/4+4qvoNxQGhq588/lztio/DODfq2iwSFw/ExGrwfpo4FPtKEJEPpIpTS?=
 =?us-ascii?Q?vrdOrbpm8LQirol6i6IPHlsSzQzEDEyQdSAZKpMS/zQ0p18U8zH1aVaN+f66?=
 =?us-ascii?Q?CgbEYVhcU87PZWsn3mgDMF9wqWjmYdBEzoubFH1bXrqssvEl6xSYwAw9CKot?=
 =?us-ascii?Q?ZN0/hO6oSHKUqmDZdB8gF+i4Qi95wjTQ2FFKgcsFzZB32n9dOXWsR/ptK178?=
 =?us-ascii?Q?Ty11ujnufIrqTKosBNnJvEQegUiYPZWM78rrA1KuZzU2JHG8CWWOn4UA0T9w?=
 =?us-ascii?Q?HF0qJy7gjukebqd2vNczVPjQElLIRIFEhHWDIGfqwGWNdHqnfoXUfPGcjps9?=
 =?us-ascii?Q?9BHY5G6yCrgyG9KgoXeBFp44u9YLXvsHq5A+tSUdgQ1ve137bJD8Njak+2d1?=
 =?us-ascii?Q?PSaIkk3qwdKcdIEN9cg1DSFbS1BhcijHbampBpj4UdFVZuQ5GxXN7pLXIDM7?=
 =?us-ascii?Q?qYNwSR33rw+l95LEJbAFn9IH/Evb0IcRPDPSb4AgGUjbseNSMEguCuCO0AYE?=
 =?us-ascii?Q?X4Jm8yx9ZGpEX1nsyywpQDmHOXlmo39DfGpa41Ahg85+RH5TYGvwFzsfSpRC?=
 =?us-ascii?Q?d/fiHbLE3Y55Am0hBoFKgfckhyIRB9n2F15ICm6eWiTNBdwzjSvEwBiVtnSd?=
 =?us-ascii?Q?g71ZwsD8yanD6lthofwx7H+TqApbuQqrrTkwYWCxPE7u8VqUQxZYE2RUtgo8?=
 =?us-ascii?Q?+XUliAiQfiegSz7HJyINdxqcAWdeL2iSp2ghr4DhGlU6TVBLZCXHcxJ86ef8?=
 =?us-ascii?Q?eJgzVlVKOjsBqyESjLzPZbfddnIOoWAlmBV9GUnu3AeD206taArOOLG1Bbm6?=
 =?us-ascii?Q?FswQS0STSv4INgJlRsztsr+tpl17FCs0aNydMKoySO9jcBOhyt2s5tXOmBED?=
 =?us-ascii?Q?rlNkd7FZdrbl1gHdaF8hrKjUOa4aiNNZvj0LucKZrKoeUAqUZecBfDyZ9Jmj?=
 =?us-ascii?Q?syoFPdm3lDRNSG/S7XaMOM/qObYeMO5oqLOcqV/SfSTYJPERiUxEY9KcTShN?=
 =?us-ascii?Q?CVNxWWAzS0jy3IEZQzLDpigr8Y/F?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 01:59:32.5853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77849d73-cabe-43f1-8288-08dc7482aa0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

On Tue, May 14, 2024 at 12:53:23PM -0300, Jason Gunthorpe wrote:
> On Sun, May 12, 2024 at 09:39:15PM -0700, Nicolin Chen wrote:
> > On Sun, May 12, 2024 at 11:46:54AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Apr 12, 2024 at 08:47:04PM -0700, Nicolin Chen wrote:
> > > > Add a pair of ops to set and unet device's virtual ID that belongs to
> > > > a viommu object. They will be used, in the following patch, by iommufd
> > > > to support some HW-acceleration feature from the host level.
> > > > 
> > > > For instance, every device behind an ARM SMMU has a Stream ID. The ID
> > > > is used by ATC invalidation commands so SMMU HW can direct invalidation
> > > > requests to the corresponding PCI device where the ID belongs to. In a
> > > > virtualization use case, a passthroughed device in the VM will have a
> > > > virtuail Stream ID, used by the ATC invalidation commands in the guest
> > > > system. NVIDIA's CMDQV extension for SMMUv3 provides a v-interface to
> > > > execute the guest-level ATC invalidation commands directly, yet needs
> > > > the HW to be aware of its virtual Stream ID so it can replace with its
> > > > physical Stream ID.
> > > 
> > > I imagine using this as well for the ATC invalidation commands. It
> > > would be very easy and simplifying if the command fixup just extracted
> > > the vSID from the ATC invalidation and used an xarray to turn it into
> > > a pSID and then pushed the resulting command.
> > 
> > You mean the nested SMMU series right? Actually the set_dev_id
> > ioctl was a part of that until we wanted to try DEV_INVALIDATE.
> 
> Yes, there is nothing inherently wrong with DEV_INVALIDATE, we could
> continue to use that as the API and automatically pick up the VIOMMU
> instance from the nesting domain to process the ATS.
> 
> The VMM needs a reliable place to send the CMDQ data, on ARM/AMD this
> needs to be an always available global-to-the-viommu thing. Intel
> needs to associate the virtual invalidation with the correct nesting
> domain as well.
> 
> So I original thought it would nice and simple to have a
> VIOMMU_INVALIDATE as well.
> 
> But.. If we need a nesting domain that is indentity (ie the S2) then
> when the VIOMMU is created then we'd also create an identity nesting
> domain as well.

So, you want a proxy S1 domain for a device to attach, in case
of a stage-2 only setup, because an S2 domain will no longer has
a VMID, since it's shared among viommus. In the SMMU driver case,
an arm_smmu_domain won't have an smmu pointer, so a device can't
attach to an S2 domain but always an nested S1 domain, right?

> Functionally we could use that global nesting domain
> to deliver the DEV_INVALIDATE too.

If my narrative above is correct, the device is actually still
attached to S2 domain via a proxy nested S1 domain. What cache
do we need to invalidate except S2 mappings in this case?

> > So again, yes, it makes sense to me that we move viommu and the
> > set_dev_id to the nested series, and then drop DEV_INVALIDATE.
> 
> I would like to do this bit by bit. viommu is a big series on its own.
> 
> DEV_INVALIDATE is fine, it just can't do ATS invalidation.

I am not very sure about AMD. Intel doesn't need DEV_INVALIDATE
at this moment. SMMU only uses DEV_INVALIDATE for ATC and CD
invalidations, which can be both shifted to VIOMMU_INVALIDATE.

Same question: any other case can we use the DEV_INVALIDATE for?

> We can add ATS invalidation after either as an enhancement as part of
> adding the VIOMMU either as DEV_INVALIDATE or VIOMMU_INVALIDATE (or
> both)

Yea, maybe step by step like this:

Part-1 VIOMMU_ALLOC and VIOMMU_ATTACH
Part-2 VIOMMU_SET/UNSET_VDEV_ID
Part-3 VIOMMU_INVALIDATE
Part-4 VQUEUE_ALLOC
...

Thanks
Nicolin
