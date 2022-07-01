Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185A1C43334
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 19:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80C554188B;
	Fri,  1 Jul 2022 19:08:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80C554188B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qzqIZeYd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTPuyiD8FNYd; Fri,  1 Jul 2022 19:08:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8F9741880;
	Fri,  1 Jul 2022 19:08:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8F9741880
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E039C0032;
	Fri,  1 Jul 2022 19:08:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99718C002D;
 Fri,  1 Jul 2022 19:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B11760BEC;
 Fri,  1 Jul 2022 19:08:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B11760BEC
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=qzqIZeYd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7oXSxjwATVj; Fri,  1 Jul 2022 19:08:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BE0B60B8B
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BE0B60B8B;
 Fri,  1 Jul 2022 19:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2yBwbVHhlwqWMr+rcJih38kR2f0WcmuhDG0qEHZhtZ0K50xtf17Gym5YjNWk85gSZuAOsQvojhFEyfEXL0XPeA9LbWW1UBB44pkAjoP7bXutp/15NbZBA8eQG5Lz6Yf/3fVDIZK1MwZgAflZbk02juezDV2oJVY8lUjGCQemccQxvqPAmZKO/2yCpqutsbwUbzebbAtfI4u6GmSgm+GTWh5sLLM9gFj6d9nNFIzDvEaqyusfZKvYxCvcFh7x9TIDtzIH+0p+C8LPQHdNjetQu3csl12FDOPvlQLfiervYn66W2OrtQVGY+UfUcK4BsUmz2vssrt2JjDwgxONc26Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgBBg6RFOOt4nf3b+D6oUcpI2maX3OP0rTgHRFsoUH4=;
 b=VR4F3ijcYmdoFvMsyDY2UaSLno2lEYhjxnYbmiEordlyUV8DzaekrHSXNzm0G2MQ/NVsPB8jnaGA8O20jaE4Nnep+F8uMcxNc3cSLz670nAjgZu6FpivW5+KzY61zUEYpyHWq99yPyLbzaLfGuejw4HTKNexrXIviGfOkuQRlKit/XL6d2loRRkGZebj/XkZIFXb6hxKyc42uWADCh1+r/iZY13gL7zjNA7Jp7yT0Nh2HAsjVDtsWQA8I2Oqdt86ExRBVrpemhxM6laDofOVEzlDC+bcgWxm4+qjoe5E7OlG98JVUJncGsiA0kJ5IEBKEkLnLBXPSk1EqvmEBWSmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgBBg6RFOOt4nf3b+D6oUcpI2maX3OP0rTgHRFsoUH4=;
 b=qzqIZeYdIapE3Dpa9LTsO93rbewoTVN6+UbAlesOcJz4nOGJZ6Av58V+cK/1O67mxQlMR9XlzbttqDA88QnehrRHfVF2WnXuYTbaKA0QCgFWNJFSjPs5b0XyzvJ5YryWX9kyXoVA0s47i5tyRA+5g3uaseRd8pgicFqobHC6EhUhcatWvDExZ6oTabfa0z+C9h3lzbQ92Hdm+IgmEGG8hqgiL+TD9pU/Cur7b3kciUmFXmzbqIMO3hsxVcjhjps/GyFh9cCFiDBKV2Vr1UCzXvVOKlTj09WRdwejvrIGp+uGfKHekEsB8/YXFcca351lk1+Y2WfiGNaHbCLw1Z0bSw==
Received: from MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 1 Jul
 2022 19:08:42 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::cd) by MW4PR03CA0162.outlook.office365.com
 (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 19:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 19:08:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Fri, 1 Jul 2022 19:08:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 1 Jul 2022
 12:08:41 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26 via Frontend
 Transport; Fri, 1 Jul 2022 12:08:39 -0700
Date: Fri, 1 Jul 2022 12:08:37 -0700
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
Message-ID: <Yr9GNTTBTP1i3QSB@Asurada-Nvidia>
References: <20220630203635.33200-1-nicolinc@nvidia.com>
 <20220630203635.33200-2-nicolinc@nvidia.com>
 <fab41f28-8f48-9f40-09c8-fd5f0714a9e0@arm.com>
 <Yr8kHnK7xRx2DZus@Asurada-Nvidia>
 <2ccb6033-4c34-ff59-50a8-549c924d269d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ccb6033-4c34-ff59-50a8-549c924d269d@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01b6b436-906b-4382-a2f9-08da5b951d31
X-MS-TrafficTypeDiagnostic: MW3PR12MB4441:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDIoIxZhp5YRuL48maMGFt4CYVHCtduSmcEu8nLmCDDzpzANUjJ0WqxDKpVVgKlZcgS4HBnpZDqHQDahEPcEaoVWC5OlTEn3/vJzcFyN4ub1x/YDKwsfQO5MoNK/U4UHCVGzkLSVlwf3CFc2BgR3WZZOjOO3dUiMCuMVFuJGnQRhP4sVRrcSCX0tSjd5MSKo/y+rRVfWc8L6f/3KUislQsvKt2SubJSoOVujAi5DVxghgyiZNjzoyzmCkWdWaTa5w+db/7rz6owpgQh9qFZThbjmQEND9JNcUGchk3a+xqrNaPIWJlF8pYlUs+MOqN7XY1G64AKCRze8QDDTF0l1dAh0TKG7l6H20DtXvXIzjH9RgP3O7NgDEXqvvfx8Eb7xzRBvrNO2V6VnsDg9Z/kxX6JsykfYfNqqyakqAaB02F4g1yGhnp/1sIK2FVbF3LQhCUo2gjnYy2coRGKNXWIQ9kXS6LUBgp+ZT0AkM1/1+HufLgCl4aW8bL5EC2yVpMCLNcrOhOwqkpF6BQLOPdmXDswbsOAZ8hbnp0H1KLKZIFtlMju1ZHWGrvTk+AaZQCUURzJ8zawUMe52fFOjag2InZRsqgWLTjK8nQJjr5Nb8ETuuij6MwbjFP8LbKQlSweUHpo9yI/pwv/tR0dRZ67L+ZozAFe/D8NlplJXMy2A3vMPHA/7dtQV0uffcU6/dLVnqRN0/D7TBDHbKn6S885cTt9rXSynws6nrSTEQ48JrzQkfE5ihX+AfSAW3wQWcrVE+gd1BJNYGqaxcIDQqdSu+4XO3ZNonBDkxO6xRrmGxcAzZwsqP8QxaJLRvafyjJmjaHfx/VWFDsVaSldFKj5yCACZ9Q+3RJMcdoGe1NzfPrI=
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(36840700001)(46966006)(36860700001)(2906002)(41300700001)(7416002)(7406005)(4326008)(33716001)(8676002)(6916009)(40480700001)(40460700003)(54906003)(316002)(70206006)(55016003)(86362001)(70586007)(82310400005)(478600001)(47076005)(81166007)(5660300002)(426003)(82740400003)(356005)(53546011)(186003)(336012)(8936002)(26005)(9686003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 19:08:42.3768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b6b436-906b-4382-a2f9-08da5b951d31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
Cc: marcan@marcan.st, linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 will@kernel.org, alyssa@rosenzweig.io, jean-philippe@linaro.org,
 kvm@vger.kernel.org, zhang.lyra@gmail.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, iommu@lists.linux.dev, jgg@nvidia.com,
 yangyingliang@huawei.com, orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com,
 kevin.tian@intel.com, linux-arm-msm@vger.kernel.org,
 alex.williamson@redhat.com, christophe.jaillet@wanadoo.fr,
 linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 cohuck@redhat.com, baolin.wang7@gmail.com, dwmw2@infradead.org
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jul 01, 2022 at 07:17:38PM +0100, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 01/07/2022 5:43 pm, Nicolin Chen wrote:
> > On Fri, Jul 01, 2022 at 11:21:48AM +0100, Robin Murphy wrote:
> > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > index 2ed3594f384e..072cac5ab5a4 100644
> > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > @@ -1135,10 +1135,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > > >        struct arm_smmu_device *smmu;
> > > >        int ret;
> > > > 
> > > > -     if (!fwspec || fwspec->ops != &arm_smmu_ops) {
> > > > -             dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
> > > > -             return -ENXIO;
> > > > -     }
> > > > +     if (!fwspec || fwspec->ops != &arm_smmu_ops)
> > > > +             return -EMEDIUMTYPE;
> > > 
> > > This is the wrong check, you want the "if (smmu_domain->smmu != smmu)"
> > > condition further down. If this one fails it's effectively because the
> > > device doesn't have an IOMMU at all, and similar to patch #3 it will be
> > 
> > Thanks for the review! I will fix that. The "on the same bus" is
> > quite eye-catching.
> > 
> > > removed once the core code takes over properly (I even have both those
> > > patches written now!)
> > 
> > Actually in my v1 the proposal for ops check returned -EMEDIUMTYPE
> > also upon an ops mismatch, treating that too as an incompatibility.
> > Do you mean that we should have fine-grained it further?
> 
> On second look, I think this particular check was already entirely
> redundant by the time I made the fwspec conversion to it, oh well. Since
> it remains harmless for the time being, let's just ignore it entirely
> until we can confidently say goodbye to the whole lot[1].

That looks cleaner!

> I don't think there's any need to differentiate an instance mismatch
> from a driver mismatch, once the latter becomes realistically possible,
> mostly due to iommu_domain_alloc() also having to become device-aware to
> know which driver to allocate from. Thus as far as a user is concerned,
> if attaching a device to an existing domain fails with -EMEDIUMTYPE,
> allocating a new domain using the given device, and attaching to that,
> can be expected to succeed, regardless of why the original attempt was
> rejected. In fact even in the theoretical different-driver-per-bus model
> the same principle still holds up.

I see. Thanks for the explanation. 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
