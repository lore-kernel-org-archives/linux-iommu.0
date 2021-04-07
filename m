Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E55EC433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 18:41:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E9061246
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 18:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E9061246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2C0784C6D;
	Wed,  7 Apr 2021 18:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JMauBOj43tWA; Wed,  7 Apr 2021 18:41:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DBF384C54;
	Wed,  7 Apr 2021 18:41:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AACFC000B;
	Wed,  7 Apr 2021 18:41:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D66C5C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 18:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C40C5418B2
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 18:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="zNxfIFBc";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="m2k9rsRQ"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h9oDO4zRjmxs for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 18:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67C51418AE
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 18:41:55 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137ITUxO056660;
 Wed, 7 Apr 2021 18:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=LPb4rhoqJLpGX6u7Mh6lxwnKmHcHdt8MeBe2p2soRuI=;
 b=zNxfIFBcgOOoXN1++98DD3v/TGI+FrttQQwjuuBxZ4/HqrOuM4Ciw1sb5eH+WaJaEdAk
 2nsQZprdg7kpM3Qo79fDvmkYzieIlF3fO5Llsxf9D9QDpMegwhMPVZVy6ZUEX7WZyneW
 2awJU9oSabDA+V0OeMtagMlzVhh9P+S54w/ka6e5UeuVQTu43+LGnq1bzPAj+GTRrvZD
 c5gD8uzfHIU2jx7M9RTisHYnVDgsVAXibe1a/4cF8egjJTtgzH7TeMX14wPRNM67bGkx
 nyAj5UkXUs8CJO1HFh8GKJc+99NcnkptPP9qvbJ4UO2fKbocDHQKwZhMIqxOwtQoyRZ6 Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 37rva63jp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Apr 2021 18:41:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137IQ7X9039055;
 Wed, 7 Apr 2021 18:41:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by aserp3030.oracle.com with ESMTP id 37rvbfcrhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Apr 2021 18:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRWB/XQQTt0DEfzf9HL5uKLSokSXpGnIAXWpiRT/MV89qi5SETk402SXzJr0YFHYC1g4Qtc6KQluh9IBOFTdMt1Ai9WdeeK3XYcqim0VxXH/fCEZd/2zwTVsjOOY+M+X8CUClv/rNKQfc6UZNwDirGmBMqmjLJVK/WhQwwQPoR4Zo+HOCwuAAp1ntsBZ0mdJieMKxLcQiHKR+qyHHWK6igROa0/qHfYZUvW4BlcTAmQj5M+4nzsysnuocMhUenvmzoHUxthJ1XvtSk3axYYz1Yo9T8WdLyozqqoZBGs5zL18jg3hyPSYDXUmYxKQVgyKGp/0UbmdB0KcwGJHvV6shg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPb4rhoqJLpGX6u7Mh6lxwnKmHcHdt8MeBe2p2soRuI=;
 b=i6Kk46voIydW9jWrrEB/RDFLgfAdlwrruAjXVNyu6l1L97Rhm+Fu4Yly59JL20LwT+bQkhU/f+OOX8ej8UqxIYpC6Dgs8sLnKRUWYPw4yE+b/mKgdKPsCqdY9ZhCuGSkFGQvv9GZSUQ7mR6bPEbY5XLVwKAaEPrC7UGkabLTcsvEZi15UNK+wBafN3Kq0u4Ux0RXV3AW0tpl10pwn3WU9kJdryBxQGVGsiGoLImyitvygXe88ZmjSt/fKudKxoYMTqHZihT9FZNaOCvkbOtTDmFksa/v8wnJDvde+w3QbsT+oWtSy1qjQMFfdWHcemhsGqXEEoMzlgBmst8JpFqnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPb4rhoqJLpGX6u7Mh6lxwnKmHcHdt8MeBe2p2soRuI=;
 b=m2k9rsRQj0dwnI/mFuMzPJcMRMhypYSdZTaGa1H+SflGpSKYIfhj+RJm53It07NMWRTYGTSXK4vm8UTO4LsHVPRsMtE2cJTQA4CShFxhPJ7V/c2NJ267wG6OtH6n9rEjiJNcSv1JI2xxjuh7Ax03ozoO62I6fafg/573G99aL7E=
Received: from BN8PR10MB3571.namprd10.prod.outlook.com (2603:10b6:408:ad::23)
 by BN0PR10MB5061.namprd10.prod.outlook.com (2603:10b6:408:12b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 18:41:41 +0000
Received: from BN8PR10MB3571.namprd10.prod.outlook.com
 ([fe80::437:6c10:f7a5:5b70]) by BN8PR10MB3571.namprd10.prod.outlook.com
 ([fe80::437:6c10:f7a5:5b70%5]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 18:41:41 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5.4 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
Thread-Topic: [PATCH v5.4 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
Thread-Index: AQHXKwMKTbWvCOW9WEuta/5vuIDFzKqoSOQAgAEcYQA=
Date: Wed, 7 Apr 2021 18:41:41 +0000
Message-ID: <129708CB-7EBC-4091-8F32-C54D58672FAC@oracle.com>
References: <20210406163534.40735-1-saeed.mirzamohammadi@oracle.com>
 <c525cdda-2286-c8db-bae4-e0092e5c830a@linux.intel.com>
In-Reply-To: <c525cdda-2286-c8db-bae4-e0092e5c830a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=oracle.com; 
x-originating-ip: [136.52.113.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7272f4fb-23e6-4e72-3ebc-08d8f9f4c919
x-ms-traffictypediagnostic: BN0PR10MB5061:
x-microsoft-antispam-prvs: <BN0PR10MB50610187F440E64788A6C11FF1759@BN0PR10MB5061.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mg27enmo1ytEnq0V5pbHE4u+H410nAfMyMannKwe1cAZtTqp/m3nq2XnXP260WpHBrFcqgR5ip+y8LmPplPdcVBbL5HnIXc9HaQ2IdlFCqVBQ/WwSn7F/9Cl+xodKM1BRyIHoJgfWYyJ/lLpH8YPqz9VIY2QtRXLsKJvo1VsHF/ftCMgSd//X2siI8GB+2Wg9o5Tdt1ILqAYEe8gIwn2eQsJrajYQaYaiftR0qpYr+TWXv1vM7sRxjBkZlMnS66qKih7fqxOYk/7yE/fhRRb+MMmRLHw17LOicN5iUGxQzLT0FBx5coCB2LvjNRjWU9fhFnbWBVxEjGj2kunXUGmXZtcp+nw0Uh8IpOBfnVeTtTx+MzORhWGisnJRcNUb0FFYN+0WnYagijrnNezMthtTEeuxK5NNab/d3zuF97L/stHWVyddkLWsS75DgId5y4f1pFrWVfg9RA9xJwYuqV4pvBW95k2I878KKfVxZzgJ2s0f/UF3m9kk2WYHr/aX9ZI2w07NVJ9nfj3T+Q1PCS09lYoieoiYRxujNHZcGh25CM6Sz8ju9caT5F7XOo36weLRlwIxzBEOCh1Tjq1g9Gs9Sqbaa/LRVPT0N2YFh7NUvoWFornzdjH4QsiddJZRnCUPWZeLkMYy2zvbMqcWGpYnnOAfrIXB5+pOUnF7u8WCGyfZ/8egV7bRbrNE+x+WpJ9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3571.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(76116006)(91956017)(54906003)(8936002)(6486002)(6916009)(2906002)(36756003)(6506007)(478600001)(8676002)(83380400001)(5660300002)(33656002)(316002)(66556008)(66476007)(44832011)(66446008)(64756008)(2616005)(186003)(6512007)(26005)(71200400001)(86362001)(38100700001)(53546011)(66946007)(4326008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?adi1o2LYbyg99HxSLadgo5FZ+sgnMM1lFkq3zitR2tb/vBPm+9Wn8IdU8jKq?=
 =?us-ascii?Q?gmNl2fHtSBIBrY9fd6r7SVLgV5m/LHNZurrX0ySqThb32K2Chxapx8WuD9KD?=
 =?us-ascii?Q?HKF3DV/d4/CVGpLNTMFhanFKWQmxZ7vs+NujEwAdE1o0bRss2Fae9OWnPOC3?=
 =?us-ascii?Q?9oE8NzJaZs6eZqohO1NiwJULvqHISOmfLo7zj0wcaeyk7F/AvGg+V0ux0WaV?=
 =?us-ascii?Q?VeW3RBGL86eSHCnYFoJJQydpGTQvwIG5fl80b2wF3uf2aj2+//2I1bhFgkjD?=
 =?us-ascii?Q?FnZ/flGQF2LBdVnmvL9sGdAdG867E684JqAzp7n6CjG7KXQmB4IkuQ8srPvt?=
 =?us-ascii?Q?fq+UGKop45S7airlorprQ4D2wfjKsCmJnbTkL8apS3Lgzg4REEKLlVR0RCMv?=
 =?us-ascii?Q?b2cqBSETvs5/Rai9aCJ9ysmIIAdgLIts62XKQ4mAljQhgIDh0DG65uQuwBAn?=
 =?us-ascii?Q?drx3QvtGHzpVcL5W3EJyIT5J9qnWnYYdXJhmz7b4CVDIQ8nXSM4m69pU0yEn?=
 =?us-ascii?Q?NkICGzxqfmikXkQRqJ/rPAL/BhALpphYGc8lSy2Z1MU2tj312eTdglFr6PAi?=
 =?us-ascii?Q?XIj/QYR6jhUPBNd5wFoV6SQWKV+fMGrxXQcDIJlcLWp5Fgs59EyhiNX5883u?=
 =?us-ascii?Q?NVlUOnQg1qCTFCx3yI2ER+sTYyWE8LJ1mX9kLDTOBuXHujbSqBIzgQLfGs7d?=
 =?us-ascii?Q?Hd936DU2XkLfIWHoy9ELxHiTXHF92J/nKlAlYjESyaJE3q2gyIzaZdVqKLZu?=
 =?us-ascii?Q?yNFkUMACdC67nLEhmRqhHtScj8+cxNdoVH3VWrGVJqy7D7qff72827LbzLGA?=
 =?us-ascii?Q?GM/xjyp1G7mNL7dfHvKBafU4NDU34ULKTsJdfWzV2aO8OMEyUZ4se/mfSeeC?=
 =?us-ascii?Q?Mf3AEoHibtzhbOj7owwiaPS7Ll3U8Lag/NlLv8treWNhm3UKf34ZzTg7tkUi?=
 =?us-ascii?Q?S6e/BIJq+iieMmhjPQSwrNEoNUPXlw4TxpApbKCNSD3lIrRuSiThxSINgVDD?=
 =?us-ascii?Q?o29U25/tAXCoHTZQIVDZ4WE2E+f95rUahGTo7aNAGDhk2m6DO51FsZAhZMYw?=
 =?us-ascii?Q?CamQA6jiiL69kZt05BG8/3gd0C2OqltzTiFtKA+0yntXlMaMJmj8bWcXt2g9?=
 =?us-ascii?Q?S7c50mWn+66PWO2cp+/hoAh9U67o4YxRFJqFO6YT736qiADdBtLEe8I+WtRw?=
 =?us-ascii?Q?/2Y+UsjkOVTs3bOqLBiwgSivL79uehiFr7ghCbiRgHU/hA9IKTOwYUaAhONj?=
 =?us-ascii?Q?/SI70y8+G6uWNNYDVNFDGVMni9PMftBUBPq+OMizfONoGGmY8fSAqaWoqPBa?=
 =?us-ascii?Q?AYZQvRxznHUz6flAa6HyvigkGJDPBvO/AC8rG3ipZM4MzQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3571.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7272f4fb-23e6-4e72-3ebc-08d8f9f4c919
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 18:41:41.1947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTijc8rXqg/nF3pXIR7EcS+ArO+3E5KSoeOz0xONBrOpT+8nlSiaDU1VE7FAYEkV2NEpB9gE5z5p9un7EKIG/4HGTMbWDOBUs+jf147Vc6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5061
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070127
X-Proofpoint-GUID: Ly5Ns8u7ZWCGINiL64pG2a211fjfzKlL
X-Proofpoint-ORIG-GUID: Ly5Ns8u7ZWCGINiL64pG2a211fjfzKlL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070127
Cc: David Woodhouse <dwmw2@infradead.org>, Camille Lu <camille.lu@hpe.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: multipart/mixed; boundary="===============0073173735929734647=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0073173735929734647==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_129708CB7EBC40918F32C54D58672FACoraclecom_"

--_000_129708CB7EBC40918F32C54D58672FACoraclecom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Lu,


On Apr 6, 2021, at 6:43 PM, Lu Baolu <baolu.lu@linux.intel.com<mailto:baolu=
.lu@linux.intel.com>> wrote:

Hi Saeed,

On 4/7/21 12:35 AM, Saeed Mirzamohammadi wrote:
The IOMMU driver calculates the guest addressability for a DMA request
based on the value of the mgaw reported from the IOMMU. However, this
is a fused value and as mentioned in the spec, the guest width
should be calculated based on the supported adjusted guest address width
(SAGAW).
This is from specification:
"Guest addressability for a given DMA request is limited to the
minimum of the value reported through this field and the adjusted
guest address width of the corresponding page-table structure.
(Adjusted guest address widths supported by hardware are reported
through the SAGAW field)."
This causes domain initialization to fail and following
errors appear for EHCI PCI driver:
[    2.486393] ehci-pci 0000:01:00.4: EHCI Host Controller
[    2.486624] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus
number 1
[    2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domain failed
[    2.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses non-identity
mapping
[    2.489359] ehci-pci 0000:01:00.4: can't setup: -12
[    2.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered
[    2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
[    2.490358] ehci-pci: probe of 0000:01:00.4 failed with error -12
This issue happens when the value of the sagaw corresponds to a
48-bit agaw. This fix updates the calculation of the agaw based on
the IOMMU's sagaw value.
Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com<mailto=
:saeed.mirzamohammadi@oracle.com>>
Tested-by: Camille Lu <camille.lu@hpe.com<mailto:camille.lu@hpe.com>>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 953d86ca6d2b..396e14fad54b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1867,8 +1867,8 @@ static int domain_init(struct dmar_domain *domain, st=
ruct intel_iommu *iommu,
  domain_reserve_special_ranges(domain);
    /* calculate AGAW */
- if (guest_width > cap_mgaw(iommu->cap))
- guest_width =3D cap_mgaw(iommu->cap);
+ if (guest_width > agaw_to_width(iommu->agaw))
+ guest_width =3D agaw_to_width(iommu->agaw);

The spec requires to use a minimum of MGAW and AGAW, so why not,

cap_width =3D min_t(int, cap_mgaw(iommu->cap), agaw_to_width(iommu->agaw));
if (guest_width > cap_width)
guest_width =3D cap_width;

Yes, this works better. I just sent the v2.

Thanks,
Saeed


Best regards,
baolu

  domain->gaw =3D guest_width;
  adjust_width =3D guestwidth_to_adjustwidth(guest_width);
  agaw =3D width_to_agaw(adjust_width);


--_000_129708CB7EBC40918F32C54D58672FACoraclecom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <27E423C02940D84DB5E498AED7D17B5A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; line-break:=
 after-white-space;" class=3D"">
Hi Lu,
<div class=3D""><br class=3D"">
<div><br class=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D"">On Apr 6, 2021, at 6:43 PM, Lu Baolu &lt;<a href=3D"mailto:=
baolu.lu@linux.intel.com" class=3D"">baolu.lu@linux.intel.com</a>&gt; wrote=
:</div>
<br class=3D"Apple-interchange-newline">
<div class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helv=
etica; font-size: 12px; font-style: normal; font-variant-caps: normal; font=
-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0p=
x; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px; text-decoration: none; float: none; display: inline !=
important;" class=3D"">Hi
 Saeed,</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetic=
a; font-size: 12px; font-style: normal; font-variant-caps: normal; font-wei=
ght: normal; letter-spacing: normal; text-align: start; text-indent: 0px; t=
ext-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-s=
troke-width: 0px; text-decoration: none;" class=3D"">
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">On
 4/7/21 12:35 AM, Saeed Mirzamohammadi wrote:</span><br style=3D"caret-colo=
r: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: norma=
l; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: nor=
mal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: no=
ne;" class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D"">
The IOMMU driver calculates the guest addressability for a DMA request<br c=
lass=3D"">
based on the value of the mgaw reported from the IOMMU. However, this<br cl=
ass=3D"">
is a fused value and as mentioned in the spec, the guest width<br class=3D"=
">
should be calculated based on the supported adjusted guest address width<br=
 class=3D"">
(SAGAW).<br class=3D"">
This is from specification:<br class=3D"">
&quot;Guest addressability for a given DMA request is limited to the<br cla=
ss=3D"">
minimum of the value reported through this field and the adjusted<br class=
=3D"">
guest address width of the corresponding page-table structure.<br class=3D"=
">
(Adjusted guest address widths supported by hardware are reported<br class=
=3D"">
through the SAGAW field).&quot;<br class=3D"">
This causes domain initialization to fail and following<br class=3D"">
errors appear for EHCI PCI driver:<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.486393] ehci-pci 0000:01:00.4: EHCI Host Controller<b=
r class=3D"">
[ &nbsp;&nbsp;&nbsp;2.486624] ehci-pci 0000:01:00.4: new USB bus registered=
, assigned bus<br class=3D"">
number 1<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domai=
n failed<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses n=
on-identity<br class=3D"">
mapping<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.489359] ehci-pci 0000:01:00.4: can't setup: -12<br cl=
ass=3D"">
[ &nbsp;&nbsp;&nbsp;2.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered=
<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail=
, -12<br class=3D"">
[ &nbsp;&nbsp;&nbsp;2.490358] ehci-pci: probe of 0000:01:00.4 failed with e=
rror -12<br class=3D"">
This issue happens when the value of the sagaw corresponds to a<br class=3D=
"">
48-bit agaw. This fix updates the calculation of the agaw based on<br class=
=3D"">
the IOMMU's sagaw value.<br class=3D"">
Signed-off-by: Saeed Mirzamohammadi &lt;<a href=3D"mailto:saeed.mirzamohamm=
adi@oracle.com" class=3D"">saeed.mirzamohammadi@oracle.com</a>&gt;<br class=
=3D"">
Tested-by: Camille Lu &lt;<a href=3D"mailto:camille.lu@hpe.com" class=3D"">=
camille.lu@hpe.com</a>&gt;<br class=3D"">
---<br class=3D"">
&nbsp;drivers/iommu/intel-iommu.c | 4 ++--<br class=3D"">
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br class=3D"">
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br c=
lass=3D"">
index 953d86ca6d2b..396e14fad54b 100644<br class=3D"">
--- a/drivers/iommu/intel-iommu.c<br class=3D"">
+++ b/drivers/iommu/intel-iommu.c<br class=3D"">
@@ -1867,8 +1867,8 @@ static int domain_init(struct dmar_domain *domain, st=
ruct intel_iommu *iommu,<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>do=
main_reserve_special_ranges(domain);<br class=3D"">
&nbsp;&nbsp;&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;=
"> </span>/* calculate AGAW */<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if (gue=
st_width &gt; cap_mgaw(iommu-&gt;cap))<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><span c=
lass=3D"Apple-tab-span" style=3D"white-space: pre;"></span>guest_width =3D =
cap_mgaw(iommu-&gt;cap);<br class=3D"">
+<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if (gue=
st_width &gt; agaw_to_width(iommu-&gt;agaw))<br class=3D"">
+<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><span c=
lass=3D"Apple-tab-span" style=3D"white-space: pre;"></span>guest_width =3D =
agaw_to_width(iommu-&gt;agaw);<br class=3D"">
</blockquote>
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">The
 spec requires to use a minimum of MGAW and AGAW, so why not,</span><br sty=
le=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; f=
ont-style: normal; font-variant-caps: normal; font-weight: normal; letter-s=
pacing: normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; tex=
t-decoration: none;" class=3D"">
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span class=3D"Apple-tab-span" style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 12px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: pre; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; text-decoration: none;"></span><span style=3D"c=
aret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-sty=
le: normal; font-variant-caps: normal; font-weight: normal; letter-spacing:=
 normal; text-align: start; text-indent: 0px; text-transform: none; white-s=
pace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decor=
ation: none; float: none; display: inline !important;" class=3D"">cap_width
 =3D min_t(int, cap_mgaw(iommu-&gt;cap), agaw_to_width(iommu-&gt;agaw));</s=
pan><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-si=
ze: 12px; font-style: normal; font-variant-caps: normal; font-weight: norma=
l; letter-spacing: normal; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-widt=
h: 0px; text-decoration: none;" class=3D"">
<span class=3D"Apple-tab-span" style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 12px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: pre; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; text-decoration: none;"></span><span style=3D"c=
aret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-sty=
le: normal; font-variant-caps: normal; font-weight: normal; letter-spacing:=
 normal; text-align: start; text-indent: 0px; text-transform: none; white-s=
pace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decor=
ation: none; float: none; display: inline !important;" class=3D"">if
 (guest_width &gt; cap_width)</span><br style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 12px; font-style: normal; font-variant-=
caps: normal; font-weight: normal; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">
<span class=3D"Apple-tab-span" style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 12px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: pre; word-spacing: 0px; -web=
kit-text-stroke-width: 0px; text-decoration: none;"></span><span class=3D"A=
pple-tab-span" style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; font-weight=
: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text=
-transform: none; white-space: pre; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none;"></span><span style=3D"caret-color: rgb(=
0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font=
-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; flo=
at: none; display: inline !important;" class=3D"">guest_width
 =3D cap_width;</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none;" class=3D"">
</div>
</blockquote>
<div><br class=3D"">
</div>
<div>Yes, this works better. I just sent the v2.</div>
<div><br class=3D"">
</div>
<div>Thanks,</div>
<div>Saeed</div>
<br class=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 12px; font-style: normal; font-variant-caps: normal; font-w=
eight: normal; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">Best
 regards,</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 12px; font-style: normal; font-variant-caps: normal; font-w=
eight: normal; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">baolu</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Hel=
vetica; font-size: 12px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; text-decoration: none;" class=3D"">
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>do=
main-&gt;gaw =3D guest_width;<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ad=
just_width =3D guestwidth_to_adjustwidth(guest_width);<br class=3D"">
&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ag=
aw =3D width_to_agaw(adjust_width);</blockquote>
</div>
</blockquote>
</div>
<br class=3D"">
</div>
</body>
</html>

--_000_129708CB7EBC40918F32C54D58672FACoraclecom_--

--===============0073173735929734647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0073173735929734647==--
