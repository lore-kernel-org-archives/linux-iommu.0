Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFB7C4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 17:58:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C373E2086D
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odYoI1Ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C373E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8A168FA9;
	Tue, 11 Jun 2019 17:58:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7AECFFA8
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 17:58:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 30A6279
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 17:58:45 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id f25so7374143pgv.10
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=LBBPbHNbMLxHuXtvkfP18Wlm24ucalIiwEp6yuzKVrw=;
	b=odYoI1GawxMsPF+9fsdFAGR5icuHDBePosT3W/x2jCUoF7YiA3NvqO/0TMdgOKiNMd
	9pQImhSQIAWI/SEq5MILFDCvA3yxyb1vwWAJNh4mZ3knbs+4LTaXfst5TsPBAxtIL//G
	a7Df57BSqIl1Sr7aHblVMhMLV5xC5iYxoYs/NIYzSbnGJTIQZeU9MVEohKjPyFtqkXlc
	1yKYQm7+ESdtLGWMFEpqEDzXFHjqk7FqjqE53AZDzAnwxyj3i9TSnIHjqaS4xOHWMio0
	GF6Adcru3dvscDEQiWac9qsA/uZ8gQ9jnGR7JAuQSkPqzoDGo4Vbm46b2M75srka9rIP
	56Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=LBBPbHNbMLxHuXtvkfP18Wlm24ucalIiwEp6yuzKVrw=;
	b=ABW7ylV2lS5UrCEC1ggai23X1S+0LMAd+C5Ex3cuCdCOoNXVAYMJE6ZtEAvWud1bts
	stjlmHUF7/t2t+T+/v2uwWW3b/eQIQIfsUCBfpJOB2VF1l5gK0ZlbJEuj7UU7QFum6J7
	Ww8/+fkQ/QIMemeJ2f7CR7YL+b5VBI+Sx/dUuMFl0eNoC1bWJFF1edUG/LNwvAuTrXNc
	L+X0ZBd4WdMVHyTMj567PQ8lPmNdbDW9YpfiCFBEJKjDbdFpipP6NbGSZ+OsBOCH1K/A
	VVuRhzqGAY2G1hYXRMn+is39vjruj2o8Egi0hdyJXyU9dWfvR3P3fSKw7WkXXJMrLUb2
	B94A==
X-Gm-Message-State: APjAAAUoBYWNgw0afc4uz5GwCx8+r6lu+RVnOWFcJzjBRplQirOFpZ4+
	B2rkxy4Up+5RrYAwtWuOtKM=
X-Google-Smtp-Source: APXvYqyTpBNB7eZvWW9ncZHcnns11TIDIARcKZGd/45wmVobCvkg5guWjJ8EwPqyjaoefy2cKPJqDg==
X-Received: by 2002:a63:295:: with SMTP id 143mr20557837pgc.279.1560275924507; 
	Tue, 11 Jun 2019 10:58:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
	by smtp.gmail.com with ESMTPSA id
	s24sm15991182pfh.133.2019.06.11.10.58.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 11 Jun 2019 10:58:43 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] swiotlb: Cleanup and consistency fix
Date: Tue, 11 Jun 2019 10:58:23 -0700
Message-Id: <20190611175825.572-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"open list:NETWORKING \[GENERAL\]" <netdev@vger.kernel.org>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

Still with my contrived memory layout where there is no physical memory
the kernel can use below 4GB, it was possible to fail swiotlb_init(),
but still not hit swiotlb_map_single() since all peripherals have a
DMA_BIT_MASK() that is within the remaining addressable physical memory.

The second path could be backported to stable, but for the same reasons
as the one we had just discussed before, this requires a very contrived
test case that is not necessarily realistic or would warrant a stable
backport IMHO.

Thanks!

Florian Fainelli (2):
  swiotlb: Group identical cleanup in swiotlb_cleanup()
  swiotlb: Return consistent SWIOTLB segments/nr_tbl

 kernel/dma/swiotlb.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
