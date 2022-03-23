Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A75C433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 20:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CCEC84847;
	Wed, 23 Mar 2022 20:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wncETQsXClev; Wed, 23 Mar 2022 20:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD0B084835;
	Wed, 23 Mar 2022 20:34:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 829FBC0012;
	Wed, 23 Mar 2022 20:34:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50806C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 20:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B1EC41B74
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 20:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QFKd20nAC4j1 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 20:34:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44E9841B73
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 20:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2yiN9DlwLdpYagUB5Lc5uq+nEkA4CtIQ7ao7iuxMnhjpp5yEzUzZMnzK5K5F6sgnKK/R+/QRheMwVteCOpftoCl8I7hO9OH8R1vB/irELcOBziil5MWbxZ2nYId/Hb4s5MlKkhcYntne3PJyXjQfhKNVLMAGC69W4k5MqjC8mbq0PsYexANN9pxiJ1lNTCcqbBgydQ8yR3q2HH53+TyXYPfxR4tHnRE6Ni5ssh6EUUTjNqnUjVq/Xn/yIckV0tpugtRRynTjN8C3F4nC6AQKN8UQB4hunCHgP6/YFvAXqgdEY426+/rutPWpIQ285VdVRAllKYoATHPMAiqSoc62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD7QMyLTKkp3lZLmc2lCgw5TiOUrvrcjww70B30+IgM=;
 b=h+MLVje9Dv2Aw7VCtqxWsrhpWUUZULBUE7WxZnZHEmleXMlyO4Gi1z5lY+WnqPOcmB+hUtAK+oHObkGKWcTKZSguqS8kukF7QSJkMg+5nUQEShLcn8FzwbW4zNEj4wMCTMMCx2ksW0aiMnrB7leoupAvcnz0UVthsu3W/9bnkV9/+CZcqVdpl9cTf1x48N+5uYaER4kWarrO2a+tbsvRojMBthCENCEc+nOVb0HEIvvZKK5+yPzo6EuIL5wkUe3K4f9DqbaaOQeECm3tmxzxIzX2CKqA/ZIsVQ3MOzHUOiPuxg4/oYUTApG2fzjjmIsbVOhFkfP2/zJ/q8Iet81mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD7QMyLTKkp3lZLmc2lCgw5TiOUrvrcjww70B30+IgM=;
 b=mpl8Kpu+Z0yCM+HY5PZWnlnqd09Uakg8U7BkolqTnoIrf+NJTmd3w/SpxksitXviG9hD05Gc31cA5Am+TU1QTCGAUvxJgim9Vm12Z2tejMKmg+5P6VZKiiUuMStOnq/Ft7n+y7Y2FlOMrLmMfcqV6i/gFroJb2MrhrZHFC8n06DXWhZKNljP2H3nnapCqxvxshiQviF6TbTdfTdyxDbnzblMUKDzYEL6sQ4B0ctJT+o51E8pclat7l1xmjgRILjx2Y+lckpP95vFjBPUlQ7nivUdJdcf3YHJRoPO6c4kxItTfeZ3H3etgmrpK1T6OnWWZpnxCC7MxlZHlyGU9LKUZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 20:34:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 20:34:19 +0000
Date: Wed, 23 Mar 2022 17:34:18 -0300
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <20220323203418.GT11336@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323131038.3b5cb95b.alex.williamson@redhat.com>
 <20220323193439.GS11336@nvidia.com>
 <20220323140446.097fd8cc.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20220323140446.097fd8cc.alex.williamson@redhat.com>
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64232cd5-abfe-40b0-6b8d-08da0d0c81d2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4849:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4849029DF0EBB1042F5909EFC2189@BL0PR12MB4849.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdiIwP8XszEcjA5W/ACD1FtXc6ImqK6dnTxP5cdOb0fzwMUayfDlNcWiwrexDw1x/C/pgjcHhwke1ikfOUVFjHQ56fA6ut/mGRCsqIPR+Fu1brU6HN1NlQ2hycsEJxNvCkbFo0Z6PuYUYpZm5rwq6yGg29RIcrC3P4gWQ4jjDaFWiwbf8yWsftkws0/1BE684dHBmnFV/EpWnSKV4sl95VoWJ6t/IGEhRcCVwIOcoGbvqUHV/3KKb4hWkuwe6nuiGviSsBSme3TR01Z/joJhr2Rs6CXQIIGEZxw89gF5QhjIGnLwIvbZG+oEYLWB1aIh7Dq2bmu38MhWfh42k6J9y8Iub8u/VXlyzTeKbT/z1a06oneIzIVnyAxwh9uxPH7wqIlAhRsiDLqXQqnfIpx9UbcwPTd1xzUf4uUjZkGmplM5GQdo3BFiKwutesiSqs4cy5V5/vSsMCfyWi/U6PlQuQAwvDGSxAgh6PFSZIUf4GajmT29QTQaZSLetUcHYNTghpFPecRzLdqTjcvWiFtqL1ESzdbszDY/cizrGjMZR1F7MS7uppdJ1OcdBuOuLfXCYYTAy8Im6D+M4LDfCeHzhlsjWcJP6IOfsnbt/w3i2WoJsqc7szLD+rz0O+9xpl5NC5ZVY+F4969DhUizUCzeYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(83380400001)(7416002)(6506007)(26005)(66556008)(54906003)(6916009)(2906002)(316002)(6486002)(508600001)(186003)(6512007)(1076003)(4326008)(8676002)(66476007)(38100700002)(2616005)(66946007)(36756003)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hB9kJFJB8qPT63GuCvTnNTNXrgTioclItwvWTUyBRsEX3lPZwlXOz9xlnIGp?=
 =?us-ascii?Q?lzqJSoUBFEK26GlQ6y9M91MnqTvjK00skCpsgt1Ezvtfd9eNPVRWlpRx33ZH?=
 =?us-ascii?Q?yOMiDlwtmIs5ET7Mw+mhU0wvI9M65Aggog0K26ZCZdXOQ6yF20FVWBXbAmyY?=
 =?us-ascii?Q?ZC5In4AZVTwFnxJchq5fBEUPANaBTK79gzt5Yhoxt/AygnV8alZVSKMjREPQ?=
 =?us-ascii?Q?1XXs+lMZldLsl8HbAMSGZZa9GYr/P0/fJGJHa+r02TlPt572r6L/ZeYdec+H?=
 =?us-ascii?Q?hUDsPj88Nal+adsXeRHKbDrkU2ZfERLQ/nO2nn8Egolhi3swGThZiIPS9Vvd?=
 =?us-ascii?Q?+P/UPnTETUYNgVMDAC9uAqo3umEM+kmQAnJye0AYCuUbyB1048LOouaegZO9?=
 =?us-ascii?Q?G8X4q1LH1TvVGP5ZKPKFS8l5eVLQ/D3gAUu0ExaaJAIDhA9Wr+1V/BGL3Vgf?=
 =?us-ascii?Q?GTWtq/i/toCD2UgRBd57CXRutoICoYE1iKf3Cx8DpjSn2DpLRSFFh/heac38?=
 =?us-ascii?Q?ZvGUaIU5vp22BWnroW0zPouurcxwKQn7r+10keKuaBuy1TfVxlLGYFEcPn2a?=
 =?us-ascii?Q?XnXXBZ24xKnnDwPXhhWNykSJcc69l7KFvCUIqhJ53EilZFoJCIU47TFGfEeJ?=
 =?us-ascii?Q?j36600cE/MxeKWK0VHFU7LSJ1PAF7eNHVJYMmU57BOXkRCYOZ1SFZY/I3CyN?=
 =?us-ascii?Q?54qbdF5VM+fYUNoNEmXKeSP6+/WUPYvFh1wtesSYVrsJLsv2e1uIGattOwVI?=
 =?us-ascii?Q?9KVRLYJ4n0bLpLD7yQMmV1oqLB6EbXhKhB6Uo8Kyk4QiYG9Fu2GJOHUsGZXw?=
 =?us-ascii?Q?u5ENT4BwqRkcmiArVSHxPoJfggx9nyFVoKjVKASKevXkL3/RSruS8FA9z6Ba?=
 =?us-ascii?Q?wxWuzXNhYIfzZyrvTLrygG737DOT63uhLaFjdq2dA1sDIJD1FrXpX/0uGP+G?=
 =?us-ascii?Q?3afPWcjDTpfJ+w56gO3z027NL7xAa3rX6K8gyLzh+z7QJBcAoMbuJoLHl0zo?=
 =?us-ascii?Q?qQcsvp1cWwTANn0ZT4UyNJmqSQ5dbAlMBzEOOfrP0z2m4i11o5GGtGP+2Hl3?=
 =?us-ascii?Q?kEKvXmOp+K09BaO/RmoZBADWiZq+Bf5iQamCy3NDd1XOwSAmmgpM3emRKiIt?=
 =?us-ascii?Q?ENyKAn+j6QJ3AXGqXyEKx/4KyIQ/yNIgf9J0Iodu5u4oZ17OJ86+wKTDtbXB?=
 =?us-ascii?Q?riPe6q3I589IFClwtbRxgT2z3HnrPHMkcNJQ8N3T2JVsO/k8N1iR7D/Z5/zN?=
 =?us-ascii?Q?9NGRK0RApeCO1BELhj+IOsKR1Vfx6JWyNfHyvOTLV2j5HQ2GfQg1xXjcphKw?=
 =?us-ascii?Q?YKSangXMSN0WaULwaqjD7lo0Dm6Y5kOFuBFsQNEM9gl8d+tyebf3tS7DEW4N?=
 =?us-ascii?Q?EAfFwWuawC7tsFDcmMIwgCCrAeUknlisVY+ASWiCbLij5vPK86WT+VpkvqAO?=
 =?us-ascii?Q?PPE8ItxJ0Z8BYcosnrDa75eJioflUlm6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64232cd5-abfe-40b0-6b8d-08da0d0c81d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 20:34:19.7185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixA3Q73jNtc9dFD6K8j23tEHWDhmH0QV3sHPDY7Q83xOPj38r4x2Joy9HZNJnGUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 iommu@lists.linux-foundation.org, Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Mar 23, 2022 at 02:04:46PM -0600, Alex Williamson wrote:
> On Wed, 23 Mar 2022 16:34:39 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Mar 23, 2022 at 01:10:38PM -0600, Alex Williamson wrote:
> > > On Fri, 18 Mar 2022 14:27:33 -0300
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >   
> > > > +static int conv_iommu_prot(u32 map_flags)
> > > > +{
> > > > +	int iommu_prot;
> > > > +
> > > > +	/*
> > > > +	 * We provide no manual cache coherency ioctls to userspace and most
> > > > +	 * architectures make the CPU ops for cache flushing privileged.
> > > > +	 * Therefore we require the underlying IOMMU to support CPU coherent
> > > > +	 * operation.
> > > > +	 */
> > > > +	iommu_prot = IOMMU_CACHE;  
> > > 
> > > Where is this requirement enforced?  AIUI we'd need to test
> > > IOMMU_CAP_CACHE_COHERENCY somewhere since functions like
> > > intel_iommu_map() simply drop the flag when not supported by HW.  
> > 
> > You are right, the correct thing to do is to fail device
> > binding/attach entirely if IOMMU_CAP_CACHE_COHERENCY is not there,
> > however we can't do that because Intel abuses the meaning of
> > IOMMU_CAP_CACHE_COHERENCY to mean their special no-snoop behavior is
> > supported.
> > 
> > I want Intel to split out their special no-snoop from IOMMU_CACHE and
> > IOMMU_CAP_CACHE_COHERENCY so these things have a consisent meaning in
> > all iommu drivers. Once this is done vfio and iommufd should both
> > always set IOMMU_CACHE and refuse to work without
> > IOMMU_CAP_CACHE_COHERENCY. (unless someone knows of an !IOMMU_CACHE
> > arch that does in fact work today with vfio, somehow, but I don't..)
> 
> IIRC, the DMAR on Intel CPUs dedicated to IGD was where we'd often see
> lack of snoop-control support, causing us to have mixed coherent and
> non-coherent domains.  I don't recall if you go back far enough in VT-d
> history if the primary IOMMU might have lacked this support.  So I
> think there are systems we care about with IOMMUs that can't enforce
> DMA coherency.
> 
> As it is today, if the IOMMU reports IOMMU_CAP_CACHE_COHERENCY and all
> mappings make use of IOMMU_CACHE, then all DMA is coherent.  Are you
> suggesting IOMMU_CAP_CACHE_COHERENCY should indicate that all mappings
> are coherent regardless of mapping protection flags?  What's the point
> of IOMMU_CACHE at that point?

IOMMU_CAP_CACHE_COHERENCY should return to what it was before Intel's
change.

It only means normal DMAs issued in a normal way are coherent with the
CPU and do not require special cache flushing instructions. ie DMA
issued by a kernel driver using the DMA API.

It does not mean that non-coherence DMA does not exist, or that
platform or device specific ways to trigger non-coherence are blocked.

Stated another way, any platform that wires dev_is_dma_coherent() to
true, like all x86 does, must support IOMMU_CACHE and report
IOMMU_CAP_CACHE_COHERENCY for every iommu_domain the platform
supports. The platform obviously declares it support this in order to
support the in-kernel DMA API.

Thus, a new cap indicating that 'all dma is coherent' or 'no-snoop
blocking' should be created to cover Intel's special need. From what I
know it is only implemented in the Intel driver and apparently only
for some IOMMUs connected to IGD.

> > Yes, it was missed in the notes for vfio compat that Intel no-snoop is
> > not working currently, I fixed it.
> 
> Right, I see it in the comments relative to extensions, but missed in
> the commit log.  Thanks,

Oh good, I remembered it was someplace..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
