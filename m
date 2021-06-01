Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD26EC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:31:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626CC610C9
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626CC610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26B5160715;
	Tue,  1 Jun 2021 17:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XyFyp0UNQN2R; Tue,  1 Jun 2021 17:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12387605D2;
	Tue,  1 Jun 2021 17:31:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F242CC000E;
	Tue,  1 Jun 2021 17:31:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C926FC000E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C32DE40426
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4NkOkUw2JwJ for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 17:31:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E2C140417
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blYjGaMy/zGoRHeHzAu1+4zeIkCvPoKg1u87ET/5QyWJPeUvScoJ8yZNUlzBAUmzMBpxKm/+6R5K6gO0aMHIo196kKnrXt7Pn7Xu4tj6s63BCy+IWuNgGN2Ww6qR5UtpOCJyfPIO5AypxhTTU5euvgCbbR83iIUmmrpyGX8G1I25zircySWYaFcoh4mnhiJfVu/2xFB7fFnr5K0i6VTccnBy2zrcvN3FWGTa2xoexsfGAuxamMkxhvjwMZpJ+FA9D+Q8vwyRrfiIPULrKclJWp1MHs6Z2ez1ElLMu/2zg4DEC8IrwBifJZDCfmzvIBUjrrCMSKKRz5E33EeGz6GwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy1oe2l3Y2XjCXwn6pumv+dZF2QffiVM7W2SZi03a94=;
 b=DeucmTtk7CGczyhDojsEv8hrefWnTP0P4mOkJUGnbDtDi9HufeGaHkYUOui58BzRM9U+fVi5skWLtaY8gDJExV9gezeaDe1Nyd24uwdd1WO5HGcHmyqlGlIXdmN9Yi4mz7FX7a1DE7DzrwGXpxvYNJUvYT+6rlOs4bc2e+/+Sw9vQngSzdQf5LuscCT5DS2eLCYkrqY+TqDjdty03Vl7D3aw+aitAOJCfXd+1yHQ94EunVzSV74wD8vbvpdB4sjGXpd8LjvCJnjm6KRD4K1AmJTZoo030unAaIVA14+U/1ZuNplvTrliLACGZBkgr/OjszBqerxCVWu7gbEw22B4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy1oe2l3Y2XjCXwn6pumv+dZF2QffiVM7W2SZi03a94=;
 b=tiXQrVHI2KryxJ+PZPbRWRmT+oySq615QZjBFiLwe4JoQ81/cJOujNxiwCrJAht2dyDPrjxM3mNJxI6v3zlsX9VI3t91I2Vgwu17bCQQEuuzh6wr2L2IdKCMpLSjQC2Yrf90bV9ue4U2HA5+q1ZKqWSDyjsVS6YeRYhKA7j7h0c3uEXbgOqKtr9q7oLhiqJvWe9kttye0erCBQiUXF85bAV4ZzuX/l+lkJtzaWSWTcftwuhvrbuPL0msl4jctyg520NUK1wPMENg4AaIVyF6dzpQp24X4VzeR38rwDqadOA5ZXFePgxbxi4BEURUxzyNUT9U/kHRPGtbrDldcKp2Rg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 17:31:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:31:39 +0000
Date: Tue, 1 Jun 2021 14:31:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210601173138.GM1002214@nvidia.com>
References: <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
 <MWHPR11MB1886269E2B3DE471F1A9A7618C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
Content-Disposition: inline
In-Reply-To: <42a71462-1abc-0404-156c-60a7ee1ad333@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR12CA0036.namprd12.prod.outlook.com
 (2603:10b6:208:a8::49) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR12CA0036.namprd12.prod.outlook.com (2603:10b6:208:a8::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21 via Frontend Transport; Tue, 1 Jun 2021 17:31:38 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lo8Es-00HXdX-7E; Tue, 01 Jun 2021 14:31:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a748361f-51c6-4edf-572e-08d925231ceb
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5505E101606DE6C29558E1F2C23E9@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyJSzaZXAtBep4NtQ7jpsJp32YEd7lqQffZoKgTTcLRkVKRh7aJjUswScxrqfsD28ZPw0WY6CY1M4p8UnLiN7ryPQfg0WTdTP49qm5YLZnngfmYcwETQxVaKeVL1iQQugXyYazfnyM2IXMZOSMMZ7UULlnULkEOemOLPHY1sFRTNc9nrAul5KECz0PmvLoch9xiGsFc/iFMnBQ8ThV2RpM2gW4XJ5uQiOt/tNvJ3moVZ3E7Vr+TfyzPVTzGz1GGHMEF09i44ONzPUiT4nNd7UbhS0gl73EpYycoQo8dXcVIo73FMiv7GxgJaeb5EwcLNZtcjzR0cQpTkgWO5nptDwu8LCWIU9uKF758GKkjmlICNLiqAN0YYmjcWj1p+EvB1nZyX1jCGtNtSAnSo8wSV67y/7NNIoI3u1XCIH9Lt1/3ZToV8PRxfJ7fi5JMcFk/Bujz/gNwY665FuK3lRwqWETdNt+zhvFgN+AQFgUYjJnoJsYF/BCnZnv+EtbD2poqkFkMq2e75eG8Z6x66WP7qsKn18Tf98Og6S68/ROX6cZ/W075h6K/xlAujOpmbvP6vN6i7bIJWyDHZ7cBtEO1SoecRWr9olis4qiw3FEFDf+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(38100700002)(6916009)(66946007)(316002)(54906003)(66476007)(9786002)(9746002)(5660300002)(66556008)(7416002)(8676002)(33656002)(426003)(478600001)(2616005)(86362001)(8936002)(36756003)(1076003)(4326008)(26005)(2906002)(4744005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?moag02HNsczOx4oy0xg8TH0g8JOTF5drapX6F863y95tYxRcoVpasJP2bUjR?=
 =?us-ascii?Q?RVrCTFjQj4lEFBfkK4qZV5UFbiK6rHbhrHK7y71t7WyB9pH3BWSIXvIX/nTn?=
 =?us-ascii?Q?4l0tnphRwo/KtWt+Ckz/EZtdUAJDMePRTaJ2ptSNrXxpB6a9VO2oqrVLNG1V?=
 =?us-ascii?Q?BVFtXZPTGD1ZeeBINe0FHuyG3YXf2yKi3mUjSupd1arbgwSfBfTmFSiG5olm?=
 =?us-ascii?Q?NsejNXoGQ60mdFHMV44Zx53u7AMPXS5cG9CTLG1p+qDLLRaELp6UTAx6PK/J?=
 =?us-ascii?Q?VowHWPigfc90nfSuUmmmRZHeLOc3RQ4vTY3Gm+uGquezg3RDlDjlWenf3bJG?=
 =?us-ascii?Q?D+jVd0p9nfEoYCXfIGxFhEOGmUufqe0P/Lu/i4LydEPQbsUInTWWo0J7yhiU?=
 =?us-ascii?Q?AdL3odtTMKw7lg2GK/3XbFZw5XL0+83+XLAljkKTdL+e4NJOWmaTqMqYqOSA?=
 =?us-ascii?Q?TPTkEwd9o9ruKo8EBX3KeaZlu7GD+1/zDuQ6pgWZwbvN7n1kzNtRaKz6AVmu?=
 =?us-ascii?Q?cJjs/wOUVWrezIhZf/c/+SJUCN9M+LCN+o4SssCG2ONW/X02m1AEMOYD2kEF?=
 =?us-ascii?Q?4GdJu8egNGEnxa7vewT15m5NGGLKlkFMa8ic0lTyjreV6vISnNkZIGBXLUF9?=
 =?us-ascii?Q?1zkNzXQg3gV72Rg14Y5/iCR2f55McWx6ovqBgcar7+V8uX4XWHpOAmgxrMS0?=
 =?us-ascii?Q?67Twp96bJB7dn0zVSmJxuRR5AbcTzv5KIYmSUeRG/87wUYd6LtZL0zYu3Beu?=
 =?us-ascii?Q?xOtU9XUxdXw0CeL6qOuyjAH8doMxqDFeiMpeYE00KfTjrJGb1T+WdpG6OOcy?=
 =?us-ascii?Q?kRSoRRPrUYL7w4KGcKY/iHJShFlxJ6Z/oD1JY3SYmnsEqioDShP6P2vEaFlg?=
 =?us-ascii?Q?WzNPIhhk7KTCFKSFAaMunfKzwsZNz1a0JnJo9OQRHlKktcCSjLMVFPuTWIMQ?=
 =?us-ascii?Q?BZJMmR0msqmU9iyYKdvjNDav75LrMJz6LZuby6WQ1Uk7artdMQUie9n0yjo6?=
 =?us-ascii?Q?KwL9KeRZR+TCIzRhj5JdAAp+/tQeMPFRf4srdnmv7sBWwCKXGMZzxArYa6bN?=
 =?us-ascii?Q?s70ynXcN2GcANeALKzuL65L1yebv7kYe9OBZJXik2AelPW8eXcDA7K9sZKE6?=
 =?us-ascii?Q?LmiO94DPn/A3ouLXcwzCcT6/I3Fb8K27A3O30Qy2SNwjyvtRGK6OBrrFTY8B?=
 =?us-ascii?Q?zcrHSSns4l1adsGqgeq6MJ1HQufdShov9nDdsVIxUhJI3oZ2gj9S0ZMwMeil?=
 =?us-ascii?Q?/7WlrbokVHKNB2IxmtKg7SBXOxewviIKA5T551QB0hbG9tUkUTBdRh41N0mr?=
 =?us-ascii?Q?fTsN397RlWPQj4GTemOBP7hk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a748361f-51c6-4edf-572e-08d925231ceb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 17:31:39.0258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70veIwYQy21gQcG6B05Y8P+MfLTnpGZMHqDzz3oLNnrontTQgAg1qg7n+RCbfq8R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Tue, Jun 01, 2021 at 04:47:15PM +0800, Jason Wang wrote:
 
> We can open up to ~0U file descriptors, I don't see why we need to restrict
> it in uAPI.

There are significant problems with such large file descriptor
tables. High FD numbers man things like select don't work at all
anymore and IIRC there are more complications.

A huge number of FDs for typical usages should be avoided.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
