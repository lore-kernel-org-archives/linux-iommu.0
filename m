Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF27AC433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 16:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FC7F81076;
	Fri, 29 Apr 2022 16:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jI_gRIzl4AOD; Fri, 29 Apr 2022 16:46:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F55C812CB;
	Fri, 29 Apr 2022 16:46:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECBE0C0039;
	Fri, 29 Apr 2022 16:46:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3D59C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 16:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA50841CDC
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 16:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H_cLwbzXNckX for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 16:46:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1B8541CDA
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 16:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKylxmJIrX1lOHGWE43g/DPMuV2wSmCRJmQfFOSpZ8Uq0PkYfo6jDOIbj9dUgeJJodTVOW8wrJtDR8BDkYwXJhbXcNmiAS/3pBKpV7n/5MccRJ675FxjS1Gq4Y+QXlwJbzKao9m8ZSW8eQtZrNStJqq6yb4wBWa02L4XpGpVsvHdVnR+4fv1c9nUapsW8fUoVCEYESeWW5t/TU0ob2kMQ+WKXJD1SSpgKgLDSFSLegeKy/UslXrPHhrgijdJCwL1qnKY54b7duq6Bkxxrrq4ZR8kW12mEOWIKw84HJrYLdPB6CS1Zap5byFbrEVu8QVyT6NMRufazifEYKou3y8JBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IBmFCKG5FL8ueSeQsK4AdQ3tdblgCITDq4p5G43juk=;
 b=a2IyNGL7SZrwYsRitiprZf/DTi8+PcoO6oGfIz7zeLh+Y/W6kMF46wM02n1loc351N/EL2VWKU/qftJ+nZ/1TNFiFZ9NjWzjEUKDF7yGT+xVx7Sd95vCdjEIlyDC4gANGWWtbcPBtgk3X3EWSnpHiTHbLNXrVIYk6b29am/2rc31sFbMFAP92qvzroGP5dOMHghDnez4cfXGeUqivW7YwB6V1wN4qQ8ucmupf+g/qTqNtBjjAwkVn0DikQFTmjcG9us7pFPl1ofcIL8/gK2aRTyKwK5OZix8saleCDQOME9KWHqc+mMcrTz+PIqCpmaFQxqUZk+Rz9K5Z/GsSemQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IBmFCKG5FL8ueSeQsK4AdQ3tdblgCITDq4p5G43juk=;
 b=fB8zDXRLTqSx+dxpqPNFok56bZL3gUo9O9b1P72kqpUMBUn1Fa8N1L25PE6fILk2gaBncvTrafgqsRL/jNwzpgeaBMS14ZlnVU5NUM8WS/t6h2qgFoe1HgsUjXmmwJuvoGO9JhsW/rvBevfVkYVFDcerrC1KNMIsY9Zm9nNE4D3eyVETCkPZOF4yHzhKgkQ6XZtkEMZVZ3yS4NM8rzQW9jQtRZ8BPhX6QLVGqKYcBh2qhP9Z8U1xWqIasv9j7qCjbHrbtCBsB2SGgrEzLeoCVPIb8/q1ywUmIajWXfkzeB5QR1td5hmO5WY9R0sGeBIWPtpCvlVbqCBKytvDuJ6Z8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 16:46:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 16:46:18 +0000
Date: Fri, 29 Apr 2022 13:46:17 -0300
To: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
 set_dirty_tracking_range() support
Message-ID: <20220429164617.GC8364@nvidia.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-16-joao.m.martins@oracle.com>
 <BN9PR11MB5276AEDA199F2BC7F13035B98CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f37924f3-ee44-4579-e4e2-251bb0557bfc@oracle.com>
 <a0331f20-9cf4-708e-a30d-6198dadd1b23@arm.com>
 <e1c92dad-c672-51c6-5acc-1a50218347ff@oracle.com>
 <20220429122352.GU8364@nvidia.com>
 <bed35e91-3b47-f312-4555-428bb8a7bd89@oracle.com>
 <20220429161134.GB8364@nvidia.com>
 <e238dd28-2449-ec1e-ee32-08446c4383a9@oracle.com>
Content-Disposition: inline
In-Reply-To: <e238dd28-2449-ec1e-ee32-08446c4383a9@oracle.com>
X-ClientProxiedBy: MN2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:208:fc::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09bbcd6f-9fc9-400f-b920-08da29ffc849
X-MS-TrafficTypeDiagnostic: DM4PR12MB5865:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5865F4FE32D3D1A0486B51F5C2FC9@DM4PR12MB5865.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRyRdIBKG61tpcxPAtkESm7xBBTlyq1F/ezu8NzJ/GwqmZ+O9d/aaiREKAuafyH5+nVmfhkC01VWFyGHJmMnTk4OuG5+jEWqbZzH8KkMzXAuByTfSns3j9I2F/D9BvCFnhSDfjvYUndHF31+e92UnqaM1xSEimVdhb1PEoA+ogcQZP77PxtTZ5e5kW6P/msuK8B+PqL/HMD9nANZAiHhP9hBJeZo7yQ4kYpBgjda667vKI7qcLPO+QOaXfXy+woMnQRQjWdSorRHUI9UHLLBIwfBbxt1Qq7iIBOstnSdU0qHUZvZI8bNViRZSBislt8pJuJycFyzJHqTBzowfObTbRMu0QkNrXDtUMHN6SVL+JT999ERzJo/u/80HCbJcZ/YfB0ANM3HlxN22i326s4gNh+E1knSuSXVZ7HaaFRsTaWZ52YqMT7gd4f8TnXJeWkDkihij29/yb+Hh3Zk//C1Q1xkBiRq3phYD7pcKndVteRkKfzuLVzuEekw6B59jybvUqNhyUUAMnp2IW9u8ykvyCNv2j9l218NtYWVDZsAKUO5sDNLamlHTpIo//ndCPIqXxhCj1Yqjc3x91/EW50GMJPC/I3TnmrJbx4lvFx9sgTnr2qTaDcsZRqJGqXSgYwPzDtO6Xk5lZCr+vz/a+8EjimWlcoB8V3oIv9LuyUT2HAP4NMt7eUCLgokonefLCOTq7ITbZWkqLrVrqfAKjoCBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(6506007)(5660300002)(186003)(8936002)(1076003)(2616005)(4744005)(36756003)(7416002)(6512007)(26005)(4326008)(6486002)(508600001)(33656002)(316002)(8676002)(54906003)(6916009)(66946007)(38100700002)(66556008)(66476007)(86362001)(14143004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36a4jdB/tSw4SzLqkPKMolfmYtJRbMsRVRRFFC2wpMWeVWdZR160D1SxS5n/?=
 =?us-ascii?Q?Q13nSCA0kcGaE9NWR/F7RQrr94AP6fLenbXujyf1+/1/SLlhmwpx86lypoqW?=
 =?us-ascii?Q?a1N0DnWfykKkrg34vFvOXnUlRBTM3F8xHeH3kKumxZSbGJmKIA6LFwZNjOtX?=
 =?us-ascii?Q?hdHcMREzYMd5NO3pvZ9ai5Pm8RXlgj0gsptKkhQ97y+eFUf3/5477zyGBsX+?=
 =?us-ascii?Q?4ewnrU1kPc/j86kwhaTqvWnjZ+usMyngj1JzUcBxbmHZ3eN/pW4XsfVduIq+?=
 =?us-ascii?Q?17FDDUuJoC/RcRHHebpfHLzmkpcCAvbZioQijna9g0t34n4z/zapcMRz/eJY?=
 =?us-ascii?Q?HZaVu4P7AupVTXopzh8AE/0qNSShrfAjJyqPlgGlZwlqScKYJLY7M3AeBGFt?=
 =?us-ascii?Q?Tc+XLHWyOFYe70lOklbAD1ZFpt5oMYcC0TqZkS6zEoCRAMJ5vAB/MtsP0IrJ?=
 =?us-ascii?Q?CJ9uKTBZKNk9RSGIQwZIoi5R7QkMuSTjaVItnjA0JHEpSdHqm9j8P9wtLqHh?=
 =?us-ascii?Q?is74/WNRgN1837bwiDQw3m4SR/0UdlZBMEfhBC8URTgti8z5F4J4ZDBzlXqM?=
 =?us-ascii?Q?rvx74bwq6qmW8+tXUSKGgaWVK6OK4TRbvPesbqzejZ0+pRJO68p4NOmaSMAK?=
 =?us-ascii?Q?mqzYTBayWN8C8rXHvKV57JkUTNi2pBcTsAGIvg3oTYUI/VYELpzStoViBby3?=
 =?us-ascii?Q?LVdC3Yvc46L1XaT5NTGfBQB9+l1j1U3yMK+u1nM2rcnkraJyDzYwMC9+m+D+?=
 =?us-ascii?Q?naFVjtL92hnzvfeZIhHYwsRRo1dqYkLlWOPQBnAWWILiCLCi3CVZbUM9ZCMZ?=
 =?us-ascii?Q?BdVxkmeMZIUqi2abC96j6iMslUig82ZdYkmjlcaVZuA2pylM4Q5vPJ7ALIRl?=
 =?us-ascii?Q?VOeXw6/KtXjlmzQu6H+VlwldMWPu7dxHseXN04BaDiPh8rEWxxAYK0+X2NoZ?=
 =?us-ascii?Q?mtVFxJx/cA5cxLLKwy/+nhg9Y3j9W8UvrDyWNnGH5Wsrrw7qQ58aOiuZp4JA?=
 =?us-ascii?Q?FlF/Mzwb5mObK3F5RbxY/bJbSyQOC5hE4flKubnRECA3TMFrN+7ihc3fBi/u?=
 =?us-ascii?Q?B6L0q+WXtYHKlmWCKW4oHsygafhsE7fz/O4IEwHcZXGWjRz6gGRJDReqbE9G?=
 =?us-ascii?Q?0jII8WjxW1D0f+GCHvjeiavFbwtmOQeJUvIc+YWcisXhIOCY7L913Hlun9y5?=
 =?us-ascii?Q?XL+OEU/cdWJ6nsEOr85+54FEtHKe/0fWjD8hzfCOWIli8pZ+KcWv9J3/KQwl?=
 =?us-ascii?Q?ApSJDBRO8SpKyOzEEM2HXGpWvv8E/vd9HKbBQQlfwdemSDg2IoY1dXupFeHH?=
 =?us-ascii?Q?1BzQL+JsHYX91LPVheLHSBMjvPjmS1YdA1wQLXiiSvzmsAkatZQG0xqlTIa/?=
 =?us-ascii?Q?4Ud/oRVVADAsB35VuqZUCtUZRgk+oxLVDsIw3l31NjYPPvzDLPi/dNZk4JRK?=
 =?us-ascii?Q?hE9ktoogsOAWOzLiDcylMOfHI9CiEnvNByrR+UD5DwfKwToQMTwQV3yzW3jd?=
 =?us-ascii?Q?NFWfxx0d/5drWUWHu3dfEtXBANktsl+X3nR3xMhoRBQVw1+DasfAFduVdJ2G?=
 =?us-ascii?Q?CJ/ewvndZ87y/Ucr9rGd4NnD6OazX2XCHMpZagPrsOdmS9nh6enZHn/okLOK?=
 =?us-ascii?Q?+1Xs4s/wgNdPxq4VphUTAJUpwU2zULzhX7nMiiKqM8tH3kcmRfBwSnnhkiR0?=
 =?us-ascii?Q?M34qou/bMOLwFxTMyvCdsmLC++aH6yBSx8txCR0umG8WENI/ro97Cfihxs0S?=
 =?us-ascii?Q?wIn8UpxMmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bbcd6f-9fc9-400f-b920-08da29ffc849
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 16:46:18.1738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgYklb6UmhcKrzbFacQgoBtBIv55wt6DT+46KcKyuUdsLOz0HE2oSJ6JbrDpnpN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>
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

On Fri, Apr 29, 2022 at 05:40:56PM +0100, Joao Martins wrote:

> > A common use model might be to just destroy the iommu_domain without
> > doing stop so prefering the clearing io page table at stop might be a
> > better overall design.
> 
> If we want to ensure that the IOPTE dirty state is immutable before start
> and after stop maybe this behaviour could be a new flag in the set-dirty-tracking
> (or be implicit as you suggest).  but ... hmm, at the same time, I wonder if
> it's better to let userspace fetch the dirties that were there /right after stopping/
> (via GET_DIRTY_IOVA) rather than just discarding them implicitly at SET_DIRTY_TRACKING(0|1).

It is not immutable, it is just the idea that there are no left over
false-dirties after start returns.

Combined with the realization that in many cases we don't need to
stop, but will just destroy the whole iommu_domain

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
