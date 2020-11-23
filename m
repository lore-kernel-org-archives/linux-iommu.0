Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882FBC2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 06:41:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9727920758
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 06:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emerson.onmicrosoft.com header.i=@emerson.onmicrosoft.com header.b="hyXiZwFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9727920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 13EF7866C4;
	Mon, 23 Nov 2020 06:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1iMhDfz4aFU; Mon, 23 Nov 2020 06:41:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3EBAB86691;
	Mon, 23 Nov 2020 06:41:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C46DC163C;
	Mon, 23 Nov 2020 06:41:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3EA4C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 06:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C635E87070
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 06:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0uBnJKar6EI9 for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 06:41:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com
 [148.163.142.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 040558706A
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 06:41:21 +0000 (UTC)
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0AN6SgE8132350; Mon, 23 Nov 2020 06:41:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
 by mx0b-00300601.pphosted.com with ESMTP id 34ycp8bdcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2020 06:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvnCUl+jDRA675PsxBJFEad0zc9Dw1v8iTSk1/Z+prdloqkcYDrrgnJ4m7saQlukq/BGTSqXqVGXS5m0/osSvaru51MwhiZaOBEzTzzO+2ymibXVnQO3qFxKmxwZx5cRmoKfp7NneXcGFDpmr4nxM7IK1OcfWeTV46CMDJd3qpo1K0QK5Ki6nwcKzIHy3di7fmqgt15s0GyofA4DVO7whXf5pmXd9Ipe31ozug19ZMUt4RxAjgk4lR346RA5QoLd1xYE3rmOF+xRPaozA1E8UFazpXsCvpx7ii7GCH80ygsnaWi/UEzQeSUl0xGeB0KUH+DnXI2mL8qhooHyisX3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZEJPtn+gJe1iUdwxo/RmNAWJaGhQ8pQkbNh3JqrzHw=;
 b=KcWYfFIGh7fwAWCf7uU+PanRItDkeUvgkStRzYkgrnzK0oEhskxmXEzlWfreIaDnnbEy2ixnexjHnM04zyr6KaV1xqSwf/RAaWHmaPqwESu7vtMxEMA/sJGx7rud44AqY+7IbP5UR7Qv6t2YL0SMy5BVR4xYeCWuRVd448sn0dLvF0pfixzVPWUYA0hxbI2sSgQD/yjmZp29NTCJ+fYg0lMW0+Xq5uwxjkC/P+hujLg/aN6Y+s1sOjy8xcNWwS95Jn2FkjkFo6IMWOG9DlTUdnrPL9twFecIpsQAVBCM5I1icsnwDEOhBu9tmp703co8mUsqyvXJBtkeKprey8KNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZEJPtn+gJe1iUdwxo/RmNAWJaGhQ8pQkbNh3JqrzHw=;
 b=hyXiZwFwhviQR74pMb43Da9yIT6aXxbbholMy6ftuEcYmE3lWKN3lUuk0SUpCvmQB0s/Jny3NbBnmRATtfHqybihiFyyzMEel3Ka0QGcYsWueq1LsmcPSMCZfpoSAYOdcmq2/xs77BRJ6NwDqBgtWI2hJQBj/cE5GbSAPla2vG4=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by MWHPR10MB1744.namprd10.prod.outlook.com (2603:10b6:301:b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Mon, 23 Nov
 2020 06:41:19 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 06:41:19 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Topic: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Index: Adaux7yL4OYKNrMETgKrPGK8SdhnWADwCzYAAADVBeAAAgZUAAAHYTJQAAGocXAAKw/AQAABvexwAAFDxYAAJDqaYAANk5QAAAF+N6AAAkOogAAAvS+wAAAsw4AAg9wdYALCm/TQ
Date: Mon, 23 Nov 2020 06:41:18 +0000
Message-ID: <MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <MWHPR10MB13108FAFDAD3D33132B6593489EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13106AFEA3B68E666DD9CA6089EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13107C8A602FD7EE065F4E3D89EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB1310AA6CDF577A1535600F7089EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201105123245.GS22179@suse.de>
 <MWHPR10MB1310C1E8308484E2F7F967E889ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106121850.GT22179@suse.de>
 <MWHPR10MB1310A315F2AB752DC789D4E689ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106140625.GU22179@suse.de>
 <MWHPR10MB131028067DF3AB908DEFC08689ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106143235.GV22179@suse.de>
 <MWHPR10MB1310643A00144144FE37505A89EA0@MWHPR10MB1310.namprd10.prod.outlook.com>
In-Reply-To: <MWHPR10MB1310643A00144144FE37505A89EA0@MWHPR10MB1310.namprd10.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [2a00:79c0:799:5900:8c27:f32f:5d32:791b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f34b94ab-8eef-4525-18ac-08d88f7ac8c5
x-ms-traffictypediagnostic: MWHPR10MB1744:
x-microsoft-antispam-prvs: <MWHPR10MB17448B1BBFCCC766CFD2A54F89FC0@MWHPR10MB1744.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HwvZR42MELFsODMjAHwXycmuJRZs8ru06f/7RZVOu6/KfLS2q4ol38Z2DefdRY+xklEjzZdLnbEIPKH+sEBzpo7qjYIUsxEXZLJvDmPXJ9r2r0PYDTt4RYAEtf34PL2u2fyfgbShGGuNBNXCThEmHpzNFdPfClUuWe7SMKIpJT0rkdJXccsYHwI1IOB48DcPt5tGGYq0+8jEWo6eF+bh0QzpmXhaFZjd0/m+S8AuntrKpWYjtCYTINO+d4Bradvt0jXAH4NBc5DMkwplrvS7KZeQe1pn46Qpn3uGPOPT1LPMqouVXseGzoye09kBe8EK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(346002)(396003)(136003)(39860400002)(186003)(316002)(4326008)(33656002)(9686003)(8676002)(8936002)(6916009)(6506007)(478600001)(53546011)(7696005)(55016002)(64756008)(52536014)(5660300002)(66446008)(2906002)(71200400001)(66476007)(83380400001)(66946007)(66574015)(76116006)(66556008)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4Ao/27O2oZ/oDqjTjpdZdqEiJoXvoLEOLEoZE8XquEEGrzrMMmhH5uGoUnOENDWz8C5fYk0zKXC1TBj60HospaqHLBT1nLBs1rhzA3UavEhgrkTpJh+z5rllr5mzTzid+BbP8VEPqhyvzUB5+LQXKJyzZ/I23Nn2Ym0atqhkX7E6xq3RvOa32b6BHEgqSiHf2D/CAT6vQexa+9Odn80TeZj4zg9bYt+kHcIKSGF0dqsMLzSv/icXPchvR3vKItYymEo3DRS+Cl+1OGEj2D5SpbiBhktLQ0F/KsHrs3PcJgcqeeAZI33OXnHkoNq0b5fwVqPQ3F+fh95Q15O73TpWwcPiz/N7Ln+jvmeHoubayGyPwXruQ1rgpTp4IkbGDrpcSA/M3iOmlq9M9pa26qycXdvIhRtJAgJtovfNO7cE93/cWfksqKrDMmpPHjLvgLFxENiD8WBhh9fCYIvPLI7Ymq6By8WGdfxqAaBuxO5hUZTu1eI5+KHpa9+1HOZftI+4HB7fklFFQ8PNJHI4RFbpqCfpRhJz0zLZJv5v2T8k0BAKFOa+KpArd5zWSXQ4eIbUBeafOeC7huZc/puQus18nAznKzRHW2slv1JlsPeLfd1JYxBiO4mqSTNO3VJdtQZ6Cpig0He1oa3MMbEGd8ZwD4jv1/+Q69bkwcOX9bHa7++GvB6RGJlG4FpL/FmgcSvIp7ozIQymFIcLxr7qMFMp2A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34b94ab-8eef-4525-18ac-08d88f7ac8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 06:41:18.8737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGhdr8JNbX89vUXx+YeHNEFvzO7Cy6w0ZlH800FGKZs+YFKQ+A+dhbbft6mVKJk7BhJ/O0qdlzK3W82OB3aXxHxHIBwQOmbm9r5lIy7wPb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1744
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-23_02:2020-11-20,
 2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230045
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello Joerg,

Just wanted to follow-up on that topic.
Is that quirk already put into upstream kernel?

Best regards,
Edgar

-----Original Message-----
From: Merger, Edgar [AUTOSOL/MAS/AUGS] =

Sent: Montag, 9. November 2020 06:33
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org
Subject: RE: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled

> Yes, but please test it first. It should apply on-top of a 5.9.3 kernel.
I applied that patch. It ran successfully for ~7 hours now in a reboot test=
. Normally it would stop and fail after 2 hours. It is continuously running=
 that reboot test or a power cycle test so I will see right away if it fail=
s. =

I am in contact to folks from AMD on this. What would be the correct wordin=
g to tell them, how this has been resolved now? =


Thank you very much J=F6rg!

-----Original Message-----
From: jroedel@suse.de <jroedel@suse.de> =

Sent: Freitag, 6. November 2020 15:33
To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
Cc: iommu@lists.linux-foundation.org
Subject: Re: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled

On Fri, Nov 06, 2020 at 02:28:27PM +0000, Merger, Edgar [AUTOSOL/MAS/AUGS] =
wrote:
> Alright, so is this going to make it into an upstream-Kernel?

Yes, but please test it first. It should apply on-top of a 5.9.3 kernel.
If it works I can send a patch and will Cc you as well as a few other folks.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
