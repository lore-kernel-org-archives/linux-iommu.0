Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8943C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 20:26:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C48C233FC
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 20:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C48C233FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DFFDA85258;
	Wed, 20 Jan 2021 20:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OhaI6ifGkKPI; Wed, 20 Jan 2021 20:26:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 51A7A84836;
	Wed, 20 Jan 2021 20:26:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AC26C08A1;
	Wed, 20 Jan 2021 20:26:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC036C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 20:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C31522036E
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 20:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N5BXa2-73e0S for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 20:25:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by silver.osuosl.org (Postfix) with ESMTPS id AE3A020357
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 20:25:57 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KJxWZW020291;
 Wed, 20 Jan 2021 20:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lQvhvbRjb4peCPtv/ZwGm9N/hHBLeifWQaYvfcGCON4=;
 b=wFJJ+KBX6nRHoOUb2SVbN47gIU8Lfd/n9u8HQCqHn8A9PUmnU8RhYj8Np1Vzsa3YqkYV
 QcGJate1spuNjMHwJkkjgITyg5oHVlmueI573Vx4vQ88sHDpDZLsQgbzddGf/71n1wqw
 vO33B0jJQ20EN8ho1H+qhXRbCljA2lsm06RJmXcr3aGOgVRhSNTogfdyqckucYy6ENeg
 One0peFIUcCeDgIPHrPhKhw13mAFx0GpWhpDgY87NVsQuxRcStGhWYDG/5S/N6ylNa3b
 N4rj7cTjpvlJIjUn+IZdKdcTeQ4Qa9sCA/WAFcRR4QA+PoqruifbvUvTEycq9/cItPi1 BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 3668qacadv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Jan 2021 20:25:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KK0gJF135473;
 Wed, 20 Jan 2021 20:25:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by aserp3030.oracle.com with ESMTP id 3668qvv93u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Jan 2021 20:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq4QfNpwtqlgOwL58diAlAo+Pyw0eq6Qx23xz+Q+SI0hteMfUZKJ4oHoRxEo5l8Q6ndDqzXkRwbCauKPJJeAMLv289Yp1i+qO3CGah/oipZeLi7RnQ6OiG66grkpl2LHfqVw3XLxdnwX/Y2Q+CBsm+cPRIsxlnjiAMjRsPeU/WQAYMBhUFEghcCSHwAm5l5xyow2IGY6rJ07s+yKBX0SljYGvHmvycO4dt1mk3BzjfQOWeJArX+rRTW4UfClwRBIWJb6rnTc4Y7x/kBxrv+MuVoyF2KpjymNVjloYGkIdwpzN7tS5TzRRLW6HFlYesNV8sZDNwftobo6iq6/0Cdd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQvhvbRjb4peCPtv/ZwGm9N/hHBLeifWQaYvfcGCON4=;
 b=EBuvyjpHN0HNmp0JzZm4+jOJeiQw4E9QBjYQKSFix1+gPX1CwjFjCyK/6J1SKFOauIBHPL2IuqodG55WjoRF/hNpLwdkw4VHyXkDv76XiHJiiWDYyl+2LkbMa0G3jJ4Y5spC3m4NtlG2jl0QNqHwkYypPICwPQztYMz1uQmuu8fZ5D9pJea5HQ/sIMceaU4YrL7GI3MDs/qk+8yyF3n58+PB4JsCQw8GwJ9BE9OIl96VpapxMCoPIS9Z/hn/WaHgezDAbtwllulxVjMTPTtaoKMvMTtR7lueY3OVIqqnA4G/uNjLSLKQ4njGndGT3AWpRItSHPopgBVrIyFTkBNYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQvhvbRjb4peCPtv/ZwGm9N/hHBLeifWQaYvfcGCON4=;
 b=x9VOgnBWFcSBtdHSdnxZ+CuLMOWwdLMSNgFvt7E3JpNnW8ZrPw/Kh5bcviGS3YH1gmqAT2fQ9Dp5CApnN5KeClIgopBmpHFBu+k2veljSeYvrwe6VqzbCt46YmfnnekTiwVdape79qDwmbbRJNOkEA02ezGzer8xNo/6Y9VljBQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 20:25:43 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 20:25:43 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
Thread-Topic: performance regression noted in v5.11-rc after c062db039f40
Thread-Index: AQHW7tKvBQQTuiJM7EWdlhiEV8dliKow9zMA
Date: Wed, 20 Jan 2021 20:25:42 +0000
Message-ID: <A8F9F581-B997-4A6C-BE11-0D67EFDDC204@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
 <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
 <603D10B9-5089-4CC3-B940-5646881BBA89@oracle.com>
 <1107f22e-c01e-0dbd-4286-3a264b36e4e4@linux.intel.com>
In-Reply-To: <1107f22e-c01e-0dbd-4286-3a264b36e4e4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=oracle.com; 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73cdab0a-b542-4256-45ee-08d8bd818f92
x-ms-traffictypediagnostic: BY5PR10MB4386:
x-microsoft-antispam-prvs: <BY5PR10MB438667E550D4D7B6ED2BB26793A29@BY5PR10MB4386.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIFB3w+CvHBkixh4PHsR1IanDH9D4f+bylbAtHIAcKR5Dbp62Fuizf5D/tHQs7IgLiX+ucMBQHZN+VQ5vNrQy5RTIf+FYY10zbSVuD/mlGAqhHUtBPGdgKiVM8jxE+B0R9kU7xCrwcooHpz/VgsI17ahXqxqRFw4NComh/1gTYIoxgWmRZft/p/ascBVg1VoiLUEm0u7gNTi6vRHuL8r8loJp8srYOcrcP9lmcTwBrC7tNrkOE9xjwCURijBl/riIlznsVJoaQ7xW2hkL+CFlUMSprOhf79XPcANGa0qs664qAIFyOfdxzSRWjkRpfRv4P285o3t7Nn2A2rDgbDLkTZ1iMg21zMHv3UF2Bhit7xjzIwfanCM8zOENaV+UadqfhCMBcBJblnimXXaEScZVdpTYYfvY8qQTo+97flLfPY1xlwbfDq3kvCKAiiXYOGBNVPtda32WFVLTGeyIbrgLxKYq9LuKKVBG9Q5hk+OYDI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(376002)(366004)(136003)(346002)(396003)(6916009)(66556008)(44832011)(186003)(2616005)(26005)(76116006)(33656002)(36756003)(54906003)(4326008)(316002)(6512007)(8936002)(71200400001)(53546011)(6506007)(8676002)(6486002)(2906002)(508600001)(66476007)(64756008)(66946007)(91956017)(5660300002)(86362001)(66446008)(98903001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eVYhqXNYDkDq2IenC3UnLWFGZ3WZidXSvVG56zFeIFCbkIFJR8Zi6r+O8MiN?=
 =?us-ascii?Q?uofhPQLSBEi/gfn+OEHQ2WCfLPu8wyBqhDtuq1JQWIqrFghhWfiDYmPgC2v7?=
 =?us-ascii?Q?RnB2dr6gizp/G5RxcaoOnMltohDu6slWdAX8WNAtZybkwSjr3W80u321nPA4?=
 =?us-ascii?Q?qq03hip6iiXVuwNcHVQ6C1HmPHGpFPhL1CW6oMeLl+CMnxoGfcxTuzKysfCE?=
 =?us-ascii?Q?ZV3EVcDaKxMl4KnHDnfedjeRqKMvxBOvUnGGsTW/JXk+JO3MY0iHooFfDM6C?=
 =?us-ascii?Q?eWYuwxp+B2+mRX4WSDdA5BXAKEjeVMClqP3MqAP5EUoYq7g60FZf2ph9aw0F?=
 =?us-ascii?Q?1LFb1J3P2kJA0GLDgeMEdLsFZ27QL4I5bLweNgMNB9KdyTbRZz2idi3jGxmR?=
 =?us-ascii?Q?/Ao13pRoYU2jaI1j7CM+LrffQPEYVAhZi7ApsP1Mj8B3iSlvOOM1yjdA2V29?=
 =?us-ascii?Q?/9001/8SV8fw5ID/SMfiNspLlZ80m1V3qW0qFxdXrS2BfVVx8F5i+3IxPK2j?=
 =?us-ascii?Q?I5ahTPO3ZJRd3dgdtMB/+BphQbq40wVVTNQ3jC+ygRALnFUIspKnBDxjrW6e?=
 =?us-ascii?Q?F9S7nxjBZLUBgjxcDJdYN9y9ZLivKDrp+aVPXJepxF37FT3n5Mx80b/49EIz?=
 =?us-ascii?Q?O1Y5BqUiHuPTHH7XaNcL8Wx3WGKVu55O572j/x7Y6//Yzuyip2e7fRjJUc7a?=
 =?us-ascii?Q?2xGDPaOSkjm9ZyHlqNInJ5YNsEWgzw7R14LlOzLDrz4lkjTuMuRu7ZsLIIpD?=
 =?us-ascii?Q?y3Gd7hHAWv9WpRHM/OSXk8waygK77smbEapQpTnGyb0mNzCPD86FROcp36Hq?=
 =?us-ascii?Q?UFmrgfh5YpN901QxcYNhhkSgQAmmMiHd+5yMnbptG5EbiBji1NXq8zbwIB/1?=
 =?us-ascii?Q?Q+podxtVQfmjs5mHhw/wBkuOixJqe2O6DjcIo4mhRK0k0VI27ICO6tGCcCOr?=
 =?us-ascii?Q?+fc2cOB+oc0vVkY2UeyKE3wh495Qp/B1pNcmtN/nxdJ/rhhQCXTmRqPf32gd?=
 =?us-ascii?Q?HAWN?=
x-ms-exchange-transport-forked: True
Content-ID: <BDABD7F2DD2AE24086F34020BDAD86DB@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cdab0a-b542-4256-45ee-08d8bd818f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 20:25:42.8620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9ZvOlRQqmQ2yFvOdcEDO6PJglc93eU2DUZngsCJd8jCrzjovdYGpMKIY5KTqpEMK/giXEF+DT6FUPVDMz+LNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 mlxlogscore=935 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200116
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>,
 Robin Murphy <robin.murphy@arm.com>, "murphyt7@tcd.ie" <murphyt7@tcd.ie>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
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



> On Jan 19, 2021, at 9:11 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> On 1/19/21 10:37 PM, Chuck Lever wrote:
>>> On Jan 18, 2021, at 8:22 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>> 
>>> Do you mind posting the cap and ecap of the iommu used by your device?
>>> 
>>> You can get it via sysfs, for example:
>>> 
>>> /sys/bus/pci/devices/0000:00:14.0/iommu/intel-iommu# ls
>>> address  cap  domains_supported  domains_used  ecap  version
>> [root@manet intel-iommu]# lspci | grep Mellanox
>> 03:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
>> [root@manet intel-iommu]# pwd
>> /sys/devices/pci0000:00/0000:00:03.0/0000:03:00.0/iommu/intel-iommu
>> [root@manet intel-iommu]# for i in *; do   echo -n $i ": ";   cat $i; done
>> address : c7ffc000
>> cap : d2078c106f0466
> 
> MGAW: 101111 (supporting 48-bit address width)
> SAGAW: 00100 (supporting 48-bit 4-level page table)
> 
> So the calculation of domain->domain.geometry.aperture_end is right.

I found the cause of the performance loss with c062db039f40: it was
a testing error on my part. I will begin looking at c588072bba6b
("iommu/vt-d: Convert intel iommu driver to the iommu ops").


--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
