Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0CC388F7
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 22:20:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0205F20735
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 22:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pp/iWP2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0205F20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6A0702746F;
	Thu,  5 Nov 2020 22:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LXfIsogzbb7u; Thu,  5 Nov 2020 22:20:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8473B2041A;
	Thu,  5 Nov 2020 22:20:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6902EC0893;
	Thu,  5 Nov 2020 22:20:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C313BC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 22:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AF285874B0
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 22:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApqoV9z8IUni for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:20:27 +0000 (UTC)
X-Greylist: delayed 22:06:32 by SQLgrey-1.7.6
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680102.outbound.protection.outlook.com [40.107.68.102])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4E0E7874AB
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 22:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlrqN48+R+DvGeCZCh/matiBP8/NjiiQ2LLFTouHrjMv2aWOOMf0ZwYi2go54XNm3BZXb1ct5TVjmhdFugI6/FFapyNnGYO1zzVdQWRukgNDX5PElpixfb+uro5XSVAgLFnhWECHrDkO+KbEUT2RmAtZiHpq0etfLu+ZNM3aOH8HRkagpE5k5TRRworZTdqnFAIz/P+qN9l9t2iyeSdGyPzUiBoBu4Sk9nRwChekACDt/WrrJyamTI7GXikUdscHUQI/sbzbbhwsKHw5BUzzG/AZjo4IKX+l9WmRZy5Hu+s12tLAZ1mk50v78MqaB4K9NRypAefRgABUltsH8yVnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYxnG1U5GFbAbfFz43YsOAl66UUJVPHjmFWsZiGwSfk=;
 b=bEc4qDgK+vYLO92iHEMI4hVbeQGBn2Z7SUykKzf3CdaUOA5+KnsXuN2QzlFFhfmZPVySHddvYF3wp6lmTf1nOXvNhIO9T06yCg3WlLsc5doEllLSz4Gu/NHcNC3Le5sAUBWf2Dcw8RD2+so6IhJRj+55YYoBmkqaGoQAUbbxp48Asw3/RE6qBsK297/63uzC3RRRfM2m0bDnoKXDLyKkMABvShgyij7umhDJl0dsFWOAtWQ7eyqcqUQz79spvciD8IfzSKEtRqoOIQscan8aSUD06tsVkG4elYbtJPbG3smZMSmO2D2o7Sv8vHGpdFdejNyPzYIz+L4S+gmcIt/DBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYxnG1U5GFbAbfFz43YsOAl66UUJVPHjmFWsZiGwSfk=;
 b=Pp/iWP2TbViAJp7lJmu48RtyBiYg1/r01LY4i+8haNCW2EryxbAVkmc6QacFLoJhqq58iI8XoZzeqtyfYBiLT9zNxFF30aRIJerPFwtzZzLfWyCz+Hm6sQSlOTUBTAKZjZv2Y1l8u8GmL0VsA4djNKzpVBYKx2EhluL8i1EVg+k=
Received: from MW2PR2101MB1130.namprd21.prod.outlook.com (2603:10b6:302:4::15)
 by MWHPR2101MB0810.namprd21.prod.outlook.com (2603:10b6:301:78::39)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Thu, 5 Nov
 2020 22:05:28 +0000
Received: from MW2PR2101MB1130.namprd21.prod.outlook.com
 ([fe80::2c5a:e38c:d8b6:3a4]) by MW2PR2101MB1130.namprd21.prod.outlook.com
 ([fe80::2c5a:e38c:d8b6:3a4%5]) with mapi id 15.20.3564.006; Thu, 5 Nov 2020
 22:05:28 +0000
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [EXTERNAL] Re: Question regarding VIOT proposal
Thread-Topic: [EXTERNAL] Re: Question regarding VIOT proposal
Thread-Index: AdazCIQyX41ICCm/R+W5gs79WO29YQAcViOAABFY4qA=
Date: Thu, 5 Nov 2020 22:05:28 +0000
Message-ID: <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
In-Reply-To: <20201105134503.GA950007@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-05T22:05:25Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6278d91c-89f5-4ef6-8ad8-66ff680b7ede;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2001:4898:80e8:0:2992:fbc2:1fdd:f5b3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec973e2b-968c-4578-7a16-08d881d6e7e6
x-ms-traffictypediagnostic: MWHPR2101MB0810:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR2101MB08109C4D2E0290136AA4B3D480EE0@MWHPR2101MB0810.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eFKkC7jOO9xZRkXJLTb+lNc9d5w0fxwzdfxr81dLlu3uB5XSFT0/yF4wGfwgV49pKgXxxkQiKI7y27wJb4yXF6H7GVZrnVxmZmEABZ+RgvaQARL9Jf/qGLRYhAMPsYEwRZ2HVECFIucd1sMlKXyKd98NLRUHn8hZC3Lc83q9Z0znp04r+m3692mtz/xHw6+BS53kzH5po8NyVBgQa/p5vSgqPX9gzrAE5ivegyZZGBqodapYTrdDEWrwk5E4oXTUQIxjoywuYT+Zze4BjaCu3W/L/f3fX4aS13xZAbE06BEwRHCAuTHLogrhR3wRmotg+Rs4GrD+XPeqeo1kQCvbPkcMphezbbev0F1UC/kL96QKVgXpFbbDv4zT9m/y4iEOj081YKzRZ3Eu5fhO6zkG6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR2101MB1130.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(86362001)(83380400001)(55016002)(6506007)(53546011)(2906002)(82960400001)(186003)(7696005)(82950400001)(8936002)(8990500004)(6916009)(478600001)(9686003)(316002)(66476007)(54906003)(66446008)(66556008)(66946007)(33656002)(76116006)(71200400001)(4326008)(5660300002)(52536014)(8676002)(10290500003)(64756008)(966005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+q0+XmajyLp3eConUjvZZTplF9l792vhS3HgF3IEv5Bg9n/nYpBOgKO9Dbxq?=
 =?us-ascii?Q?0E9bjZ8C9x5g1aX8DFNzR/TZ3qgi/iPriQKXfjUiu26hOAgQh0CEhRDKx2FP?=
 =?us-ascii?Q?M/QZycNAz1eiROB7qjEWYqnzQhvCWA/iFl2v4gpKlzJzx5FuuIGMcS26Dmgc?=
 =?us-ascii?Q?Tjw1Nc6SnckR7ipb8di6Tx5WADPBbkDBM8c/24Dc5ncqHS+/O1EPQViyfUzd?=
 =?us-ascii?Q?gsh2lFMkf71kkqdZ2qEss/MDXGUPlshdDA1/wAJwrz/GOguFcaO/oHZ3ru9V?=
 =?us-ascii?Q?DnYtDf3rttCIyfcxMTzroghYbl7bgwuOVuvwsP2MZ82B14VLKXTd/+pX8X0v?=
 =?us-ascii?Q?hzOI1rs0f5iRPrTdmpxLjxxGXGlz9a++Zf9LAGIdE+wkEopFylzhU+PYcidR?=
 =?us-ascii?Q?fpeehpnttkTwSc5IlIpnofZJMRFKP4odT8ykyAaBIS4OTxG3N/f7CuIga+nI?=
 =?us-ascii?Q?R4XKD1yiN1KZvmdctWZemvW9I+wXTdXbNMCRZqGxkW/dNDty1y1eFJcsaeNP?=
 =?us-ascii?Q?cBl07F6V1eRd4ytS98oOtJI4QUV/HpV9tal2M4l7KUqpOsOfrr0lBV4HTsYh?=
 =?us-ascii?Q?IN+zpXdhrTkT5xcE1ZwMlmywI0FK/dlRD9yissGzzHTHMqnVGpfdwpTXI/jZ?=
 =?us-ascii?Q?500vFlhQGEQI47VaOIDu53W3DkUREjal7rMbtCQxwBEXQKzq+WFiZtNBijW9?=
 =?us-ascii?Q?icq6I4CqV/NoQKe0Z5XtuwEIaF4el4hh611c40/2oBXHu7cbwyfmy4Y7aZuD?=
 =?us-ascii?Q?Mqmsd7u0i4KJjOWI3sqPxf3BbDeTjfVAVQhor/jHYdmxXgTv8pq4GlHiK6fS?=
 =?us-ascii?Q?ayxJDzYjYUirlkOUJDEsLmNuWVQGm6K5GTcqMif4MKmSyv9cniJ1oq1bcR2q?=
 =?us-ascii?Q?6ZFXMyXabhbmx4j96B7s8hF+Aqj7EZo6+bzkHE1JqFOnDQuQJvpsuRVol4sv?=
 =?us-ascii?Q?KEGl404qgrTXC4yNEGp3Gw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1130.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec973e2b-968c-4578-7a16-08d881d6e7e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 22:05:28.5511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFTQ404JPLPFLl9XimQ65cB3Yu3QqehA+FcCULtyx3mnuwreIUNkexQ4VN5XcgikyXGRPfgNCF9wS6UNJxGU0iPSrkWvuIgDmTJwYd5HtYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0810
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>,
 Alexander Grest <Alexander.Grest@microsoft.com>,
 "ahs3@redhat.com" <ahs3@redhat.com>
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
From: Yinghan Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yinghan Yang <Yinghan.Yang@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

Thank you for the clarifications. In cases where a large range of  PCI segments may be assigned to guest, would it make sense to describe this configuration as base + count. Currently, one would have to describe them individually. 

Yinghan

-----Original Message-----
From: Jean-Philippe Brucker <jean-philippe@linaro.org> 
Sent: Thursday, November 5, 2020 5:45 AM
To: Yinghan Yang <Yinghan.Yang@microsoft.com>
Cc: iommu@lists.linux-foundation.org; Alexander Grest <Alexander.Grest@microsoft.com>; eric.auger@redhat.com; jean-philippe@linaro.org; joro@8bytes.org; kevin.tian@intel.com; lorenzo.pieralisi@arm.com; mst@redhat.com; Boeuf, Sebastien <sebastien.boeuf@intel.com>; ahs3@redhat.com
Subject: [EXTERNAL] Re: Question regarding VIOT proposal

Hi,

On Thu, Nov 05, 2020 at 12:13:53AM +0000, Yinghan Yang via iommu wrote:
> Hi iommu developers,
> 
>  
> 
> I have a question regarding the recent VIOT submission for supporting 
> paravirtualized IOMMU in guests. The spec defines PCI Range Node 
> Structure
> (5.2.30.3) that maps to a single PCI segment.

(To provide some context for other readers, a description of the node is available at https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjpbrucker.net%2Fvirtio-iommu%2Fviot%2Fviot-v8.pdf&amp;data=04%7C01%7CYinghan.Yang%40microsoft.com%7Cc52e42b3eb63495ed28708d881910b6f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637401807671941922%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=YiZLS6kKMqe58vPsJFYIfA3nVICc3G44E6bziD3cC94%3D&amp;reserved=0)

> 
>  
> 
> Is it possible for the new table to express that an IOMMU covers all 
> PCI segments?  This could help support scenarios where:
> 
>  
> 
>  1. Devices are dynamically assigned to guests during runtime  2. 
> Devices in the same guests are assigned to different segments.

This is possible with the current descriptor, assuming the PCI segments are static. The platform can provide a PCI Range Node for each segment, with a BDF range 0 - 0xffff. For example a table could describe:

* PCI Range Node
  * PCI Segment: 0
  * BDF start: 0
  * BDF end: 0xffff
  * Endpoint start: 0
  * Output node: &viommu
* PCI Range Node
  * PCI Segment: 1
  * BDF start: 0
  * BDF end: 0xffff
  * Endpoint start: 0x10000
  * Output node: &viommu
* viommu Node

Then the IOMMU covers all PCI devices on the two segments. To identify a device when configuring DMA translation, the IOMMU driver builds a 32-bit endpoint ID = Endpoint start + BDF.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
