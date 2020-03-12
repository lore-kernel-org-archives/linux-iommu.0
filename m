Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1300C0044D
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 03:15:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C029220734
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 03:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gk1n+kLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C029220734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3BBC389216;
	Thu, 12 Mar 2020 03:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGle6chrWHUw; Thu, 12 Mar 2020 03:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B07058859B;
	Thu, 12 Mar 2020 03:15:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 944E2C07FF;
	Thu, 12 Mar 2020 03:15:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD582C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 03:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A795F89216
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 03:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JoSuMqMLOeMA for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 03:15:38 +0000 (UTC)
X-Greylist: delayed 02:17:40 by SQLgrey-1.7.6
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6A2618859B
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 03:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn/f0mXA3ToYW+hI75KlPqEfx9Y6WA9HdIA0DU0HZG37acUbDObNzHeFZoYrLdJyJ63dpxbHtCJxfSuHV+TA6nvfnPcE+Ilau3BpyfShmBEYzb2zUNOIldd4K7lajPk7DJeVKsOl6aoFk7w59D2WK0zI61mZXWRE9sKODbOzWqhyXbn1PDYoY8/b+DbgmQV9sqaG2Vp26VMpg14/AuAFTKyz6tJq5B0imZxCcWbT9Gk/gv0u0WoSzEQrM6WtrCQ1/nZbaYKORUMikngzPvAX2qjMUdyiacWsorqihw7+CZ39qWsM0nyuQe9ApdegLM2gNNxaezTzK0ufhru0NfW9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVGWqKJ66qeV2vsQMPQAqYByNNY7zCdGHcvYpNtbHhE=;
 b=HFaPNcJ0rhFX7GK90V3oRaEeNd8Iv40Td8soSbJ8lN2JvmsOM+TgDCltd2piug81U7tmB+E8QZ+IL1cKWJsYWxGOOIS+ZprpxE7UnvPeZ5zBoJ3+BjR8iJgzAB9BsxXCVVcIEc/tv/kUQC+l7oqTthxACbxyyz/Ju7ObgiopHShBuoKRlmZlaQbTJzTW/fleCTWC2sZ/zfry2+NSFHQp0vncZRcmDKbhTgfYMu1fi02K2hQImMDAtJz6IM8cWf/PWMCirFEKgzMdxROMNZ3Wqxwyatu4UULbavJla5OqpQWyGcgDAxkoeHbDYRedKnTp13YHdoPAY/t1p1Nl2Qi/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVGWqKJ66qeV2vsQMPQAqYByNNY7zCdGHcvYpNtbHhE=;
 b=Gk1n+kLDy+LaP24uIpfms3eFyElPkueoJM7W6jsWIGftD8BotnB4z64msp9Ma/ixOd8SBxyrLhvKPWue0nRzWaxhRs8QwUD+3mFm5hx21Hw/jkHIXHOCXWakdY6zCOvfJjwTZoKiKI1DM+q9P9YrffGiEZyuNphWqXwZX+khW7Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) by
 DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 00:43:05 +0000
Received: from DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::969:3d4e:6f37:c33c]) by DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::969:3d4e:6f37:c33c%12]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 00:43:05 +0000
Date: Thu, 12 Mar 2020 00:43:02 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200312004302.GB26448@ashkalra_ubuntu_server>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
 <20200204193500.GA15564@ashkalra_ubuntu_server>
 <20200303170353.GC31627@char.us.oracle.com>
Content-Disposition: inline
In-Reply-To: <20200303170353.GC31627@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) To DM5PR12MB1386.namprd12.prod.outlook.com
 (2603:10b6:3:77::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN4PR0501CA0034.namprd05.prod.outlook.com (2603:10b6:803:40::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7 via Frontend
 Transport; Thu, 12 Mar 2020 00:43:04 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ccaf83d-a576-4961-2224-08d7c61e53aa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:|DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB114838F297317EE23B207B698EFD0@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(7416002)(86362001)(6496006)(4744005)(52116002)(6916009)(33656002)(2906002)(33716001)(8676002)(5660300002)(66476007)(9686003)(55016002)(8936002)(81166006)(81156014)(1076003)(44832011)(478600001)(186003)(316002)(16526019)(26005)(66556008)(956004)(66946007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1148;
 H:DM5PR12MB1386.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpUcXVDk47dPORfJhlUDkzjEXA4SmdJ3+uLJ/p2fUryyZqWUOBKYf18QQEn3sJhLx0hqTzECtnBlc5byyGoDBm6Xux5lUvOQ24NXL9xccEYODukEAfgP8+xpdt6cMMppCM1J28lrZu9he56h2W8UFEA1x9jgl9jiGed0aSHcGvGkn7HkFWlcvAuOXQO+SZ4ps6Q9UoCdzg04wl5np7wOz3GAoQnInMFtvpTQ05VPNGoro2Qcs7yDX7UKDKCgmx2wBYoEb5si7QgWviJ3AW1Nkc+gPT71ZvjHyLjuC7HwETfuej0Tba0b1jtzDwZTgvt4UUEXdaKKwZ5xuVxjBLrIJ4udWPdaD7q8j5i2ItBP1+/YSS+zLsa2Z82tKsQzVtmU1Z+v0fRFKh8PdyWIs6f+Z9Dc84Nyt5zO4Teh55Uq9bezqfUbIJWvgxSuOacGNJ/F
X-MS-Exchange-AntiSpam-MessageData: lRc87YfrBsBnRp5Re+HF9k377vRiBLYhQ7883TlPZfQ3qBzgVzOcsq00k+rfCmaiHmX42hR+GAgIFUc7bPYG3QD7BBHBWP+n4mrzAfwrY2RM7IQrxw+rdws7IrMg81YTUn3jLbGLhzUbmgxTf/xXOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccaf83d-a576-4961-2224-08d7c61e53aa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 00:43:05.7239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NW5+Umcn75l9nkD8fsGnRzNwKNsPzheEf7KVSmgolBPbFDq/sqhssLEuFWQZLQHe2QPPte91Z7ENTvc9k1Www==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, dave.hansen@linux-intel.com,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 luto@kernel.org, hpa@zytor.com, Konrad Rzeszutek Wilk <konrad@darnok.org>,
 tglx@linutronix.de, hch@lst.de
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

On Tue, Mar 03, 2020 at 12:03:53PM -0500, Konrad Rzeszutek Wilk wrote:
> > > 
> > > >> 
> > > >>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
> > > >>    perhaps add in this code ? Albeit it really should be in it's own
> > > >>    file, not in arch/x86/kernel/pci-swiotlb.c
> > > 
> > > Actually, we piggyback on pci_swiotlb_detect_override which sets
> > > swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
> > > forces swiotlb on, but again this is all x86 architecture specific.
> 
> Then it looks like the best bet is to do it from within swiotlb_init?
> We really can't do it from swiotlb_size_or_default - that function
> should just return a value and nothing else.

Ok, i will fix this patch accordingly and resubmit it.

Thanks,
Ashish
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
