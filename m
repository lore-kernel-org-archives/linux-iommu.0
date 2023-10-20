Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD11BDDA
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cm+PgCqO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aglMtiLx"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KD8Evs007002;
	Fri, 20 Oct 2023 13:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GtjUidsFoYE77B9Ri4pBZSw6+maCupdKTUu2pJegdww=;
 b=cm+PgCqOxa3SeDi5swluG3Gvd5Wt1pCptmHIQdjo19bI9XqI8gIUNhiuafno8MXFuzVd
 IE0LMVH0+4Q24HDrpYT3KrfpNQSxt/0jN3EOi4iFvFar9VvlpNRBArEVz2swRMotgp7x
 fugKpk66tjaKE6hTr8yX9rE7SEMdJu1TGeb5lOlmAZ97egBj9XmphkUOMMAPtWz+0wa1
 aMpXkCHbyql740np9YNpzJZ/j3LL0Q8N8XAymFIsmDBfE9lqYgeuc5IMf/YhqjxWOFWL
 /tGsQE5fIArwXqprEINrGi5SaufD2VhDHa2i+shedHWxuYnhi6if79l658wi0MKS/tfq Mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwchutn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 13:38:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39KCOFj9013972;
	Fri, 20 Oct 2023 13:38:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tubwfasdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 13:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDDiFHDZuE40GeZdHn6NufwwmldwrxZMSoJrKZAHOVpsc9WB1t5F9VNN1VVZHv27xbwXLH0nmvO0SQh1GnlY2OBVadO0awRHGS5hjgmwQcZJb5Fcq6rdwKyM3+Th4zTP4CMsKH/yySvv7vYBu6mBgaS3guWw8gKxYofOdzZav3lDxQHQcWomTw6NYgx8cmlM5weoaqqHMlIIrKDHV4d0ZgnnAr6BRKBU5M8Ih3JYyEpxVQ2X2C5gFgr8kzJhjhV+D5ptuvkH1LaclEjTBAjYc3Gjxgj2Pz7FOPfK1T4G9l89Iflt/ybK8MhX1CEXmY4KiSkqxpHAfFDO+l7PF9MfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtjUidsFoYE77B9Ri4pBZSw6+maCupdKTUu2pJegdww=;
 b=kT5KIT8O20ocFouxtnZ9f99yrg2t6fB/iCOca+bF+WNCa/wDvrw2DbLwOLCALXU1WezlX9C/C9YO/yKrghosSKbMYS7oQ6JmbFVcZqW8EjLcYigYaLWiTwMlUCrMlexlae/eDEz6xwxIHY6RtEA4Xe4aJy9AggjM/6FOYukJKn0XMu+gmhEKkfsetiLyFpcK3GubgLULucdhUI11AuYdQQLrziJEx7UmAmMsYts9ekHXWOXZLO6ovYZOz2VPkmsLQ/MEfG/6k1HrM0UnGyb9sfZj4KMKfGPAdA0mObJ5rOMowWIEi+lF2xseJOz03I5IgW65lIOHRVVxScYJojpDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtjUidsFoYE77B9Ri4pBZSw6+maCupdKTUu2pJegdww=;
 b=aglMtiLxLeuQWwYyWKRafn5gspfTSj3Nwr1/O2mkESFh9EaG+9Bwb25QLRMcn4u7EAnUvV3EthaIjGcTfWrL8VfbjrhPkiASagJQMUy81vOFHwcqnWP3OVfzsMlpxhCYAltkFSgmALarX/xkqtgiuFx1DgRE70HJMv+m2GAeZa8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7606.namprd10.prod.outlook.com (2603:10b6:930:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 13:38:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 13:38:02 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Chuck Lever <cel@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: Re: [PATCH RFC 1/9] dma-debug: Fix a typo in a debugging eye-catcher
Thread-Topic: [PATCH RFC 1/9] dma-debug: Fix a typo in a debugging eye-catcher
Thread-Index: AQHaAqCJvBXS//eFdkmMlrTjREYwBrBSHGuAgACTkYA=
Date: Fri, 20 Oct 2023 13:38:01 +0000
Message-ID: <D983E311-0357-454C-8FA8-D365536C5ADB@oracle.com>
References: 
 <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
 <169772913879.5232.8222328841727254479.stgit@klimt.1015granger.net>
 <20231020044941.GA12234@lst.de>
In-Reply-To: <20231020044941.GA12234@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CYYPR10MB7606:EE_
x-ms-office365-filtering-correlation-id: a2d670be-aabf-4bcc-f343-08dbd171c801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cCKas8U/vcWqDrxrGnS1k3VhiGTcGv4EBmF+TShDpK9Hu9cGx90q5+yCaaSpnbbsnBpIjSMZpGCb4G69tLcw+Tx8QRjY9maK5y/jPj3ArgdmLpGVJDMUvTr0ZB9/M/y9h4wrS6zcFnjvIDOx0oY+OYsBz1d2KCnXnHpcyq7jMDPKniI21AAadqu+0X2ABxpx2NP05M8D1P7vqwc7jsKy2GJGlzBd3LlHTfbp0hjffwYVsnl2M0XITVs3iaQxNt83x59/uxN+4o6Q4FSkFw4mOqA08drZhmNlzujPsIfcJ/1GlWIR3kR4YslDzuhFTLlm/f+C19pSyMSL/GHeOK/+xgFamgscKwW2t7EfxwVX4whKa5QoRep3smQNNALf8gMiWuvfB9lUBrCKozYYmj0g4/d/6mW67F453QWIj4s63s8F0E1e/WaeZSS79k04vTJvOBdOdySARUNsuPWt7gQkrADWOE7j0jVIwHP/p+8d7+gr3XifLHdrNT8+GTe2s3mqCDRxSVeHgB5dTaksEFCfkZhkfY7tr8LXIsMgvc4mghZAUzfqdvl5uonF2yzKMixS8QZNOCl4P4brtb74Ky/Vhxhx3CrFCYeoXByrfRWqlONQjGjEGPjCrjDmi+JyBp6RgIVRggslNj9bw9mssdJrsQpGtcAisC7At9JVIya8IRqe/BABO1y8VGNDKoc/U+TmUJnUL+3hPi3BKhx0g04pHQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(4744005)(54906003)(38070700009)(478600001)(6486002)(36756003)(33656002)(8936002)(4326008)(66476007)(6512007)(8676002)(5660300002)(91956017)(76116006)(66556008)(86362001)(6916009)(64756008)(41300700001)(2616005)(66446008)(71200400001)(26005)(53546011)(6506007)(66946007)(316002)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?OcVJS0QwqYuk2j9pdnKXV+9Yf7tNND4krRe7mlYZTvhHL2dE7Z5WWoL1EcYv?=
 =?us-ascii?Q?EJ20DElqWDdlUkvYK08o3XVsbnR+la+ILxfA50COhZBrI8Acb4o15WJ6Eb+r?=
 =?us-ascii?Q?bbjct82YMCCJx3yTnkIA9DR9nF8tsLlEKH96+w+KoKsAGbsbDglC4KPQj0Yv?=
 =?us-ascii?Q?uj6As4P+M4pHJVk7lxsmBDq6t1p982U9SSz0tBmjVWGYnyPJD7Wh5rMrdp8K?=
 =?us-ascii?Q?o8QS70rw9fXCGqjHEq7G8pxOxD8yryHezsjjEl1Fx52m1oGxNtkFdWfaKzuX?=
 =?us-ascii?Q?JiE9Qv6/GajJfMcT/xDy0+Kp9UShXDGLkzu19ETrgNF3D/wIxAQVLO2LY7FN?=
 =?us-ascii?Q?D6Zi4Mz6spEKHR8Z7dCyuX+XzK3x7luG6IFJkEaeHgzHNbC1TxVRYxD+NLgh?=
 =?us-ascii?Q?2vJ6Tjhu6g8Vtxw2DCyrdeXUTewgfwNMlteVdmP1xOBlHOMGDf13I7IMQ4HB?=
 =?us-ascii?Q?5SUaI7KvHqHemRYZwBUi2HY/8NJ0RC4qRoYHX7QXs/GMaVLgT54e/MDgQA0K?=
 =?us-ascii?Q?aAdfvFFt05UhKDawP0PtfJj1l6wcaW5JYSltFdTDR4KahTKlkKR+7BBYCWsf?=
 =?us-ascii?Q?vJh7jIR1c1eyOMlj4SWYVUwooTZmRnDYN5P1Pi2fwejm5+MLwei2e83pJ3uL?=
 =?us-ascii?Q?X17UWykI+978ccHnR1fFhex+ZQrHMbtmJcaZxhCJLapRxKcXwsW8ZjDRubhE?=
 =?us-ascii?Q?gn3y7ki6bo40B7ZFP0tHZb24wOxX5tTN33a97JU67mB2AMr9nhsBEHqab0vb?=
 =?us-ascii?Q?y7Iy2qQ0qgMeC0Maxm5gekss518UzKnBTqChhn97/DocuCcWHXh6H2U8Rbiw?=
 =?us-ascii?Q?GL1cgzIvK/CTc2SsvprWH/GQ5kZNZtbW0pvuiJxYRLwtBkTmWGLVTZbOQ7mm?=
 =?us-ascii?Q?dxv8xJtHi+9N8A5Iq5sqDbe6L52ENOuP875A9A/dwMtRmr50HXjS9qVFegdP?=
 =?us-ascii?Q?V6PVkgY9aj97UiNAk4tifVylvRYyIqgkhm+cjWcBvGF567p7yZSB3v71r+Zx?=
 =?us-ascii?Q?IeT6xSkkrDcqq79OtylsBFQteVlPrNk2k/MVFh5PR/HAyaJp5tR9KB3dBoEI?=
 =?us-ascii?Q?T8twGBd4ix3cfoJD4RkNlnP9WrzUXatqdiQqn7gPniBcg1tmnQscf1FASmEZ?=
 =?us-ascii?Q?6Y6Jr1LXcgUImdGkltSyEPDJ3YkgMf1ZRPRv4WRRJ2Y8vx/BpVZtkFTTn6h7?=
 =?us-ascii?Q?Of/kXaxdp3ZK3LFHLMCdsY6xeKaPEN4tB8SJgWoL+3oYODTOrS7eoHajJzsd?=
 =?us-ascii?Q?FC7g+jvgmhxPWyr/gQz2OghjjRWSBR5vRQcO4ij4lm2xtrWQZ/nwM025ShKl?=
 =?us-ascii?Q?uViH+P+K1ZY+hfKEUlgUVd/+HnDk57B+zdAOU+1Lqfk83/S4Y+29ucJUcJbp?=
 =?us-ascii?Q?X8yPX68Hnte4HTXJSAm6nLpH1PpQgO54hI02x5wn8xTQasnlp9gEnukcdfVl?=
 =?us-ascii?Q?0i8c86/KfgiNrkQ7oX+hRDWxzQfro4TvcJ5xv03zSVeJGI6LyAcHrFvqUnv/?=
 =?us-ascii?Q?tCqU0v0xhGosvTLwJrfkbvUQyFmx26c7og+nZo1uLjIfL7mAzrB1gpcPuLro?=
 =?us-ascii?Q?FuPGV81EaVKKI29quh86FB5bXPuQaL5U9BfR3T+4XHGkAxVt2prGx3AhtXsU?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA8AD3342B9C0E43B8506283DDFF9069@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8h8zCN+cwRPtOXaJTdVd2d9vK/gS1o3TF3uSdGcqmTrjpSumA/LIpmMy44CrqroC8LvuZn7DylobAs739cH1PrtLLmK+yyqwxCxC6KZJC7U/pmeIqWZIYkdSzbN1G2vmxVu2uanDlxfaj91BpGlJYAmot1EjsR0y0d83SYHs6We/cSNVvtH9H5eU2SPivV2Z9IAtX9uinC5fYnK6t0h0kJGy3ElgDzWAhJu+M0ISrb9ZBXOZLf1tziTGViiFzNKwj09um2g1YXUODG2xBYMvHs5WHJMu5qjCFFlXmi9gBq/EYlKTLnhpNa/Bygvox4jtC4UCZC9rrPBptpYhk+vD2Egb1BsSd6CH4LvXtrGrmEPyU3pg3kdsf2cwnjtPJUprE77CEb6EJQ+3jHTy1/a6bZQDkLDTJ1Wa655mUuHfHuCEKCkoh210eZWnEqwZ/cSS6jCOJtjCBJgN7tc1K06pDxdB8567RBQpqXPBXT3IbklgtR6t6bx5URUx9yPjFeqdE5D9NaAuc6YBtNmI7chAlWuuKRNX3fSLxD2XXONi0w1MxZsV+/UcF2JI6rKNmEHL622utIBKPrr8oqsuppCeBRCsxQkTYiF5pSGXl6iaAvpI9MdM52Xvg9LY84fxu2MOW4TlCJlCU9/TTwYSkfovzlxJRkJnajpLihze88B7/chRRx2KFSFNvpmhL01+PKnXhnfrCZGXHWJ159T6BEGRFwPYfza7T81oRqvGE+i8N00/GhyijU/1wNmTjCeqTpk/AVk24lJNmxvEVCZxotURl4m5gKJe9P9lGyuAVVMhLRqkia4drAE0NU15CEqNj9C02BDa7gqXZbacb9j39vhxCqkSUUUNfejCqDqjx9pxuFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d670be-aabf-4bcc-f343-08dbd171c801
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 13:38:01.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdFw53G/5AtBq7/II982Fga4vRGNzSd1AEBI3LjBIJnEQ2ecGQT+8X1DUYNILxfjqGJIdBe1YVsCMdu+BOzB1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200111
X-Proofpoint-ORIG-GUID: 6Ai6KYm4FzvG044UGnPfl9ahl7WTDgzS
X-Proofpoint-GUID: 6Ai6KYm4FzvG044UGnPfl9ahl7WTDgzS



> On Oct 20, 2023, at 12:49 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Thanks,
>=20
> I'll add this to the dma-mapping tree.
>=20
> FYI, I only got patches 1, 2 and the cover letter.  Something seems to
> be broken in your mailer setup.

I think you were explicitly copied only the first two.
I assumed you would see the others on the mailing lists.

I used information in MAINTAINERS for the files and
subsystems those patches modified. Is that information
up to date?


--
Chuck Lever


