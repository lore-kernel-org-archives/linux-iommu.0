Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242B129E94
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556759; cv=fail; b=k6fKubR0AJ+QwTHeyjm3XB6a7/+SP3ZNxNPRHbpdKHx2TrZw//sU/6hGk4h58LLlQHXXoV3KqBQAxCAqdOHiUBK8ZcfFL0vQsz4nAkXth4mb0xVbVfjTzzq6teJsQGZds1XEFAMKdnUDQW20+5KKDzjEEDrDSijjxTYzBkesIsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556759; c=relaxed/simple;
	bh=suDi8Ym6tgoNy8GPjmhsMAnX8+lvl1i9sKoUaiZwQqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HV0XjjgIh3BnFseOoZGcGQPMUsGANvF6c4FnuSNiJQnSKVnD2u+CURejcPenPO80FsOKTQKI7MQfXkdCCkli0TjyML9Oa1TRcuCAcRgVuuVu684/v48ytZawgXNzjzvKFe2qC8g0cILBFjtr5qJWTWE5bnEb4k282g35OU6kxA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KnxyjTve; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KnxyjTve"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBYfazUoHBOI0Cgnsju4FW4tpI5WIuPIi6F+L4wzNF5LTZJkS+IkXhuDJxI9ozWmfaA/GS58uo4ZFuCij/ozIm/j968PgUlQyv3LzLOjojHGRIXUvDhFEC/91OsChgrTVQOoo2f3EUxJzdndfsmYlOiVMtfKdbJfx/PfCs9ws2+3JSuJyfFjY453QOUJKewd1BaCSZvl/csdOpUtQpjMCCGs5N4JSrR/ngb28NGJoidgVS4idU29l1JYJxvC5ylI2oNzWG8Lwl2efHV9jIdfZIfgvVH1nweQN4nuHOHGz7tm9rkDLHk1oBgU8i72a5ns6XgIXpY4WeAOViGJlVNbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+lEYI92PtHut37TmNGcT9L4NffAGszesKN+cCaOe80=;
 b=CfTtJKo6GnJOK/EmtcyvRs6NQWGoPReMSl/p33zyMrUeRtPHXiFwD1AOaYPRLBwL2JrRwY3azbEqpFnUz67mQeXVuduC+EoYglKKgxXFhY+Jn2wnAlwScTdQucTOoY2+jZ6czPuNa0ZX6mhyvCw3/mFoDMjAPTQQkpRSHicYC/QDDdBYi121rArzxVjPLdeAyVh39garPPDKlDq3BQeZNbkGN1U+GBlEpuDil/BIq7DRxlfKsC9ROExD5KkqLQdVflcIqup/MM5w1Mmr39BlxbnI+fkBpws53C6p9Y3dhwCCWQqNiCzUKoF1OK90geuJNXzMmfrSQaTmAPXO6VmMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+lEYI92PtHut37TmNGcT9L4NffAGszesKN+cCaOe80=;
 b=KnxyjTveF7iQtGC60tC1TFl3TcfTEtfzQlPJmK+BgU3WxjvBilfk0kfYfpWo3I65qslZALoQLVwTdNtsOA9xZh/XYEdaasEefd/ZF/12ctzADVRD9savSG1wVIAQ809/qroiqPOTY0XpOVqlETTniyMy9TvTvtuEBT/2A9TPaY7S45vz5RlRkahDfAfpiulYun/J+x3KX1h28s0xB1DL7NcE7uYq6nMqIpVlIHkqrTubJY9VdNZRQ+9CzqjUgp62435sDHD9bLSUSdPL3+1A6fdwCEVTBAOO6HoORRhUtQeDqDJlNmsUmd5gLFbAt2qBS7K/zrPSjyNi4EHkYWoIrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 13:19:14 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:19:13 +0000
Date: Fri, 24 May 2024 10:19:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240524131912.GT20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YTBP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: d64e5c74-0119-4e69-62c6-08dc7bf41b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQPTq47zrn+o9fgBwe/RkF15gBhzChnASBsLoFcNJv7dq2Tdht1F/Vq6e1w3?=
 =?us-ascii?Q?0bqp1+cHq+avq1sfY1yRlah/4BZ5BTO7WuiN5ADT0BLGn7WTQPsUqG4mM2Rs?=
 =?us-ascii?Q?VgNpEUps85cbTr3aLQ1H50gWEFzvR++jweuSHf9jJ7mvFOToefTludPwV4Z8?=
 =?us-ascii?Q?XRejLDMLPsYmPCEvTEjKZY+ULJ9L7A2fXhb5/R4OpMnsqTsWaUyZ4Qjyo8lS?=
 =?us-ascii?Q?uT6ReusVtFgpFdFhnKRxmo0Mu7ifj8J8uIftchshAHvOz5iN6hufe7tgKDcy?=
 =?us-ascii?Q?IhFFNqw3tgjMsAwXG/O+oh4ZriioOX9wFp2wslOI7f7bcPmpDyWYh986YQoT?=
 =?us-ascii?Q?nUVaM1Gs2Va2yfQZB9HyjnW6VTM+cepHGWpE4k14s6Z7U4zKySuHdRGvl6kQ?=
 =?us-ascii?Q?HJx5OFSGEIvufvnAnwLvf7QPrhnNb8ZdBgxZsqN74wJfw57/8s7JGhd+0jmm?=
 =?us-ascii?Q?cEUhPopiqhLlN31Cy0CSH/Ae8uVEe/CayIPbcE+5ATxs9iBc/F79FN8zY76J?=
 =?us-ascii?Q?PFTeeWK/FVkHLAvjE7I3tCDPEgqhZCqhE3+H19pYd7O/ruqNLCA22gjnkOp8?=
 =?us-ascii?Q?YAQBJNqnZtYdRkhLlgDIwcDh/HeyYVJmPKHZJp820VayqAASERgkRJpfHpDq?=
 =?us-ascii?Q?4fk90vorsbSK7R4/liggHWvPgXAbMVTuSJDY4G42haGFc85eFsX7k0MJ24Yo?=
 =?us-ascii?Q?onOUK/ZKlg2QRC6u9OfPNwX4pvzdYpJCff3ko00Ic5+1pxZisXgZYWYn/5H+?=
 =?us-ascii?Q?WTE8BDD5MjZbS/XpLwz8eZTn1nQ9b7uliyZzg+DAjl8YctOc3UmGIcaxt93g?=
 =?us-ascii?Q?9Nxa5w6meEjDrXwauoGj3OPyd4Dsyqj46oHSjiLzYq/ccfcAdom2Eq/F712y?=
 =?us-ascii?Q?K45HCIxyGT+p6B4Icy5r7FTGxk+S8/Nh5pVdkTrGyoFG60neO9ukYv8YM0Kg?=
 =?us-ascii?Q?e+6ZqIRjG5bHgzwZ9mo8jk2eZqXOI6FOKZlLcQDlheBdijKz9ZYUcjRtJC1V?=
 =?us-ascii?Q?SCuuzZ1tOog+eBOGkrdqwrRzdpmO9eC/8kSVqJYDNOlTNJC6BE3jY36jbKBF?=
 =?us-ascii?Q?vo84TFlXEAB8qBUO0OZlN29VZtBhyVSot2Y8WHmFJfpQVYAR6Hv0Zcmp0hps?=
 =?us-ascii?Q?dQJAkXsmvaAL+eU+1jwPUdNrgoEB2uibtasZ4ftrzI/pMEJv2rToHnxMHJ/W?=
 =?us-ascii?Q?rqgP/1RjvuWyZ0ZunWZFeB0eVfsMTCSFuYK7wbYkyAYkgAcx4KAt+I4tY/NL?=
 =?us-ascii?Q?BJA3u7FnSrsn2fg+PXp62Xg1phNefCn0iJd0L6kQdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qfZj8X6ezOyST0vMqxl0iIuNGbKNAuUglF6tdMOOxy+UPdPjCC2L0HhPAW8h?=
 =?us-ascii?Q?/zZ509gIEqiKInt0t3lMzhasp2qDgd9ErR8tBgKV5WwWHNYAUoIvRpXOnntI?=
 =?us-ascii?Q?ppmRSqAV9mZL6kjL7UrawyQf5pvPXZtrhqBjPfuwI1eqXfV6R7G9yq0D23gv?=
 =?us-ascii?Q?bn8fqLfvCMepZzWiUFO7ngIxdszoR04cwDk8dydjbyIDX47VbH8fnXgKhD/z?=
 =?us-ascii?Q?yflXIlifIo5VSdr9OZaP4g1lm27KlqaWnfySwRrYUfqfLHGgm2sUgXKkY+mi?=
 =?us-ascii?Q?gjBMjQRyRykUrDS4WTXBlA1chx2gmRgZJZ2SIHy/omzqOREfI8lCNfK77K/6?=
 =?us-ascii?Q?d1DKGEJhGY+jPcomsOGhD0Rp+yUvPGLI/oX7oSa6uOQaXLZz0CPoNBOxfyOE?=
 =?us-ascii?Q?U9+IXZRnkJw1qGM0al60Cj3bSkKHbHGyY56aWnlI5pMtvx9BQsNCIcAweWie?=
 =?us-ascii?Q?bKBkz5QmpNDmvzWW2ZBSFLtn8a83quavt4iEJ7Ur7mlZ5qXGXDVwyP/iMS/a?=
 =?us-ascii?Q?K0YSgmwUUGml1v4sUApjAr3eS4RalkF29Y/6fPtDrbUlVgUeI3JzR3YeMLrw?=
 =?us-ascii?Q?nOelwD+zGKYS+freN8NqYjQPWvXQ1IdTllTLKVBl+lvUmoeN9OpfjljK//0V?=
 =?us-ascii?Q?KAtZ7I9y0imj3i1sA0bD5oR0LslYtS1aZD/Z3fEO3dcpsnRQfw5fgQ/sWK1l?=
 =?us-ascii?Q?HKgdaqEPqxdXM23vMY7C2RtjFfqSq0nKSnGEBpNldua2daE9jeOpJ0AuxKFd?=
 =?us-ascii?Q?CfGg4TVGia18/x7unyx9iWCArvj/R/eIzZTAigd8PfSvaEBwH/YJJK77sP0I?=
 =?us-ascii?Q?kXv4q1B35kZpeZV/q9V2KWYQmy8zhZn2EZR9fC6Hxkptfsz1W+xMQ19f+6gg?=
 =?us-ascii?Q?LATpHvNbWqhdOPGrlTfrGKYvIzbjg+GJ6J39bvRcWTHbyEk0rh2NWJaUnYnW?=
 =?us-ascii?Q?abaeSm9vc1mxdTWQTW+AGJxr+FQc4gvZMLheSVkMUiD8m+GWeQMZtAu8q1y3?=
 =?us-ascii?Q?d186twhXw0LR3rViLxPKQSrCqKllTXFgFWjvVI+4qDgkAMBDaBBO9O2G4MAp?=
 =?us-ascii?Q?xmpa02l16N3eYHPaPcW9tPWtwrtdWOTS6/WM6wSFi9KEXVwRhl2lf7DfvrHv?=
 =?us-ascii?Q?4L42mWMaHJ3tSu4nDoKOIj98bK++ho1GmqTcpYvy8Ik9hPcz0jC/UglZ6VGx?=
 =?us-ascii?Q?LtufgCbqZxxFjx7YPuqXlxPAEs46CjJATLkt9FScfb8L6uSpkSIS9UkiyHiD?=
 =?us-ascii?Q?E1tZ5XSppYIMxLx7BCvKiRa/0xsP/6YY612DQ/V7BaE6QlrnJGuK1BazOPBH?=
 =?us-ascii?Q?zT5Lh1AbfJUTe18PGmQFsO66+w3/xNC/nWEtIig1puGjirfcf85aOmqotYTS?=
 =?us-ascii?Q?qjescCbO/W61tIpG+Dp3uhDEZ58Z+wgiSALhF/kV6DA0GRgvKz2U+xw9cE2U?=
 =?us-ascii?Q?Bv8vhhgUfSZ6Ie+sSlWMSj5LL37t8L3nPHafuev6ZZCxvNuw4GBW695X+GeX?=
 =?us-ascii?Q?6uaXtkH6SFotlZkLGgsHFqPNzP7DoqSOytCBuC/vr4EEAq6R0w8VDxsjtgWS?=
 =?us-ascii?Q?mT/M66LczCwPEoLyYO1q0WK5JoSdf9KUYk0ltsny?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64e5c74-0119-4e69-62c6-08dc7bf41b13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 13:19:13.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/F8KnS1dh8sKO68eWIIIYYg3NiT2rxdcsdxrbxnv5mqFuwtiiKwWqXfqXTCHPZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

On Fri, May 24, 2024 at 07:13:23AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 24, 2024 1:40 PM
> > 
> > On Thu, May 23, 2024 at 06:42:56AM +0000, Tian, Kevin wrote:
> > > btw there is a check in the following code:
> > >
> > > +       if (viommu->iommu_dev != idev->dev->iommu->iommu_dev) {
> > > +               rc = -EINVAL;
> > > +               goto out_put_viommu;
> > > +       }
> > >
> > > I vaguely remember an earlier discussion about multiple vSMMU instances
> > > following the physical SMMU topology, but don't quite recall the exact
> > > reason.
> > >
> > > What is the actual technical obstacle prohibiting one to put multiple
> > > VCMDQ's from different SMMU's into one vIOMMU instance?
> > 
> > Because a VCMDQ passthrough involves a direct mmap of a HW MMIO
> > page to the guest-level MMIO region. The MMIO page provides the
> > read/write of queue's head and tail indexes.
> > 
> > With a single pSMMU and a single vSMMU, it's simply 1:1 mapping.
> > 
> > With a multi-pSMMU and a single vSMMU, the single vSMMU will see
> > one guest-level MMIO region backed by multiple physical pages.
> > Since we are talking about MMIO, technically it cannot select the
> > corresponding MMIO page to the device, not to mention we don't
> > really want VMM to involve, i.e. no VM exist, when using VCMDQ.
> 
> can a vSMMU report to support multiple CMDQ's then there are
> several MMIO regions each mapped to a different backend VCMDQ?

This is something I want to support in the API, regardless vCMDQ uses
it or not..

> but I guess even if it's supported there is still a problem describing
> the association between assigned devices and the CMDQ's of the
> single vIOMMU instance. 

CMDQ should be linked to the VIOMMU instance only and not per-device,
I think that is a very important property of the system.

This means if there are multiple pSMMU instances then we need a
matching set of vSMMU instances so that the devices are grouped on the
proper vSMMU instance so they are compatible with the vCMDQ.

> I'm curious to learn the real reason of that design. Is it because you
> want to do certain load-balance between viommu's or due to other
> reasons in the kernel smmuv3 driver which e.g. cannot support a
> viommu spanning multiple pSMMU?

Yeah, there is no concept of support for a SMMUv3 instance where it's
command Q's can only work on a subset of devices.

My expectation was that VIOMMU would be 1:1 with physical iommu
instances, I think AMD needs this too??

Jason
