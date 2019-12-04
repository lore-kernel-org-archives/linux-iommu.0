Return-Path: <SRS0=Oyzs=Z2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E99C432C0
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 02:26:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5552068E
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 02:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5552068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0435587E5C;
	Wed,  4 Dec 2019 02:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNysI3ieUfv9; Wed,  4 Dec 2019 02:26:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D402787E3B;
	Wed,  4 Dec 2019 02:26:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B81A2C18DC;
	Wed,  4 Dec 2019 02:26:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD25DC1798
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 02:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B7303877F5
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 02:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDejXvIR98Fk for <iommu@lists.linux-foundation.org>;
 Wed,  4 Dec 2019 02:26:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A8E8F876FB
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 02:26:43 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Dec 2019 18:26:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,275,1571727600"; 
 d="scan'208,223";a="223058085"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 03 Dec 2019 18:26:41 -0800
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:667!
To: AM <am.online.edu@gmail.com>, iommu@lists.linux-foundation.org
References: <CAL20ACJ2cM1Zs3q5rb3jG7fDVNfzySV6WX=+nbdKiS4KT52NaQ@mail.gmail.com>
 <f0913338-3854-6ff7-aa8c-85b96efbed27@linux.intel.com>
 <CAL20ACLtwjDLaPattEkPiufsgHa2k-4Wb_Dw7Urh9we0QwbJfQ@mail.gmail.com>
 <da7fb26f-022b-eaad-1a91-11cf15531f8a@linux.intel.com>
 <CAL20ACL_t0zAnQKvfj=VHM1jBLfOuCkCOFoQxn+S1vJoZfU6yg@mail.gmail.com>
 <CAL20ACLnsBVG6g6BBVASP9jYBzXQJR-y7WRY-D4a8Rv+aZtWCg@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b9b0cd40-560a-089d-0582-5f180f92c5c0@linux.intel.com>
Date: Wed, 4 Dec 2019 10:26:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAL20ACLnsBVG6g6BBVASP9jYBzXQJR-y7WRY-D4a8Rv+aZtWCg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------D1D85ECFE7B42C802D7F028C"
Content-Language: en-US
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--------------D1D85ECFE7B42C802D7F028C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 12/4/19 3:22 AM, AM wrote:
> Hi Lu Baolu,
> 
> I tried kernel 4.18.0-147.6.el8.x86_64+debug and used the following API 
> sequence for mapping multiple hugepages:
> 
> get_user_pages_fast()
> sg_alloc_table_from_pages()
> // also tried sg_alloc_table() w/ sg_set_page() using 1GB size for each 
> entry
> dma_map_sg()
> 
> I'm able to DMA upto 1GB successfully and validate the data. Also, DMA 
> above 1GB completes w/o any error, but data isn't correct starting 
> immediately after 1GB i.e. second GB offset 0x40000000 starts showing 
> data mismatches.

I am not sure whether you followed the right way to build a sg list. But
I do care that Intel IOMMU does dma_map_sg() right.

Can you please try the attached patch? It can help you get more tracing
information when you call dma_map_sg().

Best regards,
baolu

> 
> I've used get_user_pages_fast() in two ways to no avail:
> 1. populate page array w/ first page of 1GB hugepage and used 
> sg_set_page() for
>     setting 1GB size of the page entry. This debugging effort uses the fact
>     that all pages following the first page of huge page start address 
> are contiguous.
>     Ideally dma_map_sg() should coalesce contiguous pages, and my 
> intention was to collect
>     more data from debugging.
> 2. populate page array w/ all pages from all hugepages
> 
> Thanks,
> -am
> 
> 
> 
> On Sun, Dec 1, 2019 at 7:33 PM Anand Misra <am.online.edu@gmail.com 
> <mailto:am.online.edu@gmail.com>> wrote:
> 
>     [+iommu_list]
> 
>     Application isn't aware of hugepage but a userspace (lower) level
>     stack is aware of the type of memory being allocated on behalf of
>     application, which in turn communicates w/ driver via ioctl. I'm
>     trying to make it more agnostic by using dma_map_sg() when multiple
>     GBs are required by application. Otherwise, I'm using
>     dmap_map_page(). Admittedly, I'm learning these concepts/APIs for
>     Linux along the way.
> 
>     Thanks,
>     -am
> 
> 
>     On Sun, Dec 1, 2019 at 7:12 PM Lu Baolu <baolu.lu@linux.intel.com
>     <mailto:baolu.lu@linux.intel.com>> wrote:
> 
>         Hi,
> 
>         On 12/2/19 11:00 AM, Anand Misra wrote:
>          > Thanks, Lu Baolu. This is the dev version we've in our
>         company. I can
>          > try on a Ubuntu with a recent kernel version. Although, do
>         you think I'm  > going in the right direction? Is it possible to
>         have multiple hugepages
>          > mapped via iommu to get contiguous mapping for DMA?
>          >
> 
>         You mentioned:
> 
>         "
>         I'm trying to use iommu for multiple hugepages (mmap'ed by
>         process and
>         pushed to driver via ioctl). The expectation is to have multiple
>         hugepages mapped via iommu with each huge page having an entry
>         in iommu
>         (i.e. minimize table walk for DMA). Is this possible?
>         "
> 
>         Currently huge page mapping is hidden in iommu driver according
>         to the
>         iommu capability and size of map range. Why do you want to be
>         aware of
>         it in driver or even application level?
> 
>         Best regards,
>         baolu
> 
>          > -am
>          >
>          >
>          > On Sun, Dec 1, 2019 at 6:24 PM Lu Baolu
>         <baolu.lu@linux.intel.com <mailto:baolu.lu@linux.intel.com>
>          > <mailto:baolu.lu@linux.intel.com
>         <mailto:baolu.lu@linux.intel.com>>> wrote:
>          >
>          >     Hi,
>          >
>          >     On 12/2/19 9:46 AM, Anand Misra wrote:
>          >      > Hello:
>          >      >
>          >      > I'm in process of adding iommu support in my driver
>         for a PCIe
>          >     device.
>          >      > The device doesn't publish ACS/ATS via its config
>         space. I've
>          >     following
>          >      > config:
>          >      >
>          >      > Linux cmdline: "intel-iommu=on iommu=pt
>          >      > vfio_iommu_type1.allow_unsafe_interrupts=1
>          >     pcie_acs_override=downstream"
>          >      > Centos kernel: 3.10.0-1062.1.2.el7.x86_64
>          >      >
>          >
>          >     Can you please use the latest kernel for test? 3.10 seems
>         to be pretty
>          >     old and there are a lot of changes after it.
>          >
>          >     Best regards,
>          >     baolu
>          >
> 

--------------D1D85ECFE7B42C802D7F028C
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-iommu-vt-d-trace-Extend-map_sg-trace-event.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-iommu-vt-d-trace-Extend-map_sg-trace-event.patch"

From c10422b2827b3fd4141ddac2601608ed6c883cea Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Wed, 4 Dec 2019 10:10:20 +0800
Subject: [PATCH 1/1] iommu/vt-d: trace: Extend map_sg trace event

Current map_sg stores trace message in a coarse manner. This
extends it so that more detailed messages could be traced.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c        |  4 +--
 include/trace/events/intel_iommu.h | 43 +++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6db6d969e31c..b47b8ba5ac0f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3769,8 +3769,8 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		return 0;
 	}
 
-	trace_map_sg(dev, iova_pfn << PAGE_SHIFT,
-		     sg_phys(sglist), size << VTD_PAGE_SHIFT);
+	for_each_sg(sglist, sg, nelems, i)
+		trace_map_sg(dev, i + 1, nelems, sg);
 
 	return nelems;
 }
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index 54e61d456cdf..8b0199d80b75 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -49,12 +49,6 @@ DEFINE_EVENT(dma_map, map_single,
 	TP_ARGS(dev, dev_addr, phys_addr, size)
 );
 
-DEFINE_EVENT(dma_map, map_sg,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-	TP_ARGS(dev, dev_addr, phys_addr, size)
-);
-
 DEFINE_EVENT(dma_map, bounce_map_single,
 	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
 		 size_t size),
@@ -99,6 +93,43 @@ DEFINE_EVENT(dma_unmap, bounce_unmap_single,
 	TP_ARGS(dev, dev_addr, size)
 );
 
+DECLARE_EVENT_CLASS(dma_map_sg,
+	TP_PROTO(struct device *dev, int index, int total,
+		 struct scatterlist *sg),
+
+	TP_ARGS(dev, index, total, sg),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(dma_addr_t, dev_addr)
+		__field(phys_addr_t, phys_addr)
+		__field(size_t,	size)
+		__field(int, index)
+		__field(int, total)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->dev_addr = sg->dma_address;
+		__entry->phys_addr = sg_phys(sg);
+		__entry->size = sg->dma_length;
+		__entry->index = index;
+		__entry->total = total;
+	),
+
+	TP_printk("dev=%s [%d/%d] dev_addr=0x%llx phys_addr=0x%llx size=%zu",
+		  __get_str(dev_name), __entry->index, __entry->total,
+		  (unsigned long long)__entry->dev_addr,
+		  (unsigned long long)__entry->phys_addr,
+		  __entry->size)
+);
+
+DEFINE_EVENT(dma_map_sg, map_sg,
+	TP_PROTO(struct device *dev, int index, int total,
+		 struct scatterlist *sg),
+	TP_ARGS(dev, index, total, sg)
+);
+
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.17.1


--------------D1D85ECFE7B42C802D7F028C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------D1D85ECFE7B42C802D7F028C--
