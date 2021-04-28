Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A7C43460
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 18:41:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452A661420
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 18:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452A661420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC7F4400E5;
	Wed, 28 Apr 2021 18:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1b9zpct9IL2d; Wed, 28 Apr 2021 18:41:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15577400A7;
	Wed, 28 Apr 2021 18:41:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFE73C000D;
	Wed, 28 Apr 2021 18:41:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A62BC0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 18:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DFA98438B
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 18:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lzsm5rglFAiW for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 18:41:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D377684348
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 18:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvI3kjB8WvK/3b+OGAwHn1l3D0Ykp9/JUZME6qGMNeHgdTNhAvyFQ1ySFbhRTAXHIInkggivwB3Mhae1ncFqoHd++DVTzbBAFQ1yxAVkqm/RdizvT1PWDBOMcUf7vzjqlqVKs64VABl/xFAV2No9xTtZfDUa5LxXpRsaowdLSqM6wBH2AfppXEE+ChmX66f8x6UQg/ceckxlUVzqtopfG50yU+MVNfAOK5ZUGuNxs6X4F0r81qtZQGJtixIP5ohuhpnjoPHu1VEMQWFhesy9AJZrB+Be2Ds3zo0A9Z/MtHv3og+IeKgxyoEdcS8mH2hL7bkGxA08ZkNQ+pb0pCIG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMfmm1azbuIlsXCXTeGTugB3LpP6zMt1PjDKaXST7PA=;
 b=Fm3gVWL3WyMaptnbZHFPE+NPuuQae0GDmX5a0Ce0kiMvCpslSnLSzNvK9lMfu1Uq7ZM9QoLkxr170fYNxcJS0/sKbkiV3of5lzGizm9c8mC1RjT+ieU1V5WVcGu+sJwRvrCworGp7g6osvV011n6e4n0I9Fose2Pr5VO7+1c/RvO95o8rDvLaRawZl4F6DQXJGB6i9PsTUDQuZXvKyEGeKfwfp1LS2IuQ2HXuq8/B52xwkK2raUKxEaP0Z2UtwWZg0hVHRJ8Ty5jLY0TpColLM3tzoF1s0RsT0aHpfxL7JNQZ+i0NUDi9KQsqkEE772fhMxJMVTdS9NYK7yzEqDEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMfmm1azbuIlsXCXTeGTugB3LpP6zMt1PjDKaXST7PA=;
 b=fMLBMOkBCvSgDFRgfCWPqAajG2U53d/nIUY6+cMmNLyrlDufyCB/TY07W6ymzNif6+wi7IylHN3zujuMF2gpAqdI9eILAmQroCQY3mRz37R0oHhymyy4JKNN5DFkyAmkwMg+95G+SGe2bZNV6oTdidK3sbagmyNWAwSK0s91q303Evnl7SRyBbvyGvCxBQtXJlRCMgJ7Nn75npWsst5eirZhlIxzGXiNGu466W1s7s+BFueb7165gvf42/gNnrPBwN86lEHrp56Cf4IBhJWgNivxH7Jmvtys+VGhuIzz606WstV8I/IO9oSp7+wQbNjSX8IFiM6S8dQO0/WK8/vo8w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 18:41:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 18:41:26 +0000
Date: Wed, 28 Apr 2021 15:41:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210428184123.GW1370958@nvidia.com>
References: <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <MWHPR11MB1886C9199AA3F00FF72ACB508C409@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886C9199AA3F00FF72ACB508C409@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:610:51::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25 via Frontend Transport; Wed, 28 Apr 2021 18:41:25 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lbp7k-00E5zm-07; Wed, 28 Apr 2021 15:41:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dea0b7b7-920e-4788-1a49-08d90a753a50
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2602A96402D13A2E34653919C2409@DM6PR12MB2602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmH32CcLjRO7nReGyhd4RyiSvA3UpDfz7sZClz7zqjDkNcOTzO5/PyZFggCEUK4WqzuMqmI+SR+65QWa+EUIgqb5tGa2gbWShL0oyYHkL14Z2aadRzfh7iNMG8U20T1dacoVDxJjd1dAZWjEeNMq3Su1Fri83NuiSu1F3aWA6aT1qEBO8t5U48Ue+8XDZJYBe5oPtbiLRXjr0062602i+2tn3sIymWGoAjacOAVFkOVpKimm8gpxNH1w7YeeH7lp68tbKy0Ju9GDmg55G9h1FHtOHa7W1Z0pGxTRafLoSO5Pe6eeKgpb5kZJHf7cED8XUOX+Z0EcWJeTH9CTv0lHxYwHWSjTpUzzpO8EnUilw+GGP5IEa1GSNDgYL8lnDXIFZKl72cFyGabbeE61MNa1I/RVFSC8ip7MbmIeZXKYFJ8DQvVlKzQw8ZBxFzOLf8HF5I5w5u/C40EaPFrpdb1hs6QeXSiv+qOXEXxb0WTmzU4KclbkXZNCGMMTLmSZUawiDBvgy24MqREnlh0D9ECACopg1IT3vie6NyKK2NnypId/vq7RGUuQ6ZhMoaCtq2+KVJ0SEGJ2qg1F3vGB9y7cLAC6WffowBAmgf94ogKNoAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(2906002)(316002)(7416002)(36756003)(9746002)(54906003)(186003)(6916009)(9786002)(2616005)(1076003)(33656002)(4326008)(426003)(8936002)(8676002)(5660300002)(478600001)(66556008)(86362001)(38100700002)(66476007)(83380400001)(66946007)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wYFR0UItFGTDOLMqbqqVVySTcwfGBHku3Nd82pjcCIEtl4bPHqQJcdWiYhw4?=
 =?us-ascii?Q?rv2gaPZtqmszAdzCg56Qu6rkRhvRQY0wqbXZxMFyInhfABat/tYR9+FNMDoK?=
 =?us-ascii?Q?5LhqWf9bsKQ/dPpcOKMSLi1ucR3YWNe3MgU0s9eT+C4iMmAvjVOq4WgkKnuH?=
 =?us-ascii?Q?7tyP/8dpK5x2/o2sFpbCl1IjVR42y+ybdpkZKfpNxXeg+x/tqHLK1d8mZ0SY?=
 =?us-ascii?Q?jv1zLfQ6xMbTN12P/og3mc6T0LSliqiBRMu3r8QyR+H/OnoajmuXU6QY+BZC?=
 =?us-ascii?Q?djrHo5+mjMEnAwOs9MuLzkYPTfT7ZZamjAQNU/vDUIOA4pekXpHtqC3Zx3RQ?=
 =?us-ascii?Q?wtie45qw4KtbRajD/xRrOahhdt/jBIyjEkE0BdtnxaRpC57DbU9eyuuwCYLL?=
 =?us-ascii?Q?0fc5f1MYAeT2/bkcphe3XX3jVSHeTpfW1TobDaxyrBYJAWd6G3rwRMOT74xr?=
 =?us-ascii?Q?IPqrUGBSfKeGk7VCiHAGkqc2WXr8GC+4QSi1+FUL3MYy+ML/Q93x6u1JbSK2?=
 =?us-ascii?Q?ZBTBu+FZSe9nz4Z+bcPFN4AyHQpB2BijprMoRpZ2/Xg2f7Ponm7V1EiNjFaJ?=
 =?us-ascii?Q?4cCtx+bUK/qVJzAOiesD8Sjw5Z3o7E6KXUT7QwOCZyA2jXr+JTu1XWjbjEu8?=
 =?us-ascii?Q?ahF1fuPQ6rhQf4AuECyTz+xTsoW9R/SfQOQbs2Bz2cbSDaF69BnxU+hb4AME?=
 =?us-ascii?Q?rOJvGcsqDNINEQO0X1sWYRy/pVzvlLzTNd3MKB5+HYFjnQhy6dJVv0Dqp5u9?=
 =?us-ascii?Q?oX4M169UzJwAFNGaGcoA9NjlHrHdogHsxB0RHNaPBl5I6pbpnFCVxumUbehn?=
 =?us-ascii?Q?En1oNOQjmD1EmIQ0mcEk8u0kwW5HRdRZn8t1N63/X33DtDOPRBVTv2kWh1F3?=
 =?us-ascii?Q?VWdFTrcsU1GqVrPeSCd97xs3lKM8gajEDG7e/dPwBfl+wj4eJ40lFyZEz0vH?=
 =?us-ascii?Q?sqJRXvKhJ9L+ZKispC0GBCs+V2BT4yrmPjriYMemt0nTT5QKfdSjxGPXnUmQ?=
 =?us-ascii?Q?BL0Fzbzlnmxj0Pj050IcQZuN+vO/Gcsd2p2tjx3BBSA6meUV+0vNVHKFCLqR?=
 =?us-ascii?Q?UTvQlDAN52rrLlLWPvsT9Pfjtw6jCbkrNfiNkhJbIPlVfLrHXFAM1xGcozzu?=
 =?us-ascii?Q?kxrXxGpTAvPMi+vTyyybPlHMV+bmDiJDIk87QgX/GL8Bm0riaTAHL/gCd9Ss?=
 =?us-ascii?Q?GtR7tGPw6U+zTBdeo31zQFKby3crTKQQOBdTah1/2k62ORUeQftSjim7k/Zs?=
 =?us-ascii?Q?nG92J4qYQCyi11W+RbuWE0lPUiF3FxVd7ojHbCoi0mHhRciE1He2fgspD/02?=
 =?us-ascii?Q?KRxTJYxEToH/FuLeEsZhIpqY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea0b7b7-920e-4788-1a49-08d90a753a50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 18:41:25.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f24ts17V4dFoRDA5xeY5lKYk9Z8qiHjqJb9JSIIW6nex7tcqy97V5MUpCXO8DxV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, "Wu, Hao" <hao.wu@intel.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 28, 2021 at 07:47:56AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 28, 2021 1:12 AM
> > 
> [...]
> > One option is VFIO can keep its group FD but nothing else will have
> > anthing like it. However I don't much like the idea that VFIO will
> > have a special and unique programming model to do that same things
> > other subsystem will do. That will make it harder for userspace to
> > implement.
> 
> Hi, Jason,
> 
> I have a question here. Based on discussions so far, it's clearly that the
> new ioasid uAPI will differ from existing VFIO uAPI a lot, e.g. ioasid-
> centric operations, no group fd, no incompatible domains, etc. Then 
> I wonder how we plan to support legacy VFIO applications in this 
> transition phase. 

I suspect the VFIO group fd will have to be registered with
/dev/ioasid in addition to each device if we are to retain the same
model.

> Earlier you ever mentioned the desire of directly replacing
> /dev/vfio/vfio with /dev/ioasid and having ioasid to present both
> VFIO and new uAPI. Doesn't it imply that we have to copy the VFIO
> container/group semantics into /dev/ioasid although it's a special
> programming model only for VFIO?

I gave that as a something to think about, if it doesn't work out then
it is just a bad idea to discard.

> Alternatively we could keep all the container/group legacy within VFIO
> and having /dev/ioasid support only the new uAPI semantics. In this case
> VFIO will include a shim iommu backend to connect its legacy uAPI into 
> drivers/ioasid backend functions for backward compatibility. Then VFIO
> will also support a new model which only uses its device uAPI to bind
> to new ioasid fd w/o using any legacy container/group/iommu uAPI.
> Does this sound a plan? 

It may be where we end up.. Though I fear it will make it overly
complex inside VFIO to access the new stuff. It would be very nice if
we could see a path where VFIO insides could only deal with the
in-kernel ioasid handles, whatever they are.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
