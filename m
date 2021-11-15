Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93741C433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 13:24:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCD761BF9
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 13:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BCD761BF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F397D80D40;
	Mon, 15 Nov 2021 13:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BWfEe1q3QmUi; Mon, 15 Nov 2021 13:24:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DFFE780D3C;
	Mon, 15 Nov 2021 13:24:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF77FC002E;
	Mon, 15 Nov 2021 13:24:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C67AC0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0C70401E8
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jb6Z2r_08XDh for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 13:24:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBC2D400E8
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWYlulmmRMCbHlpVQeTXTNnWTlBDwbkPqz0l+c6HG7bZBdppss8nf/og9ATOGDmpUqJ82Vv+wfOBj3Igiu+c4YcfopzB7HvxPdTCwZ+jNivMB8aaLOzVXq8rXA8uM3VGrfXHqjVk9quARkruXmprTWknnzfh/yPJpALSeDHOv0atQJgushe0wEK5a6EIwI1EztZxYl/vaSviIg+6KT5TsONn5s0TP9ag0k8mGR9HAkxwMrpNAyum2sg1AKkN6+veBrmt0eJC3lDiSqqY4OOCuZnIugQRkfHFdKghy/Kt4ciApmBTbbMEJJlPHKlfO3gCAZ/IODJXAJTLcMcZdEkv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh6M/p2LgbUMTv4fNApZon/poaqzcc6WopykMYovnTc=;
 b=oNDGVtI6v/hnAqgjvKMvoeW9BTPFRr1Ju20jOqOg749ZzPfZ4dfv+kPILPHKY0s0LLd201ucD/4TJgnii692Q/EnMlzXkz/j9/UYXAQ6dF3Th3PORILRobGo5dWDi/QIK0gK9k7GK3P4gq07spZPjFJL75nYnPuo07/HWrGzQCjYw298+eOppQgSw/O0AbQ8xkJiytxcPe4ZG3YUaTFLC1W1yC9chXoujxtukTA5Pgp+SzDI454/O5A2T2PJRCiRblYA/wdQfva4ctLCbmBDRWRhxmCKymwu5pLwLwDxzHg46etrxqtbjuei4OpXDsGc/eYJr2XrGiB4TR9H493eyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh6M/p2LgbUMTv4fNApZon/poaqzcc6WopykMYovnTc=;
 b=XwdqUqu0ZzMWHFkA+GEwe5nzRFoNxXI7NDBT/dc11M7ayjV3nNRiwA84PRY3xbrVfpuFZQ3IC/OVyyjttvc3HfEzfo9VOZ4C1pLXTKCFSCfJeqQ4Mu+YZNO6d1IVckWcroRSrdcApnlQnB/t7iUnQ7RtV8skcODwj+GlrvoPkpe46AqfqfTtK8g7u2CzWXYUXRad+jBzEgHegPJA/o9nVOapfl8yhvyCY09MGzytq6ccWOh/zTVSRkXwJ4C7jXvWxsFaYOYjOT2LwmSp+DyeI6FlaPhGrsHGojCdUaEbRTjUQVxbAlm/vGcmn4zMLL8gQQBnys4u2OnKdy+mebUiZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 13:24:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 13:24:44 +0000
Date: Mon, 15 Nov 2021 09:24:42 -0400
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <20211115132442.GA2379906@nvidia.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
 <YZJeRomcJjDqDv9q@infradead.org>
Content-Disposition: inline
In-Reply-To: <YZJeRomcJjDqDv9q@infradead.org>
X-ClientProxiedBy: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by
 YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Mon, 15 Nov 2021 13:24:44 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mmbyU-009zEL-Fa; Mon, 15 Nov 2021 09:24:42 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b00972c8-6555-43c5-3c6b-08d9a83b49dd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51101D64EC438AD0F6F979F2C2989@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtSXkfjApjI+8RAzGSWfOLQwypQEKpQETJHt7hH4vV/K31dId5TX9ki0ZT1z+ecDppWd+G6xUVkNEsRPEYt/NHW4whT+RXe1UG5yyjwXEuiB2XOTPMrsTW+Wf0C4pTQvU1weWRGHOmJ3Xxp/eoch4irOyF8qZJX6P36WGja21exPMbhLLyzHJBD9z41LUdrGqLOSVZz43gHrMyBHjVOdqIpYVZmUEONET6h45t7U4AWvuMOFqIEnD7LdDeNv6mkO9HBcJ1fuql2os7S/Ug4pzQCQaxAwpSCLuWgPRQR/wf5ojS00aBbgavltCjVoZTl3HhnmYGdage4GkRyg53GRKpR9Hz2itg4+sVCIQQcvsSmpRtPQIp/iQmK3rPtsyMvlg7P/aCK4UV0/WQnzYp70dV/ZhQw5gDvLPXZ6TVSXehXyRruOBidQdCLIsTIgP7P7ZQ6OR6ze1Oa8zJT1tiAVJlpva0dKLDAZ2bb8mrCCAwVyF1AP1MMrSsFMXG74UlfidalGBiKNWaAMQNNO88mO0qD9IYkP99JExRbPWoUt9FmoY1pND5OWxc2aApU5pm9Yb9THTLuQeHVUFM7wGjJLdUdPmgjX8BimkLPq13Uwj+qZGAC+9STglON/R+tyzmHe0lIESmuuWZ1VaPEMszWafQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(86362001)(26005)(38100700002)(7416002)(66476007)(2616005)(66946007)(316002)(66556008)(426003)(1076003)(9786002)(8676002)(8936002)(4326008)(186003)(9746002)(33656002)(36756003)(2906002)(5660300002)(508600001)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ojBxGbC5VN/S6eIF6XUDKEliwXd8ldHydZ3RA0PRJawYBI9qYBP9k5QhY0b?=
 =?us-ascii?Q?ZCP7U5x/p9XQ6a/CgRieah/nGsJFRJl2cRTOCuFHJejJwVeiYJBT4TMNBZve?=
 =?us-ascii?Q?H6+Kd1r1nAC9z4+8VC9fF8tqYZ96yI+o0QamGvNr8ukxXGK3IGZqh0qqkmB7?=
 =?us-ascii?Q?r2L5ATAMok459GijF9ipG6TyeGqfTmA7T5WyUuM+ciuI1TkEytSiPv6tkr5Y?=
 =?us-ascii?Q?ysPxSyHfdqUmlT/zIChDZOnAOeyaEwHjSal8tFWkOkChcsqMcUHyIIv60GVG?=
 =?us-ascii?Q?wLETCqLUw45VYdnmNvGOR87KrAGM5jmTSk4y2qBuAJcImCdh6LfcFNi2bNlW?=
 =?us-ascii?Q?CXEt04HXE8HG4MpmjNcPj/11muQQtXLKx1iiNoI0LX1g4/RUePM7pA6NC4Su?=
 =?us-ascii?Q?HMM0I18p9/giX+N+LC5l8t42CY2V3MKSYdHyrLRGPKKU49JDE1NoLibE1HIV?=
 =?us-ascii?Q?pR8UGYoYf+8CvOSIjCgyJC9r9vi46qYsC3ink/O3E6o7WWlXSpxN7ryipf54?=
 =?us-ascii?Q?c7a3EliB70ChDPnb8de5kjwlTv5FR7liP38NzArRtgkTfSGKN5PTOaT3iAKX?=
 =?us-ascii?Q?Gsy80SMM68xgwsAfWzuTVwUOtc6LuMcyIWuA85mobMh8gihZxoBnCzfE2Yfl?=
 =?us-ascii?Q?SYyT+KuRjUpwoJ+esyA+B2aHNw/62ayw4ezGDIRzJv3ijwxZMPGaDa0ZUVjD?=
 =?us-ascii?Q?DQ0+W7qfGmwuiD18g9A+2FIf5ExD728VAFELMmyX2nzhWIBFjQ4ZkUs8wXE7?=
 =?us-ascii?Q?LwruUTb9Lvjs9hqo5Qrxp++fsbOCiXHt8h9CM6hUF23FORB3axBc3xsQjcDg?=
 =?us-ascii?Q?uYaXoOhEe5mw7vi/fnrTuRk8Pp/idy8JFqpWahxeFm2COgRCV1rU6KeRtRyK?=
 =?us-ascii?Q?FA5jWfkJeCTneqefE8IOJG7XtYHOBQ2mSEbYPQSYTvfP81tdT2RRnoHkUsVy?=
 =?us-ascii?Q?7ihh+V4LUFJfecCg6Jw9c8k+GxPFa3RRVTVcOIRSFcu2YOFtI9uRDA3IGJ6U?=
 =?us-ascii?Q?Yf4l0Gj747Sfq6KbDu+EMbTaDJHsBpgPdV8Ac6qKnUHDqR8ch7vvfghN1vXB?=
 =?us-ascii?Q?9WWC3uXCJBhodkp4pXrG2iMdjkb+zS7zmvcfuYN4tF3qrz9iv9dXHbkFocxU?=
 =?us-ascii?Q?0n65kwxNm7dRCf42lNhye6xWPZBrwnZXUw5HQK8iH7EWf5NPRq1xqbzJODWw?=
 =?us-ascii?Q?VA08FdoZpOlgmGUjz8b+NBVkcxIWsbQAVo9PPDO5YqJxkUloUxIu6kcZ2AdB?=
 =?us-ascii?Q?nmv/qNAiUrU3qB0unpylxhQgCj+UcJiZdWnSFad56+RnUvWCwIoUOGlkiwKp?=
 =?us-ascii?Q?3YQi4/476B6XnmmsbI+grUEAOV5c2nMSly6RhX4fWqB0uaDZCfLqIsh3vAUz?=
 =?us-ascii?Q?MqrgvwU6i7G+jtf59TC5q6aXfuy8BxrRj5uSIN1kxJM5X4/r4I3N22qvrAFi?=
 =?us-ascii?Q?KbBmBz6sJHo/GOflvUhXQxcE+CGmkUxaAMvxKqsamdFYfY7CwwYR4QfqpELb?=
 =?us-ascii?Q?ejpsvYSBX4uAF7bakuB8FA0HIlQiNWw327j6d23Z1K91J+3x0gfPxyy2/x7u?=
 =?us-ascii?Q?ACEfBzWY7CBMbIW3WfM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00972c8-6555-43c5-3c6b-08d9a83b49dd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 13:24:44.7100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbVhH6ib5C8IqJSa0kr16GWW2CGAe4JP7vZQB6gBZbNsD4sG4IqaZjd3yU1uEvgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Diana Craciun <diana.craciun@oss.nxp.com>
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

On Mon, Nov 15, 2021 at 05:19:02AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 15, 2021 at 10:05:43AM +0800, Lu Baolu wrote:
> > @@ -566,6 +567,12 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >  		goto done;
> >  	}
> >  
> > +	if (!drv->suppress_auto_claim_dma_owner) {
> > +		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL, NULL);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> I'd expect this to go into iommu_setup_dma_ops (and its arm and s390
> equivalents), as that is what claims an IOMMU for in-kernel usage

If iommu_device_set_dma_owner(dev_a) fails changes dynamically
depending on what iommu_device_set_dma_owner(dev_b, DMA_OWNER_USER)
have been done.

The whole point here is that doing a
 iommu_device_set_dma_owner(dev_b, DMA_OWNER_USER)
needs to revoke kernel usage from a whole bunch of other devices in
the same group.

revoking kernel usage means it needs to ensure that no driver is bound
and prevent future drivers from being bound.

iommu_setup_dma_ops() is something done once early on in boot, not at
every driver probe, so I don't see how it can help??

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
