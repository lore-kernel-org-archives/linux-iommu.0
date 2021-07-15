Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F4BC636C9
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 18:13:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CD0613C9
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 18:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CD0613C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E04660BEA;
	Thu, 15 Jul 2021 18:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bNUwrkTqn1CW; Thu, 15 Jul 2021 18:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2FBB96065C;
	Thu, 15 Jul 2021 18:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1202C001A;
	Thu, 15 Jul 2021 18:13:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6AC8C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 18:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE6C283DFE
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 18:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id of_bTtCz376H for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 18:13:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::612])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA8A783DFD
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 18:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKf6eIeclAlBSGxO/HGvrUELhPzMdMB9ruLh8HlFabhQRW9sYg9Q3Vb7SEclLGYHshE/P+RwE48+TwI5LmzfqMTj1UYZ9SST2IZ/e5WOtvTr4RtRFRzYAs6xgQzVL53pFgLZ9elPLA+YofXPuc7xJwZx3TOEop+Vpx2OdETT9mn3Yuc1qmBLQ6qD42lfbCwn92VdMiI5wirwquuyaWqYU8MH6WUfpblzYowh8V1e/45iVlUFAJI7cgxpbg2E23i4/nmImG8pA7uo5EFTD91+PA6xhXR4KCESPQ3Cl5I9DgiucuXp/6IO908u354GIAp+aXPBTLCE6nOBFvkaOfBCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Fss30v/npeMSeksjz0XmuNun66xV/xsfbGNjFdmmc=;
 b=JrJKMWh6483DjwYkWGY7tHen4jFbUchfGR/tLJYAkegWqESRmrdAbqUoD80ugZ70liKNnTnrb+aCIpTgptstOpFdW0xMpy6clClIYOVC0ZHzIcMCUijiK2vno6mOSqhofeK+Wb+57LbBTeofQw196J66wiVU4pSzvlGSHSmAvZYbv8uMGXlEHGBRT2pkuAXfRXxfvPhkd5tF0OsVWGvKc0CkF6188xvTTRMXSt0eIidqUC4dGouOQ4xvXjR4vxk/+6RtuBSWHJFCryEuviYPl1T0VRO98zblUj/HU0t+Jltkqd9mvbhb90rIYRWbNMQEkWhQBbW9uvrPve362uKepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Fss30v/npeMSeksjz0XmuNun66xV/xsfbGNjFdmmc=;
 b=GYYBC1K3wDEXw5QPJQidXFKg/n1sKvlJ8FwPSncHBsYQTvYqQsO/FnCd87epswYByvNWcuew02NfpmxStu6uQQb6vMjsXvywekBsV9pa8pVbjJ6qlcV9cAR1TEb/27NVVCGBNnZFo2U9OPcXVbmgRlawb++JlkZ/LBZ1H3SA3lzw6GDgmUKouoIeWAvA+63D8t0RCr8FkUP8wY8Uo65bRtAjD+sSz2dSdToDm/HTaBHZuOu4myJcrMa+Pq+MaUBqmF+yKX1v5cIpRXFuctiiNvQRkmscW/CAaiCOMpyLGF4riAsytSnBt0hqt9iA7SwLZ3i5byv61t/0x2jzuvSnHw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 18:13:29 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 18:13:29 +0000
Date: Thu, 15 Jul 2021 15:13:27 -0300
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210715181327.GI543781@nvidia.com>
References: <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
 <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210715124813.GC543781@nvidia.com>
 <20210715135757.GC590891@otc-nc-03>
 <20210715152325.GF543781@nvidia.com>
 <20210715162141.GA593686@otc-nc-03>
 <20210715171826.GG543781@nvidia.com>
 <20210715174836.GB593686@otc-nc-03>
 <20210715175336.GH543781@nvidia.com>
 <20210715180545.GD593686@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20210715180545.GD593686@otc-nc-03>
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 18:13:29 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1m45rT-002nuv-HA; Thu, 15 Jul 2021 15:13:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73363514-9a49-4dcb-dc9e-08d947bc3f7b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB510957A4D704CFE1C7A2E989C2129@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTI6+yOy8CwPL9FIyz3m5L+Jb1n9TZF0sAqd6EKYwkBZBVeBJ9ce0ZCxfCrp4puDS6mKEWvWQNJdLeb2xzX5X7INs2Wghsr8ItA9XbpcYEz66LJbRJhCrHHtm9SzN25Dz0tjSib704GY4b2wRX/0WE+jKDXqBryD2hyoNu+/dj0VN3WCeeI+WtOP62zCC6ALlK0H9oe31lg7saChkGyxbPMNqPUdGMep5tqgQ6TqltGgjlDXHEqZIeQqq8DwS68vLzbLJsPkBW6SHjnLsS2+IGrD0y4n20gg7EQjgQoF/4m7Lr3o31KKX1UxoHochOQdeN7F1v8lZuXcUSXEFjFx89R6nYGSxVvcbB6Kk0ooLpyqR74ujOl9pFNhZyPlKZHGc4/hF0953Mc37ibj0o8qaFVRg35cN9Ptwa92KWMVlicfSlRg6VB8AYU1TedtshFLQyF5RHMSPebS79dIzCv/dqMj95JUeH5b+ZkvJBfcgs0k8fLkzrMBeYd/kkF3cGf9ouznFvMPMvyG/pDeX0epMTWiiOl3lFSSrNCC2Jo3eOiDkSVdgLlzjKBtJ7X4wqy3p7yIM57YWxdZAdF5uq1eIQt2hLS0f4CTnniaylB7Ud+f4InSEFhSSEsvFkbjeMgpC1Ai8zkQ8qTnP5qMAUAxv43bbA27coTXqQmg7JvZODFPmTvjrqk/SiCSJ8M38xdkdRMeiCiRX1N5aBk+oYwtUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(316002)(54906003)(5660300002)(66946007)(36756003)(86362001)(186003)(26005)(66556008)(66476007)(7416002)(6916009)(2906002)(83380400001)(9786002)(9746002)(2616005)(426003)(4326008)(1076003)(478600001)(38100700002)(33656002)(8936002)(8676002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lnyMYl08/lsfbQBTypodhvP3lpZ2kBkTFUdWh2uvIMscK+g+TEa2HAnM7VPY?=
 =?us-ascii?Q?QaTJ/oTmxJd5taHJs+idjOyVPYdP+B0dX4ITSDbhyqSoHE36J8821IBsBe00?=
 =?us-ascii?Q?IsCX0NY/7Y7Ji083vRHEvTgP2cttJ+OfCK/oAgLeqspwzcd124HhHuafGgR7?=
 =?us-ascii?Q?GyLcA54bogMPfQQoCxTf5yJwGgPyl+UTJTlBumCDgYtAFqZK7siCHahURONe?=
 =?us-ascii?Q?HHzlbUDUrOT8K/HK0TA+ShF5cb+UcNQXQyFyF5vr8/A07YkJmGMnk007VjmV?=
 =?us-ascii?Q?Ahfqrg32GH0a6KqXE6PMb1CRyLH2oBqPwRIo7bcplE07SqD5zRnSwU9hlJ/A?=
 =?us-ascii?Q?Zg0q4tvsaIJ/hAse4RwIObpNTNW+ckmh6xfvbGonMyopFsDwS1+CE9QlHW57?=
 =?us-ascii?Q?XmCFspzXoXFhOkBKMfLVkFWs5W2HSDGrQAT9bNuy87H4u0+b6iu/PT6bhbHh?=
 =?us-ascii?Q?dc5fZVvQfRvkU59IaiZTOYCVuFBNxMUZM322CorcV8/B11WuEL/V/5kNVVBv?=
 =?us-ascii?Q?81X3saxEj1I1Z85N7olqbAAN1f02oQTOOTXAFsIiPiZ/JnCL3O4VNGhoN3/n?=
 =?us-ascii?Q?I//K6pmK5IkWLyb9P6zUql7LwX8bxEsyNO/PRdUBHs55BWKB6I+LyIutQvhj?=
 =?us-ascii?Q?JUHWg6Asveul+OEKFKsSt+CGfqLDl4z5yrgWCE6VPl6PpqBW0EgQSvFCpJiJ?=
 =?us-ascii?Q?h2uN802qreC9L/hdhF0DOXCYP/ztx+/E7NqxSSso2IOwtXd0e7H6AGqJs5Ep?=
 =?us-ascii?Q?xKy6LrW7/3CbBneA97UnjD1gjFXuvArZZvR6bEBtJCXp70njJluFzkZeJKM6?=
 =?us-ascii?Q?wu8lanpjTWN8Bmq1m2Bk7vkg0YU52FFpCfJCTOQm2MjVj5ZovgShpKYB4GlP?=
 =?us-ascii?Q?fk0ZvrJft4IWntSiBdO4JKG1onM2H7FFeo0j1Bz9wukbpXswPgzGkJHef9ui?=
 =?us-ascii?Q?d4dnhVkeYzFfyTKxoY9MSIYCfdTiObw8m3AazLtBSmq494XwvG0zsaNPoZVK?=
 =?us-ascii?Q?t5mVwIvC983vuzQAFaPgQrO788b4DXw9466YuxZFl7u2sra465eyWEFkUH0j?=
 =?us-ascii?Q?NbpAAqEHGwuc9E6bFT/kREa0S+uzfMgA4awbjb/cq4qNsAxYInvPz8JPJOaJ?=
 =?us-ascii?Q?Uy3iq0z5h5AYGGKYwzPpUH7vWygh18fAcJuOSnWiJ2vgRogL5lwHAr4kE50E?=
 =?us-ascii?Q?JFJqVrY7CCysQpvZK4o0oryoJlvWTkYc49DKJaT/OGttpn8PUyczw1QsiA2g?=
 =?us-ascii?Q?f1NTVl9JX/Z+pGQ5CmMV7KpGeB5zgzhhzVVpAe/IUgF9IXMHl4IzzZoG2Sje?=
 =?us-ascii?Q?xKx7xrZFGkqe6AiSgci/dVaA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73363514-9a49-4dcb-dc9e-08d947bc3f7b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:13:29.5854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YG72ubzAnB3KNq2Ep+BtBuyJz2AS4UpzFg3rlqATRYhn2e92l6Rh5N+sW7WSjXtm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jul 15, 2021 at 11:05:45AM -0700, Raj, Ashok wrote:
> On Thu, Jul 15, 2021 at 02:53:36PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 15, 2021 at 10:48:36AM -0700, Raj, Ashok wrote:
> > 
> > > > > Do we have any isolation requirements here? its the same process. So if the
> > > > > page-request it sent to guest and even if you report it for mdev1, after
> > > > > the PRQ is resolved by guest, the request from mdev2 from the same guest
> > > > > should simply work?
> > > > 
> > > > I think we already talked about this and said it should not be done.
> > > 
> > > I get the should not be done, I'm wondering where should that be
> > > implemented?
> > 
> > The iommu layer cannot have ambiguity. Every RID or RID,PASID slot
> > must have only one device attached to it. Attempting to connect two
> > devices to the same slot fails on the iommu layer.
> 
> I guess we are talking about two different things. I was referring to SVM
> side of things. Maybe you are referring to the mdev.

I'm talking about in the hypervisor.

As I've said already, the vIOMMU interface is the problem here. The
guest VM should be able to know that it cannot use PASID 1 with two
devices, like the hypervisor knows. At the very least it should be
able to know that the PASID binding has failed and relay that failure
back to the process.

Ideally the guest would know it should allocate another PASID for
these cases.

But yes, if mdevs are going to be modeled with RIDs in the guest then
with the current vIOMMU we cannot cause a single hypervisor RID to
show up as two RIDs in the guest without breaking the vIOMMU model.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
