Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C771EC433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 05:57:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF0623120
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 05:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF0623120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7F33586208;
	Wed, 13 Jan 2021 05:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 79jqsvOjvXgs; Wed, 13 Jan 2021 05:57:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B646186044;
	Wed, 13 Jan 2021 05:57:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2E0C0893;
	Wed, 13 Jan 2021 05:57:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 621E7C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 467D985B5D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ashFEUb0k5Zf for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 05:56:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 173E78588C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:56:56 +0000 (UTC)
IronPort-SDR: UW4+HpnYaeqzYAUe5WsxWwajQ5/MwwQwga6IBARguLFHtrYXRU1v3HIFf/Psffz06YggshnhH6
 GX+XCNUcaXSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="174647288"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; d="scan'208";a="174647288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 21:56:56 -0800
IronPort-SDR: 2j/3wwk5ZHrfFrV2GK+6Ac6LRjeCPLyh5EauPJwkB/Qh5gwss/f2erZ4qGGRiCypOWZGSqFq1L
 WUxkkt7POXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; d="scan'208";a="424440911"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP; 12 Jan 2021 21:56:56 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Jan 2021 21:56:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Jan 2021 21:56:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 12 Jan 2021 21:56:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Teaed8uqhZIArY23dZbv0cIZ+yUFl94SRfeD1lY08mC19v3yeBYx06SQZPw8srqleSymG4pYGDxCfULuZSJEPtpRUPslSyf6aGqlkTdNdBXUbyEvT3jPOV5WEsm3WRD+HhuLa2EOpFiVr3mN7i/VZJe+kvoi3n0RdGPcvd/ukuJIBp3xZnlMFXLsjmmq6NtSuUKHY+Si28c8T0+Yxagxk1Vuy64II22QcnMX2T593arjdv8gKvNIro/diR+K6Je00a5xPjDITVd1sH4orBGtryh2GD1txPbjrq2g+KeUgH0hnPDgEqIWp9RgwGE79z2xhKiehsDtaVW0t5JNyXxNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuVWgsoYtmepPT8cUgKwM2zXimzLkiKjH4TMFpqNVHw=;
 b=Qm3uDU92DHwck74xCzshXbq6OeSomUwM+Ul3JATat0FWMhJIv3UfF16BlK2r4Tmw6/Wz6onYG4wf9nJP2hcw3f/BxYx6RKor9R5f3zCZ8Ym+Kf9c/t15wXtpqAAMyHYU3mVsFjj+JclF/6ZJkx8Dpumul/mz190f/AxdpK9fIBPrQ+/CQ621mGN8so1UwEsk9yv4GqHNfbXytidku5Jga40XCNiafIXRiW0HF4DMC+Iobg4Bu0L1xU/+AyfzefJp3mg74tQCcMooFmzVphxgAikhCc2zK0LGIVmg3U1vChoi+flE1P12P5rJpGJgDZcuBNlEognNWW8mOviLd3S5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuVWgsoYtmepPT8cUgKwM2zXimzLkiKjH4TMFpqNVHw=;
 b=YWfX5PRCOPQP1UPtcg6ZykoYp7e025aa255WDN49r4d2q7VU2fWsM8ne9K5PqVKqEi6qLt2RtTt7jBzni/1SgV2R0p6d6tL6v24dE+ghFjz42MW84hdoW3rGI4aJ+CBBrzpplJnkr77a3nPHqWwZn+fAKmoMiTXAMHceMhc8jCg=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3580.namprd11.prod.outlook.com (2603:10b6:5:138::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.12; Wed, 13 Jan 2021 05:56:49 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:56:49 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Vivek Gautam <vivek.gautam@arm.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>
Subject: RE: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
Thread-Topic: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
Thread-Index: AQHWh19ACfcP7ssg8UC1cgpZfCvfJKokT6+AgAAjF2CAACQ7gIABOtBw
Date: Wed, 13 Jan 2021 05:56:48 +0000
Message-ID: <DM5PR11MB1435D9ED79B2BE9C8F235428C3A90@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
 <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
 <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
In-Reply-To: <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9555387c-87f6-4bc0-ec50-08d8b7880469
x-ms-traffictypediagnostic: DM6PR11MB3580:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB358063B65E2B372C1A4059FDC3A90@DM6PR11MB3580.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPEsNrIaT9TC4KGx5A1OFmGs315emwHEhxLMBNB/adr83/3NO0y9RafOYk7Vqnn+i3ua3maJX5yVlo2xnQQ3r9bwEnJUhDc4ESQyy12cXDAIlJSffy6UUgAAo4FARL6ccHmSK8hlGSbKJaH6acDqE6czbpjMEyUpPBsx7qHr4ucAWW5q4WX3H6qTdcE+sbuzpX+gLStkJqEQIhqu8g6MAgTDCLxSFW7fTki7JIewXWB0JbLGvBkZhrISvdV/n2PaiM9vED18jHREFD5Z0xeKwlCx2FCh5+AztbKw03V2QacJ3DJ15z01Y4P2Qdz34CDtdGRhL3MS/SAvLOq3r9E/8EFT1y+JLbb7MfTwglfSCjVplymUsMCJss5yDJrHcfIuqqd4m5AmstUrEpRqIMhP6hkWZfWvRKIqk6zEo1HZHCqc+HH+LNUL+qRoknKNNzZhriFCA2SmRlzGUgksKZgpsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(186003)(4326008)(26005)(8676002)(110136005)(478600001)(9686003)(7696005)(6506007)(107886003)(54906003)(2906002)(5660300002)(316002)(83380400001)(71200400001)(66556008)(66446008)(53546011)(55016002)(7416002)(66476007)(64756008)(8936002)(966005)(66946007)(76116006)(52536014)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TkdTQ0E0Vk44R25wOUlqOEdkRVBiK1g0d2cyZ2gvcWt5YlZrOExrTkZYY0Jp?=
 =?utf-8?B?QzQxL0FtanBwRmUrdWxqc3Qvb1c3YkQweHFyOGY5ZHZGL1kxU1c1VWl5QXh6?=
 =?utf-8?B?VmgxdS9iWFg5Mjh4cCszVkY1TDQ0cXRsVWo2VFE1cHhmSGUwSVAyMW9KTUV3?=
 =?utf-8?B?QlA2bHlOaVpFeGNzVlJYSTBCQzkwS25jQUtSQ1RNQ1NmakpPc01PbGRRdUhi?=
 =?utf-8?B?Sk8xNUVVWXFLTWJyYXh4M2FkMVM4RE16YXloazRmMW1iUTV0MFBGMEVOaFEy?=
 =?utf-8?B?SE1IeWxOZ3VrbnFiczNHMEFNUGpKcnZHVzdOZ0NmWXBPWUNGVGF1RHNnSTd6?=
 =?utf-8?B?UlFEakk5VXRIM2FXYm1pN0xLbmpNY0lwa1BjaGhScm96Y2FBSnBwOEhmZG4x?=
 =?utf-8?B?Y3JPZTR3ZWk5WjBRSkN4TDhOdURyd1JJSnFDcjBNbXpBVkdYMFV1TTZlSGRY?=
 =?utf-8?B?cXFCUzYwQVFIaGRGaVJnNHFJM2RHQ0hVNERpbG1hckkrV0RlNGUwUHpXOWFv?=
 =?utf-8?B?dldFdFMySU5rMUlDOW8zS25BRyt4aE01cmMyTGR0V3ViT1VvQTVIbHg1WWNW?=
 =?utf-8?B?ZmNUTkFtdkNPOVJvWURtYkRjSjhKUVVnNG9MMjZMR0dGYWdQM28xaEIzUi9j?=
 =?utf-8?B?MWx6T2VyTEtGbEhhNEp1NVZLTzBaSUwwbUM5NWJQSHJyMHNZMHBLekFueHlU?=
 =?utf-8?B?N1UrQm92OWp0UUR5VzB1U0thaExSRjJFUjdwV2hScXpMejdYaEc3anMvUFA0?=
 =?utf-8?B?bWpXaU1xNm9pSC9VeXliVVY0bWoreW9mWm9NWlBvNjAwYmYxVWgrdkR0Q3Bv?=
 =?utf-8?B?V3RqNDZEMWlVamhVOFdsdlp4SlZKNlA2d3YrRG93ZGEwWGFTQjFjYUt1M2Y5?=
 =?utf-8?B?TmFsclZDMXArSWtSSnovK0F6TjlyTWJ6K3hvWnNTa0xoV0tvUFdPSGNmaStz?=
 =?utf-8?B?ZDIyNGpHUG5IQkNzQStWTnVTSFdrbnd5NlZiUnM2SjllYkxXcWJMNkkxTENs?=
 =?utf-8?B?M2VXU2toaTFGL2JqU3Z2Q0VGQjVWUG11QkFma00yOTM3QnFXK1BjK2lkWXhm?=
 =?utf-8?B?YUpla0pWakhEbFovSE94Y2dUbVpCdzd6S2tHRHdqZHcwZVlmL0k1ZUZxUVFM?=
 =?utf-8?B?QkxTMXVYbHhpSStzaW1Dem1SMWg3QnFjajlSS29YRjFqL2dQcWVPR1JnZko5?=
 =?utf-8?B?Q0w5bnNlT01iRUloRzJBMlhFMUxOYk9zNTloZ1lzWmErWFdjSzdQTEJTWWpi?=
 =?utf-8?B?VjI5cDc5bEdQcnZTS0MxSm1hQ1RNbG13cHQ2ZUhwdlgxNjRtUzVIQkcyR0pq?=
 =?utf-8?Q?/FnD2Cgz0s/eg=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9555387c-87f6-4bc0-ec50-08d8b7880469
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:56:48.8591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlSMvdJWTkXF+CutbxzVM+W4MRMy+vvchWl0GSaa8/xvT53ofqaML1mSkCHEaDds574IWSgsgF76u9VJfzdJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3580
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "list@263.net:IOMMU
 DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
 " <iommu@lists.linux-foundation.org>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Vivek,

> From: Vivek Gautam <vivek.gautam@arm.com>
> Sent: Tuesday, January 12, 2021 7:06 PM
> 
> Hi Yi,
> 
> 
> On Tue, Jan 12, 2021 at 2:51 PM Liu, Yi L <yi.l.liu@intel.com> wrote:
> >
> > Hi Vivek,
> >
> > > From: Vivek Gautam <vivek.gautam@arm.com>
> > > Sent: Tuesday, January 12, 2021 2:50 PM
> > >
> > > Hi Yi,
> > >
> > >
> > > On Thu, Sep 10, 2020 at 4:13 PM Liu Yi L <yi.l.liu@intel.com> wrote:
> > > >
> > > > This patch is added as instead of returning a boolean for
> > > DOMAIN_ATTR_NESTING,
> > > > iommu_domain_get_attr() should return an iommu_nesting_info
> handle.
> > > For
> > > > now, return an empty nesting info struct for now as true nesting is not
> > > > yet supported by the SMMUs.
> > > >
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > > ---
> > > > v5 -> v6:
> > > > *) add review-by from Eric Auger.
> > > >
> > > > v4 -> v5:
> > > > *) address comments from Eric Auger.
> > > > ---
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29
> > > +++++++++++++++++++++++++++--
> > > >  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 29
> > > +++++++++++++++++++++++++++--
> > > >  2 files changed, 54 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index 7196207..016e2e5 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -3019,6 +3019,32 @@ static struct iommu_group
> > > *arm_smmu_device_group(struct device *dev)
> > > >         return group;
> > > >  }
> > > >
> > > > +static int arm_smmu_domain_nesting_info(struct
> arm_smmu_domain
> > > *smmu_domain,
> > > > +                                       void *data)
> > > > +{
> > > > +       struct iommu_nesting_info *info = (struct iommu_nesting_info
> > > *)data;
> > > > +       unsigned int size;
> > > > +
> > > > +       if (!info || smmu_domain->stage !=
> ARM_SMMU_DOMAIN_NESTED)
> > > > +               return -ENODEV;
> > > > +
> > > > +       size = sizeof(struct iommu_nesting_info);
> > > > +
> > > > +       /*
> > > > +        * if provided buffer size is smaller than expected, should
> > > > +        * return 0 and also the expected buffer size to caller.
> > > > +        */
> > > > +       if (info->argsz < size) {
> > > > +               info->argsz = size;
> > > > +               return 0;
> > > > +       }
> > > > +
> > > > +       /* report an empty iommu_nesting_info for now */
> > > > +       memset(info, 0x0, size);
> > > > +       info->argsz = size;
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static int arm_smmu_domain_get_attr(struct iommu_domain
> *domain,
> > > >                                     enum iommu_attr attr, void *data)
> > > >  {
> > > > @@ -3028,8 +3054,7 @@ static int
> arm_smmu_domain_get_attr(struct
> > > iommu_domain *domain,
> > > >         case IOMMU_DOMAIN_UNMANAGED:
> > > >                 switch (attr) {
> > > >                 case DOMAIN_ATTR_NESTING:
> > > > -                       *(int *)data = (smmu_domain->stage ==
> > > ARM_SMMU_DOMAIN_NESTED);
> > > > -                       return 0;
> > > > +                       return
> arm_smmu_domain_nesting_info(smmu_domain,
> > > data);
> > >
> > > Thanks for the patch.
> > > This would unnecessarily overflow 'data' for any caller that's expecting
> only
> > > an int data. Dump from one such issue that I was seeing when testing
> > > this change along with local kvmtool changes is pasted below [1].
> > >
> > > I could get around with the issue by adding another (iommu_attr) -
> > > DOMAIN_ATTR_NESTING_INFO that returns (iommu_nesting_info).
> >
> > nice to hear from you. At first, we planned to have a separate iommu_attr
> > for getting nesting_info. However, we considered there is no existing user
> > which gets DOMAIN_ATTR_NESTING, so we decided to reuse it for iommu
> nesting
> > info. Could you share me the code base you are using? If the error you
> > encountered is due to this change, so there should be a place which gets
> > DOMAIN_ATTR_NESTING.
> 
> I am currently working on top of Eric's tree for nested stage support [1].
> My best guess was that the vfio_pci_dma_fault_init() method [2] that is
> requesting DOMAIN_ATTR_NESTING causes stack overflow, and corruption.
> That's when I added a new attribute.

I see. I think there needs a change in the code there. Should also expect
a nesting_info returned instead of an int anymore. @Eric, how about your
opinion?

	domain = iommu_get_domain_for_dev(&vdev->pdev->dev);
	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_NESTING, &info);
	if (ret || !(info.features & IOMMU_NESTING_FEAT_PAGE_RESP)) {
		/*
		 * No need go futher as no page request service support.
		 */
		return 0;
	}

https://github.com/luxis1999/linux-vsva/blob/vsva-linux-5.9-rc6-v8%2BPRQ/drivers/vfio/pci/vfio_pci.c

Regards,
Yi Liu

> I will soon publish my patches to the list for review. Let me know
> your thoughts.
> 
> [1] https://github.com/eauger/linux/tree/5.10-rc4-2stage-v13
> [2] https://github.com/eauger/linux/blob/5.10-rc4-2stage-
> v13/drivers/vfio/pci/vfio_pci.c#L494
> 
> Thanks
> Vivek
> 
> >
> > Regards,
> > Yi Liu
> 
> [snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
