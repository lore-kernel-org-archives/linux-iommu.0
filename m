Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA921ABB6
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358309; cv=fail; b=IpBgyI0FZXdTcMIOMZsism6W8UJDmPiKFVTb9dz+rp8j3VYwfKof5glVvFNI7Rrr/bhNO1LKzTTsYdfOIig+44u2m7k8yd8+83SA7dSFjoRmJdKQ5cQeSNtTvFSHRIqc06Y5pi2Lj+vPotcU1OQ4A0ZmpizO5y1rxUULEdPGLNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358309; c=relaxed/simple;
	bh=7boOK63B//bfDxDbP5liuAv8+I1QTYZ5oiMOUOgHjuE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dc4XQPJJbX2ablCDk2CgD9HEUQJcic02zJTYsxlTrgepJw7tttbV98SfkLM/ntDl3smFNGpIsPGPR6KQxwrp3utM9H8RSQtZ4NQcsLDk/b597xj2BfA4evkK459QDjJC7q16z+0GblQyR64DHQrt2uFLYjWzYkDmqVGIXzkTDFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZWueO7YU; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZWueO7YU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjeYZiGY+7go5ag7PHoFfzF3umrCm1yw0MNcBYPpZAJsCrEIMVdMVTfzuVl2t/fHrj9DAW1T3XMDwMS4KVRb5Q+/Xe+LgJDTJfJk+XslnZFU8HvTYfBcfpdlyHDdW0PKoEsa+E4ES+gmOPimUT8XBlprbrc/4oSJC1RFig/Hl66LmTchHgXU/utIqsORVs8pfQ7sh8ggFrcrjR1EF44tdJ0daeNVTci/sSyWPjacv17UHs3i7FzUdujfdhg/u/6CIxD6/laBaTsQqzX6X8ea33odRBrSoabL+2N2OFykohuOPXi+vw9Nffzd1eV1uLz7nFRDcqeQfjE5vhp0UnLAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS2bkoJ8TXD9vtMxvdy/yp+c7brG8Ft/HLEycrCaQB8=;
 b=My7TcsnFfN6e1Xy7Z+loONnGeMIU2PcA/TTP4pmjVUetYHKrRA20VfmEVu3RpdyZQJg1jpPzU4phoH1o42QJUZ3XLyktYWH4VNoQnyv9Al8HBsQ1uVHqFfgqIdnCbWpOVGw7ZA7ou/yGKBxskL+exsTROo/+SZOBqVC5G2gmh0nSBB5SI0UskYDhr3mw9TPk9DIRXzcUBhTK5W9lB/0xR3BKDFwUDDe65TFhGL4DE5Ts4tReDRf3NIJWrQl7cVQUANcQTMk+FImq5gQCZVDA31LlNYLxWbaa2+2cJNi4CTmzMcJvunQuXWyFcbGcChmL1fQjDzJfgMmuq9PqgW3Wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS2bkoJ8TXD9vtMxvdy/yp+c7brG8Ft/HLEycrCaQB8=;
 b=ZWueO7YUPsmvfLFrJ3fkpXQ45FqktHDqhTs7NNivgL0yh8zY4C6BRWoVvBu++10sEt+N28vBuI0sXx096KRx0+OT3VnB4bHtBlbFzPBToNlfJY66DzrVer7SHuDGjQCTCoGVRi1EyaJYTvtcMhbqfmzplWWleWtf879/gEDckQvm18M6E3hKjBjVsodFwoxrglYENMZr6JscVC9CXAgjFSFWOzCv+YM2IJAcahGB2UDedB14X+CATACaj7/Tbt30YPSTBAX4cbo/Phpo6L+3aeo4oebxhi1FEfJ9w3ZhJvlpp7FFE+OQF1oXDdMNipgRfIsFW7Zz4VZXYsfR8gZpdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 14:38:23 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 14:38:23 +0000
Date: Fri, 7 Mar 2025 10:38:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <20250307143821.GM354511@nvidia.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
 <Z8qzP3CR8Quhp87Z@pollux>
 <20250307124809.GL354511@nvidia.com>
 <Z8rxm-BHldKqEwyp@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8rxm-BHldKqEwyp@phenom.ffwll.local>
X-ClientProxiedBy: BL1PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::30) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: c99425d8-870f-4d93-bcd7-08dd5d85b68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkGQWX5mesuMe7cznmWgAlrqonpiKSLGuhN3+1ZGAx5QHSS5NVozIcNpRv7U?=
 =?us-ascii?Q?mX3WIrWDUPRNc1V+kJyRuDPAY4A30F7GkzuCoOkqkaj51NNcR5kGPEA/Sm/i?=
 =?us-ascii?Q?13jHmAXGAtt4oa9rbhloGRwJX9YWR7y5NACAZqbk4TSfnUhCPNGyMEoQ+xT6?=
 =?us-ascii?Q?WNfrQvfAsky/JTfWT3FKvDjvSbZL/c4uVKABfOPOSEiXPgJikVKwjKGoZDXS?=
 =?us-ascii?Q?B3+Dq8oY6DxncpC0N3g7qJUwprrB08rW6GwoDSDvIGV+RRpqbCTfOCxdZ3kO?=
 =?us-ascii?Q?YTXkkvwZvN3iVA6imwOiuJHBqFNMEW3PvHVcLAX4bmYPmgTkvZnam2iMEqIv?=
 =?us-ascii?Q?82g45haWYXTSSZv0NlKj3Lh+9q4UWrFw1t6276Ok77PrnlwHiWNZjsb+FE7/?=
 =?us-ascii?Q?DZaru/G0I5dY/jmm3kkkn+ztjFUwrheIFUHKvkDERPqxXWCRljxhvrfQA/zQ?=
 =?us-ascii?Q?l1NtJsZJQr2SfLDR5+2gzKt7HWdonFmSHN2OzG5WaIy45iZMqpBuAFmoHZdq?=
 =?us-ascii?Q?tn0F/xGa1C2j3oN95qcTbyAEIeldXJKoT5/qx4rfkVUYt8hAK19VxXg0/x13?=
 =?us-ascii?Q?21+KeyKwKBe/zyhykL01tv0xcUmTfx8zZFARl2A4Dg9PkbKKcYXCFaJOa7pg?=
 =?us-ascii?Q?dlLRj5THq2Dgz8pfp1o/AqVw9DDJ/ghOZRxThhEh7Y4ScBRamYVzZvQquoYR?=
 =?us-ascii?Q?x76vuDlBAgEJ4r9JWxw3jRdG/zqAUbzZ0d2V/mC74HYlw9LRNHdGwFPWAwrx?=
 =?us-ascii?Q?YPOx3G5eJLRx+XMliE0FRhoKuwuUmk63i+T3UTiiWQYoaNlcwaT8jBZBLG6h?=
 =?us-ascii?Q?fn6p9MVMtg9wkB7B41daq+wTyEgw/CCA1mTA/u7e70leuioAykH+2CE98bV2?=
 =?us-ascii?Q?5HXK8r4aLWp9Z1uRHHLd6RHZpzcDrSogdtx9g+HFAksZYSNHJtmOfnR/g0F0?=
 =?us-ascii?Q?H0bYI8x1tP8Y3JKaoYIQVHa9iq/M1HmynXJNmWnrmIgNTKCoC7Dl3q+LU5QB?=
 =?us-ascii?Q?b2ZOz5FCb5lZP7thYv0brOjlo6uCgOu7cwUs2VmNB/yZjG+YRsQKCC40Wq7b?=
 =?us-ascii?Q?n8kK94DQqcwolAY3DL2N+O8AbGgFDnuL35kkMgHtIxwcdqykGDepYE8E8ZPs?=
 =?us-ascii?Q?Qt6+siRZfhbsbUk95E7mgmKsUq8fn/rD4kiGe9GxCnNXqXM2HyNF7QBVTLtQ?=
 =?us-ascii?Q?X4YSQPX+Thm2Mu10qtkbRLT9ml6lTsYsyCEzK1dUT+XRXXKMPYkGnKcoY3vd?=
 =?us-ascii?Q?Q7MXBjVRHmk6hrO/eykxBe8AgCGikX2kH870vXyTWVbIyq9ZWKCnwdutEnJt?=
 =?us-ascii?Q?YoS7IJ5bnZnkM7tirigwqUtAujQ/CizK9LfybZ8RHNyxOVOH7sxGCLBJF1Nc?=
 =?us-ascii?Q?2QHNk2FVZKma/z0bM+LxT77/HnTifhA9khwPiPpbimUc5WV4Sq2he+Yt94m5?=
 =?us-ascii?Q?KDqo29i/22g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDoA6dn90ndygdP3YKx7TeQO/CRADg3arGHr6ngt4AHybDNqSBKJZyKQAeBe?=
 =?us-ascii?Q?eN18lY9FcHojpEyQKu75CqEHzQ2YcH5jZJil0L+RVuG4gw6HYUqtL+4bimDx?=
 =?us-ascii?Q?M1eEU3OJaaN96WTCRytQKzszUuian+sYTVbxALt2jnRWh8YfxAXq22Cr+HkS?=
 =?us-ascii?Q?qcX3IVGNo243SNyfFhEx+5GGkSjVpiNKwsvjqFgCgT1M3hDg/iX9bnZ17xvJ?=
 =?us-ascii?Q?1+UwmYG/is1Bn9pn1SR/dKijQwdVl50Ruev/4qAa19SF/Nfs5eqnlL6ifK/C?=
 =?us-ascii?Q?iwvfUbBwNpA6Cyjk9Q5WRC58I60ug+lAGYfVQnxiHb7NdyY1pQZgIrvvq4EX?=
 =?us-ascii?Q?oMWSYx0G6HHOKkIyjp8ccsJU1NbsG7ViDQiBcrviQfOas6G31WwHL97Hlt1M?=
 =?us-ascii?Q?ZJNra/c1Hm5pak3mRS1MmneYsZcVOKcCS6Tnfj62xm5x0oMt7HMKHDPTk1YG?=
 =?us-ascii?Q?zZP8nlThL9vHMNBqw5xEyY90d3fsa1vsFApsf9CHkD8dkSNSR4h5p60ejPv/?=
 =?us-ascii?Q?W/k2Etc4Cg/4/3SFIAn/Ic1BQVwCmYOMoPbprnwBH/2kZr/kTJXx2hQqAZN8?=
 =?us-ascii?Q?oOHSg8pi3OaC0dxPZzlCkZwrCVhrLqXOWNuRB2x8xrDg6R16SU4yd/f8yoaN?=
 =?us-ascii?Q?J5j8cL4yVDZ7R41DjKvHuPdFBSz1nFrQmmtZ9c/2v86aseAQGcGSpA3eB5/+?=
 =?us-ascii?Q?xQtb8w+pZI0oluyyqjY6k043Hnq/Fky4EZwpHPe/I3yS+snkdV95DuCe5Izn?=
 =?us-ascii?Q?TCyVGFWRcfORmIxuaoOHZiv+lf1dVQOomE2zbouE4QuPb5phREYJLqH6InOu?=
 =?us-ascii?Q?GIm62iMhYDue35L2sZNVNQ+xJIrWdaCLwv/m8luiVk7ai5SglS36q18xTdzE?=
 =?us-ascii?Q?hD3d5MECeCtUMt0qNkr9eMvoClJDqt2IqsKfkSI7abQm81xir/lA51ghl3XL?=
 =?us-ascii?Q?93pxg9JgJnyBD+/Jr91I65+BVNA7Hp1tZthgd3yaTrGQtqYybNt0d4DKB0GQ?=
 =?us-ascii?Q?98pqP55+/JYZPVGKCtTc2Trem1i4yVsaz2GoomZtwXqRJGc3PL4XXQmbhlrQ?=
 =?us-ascii?Q?WJBzi33cNH18N34cEhYNIXchaT9VnLDftS3eesocKJKDCqPmEuzk2VM6EaxD?=
 =?us-ascii?Q?O5RqUWFVeYmR6fgVHuDu3Vgm0CTzWw8wWGszKgyuxkFngb4gqUDciZpAV18E?=
 =?us-ascii?Q?UGiMsyPiHBi4Fk1nb6OT2NOhs1LBuDlRiS/R9VsyZ2SlNy8uYEbpZrxBbkKC?=
 =?us-ascii?Q?zsLc2oiTha2932Gipy7R+KbE6HTF2CK2MdQBnjgm4qIc4liPyoPOhZk9cxMn?=
 =?us-ascii?Q?gClCxG1EiVb1jBGxLeOP6sSghbaCTKSJqSu3yzYBRiPwkUefdgXBm6U/cTZS?=
 =?us-ascii?Q?jA3e/N3D+KSvIsJsnid8fUbjRJHV5mgsbKR0YOxwtgEVRSQbvXsoe9Ko6feu?=
 =?us-ascii?Q?FV3iEarhy9igLZpLAUVoXso7/8qFNaqOa6e4fcFvKEtU4bEBcCAIyMhUy8Aw?=
 =?us-ascii?Q?x4oWfKsSxmNuToKzBSCisZFUWcsDKX1KKuCqnsynAsNXRluOIum1dEBnRghE?=
 =?us-ascii?Q?mCSyfMWQmsZwWgyLHnc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99425d8-870f-4d93-bcd7-08dd5d85b68f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 14:38:23.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29jUJVqMCoCRnk5Tp171nYPCP1EnUJE/kb2jwnsl8TYCfzVLrxz8UZ2mSwECk9Bk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236

On Fri, Mar 07, 2025 at 02:16:11PM +0100, Simona Vetter wrote:
> On Fri, Mar 07, 2025 at 08:48:09AM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 07, 2025 at 09:50:07AM +0100, Danilo Krummrich wrote:
> > > > Technically it is unsafe and oopsable to call the allocation API as
> > > > well on a device that has no driver. This issue is also ignored in
> > > > these bindings and cannot be solved with revoke.
> > > 
> > > This is correct, and I am well aware of it. I brought this up once when working
> > > on the initial device / driver, devres and I/O abstractions.
> > 
> > Yes it is also incorrect to call any devm function on an unprobed
> > driver.
> 
> You can, devm groups nest, and I think by default (might misremember)
> there's 3:

This isn't about groups and the group nesting, it is about what
devres_release_all() does and when it is called. Yes it is called in
all of these places:

> - probe/remove i.e. driver bound lifetime
> - up to device_del in case you've called devm outside of a driver being
>   bound.
> - Final kref_put on the device.

However, AFAICT it always wipes out everything. You don't get to pick
which of the above scopes your devm is associated with.

IIRC there are two different use cases at play here:
 - struct devices that are expected to use drivers
 - struct devices that are known to never use drivers

devm can serve both, but with different rules and lifecycle. Remember
if a driver is attached and probe fails (eg even with EPROBE_DEFER)
then devres_release_all() is called and *all* the resources are
gone. It would be functionally wrong to attach non-driver resources to
the devm in this case since they would not reliably exist across the
device liftetime.

However, if a driver is never bound then the device owner can use devm
over the device's own lifecycle ending in either device_del on a
success path or possibly kref_put on pre-add failure paths.

From a rust perspective I think it should focus only on driver bound
cases.

> > I said this for MMIO, and I say it more strongly here. The correct
> > thing is to throw a warning if the driver has malfunctioned and leaked
> > a DMA Mapping. This indicates a driver bug. Silently fixing the issue
> > does nothing to help driver writers make correct drivers. It may even
> > confuse authors as to what their responsiblities are since so much is
> > handled "magically".
> 
> I think thus far the guideline is that software uaf should be impossible.
> So calling dma_* functions on deleted devices should not be doable (or
> result in runtime failures on the rust side).

I'm not advocating for UAF, I am arguing about what the correct
response is to a driver leaking a HW linked resource like DMA past
remove. I think it should trigger a runtime error, and maybe a sleep
wait to prevent UAF, not be silently partially "fixed".

The goal is to help people write correct drivers, and correct dirvers
should be written in a style where the map the DMA, program the HW,
deprogram the HW and then unmap the DMA is clearly written.

Requiring that pattern be explicitly written in code so that the lack
of language provided safety has clear markers and expectations so it
can be reviewed and audited.

> I think for the actual hw uaf if you leak dma_addr_t that are unmapped in
> hw device tables that would need to be outside of the scope of what rust
> can prevent. Simply because rust doesn't know about how the hw works.

I accept that, but I think you need to force this issue into the face
of the driver writers and demand they deal with it.

Silently partially-fixing the leak of dma mappings is far too quiet
and encourging of dangerous driver design.

> knows it's not allowed to automatically drop that object. So both patterns
> are possible, but rust has a very strong preference for the automagic
> approach, unlike C. So there will be somewhat of a style different here in
> what a native-feeling api looks like in C or rust.

I don't think it is simple "style difference" :( This Rust direction
is radically transforming how the driver lifecycle model of the kernel
works with almost no review from any kernel experts.

Certainly I object to it. I think others will too if they understood
what was going on here.

Write a position paper in Documentation/ on how you imagine lifecycle
will work with Rust driver bindings and get some acks from experienced
people??

Jason
