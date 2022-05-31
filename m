Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69F7C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 14:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C9524023D;
	Tue, 31 May 2022 14:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AIN51yVBUZLf; Tue, 31 May 2022 14:13:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2358840CD6;
	Tue, 31 May 2022 14:13:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6ACBC0032;
	Tue, 31 May 2022 14:13:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C290C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 167A340D35
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sYxctlPaT5m2 for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 14:13:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACF2F40D80
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkAmeSU5OF+pEqB8WGlMsVQZsyqXoVE+qj/y4D6mbk6TZJ7aMCpVuUfTnen7s0ql5OoUsEj9NdFw9LkGaF8UsbUHGoaSD8EDS1aGh4SOucXHkKM2oglSSVeFOGrWd1Igyk0xYktGF1lGz6gGKUr42/rOG9L3KfYU2udPGAeJ+Ax/R/aPJV87imHS7Jnz/UUBsFlp7w2q6ypuVAYOR8Ln9Ioymkj7VM67psSztF4EDovMr/BxDp18EwdLbS+ZCScYo9aYXGekPXBpvYqcHkgpp1RVQQGM8EYDafH0r2i3hEfuGU21/UaQFeODDZ5aTNK12GPi7jemWQzXsBs8w418og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UdeJmXnA3FXG3IEPh6NXbBExI5L/iKER5GEgwrELZo=;
 b=J4Ma9qJ6LIPdHh68bXemwL9bRRSVTu8o1BBgKzG8s17ytoGdK/2I44h7GFWbhdoSt1lpB4NCzAGuYnl+G4DKfvrFswETQ1CB69tTYpE3hmpb0/Sx2qPYu10bPuzERhAOVCH/H5XeD66sHVZ6YLFKczwAnKNkygB0wpRFr8o9jMYPIk3IeTo0ky3jxGr32UM6JkMHyeiG+SitEgGWwEzv8v7BcNASWWKk9AY8tRqtcJW8sdXo0SVir6cN92+Ee2EkVyJAEa0/GW8vmtR6DMv00A9X5Zhu6FXUYmS3sjCZ6g5PU5kJ8gim50VjanOSbG9vYhvJSwPwI4Ejk3sxh8eqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UdeJmXnA3FXG3IEPh6NXbBExI5L/iKER5GEgwrELZo=;
 b=T3ArA7yA+SQcKom7Wp81y4UsL3NMMg8jPJPlDCa6VAZkKifYOBQxIftx6K0nRFeJeYceyA0BjHoRdZS4EQKLw/jnPbaSgwwyz05hW+sV+XBNRlZNTCpmBo+cYImdlkzvGV+fXBpfBxAdRYHFGosAdsXV0oyKrMR72NbWmjyHQ0g=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BL1PR21MB3352.namprd21.prod.outlook.com (2603:10b6:208:39c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.1; Tue, 31 May
 2022 14:13:04 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.003; Tue, 31 May 2022
 14:13:04 +0000
To: "hch@lst.de" <hch@lst.de>
Subject: RE: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Thread-Topic: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Thread-Index: AQHYXiPNuhMxYMMi+USnjQGOHaoDOK0hMpCAgBN0YmCABBmDgIAAcxoQ
Date: Tue, 31 May 2022 14:13:04 +0000
Message-ID: <PH0PR21MB3025F4478CB44FECE731C767D7DC9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220502125436.23607-1-ltykernel@gmail.com>
 <20220502125436.23607-2-ltykernel@gmail.com> <YoH+mbxQAp/2XGyG@infradead.org>
 <PH0PR21MB30258D2B3B727A9BCEE039FCD7DD9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220531071639.GA23482@lst.de>
In-Reply-To: <20220531071639.GA23482@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=129c7584-f6a0-4c6f-857c-71af1370e5e1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-31T14:08:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ef1ae49-4c55-42c4-1b35-08da430fad9d
x-ms-traffictypediagnostic: BL1PR21MB3352:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BL1PR21MB335292A8A15B4D93610D8CA1D7DC9@BL1PR21MB3352.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bx1P+BQeWYb1AEI3eyV1hZGOPIQtIUP2aSE97gIrNuMF2NlYrqNLMEtiq3AfkxaPGqpOK3AbvXarBEWVCMIgN2GkkWOQudLozHNj1vqxTWqXMkrnqKtNyI73U8jk+m9H+gHvbNdj7FmmtH89dKh/PMX2sT5MRT8fd8EHEPkmj7sT3USy99eYulOBSXhdMDamzkygJGkhT2eHTvBpCeA5GP+dLJGMLjTGqbNnDAsFoMv920Yod00YICvzphnByo2aaBtCyiqId39Ii+frimu6YrlVNwXVDzSA2cMx4E5b+eWiqAT5AOfrn4zVXMYrMlo0FAR3OEXMRHZrvSF322OtN6wO13cmsutldaNlFkUu5ElyDq+gJJlczzsScC99WRpIs7iG+cKr4Yz961lc2f6OLs0e8K9cOg6oPlBTlhXUfj7H0uVU8P98yaPpMk+JGseW21bdmxcKwubGehb1eRlDm7+mmPNRqaXap7anO5Cf2FZSUCA5zrZeFbgZNYXX6+1lV184OMba8dTYv5kQQExkqxv0BuHKP+tRKlJR5LpdXsKZu6b+Bj7UzaSTguACw14C/HvV2OKtSOhWGAn2rd8iwXyGjO8MuWCljajwDMXiaaHu59/UMbiESXDXjKAOZ8Evsa0tc0BomtvbqkM9VSKKTxHnifqTuZOk6XRFHJQeHcBaaA0MoyM73LW+2CXdcvaxwrD3VjnVUEUfEBeKa9YaKUunGIl7yqGe6puwq/zZ8aBcWW9XaqjQmOhEfPTJPXYDfNny+IRl6KmikzPRNFaO9aujN5Vg53xOiFLsShaVpevbSWkxyPBUdsxrQxIM2rMuClBCSBGp7kqMTSjlWpaURw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB3025.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(71200400001)(82960400001)(82950400001)(66556008)(186003)(6916009)(66946007)(66476007)(66446008)(64756008)(8676002)(4326008)(316002)(2906002)(122000001)(86362001)(966005)(8990500004)(9686003)(26005)(8936002)(52536014)(5660300002)(76116006)(10290500003)(54906003)(38070700005)(55016003)(6506007)(33656002)(38100700002)(7696005)(7416002)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WjSJ7HucqpTw1Z0V0usroPhHhcwa/eEiQoS4ZOeyQhk9Aq7Eke/nAmdA3utn?=
 =?us-ascii?Q?uuojHaxb7QjRpr2SHhtqo/WEKLmpmb4PqKzhgIf19T62HXSU1mVC9NO9TosD?=
 =?us-ascii?Q?u0YAcx6UjBcU0ae8MXkowzKapMZt8PBXGryNS/nS/NCRm/3G0WwXQpbzlheX?=
 =?us-ascii?Q?xlTM7NRO5GS01cA8UYxx0LaJWODAx4Lcua6Yl3QOF6rQ323tjM7/uqjFRmfC?=
 =?us-ascii?Q?DZcBlWcQgY6TFGQwHQXuAq3f+AimUvHSUS6pve5ljLwGBjWUpNj2O+cbWGW3?=
 =?us-ascii?Q?DuBCrDFa2LmpuzE+FP7/3r/pE/Ate4FCaRY2bE3qBfcz1K0lcTe5cnsXtw88?=
 =?us-ascii?Q?ArCK6sbvu2Yz+5ZwLd0e5p0Y6XHhPxfnz2xtsT82u0U5yho/7M9OWutL5QS7?=
 =?us-ascii?Q?Tz/5gqI3IxaM9iRUozTdE0K4Utbemhq/D5eEBIz0GXDSVV7InSE3GP8G5PQz?=
 =?us-ascii?Q?retVhqOO0pUHHWMPF7EWBW+ZB/W0jk+90z+XZT9FlORIxF+9SfGiH78bJ/Cy?=
 =?us-ascii?Q?vz/HnpkKol3k3ry6yt++kvHbSa/L2LNmBXRUAhKk506lqTn4h+9MybUWuXT+?=
 =?us-ascii?Q?ZD4rXVMiQfv2DLMhWC9TRo0pq8su0LVQrdzttVedkTEYXxwH5VyCr3tjw6ny?=
 =?us-ascii?Q?zm9v/LQz6VPRLHcF57IekfZJEE5kqAcllSyxT6ObWOYkX2QhVwut8bP5Oh29?=
 =?us-ascii?Q?7YvO43ezGF1VmNGDOHTJG6wCbFNUNm9sjD2Kyf57Iyh8nlpnlk2QOSzBMmPA?=
 =?us-ascii?Q?5cwc9JesHARKgl0smSYDMGkgmvsuBZqu4r7A4PZioBh5oHdDFZDsUt8S1gru?=
 =?us-ascii?Q?mgIzfGrohP7YVRwxZ+us8dP+Fb6PfG69vG36kGGdW4EcqNL/CgjXd9zEZL4n?=
 =?us-ascii?Q?s37bIx2G5I2VB8dHVb4Qb4KTWmMCO5Let53qWkMiQ0ptlCubk4CBWS9tccVc?=
 =?us-ascii?Q?GeC3iDX0Fm49TzZfFCQ+aERUpy+nOYoeRisXTL6coCFVJCsvXbsap/YxAmmy?=
 =?us-ascii?Q?5SIl3R4XzOvBd2S2H67y6WVdKRVH6jpIJLobO9aQQ+J+XF0ikfMO9z9HOn4O?=
 =?us-ascii?Q?sHOizy9VnLNJPtpKlPfUed++mRLjMaEYEt5N91VEjevgUG8Jtt8KlybCLQzH?=
 =?us-ascii?Q?rYanxC9zjk09t9p//1Bt5UMKHpGNSdXcU+KT1c1Mq69YNl2NDwZ2nwFkIjYL?=
 =?us-ascii?Q?s2O685UGaH3UoqP1ciU4ilGt1Ly4IYEMp/b6AUmmhNg0GheAKGB5wqShhP3R?=
 =?us-ascii?Q?2+M8wNMyZAq6Nl+AWFFefgHxVVn2bDu6Vj0/3ulTAqvB9vsMy/RggQUE217H?=
 =?us-ascii?Q?I7Nh+jmc0OBXnqFYme0P4O802m0Jlru13LlDSo4pzOUBDJugu2LkEBhTu9lV?=
 =?us-ascii?Q?NBcvG9NJRsnTkIZI3YjJ1xJyK070CKHne0l8Oqd80uHMgOn7NGUs+Pb9gSAW?=
 =?us-ascii?Q?vVKXLaR0cpJqxgcoAu5vovga/kmSUeJhNxspgEdFoNih8+yMiTAUtwDEm749?=
 =?us-ascii?Q?WkbIsymscr5cpb79mSfh1/k0U3yK8O/UClXhsfdNF3Y9BDu4zAKn18v1uukt?=
 =?us-ascii?Q?U+gVF8PzYIPbN9Ke06MZvut4YxULz88Ol22OOVQeQ/iRFxwQRKhS2HHQ/7bc?=
 =?us-ascii?Q?UQBfy0EFpZ4Y2h75k/rEAidc/p5FRAai0CwjLZSQ9kuDRkLCNvei74aliGKC?=
 =?us-ascii?Q?o26VYCSP9YKMsmuxKChg5txoF+DZw6AOMm5H0w6csWwz+xIj6r5JAy6F12qT?=
 =?us-ascii?Q?vztdrOvPD4rxM18Pw5HP6TQazFLWaNE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef1ae49-4c55-42c4-1b35-08da430fad9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 14:13:04.1890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smBPVMHSJUsnfCGerNW9kNHBeUHNTEWm8ESDXQvie9tSZ1Y8MFN+ElbhMDqzzcJP6X3ik7YmbW/IT7nSCF3oJoPcfr2KnfPAAVLGreQLPxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3352
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tianyu Lan <ltykernel@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kirill.shutemov" <kirill.shutemov@intel.com>,
 "andi.kleen@intel.com" <andi.kleen@intel.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 vkuznets <vkuznets@redhat.com>, KY Srinivasan <kys@microsoft.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
From: "Michael Kelley \(LINUX\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: hch@lst.de <hch@lst.de> Sent: Tuesday, May 31, 2022 12:17 AM
> 
> On Mon, May 30, 2022 at 01:52:37AM +0000, Michael Kelley (LINUX) wrote:
> > B) The contents of the memory buffer must transition between
> > encrypted and not encrypted.  The hardware doesn't provide
> > any mechanism to do such a transition "in place".  The only
> > way to transition is for the CPU to copy the contents between
> > an encrypted area and an unencrypted area of memory.
> >
> > Because of (B), we're stuck needing bounce buffers.  There's no
> > way to avoid them with the current hardware.  Tianyu also pointed
> > out not wanting to expose uninitialized guest memory to the host,
> > so, for example, sharing a read buffer with the host requires that
> > it first be initialized to zero.
> 
> Ok, B is a deal breaker.  I just brought this in because I've received
> review comments that state bouncing is just the easiest option for
> now and we could map it into the hypervisor in the future.  But at
> least for SEV that does not seem like an option without hardware
> changes.
> 
> > We should reset and make sure we agree on the top-level approach.
> > 1) We want general scalability improvements to swiotlb.  These
> >     improvements should scale to high CPUs counts (> 100) and for
> >     multiple NUMA nodes.
> > 2) Drivers should not require any special knowledge of swiotlb to
> >     benefit from the improvements.  No new swiotlb APIs should be
> >     need to be used by drivers -- the swiotlb scalability improvements
> >     should be transparent.
> > 3) The scalability improvements should not be based on device
> >     boundaries since a single device may have multiple channels
> >     doing bounce buffering on multiple CPUs in parallel.
> 
> Agreed to all counts.
> 
> > The patch from Andi Kleen [3] (not submitted upstream, but referenced
> > by Tianyu as the basis for his patches) seems like a good starting point
> > for meeting the top-level approach.
> 
> Yes, I think doing per-cpu and/or per-node scaling sounds like the
> right general approach. Why was this never sent out?

I'll defer to Andi on what his thinking/plan is for this patch.

> 
> > Andi and Robin had some
> > back-and-forth about Andi's patch that I haven't delved into yet, but
> > getting that worked out seems like a better overall approach.  I had
> > an offline chat with Tianyu, and he would agree as well.
> 
> Where was this discussion?

I was just referring to this thread that you are already on:
https://lore.kernel.org/lkml/e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com/

Michael

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
