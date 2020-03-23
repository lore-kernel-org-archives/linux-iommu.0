Return-Path: <SRS0=qkVD=5I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF03C54EEB
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 15:42:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B331420409
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 15:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B331420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9068486C1B;
	Mon, 23 Mar 2020 15:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2V6e3s0QjAqM; Mon, 23 Mar 2020 15:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BAD2385CFF;
	Mon, 23 Mar 2020 15:42:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF1CBC1AE2;
	Mon, 23 Mar 2020 15:42:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDB55C1AE2
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 15:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D736E22F22
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 15:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aSw5wOzvPdqK for <iommu@lists.linux-foundation.org>;
 Mon, 23 Mar 2020 15:37:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by silver.osuosl.org (Postfix) with ESMTPS id BFE9C22E8C
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 15:37:52 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02NFYWI0079016; Mon, 23 Mar 2020 11:37:45 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywbtfmy26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 11:37:45 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02NFZICG013506;
 Mon, 23 Mar 2020 15:37:44 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 2ywaw95t6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 15:37:44 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02NFbhPO50725358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2020 15:37:43 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A33AB112063;
 Mon, 23 Mar 2020 15:37:43 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AEEE112065;
 Mon, 23 Mar 2020 15:37:41 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.116.134])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2020 15:37:40 +0000 (GMT)
X-Mailer: emacs 27.0.90 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
In-Reply-To: <20200323085059.GA32528@lst.de>
References: <20200320141640.366360-1-hch@lst.de>
 <20200320141640.366360-2-hch@lst.de>
 <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru>
 <20200323083705.GA31245@lst.de> <20200323085059.GA32528@lst.de>
Date: Mon, 23 Mar 2020 21:07:38 +0530
Message-ID: <87sghz2ibh.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_05:2020-03-21,
 2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=48 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230086
X-Mailman-Approved-At: Mon, 23 Mar 2020 15:42:44 +0000
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
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

Christoph Hellwig <hch@lst.de> writes:

> On Mon, Mar 23, 2020 at 09:37:05AM +0100, Christoph Hellwig wrote:
>> > > +	/*
>> > > +	 * Allows IOMMU drivers to bypass dynamic translations if the DMA mask
>> > > +	 * is large enough.
>> > > +	 */
>> > > +	if (dev->dma_ops_bypass) {
>> > > +		if (min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit) >=
>> > > +				dma_direct_get_required_mask(dev))
>> > > +			return true;
>> > > +	}
>> > 
>> > 
>> > Why not do this in dma_map_direct() as well?
>> 
>> Mostly beacuse it is a relatively expensive operation, including a
>> fls64.
>
> Which I guess isn't too bad compared to a dynamic IOMMU mapping.  Can
> you just send a draft patch for what you'd like to see for ppc?

This is what I was trying, but considering I am new to DMA subsystem, I
am not sure I got all the details correct. The idea is to look at the
cpu addr and see if that can be used in direct map fashion(is
bus_dma_limit the right restriction here?) if not fallback to dynamic
IOMMU mapping.

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index e486d1d78de2..bc7e6a8b2caa 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -31,6 +31,87 @@ static inline bool dma_iommu_map_bypass(struct device *dev,
 		(!iommu_fixed_is_weak || (attrs & DMA_ATTR_WEAK_ORDERING));
 }
 
+static inline bool __dma_direct_map_capable(struct device *dev, struct page *page,
+					    unsigned long offset, size_t size)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+	dma_addr_t dma_addr = phys_to_dma(dev, phys);
+	dma_addr_t end = dma_addr + size - 1;
+
+	return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
+}
+
+static inline bool dma_direct_map_capable(struct device *dev, struct page *page,
+					  unsigned long offset, size_t size,
+					  unsigned long attrs)
+{
+	if (!dma_iommu_map_bypass(dev, attrs))
+		return false;
+
+	if (!dev->dma_mask)
+		return false;
+
+	return __dma_direct_map_capable(dev, page, offset, size);
+}
+
+
+static inline bool dma_direct_unmap_capable(struct device *dev, dma_addr_t addr, size_t size,
+					    unsigned long attrs)
+{
+	dma_addr_t end = addr + size - 1;
+
+	if (!dma_iommu_map_bypass(dev, attrs))
+		return false;
+
+	if (!dev->dma_mask)
+		return false;
+
+	return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
+}
+
+static inline bool dma_direct_sg_map_capable(struct device *dev, struct scatterlist *sglist,
+					     int nelems, unsigned long attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	if (!dma_iommu_map_bypass(dev, attrs))
+		return false;
+
+	if (!dev->dma_mask)
+		return false;
+
+	for_each_sg(sglist, sg, nelems, i) {
+		if (!__dma_direct_map_capable(dev, sg_page(sg),
+					      sg->offset, sg->length))
+			return false;
+	}
+	return true;
+}
+
+static inline bool dma_direct_sg_unmap_capable(struct device *dev, struct scatterlist *sglist,
+					       int nelems, unsigned long attrs)
+{
+	int i;
+	dma_addr_t end;
+	struct scatterlist *sg;
+
+	if (!dma_iommu_map_bypass(dev, attrs))
+		return false;
+
+	if (!dev->dma_mask)
+		return false;
+
+	for_each_sg(sglist, sg, nelems, i) {
+		end = sg->dma_address + sg_dma_len(sg);
+
+		if (end > min_not_zero(*dev->dma_mask, dev->bus_dma_limit))
+			return false;
+	}
+	return true;
+}
+
+
 /* Allocates a contiguous real buffer and creates mappings over it.
  * Returns the virtual address of the buffer and sets dma_handle
  * to the dma address (mapping) of the first page.
@@ -67,7 +148,7 @@ static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 				     enum dma_data_direction direction,
 				     unsigned long attrs)
 {
-	if (dma_iommu_map_bypass(dev, attrs))
+	if (dma_direct_map_capable(dev, page, offset, size, attrs))
 		return dma_direct_map_page(dev, page, offset, size, direction,
 				attrs);
 	return iommu_map_page(dev, get_iommu_table_base(dev), page, offset,
@@ -79,7 +160,7 @@ static void dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				 size_t size, enum dma_data_direction direction,
 				 unsigned long attrs)
 {
-	if (!dma_iommu_map_bypass(dev, attrs))
+	if (!dma_direct_unmap_capable(dev, dma_handle, size, attrs))
 		iommu_unmap_page(get_iommu_table_base(dev), dma_handle, size,
 				direction,  attrs);
 	else
@@ -91,7 +172,7 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
 			    unsigned long attrs)
 {
-	if (dma_iommu_map_bypass(dev, attrs))
+	if (dma_direct_sg_map_capable(dev, sglist, nelems, attrs))
 		return dma_direct_map_sg(dev, sglist, nelems, direction, attrs);
 	return ppc_iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
 				dma_get_mask(dev), direction, attrs);
@@ -101,7 +182,7 @@ static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction,
 		unsigned long attrs)
 {
-	if (!dma_iommu_map_bypass(dev, attrs))
+	if (!dma_direct_sg_unmap_capable(dev, sglist, nelems, attrs))
 		ppc_iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems,
 			   direction, attrs);
 	else
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 99f72162dd85..702a680f5766 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1119,6 +1119,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	spin_unlock(&direct_window_list_lock);
 
 	dma_addr = be64_to_cpu(ddwprop->dma_base);
+	dev->dev.bus_dma_limit = dma_addr + query.largest_available_block;
 	goto out_unlock;
 
 out_free_window:
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
