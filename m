Return-Path: <SRS0=JKdE=Z4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A5C43603
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 14:43:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAF620706
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 14:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="nV6kfa7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAF620706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EEBD688307;
	Fri,  6 Dec 2019 14:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PFmvqrIUkEd6; Fri,  6 Dec 2019 14:43:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D39E884F6;
	Fri,  6 Dec 2019 14:43:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2A36C1D7D;
	Fri,  6 Dec 2019 14:43:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CECBC077D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 14:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E9BB886D80
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 14:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bFt-4_HwQ_rc for <iommu@lists.linux-foundation.org>;
 Fri,  6 Dec 2019 14:43:02 +0000 (UTC)
X-Greylist: delayed 00:17:48 by SQLgrey-1.7.6
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D03B486D2E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 14:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw2YdsVpbPAASPf5HLfoMwze/rZyxD01Tnwt4UmhUMYyaM+w1+2aBpDlZk6cKz50xB0rIa3AA3kJM0z9GM1g5Vn6VRAcknEPwetzQLgUjqSFSRVsFq2Yq1E5Q9x7H/Y7XKh1DbcXWihmbalA3/VYLBts2QVOP3tfwejT/AZpFS6AXnhXYbpczKYZANbX9W1MmMgWE6Sz4qE8qmLBqQLihG43IXm2PfGZ5dmVpXymu9VY/rUM/WaWCCqD+IqRVj8nvGWa8F9gZhuhigKgWW/FyGRmh4+DGUFB9r7xt9SPDYi+AiefPqgzAvDxsC2ZcH6655wXaJ4ggrJ91Cvh044+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od4pN0+qEhGfsdE3/dEeHS9fPLMbYL+0sqtYoqoaV1U=;
 b=HzDlddk0TMfFdTgG/itw1u8fvtrwd64Or4WMbYvfSR8v56fZLq60Hi7IafFXZ/NBAUN1VTLwlI7gOD2z9y3uM7lWrw9K0ehfvVyp4AQ0nkvWogyDF7xVQMqWb0lRFLntWMoBZkjrEP5KBosnCTya9VKgrCoFsN7I2Cv+jRKVxVf7n5DjbkakYOWHjSxbhMbmRZ0w1H4mceGWiojHzTviTfXV8CyuLIb9t3Hoe7u1rkTXgAwqukv8tnQSvluHzFr1HCcOa39eVW19+7rzfeCjixSjEZEghOfBxPCvLa042EMwkJWHUSV1/kOEmtFMo+u0Op2ybKaim+o5JhViDVXkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od4pN0+qEhGfsdE3/dEeHS9fPLMbYL+0sqtYoqoaV1U=;
 b=nV6kfa7Q7ZK2EmASYDB835dq9LlMl75tZkRFmwKs++JkpVu3+94KPBiAvuSShubHn/0GADPs8elIwm7E5zQV5H7yT37WCNebxEawG9ZWYKlS9/sY8dVlyRaWc+lIXH+G1vLB1fsFtxCLeqMx6DJBtedHfioMIroXvewpPAOEu0c=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6814.namprd05.prod.outlook.com (52.132.172.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.5; Fri, 6 Dec 2019 14:10:59 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8%7]) with mapi id 15.20.2516.003; Fri, 6 Dec 2019
 14:10:59 +0000
To: "hch@lst.de" <hch@lst.de>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>
Subject: Re: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Thread-Topic: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Thread-Index: AQHVqqNPg/9Qsdg+60Sr+vJTCD2APKetKK8A
Date: Fri, 6 Dec 2019 14:10:59 +0000
Message-ID: <c98d594b465d3d8228743bc54017b8c456695219.camel@vmware.com>
References: <20191204130339.22804-1-hch@lst.de>
 <20191204130339.22804-3-hch@lst.de>
In-Reply-To: <20191204130339.22804-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25e2256e-836c-485f-9ad7-08d77a561eb0
x-ms-traffictypediagnostic: MN2PR05MB6814:
x-microsoft-antispam-prvs: <MN2PR05MB68143162087E1B6829692182A15F0@MN2PR05MB6814.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(66446008)(316002)(8936002)(71190400001)(66556008)(71200400001)(66476007)(305945005)(5660300002)(91956017)(36756003)(54906003)(110136005)(2906002)(118296001)(66946007)(229853002)(6512007)(86362001)(99286004)(478600001)(102836004)(6506007)(8676002)(81166006)(76176011)(6486002)(186003)(2616005)(81156014)(26005)(4326008)(64756008)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6814;
 H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vNigA4u55E/GOHw8i99hED6wtGY8NN0R1cxCSIzed7w9PEAmjNNOjccHq2+i+UT4XDsY/zkd5rPsAxelKmAfPmsA6VszMwnEmJWyP46XMGco85yjJIKJuZjJh3IfmBdtwZNLYB5skCnJqPUsWomvbWPCNTCsCKyLZL9igp6ZkpzzpdjzESGX7anz8rC6dHDEi6Wm6mUKumJAgtGl4LC2oqtr276TnqylT/s4cF5YwHq944mPFzPHzGSQ009MjPy1uxEVtUPGWC2urgDATzzJu3HOBd9MXHM1znK5MCVo6nA0v5uxdIUuTMMyOg2E8/WAYtyFQNQ8Y8ODoOhZS3w/V4wT4kLA94wTKXHz4BwQwcnEUCTvm6pl271B6lBXmFY5NE7PXZtwXBV+8ssQ9ZnjrMRbyYvwC93hcHLjd28AKuDTtHJFYqgUZI5jIlf6UIr
x-ms-exchange-transport-forked: True
Content-ID: <4EF5620F9EA7224F9ACF5E0AA5D5D863@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e2256e-836c-485f-9ad7-08d77a561eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 14:10:59.5092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +BJ8IvB8xVjAvaPpbl3nqsXbhX+NXOBjkTRaLjlb/SnblsahndquM+UWf/hxPfMyo2qxUUBL6aEj9YWc90K7eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6814
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
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

Hi, Christoph.


On Wed, 2019-12-04 at 14:03 +0100, Christoph Hellwig wrote:
> Devices that are forced to DMA through swiotlb need to be treated as
> if
> they are addressing limited.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/dma-direct.h | 1 +
>  kernel/dma/direct.c        | 8 ++++++--
>  kernel/dma/mapping.c       | 3 +++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 24b8684aa21d..83aac21434c6 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -85,4 +85,5 @@ int dma_direct_mmap(struct device *dev, struct
> vm_area_struct *vma,
>  		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		unsigned long attrs);
>  int dma_direct_supported(struct device *dev, u64 mask);
> +bool dma_direct_addressing_limited(struct device *dev);
>  #endif /* _LINUX_DMA_DIRECT_H */
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 6af7ae83c4ad..450f3abe5cb5 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -497,11 +497,15 @@ int dma_direct_supported(struct device *dev,
> u64 mask)
>  	return mask >= __phys_to_dma(dev, min_mask);
>  }
>  
> +bool dma_direct_addressing_limited(struct device *dev)
> +{
> +	return force_dma_unencrypted(dev) || swiotlb_force ==
> SWIOTLB_FORCE;
> +}
> +
>  size_t dma_direct_max_mapping_size(struct device *dev)
>  {
>  	/* If SWIOTLB is active, use its maximum mapping size */
> -	if (is_swiotlb_active() &&
> -	    (dma_addressing_limited(dev) || swiotlb_force ==
> SWIOTLB_FORCE))
> +	if (is_swiotlb_active() && dma_addressing_limited(dev))
>  		return swiotlb_max_mapping_size(dev);
>  	return SIZE_MAX;
>  }
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 1dbe6d725962..ebc60633d89a 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -416,6 +416,9 @@ EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
>   */
>  bool dma_addressing_limited(struct device *dev)
>  {
> +	if (dma_is_direct(get_dma_ops(dev)) &&
> +	    dma_direct_addressing_limited(dev))
> +		return true;

This works fine for vmwgfx, for which the below expression is always 0.
But it looks like the only current user of dma_addressing_limited
outside of the dma code, radeon, actually wants only the below
expression to force GFP_DMA32 page allocations when the devices have
limited dma address space. Perhaps Christian can elaborate on that.

So in the end it looks like we have two different use cases. One to
force coherent memory (vmwgfx, possibly other grahpics drivers) or
reduced queue depth (vmw_pvscsi) when we have bounce-buffering.

The other one is to force GFP_DMA32 page allocation when the device
dma-addressing is limited. Perhaps this mode can be replaced by using
dma_coherent memory and stripped that functionality from TTM?

>  	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
>  			    dma_get_required_mask(dev);
>  }


Thanks,
Thomas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
