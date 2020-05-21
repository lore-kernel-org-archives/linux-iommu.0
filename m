Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22404C433DF
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 14:38:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F12206F6
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 14:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOEcaexA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F12206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5DA5525D5D;
	Thu, 21 May 2020 14:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6KCf6PWso7wQ; Thu, 21 May 2020 14:38:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2493825C89;
	Thu, 21 May 2020 14:38:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19ED8C088B;
	Thu, 21 May 2020 14:38:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E08BDC0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 14:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D9600893E0
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 14:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VvYoQRQJdtU6 for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 14:38:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7422B893D3
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 14:38:37 +0000 (UTC)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D32A20671;
 Thu, 21 May 2020 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590071917;
 bh=OiPs36foL9u2qM53WH6N6taB239fXx9YwYNRpOR+uc8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IOEcaexAkIOaBlLyjmM4y4cc/lI+AvTt2XG3MJSe97tPOOBgmi21ZXYe/wbygmmAv
 5aXAD0JnBq4smiwKKP0tkBFg6mfmBK9KQxomojoIgqFlfdKP3EZ7WzahgMAIQfnPLY
 ixdP2n51XBJE02yNEqT0nnudoDksFaXfwPwqR4lA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jbmLD-00EFyF-AE; Thu, 21 May 2020 15:38:35 +0100
MIME-Version: 1.0
Date: Thu, 21 May 2020 15:38:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v7 13/24] iommu/arm-smmu-v3: Enable broadcast TLB
 maintenance
In-Reply-To: <20200521141730.GJ6608@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-14-jean-philippe@linaro.org>
 <20200521141730.GJ6608@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <0c896ad27b43b2de554cf772f9453d0a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, jean-philippe@linaro.org,
 iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
 robin.murphy@arm.com, kevin.tian@intel.com, baolu.lu@linux.intel.com,
 Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
 christian.koenig@amd.com, felix.kuehling@amd.com, zhangfei.gao@linaro.org,
 jgg@ziepe.ca, xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 devicetree@vger.kernel.org, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 fenghua.yu@intel.com, hch@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 catalin.marinas@arm.com, felix.kuehling@amd.com, robin.murphy@arm.com,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-05-21 15:17, Will Deacon wrote:
> [+Marc]
> 
> On Tue, May 19, 2020 at 07:54:51PM +0200, Jean-Philippe Brucker wrote:
>> The SMMUv3 can handle invalidation targeted at TLB entries with shared
>> ASIDs. If the implementation supports broadcast TLB maintenance, 
>> enable it
>> and keep track of it in a feature bit. The SMMU will then be affected 
>> by
>> inner-shareable TLB invalidations from other agents.
>> 
>> A major side-effect of this change is that stage-2 translation 
>> contexts
>> are now affected by all invalidations by VMID. VMIDs are all shared 
>> and
>> the only ways to prevent over-invalidation, since the stage-2 page 
>> tables
>> are not shared between CPU and SMMU, are to either disable BTM or 
>> allocate
>> different VMIDs. This patch does not address the problem.
> 
> This sounds like a potential performance issue, particularly as we 
> expose
> stage-2 contexts via VFIO directly. Maybe we could reserve some portion 
> of
> VMID space for the SMMU? Marc, what do you reckon?

Certainly doable when we have 16bits VMIDs. With smaller VMID spaces 
(like on
v8.0), this is a bit more difficult (we do have pretty large v8.0 
systems
around). How many VMID bits are we talking about?

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
