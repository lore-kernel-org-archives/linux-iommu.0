Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA0C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 13:38:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86981611CE
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 13:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86981611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56B0E8338B;
	Mon, 14 Jun 2021 13:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hVOepBjRVWET; Mon, 14 Jun 2021 13:38:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 52CC98300C;
	Mon, 14 Jun 2021 13:38:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFDEC000D;
	Mon, 14 Jun 2021 13:38:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A100C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC98640155
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0Gw7b4Fsf5c for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 13:38:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1A7840131
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 13:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZVsSv8e6cJzriqljjd5jvWXTVoueL9bDNXhOkJj+X0waFq2WmQsq1uJutx95hHwgy37zV4tDAtB6M0W1r24LbTkZvyfZDmXjOuWaLF60BSeKlDVXo4TQK46MsgROnX7z08dbqHCSRsbnfrXGXQCctwD4U+PmcVlEZ7s2zE4hIcllkTBSxr4rYD5kYDsDSy1ntC8dPUzfGLp1E0qKiBraABCSUZpR4Se/PzSj/SeluWnyhkfTVtgqD47BPu17/UaQBMHuSWT/cr6ffip7p3kKSxj9phQ9Z/7xpRzAJT8NApzqTBnQOskDL0gN//QTRnh7qgzrk0alUmGs96IR18IKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikqX3Z5SQdfU/Cq9/yU42ZzpmojnYj484coD6T6xhlU=;
 b=b285oBbDtldW7p0TNeNuPBKvezmFKft7hIQhwDltj4djGiz7mVm05n8S5ZBEwAN22A19d9yNwZ0/emJz81BLUcQChys4w1Oxa/uQNE9sJVj4Etnhtk6lQyL6tZbM867OA+0FZlo1DYMLvL/QCHYYJop5aDW8cab3C+0++TqMI4HL4aiCtiqUuliQsHpA0thU60IB3kky5YMcKhJgrMIitL5oeevbQRgvZakse/upjZmZyY0ksTEhE7biQN0k8t4HQwTrcDifPMsyGhayVTZyTpuS9/FFBrb+ZGWH/wGKuy3zV+q630AdbPn35qSdvE8Nny3E7lcbJy6+/b7+R/qPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikqX3Z5SQdfU/Cq9/yU42ZzpmojnYj484coD6T6xhlU=;
 b=nOkKMZKjpbaUGAEXpyMLX7PTRnm3mMrfGqMOXR4uqqOoMH52mBoFRmOVfLuu53JMDG/+cGyOJhRWJyh48xCNSlq8XNVifMq2tRMKDg/kaq3YKtIGtFUMvW+jh7tzBgk8WYo/A2sOzd6IeABVrluSiMKxb6sn+kt8uNZ0RvypUFCVb9bMDRdldHLFOfS8ist7STV3s0MFnlmlTMCBd6ffV5VR6mN3UVtjOqo9hryp5LobjLV5QqiLUaOXtvjlDZzC/Wv9WfvrO4w0KJ+OYbcNy1vq6nsCUq5Yd24eEqvIpjB/Ty3KgKYj7iUoos+rCABBm5p4TCOIP7Zutmu2MkdgZg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 13:38:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 13:38:20 +0000
Date: Mon, 14 Jun 2021 10:38:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210614133819.GH1002214@nvidia.com>
References: <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <20210609102722.5abf62e1.alex.williamson@redhat.com>
 <20210609184940.GH1002214@nvidia.com>
 <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
 <BN6PR11MB187579A2F88C77ED2131CEF08C349@BN6PR11MB1875.namprd11.prod.outlook.com>
 <20210611153850.7c402f0b.alex.williamson@redhat.com>
 <MWHPR11MB1886C2A0A8AA3000EBD5F8E18C319@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886C2A0A8AA3000EBD5F8E18C319@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:208:15e::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR17CA0014.namprd17.prod.outlook.com (2603:10b6:208:15e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Mon, 14 Jun 2021 13:38:20 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lsmnD-006dAj-B8; Mon, 14 Jun 2021 10:38:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52b3c7ee-65af-48d6-db5b-08d92f39ac6d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53639AD14217913689CE80D1C2319@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMaZdPTUVOIob8vWcGdTqQn6ZphBqjJEcW5A3w6laZis+ykmG2p+TMCsKKwg9N6QTPU/fQ6q9ihIPACnUhXxU7db59CtTJMS5Mzx0j4UcZN/pzFfhihI69ooGsB8UkVCEkU8XjaogHg74JfSGWHwjQL6FHpC6YIC92xwMx0yMEHx+Vpab5csSSthzQvLaF0DH2bWRQOKCrcvmC8T9YaDt60vGIwHe7IdigcaYReXn6hKAKgwk0zxMLoHZk+zOnMSFpXlsRxNEGthbhWjE5ttenaewyKvdlX/b7qPNuon/9tfOJVwWmBW4vp3Vsw08/LoX3da21pecJw+IQnnxx87YRZRboJmhz0ObOht3aHvs40I2EEaOZirnhaJjX0dQqHLQnhr48OVGP/L7SuWIwA2Dz58gLpNdVlPgKCAMS2cTSnpGuu7kEJNiJMshoeDale2uv/1MyQtldOVescrnP6cqAHnwmujpsZD9yVWTpjnO37EzxSK8l2wbMdq3qcpJJQs4Q/bLn1/zMMGnFj9h49Tk2Bu8V9duNfSx5h0cz0MgGOLDgHRnSpPouzRLsPExhR6bmdxAwbAR9hXuBOMXYgn3UiNWaJS0Tde3m4ziJLlUas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(26005)(54906003)(8676002)(36756003)(186003)(478600001)(33656002)(86362001)(66556008)(66476007)(316002)(66946007)(5660300002)(38100700002)(83380400001)(1076003)(2616005)(2906002)(6916009)(8936002)(9786002)(9746002)(7416002)(4326008)(426003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0PtKz+QWHiHKdXJJop1VVbwe5XwYmbViXYpkZyDfZL5odvbPtKo64+opuM/?=
 =?us-ascii?Q?yPojGgcWz1QkCNBggNOHCzuGLABEhjQSETX72N8v0Wysu8Ym0Oie73m8HXxZ?=
 =?us-ascii?Q?O+YLprEs+nBWdAmYOPf/7idI7PwxNrwLmn/vcM5YdV7gRzyfKxEGHNu+OPvp?=
 =?us-ascii?Q?ybORW7HFd83wXKSMZHYSATwLrVjO72SOWnj3zldBgFP29ASp5QS4s7sh1uUS?=
 =?us-ascii?Q?GnygjxtaJzYezq9hM2Hkj/RQMST5IlV313Z8uBn62mmGfk0hQBbg6ywXwKcU?=
 =?us-ascii?Q?WN6fk/kQhB5ILPxgWsw069pk+uwYVkOxs0mzNKQ1N33s4opBC7nAvU2xXkPw?=
 =?us-ascii?Q?GAbozYVkqEdCl1N/QzRnxr6VrRwPxTPdaFp7S/eUVoDWqoNU1z9AQMatTuGC?=
 =?us-ascii?Q?ERrk7DORW7ldHGI/dRr2qaRdlXPIGpk9ICJnxg6GDXhlsjkjEkm5SBUD5E2d?=
 =?us-ascii?Q?Nhle2SbDbuS0LN/u8rzYAdzFBGUuPuzfFCRH3QXeDVyRcB/a18K+u/NU1FtA?=
 =?us-ascii?Q?u0a3FvxnUnrNXCOVDPc6bmKXVCY0wuqc0MR0KFCbPrbIrvSJsp/l0VXMhGVd?=
 =?us-ascii?Q?Nit4RLAjULMnSz84YZfaUyv2vWqX3dQNpQ8Wkg98n+6cFB/rQuS9Zp4IGl9v?=
 =?us-ascii?Q?it1zZAOENMDw5xQyOaJwYEhPHM5Yo57V+szbE2eFp06GTQLddKhpps0AhTIg?=
 =?us-ascii?Q?URohmMbsNGYNcjsDCAN4AEhlrmHQLcoWZyKnrlO0svdYg+tNFC+tT3mxpRA8?=
 =?us-ascii?Q?jmVb8q7oB2e6q7rRTw1SUrb/PfeonPpKaINw4/0qEEkwKqezUhGj+mSToBgj?=
 =?us-ascii?Q?nyUz4FDcMJJnrlEBaG9dEKUVrPMZuJLusJ3bJoDIWb8BTSA4CHn6ZO2Q/FI4?=
 =?us-ascii?Q?GzDkxJ/RAeBbiIdkaLZrliz4/NJzN+9kKHTDGssHwED2fed7sbxuqZbVRm8j?=
 =?us-ascii?Q?dWIZkmcs42W18q8RlWog+pJP7Kl1cPop1ZSqqABZqrFllkLbYvMyjPtJC87a?=
 =?us-ascii?Q?aozokeEaHoxwIwsYE0jcshT43DYzSFTu5OZu+1e0CNM91UB0qbH84kqqLLHa?=
 =?us-ascii?Q?RpHGF7gVchoSvGTw7KIjbjz5XwpiKLuu9ZStlah2XcaVF/1KI4Dm550Pqgff?=
 =?us-ascii?Q?bNXDxml6TTVDkDO3X8XrC6Y5FSG47ane0nw0eCqAljl0f0HbSgWDuM7mwBTd?=
 =?us-ascii?Q?9hETefPx9StVOUFNprfu2gHIYArlZ3q5DAEh/EuZ06az24q1GAYexKAS6GxU?=
 =?us-ascii?Q?Jt0xIED7PdafcGaVLsKuWa+pDBa5j/XxUru7qDpcGsTJvP/UFo1PN3Y++xvX?=
 =?us-ascii?Q?ts6xTKrdGrDAkoFJ2IKrSnjW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b3c7ee-65af-48d6-db5b-08d92f39ac6d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 13:38:20.4686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFa5PTwD028a8anGZAo350/4tw8RIR/uJe94UgDeBRQiqgyBP/sxVIWOMwP1QPtp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Mon, Jun 14, 2021 at 03:09:31AM +0000, Tian, Kevin wrote:

> If a device can be always blocked from accessing memory in the IOMMU
> before it's bound to a driver or more specifically before the driver
> moves it to a new security context, then there is no need for VFIO
> to track whether IOASIDfd has taken over ownership of the DMA
> context for all devices within a group.

I've been assuming we'd do something like this, where when a device is
first turned into a VFIO it tells the IOMMU layer that this device
should be DMA blocked unless an IOASID is attached to
it. Disconnecting an IOASID returns it to blocked.

> If this works I didn't see the need for vfio to keep the sequence. 
> VFIO still keeps group fd to claim ownership of all devices in a 
> group.

As Alex says you still have to deal with the problem that device A in
a group can gain control of device B in the same group.

This means device A and B can not be used from to two different
security contexts.

If the /dev/iommu FD is the security context then the tracking is
needed there.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
