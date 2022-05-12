Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AC9C433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 11:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D5B340BCB;
	Thu, 12 May 2022 11:32:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01UiJwjewcQH; Thu, 12 May 2022 11:32:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C7FEB40025;
	Thu, 12 May 2022 11:32:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B623C0039;
	Thu, 12 May 2022 11:32:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D013C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8293660F43
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0WKVRArgcFqc for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:32:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::621])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4901660B12
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:32:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSXXauvj0KSUwvLFVyGvcKxU643PRs44S7Wg1Wbm3+1UizY6zQzVI6oL00dGf9yFCfeSxXC/uEfhHvVxUMrcyqjJHpcoXyi2Xj6FPvNetz8IRzhz4swJM3tmFfzScKdW3X19kAXEDko8vTsdKQyYe4eZU6JTx/TCYKlQ6LHMI44txt0UVdg8TEMUGr04BEWRN445VPekC0XgUQ6L0RzXwWkCeJrEUDiK1ApAE53NjPEj9CIkY2bC9BcLi93bvibKDIOon+d0s/o/qpQ1rf0FDEIJ2CoC7sz7+sfo1VJcNdzDOfb3rq0uPwQriCerzjraLhL7KIO7dGI7M/x5kcWlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgbdBMWPSdmx9DAErRlLz9zRsK6iiDJx1WjycVtHyNE=;
 b=kqx9WlWZCXIqxmnWliGonnz72EcqlpPJbW/bjNIl9ababmyVuN8YAKFgicJpWDvDEDyXyOjgVvrn6ntPM84Pdq9baCIusuiVTLko6szfDoieFagem3chTl+s49SnpooR95BWCV5G/FsEQhqAP9z+2fYqzI+ytRZ2lJTekJP+QVeZMl4PiCwPInPM8Qu2e5ymfaMCjc8KF5FH7LHfife6R7lyU/cKKNzKk+Z+1mnmtcRQmD/aTlnGiZZSZsY4GWN/YAg0XAeZm7CSO9NL9BYcCsrn1MZa0pix/CS38dQVPnF6V+9bre7sdSJiP+psKH1fXYukLjkCRWr25JglkWxU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgbdBMWPSdmx9DAErRlLz9zRsK6iiDJx1WjycVtHyNE=;
 b=SiJer5D66sWayeBm6RyG11Pg+1V0jqz8GzBsfFgqirKNSDIKg5cPqTsKB40vSmvXXTOUZulgcYV1xenc0HCg1DGmYTd7E7/6zmaTAyA1Gun5zt/YFk/oP9c1GgU/abk8Nm/XUgfx+pvVN2oGrBf6+3UORNlhfohmPhAOOemeptHAO0u5RkzHr0vvPDztq2Dzf1e+dkjPpciqziPY6XAC5Mm582AUZJoyTzdTzNomUnrD6tV/vR8YIyRGhgFmFKryCT9q1fI2eq0/7XsGln62TtbFERXEeVb6BEbYsTx6EMWY0iUmLlHD7RV/5FCk0AonitBf5W6o3QePfr+SBjKpsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1925.namprd12.prod.outlook.com (2603:10b6:903:120::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 11:32:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 11:32:42 +0000
Date: Thu, 12 May 2022 08:32:41 -0300
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Message-ID: <20220512113241.GQ49344@nvidia.com>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
 <0e2f7cb8-f0d9-8209-6bc2-ca87fff57f1f@arm.com>
 <20220510181327.GM49344@nvidia.com>
 <6c6f3ecb-6339-4093-a15a-fcf95a7c61fb@linaro.org>
Content-Disposition: inline
In-Reply-To: <6c6f3ecb-6339-4093-a15a-fcf95a7c61fb@linaro.org>
X-ClientProxiedBy: MN2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:208:236::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b79170cf-843d-472a-8d8c-08da340b2097
X-MS-TrafficTypeDiagnostic: CY4PR12MB1925:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB192510C1818830E3A50435E3C2CB9@CY4PR12MB1925.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Oc7Ope0fYkSnuLEG9nJzcab3cCX0KleRRitQN+efYAEbVUQxHKi02bB7L8PalGTJYzw2bmH7wNtWetzh6LSbnknPDt6phosLtTqEv46AAQgtwou+p1MyUaO95fRUlMgLkYG4scKchiR6Kc/SEH3x4gDmScwHLs6q1czBZsAcUsu+GpCaqjwjjjFffqO8DdxXgevU8XN0+MTlJNBJaUtDDGXniezCtGgzU9EU0QsJ8nmr6u0W2VrcOZDasob0f/zfu8jXNcv6mfG/c5BvDFmfVKuHf+6YF67GCNlHEnjHwg3Qj4thU5dCFhm0IutpY1RJJ9lzWFJSzYsckp4Lbj+9ryggvk+zC55Qh21Ix4L7k8sGdt7EpGGHQRpMpkGa95BXOZVZFuNkEyXBf5URNagvIp9eCC6UQU9isXUDTtRMrr6gG6SztZMVnGeUFOqV5wDXL93GJATV9BkGW7388oMyCpbeberED93vtML6rsdt8eo1ZaqoQFc/xitXGbpM4b5AFwdzWPkvnYN4YqNbGYqAHF7sNs246Ym1NaL1JT8PLS73Sc9cVuALZImm6i5moG8XPrbbx76Jydnt2+8ON+YEJU5JPMFX5TQS+xRu/ARxeAZ/uTto105bwz5liqXedz5OwMTwaWSXG3jQtHnoBn+Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(36756003)(66556008)(4744005)(4326008)(8676002)(1076003)(2906002)(6512007)(83380400001)(6506007)(186003)(26005)(66476007)(6486002)(2616005)(86362001)(6916009)(33656002)(54906003)(8936002)(7416002)(5660300002)(38100700002)(508600001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GmeK9+ighCsEWDcwfVHotTvkVmCP56hW9yGLbywgKcwCtLwvnhX+7lPQ1Yqw?=
 =?us-ascii?Q?z6bC98C17gZ2gPOkDdEo0A0j4CP9hKkhXAoGPJs2vhQdfIBJRiCwS0UXQk+g?=
 =?us-ascii?Q?ExUA0DwmWczGGbu+V2hFpexJe1nPxzCj3CkJEIP6i/xsQ4/3O0MHMtrHAJgG?=
 =?us-ascii?Q?07fxDKODDyS0M/kGLvFfx1OVB62RcC9LRSbEssoSlTqoluGLhTdo8jhUPQvM?=
 =?us-ascii?Q?GAK+BuK6STwnsCL5TqniyVwtWr9Bgsn8k5i27+CmXPW9FcbSrR96DfX/8DTL?=
 =?us-ascii?Q?qQC3PkDWnI3ZcrDDUcBO/705czLjy6SvbL695pugooJtJP1aMpQ7kh0Ylnoa?=
 =?us-ascii?Q?C0vTmLPRUTTMc5Xu3tJsc1m9uJYT8/g2ALjgiCykbEInD5RjGOeFjW5rKzy2?=
 =?us-ascii?Q?IlJXbFbTVisYFR0hJtXsIY+9iCSWaQUES6SVEvkIrOL7MzsXR+vHKuC2W7is?=
 =?us-ascii?Q?JdfJpCP2OR+QQPiZ/w4FZlOQ7aSBUJN70MFXnMvxiPwC1vDBbWL3NQ5KS6hi?=
 =?us-ascii?Q?ho5nRdGNoUZb/EZws6ZyDKkiCx9m2CCgETnOf+NMdNmuypPtL9Zyak0M+4le?=
 =?us-ascii?Q?r9eUiOYimCUtFI1eHhQCepK+ruQFTU4PVgpL5w2SpB0uvoTtDNPhNqH9a5NC?=
 =?us-ascii?Q?N980rQLNlnuU/SYThq3CFfDlejitisUM2queynIoyQ/sn87IIoS+c324r15g?=
 =?us-ascii?Q?IO7BTE1a7IYCpH16+U5sLPhRWDrXbU92eQi0ouXk0lPyrZLxcPP2elhKfy6a?=
 =?us-ascii?Q?Coe0jjLNq1IfX4iom1DT1tAu0AOoJl/rXGaUKPxcVxN/RgigZRoju75dMsw8?=
 =?us-ascii?Q?pW4XOQ6O692CODy8HoKYCRWtEsqyWwSlRmE0uyq6JfJeQoKkWL8gwoOnJTNR?=
 =?us-ascii?Q?JHkJ6O1Kn29J4zJDQh/NbpivhagdH9ARJFDSnDmWlM3A4ghzGennGHAkPFXu?=
 =?us-ascii?Q?t+ASBgahp56svhp8uB7JwOgwhjvE0zEbkfcKJcbMzO9P6l/MFq3hXOAQE7KP?=
 =?us-ascii?Q?16dqnP3Ns0AOnmWYJdNTe105Ns8B9HxU9n1psGH228HnuU21KArjxbBZHzEi?=
 =?us-ascii?Q?3vgJ9ympjvG6FJVdcB8+Y5T9Q2Vr9WekGRqoX4mSJuNna8fagk6XuQgwjc1X?=
 =?us-ascii?Q?CF2JKS9SH7GbA12FN23Mo5EXYiFVzzrKjb/BD6DPL0M3ZC7ytX9/Z7rso/Qc?=
 =?us-ascii?Q?P/WmJmS0A4ygUpa1vYxwB9pPbO6W3XpdQz95VxjtcBT1hD3tI9OjfDj1bf1f?=
 =?us-ascii?Q?uHqwkDwVTWLxPQG2YzKlRm0Z35Bft4DfxcC/1ZiOymwus5Ov9LnsA2Pt4B4S?=
 =?us-ascii?Q?8LZFX86P+ksiQgORfroh8/d/zyimjKuaoacrFYKIDa5i3jJFj+/DQLydpqVu?=
 =?us-ascii?Q?hxH9gGZQ3y0/Upgn+WCLd0QzfkYVYjKsdh3Ppg/9ijm2Hda8xEqli2zLrVcv?=
 =?us-ascii?Q?fRveS9n8CqAxwCRGrFUYe9OloORoq2NrH7UrncBvxu5K1S7rp+MJNJ2tDmuv?=
 =?us-ascii?Q?RUikxJmvWEZ6P9UrRsqmdFPjaASju1QAgdUTtWu5tu1WtkWyMjSPuei2xDjK?=
 =?us-ascii?Q?Y8yoekonV4vCi29tQARqeYdXMmWJPNZJRXYH33/YwIIWS9+aSJCBGvR//Wfs?=
 =?us-ascii?Q?PQE/STWFEWzb+dUiZwTXFWG6QnylNSCFM4Hy4n2IPS5Efj5M6NF/BJrogHyy?=
 =?us-ascii?Q?u9ek99sQCIsh/U8KrJypslOX1c6JX09dym9o0+DqPXs7tpN3nTzHhYvnX81I?=
 =?us-ascii?Q?ntgaxwW39A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79170cf-843d-472a-8d8c-08da340b2097
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 11:32:42.3840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A35e2bKqrJ3ZN2l70TKREXdofRhxxAVhZr+DbNXI3RsEEhyLrSEsQdPb51mgGDkj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1925
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Vivek Kumar Gautam <Vivek.Gautam@arm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, May 12, 2022 at 03:07:09PM +0800, Zhangfei Gao wrote:
> > > I can't help feeling a little wary about removing this until IOMMUFD
> > > can actually offer a functional replacement - is it in the way of
> > > anything upcoming?
> >  From an upstream perspective if someone has a patched kernel to
> > complete the feature, then they can patch this part in as well, we
> > should not carry dead code like this in the kernel and in the uapi.
> > 
> > It is not directly in the way, but this needs to get done at some
> > point, I'd rather just get it out of the way.
> 
> We are using this interface for nested mode.

How are you using it? It doesn't do anything. Do you have out of tree
patches as well?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
