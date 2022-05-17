Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9070C433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 11:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5522140522;
	Tue, 17 May 2022 11:13:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uNxRlc2yfBC0; Tue, 17 May 2022 11:13:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 276F8400B9;
	Tue, 17 May 2022 11:13:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0675DC0039;
	Tue, 17 May 2022 11:13:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D63EC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED3584190B
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:13:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wnSehMk7vNhQ for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 11:13:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4ED5418E1
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+yZZOOWMsVOVZAI/hC+ew5hjorC0h695bccYa4JTU61rjYiX5svyS66/ysh3ux0BKimR4cZdKPDbSKsSs0ccze9J1EajG9k8FItKAFGKqdaAKEwHw5LX37fJVuxg5PPKI61NokNcMowPadxtc2KpgGp65vsjnrRmkN3O0BMwc0pleQEyKoLpUPJjdtmP2kDDaYBG+WtU0FGJAKe5hggj9hSaVBCKDw6Nos12S0qTIJ6/Pj8JJ9ApYDYoDEkr52OwWenXywmQKxr2fCA4W+bsXgjWV8S2/8bw358cOMOzJZYyNyOhn8DwoyK6gAF8bVdrs8EzFG/cz7R7XMySzfXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExAogaj4lLheqNLIWfIeZ3BH/4RosNO6PAFKsIU5xkI=;
 b=OrScDsgtLa7meZRfQEbm7UhAJPdL+eoSwOUCUdjZv+IUXqc9njarObxZTlf3hIYYYro8ukzZq9KnDzbmZCEihD1BFpqh8WXSGioVQu2SbWMadBOUfk5utkaikX/pFGAjxWz+5opa7q8PNlZvl6ddIX9psRhtqEpSUyQ4CBakQX7/eUv4cHrZPI86S/3yrPrfWgZoRUywvao0bZZW8rqHMTzIDS/j4ASfpKfJiRjW6AxmycQ9BU5FbEnfv8L+RzghaIHAmNagAzNYq8Rg+a8qvoMAAvLF3pdOlWap6KsjUKCrq8h6sOutm3dxcCAUTCtxjS0HpT3tONZlJOZxWsXwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExAogaj4lLheqNLIWfIeZ3BH/4RosNO6PAFKsIU5xkI=;
 b=JLylg1I5KRvyRjN5DxwgWsu3tOQv2SGka9XOBYmTmkWSK7jUYh+DmEMdIH9xzSrbSIFXA9DTo9G4UPMm6bd/EHiTYM2S4a0zFv1/DxkyUYNbCXTudDcBkABp7cDqVPxsnRM1FQ0I6xfmIJeBb99gz0n6VScxB5TiXzPVv34Jg4x74KFk+pqReZ3orDuZ/EJMIylUsZh2b9qKQR7yfBIs8nfm8A26h41LtIg3q1xWQqyXjcf23LwY89yZQCW4FQqz/fBbqMFuNJnr48XU56U/RT/aSiyYp6c39hMPXvFQtTGJa3MGZU2e88bEpCIr4iTyym8HNLs3u5DZeMiBf4qWxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 11:13:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 11:13:51 +0000
Date: Tue, 17 May 2022 08:13:50 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel
 IOMMU
Message-ID: <20220517111350.GR1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-7-baolu.lu@linux.intel.com>
 <20220516180628.GL1343366@nvidia.com>
 <6cdc43a3-72ba-5360-0827-6915ef563d64@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <6cdc43a3-72ba-5360-0827-6915ef563d64@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:208:329::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6b5612-908e-4538-c12f-08da37f6526c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45751077CBF79BE938E34843C2CE9@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez1w98ONnj80PQIhfNw1uWXhlYD1w8kaQIUvxDgJKvIk3asGUxPW+oUR5LJZRf8CmWyVeBiHRG9uKrWBFlTH31aXbRxfeEvYQWynDJBtvm0f99fiiT6jGRYMSVoT81ysKiYmDQDdnuh5AS2g7nVmj6j+AzWkH+t6WxVH0675y7DWmFIxtvQdGrDcXpYDy6bSQlCRrtppWCMDCvpMKBw+xUqm8x30j3T/8hwG4SLjk3d27MROdgKkuSOoDW2cde/P2cCaR4d4ST5htVbVKrqoqwkx5qVLA9Kkc4TNDyJrWGnO1evuas+/CsvhyhepDeQGmcndHF73nC4EdMuIcdLeIqDTrXj5cQRIuZYzVxfnx8epjD1fE1eRj2j4Hs0vN4kJch2lhda0QQsO7QZdv4RKP+LIxhlPdIRUg0I2mnNsQxkPi0GCJJWXs6b9qM/3VNKJzc8AtWKASBfmwVlSt0mUaGucT5C4ZeG3TeBQV7y0s7xbPWca0iIt19SYgqHUF5zn3Sr6GTxiW3XPSaZnqBtpdtaNDdajO3GtCISeHefiMkNHxsRxRTqNKAh2DHFA0kw+EiJYnOR0vOeTwqWOLuNsZtMgUUTbW7dCrRyjvTiJiFfxoYF4i1Xmy0sEJ3XgXnMlf1WtI/yWwDFBC+2DqEwY8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(4744005)(4326008)(8936002)(8676002)(66476007)(66556008)(66946007)(7416002)(33656002)(86362001)(6486002)(6506007)(53546011)(26005)(36756003)(2616005)(54906003)(38100700002)(6512007)(2906002)(83380400001)(186003)(1076003)(6916009)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SETbynjIvJYXZo4haR+AnUfb/EVW37ugyVzk8iSAKl96VFR630r0mDwbwzz+?=
 =?us-ascii?Q?rNzgKkippDhNfd/84L0tHy3jjLfEN0Tc/qRS9Irgv3hmZDNuBrVMaaW6OF9C?=
 =?us-ascii?Q?FWcD/yshcYxX5MtdXSD59x+lWTOvY8XHSqBOE+S6qUNIFPRZzuxhvxwz3KrT?=
 =?us-ascii?Q?2bTJQkc+mUv9H9FokEDJ4PKzQ4sULkZHJ3Rm2JwyE5wnwRMp6RG3hAmi8TUz?=
 =?us-ascii?Q?pEwYZqfHAvE7jTh+5XQf09ZuEeM3lw79aSRK35EU2D5gjQvegqIVTiS47m9B?=
 =?us-ascii?Q?zeyjnhoLwPWEQdi1cj/8JDmbIeXxkfF4PiS54+ANJC/rD+en4BDJEWcWjjmi?=
 =?us-ascii?Q?+HkSCaVAyXRNz9gk2H0OWn4zTpIyqovYIEpO8/nwZrYoe2mSCuL0dsiWjf9f?=
 =?us-ascii?Q?S4NQ5L+rG8FJBztdrnfTiNnMHlc7B1k1ZEXteFrY8cT9AX1e9Fh/4dUKRf58?=
 =?us-ascii?Q?mkzK8vcjUukBKa2EPfdhvFUCg/h0hRi3FFCbOvcS3p+QfS5G8F4vcfWXvgQY?=
 =?us-ascii?Q?BbMD8B09AU36d8Et6IBEACjkBQDcjtqnMrpdzm80rQDEs0LU+Dajqw/IUQEl?=
 =?us-ascii?Q?sCqOT/G3ybvraLAs+TsOWeuPhJYo5L1/nYMp0id4EtGzigQN3HAHSvPMUHhA?=
 =?us-ascii?Q?xnEKvm/47Fu+0OhAI1QKnE5+ByM1qUWBQC5DseDo42C/B/eHvD2esT5XK+XY?=
 =?us-ascii?Q?npcIlQWcDYO1GUsztb+in/A3flXzcRH8VD8PC0DfFZtp2sFEIlPushJBtrvG?=
 =?us-ascii?Q?HLSX+kjhZHHpgxRIw7t2ix3E98QoLYUJwF0X0E3uQjtYxnYNogNNUUwdS2Dn?=
 =?us-ascii?Q?bCpu06yXHu3kzVwtP81L0zPdjfaN60u772DdHga/AbrYSUVS1ldnzaJt84oO?=
 =?us-ascii?Q?mkEPXU9NbVbLfgfa4v+6wiG+Vl5NN+JaYrw/XxUpm3gqCkl6XZ94Kcn+XBNJ?=
 =?us-ascii?Q?uS8o85DICrzlrSCtlBoQ2rOboNVWyjZrxYj2DjTrkc7Eh3VDJAQxj6mxCzxB?=
 =?us-ascii?Q?S4xccYxAKFrQy3hl7K/NdRCLclaJFK5rljpD5y8q3qVra3iYNZ6Kywte+ZZu?=
 =?us-ascii?Q?4irWzj3eVnCpNUTfs4q2kQ8Lj2a1yCUK/ijvFSqe6LYrLxDIqprrWu/cdSwr?=
 =?us-ascii?Q?5nYLy/kS/JpyV/I/bCfIbDmmk38nxEhd8OVDgBPA5stY0GQ5IsYk6ewbatRC?=
 =?us-ascii?Q?rhuYJoVFTZ8AgR/8aYXZA1/qDqH7HHpGwpB1zNC+yYkCzP2hYwLvmGIL0u6B?=
 =?us-ascii?Q?/FQC+KdX2dFlHBw2p8FBv9r0quYTpbNUtVnSV25ecq1WYiHxAP7/ce/QseHl?=
 =?us-ascii?Q?03ypzPZpKujlwrs43dQTBzuaxI1wYsvvZrKAqxkbrR6Hl4WHIgBZwmsPlkBH?=
 =?us-ascii?Q?dpBrlHAd9ZYWVCuNnAsGeCBpW6/SBjcWCevdLse9mkHwN9vNB1nZ0zPGQEfa?=
 =?us-ascii?Q?9+SiBiUCWmaV9NbBT3/uH6IPrO/0qSmj78S7ykxkR9YduodbwGPbBhdcE3Sb?=
 =?us-ascii?Q?xDkMNK5lk6tYWTrCFpPqGZZ2pIExhIqjYEwpGxNsuLR1KDLKm3n+Pal6EY3M?=
 =?us-ascii?Q?YnSaqghPypz+0pPCfi88HeRbLEdMPoqNdDms0FVtR9//vgFRtp61uvSpEnJF?=
 =?us-ascii?Q?jj10ijQ9DccnvgPAAPuLDGDNH8/R6FPDt4eyxifuBfeuw/beuyxi+hJDK7x/?=
 =?us-ascii?Q?nSNhfVBy/Wltl1Lh8G2/A4ADEPDeHskKbIMR/VXQQZ9sBHibVNrsT37FAsxw?=
 =?us-ascii?Q?vZYKyEBASQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6b5612-908e-4538-c12f-08da37f6526c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:13:51.2875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95K8mvvJcDxhttCGPVAXQU5HFEMXv+159ZWOGVcwqDx2w7HSRuHu5wG1nvKted2j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
Cc: Steve Wahl <steve.wahl@hpe.com>, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Ning Sun <ning.sun@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, May 17, 2022 at 10:05:43AM +0800, Baolu Lu wrote:
> Hi Jason,
> 
> On 2022/5/17 02:06, Jason Gunthorpe wrote:
> > > +static __init int tboot_force_iommu(void)
> > > +{
> > > +	if (!tboot_enabled())
> > > +		return 0;
> > > +
> > > +	if (no_iommu || dmar_disabled)
> > > +		pr_warn("Forcing Intel-IOMMU to enabled\n");
> > Unrelated, but when we are in the special secure IOMMU modes, do we
> > force ATS off? Specifically does the IOMMU reject TLPs that are marked
> > as translated?
> 
> Good question. From IOMMU point of view, I don't see a point to force
> ATS off, but trust boot involves lots of other things that I am not
> familiar with. Anybody else could help to answer?

ATS is inherently not secure, if a rouge device can issue a TLP with
the translated bit set then it has unlimited access to host memory.

Many of these trusted iommu scenarios rely on the idea that a rouge
device cannot DMA to arbitary system memory.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
