Return-Path: <SRS0=c+U5=L2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3201FC11F68
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 13:18:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BF86141D
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 13:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BF86141D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8292C40337;
	Fri,  2 Jul 2021 13:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T_G3dZtETRwl; Fri,  2 Jul 2021 13:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 754BD40253;
	Fri,  2 Jul 2021 13:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F6A6C001A;
	Fri,  2 Jul 2021 13:18:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28D51C000E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 13:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1732883EC9
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 13:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fEieCpSIp-Z for <iommu@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 13:18:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C81683EC0
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 13:18:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D3B36109D;
 Fri,  2 Jul 2021 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625231920;
 bh=GDNc99vWU2EKYVywroGm/MONGRMfJ1bw5GtcP1Kxyew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UpJXnxcF4r+u8N9In3Ngt/3KsBiIssEtR46hbKVGD4imJoDwZps2CiNu9/tX6XODL
 RkRPeCMJzkowmvGyx+vBIS2hY1z4ccknZBrbZdUt3JmjE2xh4ItTea2grkiScPUhIn
 HLmoRTEOJQbfW+p5GY0xQ0VKUewGU1RsIqEJOhMbpuv3pp74w18YlrSAOnrKBIP55s
 v+J/uIyo0HZY5XHsn1OOtuplTl/3fBAHP0aXr8wAQJjJJZ7gIcW+IXijJkOA5vhe1e
 A78+z8Z0KIiDl7b4jtkq2bGKSaVHIDksVIMFkEDwiE3IncWj68Vxm0ezE9lm9A76mg
 Qcdpn8Gt/MWYA==
Date: Fri, 2 Jul 2021 14:18:29 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v15 12/12] of: Add plumbing for restricted DMA pool
Message-ID: <20210702131829.GA11132@willie-the-truck>
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-13-tientzu@chromium.org>
 <20210702030807.GA2685166@roeck-us.net>
 <87ca3ada-22ed-f40c-0089-ca6fffc04f24@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ca3ada-22ed-f40c-0089-ca6fffc04f24@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org, jxgao@google.com,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
 matthew.auld@intel.com, Nicolas Boichat <drinkcat@chromium.org>,
 thomas.hellstrom@linux.intel.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, Dan Williams <dan.j.williams@intel.com>,
 Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com, bhelgaas@google.com,
 Claire Chang <tientzu@chromium.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 airlied@linux.ie, Thierry Reding <treding@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 quic_qiancai@quicinc.com, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 thomas.lendacky@amd.com, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
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

On Fri, Jul 02, 2021 at 12:39:41PM +0100, Robin Murphy wrote:
> On 2021-07-02 04:08, Guenter Roeck wrote:
> > On Thu, Jun 24, 2021 at 11:55:26PM +0800, Claire Chang wrote:
> > > If a device is not behind an IOMMU, we look up the device node and set
> > > up the restricted DMA when the restricted-dma-pool is presented.
> > > 
> > > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > > Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> > > Tested-by: Will Deacon <will@kernel.org>
> > 
> > With this patch in place, all sparc and sparc64 qemu emulations
> > fail to boot. Symptom is that the root file system is not found.
> > Reverting this patch fixes the problem. Bisect log is attached.
> 
> Ah, OF_ADDRESS depends on !SPARC, so of_dma_configure_id() is presumably
> returning an unexpected -ENODEV from the of_dma_set_restricted_buffer()
> stub. That should probably be returning 0 instead, since either way it's not
> an error condition for it to simply do nothing.

Something like below?

Will

--->8

From 4d9dcb9210c1f37435b6088284e04b6b36ee8c4d Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Fri, 2 Jul 2021 14:13:28 +0100
Subject: [PATCH] of: Return success from of_dma_set_restricted_buffer() when
 !OF_ADDRESS

When CONFIG_OF_ADDRESS=n, of_dma_set_restricted_buffer() returns -ENODEV
and breaks the boot for sparc[64] machines. Return 0 instead, since the
function is essentially a glorified NOP in this configuration.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20210702030807.GA2685166@roeck-us.net
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/of/of_private.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 8fde97565d11..34dd548c5eac 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -173,7 +173,8 @@ static inline int of_dma_get_range(struct device_node *np,
 static inline int of_dma_set_restricted_buffer(struct device *dev,
 					       struct device_node *np)
 {
-	return -ENODEV;
+	/* Do nothing, successfully. */
+	return 0;
 }
 #endif
 
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
