Return-Path: <SRS0=khdJ=LR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAE0C4743C
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 18:50:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D1B611AC
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 18:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D1B611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FFFE40290;
	Wed, 23 Jun 2021 18:50:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSxsxvq2Obsr; Wed, 23 Jun 2021 18:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 66CBC4025E;
	Wed, 23 Jun 2021 18:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A099C001A;
	Wed, 23 Jun 2021 18:50:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 550ADC000E
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 18:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CBEE40668
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 18:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGbMPbqTry8R for <iommu@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 18:50:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F09C540696
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 18:50:08 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id u11so3730262wrw.11
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=t9g61bv+JZ07tY5UuVmyIiDTVqgatmyK1QRV0XqD+Hc=;
 b=KLXuHll2RXbwuztCykmE1EQTu6vmTzU1QQjpNTWzNCxaM1/Ps+7XEiFt8zUeOZ1baA
 xe7gg6HXyDZ4KaB5Rul1MiFZoKZ0NCIbHMmtoCQwOsmnIQiG+kgYk7+D1Nwn5IGm+2zB
 +ei/17jncOmir+dd9UyMDCtbBeqxpGTR5rZqJk0gYytyX0CnJeaGFqWYDEu6HFskFOOE
 nDzu6jGbO5UvY6TkF6GoI2grAJpQLbjUvI6cQO7vFjzZCaOOWSL1cuXCzLO2WUEC+XMu
 tRtnxpuK28KFSNdjX7/SGtxLwQUIkf75kqAgcewqO+eglB9DMfpSiAc0IPNPS5ithG0y
 BKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=t9g61bv+JZ07tY5UuVmyIiDTVqgatmyK1QRV0XqD+Hc=;
 b=q7Uqbr38TKM6l8n0BDyG77lzDxxlbX9w9R79T4ix1cNqVY40KxN2pRltDS2THL7vn/
 8i/Bk9BzwCRK/Qaqklqk8pbVPPqidVrnaEaEBZQSPHtJmO1pQLrXF8hOduD8UszO4pBC
 hSC55vZEpaiVE0O6wQWag2MMSXYrB0F+oJewRvRupN0+8Qw3lTIMRVplyUPW684FMTbs
 sAg4/TMPK9/+qShTSXYEFeroLRl1/tnm+/u4CmIvXsiKHGSKGV2cWTVRTS408hvS8UxO
 YCy3xkRwM1bRJyUIsgV2SVETbrhSrsoLiQVIUArsvLqNvba4e3xdYFp/FOitRudqgIuh
 SRqA==
X-Gm-Message-State: AOAM533Fa90elte/7c98vpAZlUOlRQKbhNl50veBat/zP1pb/Ft7woBS
 tpw9qDEQoXTVUyi8+F6CxX4=
X-Google-Smtp-Source: ABdhPJwow7ob1nYUTJTVlm2hcLViMuMJ7U2nNz+pDoNObCJVja/RfxSZArMIJ4rIufME1rWIeSAkvw==
X-Received: by 2002:a5d:6b91:: with SMTP id n17mr1793938wrx.166.1624474207108; 
 Wed, 23 Jun 2021 11:50:07 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
 by smtp.gmail.com with ESMTPSA id x10sm848038wru.58.2021.06.23.11.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jun 2021 11:50:06 -0700 (PDT)
Date: Wed, 23 Jun 2021 20:50:05 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Robin Murphy <robin.murphy@arm.com>, 989778-maintonly@bugs.debian.org
Subject: Re: Bug#989778: Regression in at least 5.10.y and mainline: Firewire
 audio interface fails to work properly (when booted under Xen)
Message-ID: <YNOCXe1cuNDNAB+Z@eldamar.lan>
References: <162352833546.2353.230557992597997974.reportbug@home.kota.moe>
 <YMWl4UnFBAVRDnys@eldamar.lan>
 <162352833546.2353.230557992597997974.reportbug@home.kota.moe>
 <2f7c7d36-b6f4-f8ab-756e-a563fa03b9e4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2f7c7d36-b6f4-f8ab-756e-a563fa03b9e4@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, =?utf-8?B?5bCP5aSq?= <nospam@kota.moe>,
 Christoph Hellwig <hch@lst.de>, Jianxiong Gao <jxgao@google.com>
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

Hi Robin,

On Mon, Jun 14, 2021 at 02:29:08PM +0100, Robin Murphy wrote:
> On 2021-06-13 07:29, Salvatore Bonaccorso wrote:
> > A user in Debian reported the above issue, which was reproducible with
> > 5.13-rc5 and 5.10.y as packaged in Debian and found that 85a5a6875ca9
> > ("swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single") that
> > introduced the issue.
> 
> Sounds like it's probably the same thing as being discussed over here:
> 
> https://lore.kernel.org/linux-iommu/2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com/

Thanks for the pointer, it seems that now it has been fixed upstream
with 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has
offset").

Regards,
Salvatore
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
