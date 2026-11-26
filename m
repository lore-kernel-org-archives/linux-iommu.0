Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674255;
	b=0fYnILxJHs1Afs/UTbTLxaHVUf1wiP9fP+0EjTWRBoq+vGYvTNezkw/Cylsg7d9QYfJl
	 yuNjR1Cs0f9ozE6sOLtmOvtDTBhxVWzoNScXdTZrDymjHXnaYVuOE1ZDQpW5Xm5ybpeFH
	 gmLij4NX9FVkJAmzOtzOBvB1E3eYnuRXN22NwLgAs4R/4SJP4vRDW95nrWG5RQ6fM+S8T
	 /ZiCnTq9KT58vGQ2lkOayU18iX/jdfzo4dbhvEaQo+lWk4Nyavt/v/7xzGXHT2uGZ13at
	 LKj0HcdXPI/NIpRYWKkyjVi26RsNJ2mtbUuYgSxWTnSzS69/rbkTJN9fEnWAZlmLBzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674255;
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
	bh=tf7B/0Cioeg39db4Chs4wrjbvneCfeod37symkgtLWk=;
	b=hMs2uCj1BeIkynVJkXnyy4qp1cc806HDqVwprmaIx5WuY2LW93Q/ggZMGzThnHwQyy4n
	 SByjTVeMr2UU0BEQYlRlDdhwjyN/dmlNhuCSkQLF1iret+4PDfugUZmFJifDYyV/IGJwu
	 qCvkS7/3hcUFZjrL7WvHWVWVtXe/vftYaRRErB0yi/+VnuSD6T8yH5hBRXhe1aqfjybwL
	 U7XYEz83js38fRIjyHZYH2tHDxVCxL0Jc58LuNH3KUEMB1tvhA9e54qgiIFlFaZ2wbb8S
	 QWgj40zgticjhnvav5gX5qz6juVUqc5ptYPmqNEeG3ox79YIB2vKd8VEKcFcpGpv0oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l7i472Wb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.33
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9B606A321;
	Thu, 26 Nov 2026 06:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC9B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l7i472Wb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/iM2z0x5B+VnDcxewhAbNNZJhdMlnYblB/hIMUCHH6xWxPhkZTXgHo9bsIGftmq2Bqh8XVcDQliqWWGC+x5jg/txSfofcrcYLBQpFPrf+xmRmZKm9rlQOoxgdrHZarW7cdfqEXXtqEe33SHkrguBJBp0yammkUUhXPEAfOxO0BKIJTomH/bcFEGX6ggHedhDlDweoQrAqo3F0KvoAIh+E0AhdVI7F4aINAGJjkljlTr2cxw1r3s+AB5Y53n5tSW5zxCiAkOlFFdRmIpVJbBgayGo0/0XEoEIMTyDnPQySQJOWwlqgNHw4opU5awAcI9QzJkSH+kM0fOwH3nU+JAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf7B/0Cioeg39db4Chs4wrjbvneCfeod37symkgtLWk=;
 b=DgmB22Gna06PD/RgKLxZsSuGZKSAYsNTDrZ2RkRNoGZ9kyFBUjCrz5GJuZDYDpydPN/DoEaTUz0M/GzoiaQXjW1soRBQ0NmqAaDEtWA69ETJB0pqgKd5VcxxeV4qY3QDyACPnx8JXoxcjdmIl+iXMW1V3bgDpfkjkTyEiAT9dtveD0X81SoxA+OLavyKRdQqBoaJ6vKWtjG4zl3PfHN5+FSx8MlTHU0M4wzrYGZNBTV8Pv2QXS/o64ZZ/Lh+q+BstwVMDPeLUdfd5xSd8oxdL+EyVWok13j9EqM5vKrn2bEZ8QLrzZZZtf6L0orQhAXHJiewZcaf6+3ZooJwuzq+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf7B/0Cioeg39db4Chs4wrjbvneCfeod37symkgtLWk=;
 b=l7i472WbaVseyv9trKAYXsiAZMCsis+Puwq+JkBb1SXxJNEmRM9KCLK3nAKKaZkA+AHs+JE9kWBXA3gO0l1PrsS8oI6H1URAqx8pZoAOMEe8vA60K2X1FWPz0B8sOG1ZtfSEmy80CljQ7pXZsHe9Un9GATX481FE9wdlh03ZvPt/6Z84h6qbrev+yaOpquzylBnvgsQMOOkcg3TzlehrzAExwyzwT6lQy88siibRZ67c98XW96BzpHQroODde9Wz1InnhZf6w3gzPOeUUJkuI30CnPeUQO8IDm4mCMF4unh8Aou1gQetRJFYxAZqTf2BX09o3VAqYEhcdCOqJdpyhg==
Received: from CH2PR18CA0047.namprd18.prod.outlook.com (2603:10b6:610:55::27)
 by SA3PR12MB095375.namprd12.prod.outlook.com (2603:10b6:806:514::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Thu, 26 Nov
 2026 06:22:10 +0000
Received: from CH2PEPF000166C5.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::58) by CH2PR18CA0047.outlook.office365.com
 (2603:10b6:610:55::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 06:22:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000166C5.mail.protection.outlook.com (10.167.244.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:22:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 22:21:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 22:21:52 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 22:21:50 -0800
Date: Wed, 25 Nov 2026 22:21:48 -0800
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
Subject: Re: [PATCH v3 6/7] iommu: Park TDISP T=0 devices in the blocking
 domain
Message-ID: <awfP/IZxaVA7ET0o@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <6620f49a3bb96837034aba24b5131a9d8c7eec8c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.16635562157369118727.b4-review@b4>
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
In-Reply-To: <179563006502.253973.16635562157369118727.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C5:EE_|SA3PR12MB095375:EE_
X-MS-Office365-Filtering-Correlation-Id: 262d086b-454e-48a9-6b36-08df4b859a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|36860700016|82310400026|261028144727099003|10067099003|261026121527099003|261021135927099003|11063799006|261009223027099003|56012099006|261022105027099003|4143699003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	n6ntSmtuxtoSu5WCTM3Pp/de57nRZCRp5f4pZFivnLhEfgFggraQIOYqld3rusvFjAwBUQOAYxIIqgpt7O88CIp5SGosBfAxgzMZVgzGw6dMYzwULL7Wc4+2GKJFLsUkx1HxGS/3nlBaurJhB2DJyGTeoT8gzVxEi0ILz+rA2G0jL1vXmtLaQSatzpigIjREujzRe5iDz6wFbR/clDZ+cIt38ou7SNGd7PCW2jb+/EWliH1C2bx/m4QISFbFemXoEJAgWaLkY3Mz7Mut3nxLEYEqFSSXv9E9BWpxgh6Llvj31Nt1I1Kjc9CZuR8BGeBdy6AsZoRHGZ7z35BR4e2z981O865Gh6CMmOeM7xvc2zilQeatMDju0ZGGIyhOV9hODftivoEAGOZ5J8G1yQnd8yAaOBAcdoLUGMk/g/rIn+lyHgn4guHImUXyGlIlrazJNcGr9ju5JFgmE/1NV/gXsu/Zv9hIikZsIFuBVF27XvPkfTILjjuKZmtirwn2wyIQPlj9s5JYgsWfGDN6tsFPDues7TjkKMPw73VeHkcu+tW8OLFGikv9MtAyA7I1MtPGodJ61wiRvLuFw4H4717HhKbCYaMhxXnJgboCXukv9yDDuhiJ4fcsXVFUMXvnJN9f0rPmzb4h9TLVXKFzEOYm9SVPGS1K23Ifof/J88Z8jhlhlRlycfschkZEd2WfaYLYCAEToVKdw8crQr6PJ6aThg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(36860700016)(82310400026)(261028144727099003)(10067099003)(261026121527099003)(261021135927099003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(4143699003)(261026140227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TCiirqfY5DdSe+adT9bzIiPgz1jmmR8QZZgyodA0E3/U0hE3pivCSm8/KS0UQJoWMrSafsrKIaA+BFyjxnz7i5AKMVw1oo+Kae7VA73HK1Glj0jNErFaYvnK4wE+bnGYd5+MiGQ6YjbpHXX35pUbrPx/r2cVgiAgoPdeFb0BFUoUo3H9QpZfsn4wgFfjGXLfYv5a8sNy9DvlDvmOq3nP2uhg6N2YC3jewE1wLh/a785rC/7Duvw/nhFn/WeVS7sAl1bgM/oDrvgh5aqawIR+rIWdIR8gCqJFuYes4L5b/3NUZajsS91p4xGI9it8mjyqofXceUU25v/wMcI/JN++cdhQ6X4f/OU3EfIvBHxrqFcIyLdXtoyJgVHFEWmolEa0EMrgnCfe9djQl1jl24yuRA34URHojlfmgJp7rjEdNBzvTuW5srGl85einKbT+ntu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:22:09.8464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262d086b-454e-48a9-6b36-08df4b859a37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB095375

On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > [ ... 28 lines skipped ... ]
> > @@ -1238,6 +1238,14 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
> >  	unsigned long pg_size;
> >  	int ret = 0;
> >  
> > +	/*
> > +	 * The direct-map reserved regions are still fine because the T=0 stream
> > +	 * always goes to an identity mapping. Skip them: recording the request
> > +	 * would only refuse the device its blocking domain.
> > +	 */
> > +	if (iommu_using_t0_stream(dev))
> > +		return 0;
> > +
> 
> Not sure about this. If we are allocating a paging domain then it
> should always have the direct mappings setup in it.

Hmm, is there a paging domain for t0? I thought it's always on the
blocked domain..

Even if there is one, t0 would ignore those mappings, since it goes
through the underlying hypervisor path, right?

> I think this patch is the right idea, but it should probably be
> removed from this series for now if we don't need it to make a basic
> trusted vIOMMU work.

Without it, every device sets dev->iommu->require_direct for RMR:

		if (entry->type == IOMMU_RESV_DIRECT)
			dev->iommu->require_direct = 1;

Then, __iommu_device_set_domain() would fail the first test:

	if (dev->iommu->require_direct &&
	    (new_domain->type == IOMMU_DOMAIN_BLOCKED ||
	     new_domain == group->blocking_domain)) {
		dev_warn(dev,
			 "Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
		return -EINVAL;
	}

> After Leon's trust level series we should have the flow I mentioned
> before where the iommu starts out in BLOCKED naturally and we will
> allocate the paging domain right at driver binding.
> 
> With that infrastructure you can make a decision to just not alloc the
> paging domain if the device is not in T=1 mode.

[...]
> > [ ... 30 lines skipped ... ]
> > @@ -4294,8 +4341,9 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> >  		return ret;
> >  
> >  	mutex_lock(&group->mutex);
> > -	/* An IDENTITY domain must pass through */
> > -	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
> > +	/* An IDENTITY domain or a T=0 device must pass through */
> > +	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY &&
> > +	    !iommu_using_t0_stream(dev)) {
> >  		switch (group->domain->cookie_type) {
> >  		case IOMMU_COOKIE_DMA_MSI:
> >  		case IOMMU_COOKIE_DMA_IOVA:
> 
> Hmm. At the moment we expect that MSI is always using T=0, so this
> would be more like '!iommu->confidential' I guess since T=0 will
> always use bypass. It doesn't matter at all though since existing VMMs
> ignore the address selected here :\

Yea, !iommu->confidential is much clearer.

Thanks
Nicolin
