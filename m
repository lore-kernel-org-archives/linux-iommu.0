Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F90C4646B
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 06:56:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91E42086D
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 06:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TZRqqw1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91E42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A672DDBB;
	Wed, 26 Jun 2019 06:56:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7A3DBCAF
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 04:34:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BFF26710
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 04:34:36 +0000 (UTC)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id
	20190626043434epoutp023518f5ac60fbfa7e349ead36ad154480~rpYI1lLVc0514605146epoutp02T
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 04:34:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
	20190626043434epoutp023518f5ac60fbfa7e349ead36ad154480~rpYI1lLVc0514605146epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1561523674;
	bh=Uil1sNUIYKSfrl7WxBso5l/UfVDometkHHjwaxg4WIM=;
	h=Subject:Reply-To:From:To:Date:References:From;
	b=TZRqqw1rrCikeANZWayGDbh9FHvHUmU0hbqEi79vs4+ZkKGz8NztPtu4uqKiZ7ni/
	lsI2W/A5YkGymhek3rQD3FBczEYWzxE5Q9Fc87IesTYwkP57tseGSMtuXOH5FcjS3c
	eywzOyowbeTDDs70izU24lMayiOXXKgrAkClaIfI=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20190626043434epcas5p2e963a5b36d5a82d03288b5e18557543e~rpYIkAF7p0352603526epcas5p2p
	for <iommu@lists.linux-foundation.org>; Wed, 26 Jun 2019 04:34:34 +0000
	(GMT)
X-AuditID: b6c32a49-59fff70000000fe7-4d-5d12f5da7cda
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EC.0D.04071.AD5F21D5; Wed, 26 Jun 2019 13:34:34 +0900 (KST)
Mime-Version: 1.0
Subject: CMA in AMD IOMMU driver
From: Sathyavathi M <sathya.m@samsung.com>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea@epcms5p8>
Date: Wed, 26 Jun 2019 10:04:33 +0530
X-CMS-MailID: 20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmlu6tr0KxBhtXsVks2G/twOgx+cZy
	xgDGKC6blNSczLLUIn27BK6MqffuMRY85alYfuwpUwPjHK4uRk4OCQETib1vLzN2MXJxCAns
	ZpT4/uoFkMPBwSsgKPF3hzBIjbCAgsTCjuesILaQgJzEncNdTBBxHYm+Z9PYQcrZBLQkXj3l
	AQmLCHhKzD+ykA1iPK/EjPanLBC2tMT25VsZIWxRiZur37LD2O+PzYeKi0i03jvLDGELSjz4
	uRvsGpDeiacCIMLlEme2b2QBuVhCoIFRouvGXlaIhLnE3HvfwWbyCvhKHJ/yG6yXRUBVYuYf
	S4gSF4l3K36DjWcWkJfY/nYOM0gJs4CmxPpd+hBhPone30+YYK7fMQ/GVpI48fktlC0hsWY/
	zFYPia6p9xkhgRMo8WJfE+sERtlZiCCchWTZLIRlCxiZVzFKphYU56anFpsWGOallusVJ+YW
	l+al6yXn525iBEetlucOxlnnfA4xCnAwKvHwNsgLxQqxJpYVV+YeYpTgYFYS4V2aKBArxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnHcS69UYIYH0xJLU7NTUgtQimCwTB6dUA6PRXv0u617+WA0m
	42Vrqv397Z07lCZwMrVutj52V/f6x1MWcTxBC2WUPbx6Ju242Fu4oP6Ld/dno3OP5s/T4Lzy
	tVrVusp7rrmz666PzAXCDaG+B6I6eSS7Lj23X9jY1NpXcJ1Dp2zjxiPq3H23Jbw3PLBY9H7j
	lPkcpRmWs3ZslnuT7KxxU4mlOCPRUIu5qDgRAKjp/9rWAgAA
X-CMS-RootMailID: 20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea
References: <CGME20190626043433epcms5p84b9b6580f6c6444e69b85525863460ea@epcms5p8>
X-Mailman-Approved-At: Wed, 26 Jun 2019 06:56:58 +0000
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Reply-To: sathya.m@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Dear All,

This mail regarding the below communication about CMA in AMD IOMMU driver.

On Mon, Feb 02, 2015 at 10:35:36AM -0700, Alex Williamson wrote:
> [cc +joerg]
> 
> On Mon, 2015-02-02 at 11:01 -0500, Mark Hounschell wrote:
> >  From what I understand of CMA, and it seems provable to me, is that 
> > dma_alloc_coherent allocates my 8MB buffer from CMA defined on the 
> > cmdline. Without CMA specified on the cmdline, dma_alloc_coherent 
> > definitely fails to allocate an 8MB contiguous buffer. From what I've 
> > read about it, it is supposed to transparently "just work" when 
> > dma_alloc_coherent is used?
> 
> Yes, if you're running with the software iotlb (aka. bounce buffers),
> then dma_ops->alloc is x86_swiotlb_alloc_coherent(), which calls
> dma_generic_alloc_coherent(), which attempts to use CMA via
> dma_alloc_from_contiguous().
> 
> If you look at the same path with AMD-Vi, dma_ops->alloc is
> amd_iommu.c:alloc_coherent(), which simply uses __get_free_pages() to
> allocate the buffer.  I don't see any CMA integration along that path.
> If you were using Intel VT-d, then the buffer is again allocated with
> dma_alloc_from_contiguous() and should use CMA.  This was added in
> kernel v3.16, but no corresponding AMD-Vi change was added.  Joerg, this
> might be an easily fixed oversight.

Right, CMA is not yet integrated in the AMD IOMMU driver, nobody asked
fot it until now :) I will add that fall-back there for big allocations.


	Joerg


Has CMA been added in AMD IOMMU driver, If yes which version of kernel has it.


Thanks in Advance.
 
Regards,
Sathya
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
