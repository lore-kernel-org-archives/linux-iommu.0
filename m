Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795726014;
	b=w7+9VGmJNAKwD0FLsVYsaZ2OtdoBK2PQoxnHdss3XeGeH5nF7PEyLmjZmyAV+fOcuaNA
	 tqHRbdYHzhMXWMD92j9Qdc+rq6aaLnISdeC8DDq4c2+mBVwGa05F2Jm6vORthgNhfjSHY
	 CzzP/X78yik8An6AcqO6ch8/NqmErRKgz3B+x3Yy0pIahjMyBEavopWd8HxWnDXcVguYZ
	 m9QpQZMqlsbrG1Pmx6othv0DeGVRnZoZ9CSoLlAsj56ufaWZOsnZb+HohTD1vbwng1q7n
	 3rhgXW6gOsOlchnT/UymD8rPkk3cCDs9jyOAEj9gSgxbGxbNUZWd5h7ZXv6LzqoByXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726014;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yzFloxmxnCImu50zEcc5C9ihVXwmXJ2wif4YvMV/Yug=;
	b=ULV2m1N2KMhYrkqlWcqMaxS2PoU2seIpI1wtpbbVHhJcU9IpD88P0ywEQYzhKoFiTn3C
	 DdAzzkd/2W/JwhAtmTGG0JSa5yaJIZ2ChFAiINlx6Z2u5ftxUMV+Buwl55tbEytoG0+iY
	 51qPW3daZT/alj2tpritGi4DqxMd5J+GOIuDB8S04uya+mKpOiZ9IAMAk6kOrBKTEytzJ
	 s0wSUKpObdeCRhWtYNflCq02Mt8Zlxgejr0pXbdJ7mu1Vgcpj3WzVxV1tuCaeHtv9j1I4
	 akFX8DC5w9bxNJnuBKrv30XB1pEhajz7IMC4AqRbpK+Zh7OqkTo7I86HekJ3PFH+QBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="n/tv7qA4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.38
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FC606A31E;
	Thu, 26 Nov 2026 20:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E74FC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n/tv7qA4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5Oy0vqfvxoZigvOfVyFdVKXfh/CulA61b8Ycvjog3HNzBalMcnPRH/KSci1k7EV6xzHz8wKYgI5rKxVlPo+OF4v9kGIAUH0DvtsC16vxtmLRGrpxPm/OKFmsMtwYQ7wtcfAEyWg5S7NLcFuU3us94m66h7gtBT/CRgymG4pWJ05SQ+loWrcBoS9Fpubq1eW0ebNqsUmXxHRSjhkaMqweyFIqutjJrlk880G5z5olNAr3V1MvvhlWNZlU0ml984bxfO5M2mTsMf5ygcvmGdafX2qthRK36awN/oMqPNFnPm5P8hkmqq9/o0I4+Hv9QXUwG3mphBKvCgITaHbp72ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzFloxmxnCImu50zEcc5C9ihVXwmXJ2wif4YvMV/Yug=;
 b=g8o/3w2sCleq6HgyEKzop08ytYcDrOxkCwfBVuUg4ZD4aJY/Vmy5fAQhcA2UuFhnvKSMTGGeHkn8RO/uV/EMWy3+kmr5Zf9Cp55I8CjzD4WuMY2zITLboB3sQfONsjSziMuRUj8due6KY4+ddnWRuOiGL8MQR/AHuuOjSx/Jf0J8WpAiMGTtmWDL+w82SWmI9dfM3ySrOoUrDSIiLH+4Svs51ztS2XYGtpr+oQjcrP4/wmwNyELi8NBauquHE7xHErXVmhNTAOvc0im/DDXDa0KYonmzdk9EswWGHduddDFOg3LLYyKfzu6AabnXhY5wm+dxm4QaQ0KmDdym9UJvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzFloxmxnCImu50zEcc5C9ihVXwmXJ2wif4YvMV/Yug=;
 b=n/tv7qA40kzz3d6pQiDbiwfeIsitsCR7GPiA8im96btZ2xO5K3BS2nqZDgAGnME4fNlH89NF4d8ZcCgWcZaYAr2/ut4GRBM8SlEP/tjD5l319c4rbtgHeA7us8XMpQglaL64cChVcJAhX9uHbnIddL4xcHf2+fn1rZXdRqhno6MAn4MkAyWAd5mD/r+SCA7CCq6YUrWSWLzgrdVdkVtGyoBJ/BAR+j9lRSjCIYz7hUGhuEVrnccC5yDdS8tLRI1AE1ZXFXZGs8wDmrHRAIQiVQ+CD/uBD1GfHtZJk9MtlIRD4MlJhmV8H1OHf234bti/rTRtWWzhQIqmzjH4DxO9Kw==
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 20:46:47 +0000
Received: from BL2PEPF000352CA.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::5b) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 20:46:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL2PEPF000352CA.mail.protection.outlook.com (10.167.249.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 20:46:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 12:46:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 12:46:28 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 12:46:26 -0800
Date: Thu, 26 Nov 2026 12:46:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
	<johan@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mark Rutland
	<mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sonang Patel <sonangp@nvidia.com>, "Ankit
 Agrawal" <ankita@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 5/7] iommu: Introduce TDISP T=0 state for confidential
 IOMMUs
Message-ID: <awiaoX4RrQPP23OY@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.9155049351516451537.b4-review@b4>
 <awe6WgoiKaBTgINn@nvidia.com>
 <20261126145715.GG114472@nvidia.com>
 <awiLcoPfk0xxEL4A@nvidia.com>
 <20261126195346.GJ114472@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261126195346.GJ114472@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CA:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 55eaa975-483b-45e5-8e25-08df4bfe63a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|7416014|82310400026|10067099003|261028144727099003|11063799006|261021121427099003|261026140227099003|261022105027099003|261026121527099003|56012099006|261021135927099003|261102123227099003|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GDsKTGM+P4FTeTzJzafk5VRtSZ7TFNUJrU3KWk0K0cWc3M3u+P5GtU/iCx0UHkhJYc5JyLWkn1zfE2DI8F5ewuXat9r/1dCufKbxlAo6CYDL8VpTvCT7C5mzkvu5HLKmktOpZb5NnZT57Ar29cVboBNALbEB5xxCWtpalgUMjOLBadNxQ+Cl4vxSjtByLSN7lUM1JbKL9TMDmWAsToMH1hutWv55+x1qfd39d3afO5T6YbK4GMRU8oG3dYfAnVe9IYNNz2ltR0I9UxfH1D4/osOLBlMx49vFGr1A5Rrtr/7fklx4bOMylbkx6PS3mz1orSALlk0lKG3tHeC415TGOGfVk8gIiOwKxJT18Anae7eTWuhaCDeV0aqVGUg4rr5fRMI1q3dXfxojCWH83RhpBcNbOWrEr0SnX69kpxqbi6FTI7Wkb5zHtcrkPqoDN9Ep1M56XF9jS3xJcSi+7dsXAv34BbLJOmk/oM3vrANPE6kIquHIuURku0ncMG0SjtNpGGVv+kVyFW2ZoG25YVW5stZyhZz0tdN5BcIQMUeXaNX7cJrYBsO9NgoPCf8V8VIrp0dYsficyHpHdhGhRP+XCDueovYr+PA0V5Rjdx2wOfVvWF4HaBLs1YyEHDFhJCL9oCs2fCDSyDIMM2VmdFJzfbhnSWLRVl4t1OLd05wxD+2g8UDSjO+Kb1/59pWfZeZSlqTDSY7KVPizfWlj7p3ihQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(7416014)(82310400026)(10067099003)(261028144727099003)(11063799006)(261021121427099003)(261026140227099003)(261022105027099003)(261026121527099003)(56012099006)(261021135927099003)(261102123227099003)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ns3Tr/EX8F4ecZzp8z+HSmeDdLLsibCmzidL8UfMvWAlGgMxwmDpv2mVH5L/ljfQp5/2odDEuUjsVpMK3PJNqeuwBZD71MS8HSoFU2vYVpFlTfwlTg0UloT/eml12JvKmlEsm9zKO1/Ntk8CsZzT/9jywA+rqNqlUtkQ4gZQfYC6ODHdKmLBakNT+4OuICw4g8mSfrI+hJuOzRLKaSAPP0PXlp5D/Sr3Y1Pq1fN/qE/jIZV3CIyKMsdotfPF++CzNRf0xKy+4F9PoiL1aaCZGfPVciw1n9beAuFuGkhzEUq+kGwUSlavjnVijpKHTdc4pJeF81zeb4FfsLKyz572amtllaWZra3dTd5hYqC+NgiZtmqFBdkgXSK2vsAxsQtyWOE2Vqs4VAWAhtY4INmNFVIxbQazj/EDSh1whOwdesgMFAuoIEq3GB+IWIacsHlT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 20:46:47.3533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eaa975-483b-45e5-8e25-08df4bfe63a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574

On Thu, Nov 26, 2026 at 03:53:46PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 26, 2026 at 11:41:38AM -0800, Nicolin Chen wrote:
> > On Thu, Nov 26, 2026 at 10:57:15AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Nov 25, 2026 at 08:49:30PM -0800, Nicolin Chen wrote:
> > > > On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > > > > Though I am wondering if we really need the ATS stuff. Why do we need
> > > > > that? The pci_ats_required() in the hypervisor should force ATS since
> > > > > the hypervisor is not going to construct a vSTE or use a nesting
> > > > > domain that would inhibit that? Can we just drop this whole patch?
> > > > 
> > > > Ah, you're right. It was added for non-pci_ats_required (non-CXL)
> > > > cases where the ATS state needs to be in sync with the hypervisor.
> > > > 
> > > > However, the justification/usecase here is pci_ats_required alone.
> > > > 
> > > > One small concern is whether VMM always exposes the underlying ATS
> > > > state or not to the guest VM. QEMU seems to do so. I did a test by
> > > > dropping the patch: lspci in the VM still shows: ATSCtl: Enable+
> > > 
> > > It probably shouldn't do that, but it is also not harmful. The guest
> > > PCI controls should be fully ignored by the VMM..
> > 
> > Would a PCI device driver (running in the guest) check the guest
> > level ATSCtl state for its ATS pathway?
> > 
> > If VMM is not supposed to read through the physical config space,
> > without this patch, I suppose ATSCtl would be disabled and ATS on
> > RID might not be functional?
> 
> VMM does not bind guest vPCI ATS Control to the physical ATS control.
>
> ATS is controlled through the vSTE only on all arches.
> 
> Without a vIOMMU ATS is controlled entirely by host preference ie
> always on if available usualy.
>
> There is no need for the guest to read or write the vPCI ATS config
> space, but it does anyhow because it doesn't know it is a guest.

Hmm, I think we are talking about different layers.

I get that the physical ATS control is decided by either vSTE or
the hypervisor.

But both the ATSCtl state and pdev->ats_enabled, in the guest OS,
reflect the vPCI status.

Since VMM isn't supposed to read through the physical PCI config
space, the ATSCtl state would be disabled.

And pdev->ats_enabled would not be set, after we drop this patch.

I agree that there is no need for the guest PCI device driver to
read those two vPCI-related states, but if it ever tests either
of them and gates its ATS pathway on it, this can break, right?

Thanks
Nicolin
