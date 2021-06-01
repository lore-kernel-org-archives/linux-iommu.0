Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F338C47092
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:30:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132AC613C1
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132AC613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D8216402B1;
	Tue,  1 Jun 2021 17:30:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iMGezMED6wIF; Tue,  1 Jun 2021 17:30:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CB19400F4;
	Tue,  1 Jun 2021 17:30:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62CC5C000E;
	Tue,  1 Jun 2021 17:30:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0438AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E121D60668
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:30:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id owd8MFBQ94nm for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 17:30:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1999A605D2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cY86ppOK1wOHtyOLiGfBDyPyQJfaU8/22SEIWg5bIrQmS6fc+3k4x8YvcevXNOzSZT33bsb88TsxiObAjCrDHRuPgFLyeaQ8aJ+TQjcplTPxrdyV72yKAYRNzVdbnlmPxCLbHlA9hpOlZB4gDpi0tocSa0h/Gyu4qEA6eWRhZRPrCB/tyvnHA97IjmCSFbkRaRO7njiO/GDeIx7duuBYeicD1NbYtcnyqQrQnnOhKgQULtLZ126dxJXbTdCV4AcD3XfUp/uFQu19qJRgAU7SXsWOwtb73Rj9XmLyb0Eoofos5pICjtiEtL0P6habpcBcgBQkkw1YwkDJHQrJIO4GMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ektvzN/JjzK37kcvqQMMpmH1kkULc2RHONF4Sg0qr+M=;
 b=Jxmagfat8d3R0zGs5QN3j1/nN+rQRIgJ8K90XSF4Il4ZpxAAF7lujmd4WPSQUSPN9Kj/eV2ZOUFQ17lthuGImennkYEr1Bm4NfilTVEkpaUtwqmk+/xQ0qxhBcnlSPqq4yse+sY1UZT7uk1DBW8iEGR/Q0VJES8WjBDpsjeyx7ov8rF0yYs0sIhl5ZageG2x8JqGfZs4g0zBfjvF8QzQhZT7uBCUzriqTathT3ivXaAwkBDZn2PqvxUjOeB5CkPrZy5/0wwsVYsgowAaW8bZuzsbPa6lUs1EdLeVns3b1wsKw4pQCglWs3uD21Otr+kAc0eiGNFeV3P9mkOD/BTJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ektvzN/JjzK37kcvqQMMpmH1kkULc2RHONF4Sg0qr+M=;
 b=QQqrkAl+1bhXtUOtVP1h3rpeED2hay5iwaWQKf9KI65yoX60kptHDRWzDaPyuTZTbzMwmOTcf1L8UWj22ZZa8eehVvd5sp2n+GcbybbgRh2KYT6JAej6nbrKqZ29g+0BRv8FWmObn1L2k1g10pMBoyM2zXklRL7WvYIwq71Nznf4JaySnOXwkHvV8KcH5yACxyWOwH5AXgjXxAyhR5F10SyDISdD979jyJyXudQ9+yXCD0umw2xYNyRiVaqO0sFnbqcRZ59AnXdooYi8itx3yzQenvc1vs6A+CeTpXfsxYlN+moCSiegg81atkVhwFORDXHwYN+OiKAdG669TqMXFA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 17:29:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:29:58 +0000
Date: Tue, 1 Jun 2021 14:29:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210601172956.GL1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
 <20210601113152.6d09e47b@yiliu-dev>
 <164ee532-17b0-e180-81d3-12d49b82ac9f@redhat.com>
 <64898584-a482-e6ac-fd71-23549368c508@linux.intel.com>
 <429d9c2f-3597-eb29-7764-fad3ec9a934f@redhat.com>
 <MWHPR11MB1886FC7A46837588254794048C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
Content-Disposition: inline
In-Reply-To: <05d7f790-870d-5551-1ced-86926a0aa1a6@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0214.namprd13.prod.outlook.com (2603:10b6:208:2bf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.9 via Frontend Transport; Tue, 1 Jun 2021 17:29:57 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lo8DE-00HXb3-V3; Tue, 01 Jun 2021 14:29:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bad9312f-47b5-4230-d455-08d92522e0b5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5272AF0773E378770B9C7B64C23E9@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZjPZT2xkQiM3S3cqzyRso8sMXepSPJQBHB6rrHkNm2QWpfbRe6IhH+c7pWJRxhFxqRZUQdUcC5gRzF15JCAXSkiAGo9I3mvQNajUAMwSabjC/x4+4l+l1qjgg+l/Qs3YcrLo/Orsp+gcNobAKcptmxvHbg6fXJrIdKgONxtYPFKaUf12QHz0YJ20W9irm3MytSCTq5JM3gOtS7h1k3OhS//ZcM3sKFy3ILMCHs9b6to+4ls88IlfGDIHLtUqHhvy4Ru5rKvSWIn05SuExwNoNOxUsRZD5vriJx7poH+TJS6Lw4gzhejDcZRkEdoMgBeGkyPIscIPsqmxgof+RLfxKQIvZ1l3xi+WFHHIiWYZJG+goEGzokPNfvczYEbJ4ZGct8HIKtPCad7H1fNbfFW8mazbFB0KzNmu00oR3bHkwhavr1uSus9dPrPmq8R7wADgxPj/AlQDfSuGu/jnJHQGnTlfQjKfV6qbeTUmPP6MrtR8sTLqW7oCYszTbY/IAA9n24s8Ca1+vOjRMgbPeIlBLnmpYRJGIBzxYx9GsIiFZVkZOTxHWBGjGHsKq9PdQG6gttoqM18nKb05/K52bKntIR0sGsEtPBuGlVwjBFojDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(7416002)(54906003)(8676002)(478600001)(66556008)(66476007)(86362001)(2906002)(8936002)(9786002)(9746002)(4326008)(36756003)(38100700002)(5660300002)(66946007)(316002)(2616005)(4744005)(26005)(1076003)(6916009)(426003)(186003)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?efqTTEOSiLWWca/PUO/M5iLK0FjmhnNpG+Dk2f4XGKXoqfo1u6gJWhBINOKr?=
 =?us-ascii?Q?+8Ao9Ta7X4yNyQpbfnSDyY6XHtxmKDi+72CuM97l5ZmCvqC02QOJbsPGPZVX?=
 =?us-ascii?Q?To85TbQI3JNhx3+9yXgo8nLwi8pC/Wp75HzVwMSchKb9nPUJ1HtpFPb5UpKm?=
 =?us-ascii?Q?yX29CW2uggDWZvQcZ/Nv8hy3l6FEQTOvSt0jKs4WbVM7f86de3pOIiH2kSBx?=
 =?us-ascii?Q?gKt88Oz/rjBhOKHWSlN+EA05x+bQ4XbFgqlSoTTxGdFjIqMPrs26/B6JHMHO?=
 =?us-ascii?Q?CaeEZl0K8lqwQG9wUJvRjtApBWLZ2rsFfLwf1EJdTzRBsJzV/bYx74YxZLIn?=
 =?us-ascii?Q?NZR0cozYB2y+Mpv7/wKMAd0I5lCaVvuhVQknwp8iAzG84c2FEEMY1DsCGyO1?=
 =?us-ascii?Q?PFMo2CrQDzIfzJuxalxBfy6C3wwOqYuZETv5uEFhCcJoBdiR7O522NmRgDSl?=
 =?us-ascii?Q?lUefGQ2k+s9XTWQuDBQA7JAloodWoFOd3/fB7mZhwES3iJ7cV3tATK3e5afL?=
 =?us-ascii?Q?U2VPV1We+TmYJeLcdK6Z7i7ZNE8pinWG4EYny7XFFNsKSICsehvfcOhxBz04?=
 =?us-ascii?Q?J1y4CRUPoj9X4mFZ+R3TLebvOlktPG6dcAjlW9lqZz8mPcYEBVVXuU80VDbU?=
 =?us-ascii?Q?ZuYKtkN2AH57f5TpOohjao1qehnLxxsdNla+8xr04Mm1DNDRlvsfuab+xbF5?=
 =?us-ascii?Q?i6Ga1DKZjmhh0Qn2cTeGy2hqRpQMlZZIHSl1ZBlTTgUYKGbmKxjYR5f+Y479?=
 =?us-ascii?Q?1DUmsxXBXteJDjdOj6rxEKMOfIi/WfrKV9B3Pfw+KpG03T+ouFIiNTmsUkTJ?=
 =?us-ascii?Q?Ti0VLzffXYP4BZB2dFQ0XPtsC+5+OOfR+m2yAfnFw6JQPuVU35k2XGTPJWkO?=
 =?us-ascii?Q?AuOELcll181bjSM1KMKaYgT1jEce3e22iIiSER5BKymyUfRGLCtXcEbqf0w6?=
 =?us-ascii?Q?1LMyVN6JMOCl72OpdimtbszM3a7ymAZWIImOSU706Xu9GCdqoP6Mk9cBnZLo?=
 =?us-ascii?Q?zTCp6jcLPNXBLkR+qI8vX5bSv54EOt7S8tbcdn+tX8OTXcmA7H3rJtQVYaHy?=
 =?us-ascii?Q?ajadexD0u3BdeHqDwJlR/Za91u/i91wwJ+JIQBNZfn5AF4x9CpowJ29NYwF3?=
 =?us-ascii?Q?mFIhv7qiym0jOzBCUzuGjV2oOxAJ5I/pYUmfNFLr6RFkMu8ns876tQrfDP9R?=
 =?us-ascii?Q?rlalSTvyggN7rIrqxahI5fgqU+1GFNhAh7mWgzPXUHVlZkKICBfUlHRaxjzp?=
 =?us-ascii?Q?LlsfFfJGeMcwpZ400z0rAnGvCXLApEZ0TBm7ExHgluHOYxjKO5UyJH87sRF4?=
 =?us-ascii?Q?Q1MNL+1dynMN9GMaGpdPuK5z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad9312f-47b5-4230-d455-08d92522e0b5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 17:29:57.9899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxSoaiAPQMasAJfPJG3Nacw1b4e14hlsyosAuDTctIVEQKlWbSlxS3t6lha1WeX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)\"\""
 <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, Jun 01, 2021 at 02:07:05PM +0800, Jason Wang wrote:

> For the case of 1M, I would like to know what's the use case for a single
> process to handle 1M+ address spaces?

For some scenarios every guest PASID will require a IOASID ID # so
there is a large enough demand that FDs alone are not a good fit.

Further there are global container wide properties that are hard to
carry over to a multi-FD model, like the attachment of devices to the
container at the startup.

> > So this RFC treats fd as a container of address spaces which is each
> > tagged by an IOASID.
> 
> If the container and address space is 1:1 then the container seems useless.

The examples at the bottom of the document show multiple IOASIDs in
the container for a parent/child type relationship

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
