Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07012C433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 11:39:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824CE21973
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 11:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ALmqWV1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824CE21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2FD8A869DA;
	Mon, 14 Sep 2020 11:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5asQVuZg2wbT; Mon, 14 Sep 2020 11:39:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B96A6869CF;
	Mon, 14 Sep 2020 11:39:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6A46C088B;
	Mon, 14 Sep 2020 11:39:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 294A0C0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 11:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 18C2F869DA
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 11:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sICttXCR1Sqv for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 11:38:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 08510869CF
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 11:38:58 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f5f56500000>; Mon, 14 Sep 2020 19:38:56 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Mon, 14 Sep 2020 04:38:56 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Mon, 14 Sep 2020 04:38:56 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 11:38:51 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 11:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aszzz9aCXPrsx2+DbUfU4MMGv5ishmNwIXr4M0VRSv20k8TbzAcl6mwrn2hF9t+7Meql3tDAgQV1mTD6/vxYbOJB6EMRWdSQGG9nmeTI6C/sXw11EPNcgDM85qIgAcrYpASn6rk4DfN1hzfHCODEfHZVvt/+WcXV2BTzUMRnC7w0Db26IKmJeMWUgs0VMLNJA/8q6XVyPOfYi91ax0XiUrEkiPeXW2B8JaONOdzHce0DMTaVEMlF36BfNpkVX4S3R9RlH2okkHmahfRzwykKWvMPq8S00FWavPk+dgLYdZWmBDfg2+6mVX0HM60/HkmbSET2pMdickRVIQf7+l6vlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXsZzUmJitkYW4cx3kqEEsWpV0Prd8msKBrWcp7+LTE=;
 b=O3pyesYYPiGCPKQmpIKiUE7FM0I8w7WiHXyPqyFOT5StejmuhJV8GXqXIH83ZUoV6RQQ0BX8xoLvpxt9wYWfGjQSszAg+fiEikMTV5jelmtYNyzbO93yFLMqhhd8c445JZ8PvcExtOY9YkhTCH9nxOyTr/fclEI43sUGAzhWFFcAd7JzoeiKVf+VRsr1EepdYqNBNA+921jhnvFj+WnTmBxpLNj7bxT0kRs14Q//W4ofNBOc3tS+DWbYTqQOY7TgQpg72hBdrNBpyS1SHUaadq/f5CqsATh1fbh507dPuINnZ/UGHKH06turz3/2PE+nDFOuTgVS/YEeVxx+wkUqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 11:38:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 11:38:48 +0000
Date: Mon, 14 Sep 2020 08:38:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200914113847.GW904879@nvidia.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <MWHPR11MB164517F15EF2C4831C191CF28C230@MWHPR11MB1645.namprd11.prod.outlook.com>
 <c3e07f47-3ce9-caf4-8a01-b68fdaae853d@redhat.com>
 <MWHPR11MB1645C702D148A2852B41FCA08C230@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1645C702D148A2852B41FCA08C230@MWHPR11MB1645.namprd11.prod.outlook.com>
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 11:38:48 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kHmop-005v8l-4l; Mon, 14 Sep 2020 08:38:47 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 705fbd55-0fc1-47ff-c211-08d858a2beeb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3305B9B05FDEEE45A32A4E85C2230@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +87kfa9WX0zkEMF7PNBthMXjUL1rWN1oFYN6/QtW+1WdEcjlh9UGlzhxzifiWAOKWR2aUIDtkFtT1J/VeaMHQBYhkfTKBrPBY63IYheTJbjfmBMn0p1VOaBh/h8UFapLK1HTkgDkaPhrB1tS46Pwu73zHGgM8tyQqMUIAEg7jXh7fiPsY1EfI2I/W1HLaKZUv07K4k1K6E6v/8zrvlrBNUXnvj3XBoSUetCGG5YvwMWiyfZ5+cOcwLRTD7Tx5+jT+qLGxK9s5OKxu1fBdC7hD2UEIyqXaBqsCD7c2CgocoaAnPn1F0aKf8bsN5uer9l7tlqOFgN69Tt7xah2fixwOK0zbFuxUwOo8nC5I2YXGQ9P90or0dlDgSCGsQCFI2MV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(2616005)(316002)(426003)(4744005)(478600001)(66946007)(66556008)(5660300002)(66476007)(2906002)(7416002)(54906003)(1076003)(86362001)(9786002)(8676002)(26005)(9746002)(36756003)(8936002)(33656002)(186003)(83380400001)(4326008)(6916009)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: C2LyWd5Fbv7+hJjn9AhU5Bx7YWIW0CzDGS8Zz97pps0uMj8kxF+UvNEKbSewX4qXdMcPUX7gxCe99rV7KSouJXM34mfMLskNB+NcjQn+I1kuwdmQS0X3+ukfnETop6UBoJgvl2lwYtCtW5sgXmB6eCmD4GHEwOnjE2K9BZgEDKPW1bOXBZbmOd3C8eqMSD0dH+XnlWS/PnW2zecpBwvunz6/8Rp6xep2zR96s9MmJaEabbAdj4iR1e/5X4jWi/40GedHzHEWVnamfodMG5053DBK1UM0QpAtNAnb/Pd3lWtnooU57dlNYpUGsP4jwdeKgt9mxn3mowuqO0GmT+NzAHho3HEnQEB6iKwMwe6uDhLChrdiUl+iD3DXCvfjF38H1JJSSh6ed8OoDTubVUaEjdTdsSrAODkDLXD/sHkks3SZ94YYpr9crH5Ss6p9bZ0KRYp1Dx6hwFUL1C3Vmh7ft8XDh9AkkgxxY0sq4Z7MLaOlVvrPyGZEm3OuA4hPu/YkP32kyx8zD9rcfk/kfmIkUAsKIDNGyTxt/saUpNaU+JnR/ZMYN2SOps9VoSDFvojtSjqaF8DwzOBlpC9YWRj3OhWbzO7XKjA2zcy4YB9YP7lW2stWYVajz5Ei3R2WGuaGctTvC98q8ePxSvwKTBrWFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 705fbd55-0fc1-47ff-c211-08d858a2beeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 11:38:48.5602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpjQbEcgF5stukR17fCgYCjVI1asAJ1Ifno625VKN6OHWlfEK7HEEUGzYb0/sxr4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600083536; bh=LXsZzUmJitkYW4cx3kqEEsWpV0Prd8msKBrWcp7+LTE=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
 X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=ALmqWV1H7zsgU4U3tifaLuXdewYuW6fwpwDKxNjwHEr1/xPLTdDdFVDtIgIU3I3hc
 Q7szgaUiVl4WMuQ+fvDE9Q4LimcVsgyBFtRIJObMS5+voVExRkoc8SgcbfC+XBp2rj
 XjrSeAoClubX50ORNmbaz5qYDhy7cBfnkfpfSmNN51YC50Ykq9FoiI4AgR/TFuUeXe
 ai2OyRiJ6LRACcfhcdB33dpjoggrjuqPeuJlc8WT1da5sG8eyEydpoyPOzFo5pm65K
 gntdCri5cvFTCqvOKqY0IsjOu+4u/FqbTstj7rnvHE3JR5Wm1p5XugpXn0p1XDSaqo
 5jFgaRl5bOGGg==
Cc: "Sun, Yi Y" <yi.y.sun@intel.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael
 S. Tsirkin" <mst@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wu, 
 Hao" <hao.wu@intel.com>
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

On Mon, Sep 14, 2020 at 10:38:10AM +0000, Tian, Kevin wrote:

> is widely used thus can better help verify the core logic with
> many existing devices. For vSVA, vDPA support has not be started
> while VFIO support is close to be accepted. It doesn't make much
> sense by blocking the VFIO part until vDPA is ready for wide

You keep saying that, but if we keep ignoring the right architecture
we end up with a mess inside VFIO just to save some development
time. That is usually not how the kernel process works.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
