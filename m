Return-Path: <SRS0=S8Y4=ZU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C71C43215
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 08:17:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A8A2176D
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 08:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="W+KaMDK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A8A2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A2858784C;
	Thu, 28 Nov 2019 08:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9DdtY4EvbzT; Thu, 28 Nov 2019 08:17:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA50087843;
	Thu, 28 Nov 2019 08:17:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF6E7C1DD5;
	Thu, 28 Nov 2019 08:17:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B687AC1DD5
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 08:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B102B203BA
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 08:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PDhOjwphAZ7N for <iommu@lists.linux-foundation.org>;
 Thu, 28 Nov 2019 08:17:13 +0000 (UTC)
X-Greylist: delayed 13:19:46 by SQLgrey-1.7.6
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800083.outbound.protection.outlook.com [40.107.80.83])
 by silver.osuosl.org (Postfix) with ESMTPS id B84312002A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 08:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/6X1GJBEeC7+whfQEowb+v72Pmaiby9+ca0BWinNtNK4Zzrzp4zYKHBXOv49FqxTXSnpgZurMfzedlzlV8guNMwOwe7YNrKO8lTlfglHSn0ZHD9ATL/lkAYyHRn3fcjeDZsDECOhViVmO087KcsxNjgw2r3m9BriHGxbu8JdaDtDpcsVuqEeI0kDLuxY9+s577FrWebLcVhaqQ13NdCYMGEeZdFgDko3n84+x5VFEJ71wQoox9sMjzN40saj+2bNmE8gO3EfBzcStMC91uz9PVR0i7gvpPFM2aRBrh5DsgkVmerSH8TUIidoun2fSuIayd7c2quHXZhSNpSpO+zvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UfAHjMeBYFMwiwe/nLzFwJqwu0w5BD61k6bcS6y3GY=;
 b=UDQfxf8kohpweUBIPjEVXhJVOro6UeJmZFPa1ZCALEc4WLWtRw7XMGBvJi/ioI/4KaFyOZZ4MPjuLfTxw2KlC3h0Mt8VmO/K8c6NNyVdP/ysOaFVXahPAHrPgvQREU0oHjJMDTS081LXm0rUS0Rfc9fD77snVhAwbgvPMaZ09jfAAz4MQRCzC9eBIMnemyVCrMGKBvXEgrSZYwAb7jNyE6DU0V4vOZvVFsk8gvxz/8yRGWtrND4x09NK2EpDm2LXOXc4Qt+sotQinCgCCrIWHDSzXytIywiVpQYvi7NwtJvKEo0bH7jCM+UjvERl7DWUsnuKGKaD+qOUJhqx/70Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UfAHjMeBYFMwiwe/nLzFwJqwu0w5BD61k6bcS6y3GY=;
 b=W+KaMDK7qloT9i4YXpyGf7TGdwpJctUxzocMN8mBV1FOD80NeYfb5sFkYi3w16uAXwUs2yv20cHAICwM+gp+wQUcVIYdrsH8W4Yp8vVvKSbrGrtgJ1uWaPuHZMLNrGjy/K39L68hysLy2diK5oQ9Ayag0YFnK4CSr+r+U5RPqAQ=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6125.namprd05.prod.outlook.com (20.178.242.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.13; Thu, 28 Nov 2019 08:02:16 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8%7]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 08:02:16 +0000
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Thread-Topic: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Thread-Index: AQHVpTCUSCVjXh+W+0SSCl6TSmyYRg==
Date: Thu, 28 Nov 2019 08:02:16 +0000
Message-ID: <MN2PR05MB6141B6D7E28A146EBF9CE79FA1470@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20191127144006.25998-1-hch@lst.de>
 <20191127144006.25998-3-hch@lst.de>
 <a95d9115fc2a80de2f97f001bbcd9aba6636e685.camel@vmware.com>
 <20191128075153.GD20659@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3653bef-8f4f-40f5-577d-08d773d94934
x-ms-traffictypediagnostic: MN2PR05MB6125:
x-microsoft-antispam-prvs: <MN2PR05MB6125BE1AACA6769A9C3CCEC0A1470@MN2PR05MB6125.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(81156014)(66946007)(256004)(54906003)(6436002)(186003)(9686003)(55016002)(6916009)(14454004)(99286004)(305945005)(8936002)(8676002)(1730700003)(2906002)(14444005)(81166006)(86362001)(7736002)(76176011)(6246003)(52536014)(2351001)(7696005)(478600001)(74316002)(5640700003)(25786009)(4326008)(5660300002)(66476007)(33656002)(3846002)(316002)(66556008)(91956017)(76116006)(66066001)(71200400001)(102836004)(6116002)(64756008)(66446008)(71190400001)(26005)(229853002)(4744005)(53546011)(6506007)(446003)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6125;
 H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymrhfljteewxg0TBmIjfZpbvMt2RCn2o5CxO3NYrnP71+UjYCNkCJzEyEki2awOohyBk56K7D45O0qHOyKqT7DZkd4ebMJeVRxjEjwGIWvK6SPLAoemFRUrdBSxZMt/uqxZIoSIy/BNvJE06OuCMOTMhC86oqvI0Pc+Ejsi13VULW6hf4h7bNhrdt5aiM8qeiPSfPFX5Z6JmNFhxLYsR+65/fojlk2q9LplgC2qgxpSNqfUUpqRTaNoWI00Ax2t8n1sWqEfWMQWMgnmg2z6cOh4l9ERNTECHTkgfScyfZxFl8kULetmBZsbvUNTMbust8ObvnO1TU9hRVmLKu2+bLh4aNeGxmzK1Ztp5dDGfLf4H/B5erTJtTtWGZMel9DrSiHBeaMaFBq4IaSsPslU5xvUX6RSBwJjlM4ENd0+wpO+7yz4kiZTKai7yFSf4tiOk
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3653bef-8f4f-40f5-577d-08d773d94934
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 08:02:16.8369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MmJ5kec9vsnBAnVI86Nno4Bb1VP2+Y5sxvpn1qsuJnmy8ZA1ZWq5DFS7zUqaga3UygpOGMp3DIFnEcOKAIa6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6125
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
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
From: Thomas Hellstrom via iommu <iommu@lists.linux-foundation.org>
Reply-To: Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 11/28/19 8:51 AM, hch@lst.de wrote:
> On Wed, Nov 27, 2019 at 06:22:57PM +0000, Thomas Hellstrom wrote:
>>>  bool dma_addressing_limited(struct device *dev)
>>>  {
>>> +	if (force_dma_unencrypted(dev))
>>> +		return true;
>>>  	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
>>>  			    dma_get_required_mask(dev);
>>>  }
>> Any chance to have the case
>>
>> (swiotlb_force == SWIOTLB_FORCE)
>>
>> also included?
> We have a hard time handling that in generic code.  Do we have any
> good use case for SWIOTLB_FORCE not that we have force_dma_unencrypted?
> I'd love to be able to get rid of it..
>
IIRC the justification for it is debugging. Drivers that don't do
syncing correctly or have incorrect assumptions of initialization of DMA
memory will not work properly when SWIOTLB is forced. We recently found
a vmw_pvscsi device flaw that way...

/Thomas



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
