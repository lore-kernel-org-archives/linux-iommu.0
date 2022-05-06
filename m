Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1FEC433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 17:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D627607C7;
	Fri,  6 May 2022 17:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Emqvty_GITK2; Fri,  6 May 2022 17:54:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 234C560BE0;
	Fri,  6 May 2022 17:54:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCFA8C0039;
	Fri,  6 May 2022 17:54:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38CA7C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 17:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1919060BE0
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 17:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8AMpb8ipyPWj for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 17:54:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::611])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C07AC607C7
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 17:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+Po1rd/6fbbNEkpB6RbYTM7c+rahP+XTt51BCR84P+UP3G2IicpiSHLnGm8Pq9QnxBTrFa2KC5chNi6taZCGtQ7OYySlKrIAFR4XwkjzFSNmQWRxFvgJPSPf9c0HxWRIPGv+XLAZj9ab9Rcx/dC8MgoYDChaMAP+9rOJx10+EdaorUg3r3ilm29Ru7HCR4u/SqnJt3E1Vq0iFZE2mu8lsasuzubrxyoKLI/UhkAL1wmWdfFXofgnv2h2UKRVA12FFjlvjLYaOq2NxTOucIXeO7zechLJj39QhZiYY+Mq2/E2LLil14FL3VYoTy4uIKfrwxhaj5LpJAjcDW2F/chDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR7T85FiF3c74aHbN1eW+W5Ww039DneUX7ryNd/EPUM=;
 b=dgMlTPNxvK3Zl7O/zbTVSjZYsLL6NkIknxmduyhYjAmDv4DBrtC69p9xKd+eOcK/9dLy3921hLYwvUe2dFtmVg4woBLuNOkvJUfns3H+WYwDKZmAqSdsj3FABg65Mld14gx4HpaszImZyi1nhcETO17NmT+SzmADpjnm0dvLXM5Vb5WqtzxpN61+0/Ys45Q5RZ2q6IiG3ksAb5pky+skhpnHT1ygFZLvZkWkq9MXpbM3Hdeu09jUG0M3uKX8fykyxKhQAEL7FVZT9vM4lXhlFqZHK+8R7Hlk5XXa2/Z+DDsPGMOZYzn1TdPc4VGeaRcL5XUkKnTyhJFcdCL3KgB1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR7T85FiF3c74aHbN1eW+W5Ww039DneUX7ryNd/EPUM=;
 b=HF+inlcx5C/X7LDr0X+ADt8dtoh2w9eh74OWAH0Ltg2YcW9rTahkam1HkcGQQaPIaHJOKGS5QG/LnbG+tq3ogWQYniXSFZuL2JNg+bOTFIlP+Vkc3QzWjQH7LewH7ZO3jRRxl8DvBQsgrMQcH6FzVro7TEDPcIim5PDXHoNv5bYS4YTN8x0Q7i6qJwwnsigbXkLQ9zysbfL9mk+PBQwCBeMeaKh7QRoB+UzNHTH2xIliOGTV4J2SZHJ9o02cLpE/fOfthEXqOo9ZFFgK6mTM6Tjs8a7Rhpxn1rUGzN0/n2JzcfUE+Xx3h6ArBASQp9K7VOnhlN59pfDFCO7XrOgpVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 17:54:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 17:54:48 +0000
Date: Fri, 6 May 2022 14:54:46 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Reorganize __iommu_attach_group()
Message-ID: <20220506175446.GF49344@nvidia.com>
References: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
 <94ced5af-820d-8fe7-4bb1-3d552a45b80c@arm.com>
 <20220506132113.GB522325@nvidia.com>
 <9b19440a-9cee-2f3b-8ab4-1316dffa33fb@arm.com>
Content-Disposition: inline
In-Reply-To: <9b19440a-9cee-2f3b-8ab4-1316dffa33fb@arm.com>
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 917ddbde-02a4-4793-c6a9-08da2f89830f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52079DCAD674426AF8D0FE63C2C59@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ndx5t1PwUcdxBNs7Dd6ABmfvbcccWriiznNIofNvptIoq372BqXk1D80lpSxNMypGF8X/UerOcRc33hCXXlXBzUX12CXI/h4/bqPBMBz38alkjjam/Put0T10iqT6fN/ac+2jvqe4DcAFN3uVo1JYzwTbLJqrmNLRawUZ6Y4s7QDwblNSA1ntdnU63ujbtb1NHpeu5d5NfS+DusdhfoRHrlJU5CPaIz3sh0ialtCJIY1mqiQuHp7dRNkQB7ubxdiyaLM2fLgLi/B+1wX7mnU04UXXhULiXyyJ1lyKh9eEwaLim1gLbbPxqwC2f1dbeWahDh3kXbSL6I3XWb5ywcLQC8DYrQRGYyQaexM7nt/WLwHyoMPBLLLX6KrRRNHsdQpVjYCmeQmuE5ruk1kFJRgxpWYQGKXItUWoaTPSeJzrLt5BvOmzbzFZEtggYBlnqpe5+SPI523r74Od6RLVy1OxpU4blRndRsCSiZG3+LPfkTB9Z0sVCQjRRG7zTkEK+DfISZ+1y9CBm9Nola4tL96bfLb5rL3vOR5uTvtIYRKudC2r0QmaSzYoese/JeaqXaY9TJnL26h1Y8EHUQ4OJwhGwqdAG0HrqFEThKFd7fL7CRV0x0oXh6PjeVJdxjn80uJfILJenyr0fGMlLivjiS7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(6916009)(6512007)(316002)(2906002)(508600001)(1076003)(5660300002)(8936002)(4326008)(26005)(66556008)(66946007)(66476007)(36756003)(33656002)(8676002)(6506007)(83380400001)(38100700002)(2616005)(6486002)(86362001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGEUhL0uvGXhBnCjgi4JXSSCQnZE+u5MFPNnV3DJsqYbpV3zYRV9oKpm3kF0?=
 =?us-ascii?Q?NwdjCA/OPxUxe2XT0kjUfFahjcEHMSexQZ7CSV93ivuDaF0naNzPhbCvyaIh?=
 =?us-ascii?Q?Wr0c83uS0kwd4mHktyXCGGrktRtv+KmbxzLcMGdxLXlCw7uOkfoZg5GzKUM6?=
 =?us-ascii?Q?7DZr1pAKt17o6KKHaGs+/wIUV2yPz8XKhgVVWbl+qYvG/mLqdXiKI4hNelN6?=
 =?us-ascii?Q?izflF5KaPtz5OLVTgNghS0c5W0+rexD7WtAFb/7NBCc5tnCDqI9U4lxOTf6w?=
 =?us-ascii?Q?DrvMqHZMOo75eq7N3Y9Fd7+ZpG0cLBA5UNQHJO0v+sH2hwwYABqioiUeOJSR?=
 =?us-ascii?Q?Xo4tPzwtZ8VdPW8r8oZES4usRT2v99O/72KRze0eKTsixqObLI2NqyjcoJ5w?=
 =?us-ascii?Q?I0mcnVFrxLRDGffV4neInorMvdT72TScYXGu3L0k/NOxAVjAEyxqDrMT7/d0?=
 =?us-ascii?Q?mDzuQDJ0twLyZ75ni4Gt6ioTvVeVVNyBt+GU0k8k5hjHSh4P7f69pGEylnPi?=
 =?us-ascii?Q?3WO6NazpbdLZMzcM9rWu+zXMaOFvhDR7n2TmMXb6Dg3hsOqKL/a1tw7E4IRZ?=
 =?us-ascii?Q?MO/rEebHYIAIfRtKLBshQ0ISVoqAk8WtlJC5YXbodzTF8/rN+xWFYVT62o9Y?=
 =?us-ascii?Q?dbL3uVh9zyOewcNFXLM9WNzFBu7/unKlKKJYn6arB6E21SDDlv48+O6kGZ3Q?=
 =?us-ascii?Q?kzLS45NjKQ7jCltn8v8Oxqtj4wxJh0VnutTFL0SmY8xh+lho/u22OYo0lEGy?=
 =?us-ascii?Q?4HeolHSPhpmtO+crJWjImiEHQeiJkdPIakf2i/rGaRHuwgc9c4ZJReUOd13x?=
 =?us-ascii?Q?+18bPSBmt8AxKNq1+JlENnp2IJSELSfrM5/ysubtQ85QKSh9/vLUSgS4xczp?=
 =?us-ascii?Q?+fXOO4cMtR25XGI5js8BtEk8I5g3FxE8Dto/Hil948fMVZ2fSuJ6rMzLx4B9?=
 =?us-ascii?Q?eKXaI4D2snF1dCnxLICcT4iopgFFYqc9FCCk7SAmFClyKTeVIErD9083BgEI?=
 =?us-ascii?Q?ttWzvX1zaVh9t0jwm1iO/Wo33rFQY3u+z101uxHZo0GvrjSY+OB5t7wFTRdb?=
 =?us-ascii?Q?E1BR4co/fSgeCzN0Y70XkdByPQCxHmPz0MtPtFIFGDkq6F1GfOB5+hBfgiN0?=
 =?us-ascii?Q?uCdZHYL27y2ZKGytPzWQF5NTLLSP2e7RdeRFWgBwkCKInAd6jRAjthNehKTB?=
 =?us-ascii?Q?S2Cb9UdKUJo1l7k7j3DBLU9JgnsTjgVG9MxutpjMknKtjuMHwaFVOunY/aCf?=
 =?us-ascii?Q?JTzHLqVLb6NPreaR66mj0ajYdKB9cLqcEL5D9u/2YtXl5Rtpl81y4hlcBCXa?=
 =?us-ascii?Q?5RB2em32TR9wt/zzXsqEE72NH9OzLfkjVCO1Nr4xGWLl1/CMCBzEwYTLHuJp?=
 =?us-ascii?Q?mb7PCOZyWpTUcr4Y7p0SZeD9urbgLjGgz+xTSdXe9+a7NFtxMq2t/N7HH54N?=
 =?us-ascii?Q?BauGRbPoEtsIrukNBWbb8CBxDEiWInJUvYhWOL+sk6RGv/Tg4BaF5PKPL5vd?=
 =?us-ascii?Q?iZjOS0EDCgb/coabeERdTuWRgQn4SS1P5zfLbCC2Eg4Ts8fBnFBhMk9No6eQ?=
 =?us-ascii?Q?0f2jqHpHgrKQqfqmMbezCtDeETmEYRYgX9cFwXYRiGk/EnadA6W3hAUG9zTQ?=
 =?us-ascii?Q?aYdVfxwDNoXtDnxxogBNTAPOGVXgmOcrNo4PGUn0T1HBxxnhtBkA8jCIR0/C?=
 =?us-ascii?Q?66p+K4DyXMVB54+mho8Gt1EkIRBn0m+ZEsti3moNeB5zj3jncm0DwJ6+7O1m?=
 =?us-ascii?Q?7JQlQxJ7fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917ddbde-02a4-4793-c6a9-08da2f89830f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 17:54:48.3626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJy5MApvt4fMgmxAoMoMXPcu9+Lu3waEhUWU2sghurLXHO+PwuwxoF9CMA+jo8mS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
Cc: "Tian, Kevin" <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On Fri, May 06, 2022 at 05:44:11PM +0100, Robin Murphy wrote:

> > > Nit: if that's true then it's equally true for iommu_attach_group() as well.
> > 
> > Is it? I didn't check this as closely..
> 
> Well, there certainly seems no obvious reason for one to WARN where the
> other fails quietly. Either it's an egregious loss of internal consistency
> to not know whether your thing is already attached or it isn't, but I don't
> see why the exact flavour of attach API called should matter.

I will try to check

> > We don't have a name for the set of domains owned by the core code vs a
> > domain set externally.
> > 
> > If you don't like core how about internal/external?
> 
> Oh no, I rather like the "core domain" nomenclature, it's the
> "iommu_group_is_..." part that then fails to parse sensibly.

Oh Ok

> > > Even getting past that, does it make sense to say NULL
> > > is a core domain? I'm not convinced.
> > 
> > NULL is not an externally imposed domain so it is definately a
> > core/internal domain in this logic.
> 
> So if it *is* a domain then I can call NULL->attach_dev() and...? ;)

You can call iommu_group_set_domain(group, NULL) and it will work.

As I said, it must have this symmetry:

 __iommu_group_attach_core_domain()
 assert(__iommu_group_is_core_domain())

This is why I choose the name, because it is a clear pairing with
__iommu_group_attach_core_domain().

How about __iommu_group_is_core_domain_attached() ? Solves the grammer
issue

> > > For the sake of future readability, I'd
> > > prefer to call this something more purpose-related like
> > > __iommu_group_can_attach()
> > 
> > That is not the case - we can always attach any domain.
> 
> No, in the context of the iommu_attach_{device,group}() APIs where this
> helper is relevant, after a successful attach, it has long been required to
> detach before another attach can be performed. That's literally the code
> you're moving around in this patch.


> This is precisely why I'm starting to think it would be beneficial to
> differentiate the internal interface now that it's firmly moving away from
> the attach/detach paradigm still exposed externally.

I'm viewing the API family of __iommu_group_attach_core_domain /
__iommu_group_set_domain / __iommu_group_is_core_domain_attached()
a layering point - the other APIs are being built on top of this
family.

It is now exposing a semantic the same as the default-domain enabled
driver ops, but is using different nomenclature.

Should it be __iommu_group_set_core_domain() ?

This naming seems way harder than it really should be.

> Heh, if we can ever get to the point where we don't have differing old and
> new semantics side-by-side at almost every level, maybe then we can find the
> right name for *everything*. Besides, it's arguably even weirder for
> attach_domain to be the only way to call detach_dev, so there's that.

It is because the ops are misnamed for what they now do.

 attach_dev is really set_domain_for_dev()
 detach_dev is really reset_dev_to_platform()

Which definitely is the root cause of the confusion that created this
bug in the first place.

Anyhow, I'll post the fixing patch again with the new comment and we
can decide how to revise the language separately, no need to delay
getting Lu's series back into the testing stream.

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
