Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF4AC433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 19:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F31E40A89;
	Mon, 28 Mar 2022 19:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k-qpneAd8ZgE; Mon, 28 Mar 2022 19:15:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA24B400FD;
	Mon, 28 Mar 2022 19:14:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99677C002C;
	Mon, 28 Mar 2022 19:14:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95BCEC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 19:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B31360ACA
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 19:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c0eZs74HG3aT for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 19:14:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8202060ABB
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 19:14:57 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SJ7COh009301; 
 Mon, 28 Mar 2022 19:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pp1; bh=FjYCX+Y243xE0VklB5ptHy12OvBRB+CsNXos3UJeMn4=;
 b=Fha71A0kfcKrqpBNMaktuOEjobZnd8F5ntwDVnQzGypfQ1e41HtsN+gBBN3zj8p1q/+j
 PqQWM8i+EzfVHd0NYt3GOZ9qKkamgPa4FiVaNi3GuIqS6NKJiXUf2l4wUFDb5cEj/q56
 ejK7HAGelTZ+uvetF+lMVfVc2ayTGuds6BJmgETz9xP9F3TDu7rhBWwdyrzJZCudRVMv
 6XX4z49tIqNxFTsvQr84rnFBaLEyOKWjj1kwtFZ9Cfi3D4+aQJfGau4H08ddk5bhSLB6
 k1+mugefDLF9e3NWYmGpIZ+bXT0WBtng+jJQ0dHsfmKEtaZq+hmL4kCqDqGWU4WKNOFA iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f3hbr1sax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Mar 2022 19:14:54 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22SJApSF027093;
 Mon, 28 Mar 2022 19:14:54 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f3hbr1san-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Mar 2022 19:14:54 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22SJDegC012562;
 Mon, 28 Mar 2022 19:14:53 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma03dal.us.ibm.com with ESMTP id 3f1tf9k5n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Mar 2022 19:14:53 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22SJEqdZ22413670
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Mar 2022 19:14:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D65DFB2066;
 Mon, 28 Mar 2022 19:14:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA127B2068;
 Mon, 28 Mar 2022 19:14:52 +0000 (GMT)
Received: from porter (unknown [9.1.104.123])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS;
 Mon, 28 Mar 2022 19:14:52 +0000 (GMT)
Received: from dfsmith by porter with local (Exim 4.92)
 (envelope-from <dfsmith@porter.almaden.ibm.com>)
 id 1nYupH-0004qe-Un; Mon, 28 Mar 2022 12:14:52 -0700
Date: Mon, 28 Mar 2022 12:14:51 -0700
From: "Daniel F. Smith" <dfsmith@us.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Bug report: VFIO map/unmep mem subject to race and DMA data goes
 to incorrect page (4.18.0)
Message-ID: <20220328191451.GA18248@porter.almaden.ibm.com>
References: <20220325200640.GA29990@porter.almaden.ibm.com>
 <20220325161022.00ab43ff.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20220325161022.00ab43ff.alex.williamson@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ktKAFhHu5tFBQFfRLMm1k7x7lnG8F0cA
X-Proofpoint-ORIG-GUID: -MbKslIAxpB5KIJRQZ-9Gx4Jfuq9tXlR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_09,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280100
Cc: iommu@lists.linux-foundation.org
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
Reply-To: dfsmith@us.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Alex,

Answers to questions I can answer are in-line.  First an apology
though---the machine with the FPGA board is 1000 miles remote, and I don't
have root access.  It's unlikely I will be able to do kernel patch testing.


Alex Williamson scribed the following, on or around Fri, Mar 25, 2022 at 04:10:22PM -0600:
> Hi Daniel,
> 
...
>
> Coherency possibly.
> 
> There's a possible coherency issue at the compare depending on the
> IOMMU capabilities which could affect whether DMA is coherent to memory
> or requires an explicit flush.  I'm a little suspicious whether dmar0
> is really the IOMMU controlling this device since you mention a 39bit
> IOVA space, which is more typical of Intel client platforms which can
> also have integrated graphics which often have a dedicated IOMMU at
> dmar0 that isn't necessarily representative of the other IOMMUs in the
> system, especially with regard to snoop-control.  Each dmar lists the
> managed devices under it in sysfs to verify.  Support for snoop-control
> would be identified in the ecap register rather than the cap register.
> VFIO can also report coherency via the VFIO_DMA_CC_IOMMU extension
> reported by VFIO_CHECK_EXTENSION ioctl.

$ cat /sys/devices/virtual/iommu/dmar0/intel-iommu/cap
d2008c40660462
$ cat /sys/devices/virtual/iommu/dmar0/intel-iommu/ecap
f050da
$ lscpu | grep Model
Model:               165
Model name:          Intel(R) Xeon(R) W-1290P CPU @ 3.70GHz
$ ls -l /sys/devices/virtual/iommu/dmar0/devices | wc -l
24
$ ... ioctl(container_fd, VFIO_CHECK_EXTENSION, VFIO_DMA_CC_IOMMU)
0

What are the implications of having no "IOMMU enforces DMA cache
conherence"?  On this machine there is no access to a PCIe bus analyzer, but
it's very unlikely that the TLPs would have NoSnoop set.

Is there a good way How can I tell what IOMMU I'm using?

(I did think it was strange that the IOMMU in this machine cannot handle
enough bits for mapping IOVA==VMA.  The test code is running in a podman
container, but (naively) I wouldn't expect that to make a difference.)

> However, CPU coherency might lead to a miscompare, but not necessarily a
> miscompare matching the previous iteration.  Still, for completeness
> let's make sure this isn't a gap in the test programming making invalid
> assumptions about CPU/DMA coherency.
> 
> The fact that randomizing the IOVA provides a workaround though might
> suggest something relative to the IOMMU page table coherency.  But for
> the new mmap target to have the data from the previous iteration, the
> IOMMU PTE would need to be stale on read, but correct on write in order
> to land back in your new mmap.  That seems peculiar.  Are we sure the
> FPGA device isn't caching the value at the IOVA or using any sort of
> IOTLB caching such as ATS that might not be working correctly?

I cannot say for certain what the FPGA caches, if anything.  The IP for that
part is closed (search for Xilinx PG302 QDMA).  It should (!) be
well-tested... oh for an analyzer!

> > Suggestion: Document issue when using fixed IOVA, or fix if security
> > is a concern.
> 
> I don't know that there's enough information here to make any
> conclusions.  Here are some further questions:
> 
>  * What size mappings are being used, both for the mmap and the VFIO
>    MAP/UNMAP operations.

The test would often fail switching from an 8KB allocation to 12KB where the
VMA would grow down by a page.  The mmap() always returned a 4KB aligned
VMA, and the requested mmap() size was always an exact number of 4KB pages. 
The VFIO map operations were always on the full extent of the mmap'd memory
(likely makes Baulu's patch moot in this case).

A typical (not consistent) syndrome would be:
  1st page: ok
  2nd page: previous mmap'd data.
  3rd page: ok
We saw the issue on transfers both to and from the card.  I.e., we placed a
memory block in the FPGA that we could interrogate when data were corrupted.

(And as mentioned, just changing the IOVA fixed this issue.)

>  * If the above is venturing into super page support (2MB), does the
>    vfio_iommu_type1 module option disable_hugepages=1 affect the
>    results.

N/A.

>  * Along the same lines, does the kernel command line option
>    intel_iommu=sp_off produce different results.

Would this affect small pages?

>  * Does this behavior also occur on upstream kernels (ie. v5.17)?

Unknown, and (unfortunately) untestable at present.

>  * Do additional CPU cache flushes in the test program produce different
>    results?

We did a number of experiments using combinations of MAP_LOCKED, mlock(),
barrier(), _mm_clflush().  They all affected reliability of the test
(through timing?), but all ultimately failed.  I'm happy to try other
flushes that can be achieved in non-root user space!

>  * Is this a consumer available FPGA device that others might be able
>    to reproduce this issue?  I've always wanted such a device for
>    testing, but also we can't rule out that the FPGA itself or its
>    programming is the source of the miscompare.

https://www.xilinx.com/products/boards-and-kits/vcu118.html
Just don't look at the price too hard!

> >From the vfio perspective, UNMAP_DMA should first unmap the pages at
> the IOMMU to prevent device access before unpinning the pages.  We do
> make use of batch unmapping to reduce iotlb flushing, but the result is
> expected to be that the IOMMU PTE entries are invalidated before the
> UNMAP_DMA operation completes.  A stale IOVA would not be expected or
> correct operation.  Thanks,
> 
> Alex

Thanks.

Daniel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
