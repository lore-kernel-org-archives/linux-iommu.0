Return-Path: <SRS0=gcKa=FI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C1DC4361A
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C882222CE3
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C882222CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5BFB187D3A;
	Fri,  4 Dec 2020 20:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hBjciWACMtz; Fri,  4 Dec 2020 20:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7919687D3D;
	Fri,  4 Dec 2020 20:48:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD8AC0FA8;
	Fri,  4 Dec 2020 20:48:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B635EC013B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 20:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A415B8723E
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 20:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VzNqemTZxtkf for <iommu@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 20:48:38 +0000 (UTC)
X-Greylist: delayed 02:18:47 by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9593286846
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 20:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7e9dAhfPX8Q1FnZqN7NC9YLUf6jjHdUebWGEA2LwYWV8ZQyIdRY32/20g2bX2uuU7TFrwWRqZhYfhmP4UBsVQoKYP5UHTrA0apJJvvmaJxWyvdoWEl+JIup2L+boJ9K+CQdRKzgw1KPpRk6QHZfRv21UkVfg/tYQ1rCUcku+2L9tschGiZEaMq2sorH6DpuCApKwAsewHrCiShZtONL3K/d2Yk59cM/R50tqAWIHpWTR59QWWcw8BFarB2W8VOCd/2x71lcyJgENJEFwC+ryR7JsdA7f2qwsWv45DFgBUk259TWtSTjufSiYzNiEzYYijfHEu1W+xoUwt89zbgM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elhOnT4xXlgDtZ93FzQ0XW8MjAp+zNVFOlz/yWDkxV4=;
 b=A7sQIRXAD8vwMKUEUwXFX3WaLncecKJxVdHyoyNJY1wXPHvAEJF0irnkBxJVoImhHb7yrZmnuBJRNZnhNvbMC7h8iii+kLeWYG+6ATdPKLW8GLauCmG5qnyFSvMsfw+X3NKIlj/7d+iaDNY2jUOK2xnhMPpDbNsf+GNYgeek/WAGQ61qJKTkIJtePFaa9VzaMqjb7QStIDghDgeORBfWG49ExUwNcjG46dhwtkH/PCwNZ+KJu9VHBwZmDncOCpyaWC/9fir+C4gyZhIGph2WzKMX3Jn3JepMjk9KUmelLpj6WnrwvkJDTOebBhGXfvrxCV80B/fnoX+24kP+bZSGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elhOnT4xXlgDtZ93FzQ0XW8MjAp+zNVFOlz/yWDkxV4=;
 b=VMNFrGH9QfKh39kBMdDZP4dmB1FSCbZsXHej6BsKdOJCtPCGAHdTbvM5AW7Z2UhhkhClmO9P3iaXB053fmudcJOPZB87kIJFvvVVp+2JDpCPTBgX5GrtvbSKkzoQWlzADgEnjORkrZhpKlBXk7zzlrwzGZ67f0BpiJDLEAEA4UY=
Received: from (2603:10b6:302:4::15) by
 MW2PR2101MB1050.namprd21.prod.outlook.com (2603:10b6:302:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5; Fri, 4 Dec
 2020 18:15:44 +0000
Received: from MW2PR2101MB1130.namprd21.prod.outlook.com
 ([fe80::2c5a:e38c:d8b6:3a4]) by MW2PR2101MB1130.namprd21.prod.outlook.com
 ([fe80::2c5a:e38c:d8b6:3a4%6]) with mapi id 15.20.3654.008; Fri, 4 Dec 2020
 18:15:44 +0000
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, Al Stone
 <ahs3@redhat.com>
Subject: RE: [EXTERNAL] Re: Question regarding VIOT proposal
Thread-Topic: [EXTERNAL] Re: Question regarding VIOT proposal
Thread-Index: AdazCIQyX41ICCm/R+W5gs79WO29YQAcViOAABFY4qAAIWNEgAVfUMIAAAGKl4AAKBd5AAAANcFw
Date: Fri, 4 Dec 2020 18:15:44 +0000
Message-ID: <MW2PR2101MB1130E163633020AC95E57AB080F11@MW2PR2101MB1130.namprd21.prod.outlook.com>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com> <20201204180924.GA1922896@myrica>
In-Reply-To: <20201204180924.GA1922896@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-04T18:15:42Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1d5da008-13e7-4861-b6ea-bc4b47e6544c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2001:4898:80e8:2:37:c37b:77a3:1a3e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b49ea25-4e57-4d7c-a4f4-08d898809e26
x-ms-traffictypediagnostic: MW2PR2101MB1050:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1050ED66B55C68E60CB98E1980F11@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VmW8EXx9QN/GV4XDjds8hsI9v2XzjOi+84pHzFJHJ0avP1v2EdNDb+7n/LPHGQTWVpE7QFtPI4dMYdooWkAG+3HkkTlMgrgvOX4CEy7GVfpDzNK/08NGE4XvW1Rhi2K2FmAN7gAzZZdc5ZVJ0wQzOqrHco4Hb0TRrbGIrVmbw9EvYMejD5U7jVY6LJ2UuOi7EfR7Bjd4khQRNr9Wgjwb+1/zO/6C4l66h8lzGzwIzwH3leXG44i0ypyB4s9nbFE/RCpC/BIg9M+AV5xI5NYo8g7d1paksgYAkQ0h9cd/HoeukNenDCJRHJQ4X+9Kz/IgNcZFH6olsIqFuqY4KqCfHNfDOgqtMtN5kMHYuODpfLkb4lG7TzZQuEbu5K2r+Y6AkVZ7YCUiMfXVZkWWwQF0Yw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR2101MB1130.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(55016002)(82960400001)(53546011)(8990500004)(186003)(9686003)(66446008)(76116006)(33656002)(7696005)(66556008)(478600001)(82950400001)(8936002)(966005)(316002)(2906002)(6506007)(86362001)(4326008)(10290500003)(66476007)(52536014)(83380400001)(71200400001)(5660300002)(64756008)(66946007)(8676002)(110136005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?S/UXnaInT7dRCe6JyXIUP2BXGq4ICqGlc9vWq766E8Rz3knkHyVO6TPgHsgT?=
 =?us-ascii?Q?eutoenOpJdb6suJRLgcd77GOeozNl6NKBjoUvZ2Dtg6xOG4lKRiTaOs8SGoY?=
 =?us-ascii?Q?iD/1x9PW3HM7mYxSamQMpD+gzrBcEmnXDxew1fGDqvR3buDrjLFJD9/srImK?=
 =?us-ascii?Q?L8WGkeOspsSrku+MRhoHy0MMU8Wrt4O7plhhfslgnyDXfH2cgX9EaIdvIMBX?=
 =?us-ascii?Q?yraPHw/V7KJAZQsA3kuHV0241R4B24wl2tY/tpnSN3KEDZ7xTZ1avrrh2y4l?=
 =?us-ascii?Q?7wBioP+BAx5hz77VXO/I7IHxV+GH0OivJDPLEqMqAmhFKVo54jY6cll5OaW5?=
 =?us-ascii?Q?K/NFXUiwBUn/fJLRcxUYu4hcAWQZ1Xbqs8BT8oiVLBkI40QPA+Lpn6zxh64I?=
 =?us-ascii?Q?hxYG5klbv6NGc1RHSzlgcPmeVDL094BovKWyIu0LxeZ5YLxOvOQJ94kW91tN?=
 =?us-ascii?Q?uUHC/xe9C93lmHBwTKVdmp0mUNmru1fLTdKhMU07cSClwGXijdUsfV3hnNcC?=
 =?us-ascii?Q?dBnYh4QH/Ua287ZP0ArCCvzTLQoQ0JFvlD1t96fk8x+CrTzjtMNBbF6RAEzQ?=
 =?us-ascii?Q?KktHbSvOpuv1q2CP7R5uWQPqV/J57CgxKUebsx58tai4+/UZpR3JDBAsNF0u?=
 =?us-ascii?Q?VZdb0rUcBmM04ZsDjMPTRKYV4IZeryxcstiRulfBbaJ6ZZneaAgaKsGe9lsP?=
 =?us-ascii?Q?ITlHrYkT0tAWdo0olr64eLubE4BKD/Ch71127IGGXN7I103plcjKhJ0uFxRg?=
 =?us-ascii?Q?r6A3o7CPsY4UIzEPvIq5VmyookxSXM/SXVnRp4Vf1jv9qVtg71tWMPSCBLvI?=
 =?us-ascii?Q?fw/kD/YLqkwqsgtfm0WHNTeOitK0gQhBumTEkxUCIsH9c6Uy63p/UBL20HM+?=
 =?us-ascii?Q?0y34hf9M4MvTKYbuqNptxzEnaE5cQu0nhngkVPuItSCC2WBqYSBKJn3qQ0Pc?=
 =?us-ascii?Q?S+6em588CAwn422IopqBZHa8OZiCvzvemdc9OSrD59GMrAxe24ez68UcOD43?=
 =?us-ascii?Q?KCTz/FzPLgb/UzsPmx+Z3QmEYh16Es+IMt3oCIjPKzdgmQ0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1130.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b49ea25-4e57-4d7c-a4f4-08d898809e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 18:15:44.8264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzzF3wx49tIrt2ZlQAMDyHh0U8PrWwCeX60Qi7dWsSjnOFBjF3a4gDNeIUpXzmYoBSn4wghtvq+mCbBPCP8hkkqcGLitHP54TXWgFdVCtU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>,
 Alexander Grest <Alexander.Grest@microsoft.com>
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

Thank you Jean.

Yinghan

-----Original Message-----
From: Jean-Philippe Brucker <jean-philippe@linaro.org> 
Sent: Friday, December 4, 2020 10:09 AM
To: Al Stone <ahs3@redhat.com>
Cc: Yinghan Yang <Yinghan.Yang@microsoft.com>; iommu@lists.linux-foundation.org; Alexander Grest <Alexander.Grest@microsoft.com>; eric.auger@redhat.com; joro@8bytes.org; kevin.tian@intel.com; lorenzo.pieralisi@arm.com; mst@redhat.com; Boeuf, Sebastien <sebastien.boeuf@intel.com>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal

Hi,

On Thu, Dec 03, 2020 at 04:01:27PM -0700, Al Stone wrote:
> On 03 Dec 2020 22:21, Yinghan Yang wrote:
> > Hi Jean,
> > 
> > I'm sorry for the delayed response. I think the new "PCI range node" description makes sense. Could you please make this change in the proposal?
> > 
> > Other than that, the proposal looks good to go.

Thanks for the feedback, I made the change

> > 
> > Thanks,
> > Yinghan
> 
> Jean, were you going to update your existing doc first?  If you do 
> that, then I can cut and paste the changes into the existing ASWG 
> proposal.  Or do you need to send out an RFC to the mailing list first 
> and finalize it there?

I updated the doc: https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjpbrucker.net%2Fvirtio-iommu%2Fviot%2Fviot-v9.pdf&amp;data=04%7C01%7CYinghan.Yang%40microsoft.com%7C91f189f2a0814e6743c308d8987fc809%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C1%7C637427022395762927%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uB0xVHvFdF1wkb2D4KJFW8JMGNtiT3tAsoNVU%2FdLlLA%3D&amp;reserved=0
You can incorporate it into the ASWG proposal.
Changes since v8:
* One typo (s/programing/programming/)
* Modified the PCI Range node to include a segment range.

I also updated the Linux and QEMU implementations on branch virtio-iommu/devel in https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjpbrucker.net%2Fgit%2Flinux%2F&amp;data=04%7C01%7CYinghan.Yang%40microsoft.com%7C91f189f2a0814e6743c308d8987fc809%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C1%7C637427022395762927%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8OS6A%2Bw1r77hiWIhUWGiUU1rZTXh0Qmx%2Fu7LzIIOalo%3D&amp;reserved=0 and
https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjpbrucker.net%2Fgit%2Fqemu%2F&amp;data=04%7C01%7CYinghan.Yang%40microsoft.com%7C91f189f2a0814e6743c308d8987fc809%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C1%7C637427022395762927%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qAX7dTxzkA%2FcqUg2urWipPv%2BCdu5yxuWGt3ndBYlQKU%3D&amp;reserved=0

Thanks again for helping with this

Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
