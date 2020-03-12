Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3DC1975A
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 15:41:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044E0206BE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 15:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=allegrodvt.com header.i=@allegrodvt.com header.b="YHk1LXqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044E0206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allegrodvt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD4E888440;
	Thu, 12 Mar 2020 15:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YWlkpOfqcbn2; Thu, 12 Mar 2020 15:41:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA0DB8808F;
	Thu, 12 Mar 2020 15:41:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A792CC18D3;
	Thu, 12 Mar 2020 15:41:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51509C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 15:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4DC8687A39
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 15:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ufN-CAtfbMT for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 15:41:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-eopbgr90129.outbound.protection.outlook.com [40.107.9.129])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 611E487A2F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 15:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hdfo/UEcJKVt7t3dxRxG0FBcC2LJTVG+0y/MQCllf4zPZ0/vJpip8vn4wSWR3REFy3XiEs3l0UmNnsq7jGuu6mf2m7GYPXbbMUpgk/DvUckkoyR4uiIgOy86OXjFDJ+NcQIeBCejU26W/MAlS7CDGpc42nN2YdpZN68qp3o+dyziQzyWYKXA9seNMtCsftslZRCiKM+121DSnkZWOdAJ3wYko5hhXnPiw/96lXC7DanAMlhthnm4REhJt9OiGMdoMMwDPU9jZbaaVfdCp18eH4YVT18P6FwRn2MtOyWy27nZEnjG+Yeeo689OYJbNEzxLP0pwrxO9b6mhlwISquCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdYGAMGleSSh7fJ++ZIcrH4OxxESn/TESQjyu1lCF2U=;
 b=AdaGEo8WgI/5IvRZ5+8VRAqlCLc2cfy5yUSzRGmYzzWtTCnfnfbdXuWKwOMj+jqgEIAGwl74ohMR6afW0XR1aFMRoIfkxoz+5YxIr+trZnJaCvv21B7ieNTEeJ5YwFTs1td9uZUDv7NXEWlut1aP7fI9riP0yaTZWfFthYXbYenQv82IOZ/chfPt79kd9lX0rem8J0p1nzwtCnmid1IYORq87sxRVxImq0EQBxLxbz5j1YydXARn3bFgXWC6QRv0ljE/KHfxihjABqCLLEGIBwpY5x4an3nTMOXeVUcbG8BQ+tTviyvxdXhl3s+KbAfPSPRUkBPTGiX6nptxFOm10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=allegrodvt.com; dmarc=pass action=none
 header.from=allegrodvt.com; dkim=pass header.d=allegrodvt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=allegrodvt.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdYGAMGleSSh7fJ++ZIcrH4OxxESn/TESQjyu1lCF2U=;
 b=YHk1LXqPfgnUugfc7qVLpFB5/SkFcd4pflreMqHnkc1BbCfAd1QVkCGByu5R7wm0UoyHSJHFqkSwfL3EbA0Jfxfx3PFgzFyn/L/fBbPrqnwi78EAga34x98wofv08r+gRESHPTq91YjTEG0q/KjqfFR2ITa8pkxJCq167o5ib2zeiZS/52ECBAu25vz4NmzuaXAxWNBOQYwRUfZIRMp20pqfhwJ5JKiXb/kvqL0MdQm8EWJME1RN13ekT0OO8chqjD05ujPET6x9Ce1JhPOq3IwbYIidHa9NOrCokJvMqxvLbyirUXJnuh7cpbvX1lWntEHUPA2rnt/svz/9kbb2BA==
Received: from MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM (52.134.49.145) by
 MRXP264MB0823.FRAP264.PROD.OUTLOOK.COM (52.134.43.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Thu, 12 Mar 2020 15:41:45 +0000
Received: from MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 ([fe80::84af:fd44:26b8:7b02]) by MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 ([fe80::84af:fd44:26b8:7b02%5]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 15:41:45 +0000
Received: from localhost.localdomain (185.223.150.134) by
 PR0P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Thu, 12 Mar 2020 15:41:45 +0000
From: Kevin Grandemange <kevin.grandemange@allegrodvt.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3] [dma-coherent] Fix integer overflow in the reserved-memory
 dma allocation
Thread-Topic: [PATCH v3] [dma-coherent] Fix integer overflow in the
 reserved-memory dma allocation
Thread-Index: AQHV+IS8MM7sTj8apEi9KYk+hfYnxg==
Date: Thu, 12 Mar 2020 15:41:45 +0000
Message-ID: <20200312154040.17040-1-kevin.grandemange@allegrodvt.com>
References: <6b2b656c-33ee-4e02-e687-c71ff43de584@arm.com>
In-Reply-To: <6b2b656c-33ee-4e02-e687-c71ff43de584@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::33)
 To MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:23::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kevin.grandemange@allegrodvt.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [185.223.150.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd4ec84d-977f-48de-832b-08d7c69bde9d
x-ms-traffictypediagnostic: MRXP264MB0823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MRXP264MB08231FAB6CC924CA88E2B29C87FD0@MRXP264MB0823.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39830400003)(366004)(396003)(136003)(199004)(508600001)(71200400001)(54906003)(86362001)(956004)(186003)(2906002)(81156014)(81166006)(6916009)(6512007)(16526019)(44832011)(26005)(1076003)(64756008)(66446008)(8676002)(36756003)(66556008)(52116002)(66946007)(69590400007)(8936002)(6486002)(2616005)(66476007)(107886003)(5660300002)(316002)(6506007)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MRXP264MB0823;
 H:MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: allegrodvt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SD4p90OHCCgPUc7f57QDXfbcM9DijcbQ3EjQYQV8nxi6rao7BjwBYd2KSBL0bAEgCe6D/fmLRYvVTj0gaSvY3h67qGk2lTMOxhrbVMX9rI+NfvwLuWsB6CkLVfKthX4VfojNokKTJIszgV2Lun0QIUpOp5ce0jjYNiksv6/cxld0fs2PcSHgwhqK/Hn6EBTknNMZ/5zO33fENm0GtHbwPBEbLfljDzYUB2VT7gKJ17JobzfTtKLIeE4D4piYgLyVw39UimcivJ9CQpYbolVVm7Gc9k22q53YYKhjthM4d68F3ja3CmEGkew5045na9twUe1NBjYZbPlah9uUAau4pZ3jizeZMglKlACoilsy5rP9w8KVNMzplV+XpSqUmwghpkbVP6VIU8F/BvwWzY1sVOTO85Lsp4iJFrEsjH3PFzzOAptiphgVovF1JW8l9T8OkiqXb5ZG5gf2etDgy09jmF594O+UdRMNeQwIUmjGPqggUJDnd+NUrkHjIz7kik80
x-ms-exchange-antispam-messagedata: Yrh++T9yOgE5arMVLDx6Q1LfzPaH0s15CV9a3llUYe1fbm3toboqlHW+DtpNhKZg7UcfZSqsAIPLY17F+KFJmBfB9Gf8vP2FSjKcW/tBJrOlbDapcYPPVR3mT60yneBMLMz60ksvMhVgWI7xxXitog==
MIME-Version: 1.0
X-OriginatorOrg: allegrodvt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4ec84d-977f-48de-832b-08d7c69bde9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 15:41:45.5108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c7a5ec0-2d92-465a-a3e1-9e3f1e9fd917
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYyutCl564HjfPbflc8LVaOCkYGezG5OW387f+tOjdr/X05vPNd2hFhDXbjg1vcceGpUfJPaakNclyTYXkarkMsDeg5w+C8VhcB470NyyeCpO3aIGpZX37Jt7I6+A/DT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0823
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kevin Grandemange <kevin.grandemange@allegrodvt.com>,
 Robin Murphy <robin.murphy@arm.com>
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

pageno is an int and the PAGE_SHIFT shift is done on an int,
overflowing if the memory is bigger than 2G

This can be reproduced using for example a reserved-memory of 4G

reserved-memory {
		    #address-cells = <2>;
		    #size-cells = <2>;
		    ranges;

		    reserved_dma: buffer@0 {
		        compatible = "shared-dma-pool";
		        no-map;
		        reg = <0x5 0x00000000 0x1 0x0>;
        };
};

Signed-off-by: Kevin Grandemange <kevin.grandemange@allegrodvt.com>
---

Changes v1 -> v2:
  - removed mem_offset tmp variable
  - use dma_addr_t instead of ssize_t
  - Fix reserved-memory size in the dts example

Changes v2 -> v3:
  - Fix several other site where PAGE_SHIFT shifts are done on ints.

 kernel/dma/coherent.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 551b0eb7028a..d322cb786e7e 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -134,7 +134,7 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 
 	spin_lock_irqsave(&mem->spinlock, flags);
 
-	if (unlikely(size > (mem->size << PAGE_SHIFT)))
+	if (unlikely(size > ((dma_addr_t)mem->size << PAGE_SHIFT)))
 		goto err;
 
 	pageno = bitmap_find_free_region(mem->bitmap, mem->size, order);
@@ -144,8 +144,8 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 	/*
 	 * Memory was found in the coherent area.
 	 */
-	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
-	ret = mem->virt_base + (pageno << PAGE_SHIFT);
+	*dma_handle = dma_get_device_base(dev, mem) + ((dma_addr_t)pageno << PAGE_SHIFT);
+	ret = mem->virt_base + ((dma_addr_t)pageno << PAGE_SHIFT);
 	spin_unlock_irqrestore(&mem->spinlock, flags);
 	memset(ret, 0, size);
 	return ret;
@@ -194,7 +194,7 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
 				       int order, void *vaddr)
 {
 	if (mem && vaddr >= mem->virt_base && vaddr <
-		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
+		   (mem->virt_base + ((dma_addr_t)mem->size << PAGE_SHIFT))) {
 		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
 		unsigned long flags;
 
@@ -238,7 +238,7 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 		struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
 {
 	if (mem && vaddr >= mem->virt_base && vaddr + size <=
-		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
+		   (mem->virt_base + ((dma_addr_t)mem->size << PAGE_SHIFT))) {
 		unsigned long off = vma->vm_pgoff;
 		int start = (vaddr - mem->virt_base) >> PAGE_SHIFT;
 		int user_count = vma_pages(vma);
@@ -248,7 +248,7 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 		if (off < count && user_count <= count - off) {
 			unsigned long pfn = mem->pfn_base + start + off;
 			*ret = remap_pfn_range(vma, vma->vm_start, pfn,
-					       user_count << PAGE_SHIFT,
+					       (unsigned long)user_count << PAGE_SHIFT,
 					       vma->vm_page_prot);
 		}
 		return 1;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
