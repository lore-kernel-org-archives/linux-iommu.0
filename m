Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E294C4332F
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF09E82A4F;
	Mon, 14 Feb 2022 13:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9q0yWzXlUPBU; Mon, 14 Feb 2022 13:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4BC23828F7;
	Mon, 14 Feb 2022 13:43:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2196AC001A;
	Mon, 14 Feb 2022 13:43:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF77C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CB6F40226
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zzuIK0Z5Jg6w for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:43:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::623])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22F19402A1
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE97dLPkHraPh0FNqwxwbYw5O6+n0MA0ohFAglHsjMfiyak3+ZpVjaYGWj4XXuWS2Bjwx5uMg1ePVE+Zs9CblCnpm5T/DHuX9V/+hXKgJH4TxMly/tS6mxHCkZcWfGcgH85d1HOHEQ2z+NE648VqvGWGiCHd6k5Spy1m3zdvbjE4SorrPYp0YlCjZ/7HujX42xI+1yTXxWy1POZahdCkrUOye3R73E5oq1AUMp06nimqjqHw2bLY+bKBXftUFfQR+c30yJWT38iPzeMm2A0RfRjmLUZUP8vJ6IibzzDLTnd7K211pSX62L1luTzPKDFk2Wtl9xkhLY3Yf/xqOrNZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cu/DWWuMTq7gTxhLGfwGPUieYNOdIb9/UasU2tzmvE=;
 b=IfbiGiclJmhbE1D5IeLWEFxdteRUNtvlMdfhdcqjlyaJSBmz2tuqsp/FYYw7U9HF8wcgE+oPA7tusBAlnarrb+nn1Znu1b2XiAf98KjT2kzb0suiWBIc3mREfo3byzWzWOqrDcXFubPEh/ldDsAKe5ZcV/h+8EvNuwLWntU1vOrvsdk1BasKflRmBYWmnao17c94CV2XskRgK1EJe95M3tz1fmIEVKn7erI3dgZdf0byU6nbEcB4dkqx+ZoedNELmzaXUA1jf4EumAvXxufu/xwJNwDfv1tUSJaDxNYJGecdDWezQxabO0WWeoVgoASJ2waUAbgIY/ofruyn/kEjBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cu/DWWuMTq7gTxhLGfwGPUieYNOdIb9/UasU2tzmvE=;
 b=fjrMgi8jRKjtJICw8BsLbHgVmTSaj02keGFJnhsjOd5Tgei7MkzOoi1Ks5uFeApjSlrSLUkn2ZphNvhK8YEZDC22EfPsoOaMs0wltVrWkqb+83yPo2ICjVyiuJAkKzEWjItU+rq3v/jH/MmbqZ4OgNjPfAwSC2VzIbIASHncSzgNJxADL8LuBJlrFkXaFDK7WNUsz5IEYajZPeRNFFBxGMBuPZ12nTTErC1VpJz5Hxve9p5F9Z6MxZhhd0wFB4nnQuQOrnFAGkM46ue8UNjGAEzaNWqztE+Pufbte6LPSMtKJgaZ5Fd8F4LX6F/fnZWBNAz/p4p0pHOmsD6C++ynRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 13:43:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 13:43:04 +0000
Date: Mon, 14 Feb 2022 09:43:03 -0400
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 04/14] driver core: platform: Add driver dma ownership
 management
Message-ID: <20220214134303.GA929467@nvidia.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-5-baolu.lu@linux.intel.com>
 <YgooFjSWLTSapuIs@kroah.com> <20220214131853.GY4160@nvidia.com>
 <YgpbC1u6YFN4GefB@kroah.com>
Content-Disposition: inline
In-Reply-To: <YgpbC1u6YFN4GefB@kroah.com>
X-ClientProxiedBy: MN2PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:208:134::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1a356d3-eee0-44f6-6c6a-08d9efbfed0b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB419913719B1EECA6FB085EE3C2339@CH2PR12MB4199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5go4pdGe2fK9lXoLg0EOJtLuNUjlSyqdbWZMO3w9Dlw8jS+mCCkexqI7yrutWiFYd0rawwh9+frL6OeNZIQJubzkROv2fui1e52xRl+GnR9+7zBKVIWJ0qX/+bxW9Q5JeK7NfCPF68S6PCHU4w406JDle1KwoopD6YPxslkqK16F6b3piIFwWawoAe1eBmhSyx7Dc08MjDJGxL7StWVvW/avaW9Kp5v/MTJiIhG/LgdAywkkcgwGShqbJXxp8OVkOqVDAvADZDDfIp0Xp2+5GaLn3BMDuQcN5TqkNOUcbG1QJ/zzOC+23BWUFwxlyYnx+w4HIlKMo+D9JJOJN4QsqjGao5OasaVvsGcGJyqy3QVH+P4GEwBzSqfBN6E3AnZG8dA0RNJmdekx2amytQtgMEETwh6EYwvY04L4tqppOYoHcyYp2PV8RTTlzlo5EfBaEzpaS5mrWDGQZiV3QfA0LNhu1MdrrHq7Qum3Sy97ZPMEBOYzPcJ+EvfChrGFrgKXU19F4sL7KpXKGPms//xaFQvi2lBTjD6yzlmNM1elJRMUh0RiJhKjac7CQ0QQ5JcOkgCTCGhAZYf5AmxhwvD1nKrG201tB1rvt3ZwrGwBcVZR5MZksjq5t79RQ+4zHb6CFgyrNTS3wBJGcMQ11C+mFoIWmqb+dm+QMnStwhfESYfX8TOs2p+uW6zCBxLyWi0D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(86362001)(66556008)(66476007)(8676002)(2906002)(8936002)(38100700002)(4326008)(5660300002)(7416002)(186003)(26005)(2616005)(1076003)(316002)(6506007)(6512007)(508600001)(6486002)(36756003)(83380400001)(54906003)(33656002)(6916009)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wY5NrCssh7UsFtjT4HKjdx3ofwbrFfB/B6YEz6DW7jqmyOIutQosjfHHeuc4?=
 =?us-ascii?Q?FO2vsWMpghgQvFsz+M5heJmk6LX3fi41HilRZLlOCbt5fPS035eG0qOW1gi4?=
 =?us-ascii?Q?V8jeSbycaXpEGN7u0YjiEvzHQfoW1CW8P4ClpjNINF3kFTRCA8nuEyOPVYGi?=
 =?us-ascii?Q?3KNjs6Sa+7sZwiR8bQeMZrIuYuP/76vJa2bZ7H32hGhh7ycAQuWa7Nz5goHK?=
 =?us-ascii?Q?NG5wDCOlnq77MoscOampoL2UtLWRmFrH6JmtrX9ij/tMF66HAoK4zcr5Mq8/?=
 =?us-ascii?Q?Kd9OXuk6RY/c4UpnVHbLHy12epg0MUU3Ufq79G8yPgAR8IWnUBr7Fn69aeuB?=
 =?us-ascii?Q?qwiTNUb1fx6/zxc7PRAkyJnGZLXCrPu0C7A6/THpdgghCobCZqTYafygvThy?=
 =?us-ascii?Q?OF0Fhaxn1epFTbmnkCvB7ZcIjEpDAO3+ut/4I9/MZjapRdELV6MycgIGZwlz?=
 =?us-ascii?Q?mHTus36y67VOewa9bvAQIK3JuprD3/8f1ER20xvjOlYGt888hRtG2WFZqRMO?=
 =?us-ascii?Q?uqCokWRlRMJ7XIvKngmEL6IOOPA0Dk6ozEbGv7RK7jSKnwHS4UqcJZpahShZ?=
 =?us-ascii?Q?+PdUwXfGAxWwxOsqLQhdInNU7IM0rhdXnOex70J8aKai+WfhS/JQXrh7wcHX?=
 =?us-ascii?Q?xURplpQsiJrWJvcg0RFnDZlLLwp2ieMfbUngtgYEW904wejPAKuuGWUfQvXb?=
 =?us-ascii?Q?OV3BdO/oQxqUUMSwhpTh4da25yjxo9wgxB7Xhbb2Kip7+SZq52zno3j9oeEs?=
 =?us-ascii?Q?NLWW9qLxU0RhuBIcRZWP5GuTHYi1kQoCk0GxaK1FT6+KmeLbG6/pi55IVl+E?=
 =?us-ascii?Q?zRcUURKRYuCXujrc+csMwBGZQ7DiSnfNgopacOpU1CWR+6f7WX1Llz9yRxNr?=
 =?us-ascii?Q?WcR+rIaQqas+OodKfwMm0Ey+s7agFen+HJT/zHAmuPKaj/IqNlHONZFN3cBV?=
 =?us-ascii?Q?L/t7ZV/dbtkuiii2L9mHMeXNM1vnm1HfEFet6hqDX3fEgXkVrkr3TWQlBgtH?=
 =?us-ascii?Q?HxqGZqKdYneIQyKoy7zndCngcodYOEk7OSCNBTxuxa9PKbzdarzXBQNRB4dL?=
 =?us-ascii?Q?cet2YRBP2E0u60UH9OfDDvKROkTtePgR3y18cFPwoWrYEPE/dPhzXwShahII?=
 =?us-ascii?Q?2nI+PWKYje2Oku4MHdqQ+Mi08aYHpiy8gJuaB9ORqS7SzU2IME782LXW9zVO?=
 =?us-ascii?Q?opnD5fCHLzmLnFeK/dIgTz+7gaKhXvAZy1LfyTyr9nIB7gIp7tGEWiIw7Koj?=
 =?us-ascii?Q?0RcejXpyEk7JPp6ZImSGUfy90N5BOft/dfLwkK+22TzlaNx3hG5n00iAPwIF?=
 =?us-ascii?Q?6wKsl++kgl+m0V+6F50mVGS3ZnHqm2bfxzu2TyQ2nL6KuLd2oiMCKFMFGq5a?=
 =?us-ascii?Q?7gZgRoR/1QvTZ2bvFIZ/4YL9P3F7bHk4D9aa1CsdM9g1htcw5CDcQrsDRxmB?=
 =?us-ascii?Q?D2453DXtxmDaKWdMYiC9II2V1OqUz4JTgPU5jgsbwsbbfFt7lbm7LcjIOSeh?=
 =?us-ascii?Q?Fg9OFkn0YpsW03GtuGIpHm6PgYoPaOWXRy1RArrrYM116wGSzyeAwqVYsqEL?=
 =?us-ascii?Q?7A0MzDiduWdQVB6tNhA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a356d3-eee0-44f6-6c6a-08d9efbfed0b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:43:04.6890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aN65iW6lHtXqPiaq+FFoSEU9Bxq/jLZTAbMtvxluDOC6cJsdRfFsfM9KlzsTymgK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Feb 14, 2022 at 02:37:15PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 14, 2022 at 09:18:53AM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 14, 2022 at 10:59:50AM +0100, Greg Kroah-Hartman wrote:
> > 
> > > > +	if (ret && !drv->no_kernel_api_dma)
> > > > +		iommu_device_unuse_dma_api(dev);
> > > 
> > > So you are now going to call this for every platform driver _unless_
> > > they set this flag?
> > 
> > Yes, it is necessary because VFIO supports platform devices as well
> > and needs to ensure security. Conflicting kernel driver attachements
> > must be blocked, just like for PCI.
> 
> A platform device shouldn't be using VFIO, but ugh, oh well, that ship
> has sailed :(

I don't know why you say that, but yes, this is was set long ago.

> And stop it with the "security" mess, do not give people a false sense
> of it here please.

I'm confused by what you mean. This is all about what we tend to refer
to as DMA security - meaning a device's DMA can be controled by a
hostile environment and not impact the integrity of the kernel.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
