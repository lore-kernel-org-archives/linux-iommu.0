Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0CCC0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:50:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4662051A
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZVHtxGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4662051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4FF3872B9;
	Mon, 16 Mar 2020 15:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qOcAuy4Iayo; Mon, 16 Mar 2020 15:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44CD887122;
	Mon, 16 Mar 2020 15:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 370D7C1D7C;
	Mon, 16 Mar 2020 15:50:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A297C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 26B6D20472
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HvhpaV2wtMDp for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:50:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by silver.osuosl.org (Postfix) with ESMTPS id B75DA203D3
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4Fcs/ravGQBzEwV+PwLN/3FuduA8sqVcdSOOMqzyw+E=; b=cZVHtxGt+DHwY530inZn5uaoAd
 NKYBLQCYm+jTGzzEtxEZZcghNZyQz3KZrzDd7pz5fIwHj8M1443PQzUVnDLn/hazE65KuoyeFpX4q
 SlRMMnPERZ+98066ISJv8PqhvKadqBvfmDLO8yR9v9I62OoyIKC9HSVz650f2PtsxYapCWFVbdZ5R
 f4Zrx1W+r/vsU+FwAD8cKpo9ZL8NyEpgdqr6xqK9E2SS96UpdcX+0mbPNpmGzTlROypcTsbmMtJ+v
 SIN/U5JGq9qiN3Kzq85xwDB29JrmkRYMtCWIIZ3wmAhwo4vIys/n0ZiMZfOMz5rdYneOW+8wr8bIu
 p6c7BDsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jDs0a-0004dZ-Nu; Mon, 16 Mar 2020 15:50:28 +0000
Date: Mon, 16 Mar 2020 08:50:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
Message-ID: <20200316155028.GB18704@infradead.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200309182255.20142-1-sibis@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: ohad@wizery.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, agross@kernel.org
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

On Mon, Mar 09, 2020 at 11:52:52PM +0530, Sibi Sankar wrote:
> The Q6 modem sub-system has direct access to DDR through memnoc and
> an indirect access routed through a SMMU which MSS CE (crypto engine
> sub-component of MSS) uses during out of reset sequence. Request direct
> mapping for the modem-firmware subdevice since smmu is not expected
> to provide access control/translation for these SIDs (sandboxing of the
> modem is achieved through XPUs engaged using SMC calls).

Please fix your device tree so that the device isn't bound to an
IOMMU.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
