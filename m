Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DE8C433E1
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 23:45:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AFC2065D
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 23:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="AvX1mS1H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="BjzGG/PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AFC2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9B960882E3;
	Tue, 21 Jul 2020 23:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GDQVbO9kExx9; Tue, 21 Jul 2020 23:45:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AC87985F9B;
	Tue, 21 Jul 2020 23:45:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DFECC088E;
	Tue, 21 Jul 2020 23:45:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97CE6C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9228586B13
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4AclfGwDDUsf for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 23:45:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7DA8886B10
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:45:29 +0000 (UTC)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06LNfSUF022639; Tue, 21 Jul 2020 19:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=d1NnGQDbcyoHgZFB3bgsugHJcB6GbPyi41eIJe6p5Ys=;
 b=AvX1mS1HQFsRyzBnfJTCr2p5nUAASpSBZGZNab3xIYWYfmIkUt6JwDauElXu0t7OFDVO
 7jifhcs8DmMnUnggBZKXk4p0PkVJaeE8Rf/t+EAI7qbjjPnR7rJ2h1Lv8H9nUvrFpbWR
 HvLG6vyE5MoV4xpmgK6a+bwn5InKJYkOCrU3+OaGJVk+6X68JMm0pCy8zxoBYcXaNp/J
 2f/WW3C2FgwvpwoBfuXl+K4fHdeUyuO6+X+vAcT3X5CtOADwvgWPspmg9dcD6oMTnl+1
 fZ2H93xHXegh6IWOUm6JLbTs2aXGBpKnUBRPP8QITft76yJ+cJznRG3AS8et3BOkASko WA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 32bw3k2mm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 19:45:21 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06LNivRN028672; Tue, 21 Jul 2020 19:45:20 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
 by mx0a-00154901.pphosted.com with ESMTP id 32e9s8gagk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2020 19:45:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeTt/nmhu4LpduE25uZFlAE9SW6HOBQcoD75W6d1D6pQMx1qIHS8/XEAxpKL25SjmFNn/evMCP/kqG8/4Rbt7/Mi3zplIIfcfr0ZZ4Mvm3gv1As3h8EvshBNS52kNb8vdkarhopIDxoMiKiHe9gzX5TNpavzGfwVPK3DnEns++0MT1y7dMOBVlXfNHi0S6ttkj9wNv8egpCJ3oMzYmZZBczeEFB87UVZ6HDAOeVbwXGpJhmnjQyWDZPPGihPo963CN5UI9ovnWonMZyEFt+gM+FQmw9GdgXDUrmGpNgisI0Mh0N3wsviXfTI3tK0lTWMNEpK8J1KxCjq7BI2MNJSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1NnGQDbcyoHgZFB3bgsugHJcB6GbPyi41eIJe6p5Ys=;
 b=LBgYD9a+qzNCETq+uhqaFMTbC7J5H2BZGBEFdCZ5ShdpDQ2yz/GqtI9uGRmY2TSVjUddv/fx6eJbcPJgJgBNgycPjtgBm3ifMEBhtgKfOQw2PZWBoV2AxGtK5IeTRR2KHHha5tOG91B2AmqIW6ux1HNkLKxG7vKSIZ42Rg5pGtdv3rtBbFZXx4bs6+JcO8SPh3Vg/zxOAcuCkRFHtGJqcCwELzxP4I/vf0vGfcYk92FiX8Rash3NGRaLRyJroFNwyF/qTcshmcXy0DVr/NU2bF1OQwK6g1Bs42ht3l/WyhlQTeVfsp4I5z+wOa/KVJ0EWEsT5584/Zu1mKmsh/03qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1NnGQDbcyoHgZFB3bgsugHJcB6GbPyi41eIJe6p5Ys=;
 b=BjzGG/PJF+wBQ8D7IZ+c/EUb7715ZEUrcYVnC5+J7IjmVBMMYFG0gIiEYjr6M9E3dyJrpLCXA/MFbLO5wdymLpFurD9JBmQ28MlGHHsFjNqIa1OXFCuGjOkbpjbzjI0RzWufa7TIK1EXu7+5IM5XCgqqUSXlVyUZvNL1lwWLoUs=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3628.namprd19.prod.outlook.com (2603:10b6:5:1dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 23:45:17 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::f1c7:5bf4:a3b:ff40]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::f1c7:5bf4:a3b:ff40%6]) with mapi id 15.20.3195.022; Tue, 21 Jul 2020
 23:45:17 +0000
From: "Limonciello, Mario" <Mario.Limonciello@dell.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky gfx dedicated
 iommu
Thread-Topic: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky gfx
 dedicated iommu
Thread-Index: AQErn65qGPIxx4/vDRlqxKGcSijyaKpnmsGwgACNHwCAAAmvIA==
Date: Tue, 21 Jul 2020 23:45:17 +0000
Message-ID: <DM6PR19MB263622CA8CAA7CDA3973E0DBFA780@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200721001713.24282-1-baolu.lu@linux.intel.com>
 <DM6PR19MB2636D1CC549743E2113C0EAFFA780@DM6PR19MB2636.namprd19.prod.outlook.com>
 <d8548318-ee2e-ca3f-cb0a-e219ce23d471@linux.intel.com>
In-Reply-To: <d8548318-ee2e-ca3f-cb0a-e219ce23d471@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-07-21T23:45:15.7100149Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=4b8a033c-1b1a-41f2-8df9-fcfe4756eda9;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec5b67ac-6034-4030-fd55-08d82dd01f95
x-ms-traffictypediagnostic: DM6PR19MB3628:
x-microsoft-antispam-prvs: <DM6PR19MB36289AD87963AA20B5D39514FA780@DM6PR19MB3628.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T2TeGQsaVfP6mkBJoVnV1nY2HzcCNEmkpwXfBY6Y7b7ldFZx26AAfhD8G+ZpBxHAXUiAJ4H7L/pmREGe7e/TlDRU6W18V9QuwN139gT7bY1JUPJ6yAK2ANeDiCFxVO41Egi8I7c8AOpnucfVhjmYEJ4HfLIXUgvRHu+NIY0M/F3Mr1g1EIIRGXHxrGFtJv/Z/FAO8CDbIRIM3Qgh2ZYpsPlJXk6vkhN0RN1cuyH2dq2m6fg2jFJ/w/jilc3EdDMZ02IrbJktwNTTI0NKqi+wtIwjFWeOwWrk/l/+T1gjXbgY9I1Ys688PKfHiQICd+O+0SGiE+Px9wjx6RD+6KYZA60x42xjSHzoGGVJrpPdjXv+6ckCE/VRjpG9MimMbM94EDJPehEw21qUcYgs1e+F7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB2636.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39850400004)(366004)(136003)(396003)(346002)(376002)(66446008)(64756008)(66946007)(66556008)(66476007)(26005)(316002)(71200400001)(54906003)(786003)(478600001)(110136005)(9686003)(76116006)(86362001)(966005)(52536014)(83380400001)(55016002)(7696005)(6506007)(5660300002)(2906002)(4326008)(8676002)(53546011)(186003)(8936002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: T9Rim8TBp6qN+5r4yXtkImhbOdfYip17WEA7NFZetx3Loeop0YJiu/sm0nYw8GTAIQ+0BuIO4PT8KvXXk3yTWT2SBbE55HrCVf+Me09vS3nLLvCP6Ou6eYqNijTtfqwsIBU+WFoEyXdEazRnUew8c0+fAWG3wHVninoADe7wC0tQW5XkcxW6iciZDOqpdFE3SffeK9difLbHfVvcCu3cZogKeL8KahULr3vA38krCD2TW11OAU7WJ9+SVR9NQ2skdKon8Lau3hV6AMVXiK1s57SIXWxP5dEy4isgZaGh+3GTk0zctcDoRXhDzgx/ErF/WByyjsIqmPLp68veIhCY1mGP+Y4g0LW6agy7ZE0riaipdB/eNlxpw7UKhndBJ7NtSnT1BoUsZlo/aSxesfhEDXE8H8okotbJyiPtjtJLkTYtaPTBv7YNGAJbsnlXvUv9fM1zNZDxQl10XuZiqHKSGBNM++GRfUr9gYx8/x7hCdvPWXPLc+YtPyN5p/HBXsWl
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5b67ac-6034-4030-fd55-08d82dd01f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 23:45:17.8136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFfyZBMQENAArxcKDF3sSmG+Bv6UlJSKfFkJ1shCdCnjFEMY2kWq01Yj4f6ycKMR9wVt3/zLXV0F8GaAcqpEZghiczG1F9UpcRnBn209z5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3628
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-21_15:2020-07-21,
 2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210149
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210149
Cc: Ashok Raj <ashok.raj@intel.com>, Christian Kellner <ckellner@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Koba Ko <koba.ko@canonical.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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



> -----Original Message-----
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, July 21, 2020 6:07 PM
> To: Limonciello, Mario; Joerg Roedel
> Cc: baolu.lu@linux.intel.com; Ashok Raj; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; Koba Ko; iommu@lists.linux-foundation.org
> Subject: Re: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky gfx dedicated
> iommu
> 
> 
> [EXTERNAL EMAIL]
> 
> Hi Limonciello,
> 
> On 7/21/20 10:44 PM, Limonciello, Mario wrote:
> >> -----Original Message-----
> >> From: iommu<iommu-bounces@lists.linux-foundation.org>  On Behalf Of Lu
> >> Baolu
> >> Sent: Monday, July 20, 2020 7:17 PM
> >> To: Joerg Roedel
> >> Cc: Ashok Raj;linux-kernel@vger.kernel.org;stable@vger.kernel.org; Koba
> >> Ko;iommu@lists.linux-foundation.org
> >> Subject: [PATCH 1/1] iommu/vt-d: Skip TE disabling on quirky gfx dedicated
> >> iommu
> >>
> >> The VT-d spec requires (10.4.4 Global Command Register, TE field) that:
> >>
> >> Hardware implementations supporting DMA draining must drain any in-flight
> >> DMA read/write requests queued within the Root-Complex before completing
> >> the translation enable command and reflecting the status of the command
> >> through the TES field in the Global Status register.
> >>
> >> Unfortunately, some integrated graphic devices fail to do so after some
> >> kind of power state transition. As the result, the system might stuck in
> >> iommu_disable_translation(), waiting for the completion of TE transition.
> >>
> >> This provides a quirk list for those devices and skips TE disabling if
> >> the qurik hits.
> >>
> >> Fixes:https://bugzilla.kernel.org/show_bug.cgi?id=208363
> > That one is for TGL.
> >
> > I think you also want to add this one for ICL:
> > Fixes:https://bugzilla.kernel.org/show_bug.cgi?id=206571
> >
> 
> Do you mean someone have tested that this patch also fixes the problem
> described in 206571?
> 

Yes, confusingly https://bugzilla.kernel.org/show_bug.cgi?id=208363#c31 actually
is the XPS 9300 ICL system and issue.

I also have a private confirmation from another person that it resolves it for
them on another ICL platform.

Christian, maybe you can add a tested by clause for the ICL testing.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
